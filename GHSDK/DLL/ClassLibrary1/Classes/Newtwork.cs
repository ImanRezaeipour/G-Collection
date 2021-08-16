using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Threading;
using System.Windows.Forms;
using System.Net.Sockets;
using System.Net;
using System.Timers;

namespace Ghadir_UI
{
    public class Network : IOBase
    {

        private int last_size_receive_buffer = 0;
        private System.Timers.Timer timer = new System.Timers.Timer();

        private Thread send_with_thread;

        private TcpClient tcp_connection;
        private NetworkStream tcp_stream;
      
        public delegate void SendEvent();
        public delegate ArrayList ReceiveEvent(ArrayList Buffer);
        public delegate void ErrorOnConnection();
        public delegate void ErrorOnSend();
        public delegate void ErrorOnReceive();

        public event SendEvent NetworkSendFinish;
        public event ReceiveEvent NetworkReceiveFinish;
        public event ErrorOnConnection ConnectionError;
        public event ErrorOnSend SendError;
        public event ErrorOnReceive ReceiveError;


        private Byte[] internal_send_buffer= new Byte[100];
        private Byte[] internal_receive_buffer = new Byte[100];

        
        public enum NetworkErrorValue
        {
            CanNotAssignNetworkMedia,
            NetworkSendFail,
            NetworkReceiveFail
        }

        private void initial()
        {
            timer.Interval = 60;
            timer.AutoReset = true;
            timer.Enabled = true;
            timer.Elapsed += new ElapsedEventHandler(timer_Elapsed);
          
            errors.Clear();
        }

        void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            try
            {
                if (tcp_connection.Client != null)
                    if (tcp_connection.Connected)
                    {
                        
                        if (tcp_connection.Available == last_size_receive_buffer && tcp_connection.Available != 0)
                        {
                            try
                            {
                                intermediate_receive_buffer.Clear();

                                internal_receive_buffer = new Byte[tcp_connection.Available];

                                if (!media_is_connect())
                                    if (!prepare_connection())
                                          return;
                                
                                   tcp_stream.Read(internal_receive_buffer, 0, tcp_connection.Available);
                                       

                                foreach (Byte b in internal_receive_buffer)
                                    intermediate_receive_buffer.Add(b);
                                Array.Resize(ref internal_receive_buffer, 0);
                                last_size_receive_buffer = 0;
                                log.LogReceivedPacket(intermediate_receive_buffer);
                                total_received_bytes += (UInt64)intermediate_receive_buffer.Count;
                                total_received_packet++;
                                if (NetworkReceiveFinish != null)
                                    NetworkReceiveFinish(intermediate_receive_buffer);
                                if (media_status == CommunicationStatus.Receiving)
                                    media_status = CommunicationStatus.Idle;
                                else if (media_status == CommunicationStatus.SendingAndReceiving)
                                    media_status = CommunicationStatus.Sending;

                            }
                            catch
                            {
                                if (ReceiveError != null)
                                    ReceiveError();
                                if (media_status == CommunicationStatus.Receiving)
                                    media_status = CommunicationStatus.Idle;
                                else if (media_status == CommunicationStatus.SendingAndReceiving)
                                    media_status = CommunicationStatus.Sending;
                                on_error_occur(NetworkErrorValue.NetworkReceiveFail);

                            }

                        }
                        else if (tcp_connection.Available != last_size_receive_buffer)
                        {
                            if (media_status == CommunicationStatus.Idle)
                                media_status = CommunicationStatus.Receiving;
                            else if (media_status == CommunicationStatus.Sending)
                                media_status = CommunicationStatus.SendingAndReceiving;
                            last_size_receive_buffer = tcp_connection.Available;
                        }                        
                    }
            }
            catch
            {
            }           
        }


        private IPEndPoint destination_address;
   
              
        public int Port
        {
            get
            {
                return destination_address.Port;
            }
        }

        public IPAddress IP
        {
            get
            {
                return destination_address.Address;
            }
        }

        private Boolean media_is_connect()
        {
            return tcp_connection.Connected;
        }

        private Boolean prepare_connection()
        {

            try
            {
                tcp_connection = new TcpClient();
                tcp_connection.SendTimeout = 2000;
                tcp_connection.ReceiveTimeout = 2000;
                
                //test tcp_connection.Client.Blocking = false;
                tcp_connection.Client.Connect(destination_address); //test
                tcp_stream = tcp_connection.GetStream(); //test
                return true; //test
                /*test
                if (tcpConnect(destination_address))
                {
                    tcp_connection.Client.Blocking = true;

                    tcp_stream = tcp_connection.GetStream();
                    return true;
                }
                else
                {
                    on_error_occur(NetworkErrorValue.CanNotAssignNetworkMedia);
                    if (ConnectionError != null)
                        ConnectionError();
                    return false;
                }test*/
            }
            catch(Exception e2)
            {                   
                on_error_occur(NetworkErrorValue.CanNotAssignNetworkMedia);
                if (ConnectionError != null)
                    ConnectionError();
                return false;
            }

        }

        private Boolean tcpConnect(IPEndPoint destinationAddress)
        {
            Boolean testB = true;
            try
            {
                //tcp_connection = new TcpClient();
                //tcp_connection.SendTimeout = 2000;
                //tcp_connection.ReceiveTimeout = 2000;
                //tcp_connection.Client.Blocking = false;                
                tcp_connection.Connect(destination_address);

                testB = true;
                return true;
            }
            catch (Exception e2)
            {
                DateTime d1 = DateTime.Now;
                d1 = d1.AddMilliseconds(500);
                //d1 = d1.AddSeconds(1);
                DateTime d2;
                while (!tcp_connection.Connected)
                {
                    d2 = DateTime.Now;
                    if (d2 > d1)
                        return false;
                    testB = false;
                }
                testB = true;
                return true;
            }
        }

        public Boolean CreateNetworkIO(IPEndPoint Address)
        {
            DestroyNetworkIO();
            Boolean temp;
            destination_address = Address;
           
            temp = prepare_connection();
            initial();
            return temp;
        }

       

        public override ArrayList ReceiveFromClient()
        {
            return intermediate_receive_buffer;
        }
        public override void SendToClient(string Buffer)
        {
            ArrayList myBuffer = new ArrayList();
            myBuffer.Add(Buffer);
            SendToClient(myBuffer);
        }
        public override void SendToClient(ArrayList Buffer)
        {
            if (Status == CommunicationStatus.Idle || Status == CommunicationStatus.Receiving)
            {
                UInt64 t = 0;
                intermediate_send_buffer = Buffer;
                internal_send_buffer = new Byte[intermediate_send_buffer.Count];
                foreach (Object o in Buffer)
                    internal_send_buffer[t++] = Convert.ToByte(o);


             
                send_with_thread = new Thread(new ThreadStart(send_thread));
                send_with_thread.Start();
            }
        }

        ~Network()
        {
            DestroyNetworkIO();
        }

        public void DestroyNetworkIO()
        {
            try
            {
                tcp_stream.Close();
                tcp_connection.Close();
                send_with_thread.Abort();
                timer.Stop();
            }

            catch
            {
            }
          
           
        }

        private void send_thread()
        {
           try
           {
                if (media_status == CommunicationStatus.Idle)
                    media_status = CommunicationStatus.Sending;
                else if (media_status == CommunicationStatus.Receiving)
                    media_status = CommunicationStatus.SendingAndReceiving;




                if (!media_is_connect())
                    if (!prepare_connection())
                         return;
                  
                  tcp_stream.Write(internal_send_buffer, 0, internal_send_buffer.Length);
                                     
           
                if (media_status == CommunicationStatus.Sending)
                    media_status = CommunicationStatus.Idle;
                else if (media_status == CommunicationStatus.SendingAndReceiving)
                    media_status = CommunicationStatus.Receiving;

                log.LogSendPacket(intermediate_send_buffer);
                total_sent_bytes += (UInt64)intermediate_send_buffer.Count;
                total_sent_packets++;
                if (NetworkSendFinish != null)
                    NetworkSendFinish();         


            }
           catch
            {
                if (SendError != null)
                    SendError();
                if (media_status == CommunicationStatus.Sending)
                    media_status = CommunicationStatus.Idle;
                else if (media_status == CommunicationStatus.SendingAndReceiving)
                    media_status = CommunicationStatus.Receiving;
                on_error_occur(NetworkErrorValue.NetworkSendFail);
               
            }
        }
    
     
                



        }
  
    
    
    
    
    }


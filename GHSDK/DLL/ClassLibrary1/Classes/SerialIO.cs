using System;
using System.Collections.Generic;
using System.Text;
using System.IO.Ports;
using System.Windows.Forms;
using System.IO;
using System.Collections;
using System.Timers;
using System.Threading;



namespace Ghadir_UI
{
    public class SerialIO : IOBase , IOInterface
    {
        

        public enum SerialPortErrorValue
        {
            CanNotOpenSerialPort=1,
            CanNotCloseSerialPort,
            CanNotSetSerialPortName,
            CanNotSetSerialPortBaudRate,
            CanNotSetSerialPortDataBitOption,
            CanNotSetSerialPortParityOption,
            CanNotSetSerialPortStopBitsOption,
            SerialPortIsInUse,
            SerialPortFrameError,
            SerialPortOverRun,
            SerialPortReceiveOverRun,
            SerialPortReceivePariryError,
            SerialPortSendBufferFull,
            SerialSendFail,
            SerialReceiveFail
        }
        
        private Byte[] internal_send_buffer;
        private Byte[] internal_receive_buffer;

     
        private int last_size_receive_buffer;

        private SerialPort serial_port = new SerialPort();
        private System.Timers.Timer timer = new System.Timers.Timer();
        private Thread send_thread ;

        public delegate void SendEvent();
        public delegate ArrayList ReceiveEvent(ArrayList Buffer);

        public event SendEvent SerialSendFinish;
        public event ReceiveEvent SerialReceiveFinish;
 
        private void send_with_thread()
        {
            try
            {
                if (media_status == CommunicationStatus.Idle)
                    media_status = CommunicationStatus.Sending;
                else if (media_status == CommunicationStatus.Receiving)
                    media_status = CommunicationStatus.SendingAndReceiving;
                serial_port.Write(internal_send_buffer, 0, internal_send_buffer.Length);
                if (media_status == CommunicationStatus.Sending)
                    media_status = CommunicationStatus.Idle;
                else if (media_status == CommunicationStatus.SendingAndReceiving)
                    media_status = CommunicationStatus.Receiving;
                log.LogSendPacket(intermediate_send_buffer);
                total_sent_bytes += (UInt64)intermediate_send_buffer.Count;
                total_sent_packets++;
                if (SerialSendFinish != null)
                    SerialSendFinish();
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.SerialSendFail);
            }
        }

        ~SerialIO()
        {
            DestroySerialIO();
        }
        private void initial()
        {
            timer.Interval = 2;
            timer.AutoReset = true;
            timer.Enabled = true;
            timer.Elapsed += new ElapsedEventHandler(SerialPortTimer_Elapsed);
            serial_port.ErrorReceived += new SerialErrorReceivedEventHandler(SerPort_ErrorReceived);
            timer.Start();
            errors.Clear();
        }


        public SerialIO(string PortName, int Baud, int DataBits, Parity Parities, StopBits StopBit)
        {

            serial_port.Dispose();
            initial();
            CloseSerialPort();
            SetPortName(PortName);
            SetBaud(Baud);
            SetDataBits(DataBits);
            SetParityBits(Parities);
            SetStopBits(StopBit);
            OpenSerialPort();
           
        }

        public SerialIO()
        {
            initial();
        }

        public SerialIO(string PortName,int BaudRate )
        {
            initial();
            CreateSerialMedia(PortName,BaudRate, 8, Parity.None, StopBits.Two);                       
        }

        public Boolean CreateSerialMedia(string PortName,int Baud, int DataBits, Parity Parities, StopBits StopBit)
        {
            return  SetPortDetail(PortName, Baud, DataBits, Parities, StopBit);
        }



        private void SerialPortTimer_Elapsed(object sender, ElapsedEventArgs e)
        { 
            
            try
            {

                if (serial_port.IsOpen)
                {

                    if (serial_port.BytesToRead == last_size_receive_buffer && serial_port.BytesToRead != 0)
                    {
                        try
                        {
                            intermediate_receive_buffer.Clear();

                            internal_receive_buffer = new Byte[serial_port.BytesToRead];
                            serial_port.Read(internal_receive_buffer, 0, serial_port.BytesToRead);
                            foreach (Byte b in internal_receive_buffer)
                                intermediate_receive_buffer.Add(b);
                            Array.Resize(ref internal_receive_buffer, 0);
                            last_size_receive_buffer = 0;
                            log.LogReceivedPacket(intermediate_receive_buffer);
                            total_received_bytes += (UInt64)intermediate_receive_buffer.Count;
                            total_received_packet++;
                            if (SerialReceiveFinish != null)
                                SerialReceiveFinish(intermediate_receive_buffer);
                            if (media_status == CommunicationStatus.Receiving)
                                media_status = CommunicationStatus.Idle;
                            else if (media_status == CommunicationStatus.SendingAndReceiving)
                                media_status = CommunicationStatus.Sending;
                        }
                        catch
                        {
                            if (media_status == CommunicationStatus.Receiving)
                                media_status = CommunicationStatus.Idle;
                            else if (media_status == CommunicationStatus.SendingAndReceiving)
                                media_status = CommunicationStatus.Sending;
                            on_error_occur(SerialPortErrorValue.SerialReceiveFail);
                        }

                    }
                    else if (serial_port.BytesToRead != last_size_receive_buffer)
                    {
                        if (media_status == CommunicationStatus.Idle)
                            media_status = CommunicationStatus.Receiving;
                        else if (media_status == CommunicationStatus.Sending)
                            media_status = CommunicationStatus.SendingAndReceiving;
                        last_size_receive_buffer = serial_port.BytesToRead;
                    }
                }
            }
            catch
            {
            }
            
        }            
        

        void SerPort_ErrorReceived(object sender, SerialErrorReceivedEventArgs e)
        {
            switch (e.EventType)
            {
                case SerialError.Frame: on_error_occur(SerialPortErrorValue.SerialPortFrameError); break;
                case SerialError.Overrun: on_error_occur(SerialPortErrorValue.SerialPortOverRun); break;
                case SerialError.RXOver: on_error_occur(SerialPortErrorValue.SerialPortReceiveOverRun); break;
                case SerialError.RXParity: on_error_occur(SerialPortErrorValue.SerialPortReceivePariryError); break;
                case SerialError.TXFull: on_error_occur(SerialPortErrorValue.SerialPortSendBufferFull); break;               
            }
        }


        public Boolean SetBaud(int Baud)
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            CloseSerialPort();
            try
            {
                serial_port.BaudRate = Baud;
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotSetSerialPortBaudRate);
                return false;
            }           
        }

        public Boolean SetDataBits(int DataBits)
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            CloseSerialPort();
            try
            {
                serial_port.DataBits = DataBits;
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotSetSerialPortDataBitOption);
                return false;
            }
        }

        public Boolean SetPortName(string PortName)
        {            
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            try
            {
                serial_port.PortName = PortName;
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotSetSerialPortName);
                return false;
            }
        }

        public Boolean SetStopBits (StopBits StopBit)
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            CloseSerialPort();
            try
            {
                serial_port.StopBits = StopBit;
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotSetSerialPortStopBitsOption);
                return false;
            }
        }

        public Boolean SetParityBits(Parity Parities)
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            CloseSerialPort();
            try
            {
                serial_port.Parity = Parities;
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotSetSerialPortParityOption);
                return false;
            }
        }

        private Boolean CloseSerialPort()
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            try
            {
                serial_port.Close();
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotCloseSerialPort);
                return false;
            }
        }
        public void DestroySerialIO()
        {       
            timer.Stop();
            timer.Enabled = false;
            serial_port.Close();
            timer.Dispose();
            serial_port.Dispose();
                
            
        }

        private Boolean OpenSerialPort()
        {
            if ((int)Status > 1)
            {
                on_error_occur(SerialPortErrorValue.SerialPortIsInUse);
                return false;
            }
            try
            {
                serial_port.Open();
                return true;
            }
            catch
            {
                on_error_occur(SerialPortErrorValue.CanNotOpenSerialPort);
                return false;
            }
        }
        
        public Boolean SetPortDetail(string PortName, int Baud, int DataBits,Parity Parities, StopBits StopBit)
        {
            if (!this.CloseSerialPort()) return false;
            if (!this.SetPortName(PortName)) return false;
            if (!this.SetBaud(Baud)) return false;
            if (!this.SetDataBits(DataBits)) return false;
            if (!this.SetParityBits(Parities)) return false;
            if (!this.SetStopBits(StopBit)) return false;
            if (!this.OpenSerialPort()) return false;
            return true;
         }

        public string[] GetAvailablePorts()
        {
            return SerialPort.GetPortNames();
        }

        public override void SendToClient(string Buffer)
        {
            ArrayList myBuffer = new ArrayList();
            myBuffer.Clear();
            for (int t=0 ; t<Buffer.Length ; t++)
                myBuffer.Add(Convert.ToByte(Buffer[t]));
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
                 
                 send_thread = new Thread(new ThreadStart(send_with_thread));
                 send_thread.Start();
             }
         }

         public override ArrayList ReceiveFromClient()
         {          
             return intermediate_receive_buffer;
         }
    }
}

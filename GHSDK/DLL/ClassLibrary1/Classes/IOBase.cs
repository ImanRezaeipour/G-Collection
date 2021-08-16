using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Windows.Forms;


namespace Ghadir_UI
{      
    public class IOBase 
    {
        public virtual void SendToClient(ArrayList Buffer) {}
        public virtual void SendToClient(string Buffer) { }
        public virtual ArrayList ReceiveFromClient() { return new ArrayList(); }
                       
        private void initial()
        {
            intermediate_receive_buffer.Clear();
            intermediate_send_buffer.Clear();
            total_received_bytes = 0;
            total_received_packet = 0;
            total_sent_bytes = 0;
            total_sent_packets = 0;
           
        }

        public IOBase()
        {
            initial();
        }

        public enum CommunicationStatus 
        {
            Idle=1,
            Sending,
            Receiving,
            SendingAndReceiving           
        }

        public enum CommunicationLiberty 
        {
            Send=1,
            Receive,
            SendAndReceive
        }
        
        protected ErrorTable errors = new ErrorTable();
        
        protected LogPacket log = new LogPacket();
               
        protected ArrayList intermediate_send_buffer = new ArrayList();
        protected ArrayList intermediate_receive_buffer = new ArrayList();

        protected UInt64 total_sent_bytes;
        protected UInt64 total_received_bytes;
        protected UInt64 total_sent_packets;
        protected UInt64 total_received_packet;

        protected CommunicationStatus media_status = CommunicationStatus.Idle;
        protected CommunicationLiberty media_liberty = CommunicationLiberty.SendAndReceive;

        public void ResetCounters()
        {
            total_received_bytes = 0;
            total_received_packet = 0;
            total_sent_bytes = 0;
            total_sent_packets =0;
        }
       
        protected void on_error_occur(Error Error)
        {
            errors.Add(Error);                              
        }

        protected void on_error_occur(Object Object)
        {
            Error temp = new Error(Object);
            errors.Add(temp);
        }

        public ErrorTable GetErrors()
        {
            return errors;
        }

        public string LogPath
        {
            get
            {
                return log.Path;
            }
            set
            {
                log.Path = value;
            }
        }

        public LogPacket.LogFileMode LogFileOption
        {
            get
            {
                return log.Mode;
            }
            set
            {
                log.Mode = value;
            }
        }

        public CommunicationStatus Status
        {
            get
            {
                return media_status;
            }
        }
        public  CommunicationLiberty Liberty
        {
            set
            {
                media_liberty = value;
            }
            get
            {
                return media_liberty;
            }
        }
        


       


        



    }
}

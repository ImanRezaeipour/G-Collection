using System;
using System.Collections.Generic;
using System.Text;
using System.Net;

namespace Ghadir_Service
{
    public class DeviceDetail
    {
        public enum DeviceType
        {
            CLK6000,
            MTT5000,
            ACC1000
        }

        public enum DeviceCommunicationType
        {
            SERIAL,
            NETWORK
        }

        private UInt32 address;
        private int baud;
        private string name;
        private string com_port;
        private DeviceType type;
        private IPAddress ip;
        private int port;
        private DeviceCommunicationType connection_type;
     
        public DeviceCommunicationType ConnectionType
        {
            get
            {
                return connection_type;
            }
            set
            {
                connection_type = value;
            }
        }

        public int BaudRate
        {
            get
            {
                return baud;
            }
            set
            {
                baud = value;
            }
        }
        public string COMPort
        {
            get
            {
                return com_port;
            }
            set
            {
                com_port = value;
            }
        }
        
              
        public IPAddress IP
        {
            get
            {
                return ip;
            }
            set
            {
                ip = value;
            }
        }
        public int Port
        {
            get
            {
                return port;
            }
            set
            {
                port = value;
            }
        }
        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                name = value;
            }
        }
        public UInt32 Address
        {
            get
            {
                return address;
            }
            set
            {
                address = value;
            }
        }
        public DeviceType Type
        {
            get
            {
                return type;
            }
            set
            {
                type = value;
            }
        }
    }
}

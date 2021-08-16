using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASPWebclock.AppCode
{
    enum MessageType
    {
        Success,
        Error
    }

    public class MessageHandler
    {
        public string Type { get; set; }
        public string Message { get; set; }
    }
}
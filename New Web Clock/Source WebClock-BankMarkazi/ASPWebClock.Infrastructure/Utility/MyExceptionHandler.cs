using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Utility
{
    public class MyExceptionHandler : Exception
    {
        private string _message;
        public override string Message
        {
            get
            {
                return _message;
            }
            
        }
        public MyExceptionHandler(string message)
        {
            _message = message;
        }
        public override string StackTrace
        {
            get
            {
                return base.StackTrace;
            }
        }
        public override System.Collections.IDictionary Data
        {
            get
            {
                return base.Data;
            }
        }
        public override string HelpLink
        {
            get
            {
                return base.HelpLink;
            }
            set
            {
                base.HelpLink = value;
            }
        }
        public override string Source
        {
            get
            {
                return base.Source;
            }
            set
            {
                base.Source = value;
            }
        }
        
    }
}

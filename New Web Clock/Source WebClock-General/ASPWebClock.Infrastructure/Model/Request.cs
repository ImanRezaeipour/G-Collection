using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace ASPWebClock.Infrastructure.Model
{
    public class Request
    {
        #region Properties

        public decimal ID
        {
            get;
            set;
        }

        public WebpassUserProxy user 
        { 
            get; 
            set; 
        }
        public string barcode
        {
            get;
            set;
        }
        public string Date
        {
            get;
            set;
        }

        public short RecState
        {
            get;
            set;
        }

        public short Time
        {
            get;
            set;
        }

        public short eTime
        {
            get;
            set;
        }

        public short FirstlyAgree
        { get; set; }
        public short SeconderyAgree
        { get; set; }
        public short FinalyAgree
        { get; set; }

        public string AgreeBarcode
        { get; set; }

        public string AgreeDate
        { get; set; }

        #endregion


        
    }
}
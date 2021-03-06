using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace ASPWebClock.Infrastructure.Model
{
    public struct TerminalRec
    {
        public string rdrCardCode;
        public string rdrDate;
        public short rdrTime;
        public short rdreTime;
        public short rdrCode;
        public short rdrStatus;
        public short rdrIOType;
        public short rdrgroup;
        public string rdrBDate;
        public short rdrBTime;
        public short rdrBeTime;
        public short rdrBStatus;
        public short rdrBRdrCode;
        public short rdrChng;
        public string rdrUser;
        public short rdrPayment;  // used in credit3
        public short rdrService;  // used in credit3
        public bool rdrErrRec;
        public string rdrAgreeCode;   //New webClock's field
        public byte rdrFirstAgree;        //New webClock's field
        public byte rdrFinalAgree;        //New webClock's field
        public string rdrdescription;      //New webClock's field
        public string rdrSendDate;
        public string rdrAgreeDate;  //New webClock's field
    }
}
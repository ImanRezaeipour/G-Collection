using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace ConvertorDataFromOWCToNWC.Model
{
    public class NW_Webpass
    {

       
        [DataObjectField(true,true,false)]
         public decimal ID { get; set; }
        public string p_barcode { get; set; }
        public string PersonPost { get; set; }
        public string p_pass { get; set; }
        public int p_status { get; set; }
        public int p_part1 { get; set; }
        public int p_part2 { get; set; }
        public int p_part3 { get; set; }
        public int p_part4 { get; set; }
        public bool Haspart { get; set; }
        public bool Hasperson { get; set; }
        public decimal TopMan { get; set; }
        public int MaxTimeReq { get; set; }
        public int MaxOverTime { get; set; }
        public bool AgreeAddWork { get; set; }
        public bool AgreeOverTime { get; set; }
        public bool HasMailServer { get; set; }
        public string HostName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int Port { get; set; }
        public bool HasInsteadMan { get; set; }
        public string InsteadMan { get; set; }
        public bool isSaveAccept { get; set; }
        public bool isAcceptOwner { get; set; }
        public bool FinalManager { get; set; }
        public DateTime? FromDateIman { get; set; }
        public DateTime? ToDateIman { get; set; }
    }
}

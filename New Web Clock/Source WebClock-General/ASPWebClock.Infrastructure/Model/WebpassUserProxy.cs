using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.ComponentModel;



namespace ASPWebClock.Infrastructure.Model
{
    public class WebpassUserProxy 
    {
        public WebpassUserProxy()
         {
             MaxTimeReq = 0;

         }
        #region Properties


public string Name { get; set; }
public string Family { get; set; }
public decimal ID { get; set; }
public string Barcode { get; set; }
public string PersonPost { get; set; }
public int Status { get; set; }
public bool Haspart { get; set; }
public bool Hasperson { get; set; }
public decimal TopMan { get; set; }
public int MaxTimeReq { get; set; }
public int MaxOverTime { get; set; }
public bool AgreeAddWork { get; set; }
public bool AgreeOverTime { get; set; }
public bool HasInsteadMan { get; set; }
public string InsteadMan { get; set; }
public bool isAcceptOwner { get; set; }
public bool FinalManager { get; set; }
public DateTime FromDateIman { get; set; }
public DateTime ToDateIman { get; set; }

        
        #endregion

      
    }
}
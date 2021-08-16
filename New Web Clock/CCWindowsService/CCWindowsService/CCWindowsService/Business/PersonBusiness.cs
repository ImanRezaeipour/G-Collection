using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace CCWindowsService.Business
{
   public class PersonBusiness
    {

       public List<string> GetAllPersonBarcode()
       {
           try
           {
               DataTable dtResult = new CCWindowsService.Repository.PersonRepository().GetAllPersonBarcode();
               List<string> barcodeList = new List<string>();
               if (dtResult != null)
               {
                   for (int i = 0; i < dtResult.Rows.Count; i++)
                   {
                       barcodeList.Add(dtResult.Rows[i]["P_BarCode"].ToString());
                   }
               }
              return barcodeList;
           }
           catch (Exception ex)
           {

               EventLog eventLog1 = new EventLog();
               eventLog1.Source = "CCLogSourse";
               eventLog1.Log = "CCLog";
               eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
               List<string> barcodeList = new List<string>();
               barcodeList = null;
               return barcodeList;
           }
       }
    }
}

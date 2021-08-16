using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Configuration;
using System.Threading.Tasks;


namespace CCServiceLibary
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
    public class CCService : ICCService
    {
        public bool CalculateOnePerson(string barcode, string year, string month, string encryptionCode)
        {

            try
            {
                if (new CryptData().DecryptData(encryptionCode) == year + month)
                {
                    ProcessStartInfo startInfo;
                    Process process = new Process();
                    startInfo = new ProcessStartInfo(ConfigurationManager.AppSettings["CCFilePath"].ToString());
                    startInfo.Arguments = barcode + " " + year + " " + month;
                    startInfo.UseShellExecute = false;
                    startInfo.CreateNoWindow = true;
                    startInfo.RedirectStandardOutput = true;
                    startInfo.RedirectStandardError = true;
                    startInfo.RedirectStandardInput = true;
                    
                    process.StartInfo = startInfo;
                    process.Start();
                    process.WaitForExit();
                    
                    process.Dispose();
                    
                    return true;
                }
                else
                {
                    return false;
                }


            }
            catch (System.Exception ex)
            {
                EventLog eventLog1 = new EventLog();
                eventLog1.Source = "CCLogSourse";
                eventLog1.Log = "CCLog";
                eventLog1.WriteEntry(ex.Message,EventLogEntryType.Error);
                return false;


            }
            

        }
        public bool CalculateListPerson(List<string> barcodeList, string year, string month, string encryptionCode)
        {
            try
            {
                if (new CryptData().DecryptData(encryptionCode) == year + month)
                {
                    int ThreadCount = int.Parse(ConfigurationManager.AppSettings["ThreadCount"]);


                    Action[] actionsArray = new Action[barcodeList.Count];

                    Parallel.For(0, barcodeList.Count, index =>
                    {
                        actionsArray[index] = () => { DoWork(barcodeList[index], year, month, encryptionCode); };

                    });
                    ParallelOptions opt = new ParallelOptions();
                    opt.MaxDegreeOfParallelism = ThreadCount;
                    Parallel.Invoke(opt, actionsArray);
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                EventLog eventLog1 = new EventLog();
                eventLog1.Source = "CCLogSourse";
                eventLog1.Log = "CCLog";
                eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
                return false;

            }
        }
        void DoWork(string barcode, string year, string month, string encryptionCode)
        {
           
            this.CalculateOnePerson(barcode, year, month, encryptionCode);
        }


    }
}

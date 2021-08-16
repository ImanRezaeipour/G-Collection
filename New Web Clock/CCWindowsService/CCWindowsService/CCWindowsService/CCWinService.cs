using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.ServiceModel;
using System.Configuration;

namespace CCWindowsService
{
    public partial class CCWinService : ServiceBase
    {
        public ServiceHost CCServiceHost = null;
        private System.Timers.Timer _timer;
        private DateTime _lastRunDate;
        public CCWinService()
        {
            InitializeComponent();
            if (!System.Diagnostics.EventLog.SourceExists("CCLogSourse"))
                System.Diagnostics.EventLog.CreateEventSource("CCLogSourse",
                                                                      "CCLog");


            eventLog1.Source = "CCLogSourse";
            // the event log source by which 

            //the application is registered on the computer

            eventLog1.Log = "CCLog";
        }

        protected override void OnStart(string[] args)
        {
            try
            {


                //System.Diagnostics.Debugger.Launch();
                eventLog1.WriteEntry("CC Windows service started",EventLogEntryType.SuccessAudit);
                if (CCServiceHost != null)
                {
                    CCServiceHost.Close();
                }
                CCServiceHost = new ServiceHost(typeof(CCServiceLibary.CCService));
                CCServiceHost.Open();
                eventLog1.WriteEntry("CC service strated",EventLogEntryType.SuccessAudit);

                _timer = new System.Timers.Timer(Convert.ToDouble(ConfigurationManager.AppSettings["timeInterval"]));
                _lastRunDate = new DateTime();
                _timer.Elapsed += new System.Timers.ElapsedEventHandler(timer_Elapsed);
                _timer.Start();
            }
            catch (Exception ex)
            {
                eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
                throw;
            }



        }

        protected override void OnStop()
        {
            try
            {


                if (CCServiceHost != null)
                {
                    CCServiceHost.Close();
                    CCServiceHost = null;
                    eventLog1.WriteEntry("CC service stopped",EventLogEntryType.Warning);
                }
                _timer.Stop();
                eventLog1.WriteEntry("CC windows service stopped",EventLogEntryType.Warning);
            }
            catch (Exception ex)
            {

                eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
            }
        }
        private void timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            try
            {



                _timer.Stop();
                DateTime dateStart = DateTime.Parse(DateTime.Now.ToShortDateString() + " " + ConfigurationManager.AppSettings["startTimeInterval"]);
                DateTime dateEnd = DateTime.Parse(DateTime.Now.ToShortDateString() + " " + ConfigurationManager.AppSettings["endTimeInterval"]);
                DateTime dateNow = DateTime.Now;
                if (dateNow >= dateStart && dateNow <= dateEnd && _lastRunDate.ToShortDateString() != dateNow.ToShortDateString())
                {
                    CalCulateAllPersonSchedule();
                    _lastRunDate = DateTime.Now;
                }
                _timer.Start();
            }
            catch (Exception ex)
            {
                _timer.Start();
                eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
            }
        }
        private void CalCulateAllPersonSchedule()
        {
            try
            {
                eventLog1.WriteEntry("Schedule Calculate AllPerson Started in Date" + DateTime.Now.ToString());

                System.Globalization.PersianCalendar pCalendar = new System.Globalization.PersianCalendar();
                string year = pCalendar.GetYear(DateTime.Now).ToString();
                int monthTemp = pCalendar.GetMonth(DateTime.Now);
                string month = "";
                if (monthTemp < 10)
                    month = "0" + monthTemp.ToString();
                else
                    month = monthTemp.ToString();

                string encryptCode = new CCServiceLibary.CryptData().EncryptData(year + month + DateTime.Today.ToShortDateString());
                List<string> barcodeList = new CCWindowsService.Business.PersonBusiness().GetAllPersonBarcode();
                if (barcodeList != null)
                {
                    CCServiceLibary.CCService ccService = new CCServiceLibary.CCService();
                    bool result = ccService.CalculateListPerson(barcodeList, year, month, encryptCode);
                    string finalMessage = "";
                    if (result == true)
                    {
                        finalMessage = "Schedule Calculate All Person Successed End";
                        eventLog1.WriteEntry(finalMessage, EventLogEntryType.Information);
                    }
                    else
                    {
                        finalMessage = "Schedule Calculate All Person Failed End";
                        eventLog1.WriteEntry(finalMessage,EventLogEntryType.Warning);
                    }
                    
                }
                else
                {
                    eventLog1.WriteEntry(".خطا در واکشی پرسنل clock", EventLogEntryType.Error);
                }
            }
            catch (Exception ex)
            {

                eventLog1.WriteEntry(ex.Message, EventLogEntryType.Error);
            }
        }

    }
}

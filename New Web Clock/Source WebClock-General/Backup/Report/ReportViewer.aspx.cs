using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.DAL.Model;
using System.ComponentModel;
using System.Diagnostics;
using System.Threading;
using System.Web.Configuration;
using System.Threading.Tasks;
using Stimulsoft.Report;
using ASPWebClock.Infrastructure.Business;

namespace ASPWebclock.Report
{

    public partial class ReportViewer : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!this.Page.IsPostBack)
            {
                HttpContext.Current.Response.BufferOutput = false;
                HttpContext.Current.Response.Write(@"<html><head></head><body>
                    <div dir='rtl' style='width: 100%; font-family: tahoma; font-size: 9pt;' align='center'><div  id='divImgLoading' 
                        style='width: 150px; font-weight: bold;' dir='rtl'>
                لطفا منتظر بمانید
                <img id='imgLoading' src='../App_Themes/Aqua/Web/Loading.gif' />
                </div></div></body></html>");
                HttpContext.Current.Response.Flush();

            }
            ShowReport((Dictionary<string, object>)Session["DicReport"], this.Page.IsPostBack);
        }

        private void ShowReport(Dictionary<string, object> dicReport, bool postBack)
        {

            IList<string> PersonnalCodeList = ((List<string>)dicReport["PersonBarcodeList"]);
            string year = dicReport["Year"].ToString();
            string month = dicReport["Month"].ToString();
            DateTime dtStartCalc = DateTime.Now;
            if (new BRequest().CheckTimeInsertRequestIsExpired(year + "/" + month + "/01", 2) == false)
            {
                if (((ASPWebClock.DAL.Model.Report)dicReport["Report"]).Report_IsCalculate == true && IsPostBack == false && ((bool)dicReport["Calculate"]) == true)
                {


                    int ThreadCount = int.Parse(WebConfigurationManager.AppSettings["ThreadCount"]);


                    Action[] actionsArray = new Action[PersonnalCodeList.Count];

                    Parallel.For(0, PersonnalCodeList.Count, index =>
                    {
                        actionsArray[index] = () => { DoWork(PersonnalCodeList[index]); };

                    });
                    ParallelOptions opt = new ParallelOptions();
                    opt.MaxDegreeOfParallelism = ThreadCount;
                    Parallel.Invoke(opt, actionsArray);


                    //ServiceReference1.CCServiceLibraryClient ccService = new ServiceReference1.CCServiceLibraryClient();
                    //bool result = ccService.CallThreats(PersonnalCodeList.ToArray(), year, month);

                    DateTime dtEndCalc = DateTime.Now;
                    TimeSpan ts = dtEndCalc - dtStartCalc;
                    Label1.Text = ts.Hours + ":" + ts.Minutes + ":" + ts.Seconds;


                }
            }
            string path = Server.MapPath("~") + WebConfigurationManager.AppSettings["TempReportPath"];
            StiOptions.Engine.ReportCache.CachePath = path;
            StiOptions.Engine.ImageCache.Enabled = false;
            StiOptions.Engine.AllowProgressInThread = true;
            
            StiReport report = (Stimulsoft.Report.StiReport)((Dictionary<string, object>)Session["DicReport"])["StiReport"];
            report.ReportCacheMode = StiReportCacheMode.On;
            report.ReportCachePath = path;
            report.RenderedPages.CanUseCacheMode = true;
            report.RenderedPages.CacheMode = true;
            report.UseProgressInThread = true;
            StiReportViewer.Report = report;
        }



        void DoWork(object personnelCode)
        {
            Dictionary<string, object> dic = (Dictionary<string, object>)Session["DicReport"];
            this.LoadCC(personnelCode.ToString(), dic["Year"].ToString(), dic["Month"].ToString());
        }

        private void LoadCC(string barcode, string year, string month)
        {
           
           

            
            try
            {

                ProcessStartInfo startInfo;
                Process process;

                startInfo = new ProcessStartInfo(WebConfigurationManager.AppSettings["CCFilePath"].ToString());
                startInfo.Arguments = barcode + " " + year + " " + month;
                startInfo.UseShellExecute = false;
                startInfo.CreateNoWindow = true;
                startInfo.RedirectStandardOutput = true;
                startInfo.RedirectStandardError = true;
                startInfo.RedirectStandardInput = true;

                process = new Process();
                process.StartInfo = startInfo;


                process.Start();

                process.WaitForExit();
                process.Close();
                process.Dispose();




            }
            catch (System.Exception ex)
            {
                string problem = ex.Message;

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Business;

namespace ASPWebclock.Operation
{
    public partial class RemainLeaveViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext.Current.Response.BufferOutput = false;
            HttpContext.Current.Response.Write(@"<html><head></head><body>
                    <div dir='rtl' style='width: 100%; font-family: tahoma; font-size: 9pt;' align='center'><div  id='divImgLoading' 
                        style='width: 150px; font-weight: bold;' dir='rtl'>
                لطفا منتظر بمانید
                <img id='imgLoading' src='../App_Themes/Aqua/Web/Loading.gif' />
                </div></div></body></html>");
            HttpContext.Current.Response.Flush();
            //***********************
            string year=Request.QueryString["year"];
            string month=Request.QueryString["month"];
            string personBarcode = new BWebpassUser().GetBarcodeByUserName(User.Identity.Name);
            if (Convert.ToBoolean(ConfigurationManager.AppSettings["UseCCService"]) == true)
            {
                CCWinService.CCServiceClient ccService = new CCWinService.CCServiceClient();
                string encryptionCode = new CryptData().EncryptData(year + month);
                bool result = ccService.CalculateOnePerson(personBarcode, year, month, encryptionCode);
            }
            else
            {
                ProcessStartInfo startInfo;
                Process process;
                startInfo = new ProcessStartInfo(WebConfigurationManager.AppSettings["CCFilePath"].ToString());
                startInfo.Arguments = personBarcode + " " + year + " " + month;
                startInfo.UseShellExecute = false;
                startInfo.CreateNoWindow = true;
                startInfo.RedirectStandardOutput = true;
                startInfo.RedirectStandardError = true;
                startInfo.RedirectStandardInput = true;
                process = new Process();
                process.StartInfo = startInfo;
                process.Start();
                process.WaitForExit();
            }

            Stimulsoft.Report.StiReport stiReport = new Stimulsoft.Report.StiReport();
            stiReport.Load(Server.MapPath("~") +  "/Operation/RemainLeave.mrt");
            foreach (Stimulsoft.Report.Dictionary.StiDatabase item in stiReport.Dictionary.Databases)
            {
                ((Stimulsoft.Report.Dictionary.StiSqlDatabase)item).ConnectionString = "Connect Timeout=60000;" + System.Configuration.ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;

            }
            stiReport.Compile();
            stiReport["@year"] = year;
            stiReport["@month"] = month;
            stiReport["@barcode"] = personBarcode;
            Response.Clear();
            StiReportViewer.Report = stiReport;
        }
    }
}
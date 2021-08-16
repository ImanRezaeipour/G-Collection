using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ASPWebClock.Infrastructure.Business;
using DevExpress.Data.Filtering;
using ASPWebClock.DAL.Business;
using ASPWebClock.DAL.Model;
using System.Web.Script.Serialization;
using DevExpress.Web.ASPxTreeList;
using ASPWebClock.Infrastructure.Model;
using System.Globalization;
using System.Diagnostics;
using System.ComponentModel;
using Stimulsoft.Report;
using System.Web.Configuration;
using DevExpress.Web.ASPxEditors;

namespace ASPWebclock.Report
{
    public partial class Report : System.Web.UI.Page
    {
        public BReport reportBussiness
        {
            get {
                return new BReport();
            }
        }
        public string ShamsiDate(DateTime MiladiDate)
        {
            PersianCalendar jc = new PersianCalendar();

            DateTime thisDate = MiladiDate;
            return jc.GetYear(thisDate).ToString() + "/" + (jc.GetMonth(thisDate) < 10 ? "0" : "") + jc.GetMonth(thisDate).ToString() + "/" + (jc.GetDayOfMonth(thisDate) < 10 ? "0" : "") + jc.GetDayOfMonth(thisDate).ToString();
        }
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public BUser userBussines
        {
            get
            {
                return new BUser();
            }
        }

        

        
       

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                FillSessionUnderManagmentPersonnel();
                FillTreeViewParts();
                FillASPxGridViewPersonnels();
                FillYearMonthDate(DateTime.Now);
                LoadAllReport();
                FillPishcard();
                FillTerminal();
                
            }
            if (ASPxGridViewPersonnels.IsCallback)
            {
                FillASPxGridViewPersonnels();
            }


        }
        private void FillTerminal()
        {
            DataTable dtResult = new BRequest().GetAllTerminal();
            ASPxComboBoxTerminal.DataSource = dtResult;
            ASPxComboBoxTerminal.TextField = "R_Name";
            ASPxComboBoxTerminal.ValueField = "R_Code";
            ASPxComboBoxTerminal.DataBind();
            ASPxComboBoxTerminal.Items.Insert(0, new ListEditItem("همه ترمینال ها", "All"));
            ASPxComboBoxTerminal.SelectedItem = ASPxComboBoxPishcard.Items.FindByValue("All");

        }
        private void FillPishcard()
        {
            DataTable dtResult = new BRequest().GetAllPishCard(new BUser().GetBarcodeByUserName(User.Identity.Name));
            ASPxComboBoxPishcard.DataSource = dtResult;
            ASPxComboBoxPishcard.TextField = "Pish_Name";
            ASPxComboBoxPishcard.ValueField="Pish_Code";
            ASPxComboBoxPishcard.DataBind();
            ASPxComboBoxPishcard.Items.Insert(0, new ListEditItem("همه درخواست ها", "All"));
            ASPxComboBoxPishcard.SelectedItem = ASPxComboBoxPishcard.Items.FindByValue("All");

        }
        private void FillSessionUnderManagmentPersonnel()
        {
         DataTable dtResult=new BPerson().GetUnderManagmentPersonnelAndCurrentUser(Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"]); 
         List<string> listBarcodeUnserManagmentPersonnel=new List<string>();
             for (int i = 0; i < dtResult.Rows.Count; i++)
			{
                 listBarcodeUnserManagmentPersonnel.Add(dtResult.Rows[i]["Barcode"].ToString()); 
			}
             Session["listBarcodeUnserManagmentPersonnel"] = listBarcodeUnserManagmentPersonnel;
             
        }
        
        private void LoadAllReport()
        {
            ASPxComboBoxReportName.TextField = "Report_Name";
            ASPxComboBoxReportName.ValueField = "Report_ID";
            ASPxComboBoxReportName.DataSource = reportBussiness.LoadAllReports();
            ASPxComboBoxReportName.DataBind();
            if (ASPxComboBoxReportName.Items.Count > 0)
                ASPxComboBoxReportName.SelectedIndex = 0;
        }
        private void FillYearMonthDate(DateTime dateSelected)
        {

            ASPxComboBoxYear.Value = ShamsiDate(dateSelected).Substring(0, 4);
            ASPxComboBoxMonth.Value = ShamsiDate(dateSelected).Substring(5, 2);
        }

        private void FillTreeViewParts()
        {

            Part partRoot = new ASPWebClock.DAL.Business.BPart().GetPartsRoot();

            DevExpress.Web.ASPxTreeView.TreeViewNode nodeRoot = new DevExpress.Web.ASPxTreeView.TreeViewNode();

            nodeRoot.Text = partRoot.P_Name;
            nodeRoot.Name = partRoot.P_CustomCode.ToString();


            LoadChildTreeViewParts(nodeRoot);
            ASPxTreeViewParts.Nodes.Add(nodeRoot);

            if (nodeRoot.Nodes.Count > 0)

                ASPxTreeViewParts.DataBind();
            ASPxTreeViewParts.Nodes.FindByName(nodeRoot.Name).Expanded = true;
        }

        private void LoadChildTreeViewParts(DevExpress.Web.ASPxTreeView.TreeViewNode nodRoot)
        {
            List<Part> listpartNodes = new ASPWebClock.DAL.Business.BPart().GetChildPartByCustomCode(nodRoot.Name);


            foreach (var item in listpartNodes)
            {

                DevExpress.Web.ASPxTreeView.TreeViewNode itemchild = new DevExpress.Web.ASPxTreeView.TreeViewNode();
                itemchild.Text = item.P_Name;
                itemchild.Name = item.P_CustomCode.ToString();

                nodRoot.Nodes.Add(itemchild);
                LoadChildTreeViewParts(itemchild);

            }


        }
        private List<string> GetPersonnelSelectedPartsAndSubParts(List<string> listPartName)
        {
            List<string> listPersonBarcode = new List<string>();

            foreach (var itemPart in listPartName)
            {
                List<string> listPersonBarcodeTemp = new ASPWebClock.Infrastructure.Business.BPerson().GetPersonBarcodeByPart(itemPart);
                foreach (var itemPerson in listPersonBarcodeTemp)
                {
                    if (((List<string>)Session["listBarcodeUnserManagmentPersonnel"]).Contains(itemPerson))
                    listPersonBarcode.Add(itemPerson);
                }
            }

            return listPersonBarcode;        


        }
        private void GetSelectedNodesNameInTreeView(string nodeName,List<string> listNodeName,bool subParts)
        {
            DevExpress.Web.ASPxTreeView.TreeViewNodeCollection collectionNode = ASPxTreeViewParts.Nodes.FindByName(nodeName).Nodes;
            foreach (DevExpress.Web.ASPxTreeView.TreeViewNode item in collectionNode)
            {
                if (item.Checked == true)
                {
                    listNodeName.Add(item.Name);
                    if (subParts == true)
                    {
                        foreach (DevExpress.Web.ASPxTreeView.TreeViewNode item2 in ASPxTreeViewParts.Nodes.FindByName(item.Name).Nodes)
                        {
                            ASPxTreeViewParts.Nodes.FindByName(item2.Name).Checked = true;
                        }
                        
                    }

                }
                GetSelectedNodesNameInTreeView(item.Name,listNodeName,subParts);

            }
        }
        
        protected void ASPxCallbackReportView_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            e.Result = "Error";
            Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
            string type = obj["Type"].ToString();
            string year = obj["Year"].ToString();
            string month = obj["Month"].ToString();
            bool subParts = Convert.ToBoolean(obj["SubPart"]);
            decimal reportID = Convert.ToDecimal (obj["ReportID"]);
            bool caculate = Convert.ToBoolean(obj["Calculate"]);
            
            string pishcard=obj["Pishcard"].ToString();
            string terminal = obj["Terminal"].ToString();
            string fromDate = JQDatePickerFromDate.Text;
            string toDate = JQDatePickerToDate.Text;
            string date = JQDatePickerDate.Text;
            string monthCalculate = "";
            string YearCalculate = "";
            List<string> listPerson = new List<string>(); ;
            switch (type)
            {
                case "Part":
                    {
                        List<string> listPartName = new List<string>();
                        if (ASPxTreeViewParts.Nodes[0].Checked == true)
                        {
                            listPartName.Add(ASPxTreeViewParts.Nodes[0].Name);
                            if (subParts == true)
                            {
                                foreach (DevExpress.Web.ASPxTreeView.TreeViewNode item2 in ASPxTreeViewParts.Nodes[0].Nodes)
                                {
                                    ASPxTreeViewParts.Nodes.FindByName(item2.Name).Checked = true;
                                }

                            }
                        }
                        GetSelectedNodesNameInTreeView(ASPxTreeViewParts.Nodes[0].Name, listPartName,subParts);


                        listPerson = GetPersonnelSelectedPartsAndSubParts(listPartName);
                        
                        
                        break;
                    }
                case "Person":
                    {
                       
                        List<object> listSelectedRows=  ASPxGridViewPersonnels.GetSelectedFieldValues("Barcode");
                       
                        for (int i = 0; i < listSelectedRows.Count; i++)
                        {
                            listPerson.Add(listSelectedRows[i].ToString());
                        }
                       
                      
                        break;
                    }
                default:
                    break;
            }
            ASPWebClock.DAL.Model.Report report = reportBussiness.GetReportByID(reportID);
            Stimulsoft.Report.StiReport stiReport = new Stimulsoft.Report.StiReport();
            stiReport.Load(Server.MapPath("~") + report.Report_FileAddress);
            
           
            

            foreach (Stimulsoft.Report.Dictionary.StiDatabase item in stiReport.Dictionary.Databases)
            {
                ((Stimulsoft.Report.Dictionary.StiSqlDatabase)item).ConnectionString ="Connect Timeout=60000;" +  System.Configuration.ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;

            }
            stiReport.Compile();
            string barcodeExpression = "";
            for (int i = 0; i < listPerson.Count; i++)
            {
                if (listPerson[i].Count() == 8)
                {
                    if (i != listPerson.Count - 1)
                        barcodeExpression += listPerson[i] + ",";
                    else
                        barcodeExpression += listPerson[i];
                }
            }
            
            switch (reportBussiness.GetReportParameterTypeByID(report.Report_ParameterTypeID))
            {
                case "DateRangePerson":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        stiReport["@month"] = month;
                        stiReport["@year"] = year;
                        stiReport["@barcode"] = barcodeExpression;
                        stiReport["month"] =AppCode.PersianDateTime.GetMonthName(month);
                        stiReport["year"] = year;
                        monthCalculate = month;
                        YearCalculate = year;
                        break;
                    }
                case "FromToDatePerson":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        if(fromDate=="" || toDate=="")
                            throw new Exception("فیلد تاریخ را تکمیل نمایید.");
                        stiReport["@fromDate"] = fromDate;
                        stiReport["@toDate"] = toDate;
                        stiReport["@barcode"] = barcodeExpression;
                        stiReport["fromDate"] = fromDate;
                        stiReport["toDate"] = toDate;
                        monthCalculate = toDate.Substring(5, 2);
                        YearCalculate = toDate.Substring(0, 4);
                        break;
                    }
                case "DatePerson":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        if (date == "")
                            throw new Exception("فیلد تاریخ را تکمیل نمایید.");
                        stiReport["@date"] = date;
                        stiReport["@barcode"] = barcodeExpression;
                        stiReport["fromDate"] = date;
                        monthCalculate = date.Substring(5, 2);
                        YearCalculate = date.Substring(0, 4);
                        break;
                    }
                case "Barcode":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        stiReport["@barcode"] = barcodeExpression;
                        break;
                    }
                case "None":
                    {

                        break;
                    }
                case "FromToDatePersonPishcard":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        if (fromDate == "" || toDate == "")
                            throw new Exception("فیلد تاریخ را تکمیل نمایید.");
                        stiReport["@fromDate"] = fromDate;
                        stiReport["@toDate"] = toDate;
                        stiReport["@barcode"] = barcodeExpression;
                        stiReport["fromDate"] = fromDate;
                        stiReport["toDate"] = toDate;
                        stiReport["@pishcard"] =pishcard;
                        monthCalculate = toDate.Substring(5, 2);
                        YearCalculate = toDate.Substring(0, 4);
                        break;
                    }
                case "FromToDatePersonTerminal":
                    {
                        if (barcodeExpression == "")
                            throw new Exception("پرسنلی برای این گزارش موجود نیست");
                        if (fromDate == "" || toDate == "")
                            throw new Exception("فیلد تاریخ را تکمیل نمایید.");
                        stiReport["@fromDate"] = fromDate;
                        stiReport["@toDate"] = toDate;
                        stiReport["@barcode"] = barcodeExpression;
                        stiReport["fromDate"] = fromDate;
                        stiReport["toDate"] = toDate;
                        stiReport["@terminal"] = terminal;
                        monthCalculate = toDate.Substring(5, 2);
                        YearCalculate = toDate.Substring(0, 4);
                        break;
                    }
                default:
                    break;
            }

            string pathReportFileTemp = Server.MapPath("~") + WebConfigurationManager.AppSettings["TempReportPath"];
            foreach (var item in System.IO.Directory.GetFiles(pathReportFileTemp))
            {
                System.IO.FileInfo file=new System.IO.FileInfo(item);

                if (file.Exists && file.CreationTime.Date < DateTime.Now.Date)
                {
                    file.Delete();
                }
                
            }
            Dictionary<string, object> dicReport = new Dictionary<string, object>();
            dicReport.Add("PersonBarcodeList", listPerson);
            dicReport.Add("StiReport", stiReport);
            dicReport.Add("Report", report);
            dicReport.Add("Year",YearCalculate);
            dicReport.Add("Month",monthCalculate);
            dicReport.Add("Calculate", caculate);
            Session["DicReport"] = dicReport;
            e.Result = "Success";
        }

       
        protected void ASPxGridViewPersonnels_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            bool status = Convert.ToBoolean(e.Parameters);
            switch (status)
            {
                case true:
                    {

                        
                        for (int i = 0; i < ASPxGridViewPersonnels.VisibleRowCount; i++)
                        {
                            ASPxGridViewPersonnels.Selection.SelectRow(i);
                        }
                        break;
                    }
                case false:
                    {
                        ASPxGridViewPersonnels.Selection.UnselectAll();
                        break;
                    }
                    
                default:
                    break;
            }
            

        }
        private void FillASPxGridViewPersonnels()
        {

            try
            {

                Session["ASPxGridViewPersonnels_ReportPage"] = null;
                if (Session["ASPxGridViewPersonnels_ReportPage"] == null)
                {

                    DataTable dtResult = new BPerson().GetUnderManagmentPersonnelAndCurrentUser(Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"]); 
                    Session.Add("ASPxGridViewPersonnels_ReportPage", dtResult);




                }
                ASPxGridViewPersonnels.DataSource = (System.Data.DataTable)Session["ASPxGridViewPersonnels_ReportPage"];
                ASPxGridViewPersonnels.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void ASPxGridViewPersonnels_ProcessColumnAutoFilter(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewAutoFilterEventArgs e)
        {
            if (Session["valFilter_ASPxGridViewPersonnels_ReportPage"] == null)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                Session["valFilter_ASPxGridViewPersonnels_ReportPage"] = dic;

            }

            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.CreateCriteria)
            {

                string newVal = "%" + e.Value + "%";
                e.Criteria = new BinaryOperator(e.Column.FieldName, new StringGenerator().TruePersianKeyboard(newVal), BinaryOperatorType.Like);
                if (!((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_ReportPage"]).ContainsKey(e.Column.FieldName.ToString()))
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_ReportPage"]).Add(e.Column.FieldName, e.Value);

                }
                else
                {
                    ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_ReportPage"])[e.Column.FieldName] = e.Value;
                }
            }
            if (e.Kind == DevExpress.Web.ASPxGridView.GridViewAutoFilterEventKind.ExtractDisplayText)
            {

                e.Value = ((Dictionary<string, string>)Session["valFilter_ASPxGridViewPersonnels_ReportPage"])[e.Column.FieldName].ToString();
            }
        }

        protected void ASPxCallbackSetParameterReport_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            ASPWebClock.DAL.Model.Report rpt = reportBussiness.GetReportByID(Convert.ToDecimal(e.Parameter));
            e.Result =reportBussiness.GetReportParameterTypeByID(rpt.Report_ParameterTypeID);
        }

        



      
        

       






    }
}
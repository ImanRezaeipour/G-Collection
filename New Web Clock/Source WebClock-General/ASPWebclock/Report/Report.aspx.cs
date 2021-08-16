using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ASPWebClock.Infrastructure.Business;
using DevExpress.Data.Filtering;
using ASPWebClock.Infrastructure.Model;
using System.Web.Script.Serialization;
using DevExpress.Web.ASPxTreeList;
using System.Globalization;
using System.Diagnostics;
using System.ComponentModel;
using Stimulsoft.Report;
using System.Web.Configuration;
using DevExpress.Web.ASPxEditors;
using System.Text;
using ASPWebClock.Infrastructure.Utility;
using ASPWebclock.AppCode;
using DevExpress.Web.ASPxCallback;
using DevExpress.Web.ASPxGridView;
namespace ASPWebclock.Report
{
    public partial class Report : System.Web.UI.Page
    {
        enum PishcardType
        {
            All,
            Daily,
            Hourly

        }
        public BReport reportBussiness
        {
            get
            {
                return new BReport();
            }
        }
        
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public BWebpassUser userBussines
        {
            get
            {
                return new BWebpassUser();
            }
        }






        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();
            SessionHandler.CheckSessionTimeOut(Page);
            if (!IsPostBack)
            {
                FillSessionUnderManagmentPersonnel();
                FillTreeViewParts();
                FillASPxGridViewPersonnels();
                LoadAllReport(Convert.ToDecimal(Session["PostID"]));
                FillJobType();
                FillPishcard(PishcardType.Daily);
                FillPishcard(PishcardType.Hourly);
                FillTerminal();
                FillStation();
                FillYearMonthDate(DateTime.Now);
                FillFromToDate(DateTime.Now);



            }
            if (ASPxGridViewPersonnels.IsCallback)
            {
                FillASPxGridViewPersonnels();
            }


        }
        private void FillTimeEdits()
        {
            try
            {
                ASPxTimeEditFromTime.Text = "08:00";
                ASPxTimeEditToTime.Text = "16:00";
            }
            catch (Exception ex)
            {

                throw ex;
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
            ASPxComboBoxTerminal.SelectedItem = ASPxComboBoxTerminal.Items.FindByValue("All");

        }
        private void FillStation()
        {

            ASPxComboBoxStation.DataSource = new BStation().GetAllStations();
            ASPxComboBoxStation.TextField = "st_Name";
            ASPxComboBoxStation.ValueField = "st_Code";
            ASPxComboBoxStation.DataBind();
            ASPxComboBoxStation.Items.Insert(0, new ListEditItem("همه ایستگاه ها", "All"));
            ASPxComboBoxStation.SelectedItem = ASPxComboBoxStation.Items.FindByValue("All");

        }
        private void FillJobType()
        {
            try
            {
                ASPxComboBoxEmploymentType.DataSource = new BJobType().GetAllJobType();
                ASPxComboBoxEmploymentType.TextField = "Job_Name";
                ASPxComboBoxEmploymentType.ValueField = "Job_Code";
                ASPxComboBoxEmploymentType.DataBind();
                ASPxComboBoxEmploymentType.Items.Insert(0, new ListEditItem("همه استخدامی ها", "All"));
                ASPxComboBoxEmploymentType.SelectedItem = ASPxComboBoxEmploymentType.Items.FindByValue("All");
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void FillPishcard(PishcardType pishType)
        {
            DataTable dtResult = new DataTable();
            switch (pishType)
            {
                case PishcardType.Daily:
                    {
                        List<Pishcard> pishcardList = new BPishcard().GetPishCardDailyPerson(((Person)Session["PersonObj"]).Barcode);
                        ASPxComboBoxPishcardDaily.DataSource = pishcardList;
                        ASPxComboBoxPishcardDaily.TextField = "Name";
                        ASPxComboBoxPishcardDaily.ValueField = "Code";
                        ASPxComboBoxPishcardDaily.DataBind();
                        ASPxComboBoxPishcardDaily.Items.Insert(0, new ListEditItem("همه درخواست ها", "All"));
                        ASPxComboBoxPishcardDaily.SelectedItem = ASPxComboBoxPishcardDaily.Items.FindByValue("All");
                        break;
                    }
                case PishcardType.Hourly:
                    {
                        List<Pishcard> pishcardList = new BPishcard().GetPishCardHourlyPermitPerson(((Person)Session["PersonObj"]).Barcode);
                        ASPxComboBoxPishcardHourly.DataSource = pishcardList;
                        ASPxComboBoxPishcardHourly.TextField = "Name";
                        ASPxComboBoxPishcardHourly.ValueField = "Code";
                        ASPxComboBoxPishcardHourly.DataBind();
                        ASPxComboBoxPishcardHourly.Items.Insert(0, new ListEditItem("همه درخواست ها", "All"));
                        ASPxComboBoxPishcardHourly.SelectedItem = ASPxComboBoxPishcardHourly.Items.FindByValue("All");
                        break;
                    }
                case PishcardType.All:
                    {
                        List<Pishcard> pishcardList = new BPishcard().GetAllPishCardPerson(((Person)Session["PersonObj"]).Barcode);
                        break;
                    }
                default:
                    break;
            }




        }
        private void FillSessionUnderManagmentPersonnel()
        {
            List<Person> personList = new BPerson().GetUnderManagmentPersonnelAndCurrentUser(Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"]);
            List<string> listBarcodeUnserManagmentPersonnel = new List<string>();
            for (int i = 0; i < personList.Count; i++)
            {
                listBarcodeUnserManagmentPersonnel.Add(personList[i].Barcode);
            }
            Session["listBarcodeUnserManagmentPersonnel"] = listBarcodeUnserManagmentPersonnel;

        }

        private void LoadAllReport(decimal webpassID)
        {
          
           
            Person prs = new BWebpassUser().GetPersonByUserName(User.Identity.Name);
            int prsPostStatus = new BWebpassUser().GetPostOfPerson(prs.Barcode).SingleOrDefault(p => p.ID == webpassID).Status;

            ASPxComboBoxReportName.TextField = "Report_Name";
            ASPxComboBoxReportName.ValueField = "Report_ID";
            ASPxComboBoxReportName.DataSource = reportBussiness.LoadAllReportsByPerson(prsPostStatus);
            ASPxComboBoxReportName.DataBind();
            if (ASPxComboBoxReportName.Items.Count > 0)
                ASPxComboBoxReportName.SelectedIndex = 0;
        }
        private void FillYearMonthDate(DateTime dateSelected)
        {

            ASPxComboBoxYear.Value = Utility.MiladiToShamsiDate (dateSelected).Substring(0, 4);
            ASPxComboBoxMonth.Value = Utility.MiladiToShamsiDate(dateSelected).Substring(5, 2);
        }
        private void FillFromToDate(DateTime dateSelected)
        {

            JQDatePickerFromDate.Text = Utility.MiladiToShamsiDate(dateSelected);
            JQDatePickerToDate.Text = Utility.MiladiToShamsiDate(dateSelected);
            JQDatePickerDate.Text = Utility.MiladiToShamsiDate(dateSelected);

        }
        private void FillTreeViewParts()
        {
            string typePart = new BPart().GetPartsType();
            switch (typePart)
            {
                case "ByRoot":

                    {
                        Part partRoot = new BPart().GetPartsRoot();

                        DevExpress.Web.ASPxTreeView.TreeViewNode nodeRoot = new DevExpress.Web.ASPxTreeView.TreeViewNode();

                        nodeRoot.Text = partRoot.P_Name;
                        nodeRoot.Name = partRoot.P_Code.ToString();

                        IList<Part> iListpartNodes = new ASPWebClock.Infrastructure.Business.BPart().GetAllChildPart(nodeRoot.Name);
                        LoadChildTreeViewParts(nodeRoot, iListpartNodes);

                        ASPxTreeViewParts.Nodes.Add(nodeRoot);

                        if (nodeRoot.Nodes.Count > 0)

                            ASPxTreeViewParts.DataBind();
                        ASPxTreeViewParts.Nodes.FindByName(nodeRoot.Name).Expanded = true;
                        break;
                    }

                case "NoRoot":
                    {
                        List<Part> partList = new BPart().GetAllParts();
                        foreach (Part item in partList)
                        {
                            DevExpress.Web.ASPxTreeView.TreeViewNode node = new DevExpress.Web.ASPxTreeView.TreeViewNode();

                            node.Text = item.P_Name;
                            node.Name = item.P_Code.ToString();
                            ASPxTreeViewParts.Nodes.Add(node);
                        }

                        break;
                    }


                default:
                    break;
            }
           
        }
        //************************

        private void LoadChildTreeViewParts(DevExpress.Web.ASPxTreeView.TreeViewNode nodRoot , IList<Part> iListPartNodes )
        {
            IList<Part> iListChilds = iListPartNodes.Where(x => x.P_Father == nodRoot.Name).ToList();
            
            foreach (var itemm in iListChilds)
             {
                 DevExpress.Web.ASPxTreeView.TreeViewNode itemChild = new DevExpress.Web.ASPxTreeView.TreeViewNode();
                 itemChild.Text = itemm.P_Name;
                 itemChild.Name = itemm.P_Code.ToString();
                 nodRoot.Nodes.Add(itemChild);
                 LoadChildTreeViewParts(itemChild, iListPartNodes);

             }
        }
        private IList<Person> GetPersonnelSelectedPartsAndSubParts(List<string> listPartName)
        {
            List<Person> personList = new List<Person>();

            foreach (var itemPart in listPartName)
            {
                IList<Person> personListemp = new BPerson().GetPersonByPart(itemPart);
                foreach (var itemPerson in personListemp)
                {
                    if (((List<string>)Session["listBarcodeUnserManagmentPersonnel"]).Contains(itemPerson.Barcode))
                        personList.Add(itemPerson);
                }
            }

            return personList;


        }
        private void GetSelectedNodesNameInTreeView(string nodeName, List<string> listNodeName, bool subParts)
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
                GetSelectedNodesNameInTreeView(item.Name, listNodeName, subParts);

            }
        }

        protected void ASPxCallbackReportView_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            try
            {


                e.Result = "Error";
                Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameter);
                string type = obj["Type"].ToString();
                string year = obj["Year"].ToString();
                string month = obj["Month"].ToString();
                bool subParts = Convert.ToBoolean(obj["SubPart"]);
                decimal reportID = Convert.ToDecimal(obj["ReportID"]);
                bool caculate = Convert.ToBoolean(obj["Calculate"]);

                string pishcard = obj["Pishcard"].ToString();
                string terminal = obj["Terminal"].ToString();
                string station = obj["Station"].ToString();
                string employmentType = obj["EmploymentType"].ToString();
                string fromDate = JQDatePickerFromDate.Text;
                string toDate = JQDatePickerToDate.Text;
                string date = JQDatePickerDate.Text;
                string monthCalculate = "";
                string YearCalculate = "";
                string fromTime = obj["FromTime"].ToString();
                string toTime = obj["ToTime"].ToString();
                string timeStartHour = obj["TimeStarHour"].ToString();
                string timeStartMinute = obj["TimeStarMinute"].ToString();
                string timeEndHour = obj["TimeEndHour"].ToString();
                string timeEndMinute = obj["TimeEndMinute"].ToString();
                string dayStart = obj["DayStart"].ToString();
                string dayEnd = obj["DayEnd"].ToString();

                IList<Person> personList = new List<Person>(); ;
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
                            GetSelectedNodesNameInTreeView(ASPxTreeViewParts.Nodes[0].Name, listPartName, subParts);
                            personList = GetPersonnelSelectedPartsAndSubParts(listPartName);
                            break;
                        }
                    case "Person":
                        {

                            List<object> listSelectedRows = ASPxGridViewPersonnels.GetSelectedFieldValues("Barcode");

                            for (int i = 0; i < listSelectedRows.Count; i++)
                            {
                                Person personObj = new Person()
                                {
                                    Barcode = listSelectedRows[i].ToString()

                                };
                                personList.Add(personObj);
                            }


                            break;
                        }
                    default:
                        break;
                }
                ASPWebClock.Infrastructure.Model.Report report = reportBussiness.GetReportByID(reportID);
                Stimulsoft.Report.StiReport stiReport = new Stimulsoft.Report.StiReport();
                stiReport.Load(Server.MapPath("~") + report.Report_FileAddress);
                foreach (Stimulsoft.Report.Dictionary.StiDatabase item in stiReport.Dictionary.Databases)
                {
                    ((Stimulsoft.Report.Dictionary.StiSqlDatabase)item).ConnectionString = "Connect Timeout=60000;" + System.Configuration.ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;

                }
                stiReport.Compile();
                string barcodeExpression = "";
                for (int i = 0; i < personList.Count; i++)
                {
                    if (personList[i].Barcode.Count() == 8)
                    {
                        if (i != personList.Count - 1)
                            barcodeExpression += personList[i].Barcode + ",";
                        else
                            barcodeExpression += personList[i].Barcode;
                    }
                }

                List<ReportParameterProxy> reportParameterList = new BAssignReportParameter().GetReportParametersByID(reportID);
                for (int i = 0; i < reportParameterList.Count; i++)
                {
                    ParameterNames paramName = (ParameterNames)Enum.Parse(typeof(ParameterNames), reportParameterList[i].ReportParameterType_Value);
                    switch (paramName)
                    {
                        case ParameterNames.Date:
                            stiReport["@date"] = date;
                            stiReport["fromDate"] = date;
                            monthCalculate = date.Substring(5, 2);
                            YearCalculate = date.Substring(0, 4);
                            break;
                        case ParameterNames.DateRange:
                            stiReport["@month"] = month;
                            stiReport["@year"] = year;
                            stiReport["month"] = AppCode.PersianDateTime.GetMonthName(month);
                            stiReport["year"] = year;
                            monthCalculate = month;
                            YearCalculate = year;
                            break;
                        case ParameterNames.FromToDate:
                            if (fromDate == "" || toDate == "")
                                throw new Exception("فیلد تاریخ را تکمیل نمایید.");
                            stiReport["@fromDate"] = fromDate;
                            stiReport["@toDate"] = toDate;

                            stiReport["fromDate"] = fromDate;
                            stiReport["toDate"] = toDate;
                            monthCalculate = toDate.Substring(5, 2);
                            YearCalculate = toDate.Substring(0, 4);
                            break;
                        case ParameterNames.Barcode:
                            if (barcodeExpression == "")
                                throw new Exception("پرسنلی برای این گزارش موجود نیست");
                            stiReport["@barcode"] = barcodeExpression;
                            date = Utility.MiladiToShamsiDate(DateTime.Now);
                            monthCalculate = date.Substring(5, 2);
                            YearCalculate = date.Substring(0, 4);
                            break;
                        case ParameterNames.None:
                            break;
                        case ParameterNames.PishcardHourly:
                            stiReport["@pishcard"] = pishcard;
                            break;
                        case ParameterNames.PishcardDaily:
                            stiReport["@pishcard"] = pishcard;
                            break;

                        case ParameterNames.TimeRange:
                            {
                                int result;
                                if ((timeStartHour == "" && timeEndHour == "" && timeStartMinute == "" && timeEndMinute == "") || !(int.TryParse(timeStartMinute, out result)) || !(int.TryParse(timeStartHour, out result)) || !(int.TryParse(timeEndHour, out result)) || !(int.TryParse(timeEndMinute, out result)))
                                    throw new Exception("لطفا زمان صحیح را مقدار دهی نمایید");

                                int timeSMinute = (Convert.ToInt32(timeStartHour) * 60) + Convert.ToInt32(timeStartMinute);
                                int timeEMinute = (Convert.ToInt32(timeEndHour) * 60) + Convert.ToInt32(timeEndMinute);
                                stiReport["@timeStart"] = timeSMinute;
                                stiReport["@timeEnd"] = timeEMinute;
                                break;
                            }

                        case ParameterNames.FromToTime:
                            {
                                if (fromTime == toTime && fromTime == "00:00")
                                    throw new Exception("لطفا زمان را مقدار دهی نمایید");

                                int timeSMinute = (Convert.ToInt32(fromTime.Substring(0, 2)) * 60) + Convert.ToInt32(fromTime.Substring(3, 2));
                                int timeEMinute = (Convert.ToInt32(toTime.Substring(0, 2)) * 60) + Convert.ToInt32(toTime.Substring(3, 2));
                                if (timeSMinute > timeEMinute)
                                    throw new Exception("لطفا زمان را صحیح مقدار دهی نمایید");
                                stiReport["@fromTime"] = timeSMinute;
                                stiReport["@toTime"] = timeEMinute;

                                break;
                            }
                        case ParameterNames.Terminal:
                            stiReport["@terminal"] = terminal;
                            break;
                        case ParameterNames.EmploymentType:
                            stiReport["@employmentType"] = employmentType;
                            break;
                        case ParameterNames.Station:
                            stiReport["@station"] = station;
                            break;
                        case ParameterNames.DayRange:
                            int result2;
                            if ((dayStart == "" && dayEnd == "") || !(int.TryParse(dayStart, out result2)) || !(int.TryParse(dayEnd, out result2)))
                                throw new Exception("لطفا زمان صحیح را مقدار دهی نمایید");


                            stiReport["@dayStart"] = dayStart;
                            stiReport["@dayEnd"] = dayEnd;
                            break;
                        default:
                            break;
                    }
                }



                string pathReportFileTemp = Server.MapPath("~") + WebConfigurationManager.AppSettings["TempReportPath"];
                if (!System.IO.Directory.Exists(pathReportFileTemp))
                    System.IO.Directory.CreateDirectory(pathReportFileTemp);
                foreach (var item in System.IO.Directory.GetFiles(pathReportFileTemp))
                {
                    System.IO.FileInfo file = new System.IO.FileInfo(item);

                    if (file.Exists && file.CreationTime.Date < DateTime.Now.Date)
                    {
                        file.Delete();
                    }

                }
                Dictionary<string, object> dicReport = new Dictionary<string, object>();
                dicReport.Add("PersonList", personList);
                dicReport.Add("StiReport", stiReport);
                dicReport.Add("Report", report);
                dicReport.Add("Year", YearCalculate);
                dicReport.Add("Month", monthCalculate);
                dicReport.Add("Calculate", caculate);
                Session["DicReport"] = dicReport;
                e.Result = "Success";
            }
            catch (MyExceptionHandler ex)
            {
                ((ASPxCallback)source).JSProperties.Add("cpError",ex.Message);
            }
            catch (Exception ex)
            {

                ((ASPxCallback)source).JSProperties.Add("cpError", ex.Message);
            }
        }


        protected void ASPxGridViewPersonnels_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            try
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
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError",ex.Message);
            }
        }
        private void FillASPxGridViewPersonnels()
        {

            try
            {

                Session["ASPxGridViewPersonnels_ReportPage"] = null;
                if (Session["ASPxGridViewPersonnels_ReportPage"] == null)
                {

                    List<Person> personList = new BPerson().GetUnderManagmentPersonnelAndCurrentUser(Convert.ToDecimal(Session["PostID"]), (IList<decimal>)Session["ListPostIDInsteadMan"]);
                    Session.Add("ASPxGridViewPersonnels_ReportPage", personList);




                }
                ASPxGridViewPersonnels.DataSource = Session["ASPxGridViewPersonnels_ReportPage"];
                ASPxGridViewPersonnels.DataBind();
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void ASPxGridViewPersonnels_ProcessColumnAutoFilter(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewAutoFilterEventArgs e)
        {
            try
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
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError",ex.Message);
            }
        }





        enum ParameterNames
        {
            Date,
            DateRange,
            FromToDate,
            Barcode,
            None,
            PishcardHourly,
            PishcardDaily,
            TimeRange,
            FromToTime,
            Terminal,
            EmploymentType,
            Station,
            DayRange
        }
        enum PanelParameterIDs
        {
            RoundPanelDateRange,
            RoundPanelFromToDate,
            RoundPanelDate,
            RoundPanelFromToTime,
            RoundPanelTimeRange,
            RoundPanelPishcardDaily,
            RoundPanelPishcardHourly,
            RoundPanelEmploymentType,
            RoundPanelTerminal,
            RoundPanelStation,
            RoundPanelDayRange
        }
        protected void ASPxCallbackSetParameterVisible_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            try
            {

            
            List<ReportParameterProxy> reportParamaterList = new BAssignReportParameter().GetReportParametersByID(Convert.ToDecimal(e.Parameter));
            List<string> parameterVisibleList = new List<string>();

            for (int i = 0; i < reportParamaterList.Count; i++)
            {

                ParameterNames paramName = (ParameterNames)Enum.Parse(typeof(ParameterNames), reportParamaterList[i].ReportParameterType_Value);
                switch (paramName)
                {
                    case ParameterNames.Date:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelDate.ToString());
                        break;
                    case ParameterNames.DateRange:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelDateRange.ToString());
                        break;
                    case ParameterNames.FromToDate:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelFromToDate.ToString());
                        break;
                    case ParameterNames.Barcode:

                        break;
                    case ParameterNames.None:
                        break;
                    case ParameterNames.PishcardHourly:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelPishcardHourly.ToString());
                        break;
                    case ParameterNames.PishcardDaily:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelPishcardDaily.ToString());
                        break;

                    case ParameterNames.TimeRange:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelTimeRange.ToString());
                        break;
                    case ParameterNames.FromToTime:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelFromToTime.ToString());
                        break;
                    case ParameterNames.Terminal:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelTerminal.ToString());
                        break;
                    case ParameterNames.EmploymentType:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelEmploymentType.ToString());
                        break;
                    case ParameterNames.Station:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelStation.ToString());
                        break;
                    case ParameterNames.DayRange:
                        parameterVisibleList.Add(PanelParameterIDs.RoundPanelDayRange.ToString());
                        break;
                    default:
                        break;
                }

            }

            e.Result = JsSerializer.Serialize(parameterVisibleList);
            }
            catch (MyExceptionHandler ex)
            {
                ((ASPxCallback)source).JSProperties.Add("cpError", ex.Message);
            }
            catch (Exception ex)
            {
                ((ASPxCallback)source).JSProperties.Add("cpError",ex.Message);
                
            }
        }




    }
}
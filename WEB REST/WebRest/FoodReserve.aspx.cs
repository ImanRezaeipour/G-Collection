using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Model;
using Business;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxEditors;
using System.Web.Script.Serialization;
using DevExpress.Web.ASPxCallbackPanel;
using DevExpress.Web.ASPxCallback;
using Business;
using WebRest.Utility;


namespace WebRest
{
    public partial class FoodReserve : System.Web.UI.Page
    {
        public BGroup groupBusiness
        {
            get
            {
                return new BGroup();
            }

        }
        public JavaScriptSerializer JsSerializer
        {
            get
            {
                return new JavaScriptSerializer();
            }
        }
        public BBuilding BuildingBusiness
        {
            get
            {
                return new BBuilding();
            }
        }
        public BParameter paramaterBusiness
        {
            get
            {
                return new BParameter();
            }
        }
        public BPerson personBusiness
        {
            get
            {
                return new BPerson();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            RefererValidation.CheckReferer();

            SessionHandler.CheckSessionTimeOut();
            
            if (!IsPostBack)
            {
                LoadCurrentDate();
                FillASPxGridViewFoodReserve(ASPxComboBoxYear.Value.ToString(), ASPxComboBoxMonth.Value.ToString());

                FillPersonCreditRemain(((person)Session["PersonObj"]).P_BarCode);
                LoadDateReport();
            }

           
          
        }
        private void LoadDateReport()
        {
           
            JQDatePickerToDateReport_FoodReserve.Text = Business.Utility.MiladiToShamsi(DateTime.Now);
            JQDatePickerFromDateReport_FoodReserve.Text = JQDatePickerToDateReport_FoodReserve.Text.Substring(0, 4) + "/" + JQDatePickerToDateReport_FoodReserve.Text.Substring(5, 2) + "/01";
        }
        private void LoadCurrentDate()
        {
            DateTime currentDate = DateTime.Now;
            System.Globalization.PersianCalendar pCalendar = new System.Globalization.PersianCalendar();
            string year = "";
            string month = "";
            if (pCalendar.GetMonth(currentDate) < 10)
                month = "0" + pCalendar.GetMonth(currentDate).ToString();
            else
                month = pCalendar.GetMonth(currentDate).ToString();
            year = pCalendar.GetYear(currentDate).ToString();
            ASPxComboBoxYear.Value = year;
            ASPxComboBoxMonth.Value = month;

        }
        private void FillPersonCreditRemain(string barcode)
        {
            try
            {
                ASPxLabelPersonCredit_FoodReserve.Text = "میزان مانده اعتبار شما " + Business.Utility.NumberToCurrencyFormat(Convert.ToUInt32(((person)Session["PersonObj"]).P_Credit).ToString()) + " ریال می باشد";
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        private void FillGridViewFoodListDetails(string date, short type, Dictionary<string, string> paramDic,int rowExpandedIndex)
        {
            try
            {
               List<WeekCustomizeModel> weekCustomModelList = new BWeek().GetFoodWeekByDateByType((person)Session["PersonObj"], date, type,paramDic);
               ((ASPxGridView)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxGridViewFoodListDetailsFoodReserve_FoodReserve")).DataSource = weekCustomModelList;
               ((ASPxGridView)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxGridViewFoodListDetailsFoodReserve_FoodReserve")).DataBind();
               
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        private void FillGridViewsupplementsListDetails(string date, short type,Dictionary<string,string> paramDic,int rowExpandedIndex)
        {
            try
            {
                wr_ReserveRange reserveRangeObj = new BReserveRange().GetReserveRange();
                if (reserveRangeObj.ReservRange_Mokhalafat == true)
                {
                    List<WeekCustomizeModel> weekCustomModelList = new BWeek().GetSupplementsWeekByDateByType((person)Session["PersonObj"], date, type, paramDic);
                    ((ASPxGridView)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve")).DataSource = weekCustomModelList;
                    ((ASPxGridView)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve")).DataBind();
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void FillComboBoxMealType(string barcode,string date, int rowExpandedIndex)
        {
            try
            {
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).Items.Clear();
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).DataSource = groupBusiness.GetPersonMealByShiftGroupByDate(barcode, date, (Dictionary<string, string>)Session["ParameterDic"]);
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).TextField = "Value";
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).ValueField = "Key";
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).DataBind();
                if (((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).Items.Count > 0)
                    ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).SelectedIndex = 0;
                
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        private void FillASPxGridViewFoodReserve(string year,string month)
        {
            try
            {


                ASPxGridViewFoodReserve_FoodReserve.DataSource = new BPrgPrs().GetSummaryFoodListPersonInDate((person)Session["PersonObj"], (Dictionary<string, string>)Session["ParameterDic"], year, month);
            ASPxGridViewFoodReserve_FoodReserve.DataBind();

            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }

        private void InsertSelectedFoodsPerson(PrgPrsCustomizeModel prgPrsCustomObj)
        {
            try
            {
                bool resultInsertProgramFood = new BPrgPrs().InsertProgramFoodPerson(prgPrsCustomObj, (Dictionary<string, string>)Session["ParameterDic"]);
                if (resultInsertProgramFood == false)
                    throw new Exception("خطا در اضافه نمودن برنامه غذایی.لطقا مجددا سعی نمایید.");
                   

            }
            catch (Exception ex)
            {
                
                throw ex; 
            }
        }
        private void DeleteSelectedFoodsPerson(PrgPrsCustomizeModel prgPrsCustomObj,person personObj)
        {
            try
            {
                bool resultDeleteProgramFood = new BPrgPrs().DeleteProgramFoodPerson(prgPrsCustomObj, personObj);
                if (resultDeleteProgramFood == false)
                    throw new Exception("خطا در حذف برنامه غذایی.لطقا مجددا سعی نمایید.");


            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void FillASPxGridViewDetailsFoodReserve(string date,string barcode,int rowExpandedIndex)
        {

            List<PrgPrsCustomizeModel> prgPrsCustomList = new BPrgPrs().GetProgramFoodPersonByDate((person)Session["PersonObj"], date, (Dictionary<string, string>)Session["ParameterDic"]);
            ((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex,"ASPxGridViewDetailsFoodReserve_FoodReserve")).DataSource = prgPrsCustomList;
            ((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex,"ASPxGridViewDetailsFoodReserve_FoodReserve")).DataBind();
        }
        private void FillASPxComboBoxBuildings_FoodReserve(int rowExpandedIndex)
        {
            try
            {
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).Items.Clear();
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).DataSource = BuildingBusiness.GetAllBuildings();
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).TextField = "Building_Name";
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).ValueField = "Building_Code";
                ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).DataBind();
                if (((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).Items.Count > 0)
                    ((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl(rowExpandedIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        protected void ASPxGridViewDetailsFoodReserve_FoodReserve_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {

            
            List<object> selectedFoodValue = ((ASPxGridView)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxGridViewFoodListDetailsFoodReserve_FoodReserve")).GetSelectedFieldValues("Week_FoodCode", "Week_FoodName", "Week_NValue", "Week_KeyID", "Week_FoodPricePerson");
            if (selectedFoodValue.Count == 0)
            {
                throw new Exception("هیچ غذایی جهت رزرو انتخاب نشده است.");
            }
            if(((ASPxComboBox)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).Value.ToString()=="")
            {
                throw new Exception("لطفا یک وعده غذایی را انتخاب نمایید.");
            }
            if (((ASPxComboBox)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).Value.ToString() == "")
            {
                throw new Exception("لطفا یک ساختمان را انتخاب نماببد.");
            }
            object isPermitted = ((ASPxGridView)sender).GetMasterRowFieldValues("IsPermittedReserve");
            if (Convert.ToBoolean(isPermitted) == false)
            {
                throw new Exception("مجاز به رزرو غذا در این روز نیستید");
            }
            List<object> selectedSupplementsValue = ((ASPxGridView)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve")).GetSelectedFieldValues("Week_FoodCode", "Week_FoodName", "Week_NValue", "Week_KeyID", "Week_FoodPricePerson");
            PrgPrsCustomizeModel prgPrsCustomObj = new PrgPrsCustomizeModel();
            prgPrsCustomObj.PP_Date = Session["DateExpanded_FoodReserve"].ToString();
            prgPrsCustomObj.PP_PCode = ((person)Session["PersonObj"]).P_BarCode;
            prgPrsCustomObj.PP_FoodCode = Convert.ToInt16(((object[])selectedFoodValue[0])[0]);
            prgPrsCustomObj.PP_FoodName = ((object[])selectedFoodValue[0])[1].ToString();
            prgPrsCustomObj.PP_FoodPricePerson = Convert.ToInt32(((object[])selectedFoodValue[0])[4]);
            prgPrsCustomObj.PP_KeyID = Convert.ToInt16(((object[])selectedFoodValue[0])[3]);
            prgPrsCustomObj.PP_KeyValue = true;
            prgPrsCustomObj.PP_Type = Convert.ToInt16(((ASPxComboBox)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).Value);
            prgPrsCustomObj.PP_Building = Convert.ToInt32(((ASPxComboBox)((ASPxGridView)sender).FindEditFormTemplateControl("ASPxComboBoxBuildings_FoodReserve")).Value);
            prgPrsCustomObj.PP_sumAllFoodSupplementPrice = Convert.ToInt32 (((object[])selectedFoodValue[0])[4]);
            List<PrgPrsCustomizeModel.Supplements> supplementsList = new List<PrgPrsCustomizeModel.Supplements>();
            if (selectedSupplementsValue.Count > 0)
            {
                for (int i = 0; i < selectedSupplementsValue.Count; i++)
                {
                    PrgPrsCustomizeModel.Supplements supplementsObj = new PrgPrsCustomizeModel.Supplements();
                    supplementsObj.PP_SupplementCode = Convert.ToInt16(((object[])selectedSupplementsValue[i])[0]);
                    supplementsObj.PP_SupplementsName = ((object[])selectedSupplementsValue[i])[1].ToString();
                    supplementsObj.PP_SupplementPricePerson = Convert.ToInt32(((object[])selectedSupplementsValue[i])[4]);
                    supplementsObj.PP_SupplementsKeyID = Convert.ToInt16(((object[])selectedSupplementsValue[i])[3]);
                    supplementsObj.PP_SupplementsKeyValue = true;
                    supplementsList.Add(supplementsObj);
                    prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt16(((object[])selectedSupplementsValue[i])[4]);
                }
            }
            prgPrsCustomObj.PP_SupplementsList = supplementsList;
           InsertSelectedFoodsPerson(prgPrsCustomObj);
           
            e.Cancel = true;


            FillASPxGridViewDetailsFoodReserve(Session["DateExpanded_FoodReserve"].ToString(), ((person)Session["PersonObj"]).P_BarCode, Convert.ToInt32(Session["rowExpandedIndex_FoodReserve"]));
            ((ASPxGridView)sender).JSProperties.Add("cpAction", "Insert");
            ((ASPxGridView)sender).CancelEdit();
            }
            catch (Exception ex)
            {
                e.Cancel = true;
                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
                
            }
        }

        protected void ASPxGridViewFoodReserve_FoodReserve_DetailRowExpandedChanged(object sender, ASPxGridViewDetailRowEventArgs e)
        {
            try
            {

            
            if (e.Expanded == true)
            {
                
                    Session["DateExpanded_FoodReserve"] = ASPxGridViewFoodReserve_FoodReserve.GetRowValues(e.VisibleIndex, "Date").ToString();
                    Session["rowExpandedIndex_FoodReserve"] = e.VisibleIndex;
                    string selectedDate = ASPxGridViewFoodReserve_FoodReserve.GetRowValues(e.VisibleIndex, "Date").ToString();
                    string userBarcode = ((person)Session["PersonObj"]).P_BarCode;
                    FillASPxGridViewDetailsFoodReserve(selectedDate, userBarcode, e.VisibleIndex);
                    
                    object isPermitted = ((ASPxGridView)sender).GetRowValues(e.VisibleIndex, "IsPermittedReserve");
                    ((ASPxButton)((ASPxGridView)sender).FindDetailRowTemplateControl(e.VisibleIndex, "ASPxButtonNewSelectFood_FoodReserve")).ClientVisible = Convert.ToBoolean(isPermitted);
                    ((ASPxGridView)((ASPxGridView)sender).FindDetailRowTemplateControl(e.VisibleIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).Columns["Delete"].Visible = Convert.ToBoolean(isPermitted);
                    ((ASPxGridView)((ASPxGridView)sender).FindDetailRowTemplateControl(e.VisibleIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).CssFilePath = "~/App_Themes/BlackGlass/{0}/styles.css";
                    ((ASPxGridView)((ASPxGridView)sender).FindDetailRowTemplateControl(e.VisibleIndex, "ASPxGridViewDetailsFoodReserve_FoodReserve")).CssPostfix = "BlackGlass";
                  
                      

            }
            }
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
            }
        }

        protected void ASPxGridViewDetailsFoodReserve_FoodReserve_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            try
            {
                ((ASPxGridView)sender).Settings.ShowColumnHeaders = false;

            string userBarcode = ((person)Session["PersonObj"]).P_BarCode;
            string date = Session["DateExpanded_FoodReserve"].ToString();

            FillASPxComboBoxBuildings_FoodReserve((int)Session["rowExpandedIndex_FoodReserve"]);
            FillComboBoxMealType(userBarcode, date, (int)Session["rowExpandedIndex_FoodReserve"]);
            short type = Convert.ToInt16(((ASPxComboBox)((ASPxGridView)ASPxGridViewFoodReserve_FoodReserve.FindDetailRowTemplateControl((int)Session["rowExpandedIndex_FoodReserve"], "ASPxGridViewDetailsFoodReserve_FoodReserve")).FindEditFormTemplateControl("ASPxComboBoxMealType_FoodReserve")).SelectedItem.Value);
            FillGridViewFoodListDetails(date, type, (Dictionary<string, string>)Session["ParameterDic"], (int)Session["rowExpandedIndex_FoodReserve"]);
            FillGridViewsupplementsListDetails(date, type, (Dictionary<string, string>)Session["ParameterDic"], (int)Session["rowExpandedIndex_FoodReserve"]);
            }
            catch (Exception ex)
            {
                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
               
            }
        }

        protected void ASPxGridViewFoodListDetailsFoodReserve_FoodReserve_Callback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {


                string date = Session["DateExpanded_FoodReserve"].ToString();
                FillGridViewFoodListDetails(date, Convert.ToInt16(e.Parameters), (Dictionary<string, string>)Session["ParameterDic"], (int)Session["rowExpandedIndex_FoodReserve"]);
            }
            catch (Exception ex)
            {
                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);

            }
        }
        protected void ASPxGridViewsupplementsListDetailsFoodReserve_Callback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {


                string date = Session["DateExpanded_FoodReserve"].ToString();
                FillGridViewsupplementsListDetails(date, Convert.ToInt16(e.Parameters), (Dictionary<string, string>)Session["ParameterDic"], (int)Session["rowExpandedIndex_FoodReserve"]);
            }
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
            }
        }

        protected void ASPxGridViewFoodReserve_FoodReserve_Callback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {

                FillASPxGridViewFoodReserve(ASPxComboBoxYear.Value.ToString(),ASPxComboBoxMonth.Value.ToString());
               
            }
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
            }
        }
        protected void ASPxGridViewDetailsFoodReserve_FoodReserve_Callback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {
                Dictionary<string, object> obj = (Dictionary<string, object>)this.JsSerializer.DeserializeObject(e.Parameters);
                string action = obj["Action"].ToString();
                int rowIndex = Convert.ToInt32(obj["SelectedRow"]);
                object objRowValues = ((ASPxGridView)sender).GetRowValues(rowIndex, "PP_Date", "PP_PCode", "PP_Type");
                string date=((object[])(objRowValues))[0].ToString();
                string barcode=((object[])(objRowValues))[1].ToString();
                Int16? type=Convert.ToInt16(((object[])(objRowValues))[2]);

                person personObj = ((person)Session["PersonObj"]);
                PrgPrsCustomizeModel prgPrsCustomObj = new BPrgPrs().GetProgramFoodPersonByDate((person)Session["PersonObj"], date, (Dictionary<string, string>)Session["ParameterDic"]).SingleOrDefault(t => t.PP_Type == type);
                switch (action)
                {
                    case "Delete":
                        {
                           
                            DeleteSelectedFoodsPerson(prgPrsCustomObj,personObj);
                            FillASPxGridViewDetailsFoodReserve(date, barcode, (int)Session["rowExpandedIndex_FoodReserve"]);
                            ((ASPxGridView)sender).JSProperties.Add("cpAction", "Delete");
                            ((ASPxGridView)sender).CancelEdit();
                            break;
                        }
                    default:
                        break;
                }
                
                

            }
            catch (Exception ex)
            {

                ((ASPxGridView)sender).JSProperties.Add("cpError", ex.Message);
            }
        }

        protected void ASPxGridViewFoodReserve_FoodReserve_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if(e.Column.FieldName=="Price")
            {
                if (e.Value.ToString() != "0")
                    e.DisplayText = Business.Utility.NumberToCurrencyFormat(e.Value.ToString());
                else
                    e.DisplayText = "";
            }
           
        }

        protected void ASPxGridViewFoodReserve_FoodReserve_SummaryDisplayText(object sender, ASPxGridViewSummaryDisplayTextEventArgs e)
        {
            if (e.Item.FieldName == "Price")
            {
                e.Text = "جمع " + Business.Utility.NumberToCurrencyFormat(e.Value.ToString()) + " ریال";
            }
        }
        protected void ASPxGridViewDetailsFoodReserve_FoodReserve_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "PP_sumAllFoodSupplementPrice")
            {
                if (e.Value.ToString() != "0")
                    e.DisplayText = Business.Utility.NumberToCurrencyFormat(e.Value.ToString());
                else
                    e.DisplayText = "";
            }

        }
        protected void ASPxGridViewFoodListDetailsFoodReserve_FoodReserve_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "Week_FoodPricePerson")
            {
                if (e.Value.ToString() != "0")
                    e.DisplayText = Business.Utility.NumberToCurrencyFormat(e.Value.ToString());
                else
                    e.DisplayText = "";
            }

        }
        protected void ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "Week_FoodPricePerson")
            {
                if (e.Value.ToString() != "0")
                    e.DisplayText = Business.Utility.NumberToCurrencyFormat(e.Value.ToString());
                else
                    e.DisplayText = "";
            }

        }

        protected void ASPxCallbackPanelLabelPersonCredit_FoodReserve_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            try
            {
                FillPersonCreditRemain(((person)Session["PersonObj"]).P_BarCode);
            }
            catch (Exception ex)
            {
                ((ASPxCallbackPanel)sender).JSProperties.Add("cpError", ex.Message);
               
            }
            
        }

        protected void ASPxCallbackReport_FoodReserve_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            try
            {

            
            string fromDateReport = JQDatePickerFromDateReport_FoodReserve.Text;
            string toDateReport = JQDatePickerToDateReport_FoodReserve.Text;

            string mealTypeReport = ASPxComboBoxMealTypeReport_FoodReserve.SelectedItem.Value.ToString();

            List<ReportFishModel> reportFishModelList = new BFish().GetFishFoodPerson(((person)Session["PersonObj"]), fromDateReport, toDateReport, mealTypeReport);
            Dictionary<string, object> paramDic = new Dictionary<string, object>();
            paramDic.Add("FromDate", fromDateReport);
            paramDic.Add("ToDate", toDateReport);
            paramDic.Add("Barcode", ((person)Session["PersonObj"]).P_BarCode);
            paramDic.Add("ReportFishModelList", reportFishModelList);
            Session["ReportParamsDic"] = paramDic;
            }
            catch (Exception ex)
            {

                ((ASPxCallback)source).JSProperties.Add("cpError", ex.Message);
            }
        }

       



        
    }
}
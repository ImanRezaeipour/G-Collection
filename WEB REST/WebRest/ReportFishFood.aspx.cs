using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace WebRest
{
    public partial class ReportFishFood : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, object> paramDic = (Dictionary<string, object>)Session["ReportParamsDic"];
            LabelFromDate_ReportFishFood.Text = paramDic["FromDate"].ToString();
            LabelToDate_ReportFishFood.Text = paramDic["ToDate"].ToString();
            LabelBarcode_ReportFishFood.Text = paramDic["Barcode"].ToString();
            ASPxGridViewReportFishFood_ReporFishFood.DataSource = (List<ReportFishModel>)paramDic["ReportFishModelList"];
            ASPxGridViewReportFishFood_ReporFishFood.DataBind();
        }

        protected void ASPxGridViewReportFishFood_ReporFishFood_SummaryDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewSummaryDisplayTextEventArgs e)
        {
            if (e.Item.FieldName == "Fish_FoodPriceInt")
            {
                e.Text = "جمع " + Business.Utility.NumberToCurrencyFormat(e.Value.ToString()) + " ریال";
            }
        }

        protected void ASPxGridViewReportFishFood_ReporFishFood_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "Fish_FoodPriceInt")
            {
                if (e.Value.ToString() != "0")
                    e.DisplayText = Business.Utility.NumberToCurrencyFormat(e.Value.ToString());
                else
                    e.DisplayText = "";
            }
        }
    }
}
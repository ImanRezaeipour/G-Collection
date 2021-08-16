<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportFishFood.aspx.cs" Inherits="WebRest.ReportFishFood" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script language="javascript" type="text/javascript">
         window.print();
    </script>
    <link href="Styles/TextCss.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="ReportFishFoodForm" runat="server">
    <div align="center" dir="rtl" 
        style="border: 3px dashed #C0C0C0; width: 98%; font-family: tahoma;">
    <div dir="rtl" align="center" style="padding: 10px; width: 100%; font-family: arial; font-size: 16pt; font-weight: bold; color: #666666">
        گزارش فیش های پرسنل</div>

        <div dir="rtl">
<div dir="rtl" align="center" 
            
                style="padding: 10px; width: 30%; font-family: tahoma; font-size: 9pt; font-weight: bold; color: #666666; float: right;">
       از تاریخ : 
    <span dir="ltr"><asp:Label ID="LabelFromDate_ReportFishFood" CssClass="LabelBoldSmall" runat="server"></asp:Label></span>
       </div>
       <div dir="rtl" align="center" 
            
            
                style="padding: 10px; width: 30%; font-family: tahoma; font-size: 9pt; font-weight: bold; color: #666666; float: right; ">
       تا تاریخ : 
    <span dir="ltr"><asp:Label ID="LabelToDate_ReportFishFood" CssClass="LabelBoldSmall" runat="server"></asp:Label></span>
       </div>
         <div dir="rtl" align="center" 
            
            
                style="padding: 10px; width: 30%; font-family: tahoma; font-size: 9pt; font-weight: bold; color: #666666; float: right; ">
      شماره پرسنلی : 
    <asp:Label ID="LabelBarcode_ReportFishFood" CssClass="LabelBoldSmall" runat="server"></asp:Label>
       </div>
       </div>
       <div dir="rtl" align="center" 
            style="width: 100%; padding-top: 10px; padding-bottom: 10px;">
            
           <dx:ASPxGridView ID="ASPxGridViewReportFishFood_ReporFishFood" runat="server" 
               AutoGenerateColumns="False" Width="95%" 
               oncustomcolumndisplaytext="ASPxGridViewReportFishFood_ReporFishFood_CustomColumnDisplayText" 
               onsummarydisplaytext="ASPxGridViewReportFishFood_ReporFishFood_SummaryDisplayText">
               <Columns>
                   <dx:GridViewDataTextColumn Caption="تاریخ" FieldName="Fish_Date" 
                       VisibleIndex="0" ShowInCustomizationForm="True">
                       <HeaderStyle HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                       </CellStyle>
                   </dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn Caption="وعده" FieldName="Fish_TypeName" 
                       VisibleIndex="1" ShowInCustomizationForm="True">
                       <HeaderStyle HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                       </CellStyle>
                   </dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn Caption="وعده" FieldName="Fish_Type" 
                       VisibleIndex="1" ShowInCustomizationForm="True" Visible="false">
                       <HeaderStyle HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                       </CellStyle>
                   </dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn Caption="نام غذا" FieldName="Fish_FoodName" 
                       VisibleIndex="2" ShowInCustomizationForm="True">
                       <HeaderStyle HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                       </CellStyle>
                   </dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn Caption="قیمت" FieldName="Fish_FoodPriceInt" 
                       VisibleIndex="3" ShowInCustomizationForm="True">
                       <HeaderStyle HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                       </CellStyle>
                       <FooterCellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                       </FooterCellStyle>
                   </dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn VisibleIndex="4" Width="0%" 
                       ShowInCustomizationForm="True">
                   </dx:GridViewDataTextColumn>
               </Columns>
               <SettingsPager PageSize="100000000" Visible="False">
               </SettingsPager>
                <TotalSummary>
            <dx:ASPxSummaryItem  FieldName="Fish_FoodPriceInt" SummaryType="Sum" />
            
        </TotalSummary>
               <Settings ShowFooter="True" />
               <SettingsText EmptyDataRow="هیچ رکوردی وجود ندارد" />
           </dx:ASPxGridView>
       </div>
    </div>
   
    </form>
</body>
</html>

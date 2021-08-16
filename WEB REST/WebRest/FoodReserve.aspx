<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FoodReserve.aspx.cs" Inherits="WebRest.FoodReserve" %>

<%@ Register Assembly="JQControls" Namespace="JQControls" TagPrefix="cc1" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/FoodReservePage_onOperations.js" type="text/javascript"></script>
    <link href="Styles/TextCss.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
    <form id="FoodReserveForm" runat="server">
    <cc1:JQLoader ID="JQLoader1"  runat="server" Theme="Redmond">
    </cc1:JQLoader>
    <div dir="rtl" style="font-family: tahoma; font-size: 9pt">
    <div align="left" id="divReportButton">
        <dx:ASPxButton ID="ASPxButtonShowReportFilter_FoodReserve" runat="server" 
            ClientInstanceName="ButtonShowReportFilter_FoodReserve" 
            CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
            SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" Text="گزارش فیش ها" 
            Width="150px" AutoPostBack="False" Font-Bold="True" Font-Size="8pt">
            <Image Url="~/Image/DesignImage/ReportIcon.png">
            </Image>
            <ClientSideEvents Click="ButtonShowReportFilter_FoodReserve_onClick" />
        </dx:ASPxButton>
        </div>
        <div id="divPanelFilterReport_FoodReserve" style="padding: 10px; display: none" 
            align="left">
        <dx:ASPxRoundPanel ID="ASPxRoundPanelReportFilter_FoodReserve" runat="server" Width="500px" 
                        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                        CssPostfix="Office2003Blue" EnableDefaultAppearance="False" 
                        GroupBoxCaptionOffsetY="-25px" HeaderText="فیلتر" RightToLeft="True" 
                        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                        <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
                        <HeaderStyle>
                        <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                            PaddingRight="2px" />
                        </HeaderStyle>
                    <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server" >
                    <table width="100%">
                    <tr>
                    <td width="18%" align="left">
                    
                        نام وعده :</td>
                        <td align="right" width="32%">
                            <dx:ASPxComboBox ID="ASPxComboBoxMealTypeReport_FoodReserve" ClientInstanceName="ComboBoxMealTypeReport_FoodReserve"
                      runat="server" RightToLeft="True" 
                                CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                                CssPostfix="Office2003Blue" SelectedIndex="0" 
                                SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" Width="80%" >

                                <Items>
                                    <dx:ListEditItem Selected="True" Text="همه" Value="All" />
                                    <dx:ListEditItem Text="صبحانه" Value="1" />
                                    <dx:ListEditItem Text="ناهار" Value="2" />
                                    <dx:ListEditItem Text="شام" Value="3" />
                                </Items>
                                <LoadingPanelImage Url="~/App_Themes/Office2003Blue/Web/Loading.gif">
                                </LoadingPanelImage>
                                <ButtonStyle Width="13px">
                                </ButtonStyle>
                    </dx:ASPxComboBox></td>
                        <td align="left" width="18%">
                            از تاریخ :</td>
                    <td width="32%">
                        <cc1:JQDatePicker ID="JQDatePickerFromDateReport_FoodReserve"  CssClass="LabelBoldSmall" runat="server"  Regional="fa" IEDateFormat="YMD" DateFormat="YMD"></cc1:JQDatePicker>
                    </td>
                    </tr>
                    <tr>
                    <td align="left">
                    
                        &nbsp;</td>
                        <td align="left">
                            &nbsp;</td>
                        <td align="left">
                            تا تاریخ :</td>
                    <td>
                        <cc1:JQDatePicker ID="JQDatePickerToDateReport_FoodReserve" CssClass="LabelBoldSmall" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"></cc1:JQDatePicker>
                    </td>
                    </tr>
                        <tr>
                            <td align="right" colspan="4" style="padding-right: 10px">
                                <dx:ASPxButton ID="ASPxButtonShowReport_FoodReserve" ClientInstanceName="ButtonShowReport_FoodReserve" runat="server" 
                                    CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
                                    SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" Text="نمایش" 
                                    AutoPostBack="False">
                                    <ClientSideEvents Click="ButtonShowReport_FoodReserve_onClick" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                    </dx:PanelContent>
                    </PanelCollection>
                    </dx:ASPxRoundPanel>
        </div>
      <table width="100%" cellpadding="5" cellspacing="5">
      <tr>
      <td>
      <table id="tblDateRange">
      <tr>
      <td align="left" width="10%">
      ماه :
      
      </td>
      <td>
      <dx:ASPxComboBox ID="ASPxComboBoxMonth" runat="server" 
             Width="100px" ValueType="System.String" ClientInstanceName="ComboBoxMonth" 
             RightToLeft="True" CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
             CssPostfix="PlasticBlue" 
             SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
             <Items>
                 <dx:ListEditItem Text="فروردین" Value="01" />
                 <dx:ListEditItem Text="اردیبهشت" Value="02" />
                 <dx:ListEditItem Text="خرداد" Value="03" />
                 <dx:ListEditItem Text="تیر" Value="04" />
                 <dx:ListEditItem Text="مرداد" Value="05" />
                 <dx:ListEditItem Text="شهریور" Value="06" />
                 <dx:ListEditItem Text="مهر" Value="07" />
                 <dx:ListEditItem Text="آبان" Value="08" />
                 <dx:ListEditItem Text="آذر" Value="09" />
                 <dx:ListEditItem Text="دی" Value="10" />
                 <dx:ListEditItem Text="بهمن" Value="11" />
                 <dx:ListEditItem Text="اسفند" Value="12" />
             </Items>
             <LoadingPanelImage Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
             </LoadingPanelImage>
             <ValidationSettings>
                 <ErrorFrameStyle ImageSpacing="4px">
                     <ErrorTextPaddings PaddingLeft="4px" />
                 </ErrorFrameStyle>
             </ValidationSettings>
         </dx:ASPxComboBox>
      </td>
      <td align="left" width="10%">
      سال :
      </td>
      <td>
      <dx:ASPxComboBox ID="ASPxComboBoxYear" runat="server" ValueType="System.String" 
                Width="100px" ClientInstanceName="ComboBoxYear" RightToLeft="True" 
                CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
                 SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
                <Items>
                    <dx:ListEditItem Text="1390" Value="1390" />
                    <dx:ListEditItem Text="1391" Value="1391" />
                    <dx:ListEditItem Text="1392" Value="1392" />
                    <dx:ListEditItem Text="1393" Value="1393" />
                    <dx:ListEditItem Text="1394" Value="1394" />
                    <dx:ListEditItem Text="1395" Value="1395" />
                </Items>
                <ItemStyle>
                <SelectedStyle Font-Size="16pt">
                </SelectedStyle>
                </ItemStyle>
                <LoadingPanelImage Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                </LoadingPanelImage>
                <ValidationSettings>
                    <ErrorFrameStyle ImageSpacing="4px">
                        <ErrorTextPaddings PaddingLeft="4px" />
                    </ErrorFrameStyle>
                </ValidationSettings>
            </dx:ASPxComboBox>
      </td>
      <td id="tdButtonLoadGridFoodReserve">
      
          <dx:ASPxButton ID="ASPxButtonLoadGridView_FoodReserve" runat="server" 
              ClientInstanceName="ButtonLoadGridView_FoodReserve" 
              CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
              SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" Text="نمایش" 
              AutoPostBack="False">
              <ClientSideEvents Click="ButtonLoadGridView_FoodReserve_onClick" />
          </dx:ASPxButton>
      
      </td>
      </tr>
      </table>
      </td>
      <td align="left">
          
          <dx:ASPxCallbackPanel ID="ASPxCallbackPanelLabelPersonCredit_FoodReserve" 
              ClientInstanceName="CallbackPanelLabelPersonCredit_FoodReserve" runat="server" 
              Width="100%" 
              oncallback="ASPxCallbackPanelLabelPersonCredit_FoodReserve_Callback" 
              LoadingPanelText="لطفا چند لحظه صبر نمایید&hellip;">
          <PanelCollection>
              <dx:PanelContent runat="server" ID="PanelContentCallbackPanelLabelPersonCredit_FoodReserve">
              <dx:ASPxLabel ID="ASPxLabelPersonCredit_FoodReserve" 
              ClientInstanceName="LabelPersonCredit_FoodReserve" runat="server" 
              Font-Bold="False" CssClass="LabelBoldSmall">
            </dx:ASPxLabel>
              </dx:PanelContent>
          </PanelCollection>
          <ClientSideEvents EndCallback="function(s,e){ CallbackPanelLabelPersonCredit_FoodReserve_EndCallback(s,e);}" />
              <ClientSideEvents CallbackError="function(s,e){CallbackPanelLabelPersonCredit_FoodReserve_ErrorCallback(s,e);}" />
          </dx:ASPxCallbackPanel>
      </td>
      </tr>
      </table>
        <dx:ASPxGridView ID="ASPxGridViewFoodReserve_FoodReserve" runat="server" 
            AutoGenerateColumns="False" ClientInstanceName="GridViewFoodReserve_FoodReserve" 
            CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
            Width="100%" KeyFieldName="Date" 
            ondetailrowexpandedchanged="ASPxGridViewFoodReserve_FoodReserve_DetailRowExpandedChanged"
            OnCustomCallback="ASPxGridViewFoodReserve_FoodReserve_Callback" 
            oncustomcolumndisplaytext="ASPxGridViewFoodReserve_FoodReserve_CustomColumnDisplayText" 
            
            
            onsummarydisplaytext="ASPxGridViewFoodReserve_FoodReserve_SummaryDisplayText">
            <ClientSideEvents EndCallback="function(s,e){GridViewFoodReserve_FoodReserve_EndCallback(s,e);}" />
            <ClientSideEvents CallbackError="function(s,e){GridViewFoodReserve_FoodReserve_ErrorCallback(s,e);}" />
            <Columns>
            <dx:GridViewDataTextColumn Caption="" FieldName="IsPermittedReserve" VisibleIndex="0" 
                    Width="0%" Visible="false">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="" FieldName="IsFood" VisibleIndex="0" 
                    Width="0%" Visible="false">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="روز" FieldName="DayOfWeek" VisibleIndex="1" 
                    Width="9%">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" >
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="تاریخ" FieldName="Date" VisibleIndex="2" 
                    Width="9%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="صبحانه" VisibleIndex="3" 
                    FieldName="BreakFast" Width="24%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ناهار" VisibleIndex="4" FieldName="Launch" 
                    Width="24%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="شام" VisibleIndex="5" FieldName="Dinner" 
                    Width="24%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="قیمت" FieldName="Price" VisibleIndex="5" 
                    Width="5%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                    </CellStyle>
                    <FooterCellStyle CssClass="LabelBoldSmall">
                    </FooterCellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="" FieldName="" VisibleIndex="6" 
                    Width="0%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataImageColumn Name="imgStatus" FieldName="statusFood" 
                    Caption="وضعیت" VisibleIndex="0" Width="5%">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataImageColumn>
            </Columns>
            <Templates>
            <DetailRow>
             
            <dx:ASPxGridView ID="ASPxGridViewDetailsFoodReserve_FoodReserve" ClientInstanceName="GridViewDetailsFoodReserve_FoodReserve"
          CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
            Width="85%"  runat="server" AutoGenerateColumns="False"  KeyFieldName="PP_Type"
            onrowinserting="ASPxGridViewDetailsFoodReserve_FoodReserve_RowInserting" 
            oninitnewrow="ASPxGridViewDetailsFoodReserve_FoodReserve_InitNewRow"
            OnCustomCallback="ASPxGridViewDetailsFoodReserve_FoodReserve_Callback"
            oncustomcolumndisplaytext="ASPxGridViewDetailsFoodReserve_FoodReserve_CustomColumnDisplayText" >
            <ClientSideEvents EndCallback="function(s,e){GridViewDetailsFoodReserve_FoodReserve_EndCallback(s,e);}" />
          <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGridViewDetailsFoodReserve(s,e);}" />
          <SettingsBehavior AllowFocusedRow="true" />
          <SettingsLoadingPanel Text="لطفا چند لحظه صبر نمایید&amp;hellip;" />
          <Columns>
          <dx:GridViewDataTextColumn Caption=""  VisibleIndex="9" 
                    Width="0%" FieldName="PP_PCode" Visible="false">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption=""  VisibleIndex="9" 
                    Width="0%" FieldName="PP_Date" Visible="false">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption=""  VisibleIndex="9" 
                    Width="0%" FieldName="PP_Type" Visible="false">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="قیمت"  VisibleIndex="11" 
                    Width="10%" FieldName="PP_sumAllFoodSupplementPrice" Visible="true">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                      <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
          <dx:GridViewDataTextColumn Caption="غذا"  VisibleIndex="9" 
                    Width="35%" FieldName="PP_FoodName">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="مخلفات"  VisibleIndex="10" 
                    Width="35%"  FieldName="PP_strAllSupplements">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                       <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn Caption="نام وعده" VisibleIndex="7" Width="10%" 
                  FieldName="PP_MealName">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
              </dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn Caption="" VisibleIndex="13" Width="0" 
                  FieldName="">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
              </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn  Name="Delete"
                                    ShowInCustomizationForm="True" VisibleIndex="12" Caption="حذف" 
                                    ButtonType="Image" Width="10%">
                                    <ClearFilterButton Visible="True">
                                    </ClearFilterButton>
                                    <CustomButtons>
                                        <dx:GridViewCommandColumnCustomButton ID="Delete" Text="حذف" 
                                            Visibility="AllDataRows" >
                                            <Image Url="Image/DesignImage/remove.png">
                                            </Image>
                                        </dx:GridViewCommandColumnCustomButton>
                                    </CustomButtons>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewCommandColumn>
               
               
               
                </Columns>
                <StylesEditors>
                    <CalendarHeader Spacing="1px">
                    </CalendarHeader>
                    <ProgressBar Height="25px">
                    </ProgressBar>
          </StylesEditors>
                <Templates>
               <EditForm>
                <table width="100%" cellpadding="5" cellspacing="5">
                <tr>
                <td align="left">
             &nbsp;وعده :
                </td>
                <td>
<dx:ASPxComboBox ID="ASPxComboBoxMealType_FoodReserve" ClientInstanceName="ComboBoxMealType_FoodReserve"
                      runat="server"    RightToLeft="True" 
        CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
        SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css" 
        style="margin-top: 0px" ValueType="System.String" >
                    <ClientSideEvents SelectedIndexChanged="ComboBoxMealType_FoodReserve_onSelectedIndexChanged" />
                    <LoadingPanelImage Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                    </LoadingPanelImage>
                    <ValidationSettings>
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                    </ValidationSettings>
                    </dx:ASPxComboBox>                  
                </td>
                <td align="left" rowspan="2">
          &nbsp;غذا :
                </td>
                <td rowspan="2">
<dx:ASPxGridView ID="ASPxGridViewFoodListDetailsFoodReserve_FoodReserve" ClientInstanceName="GridViewFoodListDetailsFoodReserve_FoodReserve"
          CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
        CssPostfix="PlasticBlue"  KeyFieldName="Week_KeyID" OnCustomCallback="ASPxGridViewFoodListDetailsFoodReserve_FoodReserve_Callback" 
            Width="100%"  runat="server" AutoGenerateColumns="False" 
            
        
        
        oncustomcolumndisplaytext="ASPxGridViewFoodListDetailsFoodReserve_FoodReserve_CustomColumnDisplayText"  >
            <ClientSideEvents EndCallback="function(s,e){ GridViewFoodListDetailsFoodReserve_FoodReserve_EndCallback(s,e);}" />
            
            <Columns>
            <dx:GridViewCommandColumn Caption="انتخاب"  ShowSelectCheckbox="true" 
        VisibleIndex="0" Width="10%" >
        
        <ClearFilterButton Visible="True">
        </ClearFilterButton>
        <CellStyle Font-Names="arial"></CellStyle>
        <HeaderStyle HorizontalAlign="Center" />
    </dx:GridViewCommandColumn>
     <dx:GridViewDataTextColumn Caption="کد غذا"  VisibleIndex="1" 
                    Width="1%" Visible="false" FieldName="Week_FoodCode">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption=""  VisibleIndex="1" 
                    Width="1%" Visible="false" FieldName="Week_NValue">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="نام غذا"  VisibleIndex="1" 
                    Width="60%" FieldName="Week_FoodName">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="قیمت"  VisibleIndex="2" 
                    Width="20%" FieldName="Week_FoodPricePerson">
                    <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                    </CellStyle>
                    
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption=""  VisibleIndex="3" 
                    Width="0%" FieldName="">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                
            </Columns>
            <SettingsPager ShowDefaultImages="False">
                <AllButton Text="All">
                </AllButton>
                <NextPageButton Text="Next &gt;">
                </NextPageButton>
                <PrevPageButton Text="&lt; Prev">
                </PrevPageButton>
            </SettingsPager>
            <SettingsText EmptyDataRow="هیچ غذایی وجود ندارد" />
            <SettingsBehavior  AllowSelectSingleRowOnly="true" />
            <Images SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/PlasticBlue/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                CssPostfix="PlasticBlue">
                <Header ImageSpacing="10px" SortingImageSpacing="10px">
                </Header>
            </Styles>
            <StylesEditors>
                <CalendarHeader Spacing="11px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
    </dx:ASPxGridView>                     
                </td>
                <td rowspan="2" align="left">
                     مخلفات :</td>
                <td rowspan="2">
                     <dx:ASPxGridView ID="ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve" ClientInstanceName="GridViewsupplementsListDetailsFoodReserve_FoodReserve"
          CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" KeyFieldName="Week_KeyID" 
                         
        OnCustomCallback="ASPxGridViewsupplementsListDetailsFoodReserve_Callback" CssPostfix="PlasticBlue" 
            Width="100%"  runat="server" AutoGenerateColumns="False" 
            
        
        oncustomcolumndisplaytext="ASPxGridViewsupplementsListDetailsFoodReserve_FoodReserve_CustomColumnDisplayText" >
            <ClientSideEvents EndCallback="function(s,e){ GridViewsupplementsListDetailsFoodReserve_FoodReserve_EndCallback(s,e);}" />
            <Columns>
             <dx:GridViewCommandColumn Caption="انتخاب" ShowSelectCheckbox="True" 
        VisibleIndex="0" Width="10%">
        <ClearFilterButton Visible="True">
        </ClearFilterButton>
        <HeaderStyle HorizontalAlign="Center" />
    </dx:GridViewCommandColumn>
     <dx:GridViewDataTextColumn Caption=""  VisibleIndex="1" 
                    Width="1%" Visible="false" FieldName="Week_NValue">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
     <dx:GridViewDataTextColumn Caption="کد غذا"  VisibleIndex="1" 
                    Width="1%" Visible="false" FieldName="Week_FoodCode">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="نام مخلفات"  VisibleIndex="1" 
                    Width="60%" FieldName="Week_FoodName">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="قیمت"  VisibleIndex="2" 
                    Width="20%" FieldName="Week_FoodPricePerson">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center" CssClass="LabelBoldSmall">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption=""  VisibleIndex="3" 
                    Width="0%" FieldName="">
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager ShowDefaultImages="False">
                <AllButton Text="All">
                </AllButton>
                <NextPageButton Text="Next &gt;">
                </NextPageButton>
                <PrevPageButton Text="&lt; Prev">
                </PrevPageButton>
            </SettingsPager>
            <SettingsText EmptyDataRow="هیچ مخلفاتی وجود ندارد" />
            <Images SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/PlasticBlue/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>

<Styles CssPostfix="PlasticBlue" 
                CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css">
    <Header ImageSpacing="10px" SortingImageSpacing="10px">
    </Header>
            </Styles>
                     <StylesEditors>
                         <CalendarHeader Spacing="11px">
                         </CalendarHeader>
                         <ProgressBar Height="25px">
                         </ProgressBar>
            </StylesEditors>
                     </dx:ASPxGridView>
                    </td>
                </tr>
                <tr>
                <td align="left">
                      ساختمان :</td>
                <td>
<dx:ASPxComboBox ID="ASPxComboBoxBuildings_FoodReserve" 
        ClientInstanceName="ComboBoxBuildings_FoodReserve" runat="server" 
        RightToLeft="True" CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
        CssPostfix="PlasticBlue" 
        SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css" 
        ValueType="System.String">
          <LoadingPanelImage Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
          </LoadingPanelImage>
          <ValidationSettings>
              <ErrorFrameStyle ImageSpacing="4px">
                  <ErrorTextPaddings PaddingLeft="4px" />
              </ErrorFrameStyle>
          </ValidationSettings>
                    </dx:ASPxComboBox>                    
                </td>
                </tr>
                <tr >
                <td>
                    &nbsp;</td>
                 <td>
                    <dx:ASPxButton ID="ASPxButtonFoodListSaveDetailsFoodReserve"  
                         CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
              SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" 
                         ClientInstanceName="ButtonFoodListSaveDetailsFoodReserve" runat="server" 
                         Text="ثبت" AutoPostBack="False" Width="80px">
                    <ClientSideEvents Click="ButtonFoodListSaveDetailsFoodReserve_onClick" />
                    </dx:ASPxButton>
                </td>
                <td></td>
                <td>
                     <dx:ASPxButton ID="ASPxButtonFoodListCancelDetailsFoodReserve"  
                        CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
              SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css"  
                        ClientInstanceName="ButtonFoodListCancelDetailsFoodReserve" runat="server" 
                        Text="لغو" AutoPostBack="False" Width="80px"
                         >
                         <ClientSideEvents Click="ButtonFoodListCancelDetailsFoodReserve_onClick" />
                     </dx:ASPxButton>
                    </td>
                <td>
                </td>
                <td></td>
                </tr>
                </table>
                </EditForm>
                
                </Templates>
          <SettingsText EmptyDataRow="هیچ غذایی ثبت نشده است." />

          <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
              <LoadingPanelOnStatusBar Url="~/App_Themes/BlackGlass/GridView/gvLoadingOnStatusBar.gif">
              </LoadingPanelOnStatusBar>
              <LoadingPanel Url="~/App_Themes/BlackGlass/GridView/Loading.gif">
              </LoadingPanel>
          </Images>
          <ImagesFilterControl>
              <LoadingPanel Url="~/App_Themes/BlackGlass/Editors/Loading.gif">
              </LoadingPanel>
          </ImagesFilterControl>

<Styles CssPostfix="BlackGlass" CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
          </Styles>
                </dx:ASPxGridView>
           
             <div style="padding-top: 10px; padding-bottom: 10px; padding-left: 10px;">
                <dx:ASPxButton ID="ASPxButtonNewSelectFood_FoodReserve" 
                    ClientInstanceName="ButtonNewSelectFood_FoodReserve" runat="server" Text="رزرو غذا"
                CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange" 
              SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" AutoPostBack="False" 
                    Width="100px">
            <ClientSideEvents Click="ButtonNewSelectFood_FoodReserve_onClick" />
                </dx:ASPxButton>
            </div>
             </DetailRow>
            </Templates>
            <SettingsPager PageSize="40" ShowDefaultImages="False">
                <AllButton Text="All">
                </AllButton>
                <NextPageButton Text="بعدی &gt;">
                </NextPageButton>
                <PrevPageButton Text="&lt; قبلی">
                </PrevPageButton>
            </SettingsPager>
            <SettingsLoadingPanel Text="لطفا چند لحظه صبر نمایید&amp;hellip;" />
            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
            <Images SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/PlasticBlue/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                CssPostfix="PlasticBlue">
                <%--<DetailCell BackColor="#DDBBFF">
                </DetailCell>
                <Cell BackColor="#CCCCFF">
                    <Border BorderColor="#3399FF" />
                    <Border BorderColor="#3399FF"></Border>
                </Cell>--%>
                <Header ImageSpacing="10px" SortingImageSpacing="10px">
                </Header>
                 <Row BackColor="White">
                </Row>
                <DetailRow BackColor="#CCCCFF">
                </DetailRow>
                <AlternatingRow BackColor="#99BBFF"></AlternatingRow>
                <DetailButton Font-Bold="False">
                    <Border BorderColor="#3399FF" />
                    <Border BorderColor="#3399FF"></Border>
                </DetailButton>
            </Styles>
            <StylesEditors>
                <CalendarHeader Spacing="11px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
             <SettingsBehavior AllowDragDrop="False" AllowSort="False" AllowGroup="False" AllowFocusedRow="false"
                AllowSelectByRowClick="False" AllowSelectSingleRowOnly="True">
            </SettingsBehavior>
            <Settings ShowFooter="True" />
            <Border BorderColor="#999999" BorderStyle="Ridge" BorderWidth="1px" />
             <TotalSummary>
            <dx:ASPxSummaryItem  FieldName="Price" SummaryType="Sum" />
            
        </TotalSummary>
        </dx:ASPxGridView>
       
        
       
        <dx:ASPxCallback ID="ASPxCallbackReport_FoodReserve" 
            ClientInstanceName="CallbackReport_FoodReserve" runat="server" 
            oncallback="ASPxCallbackReport_FoodReserve_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){CallbackReport_FoodReserve_callbackComplete(s,e);}" />
         <ClientSideEvents CallbackError="function(s,e){CallbackReport_FoodReserve_errorComplete(s,e);}" />
        </dx:ASPxCallback>
            <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>       
    </div>
      
    </form>
</body>
</html>

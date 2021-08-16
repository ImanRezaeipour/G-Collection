<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DevMonthlyReport.aspx.cs"
    Inherits="ASPWebclock.DevMonthlyReport" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGlobalEvents" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHeadline" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxSplitter" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dx" %>
<%@ Register Assembly="JQControls" Namespace="JQControls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/DevMonthlyReport_Operations.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" style="width: 100%;">
    <div dir="rtl" style="overflow: auto">
    <div dir="rtl" style="width: 800px">

    <table style="table-layout: fixed; display: block; height: 27px; font-family: tahoma; font-size: 9pt; width: 90%;" 
                                    id="tblHeaderBar" width="100%">
                                    <tr>
                                        <td width="100">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_ReportMonthly" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_ReportMonthlyt">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_ReportMonthly" 
        Text="راهنما" Enabled="True">
<Image Url="~/img/help.gif"></Image>
</dx:MenuItem>

</Items>

<LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif"></LoadingPanelImage>

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

<ItemStyle DropDownButtonSpacing="12px" ToolbarDropDownButtonSpacing="5px" 
            ToolbarPopOutImageSpacing="5px" PopOutImageSpacing="18px" Cursor="pointer" 
            VerticalAlign="Middle"></ItemStyle>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
</dx:ASPxMenu>
                                        </td>

                                        <td width="250">
                                            <dx:ASPxDropDownEdit ID="ASPxDropDownEdit2" 
                                                ClientInstanceName="DropDownEditUnderManagment" runat="server" 
                                                Text="انتخاب پرسنل تحت مدیریت" PopupHorizontalAlign="RightSides" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowShadow="False" 
                                                DropDownWindowStyle-VerticalAlign="Top" Width="100%">
                                                <DropDownWindowTemplate>
                                                    <dx:ASPxGridView ID="ASPxGridView5" runat="server" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" ClientInstanceName="GridViewUnderManegment" KeyFieldName="Barcode" Width="400px" Styles-Row-Cursor="pointer">
                                                        <ClientSideEvents EndCallback="function(s,e){
                                                        
                                                        if (s.GetVisibleRowsOnPage() > 0) {
                                                         s.SetFocusedRowIndex(s.GetTopVisibleIndex());
                                                        }}" />
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                                                        if(s.GetFocusedRowIndex()>-1)
                                                        {
var row = s.GetRow(s.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML + '  ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
DropDownEditUnderManagment.SetText(cellValue);
     
   s.GetFocusedRowIndex()
   
   }
   else
   {

   }
   
}" />
<ClientSideEvents RowClick="function(s,e){DropDownEditUnderManagment.HideDropDown();}" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="Barcode" VisibleIndex="1" 
                                                                Caption="کد پرسنلی" ShowInCustomizationForm="True">
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="2" Caption="نام" 
                                                                ShowInCustomizationForm="True">
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Family" VisibleIndex="3" 
                                                                Caption="نام خانوادگی" ShowInCustomizationForm="True">
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                                                            AutoFilterRowInputDelay="3000" />
                                                        <Settings ShowFilterRow="True" />
                                                        <Images SpriteCssFilePath="~/App_Themes/Glass/{0}/sprite.css">
                                                            <LoadingPanelOnStatusBar Url="~/App_Themes/Glass/GridView/gvLoadingOnStatusBar.gif">
                                                            </LoadingPanelOnStatusBar>
                                                            <LoadingPanel Url="~/App_Themes/Glass/GridView/Loading.gif">
                                                            </LoadingPanel>
                                                        </Images>
                                                        <ImagesFilterControl>
                                                            <LoadingPanel Url="~/App_Themes/Glass/Editors/Loading.gif">
                                                            </LoadingPanel>
                                                        </ImagesFilterControl>
                                                        <Styles CssFilePath="~/App_Themes/Glass/{0}/styles.css" CssPostfix="Glass">
                                                            <Header ImageSpacing="5px" SortingImageSpacing="5px">
                                                            </Header>
                                                        </Styles>
                                                        <StylesEditors>
                                                            <CalendarHeader Spacing="1px">
                                                            </CalendarHeader>
                                                            <ProgressBar Height="25px">
                                                            </ProgressBar>
                                                        </StylesEditors>
                                                        <SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>
                                                    </dx:ASPxGridView>
                                                    
                                                </DropDownWindowTemplate>
                                                <DropDownButton>
                                                    <Image>
                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                                    </Image>
                                                </DropDownButton>
                                                <ButtonEditEllipsisImage Height="3px" 
                                                    Url="~/App_Themes/Aqua/Editors/edtEllipsis.png" 
                                                    UrlDisabled="~/App_Themes/Aqua/Editors/edtEllipsisDisabled.png" 
                                                    UrlHottracked="~/App_Themes/Aqua/Editors/edtEllipsisHottracked.png" 
                                                    UrlPressed="~/App_Themes/Aqua/Editors/edtEllipsisPressed.png" Width="12px">
                                                </ButtonEditEllipsisImage>
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxDropDownEdit>
                                        </td>

                                        <td width="35" align="left">
                                            سال:</td>
                                        <td width="100">
                                            <dx:ASPxComboBox ID="ASPxComboBoxYear" runat="server" ValueType="System.String" 
                                                Width="100px" RightToLeft="True" 
                                                SelectedIndex="0" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                                CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                                LoadingPanelImagePosition="Top" ShowShadow="False">
                                                <Items>
                                                    <dx:ListEditItem Selected="True" Text="1390" Value="1390" />
                                                    <dx:ListEditItem Text="1391" Value="1391" />
                                                    <dx:ListEditItem Text="1392" Value="1392" />
                                                    <dx:ListEditItem Text="1393" Value="1393" />
                                                    <dx:ListEditItem Text="1394" Value="1394" />
                                                    <dx:ListEditItem Text="1395" Value="1395" />
                                                </Items>
                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                </LoadingPanelImage>
                                                <DropDownButton>
                                                    <Image>
                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                                    </Image>
                                                </DropDownButton>
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td width="30" align="left">
                                            ماه:</td>
                                        <td width="100">
                                            <dx:ASPxComboBox ID="ASPxComboBoxMonth" runat="server" RightToLeft="True" SelectedIndex="0" 
                                                ValueType="System.String" Width="100px" DropDownRows="10" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                                LoadingPanelImagePosition="Top" ShowShadow="False">
                                                <Items>
                                                    <dx:ListEditItem Selected="True" Text="فروردین" Value="01" />
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
                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                </LoadingPanelImage>
                                                <DropDownButton>
                                                    <Image>
                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                                    </Image>
                                                </DropDownButton>
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td width="120">
                                            <dx:ASPxButton ID="ASPxButtonShowReportMonthly" 
                                                ClientInstanceName="ButtonShowReportMonthly" runat="server" Text="نمایش" 
                                                AutoPostBack="False" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                                CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"  >
                                                <ClientSideEvents Click="function(s,e){ButtonShowReportMonthly_onclick();}" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                </div>
                            <div style="width: 800px">
                                <table style="font-family: tahoma; font-size: 9pt;" cellpadding="3" 
                                    cellspacing="3">
    <tr>
     <td align="left" width="30">
         نام :</td>
     <td align="right" width="120">
                                            <dx:ASPxLabel ID="ASPxLabelName" runat="server" ClientInstanceName="lbl3" 
                                                Font-Bold="True">
                                            </dx:ASPxLabel>
    </td>
     <td align="left" width="90">
         نام خانوادگی:</td>
     <td align="right" width="150">
                                            <dx:ASPxLabel ID="ASPxLabelFamily" runat="server" ClientInstanceName="lbl4" 
                                                Font-Bold="True">
                                            </dx:ASPxLabel>
    </td>
     <td align="left" width="60">
         پرسنلی:</td>
     <td align="right" width="120">
                                            <dx:ASPxLabel ID="ASPxLabelBarcode" runat="server" 
                                                ClientInstanceName="LabelBarcode" Width="54px" Height="16px" Font-Bold="True">
                                            </dx:ASPxLabel>
    </td>
    </tr>
    </table>
                            </div>
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanelGridReportMonthly" 
                                ClientInstanceName="CallbackPanelGridReportMonthly" runat="server" 
                                Width="100%" oncallback="ASPxCallbackPanelGridReportMonthly_Callback">
        <PanelCollection>
        <dx:PanelContent runat="server" id="ASPxCallbackPanelGridReportMonthlyPanelContent">
        
        <dx:ASPxGridView ID="ASPxGridViewReportMonthly" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua"  KeyFieldName="prc_date" 
               OnDetailRowGetButtonVisibility="ASPxGridViewReportMonthly_DetailRowGetButtonVisibility" OnHtmlRowPrepared="ASPxGridViewReportMonthly_HtmlRowPrepared"
            RightToLeft="True"
            ClientInstanceName="G11" 
                OnHtmlDataCellPrepared="ASPxGridViewReportMonthly_htmldatacellprepared"  >
            <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                <DetailButton Font-Bold="False">
                    <Border BorderColor="#3399FF"></Border>
                </DetailButton>
                <LoadingPanel ImageSpacing="8px">
                </LoadingPanel>
                <Header ImageSpacing="10px" SortingImageSpacing="10px">
                </Header>
                
                <Row BackColor="#CCCCFF">
                </Row>
                <DetailRow BackColor="#CCCCFF">
                </DetailRow>
                <DetailCell BackColor="#DDBBFF">
                </DetailCell>
                <Cell BackColor="#CCCCFF">
                    <Border BorderColor="#3399FF" />
                    <Border BorderColor="#3399FF"></Border>
                </Cell>
                <DetailButton Font-Bold="False">
                    <Border BorderColor="#3399FF" />
                    <Border BorderColor="#3399FF"></Border>
                </DetailButton>
            </Styles>
            <SettingsEditing PopupEditFormModal="True"></SettingsEditing>
            <SettingsDetail ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
            <Columns>
                <dx:GridViewDataTextColumn Caption="توضیـــــــــــــــــــحات" FieldName="PishCardFullName"
                    ShowInCustomizationForm="True" VisibleIndex="26">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle Wrap="True">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="روز" FieldName="FARSI_WEEK_DAY" ShowInCustomizationForm="True"
                    VisibleIndex="2">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ورود اول" FieldName="prc_FirstIn" ShowInCustomizationForm="True"
                    VisibleIndex="3">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="خروج اول" FieldName="Prc_FirstOut" ShowInCustomizationForm="True"
                    VisibleIndex="5">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ورود دوم" FieldName="Prc_SecondIn" ShowInCustomizationForm="True"
                    VisibleIndex="6">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="خروج دوم" FieldName="Prc_SecondOut" ShowInCustomizationForm="True"
                    VisibleIndex="7">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ورود سوم" FieldName="Prc_ThirdIn" ShowInCustomizationForm="True"
                    VisibleIndex="8">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="خروج سوم" FieldName="Prc_ThirdOut" ShowInCustomizationForm="True"
                    VisibleIndex="9">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ورود چهارم" FieldName="Prc_FourthIn" ShowInCustomizationForm="True"
                    VisibleIndex="10">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="خروج چهارم" FieldName="Prc_FourthOut" ShowInCustomizationForm="True"
                    VisibleIndex="11">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ورود پنجم" FieldName="Prc_FifthIn" ShowInCustomizationForm="True"
                    VisibleIndex="12">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="خروج پنجم" FieldName="Prc_FifthOut" ShowInCustomizationForm="True"
                    VisibleIndex="13">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="حضور واقعی" FieldName="HozurEVagheie" ShowInCustomizationForm="True"
                    VisibleIndex="15">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="حضور لازم" FieldName="HozurELazem" ShowInCustomizationForm="True"
                    VisibleIndex="14">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="کشیک" FieldName="Keshik" ShowInCustomizationForm="True"
                    VisibleIndex="18">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="اضافه کار" FieldName="Ezafehkar" ShowInCustomizationForm="True"
                    VisibleIndex="17">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ا ک غ م" FieldName="EzafehkarGheiremojaz" ShowInCustomizationForm="True"
                    VisibleIndex="16" Width="10px">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="کسر کار" FieldName="kasrekar" ShowInCustomizationForm="True"
                    VisibleIndex="22">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="غیبت" FieldName="GheibatRuz" ShowInCustomizationForm="True"
                    VisibleIndex="34">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ماموریت ساعتی" FieldName="MamHour" ShowInCustomizationForm="True"
                    VisibleIndex="19">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="ماموریت روزانه" FieldName="MamRuz" ShowInCustomizationForm="True"
                    VisibleIndex="23">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="استعلاجی ب" FieldName="MorDarRuzB" ShowInCustomizationForm="True"
                    VisibleIndex="26">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="مرخصی روزانه" FieldName="MorEstRuz" ShowInCustomizationForm="True"
                    VisibleIndex="24">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="اضطرار" FieldName="Ezterar" ShowInCustomizationForm="True"
                    VisibleIndex="21" Visible="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="استعلاجی الف" FieldName="MorDarRuz" ShowInCustomizationForm="True"
                    VisibleIndex="25">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="مر-بی حقوق" FieldName="MorBiHoghRuz" ShowInCustomizationForm="True"
                    VisibleIndex="27">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="مرخصی ساعتی" FieldName="MorSaati" ShowInCustomizationForm="True"
                    VisibleIndex="20">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DayMandeMorakhasi" ShowInCustomizationForm="True"
                    Visible="False" VisibleIndex="28">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="HourMandeMorakhasi" ShowInCustomizationForm="True"
                    Visible="False" VisibleIndex="30">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Prc_AbsenceNaghes" ShowInCustomizationForm="True"
                    Visible="False" VisibleIndex="31">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="تاریـــــــخ" FieldName="prc_date" ShowInCustomizationForm="True"
                    VisibleIndex="1">
                    <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
              
                <dx:GridViewDataTextColumn Name="color" ShowInCustomizationForm="True" 
                    VisibleIndex="0" Width="15px">
                    <CellStyle VerticalAlign="Top">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
              
               
             
              
            </Columns>
            
            <SettingsBehavior AllowDragDrop="False" AllowSort="False" AllowGroup="False" AllowFocusedRow="false"
                AllowSelectByRowClick="False" AllowSelectSingleRowOnly="True" EnableRowHotTrack="False">
            </SettingsBehavior>
            <SettingsPager PageSize="50">
                <AllButton Text="All">
                </AllButton>
                <NextPageButton Text="Next &gt;">
                </NextPageButton>
                <PrevPageButton Text="&lt; Prev">
                </PrevPageButton>
            </SettingsPager>
            <SettingsEditing PopupEditFormModal="True" />
            <SettingsText EmptyDataRow="هیچ آیتمی یافت نشد" />
            <SettingsLoadingPanel ImagePosition="Top" />
           
            <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesEditors>
                <DropDownEditDropDown>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                        PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                </DropDownEditDropDown>
                <SpinEditIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
                </SpinEditIncrement>
                <SpinEditDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
                </SpinEditDecrement>
                <SpinEditLargeIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
                </SpinEditLargeIncrement>
                <SpinEditLargeDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
                </SpinEditLargeDecrement>
            </ImagesEditors>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>

<Styles CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"></Styles>

            <StylesEditors>
                <CalendarHeader Spacing="1px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridView2" DataSourceID="SqlDataSource2" runat="server"  AutoGenerateColumns="False" 
                        KeyFieldName="ID_PK" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect"
                        OnHtmlDataCellPrepared="ASPxGridView2_HtmlDataCellPrepared" OnHtmlRowPrepared="ASPxGridView2_HtmlRowPrepared"
                        CssFilePath="~/App_Themes/RedWine/{0}/styles.css" OnInitNewRow="ASPxGridView2_InitNewRow" CssPostfix="RedWine" RightToLeft="True"
                        ClientInstanceName="grid" 
                        OnRowDeleting="ASPxGridView2_RowDeleting"
                        OnRowInserting="ASPxGridView2_RowInserting" Width="60%">
                        <ClientSideEvents RowClick="function(s, e) {GridView2_RowClick(s,e);}" />
                        <ClientSideEvents EndCallback="function(s,e){GridView2_EndCallback(s,e);}" />
                        <Columns>
                            <dx:GridViewCommandColumn Visible="true" Name="CommandButtonASPxGridView2_DevMonthlyReport" VisibleIndex="0">
                                <DeleteButton Visible="True">
                                </DeleteButton>
                                <NewButton Visible="True">
                                </NewButton>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="prc_date" VisibleIndex="1" Caption="تاریخ درخواست">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_SendDate" VisibleIndex="2" Caption="تاریخ صدور">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_Time" VisibleIndex="3" ReadOnly="True"
                                Caption="از ساعت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_eTime" VisibleIndex="4" ReadOnly="True"
                                Caption="تا ساعت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="pish_name" VisibleIndex="5" ReadOnly="True"
                                Caption="عنوان درخواست">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="agree" VisibleIndex="6" ReadOnly="True" Caption="وضعیت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_RecDes" VisibleIndex="7" Caption="توضیحات">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ID_PK" ReadOnly="True" VisibleIndex="8" Visible="False">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior AllowSort="False" ConfirmDelete="True" />
                        <SettingsPager>
                            <AllButton Text="All">
                            </AllButton>
                            <NextPageButton Text="Next &gt;">
                            </NextPageButton>
                            <PrevPageButton Text="&lt; Prev">
                            </PrevPageButton>
                        </SettingsPager>
                        <SettingsText CommandDelete="حذف" CommandEdit="ویرایش" CommandNew="جدید" CommandUpdate="بروزرسانی"
                            CommandCancel="انصراف" ConfirmDelete="آیا ردیف جاری را حذف می کنید؟" />
                        <SettingsLoadingPanel ImagePosition="Top" />
                        <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                            <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                            </LoadingPanelOnStatusBar>
                            <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <ImagesEditors>
                            <DropDownEditDropDown>
                                <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_RedWine" />
                            </DropDownEditDropDown>
                        </ImagesEditors>
                        <ImagesFilterControl>
                            <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                            </LoadingPanel>
                        </ImagesFilterControl>
                        <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                            <LoadingPanel ImageSpacing="8px">
                            </LoadingPanel>
                        </Styles>
                        <StylesEditors>
                            <CalendarHeader Spacing="1px">
                            </CalendarHeader>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                        <Templates>
                            <EmptyDataRow>
                                <table class="style12">
                                    <tr>
                                        <td>
                                            <dx:ASPxButton ID="ASPxButton1_DevMonthlyReport" runat="server" AutoPostBack="False" Text="درخواست جدید"
                                                Wrap="True" Enabled="true" CssPostfix="Aqua" CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                <ClientSideEvents Click="function(s, e) {
	grid.AddNewRow();
}" />
                                            </dx:ASPxButton>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </EmptyDataRow>
                            <EditForm>
                   
                                
                               
                                    
                                        <dx:ASPxRoundPanel ID="ASPxRoundPanelInsertRequest" RightToLeft="True" runat="server" Width="600px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" HeaderText="درخواست جدید">
                                        <PanelCollection>
                                        <dx:PanelContent runat="server" ID="PanelContentInsertRequest">
                                       
                                            <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" ClientInstanceName="in1"
                                                CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" CssPostfix="SoftOrange"
                                                 LoadingPanelImagePosition="Top" LoadingPanelText="بارگذاری&amp;hellip;"
                                                OnCallback="ASPxCallbackPanel1_Callback" Width="194px">
                                                <LoadingPanelImage Url="~/App_Themes/SoftOrange/Web/Loading.gif">
                                                </LoadingPanelImage>
                                                <PanelCollection>
                                                    <dx:PanelContent ID="PanelContent2" runat="server" SupportsDisabledAttribute="True">
                                                    <table width="100%">
                                                    <tr>
                                                    <td valign="top" width="70%">
                                                    <dx:ASPxRadioButtonList ClientInstanceName="RadioButtonList1" ID="ASPxRadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                            SelectedIndex="0" Width="100%" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"  CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) {
 
      in1.PerformCallback(s.GetValue());
  
}" />
                                                            <Items>
                                                                <dx:ListEditItem Selected="True" Text="ساعتی" Value="1" />
                                                                <dx:ListEditItem Text="روزانه" Value="2" />
                                                                <dx:ListEditItem Text="دستوری" Value="3" />
                                                            </Items>
                                                        </dx:ASPxRadioButtonList>
                                                        <br />
                                                        
                                                    </td>
                                                    <td width="30%" valign="top">
                                       
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                    <td valign="top">
                                                    <dx:ASPxRoundPanel ID="ASPxRoundPanelPishcard" RightToLeft="True" runat="server" Width="100%" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" HeaderText="پیش کارت ها">
                                        <PanelCollection>
                                        <dx:PanelContent runat="server" ID="PanelContent1">
                                                        <table width="100%">
                                                        <tr>
                                                        <td width="30px">
                                                         پیش کارت:
                                                        </td>
                                                        <td>
                                                        <dx:ASPxComboBox ID="ASPxComboBox3" runat="server" ClientInstanceName="cb1" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" DataSourceID="SqlDataSource3" RightToLeft="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                                                                        TextField="PishName"  ValueField="pish_code" ValueType="System.String" Width="215px">
                                                                        <ClientSideEvents Init="function(s, e) {
	                                                                                        s.SetSelectedIndex(0);
                                                                                        }" />
                                                                        <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                                        </LoadingPanelImage>
                                                                        <ValidationSettings>
                                                                            <ErrorFrameStyle ImageSpacing="4px">
                                                                                <ErrorTextPaddings PaddingLeft="4px" />
                                                                            </ErrorFrameStyle>
                                                                        </ValidationSettings>
                                                                    </dx:ASPxComboBox>
                                                        </td>
                                                        </tr>
                                                        </table>
                                                        </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxRoundPanel>
                                                    </td>
                                                    <td valign="top">
                                                                 <dx:ASPxRoundPanel ID="ASPxRoundPanelHourly" RightToLeft="True" runat="server" Width="250px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" HeaderText="بازه زمانی">
                                        <PanelCollection>
                                        <dx:PanelContent runat="server" ID="PanelContent3">
                                                        <table   width="100%">
                                                            <tr>
                                                                <td align="left">
                                                                    از ساعت:
                                                                </td>
                                                                <td>
                                                                    <dx:ASPxTimeEdit ID="ASPxTimeEdit5" runat="server" ClientInstanceName="TM1" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" EditFormat="Custom" EditFormatString="HH:mm" RightToLeft="True"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="60px">
                                                                    </dx:ASPxTimeEdit>
                                                                </td>
                                                                </tr>
                                                                <tr>
                                                                <td align="left">
                                                                    تا ساعت:
                                                                </td>
                                                                <td>
                                                                    <dx:ASPxTimeEdit ID="ASPxTimeEdit6" runat="server" ClientInstanceName="TM2" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" EditFormat="Custom" EditFormatString="HH:mm" RightToLeft="True"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="60px">
                                                                    </dx:ASPxTimeEdit>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        </dx:PanelContent>
                                                        </PanelCollection>
                                                        </dx:ASPxRoundPanel>
                                                        <dx:ASPxRoundPanel ID="ASPxRoundPanelValue" RightToLeft="True" runat="server" Width="250px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" HeaderText="زمان" Visible="False">
                                        <PanelCollection>
                                        <dx:PanelContent runat="server" ID="PanelContent5">
                                                        <table   width="100%">
                                                            <tr>
                                                                <td align="left" width="20%">
                                                                  مقدار:
                                                                </td>
                                                                <td width="60px">
                                                                   <%-- <dx:ASPxTimeEdit ID="ASPxTimeEdit1" runat="server" ClientInstanceName="TM3" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" EditFormat="Custom" EditFormatString="HH:mm" RightToLeft="True"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="60px">
                                                                    </dx:ASPxTimeEdit>--%>
                                                                    <dx:ASPxSpinEdit ID="ASPxSpinOverTime" runat="server" Height="21px" MaxValue="999"
                                                                            Number="0" Width="50px" ClientInstanceName="SpinOverTime" 
                                                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" RightToLeft="True">
                                                                            </dx:ASPxSpinEdit>
                                                                </td>
                                                                <td dir="rtl" align="right">
                                                                 ساعت
                                                                </td>
                                                                </tr>
                                                                
                                                        </table>
                                                        </dx:PanelContent>
                                                        </PanelCollection>
                                                        </dx:ASPxRoundPanel>
                                                    </td>
                                                    </tr>
                                                    </table>
                                                        
                                                        <br />
                                                       
                                                        <dx:ASPxRoundPanel ID="ASPxRoundPanelExplain" RightToLeft="True" runat="server" Width="550px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" HeaderText="توضیحات">
                                        <PanelCollection>
                                        <dx:PanelContent runat="server" ID="PanelContent4">
                                                        <table >
                                                            <tr>
                                                             
                                                                <td>
                                                                    <dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="500px" CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css">
                                                                    </dx:ASPxTextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        </dx:PanelContent>
                                                        </PanelCollection>
                                                        </dx:ASPxRoundPanel>
                                                        
                                                       <br />
                                                        
                                                        <table class="style12">
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxButton ID="ASPxButton7" runat="server" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" AutoPostBack="False" Text="بروزرسانی">
                                                             <ClientSideEvents Click="function(s, e) {button7_onClick();}" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td>
                                                                    <dx:ASPxButton ID="ASPxButton6" runat="server" AutoPostBack="False" Text="انصراف"
                                                                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                        <ClientSideEvents Click="function(s, e) {
 
grid.CancelEdit();
}" CheckedChanged="function(s, e) {
  
}" />
                                                                    </dx:ASPxButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxCallbackPanel>
                                       
                                        </dx:PanelContent>
                                        </PanelCollection>
                                        </dx:ASPxRoundPanel>
                              
                                
                            </EditForm>
                        </Templates>
                    </dx:ASPxGridView>
                </DetailRow>
                <EmptyDataRow>
                  
                </EmptyDataRow>
            </Templates>
           
        </dx:ASPxGridView>
        
        </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="function(s,e){HideLoadingImage();

var row = GridViewUnderManegment.GetRow(GridViewUnderManegment.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML + '  ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
lbl3.SetText(row.cells[1].innerHTML);
   lbl4.SetText(row.cells[2].innerHTML);
   LabelBarcode.SetText(row.cells[0].innerHTML); 
        }" />
        </dx:ASPxCallbackPanel>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:cnn %>" SelectCommand="SELECT top 100 Clock_User,dbo.person_name(Clock_User) name
      ,Clock_Date
      ,Clock_SendDate
      ,substring(Clock_AgreeDate,1,10) FirstAgreeDate
      ,substring(Clock_AgreeDate,12,10) FinalyAgreeDate
      ,dbo.MToH(Clock_Time) Clock_Time
      ,dbo.MToH(Clock_eTime) Clock_eTime
      ,Clock_RdrCode
      ,Clock_Chg
      ,Clock_RecState
      ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
      ,Clock_User
      ,dbo.person_name(Clock_User) clock_user_name
      ,Clock_RecDes
      ,Clock_FirstlyAgree
      ,Clock_FirstlyAgree_BarCode
      ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,1,8)) FirstlyAgree_name
      ,dbo.person_name(substring(Clock_FirstlyAgree_barcode,9,8)) FinallyAgree_name
      ,Clock_FinallyAgree

  FROM Requests"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="ds5" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:cnn %>" 
                                
                                
                                SelectCommand="(select (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family
from persons where P_BarCode=(select p_barcode from NW_webpass where PersonPost=@userName))
union
(select (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family 
from persons where P_Parts 
in(select PersonBarCode from NW_webpasspersons where isPart='True' and WebPassId=(select ID from NW_webpass where PersonPost=@userName))
union
select (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family 
from persons where P_BarCode 
in (select PersonBarCode from NW_webpasspersons where isPerson='True' and WebPassId=(select ID from NW_webpass where PersonPost=@userName))) order by Barcode">
                                <SelectParameters>
                                    <asp:Parameter Name="userName" />
                                </SelectParameters>
                            </asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:cnn %>"
            SelectCommand="select * from 
(select pish_code, case when Pish_LastName&lt;&gt;'' then Pish_LastName else Pish_Name end  PishName
 from pishcard where  Pish_InitCode=0 and Pish_activeWeb='True') l1 

" ID="SqlDataSource3"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceGetExistTable" runat="server">
                            </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cnn %>"
            SelectCommand="SELECT Clock_Date as prc_date
      ,Clock_SendDate
      ,dbo.MToH(Clock_Time) Clock_Time
      ,dbo.MToH(Clock_eTime) Clock_eTime
      ,dbo.pish_lastname(Clock_User,Clock_RecState) pish_name
      ,case when Clock_FirstlyAgree=2 then 2 else Clock_FinallyAgree  end agree
      ,Clock_RecDes,ID_PK,Clock_User
 FROM NW_Requests where Clock_date between '1390/08/01' and '1390/08/30' and clock_User='00035058'

 
 " UpdateCommand="update Requests

set Clock_User=@Clock_User
,Clock_Time=CONVERT(int,substring(@Clock_Time,1,2))*60+convert(int,substring(@Clock_Time,4,2))
,Clock_eTime=CONVERT(int,substring(@Clock_eTime,1,2))*60+convert(int,substring(@Clock_eTime,4,2))
,Clock_Chg=Clock_Chg+1
,Clock_RecState=@Clock_RecState
,Clock_User='Web'
,Clock_RecDes=@Clock_RecDes

where Id_PK=@Id_PK">
            <UpdateParameters>
                <asp:Parameter Name="Clock_User" />
                <asp:Parameter Name="Clock_Time" />
                <asp:Parameter Name="Clock_eTime" />
                <asp:Parameter Name="Clock_RecState" />
                <asp:Parameter Name="Clock_RecDes" />
                <asp:Parameter Name="Id_PK" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:cnn %>" 
                                SelectCommand="SELECT * FROM [_security]"></asp:SqlDataSource>
    </div>
      <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold; font-family:Tahoma; font-size:9pt;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>

    </form>
    
</body>
</html>

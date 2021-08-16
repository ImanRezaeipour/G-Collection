<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashbord.aspx.cs" Inherits="ASPWebclock.Dashbord" %>

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
<head runat="server">
    <title></title>
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/Dashboard_onOperations.js" type="text/javascript"></script>
  
  
</head>
<body>
    <form id="form1" runat="server">
    <div  dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right">
        <cc1:JQLoader ID="JQLoader1" runat="server" Theme="Start">
        </cc1:JQLoader>
        
        <table align="right">
            <tr>
                <td>
                    <dx:ASPxRoundPanel ID="ASPxRoundPanelFilter" runat="server" Width="740px" 
                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                        GroupBoxCaptionOffsetY="-28px" ClientInstanceName="RoundPanelFilter" 
                        HeaderText="فیلتر نمایش" RightToLeft="True" 
                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                        <ContentPaddings Padding="14px" />
                        <HeaderTemplate>
                        <table width="100%">
                        <tr>
                        <td align="right">
                        فیلتر نمایش
                        </td>
                        <td align="left">
                          <img id="imgSlidePanelFilter" src="../img/minimize.png" style="cursor: pointer" alt="تغییر اندازه پنل" />
                        </td>
                        </tr>
                        </table>
                      
                        </HeaderTemplate>
                    <PanelCollection>
                    <dx:PanelContent runat="server" >
                    
                   <div id="divFilterRequests_Dashborad" >
                    <table align="right" width="100%" cellspacing="10">
                        <tr>
                            <td align="right" style="font-family: Tahoma; width: 15%;">
                                <table style="font-family: Tahoma; width: 100%;">
                                    <tr>
                                        <td style="font-family: Tahoma; width: 55px; font-size: 9pt;" align="left">
                                            از تاریخ:
                                        </td>
                                        <td style="font-family: Tahoma; width: 90px;" align="right">
                                            <cc1:JQDatePicker ID="FromDate" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"
                                                Width="90px"></cc1:JQDatePicker>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" style="font-family: Tahoma; width: 65%;">
                                <dx:ASPxDropDownEdit ID="ASPxDropDownEditUnderMangmentPerson" runat="server" 
                                    ClientInstanceName="DropDownEditUnderManagment" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    PopupHorizontalAlign="RightSides" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="انتخاب همه پرسنل" 
                                    Width="98%">
                                    <DropDownWindowTemplate>
                                        <div style="width: 99%; margin: 5px">
                                            <dx:ASPxCheckBox ID="ASPxCheckBoxSelectAllPerson" runat="server" 
                                                ClientInstanceName="CheckBoxSelectAllPerson" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="انتخاب همه">
                                                <ClientSideEvents CheckedChanged="function(s,e){CheckBoxSelectAllPerson_onChanged(s,e);}" />
                                            </dx:ASPxCheckBox>
                                        </div>
                                        <dx:ASPxGridView ID="ASPxGridView5" runat="server" AutoGenerateColumns="False" 
                                            ClientInstanceName="GridViewUnderManegment" 
                                            CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
                                            KeyFieldName="Barcode" Styles-Row-Cursor="pointer" Width="400px">
                                            <ClientSideEvents EndCallback="function(s,e){
                                                        
                                                        if (s.GetVisibleRowsOnPage() &gt; 0) {
                                                         s.SetFocusedRowIndex(s.GetTopVisibleIndex());
                                                        }}" />
                                            <ClientSideEvents FocusedRowChanged="function(s, e) {
                                                        if(s.GetFocusedRowIndex()&gt;-1)
                                                        {
var row = s.GetRow(s.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
DropDownEditUnderManagment.SetText(cellValue);
CheckBoxSelectAllPerson.SetChecked(false);
     
   s.GetFocusedRowIndex();
   
   }
  
   
}" />
                                            <ClientSideEvents RowClick="function(s,e){DropDownEditUnderManagment.HideDropDown();}" />
                                            <Columns>
                                                <dx:GridViewDataTextColumn Caption="کد پرسنلی" FieldName="Barcode" 
                                                    ShowInCustomizationForm="True" VisibleIndex="1">
                                                    <Settings AutoFilterCondition="Contains" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <CellStyle HorizontalAlign="Right">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="نام" FieldName="Name" 
                                                    ShowInCustomizationForm="True" VisibleIndex="2">
                                                    <Settings AutoFilterCondition="Contains" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <CellStyle HorizontalAlign="Right">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="نام خانوادگی" FieldName="Family" 
                                                    ShowInCustomizationForm="True" VisibleIndex="3">
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
                                                <Summary Text="صفحه {0} از {1}" />
                                            </SettingsPager>
                                        </dx:ASPxGridView>
                                    </DropDownWindowTemplate>
                                    <DropDownWindowStyle VerticalAlign="Top">
                                    </DropDownWindowStyle>
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
                            <td align="right" dir="ltr" style="font-family: Tahoma; width: 20%;">
                                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_Dashboard" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_Dashboard">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_DashboardManager" 
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
                        </tr>
                        <tr>
                            <td align="center" dir="rtl" style="font-family: Tahoma; width: 33%;">
                                <table style="font-family: Tahoma; width: 100%;">
                                    <tr>
                                        <td align="left" style="font-family: Tahoma; width: 55px; font-size: 9pt;">
                                            تا تاریخ:
                                        </td>
                                        <td style="font-family: Tahoma; width: 90px;" align="right">
                                            <cc1:JQDatePicker ID="ToDate" runat="server" DateFormat="YMD" 
                                                IEDateFormat="YMD" Regional="fa" Width="90px"></cc1:JQDatePicker>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" dir="rtl" style="font-family: Tahoma; width: 65%;">
                                <dx:ASPxRadioButtonList ID="ASPxRadioButtonListFilterView" runat="server" 
                                    ClientInstanceName="RadioButtonListFilterView" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    RepeatDirection="Horizontal" RightToLeft="True" SelectedIndex="0" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px" 
                                    Width="98%">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="تایید نشده ها" Value="UnderView" />
                                        <dx:ListEditItem Text="تایید شده ها" Value="Confirmed" />
                                        <dx:ListEditItem Text="عدم تایید ها" Value="Rejected" />
                                    </Items>
                                </dx:ASPxRadioButtonList></td>
                            <td align="right" dir="rtl" id="tdButtonDoCondition">
                                <dx:ASPxButton ID="DoCondition" runat="server" Height="16px" Text="اعمال شرایط" Width="100px"
                                    AutoPostBack="False" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                    <ClientSideEvents Click="function(s, e){DashbordFilterCallback();}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" dir="rtl" style="font-family: Tahoma; width: 33%;">
                                عنوان درخواست </td>
                            <td align="right" dir="ltr" style="font-family: Tahoma; width: 65%;">
                                <dx:ASPxComboBox ID="ASPxComboBoxPishcard" 
                                    ClientInstanceName="ComboBoxPishcard" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    LoadingPanelImagePosition="Top" ShowShadow="False" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                    Width="99%" RightToLeft="True">
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
                            <td ID="tdButtonDoCondition" align="right" dir="rtl">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" dir="rtl" style="padding: 10px; font-family: Tahoma; " 
                                colspan="3">
                                
                            </td>
                        </tr>
                    </table>
                    </div>
                    <table align="center" width="100%">
                    <tr>
                    <td align="center">
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" 
                                    CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="عملیات" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css" Width="90%">
                                    <ContentPaddings Padding="14px" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
                                        <table width="100%" align="center">
                                        <tr>
                                        <td style="width: 33%" align="center">
                                            <dx:ASPxButton ID="ASPxButton3_Dashbord" runat="server" AutoPostBack="False" 
                                                ClientInstanceName="Button3_Dashbord" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" Height="16px" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="تایید انتخاب شده ها" 
                                                Width="160px" ClientEnabled="False">
                                                <ClientSideEvents Click="function(s,e){ //ConfirmationRequest('1,2');
                                    DashbordsGridView.GetSelectedFieldValues('Id_PK', ConfirmationRequest);}" />
                                            </dx:ASPxButton>
                                            </td>
                                        <td style="width: 33%" align="center">
                                            <dx:ASPxButton ID="ASPxButton4_Dashbord" runat="server" AutoPostBack="False" 
                                                ClientInstanceName="Button4_Dashbord" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" Height="16px" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                                Text="عدم تایید انتخاب شده ها" Width="160px" ClientEnabled="False">
                                                <ClientSideEvents Click="function(s,e){ DashbordsGridView.GetSelectedFieldValues('Id_PK', RejectionRequest);}" />
                                            </dx:ASPxButton>
                                            </td>
                                            <td align="center" style="width: 34%">
                                                <dx:ASPxButton ID="ASPxButtonDelete_Dashbord" runat="server" 
                                                    AutoPostBack="False" ClientInstanceName="ButtonDelete_Dashbord" 
                                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" Height="16px" 
                                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="حذف درخواست ها" 
                                                    Width="160px" ClientEnabled="False">
                                                    <ClientSideEvents Click="function(s,e){ DashbordsGridView.GetSelectedFieldValues('Id_PK', deleteRequest);}" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                        </table>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                    </td>
                    </tr>
                    </table>
                     </dx:PanelContent>
                 </PanelCollection>
                 </dx:ASPxRoundPanel>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <%-- <dx:ASPxCallbackPanel ID="DashbordsCallbackPanel" runat="server" ClientInstanceName="DashbordsCallbackPanel"
                            OnCallback="DashbordsCallbackPanel_Callback" Width="100%" ShowLoadingPanel="true">
                            <ClientSideEvents EndCallback="OnDashbordsEndCallback"></ClientSideEvents>
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent1" runat="server">--%>

                                    <dx:ASPxGridView ID="DashbordsGridView" ClientInstanceName="DashbordsGridView" runat="server"
                                        AutoGenerateColumns="False" CssPostfix="Aqua" KeyFieldName="Id_PK" Width="1500px"
                                        RightToLeft="True" OnPageIndexChanged="DashbordsGridView_PageIndexChanged" 
                                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                        OnCustomCallback="DashbordsGridView_CustomCallback">
                                        <ClientSideEvents EndCallback="function(s,e){DashbordsGridView_EndCallback(s,e);}" />
                                     
                                        <Columns>
                                       

                                          
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" ShowInCustomizationForm="true"
                                                VisibleIndex="0" Name="Selection" Caption="انتخاب">
                                               <HeaderTemplate>

                                                   <dx:ASPxCheckBox ID="cbAll" runat="server" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" OnInit="cbAll_Init"   CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua"  ClientInstanceName="cbAll" ToolTip="Select all rows" Text="همه">
                                                   <ClientSideEvents CheckedChanged="function(s,e){OnAllCheckedChanged(s,e);}" />
                                                   </dx:ASPxCheckBox>

                                                

                                               </HeaderTemplate>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="پرسنلی" FieldName="Clock_User" ShowInCustomizationForm="True"
                                                VisibleIndex="2">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="نام" FieldName="name" ReadOnly="True" ShowInCustomizationForm="True"
                                                VisibleIndex="3" Width="100px">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تاریخ" FieldName="Clock_Date" ShowInCustomizationForm="True"
                                                VisibleIndex="4">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تاریخ صدور" FieldName="Clock_SendDate" ShowInCustomizationForm="True"
                                                VisibleIndex="5">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تاریخ تایید اولیه" 
                                                FieldName="FirstAgreeDate" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="5">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                              <dx:GridViewDataTextColumn Caption="تاریخ تایید ثانویه" 
                                                FieldName="SeconderyAgreeDate" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="6">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تاریخ تایید نهایی" FieldName="FinalyAgreeDate"
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="7">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="از ساعت" FieldName="Clock_Time" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تا ساعت" FieldName="Clock_eTime" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="9">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="مدت" FieldName="timeValue" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_Chg" ShowInCustomizationForm="True" Visible="False"
                                                VisibleIndex="11">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_RecState" ShowInCustomizationForm="True"
                                                Visible="False" VisibleIndex="12">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="عنوان درخواست" FieldName="pish_name" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="13">
                                                <Settings AllowSort="True" SortMode="DisplayText" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_User" ShowInCustomizationForm="True"
                                                Visible="False" VisibleIndex="14">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="نام اپراتور" ReadOnly="True"
                                                ShowInCustomizationForm="True" VisibleIndex="15" Width="100px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="توضیحات" FieldName="Clock_RecDes" ShowInCustomizationForm="True"
                                                VisibleIndex="16" Width="400px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_FirstlyAgree" ShowInCustomizationForm="True"
                                                Visible="False" VisibleIndex="17">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_FirstlyAgree_BarCode" ShowInCustomizationForm="True"
                                                Visible="False" VisibleIndex="18">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تایید کننده اولیه" FieldName="FirstlyAgree_name"
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="19">
                                            </dx:GridViewDataTextColumn>
                                             <dx:GridViewDataTextColumn Caption="تایید کننده ثانویه" FieldName="SeconderyAgree_name"
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="20">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="تایید کننده نهایی" FieldName="FinallyAgree_name"
                                                ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="21">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Clock_FinallyAgree" ShowInCustomizationForm="True"
                                                Visible="False" VisibleIndex="22">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="ID_PK" FieldName="Id_PK" ShowInCustomizationForm="false"
                                                Visible="false" VisibleIndex="23">
                                            </dx:GridViewDataTextColumn>
                                             <dx:GridViewDataTextColumn Caption="ManagerID" FieldName="Id_PK" ShowInCustomizationForm="false"
                                                Visible="false" VisibleIndex="24">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataImageColumn Caption="وضعیت" FieldName="Status" Name="Status" 
                                                ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataImageColumn>
                                        </Columns>
                                        <SettingsBehavior AllowDragDrop="False" AllowGroup="False" AllowFocusedRow="true"
                                            AllowSort="False" />
                                        <SettingsPager PageSize="20">
                                            <AllButton Text="کل">
                                            </AllButton>
                                            <NextPageButton Text="بعدی &gt;">
                                            </NextPageButton>
                                            <PrevPageButton Text="&lt; قبلی">
                                            </PrevPageButton>
                                            <Summary Text="صفحه {0} از {1}" />
                                        </SettingsPager>
                                        <SettingsText EmptyDataRow="هیچ آیتمی یافت نشد." />
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
                                        <Styles CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css">
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
                                        </Templates>
                                    </dx:ASPxGridView>
                    </div>
                </td>
            </tr>
        </table>
         <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
     
    </form>
</body>
</html>

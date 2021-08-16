<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefineInsteadMan.aspx.cs" Inherits="ASPWebclock.Operation.DefineInsteadMan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPager" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxDataView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPager" TagPrefix="dx1" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx2" %>

    <%@ Register Assembly="JQControls" Namespace="JQControls" TagPrefix="cc1" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/DefineInsteadMan_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="DefineInsteadManForm" runat="server" onsubmit="return false;">
    <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right">
    <cc1:JQLoader ID="JQLoader1" runat="server" Theme="Start">
        </cc1:JQLoader>
     <div align="right" dir="rtl">
     
         <br />
        <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewInsteadMan" KeyFieldName="Barcode" 
                AutoGenerateColumns="False" RightToLeft="True" Width="80%" 
                ID="ASPxGridViewInsteadMan" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                            CssPostfix="Aqua" 
             oncustomcallback="ASPxGridViewInsteadMan_CustomCallback">

             <ClientSideEvents EndCallback="function(s,e){GridViewDefaultUser_EndCallback(e);}" />

<ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}"></ClientSideEvents>

<SettingsEditing Mode="Inline"></SettingsEditing>

<SettingsText ConfirmDelete="آیا این آیتم را حذف می نمایید؟" 
                EmptyDataRow="هیچ آیتمی وجود ندارد." CommandEdit="ویرایش" CommandDelete="حذف" 
                CommandCancel="انصراف" CommandUpdate="ثبت"></SettingsText>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

             <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />

<Columns>
<dx:GridViewDataTextColumn FieldName="ID" ShowInCustomizationForm="True" 
        Width="20%" Caption="ID" VisibleIndex="0" Visible="false" ReadOnly="True">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PersonPost" ShowInCustomizationForm="True" 
        Width="20%" Caption="پست" VisibleIndex="1" ReadOnly="True">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="NameFamily" ShowInCustomizationForm="True" Caption="جانشین" 
       Width="20%" VisibleIndex="2">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="fromDate" 
        ShowInCustomizationForm="True" Caption="از تاریخ" 
       Width="20%" VisibleIndex="3">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn FieldName="toDate" 
        ShowInCustomizationForm="True" Caption="تا تاریخ" 
       Width="20%" VisibleIndex="4">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>     
   
    <dx:GridViewCommandColumn 
                                    ShowInCustomizationForm="True" VisibleIndex="10" Caption="حذف" 
                                    ButtonType="Image" Width="10%">
                                    <ClearFilterButton Visible="True">
                                    </ClearFilterButton>
                                    <CustomButtons>
                                        <dx:GridViewCommandColumnCustomButton ID="Delete" Text="حذف" 
                                            Visibility="AllDataRows" >
                                            <Image Url="~/img/remove.png">
                                            </Image>
                                        </dx:GridViewCommandColumnCustomButton>
                                    </CustomButtons>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewCommandColumn>
            
</Columns>

             <SettingsBehavior AllowFocusedRow="True" />

<SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

            <SettingsEditing Mode="Inline" />
 <SettingsText CommandEdit="ویرایش" EmptyDataRow="هیچ آیتمی وجود ندارد." 
                           CommandDelete="حذف" CommandCancel="انصراف" CommandUpdate="ثبت" 
                           ConfirmDelete="آیا این آیتم را حذف می نمایید؟" />

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
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
                                </DropDownEditDropDown>
                                <SpinEditIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
                                </SpinEditIncrement>
                                <SpinEditDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
                                </SpinEditDecrement>
                                <SpinEditLargeIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
                                </SpinEditLargeIncrement>
                                <SpinEditLargeDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
                                </SpinEditLargeDecrement>
                            </ImagesEditors>
                            <ImagesFilterControl>
                                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                </LoadingPanel>
                            </ImagesFilterControl>

<Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
<AlternatingRow Enabled="True"></AlternatingRow>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
</Styles>
                            <StylesEditors>
                                <CalendarHeader Spacing="1px">
                                </CalendarHeader>
                                <ProgressBar Height="25px">
                                </ProgressBar>
                            </StylesEditors>
</dx:ASPxGridView>
           
         <br />
    <table dir="rtl" width="100%" cellpadding="5" cellspacing="5">
    <tr>
    <td>
    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="80%" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
            GroupBoxCaptionOffsetY="-28px" HeaderText="تعریف مدیر جانشین" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
            <ContentPaddings Padding="14px" />
<ContentPaddings Padding="14px"></ContentPaddings>
        <PanelCollection>
        <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
        <table width="100%">

        <tr>
        <td width="60%" valign="middle">
            <dx:ASPxMenu ID="ASPxMenuHeader" runat="server" AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
             ClientInstanceName="MenuHeader" Enabled="False">
                <Items>
                    
                    
                    <dx:MenuItem Text="ثبت" Name="SaveMenuHeader_DefineInsteadMan">
                        <Image Url="~/img/save.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Name="Help_InsteadMan" Text="راهنما" Enabled="True">
                        <Image Url="~/img/help.gif">
                        </Image>
                    </dx:MenuItem>
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuClick(e);}" />
            </dx:ASPxMenu></td>
         <td width="40%" valign="middle">
             &nbsp;</td>
            
        </tr>
            <tr>
                <td valign="middle" width="60%">
                    <dx:ASPxRoundPanel ID="ASPxRoundPanelSearchPersonnel" runat="server" 
                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                        GroupBoxCaptionOffsetY="-28px" HeaderText="جستجوی پرسنل" RightToLeft="True" 
                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="95%">
                        <ContentPaddings Padding="14px" />
                        <PanelCollection>
                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                <table ID="tableSearch" dir="rtl" style="width: 100%">
                                    <tr>
                                        <td style="width: 20%" valign="top">
                                            عبارت جستجو
                                            <br />
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="txtSearch" type="text" style="width: 80%; font-family: tahoma; font-size: 9pt;" onkeypress="txtSearchEnterKeyPressDoingSearch(event);" />
                                            &nbsp;
                                            <img alt="" src="../img/search.png" height="16px" width="16px" class="ImageButtonStyle"
                                onclick="onClickSearchPersonnel();" id="btnSearchPersonnel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" valign="top">
                                            نتایج جستجو
                                        </td>
                                        <td align="right" valign="top">
                                            <dx:ASPxDropDownEdit ID="ASPxDropDownEditPersonnelSearch" runat="server" 
                                                ClientInstanceName="DropDownEditPersonnelSearch" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                PopupHorizontalAlign="RightSides" ShowShadow="False" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="95%">
                                                <DropDownWindowTemplate>
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelSearch" runat="server" 
                                                        AutoGenerateColumns="False" ClientInstanceName="GridViewPersonnelSearch" 
                                                        CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
                                                        KeyFieldName="BarCode" 
                                                        OnCustomCallback="ASPxGridViewPersonnelSearch_CustomCallback" 
                                                        Styles-Row-Cursor="pointer" Width="400px">
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {GridViewPersonnelSearch_onFocusedRowChanged(s,e);}" />
                                                        <ClientSideEvents RowClick="function(s,e){GridViewPersonnelSearch_onRowClick();}" />
                                                        <ClientSideEvents EndCallback="function(s,e){GridViewPersonnelSearch_EndCallback()}" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="کد پرسنلی" FieldName="BarCode" 
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
                                                <DropDownWindowStyle HorizontalAlign="Center" VerticalAlign="Top">
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
                                    </tr>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                </td>
                <td valign="middle" width="40%">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                پست :</td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBoxPostOfPerson" runat="server" 
                                    ClientInstanceName="ComboBoxPostOfPerson" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    LoadingPanelImagePosition="Top" RightToLeft="True" SelectedIndex="0" 
                                    ShowShadow="False" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                    ValueType="System.String" Width="90%">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="همه پست ها" Value="All" />
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
                        </tr>
                        <tr>
                            <td align="left">
                                از تاریخ :</td>
                            <td dir="rtl">
                                <cc1:JQDatePicker ID="JQDatePickerFromDate" runat="server" DateFormat="YMD" 
                                    IEDateFormat="YMD" Regional="fa"></cc1:JQDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                تا تاریخ :</td>
                            <td dir="rtl">
                                <cc1:JQDatePicker ID="JQDatePickerToDate" runat="server" DateFormat="YMD" 
                                    IEDateFormat="YMD" Regional="fa"></cc1:JQDatePicker>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="40%">
                    &nbsp;</td>
                <td width="40%">
                    &nbsp;</td>
                <td width="20%">
                    &nbsp;</td>
            </tr>
        </table>
            </dx:PanelContent>
        </PanelCollection>
        </dx:ASPxRoundPanel>
        </td>
        </tr>
        </table>
    </div>
       <div id="divImgLoading" 
            
        style="visibility: hidden; width: 150px; font-weight: bold; " 
        dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
    <dx:ASPxCallback ID="ASPxCallbackUpdateInsteadMan" 
        ClientInstanceName="CallbackUpdateInsteadMan" runat="server" 
        oncallback="ASPxCallbackUpdateInsteadMan_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){CallbackUpdateInsteadMan_onCallbackComplete(e)}" />
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallbackDeleteInsteadMan" runat="server" 
        ClientInstanceName="CallbackDeleteInsteadMan" 
        oncallback="ASPxCallbackDeleteInsteadMan_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CallbackDeleteInsteadMan_CallbackComplete(e);}" />
    </dx:ASPxCallback>
    </form>
</body>
</html>

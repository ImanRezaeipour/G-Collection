<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ASPWebclock.Report.Report" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx1" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>
<%@ Register assembly="JQControls" namespace="JQControls" tagprefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>گزارشات</title>
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/Report_onOperations.js" type="text/javascript"></script>
    <link href="../css/treeStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="ReportForm" runat="server">
     <cc1:JQLoader ID="JQLoader1" runat="server">
                                
    </cc1:JQLoader>
    <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right">
     
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="90%" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
            CssPostfix="Aqua" GroupBoxCaptionOffsetY="-28px" HeaderText="فیلتر گزارش" RightToLeft="True"
            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
            <ContentPaddings Padding="14px" />
            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
                    <table width="100%" align="center" dir="rtl">
                        <tr>
                            <td width="50%" colspan="2" style="width: 100%">
                                <table dir="rtl" width="100%" align="center" style="margin-bottom: 10px">
                                <tr>
                                <td align="left" width="15%">
                                    نام گزارش :</td>
                                <td id="tdReportName" align="right" width="25%" dir="rtl">
                                    <dx:ASPxComboBox ID="ASPxComboBoxReportName" runat="server" 
                                        ClientInstanceName="ComboBoxReportName" 
                                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                        LoadingPanelImagePosition="Top" ShowShadow="False" 
                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                        Width="180px" RightToLeft="True">
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
                                        <ClientSideEvents SelectedIndexChanged="ComboBoxReportName_onChanged" />
                                    </dx:ASPxComboBox>
                                    </td>
                                <td align="left" width="15%">
                                    نوع جستجو :</td>
                                <td align="right" dir="rtl">
                                    <dx:ASPxComboBox ID="ASPxComboBoxTypePersonnel" runat="server" 
                                        ClientInstanceName="ComboBoxTypePersonnel" 
                                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                        LoadingPanelImagePosition="Top" ShowShadow="False" 
                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                        Width="90px" SelectedIndex="0">
                                        <ClientSideEvents SelectedIndexChanged="ComboBoxTypePersonnel_onChanged" />
                                        <Items>
                                            <dx:ListEditItem Text="بخش ها" Value="Part" Selected="True" />
                                            <dx:ListEditItem Text="پرسنل" Value="Person" />
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
                                <td width="15%" align="left" dir="rtl">
                                    محاسبه شود :</td>
                                    <td align="right">
                                        <dx:ASPxComboBox ID="ASPxComboBoxCalculate" runat="server" 
                                            ClientInstanceName="ComboBoxCalculate" 
                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                            LoadingPanelImagePosition="Top" SelectedIndex="0" ShowShadow="False" 
                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                            Width="60px">
                                            <ClientSideEvents SelectedIndexChanged="ComboBoxTypePersonnel_onChanged" />
                                            <Items>
                                                <dx:ListEditItem Selected="True" Text="خیر" Value="false" />
                                                <dx:ListEditItem Text="بلی" Value="true" />
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
                                    <td align="right" width="37%">
                                        <div ID="DivButtonViewReport" style="margin-right: 10px">
                                            <dx:ASPxButton ID="ASPxButtonViewReport" runat="server" AutoPostBack="False" 
                                                ClientInstanceName="ButtonViewReport" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="نمایش" Width="80px">
                                                <ClientSideEvents Click="function(s,e){ ButtonViewReport_onClick(s,e);}" />
                                            </dx:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                                </table></td>
                        </tr>
                        <tr>
                            <td align="center" dir="rtl" valign="top" width="50%">
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelParts" runat="server" Width="450px" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                    CssPostfix="Aqua" GroupBoxCaptionOffsetY="-28px" HeaderText="انتخاب پرسنل" RightToLeft="True"
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                    ClientInstanceName="PanelParts">
                                    <ContentPaddings Padding="14px" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent2" runat="server" SupportsDisabledAttribute="True">
                                            <div align="left" style="margin: 5px">
                                            <dx:ASPxCheckBox ID="ASPxCheckBoxSubParts" runat="server" 
                                            CheckState="Unchecked" ClientInstanceName="CheckBoxSubParts" 
                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="زیر بخش ها" 
                                            TextSpacing="2px">
                                        </dx:ASPxCheckBox>
                                                <dx:ASPxCheckBox ID="ASPxCheckBoxSelectAllPersonnel" runat="server" 
                                                    CheckState="Unchecked" ClientInstanceName="CheckBoxSelectAllPersonnel" 
                                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="انتخاب همه" 
                                                    TextSpacing="2px" ClientVisible="False">
                                                    <ClientSideEvents CheckedChanged="function(s,e){CheckBoxSelectAllPersonnel_onChanged(s,e);}" />
                                                </dx:ASPxCheckBox>
                                            </div>
                                            <div id="divContentTreeViewParts" onscroll="divContentTreeViewParts_onScroll();"  style="overflow: scroll;">
                                           
                                                
                                                <dx:ASPxTreeView ID="ASPxTreeViewParts"  runat="server" Width="99%" ClientInstanceName="TreeViewParts" 
                                                    Height="300px" RightToLeft="True" AllowCheckNodes="True">
                                                  <ClientSideEvents NodeClick="TreeViewParts_onClick" />
                                                  <ClientSideEvents ExpandedChanged="TreeViewParts_onExpandedChanged" />
                                                    <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                        <NodeLoadingPanel Url="~/App_Themes/Aqua/Web/tvNodeLoading.gif">
                                                        </NodeLoadingPanel>
                                                        <LoadingPanel Url="~/App_Themes/Aqua/Web/Loading.gif">
                                                        </LoadingPanel>
                                                    </Images>
                                                    <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                                                    </Styles>
                                                </dx:ASPxTreeView>
                                           
                                            </div>
                                            <dx:ASPxGridView ID="ASPxGridViewPersonnels" runat="server" AutoGenerateColumns="False"
                                                Width="95%" ClientInstanceName="GridViewPersonnels" KeyFieldName="Barcode" OnCustomCallback="ASPxGridViewPersonnels_CustomCallback"
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                OnProcessColumnAutoFilter="ASPxGridViewPersonnels_ProcessColumnAutoFilter" 
                                                ClientVisible="False">
                                                <SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True"></SettingsBehavior>
                                                <Settings ShowFilterRow="True" />
                                                <ClientSideEvents FocusedRowChanged="function(s, e){onClickRowGridViewPersonnels()}" />
                                                <ClientSideEvents EndCallback="function(s,e){GridViewPersonnels_EndCallback(s,e);}" />
                                                <Columns>
                                                    <dx:GridViewDataTextColumn Caption="ID" ReadOnly="True" ShowInCustomizationForm="True"
                                                        VisibleIndex="1" Width="1%" FieldName="ID" Visible="False">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <CellStyle HorizontalAlign="Center">
                                                        </CellStyle>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="شماره پرسنلی" ReadOnly="True" ShowInCustomizationForm="True"
                                                        VisibleIndex="2" Width="25%" FieldName="Barcode" Visible="True">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <CellStyle HorizontalAlign="Center">
                                                        </CellStyle>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="نام" ReadOnly="True" ShowInCustomizationForm="True"
                                                        VisibleIndex="3" Width="25%" FieldName="Name">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <CellStyle HorizontalAlign="Center">
                                                        </CellStyle>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="نام خانوادگی" ReadOnly="True" ShowInCustomizationForm="True"
                                                        VisibleIndex="4" Width="25%" FieldName="Family">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <CellStyle HorizontalAlign="Center">
                                                        </CellStyle>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewCommandColumn Caption="انتخاب" ShowSelectCheckbox="True" 
        VisibleIndex="0" Width="10%">
        <ClearFilterButton Visible="True">
        </ClearFilterButton>
        <HeaderStyle HorizontalAlign="Center" />
    </dx:GridViewCommandColumn>
                                                </Columns>
                                                <SettingsPager>
                                                    <Summary Text="صفحه {0} از {1}" />
                                                </SettingsPager>
                                                <SettingsLoadingPanel ImagePosition="Top" />
                                                <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                    <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                                                    </LoadingPanelOnStatusBar>
                                                    <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                                                    </LoadingPanel>
                                                </Images>
                                                <ImagesEditors>
                                                    <DropDownEditDropDown>
                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
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
                                                <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                                                    <AlternatingRow Enabled="True">
                                                    </AlternatingRow>
                                                    <Header Font-Bold="False">
                                                    </Header>
                                                    <LoadingPanel ImageSpacing="8px">
                                                    </LoadingPanel>
                                                    <TitlePanel Font-Bold="True">
                                                    </TitlePanel>
                                                </Styles>
                                                <StylesEditors>
                                                    <CalendarHeader Spacing="1px">
                                                    </CalendarHeader>
                                                    <ProgressBar Height="25px">
                                                    </ProgressBar>
                                                </StylesEditors>
                                               
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                            </td>
                            <td valign="top" width="50%" align="center">
                                

                               
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelDateRange" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="تاریخ" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelDateRange" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent3" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="tblDateRange" width="100%">
                                        <tr>
                                        <td align="left">
                                        
                                            ماه :</td>
                                        <td align="right">
                                            <dx:ASPxComboBox ID="ASPxComboBoxMonth" runat="server" 
                                                ClientInstanceName="ComboBoxMonth" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                LoadingPanelImagePosition="Top" RightToLeft="True" ShowShadow="False" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                                Width="100px">
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
                                        
                                            سال :</td>
                                        <td align="right">
                                            <dx:ASPxComboBox ID="ASPxComboBoxYear" runat="server" 
                                                ClientInstanceName="ComboBoxYear" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                LoadingPanelImagePosition="Top" RightToLeft="True" ShowShadow="False" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
                                                Width="100px">
                                                <Items>
                                                    <dx:ListEditItem Text="1390" Value="1390" />
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
                                        </tr>
                                        </table>
                                        </div>
                                        
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                    
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelFromToDate" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="تاریخ" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelFromToDate" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent4" runat="server" SupportsDisabledAttribute="True">
                                        
                                        <div>
                                        <table id="Table2" width="100%" >
                                        <tr>
                                        <td align="left">
                                        
                                            از تاریخ :</td>
                                        <td align="right">
                                       <cc1:JQDatePicker ID="JQDatePickerFromDate"  runat="server"  Regional="fa" IEDateFormat="YMD" DateFormat="YMD">
                                            </cc1:JQDatePicker>
                                        </td>
                                        </tr>
                                        <tr>
                                        <td align="left">
                                        
                                            تا تاریخ :</td>
                                        <td align="right">
                                            <cc1:JQDatePicker ID="JQDatePickerToDate" runat="server"  Regional="fa" IEDateFormat="YMD" DateFormat="YMD">
                                            </cc1:JQDatePicker>
                                        </td>
                                        </tr>
                                        </table>
                                        </div>
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelDate" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="تاریخ" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelDate" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent5" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="Table6" width="100%">
                                        <tr>
                                        <td align="left">
                                        
                                        تاریخ :</td>
                                        <td align="right">
                                            <cc1:JQDatePicker ID="JQDatePickerDate" runat="server"  Regional="fa" IEDateFormat="YMD" DateFormat="YMD">
                                            </cc1:JQDatePicker>
                                        </td>
                                        </tr>
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelFromToTime" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="زمان" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelFromToTime" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent6" runat="server" SupportsDisabledAttribute="True">
                                        
                                        <div>
                                        <table id="tblFromToTime" width="100%">
                                        <tr>
                                        <td align="left">
                                        
                                            از ساعت :</td>
                                        <td align="right">
                                            <dx:ASPxTimeEdit ID="ASPxTimeEditFromTime" runat="server" ClientInstanceName="TimeEditFromTime" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" EditFormat="Custom" EditFormatString="HH:mm" RightToLeft="True"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="60px">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                        </tr>
                                        <tr>
                                        <td align="left">
                                        
                                            تا ساعت :</td>
                                        <td align="right">
                                              <dx:ASPxTimeEdit ID="ASPxTimeEditToTime" runat="server" ClientInstanceName="TimeEditToTime" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                                                        CssPostfix="Aqua" EditFormat="Custom" EditFormatString="HH:mm" RightToLeft="True"
                                                                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="60px">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                        </tr>
                                        </table>
                                        </div>
                                       
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelTimeRange" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="زمان" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelTimeRange" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent7" runat="server" SupportsDisabledAttribute="True">
                                        
                                        
                                       <div>
                                        <table id="Table3" width="100%">
                                        <tr>
                                        <td align="left">
                                        
                                           مساوی و  بیشتر از :</td>
                                        <td align="right" style="vertical-align: middle" >
                                            <div style="float: right">
                                            <dx:ASPxTextBox ID="ASPxTextBoxTimeStartHour" runat="server" 
                                                ClientInstanceName="TextBoxTimeStartHour" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox></div>H
                                        </td>
                                            <td align="right">
                                                   <div style="float: right">
                                                <dx:ASPxTextBox ID="ASPxTextBoxTimeStartMinute" runat="server" 
                                                ClientInstanceName="TextBoxTimeStartMinute" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox></div>M</td>
                                        </tr>
                                        <tr>
                                        <td align="left">
                                        
                                           مساوی و کمتر از :</td>
                                        <td align="right">
                                               <div style="float: right">
                                              <dx:ASPxTextBox ID="ASPxTextBoxTimeEndHour" runat="server" 
                                                  ClientInstanceName="TextBoxTimeEndHour" 
                                                  CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                  SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                  <ValidationSettings>
                                                      <ErrorFrameStyle ImageSpacing="4px">
                                                          <ErrorTextPaddings PaddingLeft="4px" />
                                                      </ErrorFrameStyle>
                                                  </ValidationSettings>
                                              </dx:ASPxTextBox></div> H
                                        </td>
                                            <td align="right">
                                                   <div style="float: right">
                                               <dx:ASPxTextBox ID="ASPxTextBoxTimeEndMinute" runat="server" 
                                                  ClientInstanceName="TextBoxTimeEndMinute" 
                                                  CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                  SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                  <ValidationSettings>
                                                      <ErrorFrameStyle ImageSpacing="4px">
                                                          <ErrorTextPaddings PaddingLeft="4px" />
                                                      </ErrorFrameStyle>
                                                  </ValidationSettings>
                                              </dx:ASPxTextBox></div> M</td>
                                        </tr>
                                        </table>
                                        </div>
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelDayRange" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="روز" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelDayRange" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent13" runat="server" SupportsDisabledAttribute="True">
                                        
                                        
                                       <div>
                                        <table id="Table7" width="100%">
                                        <tr>
                                        <td align="left">
                                        
                                           مساوی و بیشتر از :</td>
                                        <td align="center">
                                            <dx:ASPxTextBox ID="ASPxTextBoxDayStart" runat="server" 
                                                ClientInstanceName="TextBoxDayStart" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                            <td align="right">
                                                روز</td>
                                        </tr>
                                        <tr>
                                        <td align="left">
                                        
                                           مساوی و  کمتر از :</td>
                                        <td align="center">
                                              <dx:ASPxTextBox ID="ASPxTextBoxDayEnd" runat="server" 
                                                  ClientInstanceName="TextBoxDayEnd" 
                                                  CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                  SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="40px">
                                                  <ValidationSettings>
                                                      <ErrorFrameStyle ImageSpacing="4px">
                                                          <ErrorTextPaddings PaddingLeft="4px" />
                                                      </ErrorFrameStyle>
                                                  </ValidationSettings>
                                              </dx:ASPxTextBox>
                                        </td>
                                            <td align="right">
                                                روز</td>
                                        </tr>
                                        </table>
                                        </div>
                                        
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelPishcardDaily" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="درخواست روزانه" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelPishcardDaily" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent8" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="tblPishcard" width="100%">
                                        <tr>
                                       <td>
                                       عنوان :
                                       </td>
                                       <td>
                                           <dx:ASPxComboBox ID="ASPxComboBoxPishcardDaily" 
                                               ClientInstanceName="ComboBoxPishcardDaily" runat="server" RightToLeft="True" 
                                                
                                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                               <ClientSideEvents CallbackError="function(s,e){ComboBoxPishcard_ErrorCallback(e);}" />
                                               <ClientSideEvents EndCallback="function(s,e){ComboBoxPishcard_EndCallback(e);}" />
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
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelPishcardHourly" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="درخواست ساعتی" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelPishcardHourly" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent9" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="Table4" width="100%">
                                        <tr>
                                       <td>
                                       عنوان :
                                       </td>
                                       <td>
                                           <dx:ASPxComboBox ID="ASPxComboBoxPishcardHourly" 
                                               ClientInstanceName="ComboBoxPishcardHourly" runat="server" RightToLeft="True" 
                                                
                                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                               <ClientSideEvents CallbackError="function(s,e){ComboBoxPishcard_ErrorCallback(e);}" />
                                               <ClientSideEvents EndCallback="function(s,e){ComboBoxPishcard_EndCallback(e);}" />
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
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelEmploymentType" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText=" استخدام" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelEmploymentType" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent10" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="Table1" width="100%">
                                        <tr>
                                       <td>
                                       عنوان :
                                       </td>
                                       <td>
                                           <dx:ASPxComboBox ID="ASPxComboBoxEmploymentType" 
                                               ClientInstanceName="ComboBoxEmploymentType" runat="server" RightToLeft="True" 
                                                
                                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                              
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
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelTerminal" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="ترمینال" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelTerminal" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent11" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="tblTerminal" width="100%" >
                                        <tr>
                                       <td>
                                       نام ترمینال :
                                       </td>
                                       <td>
                                           <dx:ASPxComboBox ID="ASPxComboBoxTerminal" 
                                               ClientInstanceName="ComboBoxTerminal" runat="server" RightToLeft="True" 
                                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
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
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                <dx:ASPxRoundPanel ID="ASPxRoundPanelStation" runat="server" 
                                    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                    GroupBoxCaptionOffsetY="-28px" HeaderText="ایستگاه" RightToLeft="True" 
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Width="80%" 
                                    ClientInstanceName="RoundPanelStation" ClientVisible="False">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent12" runat="server" SupportsDisabledAttribute="True">
                                        <div>
                                        <table id="Table5" width="100%" >
                                        <tr>
                                       <td>
                                       نام ایستگاه :
                                       </td>
                                       <td>
                                           <dx:ASPxComboBox ID="ASPxComboBoxStation" 
                                               ClientInstanceName="ComboBoxStation" runat="server" RightToLeft="True" 
                                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
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
                                        </table>
                                        </div>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                                
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
        <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
    <asp:HiddenField ID="hfScrollPosition" runat="server" Value="0" />
    <dx:ASPxCallback ID="ASPxCallbackReportView" runat="server" 
        ClientInstanceName="CallbackReportView" 
        oncallback="ASPxCallbackReportView_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){CallbackReportView_endCallback(s,e);}" />
        <ClientSideEvents CallbackError="function(s,e){CallbackReportView_errorCallback(e);}" />
    </dx:ASPxCallback>
    
    <dx:ASPxCallback ID="ASPxCallbackSetParameterVisible" runat="server" 
        ClientInstanceName="CallbackSetParameterVisible" 
        oncallback="ASPxCallbackSetParameterVisible_Callback">
        <ClientSideEvents CallbackComplete ="function(s,e){CallbackSetParameterVisible_CallbackComplete(e);}" />
        <ClientSideEvents EndCallback="function(s,e){CallbackSetParameterVisible_EndCallback(s, e);}" />
        <ClientSideEvents CallbackError="function(s,e){CallbackSetParameterVisible_CallbackError(e);}" />
    </dx:ASPxCallback>
    
    </form>
</body>
</html>


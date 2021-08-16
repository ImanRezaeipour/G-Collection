<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrafficRequestOperator.aspx.cs" Inherits="ASPWebclock.Operator.TrafficRequestOperator" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>


<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCloudControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
     <%@ Register Assembly="JQControls" Namespace="JQControls" TagPrefix="cc1" %>  

<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx1" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dx2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
       <link href="../css/buttonStyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/TrafficRequestOperator_Operations.js" type="text/javascript"></script>
 
</head>
<body>
    <form id="TrafficRequestOperatorForm" runat="server" >
      <cc1:JQLoader ID="JQLoader1" runat="server" Theme="Start">
        </cc1:JQLoader>
         <div id="divMain" dir="rtl" style="width:100%">
         <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_TrafficRequestOperator" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_TrafficRequestOperator">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_TrafficRequestOperator" 
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
</dx:ASPxMenu></div>
   <dx:ASPxPageControl ID="ASPxPageControlRequestDaily" runat="server" Width="800px"
                    ActiveTabIndex="0" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                    TabSpacing="3px" ClientInstanceName="PageControlRequestDaily" 
                 RightToLeft="True">
                    <TabPages>
                        <dx:TabPage  Text="روزانه" >
                            <ContentCollection>
                                <dx:ContentControl runat="server" ID="contetnRequestDaily">
                             <asp:Panel runat="server"  ID="panelDaily">
                           
    
    <br />
    
    
    <div id="divSearchPersonnelDaily" dir="rtl" style="width:100%;" align="center">
    
        <dx:ASPxRoundPanel ID="ASPxRoundPanelGridViewPersonnelDaily" runat="server" Width="90%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContentSearchPersonnelDaily" runat="server" SupportsDisabledAttribute="True">
 <table style="width: 100%">
 <tr>
 <td align="left">
     جستجوی پرسنل</td>
     <td align="right">
         <dx:ASPxDropDownEdit ID="ASPxDropDownEditPersonnelDaily" 
                                                
             ClientInstanceName="DropDownPersonnelDaily" runat="server" 
                                                Text="انتخاب پرسنل" PopupHorizontalAlign="RightSides" 
                                                
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowShadow="False" 
             Width="200px">
                                                <DropDownWindowTemplate>
                                                
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelDaily" ClientInstanceName="GridViewPersonnelDaily" runat="server" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" KeyFieldName="Barcode" Width="400px" Styles-Row-Cursor="pointer">
                                                        <ClientSideEvents EndCallback="GridViewPersonnelDaily_EndCallback" />
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                                                        if(s.GetFocusedRowIndex()>-1)
                                                        {
var row = s.GetRow(s.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML+ ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
DropDownPersonnelDaily.SetText(cellValue);
   s.GetFocusedRowIndex()
   
   }
   else
   {
   
   }
   
}" />
<ClientSideEvents RowClick="function(s,e){DropDownPersonnelDaily.HideDropDown();}" />
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
                                            </dx:ASPxDropDownEdit></td>
     <td align="center">
         تاریخ</td>
     <td align="left">
         سال</td>
     <td align="right">
         <dx:ASPxComboBox ID="ASPxComboBoxYearDaily" runat="server" ValueType="System.String" 
             Width="60px" ClientInstanceName="ComboBoxYearDaily" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
             <Items>
                 <dx:ListEditItem Text="1389" Value="1389" />
                 <dx:ListEditItem Text="1390" Value="1390" />
                 <dx:ListEditItem Text="1391" Value="1391" />
                 <dx:ListEditItem Text="1392" Value="1392" />
                 <dx:ListEditItem Text="1393" Value="1393" />
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
     <td align="left">
         ماه</td>
     <td align="right">
     <dx:ASPxComboBox ID="ASPxComboBoxMonthDaily" runat="server" 
             ValueType="System.String" Width="80px" ClientInstanceName="ComboBoxMonthDaily" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
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
     <td>
         <input id="ButtonShowResultDaily" type="button" onclick="btnShowResultSearchDaily_onClick()"  
             value="نمایش" style="font-family: tahoma; font-size: 9pt; background-color: #FFFFFF;" />
     </td>
 </tr>
     <tr>
         <td colspan="8">
             
             <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewRequestDaily" KeyFieldName="ID" 
                AutoGenerateColumns="False" RightToLeft="True" Width="100%"  
                ID="ASPxGridViewRequestDaily" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                            CssPostfix="Aqua" 
                 OnCustomCallback="ASPxGridViewRequestDaily_CustomCallback">
<%--<ClientSideEvents FocusedRowChanged="function(s, e){onClickRowASPxGridViewViewUserOfPerson()}"></ClientSideEvents>--%>
<Columns>
<dx:GridViewDataTextColumn FieldName="ID" ShowInCustomizationForm="True" 
        Width="0px" Visible="False" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Times" ShowInCustomizationForm="True" 
        Width="0px" Visible="False" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishID" ShowInCustomizationForm="True" 
        Width="0px" Visible="False" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Reader" ShowInCustomizationForm="True" 
        Width="0px" Visible="False" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Barcode" ShowInCustomizationForm="True" 
        Width="0px" Visible="False" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Day" ShowInCustomizationForm="True" 
        Width="11%" Caption="روز" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Dates" ShowInCustomizationForm="True" 
        Width="11%" Caption="تاریخ" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishName" ShowInCustomizationForm="True" 
        Width="23%" Caption="نوع رکورد" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Change" ShowInCustomizationForm="True" 
        Width="11%" Caption="تغییر" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Station" ShowInCustomizationForm="True" 
        Width="11%" Caption="دستگاه" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Operator" ShowInCustomizationForm="True" 
        Width="11%" Caption="اپراتور" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn  ShowInCustomizationForm="True" 
        Width="11%" Caption="شماره برگه" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

<SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد"></SettingsText>

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
</dx:ASPxGridView></td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
    </div>
    <br />
    <br />
    <div id="divHeaderMenuDaily" dir="rtl" style="width:100%">
    <dx:ASPxMenu ID="ASPxMenuHeaderDaily_TrafficRequestOperator" runat="server" 
            AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" 
            Font-Size="8pt" ClientInstanceName="MenuHeaderDaily">
                <Items>
                    <dx:MenuItem Text="جدید"   Name="AddMenuHeaderDaily_TrafficRequestOperator" Enabled="false">
                        <Image Url="~/img/add.png">
                        </Image>
                    </dx:MenuItem>
                    
                    <dx:MenuItem Text="ویرایش" Name="EditMenuHeaderDaily_TrafficRequestOperator" Enabled="false">
                        <Image Url="~/img/edit.png">
                        </Image>
                    </dx:MenuItem>
                    
                    <dx:MenuItem Text="ثبت" Name="SaveMenuHeaderDaily_TrafficRequestOperator" >
                        <Image Url="~/img/save.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="انصراف" Name="CancelMenuHeaderDaily_TrafficRequestOperator" >
                        <Image Url="~/img/cancel.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="حذف" Name="DeleteMenuHeaderDaily_TrafficRequestOperator" Enabled="false">
                        <Image Url="~/img/remove.png">
                        </Image>
                    </dx:MenuItem>
            
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderDailyClick(e);}" />
            </dx:ASPxMenu>
       
    </div>
    <br />
    <div id="divRegistRequestDaily" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel ID="ASPxRoundPanelSearchDaily" runat="server" Width="80%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ClientInstanceName="PanelSearchDaily">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox ID="ASPxComboBoxTrafficTypeDaily" runat="server" 
             ValueType="System.String" ClientInstanceName="ComboBoxTrafficTypeDaily" 
             CallbackPageSize="500" DropDownRows="10" RightToLeft="True">
         </dx:ASPxComboBox>
     </td>
     <td align="left">
         از تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker ID="FromDateDaily" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"
                                                Width="90px" ></cc1:JQDatePicker></td>
     <td align="left">
         تا تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker ID="ToDateDaily" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"
                                                Width="90px"></cc1:JQDatePicker></td>
 </tr>
     <tr>
         <td align="left">
             شماره برگه</td>
         <td align="right">
             <dx:ASPxTextBox ID="ASPxTextBoxFormNoDaily" runat="server" Width="170px" 
                 ClientInstanceName="TextBoxFormNoDaily">
             </dx:ASPxTextBox>
         </td>
         <td align="left">
             توضیحات</td>
         <td colspan="3" align="right">
             <dx:ASPxTextBox ID="ASPxTextBoxCommentDaily" runat="server" Width="95%" 
                 ClientInstanceName="TextBoxCommentDaily">
             </dx:ASPxTextBox>
         </td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
   
    </div>
      </asp:Panel>
      
   </dx:ContentControl>
                                </ContentCollection>
                                </dx:TabPage>
<dx:TabPage Text="ساعتی (مجوز دار)"><ContentCollection>
<dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                             <asp:Panel runat="server" ID="panelHourly">
         
    <br />
    <div id="div3" dir="rtl" style="width:100%;" align="center">
        <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="95%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelTrafficHourlyPermit" 
            ClientInstanceName="PanelTrafficHourlyPermit">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent ID="PanelContent2" runat="server" SupportsDisabledAttribute="True">
 <table style="width: 100%">
 <tr>
 <td align="left">
     جستجوی پرسنل</td>
     <td align="right">
         <dx:ASPxDropDownEdit ID="ASPxDropDownEditPersonnelHourlyPermit" 
                                                
             ClientInstanceName="DropDownPersonnelHourlyPermit" runat="server" 
                                                Text="انتخاب پرسنل" PopupHorizontalAlign="RightSides" 
                                                
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowShadow="False" 
             Width="200px">
                                                <DropDownWindowTemplate>
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelHourlyPermit" runat="server" ClientInstanceName="GridViewPersonnelHourlyPermit" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" KeyFieldName="Barcode" Width="400px" Styles-Row-Cursor="pointer">
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                                                        if(s.GetFocusedRowIndex()>-1)
                                                        {
var row = s.GetRow(s.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML+ ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
DropDownPersonnelHourlyPermit.SetText(cellValue);
   s.GetFocusedRowIndex();
   
   }
   else
   {
   
   }
   
}" />
<ClientSideEvents RowClick="function(s,e){DropDownPersonnelHourlyPermit.HideDropDown();}" />
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
                                            </dx:ASPxDropDownEdit></td>
     <td align="left">
         تاریخ</td>
     <td align="left">
         سال</td>
     <td align="right">
         <dx:ASPxComboBox ID="ASPxComboBoxYearHourlyPermit" runat="server" 
             ClientInstanceName="ComboBoxYearHourlyPermit" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
             Width="60px">
             <Items>
                 <dx:ListEditItem Text="1389" Value="1389" />
                 <dx:ListEditItem Text="1390" Value="1390" />
                 <dx:ListEditItem Text="1391" Value="1391" />
                 <dx:ListEditItem Text="1392" Value="1392" />
                 <dx:ListEditItem Text="1393" Value="1393" />
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
     <td align="left">
         ماه</td>
     <td align="right">
     <dx:ASPxComboBox ID="ASPxComboBoxMonthHourlyPermit" runat="server" 
             ClientInstanceName="ComboBoxMonthHourlyPermit" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
             Width="80px">
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
     <td>
         <input id="ButtonShowResultHourlyPermit" type="button"  onclick="btnShowResultSearchHourlyPermit_onClick()"
             value="نمایش" style="font-family: tahoma; font-size: 9pt; background-color: #FFFFFF;" />
     </td>
 </tr>
     <tr>
         <td colspan="8">
             
             <dx:ASPxGridView runat="server" ClientInstanceName="GridViewRequestHourlyPermit" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                 AutoGenerateColumns="False" RightToLeft="True" Width="100%" KeyFieldName="ID"
                 ID="ASPxGridViewRequestHourlyPermit" 
                 OnCustomCallback="ASPxGridViewRequestHourly_CustomCallback"><Columns>
<dx:GridViewDataTextColumn FieldName="ID" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishID" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Barcode" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>

<dx:GridViewDataTextColumn FieldName="Day" ShowInCustomizationForm="True" Width="11%" Caption="روز" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Dates" ShowInCustomizationForm="True" Width="11%" 
                         Caption="تاریخ" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="FromTime" ShowInCustomizationForm="True" Width="11%" 
                         Caption="از ساعت" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="ToTime" ShowInCustomizationForm="True" Width="11%" 
                         Caption="تا ساعت" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishName" ShowInCustomizationForm="True" Width="23%" 
                         Caption="نوع رکورد" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Operator" ShowInCustomizationForm="True" Width="11%" 
                         Caption="اپراتور" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn  ShowInCustomizationForm="True" Width="11%" 
                         Caption="شماره برگه" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

<SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد"></SettingsText>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

<Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
<LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif"></LoadingPanelOnStatusBar>

<LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif"></LoadingPanel>
</Images>

<ImagesEditors>
<DropDownEditDropDown>
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
        PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
</DropDownEditDropDown>

<SpinEditIncrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
</SpinEditIncrement>

<SpinEditDecrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
</SpinEditDecrement>

<SpinEditLargeIncrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
</SpinEditLargeIncrement>

<SpinEditLargeDecrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
</SpinEditLargeDecrement>
</ImagesEditors>

<ImagesFilterControl>
<LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif"></LoadingPanel>
</ImagesFilterControl>

<Styles CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css">
<AlternatingRow Enabled="True"></AlternatingRow>

<LoadingPanel ImageSpacing="8px"></LoadingPanel>
</Styles>

<StylesEditors>
<CalendarHeader Spacing="1px"></CalendarHeader>

<ProgressBar Height="25px"></ProgressBar>
</StylesEditors>
</dx:ASPxGridView>
</td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

    </div>
    <br />
    <br />
    <div id="divHeaderMenuHourly" dir="rtl" style="width:100%">
    <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeaderHourlyPermit" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeaderHourlyPermit_TrafficRequestOperator">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderHourlyPermitClick(e);}"></ClientSideEvents>
<Items>
<dx:MenuItem Name="AddMenuHeaderHourlyPermit_TrafficRequestOperator" Text="جدید" Enabled="false">
<Image Url="~/img/add.png"></Image>
</dx:MenuItem>
    <dx:MenuItem Name="EditMenuHeaderHourlyPermit_TrafficRequestOperator" Text="ویرایش" Enabled="false">
        <Image Url="~/img/edit.png">
        </Image>
    </dx:MenuItem>
<dx:MenuItem Name="SaveMenuHeaderHourlyPermit_TrafficRequestOperator" Text="ثبت">
<Image Url="~/img/save.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="CancelMenuHeaderHourlyPermit_TrafficRequestOperator" Text="انصراف">
<Image Url="~/img/cancel.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="DeleteMenuHeaderHourlyPermit_TrafficRequestOperator" Text="حذف" Enabled="false">
<Image Url="~/img/remove.png"></Image>
</dx:MenuItem>
     
</Items>

<LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif"></LoadingPanelImage>

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

<ItemStyle DropDownButtonSpacing="12px" ToolbarDropDownButtonSpacing="5px" 
            ToolbarPopOutImageSpacing="5px" PopOutImageSpacing="18px" Cursor="pointer" 
            VerticalAlign="Middle"></ItemStyle>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
</dx:ASPxMenu>

       
    </div>
    <br />
    <div id="div2" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="90%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelSearchHourlyPremit" 
            ClientInstanceName="PanelSearchHourly">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox runat="server" ValueType="System.String" 
             ID="ASPxComboBoxTrafficTypeHourlyPermit" 
             ClientInstanceName="ComboBoxTrafficTypeHourlyPermit">
</dx:ASPxComboBox>

     </td>
     <td align="left">
         تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker runat="server" Regional="fa" DateFormat="YMD" 
             IEDateFormat="YMD" Width="90px" ID="DateHourlyPermit" CurrentText=""></cc1:JQDatePicker>
</td>
     <td align="left">
         از ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditFromHourHourlyPermit" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditFromHourHourlyPermit">
         </dx:ASPxTimeEdit>
</td>
     <td align="right">
         تا ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditToHourHourlyPermit" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditToHourHourlyPermit">
         </dx:ASPxTimeEdit>
     </td>
 </tr>
     <tr>
         <td align="left">
             شماره برگه</td>
         <td align="right">
             <dx:ASPxTextBox runat="server" Width="170px" 
                 ID="ASPxTextBoxFormNoHourlyPermit" ClientInstanceName="TextBoxFormNoHourlyPermit">
</dx:ASPxTextBox>

         </td>
         <td align="left">
             توضیحات</td>
         <td colspan="5" align="right">
             <dx:ASPxTextBox runat="server" Width="95%" 
                 ID="ASPxTextBoxCommentHourlyPermit" ClientInstanceName="TextBoxCommentHourlyPermit">
</dx:ASPxTextBox>

         </td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

   
    </div>
  
    
      </asp:Panel>

                             </dx:ContentControl>
</ContentCollection>
</dx:TabPage>
<dx:TabPage Text="ساعتی (تردد)"><ContentCollection>
<dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                             <asp:Panel runat="server" ID="panel1">
         
    <br />
    <div id="div1" dir="rtl" style="width:100%;" align="center">
        <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="95%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelSearchHourlyTraffic0" 
            ClientInstanceName="PanelSearchHourlyTraffic">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent ID="PanelContent3" runat="server" SupportsDisabledAttribute="True">
 <table style="width: 100%">
 <tr>
 <td align="left">
     جستجوی پرسنل</td>
     <td align="right">
         <dx:ASPxDropDownEdit ID="ASPxDropDownPersonnelHourlyTraffic" 
                                                
             ClientInstanceName="DropDownPersonnelHourlyTraffic" runat="server" 
                                                Text="انتخاب پرسنل" PopupHorizontalAlign="RightSides" 
                                                
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ShowShadow="False" 
             Width="200px">
                                                <DropDownWindowTemplate>
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelHourlyTraffic" runat="server" ClientInstanceName="GridViewPersonnelHourlyTraffic" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" KeyFieldName="Barcode" Width="400px" Styles-Row-Cursor="pointer">
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                                                        if(s.GetFocusedRowIndex()>-1)
                                                        {
var row = s.GetRow(s.GetFocusedRowIndex());
var cellValue =  row.cells[0].innerHTML+ ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
DropDownPersonnelHourlyTraffic.SetText(cellValue);
   s.GetFocusedRowIndex();
   
   }
   else
   {
   
   }
   
}" />
<ClientSideEvents RowClick="function(s,e){DropDownPersonnelHourlyTraffic.HideDropDown();}" />
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
                                            </dx:ASPxDropDownEdit></td>
     <td align="left">
         تاریخ</td>
     <td align="left">
         سال</td>
     <td align="right">
         <dx:ASPxComboBox ID="ASPxComboBoxYearHourlyTraffic" runat="server" 
             ClientInstanceName="ComboBoxYearHourlyTraffic" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
             Width="60px">
             <Items>
                 <dx:ListEditItem Text="1389" Value="1389" />
                 <dx:ListEditItem Text="1390" Value="1390" />
                 <dx:ListEditItem Text="1391" Value="1391" />
                 <dx:ListEditItem Text="1392" Value="1392" />
                 <dx:ListEditItem Text="1393" Value="1393" />
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
     <td align="left">
         ماه</td>
     <td align="right">
     <dx:ASPxComboBox ID="ASPxComboBoxMonthHourlyTraffic" runat="server" 
             ClientInstanceName="ComboBoxMonthHourlyTraffic" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" 
             Width="80px">
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
     <td>
         <input id="btnShowResultSearchHourlyTraffic" type="button"  onclick="btnShowResultSearchHourlyTraffic_onClick()"
             value="نمایش" style="font-family: tahoma; font-size: 9pt; background-color: #FFFFFF;" />
     </td>
 </tr>
     <tr>
         <td colspan="8">
             
             <dx:ASPxGridView runat="server" ClientInstanceName="GridViewRequestHourlyTraffic" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                 AutoGenerateColumns="False" RightToLeft="True" Width="100%" KeyFieldName="ID"
                 ID="ASPxGridViewRequestHourlyTraffic" OnCustomCallback="ASPxGridViewRequestHourlyTraffic_CustomCallback" 
                 ><Columns>
<dx:GridViewDataTextColumn FieldName="ID" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishID" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Barcode" ShowInCustomizationForm="True" Width="0px" Visible="False" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Day" ShowInCustomizationForm="True" Width="10%" Caption="روز" 
                         VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Dates" ShowInCustomizationForm="True" Width="10%" 
                         Caption="تاریخ" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Times" ShowInCustomizationForm="True" Width="10%" 
                         Caption="ساعت" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishName" ShowInCustomizationForm="True" Width="20%" 
                         Caption="نوع رکورد" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Change" ShowInCustomizationForm="True" Width="10%" 
                         Caption="تغییر" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Station" ShowInCustomizationForm="True" Width="10%" 
                         Caption="دستگاه" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Operator" ShowInCustomizationForm="True" Width="10%" 
                         Caption="اپراتور" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn  ShowInCustomizationForm="True" Width="10%" 
                         Caption="شماره برگه" VisibleIndex="3">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

<SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد"></SettingsText>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

<Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
<LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif"></LoadingPanelOnStatusBar>

<LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif"></LoadingPanel>
</Images>

<ImagesEditors>
<DropDownEditDropDown>
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
        PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
</DropDownEditDropDown>

<SpinEditIncrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
</SpinEditIncrement>

<SpinEditDecrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
</SpinEditDecrement>

<SpinEditLargeIncrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
</SpinEditLargeIncrement>

<SpinEditLargeDecrement>
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
</SpinEditLargeDecrement>
</ImagesEditors>

<ImagesFilterControl>
<LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif"></LoadingPanel>
</ImagesFilterControl>

<Styles CssPostfix="Aqua" CssFilePath="~/App_Themes/Aqua/{0}/styles.css">
<AlternatingRow Enabled="True"></AlternatingRow>

<LoadingPanel ImageSpacing="8px"></LoadingPanel>
</Styles>

<StylesEditors>
<CalendarHeader Spacing="1px"></CalendarHeader>

<ProgressBar Height="25px"></ProgressBar>
</StylesEditors>
</dx:ASPxGridView>
</td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

    </div>
    <br />
    <br />
    <div id="div4" dir="rtl" style="width:100%">
    <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeaderHourlyTraffic" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeaderHourlyTraffic_TrafficRequestOperator">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderHourlyTrafficClick(e);}"></ClientSideEvents>
<Items>
<dx:MenuItem Name="AddMenuHeaderHourlyTraffic_TrafficRequestOperator" Text="جدید" Enabled="false">
<Image Url="~/img/add.png"></Image>
</dx:MenuItem>
    <dx:MenuItem Name="EditMenuHeaderHourlyTraffic_TrafficRequestOperator" Text="ویرایش" Enabled="false">
        <Image Url="~/img/edit.png">
        </Image>
    </dx:MenuItem>
<dx:MenuItem Name="SaveMenuHeaderHourlyTraffic_TrafficRequestOperator" Text="ثبت">
<Image Url="~/img/save.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="CancelMenuHeaderHourlyTraffic_TrafficRequestOperator" Text="انصراف">
<Image Url="~/img/cancel.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="DeleteMenuHeaderHourlyTraffic_TrafficRequestOperator" Text="حذف" Enabled="false">
<Image Url="~/img/remove.png"></Image>
</dx:MenuItem>

</Items>

<LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif"></LoadingPanelImage>

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

<ItemStyle DropDownButtonSpacing="12px" ToolbarDropDownButtonSpacing="5px" 
            ToolbarPopOutImageSpacing="5px" PopOutImageSpacing="18px" Cursor="pointer" 
            VerticalAlign="Middle"></ItemStyle>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
</dx:ASPxMenu>

       
    </div>
    <br />
    <div id="div5" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="90%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelSearchHourlyTraffic" 
            ClientInstanceName="PanelSearchHourly">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent ID="PanelContent4" runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox runat="server" ValueType="System.String" 
             ID="ASPxComboBoxTrafficTypeHourlyTraffic" 
             ClientInstanceName="ComboBoxTrafficTypeHourlyTraffic">
</dx:ASPxComboBox>

     </td>
     <td align="left">
         تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker runat="server" Regional="fa" DateFormat="YMD" 
             IEDateFormat="YMD" Width="90px" ID="DateHourlyTraffic" CurrentText=""></cc1:JQDatePicker>
</td>
     <td align="left">
         از ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditFromHourHourlyTraffic" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditFromHourHourlyTraffic">
         </dx:ASPxTimeEdit>
</td>
     <td align="right">
         تا ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditToHourlyTraffic" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditToHourHourlyTraffic">
         </dx:ASPxTimeEdit>
     </td>
 </tr>
     <tr>
         <td align="left">
             شماره برگه</td>
         <td align="right">
             <dx:ASPxTextBox runat="server" Width="170px" 
                 ID="ASPxTextBoxFormNoHourlyTraffic" ClientInstanceName="TextBoxFormNoHourlyTraffic">
</dx:ASPxTextBox>

         </td>
         <td align="left">
             توضیحات</td>
         <td colspan="5" align="right">
             <dx:ASPxTextBox runat="server" Width="95%" 
                 ID="ASPxTextBoxCommentHourlyTraffic" ClientInstanceName="TextBoxCommentHourlyTraffic">
</dx:ASPxTextBox>

         </td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

   
    </div>
  
    
      </asp:Panel>

                             </dx:ContentControl>
</ContentCollection>
</dx:TabPage>
                                </TabPages>
                                
                              <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                                </LoadingPanelImage>
                                <Paddings Padding="2px" PaddingLeft="5px" PaddingRight="5px" />
                                <ContentStyle>
                                    <Border BorderColor="#AECAF0" BorderStyle="Solid" BorderWidth="1px" />
                                </ContentStyle>
                            
                                </dx:ASPxPageControl>   
                                </div>
      <dx:ASPxCallback ID="ASPxCallbackInsertRequestDaily" runat="server" 
          ClientInstanceName="CallbackInsertRequestDaily" 
          oncallback="ASPxCallbackInsertRequestDaily_Callback">
          <ClientSideEvents CallbackComplete="function(s,e){ CallbackInsertRequestDaily_CallbackComplete(e);}" />
      </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallbackDeleteRequestDaily" runat="server" 
          ClientInstanceName="CallbackDeleteRequestDaily" 
          oncallback="ASPxCallbackDeleteRequestDaily_Callback">
          <ClientSideEvents CallbackComplete="function(s,e){CallbackDeleteRequestDaily_CallbackComplete(e);}" />
      </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallbackInsertRequestHourly" runat="server" 
          ClientInstanceName="CallbackInsertRequestHourly" 
          oncallback="ASPxCallbackInsertRequestHourly_Callback">
          <ClientSideEvents CallbackComplete="function(s ,e){ CallbackUpdateRequestHourly_CallbackComplete(e);}" />
      </dx:ASPxCallback>
        <dx:ASPxCallback ID="ASPxCallbackInsertRequestHourlyTraffic" runat="server" 
          ClientInstanceName="CallbackInsertRequestHourlyTraffic" oncallback="ASPxCallbackInsertRequestHourlyTraffic_Callback" 
          >
          <ClientSideEvents CallbackComplete="function(s ,e){ CallbackUpdateRequestHourlyTraffic_CallbackComplete(e);}" />
      </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallbackDeleteRequestHourlyPermit" runat="server" 
          ClientInstanceName="CallbackDeleteRequestHourlyPermit" 
          oncallback="ASPxCallbackDeleteRequestHourlyPermit_Callback">
          <ClientSideEvents CallbackComplete="function(s,e){CallbackDeleteRequestHourlyPermit_CallbackComplete(e);}" />
      </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallbackDeleteRequestHourlyTraffic" runat="server" 
          ClientInstanceName="CallbackDeleteRequestHourlyTraffic" oncallback="ASPxCallbackDeleteRequestHourlyTraffic_Callback" 
          >
          <ClientSideEvents CallbackComplete="function(s,e){CallbackDeleteRequestHourlyTraffic_CallbackComplete(e);}" />
      </dx:ASPxCallback>
      <br />
    <asp:Panel runat="server" ID="panelEditedDialogDaily">
  
      <dx:ASPxPopupControl ID="ASPxPopupInsertDaily" runat="server" CloseAction="CloseButton"
        Modal="True" PopupHorizontalAlign="RightSides" PopupVerticalAlign="TopSides"
        ClientInstanceName="PopupInsertDaily" HeaderText="ثبت تردد های روزانه" 
          RightToLeft="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="ASPxPopupQuestionBoxContentControlDaily" runat="server">
                <dx:ASPxPanel ID="ASPxPopupQuestionBoxPanelDaily" runat="server" 
                    DefaultButton="btOK" Width="480px" RightToLeft="True"
                    Height="400px">
                    <PanelCollection>
                        <dx:PanelContent>
                       <table style="width: 95%; font-family: tahoma; font-size: 8pt;" 
                                cellpadding="8">
                       <tr>
                       <td valign="middle" align="right">
                          تاریخ : <dx:ASPxComboBox ID="ASPxComboBoxDateDaily" 
                               ClientInstanceName="ComboBoxDateDaily" runat="server" Width="200px" 
                               OnCallback="ASPxComboBoxDateDaily_Callback" 
                               CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                               LoadingPanelImagePosition="Top" ShowShadow="False" 
                               SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                           <ClientSideEvents EndCallback="ComboBoxDateDaily_EndCallback" />
                           <ClientSideEvents SelectedIndexChanged="ComboBoxDateDaily_SelectedIndexChanged" />
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
                       <td  align="center">
                       <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewRequestSelectedDateDaily" KeyFieldName="ID" 
                AutoGenerateColumns="False" RightToLeft="True" Width="100%"  
                ID="ASPxGridViewRequestSelectedDateDaily" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                            CssPostfix="Aqua" 
                               OnCustomCallback="ASPxGridViewRequestSelectedDateDaily_CustomCallback">
<%--<ClientSideEvents FocusedRowChanged="function(s, e){onClickRowASPxGridViewViewUserOfPerson()}"></ClientSideEvents>--%>

<SettingsPager Mode="ShowAllRecords">
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

                               <ClientSideEvents EndCallback="GridViewRequestSelectedDateDaily_EndCallback" />
<Columns>

<dx:GridViewDataTextColumn FieldName="Dates" ShowInCustomizationForm="True" 
        Width="12%" Caption="تاریخ" VisibleIndex="1">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Times" ShowInCustomizationForm="True" 
        Width="12%" Caption="ساعت" VisibleIndex="0">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PishName" ShowInCustomizationForm="True" 
        Width="28%" Caption="نوع رکورد" VisibleIndex="2">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>




</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

                            <SettingsPager PageSize="10">
                                <Summary Text="صفحه {0} از {1}" />
                           </SettingsPager>

                            <Settings ShowVerticalScrollBar="true" />

<SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد" Title="تردد های ثبت شده در این تاریخ"></SettingsText>

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
                       </td>
                       </tr>
                       <tr>
                       <td align="center">
                       
                           درخواست های بالا برای این روز وجود دارد آیا درخواست جدید را ثبت می نمایید؟
                       
                       </td>
                       </tr>
                       <tr>
                       <td>
                                              <div style="width: 33%; float: right" align="center">
                          <input id="ButtonOkAllDaily" type="button" onclick="ButtonOkAllDaily_onClick()" value=" تایید همه روزها" style="font-family: tahoma; font-size: 8pt; background-color: #FFFFFF" /></div>
                       <div style="width: 33%; float: right" align="center">
                          <input id="ButtonOkDaily" type="button" onclick="ButtonOkDaily_onClick()" value="تایید" style="font-family: tahoma; font-size: 8pt; background-color: #FFFFFF" /></div>
                           <div style="width: 33%; float: right" align="center">
                               <input id="ButtonCancelDaily" type="button" onclick="ButtonCancelDaily_onClick()" value="عدم تایید" style="font-family: tahoma; font-size: 8pt; background-color: #FFFFFF" />
                           </div>
                       </td>
                       </tr>
                       </table>
                            
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl></asp:Panel>
    <dx:ASPxPopupControl ID="ASPxPopupControlEditDaily" runat="server" CloseAction="CloseButton"
        Modal="True" PopupHorizontalAlign="RightSides" PopupVerticalAlign="TopSides"
        ClientInstanceName="PopupControlEditDaily" HeaderText="ویرایش تردد" 
          RightToLeft="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxPanel ID="ASPxPanelEditDaily" runat="server" 
                    DefaultButton="btnSabtEditDaily" Width="480px" RightToLeft="True"
                    Height="120px">
                    <PanelCollection>
                        <dx:PanelContent>
                        
                            <table cellspacing="5" dir="rtl" style="width:100%">
                                <tr>
                                    <td align="left">
                                        نوع تردد</td>
                                    <td align="right">
                                        <dx:ASPxComboBox ID="ASPxComboBoxTrafficTypeEditDaily" runat="server" 
                                            CallbackPageSize="500" ClientInstanceName="ComboBoxTrafficTypeEditDaily" 
                                            DropDownRows="10" RightToLeft="True" ValueType="System.String">
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td align="left">
                                        تاریخ</td>
                                    <td align="right">
                                        <cc1:JQDatePicker ID="FromDateEditDaily" runat="server" DateFormat="YMD" 
                                            IEDateFormat="YMD" Regional="fa" Width="90px"></cc1:JQDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        شماره برگه</td>
                                    <td align="right">
                                        <dx:ASPxTextBox ID="ASPxTextBoxFormEditNoDaily" runat="server" 
                                            ClientInstanceName="TextBoxFormNoEditDaily" Width="150px">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td align="left">
                                        توضیحات</td>
                                    <td align="right">
                                        <dx:ASPxTextBox ID="ASPxTextBoxCommentEditDaily" runat="server" 
                                            ClientInstanceName="TextBoxCommentEditDaily" Width="170px">
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        &nbsp;</td>
                                    <td align="center">
                                        <input id="btnSabtEditDaily" onclick="btnSabtEditDaily_onClick();" type="button" value="تایید" style="font-family: tahoma; font-size: 9pt; background-color: #FFFFFF;" />
                                    </td>
                                    <td align="left">
                                        &nbsp;</td>
                                    <td align="center">
                                        <input id="btnCancelEditDaily" onclick="btnCancelEditDaily_onClick();" type="button" value="انصراف" style="font-family: tahoma; font-size: 9pt; background-color: #FFFFFF;" />
                                    </td>
                                </tr>
                            </table>
                        
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="log.aspx.cs"
    Inherits="ASPWebclock.Admin.log" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxMenu" tagprefix="dx1" %>
<%@ Register assembly="JQControls" namespace="JQControls" tagprefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>معرفی پرسنل تحت مدیریت</title>
    <link href="../css/DropDownListStyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/buttonStyle.css" rel="stylesheet" type="text/css" />
    
   
    

   
    

    
   
    

   
    
</head>
<body>
<script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/DefineManagerPersonnel_Operations.js" type="text/javascript"></script>
    <form id="DefineManagerPersonnelform" runat="server" >
        <cc1:JQLoader ID="JQLoader1" runat="server">
        </cc1:JQLoader>
    <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_DefineManagerPersonnel" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_DefineManagerPersonnel">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_DefineManagerPersonnel" 
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
 <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right" >
      <div dir="rtl" style="width: 100%" align="center">
          <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="80%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="جستجوی وقایع" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
 <table id="tableSearch" dir="rtl" class="auto-style8">
                    <tr>
                        <td align="center" valign="top" class="auto-style4">
                            براساس</td>
                        <td align="center" class="auto-style2" valign="top">&nbsp;</td>
                        <td align="right" valign="top">
                            <dx:ASPxComboBox ID="ASPxComboBoxSearchField" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" LoadingPanelImagePosition="Top" ShowShadow="False" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ValueType="System.String" OnSelectedIndexChanged="ASPxComboBox1_SelectedIndexChanged" SelectedIndex="0">
                                <Items>
                                    <dx:ListEditItem Text="نام کاربری" Value="UserName" Selected="True" />
                                    <dx:ListEditItem Text="پست" Value="UserWebPassID" />
                                    <dx:ListEditItem Text="شماره پرسنلی" Value="p_barcode" />
                                    <dx:ListEditItem Text="وضعیت" Value="Action" />
                                    <dx:ListEditItem Text="نوع اقدام" Value="Action" />
                                    <dx:ListEditItem Text="توضیحات" Value="Comment" />
                                </Items>
                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                </LoadingPanelImage>
                                <DropDownButton>
                                    <Image>
                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                    </Image>
                                </DropDownButton>
                                <ValidationSettings>
                                    <ErrorFrameStyle ImageSpacing="4px">
                                        <ErrorTextPaddings PaddingLeft="4px" />
                                    </ErrorFrameStyle>
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td align="center" valign="top" class="auto-style10">&nbsp; متن جستجو</td>
                        <td align="right" valign="top">
                            <dx:ASPxTextBox ID="ASPxTextBoxSearchKey" runat="server" Height="16px" Width="229px">
                                <ValidationSettings>
                                    <ErrorFrameStyle ImageSpacing="4px">
                                        <ErrorTextPaddings PaddingLeft="4px" />
                                    </ErrorFrameStyle>
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td align="right" class="auto-style6" valign="top">
                            <dx:ASPxButton ID="ASPxButtonShow" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="نمایش" OnClick="ASPxButtonSearchKey_Click">
                            </dx:ASPxButton>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="auto-style4" valign="top">از تاریخ</td>
                        <td align="center" class="auto-style2" valign="top">
                            <cc1:JQDatePicker ID="FromDate" runat="server" DateFormat="YMD" IEDateFormat="YMD" Regional="fa" Width="90px"></cc1:JQDatePicker>
                        </td>
                        <td align="right" valign="top">&nbsp;</td>
                        <td align="center" class="auto-style10" valign="top">تا تاریخ</td>
                        <td align="right" valign="top">
                            <cc1:JQDatePicker ID="ToDate" runat="server" DateFormat="YMD" IEDateFormat="YMD" Regional="fa" Width="90px"></cc1:JQDatePicker>
                        </td>
                        <td align="right" class="auto-style6" valign="top">
                            <dx:ASPxButton ID="ASPxButtonDelete" runat="server" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" Height="22px" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Text="حذف" Width="100px" OnClick="ASPxButtonDelete_Click">
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>

</dx:PanelContent>
</PanelCollection>
          </dx:ASPxRoundPanel>
           
        </div><br />
        <table style="width:100%" align="center">
        <tr>
        <td align="center" style="width: 55%" valign="top">
                 
                        <br />
            
            <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewDefaultUser" 
                AutoGenerateColumns="False" RightToLeft="True" Width="100%" 
                ID="ASPxGridViewLog" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                            CssPostfix="Aqua" 
                         
                 CssClass="auto-style1" KeyFieldName="ID">

            <SettingsEditing Mode="Inline" />
             <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
             <ClientSideEvents EndCallback="function(s,e){GridViewDefaultUser_EndCallback(e);}" />
            <Settings ShowFilterRow="True" />
 <SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد." />

                            <SettingsLoadingPanel ImagePosition="Top" />

<ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}"></ClientSideEvents>

<Columns>
<dx:GridViewDataTextColumn FieldName="UserName" ShowInCustomizationForm="True" Caption="نام کاربری" VisibleIndex="1" ReadOnly="True">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PersonPost" ShowInCustomizationForm="True" Caption="پست کاربر" VisibleIndex="2">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="barcode" 
        ShowInCustomizationForm="True" Caption="شماره پرسنلی" VisibleIndex="3">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn FieldName="Status" 
        ShowInCustomizationForm="True" Caption="وضعیت" VisibleIndex="4">
                   <HeaderStyle HorizontalAlign="Center" />
                   <CellStyle HorizontalAlign="Center">
                   </CellStyle>
</dx:GridViewDataTextColumn>     
    <dx:GridViewDataTextColumn Caption="نوع اقدام" FieldName="Action" ShowInCustomizationForm="True" VisibleIndex="5">
        <HeaderStyle HorizontalAlign="Center" />
        <CellStyle HorizontalAlign="Center">
        </CellStyle>
    </dx:GridViewDataTextColumn>
    <dx:GridViewDataTextColumn Caption="زمان" FieldName="Time" VisibleIndex="7">
    </dx:GridViewDataTextColumn>
    <dx:GridViewCommandColumn Caption="انتخاب" ShowSelectCheckbox="True" 
        VisibleIndex="0">
        <ClearFilterButton Visible="True">
        </ClearFilterButton>
        <HeaderStyle HorizontalAlign="Center" />
                                               <HeaderTemplate>

                                                   <dx:ASPxCheckBox  runat="server" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"    CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua"  ClientInstanceName="cbAll" ToolTip="Select all rows" Text="همه">
                                                   <ClientSideEvents CheckedChanged="function(s,e){OnAllCheckedChanged(s,e);}" />
                                                   </dx:ASPxCheckBox>

                                                

                                               </HeaderTemplate>
    </dx:GridViewCommandColumn>
        
            
    <dx:GridViewDataTextColumn Caption="تاریخ" FieldName="PersianDate" ShowInCustomizationForm="True" VisibleIndex="6">
        <HeaderStyle HorizontalAlign="Center" />
        <CellStyle HorizontalAlign="Center">
        </CellStyle>
    </dx:GridViewDataTextColumn>
    <dx:GridViewDataTextColumn Caption="توضیحات" FieldName="Comment" ShowInCustomizationForm="True" VisibleIndex="9">
        <HeaderStyle HorizontalAlign="Center" />
        <CellStyle HorizontalAlign="Center" Wrap="False">
        </CellStyle>
    </dx:GridViewDataTextColumn>
        
            
</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager AlwaysShowPager="True">
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

<SettingsEditing Mode="Inline"></SettingsEditing>

<SettingsText ConfirmDelete="آیا این آیتم را حذف می نمایید؟" 
                EmptyDataRow="هیچ آیتمی وجود ندارد." CommandEdit="ویرایش" CommandDelete="حذف" 
                CommandCancel="انصراف" CommandUpdate="ثبت"></SettingsText>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

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
        
        </td>
        </tr>
        <tr>
        <td align="center" style="width: 55%" valign="top">
                 
                        <br />
                        <br />
                        <br />
                        
                        
        
        </td>
        </tr>
        </table>
              <br />
                  <div align="center" style="width: 100%">
                  </div>
              
              
    </div>
    </form>
</body>
</html>

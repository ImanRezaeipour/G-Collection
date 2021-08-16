<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDefineDefaultUser.aspx.cs" Inherits="WebRest.Admin.AdminDefineDefultUser" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxDataView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPager" TagPrefix="dx1" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dx2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>معرفی کاربران پیش فرض</title>
    


   
    <script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
 <script src="../Scripts/AdminDefineDefaultUsers_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="AdminDefineDefultUserForm" runat="server">
    <div id="divMenuHeader" dir="rtl" style="width: 100%">
     
            <dx:ASPxMenu ID="ASPxMenu1" runat="server" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css"
                CssPostfix="Office2003Blue" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
                ClientInstanceName="MenuHeader" onitemclick="ASPxMenu1_ItemClick" 
                BorderBetweenItemAndSubMenu="HideRootOnly">
                <Items>
                    
                    <dx:MenuItem Text="ثبت کاربر پیش فرض" Name="Save">
                        <Image Url="../Image/DesignImage/save.png">
                        </Image>
                    </dx:MenuItem>
             
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Office2003Blue/Web/Loading.gif">
                </LoadingPanelImage>
                <ItemSubMenuOffset FirstItemX="2" LastItemX="2" X="2" />
                <ItemStyle HorizontalAlign="Left" />
                <SubMenuStyle GutterWidth="17px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuClick(e);}" />
            </dx:ASPxMenu>
            <br />
        <div style="width:100%" align="right" dir="rtl">
        <dx:ASPxRoundPanel ID="ASPxRoundPanelSearch" runat="server" Width="70%" 
              CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" CssPostfix="Office2003Blue" 
              GroupBoxCaptionOffsetY="-25px" HeaderText="فیلترهای انتخاب" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
                EnableDefaultAppearance="False">
              <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
              <HeaderStyle>
              <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                  PaddingRight="2px" />
              </HeaderStyle>
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
 <table style="width:100%">
 <tr>
 <td width="50%" align="center">

     <dx:ASPxCheckBox ID="ASPxCheckBoxWithUser" runat="server" 
         CheckState="Unchecked" ClientInstanceName="CheckBoxWithUser" 
         Text="انتخاب پرسنل با نام کاربری">
         <ClientSideEvents CheckedChanged="function(s,e){ CheckBoxWithUser_onCheckedChanged('User');}" />
     </dx:ASPxCheckBox>

 </td>
 <td width="50%" align="center">
     <dx:ASPxCheckBox ID="ASPxCheckBoxNoUser" runat="server" CheckState="Unchecked" 
         ClientInstanceName="CheckBoxNoUser" Text="انتخاب پرسنل بدون نام کاربری">
               <ClientSideEvents CheckedChanged="function(s,e){ CheckBoxNoUser_onCheckedChanged('NoUser');}" />
     </dx:ASPxCheckBox>
 </td>
 </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
<br />
        <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewDefaultUser" KeyFieldName="Barcode" 
                AutoGenerateColumns="False" RightToLeft="True" Width="70%" 
                ID="ASPxGridViewDefaultUser" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                            CssPostfix="Office2003Blue" 
                            OnCustomCallback="ASPxGridViewDefaultUser_CustomCallback" 
                
                onprocesscolumnautofilter="ASPxGridViewDefaultUser_ProcessColumnAutoFilter">

            <SettingsEditing Mode="Inline" />
             <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
             <ClientSideEvents EndCallback="function(s,e){GridViewDefaultUser_EndCallback(e);}" />
 <SettingsText CommandEdit="ویرایش" EmptyDataRow="هیچ آیتمی وجود ندارد." 
                           CommandDelete="حذف" CommandCancel="انصراف" CommandUpdate="ثبت" 
                           ConfirmDelete="آیا این آیتم را حذف می نمایید؟" />

<ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}"></ClientSideEvents>

<Columns>
<dx:GridViewDataTextColumn FieldName="Barcode" ShowInCustomizationForm="True" 
        Width="20%" Caption="شماره پرسنلی" VisibleIndex="1" ReadOnly="True">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Name" ShowInCustomizationForm="True" Caption="نام" 
       Width="20%" VisibleIndex="2">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Family" 
        ShowInCustomizationForm="True" Caption="نام خانوادگی" 
       Width="30%" VisibleIndex="3">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn FieldName="UserName" 
        ShowInCustomizationForm="True" Caption="نام کاربری" 
       Width="20%" VisibleIndex="4">
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

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

<SettingsEditing Mode="Inline"></SettingsEditing>

<SettingsText ConfirmDelete="آیا این آیتم را حذف می نمایید؟" 
                EmptyDataRow="هیچ آیتمی وجود ندارد." CommandEdit="ویرایش" CommandDelete="حذف" 
                CommandCancel="انصراف" CommandUpdate="ثبت"></SettingsText>

<SettingsLoadingPanel ImagePosition="Top"></SettingsLoadingPanel>

                            <Images SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                                <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Blue/GridView/gvLoadingOnStatusBar.gif">
                                </LoadingPanelOnStatusBar>
                                <LoadingPanel Url="~/App_Themes/Office2003Blue/GridView/Loading.gif">
                                </LoadingPanel>
                            </Images>
                            <ImagesFilterControl>
                                <LoadingPanel Url="~/App_Themes/Office2003Blue/Editors/Loading.gif">
                                </LoadingPanel>
                            </ImagesFilterControl>

<Styles CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                CssPostfix="Office2003Blue">
    <Header ImageSpacing="5px" SortingImageSpacing="5px">
    </Header>
<AlternatingRow Enabled="True"></AlternatingRow>
    <LoadingPanel ImageSpacing="10px">
    </LoadingPanel>
</Styles>
                            <StylesEditors>
                                <ProgressBar Height="25px">
                                </ProgressBar>
                            </StylesEditors>
                            <Settings ShowFilterRow="True"  />
</dx:ASPxGridView>
        </div>
    </form>
</body>
</html>

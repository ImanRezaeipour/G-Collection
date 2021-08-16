<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDefineUsers.aspx.cs" Inherits="WebRest.Admin.AdminDefineUsers" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>معرفی کاربران</title>
    
    <script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/AdminDefineUsers_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="AdminDefineUsersForm" runat="server">
    <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt; background-color: #FFFFFF;" align="right">
        <div id="divMenuHeader" dir="rtl" >
            <dx:ASPxMenu ID="ASPxMenu1" runat="server" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css"
                CssPostfix="Office2003Blue" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
                ClientInstanceName="MenuHeader" BorderBetweenItemAndSubMenu="HideRootOnly">
                <Items>
                    <dx:MenuItem Text="جدید" ToolTip="ایجاد کاربر جدید" Name="Add">
                        <Image Url="../Image/DesignImage/add.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="ویرایش" Name="Edit">
                        <Image Url="../Image/DesignImage/edit.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="ثبت" Name="Save">
                        <Image Url="../Image/DesignImage/save.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="انصراف" Name="Cancel">
                        <Image Url="../Image/DesignImage/cancel.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="حذف" Name="Delete">
                        <Image Url="../Image/DesignImage/remove.png">
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
        </div>
        <br />
        <table dir="rtl" style="width: 100%" >
        <tr>
        <td style="width: 50%">
          
        <dx:ASPxRoundPanel ID="ASPxRoundPanelSearch" runat="server" Width="100%" 
              CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" CssPostfix="Office2003Blue" 
              GroupBoxCaptionOffsetY="-25px" HeaderText="جستجوی پرسنل" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
                EnableDefaultAppearance="False">
              <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
              <HeaderStyle>
              <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                  PaddingRight="2px" />
              </HeaderStyle>
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
 <table id="tableSearch" style="width: 100%" dir="rtl">
                    <tr>
                        <td valign="top" style="width: 20%">
                            عبارت جستجو
                            <br />
                        </td>
                        <td align="right" valign="top">
                            <input id="txtSearch" type="text" style="width: 80%; font-family: tahoma; font-size: 9pt;" onkeypress="txtSearchEnterKeyPressDoingSearch(event);" />
                            &nbsp;
                            <img alt="" src="../Image/DesignImage/search.png" height="16px" width="16px" class="ImageButtonStyle"
                                onclick="onClickSearchPersonnel();" id="btnSearchPersonnel" style="cursor: pointer" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="width: 20%">
                            نتایج جستجو
                        </td>
                        <td align="right" valign="top">
                            
                            <dx:ASPxDropDownEdit ID="ASPxDropDownEditPersonnelSearch" 
                                                ClientInstanceName="DropDownEditPersonnelSearch" 
                                runat="server" PopupHorizontalAlign="RightSides" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                ShowShadow="False" Width="80%" DropDownWindowStyle-HorizontalAlign="Center" DropDownWindowStyle-VerticalAlign="Top">
                                                <DropDownWindowTemplate>
                                                
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelSearch" ClientInstanceName="GridViewPersonnelSearch" runat="server" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" KeyFieldName="P_BarCode" Width="400px" Styles-Row-Cursor="pointer" OnCustomCallback="ASPxGridViewPersonnelSearch_CustomCallback" >
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {GridViewPersonnelSearch_onFocusedRowChanged(s,e);}" />
                                                        <ClientSideEvents RowClick="function(s,e){GridViewPersonnelSearch_onRowClick();}" />
                                                        <ClientSideEvents EndCallback="function(s,e){GridViewPersonnelSearch_EndCallback()}" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="P_BarCode" VisibleIndex="1" 
                                                                Caption="کد پرسنلی" ShowInCustomizationForm="True" >
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="P_Name" VisibleIndex="2" Caption="نام" 
                                                                ShowInCustomizationForm="True" >
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="P_Family" VisibleIndex="3" 
                                                                Caption="نام خانوادگی" ShowInCustomizationForm="True" >
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
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>
                                                    </dx:ASPxGridView>
                                                    
                                                </DropDownWindowTemplate>

<DropDownWindowStyle HorizontalAlign="Center" VerticalAlign="Top"></DropDownWindowStyle>

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
        <td valign="top" rowspan="2" align="center">
            
            </td>
        </tr>
        <tr>
        <td>
        <dx:ASPxCallbackPanel ID="ASPxCallbackPanelUserofPersonnel" runat="server" 
                ClientInstanceName="CallbackPanelUserofPersonnel" 
                oncallback="ASPxCallbackPanelUserofPersonnel_Callback">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent3" runat="server" 
                        SupportsDisabledAttribute="True">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="100%" 
              CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" CssPostfix="Office2003Blue" 
              GroupBoxCaptionOffsetY="-25px" HeaderText="اطلاعات کاربر" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
                            EnableDefaultAppearance="False">
              <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
              <HeaderStyle>
              <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                  PaddingRight="2px" />
              </HeaderStyle>
              <PanelCollection>
<dx:PanelContent ID="PanelContent2" runat="server" SupportsDisabledAttribute="True">
<table style="width: 100%" cellpadding="5" cellspacing="8">
                    <tr>
                        <td style="width: 30%" align="left">
                            نام کاربری :
                        </td>
                        <td align="right">
                            &nbsp;<dx:ASPxTextBox ID="ASPxTextBoxUserName" runat="server" 
                                ClientInstanceName="txtUserName" Width="80%">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            کلمه عبور :
                        </td>
                        <td align="right">
                            <dx:ASPxTextBox ID="ASPxTextBoxPassword" runat="server" 
                                ClientInstanceName="txtPassword" Width="80%" Password="True">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            تکرار کلمه عبور :
                        </td>
                        <td align="right">
                           <dx:ASPxTextBox ID="ASPxTextBoxConfirmPassword" runat="server" Width="80%" 
                                ClientInstanceName="txtConfirmPassword" Password="True">
                            </dx:ASPxTextBox>
                                <dx:ASPxHiddenField ID="ASPxHiddenFieldID" ClientInstanceName="HiddenFieldID" runat="server">
            </dx:ASPxHiddenField>
            <dx:ASPxHiddenField ID="ASPxHiddenFieldBarcode" ClientInstanceName="HiddenFieldBarcode" runat="server">
            </dx:ASPxHiddenField>
                            
                        </td>
                    </tr>
                </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
 </dx:PanelContent>
                </PanelCollection>
               
            </dx:ASPxCallbackPanel>
        <input id="HiddenID" type="hidden" value="" />
        
                            <input id="HiddenBarcode" type="hidden" value="" />
                    </td>
        </tr>
        </table>
        
        <br />
        
        <div style="width:100%"> 
  
            <br />
     
    <dx:ASPxCallback ID="ASPxCallback1" runat="server" OnCallback="ASPxCallback1_Callback"
        ClientInstanceName="CallBackDefinePersonnelUpdate">
        <ClientSideEvents CallbackComplete="function(s ,e){onCallbackDefinePersonnelUpdateComplete(e);}" />
        <ClientSideEvents CallbackError="function(s ,e){onCallbackDefinePersonnelUpdateError(e);}" />
    </dx:ASPxCallback>
    </div>
        <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
    </form>
</body>
</html>

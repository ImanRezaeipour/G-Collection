<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminChangePassword.aspx.cs" Inherits="ASPWebclock.Admin.AdminChangePassword" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../js/AdminChangePassword_onOperations.js" type="text/javascript"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_ChangePassword" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_ChangePassword">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_ChangePassword" 
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
     <table align="right" class="CHANGEPASSWORDTABLE" style="width: 300px">
            <tr>
                <td style="height: 50px;">
                    <asp:TextBox ID="currentPassword" runat="server" TextMode="Password" Width="150px"
                        MaxLength="10" Font-Names="tahoma" />
                </td>
                <td style="font-family: 'tahoma'; font-size: 10pt; height: 50px; font-weight: bold;">
                    :رمز عبور فعلی
                </td>
            </tr>
            <tr>
                <td style="height: 25px;">
                    <asp:TextBox ID="newPassword" runat="server" TextMode="Password" Width="150px" MaxLength="10"
                        Font-Names="tahoma" />
                </td>
                <td style="font-family: 'tahoma'; font-size: 10pt; height: 50px; font-weight: bold;">
                    :رمز عبور جدید
                </td>
            </tr>
            <tr>
                <td style="height: 50px;">
                    <asp:TextBox ID="confirmNewPassword" runat="server" TextMode="Password" Width="150px"
                        MaxLength="10" Font-Names="tahoma" />
                </td>
                <td style="font-family: 'tahoma'; font-size: 10pt; height: 50px; font-weight: bold;">
                    :تکرار رمز عبور جدید
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="saveBtn" runat="server" Width="50px" Text="ثبت" OnClick="saveBtn_Click"
                        CssClass="buttonStyle" Font-Names="tahoma" Font-Size="9pt" />
                </td>
            </tr>
            <tr>
                <td colspan="2" dir="ltr" align="right">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="#CC3300" Font-Bold="True" 
                        Font-Names="tahoma" Font-Size="9pt"></asp:Label>
                </td>
            </tr>
        </table>
   
    </form>
</body>
</html>

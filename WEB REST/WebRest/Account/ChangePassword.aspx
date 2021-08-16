<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="WebRest.Account.ChangePassword" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx1" %>
<html>
<head>
   <title></title>
    
   
</head>
<body>
    <form id="ChangePasswordForm" runat="server">
   
        <table align="right"  style="width: 300px">
            <tr>
                <td style="height: 50px;">
                    
                    <dx:ASPxTextBox ID="currentPassword" runat="server" Width="98%" 
                        Password="True" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                        CssPostfix="Office2003Blue" 
                        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                    </dx:ASPxTextBox>
                </td>
                <td style="font-family: 'tahoma'; font-size: 9pt; height: 50px; font-weight: bold;">
                    :رمز عبور فعلی
                </td>
            </tr>
            <tr>
                <td style="height: 25px;">
                    
                        <dx:ASPxTextBox ID="newPassword" runat="server" Width="98%" Password="True" 
                            CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                            CssPostfix="Office2003Blue" 
                            SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                        </dx:ASPxTextBox>
                </td>
                <td style="font-family: 'tahoma'; font-size: 9pt; height: 50px; font-weight: bold;">
                    :رمز عبور جدید
                </td>
            </tr>
            <tr>
                <td style="height: 50px;">
                  
                    <dx:ASPxTextBox ID="confirmNewPassword" runat="server" Width="98%" 
                        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                        CssPostfix="Office2003Blue" Password="True" 
                        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                    </dx:ASPxTextBox>
                </td>
                <td style="font-family: 'tahoma'; font-size: 9pt; height: 50px; font-weight: bold;">
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
                <td align="left">
                    <dx:ASPxButton ID="ASPxButtonSave" runat="server" 
                        CssFilePath="~/App_Themes/SoftOrange/{0}/styles.css" 
                        CssPostfix="SoftOrange" onclick="ASPxButtonSave_Click" 
                        SpriteCssFilePath="~/App_Themes/SoftOrange/{0}/sprite.css" Text="ثبت" 
                        Width="100px">
                    </dx:ASPxButton>
     
            
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


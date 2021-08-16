<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebRest.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>  <title>صفحه ورود</title>
</head>
<body style="background-color: #6698FF" class="bodyStyle">
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>    
    <script type="text/javascript" src="../Scripts/Login_onPageLoad.js"></script>
    <script type="text/javascript" src="../Scripts/Login_onOperations.js"></script>               
    
    <form id="LoginForm" runat="server">
    <div style="border: 7px solid #FFFFFF; margin-top: -10px; background-color: #FFFFFF;">
        <asp:Image ID="Image1" runat="server" BorderColor="#660033" BorderStyle="Solid" BorderWidth="2px"
            Height="100px" ImageUrl="~/Image/DesignImage/Header.jpg" Width="100%" 
            ImageAlign="Middle" /></div>
    <br />
    <div dir="rtl" style="padding: 10px 50px 10px 50px">
        <asp:Label ID="lblPublicMessage_AdminSettings" runat="server" Font-Bold="True" Font-Names="tahoma"
            Font-Size="9pt" ForeColor="White" ClientIDMode="Static"></asp:Label>
    </div>
    <table width="100%" bgcolor="#6698FF">
        <tr>
            <td class="loginWidthStyle" align="center" valign="middle" style="width: 100%">
                <asp:Login ID="theLogincontrol" runat="server" DestinationPageUrl="~/ContentPage.aspx"
                    Font-Names="tahoma" Font-Size="8pt" Font-Bold="True" ForeColor="White" FailureText="نام کاربری و یا کلمه عبور اشتباه است.">
                    <LayoutTemplate>
                        <table style="border: 2px dashed #666666; background-position: center center; background-image: url('../img/images/login-box-backg.png');
                            background-repeat: no-repeat; width: 333px; height: 230px; background-attachment: fixed; background-color: #FFB888;"
                            dir="rtl" cellpadding="5" cellspacing="5">
                            <tr>
                                <td style="background-position: left center; font-family: arial; font-size: 24pt; font-weight: bold; color: #333333; background-image: url('../Image/DesignImage/food.png'); background-repeat: no-repeat; height: 60px; text-align: right; padding-right: 20px;"
                                    align="center">
                                    ورود به سیستم
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table dir="rtl" class="textformat" cellpadding="5" cellspacing="5" width="100%">
                                        <tr>
                                            <td align="left" style="font-family: tahoma; font-size: 8pt; font-weight: bold; color: #666666; width: 100px;">
                                                شماره پرسنلی:
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="UserName" runat="server" Width="150px" Style="direction: ltr;" Font-Names="Tahoma"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    Text="*"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" 
                                                style="font-family: tahoma; font-size: 8pt; font-weight: bold; color: #666666;width: 100px; vertical-align: middle;">
                                                کلمه عبور:
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="150px" Style="direction: ltr;"
                                                    Font-Names="Tahoma"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="padding-left: 40px">
                                    <asp:ImageButton ID="Login" runat="server" CommandName="Login" ImageUrl="~/Image/DesignImage/login-btn.png" /><br />
                                    <br />
                                    <asp:Label ID="FailureText" runat="server" Font-Names="tahoma" Font-Size="9pt" Font-Bold="True"
                                        ForeColor="#FF9933"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:Login>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenFieldPublicMessage" runat="server" ClientIDMode="Static" />
    </form>
</body>
</html>

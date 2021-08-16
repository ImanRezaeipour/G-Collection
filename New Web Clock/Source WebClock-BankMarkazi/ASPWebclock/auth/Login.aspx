<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="ASPWebclock.Login" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>صفحه ورود</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#DFDFFF"  class="bodyStyle" >
   <script src="../js/HelpForm_Operations.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../js/jquery-1.7.1.js"></script>
    <script language="javascript" type="text/javascript" src="../js/Login_onPageLoad.js"></script>
    <script language="javascript" type="text/javascript" src="../js/Login_onOperations.js"></script>
     
    
    <form id="form1" runat="server">
    <div style="border: 7px solid #FFFFFF">
    <asp:Image ID="Image1" runat="server" BorderColor="#660033" BorderStyle="Solid" BorderWidth="2px"
        Height="100px" ImageUrl="~/img/Header.jpg" Width="100%" /></div>
        <br />
        <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_Login" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_Login" Visible="False">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_Login" 
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
    <table width="100%" bgcolor="#DFDFFF">
        <tr>
            <td class="loginWidthStyle" align="center" valign="middle" style="width: 100%">
                <asp:Login ID="theLogincontrol" runat="server" DestinationPageUrl="~/SelectPost.aspx"
                    Font-Names="tahoma" Font-Size="8pt" Font-Bold="True" ForeColor="White" FailureText="نام کاربری و یا کلمه عبور اشتباه است." OnLoggedIn="theLogincontrol_LoggedIn">
                    <LayoutTemplate>
                        <table style="border: 2px outset #000080; background-position: center center; background-image: url('../img/images/login-box-backg.png');
                            background-repeat: no-repeat; width: 333px; height: 230px; background-attachment: fixed;"
                            dir="rtl">
                            <tr>
                                <td style="font-family: arial; font-size: 24pt; font-weight: bold; color: #FF9933;"
                                    align="center">
                                    ورود به سیستم
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table dir="rtl" class="textformat">
                                        <tr>
                                            <td align="left" style="font-family: tahoma; font-size: 8pt; font-weight: bold; color: #FFFFFF">
                                                شماره پرسنلی:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server" Width="200px" Style="direction: ltr;" Font-Names="Tahoma"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    Text="*"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="font-family: tahoma; font-size: 8pt; color: #FFFFFF; font-weight: bold">
                                                کلمه عبور:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="200px" Style="direction: ltr;"
                                                    Font-Names="Tahoma"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="padding-left: 40px">
                                    <asp:ImageButton ID="Login" runat="server" CommandName="Login" ImageUrl="~/img/images/login-btn.png" /><br />
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
    </form>
</body>
</html>

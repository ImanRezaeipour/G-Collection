<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Pelak.aspx.cs"
    Inherits="ASPWebclock.PelakChanger" %>
<html>
<head></head>
<body>
    <form runat="server">
    <table align="right" 
        style="padding: 70px 10px 50px 10px; width: 300px; font-family: tahoma; font-size: 8pt;">
        <tr>
            <td align="center" 
                style="font-family: tahoma; font-size: 9pt; font-weight: bold">
                لطفا شماره پلاک خودروهای خود را وارد نمایید
            </td>
        </tr>
        <tr>
            <td>
                <table align='right' style="width: 100%; font-family: tahoma; font-size: 9pt;">
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            ایران
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="pelak1part1TB" runat="server" Width="20px" MaxLength="2" />
                        </td>
                        <td>
                            <asp:DropDownList ID="pelak1part2Combo" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem Value="ا">الف</asp:ListItem>
                                <asp:ListItem Value="ب">ب</asp:ListItem>
                                <asp:ListItem Value="ت">ت</asp:ListItem>
                                <asp:ListItem Value="ج">ج</asp:ListItem>
                                <asp:ListItem Value="د">د</asp:ListItem>
                                <asp:ListItem Value="س">س</asp:ListItem>
                                <asp:ListItem Value="ص">ص</asp:ListItem>
                                <asp:ListItem Value="ط">ط</asp:ListItem>
                                <asp:ListItem Value="ع">ع</asp:ListItem>
                                <asp:ListItem Value="ق">ق</asp:ListItem>
                                <asp:ListItem Value="ل">ل</asp:ListItem>
                                <asp:ListItem Value="م">م</asp:ListItem>
                                <asp:ListItem Value="ن">ن</asp:ListItem>
                                <asp:ListItem Value="و">و</asp:ListItem>
                                <asp:ListItem Value="ه">ه</asp:ListItem>
                                <asp:ListItem Value="ي">ي</asp:ListItem>
                                <asp:ListItem Value="@">معلول</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="pelak1part3TB" runat="server" Width="30px" MaxLength="3" />
                        </td>
                        <td>
                            -
                        </td>
                        <td>
                            <asp:TextBox ID="pelak1part4TB" runat="server" Width="20px" MaxLength="2" />
                        </td>
                        <td dir="rtl">
                            شماره پلاک ۱:
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            ایران
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="pelak2part1TB" runat="server" Width="20px" MaxLength="2" />
                        </td>
                        <td>
                            <asp:DropDownList ID="pelak2Part2Combo" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem Value="ا">الف</asp:ListItem>
                                <asp:ListItem Value="ب">ب</asp:ListItem>
                                <asp:ListItem Value="ت">ت</asp:ListItem>
                                <asp:ListItem Value="ج">ج</asp:ListItem>
                                <asp:ListItem Value="د">د</asp:ListItem>
                                <asp:ListItem Value="س">س</asp:ListItem>
                                <asp:ListItem Value="ص">ص</asp:ListItem>
                                <asp:ListItem Value="ط">ط</asp:ListItem>
                                <asp:ListItem Value="ع">ع</asp:ListItem>
                                <asp:ListItem Value="ق">ق</asp:ListItem>
                                <asp:ListItem Value="ل">ل</asp:ListItem>
                                <asp:ListItem Value="م">م</asp:ListItem>
                                <asp:ListItem Value="ن">ن</asp:ListItem>
                                <asp:ListItem Value="و">و</asp:ListItem>
                                <asp:ListItem Value="ه">ه</asp:ListItem>
                                <asp:ListItem Value="ي">ي</asp:ListItem>
                                <asp:ListItem Value="@">معلول</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="pelak2part3TB" runat="server" Width="30px" MaxLength="3" />
                        </td>
                        <td>
                            -
                        </td>
                        <td>
                            <asp:TextBox ID="pelak2Part4TB" runat="server" Width="20px" MaxLength="2" />
                        </td>
                        <td dir="rtl">
                            شماره پلاک ۲:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        <br />
                            <asp:Button ID="saveBtn" runat="server" Width="50px" Text="ثبت" OnClick="saveBtn_Click"
                                CssClass="buttonStyle" Font-Bold="False" Font-Names="tahoma" 
                                Font-Size="9pt" />
                        </td>
                        <td>
                        </td>
                        <td colspan="2">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="6" dir="rtl">
                            <asp:Label ID="lblMessage" runat="server" ForeColor="#CC3300"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
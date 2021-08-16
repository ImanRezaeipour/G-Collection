<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonthlyReport.aspx.cs"
    Inherits="WebApplication1.MonthlyReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="css/tableStyle.css" type="text/css" rel="Stylesheet" />
    <link href="css/gridStyle.css" type="text/css" rel="Stylesheet" />
    <link href="css/lableStyle.css" type="text/css" rel="Stylesheet" />
    <link href="css/panelStyle.css" type="text/css" rel="Stylesheet" />
    <link href="css/buttonStyle.css" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body dir="rtl">
    <form id="MonthlyReport" runat="server">
    <div>
        <table style="width: 100%" class="bodyStyle">
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 10%">
                                <asp:Label ID="lbl1" runat="server" Text="مانده مرخصی تاکنون : "></asp:Label>
                            </td>
                            <td style="width: 5%">
                                <asp:Label ID="lblDayMondeMor" runat="server" Text="" style="color:Red;direction:rtl"></asp:Label>
                            </td>
                            <td style="width: 5%">
                                <asp:Label ID="lbl2" runat="server" Text="روز و"></asp:Label>
                            </td>
                            <td style="width: 5%">
                                <asp:Label ID="lblHourMondeMor" runat="server" Text="" style="color:Red;direction:rtl"></asp:Label>
                            </td>
                            <td style="width: 70%">
                                <asp:Label ID="lbl3" runat="server" Text="ساعت"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                <asp:DropDownList ID="cmbYear" runat="server" style="width:90%">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbMonth" runat="server" style="width:90%">
                                <asp:ListItem Text="فروردین" Value="1"></asp:ListItem>
                                <asp:ListItem Text="اردیبهشت" Value="2"></asp:ListItem>
                                <asp:ListItem Text="خرداد" Value="3"></asp:ListItem>
                                <asp:ListItem Text="تیر" Value="4"></asp:ListItem>
                                <asp:ListItem Text="مرداد" Value="5"></asp:ListItem>
                                <asp:ListItem Text="شهریور" Value="6"></asp:ListItem>
                                <asp:ListItem Text="مهر" Value="7"></asp:ListItem>
                                <asp:ListItem Text="آبان" Value="8"></asp:ListItem>
                                <asp:ListItem Text="آذر" Value="9"></asp:ListItem>
                                <asp:ListItem Text="دی" Value="10"></asp:ListItem>
                                <asp:ListItem Text="بهمن" Value="11"></asp:ListItem>
                                <asp:ListItem Text="اسفند" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnApplyConditions" runat="server" Text="گزارش" 
                                    onclick="btnApplyConditions_Click" CssClass="buttonStyle" />
                            </td>
                            <td>
                                <asp:Button ID="btnReturn" runat="server" Text="بازگشت" CssClass="buttonStyle" 
                                    onclick="btnReturn_Click"/>
                            </td>
                        </tr>--%>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="MonthlyReportPanel" runat="server" GroupingText="گزارش کارکرد ماهیانه"
                        CssClass="panelStyle">
                        <table style="width: 100%; height: 100%">
                            <tr>
                                <td>
                                    <asp:GridView ID="MonthlyReportGrid" runat="server" AutoGenerateColumns="False" CssClass="gridStyle"
                                        AutoGenerateSelectButton="True">
                                        <Columns>
                                            <asp:BoundField DataField="FARSI_WEEK_DAY" HeaderText="روز">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" CssClass="gridCustomCellStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_Date" HeaderText="تاریخ">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" CssClass="gridCustomCellStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="prc_FirstIn" HeaderText="ورود اول">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_FirstOut" HeaderText="خروج اول">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_SecondIn" HeaderText="ورود دوم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_SecondOut" HeaderText="خروج دوم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_ThirdIn" HeaderText="ورود سوم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_ThirdOut" HeaderText="خروج سوم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_FourthIn" HeaderText="ورود چهارم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_FourthOut" HeaderText="خروج چهارم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_FifthIn" HeaderText="ورود پنجم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Prc_FifthOut" HeaderText="خروج پنجم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="HozurELazem" HeaderText="حضور لازم">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="HozurEVagheie" HeaderText="حضور واقعی">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EzafehkarGheiremojaz" HeaderText="اضافه کار غیر مجاز">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Ezafehkar" HeaderText="اضافه کار">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Keshik" HeaderText="کشیک">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MamHour" HeaderText="ماموریت ساعتی">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MorSaati" HeaderText="مرخصی ساعتی">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Ezterar" HeaderText="اضطرار">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="kasrekar" HeaderText="کسر کار">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MamRuz" HeaderText="ماموریت">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MorEstRuz" HeaderText="مرخصی">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MorDarRuz" HeaderText="استعلاجی الف">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MorDarRuzB" HeaderText="استعلاجی ب">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="MorBiHoghRuz" HeaderText="مرخصی بی حقوق">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="GheibatRuz" HeaderText="غیبت">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PishCardFullName" HeaderText="توضیحات">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle CssClass="gridHeaderStyle" />
                                        <SelectedRowStyle CssClass="gridSelectedRowStyle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

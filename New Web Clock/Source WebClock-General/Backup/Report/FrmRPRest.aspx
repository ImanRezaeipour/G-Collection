<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmRPRest.aspx.cs" Inherits="ASPWebclock.FrmRPRest" %>

<%@ Register Assembly="DevExpress.XtraReports.v11.1.Web, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 100%" class="bodyStyle">
            <tr>
                <td>
                    <table style="width: 500px;">
                        <tr>
                            <td colspan="5">
                                &nbsp
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="cmbYear" runat="server" Style="width: 150px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbMonth" runat="server" Style="width: 150px">
                                    <asp:ListItem Text="فروردین" Value="01"></asp:ListItem>
                                    <asp:ListItem Text="اردیبهشت" Value="02"></asp:ListItem>
                                    <asp:ListItem Text="خرداد" Value="03"></asp:ListItem>
                                    <asp:ListItem Text="تیر" Value="04"></asp:ListItem>
                                    <asp:ListItem Text="مرداد" Value="05"></asp:ListItem>
                                    <asp:ListItem Text="شهریور" Value="06"></asp:ListItem>
                                    <asp:ListItem Text="مهر" Value="07"></asp:ListItem>
                                    <asp:ListItem Text="آبان" Value="08"></asp:ListItem>
                                    <asp:ListItem Text="آذر" Value="09"></asp:ListItem>
                                    <asp:ListItem Text="دی" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="بهمن" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="اسفند" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnApplyConditions" runat="server" Text="گزارش" OnClick="btnApplyConditions_Click"
                                    CssClass="buttonStyle" />
                            </td>
                            <td>
                                &nbsp
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <dx:ReportToolbar ID="ReportToolbar1" runat="server" ReportViewerID="ReportViewer1"
                        ShowDefaultButtons="False">
                        <Items>
                            <dx:ReportToolbarButton ItemKind="Search" />
                            <dx:ReportToolbarSeparator />
                            <dx:ReportToolbarButton ItemKind="PrintReport" />
                            <dx:ReportToolbarButton ItemKind="PrintPage" />
                            <dx:ReportToolbarSeparator />
                            <dx:ReportToolbarButton Enabled="False" ItemKind="FirstPage" />
                            <dx:ReportToolbarButton Enabled="False" ItemKind="PreviousPage" />
                            <dx:ReportToolbarLabel ItemKind="PageLabel" />
                            <dx:ReportToolbarComboBox ItemKind="PageNumber" Width="65px">
                            </dx:ReportToolbarComboBox>
                            <dx:ReportToolbarLabel ItemKind="OfLabel" />
                            <dx:ReportToolbarTextBox IsReadOnly="True" ItemKind="PageCount" />
                            <dx:ReportToolbarButton ItemKind="NextPage" />
                            <dx:ReportToolbarButton ItemKind="LastPage" />
                            <dx:ReportToolbarSeparator />
                            <dx:ReportToolbarButton ItemKind="SaveToDisk" />
                            <dx:ReportToolbarButton ItemKind="SaveToWindow" />
                            <dx:ReportToolbarComboBox ItemKind="SaveFormat" Width="70px">
                                <Elements>
                                    <dx:ListElement Value="pdf" />
                                    <dx:ListElement Value="xls" />
                                    <dx:ListElement Value="xlsx" />
                                    <dx:ListElement Value="rtf" />
                                    <dx:ListElement Value="mht" />
                                    <dx:ListElement Value="html" />
                                    <dx:ListElement Value="txt" />
                                    <dx:ListElement Value="csv" />
                                    <dx:ListElement Value="png" />
                                </Elements>
                            </dx:ReportToolbarComboBox>
                            <dx:ReportToolbarButton Text="Return" />
                        </Items>
                        <ClientSideEvents ItemClick="function(s, e) {
	history.go(-1)
}" />
                        <Styles>
                            <LabelStyle>
                                <Margins MarginLeft='3px' MarginRight='3px' />
                            </LabelStyle>
                        </Styles>
                    </dx:ReportToolbar>
                    <dx:ReportViewer ID="ReportViewer1" runat="server">
                    </dx:ReportViewer>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="ASPWebclock.Report.ReportViewer" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="Stimulsoft.Report.Web" Namespace="Stimulsoft.Report.Web" TagPrefix="Sti" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/ReportViewer_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="ReportViewerForm" runat="server">
    <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right">
      <asp:Label ID="Label2" runat="server" Font-Names="tahoma" Font-Size="9pt">زمان محاسبه :</asp:Label>
    <asp:Label ID="Label1" runat="server" Font-Names="tahoma" Font-Size="9pt">00:00:00</asp:Label>
</div>
   <div id="divReportViewer">
        <Sti:StiWebViewer ID="StiReportViewer" runat="server"  Width="100%" 
            Height="309px" RenderMode="Standard"
            ButtonsImagesPath="Images" ToolBarBackColor="WhiteSmoke"  
            ButtonImagesPath="../img/ReportViewer/" 
            CacheMode="Page" PrintDestination="Direct">
        </Sti:StiWebViewer>
       
    </div>
   
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemainLeaveViewer.aspx.cs" Inherits="ASPWebclock.Operation.RemainLeaveViewer" %>

<%@ Register Assembly="Stimulsoft.Report.Web, Version=2011.3.1200.0, Culture=neutral, PublicKeyToken=ebe6666cba19647a" Namespace="Stimulsoft.Report.Web" TagPrefix="Sti" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/jquery-1.7.1.js"></script>
    <script src="../js/RemainLeave_onOperations.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: auto">
     <table style="width: 100%; margin-right: auto; margin-left: auto;">
                           <tr>
                               <td>
                                   <Sti:StiWebViewer ID="StiReportViewer" runat="server" Width="100%"
                                       Height="200px" RenderMode="Standard"
                                       ButtonsImagesPath="Images" ToolBarBackColor="WhiteSmoke"
                                       ButtonImagesPath="../img/ReportViewer/"
                                       CacheMode="Page" PrintDestination="Direct" ShowToolBar="False"></Sti:StiWebViewer>
                                
                               </td>
                             
                           </tr>
                            
                       </table>
    </div>
    </form>
</body>
</html>

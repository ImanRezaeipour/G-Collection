<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardManager.aspx.cs" Inherits="ASPWebclock.Operation.DashboardManager" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/DashboardManager_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="DashboardManagerForm" runat="server">
    <table dir="rtl" width="800px" align="right">
    <tr>
    <td valign="top">
    
        <dx:ASPxRoundPanel ID="ASPxRoundPanelPersonnelRequests" runat="server" 
            CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
            GroupBoxCaptionOffsetY="-28px" HeaderText="وضعیت درخواست ها" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css" Width="380px">
            <ContentPaddings Padding="14px" />
<ContentPaddings Padding="14px"></ContentPaddings>

            <HeaderStyle HorizontalAlign="Center" />
            <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
<table width="100%" cellpadding="8" cellspacing="5" 
        style="border: 2px dashed #C0C0C0;">
<tr>
<td width="80%">
    <dx:ASPxHyperLink ID="ASPxHyperLinkPersonRequestWaitAll" runat="server" 
        ClientInstanceName="HyperLinkPersonRequestWaitAll" 
        Text="تعداد درخواست های رسیده :" Cursor="pointer">
        <ClientSideEvents Click="HyperLinkPersonRequestWaitAll_onClick" />
    </dx:ASPxHyperLink>
    </td>
<td width="30%">
    <asp:Label ID="lblPersonRequestsWaitAll" runat="server"></asp:Label>
    </td>
</tr>
    <tr>
        <td width="80%">
         <dx:ASPxHyperLink ID="ASPxHyperLinkPersonRequestsWait"  ClientInstanceName="HyperLinkPersonRequestsWait"
                runat="server" Text="تعداد درخواست های رسیده در ماه:" Cursor="pointer">
                <ClientSideEvents Click="HyperLinkPersonRequestsWait_onClick" />
            </dx:ASPxHyperLink>
        </td>
        <td width="30%">
            <asp:Label ID="lblPersonRequestsWait" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td width="70%">
        <dx:ASPxHyperLink ID="ASPxHyperLinkPersonRequestsConfirm"  ClientInstanceName="HyperLinkPersonRequestsConfirm"
                runat="server" Text="تعداد درخواست های تایید شده در ماه :" Cursor="pointer">
                <ClientSideEvents Click="HyperLinkPersonRequestsConfirm_onClick" />
            </dx:ASPxHyperLink>
        </td>
        <td width="30%">
            <asp:Label ID="lblPersonRequestsConfirm" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td width="70%">
          <dx:ASPxHyperLink ID="ASPxHyperLinkPersonRequestsReject"  ClientInstanceName="HyperLinkPersonRequestsReject"
                runat="server" Text="تعداد درخواست های تایید نشده در ماه :" Cursor="pointer">
                <ClientSideEvents Click="HyperLinkPersonRequestsReject_onClick" />
            </dx:ASPxHyperLink>
            </td>
        <td width="30%">
            <asp:Label ID="lblPersonRequestsReject" runat="server"></asp:Label>
        </td>
    </tr>
</table>
</dx:PanelContent>
</PanelCollection>
        </dx:ASPxRoundPanel>
    
    </td>
    <td valign="top">
    
        <dx:ASPxRoundPanel ID="ASPxRoundPanelPersonnelStatus" runat="server" 
            CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" 
            GroupBoxCaptionOffsetY="-28px" HeaderText="وضعیت پرسنل" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css" Width="380px">
            <ContentPaddings Padding="14px" />
            <HeaderStyle HorizontalAlign="Center" />
            <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
<table width="100%" cellpadding="8" cellspacing="5" 
        style="border: 2px dashed #C0C0C0;">
<tr>
<td width="70%">
    پرسنل تحت مدیریت :
</td>
<td width="30%">
    <asp:Label ID="lblMangerPerson" runat="server"></asp:Label>
    </td>
</tr>
    <tr>
        <td width="70%">
            پرسنل حاضر در لحظه :</td>
        <td width="30%">
            <asp:Label ID="lblPersonPersent" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td width="70%">
            مجوز های مرخصی روزانه :</td>
        <td width="30%">
            <asp:Label ID="lblPersonLeaveDaily" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td width="70%">
            مجوز های مرخصی ساعتی :</td>
        <td width="30%">
            <asp:Label ID="lblPersonLeaveHourly" runat="server"></asp:Label>
        </td>
    </tr>
</table>
</dx:PanelContent>
</PanelCollection>
        </dx:ASPxRoundPanel>
    
    </td>
    </tr>
    </table>
    </form>
</body>
</html>

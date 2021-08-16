<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="HelpNWClock.Help" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>

<%@ Register assembly="ComponentArt.Web.UI" namespace="ComponentArt.Web.UI" tagprefix="ComponentArt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WebClock Help</title>
    <link href="css/treeStyle.css" rel="stylesheet" type="text/css" />
    <link href="css/HelpDesign.css" rel="stylesheet" type="text/css" />

    <script src="js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="js/HelpForm_onPageLoad.js" type="text/javascript"></script>
    <script src="js/HelpForm_Operations.js" type="text/javascript"></script>
    
</head>

<body bgcolor="#6c83c9">
    <form id="ClientHelpForm" runat="server" meta:resourcekey="ClientHelpForm">
    <div class="roundedcornr_box_590516" 
        style="background-image: url('image/111.jpg')">
   <div class="roundedcornr_top_590516"><div></div></div>
      <div class="roundedcornr_content_590516">
      </div>
      
     <div style="width: 100%; font-family: tahoma; font-size: 14pt; font-weight: bold; color: #FFFFFF; margin-bottom: 20px;" 
            align="center" dir="rtl">
            <asp:Label ID="lblHeader_Help" runat="server" 
                Text="راهنمای جامع نرم افزار&nbsp; Web Clock" Font-Size="14pt" Font-Bold="True" 
                Font-Names="tahoma" meta:resourcekey="lblHeader_Help"></asp:Label></div>
        
        <table style="width: 100%;">
            <tr >
                <td style="padding-left: 10px; width: auto;" align="center" dir="rtl" 
                    valign="top">
                    <div id="divContentHelp_HelpForm" style="display: none">
                    <iframe id="HelpForm_iFrame" width="100%" src="" runat="server" height="500" 
                        scrolling="auto" frameborder="1"></iframe></div></td>
                <td style="width: 300px; padding-right: 10px; font-family: tahoma; font-size: 9pt;"; 
                    align="right" dir="rtl" valign="top">
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="95%" 
                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                        GroupBoxCaptionOffsetY="-28px" HeaderText="" RightToLeft="True" 
                        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                        <ContentPaddings Padding="14px" />
                    <PanelCollection>
                    <dx:PanelContent runat="server">
                    
                    
                 <dx:ASPxCallbackPanel ID="CallBack_TreeViewHelpForm_HelpForm" 
                        ClientInstanceName="CallBack_TreeViewHelpForm_HelpForm" runat="server" 
                        oncallback="CallBack_TreeViewHelpForm_HelpForm_Callback" >
                    <PanelCollection>
                       <dx:PanelContent ID="PanelTreeViewHelpForm_HelpForm_Callback" runat="server">
                       <dx:ASPxTreeView ID="TreeViewHelpForm_HelpForm" 
                               ClientInstanceName="TreeViewHelpForm_HelpForm" runat="server" 
                        RightToLeft="True" Width="98%" AllowSelectNode="True">
                        
                        <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                            <NodeLoadingPanel Url="~/App_Themes/Aqua/Web/tvNodeLoading.gif">
                            </NodeLoadingPanel>
                            <LoadingPanel Url="~/App_Themes/Aqua/Web/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                        </Styles>
                        <ClientSideEvents NodeClick="function(s,e){ TreeViewHelpForm_HelpForm_onNodeSelect(e);}" />
                    </dx:ASPxTreeView>
                       </dx:PanelContent>
                    </PanelCollection>
                    <ClientSideEvents  EndCallback="CallBack_TreeViewHelpForm_HelpForm_onCallbackComplete" />
                    </dx:ASPxCallbackPanel>
                    </dx:PanelContent>
                    </PanelCollection>
                    </dx:ASPxRoundPanel>
                </td>
                
            </tr>
        </table>
    
     <div class="roundedcornr_bottom_590516"><div></div></div>
</div><br />
<asp:HiddenField ID="hf_TreeViewFormKey_HelpForm" runat="server" />
   
    </form>
</body>
</html>

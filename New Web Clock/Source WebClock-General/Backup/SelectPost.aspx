<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="SelectPost.aspx.cs" Inherits="ASPWebclock.SelectPost" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx1" %>
   
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <title>انتخاب پست</title>
    <script src="js/HelpForm_Operations.js" type="text/javascript"></script>
    <script src="js/SelectPost_onOperations.js" type="text/javascript"></script>
</head>
<body class="bodyStyle" style="background-color:#DFDFFF">
   
    <form id="form1" runat="server">
     <div style="border: 7px solid #FFFFFF">
                         <asp:Image ID="Image1" runat="server" BorderColor="#660033" BorderStyle="Solid" BorderWidth="2px"
                            Height="100px" ImageUrl="~/img/Header.jpg" Width="100%" />
                </div>]
                <br />
                <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_SelectPost" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_SelectPost">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_SelectPost" 
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
<div dir="rtl" align="center" style="width: 100%; background-color: #DFDFFF;">
<br />
<br />
<br />
<br />
<br />
    <dx:ASPxRoundPanel ID="ASPxRoundPanelPost" runat="server" Width="30%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="انتخاب پست" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="5px" />
              <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
    <dx:ASPxRadioButtonList ID="ASPxRadioButtonListPosts" runat="server" 
        AutoPostBack="True" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
        CssPostfix="Aqua" Cursor="pointer" 
        OnSelectedIndexChanged="ASPxRadioButtonListPosts_SelectedIndexChanged" 
        SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px" 
        Width="95%">
        <Border BorderWidth="0px" />
    </dx:ASPxRadioButtonList>
    
   
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel></div>
  
    </form>
</body>
</html>


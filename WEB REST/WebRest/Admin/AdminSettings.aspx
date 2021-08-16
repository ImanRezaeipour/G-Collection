<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSettings.aspx.cs" Inherits="WebRest.Admin.AdminSettings" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src ="../Scripts/AdminSettings_onOperations.js" type ="text/javascript"></script>
</head>
<body>
    <form id="AdminSettingsForm" runat="server">
    <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt; background-color: #FFFFFF;" align="right">
    
        <dx:ASPxRoundPanel ID="ASPxRoundPanelSettings" runat="server" 
            CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
            CssPostfix="Office2003Blue" EnableDefaultAppearance="False" 
            GroupBoxCaptionOffsetY="-25px" HeaderText="تنظیمات" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" Width="600px">
            <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
            <HeaderStyle>
            <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                PaddingRight="2px" />
            </HeaderStyle>
            <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
<table>
<tr>
<td>
<table cellpadding="5">
<tr>
<td>
از
</td>
<td>
 <dx:ASPxTextBox ID="ASPxTextBoxFromDateCount_AdminSettings" ClientInstanceName="TextBoxFromDateCount_AdminSettings" runat="server" 
        Width="30px" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
    </dx:ASPxTextBox>
</td>
<td>
<dx:ASPxComboBox ID="ASPxComboBoxFromDateType_AdminSettings" 
        ClientInstanceName="ComboBoxFromDateType_AdminSettings" runat="server" Width="80px" 
        RightToLeft="True" 
        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
        SelectedIndex="0">
    <Items>
        <dx:ListEditItem Selected="True" Text="روز" Value="0" />
        <dx:ListEditItem Text="هفته" Value="1" />
    </Items>
    <LoadingPanelImage Url="~/App_Themes/Office2003Blue/Web/Loading.gif">
    </LoadingPanelImage>
    </dx:ASPxComboBox>
</td>
<td>
  بعد به مدت 
</td>
<td>
<dx:ASPxTextBox ID="ASPxTextBoxEndDateCount_AdminSettings" ClientInstanceName="TextBoxEndDateCount_AdminSettings" runat="server" 
        Width="30px" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
    </dx:ASPxTextBox>
</td>
<td>
  <dx:ASPxComboBox ID="ASPxComboBoxEndDateType_AdminSettings" 
        ClientInstanceName="ComboBoxEndDateType_AdminSettings" runat="server" Width="80px" 
        RightToLeft="True" 
        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
        SelectedIndex="0">
      <Items>
          <dx:ListEditItem Selected="True" Text="روز" Value="0" />
          <dx:ListEditItem Text="هفته" Value="1" />
          <dx:ListEditItem Text="ماه" Value="2" />
      </Items>
      <LoadingPanelImage Url="~/App_Themes/Office2003Blue/Web/Loading.gif">
      </LoadingPanelImage>
    </dx:ASPxComboBox>
</td>
<td>
 اجازه رزرو غذا وجود دارد.
</td>
</tr>
</table>

   
</td>
</tr>
<tr>
<td>
<table cellpadding="5" width="80%">
<tr>
<td align="right">
    <dx:ASPxCheckBox ID="ASPxCheckBoxSupplement_AdminSettings" ClientInstanceName="CheckBoxSupplement_AdminSettings" Text="مخلفات" runat="server" 
        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
    </dx:ASPxCheckBox>
</td>
<td align="left">
حداکثر تعداد رزرو در هر ماه
</td>
<td align="right">
    <dx:ASPxTextBox ID="ASPxTextBoxMaxCountReserve_AdminSettings" ClientInstanceName="TextBoxMaxCountReserve_AdminSettings" runat="server" 
        Width="30px" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
    </dx:ASPxTextBox>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td ID="tdSaveButton_AdminSettings">
    <dx:ASPxButton ID="ASPxButtonSave_AdminSettings" ClientInstanceName="ButtonSave_AdminSettings" runat="server" Text="ثبت" 
        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
        CssPostfix="Office2003Blue" 
        SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" Width="100px" AutoPostBack="False">
        <ClientSideEvents Click="ButtonSave_AdminSettings_onClick" />
    </dx:ASPxButton>
</td>
</tr>
</table>
</dx:PanelContent>

</PanelCollection>
        </dx:ASPxRoundPanel>
        <dx:ASPxRoundPanel ID="ASPxRoundPanelPublicMessage" runat="server" 
            Width="600px" CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
            CssPostfix="Office2003Blue" EnableDefaultAppearance="False" 
            GroupBoxCaptionOffsetY="-25px" HeaderText="پیغام عمومی" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
            <ContentPaddings Padding="2px" PaddingBottom="10px" PaddingTop="10px" />
            <HeaderStyle>
            <Paddings Padding="0px" PaddingBottom="7px" PaddingLeft="2px" 
                PaddingRight="2px" />
            </HeaderStyle>
        <PanelCollection>
        <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
        <table width="100%">
        <tr>
        <td align="left">
            متن پیغام :</td>
        <td>
            <dx:ASPxTextBox ID="ASPxTextBoxMessage_AdminSettings" runat="server" 
                CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                CssPostfix="Office2003Blue" 
                SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" 
                Width="400px" ClientInstanceName="TextBoxMessage_AdminSettings">
            </dx:ASPxTextBox>
        </td>
        <td ID="tdSavePublicMessage_AdminSettings">
            <dx:ASPxButton ID="ASPxButtonSavePublicMessage_AdminSettings" runat="server" 
                AutoPostBack="False" ClientInstanceName="ButtonSavePublicMessage_AdminSettings" 
                CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                CssPostfix="Office2003Blue" 
                SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css" Text="ثبت" 
                Width="100px">
                <ClientSideEvents Click="ButtonSavePublicMessage_AdminSettings_onClick" />
            </dx:ASPxButton>
        </td>
        </tr>
        </table>
        </dx:PanelContent>
        </PanelCollection>
        </dx:ASPxRoundPanel>
        <dx:ASPxCallback ID="ASPxCallbackUpdateSetting_AdminSettings" 
            ClientInstanceName="CallbackUpdateSetting_AdminSettings" runat="server" 
            oncallback="ASPxCallbackUpdateSetting_AdminSettings_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){CallbackUpdateSetting_AdminSettings_callbackComplete(e);}" />
        <ClientSideEvents CallbackError="function(s,e){CallbackUpdateSetting_AdminSettings_callbackError(e);}" />
        </dx:ASPxCallback>
        <dx:ASPxCallback ID="ASPxCallbackUpdatePublicMessage_AdminSettings" 
            ClientInstanceName="CallbackUpdatePublicMessage_AdminSettings" runat="server" 
            oncallback="ASPxCallbackUpdatePublicMessage_AdminSettings_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){CallbackUpdatePublicMessage_AdminSettings_callbackComplete(e);}" />
        <ClientSideEvents CallbackError="function(s,e){CallbackUpdatePublicMessage_AdminSettings_callbackError(e);}" />
        </dx:ASPxCallback>
          <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
      
    </form>
</body>
</html>

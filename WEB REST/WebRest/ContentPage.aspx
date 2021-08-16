<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.Master" AutoEventWireup="true" CodeBehind="ContentPage.aspx.cs" Inherits="WebRest.ContentPage" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxSplitter" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Web Rest</title>
    <script src="Scripts/ContentPage_onOperations.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="NavbarContent" runat="server">
    <dx:ASPxNavBar ID="ASPxNavBarMain_ContentPage" ClientInstanceName="NavBarMain_ContentPage" runat="server" CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css"
        CssPostfix="PlasticBlue" RightToLeft="True" SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css"
        Width="243px" ClientSideEvents-ItemClick="function(s, e){NavBarMain_ContentPage_onClick(s, e)}">
        <Groups>
            <dx:NavBarGroup Name="OperationsGroup"  Text="عملیات" Visible="true">
                <Items>
                    <dx:NavBarItem Text="رزرو غذا" Name="FoodReserve.aspx" Visible="true">
                    </dx:NavBarItem>
                      <dx:NavBarItem Text="تغییر رمز عبور" Name="Account/ChangePassword.aspx" Visible="true">
                    </dx:NavBarItem>
                </Items>
            </dx:NavBarGroup>
            
            
        </Groups>
        <ItemImage>
            <SpriteProperties CssClass="dxWeb_nbItemBullet_PlasticBlue" />
            <SpriteProperties CssClass="dxWeb_nbItemBullet_PlasticBlue"></SpriteProperties>
        </ItemImage>
        <LoadingPanelImage Url="~/App_Themes/PlasticBlue/Web/nbLoading.gif">
        </LoadingPanelImage>
    </dx:ASPxNavBar>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageControlContent" runat="server">
    <dx:ASPxPageControl ID="ASPxPageControlContent_ContentPage" runat="server"
        ActiveTabIndex="1" ClientInstanceName="PageControlContent_ContentPage" 
        SpritseCssFilePath="~/App_Themes/Glass/{0}/sprite.css"  RightToLeft="True" 
        CssFilePath="~/App_Themes/Glass/{0}/styles.css" CssPostfix="Glass" 
        SpriteCssFilePath="~/App_Themes/Glass/{0}/sprite.css" TabSpacing="0px">
        <TabPages>
            <dx:TabPage   Name="FoodReserve.aspx" Text="رزرو غذا"
                ClientVisible="False" ActiveTabStyle-VerticalAlign="NotSet">
                <ContentCollection>
                    <dx:ContentControl ID="FoodReserve" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
           
          <dx:TabPage  Name="Account/ChangePassword.aspx" Text="تغییر رمز عبور"
                ClientVisible="False" ActiveTabStyle-VerticalAlign="NotSet">
                <ContentCollection>
                    <dx:ContentControl ID="ChangePassword" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
        <LoadingPanelImage Url="~/App_Themes/Glass/Web/Loading.gif">
        </LoadingPanelImage>
        <ActiveTabTemplate>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="white-space: nowrap;">
                        <dx:ASPxLabel ID="Label1" runat="server" Text="<%# Container.TabPage.Text %>" Font-Names="Tahoma"
                            ForeColor="#FFFFFFF" />
                    </td>
                    <td>
                        &nbsp
                    </td>
                    <td>
                        <dx:ASPxImage ID="ASPxImageExitTab_ContentPage" ClientInstanceName="ImageExitTab_ContentPage" runat="server" ImageUrl="~/Image/DesignImage/exit.png">
                            <ClientSideEvents Click="function(s, e) {ImageExitTab_ContentPage_onClick();}" />
                        </dx:ASPxImage>
                    </td>
                </tr>
            </table>
        </ActiveTabTemplate>
        <Paddings PaddingLeft="0px" />
        <ContentStyle>
            <Border BorderColor="#4986A2" />
        </ContentStyle>
    </dx:ASPxPageControl>
</asp:Content>

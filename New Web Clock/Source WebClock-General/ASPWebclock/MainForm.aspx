<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="MainForm.aspx.cs" Inherits="ASPWebclock.MainForm" %>

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
<title>Web Clock</title>
    <script src="js/MainForm_onOperations.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="NavbarContent" runat="server">
    <dx:ASPxNavBar ID="ASPxNavBar" ClientInstanceName="ASPxNavBar" runat="server" CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css"
        CssPostfix="PlasticBlue" RightToLeft="True" SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css"
        Width="243px" ClientSideEvents-ItemClick="function(s, e){NavbarClicked(s, e)}">
        <Groups>
            <dx:NavBarGroup Name="Monthly"  Text="عملیات ماهانه" Visible="false">
                <Items>
                    <dx:NavBarItem Text="گزارش کارکرد ماهیانه" Name="report/DevMonthlyReport.aspx" Visible="false">
                    </dx:NavBarItem>
                     <dx:NavBarItem Text="درخواست های ثبت شده" Name="operation/DashboardUser.aspx" Visible="false">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="کارتابل درخواست ها" Name="operation/Dashbord.aspx" Visible="false">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="کارتابل مدیریت" Name="operation/DashboardManager.aspx" Visible="false">
                    </dx:NavBarItem>
                     <dx:NavBarItem Text="ثبت تردد" Name="operator/TrafficRequestOperator.aspx" Visible="false">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="مدیر جانشین" Name="operation/DefineInsteadMan.aspx" Visible="false">
                    </dx:NavBarItem>
                </Items>
            </dx:NavBarGroup>
            <dx:NavBarGroup Name="Report" Text="گزارشات" Visible="false">
             <Items>
                    <dx:NavBarItem Text="گزارش" Name="report/Report.aspx" Visible="false">
                    </dx:NavBarItem>
                </Items>
                <Items>
                    <dx:NavBarItem Text="گزارش رستوران" Name="report/FrmRPRest.aspx" Visible="false">
                    </dx:NavBarItem>
                </Items>
            </dx:NavBarGroup>
            <dx:NavBarGroup Name="OperatorSys" Text="عملیات سیستمی" Visible="false">
                <Items>
                    <dx:NavBarItem Text="ثبت شماره پلاک" Name="Pelak/Pelak.aspx" Visible="false">
                    </dx:NavBarItem>
                    
                    <dx:NavBarItem Text="تغییر رمز عبور" Name="auth/ChangePassword.aspx" Visible="false">
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
    <dx:ASPxPageControl ID="ASPxPageControlMain" runat="server"
        ActiveTabIndex="3"   CssFilePath="~/App_Themes/Glass/{0}/styles.css"
        CssPostfix="Glass" ClientInstanceName="PageControl" 
        SpritseCssFilePath="~/App_Themes/Glass/{0}/sprite.css" ShowTabs="True" 
        TabAlign="Left" TabSpacing="0px"  RightToLeft="True" RenderMode="Classic">
        <Paddings PaddingLeft="0px"></Paddings>
        <TabPages>
            <dx:TabPage  NewLine="True" Name="report/DevMonthlyReport.aspx" Text="گزارش کارکرد ماهیانه"
                ClientVisible="False" ActiveTabStyle-VerticalAlign="NotSet">
                <ContentCollection>
                    <dx:ContentControl ID="ReportMonthly" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="درخواست های ثبت شده" Name="operation/DashboardUser.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="کارتابل درخواست ها" Name="operation/Dashbord.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="کارتابل مدیریت" Name="operation/DashboardManager.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl5" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="ثبت تردد" Name="operator/TrafficRequestOperator.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="مدیر جانشین" Name="operation/DefineInsteadMan.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl3" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
             <dx:TabPage Text="گزارش" Name="report/Report.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl4" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="گزارش رستوران" Name="report/FrmRPRest.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="ثبت شماره پلاک" Name="Pelak/Pelak.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="تغییر رمز عبور" Name="auth/ChangePassword.aspx" ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
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
                        <dx:ASPxImage ID="ASPxImage1" runat="server" ImageUrl="~/img/exit.png">
                            <ClientSideEvents Click="function(s, e) {t = setTimeout('CloseTabPage()', 1);}" />
                        </dx:ASPxImage>
                    </td>
                </tr>
            </table>
        </ActiveTabTemplate>
        <Paddings PaddingLeft="0px" />
        <ContentStyle>
            <Border BorderColor="#4986A2" />
            <Border BorderColor="#4986A2"></Border>
        </ContentStyle>
    </dx:ASPxPageControl>
</asp:Content>

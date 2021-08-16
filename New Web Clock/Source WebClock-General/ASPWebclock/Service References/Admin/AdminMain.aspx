<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminMain.aspx.cs" Inherits="ASPWebclock.Admin.AdminMain" %>
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
    <link href="../css/DropDownListStyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/Tab.css" rel="stylesheet" type="text/css" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="NavbarContent" runat="server">
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/AdminMain_Oprations.js" type="text/javascript"></script>
    <script src="../js/HelpForm_Operations.js" type="text/javascript"></script>
<dx:ASPxNavBar ID="ASPxNavBar" ClientInstanceName="ASPxNavBar" runat="server" CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css"
        CssPostfix="PlasticBlue" RightToLeft="True" SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css"
        Width="243px" ClientSideEvents-ItemClick="function(s, e){NavbarClicked(s, e)}">
        <Groups>
            <dx:NavBarGroup Text="عملیات">
            <Items>
                    <dx:NavBarItem Text="معرفی کاربران" Name="../Admin/DefinePersonnel.aspx">
                    </dx:NavBarItem>
                    
                </Items>
                <Items>
                    <dx:NavBarItem Text="معرفی مدیر و اپراتور" Name="../Admin/DefineAdminOperator.aspx">
                    </dx:NavBarItem>
                    
                </Items> <Items>
                    <dx:NavBarItem Text="معرفی پرسنل تحت مدیریت" Name="../Admin/DefineManagerPersonnel.aspx">
                    </dx:NavBarItem>
                    
                </Items>
                <Items>
                    <dx:NavBarItem Text="دسترسی نقش ها" Name="../Admin/AdminAccessRoleNavbar.aspx">
                    </dx:NavBarItem>
                    
                </Items>
                <Items>
                    <dx:NavBarItem Text="دسترسی گزارش ها" Name="../Admin/AdminAccessReports.aspx">
                    </dx:NavBarItem> 
                </Items>
                <Items>
                    <dx:NavBarItem Text="وقایع" Name="../Admin/Log.aspx">
                    </dx:NavBarItem> 
                </Items>
            </dx:NavBarGroup>
           <dx:NavBarGroup Text="تنظیمات">
            <Items>
                    <dx:NavBarItem Text="تعریف کاربران پیش فرض" Name="../Admin/DefineDefultUser.aspx">
                    </dx:NavBarItem>
                    </Items>
                    <Items>
                    <dx:NavBarItem Text="تغییر رمز عبور" Name="../Admin/AdminChangePassword.aspx">
                    </dx:NavBarItem>
                    </Items>
                     <Items>
                    <dx:NavBarItem Text="درباره..." Name="../Admin/AdminInfo.aspx">
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
<asp:Content ID="Content3" ContentPlaceHolderID="PageControlContent" runat="server">
<dx:ASPxPageControl ID="ASPxPageControlAdmin" runat="server"
        ActiveTabIndex="0" Height="810px" BackColor="#DFDFFF" CssFilePath="~/App_Themes/Glass/{0}/styles.css"
        CssPostfix="Glass" ClientInstanceName="PageControl" 
        SpritseCssFilePath="~/App_Themes/Glass/{0}/sprite.css" ShowTabs="True" 
        TabAlign="Left" TabSpacing="0px"  RightToLeft="True" RenderMode="Classic">
        <Paddings PaddingLeft="0px"></Paddings>
        <TabPages>         
            <dx:TabPage NewLine="True" Name="../Admin/DefinePersonnel.aspx" Text="معرفی کاربران"
                ClientVisible="False" ActiveTabStyle-VerticalAlign="NotSet">
                <ContentCollection>
                    <dx:ContentControl  ID="ContentControl7" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage  Name="../Admin/DefineAdminOperator.aspx" Text="معرفی مدیر و اپراتور"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
               <dx:TabPage  Name="../Admin/DefineManagerPersonnel.aspx" Text="معرفی پرسنل تحت مدیریت"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl3" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
             <dx:TabPage  Name="../Admin/AdminAccessRoleNavbar.aspx" Text="دسترسی نقش ها"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl4" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage  Name="../Admin/AdminAccessReports.aspx" Text="دسترسی گزارش ها"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl9" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage  Name="../Admin/Log.aspx" Text="وقایع"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl8" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage  Name="../Admin/DefineDefultUser.aspx" Text="تعریف کاربران پیش فرض"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl5" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage  Name="../Admin/AdminChangePassword.aspx" Text="تغییر رمز عبور"
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl6" runat="server" SupportsDisabledAttribute="True">
                        <!--iframe will be inserted here-->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
             <dx:TabPage  Name="../Admin/AdminInfo.aspx" Text="درباره .."
                ClientVisible="false">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
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

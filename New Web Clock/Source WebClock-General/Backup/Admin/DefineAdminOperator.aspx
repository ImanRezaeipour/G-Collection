<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefineAdminOperator.aspx.cs"
    Inherits="ASPWebclock.Admin.DefineAdminOperator" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCloudControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx1" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>معرفی مدیر و اپراتور</title>
    <link href="../css/DropDownListStyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/buttonStyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/DefineAdminOperator_Operations.js" type="text/javascript"></script>
   
    <style type="text/css">
        #divImgLoading
        {
            right: 1179px;
        }
    </style>
</head>
<body>
    <form id="DefineAdminOperatorform" runat="server" onsubmit="return false;">
    <div id="divMain" style="width: 100%; font-family: tahoma; font-size: 8pt;">
        <div id="divHeaderMenu"  dir="rtl" style="width: 100%;" align="right">
            <dx:ASPxMenu ID="ASPxMenu1" runat="server" AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" ClientInstanceName="MenuHeader">
                <Items>
                    <dx:MenuItem Text="ثبت" Name="Save">
                        <Image Url="~/img/save.png">
                        </Image>
                    </dx:MenuItem>
                   <dx:MenuItem Name="Help_DefineAdminOperator" 
        Text="راهنما" Enabled="True">
<Image Url="~/img/help.gif"></Image>
</dx:MenuItem>
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuClick(e);}" />
            </dx:ASPxMenu>
          
            </div>
       
        <br />
        <div dir="rtl" style="width: 100%" align="right">
            
            <dx:ASPxRoundPanel ID="ASPxRoundPanelSearch" runat="server" Width="90%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="جستجوی پرسنل" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="14px" />
<ContentPaddings Padding="14px"></ContentPaddings>
              <PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
<table id="tableSearch" style="width: 100%" dir="rtl">
                    <tr>
                        <td valign="top" align="left">
                            عبارت جستجو
                            <br />
                        </td>
                        <td align="right" valign="top">
                            <input id="txtSearchPersonnel" type="text" style="width: 80%; font-family: tahoma;
                                font-size: 9pt;"  onkeypress="txtSearchEnterKeyPressDoingSearch(event);"/>
                            &nbsp;
                            <img  id="btnSearchPersonnel" alt="" src="../img/search.png"  height="16px" width="16px" class="ImageButtonStyle"
                                onclick="onClickbtnSearchPersonnel();" />
                        </td>
                        <td align="right" valign="top">
                            &nbsp;
                        </td>
                        <td align="right" valign="top">
                            &nbsp;
                        </td>
                        <td align="right" valign="top">
                            &nbsp;</td>
                        <td align="right" valign="top">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="width: 10%" align="left">
                            نتایج جستجو
                        </td>
                        <td align="right" valign="top" style="width: 30%">
                            <dx:ASPxDropDownEdit ID="ASPxDropDownEditPersonnelSearch" 
                                                ClientInstanceName="DropDownEditPersonnelSearch" 
                                runat="server" PopupHorizontalAlign="RightSides" 
                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                ShowShadow="False" Width="95%" 
                                DropDownWindowStyle-HorizontalAlign="Center" 
                                DropDownWindowStyle-VerticalAlign="Top">
                                                <DropDownWindowTemplate>
                                                
                                                    <dx:ASPxGridView ID="ASPxGridViewPersonnelSearch" ClientInstanceName="GridViewPersonnelSearch" runat="server" AutoGenerateColumns="False" 
                                                         CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                                                        CssPostfix="PlasticBlue" KeyFieldName="BarCode" Width="400px" Styles-Row-Cursor="pointer" OnCustomCallback="ASPxGridViewPersonnelSearch_CustomCallback" >
                                                        <ClientSideEvents FocusedRowChanged="function(s, e) {GridViewPersonnelSearch_onFocusedRowChanged(s,e);}" />
                                                        <ClientSideEvents RowClick="function(s,e){GridViewPersonnelSearch_onRowClick();}" />
                                                        <ClientSideEvents EndCallback="function(s,e){GridViewPersonnelSearch_EndCallback()}" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="BarCode" VisibleIndex="1" 
                                                                Caption="کد پرسنلی" ShowInCustomizationForm="True" >
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="2" Caption="نام" 
                                                                ShowInCustomizationForm="True" >
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Family" VisibleIndex="3" 
                                                                Caption="نام خانوادگی" ShowInCustomizationForm="True" >
                                                                <Settings AutoFilterCondition="Contains" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <CellStyle HorizontalAlign="Right">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" 
                                                            AutoFilterRowInputDelay="3000" />
                                                        
                                                        <Images SpriteCssFilePath="~/App_Themes/Glass/{0}/sprite.css">
                                                            <LoadingPanelOnStatusBar Url="~/App_Themes/Glass/GridView/gvLoadingOnStatusBar.gif">
                                                            </LoadingPanelOnStatusBar>
                                                            <LoadingPanel Url="~/App_Themes/Glass/GridView/Loading.gif">
                                                            </LoadingPanel>
                                                        </Images>
                                                        <ImagesFilterControl>
                                                            <LoadingPanel Url="~/App_Themes/Glass/Editors/Loading.gif">
                                                            </LoadingPanel>
                                                        </ImagesFilterControl>
                                                        <Styles CssFilePath="~/App_Themes/Glass/{0}/styles.css" CssPostfix="Glass">
                                                            <Header ImageSpacing="5px" SortingImageSpacing="5px">
                                                            </Header>
                                                        </Styles>
                                                        <StylesEditors>
                                                            <CalendarHeader Spacing="1px">
                                                            </CalendarHeader>
                                                            <ProgressBar Height="25px">
                                                            </ProgressBar>
                                                        </StylesEditors>
                                                        <SettingsPager>
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>
                                                    </dx:ASPxGridView>
                                                    
                                                </DropDownWindowTemplate>

<DropDownWindowStyle HorizontalAlign="Center" VerticalAlign="Top"></DropDownWindowStyle>

                                                <DropDownButton>
                                                    <Image>
                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                                    </Image>
                                                </DropDownButton>
                                                <ButtonEditEllipsisImage Height="3px" 
                                                    Url="~/App_Themes/Aqua/Editors/edtEllipsis.png" 
                                                    UrlDisabled="~/App_Themes/Aqua/Editors/edtEllipsisDisabled.png" 
                                                    UrlHottracked="~/App_Themes/Aqua/Editors/edtEllipsisHottracked.png" 
                                                    UrlPressed="~/App_Themes/Aqua/Editors/edtEllipsisPressed.png" Width="12px">
                                                </ButtonEditEllipsisImage>
                                                <ValidationSettings>
                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                        <ErrorTextPaddings PaddingLeft="4px" />
                                                    </ErrorFrameStyle>
                                                </ValidationSettings>
                                            </dx:ASPxDropDownEdit>
                        </td>
                        <td align="left" valign="top" style="width: 10%">
                            نام پست
                        </td>
                        <td align="right" valign="top" style="width: 30%">
                            <dx:ASPxComboBox ID="cbResultSearchUsers" runat="server" CallbackPageSize="10" ClientInstanceName="ComboBoxResultSearchUsers"
                                DropDownRows="10" EnableCallbackMode="True" OnCallback="cbResultSearchUsers_Callback"
                                RightToLeft="True" ValueType="System.String" Width="90%" 
                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                LoadingPanelImagePosition="Top" ShowShadow="False" 
                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                <ClientSideEvents EndCallback="ComboBoxResultSearchUsersEndCallback" />
                                <ClientSideEvents SelectedIndexChanged="ComboBoxResultSearchUsersSelectedIndexChanged" />
<ClientSideEvents EndCallback="ComboBoxResultSearchUsersEndCallback" SelectedIndexChanged="ComboBoxResultSearchUsersSelectedIndexChanged"></ClientSideEvents>

                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                </LoadingPanelImage>
                                <DropDownButton>
                                    <Image>
                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
                                    </Image>
                                </DropDownButton>
                                <ValidationSettings>
                                    <ErrorFrameStyle ImageSpacing="4px">
                                        <ErrorTextPaddings PaddingLeft="4px" />
<ErrorTextPaddings PaddingLeft="4px"></ErrorTextPaddings>
                                    </ErrorFrameStyle>
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                        </td>
                        <td align="right" style="width: 25%" valign="top">
                            <dx:ASPxMenu ID="ASPxMenuPostOfPerson" runat="server" AutoSeparators="RootOnly" 
                                ClientInstanceName="MenuHeaderPost" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                CssPostfix="Aqua" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
                                GutterImageSpacing="7px" RightToLeft="True" ShowPopOutImages="True" 
                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                <ClientSideEvents ItemClick="function(s, e){onItemMenuPostClick(e);}" />
<ClientSideEvents ItemClick="function(s, e){onItemMenuPostClick(e);}"></ClientSideEvents>
                                <Items>
                                    <dx:MenuItem Name="Save"  Text="پست جدید">
                                        <Image Url="~/img/add.png">
                                        </Image>
                                    </dx:MenuItem>
                                </Items>
                                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                                </LoadingPanelImage>
                                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

                                <ItemStyle Cursor="pointer" DropDownButtonSpacing="12px" 
                                    PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px" 
                                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" />
                                <SubMenuStyle GutterWidth="0px" />

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
                            </dx:ASPxMenu>
                        </td>
                        <td align="center" valign="top" style="width: 10%">
                        <dx:ASPxMenu ID="ASPxMenuViewResultSearchUser" runat="server" AutoSeparators="RootOnly" 
                                ClientInstanceName="MenuHeaderViewResultSearchUser" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                CssPostfix="Aqua" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
                                GutterImageSpacing="7px" RightToLeft="True" ShowPopOutImages="True" 
                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                <ClientSideEvents ItemClick="function(s, e){onItemMenuViewResultClick(e);}" />
                                
                                <Items>
                                    <dx:MenuItem Name="View"  Text="نمایش">
                                        
                                   
                                    </dx:MenuItem>
                                </Items>
                                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                                </LoadingPanelImage>
                                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

                                <ItemStyle Cursor="pointer" DropDownButtonSpacing="12px" 
                                    PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px" 
                                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" />
                                <SubMenuStyle GutterWidth="0px" />

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
                            </dx:ASPxMenu>
                            &nbsp;</td>
                    </tr>
                </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
            
        </div>
        <br />
        <div dir="rtl" style="width: 100%; ">
            <div dir="rtl" style="float: right">
            <dx:ASPxRoundPanel ID="ASPxRoundPanelStatus" runat="server" Width="260px" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="وضعیت" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">

                <dx:ASPxCallbackPanel ID="ASPxCallbackPanelUserStatus" runat="server" ClientInstanceName="ASPxCallbackPanelUserStatus"
                    Width="100%" OnCallback="ASPxCallbackPanelUserStatus_Callback">
                    <PanelCollection>
                        <dx:PanelContent runat="server" ID="ContentStatus" SupportsDisabledAttribute="True">
                        

                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <dx:ASPxTreeView ID="ASPxTreeViewStatusUser" runat="server" AllowSelectNode="True"
                                                ClientInstanceName="TreeViewStatusUser" RightToLeft="True" Width="230px">
                                            <ClientSideEvents NodeClick="function(s,e){ onClickTreeViewStatusUser(e);}" />
<ClientSideEvents NodeClick="function(s,e){ onClickTreeViewStatusUser(e);}"></ClientSideEvents>
                                                <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                    <NodeLoadingPanel Url="~/App_Themes/Aqua/Web/tvNodeLoading.gif">
                                                    </NodeLoadingPanel>
                                                    <LoadingPanel Url="~/App_Themes/Aqua/Web/Loading.gif">
                                                    </LoadingPanel>
                                                </Images>
                                                <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                                                </Styles>
                                                <Nodes>
                                                    <dx:TreeViewNode Expanded="True" Name="root" Text="نقش ها" AllowCheck="False" 
                                                        Enabled="False">
                                                        <Nodes>
                                                            <dx:TreeViewNode Text="مدیر واحد" Name="modir">
                                                                <Nodes>
                                                                    <dx:TreeViewNode Name="3" Text="تایید اولیه" 
                                                                        ToolTip="به فردي گفته مي شود که تعدادي از پرسنل تحت مديريت او هستند , و در جریان تاییدات درخواست های پرسنل  در سطح اول قرار دارد . اگر اين افراد آيتم ساعتي يا روزانه درخواست کنند ابتدا باید  به تاييد مدير اولیه خود برسانند.( در صورتی که برای تایید درخواست تایید مدیر اولیه کافی باشد میبایست گزینه تایید کننده نهایی را برای مدیر اولیه فعال گردد )">
                                                                    </dx:TreeViewNode>
                                                                    <dx:TreeViewNode Name="6" Text="تایید ثانویه" 
                                                                        ToolTip="به فردي گفته مي شود که تعدادي از پرسنل تحت مديريت او هستند , و در جریان تاییدات درخواست های پرسنل  در سطح  میانی قرار دارد و درخواستها پس از تایید مدیر اولیه در کارتابل وی دیده می شود . (در صورتی که برای تایید درخواست تایید مدیر اولیه  و سپس مدیر ثانویه کافی باشد میبایست گزینه تایید کننده نهایی را برای مدیر ثانویه فعال گردد )">
                                                                    </dx:TreeViewNode>
                                                                    <dx:TreeViewNode Name="2" Text="تایید نهایی" 
                                                                        ToolTip="به فردي گفته مي شود که تعدادي از پرسنل تحت مديريت او هستند , و در جریان تاییدات درخواست های پرسنل  در سطح  نهایی قرار دارد و درخواستها پس از تایید  دو مدیر اولیه و ثانویه  در کارتابل وی دیده می شود . تایید درخواست توسط وی به منزله تایید نهایی درخواست می باشد . ">
                                                                    </dx:TreeViewNode>
                                                                </Nodes>
                                                            </dx:TreeViewNode>
                                                            <dx:TreeViewNode Name="1" Text="مدیر حضور غیاب" 
                                                                ToolTip="به فردي گفته مي شود که در سازمان  می تواند به کلیه درخواستهایی صادر شده از طرف پرسنل  دسترسی داشته باشد وی مسئول تاييد درخواستهای ساعتي و يا روزانه اي است وی می تواند این درخواستها را در هر مرحله ای از تایید مشاهده و تایید نهایی نماید .">
                                                            </dx:TreeViewNode>
                                                            <dx:TreeViewNode Name="4" Text="اپراتور" 
                                                                ToolTip="به فردي گفته مي شود که مسئول ورود درخواستها و آيتم هاي ساعتي ، روزانه پرسنل يک یا چند بخش است.">
                                                            </dx:TreeViewNode>
                                                            <dx:TreeViewNode Name="5" Text="گزارش گیر" 
                                                                ToolTip="فردی که به گزارشات ورود و خروج و درخواست های پرسنل دسترسی دارد.">
                                                            </dx:TreeViewNode>
                                                            <dx:TreeViewNode Name="7" Text="کاربر عادی" 
                                                                ToolTip="پرسنل سازمان هستند که در سیستم می توانند گزارش کارکرد ماهیانه خود را مشاهده و درخواستهای خود را در سیستم ثبت نمایند .">
                                                            </dx:TreeViewNode>
                                                        </Nodes>
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                            </dx:ASPxTreeView>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <dx:ASPxCheckBox ID="ASPxCheckBoxisAcceptOwner" runat="server" Text="حق تایید درخواست های شخصی "
                                        RightToLeft="True" ClientInstanceName="ASPxCheckBoxisAcceptOwner" 
                                        CheckState="Unchecked" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                        CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                        TextSpacing="2px">
                                    </dx:ASPxCheckBox>
                                </div>
                                <div>
                                 <dx:ASPxCheckBox ID="ASPxCheckBoxisFinalManager" runat="server" Text="تایید کننده نهایی "
                                        RightToLeft="True" ClientInstanceName="ASPxCheckBoxisFinalManager" 
                                        CheckState="Unchecked" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                        CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                        TextSpacing="2px">
                                    </dx:ASPxCheckBox>
                                </div>
                            
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxCallbackPanel>
                </dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
            </div>
            <div dir="rtl" style="width: 57%; float: right; padding-right: 20px;">
                <dx:ASPxPageControl ID="ASPxPageControlPishCardRules" runat="server" Width="100%"
                    ActiveTabIndex="0" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                    TabSpacing="3px">
                    <TabPages>
                        <dx:TabPage Text="تنظیم پیش کارت ها">
                            <ContentCollection>
                                <dx:ContentControl runat="server" ID="contetn1">
                                
                                    <asp:Panel ID="Panel1" runat="server" Width="100%" Font-Names="tahoma" Font-Size="9pt"
                                        Direction="RightToLeft">
                                        <table dir="rtl" style="width: 100%">
                                            <tr>
                                                <td align="center" style="width: 45%" valign="top">
                                                    <dx:ASPxCallbackPanel ID="CallbackPanelDeniedPishcards" runat="server" 
                                                        ClientInstanceName="CallbackPanelDeniedPishcards"
                                                        OnCallback="CallbackPanelDeniedPishcards_onCallback">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                                <dx:ASPxListBox ID="lbPishCardPersonnelDeny" runat="server" 
                                                                    CallbackPageSize="500" ClientInstanceName="lbPishCardPersonnelDeny" 
                                                                    RightToLeft="True" Width="90%" EnableSynchronization="False">
                                                                </dx:ASPxListBox>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </td>
                                                <td style="width: 10%">
                                                    <table dir="rtl" style="width: 100%">
                                                        <tr>
                                                            <td align="center">
                                                                <img id="AddPishCard" alt="" src="../img/1leftarrow.png" height="16px" onclick="onClickAddPishCard();"
                                                                    width="16px" class="ImageButtonStyle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <img id="AddAllPishCard" alt="" src="../img/2leftarrow.png" height="16px" onclick="onClickAddAllPishCard()"
                                                                    width="16px" class="ImageButtonStyle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <img id="RemovePishCard" alt="" src="../img/1rightarrow.png" height="16px" onclick="onClickRemovePishCard()"
                                                                    width="16px" class="ImageButtonStyle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <img id="RemoveAllPishCard" alt="" height="16px" src="../img/2rightarrow.png" onclick="onClickRemoveAllPishCard()"
                                                                    width="16px" class="ImageButtonStyle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="center" style="width: 45%" valign="top">
                                                    <dx:ASPxCallbackPanel ID="CallbackPanelAllowPishcards" runat="server" 
                                                        ClientInstanceName="CallbackPanelAllowPishcards" 
                                                        OnCallback="CallbackPanelAllowPishcards_onCallBack">
                                                        <PanelCollection>
                                                            <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                                <dx:ASPxListBox ID="lbPishCardPersonnelAllow" runat="server" 
                                                                    ClientInstanceName="lbPishCardPersonnelAllow" RightToLeft="True" Width="90%" EnableSynchronization="False">
                                                                </dx:ASPxListBox>
                                                                <asp:HiddenField ID="hfAllowedPishcards" runat="server" />
                                                                <dx:ASPxHiddenField ID="ASPxHiddenFieldAllowedPishcards" runat="server" 
                                                                    ClientInstanceName="HiddenFieldAllowedPishcards">
                                                                </dx:ASPxHiddenField>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Text="مقررات مجوز اضافه کاری">
                            <ContentCollection>
                                <dx:ContentControl runat="server" ID="content2">
                                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanelOverTime" runat="server" Width="100%"
                                        OnCallback="ASPxCallbackPanelOverTime_Callback" ClientInstanceName="ASPxCallbackPanelOverTime"
                                        RightToLeft="True">
                                        <ClientSideEvents EndCallback="ASPxCallbackPanelOverTimeEmdCallback"></ClientSideEvents>
                                        <PanelCollection>
                                            <dx:PanelContent runat="server">
                                                <table style="width: 100%" align="right" dir="rtl">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxCheckBox ID="ASPxCheckBoxAgreeAddWork" runat="server" Text="  اجازه تایید مجوز اضافه کاری"
                                                                ClientInstanceName="ASPxCheckBoxAgreeAddWork" 
                                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px">
                                                                <ClientSideEvents CheckedChanged="ASPxCheckBoxAgreeAddWorkCheckedChanged" />
<ClientSideEvents CheckedChanged="ASPxCheckBoxAgreeAddWorkCheckedChanged"></ClientSideEvents>
                                                            </dx:ASPxCheckBox>
                                                        </td>
                                                        <td align="left">
                                                            &nbsp;</td>
                                                        <td align="right">
                                                            <dx:ASPxComboBox ID="ASPxComboBoxTopMan" runat="server" ValueType="System.String"
                                                                RightToLeft="True" ClientInstanceName="ASPxComboBoxTopMan" CallbackPageSize="10"
                                                                DropDownRows="10" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                                                                CssPostfix="Aqua" LoadingPanelImagePosition="Top" ShowShadow="False" 
                                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" Visible="False">
                                                                <Columns>
                                                                    <dx:ListBoxColumn Caption="نام" FieldName="TopManName" />
                                                                    <dx:ListBoxColumn Caption="نام خانوادگی" FieldName="TopManFamily" />
                                                                    <dx:ListBoxColumn Caption="نام پست" FieldName="TopManUserName" />
                                                                </Columns>
                                                                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                                                </LoadingPanelImage>
                                                                <DropDownButton>
                                                                    <Image>
                                                                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                                                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
                                                                    </Image>
                                                                </DropDownButton>
                                                                <ValidationSettings>
                                                                    <ErrorFrameStyle ImageSpacing="4px">
                                                                        <ErrorTextPaddings PaddingLeft="4px" />
<ErrorTextPaddings PaddingLeft="4px"></ErrorTextPaddings>
                                                                    </ErrorFrameStyle>
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <table align="center" style="width: 100%;">
                                                                <tr>
                                                                    <td style="width: 10%">
                                                                        حداکثر
                                                                    </td>
                                                                    <td style="width: 10%" align="left">
                                                                        <dx:ASPxSpinEdit ID="ASPxSpinAddWorkHour" runat="server" Height="21px" MaxValue="24"
                                                                            Number="0" Width="50px" ClientInstanceName="ASPxSpinAddWorkHour" 
                                                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                            <SpinButtons>
                                                                                <IncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
                                                                                </IncrementImage>
                                                                                <DecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
                                                                                </DecrementImage>
                                                                                <LargeIncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeIncrementImage>
                                                                                <LargeDecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeDecrementImage>
                                                                            </SpinButtons>
                                                                        </dx:ASPxSpinEdit>
                                                                    </td>
                                                                    <td align="right" style="width: 10%">
                                                                        ساعت
                                                                    </td>
                                                                    <td align="left" style="width: 10%">
                                                                        <dx:ASPxSpinEdit ID="ASPxSpinAddWorkMinute" runat="server" Height="21px" Number="0"
                                                                            Width="50px" MaxValue="59" ClientInstanceName="ASPxSpinAddWorkMinute" 
                                                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                            <SpinButtons>
                                                                                <IncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
                                                                                </IncrementImage>
                                                                                <DecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
                                                                                </DecrementImage>
                                                                                <LargeIncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeIncrementImage>
                                                                                <LargeDecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeDecrementImage>
                                                                            </SpinButtons>
                                                                        </dx:ASPxSpinEdit>
                                                                    </td>
                                                                    <td align="right" style="width: 10%">
                                                                        دقیقه
                                                                    </td>
                                                                    <td align="left" style="width: 25%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 25%" align="right">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <dx:ASPxCheckBox ID="ASPxCheckBoxAgreeOverTime" runat="server" Text="اجازه ثبت اضافه کار دستوری"
                                                                ClientInstanceName="ASPxCheckBoxAgreeOverTime" 
                                                                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px">
                                                                <ClientSideEvents CheckedChanged="ASPxCheckBoxAgreeOverTimeCheckedChanged" />
<ClientSideEvents CheckedChanged="ASPxCheckBoxAgreeOverTimeCheckedChanged"></ClientSideEvents>
                                                            </dx:ASPxCheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <table align="center" style="width: 100%;">
                                                                <tr>
                                                                    <td style="width: 10%">
                                                                        حداکثر
                                                                    </td>
                                                                    <td style="width: 10%" align="left">
                                                                        <dx:ASPxSpinEdit ID="ASPxSpinAgreeOverTimeHour" runat="server" Height="21px" MaxValue="999"
                                                                            Number="0" Width="50px" ClientInstanceName="ASPxSpinOverTimeHour" 
                                                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                            <SpinButtons>
                                                                                <IncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
                                                                                </IncrementImage>
                                                                                <DecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
                                                                                </DecrementImage>
                                                                                <LargeIncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeIncrementImage>
                                                                                <LargeDecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeDecrementImage>
                                                                            </SpinButtons>
                                                                        </dx:ASPxSpinEdit>
                                                                    </td>
                                                                    <td align="right" style="width: 10%">
                                                                        ساعت
                                                                    </td>
                                                                    <td align="left" style="width: 10%">
                                                                        <dx:ASPxSpinEdit ID="ASPxSpinAgreeOverTimeMinute" runat="server" Height="21px" Number="0"
                                                                            Width="50px" MaxValue="59" ClientInstanceName="ASPxSpinOverTimeMinute" 
                                                                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                                                                            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                                            <SpinButtons>
                                                                                <IncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua"></SpriteProperties>
                                                                                </IncrementImage>
                                                                                <DecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua"></SpriteProperties>
                                                                                </DecrementImage>
                                                                                <LargeIncrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeIncrementImage>
                                                                                <LargeDecrementImage>
                                                                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                                                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
<SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua"></SpriteProperties>
                                                                                </LargeDecrementImage>
                                                                            </SpinButtons>
                                                                        </dx:ASPxSpinEdit>
                                                                    </td>
                                                                    <td align="right" style="width: 10%">
                                                                        دقیقه
                                                                    </td>
                                                                    <td align="left" style="width: 25%;">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 25%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                        <ClientSideEvents EndCallback="ASPxCallbackPanelOverTimeEmdCallback" />
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                    <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                    </LoadingPanelImage>
                    <Paddings Padding="2px" PaddingLeft="5px" PaddingRight="5px" />

<Paddings Padding="2px" PaddingLeft="5px" PaddingRight="5px"></Paddings>

                    <ContentStyle>
                        <Border BorderColor="#AECAF0" BorderStyle="Solid" BorderWidth="1px" />
<Border BorderColor="#AECAF0" BorderStyle="Solid" BorderWidth="1px"></Border>
                    </ContentStyle>
                </dx:ASPxPageControl>
            </div>
        </div>
        <br />
        <br />
        <div dir="rtl" style="width: 100%; clear: both;" align="right">
        
            
                <img id="btnFilterGrid"  src="../img/FilterIcon.png" alt="فیلتر نمایش" 
                style="cursor: pointer"   />
        </div>
        <div dir="rtl" style="width: 100%" align="right">
          
                        <dx:ASPxGridView ID="ASPxGridViewUserManagerStatus" runat="server" AutoGenerateColumns="False"
                            Width="95%" ClientInstanceName="ASPxGridViewUserManagerStatus" 
                            KeyFieldName="UserName" 
                            OnCustomCallback="ASPxGridViewUserManagerStatus_CustomCallback" 
                            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                            <ClientSideEvents FocusedRowChanged="function(s, e){onClickRowASPxGridViewUserManagerStatus()}"></ClientSideEvents>

                            <Columns>
                            <dx:GridViewDataTextColumn Caption="نام" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="1%" FieldName="ID" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="1%" FieldName="idWPPerson" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="1" Width="15%" FieldName="Name">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="واحد تحت مدیریت" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="4" Width="15%" FieldName="PartName">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="وضعیت" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="5" Width="15%" FieldName="UserStatusName">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام خانوادگی" FieldName="Family" ShowInCustomizationForm="True"
                                    VisibleIndex="2" Width="15%">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="شماره پرسنلی" FieldName="Barcode" ShowInCustomizationForm="True"
                                    VisibleIndex="0" CellStyle-Cursor="pointer" Width="15%">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle Font-Underline="False" ForeColor="#3333CC" HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام پست" FieldName="UserName" ShowInCustomizationForm="True"
                                    VisibleIndex="3" Width="15%">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewCommandColumn 
                                    ShowInCustomizationForm="True" VisibleIndex="6" Caption="حذف" 
                                    ButtonType="Image">
                                    <ClearFilterButton Visible="True">
                                    </ClearFilterButton>
                                    <CustomButtons>
                                        <dx:GridViewCommandColumnCustomButton ID="Delete" Text="حذف" 
                                            Visibility="AllDataRows" >
                                            <Image Url="~/img/remove.png">
                                            </Image>
                                        </dx:GridViewCommandColumnCustomButton>
                                    </CustomButtons>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewCommandColumn>
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True"  ConfirmDelete="true"/>
                            <SettingsText EmptyDataRow="هیچ آیتمی وجود ندارد" />
                            <SettingsLoadingPanel ImagePosition="Top" />
                            <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                                </LoadingPanelOnStatusBar>
                                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                                </LoadingPanel>
                            </Images>
                            <ImagesEditors>
                                <DropDownEditDropDown>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                        PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                </DropDownEditDropDown>
                                <SpinEditIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
                                </SpinEditIncrement>
                                <SpinEditDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
                                </SpinEditDecrement>
                                <SpinEditLargeIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
                                </SpinEditLargeIncrement>
                                <SpinEditLargeDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
                                </SpinEditLargeDecrement>
                            </ImagesEditors>
                            <ImagesFilterControl>
                                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                </LoadingPanel>
                            </ImagesFilterControl>
                            <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                                <AlternatingRow Enabled="true" />
<AlternatingRow Enabled="True"></AlternatingRow>
                                <LoadingPanel ImageSpacing="8px">
                                </LoadingPanel>
                            </Styles>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

                            <SettingsPager>
                                <Summary Text="صفحه {0} از {1}" />
<Summary Text="صفحه {0} از {1}"></Summary>
                            </SettingsPager>
                            <ClientSideEvents FocusedRowChanged="function(s, e){onFocusRowASPxGridViewUserManagerStatus()}" />
                       <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
                            <StylesEditors>
                                <CalendarHeader Spacing="1px">
                                </CalendarHeader>
                                <ProgressBar Height="25px">
                                </ProgressBar>
                            </StylesEditors>
                        </dx:ASPxGridView>
                  
        </div>
        <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
    
     <dx:ASPxPopupControl ID="ASPXPopupControlFilterGrid" runat="server" 
        CloseAction="OuterMouseClick" LoadContentViaCallback="OnFirstShow"
                         PopupElementID="btnFilterGrid" PopupVerticalAlign="Below" 
        PopupHorizontalAlign="RightSides" AllowDragging="True"
                         ShowFooter="True" Width="200px" Height="130px" 
        HeaderText="Updatable content" ClientInstanceName="ClientPopupControl" 
        ShowHeader="False"  >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl" runat="server">
                <div style="vertical-align:middle" dir="rtl">
                    
                    <dx:ASPxTreeView ID="ASPxTreeViewFilterGrid" runat="server" 
                        AllowCheckNodes="True" ClientInstanceName="TreeViewFilterGrid" 
                        RightToLeft="True" Width="100%" CheckNodesRecursive="true">
                        <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                            <NodeLoadingPanel Url="~/App_Themes/Aqua/Web/tvNodeLoading.gif">
                            </NodeLoadingPanel>
                            <LoadingPanel Url="~/App_Themes/Aqua/Web/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                        </Styles>
                        <Nodes>
                            <dx:TreeViewNode Expanded="True" Text="همه" Name="0">
                                <Nodes>
                                    <dx:TreeViewNode Text="مدیر واحد" Expanded="True">
                                        <Nodes>
                                            <dx:TreeViewNode Name="3" Text="تایید اولیه">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Name="6" Text="تایید ثانویه">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Name="2" Text="تایید نهایی">
                                            </dx:TreeViewNode>
                                        </Nodes>
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Name="1" Text="مدیر حضور غیاب">
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Name="4" Text="اپراتور">
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Name="5" Text="گزارش گیر">
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Name="7" Text="کاربر عادی">
                                    </dx:TreeViewNode>
                                </Nodes>
                            </dx:TreeViewNode>
                        </Nodes>
                    </dx:ASPxTreeView>
                    
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <FooterTemplate>
            <div style="float: right; margin: 3px;">
                <dx:ASPxButton ID="ViewButtonFilterGrid" runat="server" Text="نمایش" AutoPostBack="False" 
                               ClientSideEvents-Click="function(s, e) { onClickViewButtonFilterGrid(); }" />
            </div>
        </FooterTemplate>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="ASPXPopupControl1" runat="server" 
        CloseAction="CloseButton" LoadContentViaCallback="OnPageLoad" PopupVerticalAlign="Above" 
        PopupHorizontalAlign="WindowCenter" Width="450px" 
        HeaderText="پست های پرسنل" ClientInstanceName="PopupControlPost"  >
        <ClientSideEvents CloseButtonClick="PopupControlPost_CloseButton" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div style="vertical-align:middle" dir="rtl">
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" Width="100%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="پست های پرسنل" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContent4" runat="server" SupportsDisabledAttribute="True">
<table id="newPost" align="center" dir="rtl" style="width: 100%">
                  <tr>
                  <td>
                  نام پست :
                  </td>
                  <td>
                  
                      <dx:ASPxTextBox ID="ASPxTextBoxPostOfPerson" runat="server" 
                          ClientInstanceName="TextBoxPostOfPerson" Width="140px">
                      </dx:ASPxTextBox>
                  
                  </td>
                      <td>
                          <dx:ASPxMenu ID="ASPxMenuAddPostofPerson" runat="server" AutoSeparators="RootOnly" 
                              ClientInstanceName="MenuAddPostofPerson" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                              CssPostfix="Aqua" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" 
                              GutterImageSpacing="7px" RightToLeft="True" ShowPopOutImages="True" 
                              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                              <ClientSideEvents ItemClick="function(s, e){onItemMenuAddPostofPerson(e);}" />
                              <Items>
                                  <dx:MenuItem Name="Save" Text="ثبت">
                                      <Image Url="~/img/save.png">
                                      </Image>
                                  </dx:MenuItem>
                              </Items>
                              <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                              </LoadingPanelImage>
                              <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                              <ItemStyle Cursor="pointer" DropDownButtonSpacing="12px" 
                                  PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px" 
                                  ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" />
                              <SubMenuStyle GutterWidth="0px" />
                          </dx:ASPxMenu>
                      </td>
                  </tr>
                  </table>
      

        <dx:ASPxGridView runat="server" 
                ClientInstanceName="GridViewPostOfPerson" KeyFieldName="ID" 
                AutoGenerateColumns="False" RightToLeft="True" Width="95%" 
                ID="ASPxGridViewPostOfPerson" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                            CssPostfix="Aqua" 
                            OnCustomCallback="ASPxGridViewViewUserOfPerson_CustomCallback" 
                            
        OnRowUpdating="ASPxGridViewViewUserOfPerson_RowUpdating">

<Columns>
<dx:GridViewDataTextColumn FieldName="RowNumber" ShowInCustomizationForm="True" 
        Width="10%" Caption="ردیف" VisibleIndex="0" ReadOnly="True">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<CellStyle HorizontalAlign="Center"></CellStyle>
</dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PersonPost" ShowInCustomizationForm="True" Caption="نام پست" 
       Width="65%" VisibleIndex="1">
    <HeaderStyle HorizontalAlign="Center" />
    <CellStyle HorizontalAlign="Center">
    </CellStyle>
</dx:GridViewDataTextColumn>
         <dx:GridViewCommandColumn VisibleIndex="9" Caption="ویرایش" Width="15%" 
                                    ButtonType="Image">
                <EditButton Visible="True" Text="ویرایش"  >
                
                
                                       <Image Url="~/img/edit.png">
                                       </Image>
                                       </EditButton>
                                       <CancelButton Text="انصراف">
                                           <Image Url="~/img/cancel.png">
                                           </Image>
                                       </CancelButton>
                                       <UpdateButton Text="ثبت">
                                           <Image Url="~/img/save.png">
                                           </Image>
                                       </UpdateButton>
               
                                       <HeaderStyle HorizontalAlign="Center" />
                                       <CellStyle HorizontalAlign="Center" Cursor="pointer">
                                       </CellStyle>
            </dx:GridViewCommandColumn>
            <dx:GridViewCommandColumn 
                                    ShowInCustomizationForm="True" VisibleIndex="10" Caption="حذف" 
                                    ButtonType="Image" Width="10%" >
                                    <ClearFilterButton Visible="True">
                                    </ClearFilterButton>
                                    <CustomButtons>
                                        <dx:GridViewCommandColumnCustomButton ID="DeletePost" Text="حذف" 
                                            Visibility="AllDataRows" >
                                            <Image Url="~/img/remove.png">
                                            </Image>
                                        </dx:GridViewCommandColumnCustomButton>
                                    </CustomButtons>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewCommandColumn>
</Columns>

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

<SettingsPager PageSize="5">
<Summary Text="صفحه {0} از {1}"></Summary>
</SettingsPager>

            <SettingsEditing Mode="Inline" />
             <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGridPost(e);}" />
 <SettingsText CommandEdit="ویرایش" EmptyDataRow="هیچ آیتمی وجود ندارد." 
                           CommandDelete="حذف" CommandCancel="انصراف" CommandUpdate="ثبت" 
                           ConfirmDelete="آیا این آیتم را حذف می نمایید؟" />

                            <SettingsLoadingPanel ImagePosition="Top" />
                            <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                                </LoadingPanelOnStatusBar>
                                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                                </LoadingPanel>
                            </Images>
                            <ImagesEditors>
                                <DropDownEditDropDown>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                                        PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                                </DropDownEditDropDown>
                                <SpinEditIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
                                </SpinEditIncrement>
                                <SpinEditDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
                                </SpinEditDecrement>
                                <SpinEditLargeIncrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
                                </SpinEditLargeIncrement>
                                <SpinEditLargeDecrement>
                                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
                                </SpinEditLargeDecrement>
                            </ImagesEditors>
                            <ImagesFilterControl>
                                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                                </LoadingPanel>
                            </ImagesFilterControl>

<Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
<AlternatingRow Enabled="True"></AlternatingRow>
    <LoadingPanel ImageSpacing="8px">
    </LoadingPanel>
</Styles>
                            <StylesEditors>
                                <CalendarHeader Spacing="1px">
                                </CalendarHeader>
                                <ProgressBar Height="25px">
                                </ProgressBar>
                            </StylesEditors>
</dx:ASPxGridView>
 
            </dx:PanelContent>
            </PanelCollection>
            </dx:ASPxRoundPanel>
                    
                    
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
       
    </dx:ASPxPopupControl>
      <dx:ASPxCallback ID="ASPxCallbackPostOfPerson" runat="server" OnCallback="ASPxCallbackPostOfPerson_Callback"
        ClientInstanceName="CallbackPostOfPerson">
        <ClientSideEvents CallbackComplete="function(s ,e){onCallbackPostOfPersonComplete(e);}" />
        <ClientSideEvents CallbackError="function(s ,e){onCallbackPostOfPersonUpdateError(e);}" />
    </dx:ASPxCallback>
    <dx:ASPxHiddenField ID="ASPxHiddenFieldBarcode" ClientInstanceName="HiddenFieldBarcode" runat="server">
            </dx:ASPxHiddenField>
    <dx:ASPxCallback ID="ASPxCallbackDefineAdminOperator" runat="server" ClientInstanceName="CallbackDefineAdminOperatorUpdate"
        OnCallback="ASPxCallbackDefineAdminOperator_Callback" >
        <ClientSideEvents CallbackComplete="function(s ,e){CallbackDefineAdminOperatorUpdateComplete(e)}" />
        <ClientSideEvents CallbackError="function(s ,e){CallbackDefineAdminOperator_onCallbackError(e)}"/>
    </dx:ASPxCallback>
     <dx:ASPxCallback ID="ASPxCallbackDeleteRowsSelectedGrid" runat="server" 
        ClientInstanceName="ASPxCallbackDeleteRowsSelectedGrid" oncallback="ASPxCallbackDeleteRowsSelectedGrid_Callback">
        <ClientSideEvents CallbackComplete="function(s ,e){CallbackDeleteRowsSelectedGridComplete(e)}" />
    </dx:ASPxCallback>   
    <dx:ASPxCallback ID="ASPxCallbackDeletePostOfPerson" runat="server" 
          ClientInstanceName="CallbackDeletePostOfPerson" 
          oncallback="ASPxCallbackDeletePostOfPerson_Callback">
     <ClientSideEvents CallbackComplete="function(s ,e){ CallbackPostOfPersonEndCallback(e)}" />
     </dx:ASPxCallback> 
    </form>
</body>
</html>

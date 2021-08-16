<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/DefineManagerPersonnel.aspx.cs"
    Inherits="ASPWebclock.Admin.DefineManagerPersonnel" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxMenu" tagprefix="dx1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>معرفی پرسنل تحت مدیریت</title>
    <link href="../css/DropDownListStyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/buttonStyle.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
<script src="../js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../js/DefineManagerPersonnel_Operations.js" type="text/javascript"></script>
    <form id="DefineManagerPersonnelform" runat="server" onsubmit="return false;">
    <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_DefineManagerPersonnel" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_DefineManagerPersonnel">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_DefineManagerPersonnel" 
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
 <div dir="rtl" style="width: 100%; font-family: tahoma; font-size: 8pt;" align="right" >
      <div dir="rtl" style="width: 100%" align="center">
          <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="80%" 
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
<SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" PressedCssClass="dxEditors_edtDropDownPressed_Aqua"></SpriteProperties>
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
<ErrorTextPaddings PaddingLeft="4px"></ErrorTextPaddings>
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
                                RightToLeft="True" ValueType="System.String" Width="80%" 
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
                    </tr>
                </table>

</dx:PanelContent>
</PanelCollection>
          </dx:ASPxRoundPanel>
           
        </div><br />
        <table style="width:100%" align="center">
        <tr>
        <td align="center" style="width: 45%" valign="top">
        
             
                        <dx:ASPxRoundPanel ID="ASPxRoundPanelParts" runat="server" 
                  Width="99%" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                                    CssPostfix="Aqua" GroupBoxCaptionOffsetY="-28px" 
                  HeaderText="بخش" RightToLeft="True"
                                    SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                                    ClientInstanceName="PanelParts">
                                    <ContentPaddings Padding="14px" />
                                    <HeaderStyle Font-Bold="True" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
           <div id="divContentTreeViewParts" onscroll="divContentTreeViewParts_onScroll();"  
                                                style="border: 1px solid #97D6FF; overflow: scroll;">
                                           
                                                
                                                <dx:ASPxTreeView ID="ASPxTreeViewParts"  runat="server" Width="99%" ClientInstanceName="TreeViewParts" 
                                                    Height="280px" RightToLeft="True" AllowSelectNode="True">
                                                  <ClientSideEvents NodeClick="TreeViewParts_onClick" />
                                                  <ClientSideEvents ExpandedChanged="TreeViewParts_onExpandedChanged" />
                                                    <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                                                        <NodeLoadingPanel Url="~/App_Themes/Aqua/Web/tvNodeLoading.gif">
                                                        </NodeLoadingPanel>
                                                        <LoadingPanel Url="~/App_Themes/Aqua/Web/Loading.gif">
                                                        </LoadingPanel>
                                                    </Images>
                                                    <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
                                                    </Styles>
                                                </dx:ASPxTreeView>
                                           
                                            </div>
                                            </dx:PanelContent></PanelCollection></dx:ASPxRoundPanel>
        </td>
        <td align="center" style="width: 55%" valign="top">
                 
              <dx:ASPxGridView ID="ASPxGridViewPersonnels" runat="server" AutoGenerateColumns="False"
                            Width="90%" ClientInstanceName="GridViewPersonnels" 
                            KeyFieldName="Barcode" 
                      oncustomcallback="ASPxGridViewPersonnels_CustomCallback" 
                  CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                  onprocesscolumnautofilter="ASPxGridViewPersonnels_ProcessColumnAutoFilter" >

<SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

                               <Settings ShowTitlePanel="true" />
                            <ClientSideEvents FocusedRowChanged="function(s, e){onFocusRowGridViewPersonnels()}" />
                   
<ClientSideEvents FocusedRowChanged="function(s, e){onClickRowGridViewPersonnels()}"></ClientSideEvents>

                            <Columns>
                            <dx:GridViewDataTextColumn Caption="ID" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="1%" FieldName="ID" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="شماره پرسنلی" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="25%" FieldName="Barcode" Visible="True">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="1" Width="25%" FieldName="Name" >
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="نام خانوادگی" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="1" Width="25%" FieldName="Family">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <%--<dx:GridViewDataTextColumn Caption="پست" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="1" Width="25%" FieldName="PersonPost">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>--%>
                                  
                            </Columns>
                            <SettingsBehavior AllowFocusedRow="True"  ConfirmDelete="true"/>

                            <SettingsPager>
                                <Summary Text="صفحه {0} از {1}" />
<Summary Text="صفحه {0} از {1}"></Summary>
                            </SettingsPager>
                             <Settings ShowFilterRow="True" />
        <SettingsText Title="پرسنل" />
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
                            <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                      CssPostfix="Aqua">
<AlternatingRow Enabled="True"></AlternatingRow>
                                <Header Font-Bold="False">
                                </Header>
                                <AlternatingRow Enabled="true" />
                                <LoadingPanel ImageSpacing="8px">
                                </LoadingPanel>
                                <TitlePanel Font-Bold="True">
                                </TitlePanel>
                            </Styles>

                  <StylesEditors>
                      <CalendarHeader Spacing="1px">
                      </CalendarHeader>
                      <ProgressBar Height="25px">
                      </ProgressBar>
                  </StylesEditors>
                   
                        </dx:ASPxGridView>
                        <br />
        
        </td>
        </tr>
        <tr>
        <td id="tdbtnAddParts" align="center" style="width: 45%" valign="top">
        
                  
                    <dx:ASPxMenu ID="ASPxMenuGridParts" runat="server" AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" ClientInstanceName="MenuGridPart">
                <Items>
                    <dx:MenuItem Text="اضافه" Name="add">
                        <Image Url="~/img/add.png">
                        </Image>
                    </dx:MenuItem>
                   
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuGridPartClick(e);}" />
            </dx:ASPxMenu>
           
        </td>
        <td align="center" style="width: 55%" valign="top">
                 
                        <dx:ASPxMenu ID="ASPxMenuGridPersonnel" runat="server" AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" ClientInstanceName="MenuGridPersonnel">
                <Items>
                    <dx:MenuItem Text="اضافه" Name="add">
                        <Image Url="~/img/add.png">
                        </Image>
                    </dx:MenuItem>
                   
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />
                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
                <ClientSideEvents ItemClick="function(s, e){onItemMenuGridPersonnelClick(e);}" />
            </dx:ASPxMenu>
        
                        <br />
                        <br />
                        <br />
                        
                        
        
        </td>
        </tr>
        </table>
              <br />
                  <div align="center" style="width: 100%">
                   <dx:ASPxGridView ID="ASPxGridViewEditWebPassPerson" runat="server" AutoGenerateColumns="False"
                            Width="70%" KeyFieldName="ID" 
                          ClientInstanceName="GridViewEditWebPassPerson" 
                          oncustomcallback="ASPxGridViewEditWebPassPerson_CustomCallback" 
                          onrowupdating="ASPxGridViewEditWebPassPerson_RowUpdating" 
                          CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" >

                   


                         


                            <ClientSideEvents FocusedRowChanged="function(s, e){onFocusRowGridViewEditWebPassPerson()}" />
                            



                         


                            <SettingsBehavior AllowFocusedRow="True"  ConfirmDelete="true"/>
                            
                           
                       <SettingsText CommandEdit="ویرایش" EmptyDataRow="هیچ آیتمی وجود ندارد." 
                           CommandDelete="حذف" CommandCancel="انصراف" CommandUpdate="ثبت" 
                           ConfirmDelete="آیا این آیتم را حذف می نمایید؟" />
                            

                            

                         


                            <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
                            

                            <Columns>
                            <dx:GridViewDataTextColumn Caption="" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="1%" FieldName="WebPassId" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="شرح" ReadOnly="True" ShowInCustomizationForm="True"
                                    VisibleIndex="0" Width="70%" FieldName="Name" Visible="True">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Caption="زیربخش" FieldName="isSubPart" 
                                    VisibleIndex="1" Width="10%">
                                    

                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="اپراتور" VisibleIndex="2" Width="7%" 
                                    FieldName="isOperatorfrm" Visible="false">
                                 
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="نگهبان" FieldName="isKeeperfrm" 
                                    VisibleIndex="3" Width="7%" Visible="false">
                             
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="کارکرد" FieldName="isKarkardfrm" 
                                    VisibleIndex="4" Width="7%" Visible="false">
                                   
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="درخواست ها" FieldName="isRequestfrm" 
                                    VisibleIndex="5" Width="7%" Visible="false">
                                
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="ا.ک دستوری" FieldName="isOverTimefrm" 
                                    VisibleIndex="6" Width="7%" Visible="false">
                                    
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Caption="دسترسی مدیر" FieldName="AccessType" VisibleIndex="7" Width="7%" Visible="false">
                                
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataCheckColumn>
                                   <dx:GridViewCommandColumn VisibleIndex="9" Caption="ویرایش" Width="10%" 
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
                                    ButtonType="Image" Width="10%">
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




                         


<SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True"></SettingsBehavior>


                            <SettingsPager>
                                <Summary Text="صفحه {0} از {1}" />
<Summary Text="صفحه {0} از {1}"></Summary>
                            </SettingsPager>
                            

                             <SettingsEditing EditFormColumnCount="3" Mode="Inline" 
                           PopupEditFormWidth="600px" PopupEditFormHorizontalAlign="Center" 
                                PopupEditFormModal="True"  />
                             <Settings ShowTitlePanel="true" />


        <SettingsText Title="" />


                            

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
                            
                                <Header Font-Bold="False">
                                </Header>
                            
                                <AlternatingRow Enabled="true" />
                                
                                <LoadingPanel ImageSpacing="8px">
                                </LoadingPanel>
                                
                                <TitlePanel Font-Bold="True">
                                </TitlePanel>
                                
                            </Styles>
                           
                       
                        
                            <StylesEditors>
                                <CalendarHeader Spacing="1px">
                                </CalendarHeader>
                                <ProgressBar Height="25px">
                                </ProgressBar>
                            </StylesEditors>
                           
                        <SettingsText Title="گزینه های انتخاب شده" />
                        
                        </dx:ASPxGridView>
                  </div>
              
              
     <dx:ASPxCallback ID="ASPxCallbackUpdateWebpassPerson" runat="server" 
          ClientInstanceName="CallbackUpdateWebpassPerson" oncallback="ASPxCallbackUpdateWebpassPerson_Callback" >
          <ClientSideEvents CallbackComplete="function(s ,e){ CallbackUpdateWebpassPersonEndCallback(e)}" />
     </dx:ASPxCallback>
     <dx:ASPxCallback ID="ASPxCallbackDeleteWebpassPerson" runat="server" 
          ClientInstanceName="CallbackDeleteWebpassPerson" 
          oncallback="ASPxCallbackDeleteWebpassPerson_Callback">
     <ClientSideEvents CallbackComplete="function(s ,e){ CallbackDeleteWebpassPersonEndCallback(e)}" />
     </dx:ASPxCallback>
     <asp:HiddenField ID="hfScrollPosition" runat="server" Value="0" />
      <div id="divImgLoading" 
            style="visibility: hidden; width: 150px; font-weight: bold;" dir="rtl">
    لطفا منتظر بمانید
    <img id="imgLoading" src="../App_Themes/Aqua/Web/Loading.gif" />
    </div>
    </div>
    </form>
</body>
</html>

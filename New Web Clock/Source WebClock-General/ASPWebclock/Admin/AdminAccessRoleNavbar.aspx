<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminAccessRoleNavbar.aspx.cs" Inherits="ASPWebclock.Admin.AdminAccessRoleNavbar" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/AdminAccessRoleNavbar_onOperations.js" type="text/javascript"></script>
</head>
<body>
    <form id="AdminAccessRoleNavbarForm" runat="server">
   
    <div dir="rtl">
                <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_AdminAccessRoleNavbar" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_AdminAccessRoleNavbar">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="Help_AdminAccessRoleNavbar" 
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
    <div>
    
                        <dx:ASPxGridView runat="server" 
            ClientInstanceName="GridViewAccessRoleNavbar" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             AutoGenerateColumns="False" RightToLeft="True" Width="100%" 
            ID="ASPxGridViewAccessRoleNavbar" onrowupdating="ASPxGridViewAccessRoleNavbar_RowUpdating" 
                            
                            ondetailrowexpandedchanged="ASPxGridViewAccessRoleNavbar_DetailRowExpandedChanged" 
                            onstartrowediting="ASPxGridViewAccessRoleNavbar_StartRowEditing">
<SettingsBehavior AllowFocusedRow="True"  ConfirmDelete="true" AllowSort="False"/>
                       <SettingsText CommandEdit="ویرایش" EmptyDataRow="هیچ آیتمی وجود ندارد." 
                           CommandDelete="حذف" CommandCancel="انصراف" CommandUpdate="ثبت" 
                           ConfirmDelete="آیا این آیتم را حذف می نمایید؟" />
                            <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
                            <ClientSideEvents EndCallback="function(s,e){GridViewAccessRoleNavbar_EndCallback(s,e);}" />

                            <Columns>
                     
                              
                                   <dx:GridViewCommandColumn VisibleIndex="9" Caption="ویرایش" Width="5%" 
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
           
                            </Columns>

                            <Templates>
                            <DetailRow>
                            <dx:ASPxGridView ID="AspxGridViewAccessControls" runat="server"  KeyFieldName="Ctrl_ID"
                    Width="90%" ClientInstanceName="GridViewAccessControls" 
                   RightToLeft="True" SettingsEditing-Mode="Inline" onrowupdating="AspxGridViewAccessControls_RowUpdating" >
                    <ClientSideEvents EndCallback="function(s,e){GridViewAccessControls_EndCallback(s,e);}" />
                    <SettingsText EmptyDataRow="هیچ آیتمی یافت نشد." />
                    <Columns>
                        
                       <dx:GridViewCommandColumn VisibleIndex="9" Caption="ویرایش" Width="5%" 
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
                        
                    </Columns>
                   <SettingsBehavior AllowFocusedRow="True" ConfirmDelete="True"></SettingsBehavior>
                   <SettingsText Title="دسترسی کنترل ها" />
                </dx:ASPxGridView>

                            </DetailRow>
                            </Templates>


                         


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
                            <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
                          
                        <SettingsText Title="دسترسی نقش ها" />
</dx:ASPxGridView>

    </div>

    <asp:SqlDataSource ID="SqlDataSourceWebControls" runat="server" 
        ConnectionString="<%$ ConnectionStrings:cnn %>" 
        SelectCommand="SELECT * FROM [NW_WebControl] WHERE ([Ctrl_Name] = @Ctrl_Name)">
        <SelectParameters>
            <asp:Parameter DefaultValue="&quot;&quot;" Name="Ctrl_Name" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardUser.aspx.cs" Inherits="ASPWebclock.Operation.DashboardUser" %>

<%@ Register Assembly="JQControls" Namespace="JQControls" TagPrefix="cc1" %>

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
    

<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxLoadingPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCloudControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
    <%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>


      

<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx1" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v11.1, Version=11.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dx2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  
        <script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/DashboardUser_onOperations.js"></script>
   
</head>
<body>
<form id="form1" runat="server">
<cc1:JQLoader ID="JQLoader1" runat="server" Theme="Start">
        </cc1:JQLoader>
    <div align="right" dir="rtl">
    <table dir="rtl" width="90%" cellpadding="5" cellspacing="5">
    <tr>
    <td>
  <table width="100%">
  <tr>
  <td width="60%">
  <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeader_DashboardUser" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeader_DashboardUser" 
            Enabled="True">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderClick(e);}"></ClientSideEvents>
<Items>
<dx:MenuItem Name="AddNewRequest_DashboardUser" 
        Text="درخواست جدید" Enabled="False">
<Image Url="~/img/add.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="Help_DashboardUser" 
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
</dx:ASPxMenu>
  </td>
  <td align="left" dir="rtl">
  
      <asp:Label ID="lblRemainLeave" runat="server" Font-Bold="True" 
          Font-Names="Tahoma" Font-Size="8pt"></asp:Label>
  
  </td>
  </tr>
  </table>
    
    </td>
    </tr>
    <tr>
    
    <td>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="100%" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
            GroupBoxCaptionOffsetY="-28px" HeaderText="فیلتر نمایش" RightToLeft="True" 
            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
            <ContentPaddings Padding="14px" />
<ContentPaddings Padding="14px"></ContentPaddings>
        <PanelCollection>
        <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
        <table width="100%" 
            style="font-family: tahoma; font-size: 9pt; text-align: center;">
    <tr>
    <td width="15%" align="right">
    
        <dx:ASPxCheckBox ID="ASPxCheckBoxHourly" runat="server" RightToLeft="True" 
            Text="ساعتی" Checked="True" CheckState="Checked" 
            ClientInstanceName="CheckBoxHourly" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
            SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px">
        </dx:ASPxCheckBox>
    
    </td>
     <td width="15%" align="right">
    
         <dx:ASPxCheckBox ID="ASPxCheckBoxDaily" runat="server" RightToLeft="True" 
             Text="روزانه" Checked="True" CheckState="Checked" 
             ClientInstanceName="CheckBoxDaily" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px">
         </dx:ASPxCheckBox>
    
    </td>
     <td width="15%" align="right">
    
         <dx:ASPxCheckBox ID="ASPxCheckBoxOverTime" runat="server" 
             Text="اضافه کار دستوری" ClientInstanceName="CheckBoxOverTime" 
             CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" TextSpacing="2px">
         </dx:ASPxCheckBox>
    
    </td>
     <td align="left">
    
         ماه</td>
     <td align="right" width="100px">
    
         <dx:ASPxComboBox ID="ASPxComboBoxMonth" runat="server" 
             Width="80px" ValueType="System.String" ClientInstanceName="ComboBoxMonth" 
             RightToLeft="True" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
             CssPostfix="Aqua" LoadingPanelImagePosition="Top" ShowShadow="False" 
             SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
             <Items>
                 <dx:ListEditItem Text="فروردین" Value="01" />
                 <dx:ListEditItem Text="اردیبهشت" Value="02" />
                 <dx:ListEditItem Text="خرداد" Value="03" />
                 <dx:ListEditItem Text="تیر" Value="04" />
                 <dx:ListEditItem Text="مرداد" Value="05" />
                 <dx:ListEditItem Text="شهریور" Value="06" />
                 <dx:ListEditItem Text="مهر" Value="07" />
                 <dx:ListEditItem Text="آبان" Value="08" />
                 <dx:ListEditItem Text="آذر" Value="09" />
                 <dx:ListEditItem Text="دی" Value="10" />
                 <dx:ListEditItem Text="بهمن" Value="11" />
                 <dx:ListEditItem Text="اسفند" Value="12" />
             </Items>
             <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
             </LoadingPanelImage>
             <DropDownButton>
                 <Image>
                     <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                         PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                 </Image>
             </DropDownButton>
             <ValidationSettings>
                 <ErrorFrameStyle ImageSpacing="4px">
                     <ErrorTextPaddings PaddingLeft="4px" />
                 </ErrorFrameStyle>
             </ValidationSettings>
         </dx:ASPxComboBox>
    
    </td>
     <td align="left">
    
         سال</td>
        <td align="right" width="100px">
            <dx:ASPxComboBox ID="ASPxComboBoxYear" runat="server" ValueType="System.String" 
                Width="80px" ClientInstanceName="ComboBoxYear" RightToLeft="True" 
                CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
                LoadingPanelImagePosition="Top" ShowShadow="False" 
                SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                <Items>
                    <dx:ListEditItem Text="1390" Value="1390" />
                    <dx:ListEditItem Text="1391" Value="1391" />
                    <dx:ListEditItem Text="1392" Value="1392" />
                    <dx:ListEditItem Text="1393" Value="1393" />
                    <dx:ListEditItem Text="1394" Value="1394" />
                    <dx:ListEditItem Text="1395" Value="1395" />
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Editors/Loading.gif">
                </LoadingPanelImage>
                <DropDownButton>
                    <Image>
                        <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                            PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                    </Image>
                </DropDownButton>
                <ValidationSettings>
                    <ErrorFrameStyle ImageSpacing="4px">
                        <ErrorTextPaddings PaddingLeft="4px" />
                    </ErrorFrameStyle>
                </ValidationSettings>
            </dx:ASPxComboBox>
        </td>
        <td align="center">
            <dx:ASPxButton ID="ASPxButtonViewRequest_DashboardUser" runat="server" 
                ClientInstanceName="ButtonViewRequest_DashboardUser" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                Text="نمایش" AutoPostBack="False">
                <ClientSideEvents Click="function(s,e){ButtonViewRequest_DashboardUser_onClick();  }" />

            </dx:ASPxButton>
        </td>
    </tr>
    </table></dx:PanelContent>
        </PanelCollection>
        </dx:ASPxRoundPanel>
    
    </td>
   
    
    </tr>
     <tr>
    <td>
    <dx:ASPxGridView ID="ASPxGridViewRequestsRegistered" runat="server" AutoGenerateColumns="False" 
                        KeyFieldName="ID_PK" 
                        
            
            OnHtmlDataCellPrepared="ASPxGridViewRequestsRegistered_HtmlDataCellPrepared" OnHtmlRowPrepared="ASPxGridViewRequestsRegistered_HtmlRowPrepared"
                        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
             CssPostfix="Aqua" RightToLeft="True"
                        ClientInstanceName="grid" 
                        Width="100%" 
            oncustomcallback="ASPxGridViewRequestsRegistered_CustomCallback" >
                        <ClientSideEvents RowClick="function(s, e) {}" />
                        
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="prc_date" VisibleIndex="1" Caption="تاریخ درخواست">
                                <Settings AllowSort="True" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_SendDate" VisibleIndex="2" Caption="تاریخ صدور">
                                <Settings AllowSort="True" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_Time" VisibleIndex="3" ReadOnly="True"
                                Caption="از ساعت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_eTime" VisibleIndex="4" ReadOnly="True"
                                Caption="تا ساعت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="pish_name" VisibleIndex="0" ReadOnly="True"
                                Caption="عنوان درخواست">
                                <Settings AllowSort="True" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="agree" VisibleIndex="6" ReadOnly="True" Caption="وضعیت">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Clock_RecDes" VisibleIndex="7" Caption="توضیحات">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ID_PK" ReadOnly="True" VisibleIndex="8" Visible="False">
                                
                            </dx:GridViewDataTextColumn>
                              <dx:GridViewDataTextColumn FieldName="Operator" ReadOnly="True" 
                                VisibleIndex="8" Visible="true" Caption="ثبت کننده">
                                
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="timeValue" Caption="مدت" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewCommandColumn 
                                    ShowInCustomizationForm="True" VisibleIndex="10" Caption="حذف" 
                                    ButtonType="Image" Width="10%" Name="Delete" Visible="False">
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
                        <ClientSideEvents CustomButtonClick="function(s,e){ConfirmDeleteRowGrid(e);}" />
                        <SettingsBehavior AllowSort="False" AllowFocusedRow="true" ConfirmDelete="True" />
                        <SettingsPager PageSize="20">
                            <AllButton Text="All">
                            </AllButton>
                            <NextPageButton Text="Next &gt;">
                            </NextPageButton>
                            <PrevPageButton Text="&lt; Prev">
                            </PrevPageButton>
                        </SettingsPager>
                        <SettingsText CommandDelete="حذف" CommandEdit="ویرایش" CommandNew="جدید" CommandUpdate="بروزرسانی"
                            CommandCancel="انصراف" ConfirmDelete="آیا ردیف جاری را حذف می کنید؟" />
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
                            <LoadingPanel ImageSpacing="8px">
                            </LoadingPanel>
                        </Styles>
                        <StylesEditors>
                            <CalendarHeader Spacing="1px">
                            </CalendarHeader>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                        <Templates>
                            <EmptyDataRow>
                             
                            </EmptyDataRow>
                           
                        </Templates>
                    </dx:ASPxGridView>
    </td>
   </tr>
    </table>
    </div>
    <asp:Panel runat="server" ID="panel2" Direction="RightToLeft" Width="100%">
    <dx:ASPxPopupControl ID="ASPxPopupInsertRequest" runat="server" CloseAction="CloseButton"
        Modal="True" PopupHorizontalAlign="LeftSides" PopupVerticalAlign="Middle"
        ClientInstanceName="PopupInsertRequest" HeaderText="ثبت درخواست" 
          RightToLeft="False">
        <ContentCollection>
            <dx:PopupControlContentControl ID="ASPxPopupInserRequestContentControlDaily" runat="server">
                <dx:ASPxPanel ID="ASPxPopupInsertRequestPanelDaily" runat="server" 
                    DefaultButton="btOK" Width="800px" RightToLeft="True"
                    Height="300px">
                    <PanelCollection>
                        <dx:PanelContent>
                       
                            <dx:ASPxPageControl ID="ASPxPageControlRequestDaily" runat="server" Width="800px"
                    ActiveTabIndex="0" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
                    CssPostfix="Aqua" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
                    TabSpacing="3px" ClientInstanceName="PageControlRequestDaily" 
                 RightToLeft="True">
                    <TabPages>
                        <dx:TabPage  Text="روزانه" >
                            <ContentCollection>
                                <dx:ContentControl runat="server" ID="contetnRequestDaily">
                             <asp:Panel runat="server"  ID="panelDaily">
                           
    
    <div id="divHeaderMenuDaily" dir="rtl" style="width:100%">
    <dx:ASPxMenu ID="ASPxMenuHeaderDaily_DashboardUser" runat="server" 
            AutoSeparators="RootOnly" CssFilePath="~/App_Themes/Aqua/{0}/styles.css"
                CssPostfix="Aqua" GutterImageSpacing="7px" ShowPopOutImages="True" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css"
                RightToLeft="True" Font-Bold="True" Font-Names="Tahoma" 
            Font-Size="8pt" ClientInstanceName="MenuHeaderDaily">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderDailyClick(e);}"></ClientSideEvents>
                <Items>
                    
                    
                    <dx:MenuItem Text="ثبت" Name="SaveMenuHeaderDaily_DashboardUser" >
                        <Image Url="~/img/save.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="انصراف" Name="CancelMenuHeaderDaily_DashboardUser" >
                        <Image Url="~/img/cancel.png">
                        </Image>
                    </dx:MenuItem>
                   
                </Items>
                <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                </LoadingPanelImage>
                <RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1" />

                <ItemStyle DropDownButtonSpacing="12px" PopOutImageSpacing="18px" ToolbarDropDownButtonSpacing="5px"
                    ToolbarPopOutImageSpacing="5px" VerticalAlign="Middle" Cursor="pointer" />
                <SubMenuStyle GutterWidth="0px" />
            </dx:ASPxMenu>
       
    </div>
    <br />
    <div id="divRegistRequestDaily" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel ID="ASPxRoundPanelSearchDaily" runat="server" Width="80%" 
              CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
              GroupBoxCaptionOffsetY="-28px" HeaderText="" RightToLeft="True" 
              SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" ClientInstanceName="PanelSearchDaily">
              <ContentPaddings Padding="14px" />
              <PanelCollection>
<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox ID="ASPxComboBoxTrafficTypeDaily" runat="server" 
             ValueType="System.String" ClientInstanceName="ComboBoxTrafficTypeDaily" 
             CallbackPageSize="500" DropDownRows="10" RightToLeft="True">
         </dx:ASPxComboBox>
     </td>
     <td align="left">
         از تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker ID="FromDateDaily" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"
                                                Width="90px" ></cc1:JQDatePicker></td>
     <td align="left">
         تا تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker ID="ToDateDaily" runat="server" Regional="fa" IEDateFormat="YMD" DateFormat="YMD"
                                                Width="90px"></cc1:JQDatePicker></td>
 </tr>
     <tr>
         <td align="left">
             توضیحات</td>
         <td align="right" colspan="5">
             <dx:ASPxTextBox ID="ASPxTextBoxCommentDaily" runat="server" Width="95%" 
                 ClientInstanceName="TextBoxCommentDaily">
             </dx:ASPxTextBox>
         </td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>
   
    </div>
      </asp:Panel>
      
   </dx:ContentControl>
                                </ContentCollection>
                                </dx:TabPage>
<dx:TabPage Text="ساعتی"><ContentCollection>
<dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                             <asp:Panel runat="server" ID="panelHourly">
         
    <div id="divHeaderMenuHourly" dir="rtl" style="width:100%">
    <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeaderHourly" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeaderHourly_DashboardUser">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderHourlyClick(e);}"></ClientSideEvents>
<Items>
<dx:MenuItem Name="SaveMenuHeaderHourly_DashboardUser" Text="ثبت">
<Image Url="~/img/save.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="CancelMenuHeaderHourly_DashboardUser" Text="انصراف">
<Image Url="~/img/cancel.png"></Image>
</dx:MenuItem>

</Items>

<LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif"></LoadingPanelImage>

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

<ItemStyle DropDownButtonSpacing="12px" ToolbarDropDownButtonSpacing="5px" 
            ToolbarPopOutImageSpacing="5px" PopOutImageSpacing="18px" Cursor="pointer" 
            VerticalAlign="Middle"></ItemStyle>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
</dx:ASPxMenu>

       
    </div>
    <br />
    <div id="div2" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="90%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelSearchHourlyPremit" 
            ClientInstanceName="PanelSearchHourly">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox runat="server" ValueType="System.String" 
             ID="ASPxComboBoxTrafficTypeHourly" 
             ClientInstanceName="ComboBoxTrafficTypeHourly">
</dx:ASPxComboBox>

     </td>
     <td align="left">
         تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker runat="server" Regional="fa" DateFormat="YMD" 
             IEDateFormat="YMD" Width="90px" ID="DateHourly" CurrentText=""></cc1:JQDatePicker>
</td>
     <td align="left">
         از ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditFromHourHourly" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditFromHourHourly">
         </dx:ASPxTimeEdit>
</td>
     <td align="right">
         تا ساعت</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditToHourHourly" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditToHourHourly">
         </dx:ASPxTimeEdit>
     </td>
 </tr>
     <tr>
         <td align="left">
              توضیحات</td>
         <td align="right" colspan="7">
              <dx:ASPxTextBox runat="server" Width="95%" 
                 ID="ASPxTextBoxCommentHourly" ClientInstanceName="TextBoxCommentHourly">
</dx:ASPxTextBox></td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

   
    </div>
  
    
      </asp:Panel>

                             </dx:ContentControl>
</ContentCollection>
</dx:TabPage>
<dx:TabPage Text="اضافه کار دستوری"><ContentCollection>
<dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                             <asp:Panel runat="server" ID="panel1">
         
    <div id="div4" dir="rtl" style="width:100%">
    <dx:ASPxMenu runat="server" AutoSeparators="RootOnly" 
                 ClientInstanceName="MenuHeaderOvertime" RightToLeft="True" 
                 GutterImageSpacing="7px" ShowPopOutImages="True" 
                 SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" CssPostfix="Aqua" 
                 CssFilePath="~/App_Themes/Aqua/{0}/styles.css" Font-Bold="True" 
                 Font-Names="Tahoma" Font-Size="8pt" ID="ASPxMenuHeaderOvertime_DashboardUser">
<ClientSideEvents ItemClick="function(s, e){onItemMenuHeaderOverTimeClick(e);}"></ClientSideEvents>
<Items>

<dx:MenuItem Name="SaveMenuHeaderOvertime_DashboardUser" Text="ثبت">
<Image Url="~/img/save.png"></Image>
</dx:MenuItem>
<dx:MenuItem Name="CancelMenuHeaderOvertime_DashboardUser" Text="انصراف">
<Image Url="~/img/cancel.png"></Image>
</dx:MenuItem>

</Items>

<LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif"></LoadingPanelImage>

<RootItemSubMenuOffset FirstItemX="-1" FirstItemY="-1" X="-1" Y="-1"></RootItemSubMenuOffset>

<ItemStyle DropDownButtonSpacing="12px" ToolbarDropDownButtonSpacing="5px" 
            ToolbarPopOutImageSpacing="5px" PopOutImageSpacing="18px" Cursor="pointer" 
            VerticalAlign="Middle"></ItemStyle>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>
</dx:ASPxMenu>

       
    </div>
    <br />
    <div id="div5" dir="rtl" style="width:100%" align="center">
    <dx:ASPxRoundPanel runat="server" GroupBoxCaptionOffsetY="-28px" HeaderText="" 
            Width="90%" SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css" 
            RightToLeft="True" CssPostfix="Aqua" 
            CssFilePath="~/App_Themes/Aqua/{0}/styles.css" 
            ID="ASPxRoundPanelSearchHourlyTraffic" 
            ClientInstanceName="PanelSearchHourly">
<ContentPaddings Padding="14px"></ContentPaddings>
<PanelCollection>
<dx:PanelContent ID="PanelContent4" runat="server" SupportsDisabledAttribute="True">
 <table dir="rtl" style="width:100%" cellspacing="5">
 <tr>
 <td align="left">نوع تردد</td>
     <td align="right">
         <dx:ASPxComboBox runat="server" ValueType="System.String" 
             ID="ASPxComboBoxTrafficTypeOverTime" 
             ClientInstanceName="ComboBoxTrafficTypeOverTime" SelectedIndex="0">
             <Items>
                 <dx:ListEditItem Selected="True" Text="اضافه کار دستوری" Value="99" />
             </Items>
</dx:ASPxComboBox>

     </td>
     <td align="left">
         تاریخ</td>
     <td align="right">
         <cc1:JQDatePicker runat="server" Regional="fa" DateFormat="YMD" 
             IEDateFormat="YMD" Width="90px" ID="DateOverTime" CurrentText=""></cc1:JQDatePicker>
</td>
     <td align="left">
         مقدار</td>
     <td align="right">
         <dx:ASPxTimeEdit ID="ASPxTimeEditHourOverTime" runat="server" Width="65px" 
             EditFormat="Custom" EditFormatString="HH:mm" 
             ClientInstanceName="TimeEditHourOverTime">
         </dx:ASPxTimeEdit>
</td>
     <td align="right">
         &nbsp;</td>
     <td align="right">
         &nbsp;</td>
 </tr>
     <tr>
         <td align="left">
             توضیحات</td>
         <td align="right" colspan="7">
             <dx:ASPxTextBox runat="server" Width="95%" 
                 ID="ASPxTextBoxCommentOverTime" ClientInstanceName="TextBoxCommentOverTime">
</dx:ASPxTextBox></td>
     </tr>
 </table>
</dx:PanelContent>
</PanelCollection>
</dx:ASPxRoundPanel>

   
    </div>
  
    
      </asp:Panel>

                             </dx:ContentControl>
</ContentCollection>
</dx:TabPage>
                                </TabPages>
                                
                              <LoadingPanelImage Url="~/App_Themes/Aqua/Web/Loading.gif">
                                </LoadingPanelImage>
                                <Paddings Padding="2px" PaddingLeft="5px" PaddingRight="5px" />

                                <ContentStyle>
                                    <Border BorderColor="#AECAF0" BorderStyle="Solid" BorderWidth="1px" />
                                </ContentStyle>
                            
                                </dx:ASPxPageControl>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl></asp:Panel>
    <dx:ASPxCallback ID="ASPxCallbackInsertRequestDaily" runat="server" 
          ClientInstanceName="CallbackInsertRequestDaily" 
          oncallback="ASPxCallbackInsertRequestDaily_Callback">
          <ClientSideEvents CallbackComplete="function(s,e){ CallbackInsertRequestDaily_CallbackComplete(e);}" />
      </dx:ASPxCallback>
                <dx:ASPxCallback ID="ASPxCallbackInsertRequestHourly" runat="server" 
          ClientInstanceName="CallbackInsertRequestHourly" 
          oncallback="ASPxCallbackInsertRequestHourly_Callback">
          <ClientSideEvents CallbackComplete="function(s ,e){ CallbackInsertRequestHourly_CallbackComplete(e);}" />
      </dx:ASPxCallback>
         <dx:ASPxCallback ID="ASPxCallbackInsertRequestOvertime" runat="server" 
          ClientInstanceName="CallbackInsertRequestOvertime" 
          oncallback="ASPxCallbackInsertRequestOvertime_Callback">
          <ClientSideEvents CallbackComplete="function(s ,e){ CallbackInsertRequestOvertime_CallbackComplete(e);}" />
      </dx:ASPxCallback>
                     <dx:ASPxCallback ID="ASPxCallbackDeleteRequest" runat="server" 
          ClientInstanceName="CallbackDeleteRequest" 
          oncallback="ASPxCallbackDeleteRequest_Callback">
     <ClientSideEvents CallbackComplete="function(s ,e){ CallbackDeleteRequestEndCallback(e)}" />
     </dx:ASPxCallback>                    
    </form>
</body>
</html>

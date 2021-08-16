<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConceptsManagement.aspx.cs"
    Inherits="GTS.Clock.RuleDesigner.UI.Web.ConceptsManagement" %>

<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="css/colorPickerStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/combobox.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="Css/toolbar.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/dialog.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/iframe.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/tableStyle.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="css/label.css" runat="server" type="text/css" rel="Stylesheet" />
    <link href="Css/gridStyle.css" runat="server" type="text/css" rel="stylesheet" />
    <link href="css/alert_box.css" runat="server" type="text/css" rel="Stylesheet" />
    <title></title>
    <style type="text/css">
        .auto-style1
        {
            color: black;
            font-family: Tahoma;
            font-size: 12px;
            height: 36px;
        }

        .auto-style2
        {
            height: 36px;
        }
    </style>
</head>
<body>
    <script type="text/javascript" src="JS/jquery.js"></script>
    <form id="ConceptsManagement" runat="server" dir="rtl">
        <table id="tblConcepts_ConceptsForm" style="width: 97%; height: 400px; font-family: Arial; font-size: small; text-align: right;" class="BoxStyle">
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <ComponentArt:ToolBar ID="TlbConcepts" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                    DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                    DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                    DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" DefaultItemTextImageSpacing="0"
                                    ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px" UseFadeEffect="false">
                                    <Items>
                                        <ComponentArt:ToolBarItem ID="tlbItemNew_TlbConcepts" runat="server" ClientSideCommand="tlbConceptNew_TlbConcepts_onClick();"
                                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="add.png"
                                            ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptNew_TlbConcepts"
                                            TextImageSpacing="5" />
                                        <ComponentArt:ToolBarItem ID="tlbItemEdit_TlbConcepts" runat="server" ClientSideCommand="tlbConceptEdit_TlbConcepts_onClick();"
                                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="edit.png"
                                            ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptEdit_TlbConcepts"
                                            TextImageSpacing="5" />
                                        <ComponentArt:ToolBarItem ID="tlbItemDelete_TlbConcepts" runat="server" DropDownImageHeight="16px"
                                            ClientSideCommand="tlbConceptDelete_TlbConcepts_onClick();" DropDownImageWidth="16px"
                                            ImageHeight="16px" ImageUrl="remove.png" ImageWidth="16px" ConceptType="Command"
                                            meta:resourcekey="tlbConceptDelete" TextImageSpacing="5" />
                                        <%-- <ComponentArt:ToolBarItem ID="tlbItemHelp_TlbConcepts" runat="server" DropDownImageHeight="16px"
                                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="help.gif" ImageWidth="16px"
                                            ConceptType="Command" meta:resourcekey="tlbConceptHelp" TextImageSpacing="5"
                                            ClientSideCommand="tlbConceptHelp_TlbConcepts_onClick();" />--%>
                                        <ComponentArt:ToolBarItem ID="tlbItemSave_TlbConcepts" runat="server" DropDownImageHeight="16px"
                                            ClientSideCommand="tlbConceptSave_TlbConcepts_onClick();" DropDownImageWidth="16px"
                                            ImageHeight="16px" ImageUrl="save_silver.png" ImageWidth="16px" ConceptType="Command"
                                            meta:resourcekey="tlbConceptSave" TextImageSpacing="5" Enabled="false" />
                                        <ComponentArt:ToolBarItem ID="tlbItemCancel_TlbTlbConcepts" runat="server" ClientSideCommand="tlbConceptCancel_TlbTlbConcepts_onClick();"
                                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="cancel_silver.png"
                                            ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptCancel" TextImageSpacing="5"
                                            Enabled="false" />
                                        <ComponentArt:ToolBarItem ID="tlbItemDefine_TlbTlbConcepts" runat="server" ClientSideCommand="tlbConceptDefine_TlbTlbConcepts_onClick();"
                                            DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="view_detailed.png"
                                            ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptDefine" TextImageSpacing="5"
                                            Enabled="false" />
                                        <ComponentArt:ToolBarItem ID="tlbItemFormReconstruction_TlbConcept" runat="server"
                                            ClientSideCommand="tlbItemFormReconstruction_TlbConcept_onClick();" DropDownImageHeight="16px"
                                            DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="refresh.png" ImageWidth="16px"
                                            ItemType="Command" meta:resourcekey="tlbItemFormReconstruction_TlbConcept" TextImageSpacing="5" />
                                        <ComponentArt:ToolBarItem ID="tlbItemExit_TlbConcepts" runat="server" DropDownImageHeight="16px"
                                            ClientSideCommand="tlbConceptExit_TlbConcepts_onClick();" DropDownImageWidth="16px"
                                            ImageHeight="16px" ImageUrl="exit.png" ImageWidth="16px" ConceptType="Command"
                                            meta:resourcekey="tlbConceptExit" TextImageSpacing="5" />
                                    </Items>
                                </ComponentArt:ToolBar>
                            </td>
                            <td id="ActionMode_Concepts" class="ToolbarMode"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td class="WhiteLabel">
                                <asp:Label ID="lblConceptName" runat="server" meta:resourcekey="lblConceptName"></asp:Label>
                            </td>
                            <td>
                                <input id="txtCnptName" type="text" runat="server" style="width: 200px;" class="TextBoxes" disabled="disabled"
                                    onclick="this.select();" onfocus="this.select();" />
                            </td>
                            <td class="WhiteLabel">
                                <asp:Label ID="lblConceptCode" runat="server" meta:resourcekey="lblConceptCode"></asp:Label>
                            </td>
                            <td>
                                <input id="txtCnptCode" type="text" runat="server" style="width: 200px;" class="TextBoxes" disabled="disabled"
                                    onclick="this.select();" onfocus="this.select();" />
                            </td>
                            <td class="WhiteLabel">
                                <asp:Label ID="lblReservedField" runat="server" meta:resourcekey="lblReservedField"></asp:Label>
                            </td>
                            <td>
                                <input id="txtCnpKeyColumnName" type="text" runat="server" style="width: 200px;" class="TextBoxes"
                                    onclick="this.select();" onfocus="this.select();" disabled="disabled" />
                            </td>
                            <td class="WhiteLabel">
                                <asp:Label ID="lblConceptColor" runat="server" meta:resourcekey="lblConceptColor"></asp:Label>
                            </td>
                            <td>
                                <div>
                                    <div>
                                        <span class="lbl" style="line-height: 24px;"></span><a id="a_ColorPicker" href="javascript:void(0);"
                                            class="choose" onclick="ShowDialogColors();"><span id="clr_ColorPicker"></span><span
                                                class="lbl">...</span> </a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblConceptType" runat="server" meta:resourcekey="lblConceptType"></asp:Label>
                            </td>
                            <td>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <ComponentArt:CallBack runat="server" ID="CallBack_cmbPeriodicTypeField_Concepts" OnCallback="CallBack_cmbPeriodicTypeField_Concepts_onCallBack"
                                                Height="26">
                                                <Content>
                                                    <ComponentArt:ComboBox ID="cmbPeriodicTypeField_Concepts" runat="server" AutoComplete="true"
                                                        AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                        DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                        DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                        ConceptCssClass="comboConcept" ConceptHoverCssClass="comboConceptHover" SelectedConceptCssClass="comboConceptHover"
                                                        Style="width: 200px" TextBoxCssClass="comboTextBox" Enabled="false">
                                                        <ClientEvents>
                                                            <Expand EventHandler="cmbPeriodicTypeField_Concepts_onExpand" />
                                                            <Collapse EventHandler="cmbPeriodicTypeField_Concepts_onCollapse" />
                                                        </ClientEvents>
                                                    </ComponentArt:ComboBox>
                                                    <asp:HiddenField runat="server" ID="ErrorHiddenField_TypeFields" />
                                                </Content>
                                                <ClientEvents>
                                                    <BeforeCallback EventHandler="cmbPeriodicTypeField_Concepts_onBeforeCallback" />
                                                    <CallbackComplete EventHandler="cmbPeriodicTypeField_Concepts_onCallbackComplete" />
                                                    <CallbackError EventHandler="cmbPeriodicTypeField_Concepts_onCallbackError" />
                                                </ClientEvents>
                                            </ComponentArt:CallBack>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <asp:Label ID="lblConceptMatt" runat="server" meta:resourcekey="lblConceptMatt"></asp:Label>
                            </td>
                            <td>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <ComponentArt:CallBack runat="server" ID="CallBack_cmbTypeField_Concepts" OnCallback="CallBack_cmbTypeField_Concepts_onCallBack"
                                                Height="26">
                                                <Content>
                                                    <ComponentArt:ComboBox ID="cmbTypeField_Concepts" runat="server" AutoComplete="true"
                                                        AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                        DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                        DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                        ConceptCssClass="comboConcept" ConceptHoverCssClass="comboConceptHover" SelectedConceptCssClass="comboConceptHover"
                                                        Style="width: 200px" TextBoxCssClass="comboTextBox" Enabled="False">
                                                        <ClientEvents>
                                                            <Expand EventHandler="cmbTypeField_Concepts_onExpand" />
                                                            <Collapse EventHandler="cmbTypeField_Concepts_onCollapse" />
                                                        </ClientEvents>
                                                    </ComponentArt:ComboBox>
                                                    <asp:HiddenField runat="server" ID="ErrorHiddenField_MattFields" />
                                                </Content>
                                                <ClientEvents>
                                                    <BeforeCallback EventHandler="cmbTypeField_Concepts_onBeforeCallback" />
                                                    <CallbackComplete EventHandler="cmbTypeField_Concepts_onCallbackComplete" />
                                                    <CallbackError EventHandler="cmbTypeField_Concepts_onCallbackError" />
                                                </ClientEvents>
                                            </ComponentArt:CallBack>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <asp:Label ID="lblExecuteTime" runat="server" meta:resourcekey="lblExecuteTime"></asp:Label>
                            </td>
                            <td>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <ComponentArt:CallBack runat="server" ID="CallBack_ExecuteTimeField_Concepts" OnCallback="CallBack_ExecuteTimeField_Concepts_onCallBack"
                                                Height="26">
                                                <Content>
                                                    <ComponentArt:ComboBox ID="cmbCallSituationTypeField_Concepts" runat="server" AutoComplete="true"
                                                        AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                        DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                        DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                        ConceptCssClass="comboConcept" ConceptHoverCssClass="comboConceptHover" SelectedConceptCssClass="comboConceptHover"
                                                        Style="width: 200px" TextBoxCssClass="comboTextBox" Enabled="False">
                                                        <ClientEvents>
                                                            <Expand EventHandler="cmbCallSituationTypeField_Concepts_onExpand" />
                                                            <Collapse EventHandler="cmbCallSituationTypeField_Concepts_onCollapse" />
                                                        </ClientEvents>
                                                    </ComponentArt:ComboBox>
                                                    <asp:HiddenField runat="server" ID="ErrorHiddenField_ExecuteFields" />
                                                </Content>
                                                <ClientEvents>
                                                    <BeforeCallback EventHandler="cmbCallSituationTypeField_Concepts_onBeforeCallback" />
                                                    <CallbackComplete EventHandler="cmbCallSituationTypeField_Concepts_onCallbackComplete" />
                                                    <CallbackError EventHandler="cmbCallSituationTypeField_Concepts_onCallbackError" />
                                                </ClientEvents>
                                            </ComponentArt:CallBack>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <asp:Label ID="lblStorageMethod" runat="server" meta:resourcekey="lblStorageMethod"></asp:Label>
                            </td>
                            <td>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <ComponentArt:CallBack runat="server" ID="CallBack_cmbPersistSituationTypeField_Concepts" OnCallback="CallBack_cmbPersistSituationTypeField_Concepts_onCallBack"
                                                Height="26">
                                                <Content>
                                                    <ComponentArt:ComboBox ID="cmbPersistSituationTypeField_Concepts" runat="server" AutoComplete="true"
                                                        AutoFilter="true" AutoHighlight="false" CssClass="comboBox" DropDownCssClass="comboDropDown"
                                                        DropDownResizingMode="Corner" DropHoverImageUrl="Images/ComboBox/ddn-hover.png"
                                                        DropImageUrl="Images/ComboBox/ddn.png" FocusedCssClass="comboBoxHover" HoverCssClass="comboBoxHover"
                                                        ConceptCssClass="comboConcept" ConceptHoverCssClass="comboConceptHover" SelectedConceptCssClass="comboConceptHover"
                                                        Style="width: 200px" TextBoxCssClass="comboTextBox" Enabled="False">
                                                        <ClientEvents>
                                                            <Expand EventHandler="cmbPersistSituationTypeField_Concepts_onExpand" />
                                                            <Collapse EventHandler="cmbPersistSituationTypeField_Concepts_onCollapse" />
                                                        </ClientEvents>
                                                    </ComponentArt:ComboBox>
                                                    <asp:HiddenField runat="server" ID="ErrorHiddenField_StorageMethodField" />
                                                </Content>
                                                <ClientEvents>
                                                    <BeforeCallback EventHandler="cmbPersistSituationTypeField_Concepts_onBeforeCallback" />
                                                    <CallbackComplete EventHandler="cmbPersistSituationTypeField_Concepts_onCallbackComplete" />
                                                    <CallbackError EventHandler="cmbPersistSituationTypeField_Concepts_onCallbackError" />
                                                </ClientEvents>
                                            </ComponentArt:CallBack>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td colspan="7">
                                <textarea id="txtCnpDescription" cols="20" rows="2" style="width: 99%; height: 30px;" class="TextBoxes"
                                    onclick="this.select();" onfocus="this.select();" disabled="disabled"></textarea>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 45%;" class="BoxStyle">
                                    <tr>
                                        <td>&nbsp;
                            <asp:Label ID="lblQuickSerch_Concept" runat="server" meta:resourcekey="lblQuickSerch_Concept"
                                Text=": جستجوی سریع" CssClass="WhiteLabel"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 80%">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <input type="text" runat="server" style="width: 99%;" class="TextBoxes" id="txtSerchTerm_Concept" />
                                                    </td>
                                                    <td style="width: 5%">
                                                        <ComponentArt:ToolBar ID="tlbItemQuickSearch" runat="server" CssClass="toolbar"
                                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText"
                                                            DefaultItemTextImageSpacing="0" ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px"
                                                            UseFadeEffect="false">
                                                            <Items>
                                                                <ComponentArt:ToolBarItem ID="tlbItemSearch_TlbConceptQuickSearch" runat="server"
                                                                    ClientSideCommand="tlbItemSearch_TlbConceptQuickSearch_onClick();" DropDownImageHeight="16px"
                                                                    DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="search.png" ImageWidth="16px"
                                                                    ItemType="Command" meta:resourcekey="tlbItemSearch_TlbConceptQuickSearch" TextImageSpacing="5" />
                                                            </Items>
                                                        </ComponentArt:ToolBar>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 60%">
                                <table style="width: 100%;" class="BoxStyle">
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td id="" class="HeaderLabel" style="width: 95%">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td id="header_ConceptsBox_Concepts" class="HeaderLabel" style="width: 50%;">Concepts
                                                                </td>
                                                                <td id="loadingPanel_GridConcepts_Concepts" class="HeaderLabel" style="width: 45%"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100%">
                                            <ComponentArt:CallBack ID="CallBack_GridConcepts_Concept" OnCallback="CallBack_GridConcepts_Concept_OnCallBack"
                                                runat="server">
                                                <Content>
                                                    <ComponentArt:DataGrid ID="GridConcepts_Concepts" runat="server" AllowHorizontalScrolling="true"
                                                        CssClass="Grid" EnableViewState="true" ShowFooter="false" FillContainer="true"
                                                        FooterCssClass="GridFooter" Height="150" ImagesBaseUrl="images/Grid/" PagePaddingEnabled="true"
                                                        PageSize="10" RunningMode="Client" AllowMultipleSelect="false" AllowColumnResizing="false"
                                                        ScrollBar="Off" ScrollTopBottomImagesEnabled="true" ScrollTopBottomImageHeight="2"
                                                        ScrollTopBottomImageWidth="16" ScrollImagesFolderUrl="images/Grid/scroller/"
                                                        ScrollButtonWidth="16" ScrollButtonHeight="17" ScrollBarCssClass="ScrollBar"
                                                        ScrollGripCssClass="ScrollGrip" ScrollBarWidth="16" Width="200">
                                                        <Levels>
                                                            <ComponentArt:GridLevel AlternatingRowCssClass="AlternatingRow" DataCellCssClass="DataCell"
                                                                AllowSorting="false" HeadingCellCssClass="HeadingCell" HeadingTextCssClass="HeadingCellText"
                                                                RowCssClass="Row" SelectedRowCssClass="SelectedRow" SelectorCellCssClass="SelectorCell"
                                                                SortAscendingImageUrl="asc.gif" SortDescendingImageUrl="desc.gif" SortImageHeight="5"
                                                                DataKeyField="ID" SortImageWidth="9" HoverRowCssClass="HoverRow">
                                                                <Columns>
                                                                    <ComponentArt:GridColumn DataField="ID" Visible="false" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="Name" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptName" HeadingTextCssClass="HeadingText" />
                                                                    <%--<ComponentArt:GridColumn Align="Center" DataField="Script" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptScript" HeadingTextCssClass="HeadingText" />--%>
                                                                    <ComponentArt:GridColumn Align="Center" DataField="IdentifierCode" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptIdentifierCode" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="PeriodicTypeTitle" DataCellClientTemplateId="DataCellClientTemplate_clmnPeriodicTypeTitle_GridConcepts_Concepts" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptPeriodicType" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn DataField="PeriodicType" Visible="false" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="Color" DataCellClientTemplateId="DataCellClientTemplate_clmnColor_GridConcepts_Concepts" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptColor" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="TypeTitle" DataCellClientTemplateId="DataCellClientTemplate_clmnTypeTitle_GridConcepts_Concepts" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptType" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn DataField="Type" Visible="false" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="CalcSituationTypeTitle" DataCellClientTemplateId="DataCellClientTemplate_clmnCalSituationTypeTitle_GridConcepts_Concepts" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptCalcSituationType" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn DataField="CalcSituationType" Visible="false" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="KeyColumnName" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptColumnName" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="PersistSituationTypeTitle" DataCellClientTemplateId="DataCellClientTemplate_clmnPersistSituationTypeTitle_GridConcepts_Concepts" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptPersistSituationType" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn DataField="PersistSituationType" Visible="false" />
                                                                    <ComponentArt:GridColumn Align="Center" DataField="Description" DefaultSortDirection="Descending" Width="110" meta:resourcekey="GridColumnConceptDescription" HeadingTextCssClass="HeadingText" />
                                                                    <ComponentArt:GridColumn DataField="UserDefined" Visible="false" />
                                                                    <ComponentArt:GridColumn DataField="Script" Visible="false" />
                                                                    <ComponentArt:GridColumn DataField="CSharpCode" Visible="false" />
                                                                    <ComponentArt:GridColumn DataField="JsonObject" Visible="false" />
                                                                </Columns>
                                                            </ComponentArt:GridLevel>
                                                        </Levels>
                                                        <ClientTemplates>
                                                            <ComponentArt:ClientTemplate runat="server" ID="DataCellClientTemplate_clmnPeriodicTypeTitle_GridConcepts_Concepts">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td align="center">##GetPeriodicTypeTitle_Concept(DataItem.GetMember('PeriodicType').Value)##
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ComponentArt:ClientTemplate>
                                                            <ComponentArt:ClientTemplate runat="server" ID="DataCellClientTemplate_clmnTypeTitle_GridConcepts_Concepts">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td align="center">##GetTypeTitle_Concept(DataItem.GetMember('Type').Value)##
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ComponentArt:ClientTemplate>
                                                            <ComponentArt:ClientTemplate runat="server" ID="DataCellClientTemplate_clmnCalSituationTypeTitle_GridConcepts_Concepts">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td align="center">##GetCalSituationTypeTitle_Concept(DataItem.GetMember('CalcSituationType').Value)##
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ComponentArt:ClientTemplate>
                                                            <ComponentArt:ClientTemplate runat="server" ID="DataCellClientTemplate_clmnPersistSituationTypeTitle_GridConcepts_Concepts">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td align="center">##GetPersistSituationTypeTitle_Concept(DataItem.GetMember('PersistSituationType').Value)##
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ComponentArt:ClientTemplate>
                                                            <ComponentArt:ClientTemplate ID="DataCellClientTemplate_clmnColor_GridConcepts_Concepts">
                                                                <table style="width: 100%; cursor: crosshair; background-color: ##DataItem.GetMember('Color').Value##;">
                                                                    <tr>
                                                                        <td style="height: 100%;" align="center">رنگ<!--##DataItem.GetMember('Color').Value##--></td>
                                                                    </tr>
                                                                </table>
                                                            </ComponentArt:ClientTemplate>
                                                        </ClientTemplates>
                                                        <ClientEvents>
                                                            <ItemSelect EventHandler="GridConcepts_Concepts_onItemSelect" />
                                                            <Load EventHandler="GridConcepts_Concepts_onLoad" />
                                                        </ClientEvents>
                                                    </ComponentArt:DataGrid>
                                                    <asp:HiddenField runat="server" ID="ErrorHiddenField_Concepts" />
                                                    <asp:HiddenField runat="server" ID="hfConceptsCount_Concepts" />
                                                    <asp:HiddenField runat="server" ID="hfConceptsPageCount_Concepts" />
                                                </Content>
                                                <ClientEvents>
                                                    <CallbackComplete EventHandler="CallBack_GridConcepts_Concept_OnCallbackComplete" />
                                                    <CallbackError EventHandler="CallBack_GridConcepts_Concept_onCallbackError" />
                                                </ClientEvents>
                                            </ComponentArt:CallBack>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100%">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td id="Td1" runat="server" meta:resourcekey="AlignObj" style="width: 75%;">
                                                        <ComponentArt:ToolBar runat="server" ID="TlbPaging_GridConcepts_Concepts" CssClass="toolbar"
                                                            DefaultItemActiveCssClass="itemActive" DefaultItemCheckedCssClass="itemChecked"
                                                            DefaultItemCheckedHoverCssClass="itemActive" DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover"
                                                            DefaultItemImageHeight="16px" DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageOnly"
                                                            DefaultItemTextImageSpacing="0" ImagesBaseUrl="images/ToolBar/" ItemSpacing="1px"
                                                            Style="direction: ltr" UseFadeEffect="false">
                                                            <Items>
                                                                <ComponentArt:ToolBarItem ID="tlbItemRefresh_TlbPaging_GridConcepts_Concepts"
                                                                    runat="server" ClientSideCommand="tlbConceptRefresh_TlbPaging_GridConcepts_Concepts_onClick();"
                                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                                    ImageUrl="refresh.png" ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptRefresh_TlbPaging_GridConcepts_Concepts"
                                                                    TextImageSpacing="5" TextImageRelation="ImageOnly" />
                                                                <ComponentArt:ToolBarItem ID="tlbItemFirst_TlbPaging_GridConcepts_Concepts" runat="server"
                                                                    ClientSideCommand="tlbConceptFirst_TlbPaging_GridConcepts_Concepts_onClick();"
                                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                                    ImageUrl="first.png" ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptFirst_TlbPaging_GridConcepts_Concepts"
                                                                    TextImageSpacing="5" TextImageRelation="ImageOnly" />
                                                                <ComponentArt:ToolBarItem ID="tlbItemBefore_TlbPaging_GridConcepts_Concepts" runat="server"
                                                                    ClientSideCommand="tlbConceptBefore_TlbPaging_GridConcepts_Concepts_onClick();"
                                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                                    ImageUrl="Before.png" ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptBefore_TlbPaging_GridConcepts_Concepts"
                                                                    TextImageSpacing="5" TextImageRelation="ImageOnly" />
                                                                <ComponentArt:ToolBarItem ID="tlbItemNext_TlbPaging_GridConcepts_Concepts" runat="server"
                                                                    ClientSideCommand="tlbConceptNext_TlbPaging_GridConcepts_Concepts_onClick();"
                                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                                    ImageUrl="Next.png" ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptNext_TlbPaging_GridConcepts_Concepts"
                                                                    TextImageSpacing="5" TextImageRelation="ImageOnly" />
                                                                <ComponentArt:ToolBarItem ID="tlbItemLast_TlbPaging_GridConcepts_Concepts" runat="server"
                                                                    ClientSideCommand="tlbConceptLast_TlbPaging_GridConcepts_Concepts_onClick();"
                                                                    DropDownImageHeight="16px" DropDownImageWidth="16px" Enabled="true" ImageHeight="16px"
                                                                    ImageUrl="last.png" ImageWidth="16px" ConceptType="Command" meta:resourcekey="tlbConceptLast_TlbPaging_GridConcepts_Concepts"
                                                                    TextImageSpacing="5" TextImageRelation="ImageOnly" />
                                                            </Items>
                                                        </ComponentArt:ToolBar>
                                                    </td>
                                                    <td id="footer_GridConcepts_Concepts" class="WhiteLabel" style="width: 25%"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <ComponentArt:Dialog ID="DialogColors" runat="server" AllowDrag="true" AllowResize="false"
            Alignment="MiddleCentre" Width="325" Height="363" ContentCssClass="dlg">
            <Content>
                <div class="ttl" onmousedown="DialogColors.StartDrag(event);">
                    <a class="close" href="javascript:void(0);" onclick="DialogColors.close();this.blur();return false;">
                        <span>X</span></a>
                </div>
                <div class="con">
                    <ComponentArt:MultiPage ID="DialogPages" runat="server">
                        <ComponentArt:PageView ID="GridPage">
                            <div class="pg">
                                <ComponentArt:ColorPicker ID="ColorGrid" GridColumns="12" Mode="Grid" CssClass="grid"
                                    ColorCssClass="swatch" ColorHoverCssClass="swatch-h" ColorActiveCssClass="swatch-a"
                                    ColorGridCssClass="swatches" GridCellSpacing="1" runat="server">
                                    <ClientEvents>
                                        <ColorChanged EventHandler="color_changed" />
                                    </ClientEvents>
                                    <Colors>
                                        <ComponentArt:ColorPickerColor Hex="#ff0000" />
                                        <ComponentArt:ColorPickerColor Hex="#ff8f00" />
                                        <ComponentArt:ColorPickerColor Hex="#ffff00" />
                                        <ComponentArt:ColorPickerColor Hex="#c5ff00" />
                                        <ComponentArt:ColorPickerColor Hex="#00ff00" />
                                        <ComponentArt:ColorPickerColor Hex="#00ff98" />
                                        <ComponentArt:ColorPickerColor Hex="#00ffff" />
                                        <ComponentArt:ColorPickerColor Hex="#00c1ff" />
                                        <ComponentArt:ColorPickerColor Hex="#0000ff" />
                                        <ComponentArt:ColorPickerColor Hex="#9400ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ff00ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ff0058" />
                                        <ComponentArt:ColorPickerColor Hex="#e51919" />
                                        <ComponentArt:ColorPickerColor Hex="#e58b19" />
                                        <ComponentArt:ColorPickerColor Hex="#e4e519" />
                                        <ComponentArt:ColorPickerColor Hex="#b6e519" />
                                        <ComponentArt:ColorPickerColor Hex="#19e519" />
                                        <ComponentArt:ColorPickerColor Hex="#19e592" />
                                        <ComponentArt:ColorPickerColor Hex="#19e4e5" />
                                        <ComponentArt:ColorPickerColor Hex="#19b3e5" />
                                        <ComponentArt:ColorPickerColor Hex="#1919e5" />
                                        <ComponentArt:ColorPickerColor Hex="#8f19e5" />
                                        <ComponentArt:ColorPickerColor Hex="#e519e4" />
                                        <ComponentArt:ColorPickerColor Hex="#e5195f" />
                                        <ComponentArt:ColorPickerColor Hex="#a33636" />
                                        <ComponentArt:ColorPickerColor Hex="#a37336" />
                                        <ComponentArt:ColorPickerColor Hex="#a3a336" />
                                        <ComponentArt:ColorPickerColor Hex="#8aa336" />
                                        <ComponentArt:ColorPickerColor Hex="#36a336" />
                                        <ComponentArt:ColorPickerColor Hex="#36a376" />
                                        <ComponentArt:ColorPickerColor Hex="#36a3a3" />
                                        <ComponentArt:ColorPickerColor Hex="#3688a3" />
                                        <ComponentArt:ColorPickerColor Hex="#3636a3" />
                                        <ComponentArt:ColorPickerColor Hex="#7536a3" />
                                        <ComponentArt:ColorPickerColor Hex="#a336a3" />
                                        <ComponentArt:ColorPickerColor Hex="#a3365c" />
                                        <ComponentArt:ColorPickerColor Hex="#602020" />
                                        <ComponentArt:ColorPickerColor Hex="#604420" />
                                        <ComponentArt:ColorPickerColor Hex="#606020" />
                                        <ComponentArt:ColorPickerColor Hex="#516020" />
                                        <ComponentArt:ColorPickerColor Hex="#206020" />
                                        <ComponentArt:ColorPickerColor Hex="#206046" />
                                        <ComponentArt:ColorPickerColor Hex="#206060" />
                                        <ComponentArt:ColorPickerColor Hex="#205060" />
                                        <ComponentArt:ColorPickerColor Hex="#202060" />
                                        <ComponentArt:ColorPickerColor Hex="#452060" />
                                        <ComponentArt:ColorPickerColor Hex="#602060" />
                                        <ComponentArt:ColorPickerColor Hex="#602036" />
                                        <ComponentArt:ColorPickerColor Hex="#ff9999" />
                                        <ComponentArt:ColorPickerColor Hex="#ffd299" />
                                        <ComponentArt:ColorPickerColor Hex="#ffff99" />
                                        <ComponentArt:ColorPickerColor Hex="#e8ff99" />
                                        <ComponentArt:ColorPickerColor Hex="#99ff99" />
                                        <ComponentArt:ColorPickerColor Hex="#99ffd6" />
                                        <ComponentArt:ColorPickerColor Hex="#99ffff" />
                                        <ComponentArt:ColorPickerColor Hex="#99e6ff" />
                                        <ComponentArt:ColorPickerColor Hex="#9999ff" />
                                        <ComponentArt:ColorPickerColor Hex="#d499ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ff99ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ff99bc" />
                                        <ComponentArt:ColorPickerColor Hex="#ffe0e0" />
                                        <ComponentArt:ColorPickerColor Hex="#fff1e0" />
                                        <ComponentArt:ColorPickerColor Hex="#ffffe0" />
                                        <ComponentArt:ColorPickerColor Hex="#f8ffe0" />
                                        <ComponentArt:ColorPickerColor Hex="#e0ffe0" />
                                        <ComponentArt:ColorPickerColor Hex="#e0fff3" />
                                        <ComponentArt:ColorPickerColor Hex="#e0ffff" />
                                        <ComponentArt:ColorPickerColor Hex="#e0f7ff" />
                                        <ComponentArt:ColorPickerColor Hex="#e0e0ff" />
                                        <ComponentArt:ColorPickerColor Hex="#f2e0ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ffe0ff" />
                                        <ComponentArt:ColorPickerColor Hex="#ffe0eb" />
                                        <ComponentArt:ColorPickerColor Hex="#ffffff" />
                                        <ComponentArt:ColorPickerColor Hex="#e2e2e2" />
                                        <ComponentArt:ColorPickerColor Hex="#d7d7d7" />
                                        <ComponentArt:ColorPickerColor Hex="#cdcdcd" />
                                        <ComponentArt:ColorPickerColor Hex="#b7b7b7" />
                                        <ComponentArt:ColorPickerColor Hex="#898989" />
                                        <ComponentArt:ColorPickerColor Hex="#707070" />
                                        <ComponentArt:ColorPickerColor Hex="#555555" />
                                        <ComponentArt:ColorPickerColor Hex="#464646" />
                                        <ComponentArt:ColorPickerColor Hex="#252525" />
                                        <ComponentArt:ColorPickerColor Hex="#111111" />
                                        <ComponentArt:ColorPickerColor Hex="#000000" />
                                    </Colors>
                                </ComponentArt:ColorPicker>
                            </div>
                        </ComponentArt:PageView>
                    </ComponentArt:MultiPage>
                </div>
                <div class="ftr">
                    <div id="chip">
                    </div>
                    <div id="hex">
                    </div>
                </div>
            </Content>
            <ClientEvents>
                <OnShow EventHandler="DialogColors_OnShow" />
                <OnClose EventHandler="DialogColors_OnClose" />
            </ClientEvents>
        </ComponentArt:Dialog>
        <ComponentArt:Dialog ModalMaskImage="Images/Dialog/alpha.png" HeaderCssClass="headerCss"
            Modal="true" AllowResize="false" AllowDrag="false" Alignment="MiddleCentre" ID="DialogConfirm"
            runat="server" Width="280px">
            <Content>
                <table id="tblConfirm_DialogConfirm" style="width: 100%;" class="ConfirmStyle">
                    <tr align="center">
                        <td colspan="2">
                            <asp:Label ID="lblConfirm" runat="server" CssClass="WhiteLabel"></asp:Label>
                        </td>
                    </tr>
                    <tr align="center">
                        <td style="width: 50%">
                            <ComponentArt:ToolBar ID="TlbOkConfirm" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" ImagesBaseUrl="images/ToolBar/"
                                ItemSpacing="1px" UseFadeEffect="false">
                                <Items>
                                    <ComponentArt:ToolBarItem ID="tlbItemOk_TlbOkConfirm" runat="server" ClientSideCommand="tlbItemOk_TlbOkConfirm_onClick();"
                                        DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="save.png"
                                        ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemOk_TlbOkConfirm"
                                        TextImageSpacing="5" />
                                </Items>
                            </ComponentArt:ToolBar>
                        </td>
                        <td>
                            <ComponentArt:ToolBar ID="TlbCancelConfirm" runat="server" CssClass="toolbar" DefaultItemActiveCssClass="itemActive"
                                DefaultItemCheckedCssClass="itemChecked" DefaultItemCheckedHoverCssClass="itemActive"
                                DefaultItemCssClass="item" DefaultItemHoverCssClass="itemHover" DefaultItemImageHeight="16px"
                                DefaultItemImageWidth="16px" DefaultItemTextImageRelation="ImageBeforeText" ImagesBaseUrl="images/ToolBar/"
                                ItemSpacing="1px" UseFadeEffect="false">
                                <Items>
                                    <ComponentArt:ToolBarItem ID="tlbItemCancel_TlbCancelConfirm" runat="server" ClientSideCommand="tlbItemCancel_TlbCancelConfirm_onClick();"
                                        DropDownImageHeight="16px" DropDownImageWidth="16px" ImageHeight="16px" ImageUrl="cancel.png"
                                        ImageWidth="16px" ItemType="Command" meta:resourcekey="tlbItemCancel_TlbCancelConfirm"
                                        TextImageSpacing="5" />
                                </Items>
                            </ComponentArt:ToolBar>
                        </td>
                    </tr>
                </table>
            </Content>
        </ComponentArt:Dialog>
        <iframe id="hidden_IFrame_Concepts" runat="server" style="width: 0px; height: 0px"></iframe>
        <!-- Titles -->
        <asp:HiddenField runat="server" ID="hfConceptCodeTitle" meta:resourcekey="hfConceptCodeTitle" />
        <!-- /Titles -->
        <!-- State -->
        <asp:HiddenField runat="server" ID="hfStateView_Concepts" meta:resourcekey="hfView_Concepts" />
        <asp:HiddenField runat="server" ID="hfStateAdd_Concepts" meta:resourcekey="hfAdd_Concepts" />
        <asp:HiddenField runat="server" ID="hfStateEdit_Concepts" meta:resourcekey="hfEdit_Concepts" />
        <asp:HiddenField runat="server" ID="hfStateDelete_Concepts" meta:resourcekey="hfDelete_Concepts" />
        <asp:HiddenField runat="server" ID="hfStateErrorType_Concepts" meta:resourcekey="hfErrorType_Concepts" />
        <asp:HiddenField runat="server" ID="hfStateConnectionError_Concepts" meta:resourcekey="hfConnectionError_Concepts" />
        <asp:HiddenField runat="server" ID="hfDeleteMessage_Concepts" meta:resourcekey="hfDeleteMessage_Concepts" />
        <asp:HiddenField runat="server" ID="hfCloseMessage_Concepts" meta:resourcekey="hfCloseMessage_Concepts" />

        <!-- /State -->
        <asp:HiddenField runat="server" ID="hfConceptsPageSize_Concepts" />
        <asp:HiddenField runat="server" ID="hfloadingPanel_GridConcepts_Concepts" meta:resourcekey="hfloadingPanel_GridConcepts_Concepts" />
        <!-- Enums ErrorHiddenField_TypeFields -->
        <asp:HiddenField runat="server" ID="hfJsonEnum_PeriodicType" />
        <asp:HiddenField runat="server" ID="hfJsonEnum_Type" />
        <asp:HiddenField runat="server" ID="hfJsonEnum_CalSituationType" />
        <asp:HiddenField runat="server" ID="hfJsonEnum_PersistSituationType" />
    </form>
</body>
</html>

/* Variables */
var CurrentPageIndex_GridRules_Rules = 0;
var box_RuleSearch_Rules_IsShown = false;
var LoadState_Rules = 'Normal';
var CurrentPageCombosCallBackStateObj = new Object();
var CurrentPageState_Rules = 'View';
var SelectedRules_Rule = new Object();
var ConfirmState_Rules = null;
/* /Variables */

/*  UUU  */

function ChangePageState_Rules(State) {
    CurrentPageState_Rules = State;
    SetActionMode_Rules(State);

    CurrentPageState_Rules = State;
    SetActionMode_Rules(State);
    if (State == 'Add' || State == 'Edit' || State == 'Delete') {
        if (TlbRules.get_items().getItemById('tlbItemNew_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemNew_TlbRules').set_enabled(false);
            TlbRules.get_items().getItemById('tlbItemNew_TlbRules').set_imageUrl('add_silver.png');
        }
        if (TlbRules.get_items().getItemById('tlbItemEdit_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemEdit_TlbRules').set_enabled(false);
            TlbRules.get_items().getItemById('tlbItemEdit_TlbRules').set_imageUrl('edit_silver.png');
        }
        if (TlbRules.get_items().getItemById('tlbItemDelete_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemDelete_TlbRules').set_enabled(false);
            TlbRules.get_items().getItemById('tlbItemDelete_TlbRules').set_imageUrl('remove_silver.png');
        }
        TlbRules.get_items().getItemById('tlbItemSave_TlbRules').set_enabled(true);
        TlbRules.get_items().getItemById('tlbItemSave_TlbRules').set_imageUrl('save.png');
        TlbRules.get_items().getItemById('tlbItemCancel_TlbTlbRules').set_enabled(true);
        TlbRules.get_items().getItemById('tlbItemCancel_TlbTlbRules').set_imageUrl('cancel.png');
        TlbRules.get_items().getItemById('tlbItemDefine_TlbTlbRules').set_enabled(true);
        TlbRules.get_items().getItemById('tlbItemDefine_TlbTlbRules').set_imageUrl('view_detailed.png');

        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemRefresh_TlbPaging_GridRules_Rules').set_enabled(false);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemRefresh_TlbPaging_GridRules_Rules').set_imageUrl('refresh_silver.png');
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemLast_TlbPaging_GridRules_Rules').set_enabled(false);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemLast_TlbPaging_GridRules_Rules').set_imageUrl('last_silver.png');
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemNext_TlbPaging_GridRules_Rules').set_enabled(false);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemNext_TlbPaging_GridRules_Rules').set_imageUrl('Next_silver.png');
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemBefore_TlbPaging_GridRules_Rules').set_enabled(false);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemBefore_TlbPaging_GridRules_Rules').set_imageUrl('Before_silver.png');
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemFirst_TlbPaging_GridRules_Rules').set_enabled(false);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemFirst_TlbPaging_GridRules_Rules').set_imageUrl('first_silver.png');
        if (tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch') != null) {
            tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch').set_enabled(false);
            tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch').set_imageUrl('search_silver.png');
        }
        document.getElementById('txtSerchTerm_Rule').disabled = true;
        document.getElementById('txtRuleName').disabled = false;
        document.getElementById('txtRuleCode').disabled = false;
        document.getElementById('txtRuleDescription').disabled = false;

        if (State == 'Edit')
            NavigateRules_Rules(GridRules_Rules.getSelectedItems()[0]);
        if (State == 'Delete')
            Rules_onSave();
    }

    if (State == 'View') {
        if (TlbRules.get_items().getItemById('tlbItemNew_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemNew_TlbRules').set_enabled(true);
            TlbRules.get_items().getItemById('tlbItemNew_TlbRules').set_imageUrl('add.png');
        }
        if (TlbRules.get_items().getItemById('tlbItemEdit_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemEdit_TlbRules').set_enabled(true);
            TlbRules.get_items().getItemById('tlbItemEdit_TlbRules').set_imageUrl('edit.png');
        }
        if (TlbRules.get_items().getItemById('tlbItemDelete_TlbRules') != null) {
            TlbRules.get_items().getItemById('tlbItemDelete_TlbRules').set_enabled(true);
            TlbRules.get_items().getItemById('tlbItemDelete_TlbRules').set_imageUrl('remove.png');
        }
        TlbRules.get_items().getItemById('tlbItemSave_TlbRules').set_enabled(false);
        TlbRules.get_items().getItemById('tlbItemSave_TlbRules').set_imageUrl('save_silver.png');
        TlbRules.get_items().getItemById('tlbItemCancel_TlbTlbRules').set_enabled(false);
        TlbRules.get_items().getItemById('tlbItemCancel_TlbTlbRules').set_imageUrl('cancel_silver.png');
        TlbRules.get_items().getItemById('tlbItemDefine_TlbTlbRules').set_enabled(false);
        TlbRules.get_items().getItemById('tlbItemDefine_TlbTlbRules').set_imageUrl('view_detailed_silver.png');

        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemRefresh_TlbPaging_GridRules_Rules').set_enabled(true);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemRefresh_TlbPaging_GridRules_Rules').set_imageUrl('refresh.png');
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemLast_TlbPaging_GridRules_Rules').set_enabled(true);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemLast_TlbPaging_GridRules_Rules').set_imageUrl("last.png");
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemNext_TlbPaging_GridRules_Rules').set_enabled(true);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemNext_TlbPaging_GridRules_Rules').set_imageUrl("Next.png");
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemBefore_TlbPaging_GridRules_Rules').set_enabled(true);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemBefore_TlbPaging_GridRules_Rules').set_imageUrl("Before.png");
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemFirst_TlbPaging_GridRules_Rules').set_enabled(true);
        TlbPaging_GridRules_Rules.get_items().getItemById('tlbItemFirst_TlbPaging_GridRules_Rules').set_imageUrl("first.png");
        if (tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch') != null) {
            tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch').set_enabled(true);
            tlbItemQuickSearch.get_items().getItemById('tlbItemSearch_TlbRuleQuickSearch').set_imageUrl('search.png');
        }

        document.getElementById('txtSerchTerm_Rule').disabled = false;
        document.getElementById('txtRuleName').disabled = true;
        document.getElementById('txtRuleCode').disabled = true;
        document.getElementById('txtRuleDescription').disabled = true;

    }

}

/* /UUU  */

/* GridRules Field */
function SetPageIndex_GridRules_Rules(pageIndex) {
    CurrentPageIndex_GridRules_Rules = pageIndex;
    Fill_GridRules_Rules(pageIndex);
}
function Fill_GridRules_Rules(pageIndex) {
    document.getElementById('loadingPanel_GridRules_Rules').innerHTML = document.getElementById('hfloadingPanel_GridRules_Rules').value;
    var pageSize = parseInt(document.getElementById('hfRulesPageSize_Rules').value);
    var searchKey = 'NotSpecified';
    var searchTerm = '';
    if (box_RuleSearch_Rules_IsShown) {
        searchTerm = document.getElementById('txtSerchTerm_Rule').value;
    }
    CallBack_GridRules_Rule.callback(CharToKeyCode_Rules(LoadState_Rules), CharToKeyCode_Rules(pageSize.toString()), CharToKeyCode_Rules(pageIndex.toString()), CharToKeyCode_Rules(searchKey), CharToKeyCode_Rules(searchTerm));
}
function tlbItemSearch_TlbRuleQuickSearch_onClick(sender, e) {
    box_RuleSearch_Rules_IsShown = true;
    LoadState_Rules = 'Search';
    SetPageIndex_GridRules_Rules(0);
}
function GridRules_Rules_onLoad(sender, e) {
    document.getElementById('loadingPanel_GridRules_Rules').innerHTML = '';
}
function GridRules_Rules_onItemSelect(sender, e) {
    if (CurrentPageState_Rules != 'Add')
        NavigateRules_Rules(e.get_item());
}
function CallBack_GridRules_Rule_OnCallbackComplete(sender, e) {
    var test = 'test';
}
function CallBack_GridRules_Rule_onCallbackError(sender, e) {
    var test = 'test';

}
/* /GridRules Field */

/* Grid Toolbar Button Events */
function tlbRuleRefresh_TlbPaging_GridRules_Rules_onClick(sender, e) {
    ChangeLoadState_GridRules_Rules('Normal');
}
function ChangeLoadState_GridRules_Rules(state) {
    LoadState_Rules = state;
    SetPageIndex_GridRules_Rules(0);
}
function tlbRuleFirst_TlbPaging_GridRules_Rules_onClick(sender, e) {
    SetPageIndex_GridRules_Rules(0);
}
function tlbRuleBefore_TlbPaging_GridRules_Rules_onClick(sender, e) {
    if (CurrentPageIndex_GridRules_Rules != 0) {
        CurrentPageIndex_GridRules_Rules = CurrentPageIndex_GridRules_Rules - 1;
        SetPageIndex_GridRules_Rules(CurrentPageIndex_GridRules_Rules);
    }
}
function tlbRuleNext_TlbPaging_GridRules_Rules_onClick(sender, e) {
    if (CurrentPageIndex_GridRules_Rules < parseInt(document.getElementById('hfRulesPageCount_Rules').value) - 1) {
        CurrentPageIndex_GridRules_Rules = CurrentPageIndex_GridRules_Rules + 1;
        SetPageIndex_GridRules_Rules(CurrentPageIndex_GridRules_Rules);
    }
}
function tlbRuleLast_TlbPaging_GridRules_Rules_onClick(sender, e) {
    SetPageIndex_GridRules_Rules(parseInt(document.getElementById('hfRulesPageCount_Rules').value) - 1);
}
/* /Grid Toolbar Button Events */

/* SelectedRules_Rule and it's functions */

function ClearControls_Rules() {
    document.getElementById('txtRuleCode').value = '';
    document.getElementById('txtRuleName').value = '';
    document.getElementById('txtRuleDescription').value = '';

}

function NavigateRules_Rules(selectedRule) {
    if (selectedRule == undefined) return;

    /*
    var typeTitle = selectedRule.getMember('TypeTitle').get_text();
    var periodicTypeTitle = selectedRule.getMember('PeriodicTypeTitle').get_text();
    var calcSituationTypeTitle = selectedRule.getMember('CalcSituationTypeTitle').get_text();
    var persistSituationTypeTitle = selectedRule.getMember('PersistSituationTypeTitle').get_text();
    */
    RefreshRule_Rules();

    SelectedRules_Rule_Fill(
        selectedRule.getMember('ID').get_text(),
        selectedRule.getMember('IdentifierCode').get_text(),
        selectedRule.getMember('Name').get_text(),
        selectedRule.getMember('Description').get_text(),
        selectedRule.getMember('UserDefined').get_text(),
        selectedRule.getMember('Script').get_text(),
        selectedRule.getMember('CSharpCode').get_text(),
        selectedRule.getMember('JsonObject').get_text()
    );

    SelectedRules_Rule_Fill_Fields();
}
function RefreshRule_Rules() {
    SelectedRules_Rule_Fill(0, 0, null, null, null, null,  null, null);
}
function Rules_onSave() {
    if (CurrentPageState_Rules != 'Delete')
        UpdateRule_Rules();
    else
        ShowDialogConfirm('Delete');
}
function Rules_Cancel() {
    ChangePageState_Rules('View');
    ClearControls_Rules();
}


function SelectedRules_Rule_Fill(
    id,
    identifierCode,
    name,
    description,
    userDefined,
    script,
    cSharpCode,
    JsonObject)
{
    
    SelectedRules_Rule = new Object();
    SelectedRules_Rule.ID = id;
    SelectedRules_Rule.IdentifierCode = identifierCode;
    SelectedRules_Rule.Name = name;

    SelectedRules_Rule.Description = description;

    SelectedRules_Rule.UserDefined = userDefined;

    SelectedRules_Rule.Script = script;
    SelectedRules_Rule.CSharpCode = cSharpCode;

    if (JsonObject != undefined && JsonObject != "")
        SelectedRules_Rule.JsonObject = JSON.parse(JsonObject);
    else SelectedRules_Rule.JsonObject = "";

}
function SelectedRules_Rule_Fill_Fields() {

    document.getElementById('txtRuleCode').value = SelectedRules_Rule.IdentifierCode;
    document.getElementById('txtRuleName').value = SelectedRules_Rule.Name;
    document.getElementById('txtRuleDescription').value = SelectedRules_Rule.Description;
}
/* /SelectedRules_Rule and it's functions */

/* Utilities */

function CharToKeyCode_Rules(str) {
    if (str == null) return '';

    str = str.toString();

    var OutStr = '';
    if (str != null && str != undefined) {
        for (var i = 0; i < str.length; i++) {
            var KeyCode = str.charCodeAt(i);
            var CharKeyCode = '//' + KeyCode;
            OutStr += CharKeyCode;
        }
    }
    return OutStr;
}
function ClearList_Rules() {
    if (CurrentPageState_Rules != 'Edit') {
        RefreshRule_Rules();
    }
}
function SetActionMode_Rules(state) {
    document.getElementById('ActionMode_Rules').innerHTML = document.getElementById("hfState" + state + "_Rules").value;
}
function CheckNavigator_onCmbCallBackCompleted() {
    if (navigator.userAgent.indexOf('Safari') != 1 || navigator.userAgent.indexOf('Chrome') != 1)
        return true;
    return false;
}

function CloseDialogRulesManagemen() {
    parent.document.getElementById('DialogRulesManagement_IFrame').src = 'WhitePage.aspx';
    parent.DialogRulesManagement.Close();
}
function ShowDialogConfirm(confirmState) {
    ConfirmState_Rules = confirmState;
    if (CurrentPageState_Rules == 'Delete')
        document.getElementById('lblConfirm').innerHTML = document.getElementById('hfDeleteMessage_Rules').value;
    else
        document.getElementById('lblConfirm').innerHTML = document.getElementById('hfCloseMessage_Rules').value;
    DialogConfirm.Show();
}
/* /Utilities */

/* Error */
function ShowConnectionError_Rules() {
    var error = document.getElementById('hfErrorType_Rules').value;
    var errorBody = document.getElementById('hfConnectionError_Rules').value;
    showDialog(error, errorBody, 'error');
}
/* /Error */

/* Toolbar Item Clicks */
function tlbRuleNew_TlbRules_onClick(sender, e) {
    ClearControls_Rules();
    ChangePageState_Rules('Add');
}
function tlbRuleEdit_TlbRules_onClick(sender, e) {
    ChangePageState_Rules('Edit');
}
function tlbRuleDelete_TlbRules_onClick(sender, e) {
    ChangePageState_Rules('Delete');
}
//function tlbRuleHelp_TlbRules_onClick(sender, e) {

//}
function tlbRuleSave_TlbRules_onClick(sender, e) {
    Rules_onSave();
}
function tlbRuleCancel_TlbTlbRules_onClick(sender, e) {
    Rules_Cancel();
}
function tlbRuleDefine_TlbTlbRules_onClick(sender, e) {

    var RuleJsonObjectEditor = new Object();
    RuleJsonObjectEditor.ID = SelectedRules_Rule.ID;
    RuleJsonObjectEditor.DetailsJsonObject = SelectedRules_Rule.JsonObject;
    RuleJsonObjectEditor.ScriptEn = SelectedRules_Rule.CSharpCode;
    RuleJsonObjectEditor.ScriptFa = SelectedRules_Rule.Script;

    RuleJsonObjectEditor.CallerDialog = "RuleManagement";

    parent.DialogConceptRuleEditor.set_value(RuleJsonObjectEditor);
    parent.DialogConceptRuleEditor.Show();
}
function tlbItemFormReconstruction_TlbRule_onClick(sender, e) {
    CloseDialogRulesManagemen();
    parent.DialogRulesManagement.Show();
}
function tlbRuleExit_TlbRules_onClick(sender, e) {
    ShowDialogConfirm('Exit');
}

function Apply_Object_CSharp_Script_FromRuleRuleEditor(recivedObject) {

    SelectedRules_Rule.Script = recivedObject.ScriptFa;
    SelectedRules_Rule.CSharpCode = recivedObject.ScriptEn;
    SelectedRules_Rule.JsonObject = recivedObject.DetailsJsonObject;
}

/* /Toolbar Item Clicks */

function UpdateRule_Rules() {

    ObjRule_Rules = new Object();

    ObjRule_Rules.ID = 0;
    ObjRule_Rules.IdentifierCode="";
    ObjRule_Rules.Name="";
    ObjRule_Rules.Description="";
    ObjRule_Rules.CustomCategoryCode=null;
    ObjRule_Rules.TypeId = null;
    ObjRule_Rules.UserDefined = true;
    ObjRule_Rules.Script="";
    ObjRule_Rules.CSharpCode="";
    ObjRule_Rules.JsonObject="";

    var SelectedItems_GridRules_Rules = GridRules_Rules.getSelectedItems();
    if (SelectedItems_GridRules_Rules.length > 0)
        ObjRule_Rules.ID = SelectedItems_GridRules_Rules[0].getMember("ID").get_text();
    else ObjRule_Rules.ID = 0;

    if (CurrentPageState_Rules != 'Delete') {

        ObjRule_Rules.IdentifierCode = document.getElementById('txtRuleCode').value;
        ObjRule_Rules.Name = document.getElementById('txtRuleName').value;
        ObjRule_Rules.Description = document.getElementById('txtRuleDescription').value;

        // todo: should be update!    
        ObjRule_Rules.CustomCategoryCode = SelectedRules_Rule.IdentifierCode;
        ObjRule_Rules.TypeId = 565;


        if (SelectedRules_Rule.UserDefined != undefined)
            ObjRule_Rules.UserDefined = SelectedRules_Rule.UserDefined;
        else SelectedRules_Rule.UserDefined = true;

        if (SelectedRules_Rule.Script != undefined)
            ObjRule_Rules.Script = SelectedRules_Rule.Script;
        else ObjRule_Rules.Script = '';

        if (SelectedRules_Rule.CSharpCode != undefined)
            ObjRule_Rules.CSharpCode = SelectedRules_Rule.CSharpCode;
        else ObjRule_Rules.CSharpCode = '';

        ObjRule_Rules.JsonObject = JSON.stringify(SelectedRules_Rule.JsonObject);

    }

    UpdateRule_RulesPage(
        CharToKeyCode_Rules(ObjRule_Rules.ID),
        CharToKeyCode_Rules(ObjRule_Rules.IdentifierCode),
        CharToKeyCode_Rules(ObjRule_Rules.Name),
        //CharToKeyCode_Rules(ObjRule_Rules.Description),
        CharToKeyCode_Rules(ObjRule_Rules.CustomCategoryCode),
        CharToKeyCode_Rules(ObjRule_Rules.TypeId),
        CharToKeyCode_Rules(ObjRule_Rules.UserDefined),
        CharToKeyCode_Rules(ObjRule_Rules.Script),
        CharToKeyCode_Rules(ObjRule_Rules.CSharpCode),
        CharToKeyCode_Rules(ObjRule_Rules.JsonObject),
        CharToKeyCode_Rules(CurrentPageState_Rules)
    );
}
function UpdateRule_RulesPage_onCallBack(Response) {
    //Console.log(JSON.stringify(Response));

    var RetMessage = Response;
    if (RetMessage != null && RetMessage.length > 0) {
        if (Response[1] == "ConnectionError") {
            Response[0] = document.getElementById('hfErrorType_Posts').value;
            Response[1] = document.getElementById('hfConnectionError_Posts').value;
        }
        showDialog(RetMessage[0], Response[1], RetMessage[2]);
        if (RetMessage[2] == 'success') {
            Fill_GridRules_Rules(CurrentPageIndex_GridRules_Rules);
            ClearList_Rules();
            RefreshRule_Rules();
            ClearControls_Rules();
            ChangePageState_Rules('View');
        }
        else {
            if (CurrentPageState_Rules == 'Delete')
                ChangePageState_Rules('View');
        }
    }
}


/* Conform Dialog Exit | Delete functions */
function tlbItemCancel_TlbCancelConfirm_onClick() {
    DialogConfirm.Close();
    ChangePageState_Rules('View');
}
function tlbItemOk_TlbOkConfirm_onClick() {
    switch (ConfirmState_Rules) {
        case 'Delete':
            DialogConfirm.Close();
            UpdateRule_Rules();
            break;
        case 'Exit':
            RefreshRule_Rules();
            parent.DialogRulesManagement.Close();
            break;
        default:
    }
}
/* /Conform Dialog Exit | Delete functions */

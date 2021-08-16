/// <reference path="jquery-1.7.1.js" />
$(document).ready(function () {


    FillASPxGridViewUserManagerStatus(arrayStatus, 'Load');
    LoadControlOverTimeState();
    LoadControlAddWorkState();


});
var ObjCurrentViewStat = 'View';
var arrayStatus = new Array(1, 2, 3, 4, 5, 6);
function GridViewPersonnelSearch_EndCallback() {
    if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
        GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
        var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
        DropDownEditPersonnelSearch.SetText(cellValue);
        var itemBarcode = row.cells[0].innerHTML;
        HiddenFieldBarcode.Set('Barcode', itemBarcode);
        ComboBoxResultSearchUsers.PerformCallback(itemBarcode);
        FillGridViewPostOfPerson(itemBarcode);

    }
    else {
        DropDownEditPersonnelSearch.SetText('هیچ پرسنلی یافت نشد.');
        ComboBoxResultSearchUsers.ClearItems();
        ComboBoxResultSearchUsers.SetText('هیچ پستی یافت نشد');
        ComboBoxResultSearchUsers.PerformCallback('0');
        FillGridViewPostOfPerson('');
    }

}
function GridViewPersonnelSearch_onRowClick() {
    DropDownEditPersonnelSearch.HideDropDown();
}
function GridViewPersonnelSearch_onFocusedRowChanged(s, e) {
    if (s.GetFocusedRowIndex() > -1) {
        var row = s.GetRow(s.GetFocusedRowIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
        DropDownEditPersonnelSearch.SetText(cellValue);
        var itemBarcode = row.cells[0].innerHTML;
        ComboBoxResultSearchUsers.PerformCallback(itemBarcode);
        HiddenFieldBarcode.Set('Barcode', itemBarcode);
        FillGridViewPostOfPerson(itemBarcode);
        ResetControlsForNewSearch();
    }


}
function LoadControlAddWorkState() {

    ASPxSpinAddWorkHour.SetEnabled(ASPxCheckBoxAgreeAddWork.GetChecked());
    ASPxSpinAddWorkMinute.SetEnabled(ASPxCheckBoxAgreeAddWork.GetChecked());


}
function onItemMenuAddPostofPerson(itemClicked) {
    switch (itemClicked.item.name) {
        case 'Save':
            updatePostofPerson();
            break;
        
        default:

    }
}
function CallbackPostOfPersonEndCallback(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            var TypeFarsi = "نتیجه";
            //alert(message);
            var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());
            var itemBarcode = row.cells[0].innerHTML;
            FillGridViewPostOfPerson(itemBarcode);
            
            break;
        case 'Error':
            alert(message);
            var TypeFarsi = "خطا";
            break;
        default:

    }
   
}
function onCallbackPostOfPersonComplete(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            TextBoxPostOfPerson.SetText('');
            var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());
            var itemBarcode = row.cells[0].innerHTML;
            FillGridViewPostOfPerson(itemBarcode);
           // ComboBoxResultSearchUsers.PerformCallback(ComboBoxResultSearchPersonnel.GetSelectedItem().texts[0]);
            //alert(message);

            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
    
}
function FillGridViewPostOfPerson(barcodePersonnel) {

    var callbackParams = '{"LS":"' + ObjCurrentViewStat + '","BarCode":"' + barcodePersonnel + '"}'
    GridViewPostOfPerson.PerformCallback(callbackParams);



}
function onCallbackPostOfPersonUpdateError(e) {

}
function updatePostofPerson() {
    //ShowLoadingImage('newPost');
//    var barcode = HiddenFieldBarcode.Get('Barcode');
    //    var postName = TextBoxPostOfPerson.GetText();
    var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());

    var barcode = row.cells[0].innerHTML;
    var postName = TextBoxPostOfPerson.GetText();
    var obj = '{"Barcode":"' + CharToKeyCode_DefineAdminOperator(barcode) + '","Post":"' + CharToKeyCode_DefineAdminOperator(postName) + '"}';
    CallbackPostOfPerson.PerformCallback(obj);
}
function onItemMenuPostClick(itemClicked) {
    switch (itemClicked.item.name) {
        case 'Save':
            if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0){
                PopupControlPost.Show();
            }
            else {
                alert('لطفا پرسنل مورد نظر را انتخاب نمایید.');
            }
            break;
        default:

    }
}
function onItemMenuViewResultClick(itemClicked) {
    switch (itemClicked.item.name) {
        case 'View':
            onClickbtnViewResultSearchUser();
            break;
        default:

    }
}
function ConfirmDeleteRowGridPost(e) {
    if (e.buttonID == 'DeletePost') {
        if (confirm('آیا این پست را حذف می نمایید؟'))
            CallbackDeleteRowsSelectedGridPost();
    }
}
function CallbackDeleteRowsSelectedGridPost() {
    var indexRowSelected = GridViewPostOfPerson.GetFocusedRowIndex();
    CallbackDeletePostOfPerson.PerformCallback(indexRowSelected);
}
function LoadControlOverTimeState() {

    ASPxSpinOverTimeHour.SetEnabled(ASPxCheckBoxAgreeOverTime.GetChecked());
    ASPxSpinOverTimeMinute.SetEnabled(ASPxCheckBoxAgreeOverTime.GetChecked());

}
function ASPxCheckBoxAgreeAddWorkCheckedChanged() {
    LoadControlAddWorkState();
}
function ASPxCheckBoxAgreeOverTimeCheckedChanged() {
    LoadControlOverTimeState();
}
function onClickAddPishCard() {
    if (lbPishCardPersonnelDeny.GetSelectedItem() != null) {
        CreatePishcardsList('Insert', lbPishCardPersonnelDeny.GetSelectedItem().value);
        lbPishCardPersonnelAllow.InsertItem(lbPishCardPersonnelAllow.GetItemCount(), lbPishCardPersonnelDeny.GetSelectedItem().text, lbPishCardPersonnelDeny.GetSelectedItem().value);
        lbPishCardPersonnelDeny.RemoveItem(lbPishCardPersonnelDeny.GetSelectedIndex());


    }
}
function onClickRemovePishCard() {
    if (lbPishCardPersonnelAllow.GetSelectedItem() != null) {
        CreatePishcardsList('Remove', lbPishCardPersonnelAllow.GetSelectedItem().value);
        lbPishCardPersonnelDeny.InsertItem(lbPishCardPersonnelDeny.GetItemCount(), lbPishCardPersonnelAllow.GetSelectedItem().text, lbPishCardPersonnelAllow.GetSelectedItem().value);
        lbPishCardPersonnelAllow.RemoveItem(lbPishCardPersonnelAllow.GetSelectedIndex());


    }
}
function onClickAddAllPishCard() {
    var selectedId = ComboBoxResultSearchUsers.GetSelectedItem().value;
    lbPishCardPersonnelDeny.ClearItems();
    FilllbPishCardPersonnelAllow('All', selectedId);
}
function onClickRemoveAllPishCard() {
    var selectedId = ComboBoxResultSearchUsers.GetSelectedItem().value;
    lbPishCardPersonnelAllow.ClearItems();
    HiddenFieldAllowedPishcards.Set("PishCardList", '@');
    FilllbPishCardPersonnelDeny('All', selectedId);
}

function FilllbPishCardPersonnelDeny(state, selectedwebPassID) {
    var Params = '{"LS":"' + state + '","WebPassID":"' + selectedwebPassID + '"}';
    CallbackPanelDeniedPishcards.PerformCallback(Params);
}
function FilllbPishCardPersonnelAllow(state, selectedwebPassID) {
    var Params = '{"LS":"' + state + '","WebPassID":"' + selectedwebPassID + '"}';
    CallbackPanelAllowPishcards.PerformCallback(Params);
}


function CreatePishcardsList(state, pishcardID) {
    var StrPishcardsList = HiddenFieldAllowedPishcards.Get("PishCardList");
    var splitter = '@';
    switch (state) {
        case 'Insert':
            if (StrPishcardsList.indexOf(splitter + pishcardID + splitter) < 0)
                StrPishcardsList = StrPishcardsList + pishcardID + splitter;
            break;
        case 'Remove':
            if (StrPishcardsList.indexOf(splitter + pishcardID + splitter) >= 0)
                StrPishcardsList = StrPishcardsList.replace(splitter + pishcardID + splitter, splitter);
            break;
    }
    HiddenFieldAllowedPishcards.Set("PishCardList", StrPishcardsList);
}


function ComboBoxResultSearchUsersEndCallback() {
    HideLoadingImage();
    if (ComboBoxResultSearchUsers.GetItemCount() > 0) {
        ComboBoxResultSearchUsers.SetSelectedItem(0);

    }
    else {
        ComboBoxResultSearchUsers.SetText('هیچ پستی یافت نشد');
    }
}
function PopupControlPost_CloseButton() {
    var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());
    var itemBarcode = row.cells[0].innerHTML;
    ComboBoxResultSearchUsers.PerformCallback(itemBarcode);
}

function ComboBoxResultSearchUsersSelectedIndexChanged() {
    ResetControlsForNewSearch();
}
function onClickbtnSearchPersonnel() {
    ShowLoadingImage('tableSearch');
    ResetControlsForNewSearch();
    GridViewPersonnelSearch.PerformCallback(CharToKeyCode_DefineAdminOperator(document.getElementById('txtSearchPersonnel').value));
}
function CharToKeyCode_DefineAdminOperator(str) {
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




function onClickbtnViewResultSearchUser() {
    if (ComboBoxResultSearchUsers.GetSelectedItem() != null) {
        ResetControlsForNewSearch();
        var selectedId = ComboBoxResultSearchUsers.GetSelectedItem().value;
        FilllbPishCardPersonnelDeny('Load', selectedId);
        FilllbPishCardPersonnelAllow('Load', selectedId);
        FillOverTimeUserAccess(selectedId);
        FillStatusUserAccess(selectedId);
        ObjCurrentViewStat = 'Edit';

    }
    else {
        alert('هیچ کاربری انتخاب نشده است');
    }
}
function FillStatusUserAccess(selectedWebPassId) {
    ASPxCallbackPanelUserStatus.PerformCallback(selectedWebPassId);
    var i = TreeViewStatusUser;

}
function ASPxCallbackPanelGridViewUserManagerStatusEndCallback() {
    var i = ASPxGridViewUserManagerStatus.GetSelectedFieldValues('Barcode', test)
}
function test(values) {
    var i = values;
}
function FillOverTimeUserAccess(selectedWebPassId) {
    ASPxCallbackPanelOverTime.PerformCallback(selectedWebPassId);

}
function ASPxCallbackPanelOverTimeEmdCallback() {
    //    if (ASPxComboBoxTopMan.GetItemCount() > 0) {
    //        ASPxComboBoxTopMan.SetSelectedItem(ASPxComboBoxTopMan.GetItem(0));
    //        ASPxComboBoxTopMan.SetSelectedIndex(0);
    //    }
    LoadControlOverTimeState();
    LoadControlAddWorkState();

}

function ComboBoxStatusUseronSelectedIndexChanged() {
    var valueSelectedItem = ComboBoxStatusUser.GetSelectedItem().value;
    if (valueSelectedItem == 0) {
        ComboBoxSubStatusUser.SetEnabled(true);
    }
    else {
        ComboBoxSubStatusUser.SetEnabled(false);
    }
}


function onFocusRowASPxGridViewUserManagerStatus() {
    if (ASPxGridViewUserManagerStatus.GetFocusedRowIndex() > -1) {
        var selectedBarcode = ASPxGridViewUserManagerStatus.GetRow(ASPxGridViewUserManagerStatus.GetFocusedRowIndex()).cells[0].innerHTML;
        document.getElementById('txtSearchPersonnel').value = selectedBarcode;
        ResetControlsForNewSearch();
        onClickbtnSearchPersonnel();

    }
}
function ResetControlsForNewSearch() {
    TreeViewStatusUser.SetSelectedNode(null);
    lbPishCardPersonnelDeny.ClearItems();
    lbPishCardPersonnelAllow.ClearItems();
    ASPxCheckBoxAgreeAddWork.SetChecked(false);
    ASPxCheckBoxAgreeOverTime.SetChecked(false);
    // ASPxComboBoxTopMan.ClearItems();
    ASPxSpinAddWorkHour.SetNumber(0);
    ASPxSpinAddWorkMinute.SetNumber(0);
    ASPxSpinOverTimeHour.SetNumber(0);
    ASPxSpinOverTimeMinute.SetNumber(0);
    ASPxCheckBoxisAcceptOwner.SetChecked(false);
    LoadControlOverTimeState();
    LoadControlAddWorkState();
    ObjCurrentViewStat = 'View'
}
function onItemMenuClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'Save':
            if (ObjCurrentViewStat == 'Edit')
                UpdateDefineAdminOperator();
            else
                alert('لطفا یک پست را انتخاب نمایید و روی گزینه نمایش کلیک نمایید');
            break;
        case 'Help_DefineAdminOperator':
            parent.LoadHelpPage('DefineAdminOperator');
            
            break;
        default:

    }

}
function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 50 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}
function UpdateDefineAdminOperator() {
    ShowLoadingImage('divHeaderMenu');
    var mode = ObjCurrentViewStat;
    var webPassID = ComboBoxResultSearchUsers.GetSelectedItem().value;
    if (TreeViewStatusUser.GetSelectedNode() != null)
        var userStatus = TreeViewStatusUser.GetSelectedNode().name;
    else
        var userStatus = '0';
    var acceptOwner = ASPxCheckBoxisAcceptOwner.GetChecked();
    var finalManager = ASPxCheckBoxisFinalManager.GetChecked();
    var agreeAddWork = ASPxCheckBoxAgreeAddWork.GetChecked();
    var agreeOverTime = ASPxCheckBoxAgreeOverTime.GetChecked();
    //    if (ASPxComboBoxTopMan.GetSelectedItem() != null)
    //        var topManWebPassID = ASPxComboBoxTopMan.GetSelectedItem().value;
    //    else
    var topManWebPassID = '0';
    var addWorkHour = ASPxSpinAddWorkHour.GetNumber();
    var addWorkMinute = ASPxSpinAddWorkMinute.GetNumber();
    var overTimeHour = ASPxSpinOverTimeHour.GetNumber();
    var overTimeMinute = ASPxSpinOverTimeMinute.GetNumber();
    var pishCardList = HiddenFieldAllowedPishcards.Get("PishCardList")
    var obj = '{"WebPassID":"' + webPassID + '","UserStatus":"' + userStatus + '", "AcceptOwner":"' + acceptOwner + '", "FinalManager":"' + finalManager + '", "AgreeAddWork":"' + agreeAddWork + '", "AgreeOverTime":"' + agreeOverTime + '", "TopManWebPassID":"' + topManWebPassID + '", "AddWorkHour":"' + addWorkHour + '", "AddWorkMinute":"' + addWorkMinute + '", "OverTimeHour":"' + overTimeHour + '", "OverTimeMinute":"' + overTimeMinute + '", "PishCardList":"' + pishCardList + '", "Mode":"' + mode + '"}';
    CallbackDefineAdminOperatorUpdate.PerformCallback(obj);
}


function onClickViewButtonFilterGrid() {
    arrayStatus = new Array();
    var indexArray = 0;
    for (var i = 0; i < 8; i++) {
        if (TreeViewFilterGrid.GetNodeByName(i).GetChecked() == true) {
            arrayStatus[indexArray] = TreeViewFilterGrid.GetNodeByName(i).name;
            indexArray++;
        }
    }

    FillASPxGridViewUserManagerStatus(arrayStatus, 'Filter');
    ClientPopupControl.Hide();
}
function onClickTreeViewStatusUser(nodeClicked) {

    if (nodeClicked.node.name == 'modir') {
        if (nodeClicked.node.GetExpanded() == true) {
            nodeClicked.node.SetExpanded(false);
        }
        else {
            nodeClicked.node.SetExpanded(true);
        }
        TreeViewStatusUser.SetSelectedNode(null);
    }
}
function FillASPxGridViewUserManagerStatus(arrayStatus, state) {

    var status = arrayStatus.toString();
   // if (status != '') {
        var state = state;
        var obj = '{"State":"' + state + '","Status":"' + status + '"}';
        ASPxGridViewUserManagerStatus.PerformCallback(obj);
  //  }
//    else {
//        alert('گزینه ای در فیلتر نمایش انتخاب نشده است.');
//    }
}
function ConfirmDeleteRowGrid(e) {
    if (e.buttonID == 'Delete') {
        // ShowQuestionBox('آیا مجوز های این کاربر را حذف می نمایید؟');
        if (confirm('آیا مجوز های این کاربر را حذف می نمایید؟')) {
            ObjCurrentViewStat = 'Delete';
            CallbackDeleteRowsSelectedGrid();
        }
        else {
            ObjCurrentViewStat = 'View';
        }
    }

}
function CallbackDeleteRowsSelectedGrid() {
    var indexRowSelected = ASPxGridViewUserManagerStatus.GetFocusedRowIndex();
    ASPxCallbackDeleteRowsSelectedGrid.PerformCallback(indexRowSelected);
}
function CallbackDeleteRowsSelectedGridComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            //alert(message);
            var TypeFarsi = "نتیجه";
            ObjCurrentViewStat = 'View';
            UpadateGridViewAfterDeleteing();
            var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());
            var itemBarcode = row.cells[0].innerHTML;
            ComboBoxResultSearchUsers.PerformCallback(itemBarcode);
            ResetControlsForNewSearch();

            break;
        case 'Error':
            alert(message);
            var TypeFarsi = "خطا";

            break;
        default:

    }
    
}
function UpadateGridViewAfterDeleteing() {

    ASPxGridViewUserManagerStatus.GetRow(ASPxGridViewUserManagerStatus.GetFocusedRowIndex()).cells[4].innerText = '';
    ASPxGridViewUserManagerStatus.GetRow(ASPxGridViewUserManagerStatus.GetFocusedRowIndex()).cells[5].innerText = '';
    //onClickViewButtonFilterGrid();
    FillASPxGridViewUserManagerStatus(arrayStatus, 'Filter');

}
function txtSearchEnterKeyPressDoingSearch(e) {
    if (e.keyCode == 13) {
        onClickbtnSearchPersonnel();
        return false;
    }
}

function CallbackDefineAdminOperatorUpdateComplete(e) {
    HideLoadingImage();
    CallbackDefineAdminOperatorUpdate_onAfterCallBackComplete(e.result);
}

function CallbackDefineAdminOperatorUpdate_onAfterCallBackComplete(RetMessage) {
    var RetMessage = eval('(' + RetMessage + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':

           
            FillASPxGridViewUserManagerStatus(arrayStatus, 'Filter');

            break;
        case 'Error':
            

            break;
        default:
    }
    alert(message);
}


function CallbackDefineAdminOperator_onCallbackError(e) {
    e.handled = true;
    HideLoadingImage();
    alert(e.message);
}


function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_DefineManagerPersonnel':
            parent.LoadHelpPage('DefineManagerPersonnel');
    
            break;
        default:

    }
}

function divContentTreeViewParts_onScroll() {
    document.getElementById('hfScrollPosition').value = $("#divContentTreeViewParts").scrollTop();
}
function TreeViewParts_onClick() {
    $("#divContentTreeViewParts").scrollTop(document.getElementById('hfScrollPosition').value);
}
function TreeViewParts_onExpandedChanged() {
    $("#divContentTreeViewParts").scrollTop(document.getElementById('hfScrollPosition').value);
}
function GridViewPersonnelSearch_EndCallback() {
    if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
        GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
        var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
        DropDownEditPersonnelSearch.SetText(cellValue);
        var itemBarcode = row.cells[0].innerHTML;
        ComboBoxResultSearchUsers.PerformCallback(itemBarcode);
        
    }
    else {
        DropDownEditPersonnelSearch.SetText('هیچ پرسنلی یافت نشد.');
        ComboBoxResultSearchUsers.ClearItems();
        ComboBoxResultSearchUsers.SetText('هیچ پستی یافت نشد');
        ComboBoxResultSearchUsers.PerformCallback("0");
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
    }


}
function txtSearchEnterKeyPressDoingSearch(e) {
    if (e.keyCode == 13) {
        onClickbtnSearchPersonnel();
        return false;
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
function onClickbtnSearchPersonnel() {
    ShowLoadingImage('tableSearch');
    GridViewPersonnelSearch.PerformCallback(CharToKeyCode_DefineManagerPersonnel(document.getElementById('txtSearchPersonnel').value));
    
}
function ComboBoxResultSearchUsersEndCallback() {
    HideLoadingImage();
    if (ComboBoxResultSearchUsers.GetItemCount() > 0) {
        ComboBoxResultSearchUsers.SetSelectedItem(0);
        
    }
    else {
        ComboBoxResultSearchUsers.SetText('هیچ پستی یافت نشد');

    }
    FillGridViewEditWebPassPerson('newLoad');
}
function ComboBoxResultSearchUsersSelectedIndexChanged() {
    FillGridViewEditWebPassPerson('newLoad');
}

function CharToKeyCode_DefineManagerPersonnel(str) {
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
        FillTreeViewParts();

    }
    else {
        alert( 'هیچ کاربری انتخاب نشده است');
    }
}
function FillTreeViewParts() {
    CallbackPanelTreeViewParts.PerformCallback();
}
function TreeViewParts_nodeClick(nodeClicked) {

    CallbackPanelTreeViewParts.PerformCallback(nodeClicked.node.name);
}

function onFocusRowGridViewPersonnels() {

}
function onClickRowGridViewPersonnels() {
}

function onItemMenuGridPartClick(itemSelected) {

    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'add':

            UpdateWebpassPerson('Part');
            break;
       
        default:
 }
}
function onItemMenuGridPersonnelClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'add':

            UpdateWebpassPerson('Person');
            break;
        
        default:
    }
}
function UpdateWebpassPerson(typeItemSelected) {
    ShowLoadingImage('tdbtnAddParts');
    if (ComboBoxResultSearchUsers.GetSelectedItem() != null) {
        var webPassID = ComboBoxResultSearchUsers.GetSelectedItem().value;
    }
    else {
        var webPassID = 0;
    }
    if (typeItemSelected == 'Part') {
        var person = false;
        var part = true;

        if (TreeViewParts.GetSelectedNode() != null) {
            var barcode = TreeViewParts.GetSelectedNode().name;
        }
        else {
            var barcode = 0;
        }
    }
    else if (typeItemSelected == 'Person') {

        var person = true;
        var part = false;
        if (GridViewPersonnels.GetFocusedRowIndex() > -1) {
            var barcode = GridViewPersonnels.GetRow(GridViewPersonnels.GetFocusedRowIndex()).cells[0].innerHTML;
        }
        else {
            var barcode = 0;
        }
    }
var obj = '{"WebPassID":"' + webPassID + '","Person":"' + person + '", "Part":"' + part + '", "Barcode":"' + barcode + '"}';
    CallbackUpdateWebpassPerson.PerformCallback(obj);
}
function CallbackUpdateWebpassPersonEndCallback(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':

            var TypeFarsi = "نتیجه";
            FillGridViewEditWebPassPerson('newLoad');
            //alert(message);
            break;
        case 'Error':
            alert(message);
            var TypeFarsi = "خطا";
            
            break;
        default:

    }
  
}



function FillGridViewEditWebPassPerson(state) {
    if (ComboBoxResultSearchUsers.GetSelectedItem() != null) {
        var webPassID = ComboBoxResultSearchUsers.GetSelectedItem().value;
    }
    else {
        var webPassID = 0;
    }
    var state = state;
    var obj = '{"State":"' + state + '","WebPassID":"' + webPassID + '"}';
    GridViewEditWebPassPerson.PerformCallback(obj);
}
function onFocusRowGridViewEditWebPassPerson() {
}
function ConfirmDeleteRowGrid(e) {
    if (e.buttonID == 'Delete') {
        if (confirm('آیا دسترسی های این کاربر را حذف می نمایید؟'))
            CallbackDeleteRowsSelectedGrid();
    }
}

function CallbackDeleteRowsSelectedGrid() {
    var indexRowSelected = GridViewEditWebPassPerson.GetFocusedRowIndex();
    CallbackDeleteWebpassPerson.PerformCallback(indexRowSelected);
}
function CallbackDeleteWebpassPersonEndCallback(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            var TypeFarsi = "نتیجه";
            UpadateGridViewAfterDeleteing();
            //alert(message);
            break;
        case 'Error':
            alert(message);
            var TypeFarsi = "خطا";
            break;
        default:

    }
   
}
function UpadateGridViewAfterDeleteing() {
  FillGridViewEditWebPassPerson('newLoad');
}

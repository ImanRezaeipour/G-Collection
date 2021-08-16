function onItemMenuClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'SaveMenuHeader_DefineInsteadMan':
            UpdateInsteadMan();
            break;
        case 'Help_InsteadMan':
            parent.LoadHelpPage('InsteadMan');
            break;
           
     
        default:

    }

}
function ConfirmDeleteRowGrid(e) {
    if (e.buttonID == 'Delete') {
        if (confirm('آیا این جانشین را حذف می نمایید؟'))
            CallbackDeleteRowsSelectedGrid();
    }
}
function CallbackDeleteRowsSelectedGrid() {
    var indexRowSelected = GridViewInsteadMan.GetFocusedRowIndex();
    CallbackDeleteInsteadMan.PerformCallback(indexRowSelected);
}
function CallbackDeleteInsteadMan_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            var TypeFarsi = "نتیجه";
            FillGridViewInsteadMan();

            break;
        case 'Error':
            alert(message);
            var TypeFarsi = "خطا";
            break;
        default:

    }

}
function FillGridViewInsteadMan() {
    GridViewInsteadMan.PerformCallback();
}
function DeleteInsteadMan() { 

}
function UpdateInsteadMan() {
    
    if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
        var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetFocusedRowIndex());
        var selectedBarcode = row.cells[0].innerHTML;
    }
    else {
        alert('هیچ پرسنلی انتخاب نشده است.');
        return;
    }
    var selectedPost = ComboBoxPostOfPerson.GetSelectedItem().value;
    var obj = '{"Barcode":"' + selectedBarcode + '","Post":"' + selectedPost + '"}';
    CallbackUpdateInsteadMan.PerformCallback(obj);
}
function CallbackUpdateInsteadMan_onCallbackComplete(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            FillGridViewInsteadMan();

            break;
        case 'Error':
            
            break;
        default:

    }
}
function GridViewDefaultUser_EndCallback(e)
{ }
function GridViewPersonnelSearch_EndCallback() {
    HideLoadingImage();
    if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
        GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
        var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
        DropDownEditPersonnelSearch.SetText(cellValue);
        var itemBarcode = row.cells[0].innerHTML;
        
    }
    else {
        DropDownEditPersonnelSearch.SetText('هیچ پرسنلی یافت نشد.');
        
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
        
        
    }


}
function onClickSearchPersonnel() {
    ShowLoadingImage('tableSearch');

    GridViewPersonnelSearch.PerformCallback(CharToKeyCode_DefinePersonnel(document.getElementById('txtSearch').value));
}
function txtSearchEnterKeyPressDoingSearch(e) {
    if (e.keyCode == 13) {
        onClickSearchPersonnel();
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
function CharToKeyCode_DefinePersonnel(str) {
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
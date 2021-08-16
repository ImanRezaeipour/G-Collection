var ObjCurrentViewStat = 'View';


$(document).ready(function () {
    setMenuPageStatus();
    txtUserName.SetEnabled(false);
    txtPassword.SetEnabled(false);
    txtConfirmPassword.SetEnabled(false);
});

function onClickSearchPersonnel() {
    ShowLoadingImage('tableSearch');
    
    GridViewPersonnelSearch.PerformCallback(CharToKeyCode_DefinePersonnel(document.getElementById('txtSearch').value));
}

function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 50 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}

function GridViewPersonnelSearch_EndCallback() {
    HideLoadingImage();
    if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
        GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
        var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
        DropDownEditPersonnelSearch.SetText(cellValue);
        var itemBarcode = row.cells[0].innerHTML;
        FillPanelUserInfo(itemBarcode);
    }
    else {
        DropDownEditPersonnelSearch.SetText('هیچ پرسنلی یافت نشد.');
        FillPanelUserInfo('');
    }
    ResetUserInfoConntrols();
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
        FillPanelUserInfo(itemBarcode);
        ResetUserInfoConntrols();
    }
   

}
function FillPanelUserInfo(barcode) {
    //document.getElementById('HiddenBarcode').value = barcode;
    HiddenFieldBarcode.Set('Barcode', barcode);
    CallbackPanelUserofPersonnel.PerformCallback(barcode);
}


function setMenuPageStatus() {
    switch (ObjCurrentViewStat) {
        case 'View':

            MenuHeader.GetItem(0).SetEnabled(true);
            MenuHeader.GetItem(1).SetEnabled(true);
            MenuHeader.GetItem(2).SetEnabled(false);
            MenuHeader.GetItem(3).SetEnabled(false);
            MenuHeader.GetItem(4).SetEnabled(true);
            //*****************
            txtUserName.SetEnabled(false);
            txtPassword.SetEnabled(false);
            txtConfirmPassword.SetEnabled(false);

            break;
        case 'Add':
            MenuHeader.GetItem(0).SetEnabled(false);
            MenuHeader.GetItem(1).SetEnabled(false);
            MenuHeader.GetItem(2).SetEnabled(true);
            MenuHeader.GetItem(3).SetEnabled(true);
            MenuHeader.GetItem(4).SetEnabled(false);
            //*****************
            txtUserName.SetEnabled(true);
            txtPassword.SetEnabled(true);
            txtConfirmPassword.SetEnabled(true);
            //txtUserName.SetFocus = true;
            break;
        case 'Edit':
            MenuHeader.GetItem(0).SetEnabled(false);
            MenuHeader.GetItem(1).SetEnabled(false);
            MenuHeader.GetItem(2).SetEnabled(true);
            MenuHeader.GetItem(3).SetEnabled(true);
            MenuHeader.GetItem(4).SetEnabled(false);
            //*****************
            txtUserName.SetEnabled(true);
            txtPassword.SetEnabled(true);
            txtConfirmPassword.SetEnabled(true);
           // txtUserName.GetFocus();
            break;
        case 'Delete':
            MenuHeader.GetItem(0).SetEnabled(false);
            MenuHeader.GetItem(1).SetEnabled(false);
            MenuHeader.GetItem(2).SetEnabled(false);
            MenuHeader.GetItem(3).SetEnabled(false);
            MenuHeader.GetItem(4).SetEnabled(false);
            //*****************
            txtUserName.SetEnabled(false);
            txtPassword.SetEnabled(false);
            txtConfirmPassword.SetEnabled(false);
            break;
        default:

    }


}
function onItemMenuClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'Add':
            ObjCurrentViewStat = 'Add';
            ResetUserInfoConntrols();
            break;
        case 'Edit':
            ObjCurrentViewStat = 'Edit';
            break;
        case 'Save':
            UpdateDefinePersonnel(ObjCurrentViewStat);
            break;
        case 'Cancel':
            ObjCurrentViewStat = 'View';
            ResetUserInfoConntrols();
            if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
                GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
                var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
                var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
                DropDownEditPersonnelSearch.SetText(cellValue);
                var itemBarcode = row.cells[0].innerHTML;
                FillPanelUserInfo(itemBarcode);
            }

            break;
        case 'Delete':
            ObjCurrentViewStat = 'Delete';
            if (confirm('آیا این کاربر را حذف می نمایید؟'))
                UpdateDefinePersonnel('Delete');
            else
                ObjCurrentViewStat = 'View';

            break;
        case 'Help_DefinePersonnel':
            parent.LoadHelpPage('DefinePersonnel');

            break;
        default:

    }
    setMenuPageStatus();
}

function UpdateDefinePersonnel(mode) {
    ShowLoadingImage('divMenuHeader');
    switch (mode) {
        case 'Add':
            var ID = 0;
            break;
        case 'Edit':
            var ID = HiddenFieldID.Get('ID');
            break;
        case 'Delete':
            var ID = HiddenFieldID.Get('ID');
            break;
        default:
    }

    var barcode = CharToKeyCode_DefinePersonnel(HiddenFieldBarcode.Get('Barcode'));
    var UserName = CharToKeyCode_DefinePersonnel(txtUserName.GetText());
    var Password = CharToKeyCode_DefinePersonnel(txtPassword.GetText());
    var PasswordRepeat = CharToKeyCode_DefinePersonnel(txtConfirmPassword.GetText());

    var obj = '{"UserName":"' + UserName + '","Password":"' + Password + '", "PasswordRepeat":"' + PasswordRepeat + '", "ID":"' + ID + '", "Barcode":"' + barcode + '", "Mode":"' + mode + '"}';
    CallBackDefinePersonnelUpdate.PerformCallback(obj);
}
function ResetUserInfoConntrols() {
    document.getElementById('HiddenID').value = '';
    
    txtUserName.SetText('');
    txtPassword.SetText('');
    txtConfirmPassword.SetText('');
    
}
function onCallbackDefinePersonnelUpdateComplete(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            ResetUserInfoConntrols();
            //FillPanelUserInfo(ComboBoxResultSearchPersonnel.GetSelectedItem().texts[0]);
            if (GridViewPersonnelSearch.GetVisibleRowsOnPage() > 0) {
                GridViewPersonnelSearch.SetFocusedRowIndex(GridViewPersonnelSearch.GetTopVisibleIndex());
                var row = GridViewPersonnelSearch.GetRow(GridViewPersonnelSearch.GetTopVisibleIndex());
                var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;
                DropDownEditPersonnelSearch.SetText(cellValue);
                var itemBarcode = row.cells[0].innerHTML;
                FillPanelUserInfo(itemBarcode);
            }
            ObjCurrentViewStat = 'View';
            
            break;
        case 'Error':
            if (ObjCurrentViewStat == 'Delete') {
                ObjCurrentViewStat = 'View';
            }
            break;
        default:

    }
    setMenuPageStatus();
    
    alert(message);


}
function onCallbackDefinePersonnelUpdateError(e) {
    alert(e.result);
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
function txtSearchEnterKeyPressDoingSearch(e) {
    if (e.keyCode == 13) {
        onClickSearchPersonnel();
        return false;
    }
}






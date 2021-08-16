/// <reference path="jquery-1.7.1.js" />


$(document).ready(function () {
    ButtonShowReportMonthly_onclick();
});
function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 50 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}

function ButtonShowReportMonthly_onclick() {
    if (GridViewUnderManegment.GetFocusedRowIndex() > -1) {
        ShowLoadingImage('tblHeaderBar');
        var row = GridViewUnderManegment.GetRow(GridViewUnderManegment.GetFocusedRowIndex());
        CallbackPanelGridReportMonthly.PerformCallback(row.cells[0].innerHTML);
    }
    else
        alert('لطفا یک پرسنل را جهت نمایش گزارش کارکرد انتخاب نمایید');
}
function error(e) {
    var i = e;
}
function comp(e) {
    var i = e;
}
function www(s, e) {
    if (s.GetFocusedRowIndex() > 0) {
        var row = s.GetRow(s.GetFocusedRowIndex());
        var cellValue = row.cells[0].innerHTML + row.cells[1].innerHTML + row.cells[2].innerHTML;

        lbl3.SetText(row.cells[1].innerHTML);
        lbl4.SetText(row.cells[2].innerHTML);
        LabelBarcode.SetText(row.cells[0].innerHTML);
        s.GetFocusedRowIndex()
        DropDownEditUnderManagment.HideDropDown();
    }

}
function button7_onClick() {
    if (cb1.GetValue() == '') {
        alert('لطفا پیش کارت مورد نظر را انتخاب نمایید.');
        return;
    }
    if (RadioButtonList1.GetSelectedItem().value == '1') {
        if (TM2.GetText() < TM1.GetText()) {
            if (cb1.GetValue() == '0') {
                if (TM2.GetText() != '00:00') {
                    alert('مقادیر ورودی ساعت را اصلاح کنید');
                    return;
                }
                
            }
            else {
                alert('مقادیر ورودی ساعت را اصلاح کنید');
                return;
            }
        }
        else {
            if (TM1.GetText() == '00:00' && cb1.GetValue() != '0') {
                alert('مقادیر ورودی ساعت را اصلاح کنید');
                return;
            }
        }
        if (TM2.GetText() == TM1.GetText()) {
            alert('مقادیر ورودی ساعت را اصلاح کنید');
            return;
        }
    }

    grid.UpdateEdit();
}
function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_ReportMonthly':
            parent.LoadHelpPage('ReportMonthly');

            break;
        default:

    }
}
function GridView2_EndCallback(s, e) {
    if (s.showingError != null) {
        alert(s.showingError);
    }
   
   
  

}
function GridView2_RowClick(s, e) {
}



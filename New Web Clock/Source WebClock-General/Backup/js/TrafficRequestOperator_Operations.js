/// <reference path="jquery-1.7.1.js" />

$(document).ready(function () {
    setEnabledRegistControlsHourlyPermit(false);
    setEnabledRegistControlsDaily(false);
    setMenuPageStatusDaily();
    setMenuPageStatusHourlyPermit();
    setMenuPageStatusHourlyTraffic();
    setEnabledRegistControlsHourlyTraffic(false);

});




var ObjCurrentViewStatDaily = 'View';
var ObjCurrentViewStatHourlyPermit = 'View';
var ObjCurrentViewStatHourlyTraffic = 'View';
function onItemMenuHeaderHourlyPermitClick(itemSelected)
{
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'AddMenuHeaderHourlyPermit_TrafficRequestOperator':
            ObjCurrentViewStatHourlyPermit = 'Add';

            setEnabledRegistControlsHourlyPermit(true);
            break;
        case 'EditMenuHeaderHourlyPermit_TrafficRequestOperator':
            ObjCurrentViewStatHourlyPermit = 'Edit';
            ShowEditedHourlyPermit();
            break;
        case 'SaveMenuHeaderHourlyPermit_TrafficRequestOperator':
            UpdateTrafficHourlyPermit();
            break;
        case 'CancelMenuHeaderHourlyPermit_TrafficRequestOperator':
            ObjCurrentViewStatHourlyPermit = 'View';
            setEnabledRegistControlsHourlyPermit(false);

            break;
        case 'DeleteMenuHeaderHourlyPermit_TrafficRequestOperator':
            ObjCurrentViewStatHourlyPermit = 'Delete';
            ShowQuestionBox('Delete','HourlyPermit');
            break;
        
        default:

    }
    setMenuPageStatusHourlyPermit();
}
function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_TrafficRequestOperator':
            parent.LoadHelpPage('TrafficRequestOperator');

            break;
        default:

    }
}
function onItemMenuHeaderHourlyTrafficClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'AddMenuHeaderHourlyTraffic_TrafficRequestOperator':
            ObjCurrentViewStatHourlyTraffic = 'Add';

            setEnabledRegistControlsHourlyTraffic(true);
            break;
        case 'EditMenuHeaderHourlyTraffic_TrafficRequestOperator':
            ObjCurrentViewStatHourlyTraffic = 'Edit';
            ShowEditedHourlyTraffic();
            
            break;
        case 'SaveMenuHeaderHourlyTraffic_TrafficRequestOperator':
            UpdateTrafficHourlyTraffic();
            break;
        case 'CancelMenuHeaderHourlyTraffic_TrafficRequestOperator':
            ObjCurrentViewStatHourlyTraffic = 'View';
            setEnabledRegistControlsHourlyTraffic(false);

            break;
        case 'DeleteMenuHeaderHourlyTraffic_TrafficRequestOperator':
            ObjCurrentViewStatHourlyTraffic = 'Delete';
            ShowQuestionBox('Delete', 'HourlyTraffic');
            break;
       

        default:


    }
    setMenuPageStatusHourlyTraffic();
}
function onItemMenuHeaderDailyClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'AddMenuHeaderDaily_TrafficRequestOperator':
            ObjCurrentViewStatDaily = 'Add';
            
            setEnabledRegistControlsDaily(true);
            break;
        case 'EditMenuHeaderDaily_TrafficRequestOperator':
            ObjCurrentViewStatDaily = 'Edit';
            ShowEditedDaily();
            break;
        case 'SaveMenuHeaderDaily_TrafficRequestOperator':
            UpdateRequestDaily();
            break;
        case 'CancelMenuHeaderDaily_TrafficRequestOperator':
            ObjCurrentViewStatDaily = 'View';
            setEnabledRegistControlsDaily(false);

            break;
        case 'DeleteMenuHeaderDaily_TrafficRequestOperator':
            ObjCurrentViewStatDaily = 'Delete';
            ShowQuestionBox('Delete','Daily');
            break;
        
        default:

    }
    setMenuPageStatusDaily();
}
function ShowQuestionBox(value, mode) {
    switch (mode) {
        case 'Daily':
           switch (value) {
                case 'Delete':
                    if (confirm('آیا از حذف این تردد اطمینان دارید؟')) {
                        GridViewRequestDaily.GetRowValues(GridViewRequestDaily.GetFocusedRowIndex(), 'Dates;Times;Reader;PishID;Barcode', RequestDelectedDaily)
                    }
                    break;
                default:

            }
            break;
        case 'HourlyPermit':
            switch (value) {
                case 'Delete':
                    if (confirm('آیا از حذف این تردد اطمینان دارید؟')) {
                        GridViewRequestHourlyPermit.GetRowValues(GridViewRequestHourlyPermit.GetFocusedRowIndex(), 'Dates;FromTime;ToTime;PishID;Barcode', RequestDelectedHourlyPermit)
                    }
                    break;
                default:

            }
            break;
        case 'HourlyTraffic':
            switch (value) {
                case 'Delete':
                    if (confirm('آیا از حذف این تردد اطمینان دارید؟')) {
                        GridViewRequestHourlyTraffic.GetRowValues(GridViewRequestHourlyTraffic.GetFocusedRowIndex(), 'Dates;Times;Reader;PishID;Barcode', RequestDelectedHourlyTraffic)
                    }
                    break;
                default:

            }
            break;
        default:

    }
}
function RequestDelectedHourlyPermit(values) {
    var date = values[0];
    var fromTime = Number(values[1].substr(0, 2) * 60) + Number(values[1].substr(3, 2));
    var toTime = Number(values[2].substr(0, 2) * 60) + Number(values[2].substr(3, 2));
    var pishID = values[3];
    var barcode = values[4];
    var obj = '{"Date":"' + date + '","FromTime":"' + fromTime + '","ToTime":"' + toTime + '","PishID":"' + pishID + '","Barcode":"' + barcode + '"}';
    CallbackDeleteRequestHourlyPermit.PerformCallback(obj);
}
function RequestDelectedHourlyTraffic(values) {
    var date = values[0];
    var time = Number(values[1].substr(0, 2) * 60) + Number(values[1].substr(3, 2));
    var reader = values[2];
    var pishID = values[3];
    var barcode = values[4];
    var obj = '{"Date":"' + date + '","Time":"' + time + '","Reader":"' + reader + '","PishID":"' + pishID + '","Barcode":"' + barcode + '"}';
    CallbackDeleteRequestHourlyTraffic.PerformCallback(obj);
}
function RequestDelectedDaily(values) {
    var date = values[0];
    var time = values[1];
    var reader = values[2];
    var pishID = values[3];
    var barcode = values[4];
    var obj = '{"Date":"' + date + '","Time":"' + time + '","Reader":"' + reader + '","PishID":"' + pishID + '","Barcode":"' + barcode + '"}';
    CallbackDeleteRequestDaily.PerformCallback(obj);
}
function CallbackDeleteRequestHourlyPermit_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            if (ComboBoxMonthHourlyPermit.GetSelectedIndex() > -1 && ComboBoxYearHourlyPermit.GetSelectedIndex()>-1) {
                btnShowResultSearchHourlyPermit_onClick();
            }
            ObjCurrentViewStatHourlyPermit = 'View';
            setMenuPageStatusHourlyPermit();
            setEnabledRegistControlsHourlyPermit(false);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function CallbackDeleteRequestHourlyTraffic_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            if (ComboBoxMonthHourlyTraffic.GetSelectedIndex() > -1 && ComboBoxYearHourlyTraffic.GetSelectedIndex() > -1) {
                btnShowResultSearchHourlyTraffic_onClick();
            }
            ObjCurrentViewStatHourlyTraffic = 'View';
            setMenuPageStatusHourlyTraffic();
            setEnabledRegistControlsHourlyTraffic(false);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function CallbackDeleteRequestDaily_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            btnShowResultSearchDaily_onClick();
            ObjCurrentViewStatDaily = 'View';
            setMenuPageStatusDaily();
            setEnabledRegistControlsDaily(false);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function UpdateTrafficHourlyPermit() {
    var barcode = GridViewPersonnelHourlyPermit.GetRow(GridViewPersonnelHourlyPermit.GetFocusedRowIndex()).cells[0].innerHTML;
    var pishID = ComboBoxTrafficTypeHourlyPermit.GetSelectedItem().value;
    var comment = TextBoxCommentHourlyPermit.GetText();
    var fromHour = Number((TimeEditFromHourHourlyPermit.GetText().substr(0, 2) * 60)) + Number(TimeEditFromHourHourlyPermit.GetText().substr(3, 2));
    var toHour = Number((TimeEditToHourHourlyPermit.GetText().substr(0, 2) * 60)) + Number(TimeEditToHourHourlyPermit.GetText().substr(3, 2));
    switch (ObjCurrentViewStatHourlyPermit) {
        case 'Add':
            var mode = 'Add'
            var obj = '{"Barcode":"' + barcode + '","FromHour":"' + fromHour + '","ToHour":"' + toHour + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '"}';
            CallbackInsertRequestHourly.PerformCallback(obj);
            break;
        case 'Edit':
            var mode = 'Edit';
            var rowGridSelectedIndex = GridViewRequestHourlyPermit.GetFocusedRowIndex();
            var obj = '{"Barcode":"' + barcode + '","FromHour":"' + fromHour + '","ToHour":"' + toHour + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '","IndexGrid":"' + rowGridSelectedIndex + '"}';
            CallbackInsertRequestHourly.PerformCallback(obj);
            break;
        default:

    }
    
}
function UpdateTrafficHourlyTraffic() {
    var barcode = GridViewPersonnelHourlyTraffic.GetRow(GridViewPersonnelHourlyTraffic.GetFocusedRowIndex()).cells[0].innerHTML;
   var pishID = ComboBoxTrafficTypeHourlyTraffic.GetSelectedItem().value;
    var comment = TextBoxCommentHourlyTraffic.GetText();
    var fromHour = Number((TimeEditFromHourHourlyTraffic.GetText().substr(0, 2) * 60)) + Number(TimeEditFromHourHourlyTraffic.GetText().substr(3, 2));
    var toHour = Number((TimeEditToHourHourlyTraffic.GetText().substr(0, 2) * 60)) + Number(TimeEditToHourHourlyTraffic.GetText().substr(3, 2));
    switch (ObjCurrentViewStatHourlyTraffic) {
        case 'Add':
            var mode = 'Add'
            var obj = '{"Barcode":"' + barcode + '","FromHour":"' + fromHour + '","ToHour":"' + toHour + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '"}';
            CallbackInsertRequestHourlyTraffic.PerformCallback(obj);
            break;
        case 'Edit':
            var mode = 'Edit';
            var rowGridSelectedIndex = GridViewRequestHourlyTraffic.GetFocusedRowIndex();
            var obj = '{"Barcode":"' + barcode + '","FromHour":"' + fromHour + '","ToHour":"' + toHour + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '","IndexGrid":"' + rowGridSelectedIndex + '"}';
            CallbackInsertRequestHourlyTraffic.PerformCallback(obj);
            break;
        default:

    }
}
function CallbackUpdateRequestHourly_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            if (ComboBoxMonthHourlyPermit.GetSelectedIndex() > -1 && ComboBoxYearHourlyPermit.GetSelectedIndex() > -1) {
                btnShowResultSearchHourlyPermit_onClick();
            }
            ObjCurrentViewStatHourlyPermit = 'View';
            setMenuPageStatusHourlyPermit();
            setEnabledRegistControlsHourlyPermit(false);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function CallbackUpdateRequestHourlyTraffic_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            if (ComboBoxMonthHourlyTraffic.GetSelectedIndex() > -1 && ComboBoxYearHourlyTraffic.GetSelectedIndex() > -1) {
                btnShowResultSearchHourlyTraffic_onClick();
            }
            ObjCurrentViewStatHourlyTraffic = 'View';
            setMenuPageStatusHourlyTraffic();
            setEnabledRegistControlsHourlyTraffic(false);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function ShowEditedDaily() {
    if (GridViewRequestDaily.GetFocusedRowIndex() > -1) {
        ComboBoxTrafficTypeDaily.SetText(GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[2].innerText);
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_FromDateDaily').value = GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[1].innerText;
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_ToDateDaily').disabled = true;
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_ToDateDaily').value = '';
        TextBoxFormNoDaily.SetText(GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[6].innerText);
        //TextBoxCommentDaily.SetText(GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[7].innerText);
        setEnabledRegistControlsDaily(true);
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_ToDateDaily').disabled = true;
        
    }
    else {
        alert('ترددی جهت ویرایش انتخاب نشده است');
        ObjCurrentViewStatDaily = 'View';
        setMenuPageStatusDaily();
        
    }

}
function ShowEditedHourlyPermit() {
    if (GridViewRequestHourlyPermit.GetFocusedRowIndex() > -1) {
        ComboBoxTrafficTypeHourlyPermit.SetText(GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[4].innerText);
        
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyPremit_DateHourlyPermit').value = GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[1].innerText;
        TextBoxFormNoHourlyPermit.SetText(GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[6].innerText);
        //TextBoxCommentDaily.SetText(GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[7].innerText);
        
        TimeEditFromHourHourlyPermit.SetValue(new Date(2012, 01, 01, GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[2].innerText.substr(0, 2), GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[2].innerText.substr(3, 2), 0));
        TimeEditToHourHourlyPermit.SetValue(new Date(2012, 01, 01, GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[3].innerText.substr(0, 2), GridViewRequestHourlyPermit.GetRow(GridViewRequestHourlyPermit.GetFocusedRowIndex()).cells[3].innerText.substr(3, 2), 0));
        setEnabledRegistControlsHourlyPermit(true);

        
    }
    else {
        alert('ترددی جهت ویرایش انتخاب نشده است');
        ObjCurrentViewStatHourlyPermit = 'View';
        setMenuPageStatusHourlyPermit();

    }
}
function ShowEditedHourlyTraffic() {
    if (GridViewRequestHourlyTraffic.GetFocusedRowIndex() > -1) {
        ComboBoxTrafficTypeHourlyTraffic.SetText(GridViewRequestHourlyTraffic.GetRow(GridViewRequestHourlyTraffic.GetFocusedRowIndex()).cells[3].innerText);

        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyTraffic_DateHourlyTraffic').value = GridViewRequestHourlyTraffic.GetRow(GridViewRequestHourlyTraffic.GetFocusedRowIndex()).cells[1].innerText;
        TextBoxFormNoHourlyTraffic.SetText(GridViewRequestHourlyTraffic.GetRow(GridViewRequestHourlyTraffic.GetFocusedRowIndex()).cells[7].innerText);
        //TextBoxCommentDaily.SetText(GridViewRequestDaily.GetRow(GridViewRequestDaily.GetFocusedRowIndex()).cells[7].innerText);

        TimeEditFromHourHourlyTraffic.SetValue(new Date(2012, 01, 01, GridViewRequestHourlyTraffic.GetRow(GridViewRequestHourlyTraffic.GetFocusedRowIndex()).cells[2].innerText.substr(0, 2), GridViewRequestHourlyTraffic.GetRow(GridViewRequestHourlyTraffic.GetFocusedRowIndex()).cells[2].innerText.substr(3, 2), 0));
        TimeEditToHourHourlyTraffic.SetValue(new Date(2012, 01, 01, 0, 0, 0));
        setEnabledRegistControlsHourlyTraffic(true);
        TimeEditToHourHourlyTraffic.SetEnabled(false);

    }
    else {
        alert('ترددی جهت ویرایش انتخاب نشده است');
        ObjCurrentViewStatHourlyTraffic = 'View';
        setMenuPageStatusHourlyTraffic();

    }
}
function btnCancelEditDaily_onClick() {
    ObjCurrentViewStatDaily = 'View';
    setMenuPageStatusDaily();
    PopupControlEditDaily.Hide();

}
function ShowInsertedDialogDaily() {
   ComboBoxDateDaily.PerformCallback();
}
function ComboBoxDateDaily_SelectedIndexChanged() {
    FillGridViewRequestSelectedDateDaily();
}
function FillGridViewRequestSelectedDateDaily() {
    var barcode = '';
    var selectedDate = '';
    if (ComboBoxDateDaily.GetItemCount() > 0) {
        selectedDate = ComboBoxDateDaily.GetSelectedItem().value;
        if (GridViewPersonnelDaily.GetFocusedRowIndex() >= 0) {
            barcode = GridViewPersonnelDaily.GetRow(GridViewPersonnelDaily.GetFocusedRowIndex()).cells[0].innerHTML;
        }
        var obj = '{"Date":"' + selectedDate + '","Barcode":"' + barcode + '"}';
        GridViewRequestSelectedDateDaily.PerformCallback(obj);
    }
}
function GridViewRequestSelectedDateDaily_EndCallback()
{ }
function ComboBoxDateDaily_EndCallback() {
    if (ComboBoxDateDaily.GetItemCount() > 0) {
        FillGridViewRequestSelectedDateDaily();
        PopupInsertDaily.Show();
        document.getElementById('ButtonOkAllDaily').disabled = '';
    }
}
function GridViewPersonnelDaily_EndCallback() {
    var i = GridViewPersonnelDaily;
}

function setEnabledRegistControlsHourlyPermit(value) {
    ComboBoxTrafficTypeHourlyPermit.SetEnabled(value);
    TextBoxFormNoHourlyPermit.SetEnabled(value);
    TextBoxCommentHourlyPermit.SetEnabled(value);
    TimeEditFromHourHourlyPermit.SetEnabled(value);
    TimeEditToHourHourlyPermit.SetEnabled(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyPremit_DateHourlyPermit').disabled = !(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyPremit_DateHourlyPermit').disabled = !(value);
    
    //  var i=  document.getElementById('DateHourly');
    if (value == true) {
        ComboBoxTrafficTypeHourlyPermit.SetFocus(true);
    }
    if (ObjCurrentViewStatHourlyPermit == 'Add') {
        TextBoxFormNoHourlyPermit.SetText('');
        TextBoxCommentHourlyPermit.SetText('');
        TimeEditFromHourHourlyPermit.SetValue(new Date(2012,01,01,0,0,0));
        TimeEditToHourHourlyPermit.SetValue(new Date(2012, 01, 01, 0, 0, 0));
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyPremit_DateHourlyPermit').value = '';
    }

}
function setEnabledRegistControlsHourlyTraffic(value) {
    ComboBoxTrafficTypeHourlyTraffic.SetEnabled(value);
    TextBoxFormNoHourlyTraffic.SetEnabled(value);
    TextBoxCommentHourlyTraffic.SetEnabled(value);
    TimeEditFromHourHourlyTraffic.SetEnabled(value);
    TimeEditToHourHourlyTraffic.SetEnabled(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyTraffic_DateHourlyTraffic').disabled = !(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyTraffic_DateHourlyTraffic').disabled = !(value);
    //  var i=  document.getElementById('DateHourly');
    if (value == true) {
        ComboBoxTrafficTypeHourlyTraffic.SetFocus(true);
    }
    if (ObjCurrentViewStatHourlyTraffic == 'Add') {
        TextBoxFormNoHourlyTraffic.SetText('');
        TextBoxCommentHourlyTraffic.SetText('');
        TimeEditFromHourHourlyTraffic.SetValue(new Date(2012, 01, 01, 0, 0, 0));
        TimeEditToHourHourlyTraffic.SetValue(new Date(2012, 01, 01, 0, 0, 0));
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchHourlyTraffic_DateHourlyTraffic').value = '';
    }

}
function setEnabledRegistControlsDaily(value) {
    ComboBoxTrafficTypeDaily.SetEnabled(value);
    TextBoxFormNoDaily.SetEnabled(value);
    TextBoxCommentDaily.SetEnabled(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_FromDateDaily').disabled = !(value);
    document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_ToDateDaily').disabled = !(value);
    if (value == true) {
        ComboBoxTrafficTypeDaily.SetFocus(true);
    }
    //  var i=  document.getElementById('DateHourly');
    if (ObjCurrentViewStatDaily == 'Add') {
        TextBoxFormNoDaily.SetText('');
        TextBoxCommentDaily.SetText('');
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_FromDateDaily').value = '';
        document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_ToDateDaily').value = '';
    }
}
function setMenuPageStatusDaily() {
   
            switch (ObjCurrentViewStatDaily) {
                case 'View':

                    MenuHeaderDaily.GetItem(0).SetEnabled(true);
                    MenuHeaderDaily.GetItem(1).SetEnabled(true);
                    MenuHeaderDaily.GetItem(2).SetEnabled(false);
                    MenuHeaderDaily.GetItem(3).SetEnabled(false);
                    MenuHeaderDaily.GetItem(4).SetEnabled(true);

                    //*****************


                    break;
                case 'Add':
                    MenuHeaderDaily.GetItem(0).SetEnabled(false);
                    MenuHeaderDaily.GetItem(1).SetEnabled(false);
                    MenuHeaderDaily.GetItem(2).SetEnabled(true);
                    MenuHeaderDaily.GetItem(3).SetEnabled(true);
                    MenuHeaderDaily.GetItem(4).SetEnabled(false);

                    //*****************

                    break;
                case 'Edit':
                    MenuHeaderDaily.GetItem(0).SetEnabled(false);
                    MenuHeaderDaily.GetItem(1).SetEnabled(false);
                    MenuHeaderDaily.GetItem(2).SetEnabled(true);
                    MenuHeaderDaily.GetItem(3).SetEnabled(true);
                    MenuHeaderDaily.GetItem(4).SetEnabled(false);

                    //*****************

                    break;
                case 'Delete':
                    MenuHeaderDaily.GetItem(0).SetEnabled(false);
                    MenuHeaderDaily.GetItem(1).SetEnabled(false);
                    MenuHeaderDaily.GetItem(2).SetEnabled(false);
                    MenuHeaderDaily.GetItem(3).SetEnabled(true);
                    MenuHeaderDaily.GetItem(4).SetEnabled(false);

                    //*****************

                    break;
                default:

            }

     
}

function setMenuPageStatusHourlyPermit() {
    switch (ObjCurrentViewStatHourlyPermit) {
        case 'View':

            MenuHeaderHourlyPermit.GetItem(0).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(1).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(2).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(3).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(4).SetEnabled(true);

            //*****************


            break;
        case 'Add':
            MenuHeaderHourlyPermit.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(2).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(4).SetEnabled(false);

            //*****************

            break;
        case 'Edit':
            MenuHeaderHourlyPermit.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(2).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(4).SetEnabled(false);

            //*****************

            break;
        case 'Delete':
            MenuHeaderHourlyPermit.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(2).SetEnabled(false);
            MenuHeaderHourlyPermit.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyPermit.GetItem(4).SetEnabled(false);

            //*****************

            break;
        default:

    }


}
function setMenuPageStatusHourlyTraffic() {
    switch (ObjCurrentViewStatHourlyTraffic) {
        case 'View':

            MenuHeaderHourlyTraffic.GetItem(0).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(1).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(2).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(3).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(4).SetEnabled(true);

            //*****************


            break;
        case 'Add':
            MenuHeaderHourlyTraffic.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(2).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(4).SetEnabled(false);

            //*****************

            break;
            break;
        case 'Edit':
            MenuHeaderHourlyTraffic.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(2).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(4).SetEnabled(false);

            //*****************

            break;
        case 'Delete':
            MenuHeaderHourlyTraffic.GetItem(0).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(1).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(2).SetEnabled(false);
            MenuHeaderHourlyTraffic.GetItem(3).SetEnabled(true);
            MenuHeaderHourlyTraffic.GetItem(4).SetEnabled(false);

            //*****************

            break;
        default:

    }


}
function ComboBoxResultSearchPersonnelDailyErrorCallback() {
}
function ComboBoxResultSearchPersonnelDailyEndCallback() {
}
function ComboBoxResultSearchPersonnelHourlyErrorCallback() {
}
function ComboBoxResultSearchPersonnelHourlyEndCallback() {
}
function btnShowResultSearchDaily_onClick() {
    var month = '';
    var year = '';
    var barcode = '';
    
    if (ComboBoxMonthDaily.GetSelectedItem() != null) {
        month = ComboBoxMonthDaily.GetSelectedItem().value;
    }

    if (ComboBoxYearDaily.GetSelectedItem() != null) {
        year = ComboBoxYearDaily.GetSelectedItem().value;
    }
    if (GridViewPersonnelDaily.GetFocusedRowIndex() >= 0) {
        barcode = GridViewPersonnelDaily.GetRow(GridViewPersonnelDaily.GetFocusedRowIndex()).cells[0].innerHTML;
    }
    var obj = '{"Barcode":"' + barcode + '","Month":"' + month + '","Year":"' + year + '"}';
    GridViewRequestDaily.PerformCallback(obj);
    

}

function btnShowResultSearchHourlyPermit_onClick() {
    var month = '';
    var year = '';
    var barcode = '';

    if (ComboBoxMonthHourlyPermit.GetSelectedItem() != null) {
        month = ComboBoxMonthHourlyPermit.GetSelectedItem().value;
    }

    if (ComboBoxYearHourlyPermit.GetSelectedItem() != null) {
        year = ComboBoxYearHourlyPermit.GetSelectedItem().value;
    }
    if (GridViewPersonnelHourlyPermit.GetFocusedRowIndex() >= 0) {
        barcode = GridViewPersonnelHourlyPermit.GetRow(GridViewPersonnelHourlyPermit.GetFocusedRowIndex()).cells[0].innerHTML;
    }
    var obj = '{"Barcode":"' + barcode + '","Month":"' + month + '","Year":"' + year + '"}';
    GridViewRequestHourlyPermit.PerformCallback(obj);


}
function btnShowResultSearchHourlyTraffic_onClick() {
    var month = '';
    var year = '';
    var barcode = '';

    if (ComboBoxMonthHourlyTraffic.GetSelectedItem() != null) {
        month = ComboBoxMonthHourlyTraffic.GetSelectedItem().value;
    }

    if (ComboBoxYearHourlyTraffic.GetSelectedItem() != null) {
        year = ComboBoxYearHourlyTraffic.GetSelectedItem().value;
    }
    if (GridViewPersonnelHourlyTraffic.GetFocusedRowIndex() >= 0) {
        barcode = GridViewPersonnelHourlyTraffic.GetRow(GridViewPersonnelHourlyTraffic.GetFocusedRowIndex()).cells[0].innerHTML;
    }
    var obj = '{"Barcode":"' + barcode + '","Month":"' + month + '","Year":"' + year + '"}';
    GridViewRequestHourlyTraffic.PerformCallback(obj);


}
function UpdateRequestDaily() {
    switch (ObjCurrentViewStatDaily) {
        case 'Add':
            ShowInsertedDialogDaily();
            break;
        case 'Edit':
            var barcode = GridViewPersonnelDaily.GetRow(GridViewPersonnelDaily.GetFocusedRowIndex()).cells[0].innerHTML;
            var fromdate = document.getElementById('ASPxPageControlRequestDaily_ASPxRoundPanelSearchDaily_FromDateDaily').value;
            var toDate = '';
            var pishID = ComboBoxTrafficTypeDaily.GetSelectedItem().value;
            var comment = TextBoxCommentDaily.GetText();
            var indexGrid = GridViewRequestDaily.GetFocusedRowIndex();
            var mode = 'Edit';
            var obj = '{"Barcode":"' + barcode + '","FromDate":"' + fromdate + '","ToDate":"' + toDate + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '","IndexGrid":"' + indexGrid + '"}';
            CallbackInsertRequestDaily.PerformCallback(obj);
            break;
        default:

    }
    
}
function ButtonOkDaily_onClick() {
   var barcode = GridViewPersonnelDaily.GetRow(GridViewPersonnelDaily.GetFocusedRowIndex()).cells[0].innerHTML;
   var fromdate = ComboBoxDateDaily.GetSelectedItem().value;
   var toDate = '';
   var pishID = ComboBoxTrafficTypeDaily.GetSelectedItem().value;
   var comment = TextBoxCommentDaily.GetText();
   var mode = 'InsertOne';
   var obj = '{"Barcode":"' + barcode + '","FromDate":"' + fromdate + '","ToDate":"' + toDate + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '"}';
   CallbackInsertRequestDaily.PerformCallback(obj);


}
function CallbackInsertRequestDaily_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            var selectedIndex = ComboBoxDateDaily.GetSelectedIndex();
            ComboBoxDateDaily.RemoveItem(selectedIndex);
            ComboBoxDateDaily.SetSelectedIndex(selectedIndex);
            
            FillGridViewRequestSelectedDateDaily();
            btnShowResultSearchDaily_onClick();
            document.getElementById('ButtonOkAllDaily').disabled = 'disabled';
            if (ComboBoxDateDaily.GetItemCount() == 0) {
                PopupInsertDaily.Hide();
                ObjCurrentViewStatDaily = 'View';
                setEnabledRegistControlsDaily(false);
                setMenuPageStatusDaily();
            }
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
   
   
}
function ButtonCancelDaily_onClick() {
    var selectedIndex = ComboBoxDateDaily.GetSelectedIndex();
    ComboBoxDateDaily.RemoveItem(selectedIndex);
    ComboBoxDateDaily.SetSelectedIndex(selectedIndex);
    FillGridViewRequestSelectedDateDaily();

}
function ButtonOkAllDaily_onClick() {
    var barcode = GridViewPersonnelDaily.GetRow(GridViewPersonnelDaily.GetFocusedRowIndex()).cells[0].innerHTML;
    var fromdate = '';
    var toDate = '';
    if (ComboBoxTrafficTypeDaily.GetItemCount() > 0) {
        var pishID = ComboBoxTrafficTypeDaily.GetSelectedItem().value;
    }
    else {
        var pishID = '';
    }
    var comment = TextBoxCommentDaily.GetText();
    var mode = 'InsertAll';
    var obj = '{"Barcode":"' + barcode + '","FromDate":"' + fromdate + '","ToDate":"' + toDate + '","PishID":"' + pishID + '","Comment":"' + comment + '","Mode":"' + mode + '"}';
    CallbackInsertRequestDaily.PerformCallback(obj);
    ComboBoxDateDaily.ClearItems();
    
}
function btnSabtEditDaily_onClick() {

}

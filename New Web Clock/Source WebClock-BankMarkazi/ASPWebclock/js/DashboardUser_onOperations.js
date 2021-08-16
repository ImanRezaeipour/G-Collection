var ObjCurrentViewStatDaily='Add'




function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'AddNewRequest_DashboardUser':
            PopupInsertRequest.Show();
            break;
        case 'Help_DashboardUser':
            parent.LoadHelpPage('DashboardUser');
            
            break;
        default:

    }
}
function ButtonShowRemainLeave_onClick() {
    window.open('../Operation/RemainLeaveViewer.aspx?year=' + ComboBoxYear.GetSelectedItem().value + '&month=' + ComboBoxMonth.GetSelectedItem().value , 'RemainLeaveViewer' + (new Date()).getTime(), 'height=300px,width=1000px,status=yes,menubar=no,scrollbars=no,resizable=no')
}
function ButtonViewRequest_DashboardUser_onClick() {
    fillGridRequested_DashboardUser();
    //CallbackPanelRemainLeave.PerformCallback();
}
function fillGridRequested_DashboardUser() {
    var params = '';
    grid.PerformCallback(params.concat(ComboBoxYear.GetSelectedItem().value, ';', ComboBoxMonth.GetSelectedItem().value, ';', CheckBoxDaily.GetChecked(), ';', CheckBoxHourly.GetChecked(), ';', CheckBoxOverTime.GetChecked()));

} 
function onItemMenuHeaderDailyClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        
        case 'SaveMenuHeaderDaily_DashboardUser':
            InsertNewRequestDaily();
            break;
        case 'CancelMenuHeaderDaily_DashboardUser':
            ObjCurrentViewStatDaily = 'View';
            PopupInsertRequest.Hide();
            break;
        
        default:

    }

}
function CallbackPanelRemainLeave_EndCallback(s, e) {
}
function CallbackPanelRemainLeave_ErrorCallback(s, e) {
}
function InsertNewRequestDaily() {
    if (ComboBoxTrafficTypeDaily.GetItemCount() > 0) {
        var pishID = ComboBoxTrafficTypeDaily.GetSelectedItem().value;
    }
    else {
        alert('لطفا پیش کارت مورد نظر را انتخاب نماببد.');
        return;
    }
    var comment = TextBoxCommentDaily.GetText();
    var obj = '{"PishID":"' + pishID + '","Comment":"' + comment + '"}';
    CallbackInsertRequestDaily.PerformCallback(obj);
}
function CallbackInsertRequestDaily_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);
            
            ButtonViewRequest_DashboardUser_onClick();
            
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }


}
function InsertRequestHourly() {
    if (ComboBoxTrafficTypeHourly.GetItemCount() > 0) {
        var pishID = ComboBoxTrafficTypeHourly.GetSelectedItem().value;

    }
    else {
        alert('لطفا پیش کارت مورد نظر را انتخاب نماببد.');
        return;
    }
    var comment = TextBoxCommentHourly.GetText();
    var fromHour = Number((TimeEditFromHourHourly.GetText().substr(0, 2) * 60)) + Number(TimeEditFromHourHourly.GetText().substr(3, 2));
    var toHour = Number((TimeEditToHourHourly.GetText().substr(0, 2) * 60)) + Number(TimeEditToHourHourly.GetText().substr(3, 2));
    if (TimeEditToHourHourly.GetText() < TimeEditFromHourHourly.GetText()) {
        if (ComboBoxTrafficTypeHourly.GetValue() == '0') {
            if (TimeEditToHourHourly.GetText() != '00:00') {
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
        if (TimeEditFromHourHourly.GetText() == '00:00' && ComboBoxTrafficTypeHourly.GetValue() != '0') {
            alert('مقادیر ورودی ساعت را اصلاح کنید');
            return;
        }
    }
    if (TimeEditToHourHourly.GetText() == TimeEditFromHourHourly.GetText()) {
        alert('مقادیر ورودی ساعت را اصلاح کنید');
        return;
    }
          
            var obj = '{"FromHour":"' + fromHour + '","ToHour":"' + toHour + '","PishID":"' + pishID + '","Comment":"' + comment + '"}';
            CallbackInsertRequestHourly.PerformCallback(obj);
       

}
function CallbackInsertRequestHourly_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);

            ObjCurrentViewStatHourlyPermit = 'View';
            ButtonViewRequest_DashboardUser_onClick();
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function InsertRequestOvertime() {
    if (ComboBoxTrafficTypeOverTime.GetItemCount() > 0) {
        var pishID = ComboBoxTrafficTypeOverTime.GetSelectedItem().value;

    }
    else {
        alert('لطفا پیش کارت مورد نظر را انتخاب نماببد.');
        return;
    }
    var comment = TextBoxCommentHourly.GetText();
    var Hour = Number((TimeEditHourOverTime.GetText().substr(0, 2) * 60)) + Number(TimeEditHourOverTime.GetText().substr(3, 2));
    

    var obj = '{"Hour":"' + Hour + '","PishID":"' + pishID + '","Comment":"' + comment + '"}';
    CallbackInsertRequestOvertime.PerformCallback(obj);


}
function CallbackInsertRequestOvertime_CallbackComplete(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);

            ObjCurrentViewStatHourlyPermit = 'View';
            ButtonViewRequest_DashboardUser_onClick();
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function onItemMenuHeaderHourlyClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'SaveMenuHeaderHourly_DashboardUser':
            InsertRequestHourly();
            break;
        case 'CancelMenuHeaderHourly_DashboardUser':
            ObjCurrentViewStatDaily = 'View';
            PopupInsertRequest.Hide();
            break;

        default:

    }

}
function onItemMenuHeaderOverTimeClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'SaveMenuHeaderOvertime_DashboardUser':
            InsertRequestOvertime();
            break;
        case 'CancelMenuHeaderOvertime_DashboardUser':
            ObjCurrentViewStatDaily = 'View';
            PopupInsertRequest.Hide();
            break;

        default:

    }

}
function ConfirmDeleteRowGrid(e) {
    if (e.buttonID == 'Delete') {
        if (confirm('آیا این درخواست را حذف می نمایید؟'))
            CallbackDeleteRowsSelectedGrid();
    }
}
function CallbackDeleteRowsSelectedGrid() {
    var indexRowSelected = grid.GetFocusedRowIndex();
    CallbackDeleteRequest.PerformCallback(indexRowSelected);
}
function CallbackDeleteRequestEndCallback(e) {
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            ButtonViewRequest_DashboardUser_onClick();
           alert(message);
            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
   
}





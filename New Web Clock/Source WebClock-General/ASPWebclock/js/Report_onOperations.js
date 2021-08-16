/// <reference path="jquery-1.7.1.js" />
$(document).ready(function () {
    ComboBoxReportName_onChanged();
});
function divContentTreeViewParts_onScroll() {
    document.getElementById('hfScrollPosition').value = $("#divContentTreeViewParts").scrollTop();
}
function TreeViewParts_onClick() {
    $("#divContentTreeViewParts").scrollTop(document.getElementById('hfScrollPosition').value);
}
function TreeViewParts_onExpandedChanged() {
    $("#divContentTreeViewParts").scrollTop(document.getElementById('hfScrollPosition').value);
}

function ComboBoxTypePersonnel_onChanged() {
    switch (ComboBoxTypePersonnel.GetSelectedItem().value) {
        case 'Part':
            {
                GridViewPersonnels.SetVisible(false);
                TreeViewParts.SetVisible(true);

                CheckBoxSubParts.SetVisible(true);
                CheckBoxSelectAllPersonnel.SetVisible(false);
                document.getElementById('divContentTreeViewParts').style.visibility = 'visible';
                break;
            }
        case 'Person':
            {
                TreeViewParts.SetVisible(false);
                GridViewPersonnels.SetVisible(true);

                CheckBoxSubParts.SetChecked(false);
                CheckBoxSubParts.SetVisible(false);
                CheckBoxSelectAllPersonnel.SetVisible(this);
                document.getElementById('divContentTreeViewParts').style.visibility = 'hidden';
                break;
            }
        default:
            break;
    }
}

function CheckBoxSelectAllPersonnel_onChanged(s, e) {

    GridViewPersonnels.PerformCallback(s.GetChecked());
}
function onClickRowGridViewPersonnels() {
}
function onFocusRowGridViewPersonnels() {

}

function ButtonViewReport_onClick(s, e) {

    ShowLoadingImage('DivButtonViewReport');
    ButtonViewReport.SetEnabled(false);
    var type = "Part";
    var year = "";
    var month = "";
    var reportID = 0;
    var calculate = false;
    var pishcard = "All";
    var terminal = "All";
    var station = "All";
    var emplymentType = "All";
    if (ComboBoxTypePersonnel.GetSelectedIndex() > -1)
        type = ComboBoxTypePersonnel.GetSelectedItem().value;


    if (ComboBoxYear.GetSelectedIndex() > -1)
        year = ComboBoxYear.GetSelectedItem().value;
    if (ComboBoxMonth.GetSelectedIndex() > -1)
        month = ComboBoxMonth.GetSelectedItem().value;

    var subParts = CheckBoxSubParts.GetChecked();
    if (ComboBoxReportName.GetSelectedIndex() > -1)
        reportID = ComboBoxReportName.GetSelectedItem().value;

    if (ComboBoxCalculate.GetSelectedIndex() > -1)
        calculate = ComboBoxCalculate.GetSelectedItem().value;

    if (ComboBoxPishcardDaily.GetSelectedIndex() > -1)
        pishcard = ComboBoxPishcardDaily.GetSelectedItem().value;
    if (ComboBoxTerminal.GetSelectedIndex() > -1)
        terminal = ComboBoxTerminal.GetSelectedItem().value;
    if (ComboBoxStation.GetSelectedIndex() > -1)
        station = ComboBoxStation.GetSelectedItem().value;
    ComboBoxEmploymentType
    if (ComboBoxEmploymentType.GetSelectedIndex() > -1)
        emplymentType = ComboBoxEmploymentType.GetSelectedItem().value;
    var fromTime = TimeEditFromTime.GetText();
    var toTime = TimeEditToTime.GetText();
    var timeStartHour = TextBoxTimeStartHour.GetText();
    var timeStartMinute = TextBoxTimeStartMinute.GetText();
    var timeEndHour = TextBoxTimeEndHour.GetText();
    var timeEndMinute = TextBoxTimeEndMinute.GetText();
    var dayStart = TextBoxDayStart.GetText();
    var dayEnd = TextBoxDayEnd.GetText();

    var obj = '{"Type":"' + type + '","Year":"' + year + '","Month":"' + month + '","SubPart":"' + subParts + '","ReportID":"' + reportID + '","Calculate":"' + calculate + '","Pishcard":"' + pishcard + '","Terminal":"' + terminal + '","Station":"' + station + '","EmploymentType":"' + emplymentType + '","FromTime":"' + fromTime + '","ToTime":"' + toTime + '","TimeStarHour":"' + timeStartHour + '","TimeStarMinute":"' + timeStartMinute + '","TimeEndHour":"' + timeEndHour + '","TimeEndMinute":"' + timeEndMinute + '","DayStart":"' + dayStart + '","DayEnd":"' + dayEnd + '"}';
    if (!CallbackReportView.InCallback()) {
        CallbackReportView.PerformCallback(obj);
    }


}
function CallbackReportView_errorCallback(e) {
    ButtonViewReport.SetEnabled(true);
    HideLoadingImage();
}
function CallbackReportView_endCallback(s,e) {
    ButtonViewReport.SetEnabled(true);
    HideLoadingImage();

    if (e.result == 'Success')
        window.open('../Report/ReportViewer.aspx', 'ReportViewer' + (new Date()).getTime(), 'height=' + (screen.height) + ',width=' + (screen.width) + ',status=yes,menubar=yes,scrollbars=yes,resizable=yes')
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}

function ComboBoxReportName_onChanged() {
    ButtonViewReport.SetEnabled(false);
    if (ComboBoxReportName.GetSelectedIndex() > -1) {
        ShowLoadingImage('tdReportName');
        

        var selectedReport = ComboBoxReportName.GetSelectedItem().value;

        CallbackSetParameterVisible.PerformCallback(selectedReport);
    }
    
}

function SetVisiblePanelsParameter(state) {
    RoundPanelDate.SetVisible(state);
    RoundPanelDateRange.SetVisible(state);
    RoundPanelFromToDate.SetVisible(state);
    RoundPanelFromToTime.SetVisible(state);
    RoundPanelPishcardDaily.SetVisible(state);
    RoundPanelPishcardHourly.SetVisible(state);
    RoundPanelTerminal.SetVisible(state);
    RoundPanelStation.SetVisible(state);
    RoundPanelTimeRange.SetVisible(state);
    RoundPanelEmploymentType.SetVisible(state);
    RoundPanelDayRange.SetVisible(state);
}
function CallbackSetParameterVisible_CallbackComplete(e) {
    ButtonViewReport.SetEnabled(true);
    SetVisiblePanelsParameter(false);
    var RetResult = eval('(' + e.result + ')');
    for (var i = 0; i < RetResult.length; i++) {
        var ctrl = eval(RetResult[i]);
        ctrl.SetVisible(true);

    }
}
function CallbackSetParameterVisible_EndCallback(s, e) {
    HideLoadingImage();
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }

}
function CallbackSetParameterVisible_CallbackError(e) {
    HideLoadingImage();
    alert('خطا در انجام عملیات .لطفا مجددا سعی نمایید.');
}


function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 8 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}
function GridViewPersonnels_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}

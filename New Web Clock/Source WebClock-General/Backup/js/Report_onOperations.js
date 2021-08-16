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
        var type = ComboBoxTypePersonnel.GetSelectedItem().value;


        var year = ComboBoxYear.GetSelectedItem().value;
        var month = ComboBoxMonth.GetSelectedItem().value;
        var subParts = CheckBoxSubParts.GetChecked();
        var reportID = ComboBoxReportName.GetSelectedItem().value;
        var calculate = ComboBoxCalculate.GetSelectedItem().value;
        var pishcard = ComboBoxPishcard.GetSelectedItem().value;
        var terminal = ComboBoxTerminal.GetSelectedItem().value;
        var obj = '{"Type":"' + type + '","Year":"' + year + '","Month":"' + month + '","SubPart":"' + subParts + '","ReportID":"' + reportID + '","Calculate":"' + calculate + '","Pishcard":"' + pishcard + '","Terminal":"' + terminal + '"}';
        if (!CallbackReportView.InCallback()) {
            CallbackReportView.PerformCallback(obj);
        }
    

}
function CallbackReportView_errorCallback(e) {
    
    HideLoadingImage();
}
function CallbackReportView_endCallback(e) {
    
    HideLoadingImage();
if(e.result=='Success')
    window.open('../Report/ReportViewer.aspx', 'ReportViewer' + (new Date()).getTime(), 'height=' + (screen.height) + ',width=' + (screen.width) + ',status=yes,menubar=yes,scrollbars=yes,resizable=yes')
}

function ComboBoxReportName_onChanged() {
    ShowLoadingImage('tdReportName');
    var selectedReport = ComboBoxReportName.GetSelectedItem().value;
    CallbackSetParameterReport.PerformCallback(selectedReport);
}
function CallbackSetParameterReport_endCallback(e) {
    HideLoadingImage();
    switch (e.result) {
        case 'DateRangePerson':
            document.getElementById('tblDateRange').style.display = '';
            document.getElementById('tblFromDateToDate').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(false);
            break;
        case 'FromToDatePerson':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            document.getElementById('tblFromDateToDate').style.display = '';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(false);
            break;
        case 'DatePerson':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = '';
            document.getElementById('tblFromDateToDate').style.display = 'none';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(false);
            break;
        case 'Barcode':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            document.getElementById('tblFromDateToDate').style.display = 'none';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(false);
            break;
        case 'None':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            document.getElementById('tblFromDateToDate').style.display = 'none';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(false);

            break;
        case 'FromToDatePersonPishcard':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            document.getElementById('tblFromDateToDate').style.display = '';
            //document.getElementById('tblPishcard').style.display = '';
            RoundPanelPishcardFilter.SetVisible(true);
            RoundPanelTerminalFilter.SetVisible(false);
            break;
        case 'FromToDatePersonTerminal':
            document.getElementById('tblDateRange').style.display = 'none';
            document.getElementById('tblDatePerson').style.display = 'none';
            document.getElementById('tblFromDateToDate').style.display = '';
            //document.getElementById('tblPishcard').style.display = '';
            RoundPanelPishcardFilter.SetVisible(false);
            RoundPanelTerminalFilter.SetVisible(true);
            break;
        default:
            break;
    }
}
function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 8 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}

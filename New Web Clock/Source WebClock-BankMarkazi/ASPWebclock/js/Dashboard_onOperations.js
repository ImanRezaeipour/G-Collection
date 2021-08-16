/// <reference path="jquery-1.7.1.js" />
var slideFilterStatus = 'Down';
var actionFilter = '';
var ConfirmButtonState;
var RejectedButtonState;
$(document).ready(function () {
    ConfirmButtonState = Button3_Dashbord.GetEnabled();
    RejectedButtonState = Button4_Dashbord.GetEnabled();
    $("#imgSlidePanelFilter").click(function () {
        slideFilterPanel_Dashboard(slideFilterStatus);

       
    });


});
function slideFilterPanel_Dashboard(stateSlide) {
    switch (slideFilterStatus) {
        case 'Down':
            {
                $("#divFilterRequests_Dashborad").slideUp(1000);
                slideFilterStatus = 'Up';
                document.getElementById('imgSlidePanelFilter').src = '../img/maximize.png';
                break;
            }
        case 'Up':
            {
                $("#divFilterRequests_Dashborad").slideDown(1000);
                slideFilterStatus = 'Down';
                document.getElementById('imgSlidePanelFilter').src = '../img/minimize.png';
                break;
            }

        default:
            break;
    }
}
function ConfirmationRequest(selectedValues) {
    SetStatePageByFilterType(RadioButtonListFilterView.GetSelectedItem().value);
    PerformDashbordCallback('2', underView, confirmed, rejected, deleted, selectedValues);
}
function deleteRequest(selectedValues) {

    SetStatePageByFilterType(RadioButtonListFilterView.GetSelectedItem().value);
    PerformDashbordCallback('4', underView, confirmed, rejected, deleted, selectedValues);
}
var underView;
var confirmed;
var rejected;
var deleted;
function SetStatePageByFilterType(filterType) {
    switch (filterType) {
        case 'UnderView':
            underView = true;
            confirmed = false;
            rejected = false;
            deleted = false;
            Button3_Dashbord.SetEnabled(ConfirmButtonState);
           Button4_Dashbord.SetEnabled(RejectedButtonState);
            

            break;
        case 'Confirmed':
            underView = false;
            confirmed = true;
            rejected = false;
            deleted = false;
            Button3_Dashbord.SetEnabled(false);
            Button4_Dashbord.SetEnabled(false);
            break;
        case 'Rejected':
            underView = false;
            confirmed = false;
            rejected = true;
            deleted = false;
            Button3_Dashbord.SetEnabled(false);
            Button4_Dashbord.SetEnabled(false);
            break;
        case 'Deleted':
            underView = false;
            confirmed = false;
            rejected = false;
            deleted = true;
            Button3_Dashbord.SetEnabled(false);
            Button4_Dashbord.SetEnabled(false);
            break;
        default:
            break;
    }
}
function RejectionRequest(selectedValues) {
    SetStatePageByFilterType(RadioButtonListFilterView.GetSelectedItem().value);
    PerformDashbordCallback('3', underView, confirmed, rejected, deleted, selectedValues);
}

function DashbordFilterCallback() {
    ShowLoadingImage('tdButtonDoCondition');
    actionFilter = 'UnderView';
    SetStatePageByFilterType(RadioButtonListFilterView.GetSelectedItem().value);

    PerformDashbordCallback('1', underView, confirmed, rejected, deleted, '');
}

function PerformDashbordCallback(actionType, underReview, confirmed, Rejected, Deleted, selectedValues) {
    var selectedPersonBarcode = '';
    var selectedPishcard=''
    if (GridViewUnderManegment.GetFocusedRowIndex() >= 0) {

        var row = GridViewUnderManegment.GetRow(GridViewUnderManegment.GetFocusedRowIndex());
        var cellValue = row.cells[0].innerHTML + ' ' + row.cells[1].innerHTML + ' ' + row.cells[2].innerHTML;

        selectedPersonBarcode = row.cells[0].innerHTML;
    }
    else {
        selectedPersonBarcode = 'All';
    }
    if (ComboBoxPishcard.GetSelectedIndex() >= 0) {
        selectedPishcard = ComboBoxPishcard.GetSelectedItem().value;
    }
    else {
        ComboBoxPishcard.SetSelectedIndex(0);
        selectedPishcard = ComboBoxPishcard.GetSelectedItem().value;
    }
    var params = actionType.concat(';');
    if (!DashbordsGridView.InCallback()) {
        DashbordsGridView.cpCallbackMsg = undefined;
        DashbordsGridView.PerformCallback(params.concat(underReview.toString(), ';', confirmed.toString(), ';', Rejected.toString(), ';', Deleted.toString(), ';', selectedValues, ';', selectedPersonBarcode,';',selectedPishcard));
    }
}
function CheckBoxSelectAllPerson_onChanged(s, e) {
    if (s.GetChecked() == true) {
        DropDownEditUnderManagment.SetText('انتخاب همه پرسنل');
        GridViewUnderManegment.SetFocusedRowIndex(-1);
    }
    DropDownEditUnderManagment.HideDropDown();
    CheckBoxSelectAllPerson.SetChecked(true);
}

function DashbordsGridView_EndCallback(s, e) {
    HideLoadingImage();
    if (typeof (s.cpCallbackMsg) != "undefined") {
        alert(s.cpCallbackMsg.toString());
        s.cpCallbackMsg = undefined;
    }
    if (actionFilter == 'UnderView') {
        slideFilterPanel_Dashboard('Up')
        {
            actionFilter = '';
        }
    }
   
}

function OnAllCheckedChanged(s, e) {

    if (s.GetChecked())

        DashbordsGridView.SelectAllRowsOnPage();

    else

        DashbordsGridView.UnselectAllRowsOnPage();

}
function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_DashboardManager':
            parent.LoadHelpPage('DashboardManager');

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
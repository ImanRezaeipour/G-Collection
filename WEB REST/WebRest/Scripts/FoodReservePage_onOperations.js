
/// <reference path="http://localhost:35055/Scripts/jquery-1.9.1.js" />



function ButtonNewSelectFood_FoodReserve_onClick() {

    GridViewDetailsFoodReserve_FoodReserve.AddNewRow();
    ButtonNewSelectFood_FoodReserve.SetVisible(false);
}
function ComboBoxMealType_FoodReserve_onSelectedIndexChanged() {
    var mealTypeSelected = ComboBoxMealType_FoodReserve.GetSelectedItem().value;
    GridViewFoodListDetailsFoodReserve_FoodReserve.PerformCallback(mealTypeSelected);
    GridViewsupplementsListDetailsFoodReserve_FoodReserve.PerformCallback(mealTypeSelected)
}
function GridViewFoodListDetailsFoodReserve_FoodReserve_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
    
}
function GridViewsupplementsListDetailsFoodReserve_FoodReserve_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}

function ButtonFoodListCancelDetailsFoodReserve_onClick() {
    GridViewDetailsFoodReserve_FoodReserve.CancelEdit();
    ButtonNewSelectFood_FoodReserve.SetVisible(true);
}
function ButtonFoodListSaveDetailsFoodReserve_onClick() {
    GridViewDetailsFoodReserve_FoodReserve.UpdateEdit();
}
function GridViewDetailsFoodReserve_FoodReserve_EndCallback(s, e) {
    switch (s.cpAction) {
        case "Insert":
            {
                ButtonNewSelectFood_FoodReserve.SetVisible(true);
                GridViewFoodReserve_FoodReserve.PerformCallback();
                CallbackPanelLabelPersonCredit_FoodReserve.PerformCallback();
                break;
            }
        case "Delete":
            {
                GridViewFoodReserve_FoodReserve.PerformCallback();
                CallbackPanelLabelPersonCredit_FoodReserve.PerformCallback();
                break;
            }
        default:
            break;

    }
    
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
    if (s.showingError != null) {
        alert(s.showingError);
    }
}
function ConfirmDeleteRowGridViewDetailsFoodReserve(s,e) {
    if (e.buttonID == 'Delete') {
        if (confirm('آیا این رزرو را حذف می نمایید؟')) {
            
            var action = 'Delete';
            var indexRowSelected = GridViewDetailsFoodReserve_FoodReserve.GetFocusedRowIndex();
            var obj = '{"Action":"' + action + '","SelectedRow":"' + indexRowSelected + '"}';
            GridViewDetailsFoodReserve_FoodReserve.PerformCallback(obj);
        }
        
    }
}
function CallbackPanelLabelPersonCredit_FoodReserve_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}
function CallbackPanelLabelPersonCredit_FoodReserve_ErrorCallback(s, e) {
    alert(e);
}

function ButtonLoadGridView_FoodReserve_onClick() {
    ShowLoadingImage('tdButtonLoadGridFoodReserve');
    GridViewFoodReserve_FoodReserve.PerformCallback();
   
}
function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 40 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}
function GridViewFoodReserve_FoodReserve_EndCallback(s,e) {
    HideLoadingImage();
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}
function GridViewFoodReserve_FoodReserve_ErrorCallback(s,e) {
    HideLoadingImage();
    alert(e);
}
var slideReport = 'Up';
function ButtonShowReportFilter_FoodReserve_onClick() {
    switch (slideReport) {
        case 'Down':
            {
                $("#divPanelFilterReport_FoodReserve").slideUp(500);
                slideReport = 'Up';
                break;
            }
        case 'Up':
            {
                $("#divPanelFilterReport_FoodReserve").slideDown(500);
                slideReport = 'Down';
                break;
            }
        default:
            break;
    }
    
}
function ButtonShowReport_FoodReserve_onClick() {
    ShowLoadingImage('divReportButton');
    $("#divPanelFilterReport_FoodReserve").slideUp(500);
    slideReport = 'Up';
    CallbackReport_FoodReserve.PerformCallback();
}
function CallbackReport_FoodReserve_callbackComplete(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
    else {
        HideLoadingImage();
        window.open('ReportFishFood.aspx', 'PrintMe', 'height=600px,width=800px,scrollbars=1');
    }
}
function CallbackReport_FoodReserve_errorComplete(s, e) {

    HideLoadingImage();
    alert(e);
}
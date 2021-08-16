function ButtonSave_AdminSettings_onClick() {
    var fromDateCount = TextBoxFromDateCount_AdminSettings.GetText();
    var fromDateType = ComboBoxFromDateType_AdminSettings.GetSelectedItem().value;
    var endDateCount = TextBoxEndDateCount_AdminSettings.GetText();
    var endDateType = ComboBoxEndDateType_AdminSettings.GetSelectedItem().value;
    var supplement = CheckBoxSupplement_AdminSettings.GetChecked();
    var maxCountReserve = TextBoxMaxCountReserve_AdminSettings.GetText();

    var obj = '{"FDCount":"' + fromDateCount + '","FDType":"' + fromDateType + '", "EDCount":"' + endDateCount + '", "EDType":"' + endDateType + '", "Supplement":"' + supplement + '", "MaxReserve":"' + maxCountReserve + '"}';
    CallbackUpdateSetting_AdminSettings.PerformCallback(obj);
    ShowLoadingImage('tdSaveButton_AdminSettings');
}

function CallbackUpdateSetting_AdminSettings_callbackComplete(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);

            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function CallbackUpdateSetting_AdminSettings_callbackError(e) {
    HideLoadingImage();
    alert(e.result);
}
function ShowLoadingImage(InputControl) {
    document.getElementById('divImgLoading').style.visibility = 'visible';
    var offsetdivHeaderMenu = $("#" + InputControl).offset();
    $("#divImgLoading").css({ position: "absolute", left: 50 + "%", top: offsetdivHeaderMenu.top });
}
function HideLoadingImage() {
    document.getElementById('divImgLoading').style.visibility = 'hidden';
}
function ButtonSavePublicMessage_AdminSettings_onClick() {
    var message = TextBoxMessage_AdminSettings.GetText();
    CallbackUpdatePublicMessage_AdminSettings.PerformCallback(message);
    ShowLoadingImage('tdSavePublicMessage_AdminSettings');
}
function CallbackUpdatePublicMessage_AdminSettings_callbackComplete(e) {
    HideLoadingImage();
    var RetMessage = eval('(' + e.result + ')');
    var type = RetMessage.Type;
    var message = RetMessage.Message;
    switch (type) {
        case 'Success':
            alert(message);

            break;
        case 'Error':
            alert(message);
            break;
        default:

    }
}
function CallbackUpdatePublicMessage_AdminSettings_callbackError(e) {
    HideLoadingImage();
    alert(e.result);
}
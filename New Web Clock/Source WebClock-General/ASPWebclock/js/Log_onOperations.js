
function SearchFieldItems(e) {
    var ComboVal = ComboBoxSearchField.lastSuccessValue;

    switch (ComboVal) {
        case 'Status':
            LabelSearchKey.SetVisible(true);
            TextBoxSearchKey.SetVisible(false);
            ComboBoxAction.SetVisible(false);
            ComboBoxStatus.SetVisible(true);
            break;
        case 'Action':
            LabelSearchKey.SetVisible(true);
            TextBoxSearchKey.SetVisible(false);
            ComboBoxAction.SetVisible(true);
            ComboBoxStatus.SetVisible(false);
            break;
        case 'Nothing':
            LabelSearchKey.SetVisible(false);
            TextBoxSearchKey.SetVisible(false);
            ComboBoxAction.SetVisible(false);
            ComboBoxStatus.SetVisible(false);
            break;
        default:
            LabelSearchKey.SetVisible(true);
            TextBoxSearchKey.SetVisible(true);
            ComboBoxAction.SetVisible(false);
            ComboBoxStatus.SetVisible(false);
            break;
    }
}

function CallBackError(e)
{
    alert('ارتباط با سرور قطع شده ، لطفا مجدد سعی کنید');
}

function ButtonShow_onClick(e) {
    State = "show";
    var SearchField = ComboBoxSearchField.lastSuccessValue;
    var SearchValue = '';
    switch (SearchField) {
        case 'Status':
            SearchValue = ComboBoxStatus.lastSuccessValue;
            break;
        case 'Action':
            SearchValue = ComboBoxAction.lastSuccessValue;
            break;
        default:
            SearchValue = TextBoxSearchKey.GetText();
            break;

    }
    var FromDate = document.getElementById('ASPxRoundPanel1_FromDate').value;
    var ToDate = document.getElementById('ASPxRoundPanel1_ToDate').value;
    var StrSearchField = '{"SearchField":"' + SearchField + '","SearchValue":"' + SearchValue + '","FromDate":"' + FromDate + '","ToDate":"' + ToDate + '","State":"'+ State +'"}';
    GridViewLog.PerformCallback(StrSearchField);

}
function OnAllCheckedChanged(s, e) {

    if (s.GetChecked())

        GridViewLog.SelectAllRowsOnPage();

    else

        GridViewLog.UnselectAllRowsOnPage();
}

function ButtonDelete_Click(e) {
    State = "delete";
    var SearchField = ComboBoxSearchField.lastSuccessValue;
    var SearchValue = '';
    switch (SearchField) {
        case 'Status':
            SearchValue = ComboBoxStatus.lastSuccessValue;
            break;
        case 'Action':
            SearchValue = ComboBoxAction.lastSuccessValue;
            break;
        default:
            SearchValue = TextBoxSearchKey.GetText();
            break;
    }
    var FromDate = document.getElementById('ASPxRoundPanel1_FromDate').value;
    var ToDate = document.getElementById('ASPxRoundPanel1_ToDate').value;
    var StrSearchField = '{"SearchField":"' + SearchField + '","SearchValue":"' + SearchValue + '","FromDate":"' + FromDate + '","ToDate":"' + ToDate + '","State":"' + State + '"}';
    GridViewLog.PerformCallback(StrSearchField);
}

function GridViewLog_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}
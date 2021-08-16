

function HyperLinkPersonRequestWaitAll_onClick() {
    ShowTabPage('operation/Dashbord.aspx', '?date=all&Filter=UnderView');
}
function HyperLinkPersonRequestsWait_onClick() {
    ShowTabPage('operation/Dashbord.aspx', '?date=selected&Filter=UnderView');
}
function HyperLinkPersonRequestsConfirm_onClick() {
    ShowTabPage('operation/Dashbord.aspx', '?date=selected&Filter=Confirm');
}
function HyperLinkPersonRequestsReject_onClick() {
    ShowTabPage('operation/Dashbord.aspx', '?date=selected&Filter=Reject');
}
function ShowTabPage(name,query) {
    var frame = '<iframe id="PageControlFrame';
    

    var tab = parent.PageControl.GetTabByName(name);
    tab.SetVisible(true);

    switch (name) {
        case 'report/DevMonthlyReport.aspx':
            var widthSize = 'width = "1800px"';
            break;
        case 'operation/Dashbord.aspx':
            var widthSize = 'width = "1800px"';
            break;
        case 'operator/TrafficRequestOperator.aspx':
            var widthSize = 'width = "1000px"';
            break;

        default:
            var widthSize = 'width = "1000px"';
    }
    parent.PageControl.SetTabContentHTML(tab, frame.concat(name, '" src="', name + query, '" scrolling="no" frameborder="0" ' + widthSize + ' height="1500px"></iframe>'));
    parent.PageControl.SetActiveTab(tab);
}
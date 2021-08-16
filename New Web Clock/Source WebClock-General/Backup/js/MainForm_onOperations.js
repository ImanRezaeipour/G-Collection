function NavbarClicked(s, e) {
    var frame = '<iframe id="PageControlFrame';
    var name = e.item.name;
   
    var tab = PageControl.GetTabByName(name);
    tab.SetVisible(true);

    switch (e.item.name) {
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
    PageControl.SetTabContentHTML(tab, frame.concat(name, '" src="', e.item.name, '" scrolling="no" frameborder="0" ' + widthSize + ' height="1500px"></iframe>'));
    PageControl.SetActiveTab(tab);
}

function CloseTabPage() {
    var tab = PageControl.GetActiveTab();
    tab.SetVisible(false);
}
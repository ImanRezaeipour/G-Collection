function NavbarClicked(s, e) {
    var frame = '<iframe id="PageControlFrame';
    var name = e.item.name;
   
    var tab = PageControl.GetTabByName(name);
    tab.SetVisible(true);
    switch (e.item.name) {
        case '../Admin/Log.aspx':
            var widthSize = 'width = "1000px"';
            var heighSize = ' height="1000px" '
            break;
        
        default:
            var widthSize = ' width = "1000px" ';
            var heighSize = ' height="1500px" '
    }
    PageControl.SetTabContentHTML(tab, frame.concat(name, '" src="', e.item.name, '" scrolling="no" frameborder="0" ' + widthSize + heighSize + '></iframe>'));
    PageControl.SetActiveTab(tab);
}

function CloseTabPage() {
    var tab = PageControl.GetActiveTab();
    tab.SetVisible(false);
}
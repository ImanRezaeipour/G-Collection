function NavbarClicked(s, e) {
    var frame = '<iframe id="PageControlFrame';
    var name = e.item.name;
   
    var tab = PageControl.GetTabByName(name);
    tab.SetVisible(true);
    PageControl.SetTabContentHTML(tab, frame.concat(name, '" src="', e.item.name, '" scrolling="no" frameborder="0" width="1000px" height="1000px"></iframe>'));
    PageControl.SetActiveTab(tab);
}

function CloseTabPage() {
    var tab = PageControl.GetActiveTab();
    tab.SetVisible(false);
}
function NavBarMain_ContentPage_onClick(s, e) {
    var frame = '<iframe id="PageControlFrame';
    var name = e.item.name;

    var tab = PageControlContent_ContentPage.GetTabByName(name);
    tab.SetVisible(true);

    switch (e.item.name) {
       

        default:
            var widthSize = 'width = "1000px"';
    }
    PageControlContent_ContentPage.SetTabContentHTML(tab, frame.concat(name, '" src="', e.item.name, '" scrolling="no" frameborder="0" ' + widthSize + ' height="1500px"></iframe>'));
    PageControlContent_ContentPage.SetActiveTab(tab);
}

function CloseTabPage() {
    var tab = PageControlContent_ContentPage.GetActiveTab();
    tab.SetVisible(false);
}
function ImageExitTab_ContentPage_onClick() {
    t = setTimeout('CloseTabPage()', 1)
}
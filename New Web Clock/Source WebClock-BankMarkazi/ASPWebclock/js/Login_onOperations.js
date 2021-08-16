var State = "";
function disableBack() {
    window.history.forward(1);
}

function CheckReferer() {
    if (this.location.href != '' && this.location.href.indexOf('.aspx') >= 0 && this.location.href.indexOf('MainForm.aspx') < 0) {
        if (parent.window == this.window)
            return;
        var parentWindow = parent.window;
        while (true) {
            //if (parentWindow.document.getElementById('masterPageForm') != null) {
            if (parentWindow.location.href.indexOf('MainForm.aspx') >= 0) {
                parentWindow.location = 'Login.aspx';
                break;
            }
            else
                parentWindow = parentWindow.parent;
        };
    }
    if (this.location.href != '' && this.location.href.indexOf('.aspx') >= 0 && this.location.href.indexOf('AdminMain.aspx') < 0) {
        if (parent.window == this.window)
            return;
        var parentWindow = parent.window;
        while (true) {
            //if (parentWindow.document.getElementById('masterPageForm') != null) {
            if (parentWindow.location.href.indexOf('AdminMain.aspx') >= 0) {
                parentWindow.location = 'Login.aspx';
                break;
            }
            else
                parentWindow = parentWindow.parent;
        };
    }
}

function Login_onPageLoad() {
    disableBack();
    CheckReferer();
}
function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_Login':
            LoadHelpPage('Login');

            break;
        default:

    }
}



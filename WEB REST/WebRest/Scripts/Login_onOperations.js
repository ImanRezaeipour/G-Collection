
function disableBack() {
    window.history.forward(1);
}

function CheckReferer() {
    if (this.location.href != '' && this.location.href.indexOf('.aspx') >= 0 && this.location.href.indexOf('ContentPage.aspx') < 0) {
        if (parent.window == this.window)
            return;
        var parentWindow = parent.window;
        while (true) {

            if (parentWindow.location.href.indexOf('ContentPage.aspx') >= 0) {
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
    tid = setInterval(mycode, 100);
}
//function onItemMenuHeaderClick(itemSelected) {
//    var nameItem = itemSelected.item.name;
//    switch (nameItem) {

//        case 'Help_Login':
//            LoadHelpPage('Login');

//            break;
//        default:

//    }
//}



var tid;
var countCharMessage = 0;

function mycode() {
    
    var message = document.getElementById('HiddenFieldPublicMessage').value.substring(0, countCharMessage);
    document.getElementById('lblPublicMessage_AdminSettings').innerHTML = message;
    countCharMessage = countCharMessage + 1;
    if (document.getElementById('HiddenFieldPublicMessage').value.length == countCharMessage) {
        abortTimer();
        
    }
    // no need to recall the function (it's an interval, it'll loop forever)
}
function repeatcode() {
    
    setInterval(mycode, 100);
    
}
function abortTimer() { // to be called when you want to stop the timer
    clearInterval(tid);
    
}
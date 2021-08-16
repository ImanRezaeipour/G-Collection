function LoadHelpPage(formKeyHelp) {

    window.open("../Help.aspx?formKeyHelp=" + formKeyHelp, "help", "width=1024,heigth=650,menubar=yes,resizable=yes")
}
function Loadtree() {
    var fromKey = document.getElementById('hf_TreeViewFormKey_HelpForm').value;


    CallBack_TreeViewHelpForm_HelpForm.PerformCallback(fromKey);
}
function CallBack_TreeViewHelpForm_HelpForm_onCallbackComplete() {
    LoadContentHelp(document.getElementById('hf_TreeViewFormKey_HelpForm').value);
}
function TreeViewHelpForm_HelpForm_onNodeSelect(e) {
    LoadContentHelp(e.node.name);
    
    
}
function LoadContentHelp(formKey) {
    
    $("#divContentHelp_HelpForm").slideUp(1000, function () {
        document.getElementById('HelpForm_iFrame').src = "HelpContent.aspx?formKeyHelp=" + formKey + '&dt=' + (new Date()).getTime();
    });
    $("#divContentHelp_HelpForm").slideDown(1000);
}


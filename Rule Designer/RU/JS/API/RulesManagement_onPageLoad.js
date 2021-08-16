
$(document).ready(
 function () {
     document.body.dir = document.RulesManagementForm.dir;
     SetWrapper_Alert_Box(document.RulesManagementForm.id);
     //GetBoxesHeaders_Rules();
     SetActionMode_Rules('View');
     SetPageIndex_GridRules_Rules(0);
 });
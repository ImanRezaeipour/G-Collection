
$(document).ready(
 function () {
     document.body.dir = document.ConceptsManagement.dir;
     SetWrapper_Alert_Box(document.ConceptsManagement.id);
     //GetBoxesHeaders_Concepts();
     SetActionMode_Concepts('View');
     SetPageIndex_GridConcepts_Concepts(0);
     SetEnumTypes();
 });
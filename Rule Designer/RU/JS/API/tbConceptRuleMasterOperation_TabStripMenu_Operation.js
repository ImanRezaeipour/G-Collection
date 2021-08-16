
function tlbItemExit_TlbConceptRuleMasteOperation() {
    ShowDialogConfirm();
}

function ShowDialogConfirm() {
    document.getElementById('lblConfirm').innerHTML = document.getElementById('hfCloseMessage_ConceptRuleMasteOperation').value;
    DialogConfirm.Show();
}

function tlbItemOk_TlbOkConfirm_onClick() {
    parent.CloseCurrentTabOnTabStripMenus();
}

function tlbItemCancel_TlbCancelConfirm_onClick() {
    DialogConfirm.Close();
}

function tlbItemConcepts_TlbConcepts_ConceptRuleMasterOperation_onClick() {
    ShowDialogConceptsManagement();
}

function ShowDialogConceptsManagement() {
    parent.DialogConceptsManagement.Show();
}

function tlbItemRules_TlbRules_ConceptRuleMasterOperation_onClick() {
    ShowDialogRulesManagements();
}

function ShowDialogRulesManagements() {
    parent.DialogRulesManagement.Show();
}

function tlbItemFormReconstruction_TlbConceptRuleMasteOperation_onClick() {
    parent.DialogLoading.Show();
    parent.document.getElementById('pgvConceptRuleMasteOperationReport_iFrame').src = 'ConceptRuleMasteOperation.aspx';
}

function tlbItemHelp_TlbConceptRuleMasteOperation_onClick() {
    LoadHelpPage('tlbItemHelp_TlbConceptRuleMasteOperation');
}

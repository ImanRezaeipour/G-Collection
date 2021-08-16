function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_AdminAccessRoleNavbar':
            parent.LoadHelpPage('AdminAccessRoleNavbar');

            break;
        default:

    }
}

function GridViewAccessRoleNavbar_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}
function GridViewAccessControls_EndCallback(s, e) {
    if (s.cpError != undefined) {
        alert(s.cpError);
        s.cpError = undefined;
    }
}
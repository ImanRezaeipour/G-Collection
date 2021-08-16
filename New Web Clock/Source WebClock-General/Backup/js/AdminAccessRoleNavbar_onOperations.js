function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_AdminAccessRoleNavbar':
            parent.LoadHelpPage('AdminAccessRoleNavbar');

            break;
        default:

    }
}
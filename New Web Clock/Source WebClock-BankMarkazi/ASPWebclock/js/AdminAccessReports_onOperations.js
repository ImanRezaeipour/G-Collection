function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_AdminAccessReports':
            parent.LoadHelpPage('AdminAccessReports');

            break;
        default:

    }
}
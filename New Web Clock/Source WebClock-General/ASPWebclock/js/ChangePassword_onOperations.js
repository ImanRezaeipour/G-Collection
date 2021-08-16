function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_ChangePassword':
            parent.LoadHelpPage('ChangePasswordUser');

            break;
        default:

    }
}
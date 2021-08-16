function onItemMenuHeaderClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {

        case 'Help_SelectPost':
            LoadHelpPage('SelectPost');

            break;
        default:

    }
}
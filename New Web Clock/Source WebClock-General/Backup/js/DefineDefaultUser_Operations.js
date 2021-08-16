var objStatusPage = 'View';
function CheckBoxWithUser_onCheckedChanged(value) {
    objStatusPage = 'View';
    var status = CheckBoxWithUser.GetChecked();
    GridViewDefaultUser.PerformCallback(value + status);
}
function CheckBoxNoUser_onCheckedChanged(value) {
    objStatusPage = 'View';
    var status = CheckBoxNoUser.GetChecked();
    GridViewDefaultUser.PerformCallback(value + status);
    
}
function onItemMenuClick(itemSelected) {
    var nameItem = itemSelected.item.name;
    switch (nameItem) {
        case 'Save':
            if (confirm('آیا از ایجاد نام کاربری پیش فرض برای پرسنل انتخاب شده اطمینان دارید؟') == true) {

            }
            else {
                itemSelected.processOnServer = false;
            }

            break;
        case 'Help_DefineDefultUser':
            parent.LoadHelpPage('DefineDefultUser');
            itemSelected.processOnServer = false;
            break;
        default:

    }
}
function GridViewDefaultUser_EndCallback(e) {
}
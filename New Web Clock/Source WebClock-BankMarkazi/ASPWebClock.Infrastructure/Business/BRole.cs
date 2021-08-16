using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Repository;
using System.Data;
using System.Collections.Specialized;

namespace ASPWebClock.Infrastructure.Business
{
   public class BRole
    {
        public IList<Role> GetAllRoles()
        {
            return (new RoleRepositpry().GetAllRoles());
        }
        public DataTable GetAllNavbar()
        {
            return (new RoleRepositpry().GetAllNavbar());
        }
        public DataTable GetAccessRoleNavbar()
        {
            return (new RoleRepositpry().GetAccessRoleNavbar());
        }
        public DataTable GetAccessControls(string navbarName)
        {
            return (new RoleRepositpry().GetAccessControls(navbarName));
        }
        public bool DeleteAccessRoleNavbar(string roleName)
        { 
        return (new RoleRepositpry().DeleteAccessRoleNavbar(roleName));
        }
        public string InsertAccessRoleNavbar(string roleName, Dictionary<string, bool> dicNavBatName)
        {
            return (new RoleRepositpry().InsertAccessRoleNavbar(roleName,dicNavBatName));
        }
        public string InsertAccessControls(string controlName, Dictionary<string, bool> dicControlName)
        {
            return (new RoleRepositpry().InsertAccessControls(controlName,dicControlName));
        }
        public DataTable GetAccessRoleNavbarByUserRoleName(string roleName)
        {
            return (new RoleRepositpry().GetAccessRoleNavbarByUserRoleName(roleName));
        }
    }
}

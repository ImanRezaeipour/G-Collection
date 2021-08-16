using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Utility;
using System.Data;
using System.Collections.Specialized;
using System.Collections;


namespace ASPWebClock.Infrastructure.Repository
{

   public class RoleRepositpry
    {
        dbConnection connection = new dbConnection();
        logRepository logger = new logRepository();

        public IList<Role> GetAllRoles()
        {
            try
            {
                List<Role> roleList = new List<Role>();

                foreach (PersonStatus item in Enum.GetValues(typeof(PersonStatus)))
                {
                    Role role = new Role();
                    role.ID = (int)item;
                    role.Name = item.ToString();
                    role.Title = new DicStatus().GetTitleStatus(item.ToString());
                    roleList.Add(role);
                }
                var orderedRoleList = roleList.OrderBy(o => o.Title).ToList();
                return orderedRoleList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دریافت قوانین  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت قوانین");
            }


        }
        public DataTable GetAllNavbar()
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select navbar_ID,navbar_Name,navbar_Title from NW_webNavbar order by navbar_Title";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت اطلاعات منو");
                }
                return dtResult;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی منو  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت اطلاعات منو");
            }


        }
        public Navbar GetNavbarByName(string nameNavbar)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select navbar_ID,navbar_Name,navbar_Title,navbar_ParentName from NW_webNavbar where (navbar_Name=@name)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter nameParam = new SqlParameter("@name", nameNavbar);
                paramArray[0] = nameParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت اطلاعات منو");
                }
                Navbar navbarObj = null;
                if (dtResult.Rows.Count > 0)
                {
                    navbarObj = new Navbar();
                    navbarObj.navbar_ID = Convert.ToDecimal(dtResult.Rows[0]["navbar_ID"] == DBNull.Value ? 0 : dtResult.Rows[0]["navbar_ID"]);
                    navbarObj.navbar_Name = dtResult.Rows[0]["navbar_Name"] == DBNull.Value ? "" : dtResult.Rows[0]["navbar_Name"].ToString();
                    navbarObj.navbar_ParentName = dtResult.Rows[0]["navbar_ParentName"] == DBNull.Value ? "" : dtResult.Rows[0]["navbar_ParentName"].ToString();
                    navbarObj.navbar_Title = dtResult.Rows[0]["navbar_Title"] == DBNull.Value ? "" : dtResult.Rows[0]["navbar_Title"].ToString();
                }
                return navbarObj;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی منو  {0} با name=، متن پیغام {1}.خطا", nameNavbar, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت اطلاعات منو");
            }


        }
        public WebControl GetControlByName(string nameControl)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "SELECT Ctrl_ID,Ctrl_Name,Ctrl_Title,Ctrl_NavbarName FROM NW_WebControl where Ctrl_Name=@name";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter nameParam = new SqlParameter("@name", nameControl);
                paramArray[0] = nameParam;
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت اطلاعات کنترل");
                }
                WebControl webControlObj = null;
                if (dtResult.Rows.Count > 0)
                {
                    webControlObj = new WebControl();
                    webControlObj.Ctrl_ID = Convert.ToDecimal(dtResult.Rows[0]["Ctrl_ID"] == DBNull.Value ? 0 : dtResult.Rows[0]["Ctrl_ID"]);
                    webControlObj.Ctrl_Name = dtResult.Rows[0]["Ctrl_Name"] == DBNull.Value ? "" : dtResult.Rows[0]["Ctrl_Name"].ToString();
                    webControlObj.Ctrl_NavbarName = dtResult.Rows[0]["Ctrl_NavbarName"] == DBNull.Value ? "" : dtResult.Rows[0]["Ctrl_NavbarName"].ToString();
                    webControlObj.Ctrl_Title = dtResult.Rows[0]["Ctrl_Title"] == DBNull.Value ? "" : dtResult.Rows[0]["Ctrl_Title"].ToString();
                }
                return webControlObj;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی کنترل  {0} با name=، متن پیغام {1}.خطا", nameControl, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت اطلاعات کنترل");
            }


        }
        public DataTable GetControlsByNavbarName(string navbarName)
        {
            try
            {
                System.Data.DataTable dtResult = new System.Data.DataTable();
                string commandText = "select Ctrl_ID,Ctrl_Name,Ctrl_Title from NW_webControl where (Ctrl_NavbarName='" + navbarName + "') order by Ctrl_Title";
                SqlParameter[] paramArray = new SqlParameter[0];
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                //*********************
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در دریافت کنترول های منو");
                }
                return dtResult;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName=Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی کنترول های منو  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دریافت کنترول های منو");
            }


        }
        public bool DeleteAccessRoleNavbar(string navbarName)
        {
            try
            {
               
                string commandText = "delete from NW_webAssignRoleNavbar where (navbar_Name=@navbar_Name)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter roleNameParam = new SqlParameter("@navbar_Name", navbarName);
                paramArray[0] = roleNameParam;
                bool  result = connection.executeDeleteQuery(commandText, paramArray);
                //*********************
               
                return result;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در حذف کردن دسترسی های منو  {0}، متن پیغام {1}.خطا", navbarName, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در حذف کردن دسترسی های منو");
            }


        }
        public bool DeleteAccessControls(string ControlName)
        {
            try
            {

                string commandText = "delete from NW_webAssignRoleNavbar where (navbar_Name=@control_Name)";
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter roleNameParam = new SqlParameter("@control_Name", ControlName);
                paramArray[0] = roleNameParam;
                bool result = connection.executeDeleteQuery(commandText, paramArray);
                //*********************

                return result;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Delete";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا حذف دسترسی های کنترل  {0}، متن پیغام {1}.خطا", ControlName, Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا حذف دسترسی های کنترل");
            }


        }
        public bool InsertAccessRoleNavbar(string navbarName,Dictionary<string,bool> dicRoleName)
        {
            try
            {
                bool result = false;
                bool resultDelete = DeleteAccessRoleNavbar(navbarName);
                if (resultDelete == true)
                {
                    IList<Role> dtRole = GetAllRoles();
                    foreach (var item in dicRoleName)
                    {
                        for (int i = 0; i < dtRole.Count; i++)
                        {
                           
                            if (item.Key.ToString()==dtRole[i].Name.ToString())
                            {
                                string commandText = "insert into NW_webAssignRoleNavbar (role_Name,navbar_Name) values (@role_Name,@navbar_Name)";
                                SqlParameter[] paramArray = new SqlParameter[2];
                                SqlParameter roleNameParam = new SqlParameter("role_Name",item.Key.ToString() );
                                SqlParameter navbarParam = new SqlParameter("navbar_Name", navbarName);
                                paramArray[0] = roleNameParam;
                                paramArray[1] = navbarParam;
                                 result = connection.executeInsertQuery(commandText, paramArray);
                               
                            }
                        }
                        
                    }
                    return result;
                    
                    
                    
                }
                else
                {
                    return false;
                }
                //*********************
             
               
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در اضافه کردن قانون به منو  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

            //    (new BaseLog()).Info(string.Format("خطا در واکشی کاربران  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex)));
                throw new MyExceptionHandler("خطا در اضافه کردن قانون به منو");
            }


        }
        public string InsertAccessControls(string controlName, Dictionary<string, bool> dicControlName)
        {
            try
            {
                bool result = false;
                bool resultDelete = DeleteAccessRoleNavbar(controlName);
                if (resultDelete == true)
                {
                    IList<Role> dtRole = GetAllRoles();
                    foreach (var item in dicControlName)
                    {
                        for (int i = 0; i < dtRole.Count; i++)
                        {

                            if (item.Key.ToString() == dtRole[i].Name.ToString())
                            {
                                string commandText = "insert into NW_webAssignRoleNavbar (role_Name,navbar_Name) values (@role_Name,@control_Name)";
                                SqlParameter[] paramArray = new SqlParameter[2];
                                SqlParameter roleNameParam = new SqlParameter("role_Name", item.Key.ToString());
                                SqlParameter controlParam = new SqlParameter("control_Name", controlName);
                                paramArray[0] = roleNameParam;
                                paramArray[1] = controlParam;
                                result = connection.executeInsertQuery(commandText, paramArray);

                            }
                        }

                    }
                    if (result == true)
                    {
                        return "اطلاعات با موفقیت ثبت شد.";
                    }
                    else
                    {
                        return "خطا در ثبت اطلاعات .مجددا سعی نمایید";
                    }


                }
                else
                {
                    return "خطا در ثبت اطلاعات .مجددا سعی نمایید";
                }
                //*********************


            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Insert";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در اضافه کردن کنترول های دسترسی  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در اضافه کردن کنترول های دسترسی");
            }


        }
        public DataTable GetAccessRoleNavbar()
        {
            try
            {

                System.Data.DataTable dtResult = new System.Data.DataTable();
                System.Data.DataTable dtNavbar = new System.Data.DataTable();
                System.Data.DataTable dtRole = new System.Data.DataTable();
                System.Data.DataTable dtTempResult = new System.Data.DataTable();
                SqlParameter[] paramArray = new SqlParameter[0];
                dtNavbar = GetAllNavbar();
                IList<Role> roleList = GetAllRoles();

                dtResult.Columns.Add("navbar_ID");
                dtResult.Columns.Add("navbar_Name");
                dtResult.Columns.Add("navbar_Title");

                for (int i = 0; i < roleList.Count; i++)
                {
                    dtResult.Columns.Add(roleList[i].Name.ToString(), typeof(bool));

                }
                DataColumn[] keyColumn = new DataColumn[1];
                keyColumn[0] = dtResult.Columns["navbar_Name"];
                dtResult.PrimaryKey = keyColumn;
                for (int i = 0; i < dtNavbar.Rows.Count; i++)
                {
                    dtResult.Rows.Add(dtNavbar.Rows[i]["navbar_ID"].ToString(), dtNavbar.Rows[i]["navbar_Name"].ToString(), dtNavbar.Rows[i]["navbar_Title"].ToString());

                }
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    string commandText = "select role_Name,navbar_Name from NW_webAssignRoleNavbar where navbar_Name='" + dtResult.Rows[i]["navbar_Name"].ToString() + "'";
                    dtTempResult = connection.executeSelectQuery(commandText, paramArray);
                    for (int j = 0; j < dtTempResult.Rows.Count; j++)
                    {
                        dtResult.Rows[i][dtTempResult.Rows[j]["Role_Name"].ToString()] = true;
                    }
                    for (int k = 0; k < dtResult.Rows.Count; k++)
                    {
                        for (int l = 0; l < dtResult.Columns.Count; l++)
                        {
                            if (dtResult.Rows[k][l].ToString() == string.Empty)
                                dtResult.Rows[k][l] = false;
                        }
                    }
                }
                
                
                
                
                return dtResult;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در دسترسی به navbar   {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در دسترسی به navbar ");
            }


        }
        public DataTable GetAccessControls(string navbarName)
        {
            try
            {

                System.Data.DataTable dtResult = new System.Data.DataTable();
                System.Data.DataTable dtControls = new System.Data.DataTable();
                System.Data.DataTable dtRole = new System.Data.DataTable();
                System.Data.DataTable dtTempResult = new System.Data.DataTable();
                SqlParameter[] paramArray = new SqlParameter[0];
                dtControls = GetControlsByNavbarName(navbarName);
                IList<Role> roleList = GetAllRoles();

                dtResult.Columns.Add("Ctrl_ID");
                dtResult.Columns.Add("Ctrl_Name");
                dtResult.Columns.Add("Ctrl_Title");

                for (int i = 0; i < roleList.Count; i++)
                {
                    dtResult.Columns.Add(roleList[i].Name.ToString(), typeof(bool));

                }
                DataColumn[] keyColumn = new DataColumn[1];
                keyColumn[0] = dtResult.Columns["Ctrl_Name"];
                dtResult.PrimaryKey = keyColumn;
                for (int i = 0; i < dtControls.Rows.Count; i++)
                {
                    dtResult.Rows.Add(dtControls.Rows[i]["Ctrl_ID"].ToString(), dtControls.Rows[i]["Ctrl_Name"].ToString(), dtControls.Rows[i]["Ctrl_Title"].ToString());

                }
                for (int i = 0; i < dtResult.Rows.Count; i++)
                {
                    string commandText = "select role_Name,navbar_Name from NW_webAssignRoleNavbar where navbar_Name='" + dtResult.Rows[i]["Ctrl_Name"].ToString() + "'";
                    dtTempResult = connection.executeSelectQuery(commandText, paramArray);
                    for (int j = 0; j < dtTempResult.Rows.Count; j++)
                    {
                        dtResult.Rows[i][dtTempResult.Rows[j]["Role_Name"].ToString()] = true;
                    }
                    for (int k = 0; k < dtResult.Rows.Count; k++)
                    {
                        for (int l = 0; l < dtResult.Columns.Count; l++)
                        {
                            if (dtResult.Rows[k][l].ToString() == string.Empty)
                                dtResult.Rows[k][l] = false;
                        }
                    }
                }



                
                return dtResult;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی کنترول های دسترسی  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);

                throw new MyExceptionHandler("خطا در واکشی کنترول های دسترسی");
            }


        }
        public DataTable GetAccessRoleNavbarByUserRoleName(string roleName)
        {
            try
            {

                System.Data.DataTable dtResult = new System.Data.DataTable();
                
                SqlParameter[] paramArray = new SqlParameter[1];
                SqlParameter rolNameParam = new SqlParameter("@role_Name", roleName);
                paramArray[0] = rolNameParam;
                string commandText = "select navbar_Name from NW_webAssignRoleNavbar where Role_Name=@role_Name";
                dtResult = connection.executeSelectQuery(commandText, paramArray);
                
                return dtResult;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                Log LogObj = new Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.Comment = string.Format("خطا در واکشی منو قوانین دسترسی به وسیله ی نام قانون کاربر  {0}، متن پیغام {1}.خطا", "", Utility.Utility.GetExecptionMessage(ex));
                bool result = logger.InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در واکشی منو قوانین دسترسی به وسیله ی نام قانون کاربر");

            }


        }
        
    }
}

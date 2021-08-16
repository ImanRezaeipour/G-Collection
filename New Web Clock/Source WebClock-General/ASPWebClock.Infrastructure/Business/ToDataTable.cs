using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;
using System.Web;
using ASPWebClock.Infrastructure.Repository;

namespace ASPWebClock.Infrastructure.Business
{
    class ToDataTable
    {
        public DataTable CreateDataTable(System.Data.Linq.DataContext ctx, object query)
        {
            try
            {
                if (query == null)
                {
                    throw new ArgumentNullException("query");
                }
                IDbCommand cmd = ctx.GetCommand((IQueryable)query);
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                adapter.SelectCommand = (System.Data.SqlClient.SqlCommand)cmd;
                DataTable dt = new DataTable("dataTbl");
                try
                {
                    cmd.Connection.Open();
                    adapter.FillSchema(dt, SchemaType.Source);
                    adapter.Fill(dt);
                }
                finally
                {
                    cmd.Connection.Close();
                }
                return dt;
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
                LogObj.LayerName = Log.LayerNameEnum.Business.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا ددر ساخت جدول  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در ساخت جدول ");
            }
        }
    }
}
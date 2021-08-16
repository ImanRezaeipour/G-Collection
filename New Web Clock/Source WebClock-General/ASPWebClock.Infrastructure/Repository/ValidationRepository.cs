using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using ASPWebClock.Infrastructure.Utility;
using ASPWebClock.Infrastructure.Model;

namespace ASPWebClock.Infrastructure.Repository
{
    public class ValidationRepository
    {
        public int checkSumLeaveHourlyInWeek(int requestValue, string shortMiladiDate, string barcode)
        {
            string sql = "select dbo.WMorHRemain(@requestvalue,@date,@barcode)";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                cmd.Parameters.Add("@date", SqlDbType.VarChar);
                cmd.Parameters.Add("@requestvalue", SqlDbType.Int);
                cmd.Parameters["@barcode"].Value = barcode;
                cmd.Parameters["@date"].Value = shortMiladiDate;
                cmd.Parameters["@requestvalue"].Value = Convert.ToInt32(requestValue);
                try
                {
                    con.Open();
                    int returnvalue = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                    return returnvalue;
                }
                catch (MyExceptionHandler ex)
                {
                    throw ex;
                }
                catch (Exception ex)
                {
                    Log LogObj = new Log();
                    LogObj.Action = "select";
                    LogObj.date = DateTime.Now;
                    LogObj.Status = false;
                    LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                    LogObj.UserName = HttpContext.Current.User.Identity.Name;
                    LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                    LogObj.Comment = string.Format("خطا در چک کردن مرخصی ساعتی  {0}، متن پیغام {1}.خطا",barcode, Utility.Utility.GetExecptionMessage(ex));
                    LogObj.p_barcode = barcode;
                    bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                    throw new MyExceptionHandler("خطا در چک کردن مجوز ساعتی با barcode = "+ barcode);
                }

            }
        }
        public bool CheckPersonHaveTakhirGheirMojaz(string date, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();
                string tableName = "P" + date.Substring(0, 4) + date.Substring(5, 2);
                string sqlQuery = "select Prc_PCode from " + tableName + " where Prc_PCode=@barcode and Prc_Date=@date and Prc_TakhirLessWork<>0";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@date", SqlDbType.VarChar);
                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@date"].Value = date;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    if (dtResult.Rows.Count > 0)
                        return true;
                    else
                        return false;
                }
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
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در چک کردن تاخیز غیرمجاز شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در چک کردن تاخیز غیرمجاز شخص با barcode = " + barcode);
            }

        }
		public int GetFirstInPerson(string date, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();
                string tableName = "P" + date.Substring(0, 4) + date.Substring(5, 2);
                string sqlQuery = "select Prc_FirstIn from " + tableName + " where Prc_PCode=@barcode and Prc_Date=@date and Prc_TakhirLessWork<>0";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@date", SqlDbType.VarChar);
                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@date"].Value = date;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    if (dtResult.Rows.Count > 0)
                        return Convert.ToInt32(dtResult.Rows[0]["Prc_FirstIn"]);
                    else
                        return 0;
                }
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
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت اولین ورود شخص  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت اولین ورود شخص با barcode = " + barcode);
            }

        }
        public int GetValuesMorkhasiEzteraPermitedInMonth(string year, string month, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();
                string tableName = "T" + year + month;
                string sqlQuery = "select clock_barcode,clock_date,clock_time,clock_etime,clock_RecState from " + tableName + " where clock_barcode=@barcode and  clock_RecState=@recState";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@recState", SqlDbType.VarChar);

                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@recState"].Value = 21;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    int sumMorkhasiEzterar = 0;
                    if (dtResult.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtResult.Rows.Count; i++)
                        {
                            sumMorkhasiEzterar += (Convert.ToInt32(dtResult.Rows[i]["clock_etime"]) - Convert.ToInt32(dtResult.Rows[i]["clock_time"]));
                        }
                        return sumMorkhasiEzterar;
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مجوز مرخصی اضطراری در ماه  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز مرخصی اضطراری در ماه با barcode = " + barcode);
            }

        }
        public int GetValuesMorkhasiEzterarRequestedInDateRange(string fromDate, string toDate, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = "select Clock_Date,Clock_Time,Clock_eTime,Clock_RecState,Clock_User from nw_requests where Clock_User=@barcode and  Clock_FirstlyAgree<>2 and Clock_SeconderyAgree<>2 and Clock_FinallyAgree=0 and Clock_RecState=21  and Clock_Date between @firstDayMonth and @endDayMonth";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@firstDayMonth", SqlDbType.VarChar);
                    cmd.Parameters.Add("@endDayMonth", SqlDbType.VarChar);
                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@firstDayMonth"].Value = fromDate;
                    cmd.Parameters["@endDayMonth"].Value = toDate;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    int sumMorkhasiEzterar = 0;
                    if (dtResult.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtResult.Rows.Count; i++)
                        {
                            sumMorkhasiEzterar += (Convert.ToInt32(dtResult.Rows[i]["clock_etime"]) - Convert.ToInt32(dtResult.Rows[i]["clock_time"]));
                        }
                        return sumMorkhasiEzterar;
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت درخواست مرخصی اضطراری در زمان  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت درخواست مرخصی اضطراری در زمان با  barcode = " + barcode);
            }

        }
        public int GetAllRemainLeaveToMonthInMinute(string year, string month, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                string tableName = "p" + year + month;
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();
                //********bank
//                string sqlQuery = @"SELECT 
//                                ((Prc_DayEleaveRemain * (select Rule_MARHR from rules where Rule_Code=
//                                (select P_RuleGroup from persons where P_BarCode=@barcode)) + Prc_HourEleaveRemain)) as RemainLeaveInMinute from " + tableName + @"
//                                where Prc_Date=@date and Prc_PCode=@barcode";
                //********general
                string sqlQuery = @"SELECT 
                                                   ((Prc_HourDayEleaveSalary * (select Rule_MARHR from rules where Rule_Code=
                                                   (select P_RuleGroup from persons where P_BarCode=@barcode)) + Prc_HourDaySleaveSalary)) as RemainLeaveInMinute from " + tableName + @"
                                                   where Prc_Date=@date and Prc_PCode=@barcode";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@date", SqlDbType.VarChar);

                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@date"].Value = year + "/" + month + "/00";

                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return (int)dtResult.Rows[0]["RemainLeaveInMinute"];
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مانده مرخصی در ماه به دقیقه  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مانده مرخصی در ماه به دقیقه با barcode = "+ barcode);
            }

        }
        public int GetSumDailyUsedToDayOfEndMonthInMinute(string year, string month, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();

                string tableNameC = "C" + year + month;

                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = @"select isnull(count(clock_time) * " + GetPersonValueDailyLeaveToMinute(barcode) + @",0)as sumLeaveDaily
                              from " + tableNameC + @"
                              where clock_barcode=@barcode and clock_RecState='41'";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);


                    cmd.Parameters["@barcode"].Value = barcode;


                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return (int)dtResult.Rows[0]["sumLeaveDaily"];
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مرخصی روزانه استفاده شده در ماه به دقیقه  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مرخصی روزانه استفاده شده در ماه به دقیقه با barcode = " + barcode);
            }

        }
        public int GetSumLeaveDailyRequestedInDateRange(string fromDate, string toDate, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = "select isnull((count(*) * " + GetPersonValueDailyLeaveToMinute(barcode) + "),0) as sumReqestedDailyLeave  from nw_requests where Clock_User=@barcode and  Clock_FirstlyAgree<>2 and Clock_SeconderyAgree<>2 and Clock_FinallyAgree=0 and Clock_RecState=41  and Clock_Date between @firstDayMonth and @endDayMonth";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@firstDayMonth", SqlDbType.VarChar);
                    cmd.Parameters.Add("@endDayMonth", SqlDbType.VarChar);
                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@firstDayMonth"].Value = fromDate;
                    cmd.Parameters["@endDayMonth"].Value = toDate;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return (int)dtResult.Rows[0]["sumReqestedDailyLeave"];
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت جمع مرخصی روزانه های درخواست شده  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت جمع مرخصی روزانه های درخواست شده با barcode = " + barcode);
            }

        }
        public int GetSumLeaveHourlyRequestedInDateRange(string fromDate, string toDate, string barcode)
        {

            try
            {
                DataTable dtResult = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = "select Clock_Date,Clock_Time,Clock_eTime,Clock_RecState,Clock_User from nw_requests where Clock_User=@barcode and  Clock_FirstlyAgree<>2 and Clock_SeconderyAgree<>2 and Clock_FinallyAgree=0 and Clock_RecState=21  and Clock_Date between @firstDayMonth and @endDayMonth";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);
                    cmd.Parameters.Add("@firstDayMonth", SqlDbType.VarChar);
                    cmd.Parameters.Add("@endDayMonth", SqlDbType.VarChar);
                    cmd.Parameters["@barcode"].Value = barcode;
                    cmd.Parameters["@firstDayMonth"].Value = fromDate;
                    cmd.Parameters["@endDayMonth"].Value = toDate;
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    int sumHourlyLeave = 0;
                    if (dtResult.Rows.Count > 0)
                    {
                        for (int i = 0; i < dtResult.Rows.Count; i++)
                        {
                            sumHourlyLeave += (Convert.ToInt32(dtResult.Rows[i]["clock_etime"]) - Convert.ToInt32(dtResult.Rows[i]["clock_time"]));
                        }
                        return sumHourlyLeave;
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت جمع مرخصی های ساعتی درخواست شده  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت جمع مرخصی های ساعتی درخواست شده با barcode = " + barcode);
            }

        }
        public int GetSumHourlyUsedToDayOfEndMonthInMinute(string year, string month, string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();

                string tableNameT = "T" + year + month;

                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = @"select isnull(SUM(clock_etime - clock_time),0) as sumLeaveHoury 
                                      from " + tableNameT + @"
                                      where clock_barcode=@barcode and clock_RecState='21'";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);


                    cmd.Parameters["@barcode"].Value = barcode;


                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return (int)dtResult.Rows[0]["sumLeaveHoury"];
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت جمع مرخصی های ساعتی استفاده شده در ماه به دقیقه  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت جمع مرخصی های ساعتی استفاده شده در ماه به دقیقه با barcode = " + barcode);
            }

        }
        public int GetPersonValueDailyLeaveToMinute(string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();



                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = @"select isnull(Rule_MARHR,0) as Rule_MARHR from rules where Rule_Code=(select P_RuleGroup from persons where P_BarCode=@barcode)";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);


                    cmd.Parameters["@barcode"].Value = barcode;


                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);
                    if (dtResult == null)
                    {

                    }
                    if (dtResult.Rows.Count > 0)
                    {

                        return Convert.ToInt32(dtResult.Rows[0]["Rule_MARHR"]);
                    }
                    else
                        return 0;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مجوز مرخصی روزانه به دقیقه  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز مرخصی روزانه به دقیقه با barcode = " + barcode);
            }

        }
        public bool CheckUserIsPermitOverTimeBeforeTime(string barcode)
        {
            try
            {
                DataTable dtResult = new DataTable();



                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = @"select P_BarCode from persons where P_Reserve6=100 and P_BarCode=@barcode";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);


                    cmd.Parameters["@barcode"].Value = barcode;


                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return true;
                    }
                    else
                        return false;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت مجوز اضافه کاری قبل از وقت و بعد از وقت  {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت مجوز اضافه کاری قبل از وقت و بعد از وقت با barcode = " + barcode);
            }

        }
        public bool checkExistTableP(string year,string month)
        {
            try
            {
                DataTable dtResult = new DataTable();

                

                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();

                string sqlQuery = "IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[p" + year + month + "]') AND type in (N'U')) select 'True'  else select 'False'";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {

                        return Convert.ToBoolean(dtResult.Rows[0][0]);
                    }
                    else
                        return false;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("خطا در دریافت اطلاعات از جدول پی  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = "";
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("خطا در دریافت اطلاعات از جدول پی");
            }

        }
        public bool addmojazdatetimepart(string barcode, string mdate)
        {
            try
            {


                DataTable dtResult = new DataTable();

                DataTable dtResult2 = new DataTable();
                DataTable dtResult3 = new DataTable();
                DataTable dtResult4 = new DataTable();
                System.Data.SqlClient.SqlDataAdapter myAdapter = new SqlDataAdapter();
                //تعیین بخش پرسنل
                string sqlQuery = @"select p_parts,p_reserve6 FROM persons where p_barcode=@barcode";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnn"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.Parameters.Add("@barcode", SqlDbType.VarChar);


                    cmd.Parameters["@barcode"].Value = barcode;


                    myAdapter.SelectCommand = cmd;
                    myAdapter.Fill(dtResult);

                    if (dtResult.Rows.Count > 0)
                    {
                        //تعیین درصد مجاز این بخش
                        string PersonPart = dtResult.Rows[0]["p_parts"].ToString();
                        string PersonReserve6 = dtResult.Rows[0]["p_reserve6"].ToString();
                        if (PersonReserve6 == "100")
                            return true;
                        bool FindPart = false;
                        string tempPersonPart = PersonPart;
                        int counter = 0;
                        while (!FindPart)
                        {
                            string sqlQuery2 = @"select eb_percent,eb_part FROM ebank where eb_part=@part
                                             and eb_fdate<=@date and eb_tdate>=@date";
                            SqlCommand cmd2 = new SqlCommand(sqlQuery2, con);
                            cmd2.Parameters.Add("@part", SqlDbType.VarChar);
                            cmd2.Parameters["@part"].Value = tempPersonPart;
                            cmd2.Parameters.Add("@date", SqlDbType.VarChar);
                            cmd2.Parameters["@date"].Value = mdate;


                            myAdapter.SelectCommand = cmd2;
                            myAdapter.Fill(dtResult2);
                            if (dtResult2.Rows.Count > 0)
                                FindPart = true;

                            else
                            {
                                counter++;
                                if (tempPersonPart.Length != 0)
                                    tempPersonPart = tempPersonPart.Substring(0, PersonPart.Length - counter);
                                else
                                    throw new MyExceptionHandler("میزان مجوز بخش پرسنل جهت اضافه کاری بعد از وقت یافت نشد");
                            }
                        }


                        if (dtResult2.Rows.Count > 0)
                        {

                            //    تعيين تعداد افراد مجوز گرفته
                            string tableName = "t" + mdate.Substring(0, 4) + mdate.Substring(5, 2);
                            string PersonPart2 = dtResult2.Rows[0]["eb_part"].ToString();
                            Int16 PercentValid = Convert.ToInt16(dtResult2.Rows[0]["eb_percent"]);
                            string sqlQuery3 = "select count(clock_barcode) as countPerson FROM " + tableName +
                                              @" where clock_barcode in (select p_barcode from persons where P_Parts like @part and p_reserve6<>'100') and clock_recstate= '3' and
                                                ((clock_time>=1080 and clock_time<=1200) or (clock_etime>1080 and clock_etime<=1200) or (clock_time<1080 and clock_etime>1200)) and clock_date=@date ";
                            SqlCommand cmd3 = new SqlCommand(sqlQuery3, con);
                            cmd3.Parameters.Add("@part", SqlDbType.VarChar);
                            cmd3.Parameters["@part"].Value = PersonPart2 + "%";
                            cmd3.Parameters.Add("@date", SqlDbType.VarChar);
                            cmd3.Parameters["@date"].Value = mdate;
                            myAdapter.SelectCommand = cmd3;
                            myAdapter.Fill(dtResult3);
                            if (dtResult3.Rows.Count > 0)
                            {
                                //    تعيين تعداد افراد بخش
                                int countLicensedPerson = (int)dtResult3.Rows[0]["countPerson"];
                                string sqlQuery4 = "select  count(p_parts) as countPersonParts  FROM persons where p_parts like @part and P_IsValid='True'";
                                SqlCommand cmd4 = new SqlCommand(sqlQuery4, con);
                                cmd4.Parameters.Add("@part", SqlDbType.VarChar);
                                cmd4.Parameters["@part"].Value = PersonPart2 + "%";

                                myAdapter.SelectCommand = cmd4;
                                myAdapter.Fill(dtResult4);
                                if (dtResult4.Rows.Count > 0)
                                {
                                    int countPersonPart = (int)dtResult4.Rows[0]["countPersonParts"];
                                    int countPersonPercent = 0;
                                    //گرد کردن اعشار عدد به یک نفر بیشتر
                                    decimal decimalPersonnelPercent = (Convert.ToDecimal(countPersonPart) * Convert.ToDecimal(PercentValid)) / 100;
                                    decimal intPersonnelPercent = Math.Floor((Convert.ToDecimal(countPersonPart) * Convert.ToDecimal(PercentValid)) / 100);
                                    if (decimalPersonnelPercent > intPersonnelPercent && decimalPersonnelPercent < (intPersonnelPercent + 1))
                                    {
                                        countPersonPercent = ((countPersonPart * PercentValid) / 100) + 1;
                                    }
                                    else
                                    {
                                        countPersonPercent = ((countPersonPart * PercentValid) / 100);
                                    }
                                    if ((countLicensedPerson + 1) <= countPersonPercent)
                                    {
                                        return true;
                                    }
                                    else
                                    {
                                        return false;
                                    }
                                }
                                else return false;
                            }
                            else
                                return false;
                        }
                        else
                            return false;

                    }
                    else
                        return false;
                }
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {

                Log LogObj = new Model.Log();
                LogObj.Action = "Select";
                LogObj.date = DateTime.Now;
                LogObj.Status = false;
                LogObj.UserName = HttpContext.Current.User.Identity.Name;
                LogObj.LayerName = Model.Log.LayerNameEnum.Repository.ToString();
                LogObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                LogObj.Comment = string.Format("میزان مجوز بخش پرسنل جهت اضافه کاری بعد از وقت یافت نشد  {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
                LogObj.p_barcode = barcode;
                bool BoolResult = new logRepository().InsertToLogTable(LogObj);
                throw new MyExceptionHandler("میزان مجوز بخش پرسنل جهت اضافه کاری بعد از وقت یافت نشد");
            }
        }

       
    }
}
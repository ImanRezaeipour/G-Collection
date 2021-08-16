using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using ASPWebClock.Infrastructure.Model;
using ASPWebClock.Infrastructure.Business;
using ASPWebClock.Infrastructure.Utility;
using System.Data;
using System.Web;


namespace ASPWebClock.Infrastructure.Repository
{
   public class PersonRepository
    {

       dbConnection connection = new dbConnection();
       logRepository logger = new logRepository();

       public List<Person> GetUnderManagmentPersonnel(decimal webPassID,Person prs,Person prsCurrentUser)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               string commandText = @"SELECT (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family ,p_param
                                        from persons where  P_BarCode in (SELECT (Sub_BarCode) as barcode FROM NW_ManagerPersons(@id) where sub_barcode not in (" + prs.Barcode + ")  union select (p_barcode) as barcode from NW_webpass where (id=@id) and (isAcceptOwner='True'))  order by Barcode";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter webPassIDParam = new SqlParameter("@id",webPassID);
                
               
               paramArray[0] = webPassIDParam;
              
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت پرسنل تحت مدیریت مدیر با ID=" + webPassID);
               }
               List<Person> personList = new List<Person>();
               if (dtResult.Rows.Count > 0)
               {
                   for (int i = 0; i < dtResult.Rows.Count; i++)
			            {
                            Person personObj = new Person();
                            personObj.Barcode = dtResult.Rows[i]["Barcode"].ToString();
                            personObj.Family = dtResult.Rows[i]["Family"].ToString();
                            personObj.Name = dtResult.Rows[i]["Name"].ToString();
                            personObj.Param = Convert.ToInt16(dtResult.Rows[i]["p_param"]==DBNull.Value ? 0 : dtResult.Rows[i]["p_param"]);
                            personList.Add(personObj);
			            }
                 
               }

               return personList;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.UserWebPassID = webPassID;
               logObj.p_barcode = prs.Barcode;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی پرسنل تحت مدیریت {0}، متن پیغام {1}.خطا", webPassID, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);

               throw new MyExceptionHandler("خطا در دریافت پرسنل تحت مدیریت مدیر با ID=" + webPassID);
           }
       }
       public DataTable GetReportMonthlyPerson(string barcode, string tableName)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               
               string commandText = " if object_id('tempdb..#_t') is not null drop table #_t" +
" select * into #_t  from " +
" (SELECT" +
" dbo.PishCardFullName(prc_kind,prc_type) AS PishCardFullName" +
" ,prc_kind AS PishCard, prc_type, Prc_PCode,prc_date,prc_date DateSort" +
" ,dbo.FARSI_WEEK_DAY(prc_date) AS FARSI_WEEK_DAY " +
" ,Prc_AbsenceNaghes as Prc_AbsenceNaghes" +
" ,convert(int,SUBSTRING(Prc_Date, 9, 2)) as NSort" + 
" ,dbo.MToHTaraddod(prc_FirstIn) AS prc_FirstIn, dbo.MToHTaraddod(Prc_FirstOut) AS Prc_FirstOut" +
" ,dbo.MToHTaraddod(Prc_SecondIn)AS Prc_SecondIn,dbo.MToHTaraddod(Prc_SecondOut) AS Prc_SecondOut" +
" ,dbo.MToHTaraddod(Prc_ThirdIn) AS Prc_ThirdIn,dbo.MToHTaraddod(Prc_ThirdOut) AS Prc_ThirdOut" +
" ,dbo.MToHTaraddod(Prc_FourthIn) AS Prc_FourthIn,dbo.MToHTaraddod(Prc_FourthOut) AS Prc_FourthOut" +
" ,dbo.MToHTaraddod(Prc_FifthIn) AS Prc_FifthIn,dbo.MToHTaraddod(Prc_FifthOut) AS Prc_FifthOut" +
" ,dbo.MToH(Prc_PresenceWork) AS HozurEVagheie" +
" ,dbo.MToH(Prc_NormWork) AS HozurELazem" +
" ,dbo.MToH(Prc_keshiktime) as Keshik" +
" ,dbo.MToH(Prc_ValidAddWork) as Ezafehkar" +
" ,dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz" +
" ,dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar" +
" ,dbo.zerotospace(Prc_DayAbsence) AS GheibatRuz" +
" ,dbo.MToH(Prc_HourMission) AS MamHour" +
" ,dbo.zerotospace(Prc_DayMission) AS MamRuz" +
" ,dbo.zerotospace(Prc_DaySleaveSalary) AS  MorDarRuzB " +
" ,dbo.zerotospace(Prc_DayleaveSalary44) AS MorDarRuz" +
" ,dbo.MToH(Prc_HourEleaveSalarysum) AS Ezterar" +
" ,dbo.zerotospace(Prc_DayEleaveSalarypure)AS MorEstRuz" +
" ,dbo.zerotospace(Prc_DayleaveNoSalary) AS MorBiHoghRuz" +
" ,dbo.MToH(Prc_HourleaveSalary27) AS MorSaati" +
" ,Prc_DayeleaveRemain AS DayMandeMorakhasi " +
" ,dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi" +

" FROM " + tableName + 
" WHERE Prc_PCode=@barcode AND " +
" SUBSTRING(Prc_Date, 9, 2) <> '00' ) L40" +
" insert into #_t" +
" SELECT " +
" '' PishCardFullName" +
" ,'' AS PishCard,'' prc_type,'' Prc_PCode,'' Prc_Date, '9999/99/99' AS DateSort" +
" ,'جمع ماه' FARSI_WEEK_DAY" +
" ,Prc_AbsenceNaghes as Prc_AbsenceNaghes" +
" ,1000 as NSort" +
" ,'' AS prc_FirstIn, '' AS Prc_FirstOut" +
" ,'' AS Prc_SecondIn, '' AS Prc_SecondOut" +
" ,'' AS Prc_ThirdIn, '' AS Prc_ThirdOut" +
" ,'' AS Prc_FourthIn, '' AS Prc_FourthOut" +
" ,'' AS Prc_FifthIn, '' AS Prc_FifthOut" +
" ,dbo.MToH(Prc_PresenceWork) AS HozurEVagheie" +
" ,dbo.MToH(Prc_NormWork) AS HozurELazem" +
" ,dbo.MToH(Prc_keshiktime) as Keshik" +
" ,dbo.MToH(Prc_ValidAddWork) as Ezafehkar" +
" ,dbo.MToH(Prc_InvalidAddWork) as EzafehkarGheiremojaz" +
" ,dbo.MToH(Prc_HourAbsence+Prc_HourDayAbsence) AS kasrekar" +
" ,Prc_DayAbsence AS GheibatRuz" +
" ,dbo.MToH(Prc_HourMission) AS MamHour" +
" ,Prc_DayMission AS MamRuz" +
" ,Prc_DaySleaveSalary AS MorDarRuz" +
" ,Prc_DayleaveSalary44 as MorDarRuzB" +
" ,dbo.MToH(Prc_HourEleaveSalarysum) AS Ezterar" +
" ,Prc_DayEleaveSalarypure AS MorEstRuz" +
" ,Prc_DayleaveNoSalary AS MorBiHoghRuz" +
" ,dbo.MToH(Prc_HourleaveSalary27) AS MorSaati" +
" ,Prc_DayeleaveRemain AS DayMandeMorakhasi" +
" ,dbo.MToH(Prc_HourEleaveRemain) AS HourMandeMorakhasi " +

" From " + tableName + " WHERE Prc_PCode=@barcode AND SUBSTRING(Prc_Date, 9, 2) = '00'" +

" if not exists( select prc_secondin from #_t where prc_secondin<>'') update #_t set prc_secondin='2I'" +
" if not exists( select prc_secondout from #_t where prc_secondout<>'') update #_t set prc_secondout='2O'" +
" if not exists( select prc_thirdin from #_t where prc_thirdin<>'') update #_t set prc_thirdin='3I'" +
" if not exists( select prc_thirdout from #_t where prc_thirdout<>'') update #_t set prc_thirdout='3O'" +
" if not exists( select prc_fourthin from #_t where prc_fourthin<>'') update #_t set prc_fourthin='4I'" +
" if not exists( select prc_fourthout from #_t where prc_fourthout<>'') update #_t set prc_fourthout='4O'" +

" if not exists( select prc_fifthin from #_t where prc_fifthin<>'') update #_t set prc_fifthin='5I'" +
" if not exists( select prc_fifthout from #_t where prc_fifthout<>'') update #_t set prc_fifthout='5O'" +


" select * from #_t order by DateSort";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter barcodeParam = new SqlParameter("@barcode", barcode);


               paramArray[0] = barcodeParam;

               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت گزارش کارکرد ماهیانه پرسنل " + barcode);
               }


               return dtResult;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {
               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.UserWebPassID = 0;
               logObj.p_barcode = barcode;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی گزارش کارکرد ماهیانه  پرسنل {0}، متن پیغام {1}.خطا", barcode, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);
               throw new MyExceptionHandler("خطا در دریافت گزارش کارکرد ماهیانه پرسنل " + barcode);
           }
       }
       public DataTable GetUnderManagmentPersonnelTaradodCount(decimal webPassID,string tableName,string dateNow)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               string commandText = @"select * from 
                                    (SELECT MAX(clock_time) As Last_Clock,
	                                    count(clock_time) As clock_count,Clock_BarCode,Clock_Date,P_Name,P_Family 
	                                    ,dbo.FARSI_WEEK_DAY(Clock_Date) AS FARSI_WEEK_DAY FROM " + tableName + @"

                                            join persons on Clock_BarCode=P_BarCode

                                    where clock_barcode in (select sub_barcode from dbo.NW_ManagerPersons(@id))
                                    and clock_date=@date
                                        and clock_chg<='1' 
                                    group by Clock_BarCode,Clock_Date,P_Name,P_Family)result";
               SqlParameter[] paramArray = new SqlParameter[2];
               SqlParameter webPassIDParam = new SqlParameter("@id", webPassID);
               SqlParameter dateParam = new SqlParameter("@date", dateNow);

               paramArray[0] = webPassIDParam;
               paramArray[1] = dateParam;

               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت تعداد تردد پرسنل تحت مدیریت با ID=" + webPassID);
               }


               return dtResult;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {

               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.UserWebPassID = webPassID;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی تعداد تردد پرسنل تحت مدیریت {0}، متن پیغام {1}.خطا", webPassID, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);

               throw new MyExceptionHandler("خطا در دریافت تعداد تردد پرسنل تحت مدیریت با ID=" + webPassID);
           }
       }
       public int GetUnderManagmentPersonnelLeaveDailyCount(decimal webPassID, string tableName,string dateNow)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               string commandText = @"select count(*) as CountPerson from " + tableName + @"  where
                                        Clock_Chg='2' and Clock_BarCode in (select sub_barcode from dbo.NW_ManagerPersons(@id)) and 
                                        (Clock_RecState between 33 and 42)
                                        and clock_date=@date";
               SqlParameter[] paramArray = new SqlParameter[2];
               SqlParameter webPassIDParam = new SqlParameter("@id", webPassID);
               SqlParameter dateParam = new SqlParameter("@date", dateNow);

               paramArray[0] = webPassIDParam;
               paramArray[1] = dateParam;

               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت تعداد مرخصی روزانه پرسنل تخت مدیریت با ID=" + webPassID);
               }


               return (int)dtResult.Rows[0]["CountPerson"];
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {

               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.UserWebPassID = webPassID;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی تعداد مرخصی روزانه پرسنل تحت مدیریت {0}، متن پیغام {1}.خطا", webPassID, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);

               throw new MyExceptionHandler("خطا در دریافت تعداد مرخصی روزانه پرسنل تخت مدیریت با ID=" + webPassID);
           }
       }
       public int GetUnderManagmentPersonnelLeaveHourlyCount(decimal webPassID, string tableName, string dateNow)
       {
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {
               string commandText = @"select count(*) as CountPerson from " + tableName + @"  where
                                        Clock_BarCode in (select sub_barcode from dbo.NW_ManagerPersons(@id)) and 
                                        (Clock_RecState between 11 and 27)
                                        and clock_date=@date";
               SqlParameter[] paramArray = new SqlParameter[2];
               SqlParameter webPassIDParam = new SqlParameter("@id", webPassID);
               SqlParameter dateParam = new SqlParameter("@date", dateNow);

               paramArray[0] = webPassIDParam;
               paramArray[1] = dateParam;

               dtResult = connection.executeSelectQuery(commandText, paramArray);
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت تعداد مرخصی ساعتی پرسنل تخت مدیریت با ID=" + webPassID);
               }


               return (int)dtResult.Rows[0]["CountPerson"];
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {

               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.UserWebPassID = webPassID;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی تعداد مرخصی ساعتی پرسنل تحت مدیریت {0}، متن پیغام {1}.خطا", webPassID, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);

               throw new MyExceptionHandler("خطا در دریافت تعداد مرخصی ساعتی پرسنل تخت مدیریت با ID=" + webPassID);
           }
       }
       public IList<Person> GetAllPersonnel()
       {
          
           System.Data.DataTable dtResult = new System.Data.DataTable();
           try
           {


               string commandText = "select (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family from persons";
               SqlParameter[] paramArray = new SqlParameter[0];
               dtResult = connection.executeSelectQuery(commandText, paramArray);

               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت همه پرسنل.لطفا مجددا سعی نمایید.");
               } List<Person> personList = new List<Model.Person>();
               for (int i = 0; i < dtResult.Rows.Count; i++)
               {
                   Person personObj = new Model.Person() { 
                   Barcode=dtResult.Rows[i]["Barcode"].ToString(),
                   Name = dtResult.Rows[i]["Name"].ToString(),
                   Family = dtResult.Rows[i]["Family"].ToString()
                   };
                   personList.Add(personObj);
               }
               return personList;
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {

               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی همه پرسنل {0}، متن پیغام {1}.خطا", Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
               bool result = logger.InsertToLogTable(logObj);

               throw new MyExceptionHandler("خطا در دریافت همه پرسنل.لطفا مجددا سعی نمایید.");
           }
       }
       public IList<Person> GetPersonByPart(string part)
       {

           DataTable dtResult = new DataTable();
           try
           {


               string commandText = "select (P_BarCode) as Barcode,(P_Name) as Name,(P_Family) as Family from persons where p_parts=@part and P_IsValid='True'";
               SqlParameter[] paramArray = new SqlParameter[1];
               SqlParameter partParam = new SqlParameter("@part", part);
               paramArray[0]=partParam;
               dtResult = connection.executeSelectQuery(commandText, paramArray);
               List<Person> personList = new List<Person>();
               if (dtResult == null)
               {
                   throw new MyExceptionHandler("خطا در دریافت پرسنل با کد بخش " + part);
               }
               else
               {
                   
                   for (int i = 0; i < dtResult.Rows.Count; i++)
                   {
                       Person personObj = new Model.Person() {
                       Barcode=dtResult.Rows[i]["Barcode"].ToString(),
                       Name = dtResult.Rows[i]["Name"].ToString(),
                       Family = dtResult.Rows[i]["Family"].ToString(),
                       };
                       personList.Add(personObj);
                       
                   }

               }
               return personList;

             
           }
           catch (MyExceptionHandler ex)
           {
               throw ex;
           }
           catch (Exception ex)
           {

               Model.Log logObj = new Model.Log();
               logObj.Action = "Select";
               logObj.date = DateTime.Now;
               logObj.UserName = HttpContext.Current.User.Identity.Name;
               logObj.Status = false;
               logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
               logObj.Comment = string.Format("خطا در وا کشی پرسنل پرسنل با پیش کد بخش {0}، متن پیغام {1}.خطا",part, Utility.Utility.GetExecptionMessage(ex));
               logObj.LayerName = Log.LayerNameEnum.Repository.ToString();

               throw new MyExceptionHandler("خطا در دریافت پرسنل با کد بخش " + part);
           }
       }
        public IList<Person> GetPersonBySearchKey(string SearchKey)
        {
            List<Person> personList = new List<Person>();
            System.Data.DataTable dtResult = new System.Data.DataTable();
            try
            {
               
            
            string commandText = "select P_BarCode,P_Name,P_Family from persons where (P_BarCode like @barcode) or (P_Name like @name) or (P_Family like @family) order by P_BarCode";
            SqlParameter[] paramArray = new SqlParameter[3];
            SqlParameter paramBarcode=new SqlParameter("@barcode","%" +  SearchKey + "%");
            SqlParameter paramName=new SqlParameter("@name", "%" + SearchKey + "%");
            SqlParameter paramFamily=new SqlParameter("@family", "%" + SearchKey + "%");
            paramArray[0] = paramBarcode;
            paramArray[1] = paramName;
            paramArray[2] = paramFamily;
            dtResult = connection.executeSelectQuery(commandText, paramArray);
            
                if (dtResult == null)
                {
                    throw new MyExceptionHandler("خطا در جستجوی پرستل .لطفا مجددا سعی نمایید.");
                }
            
       
            
            for (int i = 0; i < dtResult.Rows.Count; i++)
            {
                Person personObj = new Person()
                {
                    Barcode = dtResult.Rows[i]["P_BarCode"].ToString(),
                    Name = dtResult.Rows[i]["P_Name"].ToString(),
                    Family = dtResult.Rows[i]["P_Family"].ToString()
                };
                personList.Add(personObj);
            }
            
               

            
            return personList;
            }
            catch (MyExceptionHandler ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {

                Model.Log logObj = new Model.Log();
                logObj.Action = "Select";
                logObj.date = DateTime.Now;
                logObj.UserName = HttpContext.Current.User.Identity.Name;
                logObj.Status = false;
                logObj.MethodName = System.Reflection.MethodBase.GetCurrentMethod().Name;
                logObj.Comment = string.Format("خطا در وا کشی جستجوی پرسنل {0}، متن پیغام {1}.خطا","", Utility.Utility.GetExecptionMessage(ex));
                logObj.LayerName = Log.LayerNameEnum.Repository.ToString();
                bool result = logger.InsertToLogTable(logObj);
                throw new MyExceptionHandler("خطا در جستجوی پرستل .لطفا مجددا سعی نمایید.");
            }
        }
        
        
        
    }
}

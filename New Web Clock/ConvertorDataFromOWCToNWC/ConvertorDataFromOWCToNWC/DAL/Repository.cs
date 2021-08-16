using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using ConvertorDataFromOWCToNWC.Model;
using Microsoft.SqlServer.Management.Smo;
using Microsoft.SqlServer.Management.Common;



namespace ConvertorDataFromOWCToNWC.DAL
{

    public class Repository
    {
        private string connectionString = string.Empty;
        private SqlConnection sqlConnection = null;
        private SqlCommand myCommand = null;
        public Repository()
        {
            connectionString = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;

        }
        public bool ConnectToDatabase()
        {
            try
            {
                sqlConnection = new SqlConnection(connectionString);
                sqlConnection.Open();
                sqlConnection.Close();


                return true;

            }
            catch (Exception ex)
            {
                return false;

            }
        }
        public bool CreateTablesNewWebClock()
        {
            try
            {
                string scriptCreateTableFilePath = AppDomain.CurrentDomain.BaseDirectory + @"\SqlScripts\ScriptsCreateTables.txt";
                string scriptCreateTablesText = GetScriptTextFromFile(scriptCreateTableFilePath);
                sqlConnection = new SqlConnection(connectionString);
                ServerConnection serverCnn = new ServerConnection(sqlConnection);
                Server server = new Server(serverCnn);
                int result= server.ConnectionContext.ExecuteNonQuery(scriptCreateTablesText);
                

                return true;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        public bool InsertDefaultDataNewWebClock()
        {
            try
            {
               
                sqlConnection = new SqlConnection(connectionString);
                ServerConnection serverCnn = new ServerConnection(sqlConnection);
                Server server = new Server(serverCnn);
                
                string scriptDataTableFilePath = AppDomain.CurrentDomain.BaseDirectory + @"\SqlScripts\ScriptsDataTables.txt";
                string scriptDataTablesText = GetScriptTextFromFile(scriptDataTableFilePath);
                int result2 = server.ConnectionContext.ExecuteNonQuery(scriptDataTablesText);
                

                return true;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        public bool CreateFunctionsNewWebClock()
        {
            try
            {

                sqlConnection = new SqlConnection(connectionString);
                ServerConnection serverCnn = new ServerConnection(sqlConnection);
                Server server = new Server(serverCnn);

                string scriptFunctionsFilePath = AppDomain.CurrentDomain.BaseDirectory + @"\SqlScripts\ScriptsFunctions.txt";
                string scriptFunctionText = GetScriptTextFromFile(scriptFunctionsFilePath);
                int result3 = server.ConnectionContext.ExecuteNonQuery(scriptFunctionText);


                return true;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        private string GetScriptTextFromFile(string filePath)
        {
            try
            {

                System.IO.FileInfo file = new System.IO.FileInfo(filePath);
                string scriptText = file.OpenText().ReadToEnd();
                return scriptText;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public bool ConvertDataFromTbl_WebPassToTbl_NW_Login()
        {
            try
            {
                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string deleteQuery = "delete  from NW_webLogin";
                string query = "select * from webpass";
                
                myCommand.Connection.Open();
                myCommand.CommandText = deleteQuery;
                int resultDelete = myCommand.ExecuteNonQuery();
                myCommand.CommandText = query;
                SqlDataReader reader = myCommand.ExecuteReader();
                List<NW_WebLogin> nw_WebLoginList = new List<NW_WebLogin>();
                while (reader.Read())
                {
                    nw_WebLoginList.Add(ConvertModelWebPassToNW_WebLogin(CreateWebpassObj(reader)));
                }
                for (int i = 0; i < nw_WebLoginList.Count; i++)
                {
                    new GenerateAdoNetQuery().InsertQuery("NW_WebLogin", nw_WebLoginList[i]);
                }
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        public bool ConvertDataFromOldWebClockToNewWebClock()
        {
            try
            {
                ConvertDataFromTbl_WebPassToTbl_NW_Login();
                ConvertDataFromTbl_WebPassToTbl_NW_WebPass();
                ConvertDataFromTbl_WebpassPersonsToTbl_NW_WebpassPersons();
                ConvertDataFromTbl_AgreeToTbl_NW_Agree();
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public bool ConvertDataFromTbl_TCToTbl_NW_Requests(int fromMonth, int fromYear)
        {
            try
            {
                System.Globalization.PersianCalendar ps = new System.Globalization.PersianCalendar();
                int yearNow = ps.GetYear(DateTime.Today);
                int monthNow = ps.GetMonth(DateTime.Today);
                List<NW_Requests> nw_wRequestsList = new List<NW_Requests>();
                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                myCommand.Connection.Open();
                string deleteQuery = "delete  from NW_Requests";
                myCommand.CommandText = deleteQuery;
                int resultDelete = myCommand.ExecuteNonQuery();
                myCommand.Connection.Close();
                for (int i = fromYear; i <= yearNow; i++)
                {
                    for (int j = fromMonth; j <= 12; j++)
                    {
                        string tableName = "tc" + i.ToString() + (j >= 10 ? j.ToString() : "0" + j.ToString());


                       
                        
                        string query = "select * from " + tableName;
                        myCommand = new SqlCommand(query,sqlConnection);
                        
                        myCommand.Connection.Open();
                        SqlDataReader reader = myCommand.ExecuteReader();
                       
                        while (reader.Read())
                        {
                            NW_Requests nw_RequestsObj = ConvertModelTCToNW_Requests(CreateTCObj(reader));
                            if (nw_RequestsObj.WebPassId > 0)
                            {
                                nw_wRequestsList.Add(nw_RequestsObj);
                            }
                        }
                        myCommand.Connection.Close();
                    }
                }
                for (int i = 0; i < nw_wRequestsList.Count; i++)
                {
                    new GenerateAdoNetQuery().InsertQuery("NW_Requests", nw_wRequestsList[i]);
                }
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        public bool ConvertDataFromTbl_AgreeToTbl_NW_Agree()
        {
            try
            {
                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string deleteQuery = "delete  from NW_Agree";
                string query = "select * from agree";
                
                myCommand.Connection.Open();
                myCommand.CommandText = deleteQuery;
                int resultDelete = myCommand.ExecuteNonQuery();
                myCommand.CommandText = query;
                SqlDataReader reader = myCommand.ExecuteReader();
                List<NW_Agree> nw_webpassPersonsList = new List<NW_Agree>();
                while (reader.Read())
                {
                    NW_Agree nw_webpassPersonsObj = ConvertModelAgreeToNW_Agree(CreateAgreeObj(reader));
                    if (nw_webpassPersonsObj.WebPassId > 0)
                    {
                        nw_webpassPersonsList.Add(nw_webpassPersonsObj);
                    }
                }
                for (int i = 0; i < nw_webpassPersonsList.Count; i++)
                {
                    new GenerateAdoNetQuery().InsertQuery("NW_Agree", nw_webpassPersonsList[i]);
                }
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        public bool ConvertDataFromTbl_WebpassPersonsToTbl_NW_WebpassPersons()
        {
            try
            {
                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string deleteQuery = "delete  from NW_webpasspersons";
                string query = "select * from webpasspersons";
                
                myCommand.Connection.Open();
                myCommand.CommandText = deleteQuery;
                int resultDelete = myCommand.ExecuteNonQuery();
                myCommand.CommandText = query;
                SqlDataReader reader = myCommand.ExecuteReader();
                List<NW_WebpassPersons> nw_webpassPersonsList = new List<NW_WebpassPersons>();
                while (reader.Read())
                {
                    NW_WebpassPersons nw_webpassPersonsObj = ConvertModelWebpassPersonsToNW_WebpassPersons(CreateWebpassPersonsObj(reader));
                    if (nw_webpassPersonsObj.WebPassId > 0)
                    {
                        nw_webpassPersonsList.Add(nw_webpassPersonsObj);
                    }
                }
                for (int i = 0; i < nw_webpassPersonsList.Count; i++)
                {
                    new GenerateAdoNetQuery().InsertQuery("NW_Webpasspersons", nw_webpassPersonsList[i]);
                }
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }

        public bool ConvertDataFromTbl_WebPassToTbl_NW_WebPass()
        {
            try
            {
                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string deleteQuery = "delete  from NW_webpass";
                string query = "select * from webpass";
                
                myCommand.Connection.Open();
                myCommand.CommandText = deleteQuery;
                int resultDelete = myCommand.ExecuteNonQuery();
                myCommand.CommandText = query;
                SqlDataReader reader = myCommand.ExecuteReader();
                List<NW_Webpass> nw_WebpassList = new List<NW_Webpass>();

                while (reader.Read())
                {

                    nw_WebpassList.AddRange(ConvertModelWebpassToNW_Webpass(CreateWebpassObj(reader)));

                }
                for (int i = 0; i < nw_WebpassList.Count; i++)
                {
                    new GenerateAdoNetQuery().InsertQuery("NW_Webpass", nw_WebpassList[i]);
                }
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }

        private Webpass CreateWebpassObj(SqlDataReader reader)
        {
            try
            {
                Webpass webPassObj = new Webpass();
                webPassObj.AgreeAddWork = Convert.ToBoolean(reader["AgreeAddWork"] == DBNull.Value ? false : reader["AgreeAddWork"]);
                webPassObj.AgreeOverTime = Convert.ToBoolean(reader["AgreeOverTime"] == DBNull.Value ? false : reader["AgreeOverTime"]);
                webPassObj.HasInsteadMan = Convert.ToBoolean(reader["HasInsteadMan"] == DBNull.Value ? false : reader["HasInsteadMan"]);
                webPassObj.HasMailServer = Convert.ToBoolean(reader["HasMailServer"] == DBNull.Value ? false : reader["HasMailServer"]);
                webPassObj.Haspart = Convert.ToBoolean(reader["Haspart"] == DBNull.Value ? false : reader["Haspart"]);
                webPassObj.Hasperson = Convert.ToBoolean(reader["Hasperson"] == DBNull.Value ? false : reader["Hasperson"]);
                webPassObj.HostName = (reader["HostName"] == DBNull.Value ? "" : reader["HostName"]).ToString();
                webPassObj.InsteadMan = (reader["InsteadMan"] == DBNull.Value ? "" : reader["InsteadMan"]).ToString();
                webPassObj.isAcceptOwner = Convert.ToBoolean(reader["isAcceptOwner"] == DBNull.Value ? false : reader["isAcceptOwner"]);
                webPassObj.isSaveAccept = Convert.ToBoolean(reader["isSaveAccept"] == DBNull.Value ? false : reader["isSaveAccept"]);
                webPassObj.MaxOverTime = Convert.ToInt32(reader["MaxOverTime"] == DBNull.Value ? 0 : reader["MaxOverTime"]);
                webPassObj.MaxTimeReq = Convert.ToInt32(reader["MaxTimeReq"] == DBNull.Value ? 0 : reader["MaxTimeReq"]);
                webPassObj.p_barcode = (reader["p_barcode"] == DBNull.Value ? "" : reader["p_barcode"]).ToString();
                webPassObj.p_part1 = Convert.ToInt32(reader["p_part1"] == DBNull.Value ? 0 : reader["p_part1"]);
                webPassObj.p_part2 = Convert.ToInt32(reader["p_part2"] == DBNull.Value ? 0 : reader["p_part2"]);
                webPassObj.p_part3 = Convert.ToInt32(reader["p_part3"] == DBNull.Value ? 0 : reader["p_part3"]);
                webPassObj.p_part4 = Convert.ToInt32(reader["p_part4"] == DBNull.Value ? 0 : reader["p_part4"]);
                webPassObj.p_pass = (reader["p_pass"] == DBNull.Value ? "" : reader["p_pass"]).ToString();
                webPassObj.p_status = Convert.ToInt32(reader["p_status"] == DBNull.Value ? 0 : reader["p_status"]);
                webPassObj.Password = (reader["Password"] == DBNull.Value ? "" : reader["Password"]).ToString();
                webPassObj.Port = Convert.ToInt32(reader["Port"] == DBNull.Value ? 0 : reader["Port"]);
                webPassObj.TopMan = (reader["TopMan"] == DBNull.Value ? "" : reader["TopMan"]).ToString();
                webPassObj.UserName = (reader["UserName"] == DBNull.Value ? "" : reader["UserName"]).ToString();
                return webPassObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private TC CreateTCObj(SqlDataReader reader)
        {
            try
            {
                TC tcObj = new TC();
                tcObj.Clock_AgreeDate = (reader["Clock_AgreeDate"] == DBNull.Value ? "" : reader["Clock_AgreeDate"]).ToString();
                tcObj.Clock_BarCode = (reader["Clock_BarCode"] == DBNull.Value ? "" : reader["Clock_BarCode"]).ToString();
                tcObj.Clock_Chg = Convert.ToInt32(reader["Clock_Chg"] == DBNull.Value ? 0 : reader["Clock_Chg"]);
                tcObj.Clock_Date = (reader["Clock_Date"] == DBNull.Value ? "" : reader["Clock_Date"]).ToString();
                tcObj.Clock_eTime = Convert.ToInt32(reader["Clock_eTime"] == DBNull.Value ? 0 : reader["Clock_eTime"]);
                tcObj.Clock_FinallyAgree = Convert.ToInt32(reader["Clock_FinallyAgree"] == DBNull.Value ? 0 : reader["Clock_FinallyAgree"]);
                tcObj.Clock_FirstlyAgree = Convert.ToInt32(reader["Clock_FirstlyAgree"] == DBNull.Value ? 0 : reader["Clock_FirstlyAgree"]);
                tcObj.Clock_FirstlyAgree_BarCode = (reader["Clock_FirstlyAgree_BarCode"] == DBNull.Value ? "" : reader["Clock_FirstlyAgree_BarCode"]).ToString();
                tcObj.Clock_RdrCode = Convert.ToInt32(reader["Clock_RdrCode"] == DBNull.Value ? 0 : reader["Clock_RdrCode"]);
                tcObj.Clock_RecDes = (reader["Clock_RecDes"] == DBNull.Value ? "" : reader["Clock_RecDes"]).ToString();
                tcObj.Clock_RecState = Convert.ToInt32(reader["Clock_RecState"] == DBNull.Value ? 0 : reader["Clock_RecState"]);
                tcObj.Clock_SendDate = (reader["Clock_SendDate"] == DBNull.Value ? "" : reader["Clock_SendDate"]).ToString();
                tcObj.Clock_Time = Convert.ToInt32(reader["Clock_Time"] == DBNull.Value ? 0 : reader["Clock_Time"]);
                tcObj.Clock_User = (reader["Clock_User"] == DBNull.Value ? "" : reader["Clock_User"]).ToString();

                return tcObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private NW_Webpass CreateNW_WebpassObj(SqlDataReader reader)
        {
            try
            {
                NW_Webpass nw_WebPassObj = new NW_Webpass();
                nw_WebPassObj.AgreeAddWork = Convert.ToBoolean(reader["AgreeAddWork"] == DBNull.Value ? false : reader["AgreeAddWork"]);
                nw_WebPassObj.AgreeOverTime = Convert.ToBoolean(reader["AgreeOverTime"] == DBNull.Value ? false : reader["AgreeOverTime"]);
                nw_WebPassObj.HasInsteadMan = Convert.ToBoolean(reader["HasInsteadMan"] == DBNull.Value ? false : reader["HasInsteadMan"]);
                nw_WebPassObj.HasMailServer = Convert.ToBoolean(reader["HasMailServer"] == DBNull.Value ? false : reader["HasMailServer"]);
                nw_WebPassObj.Haspart = Convert.ToBoolean(reader["Haspart"] == DBNull.Value ? false : reader["Haspart"]);
                nw_WebPassObj.Hasperson = Convert.ToBoolean(reader["Hasperson"] == DBNull.Value ? false : reader["Hasperson"]);
                nw_WebPassObj.HostName = (reader["HostName"] == DBNull.Value ? "" : reader["HostName"]).ToString();
                nw_WebPassObj.InsteadMan = (reader["InsteadMan"] == DBNull.Value ? "" : reader["InsteadMan"]).ToString();
                nw_WebPassObj.isAcceptOwner = Convert.ToBoolean(reader["isAcceptOwner"] == DBNull.Value ? false : reader["isAcceptOwner"]);
                nw_WebPassObj.isSaveAccept = Convert.ToBoolean(reader["isSaveAccept"] == DBNull.Value ? false : reader["isSaveAccept"]);
                nw_WebPassObj.MaxOverTime = Convert.ToInt32(reader["MaxOverTime"] == DBNull.Value ? 0 : reader["MaxOverTime"]);
                nw_WebPassObj.MaxTimeReq = Convert.ToInt32(reader["MaxTimeReq"] == DBNull.Value ? 0 : reader["MaxTimeReq"]);
                nw_WebPassObj.p_barcode = (reader["p_barcode"] == DBNull.Value ? "" : reader["p_barcode"]).ToString();
                nw_WebPassObj.p_part1 = Convert.ToInt32(reader["p_part1"] == DBNull.Value ? 0 : reader["p_part1"]);
                nw_WebPassObj.p_part2 = Convert.ToInt32(reader["p_part2"] == DBNull.Value ? 0 : reader["p_part2"]);
                nw_WebPassObj.p_part3 = Convert.ToInt32(reader["p_part3"] == DBNull.Value ? 0 : reader["p_part3"]);
                nw_WebPassObj.p_part4 = Convert.ToInt32(reader["p_part4"] == DBNull.Value ? 0 : reader["p_part4"]);
                nw_WebPassObj.p_pass = (reader["p_pass"] == DBNull.Value ? "" : reader["p_pass"]).ToString();
                nw_WebPassObj.p_status = Convert.ToInt32(reader["p_status"] == DBNull.Value ? 0 : reader["p_status"]);
                nw_WebPassObj.Password = (reader["Password"] == DBNull.Value ? "" : reader["Password"]).ToString();
                nw_WebPassObj.Port = Convert.ToInt32(reader["Port"] == DBNull.Value ? 0 : reader["Port"]);
                nw_WebPassObj.TopMan = Convert.ToDecimal(reader["TopMan"] == DBNull.Value ? 0 : reader["TopMan"]);
                nw_WebPassObj.UserName = (reader["UserName"] == DBNull.Value ? "" : reader["UserName"]).ToString();
                nw_WebPassObj.PersonPost = (reader["PersonPost"] == DBNull.Value ? "" : reader["PersonPost"]).ToString();
                nw_WebPassObj.ID = Convert.ToDecimal(reader["ID"] == DBNull.Value ? 0 : reader["ID"]);
                return nw_WebPassObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private WebpassPersons CreateWebpassPersonsObj(SqlDataReader reader)
        {
            try
            {
                WebpassPersons webPassPersonsObj = new WebpassPersons();
                webPassPersonsObj.AccessType = Convert.ToBoolean(reader["AccessType"] == DBNull.Value ? false : reader["AccessType"]);
                webPassPersonsObj.BarCode = (reader["BarCode"] == DBNull.Value ? "" : reader["BarCode"]).ToString();
                webPassPersonsObj.isKarkardfrm = Convert.ToBoolean(reader["isKarkardfrm"] == DBNull.Value ? false : reader["isKarkardfrm"]);
                webPassPersonsObj.isKeeperfrm = Convert.ToBoolean(reader["isKeeperfrm"] == DBNull.Value ? false : reader["isKeeperfrm"]);
                webPassPersonsObj.isOperatorfrm = Convert.ToBoolean(reader["isOperatorfrm"] == DBNull.Value ? false : reader["isOperatorfrm"]);
                webPassPersonsObj.isOverTimefrm = Convert.ToBoolean(reader["isOverTimefrm"] == DBNull.Value ? false : reader["isOverTimefrm"]);
                webPassPersonsObj.isPart = Convert.ToBoolean(reader["isPart"] == DBNull.Value ? false : reader["isPart"]);
                webPassPersonsObj.isPerson = Convert.ToBoolean(reader["isPerson"] == DBNull.Value ? false : reader["isPerson"]);
                webPassPersonsObj.isRequestfrm = Convert.ToBoolean(reader["isRequestfrm"] == DBNull.Value ? false : reader["isRequestfrm"]);
                webPassPersonsObj.isSubPart = Convert.ToBoolean(reader["isSubPart"] == DBNull.Value ? false : reader["isSubPart"]);
                webPassPersonsObj.PersonBarCode = (reader["PersonBarCode"] == DBNull.Value ? "" : reader["PersonBarCode"]).ToString();


                return webPassPersonsObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private Agree CreateAgreeObj(SqlDataReader reader)
        {
            try
            {
                Agree agreeObj = new Agree();
                agreeObj.BarCode = (reader["BarCode"] == DBNull.Value ? "" : reader["BarCode"]).ToString();
                agreeObj.p_status = Convert.ToInt32(reader["p_status"] == DBNull.Value ? 0 : reader["p_status"]);
                agreeObj.PishCard_No = Convert.ToInt32(reader["PishCard_No"] == DBNull.Value ? 0 : reader["PishCard_No"]);



                return agreeObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private NW_Requests ConvertModelTCToNW_Requests(TC tcObj)
        {
            try
            {
                NW_Requests nw_RequestsObj = new NW_Requests();
                nw_RequestsObj.Clock_AgreeDate = tcObj.Clock_AgreeDate.Replace("-","");
                nw_RequestsObj.Clock_Chg = tcObj.Clock_Chg;
                nw_RequestsObj.Clock_Date = tcObj.Clock_Date;
                nw_RequestsObj.Clock_eTime = tcObj.Clock_eTime;
                nw_RequestsObj.Clock_FinallyAgree = tcObj.Clock_FinallyAgree;
                nw_RequestsObj.Clock_FirstlyAgree = tcObj.Clock_FirstlyAgree;
                nw_RequestsObj.Clock_FirstlyAgree_BarCode = tcObj.Clock_FirstlyAgree_BarCode;
                nw_RequestsObj.Clock_RdrCode = tcObj.Clock_RdrCode;
                nw_RequestsObj.Clock_RecDes = tcObj.Clock_RecDes;
                nw_RequestsObj.Clock_RecState = tcObj.Clock_RecState;
                nw_RequestsObj.Clock_SeconderyAgree = tcObj.Clock_FinallyAgree;
                nw_RequestsObj.Clock_SendDate = tcObj.Clock_SendDate;
                nw_RequestsObj.Clock_Time = tcObj.Clock_Time;
                nw_RequestsObj.Clock_User = tcObj.Clock_User;
                string strStatusList = "7";
                NW_Webpass nw_WebpassObj = GetNW_WebpassByBarcode(tcObj.Clock_BarCode, strStatusList);
                nw_RequestsObj.WebPassId = nw_WebpassObj.ID;
                

                return nw_RequestsObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private NW_WebpassPersons ConvertModelWebpassPersonsToNW_WebpassPersons(WebpassPersons webpassPersonsObj)
        {
            try
            {

                NW_WebpassPersons nw_WebpassPersons = new NW_WebpassPersons();
                nw_WebpassPersons.AccessType = webpassPersonsObj.AccessType;
                nw_WebpassPersons.isKarkardfrm = webpassPersonsObj.isKarkardfrm;
                nw_WebpassPersons.isKeeperfrm = webpassPersonsObj.isKeeperfrm;
                nw_WebpassPersons.isOperatorfrm = webpassPersonsObj.isOperatorfrm;
                nw_WebpassPersons.isOverTimefrm = webpassPersonsObj.isOverTimefrm;
                nw_WebpassPersons.isPart = webpassPersonsObj.isPart;
                nw_WebpassPersons.isPerson = webpassPersonsObj.isPerson;
                nw_WebpassPersons.isRequestfrm = webpassPersonsObj.isRequestfrm;
                nw_WebpassPersons.isSubPart = webpassPersonsObj.isSubPart;
                nw_WebpassPersons.PersonBarCode = webpassPersonsObj.PersonBarCode;
                string strStatusList = "1,2,3,4,6";
                NW_Webpass nw_webPassObj = GetNW_WebpassByBarcode(webpassPersonsObj.BarCode, strStatusList);
                nw_WebpassPersons.WebPassId = nw_webPassObj.ID;
                return nw_WebpassPersons;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private NW_Agree ConvertModelAgreeToNW_Agree(Agree agreeObj)
        {
            try
            {

                NW_Agree nw_AgreeObj = new NW_Agree();
                nw_AgreeObj.PishCard_No = agreeObj.PishCard_No;
                nw_AgreeObj.p_status = agreeObj.p_status;
                string strStatusList = "1,2,3,4,6";
                NW_Webpass nw_webPassObj = GetNW_WebpassByBarcode(agreeObj.BarCode, strStatusList);
                nw_AgreeObj.WebPassId = nw_webPassObj.ID;
                return nw_AgreeObj;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private NW_WebLogin ConvertModelWebPassToNW_WebLogin(Webpass webpassObj)
        {
            try
            {
                NW_WebLogin nw_WebLoginObj = new NW_WebLogin();
                nw_WebLoginObj.lgn_barcode = webpassObj.p_barcode;
                nw_WebLoginObj.lgn_UserName = webpassObj.p_barcode;
                nw_WebLoginObj.lgn_Password = webpassObj.p_pass;
                return nw_WebLoginObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private List<NW_Webpass> ConvertModelWebpassToNW_Webpass(Webpass webpassObj)
        {
            try
            {
                List<NW_Webpass> nw_WebpassList = new List<NW_Webpass>();
                NW_Webpass nw_WebpassDefaultUserObj = new NW_Webpass();
                nw_WebpassDefaultUserObj.p_barcode = webpassObj.p_barcode;
                nw_WebpassDefaultUserObj.p_status = 7;
                nw_WebpassDefaultUserObj.PersonPost = "کارمند";

                nw_WebpassList.Add(nw_WebpassDefaultUserObj);
                if (webpassObj.p_status == 1 || webpassObj.p_status == 2 || webpassObj.p_status == 3 || webpassObj.p_status == 4)
                {
                    NW_Webpass nw_WebpassManagerUserObj = new NW_Webpass();
                    nw_WebpassManagerUserObj.p_barcode = webpassObj.p_barcode;
                    nw_WebpassManagerUserObj.AgreeAddWork = webpassObj.AgreeAddWork;
                    nw_WebpassManagerUserObj.AgreeOverTime = webpassObj.AgreeOverTime;
                    nw_WebpassManagerUserObj.HasInsteadMan = webpassObj.HasInsteadMan;
                    nw_WebpassManagerUserObj.HasMailServer = webpassObj.HasMailServer;
                    nw_WebpassManagerUserObj.Haspart = webpassObj.Haspart;
                    nw_WebpassManagerUserObj.Hasperson = webpassObj.Hasperson;
                    nw_WebpassManagerUserObj.HostName = webpassObj.HostName;
                    nw_WebpassManagerUserObj.InsteadMan = webpassObj.InsteadMan;
                    nw_WebpassManagerUserObj.isAcceptOwner = webpassObj.isAcceptOwner;
                    nw_WebpassManagerUserObj.isSaveAccept = webpassObj.isSaveAccept;
                    nw_WebpassManagerUserObj.MaxOverTime = webpassObj.MaxOverTime;
                    nw_WebpassManagerUserObj.MaxTimeReq = webpassObj.MaxTimeReq;
                    nw_WebpassManagerUserObj.p_part1 = webpassObj.p_part1;
                    nw_WebpassManagerUserObj.p_part2 = webpassObj.p_part2;
                    nw_WebpassManagerUserObj.p_part3 = webpassObj.p_part3;
                    nw_WebpassManagerUserObj.p_part4 = webpassObj.p_part4;
                    nw_WebpassManagerUserObj.p_pass = webpassObj.p_pass;
                    nw_WebpassManagerUserObj.Password = webpassObj.Password;
                    nw_WebpassManagerUserObj.Port = webpassObj.Port;
                    nw_WebpassManagerUserObj.TopMan = Convert.ToDecimal(webpassObj.TopMan == null || webpassObj.TopMan == "" ? "0" : webpassObj.TopMan);
                    nw_WebpassManagerUserObj.UserName = webpassObj.UserName;

                    switch (webpassObj.p_status)
                    {
                        case 1:
                            {
                                
                                nw_WebpassManagerUserObj.p_status = 6;
                                nw_WebpassManagerUserObj.PersonPost = "مدیر ثانویه و نهایی";
                                break;
                            }
                        case 2:
                            {
                                nw_WebpassManagerUserObj.p_status = 1;
                                nw_WebpassManagerUserObj.PersonPost = "مدیر حضور غیاب";
                                nw_WebpassManagerUserObj.FinalManager = true;
                                break;
                            }
                        case 3:
                            {
                                nw_WebpassManagerUserObj.p_status = 3;
                                nw_WebpassManagerUserObj.PersonPost = "مدیر اولیه";
                                break;
                            }
                        case 4:
                            {
                                nw_WebpassManagerUserObj.p_status = 4;
                                nw_WebpassManagerUserObj.PersonPost = "اپراتور";
                                break;
                            }


                        default:
                            break;
                    }
                    nw_WebpassList.Add(nw_WebpassManagerUserObj);
                }
                return nw_WebpassList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private NW_Webpass GetNW_WebpassByBarcode(string barcode, string strStatusList)
        {
            try
            {

                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string query = "select * from nw_webpass where p_barcode='" + barcode + "' and p_status in (" + strStatusList + ")";
                myCommand.CommandText = query;
                myCommand.Connection.Open();
                SqlDataReader reader = myCommand.ExecuteReader();
                NW_Webpass nw_webPassObj = new NW_Webpass();
                while (reader.Read())
                {
                    nw_webPassObj = CreateNW_WebpassObj(reader);
                }
                return nw_webPassObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
        private NW_Webpass GetWebpassByBarcode(string barcode)
        {
            try
            {

                myCommand = new SqlCommand();
                myCommand.CommandTimeout = 60000;
                sqlConnection = new SqlConnection(connectionString);
                myCommand.Connection = sqlConnection;
                string query = "select * from webpass where p_barcode='" + barcode + "'";
                myCommand.CommandText = query;
                myCommand.Connection.Open();
                SqlDataReader reader = myCommand.ExecuteReader();
                NW_Webpass nw_webPassObj = new NW_Webpass();
                while (reader.Read())
                {
                    nw_webPassObj = CreateNW_WebpassObj(reader);
                }
                return nw_webPassObj;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                myCommand.Connection.Close();
            }
        }
    }
}

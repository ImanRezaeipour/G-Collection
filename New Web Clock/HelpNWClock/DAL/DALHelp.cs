using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class DALHelp
    {
        SqlConnection cnn;
        SqlDataAdapter myAdaptor;
        public DALHelp()
        {
             cnn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["cnn"].ConnectionString);
             myAdaptor = new SqlDataAdapter();
        }


        public ModelHelp GetHelpByFormKey(string formKey)
        {
            try
            {
                DataTable dtResult = new DataTable();
                ModelHelp modelHelp = new ModelHelp();
                string commandText = "select * from nw_help where Help_FormKey=@formKey";
                SqlCommand command = new SqlCommand(commandText, cnn);
                SqlParameter formKeyParam = new SqlParameter("@formKey", formKey);
                command.Parameters.Add(formKeyParam);
                cnn.Open();
                int result = command.ExecuteNonQuery();
                myAdaptor.SelectCommand = command;
                myAdaptor.Fill(dtResult);
                cnn.Close();
                if (dtResult.Rows.Count > 0)
                {
                    modelHelp.Help_ID = (decimal)dtResult.Rows[0]["Help_ID"];
                    modelHelp.Help_ParantID = (decimal)dtResult.Rows[0]["Help_ParantID"];
                    modelHelp.Help_FaName = dtResult.Rows[0]["Help_FaName"].ToString();
                    modelHelp.Help_EnName = dtResult.Rows[0]["Help_EnName"].ToString();
                    modelHelp.Help_FaHTMLContent = dtResult.Rows[0]["Help_FaHTMLContent"].ToString();
                    modelHelp.Help_EnHTMLContent = dtResult.Rows[0]["Help_EnHTMLContent"].ToString();
                    modelHelp.Help_FormKey = dtResult.Rows[0]["Help_FormKey"].ToString();
                    // modelHelp.Help_LevelOrder = (int)dtResult.Rows[0]["Help_LevelOrder"];
                }
                return modelHelp;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public ModelHelp GetHelpRoot()
        {
            try
            {
                DataTable dtResult = new DataTable();
                ModelHelp modelHelp = new ModelHelp();
                string commandText = "select * from nw_help where Help_FormKey='rootkey'";
                SqlCommand command = new SqlCommand(commandText,cnn);
                cnn.Open();
                int result= command.ExecuteNonQuery();
                myAdaptor.SelectCommand = command;
                myAdaptor.Fill(dtResult);
                cnn.Close();
                if (dtResult.Rows.Count > 0)
                {
                    modelHelp.Help_ID =(decimal)dtResult.Rows[0]["Help_ID"];
                    modelHelp.Help_ParantID = (decimal)dtResult.Rows[0]["Help_ParantID"];
                    modelHelp.Help_FaName = dtResult.Rows[0]["Help_FaName"].ToString();
                    modelHelp.Help_EnName = dtResult.Rows[0]["Help_EnName"].ToString();
                    modelHelp.Help_FaHTMLContent = dtResult.Rows[0]["Help_FaHTMLContent"].ToString();
                    modelHelp.Help_EnHTMLContent = dtResult.Rows[0]["Help_EnHTMLContent"].ToString();
                    modelHelp.Help_FormKey = dtResult.Rows[0]["Help_FormKey"].ToString();
                   // modelHelp.Help_LevelOrder = (int)dtResult.Rows[0]["Help_LevelOrder"];
                }
                return modelHelp;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public IList<ModelHelp> GetHelpChilds(decimal parentID)
        {
            try
            {
                DataTable dtResult = new DataTable();
                List<ModelHelp> listModelHelp = new List<ModelHelp>();
                
                string commandText = "select * from nw_help where Help_ParantID=@parentID";
                SqlCommand command = new SqlCommand(commandText, cnn);
                SqlParameter parentIDParam = new SqlParameter("@parentID", parentID);
                command.Parameters.Add(parentIDParam);
                cnn.Open();
                int result = command.ExecuteNonQuery();
                myAdaptor.SelectCommand = command;
                myAdaptor.Fill(dtResult);
                cnn.Close();
                if (dtResult.Rows.Count > 0)
                {
                    for (int i = 0; i < dtResult.Rows.Count; i++)
                    {
                        ModelHelp modelHelp = new ModelHelp();
                        modelHelp.Help_ID = (decimal)dtResult.Rows[i]["Help_ID"];
                        modelHelp.Help_ParantID = (decimal)dtResult.Rows[i]["Help_ParantID"];
                        modelHelp.Help_FaName = dtResult.Rows[i]["Help_FaName"].ToString();
                        modelHelp.Help_EnName = dtResult.Rows[i]["Help_EnName"].ToString();
                        modelHelp.Help_FaHTMLContent = dtResult.Rows[i]["Help_FaHTMLContent"].ToString();
                        modelHelp.Help_EnHTMLContent = dtResult.Rows[i]["Help_EnHTMLContent"].ToString();
                        modelHelp.Help_FormKey = dtResult.Rows[i]["Help_FormKey"].ToString();
                        // modelHelp.Help_LevelOrder = (int)dtResult.Rows[0]["Help_LevelOrder"];
                        listModelHelp.Add(modelHelp);
                    }
                   
                }
                return listModelHelp;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public decimal GetIDByFormKey(string formKey)
        {
            try
            {
                DataTable dtResult = new DataTable();
                

                string commandText = "select * from nw_help where Help_FormKey=@formKey";
                SqlCommand command = new SqlCommand(commandText, cnn);
                SqlParameter formKeyParam = new SqlParameter("@formKey", formKey);
                command.Parameters.Add(formKeyParam);
                cnn.Open();
                int result = command.ExecuteNonQuery();
                myAdaptor.SelectCommand = command;
                myAdaptor.Fill(dtResult);
                cnn.Close();
                if (dtResult.Rows.Count > 0)
                {

                    ModelHelp modelHelp = new ModelHelp();
                    modelHelp.Help_ID = (decimal)dtResult.Rows[0]["Help_ID"];
                    modelHelp.Help_ParantID = (decimal)dtResult.Rows[0]["Help_ParantID"];
                    modelHelp.Help_FaName = dtResult.Rows[0]["Help_FaName"].ToString();
                    modelHelp.Help_EnName = dtResult.Rows[0]["Help_EnName"].ToString();
                    modelHelp.Help_FaHTMLContent = dtResult.Rows[0]["Help_FaHTMLContent"].ToString();
                    modelHelp.Help_EnHTMLContent = dtResult.Rows[0]["Help_EnHTMLContent"].ToString();
                    modelHelp.Help_FormKey = dtResult.Rows[0]["Help_FormKey"].ToString();
                    // modelHelp.Help_LevelOrder = (int)dtResult.Rows[0]["Help_LevelOrder"];
                    return modelHelp.Help_ID;

                }
                else
                {
                    return 0;
                }
                
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public void UpdateHelp(ModelHelp modelHelp)
        {
            try
            {

                string commandText = "update nw_help set Help_FaHTMLContent=@content where Help_ID=@id";
                SqlCommand command = new SqlCommand(commandText, cnn);
                SqlParameter idParam = new SqlParameter("@id", modelHelp.Help_ID);
                SqlParameter contentParam = new SqlParameter("@content", modelHelp.Help_FaHTMLContent);
                command.Parameters.Add(idParam);
                command.Parameters.Add(contentParam);
                cnn.Open();
                int result = command.ExecuteNonQuery();
                
                cnn.Close();

                
                
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}

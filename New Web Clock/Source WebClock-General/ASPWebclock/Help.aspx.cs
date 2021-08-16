using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

using System.Threading;
using System.Globalization;


namespace HelpNWClock
{
    public partial class Help : System.Web.UI.Page
    {
       
        
        
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Request.QueryString["formKeyHelp"] != null)
                {

                    hf_TreeViewFormKey_HelpForm.Value = Request.QueryString["formKeyHelp"].ToString();
                }
                LoadTreeView();
            }
        }

        DevExpress.Web.ASPxTreeView.TreeViewNode nodeSelected = new DevExpress.Web.ASPxTreeView.TreeViewNode();
        private void LoadTreeView()
        {
           
            DAL.BHelp bhelp = new DAL.BHelp();
            DAL.ModelHelp proot = new DAL.ModelHelp();
            proot = bhelp.GetHelpRoot();
            DevExpress.Web.ASPxTreeView.TreeViewNode nodeRoot=new DevExpress.Web.ASPxTreeView.TreeViewNode();
           // ComponentArt.Web.UI.TreeViewNode nodeRoot = new ComponentArt.Web.UI.TreeViewNode();
            nodeRoot.Text = proot.Help_FaName;
            nodeRoot.Name = proot.Help_FormKey.ToString();
            //nodeRoot.Value = proot.Help_ID.ToString();
            LoadChild(nodeRoot);
            TreeViewHelpForm_HelpForm.Nodes.Add(nodeRoot);

        }
        private void LoadChild(DevExpress.Web.ASPxTreeView.TreeViewNode nodRoot)
        {

            DAL.BHelp bhelp = new DAL.BHelp();
            decimal nodeID = bhelp.GetIDByFormKey(nodRoot.Name);
            IList<DAL.ModelHelp> pchild = bhelp.GetHelpChilds(nodeID);

            foreach (var item in pchild)
            {

                DevExpress.Web.ASPxTreeView.TreeViewNode itemchild = new DevExpress.Web.ASPxTreeView.TreeViewNode();
                itemchild.Text = item.Help_FaName;
                itemchild.Name = item.Help_FormKey.ToString();
                //itemchild.Value = item.Help_ID.ToString();
                nodRoot.Nodes.Add(itemchild);
                LoadChild(itemchild);
            }

        }

        protected void CallBack_TreeViewHelpForm_HelpForm_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            LoadChild(TreeViewHelpForm_HelpForm.Nodes, e.Parameter);
            
                TreeViewHelpForm_HelpForm.SelectedNode = nodeSelected;


                TreeViewHelpForm_HelpForm.ExpandAll();
                
            
        }
        private void LoadChild(DevExpress.Web.ASPxTreeView.TreeViewNodeCollection nodeItem, string indexNode)
        {
            DevExpress.Web.ASPxTreeView.TreeViewNodeCollection nodeCollection = new DevExpress.Web.ASPxTreeView.TreeViewNodeCollection();

            foreach (DevExpress.Web.ASPxTreeView.TreeViewNode node in nodeItem)
            {
                if (indexNode.ToString() == node.Name)
                {

                    nodeSelected = node;
                }
                else
                {
                    if (!node.Nodes.IsEmpty)
                    {
                        LoadChild(node.Nodes, indexNode);
                    }
                }

            }
      
        }


      

      

    }
}
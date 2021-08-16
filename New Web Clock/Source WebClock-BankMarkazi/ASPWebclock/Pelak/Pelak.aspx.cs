using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPWebClock.Infrastructure.Repository;

namespace ASPWebclock
{
    public partial class PelakChanger : System.Web.UI.Page
    {
        public string Username
        {
            get
            {
                return this.User.Identity.Name;
            }
        }
        private string[] alphabets=new string[20];
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) 
            {
                
                alphabets = new string[20];
                for (int i = 0; i < pelak1part2Combo.Items.Count;i++ )
                {
                    alphabets[i] = pelak1part2Combo.Items[i].Value;
                }
                LoadPelak();
            }
        }

        private void LoadPelak()
        {
            try
            {
                //PelakRepository pelakRep = new PelakRepository().GetByBarcode(Username);
                //if (pelakRep.Barcode != null && pelakRep.Barcode.Length > 0)
                //{
                //    if (pelakRep.Pelak1 != null && pelakRep.Pelak1.Length == 8)
                //    {
                //        string part2 = pelakRep.Pelak1.Substring(2, 1);

                //        for (int i = 0; i < alphabets.Length; i++)
                //        {
                //            if (alphabets[i] == part2)
                //            {
                //                pelak1part2Combo.SelectedIndex = i;
                //            }
                //        }
                //        pelak1part1TB.Text = pelakRep.Pelak1.Substring(0, 2);
                //        pelak1part2Combo.SelectedValue = pelakRep.Pelak1.Substring(2, 1);
                //        pelak1part3TB.Text = pelakRep.Pelak1.Substring(3, 3);
                //        pelak1part4TB.Text = pelakRep.Pelak1.Substring(6, 2);
                //    }
                //    else if (pelakRep.Pelak1.Length > 0 && pelakRep.Pelak1.Length != 8)
                //    {
                //        throw new Exception("طول شماره پلاک نامعتبر است");
                //    }

                //    if (pelakRep.Pelak2 != null && pelakRep.Pelak2.Length == 8)
                //    {
                //        string part2 = pelakRep.Pelak2.Substring(2, 1);

                //        for (int i = 0; i < alphabets.Length; i++)
                //        {
                //            if (alphabets[i] == part2)
                //            {
                //                pelak2Part2Combo.SelectedIndex = i;
                //            }
                //        }
                //        pelak2part1TB.Text = pelakRep.Pelak2.Substring(0, 2);
                //        pelak2Part2Combo.SelectedValue = pelakRep.Pelak2.Substring(2, 1);
                //        pelak2part3TB.Text = pelakRep.Pelak2.Substring(3, 3);
                //        pelak2Part4TB.Text = pelakRep.Pelak2.Substring(6, 2);
                //    }
                //    else if (pelakRep.Pelak2.Length > 0 && pelakRep.Pelak2.Length != 8)
                //    {
                //        throw new Exception("طول شماره پلاک نامعتبر است");
                //    }
                //}
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

        protected void returnBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("main.aspx");
        }

        protected void saveBtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (Validate())
                {
                    lblMessage.Text = "";
                    PelakRepository pelakRep = new PelakRepository();
                    pelakRep.Barcode = this.User.Identity.Name;
                    pelakRep.Pelak1 = String.Format("{0}{1}{2}{3}", pelak1part1TB.Text, pelak1part2Combo.SelectedValue, pelak1part3TB.Text, pelak1part4TB.Text);
                    pelakRep.Pelak2 = String.Format("{0}{1}{2}{3}", pelak2part1TB.Text, pelak2Part2Combo.SelectedValue, pelak2part3TB.Text, pelak2Part4TB.Text);
                    pelakRep.InsertOrUdate();
                }
            }
            catch (Exception ex) 
            {
                lblMessage.Text = ex.Message;
            }
        }

        private bool Validate() 
        {
            if (!(pelak1part1TB.Text.Length == 0 && pelak1part2Combo.SelectedValue.Length == 0
                && pelak1part3TB.Text.Length == 0 && pelak1part4TB.Text.Length == 0))
            {
                if (pelak1part1TB.Text.Length == 0 || pelak1part2Combo.SelectedValue.Length == 0
                || pelak1part3TB.Text.Length == 0 || pelak1part4TB.Text.Length == 0) 
                {
                    lblMessage.Text = "فرمت پلاک معتبر نمیباشد";
                    return false;
                }

            }
            if (!(pelak2part1TB.Text.Length == 0 && pelak2Part2Combo.SelectedValue.Length == 0
                && pelak2part3TB.Text.Length == 0 && pelak2Part4TB.Text.Length == 0))
            {
                if (pelak2part1TB.Text.Length == 0 || pelak2Part2Combo.SelectedValue.Length == 0
                || pelak2part3TB.Text.Length == 0 || pelak2Part4TB.Text.Length == 0)
                {
                    lblMessage.Text = "فرمت پلاک معتبر نمیباشد";
                    return false;
                }

            }
            return true;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAL
{
   public class BHelp
    {

       public ModelHelp GetHelpRoot()
       {
           return new DALHelp().GetHelpRoot();
       }
       public IList<ModelHelp> GetHelpChilds(decimal parentID)
       {
           return new DALHelp().GetHelpChilds(parentID);
       }
       public void UpdateHelp(ModelHelp modelHelp)
       {
            new DALHelp().UpdateHelp(modelHelp);
       }
       public ModelHelp GetHelpByFormKey(string formKey)
       {
           return new DALHelp().GetHelpByFormKey(formKey);
       }
       public decimal GetIDByFormKey(string formKey)
       {
           return new DALHelp().GetIDByFormKey(formKey);
       }
    }
}

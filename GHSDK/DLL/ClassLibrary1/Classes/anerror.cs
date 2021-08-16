using System;
using System.Collections.Generic;
using System.Text;

namespace Ghadir_UI
{
    public class Error
    {
        private string error_description;
        private DateTime error_instance = new DateTime();
        private Object error_value;

        public Error()
        {
            Clear();            
        }

        public Error(Object ErrorValue)
        {
            error_value = ErrorValue;
            error_description = ErrorValue.ToString();
            error_instance = DateTime.Now;
        }

        public Error(Object ErrorValue, string ErrorDescription)
        {
            error_value = ErrorValue;
            error_description = ErrorDescription;
            error_instance = DateTime.Now;
        }

        public Error(Object ErrorValue, string ErrorDescription, DateTime ErrorInstance)
        {
            error_value = ErrorValue;
            error_description = ErrorDescription;
            error_instance = ErrorInstance;
        }

        public void Clear()
        {
            error_value = 0;
            error_description = string.Empty;
            error_instance = new DateTime(1, 1, 1, 1, 1,1);
        }
        
        public string Description
        {
            set
            {
                error_description = value;
            }
            get
            {
                return error_description;
            }
        }

        public DateTime Instance
        {
            set
            {
                error_instance = value;
            }
            get
            {
                return error_instance;
            }
        }

        public Object Value
        {
            set
            {
                error_value = value;
            }
            get
            {
                return error_value;
            }
        }
    }
}

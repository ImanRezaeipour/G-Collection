using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    

    public class ErrorTable
    {
        private ArrayList errors = new ArrayList();
        private Error last_error = new Error();
       
        public ErrorTable()
        {
            Clear();
        }

        public void Add(Error Error)
        {
            last_error = Error;
            errors.Add(Error);
        }

        public Error GetLastError()
        {
            return last_error;
        }

        public ArrayList GetAllErrors()
        {
            return errors;
        }

        public void Clear()
        {
            errors.Clear();
            last_error.Clear();
        }
        public void ClearLastError()
        {
            last_error.Clear();
        }

        public Boolean AnyErrorOccur()
        {
            if (errors.Count == 0)
                return false;
            else
                return true;
        }
      }
}

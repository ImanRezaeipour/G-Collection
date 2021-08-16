using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
   public class TransactionProxy
    {
       public enum TypeQueryEnum
       {
           Insert,
           Update,
           Select,
           Delete
       }
        public object Object { get; set; }
        public Dictionary<string, string> WhereParametersDic { get; set; }
        public TypeQueryEnum TypeQuery { get; set; }
    }
}

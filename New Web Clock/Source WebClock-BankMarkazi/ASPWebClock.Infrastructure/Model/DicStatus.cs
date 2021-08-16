using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ASPWebClock.Infrastructure.Model
{
    class DicStatus
    {

        Dictionary<string, string> dicStatus = new Dictionary<string, string>();
        public DicStatus()
        {
            dicStatus.Add("unKnown", "تعریف نشده");
            dicStatus.Add("TAManagment", "مدیر حضور غیاب");
            dicStatus.Add("FinalManagment", "مدیر نهایی");
            dicStatus.Add("EarlyManagment", "مدیر اولیه");
            dicStatus.Add("Operator", "اپراتور");
            dicStatus.Add("Reporter", "گزارش گیر");
            dicStatus.Add("SecondManagment", "مدیر ثانویه");
            dicStatus.Add("User", "کاربر عادی");
        }
        public string GetTitleStatus(string Status)
        {
            return dicStatus[Status];
        }
    }
}

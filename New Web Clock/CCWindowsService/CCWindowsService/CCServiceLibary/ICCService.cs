using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace CCServiceLibary
{
    [ServiceContract]
    public interface ICCService
    {
        [OperationContract(IsOneWay=false)]
        bool CalculateOnePerson(string barcode, string year, string month,string encryptedCode);

        [OperationContract(IsOneWay = false)]
        bool CalculateListPerson(List<string> barcodeList, string year, string month, string encryptedCode);
    }

}

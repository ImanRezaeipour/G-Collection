using System;
using System.Collections.Generic;
using System.Text;

namespace Restaurant_Service
{
    class Constant
    {
        /*restkk
                static public string ConfigFileDirectory = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\Restaurant Service";
                static public string ConfigFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\Restaurant Service\gco.cfg";
                static public string DBConfigFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\Restaurant Service\config.cfg";
        */
        //restkk

//restkk is
//        static public string ConfigFileDirectory = @"";
//        static public string ConfigFilePath = @"gco.cfg";
        static public string DBConfigFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\Restaurant Service\DBSType.Dta";
/////        static public string DBConfigFilePath = Environment.CurrentDirectory + @"\DBSType.Dta";
//restkk ie
        static public string encryptKey = "!#$a54?3";
    }
}

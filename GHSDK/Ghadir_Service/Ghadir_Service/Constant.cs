using System;
using System.Collections.Generic;
using System.Text;

namespace Ghadir_Service
{
    class Constant
    {
        static public string ConfigFileDirectory = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO";
        static public string ConfigFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\gco.cfg";
        static public string DBConfigFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles) + @"\GhadirCO\config.cfg";
        static public string encryptKey = "!#$a54?3";
    }
}

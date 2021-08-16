using System;
using System.ServiceProcess;
using System.Collections.Specialized;
namespace Restaurant_Service
{
    partial class ProjectInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.serviceProcessInstaller1 = new System.ServiceProcess.ServiceProcessInstaller();
            this.serviceInstaller1 = new System.ServiceProcess.ServiceInstaller();
            // 
            // serviceProcessInstaller1
            // 
            this.serviceProcessInstaller1.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.serviceProcessInstaller1.Password = null;
            this.serviceProcessInstaller1.Username = null;
            this.serviceProcessInstaller1.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.serviceProcessInstaller1_AfterInstall);
            // 
            // serviceInstaller1
            // 




            //==========================Dependency on SQL Server==========================



            ServiceController[] sc = ServiceController.GetServices();

            StringCollection stc = new StringCollection();

            this.serviceInstaller1.ServicesDependedOn.Initialize();
            for (int i = 0; i < sc.Length; i++)
            {
                string str = sc[i].ServiceName;
                string sql = "MSSQL111111";
                if (str.Contains(sql) && str != "MSSQLServerADHelper11")
                {
                    stc.Add(str);
                }
            }
            int len = stc.Count;
            this.serviceInstaller1.ServicesDependedOn = new string[len];
            stc.CopyTo(this.serviceInstaller1.ServicesDependedOn, 0);
                      
            //============================================================================
            this.serviceInstaller1.DisplayName = "RestaurantService";
            this.serviceInstaller1.ServiceName = "RestaurantService";
            this.serviceInstaller1.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.serviceProcessInstaller1,
            this.serviceInstaller1});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller serviceProcessInstaller1;
        private System.ServiceProcess.ServiceInstaller serviceInstaller1;
    }
}
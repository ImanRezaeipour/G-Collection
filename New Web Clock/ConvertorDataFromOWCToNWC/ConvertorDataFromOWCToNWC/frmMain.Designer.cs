namespace ConvertorDataFromOWCToNWC
{
    partial class frmMain
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.gbConnectToDatabase = new System.Windows.Forms.GroupBox();
            this.btnDisconnectDatabase = new System.Windows.Forms.Button();
            this.btnConnetDatabase = new System.Windows.Forms.Button();
            this.gbCreateTable = new System.Windows.Forms.GroupBox();
            this.btnCreateTables = new System.Windows.Forms.Button();
            this.gbConvertData = new System.Windows.Forms.GroupBox();
            this.chbWebPassPersons = new System.Windows.Forms.CheckBox();
            this.chbAgree = new System.Windows.Forms.CheckBox();
            this.chbRequests = new System.Windows.Forms.CheckBox();
            this.chbWebPass = new System.Windows.Forms.CheckBox();
            this.lblRequestCondition2 = new System.Windows.Forms.Label();
            this.cbYear = new System.Windows.Forms.ComboBox();
            this.cbMonth = new System.Windows.Forms.ComboBox();
            this.lblRequestConditions = new System.Windows.Forms.Label();
            this.btnConvertData = new System.Windows.Forms.Button();
            this.pbLoading = new System.Windows.Forms.PictureBox();
            this.lblLoading = new System.Windows.Forms.Label();
            this.backgroundWorkerCreateTables = new System.ComponentModel.BackgroundWorker();
            this.backgroundWorkerConvertData = new System.ComponentModel.BackgroundWorker();
            this.btnInsertDefaultData = new System.Windows.Forms.Button();
            this.btnCreateFunctions = new System.Windows.Forms.Button();
            this.gbConnectToDatabase.SuspendLayout();
            this.gbCreateTable.SuspendLayout();
            this.gbConvertData.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbLoading)).BeginInit();
            this.SuspendLayout();
            // 
            // gbConnectToDatabase
            // 
            this.gbConnectToDatabase.Controls.Add(this.btnDisconnectDatabase);
            this.gbConnectToDatabase.Controls.Add(this.btnConnetDatabase);
            this.gbConnectToDatabase.Location = new System.Drawing.Point(12, 35);
            this.gbConnectToDatabase.Name = "gbConnectToDatabase";
            this.gbConnectToDatabase.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.gbConnectToDatabase.Size = new System.Drawing.Size(360, 120);
            this.gbConnectToDatabase.TabIndex = 0;
            this.gbConnectToDatabase.TabStop = false;
            this.gbConnectToDatabase.Text = "اتصال به دیتابیس";
            // 
            // btnDisconnectDatabase
            // 
            this.btnDisconnectDatabase.Enabled = false;
            this.btnDisconnectDatabase.Location = new System.Drawing.Point(21, 52);
            this.btnDisconnectDatabase.Name = "btnDisconnectDatabase";
            this.btnDisconnectDatabase.Size = new System.Drawing.Size(104, 23);
            this.btnDisconnectDatabase.TabIndex = 9;
            this.btnDisconnectDatabase.Text = "قطع ارتباط";
            this.btnDisconnectDatabase.UseVisualStyleBackColor = true;
            this.btnDisconnectDatabase.Click += new System.EventHandler(this.btnDisconnectDatabase_Click);
            // 
            // btnConnetDatabase
            // 
            this.btnConnetDatabase.Location = new System.Drawing.Point(234, 52);
            this.btnConnetDatabase.Name = "btnConnetDatabase";
            this.btnConnetDatabase.Size = new System.Drawing.Size(104, 23);
            this.btnConnetDatabase.TabIndex = 8;
            this.btnConnetDatabase.Text = "اتصال به دیتابیس";
            this.btnConnetDatabase.UseVisualStyleBackColor = true;
            this.btnConnetDatabase.Click += new System.EventHandler(this.btnConnetDatabase_Click);
            // 
            // gbCreateTable
            // 
            this.gbCreateTable.Controls.Add(this.btnCreateFunctions);
            this.gbCreateTable.Controls.Add(this.btnInsertDefaultData);
            this.gbCreateTable.Controls.Add(this.btnCreateTables);
            this.gbCreateTable.Enabled = false;
            this.gbCreateTable.Location = new System.Drawing.Point(12, 161);
            this.gbCreateTable.Name = "gbCreateTable";
            this.gbCreateTable.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.gbCreateTable.Size = new System.Drawing.Size(360, 113);
            this.gbCreateTable.TabIndex = 1;
            this.gbCreateTable.TabStop = false;
            this.gbCreateTable.Text = "ساخت جداول WebClock";
            // 
            // btnCreateTables
            // 
            this.btnCreateTables.Location = new System.Drawing.Point(234, 34);
            this.btnCreateTables.Name = "btnCreateTables";
            this.btnCreateTables.Size = new System.Drawing.Size(104, 23);
            this.btnCreateTables.TabIndex = 0;
            this.btnCreateTables.Text = "ساخت جداول";
            this.btnCreateTables.UseVisualStyleBackColor = true;
            this.btnCreateTables.Click += new System.EventHandler(this.btnCreateTables_Click);
            // 
            // gbConvertData
            // 
            this.gbConvertData.Controls.Add(this.chbWebPassPersons);
            this.gbConvertData.Controls.Add(this.chbAgree);
            this.gbConvertData.Controls.Add(this.chbRequests);
            this.gbConvertData.Controls.Add(this.chbWebPass);
            this.gbConvertData.Controls.Add(this.lblRequestCondition2);
            this.gbConvertData.Controls.Add(this.cbYear);
            this.gbConvertData.Controls.Add(this.cbMonth);
            this.gbConvertData.Controls.Add(this.lblRequestConditions);
            this.gbConvertData.Controls.Add(this.btnConvertData);
            this.gbConvertData.Enabled = false;
            this.gbConvertData.Location = new System.Drawing.Point(12, 280);
            this.gbConvertData.Name = "gbConvertData";
            this.gbConvertData.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.gbConvertData.Size = new System.Drawing.Size(362, 167);
            this.gbConvertData.TabIndex = 2;
            this.gbConvertData.TabStop = false;
            this.gbConvertData.Text = "انتقال اطلاعات";
            // 
            // chbWebPassPersons
            // 
            this.chbWebPassPersons.AutoSize = true;
            this.chbWebPassPersons.Location = new System.Drawing.Point(238, 43);
            this.chbWebPassPersons.Name = "chbWebPassPersons";
            this.chbWebPassPersons.Size = new System.Drawing.Size(108, 17);
            this.chbWebPassPersons.TabIndex = 11;
            this.chbWebPassPersons.Text = "WebPassPersons";
            this.chbWebPassPersons.UseVisualStyleBackColor = true;
            this.chbWebPassPersons.CheckedChanged += new System.EventHandler(this.chbWebPassPersons_CheckedChanged);
            // 
            // chbAgree
            // 
            this.chbAgree.AutoSize = true;
            this.chbAgree.Location = new System.Drawing.Point(146, 20);
            this.chbAgree.Name = "chbAgree";
            this.chbAgree.Size = new System.Drawing.Size(55, 17);
            this.chbAgree.TabIndex = 10;
            this.chbAgree.Text = "Agree";
            this.chbAgree.UseVisualStyleBackColor = true;
            this.chbAgree.CheckedChanged += new System.EventHandler(this.chbAgree_CheckedChanged);
            // 
            // chbRequests
            // 
            this.chbRequests.AutoSize = true;
            this.chbRequests.Location = new System.Drawing.Point(130, 43);
            this.chbRequests.Name = "chbRequests";
            this.chbRequests.Size = new System.Drawing.Size(71, 17);
            this.chbRequests.TabIndex = 8;
            this.chbRequests.Text = "Requests";
            this.chbRequests.UseVisualStyleBackColor = true;
            this.chbRequests.CheckedChanged += new System.EventHandler(this.chbRequests_CheckedChanged);
            // 
            // chbWebPass
            // 
            this.chbWebPass.AutoSize = true;
            this.chbWebPass.Location = new System.Drawing.Point(276, 20);
            this.chbWebPass.Name = "chbWebPass";
            this.chbWebPass.Size = new System.Drawing.Size(70, 17);
            this.chbWebPass.TabIndex = 6;
            this.chbWebPass.Text = "WebPass";
            this.chbWebPass.UseVisualStyleBackColor = true;
            this.chbWebPass.CheckedChanged += new System.EventHandler(this.chbWebPass_CheckedChanged);
            // 
            // lblRequestCondition2
            // 
            this.lblRequestCondition2.AutoSize = true;
            this.lblRequestCondition2.Enabled = false;
            this.lblRequestCondition2.Location = new System.Drawing.Point(14, 83);
            this.lblRequestCondition2.Name = "lblRequestCondition2";
            this.lblRequestCondition2.Size = new System.Drawing.Size(34, 13);
            this.lblRequestCondition2.TabIndex = 5;
            this.lblRequestCondition2.Text = "به بعد";
            // 
            // cbYear
            // 
            this.cbYear.Enabled = false;
            this.cbYear.FormattingEnabled = true;
            this.cbYear.Items.AddRange(new object[] {
            "1380",
            "1381",
            "1382",
            "1383",
            "1384",
            "1385",
            "1386",
            "1387",
            "1388",
            "1389",
            "1390",
            "1391",
            "1392",
            "1393",
            "1394",
            "1395"});
            this.cbYear.Location = new System.Drawing.Point(54, 80);
            this.cbYear.Name = "cbYear";
            this.cbYear.Size = new System.Drawing.Size(58, 21);
            this.cbYear.TabIndex = 4;
            // 
            // cbMonth
            // 
            this.cbMonth.Enabled = false;
            this.cbMonth.FormattingEnabled = true;
            this.cbMonth.Items.AddRange(new object[] {
            "فروردین",
            "اردیبهشت",
            "خرداد",
            "تیر",
            "مرداد",
            "شهریور",
            "مهر",
            "آبان",
            "آذر",
            "دی",
            "بهمن",
            "اسفند"});
            this.cbMonth.Location = new System.Drawing.Point(118, 80);
            this.cbMonth.Name = "cbMonth";
            this.cbMonth.Size = new System.Drawing.Size(72, 21);
            this.cbMonth.TabIndex = 3;
            // 
            // lblRequestConditions
            // 
            this.lblRequestConditions.AutoSize = true;
            this.lblRequestConditions.Enabled = false;
            this.lblRequestConditions.Location = new System.Drawing.Point(196, 83);
            this.lblRequestConditions.Name = "lblRequestConditions";
            this.lblRequestConditions.Size = new System.Drawing.Size(160, 13);
            this.lblRequestConditions.TabIndex = 2;
            this.lblRequestConditions.Text = "انتقال جدول درخواست ها از تاریخ ";
            // 
            // btnConvertData
            // 
            this.btnConvertData.Location = new System.Drawing.Point(140, 138);
            this.btnConvertData.Name = "btnConvertData";
            this.btnConvertData.Size = new System.Drawing.Size(104, 23);
            this.btnConvertData.TabIndex = 1;
            this.btnConvertData.Text = "انتقال اطلاعات";
            this.btnConvertData.UseVisualStyleBackColor = true;
            this.btnConvertData.Click += new System.EventHandler(this.btnConvertData_Click);
            // 
            // pbLoading
            // 
            this.pbLoading.Image = ((System.Drawing.Image)(resources.GetObject("pbLoading.Image")));
            this.pbLoading.Location = new System.Drawing.Point(117, 7);
            this.pbLoading.Name = "pbLoading";
            this.pbLoading.Size = new System.Drawing.Size(20, 20);
            this.pbLoading.TabIndex = 3;
            this.pbLoading.TabStop = false;
            this.pbLoading.Visible = false;
            // 
            // lblLoading
            // 
            this.lblLoading.AutoSize = true;
            this.lblLoading.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.lblLoading.Location = new System.Drawing.Point(12, 10);
            this.lblLoading.Name = "lblLoading";
            this.lblLoading.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.lblLoading.Size = new System.Drawing.Size(104, 13);
            this.lblLoading.TabIndex = 4;
            this.lblLoading.Text = "لطفا منتظر بمانید...";
            this.lblLoading.Visible = false;
            // 
            // backgroundWorkerCreateTables
            // 
            this.backgroundWorkerCreateTables.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorkerCreateTables_RunWorkerCompleted);
            // 
            // backgroundWorkerConvertData
            // 
            this.backgroundWorkerConvertData.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorkerConvertData_RunWorkerCompleted);
            // 
            // btnInsertDefaultData
            // 
            this.btnInsertDefaultData.Location = new System.Drawing.Point(118, 74);
            this.btnInsertDefaultData.Name = "btnInsertDefaultData";
            this.btnInsertDefaultData.Size = new System.Drawing.Size(126, 23);
            this.btnInsertDefaultData.TabIndex = 1;
            this.btnInsertDefaultData.Text = "ایجاد اطلاعات پیش فرض";
            this.btnInsertDefaultData.UseVisualStyleBackColor = true;
            this.btnInsertDefaultData.Click += new System.EventHandler(this.btnInsertDefaultData_Click);
            // 
            // btnCreateFunctions
            // 
            this.btnCreateFunctions.Location = new System.Drawing.Point(21, 33);
            this.btnCreateFunctions.Name = "btnCreateFunctions";
            this.btnCreateFunctions.Size = new System.Drawing.Size(104, 23);
            this.btnCreateFunctions.TabIndex = 2;
            this.btnCreateFunctions.Text = "ساخت توابع";
            this.btnCreateFunctions.UseVisualStyleBackColor = true;
            this.btnCreateFunctions.Click += new System.EventHandler(this.btnCreateFunctions_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(386, 459);
            this.Controls.Add(this.lblLoading);
            this.Controls.Add(this.pbLoading);
            this.Controls.Add(this.gbConvertData);
            this.Controls.Add(this.gbCreateTable);
            this.Controls.Add(this.gbConnectToDatabase);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "فرم اصلی";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.gbConnectToDatabase.ResumeLayout(false);
            this.gbCreateTable.ResumeLayout(false);
            this.gbConvertData.ResumeLayout(false);
            this.gbConvertData.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbLoading)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox gbConnectToDatabase;
        private System.Windows.Forms.Button btnDisconnectDatabase;
        private System.Windows.Forms.Button btnConnetDatabase;
        private System.Windows.Forms.GroupBox gbCreateTable;
        private System.Windows.Forms.Button btnCreateTables;
        private System.Windows.Forms.GroupBox gbConvertData;
        private System.Windows.Forms.Button btnConvertData;
        private System.Windows.Forms.PictureBox pbLoading;
        private System.Windows.Forms.Label lblLoading;
        private System.ComponentModel.BackgroundWorker backgroundWorkerCreateTables;
        private System.ComponentModel.BackgroundWorker backgroundWorkerConvertData;
        private System.Windows.Forms.Label lblRequestCondition2;
        private System.Windows.Forms.ComboBox cbYear;
        private System.Windows.Forms.ComboBox cbMonth;
        private System.Windows.Forms.Label lblRequestConditions;
        private System.Windows.Forms.CheckBox chbWebPassPersons;
        private System.Windows.Forms.CheckBox chbAgree;
        private System.Windows.Forms.CheckBox chbRequests;
        private System.Windows.Forms.CheckBox chbWebPass;
        private System.Windows.Forms.Button btnCreateFunctions;
        private System.Windows.Forms.Button btnInsertDefaultData;

    }
}


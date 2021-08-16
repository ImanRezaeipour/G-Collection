namespace WebconfigSetParameter
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnTestCnn = new System.Windows.Forms.Button();
            this.txtDatabaseName = new System.Windows.Forms.TextBox();
            this.txtUsername = new System.Windows.Forms.TextBox();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.txtServerName = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSaveCnn = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtCCAddress = new System.Windows.Forms.TextBox();
            this.txtThreatCount = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.chbCCService = new System.Windows.Forms.CheckBox();
            this.btnSelectCC = new System.Windows.Forms.Button();
            this.ofd1 = new System.Windows.Forms.OpenFileDialog();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnTestCnn);
            this.groupBox1.Controls.Add(this.txtDatabaseName);
            this.groupBox1.Controls.Add(this.txtUsername);
            this.groupBox1.Controls.Add(this.txtPassword);
            this.groupBox1.Controls.Add(this.txtServerName);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.groupBox1.Size = new System.Drawing.Size(318, 202);
            this.groupBox1.TabIndex = 24;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "اطلاعات دیتابیس";
            // 
            // btnTestCnn
            // 
            this.btnTestCnn.Location = new System.Drawing.Point(158, 153);
            this.btnTestCnn.Name = "btnTestCnn";
            this.btnTestCnn.Size = new System.Drawing.Size(75, 23);
            this.btnTestCnn.TabIndex = 4;
            this.btnTestCnn.Text = "تست ارتباط";
            this.btnTestCnn.UseVisualStyleBackColor = true;
            this.btnTestCnn.Click += new System.EventHandler(this.btnTestCnn_Click_1);
            // 
            // txtDatabaseName
            // 
            this.txtDatabaseName.Location = new System.Drawing.Point(6, 60);
            this.txtDatabaseName.Name = "txtDatabaseName";
            this.txtDatabaseName.Size = new System.Drawing.Size(227, 21);
            this.txtDatabaseName.TabIndex = 1;
            // 
            // txtUsername
            // 
            this.txtUsername.Location = new System.Drawing.Point(6, 87);
            this.txtUsername.Name = "txtUsername";
            this.txtUsername.Size = new System.Drawing.Size(227, 21);
            this.txtUsername.TabIndex = 2;
            // 
            // txtPassword
            // 
            this.txtPassword.Location = new System.Drawing.Point(6, 114);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = '*';
            this.txtPassword.Size = new System.Drawing.Size(227, 21);
            this.txtPassword.TabIndex = 3;
            // 
            // txtServerName
            // 
            this.txtServerName.Location = new System.Drawing.Point(6, 33);
            this.txtServerName.Name = "txtServerName";
            this.txtServerName.Size = new System.Drawing.Size(227, 21);
            this.txtServerName.TabIndex = 0;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(239, 63);
            this.label4.Name = "label4";
            this.label4.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.label4.Size = new System.Drawing.Size(66, 13);
            this.label4.TabIndex = 29;
            this.label4.Text = "نام دیتابیس :";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(239, 90);
            this.label3.Name = "label3";
            this.label3.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.label3.Size = new System.Drawing.Size(60, 13);
            this.label3.TabIndex = 30;
            this.label3.Text = "نام کاربری :";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(239, 117);
            this.label2.Name = "label2";
            this.label2.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.label2.Size = new System.Drawing.Size(59, 13);
            this.label2.TabIndex = 31;
            this.label2.Text = "کلمه عبور :";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(239, 36);
            this.label1.Name = "label1";
            this.label1.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.label1.Size = new System.Drawing.Size(55, 13);
            this.label1.TabIndex = 28;
            this.label1.Text = "نام سرور :";
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(12, 407);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 10;
            this.btnCancel.Text = "لغو";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSaveCnn
            // 
            this.btnSaveCnn.Location = new System.Drawing.Point(255, 407);
            this.btnSaveCnn.Name = "btnSaveCnn";
            this.btnSaveCnn.Size = new System.Drawing.Size(75, 23);
            this.btnSaveCnn.TabIndex = 9;
            this.btnSaveCnn.Text = "ثبت";
            this.btnSaveCnn.UseVisualStyleBackColor = true;
            this.btnSaveCnn.Click += new System.EventHandler(this.btnSaveCnn_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.btnSelectCC);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.txtCCAddress);
            this.groupBox2.Controls.Add(this.txtThreatCount);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.chbCCService);
            this.groupBox2.Location = new System.Drawing.Point(12, 220);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.groupBox2.Size = new System.Drawing.Size(318, 172);
            this.groupBox2.TabIndex = 28;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "تنظمات نرم افزار";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(221, 101);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(78, 13);
            this.label6.TabIndex = 41;
            this.label6.Text = "آدرس فایل CC :";
            // 
            // txtCCAddress
            // 
            this.txtCCAddress.Enabled = false;
            this.txtCCAddress.Location = new System.Drawing.Point(94, 126);
            this.txtCCAddress.Name = "txtCCAddress";
            this.txtCCAddress.Size = new System.Drawing.Size(202, 21);
            this.txtCCAddress.TabIndex = 7;
            // 
            // txtThreatCount
            // 
            this.txtThreatCount.Location = new System.Drawing.Point(115, 63);
            this.txtThreatCount.Name = "txtThreatCount";
            this.txtThreatCount.Size = new System.Drawing.Size(54, 21);
            this.txtThreatCount.TabIndex = 6;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(175, 66);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(124, 13);
            this.label5.TabIndex = 42;
            this.label5.Text = "تعداد اجرای همزمان CC :";
            // 
            // chbCCService
            // 
            this.chbCCService.AutoSize = true;
            this.chbCCService.Location = new System.Drawing.Point(165, 32);
            this.chbCCService.Name = "chbCCService";
            this.chbCCService.Size = new System.Drawing.Size(131, 17);
            this.chbCCService.TabIndex = 5;
            this.chbCCService.Text = "استفاده از سرویس CC";
            this.chbCCService.UseVisualStyleBackColor = true;
            // 
            // btnSelectCC
            // 
            this.btnSelectCC.Location = new System.Drawing.Point(6, 124);
            this.btnSelectCC.Name = "btnSelectCC";
            this.btnSelectCC.Size = new System.Drawing.Size(75, 23);
            this.btnSelectCC.TabIndex = 43;
            this.btnSelectCC.Text = "انتخاب";
            this.btnSelectCC.UseVisualStyleBackColor = true;
            this.btnSelectCC.Click += new System.EventHandler(this.btnSelectCC_Click);
            // 
            // ofd1
            // 
            this.ofd1.FileName = "openFileDialog1";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(347, 442);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSaveCnn);
            this.Controls.Add(this.groupBox1);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "تنظیمات وب کانفیگ";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnTestCnn;
        private System.Windows.Forms.TextBox txtDatabaseName;
        private System.Windows.Forms.TextBox txtUsername;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.TextBox txtServerName;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnSaveCnn;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtCCAddress;
        private System.Windows.Forms.TextBox txtThreatCount;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.CheckBox chbCCService;
        private System.Windows.Forms.Button btnSelectCC;
        private System.Windows.Forms.OpenFileDialog ofd1;

    }
}


namespace Test_GP7dll
{
    partial class Form1
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
            this.lblID = new System.Windows.Forms.Label();
            this.txtIP = new System.Windows.Forms.TextBox();
            this.lblIP = new System.Windows.Forms.Label();
            this.lblPort = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtPort = new System.Windows.Forms.MaskedTextBox();
            this.txtID = new System.Windows.Forms.MaskedTextBox();
            this.rbtnUSB = new System.Windows.Forms.RadioButton();
            this.rbtnSerial = new System.Windows.Forms.RadioButton();
            this.rbtnEthernet = new System.Windows.Forms.RadioButton();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.lblCommand = new System.Windows.Forms.Label();
            this.txtCommand = new System.Windows.Forms.TextBox();
            this.btnRun = new System.Windows.Forms.Button();
            this.cmBox = new System.Windows.Forms.ComboBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.LstvLog = new System.Windows.Forms.ListView();
            this.Messages = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblID
            // 
            this.lblID.AutoSize = true;
            this.lblID.Location = new System.Drawing.Point(6, 75);
            this.lblID.Name = "lblID";
            this.lblID.Size = new System.Drawing.Size(52, 13);
            this.lblID.TabIndex = 1;
            this.lblID.Text = "DeviceID";
            // 
            // txtIP
            // 
            this.txtIP.Location = new System.Drawing.Point(64, 15);
            this.txtIP.Name = "txtIP";
            this.txtIP.Size = new System.Drawing.Size(112, 20);
            this.txtIP.TabIndex = 2;
            this.txtIP.Text = "192.168.10.160";
            // 
            // lblIP
            // 
            this.lblIP.AutoSize = true;
            this.lblIP.Location = new System.Drawing.Point(6, 16);
            this.lblIP.Name = "lblIP";
            this.lblIP.Size = new System.Drawing.Size(17, 13);
            this.lblIP.TabIndex = 3;
            this.lblIP.Text = "IP";
            // 
            // lblPort
            // 
            this.lblPort.AutoSize = true;
            this.lblPort.Location = new System.Drawing.Point(6, 48);
            this.lblPort.Name = "lblPort";
            this.lblPort.Size = new System.Drawing.Size(37, 13);
            this.lblPort.TabIndex = 5;
            this.lblPort.Text = "PORT";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txtPort);
            this.groupBox1.Controls.Add(this.txtID);
            this.groupBox1.Controls.Add(this.rbtnUSB);
            this.groupBox1.Controls.Add(this.rbtnSerial);
            this.groupBox1.Controls.Add(this.rbtnEthernet);
            this.groupBox1.Controls.Add(this.txtIP);
            this.groupBox1.Controls.Add(this.lblPort);
            this.groupBox1.Controls.Add(this.lblID);
            this.groupBox1.Controls.Add(this.lblIP);
            this.groupBox1.Location = new System.Drawing.Point(33, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(286, 106);
            this.groupBox1.TabIndex = 6;
            this.groupBox1.TabStop = false;
            // 
            // txtPort
            // 
            this.txtPort.Location = new System.Drawing.Point(64, 45);
            this.txtPort.Mask = "000000";
            this.txtPort.Name = "txtPort";
            this.txtPort.PromptChar = ' ';
            this.txtPort.Size = new System.Drawing.Size(112, 20);
            this.txtPort.TabIndex = 10;
            this.txtPort.Text = "5000";
            // 
            // txtID
            // 
            this.txtID.Location = new System.Drawing.Point(64, 75);
            this.txtID.Mask = "00000";
            this.txtID.Name = "txtID";
            this.txtID.PromptChar = ' ';
            this.txtID.Size = new System.Drawing.Size(112, 20);
            this.txtID.TabIndex = 9;
            this.txtID.Text = "1001";
            this.txtID.ValidatingType = typeof(int);
            // 
            // rbtnUSB
            // 
            this.rbtnUSB.AutoSize = true;
            this.rbtnUSB.Location = new System.Drawing.Point(204, 73);
            this.rbtnUSB.Name = "rbtnUSB";
            this.rbtnUSB.Size = new System.Drawing.Size(47, 17);
            this.rbtnUSB.TabIndex = 8;
            this.rbtnUSB.Text = "USB";
            this.rbtnUSB.UseVisualStyleBackColor = true;
            this.rbtnUSB.CheckedChanged += new System.EventHandler(this.rbtn_CheckedChanged);
            // 
            // rbtnSerial
            // 
            this.rbtnSerial.AutoSize = true;
            this.rbtnSerial.Location = new System.Drawing.Point(204, 48);
            this.rbtnSerial.Name = "rbtnSerial";
            this.rbtnSerial.Size = new System.Drawing.Size(51, 17);
            this.rbtnSerial.TabIndex = 7;
            this.rbtnSerial.Text = "Serial";
            this.rbtnSerial.UseVisualStyleBackColor = true;
            this.rbtnSerial.CheckedChanged += new System.EventHandler(this.rbtn_CheckedChanged);
            // 
            // rbtnEthernet
            // 
            this.rbtnEthernet.AutoSize = true;
            this.rbtnEthernet.Checked = true;
            this.rbtnEthernet.Location = new System.Drawing.Point(204, 22);
            this.rbtnEthernet.Name = "rbtnEthernet";
            this.rbtnEthernet.Size = new System.Drawing.Size(65, 17);
            this.rbtnEthernet.TabIndex = 6;
            this.rbtnEthernet.TabStop = true;
            this.rbtnEthernet.Text = "Ethernet";
            this.rbtnEthernet.UseVisualStyleBackColor = true;
            this.rbtnEthernet.CheckedChanged += new System.EventHandler(this.rbtn_CheckedChanged);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.lblCommand);
            this.groupBox2.Controls.Add(this.txtCommand);
            this.groupBox2.Controls.Add(this.btnRun);
            this.groupBox2.Controls.Add(this.cmBox);
            this.groupBox2.Controls.Add(this.btnConnect);
            this.groupBox2.Location = new System.Drawing.Point(12, 259);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(322, 82);
            this.groupBox2.TabIndex = 7;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Function Test";
            // 
            // lblCommand
            // 
            this.lblCommand.AutoSize = true;
            this.lblCommand.Location = new System.Drawing.Point(113, 51);
            this.lblCommand.Name = "lblCommand";
            this.lblCommand.Size = new System.Drawing.Size(0, 13);
            this.lblCommand.TabIndex = 15;
            // 
            // txtCommand
            // 
            this.txtCommand.Enabled = false;
            this.txtCommand.Location = new System.Drawing.Point(169, 48);
            this.txtCommand.Name = "txtCommand";
            this.txtCommand.Size = new System.Drawing.Size(92, 20);
            this.txtCommand.TabIndex = 14;
            // 
            // btnRun
            // 
            this.btnRun.Location = new System.Drawing.Point(269, 30);
            this.btnRun.Name = "btnRun";
            this.btnRun.Size = new System.Drawing.Size(47, 29);
            this.btnRun.TabIndex = 13;
            this.btnRun.Text = "Go";
            this.btnRun.UseVisualStyleBackColor = true;
            this.btnRun.Click += new System.EventHandler(this.btnRun_Click);
            // 
            // cmBox
            // 
            this.cmBox.FormattingEnabled = true;
            this.cmBox.Items.AddRange(new object[] {
            "Get Time",
            "Set Time",
            "Collect Record",
            "Read Config",
            "Get User Info",
            "Enroll User"});
            this.cmBox.Location = new System.Drawing.Point(116, 21);
            this.cmBox.Name = "cmBox";
            this.cmBox.Size = new System.Drawing.Size(145, 21);
            this.cmBox.TabIndex = 12;
            this.cmBox.SelectedIndexChanged += new System.EventHandler(this.cmBox_SelectedIndexChanged);
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(15, 31);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(74, 28);
            this.btnConnect.TabIndex = 8;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // LstvLog
            // 
            this.LstvLog.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.Messages});
            this.LstvLog.FullRowSelect = true;
            this.LstvLog.Location = new System.Drawing.Point(12, 127);
            this.LstvLog.Name = "LstvLog";
            this.LstvLog.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.LstvLog.RightToLeftLayout = true;
            this.LstvLog.Size = new System.Drawing.Size(321, 126);
            this.LstvLog.TabIndex = 9;
            this.LstvLog.UseCompatibleStateImageBehavior = false;
            this.LstvLog.View = System.Windows.Forms.View.Details;
            // 
            // Messages
            // 
            this.Messages.Text = "";
            this.Messages.Width = 300;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(345, 353);
            this.Controls.Add(this.LstvLog);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.Text = "GP7 SDK EXAMPLE";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblID;
        private System.Windows.Forms.TextBox txtIP;
        private System.Windows.Forms.Label lblIP;
        private System.Windows.Forms.Label lblPort;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton rbtnUSB;
        private System.Windows.Forms.RadioButton rbtnSerial;
        private System.Windows.Forms.RadioButton rbtnEthernet;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.ListView LstvLog;
        private System.Windows.Forms.MaskedTextBox txtID;
        private System.Windows.Forms.MaskedTextBox txtPort;
        private System.Windows.Forms.ColumnHeader Messages;
        private System.Windows.Forms.ComboBox cmBox;
        private System.Windows.Forms.Button btnRun;
        private System.Windows.Forms.Label lblCommand;
        private System.Windows.Forms.TextBox txtCommand;
    }
}


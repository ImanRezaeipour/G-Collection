namespace Ghadir_UI
{
    partial class PhisycalLayer
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
            this.serial_baud = new System.Windows.Forms.ComboBox();
            this.ebx_port = new System.Windows.Forms.TextBox();
            this.ebx_ip = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.rdo_ser = new System.Windows.Forms.RadioButton();
            this.rdo_net = new System.Windows.Forms.RadioButton();
            this.label1 = new System.Windows.Forms.Label();
            this.serial_port = new System.Windows.Forms.ComboBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.device_type = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.device_name = new System.Windows.Forms.TextBox();
            this.device_address = new System.Windows.Forms.NumericUpDown();
            this.label7 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            ((System.ComponentModel.ISupportInitialize)(this.device_address)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // serial_baud
            // 
            this.serial_baud.FormattingEnabled = true;
            this.serial_baud.Items.AddRange(new object[] {
            "2400",
            "4800",
            "9600",
            "19200",
            "38400"});
            this.serial_baud.Location = new System.Drawing.Point(263, 22);
            this.serial_baud.Name = "serial_baud";
            this.serial_baud.Size = new System.Drawing.Size(64, 21);
            this.serial_baud.TabIndex = 0;
            this.serial_baud.Text = "38400";
            // 
            // ebx_port
            // 
            this.ebx_port.Location = new System.Drawing.Point(263, 68);
            this.ebx_port.Name = "ebx_port";
            this.ebx_port.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.ebx_port.Size = new System.Drawing.Size(64, 20);
            this.ebx_port.TabIndex = 14;
            this.ebx_port.Text = "1001";
            // 
            // ebx_ip
            // 
            this.ebx_ip.Location = new System.Drawing.Point(14, 69);
            this.ebx_ip.Name = "ebx_ip";
            this.ebx_ip.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.ebx_ip.Size = new System.Drawing.Size(82, 20);
            this.ebx_ip.TabIndex = 15;
            this.ebx_ip.Text = "192.168.0.1";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(327, 26);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(42, 13);
            this.label2.TabIndex = 17;
            this.label2.Text = "”—⁄  :";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(333, 72);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(36, 13);
            this.label3.TabIndex = 18;
            this.label3.Text = "ÅÊ—  :";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(101, 72);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(67, 13);
            this.label4.TabIndex = 19;
            this.label4.Text = " ¬œ—” ‘»ﬂÂ :";
            // 
            // rdo_ser
            // 
            this.rdo_ser.AutoSize = true;
            this.rdo_ser.Location = new System.Drawing.Point(184, 26);
            this.rdo_ser.Name = "rdo_ser";
            this.rdo_ser.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.rdo_ser.Size = new System.Drawing.Size(54, 17);
            this.rdo_ser.TabIndex = 20;
            this.rdo_ser.TabStop = true;
            this.rdo_ser.Text = "”—Ì«·";
            this.rdo_ser.UseVisualStyleBackColor = true;
            this.rdo_ser.CheckedChanged += new System.EventHandler(this.rdo_ser_CheckedChanged);
            // 
            // rdo_net
            // 
            this.rdo_net.AutoSize = true;
            this.rdo_net.Location = new System.Drawing.Point(188, 70);
            this.rdo_net.Name = "rdo_net";
            this.rdo_net.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.rdo_net.Size = new System.Drawing.Size(50, 17);
            this.rdo_net.TabIndex = 21;
            this.rdo_net.TabStop = true;
            this.rdo_net.Text = "‘»ﬂÂ";
            this.rdo_net.UseVisualStyleBackColor = true;
            this.rdo_net.CheckedChanged += new System.EventHandler(this.rdo_net_CheckedChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(100, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(68, 13);
            this.label1.TabIndex = 22;
            this.label1.Text = "ÅÊ—  ”—Ì«· :";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // serial_port
            // 
            this.serial_port.FormattingEnabled = true;
            this.serial_port.Location = new System.Drawing.Point(14, 22);
            this.serial_port.Name = "serial_port";
            this.serial_port.Size = new System.Drawing.Size(82, 21);
            this.serial_port.TabIndex = 23;
            this.serial_port.Text = "COM1";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(301, 308);
            this.button1.Margin = new System.Windows.Forms.Padding(2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(97, 29);
            this.button1.TabIndex = 24;
            this.button1.Text = " «ÌÌœ";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button2.Location = new System.Drawing.Point(53, 308);
            this.button2.Margin = new System.Windows.Forms.Padding(2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(97, 29);
            this.button2.TabIndex = 25;
            this.button2.Text = "·€Ê";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // device_type
            // 
            this.device_type.FormattingEnabled = true;
            this.device_type.Items.AddRange(new object[] {
            "CLK6000"});
            this.device_type.Location = new System.Drawing.Point(211, 36);
            this.device_type.Margin = new System.Windows.Forms.Padding(2);
            this.device_type.Name = "device_type";
            this.device_type.Size = new System.Drawing.Size(90, 21);
            this.device_type.TabIndex = 26;
            this.device_type.Text = "CLK6000";
            this.device_type.SelectedIndexChanged += new System.EventHandler(this.device_type_SelectedIndexChanged);
            this.device_type.TextChanged += new System.EventHandler(this.device_type_TextChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(326, 39);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(33, 13);
            this.label5.TabIndex = 27;
            this.label5.Text = "‰Ê⁄  :";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(333, 74);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(26, 13);
            this.label6.TabIndex = 28;
            this.label6.Text = "‰«„ :";
            // 
            // device_name
            // 
            this.device_name.Location = new System.Drawing.Point(211, 74);
            this.device_name.Margin = new System.Windows.Forms.Padding(2);
            this.device_name.Name = "device_name";
            this.device_name.Size = new System.Drawing.Size(90, 20);
            this.device_name.TabIndex = 29;
            this.device_name.Text = "œ” ê«Â ‘„«—Â 1";
            // 
            // device_address
            // 
            this.device_address.Location = new System.Drawing.Point(33, 57);
            this.device_address.Margin = new System.Windows.Forms.Padding(2);
            this.device_address.Maximum = new decimal(new int[] {
            255,
            0,
            0,
            0});
            this.device_address.Name = "device_address";
            this.device_address.Size = new System.Drawing.Size(48, 20);
            this.device_address.TabIndex = 30;
            this.device_address.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(109, 59);
            this.label7.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(36, 13);
            this.label7.TabIndex = 31;
            this.label7.Text = "¬œ—” :";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.device_address);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.device_name);
            this.groupBox1.Controls.Add(this.device_type);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Location = new System.Drawing.Point(20, 11);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(2);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(2);
            this.groupBox1.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.groupBox1.Size = new System.Drawing.Size(409, 133);
            this.groupBox1.TabIndex = 32;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = " ‰ŸÌ„«  œ” ê«Â";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.rdo_ser);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.serial_port);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.ebx_port);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.ebx_ip);
            this.groupBox2.Controls.Add(this.rdo_net);
            this.groupBox2.Controls.Add(this.serial_baud);
            this.groupBox2.Location = new System.Drawing.Point(20, 162);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(2);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(2);
            this.groupBox2.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.groupBox2.Size = new System.Drawing.Size(409, 119);
            this.groupBox2.TabIndex = 33;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = " ‰ŸÌ„«  « ’«·";
            // 
            // PhisycalLayer
            // 
            this.AcceptButton = this.button1;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightSteelBlue;
            this.CancelButton = this.button2;
            this.ClientSize = new System.Drawing.Size(456, 361);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "PhisycalLayer";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Device Settings";
            this.Load += new System.EventHandler(this.PhisycalLayer_Load);
            ((System.ComponentModel.ISupportInitialize)(this.device_address)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RadioButton rdo_ser;
        private System.Windows.Forms.RadioButton rdo_net;
        private System.Windows.Forms.ComboBox serial_port;
        private System.Windows.Forms.ComboBox device_type;
        private System.Windows.Forms.TextBox device_name;
        private System.Windows.Forms.NumericUpDown device_address;
        private System.Windows.Forms.ComboBox serial_baud;
        private System.Windows.Forms.TextBox ebx_port;
        private System.Windows.Forms.TextBox ebx_ip;
        private System.Windows.Forms.Button button1;
    }
}
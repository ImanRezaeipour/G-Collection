using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Runtime.InteropServices;
namespace WindowsApplication3
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		const   int ALL_COLLECTION = 1;
		const   int ALL_RECOVERY   = 2;
		const   int NEW_RECOVERY   = 3;

		const   int ERR_NONE     = 1;
		const   int ERR_TIMEOUT  = 2;
		const   int ERR_CHEKSUM  = 3;
		const   int ERR_STX      = 4;
		const   int ERR_ETX      = 5;
		const   int ERR_OFF      = 6;
		const   int MB_BUFFEMPTY = 7;
		const   byte MB_TRUEREC   = 8;
		const   int MB_BADREC    = 9;
		const   int MB_BADDATA   = 10;
		const   int MTT_OFFLINE  = 15;		

		const   int RDR_Z84   = 101;

		const   int PRN_LX          = 0;
		const   int PRN_LQ          = 1;
		const   int PRN_CITIZEN3551 = 2;
		const   int PRN_CITIZEN3541 = 3;
		const   int PRN_ITHACA      = 4;



		byte retVal;
		bool is98 = false;
		private System.Windows.Forms.Label lblResult;
		private System.Windows.Forms.ListBox lstData;
		private System.Windows.Forms.Button btnOnline;
		private System.Windows.Forms.Button btnLinkTest;
		private System.Windows.Forms.Button btnCollectAll;
		private System.Windows.Forms.TabPage tabPage3;
		private System.Windows.Forms.TextBox txtAuthority;
		private System.Windows.Forms.TabPage tabPage4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Button btnMsgtoPerson;
		private System.Windows.Forms.Button btnMsgtoReader;
		private System.Windows.Forms.TextBox txtMsg1;
		private System.Windows.Forms.TextBox txtMsg2;
		private System.Windows.Forms.TextBox txtMsg3;
		private System.Windows.Forms.TextBox txtMsg4;
		private System.Windows.Forms.TextBox txtCardNo;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.Button btnDelMsg;
		private System.Windows.Forms.Button btnDelAllMsg;
		private System.Windows.Forms.TabPage tabPage5;
		private System.Windows.Forms.Button btnGetTable;
		private System.Windows.Forms.Button btnSendTable;
		private System.Windows.Forms.Button btnGetOnlyCard;
		private System.Windows.Forms.Button btnSendOnlyCard;
		private System.Windows.Forms.TextBox txtOnlyCard;
		private System.Windows.Forms.TextBox txtRecoveryDate;
		private System.Windows.Forms.Button btnRecoveryAll;
		private System.Windows.Forms.TabPage tabPage6;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.TextBox textBox1;
        private TabPage tabPage7;
        private Label label8;
        private Button btnSetFunctionKeys;
        private TextBox txtF4;
        private TextBox txtF3;
        private TextBox txtF2;
        private TextBox txtF1;
        private Label label11;
        private Label label10;
        private Label label9;
        private Button btnGetFunctionKeys;
        private CheckBox chkChangeFunctionKeysActive;
		private System.Windows.Forms.Label label3;
		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_LinkTest",  SetLastError=true,
			 CharSet=CharSet.Unicode, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_LinkTest(byte readerCode, int BaudRate, byte comPort, byte protocol, bool is98);

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_ReStart",  SetLastError=true,
			 CharSet=CharSet.Unicode, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_ReStart(byte readerCode, int BaudRate, byte comPort, byte protocol, bool is98);

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_ReadVersion",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_ReadVersion(byte readerCode, int BaudRate, byte comPort, byte protocol, ref string VersionST, bool is98);


		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_GetRecord",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetRecord(byte readerCode, int BaudRate, byte comPort, byte protocol, byte rType , string Date , bool IsFirst, ref byte retVal , ref string Data , bool is98);
		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_SetAuthority",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SetAuthority(byte readerCode, int BaudRate, byte comPort, byte protocol , string CardNoList , bool is98);											   
		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_GetAuthority",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetAuthority(byte readerCode, int BaudRate, byte comPort, byte protocol , ref string CardNoList , bool is98);											   

		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_SetOnlyCards",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SetOnlyCards(byte readerCode, int BaudRate, byte comPort, byte protocol , string CardNoList , bool is98);											   
		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_GetOnlyCards",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetOnlyCards(byte readerCode, int BaudRate, byte comPort, byte protocol , ref string CardNoList , bool is98);											   


		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_SendReaderMsg",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SendReaderMsg(byte readerCode, int BaudRate, byte comPort, byte protocol , string msg1 , string msg2, string msg3, string msg4, bool is98);											   

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_SendPersonMsg",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SendPersonMsg(byte readerCode, int BaudRate, byte comPort, byte protocol , string CardNo , string msg , bool is98);											   
		
		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_DelPersonMsg",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_DelPersonMsg(byte readerCode, int BaudRate, byte comPort, byte protocol , string CardNo, bool is98);											   

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_DeleteAllReaderMessage",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_DeleteAllReaderMessage(byte readerCode, int BaudRate, byte comPort, byte protocol , bool is98);											   

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_PrintToReaders",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_PrintToReaders(byte readerCode, int BaudRate, byte comPort, byte protocol ,byte printer_type , string st ,bool DblWidth , bool color , bool is98);											   

		[DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint="Z84_SetFunctionKeys",  SetLastError=true,
			 CharSet=CharSet.Unicode, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
        public static extern bool Z84_SetFunctionKeys(byte readerCode, int BaudRate, byte comPort, byte protocol, byte FKey1, byte FKey2, byte FKey3, byte FKey4, bool is98);

        [DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint = "Z84_ChangeFunctionKeysActive", SetLastError = true,
             CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool Z84_ChangeFunctionKeysActive(byte readerCode, int BaudRate, byte comPort, byte protocol,bool KeyActive, bool is98);

        [DllImport("..\\..\\..\\..\\..\\Z84SDK.dll", EntryPoint = "Z84_GetFunctionKeys", SetLastError = true,
             CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool Z84_GetFunctionKeys(byte readerCode, int BaudRate, byte comPort, byte protocol, ref byte FKey1, ref byte FKey2, ref byte FKey3, ref byte FKey4, bool is98);

		private System.Timers.Timer timer1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox txtCode;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage tabPage1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.ComboBox cmbBaud;
		private System.Windows.Forms.ComboBox cmbComPort;
		private System.Windows.Forms.TabPage tabPage2;
		
    	private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//		
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.timer1 = new System.Timers.Timer();
            this.btnOnline = new System.Windows.Forms.Button();
            this.txtCode = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.btnLinkTest = new System.Windows.Forms.Button();
            this.tabPage6 = new System.Windows.Forms.TabPage();
            this.label7 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.btnDelAllMsg = new System.Windows.Forms.Button();
            this.btnDelMsg = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.btnMsgtoReader = new System.Windows.Forms.Button();
            this.btnMsgtoPerson = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.txtCardNo = new System.Windows.Forms.TextBox();
            this.txtMsg4 = new System.Windows.Forms.TextBox();
            this.txtMsg3 = new System.Windows.Forms.TextBox();
            this.txtMsg2 = new System.Windows.Forms.TextBox();
            this.txtMsg1 = new System.Windows.Forms.TextBox();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.txtAuthority = new System.Windows.Forms.TextBox();
            this.btnGetTable = new System.Windows.Forms.Button();
            this.btnSendTable = new System.Windows.Forms.Button();
            this.tabPage5 = new System.Windows.Forms.TabPage();
            this.txtOnlyCard = new System.Windows.Forms.TextBox();
            this.btnGetOnlyCard = new System.Windows.Forms.Button();
            this.btnSendOnlyCard = new System.Windows.Forms.Button();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.txtRecoveryDate = new System.Windows.Forms.TextBox();
            this.btnRecoveryAll = new System.Windows.Forms.Button();
            this.lstData = new System.Windows.Forms.ListBox();
            this.btnCollectAll = new System.Windows.Forms.Button();
            this.cmbBaud = new System.Windows.Forms.ComboBox();
            this.cmbComPort = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.lblResult = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.tabPage7 = new System.Windows.Forms.TabPage();
            this.label8 = new System.Windows.Forms.Label();
            this.btnSetFunctionKeys = new System.Windows.Forms.Button();
            this.txtF4 = new System.Windows.Forms.TextBox();
            this.txtF3 = new System.Windows.Forms.TextBox();
            this.txtF2 = new System.Windows.Forms.TextBox();
            this.txtF1 = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.btnGetFunctionKeys = new System.Windows.Forms.Button();
            this.chkChangeFunctionKeysActive = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.timer1)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage6.SuspendLayout();
            this.tabPage4.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.tabPage5.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage7.SuspendLayout();
            this.SuspendLayout();
            // 
            // timer1
            // 
            this.timer1.Interval = 1000;
            this.timer1.SynchronizingObject = this.btnOnline;
            this.timer1.Elapsed += new System.Timers.ElapsedEventHandler(this.tmrOnline_Elapsed);
            // 
            // btnOnline
            // 
            this.btnOnline.ForeColor = System.Drawing.Color.Red;
            this.btnOnline.Location = new System.Drawing.Point(184, 16);
            this.btnOnline.Name = "btnOnline";
            this.btnOnline.Size = new System.Drawing.Size(128, 24);
            this.btnOnline.TabIndex = 4;
            this.btnOnline.Text = "جمع آوري دائمي";
            this.btnOnline.Click += new System.EventHandler(this.btnOnline_Click);
            // 
            // txtCode
            // 
            this.txtCode.Location = new System.Drawing.Point(208, 22);
            this.txtCode.Name = "txtCode";
            this.txtCode.Size = new System.Drawing.Size(40, 21);
            this.txtCode.TabIndex = 1;
            this.txtCode.Text = "1";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(128, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(71, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "سرعت ارتباط:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(256, 24);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(62, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "کد دستگاه :";
            // 
            // tabControl1
            // 
            this.tabControl1.Alignment = System.Windows.Forms.TabAlignment.Bottom;
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage6);
            this.tabControl1.Controls.Add(this.tabPage4);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Controls.Add(this.tabPage5);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage7);
            this.tabControl1.Location = new System.Drawing.Point(1, 88);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(328, 208);
            this.tabControl1.TabIndex = 5;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.button3);
            this.tabPage1.Controls.Add(this.button2);
            this.tabPage1.Controls.Add(this.btnLinkTest);
            this.tabPage1.Location = new System.Drawing.Point(4, 4);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Size = new System.Drawing.Size(320, 182);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "عمليات اوليه";
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(96, 96);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(128, 24);
            this.button3.TabIndex = 3;
            this.button3.Text = "خواندن نسخه دستگاه";
            this.button3.Click += new System.EventHandler(this.btnReadVersion_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(96, 64);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(128, 24);
            this.button2.TabIndex = 2;
            this.button2.Text = "راه اندازي مجدد ";
            this.button2.Click += new System.EventHandler(this.btnRestart_Click);
            // 
            // btnLinkTest
            // 
            this.btnLinkTest.Location = new System.Drawing.Point(96, 32);
            this.btnLinkTest.Name = "btnLinkTest";
            this.btnLinkTest.Size = new System.Drawing.Size(128, 24);
            this.btnLinkTest.TabIndex = 1;
            this.btnLinkTest.Text = "تست ارتباط";
            this.btnLinkTest.Click += new System.EventHandler(this.btnLinkTest_Click);
            // 
            // tabPage6
            // 
            this.tabPage6.Controls.Add(this.label7);
            this.tabPage6.Controls.Add(this.button1);
            this.tabPage6.Controls.Add(this.textBox1);
            this.tabPage6.Location = new System.Drawing.Point(4, 4);
            this.tabPage6.Name = "tabPage6";
            this.tabPage6.Size = new System.Drawing.Size(320, 182);
            this.tabPage6.TabIndex = 5;
            this.tabPage6.Text = "ارسال پرينت";
            // 
            // label7
            // 
            this.label7.Location = new System.Drawing.Point(240, 8);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(64, 16);
            this.label7.TabIndex = 11;
            this.label7.Text = "متن پيام";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(84, 137);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(160, 32);
            this.button1.TabIndex = 10;
            this.button1.Text = "پرينت";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(8, 32);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(296, 96);
            this.textBox1.TabIndex = 9;
            // 
            // tabPage4
            // 
            this.tabPage4.Controls.Add(this.btnDelAllMsg);
            this.tabPage4.Controls.Add(this.btnDelMsg);
            this.tabPage4.Controls.Add(this.label6);
            this.tabPage4.Controls.Add(this.btnMsgtoReader);
            this.tabPage4.Controls.Add(this.btnMsgtoPerson);
            this.tabPage4.Controls.Add(this.label5);
            this.tabPage4.Controls.Add(this.txtCardNo);
            this.tabPage4.Controls.Add(this.txtMsg4);
            this.tabPage4.Controls.Add(this.txtMsg3);
            this.tabPage4.Controls.Add(this.txtMsg2);
            this.tabPage4.Controls.Add(this.txtMsg1);
            this.tabPage4.Location = new System.Drawing.Point(4, 4);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Size = new System.Drawing.Size(320, 182);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "ارسال پيام";
            // 
            // btnDelAllMsg
            // 
            this.btnDelAllMsg.Location = new System.Drawing.Point(8, 112);
            this.btnDelAllMsg.Name = "btnDelAllMsg";
            this.btnDelAllMsg.Size = new System.Drawing.Size(120, 23);
            this.btnDelAllMsg.TabIndex = 10;
            this.btnDelAllMsg.Text = "حذف کليه پيامها";
            this.btnDelAllMsg.Click += new System.EventHandler(this.btnDelAllMsg_Click);
            // 
            // btnDelMsg
            // 
            this.btnDelMsg.Location = new System.Drawing.Point(8, 82);
            this.btnDelMsg.Name = "btnDelMsg";
            this.btnDelMsg.Size = new System.Drawing.Size(120, 23);
            this.btnDelMsg.TabIndex = 9;
            this.btnDelMsg.Text = "حذف پيام  فرد";
            this.btnDelMsg.Click += new System.EventHandler(this.btnDelMsg_Click);
            // 
            // label6
            // 
            this.label6.Location = new System.Drawing.Point(240, 5);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(64, 16);
            this.label6.TabIndex = 8;
            this.label6.Text = "متن پيام";
            // 
            // btnMsgtoReader
            // 
            this.btnMsgtoReader.Location = new System.Drawing.Point(144, 128);
            this.btnMsgtoReader.Name = "btnMsgtoReader";
            this.btnMsgtoReader.Size = new System.Drawing.Size(160, 32);
            this.btnMsgtoReader.TabIndex = 7;
            this.btnMsgtoReader.Text = "ارسال مستقيم پيام به دستگاه";
            this.btnMsgtoReader.Click += new System.EventHandler(this.btnMsgtoReader_Click);
            // 
            // btnMsgtoPerson
            // 
            this.btnMsgtoPerson.Location = new System.Drawing.Point(8, 52);
            this.btnMsgtoPerson.Name = "btnMsgtoPerson";
            this.btnMsgtoPerson.Size = new System.Drawing.Size(120, 23);
            this.btnMsgtoPerson.TabIndex = 6;
            this.btnMsgtoPerson.Text = "ارسال پيام به فرد";
            this.btnMsgtoPerson.Click += new System.EventHandler(this.btnMsgtoPerson_Click);
            // 
            // label5
            // 
            this.label5.Location = new System.Drawing.Point(64, 5);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(64, 16);
            this.label5.TabIndex = 5;
            this.label5.Text = "شماره کارت";
            // 
            // txtCardNo
            // 
            this.txtCardNo.Location = new System.Drawing.Point(8, 24);
            this.txtCardNo.Name = "txtCardNo";
            this.txtCardNo.Size = new System.Drawing.Size(120, 21);
            this.txtCardNo.TabIndex = 4;
            // 
            // txtMsg4
            // 
            this.txtMsg4.Location = new System.Drawing.Point(136, 92);
            this.txtMsg4.Name = "txtMsg4";
            this.txtMsg4.Size = new System.Drawing.Size(168, 21);
            this.txtMsg4.TabIndex = 3;
            // 
            // txtMsg3
            // 
            this.txtMsg3.Location = new System.Drawing.Point(136, 69);
            this.txtMsg3.Name = "txtMsg3";
            this.txtMsg3.Size = new System.Drawing.Size(168, 21);
            this.txtMsg3.TabIndex = 2;
            // 
            // txtMsg2
            // 
            this.txtMsg2.Location = new System.Drawing.Point(136, 46);
            this.txtMsg2.Name = "txtMsg2";
            this.txtMsg2.Size = new System.Drawing.Size(168, 21);
            this.txtMsg2.TabIndex = 1;
            // 
            // txtMsg1
            // 
            this.txtMsg1.Location = new System.Drawing.Point(136, 23);
            this.txtMsg1.Name = "txtMsg1";
            this.txtMsg1.Size = new System.Drawing.Size(168, 21);
            this.txtMsg1.TabIndex = 0;
            // 
            // tabPage3
            // 
            this.tabPage3.Controls.Add(this.txtAuthority);
            this.tabPage3.Controls.Add(this.btnGetTable);
            this.tabPage3.Controls.Add(this.btnSendTable);
            this.tabPage3.Location = new System.Drawing.Point(4, 4);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(320, 182);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "ليست افراد مجاز";
            // 
            // txtAuthority
            // 
            this.txtAuthority.Location = new System.Drawing.Point(133, 10);
            this.txtAuthority.Multiline = true;
            this.txtAuthority.Name = "txtAuthority";
            this.txtAuthority.Size = new System.Drawing.Size(176, 160);
            this.txtAuthority.TabIndex = 11;
            // 
            // btnGetTable
            // 
            this.btnGetTable.Location = new System.Drawing.Point(16, 80);
            this.btnGetTable.Name = "btnGetTable";
            this.btnGetTable.Size = new System.Drawing.Size(105, 23);
            this.btnGetTable.TabIndex = 8;
            this.btnGetTable.Text = "دريافت ليست";
            this.btnGetTable.Click += new System.EventHandler(this.btnGetTable_Click);
            // 
            // btnSendTable
            // 
            this.btnSendTable.Location = new System.Drawing.Point(16, 40);
            this.btnSendTable.Name = "btnSendTable";
            this.btnSendTable.Size = new System.Drawing.Size(104, 23);
            this.btnSendTable.TabIndex = 7;
            this.btnSendTable.Text = "ارسال ليست";
            this.btnSendTable.Click += new System.EventHandler(this.btnSendTable_Click);
            // 
            // tabPage5
            // 
            this.tabPage5.Controls.Add(this.txtOnlyCard);
            this.tabPage5.Controls.Add(this.btnGetOnlyCard);
            this.tabPage5.Controls.Add(this.btnSendOnlyCard);
            this.tabPage5.Location = new System.Drawing.Point(4, 4);
            this.tabPage5.Name = "tabPage5";
            this.tabPage5.Size = new System.Drawing.Size(320, 182);
            this.tabPage5.TabIndex = 4;
            this.tabPage5.Text = "افراد فقط کارت";
            // 
            // txtOnlyCard
            // 
            this.txtOnlyCard.Location = new System.Drawing.Point(131, 11);
            this.txtOnlyCard.Multiline = true;
            this.txtOnlyCard.Name = "txtOnlyCard";
            this.txtOnlyCard.Size = new System.Drawing.Size(176, 160);
            this.txtOnlyCard.TabIndex = 14;
            // 
            // btnGetOnlyCard
            // 
            this.btnGetOnlyCard.Location = new System.Drawing.Point(14, 128);
            this.btnGetOnlyCard.Name = "btnGetOnlyCard";
            this.btnGetOnlyCard.Size = new System.Drawing.Size(105, 23);
            this.btnGetOnlyCard.TabIndex = 13;
            this.btnGetOnlyCard.Text = "دريافت ليست";
            this.btnGetOnlyCard.Click += new System.EventHandler(this.btnGetOnlyCard_Click);
            // 
            // btnSendOnlyCard
            // 
            this.btnSendOnlyCard.Location = new System.Drawing.Point(14, 88);
            this.btnSendOnlyCard.Name = "btnSendOnlyCard";
            this.btnSendOnlyCard.Size = new System.Drawing.Size(104, 23);
            this.btnSendOnlyCard.TabIndex = 12;
            this.btnSendOnlyCard.Text = "ارسال ليست";
            this.btnSendOnlyCard.Click += new System.EventHandler(this.btnSendOnlyCard_Click);
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.txtRecoveryDate);
            this.tabPage2.Controls.Add(this.btnRecoveryAll);
            this.tabPage2.Controls.Add(this.lstData);
            this.tabPage2.Controls.Add(this.btnOnline);
            this.tabPage2.Controls.Add(this.btnCollectAll);
            this.tabPage2.Location = new System.Drawing.Point(4, 4);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Size = new System.Drawing.Size(320, 182);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "جمع آوري اطلاعات";
            // 
            // txtRecoveryDate
            // 
            this.txtRecoveryDate.Location = new System.Drawing.Point(208, 108);
            this.txtRecoveryDate.Name = "txtRecoveryDate";
            this.txtRecoveryDate.Size = new System.Drawing.Size(72, 21);
            this.txtRecoveryDate.TabIndex = 7;
            this.txtRecoveryDate.Text = "1385/02/01";
            // 
            // btnRecoveryAll
            // 
            this.btnRecoveryAll.Location = new System.Drawing.Point(184, 80);
            this.btnRecoveryAll.Name = "btnRecoveryAll";
            this.btnRecoveryAll.Size = new System.Drawing.Size(128, 24);
            this.btnRecoveryAll.TabIndex = 6;
            this.btnRecoveryAll.Text = "بازيابي اطلاعات";
            this.btnRecoveryAll.Click += new System.EventHandler(this.btnRecoveryAll_Click);
            // 
            // lstData
            // 
            this.lstData.Location = new System.Drawing.Point(8, 8);
            this.lstData.Name = "lstData";
            this.lstData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.lstData.Size = new System.Drawing.Size(171, 160);
            this.lstData.TabIndex = 5;
            // 
            // btnCollectAll
            // 
            this.btnCollectAll.Location = new System.Drawing.Point(184, 48);
            this.btnCollectAll.Name = "btnCollectAll";
            this.btnCollectAll.Size = new System.Drawing.Size(128, 24);
            this.btnCollectAll.TabIndex = 3;
            this.btnCollectAll.Text = "جمع آوري اطلاعات جديد";
            this.btnCollectAll.Click += new System.EventHandler(this.btnCollectAll_Click);
            // 
            // cmbBaud
            // 
            this.cmbBaud.Items.AddRange(new object[] {
            "4800",
            "9600",
            "19200",
            "38400"});
            this.cmbBaud.Location = new System.Drawing.Point(8, 22);
            this.cmbBaud.Name = "cmbBaud";
            this.cmbBaud.Size = new System.Drawing.Size(112, 21);
            this.cmbBaud.TabIndex = 6;
            this.cmbBaud.Text = "38400";
            // 
            // cmbComPort
            // 
            this.cmbComPort.Items.AddRange(new object[] {
            "Com1",
            "Com2",
            "Com3",
            "Com4",
            "Com5",
            "Com6"});
            this.cmbComPort.Location = new System.Drawing.Point(8, 56);
            this.cmbComPort.Name = "cmbComPort";
            this.cmbComPort.Size = new System.Drawing.Size(112, 21);
            this.cmbComPort.TabIndex = 7;
            this.cmbComPort.Text = "Com1";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(128, 59);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(67, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "پورت سريال :";
            // 
            // lblResult
            // 
            this.lblResult.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblResult.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.lblResult.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.lblResult.Location = new System.Drawing.Point(20, 336);
            this.lblResult.Name = "lblResult";
            this.lblResult.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.lblResult.Size = new System.Drawing.Size(288, 84);
            this.lblResult.TabIndex = 10;
            this.lblResult.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.label3.ForeColor = System.Drawing.Color.Red;
            this.label3.Location = new System.Drawing.Point(156, 316);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 16);
            this.label3.TabIndex = 9;
            this.label3.Text = "نتيجه";
            // 
            // tabPage7
            // 
            this.tabPage7.Controls.Add(this.chkChangeFunctionKeysActive);
            this.tabPage7.Controls.Add(this.btnGetFunctionKeys);
            this.tabPage7.Controls.Add(this.label11);
            this.tabPage7.Controls.Add(this.label10);
            this.tabPage7.Controls.Add(this.label9);
            this.tabPage7.Controls.Add(this.label8);
            this.tabPage7.Controls.Add(this.btnSetFunctionKeys);
            this.tabPage7.Controls.Add(this.txtF4);
            this.tabPage7.Controls.Add(this.txtF3);
            this.tabPage7.Controls.Add(this.txtF2);
            this.tabPage7.Controls.Add(this.txtF1);
            this.tabPage7.Location = new System.Drawing.Point(4, 4);
            this.tabPage7.Name = "tabPage7";
            this.tabPage7.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage7.Size = new System.Drawing.Size(320, 182);
            this.tabPage7.TabIndex = 6;
            this.tabPage7.Text = "معرفی کلیدهای عمیاتی";
            this.tabPage7.UseVisualStyleBackColor = true;
            // 
            // label8
            // 
            this.label8.Location = new System.Drawing.Point(247, 12);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(64, 16);
            this.label8.TabIndex = 14;
            this.label8.Text = "کلید F1";
            // 
            // btnSetFunctionKeys
            // 
            this.btnSetFunctionKeys.Location = new System.Drawing.Point(168, 143);
            this.btnSetFunctionKeys.Name = "btnSetFunctionKeys";
            this.btnSetFunctionKeys.Size = new System.Drawing.Size(135, 23);
            this.btnSetFunctionKeys.TabIndex = 13;
            this.btnSetFunctionKeys.Text = "تنظیم کلیدهای عملیاتی";
            this.btnSetFunctionKeys.Click += new System.EventHandler(this.button4_Click);
            // 
            // txtF4
            // 
            this.txtF4.Location = new System.Drawing.Point(73, 90);
            this.txtF4.Name = "txtF4";
            this.txtF4.Size = new System.Drawing.Size(168, 21);
            this.txtF4.TabIndex = 12;
            // 
            // txtF3
            // 
            this.txtF3.Location = new System.Drawing.Point(73, 63);
            this.txtF3.Name = "txtF3";
            this.txtF3.Size = new System.Drawing.Size(168, 21);
            this.txtF3.TabIndex = 11;
            // 
            // txtF2
            // 
            this.txtF2.Location = new System.Drawing.Point(73, 36);
            this.txtF2.Name = "txtF2";
            this.txtF2.Size = new System.Drawing.Size(168, 21);
            this.txtF2.TabIndex = 10;
            // 
            // txtF1
            // 
            this.txtF1.Location = new System.Drawing.Point(73, 9);
            this.txtF1.Name = "txtF1";
            this.txtF1.Size = new System.Drawing.Size(168, 21);
            this.txtF1.TabIndex = 9;
            // 
            // label9
            // 
            this.label9.Location = new System.Drawing.Point(247, 39);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(64, 16);
            this.label9.TabIndex = 15;
            this.label9.Text = "کلید F2";
            // 
            // label10
            // 
            this.label10.Location = new System.Drawing.Point(247, 66);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(64, 16);
            this.label10.TabIndex = 16;
            this.label10.Text = "کلید F3";
            // 
            // label11
            // 
            this.label11.Location = new System.Drawing.Point(247, 93);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(64, 16);
            this.label11.TabIndex = 17;
            this.label11.Text = "کلید F4";
            // 
            // btnGetFunctionKeys
            // 
            this.btnGetFunctionKeys.Location = new System.Drawing.Point(15, 143);
            this.btnGetFunctionKeys.Name = "btnGetFunctionKeys";
            this.btnGetFunctionKeys.Size = new System.Drawing.Size(135, 23);
            this.btnGetFunctionKeys.TabIndex = 18;
            this.btnGetFunctionKeys.Text = "خواندن کلیدهای عملیاتی";
            this.btnGetFunctionKeys.Click += new System.EventHandler(this.btnGetFunctionKeys_Click);
            // 
            // chkChangeFunctionKeysActive
            // 
            this.chkChangeFunctionKeysActive.AutoSize = true;
            this.chkChangeFunctionKeysActive.Location = new System.Drawing.Point(150, 120);
            this.chkChangeFunctionKeysActive.Name = "chkChangeFunctionKeysActive";
            this.chkChangeFunctionKeysActive.Size = new System.Drawing.Size(158, 17);
            this.chkChangeFunctionKeysActive.TabIndex = 19;
            this.chkChangeFunctionKeysActive.Text = "فعال نمودن کلیدهای عمیاتی";
            this.chkChangeFunctionKeysActive.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
            this.ClientSize = new System.Drawing.Size(328, 429);
            this.Controls.Add(this.lblResult);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cmbComPort);
            this.Controls.Add(this.cmbBaud);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtCode);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.Name = "Form1";
            this.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.timer1)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage6.ResumeLayout(false);
            this.tabPage6.PerformLayout();
            this.tabPage4.ResumeLayout(false);
            this.tabPage4.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            this.tabPage5.ResumeLayout(false);
            this.tabPage5.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.tabPage7.ResumeLayout(false);
            this.tabPage7.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		
		bool OnlineIsFirst = true;
		
		private void btnLinkTest_Click(object sender, System.EventArgs e)
		{
			if (Z84_LinkTest(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, is98))
				lblResult.Text = "ارتباط برقرار است .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}

		private void btnRestart_Click(object sender, System.EventArgs e)
		{
			if (Z84_ReStart(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, is98))
				lblResult.Text = "دستگاه راه اندازي شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}

		private void btnReadVersion_Click(object sender, System.EventArgs e)
		{
			string VerStr = "";
			if (Z84_ReadVersion(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ref VerStr ,is98))
				lblResult.Text = VerStr;
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}
		

		private void btnCollectAll_Click(object sender, System.EventArgs e)
		{
			bool isFirst = false;
			string data="";
			int n=0;
			int recCount=0;
			lstData.Items.Clear();
			do 
			{   
				Z84_GetRecord(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ALL_COLLECTION, "1385/02/19", isFirst, ref retVal, ref data,is98);
				if (retVal == MB_TRUEREC)
				{
					isFirst = false;
					lstData.Items.Add(data);
					n = 0;
					recCount += 1;
				}
				else
				{
					isFirst = true;
					n += 1;
				}
				lstData.Refresh();
			}
			while ((retVal != MB_BUFFEMPTY) && (retVal != ERR_OFF) && (n < 2));

			if (retVal == MB_BUFFEMPTY)
			{
				if (recCount == 0)
					lblResult.Text = "رکورد جديدي وجود ندارد .";
				else
					lblResult.Text = Convert.ToString(recCount) + " رکورد بطور کامل جمع آوري شد .";
			}
			else
			{
				if (recCount == 0)
					lblResult.Text = "عدم برقراري ارتباط";
				else
					lblResult.Text = Convert.ToString(recCount) + " رکورد بطور ناقص جمع آوري شد .";
			}
		
		}

		private void btnOnline_Click(object sender, System.EventArgs e)
		{
			timer1.Enabled = !timer1.Enabled;
			if (timer1.Enabled)
				btnOnline.Text = "جمع آوري دائمي : فعال";
			else
				btnOnline.Text = "جمع آوري دائمي : غير فعال";

		}

		private void tmrOnline_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			if (btnOnline.ForeColor == System.Drawing.Color.Red)
				btnOnline.ForeColor = System.Drawing.Color.Black;
			else
				btnOnline.ForeColor = System.Drawing.Color.Red;
			string data="";
			Z84_GetRecord(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ALL_COLLECTION, "", OnlineIsFirst, ref retVal, ref data,is98);
			if (retVal == MB_TRUEREC)
			{
				OnlineIsFirst = false;
				lstData.Items.Add(data);
			}
			else
			{
				OnlineIsFirst = true;
			}
			lstData.Refresh();
		}

		private void btnSendTable_Click(object sender, System.EventArgs e)
		{
			string Lst = "";

            foreach (string s in txtAuthority.Lines)
			{
				for(int i=1 ; i<= (8 - s.Length);i++)
					Lst = Lst + "0";
				Lst = Lst + s;
			}
			Lst = Lst + "FFFFFFFF";	
			if (Z84_SetAuthority(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, Lst ,is98))
				lblResult.Text = "جدول ارسال شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}
		
		private void btnGetTable_Click(object sender, System.EventArgs e)
		{
			
			string Lst = "";
			if (Z84_GetAuthority(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ref Lst ,is98))
			{
				lblResult.Text = "جدول دريافت شد .";
				txtAuthority.Clear();
				int i=0;
				for(i=0 ; i<= (Lst.Length / 8)-2 ;i++)
				{
					txtAuthority.Text = txtAuthority.Text + Lst.Substring(i*8,8);
					if (i< (Lst.Length / 8)-2)
						txtAuthority.Text = txtAuthority.Text + "\r\n";
				}

			}
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}
		
		private void btnMsgtoReader_Click(object sender, System.EventArgs e)
		{
			if (Z84_SendReaderMsg(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, txtMsg1.Text,txtMsg2.Text,txtMsg3.Text,txtMsg4.Text ,is98))
				lblResult.Text = "پيام ارسال شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}

		private void btnMsgtoPerson_Click(object sender, System.EventArgs e)
		{
			string msg = "";
			msg = msg + txtMsg1.Text;
			for(int i=1 ; i<= (16 - txtMsg1.Text.Length);i++)
				msg = msg + " ";
			msg = msg + txtMsg2.Text;
			for(int i=1 ; i<= (16 - txtMsg2.Text.Length);i++)
				msg = msg + " ";
			msg = msg + txtMsg3.Text;
			for(int i=1 ; i<= (16 - txtMsg3.Text.Length);i++)
				msg = msg + " ";
			msg = msg + txtMsg4.Text;
			for(int i=1 ; i<= (16 - txtMsg4.Text.Length);i++)
				msg = msg + " ";

			if (Z84_SendPersonMsg(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, txtCardNo.Text , msg,is98))
				lblResult.Text = "پيام ارسال شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";

		}

		private void btnDelMsg_Click(object sender, System.EventArgs e)
		{
			if (Z84_DelPersonMsg(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, txtCardNo.Text ,is98))
				lblResult.Text = "پيام حذف شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		}

		private void btnDelAllMsg_Click(object sender, System.EventArgs e)
		{
			if (Z84_DeleteAllReaderMessage(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84,is98))
				lblResult.Text = "تمام پيامها حذف شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
		
		}


		private void btnSendOnlyCard_Click(object sender, System.EventArgs e)
		{
			string Lst = "";

			foreach (string s in txtOnlyCard.Lines)
			{
				for(int i=1 ; i<= (8 - s.Length);i++)
					Lst = Lst + "0";
				Lst = Lst + s;
			}
			Lst = Lst + "FFFFFFFF";	
			if (Z84_SetOnlyCards(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, Lst ,is98))
				lblResult.Text = "جدول ارسال شد .";
			else
				lblResult.Text = "عدم برقراري ارتباط";
	
		}

		private void btnGetOnlyCard_Click(object sender, System.EventArgs e)
		{
			string Lst = "";
			if (Z84_GetOnlyCards(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ref Lst ,is98))
			{
				lblResult.Text = "جدول دريافت شد .";
				txtOnlyCard.Clear();
				int i=0;
				for(i=0 ; i<= (Lst.Length / 8)-2 ;i++)
				{
					txtOnlyCard.Text = txtOnlyCard.Text + Lst.Substring(i*8,8);
					if (i< (Lst.Length / 8)-2)
						txtOnlyCard.Text = txtOnlyCard.Text + "\r\n";
				}

			}
			else
				lblResult.Text = "عدم برقراري ارتباط";
		
		}

		private void btnRecoveryAll_Click(object sender, System.EventArgs e)
		{
			bool isFirst = false;
			string data="";
			int n=0;
			int recCount=0;
			lstData.Items.Clear();
			do 
			{   
				Z84_GetRecord(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ALL_RECOVERY, txtRecoveryDate.Text , isFirst, ref retVal, ref data,is98);
				if (retVal == MB_TRUEREC)
				{
					isFirst = false;
					lstData.Items.Add(data);
					n = 0;
					recCount += 1;
				}
				else
				{
					isFirst = true;
					n += 1;
				}
				lstData.Refresh();
			}
			while ((retVal != MB_BUFFEMPTY) && (retVal != ERR_OFF) && (n < 2));

			if (retVal == MB_BUFFEMPTY)
			{
				if (recCount == 0)
					lblResult.Text = "رکورد جديدي وجود ندارد .";
				else
					lblResult.Text = Convert.ToString(recCount) + " رکورد بطور کامل جمع آوري شد .";
			}
			else
			{
				if (recCount == 0)
					lblResult.Text = "عدم برقراري ارتباط";
				else
					lblResult.Text = Convert.ToString(recCount) + " رکورد بطور ناقص جمع آوري شد .";
			}
		
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			
//			for (int i =0;i<=10;i++)
//			{
				Z84_PrintToReaders(Convert.ToByte(txtCode.Text) , Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84 ,4,textBox1.Text ,false,false ,is98);
//			}
	
		}

        private void button4_Click(object sender, EventArgs e)
        {
            if (Z84_SetFunctionKeys(Convert.ToByte(txtCode.Text), Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, Convert.ToByte(txtF1.Text), Convert.ToByte(txtF2.Text), Convert.ToByte(txtF3.Text), Convert.ToByte(txtF4.Text), is98))
            {
                if (chkChangeFunctionKeysActive.Checked)
                    if (Z84_ChangeFunctionKeysActive(Convert.ToByte(txtCode.Text), Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, true, is98))
                        lblResult.Text = "کلیدهای عملیاتی تنظیم و فعال شد.";
                    else
                        lblResult.Text = "کلیدهای عملیاتی تنظیم شد ولی فعال نگردید.";
                else
                    if (Z84_ChangeFunctionKeysActive(Convert.ToByte(txtCode.Text), Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, false, is98))
                        lblResult.Text = "کلیدهای عملیاتی تنظیم و غیرفعال شد.";
                    else
                        lblResult.Text = "کلیدهای عملیاتی تنظیم شد ولی غیرفعال نگردید.";
            }
			else
            {
				lblResult.Text = "عدم برقراري ارتباط";
            }

        }

        private void btnGetFunctionKeys_Click(object sender, EventArgs e)
        {
            byte fkey1 = 0, fkey2 = 0, fkey3 = 0, fkey4 = 0;
            if (Z84_GetFunctionKeys(Convert.ToByte(txtCode.Text), Convert.ToInt32(cmbBaud.Text), Convert.ToByte(cmbComPort.SelectedIndex + 1), RDR_Z84, ref fkey1, ref fkey2, ref fkey3, ref fkey4, is98))
            {
                txtF1.Text = Convert.ToString(fkey1);
                txtF2.Text = Convert.ToString(fkey2);
                txtF3.Text = Convert.ToString(fkey3);
                txtF4.Text = Convert.ToString(fkey4);
                lblResult.Text = "کلیدهای عملیاتی خوانده شد.";
            }
            else
            {
                lblResult.Text = "عدم برقراري ارتباط";
            }
        }

		

		
	}
}

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
		private System.Windows.Forms.ComboBox cmbProtocol;
		private System.Windows.Forms.TextBox txtIP;
		private System.Windows.Forms.Label label3;
		//. .\\..\\..\\..\\..\\
		[DllImport("Z84SDK.dll", EntryPoint="Z84_LinkTest_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_LinkTest_LAN(byte readerCode, byte protocol, string IPAddress);

		[DllImport("Z84SDK.dll", EntryPoint="Z84_ReStart_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_ReStart_LAN(byte readerCode, byte protocol, string IPAddress);

		[DllImport("Z84SDK.dll", EntryPoint="Z84_ReadVersion_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_ReadVersion_LAN(byte readerCode, byte protocol, string IPAddress, ref string VersionST);


		[DllImport("Z84SDK.dll", EntryPoint="Z84_GetRecord_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetRecord_LAN(byte readerCode, byte protocol, string IPAddress, byte rType , string Date , bool IsFirst, ref byte retVal , ref string Data);
		
		[DllImport("Z84SDK.dll", EntryPoint="Z84_SetAuthority_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SetAuthority_LAN(byte readerCode, byte protocol, string IPAddress, string CardNoList);											   
		
		[DllImport("Z84SDK.dll", EntryPoint="Z84_GetAuthority_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetAuthority_LAN(byte readerCode, byte protocol, string IPAddress, ref string CardNoList);											   

		
		[DllImport("Z84SDK.dll", EntryPoint="Z84_SetOnlyCards_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SetOnlyCards_LAN(byte readerCode, byte protocol, string IPAddress, string CardNoList);											   
		
		[DllImport("Z84SDK.dll", EntryPoint="Z84_GetOnlyCards_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_GetOnlyCards_LAN(byte readerCode, byte protocol, string IPAddress , ref string CardNoList);											   


		[DllImport("Z84SDK.dll", EntryPoint="Z84_SendReaderMsg_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SendReaderMsg_LAN(byte readerCode, byte protocol, string IPAddress , string msg1 , string msg2, string msg3, string msg4);											   

		[DllImport("Z84SDK.dll", EntryPoint="Z84_SendPersonMsg_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_SendPersonMsg_LAN(byte readerCode, byte protocol, string IPAddress , string CardNo , string msg);											   
		
		[DllImport("Z84SDK.dll", EntryPoint="Z84_DelPersonMsg_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_DelPersonMsg_LAN(byte readerCode, byte protocol, string IPAddress , string CardNo);											   

		[DllImport("Z84SDK.dll", EntryPoint="Z84_DeleteAllReaderMessage_LAN",  SetLastError=true,
			 CharSet=CharSet.Ansi, ExactSpelling=true, CallingConvention=CallingConvention.StdCall)]
		public static extern bool Z84_DeleteAllReaderMessage_LAN(byte readerCode, byte protocol, string IPAddress);											   

		private System.Timers.Timer timer1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox txtCode;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage tabPage1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Label label4;
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
			this.tabPage2 = new System.Windows.Forms.TabPage();
			this.txtRecoveryDate = new System.Windows.Forms.TextBox();
			this.btnRecoveryAll = new System.Windows.Forms.Button();
			this.lstData = new System.Windows.Forms.ListBox();
			this.btnCollectAll = new System.Windows.Forms.Button();
			this.tabPage5 = new System.Windows.Forms.TabPage();
			this.txtOnlyCard = new System.Windows.Forms.TextBox();
			this.btnGetOnlyCard = new System.Windows.Forms.Button();
			this.btnSendOnlyCard = new System.Windows.Forms.Button();
			this.tabPage3 = new System.Windows.Forms.TabPage();
			this.txtAuthority = new System.Windows.Forms.TextBox();
			this.btnGetTable = new System.Windows.Forms.Button();
			this.btnSendTable = new System.Windows.Forms.Button();
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
			this.cmbProtocol = new System.Windows.Forms.ComboBox();
			this.label4 = new System.Windows.Forms.Label();
			this.lblResult = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.txtIP = new System.Windows.Forms.TextBox();
			((System.ComponentModel.ISupportInitialize)(this.timer1)).BeginInit();
			this.tabControl1.SuspendLayout();
			this.tabPage1.SuspendLayout();
			this.tabPage2.SuspendLayout();
			this.tabPage5.SuspendLayout();
			this.tabPage3.SuspendLayout();
			this.tabPage4.SuspendLayout();
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
			this.btnOnline.Text = "Ã„⁄ ¬Ê—Ì œ«∆„Ì";
			this.btnOnline.Click += new System.EventHandler(this.btnOnline_Click);
			// 
			// txtCode
			// 
			this.txtCode.Location = new System.Drawing.Point(72, 22);
			this.txtCode.Name = "txtCode";
			this.txtCode.Size = new System.Drawing.Size(72, 21);
			this.txtCode.TabIndex = 1;
			this.txtCode.Text = "1";
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Cursor = System.Windows.Forms.Cursors.VSplit;
			this.label1.Location = new System.Drawing.Point(8, 56);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(58, 17);
			this.label1.TabIndex = 2;
			this.label1.Text = "IP Address";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(32, 24);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(33, 17);
			this.label2.TabIndex = 3;
			this.label2.Text = "Code ";
			this.label2.Click += new System.EventHandler(this.label2_Click);
			// 
			// tabControl1
			// 
			this.tabControl1.Alignment = System.Windows.Forms.TabAlignment.Bottom;
			this.tabControl1.Controls.Add(this.tabPage1);
			this.tabControl1.Controls.Add(this.tabPage2);
			this.tabControl1.Controls.Add(this.tabPage5);
			this.tabControl1.Controls.Add(this.tabPage3);
			this.tabControl1.Controls.Add(this.tabPage4);
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
			this.tabPage1.Text = "⁄„·Ì«  «Ê·ÌÂ";
			// 
			// button3
			// 
			this.button3.Location = new System.Drawing.Point(96, 96);
			this.button3.Name = "button3";
			this.button3.Size = new System.Drawing.Size(128, 24);
			this.button3.TabIndex = 3;
			this.button3.Text = "ŒÊ«‰œ‰ ‰”ŒÂ œ” ê«Â";
			this.button3.Click += new System.EventHandler(this.btnReadVersion_Click);
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(96, 64);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(128, 24);
			this.button2.TabIndex = 2;
			this.button2.Text = "—«Â «‰œ«“Ì „Ãœœ ";
			this.button2.Click += new System.EventHandler(this.btnRestart_Click);
			// 
			// btnLinkTest
			// 
			this.btnLinkTest.Location = new System.Drawing.Point(96, 32);
			this.btnLinkTest.Name = "btnLinkTest";
			this.btnLinkTest.Size = new System.Drawing.Size(128, 24);
			this.btnLinkTest.TabIndex = 1;
			this.btnLinkTest.Text = " ”  «— »«ÿ";
			this.btnLinkTest.Click += new System.EventHandler(this.btnLinkTest_Click);
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
			this.tabPage2.Text = "Ã„⁄ ¬Ê—Ì «ÿ·«⁄« ";
			// 
			// txtRecoveryDate
			// 
			this.txtRecoveryDate.Location = new System.Drawing.Point(208, 108);
			this.txtRecoveryDate.Name = "txtRecoveryDate";
			this.txtRecoveryDate.Size = new System.Drawing.Size(72, 21);
			this.txtRecoveryDate.TabIndex = 7;
			this.txtRecoveryDate.Text = "1386/10/10";
			// 
			// btnRecoveryAll
			// 
			this.btnRecoveryAll.Location = new System.Drawing.Point(184, 80);
			this.btnRecoveryAll.Name = "btnRecoveryAll";
			this.btnRecoveryAll.Size = new System.Drawing.Size(128, 24);
			this.btnRecoveryAll.TabIndex = 6;
			this.btnRecoveryAll.Text = "»«“Ì«»Ì «ÿ·«⁄« ";
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
			this.btnCollectAll.Text = "Ã„⁄ ¬Ê—Ì «ÿ·«⁄«  ÃœÌœ";
			this.btnCollectAll.Click += new System.EventHandler(this.btnCollectAll_Click);
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
			this.tabPage5.Text = "«›—«œ ›ﬁÿ ò«— ";
			// 
			// txtOnlyCard
			// 
			this.txtOnlyCard.Location = new System.Drawing.Point(131, 11);
			this.txtOnlyCard.Multiline = true;
			this.txtOnlyCard.Name = "txtOnlyCard";
			this.txtOnlyCard.Size = new System.Drawing.Size(176, 160);
			this.txtOnlyCard.TabIndex = 14;
			this.txtOnlyCard.Text = "";
			// 
			// btnGetOnlyCard
			// 
			this.btnGetOnlyCard.Location = new System.Drawing.Point(14, 128);
			this.btnGetOnlyCard.Name = "btnGetOnlyCard";
			this.btnGetOnlyCard.Size = new System.Drawing.Size(105, 23);
			this.btnGetOnlyCard.TabIndex = 13;
			this.btnGetOnlyCard.Text = "œ—Ì«›  ·Ì” ";
			this.btnGetOnlyCard.Click += new System.EventHandler(this.btnGetOnlyCard_Click);
			// 
			// btnSendOnlyCard
			// 
			this.btnSendOnlyCard.Location = new System.Drawing.Point(14, 88);
			this.btnSendOnlyCard.Name = "btnSendOnlyCard";
			this.btnSendOnlyCard.Size = new System.Drawing.Size(104, 23);
			this.btnSendOnlyCard.TabIndex = 12;
			this.btnSendOnlyCard.Text = "«—”«· ·Ì” ";
			this.btnSendOnlyCard.Click += new System.EventHandler(this.btnSendOnlyCard_Click);
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
			this.tabPage3.Text = "·Ì”  «›—«œ „Ã«“";
			// 
			// txtAuthority
			// 
			this.txtAuthority.Location = new System.Drawing.Point(133, 10);
			this.txtAuthority.Multiline = true;
			this.txtAuthority.Name = "txtAuthority";
			this.txtAuthority.Size = new System.Drawing.Size(176, 160);
			this.txtAuthority.TabIndex = 11;
			this.txtAuthority.Text = "";
			// 
			// btnGetTable
			// 
			this.btnGetTable.Location = new System.Drawing.Point(16, 80);
			this.btnGetTable.Name = "btnGetTable";
			this.btnGetTable.Size = new System.Drawing.Size(105, 23);
			this.btnGetTable.TabIndex = 8;
			this.btnGetTable.Text = "œ—Ì«›  ·Ì” ";
			this.btnGetTable.Click += new System.EventHandler(this.btnGetTable_Click);
			// 
			// btnSendTable
			// 
			this.btnSendTable.Location = new System.Drawing.Point(16, 40);
			this.btnSendTable.Name = "btnSendTable";
			this.btnSendTable.Size = new System.Drawing.Size(104, 23);
			this.btnSendTable.TabIndex = 7;
			this.btnSendTable.Text = "«—”«· ·Ì” ";
			this.btnSendTable.Click += new System.EventHandler(this.btnSendTable_Click);
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
			this.tabPage4.Text = "«—”«· ÅÌ«„";
			// 
			// btnDelAllMsg
			// 
			this.btnDelAllMsg.Location = new System.Drawing.Point(8, 112);
			this.btnDelAllMsg.Name = "btnDelAllMsg";
			this.btnDelAllMsg.Size = new System.Drawing.Size(120, 23);
			this.btnDelAllMsg.TabIndex = 10;
			this.btnDelAllMsg.Text = "Õ–› ò·ÌÂ ÅÌ«„Â«";
			this.btnDelAllMsg.Click += new System.EventHandler(this.btnDelAllMsg_Click);
			// 
			// btnDelMsg
			// 
			this.btnDelMsg.Location = new System.Drawing.Point(8, 82);
			this.btnDelMsg.Name = "btnDelMsg";
			this.btnDelMsg.Size = new System.Drawing.Size(120, 23);
			this.btnDelMsg.TabIndex = 9;
			this.btnDelMsg.Text = "Õ–› ÅÌ«„  ›—œ";
			this.btnDelMsg.Click += new System.EventHandler(this.btnDelMsg_Click);
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(240, 5);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(64, 16);
			this.label6.TabIndex = 8;
			this.label6.Text = "„ ‰ ÅÌ«„";
			// 
			// btnMsgtoReader
			// 
			this.btnMsgtoReader.Location = new System.Drawing.Point(144, 128);
			this.btnMsgtoReader.Name = "btnMsgtoReader";
			this.btnMsgtoReader.Size = new System.Drawing.Size(160, 32);
			this.btnMsgtoReader.TabIndex = 7;
			this.btnMsgtoReader.Text = "«—”«· „” ﬁÌ„ ÅÌ«„ »Â œ” ê«Â";
			this.btnMsgtoReader.Click += new System.EventHandler(this.btnMsgtoReader_Click);
			// 
			// btnMsgtoPerson
			// 
			this.btnMsgtoPerson.Location = new System.Drawing.Point(8, 52);
			this.btnMsgtoPerson.Name = "btnMsgtoPerson";
			this.btnMsgtoPerson.Size = new System.Drawing.Size(120, 23);
			this.btnMsgtoPerson.TabIndex = 6;
			this.btnMsgtoPerson.Text = "«—”«· ÅÌ«„ »Â ›—œ";
			this.btnMsgtoPerson.Click += new System.EventHandler(this.btnMsgtoPerson_Click);
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(64, 5);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(64, 16);
			this.label5.TabIndex = 5;
			this.label5.Text = "‘„«—Â ò«— ";
			// 
			// txtCardNo
			// 
			this.txtCardNo.Location = new System.Drawing.Point(8, 24);
			this.txtCardNo.Name = "txtCardNo";
			this.txtCardNo.Size = new System.Drawing.Size(120, 21);
			this.txtCardNo.TabIndex = 4;
			this.txtCardNo.Text = "";
			// 
			// txtMsg4
			// 
			this.txtMsg4.Location = new System.Drawing.Point(136, 92);
			this.txtMsg4.Name = "txtMsg4";
			this.txtMsg4.Size = new System.Drawing.Size(168, 21);
			this.txtMsg4.TabIndex = 3;
			this.txtMsg4.Text = "";
			// 
			// txtMsg3
			// 
			this.txtMsg3.Location = new System.Drawing.Point(136, 69);
			this.txtMsg3.Name = "txtMsg3";
			this.txtMsg3.Size = new System.Drawing.Size(168, 21);
			this.txtMsg3.TabIndex = 2;
			this.txtMsg3.Text = "";
			// 
			// txtMsg2
			// 
			this.txtMsg2.Location = new System.Drawing.Point(136, 46);
			this.txtMsg2.Name = "txtMsg2";
			this.txtMsg2.Size = new System.Drawing.Size(168, 21);
			this.txtMsg2.TabIndex = 1;
			this.txtMsg2.Text = "";
			// 
			// txtMsg1
			// 
			this.txtMsg1.Location = new System.Drawing.Point(136, 23);
			this.txtMsg1.Name = "txtMsg1";
			this.txtMsg1.Size = new System.Drawing.Size(168, 21);
			this.txtMsg1.TabIndex = 0;
			this.txtMsg1.Text = "";
			// 
			// cmbProtocol
			// 
			this.cmbProtocol.Items.AddRange(new object[] {
															 "UDP",
															 "TCP"});
			this.cmbProtocol.Location = new System.Drawing.Point(248, 56);
			this.cmbProtocol.Name = "cmbProtocol";
			this.cmbProtocol.RightToLeft = System.Windows.Forms.RightToLeft.No;
			this.cmbProtocol.Size = new System.Drawing.Size(72, 21);
			this.cmbProtocol.TabIndex = 7;
			this.cmbProtocol.SelectedIndexChanged += new System.EventHandler(this.cmbComPort_SelectedIndexChanged);
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(200, 56);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(45, 17);
			this.label4.TabIndex = 8;
			this.label4.Text = "Protocol";
			// 
			// lblResult
			// 
			this.lblResult.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.lblResult.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(178)));
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
			this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(178)));
			this.label3.ForeColor = System.Drawing.Color.Red;
			this.label3.Location = new System.Drawing.Point(156, 316);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(35, 19);
			this.label3.TabIndex = 9;
			this.label3.Text = "‰ ÌÃÂ";
			// 
			// txtIP
			// 
			this.txtIP.Location = new System.Drawing.Point(72, 56);
			this.txtIP.Name = "txtIP";
			this.txtIP.Size = new System.Drawing.Size(112, 21);
			this.txtIP.TabIndex = 12;
			this.txtIP.Text = "192.168.2.88";
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.ClientSize = new System.Drawing.Size(328, 429);
			this.Controls.Add(this.txtIP);
			this.Controls.Add(this.lblResult);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.cmbProtocol);
			this.Controls.Add(this.tabControl1);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.txtCode);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(178)));
			this.Name = "Form1";
			this.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
			this.Text = "Form1";
			((System.ComponentModel.ISupportInitialize)(this.timer1)).EndInit();
			this.tabControl1.ResumeLayout(false);
			this.tabPage1.ResumeLayout(false);
			this.tabPage2.ResumeLayout(false);
			this.tabPage5.ResumeLayout(false);
			this.tabPage3.ResumeLayout(false);
			this.tabPage4.ResumeLayout(false);
			this.ResumeLayout(false);

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
			if (Z84_LinkTest_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text))
				lblResult.Text = "«— »«ÿ »—ﬁ—«— «”  .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		}

		private void btnRestart_Click(object sender, System.EventArgs e)
		{
			if (Z84_ReStart_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text))
				lblResult.Text = "œ” ê«Â —«Â «‰œ«“Ì ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		}

		private void btnReadVersion_Click(object sender, System.EventArgs e)
		{
			string VerStr = "";
			if (Z84_ReadVersion_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, ref VerStr))
				lblResult.Text = VerStr;
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
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
				Z84_GetRecord_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, ALL_COLLECTION, "", isFirst, ref retVal, ref data);
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
					lblResult.Text = "—òÊ—œ ÃœÌœÌ ÊÃÊœ ‰œ«—œ .";
				else
					lblResult.Text = Convert.ToString(recCount) + " —òÊ—œ »ÿÊ— ò«„· Ã„⁄ ¬Ê—Ì ‘œ .";
			}
			else
			{
				if (recCount == 0)
					lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
				else
					lblResult.Text = Convert.ToString(recCount) + " —òÊ—œ »ÿÊ— ‰«ﬁ’ Ã„⁄ ¬Ê—Ì ‘œ .";
			}
		
		}

		private void btnOnline_Click(object sender, System.EventArgs e)
		{
			timer1.Enabled = !timer1.Enabled;
			if (timer1.Enabled)
				btnOnline.Text = "Ã„⁄ ¬Ê—Ì œ«∆„Ì : ›⁄«·";
			else
				btnOnline.Text = "Ã„⁄ ¬Ê—Ì œ«∆„Ì : €Ì— ›⁄«·";

		}

		private void tmrOnline_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			if (btnOnline.ForeColor == System.Drawing.Color.Red)
				btnOnline.ForeColor = System.Drawing.Color.Black;
			else
				btnOnline.ForeColor = System.Drawing.Color.Red;
			string data="";
			Z84_GetRecord_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, ALL_COLLECTION, "", OnlineIsFirst, ref retVal, ref data);
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
			if (Z84_SetAuthority_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, Lst))
				lblResult.Text = "ÃœÊ· «—”«· ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		}
		
		private void btnGetTable_Click(object sender, System.EventArgs e)
		{
			
			string Lst = "";
			if (Z84_GetAuthority_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text,ref Lst))
			{
				lblResult.Text = "ÃœÊ· œ—Ì«›  ‘œ .";
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
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		}
		
		private void btnMsgtoReader_Click(object sender, System.EventArgs e)
		{
			if (Z84_SendReaderMsg_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, txtMsg1.Text,txtMsg2.Text,txtMsg3.Text,txtMsg4.Text))
				lblResult.Text = "ÅÌ«„ «—”«· ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
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

			if (Z84_SendPersonMsg_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, txtCardNo.Text , msg))
				lblResult.Text = "ÅÌ«„ «—”«· ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";

		}

		private void btnDelMsg_Click(object sender, System.EventArgs e)
		{
			if (Z84_DelPersonMsg_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, txtCardNo.Text))
				lblResult.Text = "ÅÌ«„ Õ–› ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		}

		private void btnDelAllMsg_Click(object sender, System.EventArgs e)
		{
			if (Z84_DeleteAllReaderMessage_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text))
				lblResult.Text = " „«„ ÅÌ«„Â« Õ–› ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		
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
			if (Z84_SetOnlyCards_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, Lst))
				lblResult.Text = "ÃœÊ· «—”«· ‘œ .";
			else
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
	
		}

		private void btnGetOnlyCard_Click(object sender, System.EventArgs e)
		{
			string Lst = "";
			if (Z84_GetOnlyCards_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text, ref Lst))
			{
				lblResult.Text = "ÃœÊ· œ—Ì«›  ‘œ .";
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
				lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
		
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
				Z84_GetRecord_LAN(Convert.ToByte(txtCode.Text) , Convert.ToByte(cmbProtocol.SelectedIndex), txtIP.Text , ALL_RECOVERY, txtRecoveryDate.Text , isFirst, ref retVal, ref data);
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
					lblResult.Text = "—òÊ—œ ÃœÌœÌ ÊÃÊœ ‰œ«—œ .";
				else
					lblResult.Text = Convert.ToString(recCount) + " —òÊ—œ »ÿÊ— ò«„· Ã„⁄ ¬Ê—Ì ‘œ .";
			}
			else
			{
				if (recCount == 0)
					lblResult.Text = "⁄œ„ »—ﬁ—«—Ì «— »«ÿ";
				else
					lblResult.Text = Convert.ToString(recCount) + " —òÊ—œ »ÿÊ— ‰«ﬁ’ Ã„⁄ ¬Ê—Ì ‘œ .";
			}
		
		}

		private void label2_Click(object sender, System.EventArgs e)
		{
		
		}

		private void cmbComPort_SelectedIndexChanged(object sender, System.EventArgs e)
		{
		
		}

		private void cmbComPort_SelectedIndexChanged_1(object sender, System.EventArgs e)
		{
		
		}

		private void cmbBaud_SelectedIndexChanged(object sender, System.EventArgs e)
		{
		
		}

		

		
	}
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace Test_GP7dll
{
    [StructLayout(LayoutKind.Sequential)]
    public struct TrafficRecord
    {
        public UInt32 UserID; 
        public byte PIS;			//PersonalIdentifyScenario
        public byte PC;			    //PreCard
        [MarshalAs(UnmanagedType.ByValArray, SizeConst=7)]
        public byte[] DateTime;
    };

    [StructLayout(LayoutKind.Sequential)]
    struct PersonInformation
    {
	    public UInt32 PersonNumber;
	    public UInt32 Password;
	    public UInt32 FingerID;
	    public UInt32 CardID;
        public byte PIS;            //PersonalIdentifyScenario
        public byte PAR;            //PersonalAccessRight
	    public byte FingerTemplateNumber;
    };

    [StructLayout(LayoutKind.Sequential)]
    struct FingerTemplate
    {
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 512)]
        public byte[] Template;
    }

    enum CommunicationFlag
    {
        CF_None = 0,
        PacketError = 2,
        ProccessSuccess = 3,
        CommunicatonFail = 4,
        CommunicationError = 7,
        CardIsRepetitive = 9,
        FingerIsRepetitive = 10,
        PersonIsRepetitive = 11
    };

    public partial class Form1 : Form
    {
        const int d_OK = 0, d_Err = -1;
        int handle = 0;
        PersonInformation pi = new PersonInformation();
        FingerTemplate[] TemplateFinger = new FingerTemplate[10];
        int NumofFinger;

        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern int Open_Serial(IntPtr Port, int Buadrate, ref int Handle);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern void Close_Serial(int Handle);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern int Open_Ehternet(IntPtr IP, int Port, ref int Handle);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern void Close_Ehternet(int Handle);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern void CLOSE(int Handle);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern bool Test_Connect(int Handle, int DeviceID);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern void ConvertToShamsi(StringBuilder Date);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern bool Set_Time(int Handle, StringBuilder Time, int DeviceID);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern bool Get_Time(int Handle, StringBuilder Time, int DeviceID);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern bool Set_Date(int Handle, StringBuilder Time, int DeviceID);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern bool Get_Date(int Handle, StringBuilder Time, int DeviceID);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern int Collect_Record(int Handle, StringBuilder fromDate, StringBuilder toDate, StringBuilder fromTime, StringBuilder toTime, int DeviceID,[Out] TrafficRecord []TF);
        [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern int Get_UserInfo(int Handle, int DeviceID, ref PersonInformation PI, [Out] FingerTemplate[] FingerPrintTemplate);
	    [System.Runtime.InteropServices.DllImport("GP7-dll.dll")]
        private static extern CommunicationFlag Enroll_User(int Handle, int DeviceID, PersonInformation PI, FingerTemplate[] FingerPrintTemplate, int NumOfFPtemplate);

        public Form1()
        {
            InitializeComponent();
        }

        private void rbtn_CheckedChanged(object sender, EventArgs e)
        {
            lblIP.Enabled = true;
            lblPort.Enabled = true;
            txtIP.Enabled = true;
            txtPort.Enabled = true;

            if (rbtnEthernet.Checked)
            {
                lblIP.Text = "IP";
                lblPort.Text = "Port";
                txtIP.Text = "192.168.10.160";
                txtPort.Text = "5000";
            }
            else if (rbtnSerial.Checked)
            {
                lblIP.Text = "ComPort";
                lblPort.Text ="BoudRate" ;
                txtIP.Text = "COM5";
                txtPort.Text = "57600";
            }
            else
            {
                lblIP.Enabled = false;
                lblPort.Enabled = false;
                txtIP.Enabled = false;
                txtPort.Enabled = false;
            }
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            int i = 1;
            bool bln = false;

            string str = txtIP.Text.ToUpper().ToString();
            IntPtr ptr = Marshal.StringToHGlobalAnsi(str);
            if (rbtnSerial.Checked)
                i = Open_Serial(ptr, Convert.ToInt32(txtPort.Text), ref handle);
            else if (rbtnEthernet.Checked)
                i = Open_Ehternet(ptr, Convert.ToInt32(txtPort.Text), ref handle);
            else
                ;// USB Open

            if (i != d_OK || handle == 0)
            {
                LstView_Show("پورت در دسترس نیست !!!", Color.Red);
                return;
            }

            bln =Test_Connect(handle, Convert.ToInt32(txtID.Text));
            if (bln)
            {
                LstView_Show("ارتباط برقرار است", Color.Blue);
            }
            else
            {
                LstView_Show("ارتباط برقرار نیست", Color.Red);
            }
            CLOSE(handle);

        }

        private void LstView_Show(string str,Color color)
        {
            if (str.Length != 0)
            {
                LstvLog.Items.Add(str);
                LstvLog.Items[this.LstvLog.Items.Count - 1].ForeColor = color;
                //if (this.LstvLog.Items.Count > 7)
                //    this.LstvLog.Items.RemoveAt(0);
            }
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            int i = 1;
            int NumofRec;

            string str = txtIP.Text.ToUpper().ToString();
            IntPtr ptr = Marshal.StringToHGlobalAnsi(str);
            if (rbtnSerial.Checked)
                i = Open_Serial(ptr, Convert.ToInt32(txtPort.Text), ref handle);
            else if (rbtnEthernet.Checked)
                i = Open_Ehternet(ptr, Convert.ToInt32(txtPort.Text), ref handle);
            else
                ;// USB Open

            if (i != d_OK || handle == 0)
            {
                LstView_Show("پورت در دسترس نیست !!!", Color.Red);
                return;
            }

            if(cmBox.Text == "Get Time")
            {
                StringBuilder strb = new StringBuilder(16);
                if (Get_Time(handle, strb, Convert.ToInt32(txtID.Text)))
                    LstView_Show("دریافت زمان : " + strb.ToString(), Color.Black);
                else
                    LstView_Show("اشکال در خواندن زمان !!!", Color.Red);

                if (Get_Date(handle, strb, Convert.ToInt32(txtID.Text)))
                {
                    ConvertToShamsi(strb);
                    LstView_Show("دریافت تاریخ : " + strb.ToString(), Color.Black);
                }
                else
                    LstView_Show("اشکال در خواندن تاریخ !!!", Color.Red);
            }
            else if(cmBox.Text == "Set Time")
            {
                str = DateTime.Now.ToString("HH:mm:ss");
                StringBuilder strb = new StringBuilder(str);
                if (Set_Time(handle, strb, Convert.ToInt32(txtID.Text)))
                    LstView_Show("ارسال زمان : " + str, Color.Black);
                else
                    LstView_Show("اشکال در ارسال زمان !!!", Color.Red);

                str = DateTime.Now.ToString("yyyy/MM/dd");
                StringBuilder strb2 = new StringBuilder(str);
                if (Set_Date(handle, strb2, Convert.ToInt32(txtID.Text)))
                    LstView_Show("ارسال تاریخ : " + str, Color.Black);
                else
                    LstView_Show("اشکال در ارسال تاریخ !!!", Color.Red);
            }
            else if(cmBox.Text == "Collect Record")
            {
                TrafficRecord[] Rec = new TrafficRecord[1024];
                str = DateTime.Now.ToString("HH:mm:ss");
                StringBuilder strbToTime = new StringBuilder(str);
                str = DateTime.Now.ToString("yyyy/MM/dd");
                StringBuilder strbToDate = new StringBuilder(str);
                DateTime dt = new DateTime(2012, 12, 10, 00, 00, 00);
                str = dt.ToString("HH:mm:ss");
                StringBuilder strbFromTime = new StringBuilder(str);
                str = dt.ToString("yyyy/MM/dd");
                StringBuilder strbFromDate = new StringBuilder(str);
                NumofRec = Collect_Record(handle, strbFromDate, strbToDate, strbFromTime, strbToTime, Convert.ToInt32(txtID.Text), Rec);
                if (NumofRec == 0)
                    LstView_Show("هیچ رکوردی موجود نیست", Color.BlueViolet);
                else if (NumofRec == -1)
                    LstView_Show("خطا در خواندن رکورد", Color.Red);
                else
                {
                    LstView_Show("تعداد رکورد = " + NumofRec.ToString(), Color.Blue);
                    for (i = 0; i < NumofRec; i++)
                    {
                        LstView_Show("PN = " + Rec[i].UserID.ToString() + "  Date = " + Rec[i].DateTime[4].ToString() +
                        "/" + Rec[i].DateTime[3].ToString() + " " + Rec[i].DateTime[2].ToString() +
                        ":" + Rec[i].DateTime[1].ToString(), Color.Black);
                    }
                }
            }
            else if (cmBox.Text == "Get User Info")
            {
                if (txtCommand.Text == "")
                {
                    MessageBox.Show("Fill User ID", "", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    CLOSE(handle);
                    return;
                }
                pi.PersonNumber = Convert.ToUInt32(txtCommand.Text);

                NumofFinger = Get_UserInfo(handle, Convert.ToInt32(txtID.Text), ref pi, TemplateFinger);
                if (NumofFinger == d_Err)
                {
                    MessageBox.Show("Unsuccess Read Template", "", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else if (pi.PersonNumber == 0)
                {
                    LstView_Show("کاربر با این شماره موجود نمی باشد", Color.Red);
                    CLOSE(handle);
                    return;
                }
                else if (NumofFinger == 0)
                {
                    LstView_Show("کاربر فاقد اثر انگشت می باشد", Color.Blue);
                }
                else
                {
                    LstView_Show("کاربر دارای " + NumofFinger + "اثر انگشت می باشد", Color.Blue);
                }

            }
            else if (cmBox.Text == "Enroll User")
            {
                CommunicationFlag flg = Enroll_User(handle, Convert.ToInt32(txtID.Text), pi, TemplateFinger, NumofFinger);
                if (flg == CommunicationFlag.ProccessSuccess)
                {
                    LstView_Show("کاربر " + pi.PersonNumber + " در دستگاه " + Convert.ToInt32(txtID.Text) + "ثبت شد", Color.Blue);
                }
                else if(flg == CommunicationFlag.PersonIsRepetitive)
                {
                    LstView_Show("شماره کاربر تکراری می باشد", Color.Red);
                }
                else if (flg == CommunicationFlag.FingerIsRepetitive)
                {
                    LstView_Show("اثر انگشت تکراری می باشد", Color.Red);
                }
                else if (flg == CommunicationFlag.CardIsRepetitive)
                {
                    LstView_Show("شماره کارت تکراری می باشد", Color.Red);
                }
                else
                {
                    LstView_Show("خطا در ثبت کاربر", Color.Red);
                }

            }
            CLOSE(handle);
        }

        private void cmBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmBox.Text == "Get Time")
            {
                txtCommand.Enabled = false;
                lblCommand.Text = "";
            }
            else if (cmBox.Text == "Set Time")
            {
                txtCommand.Enabled = false;
                lblCommand.Text = "";
            }
            else if (cmBox.Text == "Collect Record")
            {
                txtCommand.Enabled = false;
                lblCommand.Text = "";
            }
            else if (cmBox.Text == "Read Config")
            {
                txtCommand.Enabled = false;
                lblCommand.Text = "";
            }
            else if (cmBox.Text == "Get User Info")
            {
                txtCommand.Enabled = true;
                lblCommand.Text = "User ID";
            }
            else if (cmBox.Text == "Enroll User")
            {
                txtCommand.Enabled = false;
                txtCommand.Text = pi.PersonNumber.ToString();
                lblCommand.Text = "User ID";
            }

        }

    }
}

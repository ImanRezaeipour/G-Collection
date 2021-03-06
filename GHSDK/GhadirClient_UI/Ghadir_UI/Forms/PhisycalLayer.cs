using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;
using System.IO;
using System.Data.SqlClient;

namespace Ghadir_UI
{
    public partial class PhisycalLayer : Form
    {
        SqlConnection myConnection;     
        public enum FormType
        {
            Edit,
            Create
        }
        public DeviceDetail dd = new DeviceDetail();
        private Boolean edit = false;
      
        public PhisycalLayer()
        {
            InitializeComponent();
            if (!Directory.Exists(Constant.ConfigFileDirectory))
                Directory.CreateDirectory(Constant.ConfigFileDirectory);

            if (!File.Exists(Constant.DBConfigFilePath))
                return;
            string[] detail = File.ReadAllLines(Constant.DBConfigFilePath);
            string ConnStr = "Trusted_Connection=no;connection timeout=10;";
            for (int t = 0; t < detail.Length; t++)
            {
                if (detail[t].Equals("Server Name:"))
                    ConnStr = ConnStr + "server=" + detail[t + 1].Trim() + ";";
                if (detail[t].Equals("Database Name:"))
                    ConnStr = ConnStr + "database=" + detail[t + 1].Trim() + ";";
                if (detail[t].Equals("User Name:"))
                    ConnStr = ConnStr + "user id=" + detail[t + 1].Trim() + ";";
                if (detail[t].Equals("Password:"))
                {
                    DB.Encryption64 oEs = new DB.Encryption64();
                    string txtPassText;
                    txtPassText = oEs.Decrypt(detail[t + 1].Trim(), Constant.encryptKey);
                    ConnStr = ConnStr + "password=" + txtPassText + ";";
//                    ConnStr = ConnStr + "password=" + detail[t + 1].Trim() + ";";
                }
            }
            myConnection = new SqlConnection(ConnStr);
            try
            {
                myConnection.Open();
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message, "مشکل ارتباط با بانک اطلاعاتی");
            }
        }
       
        private void PhisycalLayer_Load(object sender, EventArgs e)
        {
            
        }

        public void update_form(FormType Type)
        {
            if (Type == FormType.Create)
            {
                initial();
                edit = false;
                return;
            }
            if (Type == FormType.Edit)
            {
                edit = true;
                initial();
                button1.Text = "اصلاح";
                device_address.Value = dd.Address;
                device_name.Text = dd.Name;
                device_type.Text = dd.Type.ToString(); ;

                if (dd.ConnectionType ==  DeviceDetail.DeviceCommunicationType.SERIAL)
                {
                    rdo_ser.Checked = true;
                    rdo_net.Checked = false;
                    serial_port.Text = dd.COMPort;
                    serial_baud.Text = dd.BaudRate.ToString();
                }
                if (dd.ConnectionType ==  DeviceDetail.DeviceCommunicationType.NETWORK)
                {
                    rdo_net.Checked = true;
                    rdo_ser.Checked = false;
                    ebx_ip.Text = dd.IP.ToString();
                    ebx_port.Text = dd.Port.ToString();
                } 
                update_display();
            }
        }


        private void initial()
        {
            string[] temp = SerialPort.GetPortNames();
            serial_port.Items.Clear();
            Array.Sort(temp);
            foreach (string s in temp)
                serial_port.Items.Add(s);

            rdo_ser.Checked = true;
            rdo_net.Checked = false;
            update_display();
        }


        private void update_display()
        {
            if (rdo_net.Checked)
            {
                serial_baud.Enabled = false;
                serial_port.Enabled = false;

                ebx_ip.Enabled = true;
                ebx_port.Enabled = true;
            }
            if (rdo_ser.Checked)
            {
                serial_baud.Enabled = true;
                serial_port.Enabled = true;
           
                ebx_ip.Enabled = false;
                ebx_port.Enabled = false;
            }
           
        }


       

        private void rdo_ser_CheckedChanged(object sender, EventArgs e)
        {
            update_display();
        }

        private void rdo_net_CheckedChanged(object sender, EventArgs e)
        {
            update_display();
        }

        private Boolean validate()
        {
            if (rdo_net.Checked)
            {
                if (Utility.GetEndPoint(ebx_ip.Text, Convert.ToInt32(ebx_port.Text)).Port == 0)
                {
                    MessageBox.Show("Input Correct Network Address");
                    return false ;
                }
                if (ip_redundancy_check())
                {
                    MessageBox.Show("This IP used for another device");
                    return false ;
                }
            }
            else
            {
                if (comport_redundancy_check())
                {
                    MessageBox.Show("Comport is udec for another device");
                    return false ;
                }
            }

            if (address_redundancy_check())
            {
                MessageBox.Show("This address used for another device");
                return false ;
            }
            if (name_redundancy_check())
            {
                MessageBox.Show("This name used for another device");
                return false ;
            }
            return true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (!validate())
                return;  
            if (edit == false)
            {   
                try
                {
                    
                    register_device();
                }
                catch
                {
                }
            }
            else
            {
                try
                {
                    edit_device();
                }
                catch
                {
                }
            }
            this.Close();
        }
        private Boolean name_redundancy_check()
        {
            if (!File.Exists(Constant.ConfigFilePath))
                return false;

            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            for (int t = 0; t < temp.Length; t++)
            {
                if (edit == true && dd.Name.Equals(temp[t]))
                {
                    t += 13;
                    continue;
                }
                if (temp[t].Equals(device_name.Text.Trim()))
                    return true;
            }
            return false;
        }

        private Boolean address_redundancy_check()
        {
            if (!File.Exists(Constant.ConfigFilePath))
                return false ;

            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            for (int t = 0; t < temp.Length; t++)
            {
                if (edit == true && dd.Name.Equals(temp[t]))
                {
                    t += 13;
                    continue;
                }
                if (temp[t].Equals(device_address.Value.ToString().Trim()))
                    return true;
            }
            return false ;
        }

        private Boolean ip_redundancy_check()
        {
            if (!File.Exists(Constant.ConfigFilePath))
                return false ;

            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            for (int t = 0; t < temp.Length; t++)
            {
                if (edit == true && dd.Name.Equals(temp[t]))
                {
                    t += 13;
                    continue;
                }
                if (temp[t].Equals(ebx_ip.Text.Trim()))
                    return true;
            }
            return false ;
        }

        private Boolean comport_redundancy_check()
        {
            if (!File.Exists(Constant.ConfigFilePath))
                return false ;

            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            for (int t = 0; t < temp.Length; t++)
            {
                if (edit == true && dd.Name.Equals(temp[t]))
                {
                    t += 13;
                    continue;
                }
                if (temp[t].Equals(serial_port.Text.Trim()))
                    return true;
            }
            return false ;
        }
        private void edit_device_in_DB()
        {
            SqlCommand myCommand = new SqlCommand("Delete from readers where r_code = " + device_address.Value.ToString().Trim(), myConnection);
            myCommand.ExecuteNonQuery();
            register_device_In_DB();
        }
        private void edit_device()
        {
            edit_device_in_DB();
            return;
            if (!File.Exists(Constant.ConfigFilePath))
                return;

            string[] temp = File.ReadAllLines(Constant.ConfigFilePath);

            for (int t=0;t<temp.Length;t++)
                if (dd.Name.Equals(temp[t]))
                {
                    temp[t - 2] = device_type.Text.Trim();
                    temp[t] = device_name.Text.Trim();
                    temp[t + 2] = device_address.Value.ToString().Trim();
                    if (rdo_ser.Checked)
                    {
                        temp[t + 3] = "SERIAL:";
                        temp[t + 4] = serial_port.Text.Trim();
                        temp[t + 5] = serial_baud.Text.Trim();
                    }
                    else
                    {
                        temp[t + 3] = "NETWORK:";
                        temp[t + 4] = ebx_ip.Text.Trim();
                        temp[t + 5] = ebx_port.Text.Trim();
                    }                    
                }
            File.WriteAllLines(Constant.ConfigFilePath, temp);


        }

        private void register_device_In_DB()
        {
//871215            string qry = "INSERT INTO readers (r_Code,r_name,r_Active,r_IsCom,r_port,r_baudNo,r_IP,r_TCP,r_type,r_modem) " + "Values (";
            string qry = "INSERT INTO readers (r_Code,r_name,r_Active,R_COMType,r_port,r_baudNo,r_IP,r_TCP,r_type,r_modem) " + "Values (";
            qry += device_address.Value.ToString().Trim() + ", '" + device_name.Text.Trim() + "', 'T' , ";
            if (rdo_ser.Checked)
                qry += "0,";
            else if (rdo_net.Checked)
                qry += "1,";
           qry += serial_port.Text.Remove(0,3) + ", ";

           qry += serial_baud.SelectedIndex;
           qry += ", '" + Utility.GetEndPoint(ebx_ip.Text, Convert.ToInt32(ebx_port.Text)).Address.ToString().Trim() + " ' , 1 , 2 , 0 )";

            SqlCommand myCommand = new SqlCommand( qry , myConnection);
            myCommand.ExecuteNonQuery();
            if (edit == false)
            {
                if (!Startup.logSave("Device Registered - Device: [" + device_name.Text.Trim() + "] - Address: [" + device_address.Value.ToString().Trim() + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                if (!Startup.logSave("Device Edited - Device: [" + device_name.Text.Trim() + "] - Address: [" + device_address.Value.ToString().Trim() + "]")) MessageBox.Show("Error saving log!", "Log Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void register_device()
        {
            register_device_In_DB();
            return;
            File.AppendAllText(Constant.ConfigFilePath, "NEW DEVICE DETAIL START");
            StreamWriter sw = File.AppendText(Constant.ConfigFilePath);
            sw.WriteLine();
            sw.WriteLine("TYPE:");
            sw.WriteLine(device_type.Text.Trim());
            sw.WriteLine("NAME:");
            sw.WriteLine(device_name.Text.Trim());
            sw.WriteLine("Address:");
            sw.WriteLine(device_address.Value.ToString().Trim());

            if (rdo_ser.Checked)
            {
                sw.WriteLine("SERIAL:");
                sw.WriteLine(serial_port.Text.Trim());
                sw.WriteLine(serial_baud.Text.Trim());
            }
            else
            {
                sw.WriteLine("NETWORK:");
                sw.WriteLine(Utility.GetEndPoint(ebx_ip.Text, Convert.ToInt32(ebx_port.Text)).Address.ToString().Trim());
                sw.WriteLine(Utility.GetEndPoint(ebx_ip.Text, Convert.ToInt32(ebx_port.Text)).Port.ToString().Trim());

            }
            sw.WriteLine("NEW DEVICE DETAIL END");
            sw.WriteLine();
            sw.WriteLine();
            sw.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void device_type_TextChanged(object sender, EventArgs e)
        {
           
        }

        private void device_type_SelectedIndexChanged(object sender, EventArgs e)
        {
            return;

        }

        private void label1_Click(object sender, EventArgs e)
        {

        } 
    }
}
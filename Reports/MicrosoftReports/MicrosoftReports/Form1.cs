using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Reporting;
using MicrosoftReports.Properties;
using Microsoft.Reporting.WinForms;
using System.Data.SqlClient;

namespace MicrosoftReports
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

            comboBox1.DataSource = BLL.Select("Select * from Instructor");
            comboBox1.DisplayMember = "Name";
            comboBox1.ValueMember = "ID";






        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if(comboBox1.SelectedItem !=null)
            {
                BLL.SelectData(this.reportViewer1, "SP_Select_InsructorReport", new List<SqlParameter>()
                {
                   new SqlParameter("@InstructorID",Convert.ToInt32(comboBox1.SelectedValue))

                });
            }

        }
    }
}

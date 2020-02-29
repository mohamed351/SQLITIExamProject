using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MicrosoftReports
{
    public partial class StudentGrade : Form
    {
        public StudentGrade()
        {
            InitializeComponent();
        }

        private void StudentGrade_Load(object sender, EventArgs e)
        {

            comboBox1.DataSource = BLL.Select("select * from Student");
            comboBox1.DisplayMember = "FName";
            comboBox1.ValueMember = "ID";

          
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            BLL.SelectData(this.reportViewer1, "sp_Select_Student_ExamReport2", new List<System.Data.SqlClient.SqlParameter>()
            {
                new System.Data.SqlClient.SqlParameter("@studentID",comboBox1.SelectedValue)
            });

        }
    }
}

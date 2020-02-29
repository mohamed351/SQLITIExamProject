using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace MicrosoftReports
{
    public partial class TracksFrm : Form
    {
        public TracksFrm()
        {
            InitializeComponent();
        }

        private void TracksFrm_Load(object sender, EventArgs e)
        {

            comboBox1.DataSource = BLL.Select("Select * from Track");
            comboBox1.DisplayMember = "Name";
            comboBox1.ValueMember = "ID";


        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
          
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem != null)
            {
                BLL.SelectData(this.reportViewer1, "sp_Select_Student_Report", new List<System.Data.SqlClient.SqlParameter>() {
                new SqlParameter("@TrackID",comboBox1.SelectedValue)

            });

            }
        }
    }
}

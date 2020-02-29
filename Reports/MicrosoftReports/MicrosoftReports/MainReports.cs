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
    public partial class MainReports : MetroFramework.Forms.MetroForm
    {
        public MainReports()
        {
            InitializeComponent();
        }

        private void MainReports_Load(object sender, EventArgs e)
        {

        }

        private void metroTile1_Click(object sender, EventArgs e)
        {
            using (Form1 frm = new Form1())
            {
                frm.ShowDialog();
            }
        }

        private void metroTile3_Click(object sender, EventArgs e)
        {
            using (TracksFrm frm = new TracksFrm())
            {
                frm.ShowDialog();
            }

        }

        private void metroTile4_Click(object sender, EventArgs e)
        {
            using (StudentGrade st = new StudentGrade())
            {
                st.ShowDialog();
            }
        }
    }
}

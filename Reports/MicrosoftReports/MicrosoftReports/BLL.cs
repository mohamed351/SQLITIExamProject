using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Microsoft.Reporting.WinForms;
using System.Configuration;

namespace MicrosoftReports
{
   public static class BLL
    {
        
        public static void SelectData(ReportViewer viewer, string StoredProcdureName , List<SqlParameter> Paramters, string DataSetName)
        {
            using (MyDataLayer.MyData my = new MyDataLayer.MyData(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                DataTable table = (DataTable)my.MyMethod(StoredProcdureName, Paramters.ToArray(), MyDataLayer.MyData.TypeStatment.Select);
                var element = new ReportDataSource(DataSetName, table);
                viewer.LocalReport.DataSources.Clear();
                viewer.LocalReport.DataSources.Add(element);
                viewer.RefreshReport();
            }
        }
        public static void SelectData(ReportViewer viewer, string StoredProcdureName, List<SqlParameter> Paramters)
        {
            using (MyDataLayer.MyData my = new MyDataLayer.MyData(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                DataTable table = (DataTable)my.MyMethod(StoredProcdureName, Paramters.ToArray(), MyDataLayer.MyData.TypeStatment.Select);
                var element = new ReportDataSource("DataSet1", table);
                viewer.LocalReport.DataSources.Clear();
                viewer.LocalReport.DataSources.Add(element);
                viewer.RefreshReport();
            }
        }


        public static void SelectData(ReportViewer viewer, string StoredProcdureName)
        {
            using (MyDataLayer.MyData my = new MyDataLayer.MyData(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                DataTable table = (DataTable)my.MyMethod(StoredProcdureName, null, MyDataLayer.MyData.TypeStatment.Select);
                var element = new ReportDataSource("DataSet1", table);
                viewer.LocalReport.DataSources.Clear();
                viewer.LocalReport.DataSources.Add(element);
                viewer.RefreshReport();
            }
        }

        public static  DataTable Select(string SelectStatment)
        {

            using (MyDataLayer.MyData my = new MyDataLayer.MyData(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                DataTable table = (DataTable)my.MyMethod(SelectStatment, MyDataLayer.MyData.TypeStatment.Select);
                return table;

            }
        }


    }
}

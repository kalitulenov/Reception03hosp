using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;


namespace WebInsurance.Report
{
    public partial class RepTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void generateReport(string _ReportName, string _period1, string _period2, string _division, string _department, string _employee)
        {
            try
            {
                string _ReportServer = System.Configuration.ConfigurationManager.ConnectionStrings["ReportServer"].ToString();
                string _ReportPath = System.Configuration.ConfigurationManager.ConnectionStrings["ReportPath"].ToString();
                DauaReport.ProcessingMode = ProcessingMode.Remote;
                Uri ReportURI = new Uri(_ReportServer);
                this.DauaReport.ServerReport.ReportServerUrl = ReportURI;
                this.DauaReport.ServerReport.ReportPath = _ReportPath + _ReportName;
                int repParams = 2;
                switch (_ReportName)
                {
                    case "/ExpenseReportByDivision":
                        repParams = 2;
                        break;
                    case "/ExpenseReportByDepartment":
                        repParams = 3;
                        break;
                    case "/ExpenseReportByEmployee":
                        repParams = 4;
                        break;
                    case "/CallDetailsByAccount":
                        repParams = 5;
                        break;
                }
                ReportParameter[] parameters = new ReportParameter[repParams];
                parameters[0] = new ReportParameter("p_Period", _period1.ToString());
                parameters[1] = new ReportParameter("p_Period1", _period2.ToString());
                if (repParams >= 3)
                {
                    parameters[2] = new ReportParameter("p_DivisionID", _division.ToString());
                }
                if (repParams >= 4)
                {
                    parameters[3] = new ReportParameter("p_DepartmentID", _department.ToString());
                }
                if (repParams == 5)
                {
                    parameters[4] = new ReportParameter("p_EmployeeID", _employee.ToString());
                }
                this.DauaReport.ServerReport.SetParameters(parameters);
                //Export to File
                string mimeType, encoding, extension, deviceInfo;
                string[] streamids;
                /*
                //   сохранить в JPEG
                                Microsoft.Reporting.WebForms.Warning[] warnings;
                                string format = "IMAGE";
                                encoding = String.Empty;
                                mimeType = "image/jpeg";
                                extension = "jpeg";
                //Generate report
                Byte[] results = rep.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                
                //Read and export to image
                using (FileStream stream = File.OpenWrite(filePath + "\\" + fileName + "." + formatImage))
                {
                    stream.Write(results, 0, results.Length);
                }
                */


                Microsoft.Reporting.WebForms.Warning[] warnings;
                string format = "PDF"; //Desired format goes here (PDF, Excel, or Image)
                deviceInfo = "<DeviceInfo>" + "<SimplePageHeaders>True</SimplePageHeaders>" + "</DeviceInfo>";
                byte[] bytes = DauaReport.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                Response.Clear();
                if (format == "PDF")
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-disposition", "filename=" + _ReportName + ".pdf");
                }
                else if (format == "Excel")
                {
                    Response.ContentType = "application/excel";
                    Response.AddHeader("Content-disposition", "filename=" + _ReportName + ".xls");
                }
                Response.OutputStream.Write(bytes, 0, bytes.Length);
                Response.OutputStream.Flush();
                Response.OutputStream.Close();
                Response.Flush();
                Response.Close();
                //To View Report
                //this.ReportViewer1.ServerReport.Refresh();
            }
            catch (Exception EX)
            {
                String _error = EX.Message;
      //          lblMessage.Text = _error;
            }

        }

    }
}

<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" %>

<%-- ========================================================================================= --%>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="Microsoft.Reporting.WebForms" %>
<%@ Import Namespace="System.Net" %>

<%-- ========================================================================================= --%>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
   Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%-- ========================================================================================= --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        
        string BuxFrm;
        string outputPath = @"C:\Temp\";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BuxFrm = (string)Session["BuxFrmKod"];
                string ReportName = "InsKltRzn";

                // -------------------- можно не задавать 
   //             IReportServerCredentials irsc = new CustomReportCredentials("Administrator", "j5c3p6jo5AOA", "MSSQLSERVER");
   //             ReportViewer1.ServerReport.ReportServerCredentials = irsc;
                ReportViewer1.ServerReport.ReportServerUrl = new Uri("http://localhost:8080/ReportServer");
                ReportViewer1.ServerReport.ReportPath = "/DauaReports/"+ReportName;

                ReportParameter[] parameters = new ReportParameter[2];
                parameters[0] = new ReportParameter("BEGDAT", "01.10.2014", false);
                parameters[1] = new ReportParameter("ENDDAT", "31.10.2014", false);
                ReportViewer1.ServerReport.SetParameters(parameters);
  //              ReportViewer1.ServerReport.Refresh();
 
                string mimeType, encoding, extension;
                string[] streamids;
                Microsoft.Reporting.WebForms.Warning[] warnings;
                string format = "Excel"; //Desired format goes here (PDF, Excel, or Image)

                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                byte[] bytes = ReportViewer1.ServerReport.Render(format, string.Empty, out mimeType, out encoding, out extension, out streamids, out warnings);
                
                // save the file
                outputPath = outputPath + ReportName + ".xls";
                using (FileStream fs = new FileStream(outputPath, FileMode.Create))
                {
                    fs.Write(bytes, 0, bytes.Length);
                    fs.Close();
                }


                /* 
              
                 string mimeType, encoding, extension, deviceInfo;
                 string[] streamids;
                 Microsoft.Reporting.WebForms.Warning[] warnings;
                 string format = "Excel"; //Desired format goes here (PDF, Excel, or Image)
                 deviceInfo = "<DeviceInfo>" + "<SimplePageHeaders>True</SimplePageHeaders>" + "</DeviceInfo>";

                 byte[] bytes = ReportViewer1.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                 Response.Clear();
                 if (format == "PDF")
                    {
                      Response.ContentType = "application/pdf";
                      Response.AddHeader("Content-disposition", "filename=" + ReportName + ".pdf");
                    }
                  else if (format == "Excel")
                    {
                      Response.ContentType = "application/excel";
                      Response.AddHeader("Content-disposition", "filename=" + ReportName + ".xls");
                    }
                  Response.OutputStream.Write(bytes, 0, bytes.Length);
                  Response.OutputStream.Flush();
                  Response.OutputStream.Close();
                  Response.Flush();
                  Response.Close();
                 
            */
                //To View Report
                //this.ReportViewer1.ServerReport.Refresh();

                
            }
        }

        // ======================================================================================
     </script> 
     
     
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
<
      <rsweb:ReportViewer ID="ReportViewer1" 
             runat="server" 
             Font-Names="Verdana" 
             Font-Size="8pt" 
             Width="100%" 
             Height="900px"
             ProcessingMode="Remote" >
            <ServerReport ReportServerUrl="http://localhost:8080/reportserver" />
      </rsweb:ReportViewer>
      
      
      
</asp:Content>

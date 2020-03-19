<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" %>

<%-- ========================================================================================= --%>
<%@ Import Namespace="System" %>
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BuxFrm = (string)Session["BuxFrmKod"];

                ReportViewer1.Width = 1200;
                ReportViewer1.Height = 600;
                ReportViewer1.ProcessingMode = ProcessingMode.Remote;
                // -------------------- можно не задавать 
                IReportServerCredentials irsc = new CustomReportCredentials("Administrator", "j5c3p6jo5AOA", "MSSQLSERVER");
//                ReportViewer1.ServerReport.ReportServerCredentials = irsc;
                ReportViewer1.ServerReport.ReportServerUrl = new Uri("http://localhost:8080/ReportServer");
                //  вызов без параметра
                //         ReportViewer1.ServerReport.ReportPath = "/AptekaRpt/Report1";
                //  вызов спараметром

                ReportParameter[] parameters = new ReportParameter[1];
                parameters[0] = new ReportParameter("BUXFRM", BuxFrm, false);
                // parameters[1] = new ReportParameter("GLVBEGDAT", "01.09.2013", false);
                // parameters[2] = new ReportParameter("GLVENDDAT", "30.09.2013", false);
                ReportViewer1.ServerReport.ReportPath = "/Reception03hospRpt/RptGrfDoc";
                ReportViewer1.ServerReport.SetParameters(parameters);

                // -------------------- если не указать параметры появится окошки опроса
                //       ReportParameter[] parameters = new ReportParameter[1];
                //       parameters[0] = new ReportParameter("FRM", "1", false);
                //      ReportViewer1.ServerReport.SetParameters(parameters);

                ReportViewer1.ServerReport.Refresh();

            }
        }


        public class CustomReportCredentials : IReportServerCredentials
        {
            private string _UserName;
            private string _PassWord;
            private string _DomainName;

            public CustomReportCredentials(string UserName, string PassWord, string DomainName)
            {
                _UserName = UserName;
                _PassWord = PassWord;
                _DomainName = DomainName;
            }

            public System.Security.Principal.WindowsIdentity ImpersonationUser
            {
                get { return null; }
            }

            public ICredentials NetworkCredentials
            {
                get { return new NetworkCredential(_UserName, _PassWord, _DomainName); }
            }

            public bool GetFormsCredentials(out Cookie authCookie, out string user,
             out string password, out string authority)
            {
                authCookie = null;
                user = password = authority = null;
                return false;
            }
        }

        // ======================================================================================
     </script> 
     
     
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
<
      <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" Height="400px" ProcessingMode="Remote" Width="872px">
            <ServerReport ReportServerUrl="http://localhost:80/reportserver" />
      </rsweb:ReportViewer>
      
      
      
</asp:Content>

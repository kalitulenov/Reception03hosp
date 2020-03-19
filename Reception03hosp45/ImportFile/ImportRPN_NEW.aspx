<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Common" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        string MdbNam = "HOSPBASE";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    string path = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));
                    FileUpload1.SaveAs(path);

                    // Connection String to Excel Workbook
                    string excelConnectionString = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", path);
//                    string excelConnectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=Excel 8.0", path);
                    OleDbConnection connection = new OleDbConnection();
                    connection.ConnectionString = excelConnectionString;
                    OleDbCommand command = new OleDbCommand("select * from [Page 1$]", connection);
                    connection.Open();
                    // Create DbDataReader to Data Worksheet
                    DbDataReader dr = command.ExecuteReader();

                    // SQL Server Connection String
                     // строка соединение
                    string sqlConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

                    // Bulk Copy to SQL Server 
                    SqlBulkCopy bulkInsert = new SqlBulkCopy(sqlConnectionString);
                    bulkInsert.DestinationTableName = "TAB_RPN";
                    bulkInsert.WriteToServer(dr);
                    lblMessage.Text = "Ho Gaya";
                    connection.Close();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }
        }

    </script>


    
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    
     
<!--  конец -----------------------------------------------  -->
 <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None" Style="border-style: double; left: 10px;
            left: 30%; position: relative; top: 200px; width: 40%; height: 300px;">

        <asp:Panel ID="Panel1" runat="server">
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
            <br />
            <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        </asp:Panel>
        
     </asp:Panel>   
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>
</asp:Content>

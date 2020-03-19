<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
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

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
                string FolderPath = ConfigurationManager.AppSettings["FolderPath"];
                //  string FilePath = Server.MapPath(FolderPath + FileName);

                string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

                FileUpload1.SaveAs(FilePath);
                //                GetExcelSheets(FilePath, Extension, "Yes");

                ImportDataFromExcel(FilePath);

            }
        }
        private void GetExcelSheets(string FilePath, string Extension, string isHDR)
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
            }

            //Get the Sheets in Excel WorkBoo
            conStr = String.Format(conStr, FilePath, isHDR);
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            cmdExcel.Connection = connExcel;
            connExcel.Open();

            ImportDataFromExcel(FilePath);
        }


        public void ImportDataFromExcel(string excelFilePath)
        {
            //declare variables - edit these based on your particular situation 
            string ssqltable = "TAB_APP";
            // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have    different 
            string myexceldataquery = "SELECT '" + BuxFrm + "',* FROM  [Page 1$]";
            try
            {
                //create our connection strings 
                //                string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=yes;\""; 
                string sexcelconnectionstring = @"provider=Microsoft.ACE.OLEDB.12.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";

                //      string ssqlconnectionstring = "Data Source=SAYYED;Initial Catalog=SyncDB;Integrated Security=True"; 
                string ssqlconnectionstring = ConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;


                //              ----------------------------------------------------------  очистить таблицу -----------------------
                //execute a query to erase any previous data from our destination table 
                string sclearsql = "DELETE FROM TAB_APP WHERE APPFRM='" + BuxFrm + "'";
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                //        sqlconn.Close();

                //              ----------------------------------------------------------  загрузить таблицу -----------------------
                //series of commands to bulk copy data from the excel file into our sql table 
                OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
                OleDbCommand oledbcmd = new OleDbCommand(myexceldataquery, oledbconn);
                oledbconn.Open();
                OleDbDataReader dr = oledbcmd.ExecuteReader();
                SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
                bulkcopy.DestinationTableName = ssqltable;
                while (dr.Read())
                {
                    bulkcopy.WriteToServer(dr);
                }
                dr.Close();
                oledbconn.Close();
                //              ----------------------------------------------------------  слить в базу данных -----------------------
                //execute a query to erase any previous data from our destination table 
                // string sclearsql = "DELETE FROM TAB_RPN WHERE FRM='" + BuxFrm + "'";
                SqlConnection sqlconnMrg = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmdMrg = new SqlCommand("HspAppImpExl", sqlconn);
                sqlcmdMrg.CommandType = CommandType.StoredProcedure;
                sqlcmdMrg.Parameters.Add("@KLTFRM", SqlDbType.Int, 4).Value = BuxFrm;

                sqlconnMrg.Open();
                sqlcmdMrg.ExecuteNonQuery();
                sqlconnMrg.Close();

                sqlconn.Close();

                lblMessage.Text = "АПП ЗАГРУЖЕН В БАЗУ.";

                // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(excelFilePath)) File.Delete(excelFilePath);
            }
            catch (Exception ex)
            {
                //handle exception 
                lblMessage.Text = ex.Message;
            }
        }


    </script>


    
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    
     
<!--  конец -----------------------------------------------  -->
<%-- ============================  верхний блок  ============================================ --%>
                               
          <asp:TextBox ID="Sapka" 
             Text="ЗАГРУЗКА АПП В БАЗУ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
    <%-- ============================  средний блок  ============================================ --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 30%; position: relative; top: 0px; width: 40%; height: 40px;">
          <div id="div_cnt" style="position: relative; top: 10px; left: 15%; width: 70%;">
            <asp:FileUpload ID="FileUpload1" runat="server"  />
            <asp:Button ID="btnUpload" runat="server" Text="Загрузить" OnClick="btnUpload_Click" />	        
          </div>
  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 30%; position: relative; top: 0px; width: 40%; height: 60px;">
             <center>
                  <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
             </center>
  </asp:Panel> 


 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>
</asp:Content>

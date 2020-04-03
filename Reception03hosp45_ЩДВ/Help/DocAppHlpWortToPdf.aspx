<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Spire.Doc" %>
<%@ Import Namespace="Spire.Doc.Documents" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

</head>


<script runat="server">

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
            Document document = new Document();
 //           document.LoadFromFile(@"C:\HELP\Администратор.doc");
//            document.LoadFromFile(@"C:\HELP\Лаборатория.doc");
 //           document.LoadFromFile(@"C:\HELP\Ресепшн.doc");
 //           document.LoadFromFile(@"C:\HELP\УЗИ.doc");
 //           document.LoadFromFile(@"C:\HELP\Врачи.doc");
 //             document.LoadFromFile(@"C:\HELP\ПроцКабинет.doc");

            document.LoadFromFile(@"C:\HELP\Administrator.PDF");
            document.SaveToFile(@"C:\HELP\Administrator_doc.doc", FileFormat.Doc);

            //Convert Word to PDF
//            document.SaveToFile(@"C:\HELP\Administrator.PDF", FileFormat.PDF);
//            document.SaveToFile(@"C:\HELP\Laboratory.PDF", FileFormat.PDF);
//            document.SaveToFile(@"C:\HELP\Reception.PDF", FileFormat.PDF);
 //           document.SaveToFile(@"C:\HELP\UZI.PDF", FileFormat.PDF);
  //          document.SaveToFile(@"C:\HELP\Doctor.PDF", FileFormat.PDF);
  //          document.SaveToFile(@"C:\HELP\ProcCab.PDF", FileFormat.PDF);
   //         System.Diagnostics.Process.Start(@"C:\HELP\Administrator.PDF");
        
            //Launch Document
    //        System.Diagnostics.Process.Start("toPDF.PDF");
    }

 
</script>


<body>
    <form id="form1" runat="server">
    <object width='100%' height='550' type='application/pdf' data='C:\BASELab\00007\2017.04\Тузелбай Бау_0005318534.pdf?#zoom=85&scrollbar=0&toolbar=0&navpanes=0&highlight=0,0,0,0' id='pdf_content' > </object> 

    </form>

</body>

</html>



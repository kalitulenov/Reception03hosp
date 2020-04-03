<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

        <script type="text/javascript">

            window.onload = function ()
            {
            var QueryString = getQueryString();
            var GlvDocNam= QueryString[1];
  //          alert("GlvDocNam=" + GlvDocNam);
  //          HlpWindow.setUrl("/Doctor.pdf");
  //          HlpWindow.Open();
            window.open(GlvDocNam, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");

            };


        //    ------------------ смена логотипа ----------------------------------------------------------
        function getQueryString() {
            var queryString = [];
            var vars = [];
            var hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            //           alert("hashes=" + hashes);
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                queryString.push(hash[0]);
                vars[hash[0]] = hash[1];
                queryString.push(hash[1]);
            }
            return queryString;
        }

</script>

</head>


<script runat="server">

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
    //        Document document = new Document();
   //         document.LoadFromFile(@"C:\HELP\Врачи.doc");
            //Convert Word to PDF
    //        document.SaveToFile(@"C:\HELP\Врачи.Htm", FileFormat.Html);
   //         document.SaveToFile(@"C:\HELP\Doctors.PDF", FileFormat.PDF);
            //Launch Document
    //        System.Diagnostics.Process.Start("toPDF.PDF");
    //        System.Diagnostics.Process.Start(@"C:\HELP\Врачи.doc");
    }

 
</script>


<body>
    <form id="form1" runat="server">

    </form>

</body>

</html>



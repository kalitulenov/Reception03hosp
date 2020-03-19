<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <script type="text/javascript">
        //alert("ok1");
        //$(document).ready(function () {
        //    alert("ok2");
        //    $('.aspNetHidden').remove();
        //});​

       // document.getElementsByClassName('aspNetHidden').style.display = 'none';
       // $('.aspNetHidden').remove();
        //const elements = document.getElementsByClassName("aspNetHidden");

        //while (elements.length > 0) elements[0].remove();

        //document.querySelectorAll('.aspNetHidden').forEach(function (a) {
        //    a.remove()
        //})

     </script>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style>
        div {
            border: 1px solid gray;
            padding: 8px;
        }

        h1 {
            text-align: center;
            text-transform: uppercase;
            color: #4CAF50;
        }

        p {
            text-indent: 50px;
            text-align: justify;
            letter-spacing: 3px;
        }

        a {
            text-decoration: none;
            color: #008CBA;
        }
    </style>

</head>

<script runat="server">
    string MdbNam = "HOSPBASE";
    string EodVid;
    string EodTxt;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        EodVid = Convert.ToString(Request.QueryString["EodVid"]);
        EodTxt = Convert.ToString(Request.QueryString["EodTxt"]);
        divVid.Text = EodVid;
        divTxt.Text = EodTxt;
    }
</script>


<body>
    <form id="form1" runat="server">
        <h1><asp:Literal ID="divVid" runat="server" Text='31' /></h1>
        <div> 
          <asp:Literal ID="divTxt" runat="server" Text='31' />
         </div>

    </form>


</body>
</html>



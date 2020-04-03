<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>
<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

        /* Организация диалога на ОК ----------------------------------------------------------------------------------*/
        $(function () {
            $(".YesZapis").dialog(
                 {
                     autoOpen: true,
                     width: 350,
                     height: 210,
                     modal: true,
                     buttons:
                     {
                         "ОК": function () {
                         $(this).dialog("close");
                         }
                             
                     }

                 });
        });


    </script>



<script runat="server">

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        txtAht.Text = "     "+Convert.ToString(Request.QueryString["TxtAht"]);
        if (!Page.IsPostBack)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("$(function() {$('.YesZapis').dialog('open');});");

            Page.ClientScript.RegisterStartupScript(typeof(Page), "myscript2", sb.ToString(), true);

        }

    }

    // ======================================================================================
                
</script>

        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>
    <%-- =================  Окно сообщения  ============================================ --%>
    <div class="YesZapis" title="" style="display: none">
         ПРОГРАММА НА РАЗРАБОТКЕ ...
        <br /> <br /> 
        <asp:TextBox ID="txtAht" Width="95%" runat="server" ReadOnly="true" BorderStyle="None" CssClass="DatePickerInput" />
    </div>

</asp:Content>



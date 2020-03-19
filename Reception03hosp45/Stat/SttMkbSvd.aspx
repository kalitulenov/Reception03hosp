<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!--  ссылка на JQUERY DATEPICKER-------------------------------------------------------------- -->

    <link href="/Styles/DatePicker/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />

    <script src="/JS/DatePicker/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.core.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/DatePickerRus.js" type="text/javascript"></script>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

        /* Организация диалога на добавления -----------------------------------------------------------------------*/
        $(function () {
            $(".InpBegEndDat").dialog({
                autoOpen: false,
                width: 500,
                height: 180,
                modal: true,
                open: function (event, ui) {
                    $(".DatePickerInput").datepicker("enable");
                },
                buttons:
                {
                    "OK": function () {
                        var GrfBeg = $("#<%= txtEventStartDate.ClientID  %>").val();
                        var GrfEnd = $("#<%= txtEventEndDate.ClientID  %>").val();
                        var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;
    //            alert(BegDat);
     //           alert(EndDat);
     //           alert(document.getElementById('parBuxFrm').value);

                $(this).dialog("close");
                // =========================================================================================================================================================
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Report/DauaReports.aspx?ReportName=HspSttMkbSvd&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                        "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSttMkbSvd&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
                // =========================================================================================================================================================
            },
            "Отмена": function () {
                $(this).dialog("close");
            }
        }
    });
});

    </script>



<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";
    string Cond = "";

    string MdbNam = "HOSPBASE";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        parBuxFrm.Value = BuxFrm;

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("$(function() {$('.InpBegEndDat').dialog('open');});");

            Page.ClientScript.RegisterStartupScript(typeof(Page), "myscript2", sb.ToString(), true);

            txtEventStartDate.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
            txtEventEndDate.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
        }

    }

    // ======================================================================================
                
</script>

        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>
        <div class="InpBegEndDat" title=" Укажите период">
            <table>
                <tr>
                    <td>Начало &nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtEventStartDate" Width="120px" runat="server" CssClass="DatePickerInput" /></td>
                    <td>Конец &nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtEventEndDate" Width="120px" runat="server" CssClass="DatePickerInput" /></td>
                </tr>
            </table>
            <br />
            <asp:Literal ID="litMessage" runat="server" />
        </div>

</asp:Content>



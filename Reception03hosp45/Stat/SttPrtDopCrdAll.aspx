<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

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
                height: 240,
                modal: true,
                open: function (event, ui) {
                    $(".DatePickerInput").datepicker("enable");
                },
                buttons:
                {
                    "OK": function () {
                        var GrfBeg = $("#<%= txtEventStartDate.ClientID  %>").val();
                        var GrfEnd = $("#<%= txtEventEndDate.ClientID  %>").val();
                        var IinBeg = $("#<%= txtIIN001.ClientID  %>").val();
                        var IinEnd = $("#<%= txtIIN002.ClientID  %>").val();
                        var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;
                        var GrfUch = BoxUch.options[BoxUch.selectedIndex()].value;
             // alert(GrfUch);
     //           alert(EndDat);
        //                alert("TekDocFrm =" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekIinBeg=" + IinBeg + "&TekIinEnd=" + IinEnd + "&TekUchTxt=" + GrfUch +"#");

                $(this).dialog("close");
                // =========================================================================================================================================================
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Report/DauaReports.aspx?ReportName=HspDopKrtCemAll&TekDocIdn=0&TekDocKod=0&TekDocFrm=" +
                        GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekIinBeg=" + IinBeg + "&TekIinEnd=" + IinEnd + "&TekUchTxt=" + GrfUch,
                        "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDopKrtCemAll&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + 
                        GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekIinBeg=" + IinBeg + "&TekIinEnd=" + IinEnd + "&TekUchTxt=" + GrfUch,
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
                    <td>Участок &nbsp;&nbsp;</td>
                    <td>
                        <obout:ComboBox runat="server" ID="BoxUch"  Width="120px" Height="250"
                               FolderStyle="/Styles/Combobox/Plain" >
                                  <Items>
                                        <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                        <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="1 общей практики" Value="1 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text="2 общей практики" Value="2 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="3 общей практики" Value="3 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="4 общей практики" Value="4 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="5 общей практики" Value="5 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="6 терапевтический" Value="6 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="7 терапевтический" Value="7 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem45" runat="server" Text="8 терапевтический" Value="8 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem46" runat="server" Text="9 общей практики" Value="9 " />
                                        <obout:ComboBoxItem ID="ComboBoxItem47" runat="server" Text="10 педиатрический" Value="10" />
                                    </Items>
                         </obout:ComboBox>  
                     </td>
                    <td></td>
                    <td>
                </tr>
                <tr>
                    <td>Начало &nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtEventStartDate" Width="120px" runat="server" CssClass="DatePickerInput" /></td>
                    <td>Конец &nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtEventEndDate" Width="120px" runat="server" CssClass="DatePickerInput" /></td>
                </tr>
                <tr>
                    <td>Нач.ИИН</td>
                    <td>
                        <asp:TextBox ID="txtIIN001" Width="120px" runat="server" /></td>
                    <td>Кон.ИИН</td>
                    <td>
                        <asp:TextBox ID="txtIIN002" Width="120px" runat="server" /></td>
                </tr>
            </table>
            <br />
            <asp:Literal ID="litMessage" runat="server" />
        </div>

</asp:Content>



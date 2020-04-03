<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%-- ============================  JAVA ============================================ --%>
         <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
         <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->

    <script type="text/javascript">

        $(function () {
     //       var QueryString = getQueryString();
    //        var BuxKod = QueryString[2];

            $(".PswDialog").dialog(
             {
                 autoOpen: true,
                 width: 500,
                 height: 200,
                 modal: true,
                 zIndex: 20000,
                 buttons:
                 {
                     "ОК": function () {
                         //     alert("OK_1=" + document.getElementById('MainContent_txtNewPsw').value);
                         //      alert("OK_2=" + document.getElementById('MainContent_txtRepPsw').value);

                       //  alert("OK_3=" + document.getElementById('MainContent_parBuxKod').value);

                         if (document.getElementById('MainContent_txtNewPsw').value != document.getElementById('MainContent_txtRepPsw').value) {
                             ERR_OK_click();
                             $(this).dialog("close");
                         }
                         else {
                             // ---------------------------------------------------------------------------------------------
                             $.ajax({
                                 type: 'POST',
                                 url: 'HspPswRep.aspx/RepNewPsw',
                                 data: '{"BuxKod":"' + document.getElementById('MainContent_parBuxKod').value + '", "PswNew":"' + document.getElementById('MainContent_txtNewPsw').value + '"}',
                                 contentType: "application/json; charset=utf-8",
                                 dataType: "json",
                                 success: function () { },
                                 error: function () { alert("ERROR=" + SqlStr); }
                             });
                             // ---------------------------------------------------------------------------------------------
                             PSW_OK_click();
                             $(this).dialog("close");
                         }
                     },
                     "Отмена": function () {
                         $(this).dialog("close");
                     }
                 }
             });
        });

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------       

        function ERR_OK_click() {
            //                    alert(" Eml_OK_click(1)=");
            $(".OkMessage").dialog(
                {
                    autoOpen: true,
                    width: 300,
                    height: 170,
                    modal: true,
                    zIndex: 2000,
                    buttons:
                      {
                          "ОК": function () {
                              $(this).dialog("close");
                              //                             OK_message();
                          }

                      }
                });
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------       
        function PSW_OK_click() {
            //                    alert(" Eml_OK_click(1)=");
            $(".OkSuccess").dialog(
                {
                    autoOpen: true,
                    width: 300,
                    height: 170,
                    modal: true,
                    zIndex: 2000,
                    buttons:
                      {
                          "ОК": function () {
                              $(this).dialog("close");
                              //                             OK_message();
                          }

                      }
                });
        }
        // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

    </script>


    <script language="C#" runat="server">

        string BuxSid;
        string BuxFrm;
        string BuxKod;


        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            
            parBuxKod.Value = BuxKod; 
            //============= начало  ===========================================================================================
            if (!Page.IsPostBack)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("$(function() {$('.PswDialog').dialog('open');});");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "myscript1", sb.ToString(), true);

                txtNewPsw.Text = "";
                txtRepPsw.Text = "";
            }

        }

        // ============================ чтение заголовка таблицы а оп ==============================================

        [WebMethod]
        public static bool RepNewPsw(string BuxKod, string PswNew)
        {
            string connectionString = "Data Source=localhost;Initial Catalog=HOSPBASE;Integrated Security=SSPI; Max Pool Size=1000;Pooling=True;Connect Timeout=1000";
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("UPDATE SPRBUX SET BUXPSWDAT=GETDATE(),BUXPSW='" + PswNew + "' WHERE BUXKOD=" + BuxKod, con);
            cmd.ExecuteNonQuery();
            // создание команды

            con.Close();

            return false;
        }


    </script>
    
    <!--  для хранения переменных -----------------------------------------------  -->
    <asp:HiddenField ID="parBuxKod" runat="server" />
    <!--  для хранения переменных -----------------------------------------------  -->

                               
    <%-- =================  диалоговое окно для смены пароля  ============================================ --%>
    <div class="PswDialog" title=" Смена пароля" >
        <table>
            <tr>
                <td>Новый пароль:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtNewPsw" TextMode="Password"></asp:TextBox>
                 </td>
           </tr>
            <tr>
                <td>Еще раз:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtRepPsw" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
    <div class="OkMessage" title=" Смена пароля " style="display: none">
        <table>
            <tr>
                <td>Пароли не совпадают 
               </td>
            </tr>
        </table>
    </div>

    <%-- =================  Пароль успешно изменен  ============================================ --%>
    <div class="OkSuccess" title=" Смена пароля " style="display: none">
        <table>
            <tr>
                <td>Пароль успешно изменен! 
               </td>
            </tr>
        </table>
    </div>

</asp:Content>

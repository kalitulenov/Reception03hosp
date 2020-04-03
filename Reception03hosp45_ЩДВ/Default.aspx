<%@ Page Title="Медицинская ифнормационная система" Language="C#" MasterPageFile="~/Masters/MstrAcct.master" AutoEventWireup="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
 </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <script type="text/javascript">

 /* Организация диалога на добавления -----------------------------------------------------------------------*/
        $(function() {
 //           var myDialogX = 630; // $(this).position().left - $(this).outerWidth();
            //            var myDialogY = 580;  // $(this).position().top - ( $(document).scrollTop() + $('.ui-dialog').outerHeight() );
            var myDialogX = 530; // $(this).position().left - $(this).outerWidth();
            var myDialogY = 280;  // $(this).position().top - ( $(document).scrollTop() + $('.ui-dialog').outerHeight() );

            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
               myDialogX = 330; // $(this).position().left - $(this).outerWidth();
               myDialogY = 120;  // $(this).position().top - ( $(document).scrollTop() + $('.ui-dialog').outerHeight() );
            }


           $(".Login").dialog({
                autoOpen: false,
                width: 400,
                height: 210,
                modal: true,
                draggable: false,
                position: [myDialogX, myDialogY],
                buttons:
                {
                    "OK": function() {
       //                 var OrgNam = $("").val();
       //                 var LogNam = $("#<%= txtLogNam.ClientID %>").val();
       //                 var PswNam = $("#<%= txtPswNam.ClientID %>").val();

                        var OrgNam = 'РСВЦ';
           //             var LogNam = document.getElementById('ctl00_MainContent_txtLogNam').value;
           //             var PswNam = document.getElementById('ctl00_MainContent_txtPswNam').value;
                        var LogNam = document.getElementById('MainContent_txtLogNam').value;
                        var PswNam = document.getElementById('MainContent_txtPswNam').value;
                        var BrwNam = "Desktop";

                        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                            BrwNam ="Android";
                        }

            //           alert('OrgNam=' + OrgNam);
             //           alert('LogNam=' + LogNam);
           //             alert('PswNam=' + PswNam);

                        $.ajax({ 
                            type: 'POST',
                            url: 'Default.aspx/LoginOk',
                            data: '{"OrgNam":"' + OrgNam + '", "LogNam":"' + LogNam + '","PswNam":"' + PswNam + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (msg) {
//                                alert("msg.d=" + msg.d);
//                                alert("msg.d2=" + msg.d.substring(0, 3));
//                                alert("msg.d3=" + msg.d.substring(3, 7));
                                if (msg.d.substring(0, 3) == "ДОК") {
                                    location.href = "/GlavMenu.aspx?OrgKod=" + msg.d.substring(3, 7);
                               //     location.href = "/Delo/EodChkRed.aspx";
                              //      $(this).dialog("close");
                                    $('.Login').dialog('close')
                                  //  window.open("/Delo/EodChkRed.aspx", "DocAppAmb", "toolbar=no,width=500,height=400,left=25,top=100,location=no,modal=0,status=no,scrollbars=no,resize=no");
                                  //  window.open('/Delo/EodChkRed.aspx', 'name','height=255,width=250,toolbar=no,directories=no,status=no, linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
                                 //   window.open('/Delo/EodChkRed.aspx', 'name','height=255,width=250,toolbar=no,directories=no,status=no,linemenubar = no, scrollbars = no, resizable = no, modal = yes');
                                    //var w = window.open("/Delo/EodChkRed.aspx", "popupWindow", "width=600, height=400, scrollbars=yes, modal = yes");
                                    //var $w = $(w.document.body);
                                }
                                else
                                    if (msg.d.substring(0, 3) == "СМП")
                                        location.href = "/Priem/DocAppCmpLst.aspx?NumSpr=СМП&TxtSpr=СКОРАЯ ПОМОЩЬ";
                                    else alert("Ошибка");
                            },
                            error: function() {
                                alert("Ошибка! Еще раз...");
                            }

                        });
//                        $(this).dialog("close");
                    },
                    "Отмена": function () {
                        $(this).dialog("close");
                    }
                }
            });
        });
        /* --------------------------------------------------------------------------------------------------------*/

   //     ~/Priem/DocAppLst.aspx?NumSpr=СМП&TxtSpr=СКОРАЯ ПОМОЩЬ
</script>
       <script language="C#" runat="server">
           protected void Page_Load(object sender, EventArgs e)
           {
               StringBuilder sb = new StringBuilder();
               sb.Append("$(function() {$('.Login').dialog('open');});");

               Page.ClientScript.RegisterStartupScript(typeof(Page), "myscript1", sb.ToString(), true);

            //   txtOrgNam.Text = "";
               //      txtOrgPsw.Text = "18";
               txtLogNam.Text = "";
               txtPswNam.Text = "";

           }

           [WebMethod]
           public static string LoginOk(string OrgNam, string LogNam, string PswNam)
           {
               int FrmKod;
               
               LoginCur person = new LoginCur() { OrgNamCur = OrgNam, LogNamCur = LogNam, PswNamCur = PswNam };

               // ============================проверяет есть ли такая организация в базе======================================================================  
               // строка соединение
               string connectionString = "Data Source=localhost;Initial Catalog=HOSPBASE;Integrated Security=SSPI; Max Pool Size=1000;Pooling=True;Connect Timeout=1000";
               // создание соединение Connection
               SqlConnection con = new SqlConnection(connectionString);
               con.Open();

               // создание команды
               SqlCommand cmd = new SqlCommand("ComChkUsrPsw", con);
               // указать тип команды
               cmd.CommandType = CommandType.StoredProcedure;
               // создать коллекцию параметров
  //             cmd.Parameters.Add(new SqlParameter("@BUXFRMLOG", SqlDbType.VarChar));
               cmd.Parameters.Add(new SqlParameter("@BUXLOG", SqlDbType.VarChar));
               cmd.Parameters.Add(new SqlParameter("@BUXPSW", SqlDbType.VarChar));
               // передать параметр
  //             cmd.Parameters["@BUXFRMLOG"].Value = OrgNam;
               cmd.Parameters["@BUXLOG"].Value = LogNam;
               cmd.Parameters["@BUXPSW"].Value = PswNam;
               // создание DataAdapter
               SqlDataAdapter da = new SqlDataAdapter(cmd);
               // создание DataSet.
               DataSet ds = new DataSet();
               // заполняем DataSet из хран.процедуры.
               da.Fill(ds, "ComChkUsrPsw");
               // если запись найден
               // присваивается значение из первой колонки, первой строки,
               // первой таблицы набора данных ds
               try
               {
                   HttpContext.Current.Session.Clear();
                   HttpContext.Current.Session.Add("BuxFrmKod", Convert.ToString(ds.Tables[0].Rows[0]["BUXFRMKOD"]));
                   HttpContext.Current.Session.Add("BuxFrmNam", Convert.ToString(ds.Tables[0].Rows[0]["BUXFRMNAM"]));
                   HttpContext.Current.Session.Add("BuxSid", (string)ds.Tables[0].Rows[0]["BUXSID"]);
                   HttpContext.Current.Session.Add("BuxKod", Convert.ToString(ds.Tables[0].Rows[0]["BUXKOD"]));
                   //          HttpContext.Current.Session.Add("BuxPsw", (string)ds.Tables[0].Rows[0]["BUXPSW"]);
                   //          HttpContext.Current.Session.Add("BuxKod", (int)ds.Tables[0].Rows[0]["BUXKOD"]);
                   //          HttpContext.Current.Session.Add("BuxNam", (string)ds.Tables[0].Rows[0]["BUXNAM"]);
                   //          HttpContext.Current.Session.Add("BuxAppStd", (int)ds.Tables[0].Rows[0]["APPSTD"]);
                   //          HttpContext.Current.Session.Add("BuxAppKom", (int)ds.Tables[0].Rows[0]["APPKOM"]);
                   //          HttpContext.Current.Session.Add("BuxAppStp", (int)ds.Tables[0].Rows[0]["APPSTP"]);
                   //          HttpContext.Current.Session.Add("BuxAppDkn", (int)ds.Tables[0].Rows[0]["APPDKN"]);
                   //          HttpContext.Current.Session.Add("BuxAppStu", (int)ds.Tables[0].Rows[0]["APPSTU"]);
                   //          HttpContext.Current.Session.Add("BuxAppZpl", (int)ds.Tables[0].Rows[0]["APPZPL"]);
                   //          HttpContext.Current.Session.Add("BuxAppBux", (int)ds.Tables[0].Rows[0]["APPBUX"]);
                   HttpContext.Current.Session.Add("GlvBegDat", (DateTime)ds.Tables[0].Rows[0]["GLVBEGDAT"]);
                   HttpContext.Current.Session.Add("GlvEndDat", (DateTime)ds.Tables[0].Rows[0]["GLVENDDAT"]);
                   HttpContext.Current.Session.Add("GlvDatRas", (DateTime)ds.Tables[0].Rows[0]["GLVDATRAS"]);

                   FrmKod = Convert.ToInt32(ds.Tables[0].Rows[0]["BUXFRMKOD"]);

                   if (Convert.ToString(ds.Tables[0].Rows[0]["BUXTYP"]) == "СМП") return "СМП" + FrmKod.ToString("0000");
                   else return "ДОК" + FrmKod.ToString("0000");
                  
               }
               catch
               {
                   //          Otvet.Text = "Неверный пароль или входное имя";
                   return "ERR";
               }
           }

           public class LoginCur
           {
               public string OrgNamCur { get; set; }
               public string LogNamCur { get; set; }
               public string PswNamCur { get; set; }
           }
                      

       </script>

<%--<asp:ScriptManager ID="scriptManager" EnablePageMethods="true" runat="server" />--%>

        <div class="Login" title=" Укажите логин и пароль" >
            <table>
                    <tr>
                        <td>Логин:</td>
                        <td><asp:TextBox runat="server" ID="txtLogNam"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Пароль:</td>
                        <td><asp:TextBox runat="server" ID="txtPswNam" TextMode="Password"></asp:TextBox></td>
                    </tr>
                </table>  
        </div> 
          <%-- ==
              ==========================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

</asp:Content>



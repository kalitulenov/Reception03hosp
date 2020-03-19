<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage"  %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

        <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>
<%-- ============================  стили ============================================ --%>
<style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
        }
    </style>
 
<%-- ============================  JAVA ============================================ --%>
      <script type="text/javascript">
          window.onload = function () {
         //     alert(document.getElementById('parPstBck').value);
              if (document.getElementById('parPstBck').value != "Post") {
                  document.getElementById('parPstBck').value = "Post";
                  GridDebLoad(0);
              }
          }


        function GridDeb_ClientUpdate(sender, record) {
            var TekAcc = BoxAccDeb.value();
            var TekMol = BoxMolDeb.value();
  //                   alert(TekAcc);
  //                   alert(TekMol);

            ob_post.AddParam("TekAcc", TekAcc);
            ob_post.AddParam("TekMol", TekMol);

            ob_post.post(null, "CreateGridDeb", function () { });
        }

          function GridDebLoad(AmbUslRej) {
      //        alert("AmbUslRej=" + AmbUslRej);
            var AmbUslIdn = document.getElementById('parUslIdn').value;
            var AmbCrdIdn = document.getElementById('parCrdIdn').value;

            mySpl.loadPage("LeftContent", "DocAppAmbUslRsxMatDeb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn);

            mySpl.loadPage("RightContent", "DocAppAmbUslRsxMatKrd.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn + "&AmbUslRej=" + AmbUslRej);
           // GridKrd();
          }

          /*
        function GridKrd() {
            var AmbUslIdn = document.getElementById('parUslIdn').value;
            var AmbCrdIdn = document.getElementById('parCrdIdn').value;
            mySpl.loadPage("RightContent", "DocAppAmbUslRsxMatKrd.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn);
        }
          */

        function BoxAccDeb_SelectedIndexChanged(sender, selectedIndex) {

            var TekAccDeb = BoxAccDeb.value();
            var TekMolDeb = BoxMolDeb.value();
            var TekAccKrd = BoxAccKrd.value();
            var TekMolKrd = BoxMolKrd.value();
/*
            alert("TekAcc=" + TekAccDeb);
            alert("TekMol=" + TekMolDeb);
            alert("TekAccKrd=" + TekAccKrd);
            alert("TekMolKrd=" + TekMolKrd);
            alert("parDocIdn=" + document.getElementById('MainContent_parDocIdn').value);
*/
            mySpl.loadPage("LeftContent", "DocAppAmbUslRsxMatDeb.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value +
                                               "&TekAccDeb=" + TekAccDeb + "&TekMolDeb=" + TekMolDeb + "&TekPrxIdn=0");
        }


        /*------------------------- при нажатии на поле текст --------------------------------*/

        function BoxPrxDeb_SelectedIndexChanged(sender, selectedIndex) {
         //   alert("BoxMolKrd.value()");

            var TekAccDeb = BoxAccDeb.value();
            var TekMolDeb = BoxMolDeb.value();
            var TekAccKrd = BoxAccKrd.value();
            var TekMolKrd = BoxMolKrd.value();
            var TekPrxIdn = BoxPrxDeb.value();
        /*    
                        alert("TekAcc=" + TekAccDeb);
                        alert("TekMol=" + TekMolDeb);
                        alert("TekAccKrd=" + TekAccKrd);
                        alert("TekMolKrd=" + TekMolKrd);
                        alert("parDocIdn=" + document.getElementById('MainContent_parDocIdn').value);
       */     
            mySplDeb.loadPage("RightContent", "DocAppAmbUslRsxMatDeb.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value +
                                               "&TekAccDeb=" + "&TekMolDeb=0" + "&TekPrxIdn=" + TekPrxIdn);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            //          alert("1");
            var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;
            //          alert("2");
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxPrmDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPrmDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        /*------------------------- при нажатии на поле текст --------------------------------*/
        function ClearKrd_Click() {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTyp = 'Sql';

            var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;

            SqlStr = "DELETE FROM TABDOCDTL WHERE DTLDOCIDN="+ DatDocIdn;
                        alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });

            mySplKrd.loadPage("LeftContent", "DocAppAmbUslRsxMatKrd.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value);

          }

          function ExitFun() {
              //     var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
              //                        alert("GrfFio=" + GrfFio); 
              //     localStorage.setItem("KasSumMem", KasSumMem); //setter
              window.opener.HandlePopupResult("UslRef");
              self.close();
              //   window.parent.UslRef();
          }

      </script>

</head>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
     <script runat="server">
         int GlvDocIdn;
         string GlvDocPrv;
         string GlvDocTyp;
         DateTime GlvDocDat;
         string MdbNam = "HOSPBASE";

         string BuxSid;
         string BuxKod;
         string BuxFrm;
         int AmbCrdIdn;
         int AmbUslIdn;

         string TekAcc;
         string TekMol;

         decimal ItgDocSum = 0;
         //=============Установки===========================================================================================
         protected void Page_Load(object sender, EventArgs e)
         {
             BuxSid = (string)Session["BuxSid"];
             BuxKod = (string)Session["BuxKod"];
             BuxFrm = (string)Session["BuxFrmKod"];
             GlvDocTyp = "УСЛ";
             parBuxFrm.Value = BuxFrm;
             parBuxKod.Value = BuxKod;

             //=====================================================================================
             AmbCrdIdn = Convert.ToInt32(Request.QueryString["AmbCrdIdn"]);
             AmbUslIdn = Convert.ToInt32(Request.QueryString["AmbUslIdn"]);

             if (!Page.IsPostBack)
             {
                 parCrdIdn.Value = Convert.ToString(AmbCrdIdn);
                 parUslIdn.Value = Convert.ToString(AmbUslIdn);
            
                 getDocNum();
                 if (parPstBck.Value != "Post") InsertGridKrd();
             }
         }

         // ============================ чтение заголовка таблицы а оп ==============================================
         //------------------------------------------------------------------------
         // ============================ чтение заголовка таблицы а оп ==============================================

         void getDocNum()
         {
             DataSet ds = new DataSet();
             string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
             // создание соединение Connection
             SqlConnection con = new SqlConnection(connectionString);
             // создание команды

             SqlCommand cmd = new SqlCommand("SELECT * FROM AMBCRD WHERE GRFIDN=" + parCrdIdn.Value, con);

             con.Open();
             // создание DataAdapter
             SqlDataAdapter da = new SqlDataAdapter(cmd);
             // заполняем DataSet из хран.процедуры.
             da.Fill(ds, "GetDocNum");

             con.Close();

             parAmbDat.Value = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
             parAmbPth.Value = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
         }


                  // ============================ чтение заголовка таблицы а оп ==============================================
        protected void InsertGridKrd()
         {

             string PolSql = "";

             // создание DataSet.
             DataSet ds = new DataSet();
             // строка соединение
             string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
             // создание соединение Connection
             SqlConnection con = new SqlConnection(connectionString);
             con.Open();

             PolSql = "DELETE FROM TABDOCDTL WHERE DTLDOCNUM='УСЛ' AND DTLDOCIDN=" + parUslIdn.Value;
             // создание команды
             SqlCommand cmd01 = new SqlCommand(PolSql, con);
             cmd01.ExecuteNonQuery();
             
             PolSql = "INSERT INTO TABDOCDTL (DtlDocNum,DtlDocIdn,DtlOpr,DtlDat,DtlDeb,DtlDebSpr,DtlDebSprVal,DtlKrd,DtlKrdSpr,DtlKrdSprVal,DtlKod,DtlNam,DtlEdn,DtlZen,DtlKol,DtlSum) " +
                      "SELECT 'УСЛ'," + parUslIdn.Value + ",MDVOPR,MDVDAT,MDVDEB,MDVDEBSPR,MDVDEBSPRVAL,MDVKRD,MDVKRDSPR,MDVKRDSPRVAL,MDVMAT,MATNAM,MATEDN,MATZEN,MDVKOL,MDVSUM " +
                      "FROM TABMDV LEFT OUTER JOIN TABMAT ON TABMDV.MDVMAT=TABMAT.MATKOD " +
                      "WHERE MDVDOCNUM='УСЛ' AND MDVDOCIDN=" + parUslIdn.Value + 
                      " UNION " +
                      "SELECT 'УСЛ'," + parUslIdn.Value + ",MDVOPR,MDVDAT,MDVDEB,MDVDEBSPR,MDVDEBSPRVAL,MDVKRD,MDVKRDSPR,MDVKRDSPRVAL,MDVMAT,MATNAM,MATEDN,MATZEN,MDVKOL,MDVSUM " +
                      "FROM TABMDV LEFT OUTER JOIN TABMAT ON TABMDV.MDVMAT=TABMAT.MATKOD " +
                      "WHERE MDVDOCNUM='УСЛ' AND MDVDOCIDN=" + parUslIdn.Value;

             // создание команды
             SqlCommand cmd02 = new SqlCommand(PolSql, con);
             cmd02.ExecuteNonQuery();



             con.Close();
         }
         //------------------------------------------------------------------------

         // ============================ проверка и опрос для записи документа в базу ==============================================
         protected void AddButton_Click(object sender, EventArgs e)
         {
             GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

             string KodErr = "";
             ConfirmOK.Visible = false;
             ConfirmOK.VisibleOnLoad = false;


             ConfirmDialog.Visible = true;
             ConfirmDialog.VisibleOnLoad = true;
         }

         // ============================ одобрение для записи документа в базу ==============================================
         protected void btnOK_click(object sender, EventArgs e)
         {
             string TekDocNum = "УСЛ";

             GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

             //          localhost.Service1Soap ws = new localhost.Service1SoapClient();
             //          ws.AptPrxDocAddRep(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, BoxOrg.SelectedValue, BuxKod);
             // строка соединение
             string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
             // создание соединение Connection
             SqlConnection con = new SqlConnection(connectionString);
             con.Open();
             // создание команды
             SqlCommand cmd = new SqlCommand("BuxPrxDocAddRep", con);
             cmd = new SqlCommand("BuxPrxDocAddRep", con);
             // указать тип команды
             cmd.CommandType = CommandType.StoredProcedure;
             // создать коллекцию параметров
             cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
             cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
             cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
             cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = parUslIdn.Value;
             cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = "0";
             cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = parAmbDat.Value;
             cmd.Parameters.Add("@DOCDEB", SqlDbType.VarChar).Value = "7210";
             cmd.Parameters.Add("@DOCDEBSPR", SqlDbType.VarChar).Value = "1";                // BoxOrg.SelectedValue;
             cmd.Parameters.Add("@DOCDEBSPRVAL", SqlDbType.VarChar).Value = "0";
             cmd.Parameters.Add("@DOCKRD", SqlDbType.VarChar).Value = "1310";
             cmd.Parameters.Add("@DOCKRDSPR", SqlDbType.VarChar).Value = "6";
             cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = parBuxKod.Value;
             cmd.Parameters.Add("@DOCNUMFKT", SqlDbType.VarChar).Value = "";
             cmd.Parameters.Add("@DOCDATFKT", SqlDbType.VarChar).Value = "";
             cmd.Parameters.Add("@DOCMEM", SqlDbType.VarChar).Value = parAmbPth.Value;
             cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

             // ------------------------------------------------------------------------------заполняем первый уровень
             cmd.ExecuteNonQuery();
             con.Close();

             ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

         }

         // ============================ отказ записи документа в базу ==============================================
         protected void CanButton_Click(object sender, EventArgs e)
         {
          //   Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прм&TxtSpr=Документы на перемещение");
         }
         // ============================ отказ записи документа в базу ==============================================
         // ---------Суммация  ------------------------------------------------------------------------
         //------------------------------------------------------------------------
         // ============================ проводить записи документа в базу ==============================================
         // ============================ одобрение для проведения документа в базу ==============================================

         protected void BoxPrxDeb_OnSelectedIndexChanged(object sender, EventArgs e)
         {
             int TekPrxIdn;

             GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

             //     if (BoxPrxDeb.SelectedValue == null | BoxPrxDeb.SelectedValue == "") TekPrxIdn = 0;
             //     else TekPrxIdn =  Convert.ToInt32(BoxPrxDeb.SelectedValue);

             //        if (TekStx > 0)
             //        {
             string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
             SqlConnection con = new SqlConnection(connectionString);
             con.Open();
             SqlCommand cmd = new SqlCommand("BuxPrmDocAddPrx", con);
             // указать тип команды
             cmd.CommandType = CommandType.StoredProcedure;
             // передать параметр
             cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
             //      cmd.Parameters.Add("@PRXIDN", SqlDbType.Int, 4).Value = TekPrxIdn;
             //      cmd.Parameters.Add("@MATKRDSPRVAL", SqlDbType.VarChar).Value = BoxAccKrd.SelectedValue;

             // создание команды
             cmd.ExecuteNonQuery();
             con.Close();
             //===============================================================================================================


             //            getDocNum();

         }

         // ============================ одобрение для записи документа в базу ==============================================

</script>

<body>

    <form id="form1" runat="server">
<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="Pusto" id="Pusto" value="Pusto" runat="server"/>
  <asp:HiddenField ID="parCrdIdn" runat="server" />
  <asp:HiddenField ID="parUslIdn" runat="server" />
  <asp:HiddenField ID="parBuxFrm" runat="server" />
  <asp:HiddenField ID="parBuxKod" runat="server" />
  <asp:HiddenField ID="parAmbDat" runat="server" />
  <asp:HiddenField ID="parAmbPth" runat="server" />
  <asp:HiddenField ID="parPstBck" runat="server" />

  <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Списание материальных средств" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  подшапка  ============================================ --%>
<%-- ============================  верхний блок  ============================================ --%>

    <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager1" />

        <asp:Panel ID="Panel1" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 0%; position: relative; top: 0px; width: 100%; height: 470px;">

            <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
                <LeftPanel WidthMin="200" WidthMax="600" WidthDefault="500">
                    <Content>
                        <asp:TextBox ID="TextBox1"
                            Text="Остаток"
                            BackColor="#32CD32"
                            Font-Names="Verdana"
                            Font-Size="18px"
                            Font-Bold="True"
                            ForeColor="White"
                            Style="top: 0px; left: 0; position: relative; width: 99%; text-align: center"
                            runat="server"></asp:TextBox>

                    </Content>
                </LeftPanel>

                <RightPanel>
                    <Content>
                        <asp:TextBox ID="TextBox2"
                            Text="Перемещение"
                            BackColor="#32CD32"
                            Font-Names="Verdana"
                            Font-Size="18px"
                            Font-Bold="True"
                            ForeColor="White"
                            Style="top: 0px; left: 0; position: relative; width: 99%; text-align: center"
                            runat="server"></asp:TextBox>
                    </Content>
                </RightPanel>
            </spl:Splitter>
        </asp:Panel>

   

<%-- ============================  средний блок  ============================================ --%>

<%-- ============================  средний блок  ============================================ --%>
 
<%-- ============================  подшапка  ============================================ --%>

 <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
            </center>
  </asp:Panel> 

  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>
 
<%-- =================  источник  для КАДРЫ ============================================ --%>
             <asp:SqlDataSource runat="server" ID="sdsAccDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsMolDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsAccKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsMolKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsPrxDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

<%-- =================  источник  для КАДРЫ ============================================ --%>
       
    </form>

</body>
</html>



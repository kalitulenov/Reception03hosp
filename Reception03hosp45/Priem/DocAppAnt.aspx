<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    
    <%--     ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }
        
   td.fics{
          height:38px;
          background-color: none
          }

          hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>

    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
  
         window.onload = function () {
             $.mask.definitions['H'] = '[012]';
             $.mask.definitions['S'] = '[012345]';

             $.mask.definitions['D'] = '[0123]';
             $.mask.definitions['M'] = '[01]';
             $.mask.definitions['Y'] = '[12]';

             $('#ctl00$MainContent$TextBoxDat').mask('D9.M9.Y999');
             $('#ctl00$MainContent$TextBoxTim').mask('H9:S9');
         };

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

         function WindowClose() {
             //           alert("GridNazClose");
             var jsVar = "dotnetcurry.com";
             __doPostBack('callPostBack', jsVar);
         }
         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeTxt(sender, newText) {
          //               alert("onChangeJlb=" + sender + " " + newText);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Int';

             switch (sender) {
                 case 'ctl00$MainContent$TextBoxDat':
                     if (newText.length != 10) return
                     GrfDocRek = 'GRFDAT';
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), '" + newText +"', 104)+''+ LEFT(CONVERT(CHAR(12), GRFBEG, 114),8) ,103)";
                     break;
                 case 'ctl00$MainContent$TextBoxTim':
                     if (newText.length != 5) return
                     GrfDocRek = 'GRFBEG';
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), GRFDAT, 104)+" + " '" + newText + ":00',103)";
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }
         //    ------------------------------------------------------------------------------------------------------------------------
         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBCRD';
             var DatDocKey = 'GRFIDN';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

       //                   alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
             switch (DatDocTyp) {
                 case 'Sql':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Str':
                     DatDocTyp = 'Str';
                     SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                     break;
                 case 'Dat':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Int':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 default:
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
    //         alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR="); }
             });

         }

         //    =======================================================================================================================
         function BckButton_Click() {
             location.href = "/GoBack/GoBack1.aspx";
         }

         //    =======================================================================================================================

         // --------------  ИЗМЕНИТЬ ДАТУ ПРИЕМА ----------------------------
         function onDateChange(sender, selectedDate) {
             //          alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             //             var GrfDocRek='GRFCTRDAT';
             //           alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //           alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
             //            alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

         }

         function ExitFun() {
             window.history.go(-2);
         } </script>



<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UslRos;
    int UslBec;
    int UslTal;
    int UslAdt;
    int UslAdb;

    int UslIdn;
    int UslAmb;
    int UslNap;
    string UslStx;
    int UslLgt;
    int UslZen;
    int UslKol;
    int UslKod;
    int UslKto;
    string UslGde;

    string UslNam;
    string UslMem;
    string KltIIN;

    int NumDoc;
    //        string TxtDoc;

    //        DateTime GlvBegDat;
    //        DateTime GlvEndDat;

    string AmbCrdIdn;
    string AmbCntIdn;
    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
        //           TxtDoc = (string)Request.QueryString["TxtSpr"];
        //           Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI + ' ' + DLGNAM AS FIO FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI";

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter

        if (par02 != null && !par02.Equals("") && AmbCrdIdn == "0")
        {
            Session["AmbUslIdn"] = "Post";
            AmbCrdIdn = HidAmbCrdIdn.Value;
            PushButton();
        }
        //            TextBoxDat.Attributes.Add("onchange", "onChangeTxt('ctl00$MainContent$TextBoxDat',ctl00$MainContent$TextBoxDat.value);");
        //           TextBoxTim.Attributes.Add("onchange", "onChangeTxt('ctl00$MainContent$TextBoxTim',ctl00$MainContent$TextBoxTim.value);");

        if (!Page.IsPostBack)
        {

            //============= Установки ===========================================================================================
            if (AmbCrdIdn == "0")  // новый документ
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "АНТ";
                cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = AmbCntIdn;
                cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
                }
                finally
                {
                    con.Close();
                }
            }

            HidAmbCrdIdn.Value = AmbCrdIdn;
            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

            getDocNum();

            getGrid();
        }

    }

    // ============================ чтение таблицы а оп ==============================================

    void PushButton()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspDocAppLstSumIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.ExecuteNonQuery();

        con.Close();
    }

    // ============================ кнопка новый документ  ==============================================


    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        int KodOrg = 0;
        int KodCnt = 0;

        string KeyOrg;
        string KeyCnt;
        int LenCnt;
        string SqlCnt;


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbCrdIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbCrdIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
            TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["HURMIN"]).ToString("hh:mm");
            TextBoxKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
            TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["RABNAM"]);
            TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
            TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getGrid()
      {
          string TekDat;
          KltIIN=TextBoxIIN.Text;
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbScrIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbScrIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              //     obout:OboutTextBox ------------------------------------------------------------------------------------     
       //       parKltIIN.Value = Convert.ToString(ds.Tables[0].Rows[0]["ScrIin"]); 
              TxtRos.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrRos"]);
              TxtBec.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrBec"]);
              TxtTal.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrTal"]);
              TxtDav001.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrDav001"]);
              TxtDav002.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrDav002"]);
              TxtEkg.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrEkg"]);
              TxtInvDig.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrInvDig"]);
              TxtXol.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrXolVal"]);
              TxtSax.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrSaxVal"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrInv"].ToString())) BoxInv.SelectedIndex = 0;
              else BoxInv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrInv"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrInvGrp"].ToString())) BoxInvGrp.SelectedIndex = 0;
              else BoxInvGrp.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrInvGrp"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKur"].ToString())) BoxKur.SelectedIndex = 0;
              else BoxKur.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKur"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlc"].ToString())) BoxAlc.SelectedIndex = 0;

              else BoxAlc.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlc"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcPiv"].ToString())) BoxAlcPiv.SelectedIndex = 0;
              else BoxAlcPiv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcPiv"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcVin"].ToString())) BoxAlcVin.SelectedIndex = 0;
              else BoxAlcVin.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcVin"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcVod"].ToString())) BoxAlcVod.SelectedIndex = 0;
              else BoxAlcVod.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcVod"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrFiz"].ToString())) BoxFiz.SelectedIndex = 0;
              else BoxFiz.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrFiz"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPrnIbc"].ToString())) BoxPrn.SelectedIndex = 0;
              else BoxPrn.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPrnIbc"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrSrd"].ToString())) BoxSrd.SelectedIndex = 0;
              else BoxSrd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrSrd"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGolBol"].ToString())) BoxGol.SelectedIndex = 0;
              else BoxGol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGolBol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrDav"].ToString())) BoxDav.SelectedIndex = 0;
              else BoxDav.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrDav"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrn"].ToString())) BoxZrn.SelectedIndex = 0;
              else BoxZrn.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrn"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnPel"].ToString())) BoxZrnPel.SelectedIndex = 0;
              else BoxZrnPel.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnPel"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnGlo"].ToString())) BoxZrnGlo.SelectedIndex = 0;
              else BoxZrnGlo.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnGlo"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnDio"].ToString())) BoxZrnDio.SelectedIndex = 0;
              else BoxZrnDio.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnDio"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKal"].ToString())) BoxKal.SelectedIndex = 0;
              else BoxKal.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKal"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrXol"].ToString())) BoxXol.SelectedIndex = 0;
              else BoxXol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrXol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrSax"].ToString())) BoxSax.SelectedIndex = 0;
              else BoxSax.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrSax"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnDav"].ToString())) BoxZrnDav.SelectedIndex = 0;
              else BoxZrnDav.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnDav"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGem"].ToString())) BoxGem.SelectedIndex = 0;
              else BoxGem.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGem"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGemTst"].ToString())) BoxGemTst.SelectedIndex = 0;
              else BoxGemTst.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGemTst"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKln"].ToString())) BoxGemKol.SelectedIndex = 0;
              else BoxGemKol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKln"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResZdr"].ToString())) BoxZdr.SelectedIndex = 0;
              else BoxZdr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResZdr"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrDoc"].ToString())) BoxOtv.SelectedIndex = 0;
              else BoxOtv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrDoc"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResNas"].ToString())) Chk001.Checked = false;
              else Chk001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResNas"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip001"].ToString())) Chk002.Checked = false;
              else Chk002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip001"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip002"].ToString())) Chk003.Checked = false;
              else Chk003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip002"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip003"].ToString())) Chk004.Checked = false;
              else Chk004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip003"]);

          }

          //          string name = value ?? string.Empty;
      }

      // ============================ проверка и опрос для записи документа в базу ==============================================
      protected void Save_Click(object sender, EventArgs e)
      {
          bool ScrResNas = false;
          bool ScrResGip001 = false;
          bool ScrResGip002 = false;
          bool ScrResGip003 = false;
          //=====================================================================================
          //        BuxSid = (string)Session["BuxSid"];
          BuxFrm = (string)Session["BuxFrmKod"];
          //=====================================================================================
          if (Convert.ToString(Chk001.Text) == "Checked = true") ScrResNas = true;
          else ScrResNas = Chk001.Checked;
          if (Convert.ToString(Chk002.Text) == "Checked = true") ScrResGip001 = true;
          else ScrResGip001 = Chk002.Checked;
          if (Convert.ToString(Chk003.Text) == "Checked = true") ScrResGip002 = true;
          else ScrResGip002 = Chk003.Checked;
          if (Convert.ToString(Chk004.Text) == "Checked = true") ScrResGip003 = true;
          else ScrResGip003 = Chk004.Checked;

          if (Convert.ToString(TxtXol.Text) == null || Convert.ToString(TxtXol.Text) == "") TxtXol.Text = "0";
          if (Convert.ToString(TxtSax.Text) == null || Convert.ToString(TxtSax.Text) == "") TxtSax.Text = "0";


          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisScrLstDocOneScrUpd", con);
          cmd = new SqlCommand("HspAisScrLstDocOneScrUpd", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@SCRIIN", SqlDbType.VarChar).Value = TextBoxIIN.Text;
          cmd.Parameters.Add("@ScrRos", SqlDbType.VarChar).Value = TxtRos.Text;
          cmd.Parameters.Add("@ScrBec", SqlDbType.VarChar).Value = TxtBec.Text;
          cmd.Parameters.Add("@ScrTal", SqlDbType.VarChar).Value = TxtTal.Text;
          cmd.Parameters.Add("@ScrDav001", SqlDbType.VarChar).Value = TxtDav001.Text;
          cmd.Parameters.Add("@ScrDav002", SqlDbType.VarChar).Value = TxtDav002.Text;
          cmd.Parameters.Add("@ScrEkg", SqlDbType.VarChar).Value = TxtEkg.Text;
          cmd.Parameters.Add("@ScrInvDig", SqlDbType.VarChar).Value = TxtInvDig.Text;
          cmd.Parameters.Add("@ScrXolVal", SqlDbType.Decimal).Value = TxtXol.Text;
          cmd.Parameters.Add("@ScrSaxVal", SqlDbType.Decimal).Value = TxtSax.Text;

          cmd.Parameters.Add("@ScrInv", SqlDbType.VarChar).Value = BoxInv.SelectedIndex;
          cmd.Parameters.Add("@ScrInvGrp", SqlDbType.VarChar).Value = BoxInvGrp.SelectedIndex;
          cmd.Parameters.Add("@ScrKur", SqlDbType.VarChar).Value = BoxKur.SelectedIndex;
          cmd.Parameters.Add("@ScrAlc", SqlDbType.VarChar).Value = BoxAlc.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcPiv", SqlDbType.VarChar).Value = BoxAlcPiv.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcVin", SqlDbType.VarChar).Value = BoxAlcVin.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcVod", SqlDbType.VarChar).Value = BoxAlcVod.SelectedIndex;
          cmd.Parameters.Add("@ScrFiz", SqlDbType.VarChar).Value = BoxFiz.SelectedIndex;
          cmd.Parameters.Add("@ScrPrnIbc", SqlDbType.VarChar).Value = BoxPrn.SelectedIndex;
          cmd.Parameters.Add("@ScrSrd", SqlDbType.VarChar).Value = BoxSrd.SelectedIndex;
          cmd.Parameters.Add("@ScrGolBol", SqlDbType.VarChar).Value = BoxGol.SelectedIndex;
          cmd.Parameters.Add("@ScrDav", SqlDbType.VarChar).Value = BoxDav.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnPel", SqlDbType.VarChar).Value = BoxZrnPel.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnGlo", SqlDbType.VarChar).Value = BoxZrnGlo.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnDio", SqlDbType.VarChar).Value = BoxZrnDio.SelectedIndex;
          cmd.Parameters.Add("@ScrKal", SqlDbType.VarChar).Value = BoxKal.SelectedIndex;
          cmd.Parameters.Add("@ScrXol", SqlDbType.VarChar).Value = BoxXol.SelectedIndex;
          cmd.Parameters.Add("@ScrSax", SqlDbType.VarChar).Value = BoxSax.SelectedIndex;
          cmd.Parameters.Add("@ScrZrn", SqlDbType.VarChar).Value = BoxZrn.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnDav", SqlDbType.VarChar).Value = BoxZrnDav.SelectedIndex;
          cmd.Parameters.Add("@ScrGem", SqlDbType.VarChar).Value = BoxGem.SelectedIndex;
          cmd.Parameters.Add("@ScrGemTst", SqlDbType.VarChar).Value = BoxGemTst.SelectedIndex;
          cmd.Parameters.Add("@ScrKln", SqlDbType.VarChar).Value = BoxGemKol.SelectedIndex;
          cmd.Parameters.Add("@ScrResZdr", SqlDbType.VarChar).Value = BoxZdr.SelectedIndex;
          cmd.Parameters.Add("@ScrDoc", SqlDbType.VarChar).Value = BoxOtv.SelectedIndex;
 
          cmd.Parameters.Add("@ScrResNas", SqlDbType.Bit, 1).Value = ScrResNas;
          cmd.Parameters.Add("@ScrResGip001", SqlDbType.Bit, 1).Value = ScrResGip001;
          cmd.Parameters.Add("@ScrResGip002", SqlDbType.Bit, 1).Value = ScrResGip002;
          cmd.Parameters.Add("@ScrResGip003", SqlDbType.Bit, 1).Value = ScrResGip003;
          
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();

          ExecOnLoad("ExitFun();");

      }

    // ======================================================================================
</script>

      <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />

      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:5%; position: relative; top: 0px; width: 90%; height: 65px;">

     <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="27%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="80px" Height="20" RunAt="server" BackColor="#FFFFE0" />
			          <obout:Calendar ID="Calendar3" runat="server"
			 	                    	StyleFolder="/Styles/Calendar/styles/default" 
    	          					    DatePickerMode="true"
    	           					    ShowYearSelector="true"
                					    YearSelectorType="DropDownList"
    	           					    TitleText="Выберите год: "
    	           					    CultureName = "ru-RU"
                					    TextBoxId = "TextBoxDat"
                                        OnClientDateChanged="onDateChange"   
                					    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="27%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                  </td>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 5%; position: relative; top: -12px; width: 90%; height: 500px;">

             <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                <!--  Инвалидность ----------------------------------------------------------------------------------------------------------  -->
                <tr >
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="LblInv" Text="9.Инвалидность:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxInv" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Есть" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LblInvGrp" Text="9.1.Группа инвалидности (от 16 лет):" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxInvGrp" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="1 группа" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="2 группа" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="3 группа" Value="3" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LblInvDig" Text="9.2.Диагноз по инвалидности:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtInvDig" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
                <!--  Антропометрия ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label2" Text="10.Рост:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtRos" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <asp:Label ID="Label12" Text="11.Вес:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtBec" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <asp:Label ID="Label13" Text="13.Объем талии:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtTal" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                    </td>
                </tr>
                <!--  Вредные привычки ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label3" Text="14.Курение:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKur" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label11" Text="15.Употребление алкоголя:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlc" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label14" Text="Пиво:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcPiv" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="До 0.5 л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Более 0.5 л" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="До 285 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Более 285 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label15" Text="Вино:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcVin" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="До 250 мл" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem19" runat="server" Text="Более 250 мл" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem20" runat="server" Text="До 120 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem21" runat="server" Text="Более 120 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label16" Text="Водка:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcVod" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem22" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="До 50 мл" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Более 50 мл" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="До 25 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="Более 25 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

                <!--  16.Физическая активность ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label17" Text="16.Физ.активность:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxFiz" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label18" Text="17.Имеются ли у родителей болезни сердца:" runat="server" Width="30%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPrn" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem48" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label19" Text="18.Появляется ли у Вас боль за грудиной:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxSrd" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem49" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem50" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem51" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <!--  19.Отмечаются ли у Вас головные боли ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label20" Text="19.Головные боли:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGol" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem52" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem53" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem54" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label21" Text="20.Есть ли у Вас повышение АД:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDav" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem55" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem56" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem57" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label22" Text="21.АД(систолическое/диастолическое):" runat="server" Width="25%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtDav001" Width="5%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <obout:OboutTextBox runat="server" ID="TxtDav002" Width="5%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                    </td>
                </tr>

                <!--  Наблюдается ли у Вас снижение остроты зрения ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label23" Text="22.Сниж.ост.зрения:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrn" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem58" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem59" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem60" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label24" Text="23.Есть ли (пелена) перед глазами :" runat="server" Width="22%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnPel" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem61" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem62" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem63" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label25" Text="24.Есть ли у родителей глаукома:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnGlo" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem64" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem65" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem66" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label26" Text="25.Диоптрии > 4:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnDio" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem67" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem68" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem69" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                    </td>
                </tr>

                <!--  26.Отмечаются ли у Вас в течение последнего года патологические примеси в кале ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label27" Text="26.Отмечаются ли у Вас в течение последнего года патологические примеси в кале:" runat="server" Width="50%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKal" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem70" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem71" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem72" runat="server" Text="Кровь" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem73" runat="server" Text="Слизь" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem74" runat="server" Text="Гной" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
               <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label1" Text="28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета:" runat="server" Width="100%" Font-Bold="true" />
                    </td>
                </tr>
                <tr>
                    <td class="fics" >
                        <asp:Label ID="Label4" Text="28.1 ЭКГ:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtEkg" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>

                        <asp:Label ID="Label5" Text=" 28.2 Уровень холестерина:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtXol" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>
                        <obout:ComboBox runat="server" ID="BoxXol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="5.2 ммоль/л" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text=">5.2 ммоль/л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text=">состоит на дисп у" Value="3" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label6" Text=" 28.3 Глюкоза:" runat="server" Width="10%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtSax" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>
                        <obout:ComboBox runat="server" ID="BoxSax" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="3.88-5.55 ммоль/л" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text=">5.5 ммоль/л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="состоит на дисп у." Value="3" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <!--  29.Результаты обследования на выявление глаукомы: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label7" Text="29.Результаты обследования на выявление глаукомы:" runat="server" Width="40%" Font-Bold="true" />
                        <asp:Label ID="Label8" Text="29.1 Глазное давление:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnDav" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem45" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem46" runat="server" Text="Норма" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem47" runat="server" Text=">Повышение" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem75" runat="server" Text=">Состоит на дисп у." Value="3" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="fics" >
                        <asp:Label ID="Label9" Text="30.6 Гемокульт-тест:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGem" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem76" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem77" runat="server" Text="Положительный" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem78" runat="server" Text="Отрицательный" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem79" runat="server" Text="Не проведен" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem80" runat="server" Text="Состоит на дисп. учете" Value="4" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label10" Text="30.7 Гемокульт-тест по скринингу:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGemTst" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem81" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem82" runat="server" Text="Впервые" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem83" runat="server" Text="Повторно" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label28" Text="30.8 Колоноскопия:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGemKol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem84" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem85" runat="server" Text="KS1" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem86" runat="server" Text="KS2" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem87" runat="server" Text="KS3" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem88" runat="server" Text="KS4" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem89" runat="server" Text="KS5а" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem90" runat="server" Text="KS5б" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem91" runat="server" Text="KS6" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem92" runat="server" Text="KS8" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem93" runat="server" Text="Не проведена" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem94" runat="server" Text="Отказ пациента" Value="10" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label29" Text="32.1. Здоров(а):" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZdr" Width="10%" Height="200" FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem95" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem96" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem97" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    
                            <asp:Label ID="Label30" Text="32.3. Фкторы риска:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="Chk001"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label31" Text="Наслед.предраспол." runat="server" Width="13%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk002"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label32" Text="Гипертензия." runat="server" Width="10%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk003"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label33" Text="Гиперлипидемия." runat="server" Width="12%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk004"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label34" Text="Гипергликемия." runat="server" Width="10%" Font-Bold="true" />
                    </td>
                </tr>
            </table>


        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 5%; position: relative; top: -10px; width: 90%; height: 30px;">
            <center>
                <asp:Label ID="Label35" Text="Ответственный:" runat="server" Width="10%" Font-Bold="true" />
                <obout:ComboBox runat="server" ID="BoxOtv" Width="30%" Height="150"
                                FolderStyle="/Styles/Combobox/Plain"
                                DataSourceID="sdsKto" DataTextField="FIO" DataValueField="BuxKod">
                </obout:ComboBox>

                <asp:Button ID="Button1" runat="server" CommandName="Add" OnClick="Save_Click" Text="Сохранить"/>
            </center>
        </asp:Panel>
     
<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

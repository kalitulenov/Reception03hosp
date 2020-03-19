<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%-- ============================  для почты  ============================================ --%>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>


 

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;
        //    ------------------ смена логотипа ----------------------------------------------------------

        window.onload = function () {
            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var GlvDocPrv = document.getElementById('parKasPrv').value;
            //       mySpl.loadPage("BottomContent", "/Priem/DocAppAmbUsl.aspx?AmbCrdIdn=" + GlvDocIdn);
        };


        function PrtPrxOrd() {
            //          alert("PrtPrxOrd=");

            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function ExitFun() {
            window.parent.KasClose();
            location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        function ButFio_Click(sender, record) {
            //      alert("AddButton_Click=");
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppKlt.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppKlt.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
        }


        function ButKdr_Click(sender, record) {
            //      alert("AddButton_Click=");
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/BuxFndKdr.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/BuxFndKdr.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
        }

        function ButFrm_Click(sender, record) {
            //      alert("AddButton_Click=");
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/BuxFndFrm.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/BuxFndFrm.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
        }
        /*
                function ButUsl_Click() {
                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Priem/DocAppUsl.aspx?SenDer=USL", "ModalPopUp", "toolbar=no,width=1000,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                    else
                        window.showModalDialog("/Priem/DocAppUsl.aspx?SenDer=USL", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:1000px;dialogHeight:450px;");
                }
        */
        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

        function HandlePopupResult(result) {
            //                  alert("result of popup is: " + result);
            var hashes = result.split('&');
            //        alert("hashes=" + hashes[0]);
            if (hashes[0] == "USL") {
                document.getElementById('parKasKod').value = hashes[1];
                document.getElementById('parKasNam').value = hashes[2];
                document.getElementById('parKasZen').value = hashes[3];
                //                       alert("hashes=" + hashes[0]);
                if (document.getElementById('KASSUM').value == "") document.getElementById('KASSUM').value = "0";

                if (document.getElementById('parKasNam').value.length > 0) {
                    document.getElementById('KASMEM').value = document.getElementById('KASMEM').value + " # " +
                                                                                document.getElementById('parKasNam').value + "=" +
                                                                                parseInt(document.getElementById('parKasZen').value);
                    document.getElementById('KASSUM').value = parseInt(document.getElementById('KASSUM').value) +
                                                                                parseInt(document.getElementById('parKasZen').value);
                }
            }
            else
                if (hashes[0] == "KDR") {
                    document.getElementById('KASIIN').value = hashes[1];
                    document.getElementById('KASFIO').value = hashes[2];
                    document.getElementById('parKasSpr').value = "1";
                }
                else
                    if (hashes[0] == "FRM") {
                        document.getElementById('KASFIO').value = hashes[1];
                        document.getElementById('KASIIN').value = hashes[2];
                        document.getElementById('parKasSpr').value = "2";
                    }
                    else {
                        document.getElementById('KASFIO').value = hashes[1];
                        document.getElementById('KASIIN').value = hashes[2];
                        document.getElementById('parKasSpr').value = "3";
                    }


        }

        //  -----------------------------------------------------------------
        //    ==========================  ПЕЧАТЬ =============================================================================================
        function TabPanelYes() {
            document.getElementById('PanelTab').style.display = 'block';
            document.getElementById('PanelAkt').style.display = 'block';
            /*
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
      */
        }


        function loadDoc(sender, index) {
            var SndPar = ddlDocNam.options[index].value;
            //          alert("loadStx 3 =" + SndPar);
            PageMethods.GetSprUsl(SndPar, onSprUslLoaded, onSprUslLoadedError);
            //         alert("loadStx 2 =" + SndPar);
        }

        function onSprUslLoaded(SprUsl) {
            //                 alert("onSprUslLoaded=" + SprUsl);

            SprUslComboBox.options.clear();
            ddlDocNam.options.add("");   //   без этой строки не работает !!!!!!!!!!!!!!!!!!!!!!!!

            for (var i = 0; i < SprUsl.length; i++) {
                SprUslComboBox.options.add(SprUsl[i]);
            }

            SprUslComboBox.value(document.getElementById('hiddenUslNam').value);
        }

        function onSprUslLoadedError() {
        }

        function updateSprUslSelection(sender, index) {
            //       alert("updateSprUslSelection=" + index);
            document.getElementById('hiddenUslNam').value = sender.value();
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtAktButton_Click() {
            //          alert("1");
            var DatDocIdn = document.getElementById('parKasIdn').value;
            //          alert("2");
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxAktDocKas&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxAktDocKas&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }


    </script>
</head>



    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

<script runat="server">


    string GlvDocIdn;
    string GlvDocPrv;

    int DtlIdn;
    string DtlNam;
    decimal DtlKol;
    string DtlEdn;
    decimal DtlZen;
    decimal DtlSum;
    string DtlIzg;
    string DtlSrkSlb;


    string GlvDocTyp;
    DateTime GlvDocDat;
    string MdbNam = "HOSPBASE";

    string BuxSid;
    string BuxKod;
    string BuxFrm;
    string CountTxt;
    int CountInt;
    decimal ItgDocSum = 0;

    int AmbCrdIdn;
    int UslIdn;
    int UslAmb;
    int UslNap;
    int UslBux;
    string UslStx;
    int UslLgt;
    string UslNam;
    string UslDat = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        //============= Установки ===========================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        BuxFrm = (string)Session["BuxFrmKod"];

        GlvDocTyp = "Прх";
        //=====================================================================================
        GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
        GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
        //============= начало  ===========================================================================================
        sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,4)='1010' AND ACCPRV=1 ORDER BY ACCKOD";
        sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,4)<>'1010' AND ACCPRV=1 ORDER BY ACCKOD";
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
 //       sdsKto.SelectCommand = "SELECT BUXKOD,FI FROM SprBuxKdr WHERE BUXFRM=1 AND ISNULL(BUXUBL,0)=0 ORDER BY FI";
        sdsNaz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNaz.SelectCommand = "SELECT BuxSpzKod,BuxSpzNam FROM SprBuxSpz";


        if (!Page.IsPostBack)
        {
            //============= Установки ===========================================================================================
            if (GlvDocIdn == "0")  // новый документ
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxKasAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
                cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@KASIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    GlvDocIdn = Convert.ToString(cmd.Parameters["@KASIDN"].Value);
                }
                finally
                {
                    con.Close();
                }


            }

            /*
            if (GlvDocPrv == "проведен")
            {
                AddButton.Visible = false;
                KASNUM.Enabled = false;
                KASDAT.Enabled = false;
                KASDEB.Enabled = false;
                KASKRD.Enabled = false;
                KASSUM.Enabled = false;
                cal1.Visible = false;
                KASKTO.Enabled = false;
                KASFIO.Enabled = false;
                KASMEM.Enabled = false;
                KASIIN.Enabled = false;
                KASFIO.Enabled = false;

             //   mySpl.TopPanel.EnableTheming = false;

            }
            */

            Session.Add("KASSPL", "");

            Session["GlvDocIdn"] = Convert.ToString(GlvDocIdn);
            parKasIdn.Value = Convert.ToString(GlvDocIdn);
            parKasPrv.Value = Convert.ToString(GlvDocPrv);

            getDocNum();
  //          getGridUsl();

        }
    }

    //============= ввод записи после опроса  ===========================================================================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("BuxKasIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxKasIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {

            KASDAT.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KASDAT"]).ToString("dd.MM.yyyy");
            KASNUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASNUM"]);
            KASSUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
            KASDEB.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASDEB"]);
            KASKRD.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASKRD"]);
            KASFIO.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIONAM"]);
            //     KASKTO.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSPRVAL"]);
            KASSYM.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSYM"]);
            parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);
            KASMEM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
            KASIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIOIIN"]);

            parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);

        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    void RebindGridUsl(object sender, EventArgs e)
    {
          getGridUsl();
    }
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        if (KASNUM.Text.Length == 0)
        {
            Err.Text = "Не указан номер документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASDAT.Text.Length == 0)
        {
            Err.Text = "Не указан дата документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASDEB.SelectedText == "")
        {
            Err.Text = "Не указан дебетовый счет";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASKRD.SelectedText == "")
        {
            Err.Text = "Не указан кредитовый счет";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASSUM.Text.Length == 0)
        {
            Err.Text = "Не указан сумма";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASFIO.Text.Length == 0)
        {
            Err.Text = "Не указан ФИО плательщика";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (KASMEM.Text.Length == 0)
        {
            Err.Text = "Не указан основание";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        ConfirmDialog.Visible = true;
        ConfirmDialog.VisibleOnLoad = true;
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnOK_click(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxKasOrdWrt", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
        cmd.Parameters.Add("@KASNUM", SqlDbType.VarChar).Value = KASNUM.Text;
        cmd.Parameters.Add("@KASDAT", SqlDbType.VarChar).Value = KASDAT.Text;

        cmd.Parameters.Add("@KASDEB", SqlDbType.VarChar).Value = KASDEB.SelectedValue;
        cmd.Parameters.Add("@KASDEBSPR", SqlDbType.VarChar).Value = "2";
        cmd.Parameters.Add("@KASDEBSPRVAL", SqlDbType.VarChar).Value = "1";

        cmd.Parameters.Add("@KASKRD", SqlDbType.VarChar).Value = KASKRD.SelectedValue;
        cmd.Parameters.Add("@KASKRDSPR", SqlDbType.VarChar).Value = parKasSpr.Value;
        cmd.Parameters.Add("@KASKRDSPRVAL", SqlDbType.VarChar).Value = KASIIN.Text;

        cmd.Parameters.Add("@KASFIO", SqlDbType.VarChar).Value = KASFIO.Text;
        cmd.Parameters.Add("@KASSUM", SqlDbType.VarChar).Value = KASSUM.Text;
        cmd.Parameters.Add("@KASVAL", SqlDbType.VarChar).Value = 0; // KASKTO.SelectedValue;
        cmd.Parameters.Add("@KASSYM", SqlDbType.VarChar).Value = KASSYM.SelectedValue;
        cmd.Parameters.Add("@KASMEM", SqlDbType.VarChar).Value = KASMEM.Text;
        cmd.Parameters.Add("@KASDOCNUM", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KASDOCDAT", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KASDOCVID", SqlDbType.VarChar).Value = "";

        cmd.ExecuteNonQuery();
        /*
                                // создание команды
                                SqlCommand cmdUsl = new SqlCommand("BuxKasPrxUslWrt", con);
                                // указать тип команды
                                cmdUsl.CommandType = CommandType.StoredProcedure;
                                cmdUsl.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                                cmdUsl.ExecuteNonQuery();
        */
        con.Close();

        ExecOnLoad("ExitFun();");

        //                       Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
    }

    // ============================ отказ записи документа в базу ==============================================
    // ============================ отказ записи документа в базу ==============================================
    //----------------  ПЕЧАТЬ  --------------------------------------------------------
    protected void PrtButton_Click(object sender, EventArgs e)
    {

 //       if (GlvDocPrv != "проведен")
 //       {

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (KASNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASDEB.SelectedText == "")
            {
                Err.Text = "Не указан дебетовый счет";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASKRD.SelectedText == "")
            {
                Err.Text = "Не указан кредитовый счет";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASSUM.Text.Length == 0)
            {
                Err.Text = "Не указан сумма";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASFIO.Text.Length == 0)
            {
                Err.Text = "Не указан ФИО плательщика";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (KASMEM.Text.Length == 0)
            {
                Err.Text = "Не указан основание";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            ConfirmDialogPrt.Visible = true;
            ConfirmDialogPrt.VisibleOnLoad = true;
 //       }
 //       else
 //       {
  //          GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);

   //         ExecOnLoad("PrtPrxOrd();");
  //      }

        //                      System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "Alert('PrtPrxOrd();')", true);
        //        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Alert('PrtPrxOrd();')", true);
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnPrtOK_click(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxKasOrdWrt", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
        cmd.Parameters.Add("@KASNUM", SqlDbType.VarChar).Value = KASNUM.Text;
        cmd.Parameters.Add("@KASDAT", SqlDbType.VarChar).Value = KASDAT.Text;

        cmd.Parameters.Add("@KASDEB", SqlDbType.VarChar).Value = KASDEB.SelectedValue;
        cmd.Parameters.Add("@KASDEBSPR", SqlDbType.VarChar).Value = "2";
        cmd.Parameters.Add("@KASDEBSPRVAL", SqlDbType.VarChar).Value = "1";

        cmd.Parameters.Add("@KASKRD", SqlDbType.VarChar).Value = KASKRD.SelectedValue;
        cmd.Parameters.Add("@KASKRDSPR", SqlDbType.VarChar).Value = parKasSpr.Value;
        cmd.Parameters.Add("@KASKRDSPRVAL", SqlDbType.VarChar).Value = KASIIN.Text;

        cmd.Parameters.Add("@KASFIO", SqlDbType.VarChar).Value = KASFIO.Text;
        cmd.Parameters.Add("@KASSUM", SqlDbType.VarChar).Value = KASSUM.Text;
        cmd.Parameters.Add("@KASVAL", SqlDbType.VarChar).Value = 0;   // KASKTO.SelectedValue;
        cmd.Parameters.Add("@KASSYM", SqlDbType.VarChar).Value = KASSYM.SelectedValue;
        cmd.Parameters.Add("@KASMEM", SqlDbType.VarChar).Value = KASMEM.Text;
        cmd.Parameters.Add("@KASDOCNUM", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KASDOCDAT", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KASDOCVID", SqlDbType.VarChar).Value = "";

        cmd.ExecuteNonQuery();
        /*
                                // создание команды
                                SqlCommand cmdUsl = new SqlCommand("BuxKasPrxUslWrt", con);
                                // указать тип команды
                                cmdUsl.CommandType = CommandType.StoredProcedure;
                                cmdUsl.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                                cmdUsl.ExecuteNonQuery();
        */
        con.Close();

        //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        ExecOnLoad("PrtPrxOrd();");

        ExecOnLoad("ExitFun();");

        //               Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
    }

    // ============================ отказ записи документа в базу ==============================================
    protected void CanButton_Click(object sender, EventArgs e)
    {
        if (GlvDocPrv != "проведен")
        {

            GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxKasOrdCan", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
            cmd.ExecuteNonQuery();

            con.Close();
        }

        ExecOnLoad("ExitFun();");
        //            Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
    }

    protected void TabButton_Click(object sender, EventArgs e)
    {
        getGridUsl();
    }

    void getGridUsl()
    {
        if (parKasSpr.Value != "3") return;

   //     ExecOnLoad("ButClick();");
        GridUsl.Visible = true;


        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslKas", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
        cmd.Parameters.Add("@KASIIN", SqlDbType.VarChar).Value = KASIIN.Text;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslKas");

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

 //       ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "DoPostBack", "__doPostBack(sender, e)", true);
  //      Response.Redirect("BuxKasPrxTab.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=0", false);

    }


    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddKasButton_Click(object sender, EventArgs e)
    {
        parKasOpr.Value = "+";
        btnKasOK();
    }
    
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void DelKasButton_Click(object sender, EventArgs e)
    {
        parKasOpr.Value = "-";
        btnKasOK();
    }

    // ============================ одобрение для записи документа в базу ==============================================
//    protected void btnKasOK_click(object sender, EventArgs e)
    protected void btnKasOK()
    {
        string LstIdn = "";

        if (GridUsl.SelectedRecords != null)
        {
            foreach (Hashtable oRecord in GridUsl.SelectedRecords)
            {
                LstIdn = LstIdn + Convert.ToInt32(oRecord["USLIDN"]).ToString("D10") + ":"; // форматирование строки
            }

        }

        if (LstIdn.Length == 0)
        {
  //          ConfirmDialogKas.Visible = false;
  //          ConfirmDialogKas.VisibleOnLoad = false;

            return;
        }

        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);

        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUslKasAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@KASIIN", SqlDbType.VarChar).Value = KASIIN.Text;
        cmd.Parameters.Add("@LSTIDN", SqlDbType.VarChar).Value = LstIdn;
        cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = parKasOpr.Value;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslKasAdd");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            KASSUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
            KASMEM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
        }

        getGridUsl();

  //      ConfirmDialogKas.Visible = false;
 //       ConfirmDialogKas.VisibleOnLoad = false;


        //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //   ExecOnLoad("PrtPrxOrd();");
    }


    //------------------------------------------------------------------------
   
    // ===================================================================================================================================================================                   
    // ===================================================================================================================================================================                   
    // ===================================================================================================================================================================                   

    void InsertRecordUsl(object sender, GridRecordEventArgs e)
    {
        //        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        //        else UslNap = Convert.ToInt32(e.Record["USLNAP"]);
        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);

        AmbCrdIdn = 0;

        UslBux = Convert.ToInt32(e.Record["BUXKOD"]);
        UslNap = 0;
        UslStx = "00000";

        if (Convert.ToString(e.Record["GRFDAT"]) == null || Convert.ToString(e.Record["GRFDAT"]) == "") UslDat = "";
        else UslDat = Convert.ToString(e.Record["GRFDAT"]);
        
  //      DateTime dt;
  //      bool parse = DateTime.TryParse(UslDat, out dt);//parse=false
       
        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspKasUslStxAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIIN", SqlDbType.VarChar).Value = KASIIN.Text;
        cmd.Parameters.Add("@USLPTH", SqlDbType.VarChar).Value = KASFIO.Text;
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@USLBUX", SqlDbType.Int, 4).Value = UslBux;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = UslDat;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;

        // создание команды

        cmd.ExecuteNonQuery();
        con.Close();

        //    TabButton_Click(this, EventArgs.Empty);   // нажатие кнопки в программе
        //   ExecOnLoad("ClickBut();");
        getGridUsl();
    }

    void UpdateRecordUsl(object sender, GridRecordEventArgs e)
    {
        AmbCrdIdn = Convert.ToInt32(e.Record["GRFIDN"]);
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);
        //       if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        //       else UslNap = Convert.ToInt32(e.Record["USLNAP"]);

        UslBux = Convert.ToInt32(e.Record["BUXKOD"]);

        UslNap = 0;

        UslStx = "00000";

        if (Convert.ToString(e.Record["GRFDAT"]) == null || Convert.ToString(e.Record["GRFDAT"]) == "") UslDat = "";
        else UslDat = Convert.ToString(e.Record["GRFDAT"]);
        
        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspKasUslStxRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLBUX", SqlDbType.Int, 4).Value = UslBux;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = UslDat;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGridUsl();
    }

    void DeleteRecordUsl(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGridUsl();
    }

    //==================================================================================================================================================
    [WebMethod]
    public static List<string> GetSprUsl(string StxKod)
    {
        List<string> SprUsl = new List<string>();

        string[] MasLst = StxKod.Split(':');


        if (!string.IsNullOrEmpty(StxKod))
        {
            string SqlStr;
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("HspAmbUslPltSou", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = MasLst[0];
            // создание команды

            con.Open();

            SqlDataReader myReader = cmd.ExecuteReader();
            while (myReader.Read())
            {
                SprUsl.Add(myReader.GetString(0));
            }

            con.Close();
        }

        return SprUsl;
    }

                    // =================================================================================================================================================
                   
</script>

<body>
    <form id="form1" runat="server">

        <%-- ************************************* HTML **************************************************** --%>
        <%-- ************************************* HTML **************************************************** --%>
        <%-- ************************************* HTML **************************************************** --%>

        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parKasPrv" runat="server" />
        <asp:HiddenField ID="parKasSpr" runat="server" />
        <asp:HiddenField ID="parKasKod" runat="server" />
        <asp:HiddenField ID="parKasNam" runat="server" />
        <asp:HiddenField ID="parKasZen" runat="server" />
        <asp:HiddenField ID="parKasOpr" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka0"
            Text="Кассовый приходной ордер"
            BackColor="#3CB371"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 0%; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>
        <%-- ============================  подшапка  ============================================ --%>
        <%-- ============================  средний блок  ============================================ --%>
        <%-- ============================  средний блок  ============================================ 
      <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />
        --%>

        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 170px;">

            <table border="1" cellspacing="0" width="100%">
                <tr>
                    <td width="5%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Признак</td>
                    <td width="14%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">№ доку<wbr>мента</td>
                    <td width="8%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Дата</td>
                    <td width="8%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Счет кассы</td>
                    <td width="21%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Корр.счет</td>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Сумма</td>
                    <td width="5%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">НДС</td>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Сумма НДС</td>
                    <td width="19%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Назачения</td>
                </tr>

                <tr>
                    <td width="5%" class="PO_RowCap"></td>
                    <td width="14%" class="PO_RowCap">
                        <asp:TextBox ID="KASNUM" Font-Size="Medium" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="13%" class="PO_RowCap">
                        <asp:TextBox runat="server" ID="KASDAT" Width="80px" />
                        <obout:Calendar ID="cal1" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="DOCDAT"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                    </td>
                    <td width="10%" class="PO_RowCap">
                        <obout:ComboBox runat="server" ID="KASDEB" Width="100%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsDeb" DataTextField="AccKod" DataValueField="AccKod">
                        </obout:ComboBox>

                    </td>

                    <td width="10%" class="PO_RowCap">
                        <obout:ComboBox runat="server" ID="KASKRD" Width="100%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsKrd" DataTextField="AccKod" DataValueField="AccKod">
                        </obout:ComboBox>
                    </td>
                    <td width="10%" class="PO_RowCap">
                        <asp:TextBox ID="KASSUM" Font-Size="Medium" Font-Bold="true" Style="text-align: right" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="5%" class="PO_RowCap"></td>
                    <td width="10%" class="PO_RowCap"></td>
                    <td width="19%" colspan="3" class="PO_RowCap">
                        <obout:ComboBox runat="server" ID="KASSYM" Width="100%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsNaz" DataTextField="BUXSPZNAM" DataValueField="BUXSPZKOD">
                        </obout:ComboBox>
                    </td>

                </tr>
                <tr>
                    <td width="5%" align="center" style="font-weight: bold;" class="PO_RowCap">Принято</td>
                    <td width="14%" class="PO_RowCap">
                        <asp:TextBox ID="KASIIN" Font-Size="Medium" Font-Bold="true" Style="text-align: left" Width="98%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="40%" colspan="2" class="PO_RowCap">
                        <asp:TextBox ID="KASFIO" Font-Size="Medium" Font-Bold="true" Style="text-align: left" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="14%" align="center" style="font-weight: bold;" class="PO_RowCap">
                        <input type="button" value="Клиент" style="width: 30%" id="FioBut" onclick="ButFio_Click()" />
                        <input type="button" value="Сотрудник" style="width: 30%" id="KdrBut" onclick="ButKdr_Click()" />
                        <input type="button" value="Фирма" style="width: 30%" id="FrmBut" onclick="ButFrm_Click()" />
                    </td>
                    <td width="10%" colspan="3" class="PO_RowCap"></td>
                    <td width="10%" class="PO_RowCap"></td>
                </tr>

                <tr>
                    <td width="5%" align="center" style="font-weight: bold;" class="PO_RowCap">Основан.</td>
                    <td width="85%" colspan="8" class="PO_RowCap">
                        <obout:OboutTextBox runat="server" ID="KASMEM" Width="100%" BackColor="White" Height="80px" Font-Bold="true"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>

        </asp:Panel>
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  нижний блок  ============================================ --%>
        <%-- ============================  нижний блок  ============================================ --%>

        <asp:Panel ID="PanelBut" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 25px;">
            <center>
                <asp:Button ID="AddButton" runat="server" CommandName="Cancel" Text="Записать" OnClick="AddButton_Click" />
                <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать" OnClick="PrtButton_Click" />
                <asp:Button ID="TabButton" runat="server" CommandName="Cancel" Text="Услуги" OnClientClick="ButClick();" OnClick="TabButton_Click" />
                <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Закрыть" OnClick="CanButton_Click" />
            </center>
        </asp:Panel>
        <%-- ============================  нижний блок  ============================================ --%>
            <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelTab" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 260px;">
            <%-- ============================  шапка экрана ============================================ --%>
            <%-- ============================  шапка экрана ============================================ --%>
            
            <%-- ============================  шапка экрана ============================================ --%>
                    <obout:Grid ID="GridUsl" runat="server"
                        CallbackMode="true"
                        Serialize="true"
                        FolderStyle="~/Styles/Grid/style_5"
                        AutoGenerateColumns="false"
                        ShowTotalNumberOfPages="false"
                        FolderLocalization="~/Localization"
                        AllowAddingRecords="true"
                        AllowRecordSelection="true"
                        AllowSorting="false"
                        Language="ru"
                        PageSize="-1"
                        AllowPaging="false"
                        Width="99%"
                        AllowPageSizeSelection="false"
                        EnableTypeValidation="false"
                        OnRebind="RebindGridUsl" OnInsertCommand="InsertRecordUsl" OnDeleteCommand="DeleteRecordUsl" OnUpdateCommand="UpdateRecordUsl"
                        ShowColumnsFooter="true">
                        <ScrollingSettings ScrollHeight="200" />
                        <Columns>
                            <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                            <obout:Column ID="Column1" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%" />
                            <obout:Column ID="Column2" DataField="KASOPL" HeaderText="ОПЛАЧЕНО" Width="5%" ReadOnly="true" />
                            <obout:Column ID="Column3" DataField="GRFDAT" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ReadOnly="true" Width="10%" />
                            <obout:Column ID="Column4" DataField="BUXKOD" HeaderText="ВРАЧ" Width="15%">
                                <TemplateSettings TemplateId="TemplateDocNam" EditTemplateId="TemplateEditDocNam" />
                            </obout:Column>
                            <obout:Column ID="Column5" DataField="DLGNAM" HeaderText="СПЕЦ." Width="8%" ReadOnly="true" />
                            <obout:Column ID="Column6" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="37%" Align="left">
                                <TemplateSettings TemplateId="TemplateUslNam" EditTemplateId="TemplateEditUslNam" />
                            </obout:Column>
                            <obout:Column ID="Column7" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="5%" />
                            <obout:Column ID="Column8" DataField="USLZEN" HeaderText="ЦЕНА" Width="5%" ReadOnly="true" />
                            <obout:Column ID="Column9" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" />
                            <obout:Column ID="Column10" HeaderText="Коррек  Удаление" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
                                <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                            </obout:Column>
                        </Columns>

                        <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                        <Templates>
                            <obout:GridTemplate runat="server" ID="tplDatePickerDat" ControlID="txtOrderDateDat" ControlPropertyName="value">
                                <Template>
                                    <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                        <tr>
                                            <td valign="middle">
                                                <obout:OboutTextBox runat="server" ID="txtOrderDateDat" Width="100%"
                                                    FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                            </td>
                                            <td valign="bottom" width="30">
                                                <obout:Calendar ID="calDat" runat="server"
                                                    StyleFolder="~/Styles/Calendar/styles/default"
                                                    DatePickerMode="true"
                                                    ShowYearSelector="true"
                                                    YearSelectorType="DropDownList"
                                                    TitleText="Выберите год: "
                                                    CultureName="ru-RU"
                                                    DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />


                                            </td>
                                        </tr>
                                    </table>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="editBtnTemplate">
                                <Template>
                                    <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridUsl.edit_record(this)" />
                                    <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                                <Template>
                                    <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)" />
                                    <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="addTemplate">
                                <Template>
                                    <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl.addRecord()" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="saveTemplate">
                                <Template>
                                    <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUsl.insertRecord()" />
                                    <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="TemplateDocNam">
                                <Template>
                                    <%# Container.DataItem["BuxNam"]%>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ControlID="ddlDocNam" ID="TemplateEditDocNam" ControlPropertyName="value">
                                <Template>
                                    <obout:ComboBox runat="server" ID="ddlDocNam" Width="100%" Height="150"
                                        FolderStyle="/Styles/Combobox/premiere_blue"
                                        DataSourceID="sdsKto" DataTextField="BUXNAM" DataValueField="BUXKOD">
                                        <ClientSideEvents OnSelectedIndexChanged="loadDoc" />
                                    </obout:ComboBox>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="TemplateUslNam">
                                <Template>
                                    <%# Container.DataItem["UslNam"]%>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUslNam" ControlPropertyName="value">
                                <Template>
                                    <input type="hidden" id="hiddenUslNam" />
                                    <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="300"
                                        FolderStyle="/Styles/Combobox/premiere_blue">
                                        <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                                    </obout:ComboBox>
                                </Template>
                            </obout:GridTemplate>


                        </Templates>
                    </obout:Grid>

        </asp:Panel>


        <asp:Panel ID="PanelAkt" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                <asp:Button ID="Button3" runat="server" CommandName="Cancel" Text="Добавить в кассу" OnClick="AddKasButton_Click" />
                <asp:Button ID="Button6" runat="server" CommandName="Cancel" Text="Удалить из кассы" OnClick="DelKasButton_Click" />
                <input type="button" name="PrtAktButton" value="Печать (Акт)" id="PrtButton" onclick="PrtAktButton_Click();">
                <asp:Button ID="Button5" runat="server" CommandName="Cancel" Text="Закрыть" OnClick="CanButton_Click" />
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
                            <input type="button" value="Назад" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>
            </center>
        </owd:Dialog>
        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialogPrt" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать и распечатать?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                            <asp:Button runat="server" ID="Button1" Text="ОК" OnClick="btnPrtOK_click" />
                            <input type="button" value="Назад" onclick="ConfirmDialogPrt.Close();" />
                        </td>
                    </tr>
                </table>
            </center>
        </owd:Dialog>

        <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

        <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="450" Height="150" StyleFolder="/Styles/Window/wdstyles/default" Title="" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="Err" ReadOnly="True" Width="300" Text="" BackColor="Transparent" BorderStyle="None" Font-Size="Large" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                            <input type="button" value="OK" style="width: 150px; height: 30px;" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>
            </center>
        </owd:Dialog>

        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>

        <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="BuxKasDocSel" SelectCommandType="StoredProcedure" 
             ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="BuxFrmKod" Name="BUXFRM" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

        <%-- =================  источник  для ГРИДА============================================ --%>
        <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="sdsNaz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>



    </form>

        <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%> 
 

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
         <%-- ============================ стили ============================================ --%> 
   <style type="text/css">
        .super-form {
            margin: 12px;
        }

        .ob_fC table td {
            white-space: normal !important;
        }

        .command-row .ob_fRwF {
            padding-left: 50px !important;
        }

        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
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
    </style>


   </body>
</html>
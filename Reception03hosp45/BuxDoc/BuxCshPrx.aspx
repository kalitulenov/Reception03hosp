<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
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

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%> 
 

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>


    <%-- ============================  стили ============================================ --%>
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
    </style>

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;
        //    ------------------ смена логотипа ----------------------------------------------------------

        window.onload = function () {
            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var GlvDocPrv = document.getElementById('parKasPrv').value;
     //       mySpl.loadPage("BottomContent", "/Priem/DocAppAmbUsl.aspx?AmbCrdIdn=" + GlvDocIdn);
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


        function PrtPrxOrd() {
  //          alert("PrtPrxOrd=");

            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxCshPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxCshPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
        function ExitFun() {
            window.parent.KasClose();
            //       location.href = "/BuxDoc/BuxCsh.aspx?NumSpr=Csh&TxtSpr=Касса № 2";
        }

        function ButFio_Click(sender, record) {
            //      alert("AddButton_Click=");
            var GlvBuxFrm = document.getElementById('parBuxFrm').value;
       //     alert("GlvBuxFrm=" + GlvBuxFrm);
            var ua = navigator.userAgent;
            if (GlvBuxFrm == '3') {
                if (ua.search(/Chrome/) > -1)
                    window.open("/Referent/RefGlv003Klt.aspx", "ModalPopUp", "toolbar=no,width=1200,height=620,left=200,top=110,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Referent/RefGlv003Klt", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:110px;dialogWidth:1200px;dialogHeight:620px;");
            }
            else {
                if (ua.search(/Chrome/) > -1)
                    window.open("/Priem/DocAppKlt.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Priem/DocAppKlt.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
            }
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

        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

        function HandlePopupResult(result) {
        //           alert("result of popup is: " + result);
            var hashes = result.split('&');
            //        alert("hashes=" + hashes[0]);



            switch (hashes[0]) {
                case "OLD": // USL
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
                    break;
                case "USL":
                    document.getElementById('parKasSum').value = parseInt(hashes[1]);
                    document.getElementById('parKasMem').value = hashes[2];
          //                                alert("hashes1=" + hashes[1]);
                    //                                alert("hashes2=" + hashes[2]);
                    if (document.getElementById('KASSUM').value.length == 0) document.getElementById('KASSUM').value = 0;
                    if (document.getElementById('parKasSum').value.length > 0) document.getElementById('KASSUM').value = parseInt(document.getElementById('KASSUM').value) + parseInt(document.getElementById('parKasSum').value);
                    if (document.getElementById('parKasMem').value.length > 0) document.getElementById('KASMEM').value = document.getElementById('KASMEM').value + document.getElementById('parKasMem').value;
                    break;
                case "KDR":
                    document.getElementById('KASIIN').value = hashes[1];
                    document.getElementById('KASFIO').value = hashes[2];
                    document.getElementById('parKasSpr').value = "1";
                    break;
                case "FRM":
                    document.getElementById('KASFIO').value = hashes[1];
                    document.getElementById('KASIIN').value = hashes[2];
                    document.getElementById('parKasSpr').value = "2";
                    break;
                default:
                    document.getElementById('KASFIO').value = hashes[1];
                    document.getElementById('KASIIN').value = hashes[2];
                    document.getElementById('parKasSpr').value = "3";
                break;
            }

        }

        //  -----------------------------------------------------------------

        //  -----------------------------------------------------------------

        function TabButton_Click() {
     //       alert("TabButton_Clic=");
            if (document.getElementById('parKasSpr').value == "3") {
                var GlvKasIdn = document.getElementById('parKasIdn').value;
                var GlvKasIin = document.getElementById('KASIIN').value;
                var GlvKasFio = document.getElementById('KASFIO').value;

    //                    alert("GlvKasIdn=" + GlvKasIdn);
    //                     alert("GlvKasIin=" + GlvKasIin);
    //                      alert("GlvKasFio=" + GlvKasFio);
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Priem/BuxCshPrxSpr.aspx?KasIdn=" + GlvKasIdn + "&KasIin=" + GlvKasIin,
                                "ModalPopUp", "toolbar=no,width=1100,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Priem/BuxCshPrxSpr.aspx?KasIdn=" + GlvKasIdn + "&KasIin=" + GlvKasIin,
                        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1100px;dialogHeight:650px;");
                return false;
            }
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

        protected void Page_Load(object sender, EventArgs e)
        {
            //============= Установки ===========================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            BuxFrm = (string)Session["BuxFrmKod"];

            parBuxFrm.Value = Convert.ToString(BuxFrm);


            GlvDocTyp = "Прх";
            //=====================================================================================
            GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,4)='1010' AND ACCPRV=1 ORDER BY ACCKOD";
            sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND ACCPRV=1 ORDER BY ACCKOD";
            sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " ORDER BY FI";
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
                    SqlCommand cmd = new SqlCommand("BuxCshAdd", con);
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
                    parKasTyp.Value = "ADD";
                    
                }
                else parKasTyp.Value = "REP";

/*
                if (GlvDocPrv == "проведен")
                {
                    AddButton.Visible = false;
              //      CanButton.Visible = false;
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
                }
*/
                ConfirmDialog.Visible = false;
                ConfirmDialog.VisibleOnLoad = false;

                Session.Add("KASSPL", "");
              
                Session["GlvDocIdn"] = Convert.ToString(GlvDocIdn);
                parKasIdn.Value = Convert.ToString(GlvDocIdn);
                parKasPrv.Value = Convert.ToString(GlvDocPrv);

                getDocNum();
                getDocUsl();

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
                        SqlCommand cmd = new SqlCommand("BuxCshIdn", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;

                        // создание DataAdapter
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "BuxCshIdn");

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
             void getDocUsl()
             {


             }
                    // ============================ проводить записи документа в базу ==============================================

                    void RebindGrid(object sender, EventArgs e)
                    {
//                        getGrid();
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
                        SqlCommand cmd = new SqlCommand("BuxCshOrdWrt", con);
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
                        cmd.Parameters.Add("@KASVAL", SqlDbType.VarChar).Value = 0;  // KASKTO.SelectedValue;
                        cmd.Parameters.Add("@KASSYM", SqlDbType.VarChar).Value = KASSYM.SelectedValue;
                        cmd.Parameters.Add("@KASMEM", SqlDbType.VarChar).Value = KASMEM.Text;
                        cmd.Parameters.Add("@KASDOC", SqlDbType.VarChar).Value = "";
                        
 //                       cmd.Parameters.Add("@KASDOCNUM", SqlDbType.VarChar).Value = "";
 //                       cmd.Parameters.Add("@KASDOCDAT", SqlDbType.VarChar).Value = "";
 //                       cmd.Parameters.Add("@KASDOCVID", SqlDbType.VarChar).Value = "";
                        
                        cmd.ExecuteNonQuery();
/*
                        // создание команды
                        SqlCommand cmdUsl = new SqlCommand("BuxCshPrxUslWrt", con);
                        // указать тип команды
                        cmdUsl.CommandType = CommandType.StoredProcedure;
                        cmdUsl.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                        cmdUsl.ExecuteNonQuery();
*/                                                
                        con.Close();
                        
                        ExecOnLoad("ExitFun();");

 //                       Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
                    }

                    // ============================ проверка и опрос для записи документа в базу ==============================================
                    protected void NonPrvButton_Click(object sender, EventArgs e)
                    {
                        ConfirmDialogPrv.Visible = true;
                        ConfirmDialogPrv.VisibleOnLoad = true;
                    }                  
                    // ============================ Снять признак проведен ==============================================
                    protected void NonPrvButtonOK_Click(object sender, EventArgs e)
                    {
                        GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();

                        // создание команды
                        SqlCommand cmd = new SqlCommand("BuxCshOrdNonPrv", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
                        cmd.Parameters.Add("@KASBUX", SqlDbType.Int, 4).Value = Convert.ToInt32(BuxKod);

                        cmd.ExecuteNonQuery();
                        con.Close();

                        ExecOnLoad("ExitFun();");

                        //                       Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
                    }
                    // ============================ отказ записи документа в базу ==============================================
                    // ============================ отказ записи документа в базу ==============================================
                    //----------------  ПЕЧАТЬ  --------------------------------------------------------
                    protected void PrtButton_Click(object sender, EventArgs e)
                    {

                        if (GlvDocPrv != "проведен")
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

                            ConfirmDialogPrt.Visible = true;
                            ConfirmDialogPrt.VisibleOnLoad = true;
                        }
                        else
                        {
                            GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
                           
                            ExecOnLoad("PrtPrxOrd();");
                        }

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
                        SqlCommand cmd = new SqlCommand("BuxCshOrdWrt", con);
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
                        cmd.Parameters.Add("@KASDOC", SqlDbType.VarChar).Value = "";
                        
                        //        cmd.Parameters.Add("@KASDOCNUM", SqlDbType.VarChar).Value = "";
                 //       cmd.Parameters.Add("@KASDOCDAT", SqlDbType.VarChar).Value = "";
                 //       cmd.Parameters.Add("@KASDOCVID", SqlDbType.VarChar).Value = "";

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
                    //    if (GlvDocPrv != "проведен")
                        if (parKasTyp.Value == "ADD")
                        {
                            
                            GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
                            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                            // создание соединение Connection
                            SqlConnection con = new SqlConnection(connectionString);
                            con.Open();

                            // создание команды
                            SqlCommand cmd = new SqlCommand("BuxCshOrdCan", con);
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
                    
                                       
 </script>

<body>
    <form id="form1" runat="server">   

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

    <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parKasPrv" runat="server" />
        <asp:HiddenField ID="parKasSpr" runat="server" />
        <asp:HiddenField ID="parKasKod" runat="server" />
        <asp:HiddenField ID="parKasNam" runat="server" />
        <asp:HiddenField ID="parKasZen" runat="server" />
        <asp:HiddenField ID="parKasSum" runat="server" />
        <asp:HiddenField ID="parKasMem" runat="server" />
        <asp:HiddenField ID="parKasTyp" runat="server" />
    <%-- ============================  шапка экрана ============================================ --%>
    <asp:TextBox ID="Sapka0"
        Text="Кассовый приходной ордер"
        BackColor="#0099ff"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0%; position: relative; width: 100%; text-align: center"
        runat="server"></asp:TextBox>
    <%-- ============================  подшапка  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>
      <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 0%; position: relative; top: 0px; width: 100%; height: 220px;">

        <table border="1" cellspacing="0" width="100%">
            <tr>
                <td width="11%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Признак</td>
                <td width="12%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">№ доку<wbr>мента</td>
                <td width="13%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Дата</td>
                <td width="10%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Счет кассы</td>
                <td width="15%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Корр.счет</td>
                <td width="10%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Сумма</td>
                <td width="05%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">НДС</td>
                <td width="10%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Сумма НДС</td>
                <td width="19%" align="center" style="font-weight: bold; background-color: gray" class="PO_RowCap">Назачения</td>
            </tr>

            <tr>
                <td width="11%" class="PO_RowCap"></td>
                <td width="12%" class="PO_RowCap">
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
                        TextBoxId="KASDAT"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                </td>
                <td width="10%" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASDEB" Width="100%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsDeb" DataTextField="AccKod" DataValueField="AccKod">
                    </obout:ComboBox>

                </td>

                <td width="15%" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASKRD" Width="100%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsKrd" DataTextField="AccKod" DataValueField="AccKod">
                    </obout:ComboBox>
                </td>
                <td width="10%" class="PO_RowCap">
                    <asp:TextBox ID="KASSUM" Font-Size="Medium" Font-Bold="true" style="text-align:right" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="5%" class="PO_RowCap"></td>
                <td width="10%" class="PO_RowCap"></td>
                <td width="19%" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASSYM" Width="100%" Height="200"
                          FolderStyle="/Styles/Combobox/Plain"
                          DataSourceID="sdsNaz" DataTextField="BUXSPZNAM" DataValueField="BUXSPZKOD" >
                    </obout:ComboBox>
                </td>

            </tr>
            <tr>
                <td width="11%" align="center" style="font-weight: bold;" class="PO_RowCap">Принято от</td>
                <td width="12%" class="PO_RowCap">
                    <asp:TextBox ID="KASIIN" Font-Size="Medium" Font-Bold="true" style="text-align:left" Width="98%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="40%" colspan="2" class="PO_RowCap">
                    <asp:TextBox ID="KASFIO" Font-Size="Medium" Font-Bold="true" style="text-align:left" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="20%" align="center" style="font-weight: bold;" class="PO_RowCap">
                    <input type="button" value="Клиент" style="width:30%" id="FioBut"  onclick="ButFio_Click()" />
                    <input type="button" value="Сотрудник" style="width:30%" id="KdrBut"  onclick="ButKdr_Click()" />
                    <input type="button" value="Фирма" style="width:30%" id="FrmBut"  onclick="ButFrm_Click()" />
                </td>
                <td width="10%" colspan="3" class="PO_RowCap"> </td>
                <td width="19%" class="PO_RowCap"> 
              </td>
            </tr>
            
            <tr>
                <td width="11%" align="center" style="font-weight: bold;" class="PO_RowCap">Основание</td>
                <td width="85%" colspan="8" class="PO_RowCap">
                    <obout:OboutTextBox runat="server" ID="KASMEM" Width="100%" BackColor="White" Height="125px" Font-Bold="true"
                           TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                    </obout:OboutTextBox>
                </td>
            </tr>
        </table>

    </asp:Panel>
        <%-- ============================  шапка экрана ============================================ --%>

<%-- ============================  нижний блок  ============================================ --%>
<%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                 <asp:Button ID="AddButton" runat="server" CommandName="Cancel" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать" onclick="PrtButton_Click"/>
                 <input type="button" name="TabButton" value="Услуги" id="TabButton" onclick="TabButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Закрыть" OnClick="CanButton_Click" />
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
                              <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="btnOK_click" />
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
                              <asp:Button runat="server" ID="Button1" Text="ОК" onclick="btnPrtOK_click" />
                              <input type="button" value="Назад" onclick="ConfirmDialogPrt.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialogPrv" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите не проводить?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="NonPrvButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialogPrv.Close();" />
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
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Text="" BackColor="Transparent" BorderStyle="None"  Font-Size="Large"  Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" style="width:150px; height:30px;"  onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

<%-- =================  источник  для ГРИДА============================================ --%>
    <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsNaz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

      </form>
   </body>
</html>
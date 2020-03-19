<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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
        .Textbox {}
        .auto-style1 {
            width: 587px;
        }
        .auto-style2 {
            width: 208px;
        }
        .auto-style6 {
            width: 587px;
            height: 24px;
        }
    </style>

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;
        //    ------------------ смена логотипа ----------------------------------------------------------

        window.onload = function () {
            var GlvDocIdn = document.getElementById('parPltIdn').value;
            var GlvDocPrv = document.getElementById('parPltPrv').value;
   //         mySpl.loadPage("BottomContent", "/Priem/DocAppAmbUsl.aspx?AmbCrdIdn=" + GlvDocIdn);
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


        function PrtPltOne() {
            var GlvDocIdn = document.getElementById('parPltIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxPltPor&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPltPor&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function ExitFun() {
            window.parent.PltClose();
            location.href = "/BuxDoc/BuxPlt.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        // ==================================== 11111111111111111111111111111111111111  ============================================
        function BNKKRDSPRVAL_SelectedIndexChanged(sender, selectedIndex) {
            //      alert("selectedIndex=" + selectedIndex);
            //       var GrfDlg = BoxDoc001.value();
            var BnkKod = BNKKODBNK.options[BNKKODBNK.selectedIndex()].value;
            var ParStr = document.getElementById('parBuxFrm').value + ':' + BnkKod + ':';

       //        alert("ParStr=" + ParStr);
            
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/BuxPltOneKrd',
                contentType: "application/json; charset=utf-8",
                data: '{"ParStr":"' + ParStr + '"}',
                dataType: "json",
                success: function (msg) {
                    //        alert("msg=" + msg);
                    //        alert("msg.d=" + msg.d);
                    //                                alert("msg.d2=" + msg.d.substring(0, 3));
                    //                                alert("msg.d3=" + msg.d.substring(3, 7));
                    var hashes = msg.d.split(':');
                    document.getElementById('OTPBIN').value = hashes[0];
                    document.getElementById('OTPBNK').value = hashes[1];
                    document.getElementById('OTPIIK').value = hashes[2];
                    document.getElementById('OTPKBE').value = hashes[3];
                    document.getElementById('OTPBIK').value = hashes[4];
                    //         alert("parSpr001.value=" + parSpr001.value);
                    //        alert("parSpr002.value=" + parSpr002.value);
                    //         alert("parSpr003.value=" + parSpr003.value);
                },
                error: function () { }
            });
           

        }
        // ==================================== 11111111111111111111111111111111111111  ============================================
        function BNKDEBSPRVAL_SelectedIndexChanged(sender, selectedIndex) {
            //      alert("selectedIndex=" + selectedIndex);
            //       var GrfDlg = BoxDoc001.value();
            var OrgKod = BNKDEBSPRVAL.options[BNKDEBSPRVAL.selectedIndex()].value;
            var ParStr = OrgKod + ':';

        //    alert("ParStr=" + ParStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/BuxPltOneDeb',
                contentType: "application/json; charset=utf-8",
                data: '{"ParStr":"' + ParStr + '"}',
                dataType: "json",
                success: function (msg) {
                    //        alert("msg=" + msg);
                    //        alert("msg.d=" + msg.d);
                    //                                alert("msg.d2=" + msg.d.substring(0, 3));
                    //                                alert("msg.d3=" + msg.d.substring(3, 7));
                    var hashes = msg.d.split(':');
                    document.getElementById('POLBIN').value = hashes[0];
                    document.getElementById('POLBNK').value = hashes[1];
                    document.getElementById('POLIIK').value = hashes[2];
                    document.getElementById('POLKBE').value = hashes[3];
                    document.getElementById('POLBIK').value = hashes[4];
                    //         alert("parSpr001.value=" + parSpr001.value);
                    //        alert("parSpr002.value=" + parSpr002.value);
                    //         alert("parSpr003.value=" + parSpr003.value);
                },
                error: function () { }
            });
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
            parBuxFrm.Value = BuxFrm;


            GlvDocTyp = "Рсх";
            //=====================================================================================
            GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDeb.SelectCommand = "SELECT SprBnk.BNKKOD,SprOrg.ORGNAM + '  БИК  ' + SprBnk.BNKBIK AS ORGNAM " +
                                   "FROM SprOrg INNER JOIN SprOrgBnk ON SprOrg.ORGKOD=SprOrgBnk.ORGBNKORG " +
                                               "INNER JOIN SprBnk ON SprOrgBnk.ORGBNKKOD=SprBnk.BNKKOD " +
                                               "INNER JOIN SprOrgKlt ON SprOrg.ORGBIN=SprOrgKlt.ORGKLTBIN " +
                                   "WHERE SprOrgKlt.ORGKLTKOD=" + BuxFrm;
            sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKrd.SelectCommand = "SELECT ORGKOD, ORGNAM FROM SPRORG WHERE ORGFRM=" + BuxFrm + " ORDER BY ORGNAM";
            sdsNaz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNaz.SelectCommand = "SELECT EKNKOD,EKNNAM FROM SPREKN";

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
                    SqlCommand cmd = new SqlCommand("BuxPltAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BNKFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@BNKBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@BNKIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@BNKIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        GlvDocIdn = Convert.ToString(cmd.Parameters["@BNKIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }

                Session.Add("BNKSPL", "");

                Session["GlvDocIdn"] = Convert.ToString(GlvDocIdn);
                parPltIdn.Value = Convert.ToString(GlvDocIdn);
                parPltPrv.Value = Convert.ToString(GlvDocPrv);

                getDocNum();
          //      getDocUsl();

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
            SqlCommand cmd = new SqlCommand("BuxPltIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BNKIDN", SqlDbType.VarChar).Value = parPltIdn.Value;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxPltIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {

                BNKDAT.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BNKDAT"]).ToString("dd.MM.yyyy");
                BNKNUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["BNKNUM"]);
                BNKSUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["BNKSUM"]);

                BNKKODBNK.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BNKKOD"]);
                OTPBIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["OTPBIN"]);
                OTPBIK.Text = Convert.ToString(ds.Tables[0].Rows[0]["OTPBIK"]);
                OTPIIK.Text = Convert.ToString(ds.Tables[0].Rows[0]["OTPIIK"]);
                OTPKBE.Text = Convert.ToString(ds.Tables[0].Rows[0]["OTPKBE"]);
                OTPBNK.Text = Convert.ToString(ds.Tables[0].Rows[0]["OTPBNK"]);

                BNKDEBSPRVAL.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BNKDEBSPRVAL"]);
                POLBIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["POLBIN"]);
                POLBIK.Text = Convert.ToString(ds.Tables[0].Rows[0]["POLBIK"]);
                POLIIK.Text = Convert.ToString(ds.Tables[0].Rows[0]["POLIIK"]);
                POLKBE.Text = Convert.ToString(ds.Tables[0].Rows[0]["POLKBE"]);
                POLBNK.Text = Convert.ToString(ds.Tables[0].Rows[0]["POLBNK"]);

                BNKPOS.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BNKPOS"]);
                //     BNKPOSBIK.Text = Convert.ToString(ds.Tables[0].Rows[0]["BNKPOSBIK"]);

                BNKMEM.Text = Convert.ToString(ds.Tables[0].Rows[0]["BNKMEM"]);
                BNKEKN.Text = Convert.ToString(ds.Tables[0].Rows[0]["BNKEKN"]);

            }
        }

        // ============================ чтение заголовка таблицы а оп ==============================================

        void RebindGrid(object sender, EventArgs e)
        {
            //                        getGrid();
        }
        // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void AddButton_Click(object sender, EventArgs e)
        {
            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;

            if (BNKNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKKODBNK.SelectedText == "")
            {
                Err.Text = "Не указан отправитель";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKDEBSPRVAL.SelectedText == "")
            {
                Err.Text = "Не указан получатель";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKSUM.Text.Length == 0)
            {
                Err.Text = "Не указан сумма";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKMEM.Text.Length == 0)
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
            SqlCommand cmd = new SqlCommand("BuxPltOneWrt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BNKIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@BNKFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BNKBUX", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BNKNUM", SqlDbType.VarChar).Value = BNKNUM.Text;
            cmd.Parameters.Add("@BNKDAT", SqlDbType.VarChar).Value = BNKDAT.Text;
            cmd.Parameters.Add("@BNKSUM", SqlDbType.VarChar).Value = BNKSUM.Text;

            cmd.Parameters.Add("@BNKKOD", SqlDbType.Int, 4).Value = BNKKODBNK.SelectedValue;

            cmd.Parameters.Add("@BNKDEBSPRVAL", SqlDbType.Int, 4).Value = BNKDEBSPRVAL.SelectedValue;

            cmd.Parameters.Add("@BNKPOS", SqlDbType.Int, 4).Value = BNKPOS.SelectedValue;

            cmd.Parameters.Add("@BNKMEM", SqlDbType.VarChar).Value = BNKMEM.Text;
            cmd.Parameters.Add("@BNKEKN", SqlDbType.VarChar).Value = BNKEKN.Text;

            cmd.ExecuteNonQuery();
            con.Close();

            ExecOnLoad("ExitFun();");
        }

        // ============================ отказ записи документа в базу ==============================================

        //----------------  ПЕЧАТЬ  --------------------------------------------------------
        protected void PrtButton_Click(object sender, EventArgs e)
        {
          ConfirmOK.Visible = false;
          ConfirmOK.VisibleOnLoad = false;

            if (BNKNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKKODBNK.SelectedText == "")
            {
                Err.Text = "Не указан отправитель";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKDEBSPRVAL.SelectedText == "")
            {
                Err.Text = "Не указан получатель";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKSUM.Text.Length == 0)
            {
                Err.Text = "Не указан сумма";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BNKMEM.Text.Length == 0)
            {
                Err.Text = "Не указан основание";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

    //        ConfirmDialog.Visible = true;
   //         ConfirmDialog.VisibleOnLoad = true;

            ExecOnLoad("PrtPltOne();");

            //                      System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "Alert('PrtPrxOrd();')", true);
            //        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Alert('PrtPrxOrd();')", true);
        }

        // ============================ одобрение для записи документа в базу ==============================================
        protected void btnPrtOK_click(object sender, EventArgs e)
        {
            /*
            GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxPltOrdWrt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BNKIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@BNKFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BNKBUX", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BNKOPR", SqlDbType.VarChar).Value = "-";
            cmd.Parameters.Add("@BNKNUM", SqlDbType.VarChar).Value = BNKNUM.Text;
            cmd.Parameters.Add("@BNKDAT", SqlDbType.VarChar).Value = BNKDAT.Text;

            cmd.Parameters.Add("@BNKDEB", SqlDbType.VarChar).Value = BNKDEB.SelectedValue;
            cmd.Parameters.Add("@BNKDEBSPR", SqlDbType.VarChar).Value = parPltSpr.Value;
            cmd.Parameters.Add("@BNKDEBSPRVAL", SqlDbType.VarChar).Value = BNKIIN.Text;

            cmd.Parameters.Add("@BNKKRD", SqlDbType.VarChar).Value = BNKKRD.SelectedValue;
            cmd.Parameters.Add("@BNKKRDSPR", SqlDbType.VarChar).Value ="2";
            cmd.Parameters.Add("@BNKKRDSPRVAL", SqlDbType.VarChar).Value = "1";

            cmd.Parameters.Add("@BNKFIO", SqlDbType.VarChar).Value = BNKFIO.Text;
            cmd.Parameters.Add("@BNKVAL", SqlDbType.VarChar).Value = "0";
            cmd.Parameters.Add("@BNKSUM", SqlDbType.VarChar).Value = BNKSUM.Text;
            cmd.Parameters.Add("@BNKSYM", SqlDbType.VarChar).Value = BNKSYM.SelectedValue;
            cmd.Parameters.Add("@BNKMEM", SqlDbType.VarChar).Value = BNKMEM.Text;
            cmd.Parameters.Add("@BNKDOC", SqlDbType.VarChar).Value = BNKDOC.Text;


            cmd.ExecuteNonQuery();
            con.Close();

            //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
            ExecOnLoad("PrtRsxOrd();");

            ExecOnLoad("ExitFun();");

            //               Response.Redirect("~/BuxDoc/BuxBnk.aspx?NumSpr=Кас&TxtSpr=Касса");
            */
        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            ExecOnLoad("ExitFun();");
            //       Response.Redirect("~/BuxDoc/BuxBnk.aspx?NumSpr=Кас&TxtSpr=Касса");

        }

 </script>

<body>
    <form id="form1" runat="server"> 
          
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

    <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parPltIdn" runat="server" />
        <asp:HiddenField ID="parPltPrv" runat="server" />
        <asp:HiddenField ID="parPltSpr" runat="server" />
        <asp:HiddenField ID="parPltKod" runat="server" />
        <asp:HiddenField ID="parPltNam" runat="server" />
        <asp:HiddenField ID="parPltZen" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
    <%-- ============================  шапка экрана ============================================ --%>
    <asp:TextBox ID="Sapka0"
        Text="ПЛАТЕЖНОЕ ПОРУЧЕНИЕ"
        BackColor="#ff99cc"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0%; position: relative; width: 70%; text-align: center"
        runat="server"></asp:TextBox>

        <asp:TextBox runat="server" ID="BNKNUM" Width="100px" Height="20px" Font-Size="Medium" Font-Bold="true" />

        <asp:TextBox runat="server" ID="BNKDAT" Width="100px" Height="20px" Font-Size="Medium" Font-Bold="true" />
                    <obout:Calendar ID="cal1" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="BNKDAT"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
    <%-- ============================  подшапка  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>

        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 410px;">

            <table border="1" cellspacing="0" width="100%" style="">
                <%-- ============================  Отправитель ============================================ --%>
                <tr>
                    <td width="60%" class="PO_RowCap">
                        <%-- ============================  Отправитель денег  ============================================ --%>
                        <table width="100%">
                            <tr>
                                <td class="PO_RowCap" width="20%">Отправитель денег </td>
                                <td class="PO_RowCap" width="80%">
                                    <obout:ComboBox runat="server" ID="BNKKODBNK" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="sdsDeb" DataTextField="ORGNAM" DataValueField="BNKKOD">
                                        <ClientSideEvents OnSelectedIndexChanged="BNKKRDSPRVAL_SelectedIndexChanged" />
                                    </obout:ComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="PO_Rowsap" width="20%">БИН </td>
                                <td class="PO_RowCap" width="80%">
                                    <asp:TextBox ID="OTPBIN" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="PO_RowCap" width="20%">Банк-отправитель </td>
                                <td class="PO_RowCap" width="80%">
                                    <asp:TextBox ID="OTPBNK" runat="server" Height="25px" ReadOnly="True" TextMode="MultiLine" Width="100%" />
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td width="25%" class="PO_RowCap">
                        <%-- ============================  Отправитель денег ИИК  ============================================ --%>
                        <table width="100%">
                            <tr>
                                <td class="PO_RowCap" width="80%">ИИК
                                    <asp:TextBox ID="OTPIIK" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                                <td class="PO_RowCap" width="20%">КОд
                                    <asp:TextBox ID="OTPKBE" runat="server" CssClass="Textbox" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="PO_TBCap" colspan="2" width="30%">БИК
                                    <asp:TextBox ID="OTPBIK" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td width="15%" class="PO_RowCap">
                        <%-- ============================  Отправитель денег СУММА  ============================================ --%>
                        <table width="100%">
                            <tr>
                                <td width="100%" class="PO_RowCap">Сумма
                                    <asp:TextBox ID="BNKSUM" runat="server" Font-Size="Medium" Font-Bold="true" style="text-align:right" Height="25px" Width="100%" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <%-- ============================  Бенефициар  ============================================ --%>

                <tr>
                    <td width="60%" class="PO_RowCap">
                        <%-- ============================  Бенефициар  ============================================ --%>
                        <table width="100%">
                            <tr>
                                <td class="PO_RowCap" width="20%">Бенефициар </td>
                                <td class="PO_RowCap" width="80%">
                                    <obout:ComboBox runat="server" ID="BNKDEBSPRVAL" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="sdsKrd" DataTextField="ORGNAM" DataValueField="ORGKOD">
                                        <ClientSideEvents OnSelectedIndexChanged="BNKDEBSPRVAL_SelectedIndexChanged" />
                                    </obout:ComboBox>

                                </td>
                            </tr>
                            <tr>
                                <td class="PO_Rowsap" width="20%">БИН </td>
                                <td class="PO_RowCap" width="80%">
                                    <asp:TextBox ID="POLBIN" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="PO_RowCap" width="20%">Банк-бенефициара </td>
                                <td class="PO_RowCap" width="80%">
                                    <asp:TextBox ID="POLBNK" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="25%" class="PO_RowCap">
                        <%-- ============================  Бенефициар ИИК ============================================ --%>
                        <table width="100%">
                            <tr>
                                <td class="PO_RowCap" width="80%">ИИК
                                    <asp:TextBox ID="POLIIK" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                                <td class="PO_RowCap" width="20%">КБе
                                    <asp:TextBox ID="POLKBE" runat="server" CssClass="Textbox" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="PO_TBCap" colspan="2" width="30%">БИК
                                    <asp:TextBox ID="POLBIK" runat="server" Height="25px" ReadOnly="True" Width="100%" />
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td width="15%" class="PO_RowCap"></td>
</tr>
                    <%-- ============================  Банк-посредник  ============================================ --%>
                    <tr>
                        <td width="20%" class="PO_RowCap">
                            <%-- ============================  Банк-посредник  ============================================ --%>
                            <table width="100%">
                                <tr>
                                    <td class="PO_RowCap" width="20%">Банк-посредник </td>
                                    <td>
                                        <obout:ComboBox runat="server" ID="BNKPOS" Width="100%" Height="200"
                                            FolderStyle="/Styles/Combobox/Plain"
                                            DataSourceID="sdsKrd" DataTextField="ORGNAM" DataValueField="ORGKOD">
                                        </obout:ComboBox>

                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="PO_TBCap" colspan="2">БИК
                            <asp:TextBox ID="BNKPOSBIK" runat="server" CssClass="Textbox" Height="25px" ReadOnly="True" Width="30%" />
                        </td>
                    </tr>

                    <%-- ============================  Назначения платежа ============================================ --%>
                    <tr>
                        <td width="60%" class="PO_RowCap">
                            <%-- ============================  Назначения платежа  ============================================ --%>
                            <table width="100%">
                                <tr>
                                    <td class="PO_RowCap" width="100%">(Назн.платежа,наим.товара,работ,услуг № и дата договора)<br>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="PO_RowCap" width="100%" rowspan="2">
                                        <asp:TextBox ID="BNKMEM" runat="server" CssClass="Textbox" Height="90px" TextMode="MultiLine" Width="100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>

                        <td width="20%" class="PO_RowCap">
                            <%-- ============================  Назначения платежа  ============================================ --%>
                            <table width="100%">
                                <tr>
                                    <td class="PO_RowCap" style="height: 25px;">Код наз.плат.</td>
                                </tr>
                                <tr>
                                    <td class="PO_RowCap" style="height: 25px;">Код бюд. клас</td>
                                </tr>
                                <tr>
                                    <td class="PO_RowCap" style="height: 25px;">Дата валют.</td>
                                </tr>
                            </table>
                        </td>

                        <td width="20%" class="PO_RowCap">
                            <%-- ============================ Назначения платежа  ============================================ --%>
                            <table width="100%">
                                <tr>
                                    <td width="100%" class="PO_RowCap">
                                        <asp:TextBox ID="BNKEKN" runat="server" CssClass="textbox" Height="25" Font-Size="Medium" Font-Bold="true" Width="100%" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:TextBox ID="BNKBUD" runat="server" CssClass="textbox" Height="25" ReadOnly="True" Width="100%" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <asp:TextBox ID="BNKDATVAL" runat="server" CssClass="textbox" Height="25" ReadOnly="True" Width="100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%-- ============================  Назн.платежа,наим.товара,работ,услуг № и дата договора  ============================================ --%>
                </tr>
            </table>
        </asp:Panel>
<%-- ============================  нижний блок  ============================================ --%>
<%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                 <asp:Button ID="AddButton" runat="server" CommandName="Cancel" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать" onclick="PrtButton_Click"/>
                 <input type="button" value="Отмена" onclick="ExitFun()();" />
              </center>      
  </asp:Panel> 

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
<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage"%>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }

    </style>
 
<%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

        //    ------------------ смена логотипа ----------------------------------------------------------
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

        // Client-Side Events for Delete
        function OnBeforeDelete(sender, record) {

            if (myconfirm == 1) {
                return true;
            }
            else {
                document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                myConfirmBeforeDelete.Open();
                return false;
            }
        }

        function findIndex(record) {
            var index = -1;
            for (var i = 0; i < GridMat.Rows.length; i++) {
                if (GridMat.Rows[i].Cells[0].Value == record.DTLIDN) {
                    index = i;

                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridMat.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            //          alert("1");
            var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;
            //          alert("2");
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxPrxDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPrxDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function WindowClose() {
            //           alert("GridNazClose");
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }

         function OnButtonMat() {
       //     MatWindow.setTitle("Печать");
       //     MatWindow.setUrl("/BuxDoc/BuxDocPrxSrdOne.aspx");
                //     MatWindow.Open();
            // alert("rowIndex=" + rowIndex); //document.getElementById('photopath_text').value);

           // var AmbStfIdn = GridMat.Rows[rowIndex].Cells[0].Value;
           // var AmbStfKod = GridMat.Rows[rowIndex].Cells[1].Value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/BuxDoc/BuxDocPrxSrdOne.aspx",
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/BuxDoc/BuxDocPrxSrdOne.aspx",
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

        }
        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

        function HandlePopupResult(result) {
                alert("result of popup is: " + result);
            var hashes = result.split('&');
            alert("hashes=" + hashes[0] + "  " + hashes[1]);
            var rowIndex = document.getElementById('MainContent_parRowIndex').value;

            GridGrfDoc.Rows[rowIndex].Cells[2].Value = hashes[0];
        }


        // --------------------- РАСХОД МАТЕРИАЛОВ ПО ЭТОЙ УСЛУГЕ
        function GridUsl_rsx(rowIndex) {
            alert("rowIndex=" + rowIndex); 
        }

    </script>


<script runat="server">

    int GlvDocIdn;
    string GlvDocPrv;

    int DtlIdn;

    string DtlDeb;
    int DtlDebSpr;
    int DtlDebSprVal;
    string DtlKrd;
    int DtlKrdSpr;
    int DtlKrdSprVal;

    int DtlKod;
    Boolean DtlNdc;
    int DtlGrp;
    int DtlGrpNal;
    int DtlUpk;

    decimal DtlKol;
    decimal DtlPrz;
    decimal DtlBxdIzn;
    string DtlEdn;
    string DtlNam;
    decimal DtlZen;
    decimal DtlSum;
    string DtlIzg;
    string DtlNumIzg;
    string DtlSrkSlb;
    string DtlDatIzg;


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


        GlvDocTyp = "Прс";
        //=====================================================================================
        GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
        GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
        //============= начало  ===========================================================================================
        if (GlvDocPrv != null && GlvDocPrv != "")
        {
            //               AddButton.Visible = false;
            //               PrvButton.Visible = false;
            //               GridMat.Columns[8].Visible = false;
        }
        //           if (GlvDocIdn == 0) PrvButton.Visible = false;

        // ViewState
        // ViewState["text"] = "Artem Shkolovy";
        // string Value = (string)ViewState["name"];
        GridMat.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridMat.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridMat.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridMat.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

        //           GlvDocIdn = 350;
        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EDNNAM FROM SPREDN ORDER BY EDNNAM";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsOrg.SelectCommand = "SELECT ORGKOD,ORGNAM FROM SPRORG WHERE ORGFRM='" + BuxFrm + "' ORDER BY ORGNAM";

        sdsAccOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAccOrg.SelectCommand = "SELECT ACCKOD,ACCKOD+'.  '+ACCNAM AS ACCTXT FROM TABACC " +
                                  "WHERE (ACCKOD LIKE '33%' OR ACCKOD LIKE '12%') AND ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD,ACCKOD+'.  '+ACCNAM AS ACCTXT FROM TABACC " +
                               " WHERE (ACCKOD LIKE '13%' OR ACCKOD LIKE '24%') AND ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

        sdsMol.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsMol.SelectCommand = "SELECT BUXKOD AS MOLKOD,FI AS MOLNAM FROM SprBuxKdr WHERE ISNULL(BuxMol,0)=1 AND BuxFrm=" + BuxFrm + " ORDER BY SprBuxKdr.FIO";

        sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT GrpMatKod,GrpMatNam FROM SPRGRPMAT ORDER BY GRPMATNAM";

        //     sdsNal.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //     sdsNal.SelectCommand = "SELECT NalKod,NalNam+'.'+NalNamGrp AS NamNal FROM SPRGRPNAL ORDER BY NALNAM";

        //============= Соединение ===========================================================================================
        sdsDtl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        //============= Источник для ГРИДа  ===========================================================================================
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        if (!Page.IsPostBack)
        {

            //============= Установки ===========================================================================================
            if (GlvDocIdn == 0)  // новый документ
            {
                Session.Add("CounterTxt", "0");

                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrxDocAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Прс";
                cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@GLVDOCIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    GlvDocIdn = Convert.ToInt32(cmd.Parameters["@GLVDOCIDN"].Value);
                    parDocIdn.Value = Convert.ToString(GlvDocIdn);

                }
                finally
                {
                    con.Close();
                }
                Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                Session.Add("GLVREJ", "ADD");

            }
            else
            {
                Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                Session.Add("GLVREJ", "ARP");

            }

            parDocIdn.Value = Convert.ToString(GlvDocIdn);
            getDocNum();

            //        ddlEdnNam.SelectedValue = "шт";
        }
        CreateGrid();


    }



    void CreateGrid()
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды

        SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPMAT.GRPMATNAM,TABMAT.MATNAM " +
                                        "FROM TABDOCDTL LEFT OUTER JOIN TABMAT ON TABDOCDTL.DTLKOD = TABMAT.MATKOD " +
                                                       "LEFT OUTER JOIN SPRGRPMAT ON TABDOCDTL.DTLGRP = SPRGRPMAT.GRPMATKOD " +
                                        "WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);
        //  SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPAMR.AMRNAMGRP AS NAMAMR,SPRGRPNAL.NALNAMGRP AS NAMNAL " +
        //                                  "FROM TABDOCDTL LEFT OUTER JOIN SPRGRPAMR ON TABDOCDTL.DTLGRP = SPRGRPAMR.AMRKOD " + 
        //                                                 "LEFT OUTER JOIN SPRGRPNAL ON TABDOCDTL.DTLGRPNAL = SPRGRPNAL.NALKOD WHERE DTLDOCIDN =" + GlvDocIdn + " ORDER BY DTLIDN", con);

        con.Open();
        SqlDataReader myReader = cmd.ExecuteReader();

        GridMat.DataSource = myReader;
        GridMat.DataBind();

        con.Close();
    }

    //============= ввод записи после опроса  ===========================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        DateTime dt;
        string Pol;
        bool parse;

        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        //       DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
        if (Convert.ToString(e.Record["DTLDEB"]) == null || Convert.ToString(e.Record["DTLDEB"]) == "") DtlDeb = "";
        else DtlDeb = Convert.ToString(e.Record["DTLDEB"]);

        if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "") DtlNam = "";
        else DtlNam = Convert.ToString(e.Record["DTLNAM"]);

        if (Convert.ToString(e.Record["DTLKOL"]) == null || Convert.ToString(e.Record["DTLKOL"]) == "") DtlKol = 0;
        else DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);

        DtlNdc = Convert.ToBoolean(e.Record["DTLNDC"]);

        DtlEdn = Convert.ToString(e.Record["DTLEDN"]);

        //       if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
        //       else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

        if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
        else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

        if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
        else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

        if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
        else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

        //         if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
        //         else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

        DtlSum = DtlKol * DtlZen;

        //         if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
        //         else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

        //          Pol = Convert.ToString(e.Record["DTLDATIZG"]);
        //          parse = DateTime.TryParse(Pol, out dt);//parse=false

        //          if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
        //          else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

        //         Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
        //         parse = DateTime.TryParse(Pol, out dt);//parse=false

        //         if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
        //         else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

        //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
        //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

        //        if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
        //        else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);



        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;

        cmd.Parameters.Add("@DTLDEB", SqlDbType.VarChar).Value = DtlDeb;
        cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 6;
        cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

        cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
        cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
        cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
        cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
        cmd.Parameters.Add("@DTLPRZ", SqlDbType.Decimal).Value = DtlPrz;
        cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = 0;  // DtlUpk;
        cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
        cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
        cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = "";  // DtlSrkSlb;

        cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = 0;  // DtlBxdIzn;
        cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = "";  // DtlDatIzg;
        cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = "";   // DtlIzg;
        cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = 0;  // DtlGrpNal;
        cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = "";   // DtlNumIzg;

        con.Open();
        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
        }
        finally
        {
            con.Close();
        }


        //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);

        CreateGrid();
    }


    //============= изменение записи после опроса  ===========================================================================================

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        DateTime dt;
        string Pol;
        bool parse;

        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
        if (Convert.ToString(e.Record["DTLDEB"]) == null || Convert.ToString(e.Record["DTLDEB"]) == "") DtlDeb = "";
        else DtlDeb = Convert.ToString(e.Record["DTLDEB"]);

        if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "") DtlNam = "";
        else DtlNam = Convert.ToString(e.Record["DTLNAM"]);

        if (Convert.ToString(e.Record["DTLKOL"]) == null || Convert.ToString(e.Record["DTLKOL"]) == "") DtlKol = 0;
        else DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);

        DtlNdc = Convert.ToBoolean(e.Record["DTLNDC"]);

        DtlEdn = Convert.ToString(e.Record["DTLEDN"]);

        //          if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
        //          else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

        if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
        else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

        if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
        else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

        if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
        else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

        //          if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
        //          else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

        DtlSum = DtlKol * DtlZen;

        //          if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
        //          else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

        //          if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
        //          else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

        //          Pol = Convert.ToString(e.Record["DTLDATIZG"]);
        //          parse = DateTime.TryParse(Pol, out dt);//parse=false

        //          if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
        //          else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

        //          Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
        //          parse = DateTime.TryParse(Pol, out dt);//parse=false

        //          if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
        //          else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

        //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
        //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

        //          if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
        //          else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);


        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;

        cmd.Parameters.Add("@DTLDEB", SqlDbType.VarChar).Value = DtlDeb;
        cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 6;
        cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
        cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
        cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
        cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
        cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
        cmd.Parameters.Add("@DTLPRZ", SqlDbType.Int, 4).Value = DtlPrz;
        cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = 0;  // DtlUpk;
        cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
        cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
        cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = "";  //DtlSrkSlb;

        cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = 0;   // DtlBxdIzn;
        cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = "";  // DtlDatIzg;
        cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = "";  // DtlIzg;
        cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = 0;  // DtlGrpNal;
        cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = 0; // DtlNumIzg;

        con.Open();

        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
        }
        finally
        {
            con.Close();
        }

        //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);

        CreateGrid();
    }


    // ============================ чтение заголовка таблицы а оп ==============================================

    void RebindGrid(object sender, EventArgs e)
    {
        CreateGrid();
    }
    //============= удаление записи после опроса  ===========================================================================================
    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);

        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        con.Open();
        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
        }
        finally
        {
            con.Close();
        }


        //            localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //            ws.AptPrxDtlDel(MdbNam, BuxSid, DtlIdn);

        CreateGrid();
    }
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды

        SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOC WHERE DOCIDN=" + GlvDocIdn, con);

        con.Open();
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "GetDocNum");

        //       SqlDataReader myReader = cmd.ExecuteReader();
        //       GridMat.DataSource = myReader;
        //       GridMat.DataBind();

        con.Close();

        //                        localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //                        DataSet ds = new DataSet("ComDocGetBux");

        //                        ds.Merge(ws.ComDocGetBux(MdbNam, BuxSid));
        TxtDocDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
        TxtDocNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);

        if (GlvDocIdn > 0)
        {
            BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRDSPRVAL"]);
            BoxAcc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRD"]);
            BoxMol.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
            TxtFkt.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUMFKT"]);
            TxtFktDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDATFKT"]);
        }


    }
    // ============================ запись заголовка таблицы а оп ==============================================
    //                  void setDocNum()
    //                  {
    //                      localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //                      DataSet ds = new DataSet("ComDocSetBux");
    //         //             ws.ComDocSetBux(MdbNam, BuxSid, DOCNUM.Text, DOCDAT.Text, BuxKod);
    //                  }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        string KodErr = "";
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        if (TxtDocNum.Text.Length == 0)
        {
            Err.Text = "Не указан номер документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtDocDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxAcc.SelectedValue == "" || BoxAcc.SelectedValue == "0")
        {
            Err.Text = "Не указан кредитовый счет";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxMol.SelectedValue == "" || BoxMol.SelectedValue == "0")
        {
            Err.Text = "Не указан МОЛ";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxOrg.SelectedValue == "" || BoxOrg.SelectedValue == "0")
        {
            Err.Text = "Не указан поставщик";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlChk", con);
        cmd = new SqlCommand("BuxPrxDocDtlChk", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxPrxDocDtlChk");

        //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //           DataSet ds = new DataSet("AptPrxDocChk");
        //           ds.Merge(ws.AptPrxDocChk(MdbNam, BuxSid, BuxKod));

        KodErr = Convert.ToString(ds.Tables[0].Rows[0]["KODERR"]);
        Err.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAMERR"]);

        if (KodErr == "ERR")
        {
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
        }
        else
        {
            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;
        }

    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnOK_click(object sender, EventArgs e)
    {
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
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = TxtDocNum.Text;
        cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
        cmd.Parameters.Add("@DOCDEB", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@DOCDEBSPR", SqlDbType.VarChar).Value = "6";                // BoxOrg.SelectedValue;
        cmd.Parameters.Add("@DOCDEBSPRVAL", SqlDbType.VarChar).Value = BoxMol.SelectedValue;
        cmd.Parameters.Add("@DOCKRD", SqlDbType.VarChar).Value = BoxAcc.SelectedValue;
        cmd.Parameters.Add("@DOCKRDSPR", SqlDbType.VarChar).Value = "2";
        cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = BoxOrg.SelectedValue;
        cmd.Parameters.Add("@DOCNUMFKT", SqlDbType.VarChar).Value = TxtFkt.Text;
        cmd.Parameters.Add("@DOCDATFKT", SqlDbType.VarChar).Value = TxtFktDat.Text;
        cmd.Parameters.Add("@DOCMEM", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

        // ------------------------------------------------------------------------------заполняем первый уровень
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прс&TxtSpr=Приходная накладная");
    }

    // ============================ отказ записи документа в базу ==============================================
    protected void CanButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прс&TxtSpr=Приходная накладная");
    }
    // ============================ проводить записи документа в базу ==============================================
    //------------------------------------------------------------------------
    protected void PrtButton_Click(object sender, EventArgs e)
    {
        //       AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
        // --------------  печать ----------------------------
        //       Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbLab003&TekDocIdn=" + AmbUslIdn);
    }

    // ---------Суммация  ------------------------------------------------------------------------
    public void SumDoc(object sender, GridRowEventArgs e)
    {

        if (e.Row.RowType == GridRowType.DataRow)
        {
            if (e.Row.Cells[9].Text == null | e.Row.Cells[9].Text == "") ItgDocSum += 0;
            else ItgDocSum += decimal.Parse(e.Row.Cells[9].Text);
        }
        else if (e.Row.RowType == GridRowType.ColumnFooter)
        {
            e.Row.Cells[2].Text = "Итого:";
            e.Row.Cells[9].Text = ItgDocSum.ToString();
        }

    }

    protected void Import_Click_OLD(object sender, EventArgs e)
    {
        int[,] MasLek = new Int32[5000, 2];
        int LekKol;

        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        //            string StrBeg = "=";
        //            string StrEnd  =  "";

        string ExcelContentType = "application/vnd.ms-excel";
        string Excel2010ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

        // --------------------------------------------------------------------------------------
        if (FileUpload1.HasFile)
        {
            //Check the Content Type of the file
            if (FileUpload1.PostedFile.ContentType == ExcelContentType || FileUpload1.PostedFile.ContentType == Excel2010ContentType)
            {
                try
                {
                    //Save file path
                    //                                    string path = string.Concat(Server.MapPath("~/Temp/"), FileUpload1.FileName);
                    string path = string.Concat(Server.MapPath(""), FileUpload1.FileName);
                    //Save File as Temp then you can delete it if you want
                    FileUpload1.SaveAs(path);
                    DataSet DtSet;
                    DtSet = new DataSet();

                    //  ========================================================================================================================
                    string LstIdn = "";
                    int i = 1;
                    int n = 0;
                    foreach (DataRow row in DtSet.Tables[0].Rows)
                    {
                        i = 1;
                        for (int j = 0; j < DtSet.Tables[0].Columns.Count; j++)  // количество колонок в GRID
                        {
                            if (row[j].ToString() == Convert.ToString(i))
                            {
                                MasLek[i, 0] = j;
                                MasLek[i, 1] = i;
                                i = i + 1;
                            }
                        }

                        if (i > 8) break;
                    }

                    n = 0;
                }

                catch (Exception ex)
                {
                    Err.Text = ex.Message;
                    ConfirmOK.Visible = true;
                    ConfirmOK.VisibleOnLoad = true;
                }
            }

        }
    }
    // ============================ проверка и очистка таблицы документа в базе ==============================================
    protected void ClrButton_Click(object sender, EventArgs e)
    {
        CreateGrid();
    }

    // ============================ конец текста ==============================================

    protected void Import_Click(object sender, EventArgs e)
    {
        string conStr = "";
        String[] PagNam;

        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

        string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

        FileUpload1.SaveAs(FilePath);

        PagNam = GetExcelSheetNames(FilePath);

        //declare variables - edit these based on your particular situation 
        string ssqltable = "TAB_EXCEL";
        // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have    different 
        //  string myexceldataquery = "SELECT '" + BuxKod + "',* FROM [" + ddlSheets.SelectedItem.Text + "]";
        string myexceldataquery = "SELECT '" + BuxKod + "',* FROM [" + PagNam[0] +"]";
        try
        {
            //create our connection strings 
            //                string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=yes;\""; 
            string sexcelconnectionstring = @"provider=Microsoft.ACE.OLEDB.12.0;data source=" + FilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";

            //      string ssqlconnectionstring = "Data Source=SAYYED;Initial Catalog=SyncDB;Integrated Security=True"; 
            string ssqlconnectionstring = ConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

            //              ----------------------------------------------------------  очистить таблицу -----------------------
            //execute a query to erase any previous data from our destination table 
            string sclearsql = "DELETE FROM TAB_EXCEL WHERE BUX='" + BuxKod + "'";
            SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
            SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
            sqlconn.Open();
            sqlcmd.ExecuteNonQuery();
            //        sqlconn.Close();

            //              ----------------------------------------------------------  загрузить таблицу -----------------------
            //series of commands to bulk copy data from the excel file into our sql table 
            OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
            OleDbCommand oledbcmd = new OleDbCommand(myexceldataquery, oledbconn);
            oledbconn.Open();
            OleDbDataReader dr = oledbcmd.ExecuteReader();
            SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
            bulkcopy.DestinationTableName = ssqltable;
            while (dr.Read())
            {
                bulkcopy.WriteToServer(dr);
            }
            dr.Close();
            oledbconn.Close();
            /*
            //              ----------------------------------------------------------  слить в базу данных -----------------------
            //execute a query to erase any previous data from our destination table 
            // string sclearsql = "DELETE FROM TAB_RPN WHERE FRM='" + BuxFrm + "'";
            SqlConnection sqlconnMrg = new SqlConnection(ssqlconnectionstring);
            SqlCommand sqlcmdMrg = new SqlCommand("HspRpnImpExl", sqlconn);
            sqlcmdMrg.CommandType = CommandType.StoredProcedure;
            sqlcmdMrg.Parameters.Add("@KLTFRM", SqlDbType.Int, 4).Value = BuxFrm;

            sqlconnMrg.Open();
            sqlcmdMrg.ExecuteNonQuery();
            sqlconnMrg.Close();
            */

            sqlconn.Close();

            //        lblMessage.Text = "РПН ЗАГРУЖЕН В БАЗУ.";



            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(FilePath)) File.Delete(FilePath);

            Err.Text = "Таблица загружен";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
        }
        catch (Exception ex)
        {
            //handle exception 
            //      lblMessage.Text = ex.Message;
        }

    }

    // ============================ конец текста ==============================================

    protected void SelectSheed(object sender, EventArgs e)
    {
        string conStr = "";
        string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

        string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

        FileUpload1.SaveAs(FilePath);

        //Get the Sheets in Excel WorkBoo
        conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
        conStr = String.Format(conStr, FilePath, "yes");
        OleDbConnection connExcel = new OleDbConnection(conStr);
        OleDbCommand cmdExcel = new OleDbCommand();
        OleDbDataAdapter oda = new OleDbDataAdapter();
        cmdExcel.Connection = connExcel;
        connExcel.Open();

        //Bind the Sheets to DropDownList
        //    ddlSheets.Items.Clear();
        //    ddlSheets.Items.Add(new ListItem("Выберите лист...", ""));
        //    ddlSheets.DataSource = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        //    ddlSheets.DataTextField = "TABLE_NAME";
        //    ddlSheets.DataValueField = "TABLE_NAME";
        //    ddlSheets.DataBind();
        connExcel.Close();
    }

    /// <span class="code-SummaryComment"><summary></span>
    /// This mehtod retrieves the excel sheet names from 
    /// an excel workbook.
    /// <span class="code-SummaryComment"></summary></span>
    /// <span class="code-SummaryComment"><param name="excelFile">The excel file.</param></span>
    /// <span class="code-SummaryComment"><returns>String[]</returns></span>

    private String[] GetExcelSheetNames(string excelFile)
    {
        OleDbConnection objConn = null;
        System.Data.DataTable dt = null;

        try
        {
            // Connection String. Change the excel file to the file you
            // will search.
            //     String connString = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
            String connString = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
            // Create connection object by using the preceding connection string.
            objConn = new OleDbConnection(connString);
            // Open connection with the database.
            objConn.Open();
            // Get the data table containg the schema guid.
            dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

            if (dt == null)
            {
                return null;
            }

            String[] excelSheets = new String[dt.Rows.Count];
            int i = 0;

            // Add the sheet name to the string array.
            foreach (DataRow row in dt.Rows)
            {
                excelSheets[i] = row["TABLE_NAME"].ToString();
                i++;
                break;
            }

            // Loop through all of the sheets if you want too...
            //  for (int j = 0; j < excelSheets.Length; j++)
            //  {
            //      // Query each excel sheet.
            //  }

            return excelSheets;
        }
        catch (Exception ex)
        {
            return null;
        }
        finally
        {
            // Clean up.
            if (objConn != null)
            {
                objConn.Close();
                objConn.Dispose();
            }
            if (dt != null)
            {
                dt.Dispose();
            }
        }
    }


</script>

<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  <asp:HiddenField ID="parDocIdn" runat="server" />
  <asp:HiddenField ID="parRowIndex" runat="server" />

<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Приходные накладные" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 5%; position: relative; width: 90%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 60px;">

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="№ док.:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                    <asp:TextBox ID="TxtDocNum" Width="25%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;от&nbsp;&nbsp;"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtDocDat" Width="80px" />
                    <obout:Calendar ID="CalDoc" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtDocDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                </td>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label3" runat="server" align="center" Style="font-weight: bold;" Text="Поставщик:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <%-- ============================  выбор поставщика  ============================================ --%>
                    <obout:ComboBox runat="server"
                        AutoPostBack="false"
                        ID="BoxOrg"
                        Width="90%"
                        Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        EmptyText="Выберите поставщика ..."
                        DataSourceID="sdsOrg"
                        DataTextField="ORGNAM"
                        DataValueField="ORGKOD" />
                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label4" runat="server" align="center" Style="font-weight: bold;" Text="Счет:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                     <obout:ComboBox runat="server" ID="BoxAcc" Width="25%" Height="200" MenuWidth="600px" 
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsAccOrg" DataTextField="ACCTXT" DataValueField="ACCKOD">
                    </obout:ComboBox>

                    <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="МОЛ:"></asp:Label>
                     <obout:ComboBox runat="server" ID="BoxMol" Width="50%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsMol" DataTextField="MOLNAM" DataValueField="MOLKOD">
                    </obout:ComboBox>

                </td>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label6" runat="server" align="center" Style="font-weight: bold;" Text="Счет-фактура:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <asp:TextBox ID="TxtFkt" Width="50%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtFktDat" Width="60px" />
                    <obout:Calendar ID="CalFkt" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtFktDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />


                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->

        </table>


    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>

    <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">


        <obout:Grid runat="server"
            ID="GridMat"
            Serialize="true"
            AutoGenerateColumns="false"
            FolderStyle="~/Styles/Grid/style_5"
            ShowTotalNumberOfPages="false"
            FolderLocalization="~/Localization"
            AllowSorting="false"
            Language="ru"
            CallbackMode="true"
            AllowPaging="false"
            AllowPageSizeSelection="false"
            Width="100%"
            PageSize="-1"
             EnableTypeValidation="false"
            ShowColumnsFooter="true">
            <ScrollingSettings ScrollHeight="310" />
            <Columns>
                <obout:Column ID="Column00" DataField="DTLIDN" Visible="false" HeaderText="Идн" Width="0%" />
                <obout:Column ID="Column01" DataField="DTLDEB" HeaderText="СЧЕТ" Align="right" Width="5%">
                    <TemplateSettings EditTemplateId="TemplateEditAccNam" />
                </obout:Column>
         
                <obout:Column ID="Column02" DataField="DTLNAM" HeaderText="НАИМЕНОВАНИЕ" Width="38%" >
                    <TemplateSettings TemplateId="TemplateMat" EditTemplateId="TemplateEditMat" />
                </obout:Column>

                <obout:Column ID="Column03" DataField="DTLKOL" HeaderText="КОЛ-ВО" Align="right" Width="5%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column04" DataField="DTLEDN" HeaderText="ЕД.ИЗМ" Width="10%">
                    <TemplateSettings TemplateId="TemplateEdn" EditTemplateId="TemplateEditEdn" />
                </obout:Column>
                <obout:Column ID="Column07" DataField="DTLZEN" HeaderText="ЦЕНА" Align="right" Width="10%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column08" DataField="DTLNDC" HeaderText="НДС" Align="center" Width="5%">
                    <TemplateSettings TemplateId="TemplateNdc" EditTemplateId="TemplateEditNdc" />
                </obout:Column>
                <obout:Column ID="Column09" DataField="DTLSUM" HeaderText="СУММА" Align="right" ReadOnly="true" Width="5%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column10" DataField="DTLPRZ" HeaderText="НАДБАВКА" Width="5%" DataFormatString="{0:F2}" Align="right" />
                <obout:Column ID="Column11" DataField="DTLGRP" HeaderText="ГРУППА" Width="12%">
                    <TemplateSettings TemplateId="TemplateGrp" EditTemplateId="TemplateEditGrp" />
                </obout:Column>
                
                <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="5%" AllowEdit="true" AllowDelete="true" runat="server">
                      <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                </obout:Column>
                
            </Columns>

            <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
            <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridMat.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridMat.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridMat.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridMat.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridMat.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохр" class="tdTextSmall" onclick="GridMat.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridMat.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEdn">
                    <Template>
                        <%# Container.DataItem["DTLEDN"]%>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditEdn" ControlID="ddlEdn" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlEdn" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNNAM">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateGrp">
                    <Template>
                        <%# Container.DataItem["GRPMATNAM"]%>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditGrp" ControlID="ddlGrp" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlGrp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGrp" CssClass="ob_gEC" DataTextField="GRPMATNAM" DataValueField="GRPMATKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditAccNam" ControlID="ddlAccNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlAccNam" runat="server" Width="99%" DataSourceID="sdsAcc" CssClass="ob_gEC" DataTextField="ACCTXT" DataValueField="ACCKOD">
                            <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateNdc" UseQuotes="true">
                    <Template>
                        <%# (Container.Value == "True" ? "+" : " ") %>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditNdc" ControlID="chkNdc" ControlPropertyName="checked" UseQuotes="false">
                    <Template>
                        <input type="checkbox" id="chkNdc" />
                    </Template>
                </obout:GridTemplate>
 
                <obout:GridTemplate runat="server" ID="TemplateSpr" UseQuotes="true">
                    <Template>
                        <input type="button" id="btnPrt2"/>
                    </Template>
                </obout:GridTemplate>               
                <obout:GridTemplate runat="server" ID="TemplateEditSpr" ControlID="btnPrt" ControlPropertyName="value">
                        <Template>
                            <input type="button" id="btnPrt" value="..." onclick="OnButtonMat(<%# Container.UniqueID %>)"/>
                       </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateMat">
                    <Template>
                        <%# Container.DataItem["MATNAM"]%>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditMat" ControlID="ddlMat" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlMat" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsMat" CssClass="ob_gEC" DataTextField="MATNAM" DataValueField="MATKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

            </Templates>


        </obout:Grid>
    </asp:Panel>

    <%-- ============================  нижний блок  ============================================ 
                    <asp:DropDownList ID="ddlSheets" runat="server" AppendDataBoundItems = "true"/>
     --%>

    <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>
                 <input type="button" name="PrtButton" value="Справочник" id="SprButton" onclick="OnButtonMat();">
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="ClrButton" runat="server" CommandName="Clr" Text="Очистить" onclick="ClrButton_Click"/>
                 <asp:FileUpload ID="FileUpload1" runat="server" />
                 <asp:Button ID="ButtonUpl" runat="server" onclick="Import_Click" Text="Загрузить" />
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
    </asp:Panel> 
  
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <owd:Window ID="MatWindow" runat="server" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
            Left="20" Top="10" Height="400" Width="950" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Материалы">
          </owd:Window>

              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="150" StyleFolder="/Styles/Window/wdstyles/default" Title="ЗАПИСЬ" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
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
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
    
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="130" StyleFolder="/Styles/Window/wdstyles/default" Title="ОШИБКА" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" TextMode="MultiLine" Height="20" runat="server" 
                                ForeColor="Red" BorderStyle="None" BackColor="#cccccc" Font-Bold="true" Font-Size="Larger" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" style="width:60%; font-size:medium" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

        <%-- =================  окно для поиска клиента из базы  ============================================ 
                   <ClientSideEvents OnClientSelect="OnClientSelect" />
          
             OnTextChanged="FndBtn_Click"
            --%>

 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
 <%-- =================  источник  для ГРИДА============================================ 
	<asp:SqlDataSource ID="sdsDtl" runat="server">
         <UpdateParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
         </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
--%>    
<%-- =================  источник  для КАДРЫ ============================================ --%>
    	    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMol" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsAccOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
	        <asp:SqlDataSource ID="sdsDtl" runat="server"></asp:SqlDataSource>
		    
<%-- =================  прочие ============================================ --%>
    
       
</asp:Content>

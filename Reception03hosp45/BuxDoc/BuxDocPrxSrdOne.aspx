<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->

    <script type="text/javascript">
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

        // ==================================== при выборе клиента показывает его программу  ============================================
        function OnButtonMat() {
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/BuxDoc/BuxDocPrxSrdOneMat.aspx",
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/BuxDoc/BuxDocPrxSrdOneMat.aspx",
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

       }

        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

        function HandlePopupResult(result) {
 //           alert("result of popup is: " + result);
            var hashes = result.split('&');
     //       alert("hashes=" + hashes[0] + "  " + hashes[1]);
     //       var rowIndex = document.getElementById('MainContent_parRowIndex').value;
    //        alert("BoxMat.SelectedValue=" + BoxMat.options[BoxMat.selectedIndex()].value);
     //       alert("BoxMat.Text=" + BoxMat.options[BoxMat.selectedIndex()].text);
     //       BoxMat.options[BoxMat.selectedIndex()].value = hashes[0];
     //       BoxMat.options[BoxMat.selectedIndex()].text = hashes[1];
      //      alert("BoxMat.SelectedValue2=" + BoxMat.options[BoxMat.selectedIndex()].value);
      //      alert("BoxMat.Text2=" + BoxMat.options[BoxMat.selectedIndex()].text);
     //       document.getElementById('BoxMat_BoxMat').value = "109";
    //        alert("element.text=" + element.text);

            var element = document.getElementById('BoxMat_ob_CboBoxMatTB');
            element.value = hashes[1];
   //         alert("element.valueN=" + element.value);
            element = document.getElementById('BoxEdn_ob_CboBoxEdnTB');
            element.value = hashes[2];
    //        alert("element.valueE=" + element.value);

            element = document.getElementById('TxtZen');
            element.value = hashes[3];
       //     alert("element.valueZ=" + element.value);

            element = document.getElementById('TxtUpk');
            element.value = hashes[4];
       //     alert("element.valueU=" + element.value);
           element = document.getElementById('TxtPrz');
            element.value = hashes[5];
        //    alert("element.valueZ=" + element.value);
           element = document.getElementById('BoxGrp_ob_CboBoxGrpTB');
           element.value = hashes[6];
        //    alert("element.valueG=" + element.value);

          //  alert("BoxMat.Text=" + BoxMat.Text);

      //      GridGrfDoc.Rows[rowIndex].Cells[2].Value = hashes[0];
     //       GrfDocVal = BoxDocNoz.options[BoxDocNoz.selectedIndex()].value;

     //       BoxMat.SelectedValue = hashes[0];
     //       BoxMat.Text = hashes[1];
        }

        function ExitFun() {
          //  var KltFio = document.getElementById('SelFio').value;
            //   alert(KltFio);
            //window.parent.KofClick();
            window.parent.MatWindowClose();
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }


        function BoxMat_SelectedIndexChanged(sender, selectedIndex) {
        //    var currentLogs = '\r\n' + OboutTextBox1.value();
        //    OboutTextBox1.value('SelectedIndexChanged was raised - new selected index: ' + selectedIndex + currentLogs);

            var SndPar = BoxMat.options[selectedIndex].value;
   //         alert("loadStx 3 =" + SndPar);


            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/GetSprMat',
                contentType: "application/json; charset=utf-8",
                data: '{"SndPar":"' + SndPar + '"}',
                dataType: "json",
                success: function (msg) {
                    var hashes = msg.d.split('&');
                    //        alert("msg=" + msg);
                    //        alert("msg.d=" + msg.d);

                    //        var element = document.getElementById('BoxMat_ob_CboBoxMatTB');
                    //        element.value = hashes[1];
                            //         alert("element.valueN=" + element.value);
                            var element = document.getElementById('BoxEdn_ob_CboBoxEdnTB');
                            element.value = hashes[2];
                            //        alert("element.valueE=" + element.value);

                            element = document.getElementById('TxtZen');
                            element.value = hashes[3];
                            //     alert("element.valueZ=" + element.value);

                            element = document.getElementById('TxtUpk');
                            element.value = hashes[4];
                            //     alert("element.valueU=" + element.value);
                            element = document.getElementById('TxtPrz');
                            element.value = hashes[5];
                            //    alert("element.valueZ=" + element.value);
                            element = document.getElementById('BoxGrp_ob_CboBoxGrpTB');
                            element.value = hashes[6];
                },
                error: function () { }
            });

        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string GlvDocIdn;
    string TabDtlIdn;
    string TabDtlIdnTek;
    string AmbDtlTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;
    /*
        int MatIdn;
        string MatNam;
        string MatEdn;
        decimal MatZen;
        int MatUpk;
        int MatPrz;
        int MatGrp;
    */
    int DtlIdn;

    string DtlDeb;
    int DtlDebSpr;
    int DtlDebSprVal;
    string DtlKrd;
    int DtlKrdSpr;
    int DtlKrdSprVal;

    int DtlKod;
    string DtlMat;
    Boolean DtlNdc;
    string DtlGrp;
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


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
        TabDtlIdn = Convert.ToString(Request.QueryString["TabDtlIdn"]);
        if (TabDtlIdn == "0") AmbDtlTyp = "ADD";
        else AmbDtlTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        GlvDocIdn = (string)Session["GlvDocIdn"];
        Session.Add("TabDtlIdn ", TabDtlIdn);

        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EDNNAM,EDNNAM AS EDNKOD FROM SPREDN ORDER BY EDNNAM";

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT GRPMATKOD,GRPMATNAM FROM SPRGRPMAT ORDER BY GRPMATNAM";

        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

        sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

        if (!Page.IsPostBack)
        {
            //============= Установки ===========================================================================================
            TabDtlIdnTek = (string)Session["TabDtlIdn"];
            if (TabDtlIdnTek != "Post")
            {

                if (TabDtlIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("BuxPrxDocDtlAddEmp", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@DTLOPR", SqlDbType.VarChar).Value = "+";
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                    cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@DTLIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        TabDtlIdn = Convert.ToString(cmd.Parameters["@DTLIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }

                }
            }

            Session["TabDtlIdn"] = Convert.ToString(TabDtlIdn);
            parDtlIdn.Value = TabDtlIdn;

            getDocNum();
         //            GetGrid();
        }

        /*
                 if (GridMat.SelectedRecords != null)
                {
                    string sText="";
                    foreach (Hashtable oRecord in GridMat.SelectedRecords)
                    {
                        sText += oRecord["MATIDN"];
                    }

                    TxtSum.Text = sText;
                }
                */
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOCDTL WHERE DTLIDN=" + parDtlIdn.Value, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "DtlOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRDtlNAM"]);
            BoxAcc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLDEB"]);
            //    BoxMat.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLNAM"]);
            BoxEdn.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLEDN"]);
            BoxGrp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLGRP"]);
            BoxMat.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLKOD"]);

            //            TxtMat.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLNAM"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLSUM"]);
            TxtKol.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLKOL"]);
            TxtUpk.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLUPK"]);
            TxtPrz.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLPRZ"]);
            TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLZEN"]);
            TxtSumNdc.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLSUMNDC"]);

            //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DTLSRKSLB"].ToString())) TxtDat.Text = "";
            //      else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DTLSRKSLB"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DTLNDC"].ToString())) ChkNdc.Checked = false;
            else ChkNdc.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DTLNDC"]);

        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            //         BoxDtl.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        DateTime dt;
        string Pol;
        bool parse;


        if (Convert.ToString(BoxAcc.SelectedValue) == null || Convert.ToString(BoxAcc.SelectedValue) == "") DtlDeb = "";
        else DtlDeb = Convert.ToString(BoxAcc.SelectedValue);

        if (Convert.ToString(BoxMat.SelectedValue) == null || Convert.ToString(BoxMat.SelectedValue) == "") DtlKod = 0;
        else DtlKod = Convert.ToInt32(BoxMat.SelectedValue);

        if (Convert.ToString(BoxMat.SelectedText) == null || Convert.ToString(BoxMat.SelectedText) == "") DtlMat = "";
        else DtlMat = Convert.ToString(BoxMat.SelectedText);

        if (Convert.ToString(TxtKol.Text) == null || Convert.ToString(TxtKol.Text) == "") DtlKol = 0;
        else DtlKol = Convert.ToDecimal(TxtKol.Text);

        if (Convert.ToString(ChkNdc.Text) == "Checked = true") DtlNdc = true;
        else DtlNdc = ChkNdc.Checked;

        if (Convert.ToString(BoxEdn.SelectedValue) == null || Convert.ToString(BoxEdn.SelectedValue) == "") DtlEdn = "";
        else DtlEdn = Convert.ToString(BoxEdn.SelectedValue);

        //          if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
        //          else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

        if (Convert.ToString(TxtZen.Text) == null || Convert.ToString(TxtZen.Text) == "") DtlZen = 0;
        else DtlZen = Convert.ToDecimal(TxtZen.Text);

        if (Convert.ToString(TxtPrz.Text) == null || Convert.ToString(TxtPrz.Text) == "") DtlPrz = 0;
        else DtlPrz = Convert.ToDecimal(TxtPrz.Text);

        if (Convert.ToString(TxtUpk.Text) == null || Convert.ToString(TxtUpk.Text) == "") DtlUpk = 0;
        else DtlUpk = Convert.ToInt32(TxtUpk.Text);

        if (Convert.ToString(BoxMat.SelectedText) == null || Convert.ToString(BoxMat.SelectedText) == "") DtlGrp = "";
        else DtlGrp = Convert.ToString(BoxGrp.SelectedText);

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
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Прс";
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;

        cmd.Parameters.Add("@DTLDEB", SqlDbType.VarChar).Value = DtlDeb;
        cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 6;
        cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = parDtlIdn.Value;
        cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = DtlKod;
        cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlMat;
        cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
        cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
        cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
        cmd.Parameters.Add("@DTLPRZ", SqlDbType.Int, 4).Value = DtlPrz;
        cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = DtlUpk;
        cmd.Parameters.Add("@DTLGRP", SqlDbType.VarChar).Value = DtlGrp;
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

        ExecOnLoad("ExitFun();");

        //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);

    }



    // ------------------------------------------------------------------------------заполняем второй уровень

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDtlIdn" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <asp:HiddenField ID="hidWhere" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 350px;">

        <asp:TextBox ID="Sapka" 
             Text="ВВОД МАТЕРИАЛА" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

            <hr />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label1" Text="СЧЕТ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="false"
                            ID="BoxAcc"
                            Width="20%"
                            Height="200"
                            EmptyText="Выберите счет ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsAcc"
                            DataTextField="AccKod"
                            DataValueField="AccKod" >
                        </obout:ComboBox>

                    </td>
                </tr>
 
                <tr>
                    <td style="width: 100%; height: 30px;">
                       <asp:Label ID="Label5" Text="НАИМЕНОВАНИЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="false"
                            ID="BoxMat"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите применение ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsMat"
                            DataTextField="MATNAM"
                            DataValueField="MATKOD" >
                            <ClientSideEvents  OnSelectedIndexChanged="BoxMat_SelectedIndexChanged" />
                        </obout:ComboBox>

                        <asp:Button ID="ButMat" runat="server"
                             OnClientClick="OnButtonMat()"
                             Width="10%" CommandName="" CommandArgument=""
                             Text="Материалы" Height="25px" Font-Bold="true"
                             Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>
 
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label9" Text="ЕД.ИЗМ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="false"
                            ID="BoxEdn"
                            Width="20%"
                            Height="200"
                            EmptyText="Выберите применение ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsEdn"
                            DataTextField="EDNNAM"
                            DataValueField="EDNKOD" >
                        </obout:ComboBox>
 
                    </td>
                </tr>
                               
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label10" Text="КОЛИЧЕСТВО:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtKol" Width="10%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="regexTxtKol" ControlToValidate="TxtKol" SetFocusOnError="True" 
                                   ValidationExpression="(?!^0*$)(?!^0*\.0*$)^\d{1,18}(\,\d{1,2})?$" ErrorMessage="Ошибка" runat="server" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label11" Text="ЦЕНА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtZen" Width="10%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label13" Text="В УПАКОВКЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtUpk" Width="10%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

               <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label8" Text="НДС:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkNdc" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtSumNdc" Width="20%" Height="20" runat="server" ReadOnly="true"  Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label12" Text="СУММА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtSum" Width="10%" Height="20" runat="server" ReadOnly="true" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
 
                 <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label2" Text="НАДБАВКА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtPrz" Width="10%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                               
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="ГРУППА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="false"
                            ID="BoxGrp"
                            Width="40%"
                            Height="100"
                            EmptyText="Выберите применение ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsGrp"
                            DataTextField="GRPMATNAM"
                            DataValueField="GRPMATKOD" >
                        </obout:ComboBox>
 
                    </td>
                </tr>
                               
            </table>

        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="Button1" runat="server" CommandName="Add" OnClick="AddButton_Click" Text="Записать"/>
                 <input type="button" name="PrtButton" value="Отмена" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel> 

       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
     <%-- =================  окно для поиска клиента из базы  ============================================ --%>
    </form>

    <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>




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
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            width: 100%;
            font-size: 12px !important;  // для увеличения коррект поля
            padding-top: 4px;
            padding-bottom: 4px;
        }


        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>



</body>

</html>



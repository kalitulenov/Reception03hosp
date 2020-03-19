<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        function GridUsl_Edit(sender, record) {
     //      alert("GridUsl_Edit=");

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }

        function loadStx(sender, index) {
  //          alert("loadStx 0 =" + index);
  //          alert("loadStx 1 =" + document.getElementById('parBuxFrm').value);
  //          alert("loadStx 2 =" + document.getElementById('parBuxKod').value);
            var SndPar = sender.value() + ':' + document.getElementById('parBuxFrm').value + ':' + document.getElementById('parCrdIdn').value;
 //           alert("loadStx 3 =" + SndPar);
            PageMethods.GetSprUsl(SndPar, onSprUslLoaded, onSprUslLoadedError);
/*
            var DatDocIdn;
            var QueryString = getQueryString();
            DatDocIdn = QueryString[1];
*/
            //                      alert("onChange=" + DatDocMdb + ' ' + DatDocTab + ' ' + DatDocKey + ' ' +DatDocIdn + ' ' + DatDocRek + ' ' + DatDocVal);

        }

        function onSprUslLoaded(SprUsl) {
       //     alert("onSprUslLoaded=" + SprUsl);

            SprUslComboBox.options.clear();

            for (var i = 0; i < SprUsl.length; i++) {
                SprUslComboBox.options.add(SprUsl[i]);
            }

            SprUslComboBox.value(document.getElementById('hiddenUslNam').value);
        }

        function onSprUslLoadedError() {
        }

        function updateSprUslSelection(sender, index) {
            document.getElementById('hiddenUslNam').value = sender.value();
        }

        // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
        function OK_click() {
 
        }

// -----------------------------------------------------------------------------------------------------------------------------
        function PrtPrxOrd() {

//            if (confirm("Хотите распечатать ?")) {

            var GlvDocIdn = document.getElementById('parKasIdn').value;
            if (GlvDocIdn == null || GlvDocIdn == "" || GlvDocIdn == "0") alert("Услуги не записны в кассу");
            else
            {
         //       alert("GlvDocIdn =" + GlvDocIdn);

                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            }

    //        self.close();
    //        window.parent.KasClose();
        }

        function GridUsl_add() {
     //       alert("GridUsl_add=" + document.getElementById("parCrdIdn").value);
        //    var BuxFrm = document.getElementById('parBuxFrm').value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/BuxKasPrxSprDoc.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value+"&AmbCrdFio=" + document.getElementById("parCrdFio").value,
                            "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/BuxKasPrxSprDoc.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&AmbCrdFio=" + document.getElementById("parCrdFio").value,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");

            //      return true;
        }

        // ------------------------  нажать на кнопку  ------------------------------------------------------------------
        function HandlePopupResult(result) {
            //         alert("result of popup is: " + result);
            //          alert("UslRef=");
            document.getElementById("ButtonRef").click();
        }

        function MrtLstButton_Click() {
            var AmbCrdIdn = document.getElementById("parCrdIdn").value;

    //        alert("AmbCrdIdn =" + AmbCrdIdn);

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspRefMrtLst&TekDocIdn=" + AmbCrdIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspRefMrtLst&TekDocIdn=" + AmbCrdIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        /*
        function onChange(sender, newText) {
            //           alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parCrdIdn').value;

            var SqlStr = "";
            switch (sender) {
                case 'TxtNum':
                    //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBCRD SET GRFNUM=" + DatDocVal + " WHERE GRFIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
         //                     alert("SqlStr=" + SqlStr);
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
*/

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int UslIdn;
    int UslAmb;
    int UslNap;
    string UslStx;
    int UslLgt;
    int UslZen;
    int UslKol;
    string UslNam;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================
        //============= начало  ===========================================================================================
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        //        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        parCrdIdn.Value = AmbCrdIdn;
        //=====================================================================================

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            //          TxtNum.Attributes.Add("onchange", "onChange('TxtNum',TxtNum.value);");
            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
            getDocNum();
            getGrid();
        }

    }

    // ============================ чтение таблицы а оп ==============================================
    void getDocNum()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxIdnDoc", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslStxIdnDoc");

        con.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
            TxtTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIMBEG"]);
            TxtDoc.Text = Convert.ToString(ds.Tables[0].Rows[0]["FI"]) + "  (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
            TxtPth.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TxtInv.Text = Convert.ToString(ds.Tables[0].Rows[0]["NUMINV"]);

            if (TxtInv.Text == null | TxtInv.Text == "") TxtInv.Text = "";
            else TxtInv.Text = "№ инв: " + TxtInv.Text;
        }

    }
    // ======================================================================================
    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslStxIdn");

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

    }

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["USLZEN"] == null | e.Record["USLZEN"] == "") UslZen = 0;
        else UslZen = Convert.ToInt32(e.Record["USLZEN"]);

        UslNap = 0;

        if (e.Record["USLSTX"] == null | e.Record["USLSTX"] == "") UslStx = "00000";
        else UslStx = Convert.ToString(e.Record["USLSTX"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 0;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = UslKol;
        cmd.Parameters.Add("@USLZEN", SqlDbType.Int, 4).Value = UslZen;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        if (e.Record["USLZEN"] == null | e.Record["USLZEN"] == "") UslZen = 0;
        else UslZen = Convert.ToInt32(e.Record["USLZEN"]);

        UslNap = 0;

        if (e.Record["USLSTX"] == null | e.Record["USLSTX"] == "") UslStx = "00000";
        else UslStx = Convert.ToString(e.Record["USLSTX"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 0;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = UslKol;
        cmd.Parameters.Add("@USLZEN", SqlDbType.Int, 4).Value = UslZen;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void RebindGrid(object sender, EventArgs e)
    {
        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
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

        getGrid();
    }

    //==================================================================================================================================================
    // ============================ проверка и опрос для записи документа в базу ==============================================
    // ============================ отказ записи документа в базу ==============================================


    //----------------  ЗАПИСАТЬ  --------------------------------------------------------
    protected void ZapChkButton_Click(object sender, EventArgs e)
    {
        ConfirmDialogZapChk.Visible = true;
        ConfirmDialogZapChk.VisibleOnLoad = true;
    }


    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnZapChkOK_click(object sender, EventArgs e)
    {
        string LstIdn = "";

        if (GridUsl.SelectedRecords != null)
        {
            foreach (Hashtable oRecord in GridUsl.SelectedRecords)
            {
                if (Convert.ToString(oRecord["USLSTX"]) == "00000") LstIdn = LstIdn + Convert.ToInt32(oRecord["USLIDN"]).ToString("D10") + ":"; // форматирование строки
            }

        }

        if (LstIdn.Length == 0)
        {
            ConfirmDialogZapChk.Visible = false;
            ConfirmDialogZapChk.VisibleOnLoad = false;

            return;
        }

        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUslStxKas", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@LSTIDN", SqlDbType.VarChar).Value = LstIdn;
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters["@KASIDN"].Direction = ParameterDirection.Output;

        cmd.ExecuteNonQuery();

        try
        {
            parKasIdn.Value = Convert.ToString(cmd.Parameters["@KASIDN"].Value);
        }
        finally
        {
            con.Close();
        }

        ConfirmDialogZapChk.Visible = false;
        ConfirmDialogZapChk.VisibleOnLoad = false;


        //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //       ExecOnLoad("PrtPrxOrd();");
    }

    //----------------  ПЕЧАТЬ  --------------------------------------------------------
    protected void ZapAllButton_Click(object sender, EventArgs e)
    {
        ConfirmDialogZapAll.Visible = true;
        ConfirmDialogZapAll.VisibleOnLoad = true;
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnZapAllOK_click(object sender, EventArgs e)
    {
        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUslStxKasAll", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@KASBUX", SqlDbType.Int, 4).Value = BuxKod;
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters["@KASIDN"].Direction = ParameterDirection.Output;

        cmd.ExecuteNonQuery();

        try
        {
            parKasIdn.Value = Convert.ToString(cmd.Parameters["@KASIDN"].Value);
        }
        finally
        {
            con.Close();
        }

        ConfirmDialogZapAll.Visible = false;
        ConfirmDialogZapAll.VisibleOnLoad = false;


        //        ExecOnLoad("PrtPrxOrd();");
    }

    //----------------  ПЕЧАТЬ  --------------------------------------------------------
    protected void PrtButton_Click(object sender, EventArgs e)
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT KASIDN FROM TABKAS WHERE KASAMB=" + AmbCrdIdn, con);
        // указать тип команды
        //     cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "DssKasIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            parKasIdn.Value =  Convert.ToString(ds.Tables[0].Rows[0]["KASIDN"]);
        }
        ExecOnLoad("PrtPrxOrd();");

    }


    // =================================================================================================================================================
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

            SqlCommand cmd = new SqlCommand("HspAmbUslStxSou", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = MasLst[2];
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = MasLst[1];
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = MasLst[0];
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
    // ==================================== поиск клиента по фильтрам  ============================================

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parCrdFio" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka"
            Text="ЗАПИСЬ УСЛУГИ К ВРАЧУ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

<%-- ============================  верхний блок  ============================================ 
                           <asp:Label ID="Label5" Text="№_КАРТЫ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtNum" Width="10%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
    --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 70px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                <!--  ----------------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="10%" style="vertical-align: top;">
                        <asp:Label ID="Label4" Text="ДАТА:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtDat" Width="10%" Height="20" BorderStyle="None" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:Label ID="Label1" Text="ВРЕМЯ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtTim" Width="20%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:TextBox ID="TxtInv" Width="20%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td width="10%" style="vertical-align: top;">
                        <asp:Label ID="Label2" Text="ВРАЧ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtDoc" Width="40%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td width="10%" style="vertical-align: top;">
                        <asp:Label ID="Label3" Text="ПАЦИЕНТ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtPth" Width="50%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 310px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
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
        OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="KASOPL" HeaderText="Касса" Width="7%" ReadOnly="true" />
                    <obout:Column ID="Column2" DataField="USLSTX" HeaderText="ВИД ОПЛ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateStxNam" EditTemplateId="TemplateEditStxNam" />
                    </obout:Column>
                    <obout:Column ID="Column3" DataField="USLNAM" HeaderText="Наименование услуги" Width="50%" Align="left" >
                        <TemplateSettings TemplateId="TemplateUslNam" EditTemplateId="TemplateEditUslNam" />
                    </obout:Column>
                    <obout:Column ID="Column4" DataField="USLLGT" HeaderText="Льгота" Width="5%" Align="right"/>
                    <obout:Column ID="Column5" DataField="USLKOL" HeaderText="Кол" Width="5%" Align="right"  />
                    <obout:Column ID="Column6" DataField="USLZEN" HeaderText="Цена" Width="7%" Align="right"  />
                    <obout:Column ID="Column7" DataField="USLSUM" HeaderText="Сумма" Width="6%" ReadOnly="true" Align="right"/>
                    
                    <obout:Column ID="Column8" HeaderText="Коррек  Удаление" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>								
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridUsl.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                           <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl_add()" />
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUsl.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
                   			
                    <obout:GridTemplate runat="server" ID="TemplateStxNam">
                        <Template>
                            <%# Container.DataItem["StxNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlStxNam" ID="TemplateEditStxNam" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlStxNam" Width="100%" Height="150"
                                DataSourceID="sdsStx" DataTextField="StxNam" DataValueField="StxKod">
                                <ClientSideEvents OnSelectedIndexChanged="loadStx" />
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
                           <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="300" >
                                <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%-- ============================  нижний блок  ============================================ BackColor="#F0E68C"
                  <asp:Button ID="Button6" runat="server" CommandName="Cancel" Text="Записать в кассу (отмечанные)" onclick="ZapChkButton_Click" />
   
    --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                 <asp:Button ID="ButtonRef" runat="server" CommandName="Cancel" Text="Обновить" OnClick="RebindGrid"  />
                 <asp:Button ID="Button5" runat="server" CommandName="Cancel" Text="Записать в кассу (все)" onclick="ZapAllButton_Click"/>
                 <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать прих.ордера" onclick="PrtButton_Click" />
                 <input type="button" name="ButpPrt002" value="Печать марш.лист" onclick="MrtLstButton_Click();" id="ButPrt002" />              

              </center>      
  </asp:Panel> 

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialogZapChk" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать отмечанные?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button1" Text="ОК" onclick="btnZapChkOK_click" />
                              <input type="button" value="Назад" onclick="ConfirmDialogZapChk.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialogZapAll" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать все?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button4" Text="ОК" onclick="btnZapAllOK_click" />
                              <input type="button" value="Назад" onclick="ConfirmDialogZapAll.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

    </form>

    <%-- ============================  STYLES ============================================ --%>

     <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="HspAmbUslKodSou" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="BUXFRMKOD" Name="BuxFrmKod" Type="String" />
                    <asp:SessionParameter SessionField="BUXKOD" Name="BuxKod" Type="String" />
                </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

<%--  ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
         /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
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
    </style>

</body>
</html>



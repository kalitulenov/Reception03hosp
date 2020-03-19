<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%-- ================================================================================ --%>

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

        // -------изменение как EXCEL-------------------------------------------------------------------          
        function markAsFocused(textbox) {
            //           alert("markAsFocused=");
            textbox.className = 'excel-textbox-focused';
        }

        /*------------------------- при нажатии на поле текст --------------------------------*/
        function markAsBlured(textbox, dataField, rowIndex) {
            //           alert("markAsBlured=");
            //           alert("textbox=" + textbox.value + " dataField=" + dataField + " rowIndex=" + rowIndex);
            var DatDocIdn;
            var DatDocRek = 'USLDTLVAL';
            var DatDocVal;
            var DatDocTyp = 'Txt';

            textbox.className = 'excel-textbox';

            GridXry.Rows[rowIndex].Cells[dataField].Value = textbox.value;

            //          DatDocRek = GridXry.Rows[rowIndex].Cells['XryUSLREK'].Value;
            DatDocIdn = GridXry.Rows[rowIndex].Cells['XryUSLIDN'].Value;
            DatDocVal = textbox.value;
            onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
            parDocIdn.value = GridXry.Rows[rowIndex].Cells['XryUSLIDN'].Value;
            //            alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

        }

//  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
 //           alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
//            var QueryString = getQueryString();
//            var DatDocIdn = QueryString[1];
            var DatDocIdn = document.getElementById('parUslIdn').value;

            var SqlStr = "";


            switch (sender) {
                case 'TxtNap':
 //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBUSL SET USLNAP=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtLgt':
                    if (DatDocVal == null || DatDocVal == "" || DatDocVal <= "0" || DatDocVal > "99") {
               //         alert("DatDocVal=" + DatDocVal + " " + TxtZen.value);
                        SqlStr = "UPDATE AMBUSL SET USLLGT=0,USLSUM=USLZEN WHERE USLIDN=" + DatDocIdn;
              //          alert("DatDocVal2=" + DatDocVal + " " + TxtZen.value);
                        TxtSum.value = TxtZen.value;
                    }
                    else
                        SqlStr = "UPDATE AMBUSL SET USLLGT=" + DatDocVal + ",USLSUM=(100-" + DatDocVal + ")*USLZEN/100 WHERE USLIDN=" + DatDocIdn;
                    TxtSum.value = Math.round(TxtSum.value * (100-TxtLgt.value)/100);
                    break;
                case 'TxtSum':
                    SqlStr = "UPDATE AMBUSL SET USLSUM=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'Dig003':
                    DatDocIdn = DigIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                case 'Ops003':
                    DatDocIdn = OpsIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                case 'Zak003':
                    DatDocIdn = ZakIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                case 'Rek003':
                    DatDocIdn = RekIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
//                  alert("SqlStr=" + SqlStr);

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


        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBUSLDTL';
            var DatDocKey = 'USLDTLIDN';

            SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
            //           alert("SqlStr=" + SqlStr);

            //          alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
            //           alert("SqlStr=" + SqlStr);

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

// ============================================================================================================
        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parUslIdn').value;

            switch (sender.ID) {
                case 'BoxNoz':
                    DatDocVal = BoxNoz.options[BoxNoz.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLNOZ=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'BoxKto':
                    DatDocVal = BoxKto.options[BoxKto.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLKTO=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'BoxLab':
                    DatDocVal = BoxLab.options[BoxLab.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLBINGDE='" + DatDocVal + "' WHERE USLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
            //                           alert("SqlStr=" + SqlStr);

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

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            var AmbUslIdn = document.getElementById('parUslIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbXry&TekDocIdn=" + AmbUslIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbXry&TekDocIdn=" + AmbUslIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function SablonOps() {
            //       alert('SablonJlb_1');
            //    ob_post.ResetParams();
            //     parSblNum.value = "Jlb";
            SablonWin("Ops");
        }
        function SablonZak() {
            SablonWin("Zak");
        }
        function SablonRek() {
            SablonWin("Rek");
        }

        function SablonWin(SblTyp) {
            //      alert('SblTyp=' + SblTyp);
       //     window.open("DocAppSbl.aspx?SblTyp=" + SblTyp + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=385,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
            window.open("DocAppSblFlg.aspx?SblTyp=" + SblTyp + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=1000,height=600,left=200,top=100,location=no,modal=yes,status=no,scrollbars=no,resize=no");
        }

        function HandlePopupResult(result) {
          //  alert("result of popup is: " + result);
            var MasPar = result.split('@');
            //   ========================================================================= ГОЛОС
            if (MasPar[0] == 'GrfOps') {
                document.getElementById('Ops003').value = document.getElementById('Ops003').value + MasPar[1] + '.';
                onChange('Ops003', document.getElementById('Ops003').value);
            }
            if (MasPar[0] == 'GrfZak') {
                document.getElementById('Zak003').value = document.getElementById('Zak003').value + MasPar[1] + '.';
                onChange('Zak003', document.getElementById('Zak003').value);
            }
            if (MasPar[0] == 'GrfRek') {
                document.getElementById('Rek003').value = document.getElementById('Rek003').value + MasPar[1] + '.';
                onChange('Rek003', document.getElementById('Rek003').value);
            }
            //   ========================================================================= ШАБЛОНЫ
            if (MasPar[0] == 'Ops002') {
                document.getElementById('Ops003').value = document.getElementById('Ops003').value + MasPar[1] + '.';
                onChange('Ops003', document.getElementById('Ops003').value);
            }
            if (MasPar[0] == 'Zak002') {
                document.getElementById('Zak003').value = document.getElementById('Zak003').value + MasPar[1] + '.';
                onChange('Zak003', document.getElementById('Zak003').value);
            }
            if (MasPar[0] == 'Rek002') {
                document.getElementById('Rek003').value = document.getElementById('Rek003').value + MasPar[1] + '.';
                onChange('Rek003', document.getElementById('Rek003').value);
            }
        }

        //    ------------------------------------------------------------------------------------------------------------------------
        function Speech(event) {
            var ParTxt = "Жалобы";
            window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
            return false;
        }

        //    ---------------- обращение веб методу --------------------------------------------------------
        function WebCam() {
    //        alert("WebCam");
            var AmbAnlIdn = document.getElementById('parUslIdn').value;
    //        alert("AmbAnlIdn =" + AmbAnlIdn);
            var AmbAnlPth = document.getElementById('parUslFio').value;
    //        alert("AmbAnlPth =" + AmbAnlPth);

            AnlWindow.setTitle(AmbAnlPth);
            AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslPth=" + AmbAnlPth);
            AnlWindow.Open();
            return false;
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslIdnTek;
    string AmbXryTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    string Col001;
    string Col002;
    string Col003;
    string Col004;
    string Col005;
    string Col006;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        parUslFio.Value = Convert.ToString(Request.QueryString["AmbUslFio"]);

        if (AmbUslIdn == "0") AmbXryTyp = "ADD";
        else AmbXryTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbUslIdn ", AmbUslIdn);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";


        if (!Page.IsPostBack)
        {
            //      TxtNap.Attributes.Add("onchange", "onChange('TxtNap',TxtNap.value);");
            TxtLgt.Attributes.Add("onchange", "onChange('TxtLgt',TxtLgt.value);");
            TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
            Dig003.Attributes.Add("onchange", "onChange('Dig003',Dig003.value);");
            Ops003.Attributes.Add("onchange", "onChange('Ops003',Ops003.value);");
            Zak003.Attributes.Add("onchange", "onChange('Zak003',Zak003.value);");
            Rek003.Attributes.Add("onchange", "onChange('Rek003',Rek003.value);");
            //============= Установки ===========================================================================================
            AmbUslIdnTek = (string)Session["AmbUslIdn"];
            if (AmbUslIdnTek != "Post")
            {

                if (AmbUslIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbUslWinAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                    cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@USLIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbUslIdn = Convert.ToString(cmd.Parameters["@USLIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }

            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;

            getDocNum();
            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM AMBUSL WHERE USLIDN=" + AmbUslIdn, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "XryOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            // ============================================================================================
            sdsUsl.SelectCommand = "HspAmbUslKodSou";
            sdsUsl.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            sdsUsl.SelectParameters.Clear();
            Parameter par1 = new Parameter("BUXFRMKOD", TypeCode.String, BuxFrm);
            par1.Size = 10;
            sdsUsl.SelectParameters.Add(par1);
            Parameter par2 = new Parameter("BUXKOD", TypeCode.String, BuxKod);
            par2.Size = 10;
            sdsUsl.SelectParameters.Add(par2);
            Parameter par3 = new Parameter("USLSTX", TypeCode.String, Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]));
            par3.Size = 10;
            sdsUsl.SelectParameters.Add(par3);
            Parameter par4 = new Parameter("AMBCRDIDN", TypeCode.String, AmbCrdIdn);
            par4.Size = 10;
            sdsUsl.SelectParameters.Add(par4);
            Parameter par5 = new Parameter("AMBUSLIDN", TypeCode.String, AmbUslIdn);
            par5.Size = 10;
            sdsUsl.SelectParameters.Add(par5);
            sdsUsl.DataBind();                    //???
            BoxUsl.Items.Clear();
            BoxUsl.DataBind();
            // ============================================================================================
            //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRXryNAM"]);
            BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]);
            BoxUsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);
            //          BoxNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLNOZ"]);
            //          TxtNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAP"]);
            TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLLGT"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLSUM"]);
            TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLZEN"]);

            if (BoxUsl.SelectedValue != "")
            {
            }

        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            BoxUsl.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================

    void GetGrid()
    {

        //        if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbXryOneDtl", con);
        cmd = new SqlCommand("HspAmbXryOneDtl", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbXryOneDtl");

        if (ds.Tables[0].Rows.Count > 0)
        {

            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DIG"]);
            Ops003.Text = Convert.ToString(ds.Tables[0].Rows[0]["OPS"]);
            Zak003.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZAK"]);
            Rek003.Text = Convert.ToString(ds.Tables[0].Rows[0]["REK"]);

            DigIdn.Value = Convert.ToString(ds.Tables[0].Rows[0]["IDNDIG"]);
            OpsIdn.Value = Convert.ToString(ds.Tables[0].Rows[0]["IDNOPS"]);
            ZakIdn.Value = Convert.ToString(ds.Tables[0].Rows[0]["IDNZAK"]);
            RekIdn.Value = Convert.ToString(ds.Tables[0].Rows[0]["IDNREK"]);

        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }

    //------------------------------------------------------------------------
    protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string TekStx;
        int TekUsl;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        //        if (TekStx > 0)
        //        {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
        cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
        cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
        cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        //===============================================================================================================

        getDocNum();

        GetGrid();

        //      }
    }

    //------------------------------------------------------------------------
    protected void BoxUsl_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int TekUsl;
        string TekStx;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);


        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        if (TekUsl > 0)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
            cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
            cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
            cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            //===============================================================================================================

            getDocNum();

            GetGrid();

        }
    }
    //===============================================================================================================
    /*
        //------------------------------------------------------------------------
        protected void PrtButton_Click(object sender, EventArgs e)
        {
            AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
            // --------------  печать ----------------------------
            Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbXry&TekDocIdn=" + AmbUslIdn);
        }
     */
    //===============================================================================================================
    //===============================================================================================================

    protected void RepButton_Click(object sender, EventArgs e)
    {
        //          System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
        //   System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "XryWindow.Close();", true);
        //   ScriptManager.RegisterStartupScript(this, GetType(), "YourUniqueScriptKey", "self.close();", true);
        //        ClientScript.RegisterStartupScript(typeof(Page), "Alert", "self.close();", true);
        //      ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowStatus", "javascript:XryWindow.Close();", true);
        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "XryWindow.Close();", true);
        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "XryWindow_ct.Close();", true);
        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "XryWindow_container.Close();", true);



    }

    // ------------------------------------------------------------------------------заполняем второй уровень

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslFio" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <asp:HiddenField ID="RekIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 70px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%">
                     <asp:Label id="Label1" Text="СТРАХОВ:" runat="server"  Width="8%" Font-Bold="true" /> 
                     <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxStx"
                            Width="33%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"
                            DataSourceID="sdsStx"
                            DataTextField="StxNam"
                            DataValueField="StxKod" />

                      <asp:Label id="Label2" Text="ЛЬГОТ:" runat="server"  Width="7%" Font-Bold="true" /> 
                      <asp:TextBox ID="TxtLgt" Width="10%" Height="25" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                      <asp:RegularExpressionValidator id="RegularExpressionValidator2"
                            ControlToValidate="TxtLgt"
                            ValidationExpression="\d+"
                            Display="Static"
                            EnableClientScript="true"
                            ErrorMessage="*"
                            runat="server"/>

                       <asp:Label id="Label4" Text="СУММА:" runat="server"  Width="7%" Font-Bold="true" /> 
                       <asp:TextBox ID="TxtSum" Width="10%" Height="25" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />

                      <asp:TextBox ID="TxtZen" Width="0%" Height="25" runat="server" Style="position: relative; font-weight: 700; font-size: medium; display:none" />

                    </td>
                </tr>
                <tr>
                    <td style="width: 100%">
                       <asp:Label id="Label6" Text="УСЛУГА:" runat="server" Height="25"  Width="8%" Font-Bold="true" /> 
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxUsl"
                            Width="70%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxUsl_OnSelectedIndexChanged"
                            DataSourceID="sdsUsl"
                            DataTextField="USLNAM"
                            DataValueField="USLKOD" />

                       <asp:Button ID="Button3" runat="server"  Width="5%" Text="Образ" OnClientClick="WebCam();" />

                    </td>
                </tr>

            </table>
         </asp:Panel>

       <asp:Panel ID="Panel1" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 430px;">
        <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->    
    
 <!--  Направительный диагноз ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:30px">                             
                            <td width="10%" style="vertical-align: top;">
                                <asp:Button ID="Dig002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз нап" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="88%" style="vertical-align: top;">
                                 <asp:TextBox ID="Dig003" Width="99%" Height="20" runat="server" TextMode="MultiLine" Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                        </tr>
 <!--  Описание----------------------------------------------------------------------------------------------------------  -->
                         <tr style="height:80px">                            
                            <td width="10%" style="vertical-align: top;">
                                <asp:Button ID="Ops002" runat="server"
                                    OnClientClick="SablonOps()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Описание" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="81%" style="vertical-align: top;">
                                 <asp:TextBox ID="Ops003" Width="99%" Height="250" runat="server" TextMode="MultiLine" Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Ops" onclick="Speech('GrfOps')">
                                 <img id="start_img61" src="/Icon/Microphone.png" alt="Start"></button>
                            </td>  
                        </tr>
 <!--  Заключения ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="10%" style="vertical-align: top;">
                                <asp:Button ID="Zak002" runat="server"
                                    OnClientClick="SablonZak()()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Заключения" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="81%" style="vertical-align: top;">
                                 <asp:TextBox ID="Zak003" Width="99%" Height="90" runat="server" TextMode="MultiLine" Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Zak" onclick="Speech('GrfZak')">
                                 <img id="start_img62" src="/Icon/Microphone.png" alt="Start"></button>
                            </td> 
                        </tr> 
 <!--  Рекомендации ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="10%" style="vertical-align: top;">
                                <asp:Button ID="Rek002" runat="server"
                                    OnClientClick="SablonRek()()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Рекомендации" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="88%" style="vertical-align: top;">
                                 <asp:TextBox ID="Rek003" Width="99%" Height="40" runat="server" TextMode="MultiLine" Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Rek" onclick="Speech('GrfRek')">
                                 <img id="start_img63" src="/Icon/Microphone.png" alt="Start"></button>
                            </td> 
                        </tr> 

        </table>
        </asp:Panel>

            <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px%; position: relative; top: 0px; width: 100%; height: 25px;">
                <center>
                    <input type="button" value="Печать"  onclick="PrtButton_Click()" />
                </center>
            </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="300" Top="100" Height="200" Width="600" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>

    </form>
<%-- 
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="HspAmbUslKodSou" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
        <SelectParameters>
            <asp:SessionParameter SessionField="BUXFRMKOD" Name="BuxFrmKod" Type="String" />
            <asp:SessionParameter SessionField="BUXKOD" Name="BuxKod" Type="String" />
            <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
            <asp:SessionParameter SessionField="AMBUSLIDN" Name="AmbUslIdn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
--%>   
     <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


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



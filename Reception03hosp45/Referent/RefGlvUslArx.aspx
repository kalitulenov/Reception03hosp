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
            else {
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
                window.open("/Priem/BuxKasPrxSprDoc.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&AmbCrdFio=" + document.getElementById("parCrdFio").value,
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
       //     TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
       //     TxtTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIMBEG"]);
       //     TxtDoc.Text = Convert.ToString(ds.Tables[0].Rows[0]["FI"]) + "  (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
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
        SqlCommand cmd = new SqlCommand("HspAmbUslStxIdnArx", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslStxIdnArx");

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

    }


    //==================================================================================================================================================
    // ============================ проверка и опрос для записи документа в базу ==============================================
    // ============================ отказ записи документа в базу ==============================================


    //----------------  ЗАПИСАТЬ  --------------------------------------------------------

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
<%-- ============================  верхний блок  ============================================ 
                           <asp:Label ID="Label5" Text="№_КАРТЫ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtNum" Width="10%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
    --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 25px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="10%" style="vertical-align: top;">
                        <asp:Label ID="Label3" Text="ПАЦИЕНТ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtPth" Width="50%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:TextBox ID="TxtInv" Width="20%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                   </td>
                </tr>
            </table>
        </asp:Panel>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 410px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="99%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                <obout:Column ID="Column01" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="6%" />
                    <obout:Column ID="Column02" DataField="KASOPL" HeaderText="КАССА" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column03" DataField="STXNAM" HeaderText="СТРАХ" Width="7%" />
                    <obout:Column ID="Column04" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="41%" Align="left" />
                    <obout:Column ID="Column05" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="5%" Align="right"/>
                    <obout:Column ID="Column06" DataField="USLKOL" HeaderText="КОЛ" Width="5%" Align="right"  />
                    <obout:Column ID="Column07" DataField="USLZEN" HeaderText="ЦЕНА" Width="5%" Align="right"  />
                    <obout:Column ID="Column08" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" Align="right"/>
                    <obout:Column ID="Column09" DataField="FI" HeaderText="ВРАЧ" Width="10%" ReadOnly="true" Align="left"/>
                    <obout:Column ID="Column10" DataField="DLGNAM" HeaderText="СПЕЦ" Width="11%" ReadOnly="true" Align="left"/>
                </Columns>
            </obout:Grid>
        </asp:Panel>
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%-- ============================  нижний блок  ============================================ BackColor="#F0E68C"--%>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->

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



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
        function Grid1_Edit(sender, record) {

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbNazPrz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbNazPrz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
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

    int UklIdn;
    int UklAmb;
    int UklNaz;
    string UklNam;
    string UklFlg001;
    string UklFlg002;
    string UklFlg003;
    string UklFlg004;
    string UklFlg005;
    string UklFlg006;
    string UklFlg007;
    string UklFlg008;
    string UklFlg009;
    string UklFlg010;
    string UklFlg011;
    string UklFlg012;
    string UklFlg013;
    string UklFlg014;
    string UklFlg015;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================
        sdsUkl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsUkl.SelectCommand = "SELECT UklKolKod,UklKolNam FROM SprUklKol";

        Grid1.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        Grid1.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        Grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {

            getGrid();
        }
        
        HidAmbCrdIdn.Value = AmbCrdIdn;
   

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        DateTime TekBegDat;
        
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUklIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["UKLDAT"].ToString())) TekBegDat = DateTime.Today;
            else TekBegDat = Convert.ToDateTime(ds.Tables[0].Rows[0]["UKLDAT"]);

            Grid1.Columns[07].HeaderText = Convert.ToDateTime(TekBegDat).ToString("dd.MM");
            Grid1.Columns[08].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(1)).ToString("dd.MM");
            Grid1.Columns[09].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(2)).ToString("dd.MM");
            Grid1.Columns[10].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(3)).ToString("dd.MM");
            Grid1.Columns[11].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(4)).ToString("dd.MM");
            Grid1.Columns[12].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(5)).ToString("dd.MM");
            Grid1.Columns[13].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(6)).ToString("dd.MM");
            Grid1.Columns[14].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(7)).ToString("dd.MM");
            Grid1.Columns[15].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(8)).ToString("dd.MM");
            Grid1.Columns[16].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(9)).ToString("dd.MM");
            Grid1.Columns[17].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(10)).ToString("dd.MM");
            Grid1.Columns[18].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(11)).ToString("dd.MM");
            Grid1.Columns[19].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(12)).ToString("dd.MM");
            Grid1.Columns[20].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(13)).ToString("dd.MM");
            Grid1.Columns[21].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(14)).ToString("dd.MM");
        }
            
        Grid1.DataSource = ds;
        Grid1.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["UKLNAM"] == null | e.Record["UKLNAM"] == "") UklNam = "";
        else UklNam = Convert.ToString(e.Record["UKLNAM"]);
        if (e.Record["UKLFLG001"] == null | e.Record["UKLFLG001"] == "") UklFlg001 = "";
        else UklFlg001 = Convert.ToString(e.Record["UKLFLG001"]);
        if (e.Record["UKLFLG002"] == null | e.Record["UKLFLG002"] == "") UklFlg002 = "";
        else UklFlg002 = Convert.ToString(e.Record["UKLFLG002"]);
        if (e.Record["UKLFLG003"] == null | e.Record["UKLFLG003"] == "") UklFlg003 = "";
        else UklFlg003 = Convert.ToString(e.Record["UKLFLG003"]);
        if (e.Record["UKLFLG004"] == null | e.Record["UKLFLG004"] == "") UklFlg004 = "";
        else UklFlg004 = Convert.ToString(e.Record["UKLFLG004"]);
        if (e.Record["UKLFLG005"] == null | e.Record["UKLFLG005"] == "") UklFlg005 = "";
        else UklFlg005 = Convert.ToString(e.Record["UKLFLG005"]);
        if (e.Record["UKLFLG006"] == null | e.Record["UKLFLG006"] == "") UklFlg006 = "";
        else UklFlg006 = Convert.ToString(e.Record["UKLFLG006"]);
        if (e.Record["UKLFLG007"] == null | e.Record["UKLFLG007"] == "") UklFlg007 = "";
        else UklFlg007 = Convert.ToString(e.Record["UKLFLG007"]);
        if (e.Record["UKLFLG008"] == null | e.Record["UKLFLG008"] == "") UklFlg008 = "";
        else UklFlg008 = Convert.ToString(e.Record["UKLFLG008"]);
        if (e.Record["UKLFLG009"] == null | e.Record["UKLFLG009"] == "") UklFlg009 = "";
        else UklFlg009 = Convert.ToString(e.Record["UKLFLG009"]);
        if (e.Record["UKLFLG010"] == null | e.Record["UKLFLG010"] == "") UklFlg010 = "";
        else UklFlg010 = Convert.ToString(e.Record["UKLFLG010"]);
        if (e.Record["UKLFLG011"] == null | e.Record["UKLFLG011"] == "") UklFlg011 = "";
        else UklFlg011 = Convert.ToString(e.Record["UKLFLG011"]);
        if (e.Record["UKLFLG012"] == null | e.Record["UKLFLG012"] == "") UklFlg012 = "";
        else UklFlg012 = Convert.ToString(e.Record["UKLFLG012"]);
        if (e.Record["UKLFLG013"] == null | e.Record["UKLFLG013"] == "") UklFlg013 = "";
        else UklFlg013 = Convert.ToString(e.Record["UKLFLG013"]);
        if (e.Record["UKLFLG014"] == null | e.Record["UKLFLG014"] == "") UklFlg014 = "";
        else UklFlg014 = Convert.ToString(e.Record["UKLFLG014"]);
        if (e.Record["UKLFLG015"] == null | e.Record["UKLFLG015"] == "") UklFlg015 = "";
        else UklFlg015 = Convert.ToString(e.Record["UKLFLG015"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@UKLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@UKLNAM", SqlDbType.VarChar).Value = UklNam;
        cmd.Parameters.Add("@UKLFLG001", SqlDbType.VarChar).Value = UklFlg001;
        cmd.Parameters.Add("@UKLFLG002", SqlDbType.VarChar).Value = UklFlg002;
        cmd.Parameters.Add("@UKLFLG003", SqlDbType.VarChar).Value = UklFlg003;
        cmd.Parameters.Add("@UKLFLG004", SqlDbType.VarChar).Value = UklFlg004;
        cmd.Parameters.Add("@UKLFLG005", SqlDbType.VarChar).Value = UklFlg005;
        cmd.Parameters.Add("@UKLFLG006", SqlDbType.VarChar).Value = UklFlg006;
        cmd.Parameters.Add("@UKLFLG007", SqlDbType.VarChar).Value = UklFlg007;
        cmd.Parameters.Add("@UKLFLG008", SqlDbType.VarChar).Value = UklFlg008;
        cmd.Parameters.Add("@UKLFLG009", SqlDbType.VarChar).Value = UklFlg009;
        cmd.Parameters.Add("@UKLFLG010", SqlDbType.VarChar).Value = UklFlg010;
        cmd.Parameters.Add("@UKLFLG011", SqlDbType.VarChar).Value = UklFlg011;
        cmd.Parameters.Add("@UKLFLG012", SqlDbType.VarChar).Value = UklFlg012;
        cmd.Parameters.Add("@UKLFLG013", SqlDbType.VarChar).Value = UklFlg013;
        cmd.Parameters.Add("@UKLFLG014", SqlDbType.VarChar).Value = UklFlg014;
        cmd.Parameters.Add("@UKLFLG015", SqlDbType.VarChar).Value = UklFlg015;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UklIdn = Convert.ToInt32(e.Record["UKLIDN"]);
        if (e.Record["UKLNAM"] == null | e.Record["UKLNAM"] == "") UklNam = "";
        else UklNam = Convert.ToString(e.Record["UKLNAM"]);
        if (e.Record["UKLFLG001"] == null | e.Record["UKLFLG001"] == "") UklFlg001 = "";
        else UklFlg001 = Convert.ToString(e.Record["UKLFLG001"]);
        if (e.Record["UKLFLG002"] == null | e.Record["UKLFLG002"] == "") UklFlg002 = "";
        else UklFlg002 = Convert.ToString(e.Record["UKLFLG002"]);
        if (e.Record["UKLFLG003"] == null | e.Record["UKLFLG003"] == "") UklFlg003 = "";
        else UklFlg003 = Convert.ToString(e.Record["UKLFLG003"]);
        if (e.Record["UKLFLG004"] == null | e.Record["UKLFLG004"] == "") UklFlg004 = "";
        else UklFlg004 = Convert.ToString(e.Record["UKLFLG004"]);
        if (e.Record["UKLFLG005"] == null | e.Record["UKLFLG005"] == "") UklFlg005 = "";
        else UklFlg005 = Convert.ToString(e.Record["UKLFLG005"]);
        if (e.Record["UKLFLG006"] == null | e.Record["UKLFLG006"] == "") UklFlg006 = "";
        else UklFlg006 = Convert.ToString(e.Record["UKLFLG006"]);
        if (e.Record["UKLFLG007"] == null | e.Record["UKLFLG007"] == "") UklFlg007 = "";
        else UklFlg007 = Convert.ToString(e.Record["UKLFLG007"]);
        if (e.Record["UKLFLG008"] == null | e.Record["UKLFLG008"] == "") UklFlg008 = "";
        else UklFlg008 = Convert.ToString(e.Record["UKLFLG008"]);
        if (e.Record["UKLFLG009"] == null | e.Record["UKLFLG009"] == "") UklFlg009 = "";
        else UklFlg009 = Convert.ToString(e.Record["UKLFLG009"]);
        if (e.Record["UKLFLG010"] == null | e.Record["UKLFLG010"] == "") UklFlg010 = "";
        else UklFlg010 = Convert.ToString(e.Record["UKLFLG010"]);
        if (e.Record["UKLFLG011"] == null | e.Record["UKLFLG011"] == "") UklFlg011 = "";
        else UklFlg011 = Convert.ToString(e.Record["UKLFLG011"]);
        if (e.Record["UKLFLG012"] == null | e.Record["UKLFLG012"] == "") UklFlg012 = "";
        else UklFlg012 = Convert.ToString(e.Record["UKLFLG012"]);
        if (e.Record["UKLFLG013"] == null | e.Record["UKLFLG013"] == "") UklFlg013 = "";
        else UklFlg013 = Convert.ToString(e.Record["UKLFLG013"]);
        if (e.Record["UKLFLG014"] == null | e.Record["UKLFLG014"] == "") UklFlg014 = "";
        else UklFlg014 = Convert.ToString(e.Record["UKLFLG014"]);
        if (e.Record["UKLFLG015"] == null | e.Record["UKLFLG015"] == "") UklFlg015 = "";
        else UklFlg015 = Convert.ToString(e.Record["UKLFLG015"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@UKLIDN", SqlDbType.Int, 4).Value = UklIdn;
        cmd.Parameters.Add("@UKLNAM", SqlDbType.VarChar).Value = UklNam;
        cmd.Parameters.Add("@UKLFLG001", SqlDbType.VarChar).Value = UklFlg001;
        cmd.Parameters.Add("@UKLFLG002", SqlDbType.VarChar).Value = UklFlg002;
        cmd.Parameters.Add("@UKLFLG003", SqlDbType.VarChar).Value = UklFlg003;
        cmd.Parameters.Add("@UKLFLG004", SqlDbType.VarChar).Value = UklFlg004;
        cmd.Parameters.Add("@UKLFLG005", SqlDbType.VarChar).Value = UklFlg005;
        cmd.Parameters.Add("@UKLFLG006", SqlDbType.VarChar).Value = UklFlg006;
        cmd.Parameters.Add("@UKLFLG007", SqlDbType.VarChar).Value = UklFlg007;
        cmd.Parameters.Add("@UKLFLG008", SqlDbType.VarChar).Value = UklFlg008;
        cmd.Parameters.Add("@UKLFLG009", SqlDbType.VarChar).Value = UklFlg009;
        cmd.Parameters.Add("@UKLFLG010", SqlDbType.VarChar).Value = UklFlg010;
        cmd.Parameters.Add("@UKLFLG011", SqlDbType.VarChar).Value = UklFlg011;
        cmd.Parameters.Add("@UKLFLG012", SqlDbType.VarChar).Value = UklFlg012;
        cmd.Parameters.Add("@UKLFLG013", SqlDbType.VarChar).Value = UklFlg013;
        cmd.Parameters.Add("@UKLFLG014", SqlDbType.VarChar).Value = UklFlg014;
        cmd.Parameters.Add("@UKLFLG015", SqlDbType.VarChar).Value = UklFlg015;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        UklIdn = Convert.ToInt32(e.Record["UKLIDN"]);

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@UKLIDN", SqlDbType.Int, 4).Value = UklIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

/*
    protected void PrtButton_Click(object sender, EventArgs e)
    {
        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbNazPrz&TekDocIdn=" + AmbCrdIdn);
    }
*/    
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАЗНАЧЕНИЯ ДЛЯ ПРОЦЕДУРНОГО КАБИНЕТА"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 380px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="Grid1" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="UKLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="UKLAMB" HeaderText="№ рецепт" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="UKLNAZ" HeaderText="Бланк"  Visible="false" Width="0%" />
                    <obout:Column ID="Column3" DataField="UKLNAM" HeaderText="Назначения" Width="20%" />
                    <obout:Column ID="Column4" DataField="PRMNAM" HeaderText="Примен" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column5" DataField="EDNLEKNAM" HeaderText="Ед.изм" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column6" DataField="UKLKOLTAB" HeaderText="Кол" Width="3%" ReadOnly="true" />

                    <obout:Column ID="Column001" DataField="UKLFLG001" HeaderText="." Width="4%" />
                    <obout:Column ID="Column002" DataField="UKLFLG002" HeaderText="." Width="4%" />
                    <obout:Column ID="Column003" DataField="UKLFLG003" HeaderText="." Width="4%" />
                    <obout:Column ID="Column004" DataField="UKLFLG004" HeaderText="." Width="4%" />
                    <obout:Column ID="Column005" DataField="UKLFLG005" HeaderText="." Width="4%" />
                    <obout:Column ID="Column006" DataField="UKLFLG006" HeaderText="." Width="4%" />
                    <obout:Column ID="Column007" DataField="UKLFLG007" HeaderText="." Width="4%" />
                    <obout:Column ID="Column008" DataField="UKLFLG008" HeaderText="." Width="4%" />
                    <obout:Column ID="Column009" DataField="UKLFLG009" HeaderText="." Width="4%" />
                    <obout:Column ID="Column010" DataField="UKLFLG010" HeaderText="." Width="4%" />
                    <obout:Column ID="Column011" DataField="UKLFLG011" HeaderText="." Width="4%" />
                    <obout:Column ID="Column012" DataField="UKLFLG012" HeaderText="." Width="4%" />
                    <obout:Column ID="Column013" DataField="UKLFLG013" HeaderText="." Width="4%" />
                    <obout:Column ID="Column014" DataField="UKLFLG014" HeaderText="." Width="4%" />
                    <obout:Column ID="Column015" DataField="UKLFLG015" HeaderText="." Width="4%" />

                    <obout:Column ID="Column9" DataField="" HeaderText="Корр" Width="7%" AllowEdit="false" AllowDelete="true" />
                </Columns>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                <input type="button" value="Печать назначения"   onclick="PrtButton_Click()" />
            </center>
        </asp:Panel>

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsUkl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
    </style>

</body>
</html>



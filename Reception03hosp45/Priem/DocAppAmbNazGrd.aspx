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
        function GridNaz_Edit(sender, record) {

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtNazButton_Click() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbNaz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbNaz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtRzpButton_Click() {
            //         alert("PrtRzpButton=");
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function SablonNaz() {
            //      alert('SblTyp=' + SblTyp);
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            window.open("DocAppSblNaz.aspx?AmbCrdIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
        }

        function GridNaz_sbl(rowIndex) {
            //           alert("GridUsl_rsx=");
            var AmbNazIdn = GridNaz.Rows[rowIndex].Cells[0].Value;
            //      alert("AmbNazIdn="+AmbNazIdn);
            //      alert("document.getElementById('parBuxKod').value="+document.getElementById('parBuxKod').value);

            $.ajax({
                type: 'POST',
                url: 'DocAppAmbNaz.aspx/ZapSablon',
                data: '{"AmbNazIdn":"' + AmbNazIdn + '", "BuxKod":"' + document.getElementById('parBuxKod').value + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("Ошибка!"); }
            });
        }



    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string AmbCrdTyp = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int NazIdn;
    int NazAmb;
    int NazNum;
    int NazBln;
    string NazObs;
    int NazTab;
    int NazKrt;
    string NazDat;
    int NazDni;
    bool NazFlg;
    int NazEdn;
    string NazDoz;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCrdTyp = Convert.ToString(Request.QueryString["AmbCrdTyp"]);
        //=====================================================================================
        sdsBln.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBln.SelectCommand = "SELECT NazBlnKod,NazBlnNam FROM SprNazBln";
        sdsPrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsPrm.SelectCommand = "SELECT PrmKod,PrmNam FROM SprNazPrm";
        sdsKrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrt.SelectCommand = "SELECT KrtKod,KrtNam FROM SprNazKrt";
        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EdnLekKod,EdnLekNam FROM SprEdnLek ORDER BY EdnLekNam";

        GridNaz.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNaz.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridNaz.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {

            getGrid();
        }
        HidAmbCrdIdn.Value = AmbCrdIdn;
        HidAmbCrdTyp.Value = AmbCrdTyp;


    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbNazIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbNazIdn");

        con.Close();

        GridNaz.DataSource = ds;
        GridNaz.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["NAZNUMBLN"] == null | e.Record["NAZNUMBLN"] == "") NazNum = 0;
        else NazNum = Convert.ToInt32(e.Record["NAZNUMBLN"]);
        if (e.Record["NAZBLNKOD"] == null | e.Record["NAZBLNKOD"] == "") NazBln = 0;
        else NazBln = Convert.ToInt32(e.Record["NAZBLNKOD"]);
        if (e.Record["NAZPLNOBS"] == null | e.Record["NAZPLNOBS"] == "") NazObs = "";
        else NazObs = Convert.ToString(e.Record["NAZPLNOBS"]);
        if (e.Record["PRMKOD"] == null | e.Record["PRMKOD"] == "") NazTab = 0;
        else NazTab = Convert.ToInt32(e.Record["PRMKOD"]);
        if (e.Record["NAZEDNTAB"] == null | e.Record["NAZEDNTAB"] == "") NazEdn = 0;
        else NazEdn = Convert.ToInt32(e.Record["NAZEDNTAB"]);
        if (e.Record["NAZKOLTAB"] == null | e.Record["NAZKOLTAB"] == "") NazDoz = "";
        else NazDoz = Convert.ToString(e.Record["NAZKOLTAB"]);
        if (e.Record["KRTKOD"] == null | e.Record["KRTKOD"] == "") NazKrt = 0;
        else NazKrt = Convert.ToInt32(e.Record["KRTKOD"]);
        //    if (e.Record["NAZDATNAZ"] == null | e.Record["NAZDATNAZ"] == "") NazDat = null;
        //    else NazDat = Convert.ToDateTime(e.Record["NAZDATNAZ"]).ToString("dd.MM.yyyy");
        if (e.Record["NAZDNI"] == null | e.Record["NAZDNI"] == "") NazDni = 0;
        else NazDni = Convert.ToInt32(e.Record["NAZDNI"]);
        NazFlg = Convert.ToBoolean(e.Record["NAZRZPFLG"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbNazAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@NAZAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@NAZNUMBLN", SqlDbType.Int, 4).Value = NazNum;
        cmd.Parameters.Add("@NAZBLN", SqlDbType.Int, 4).Value = NazBln;
        cmd.Parameters.Add("@NAZPLNOBS", SqlDbType.VarChar).Value = NazObs;
        cmd.Parameters.Add("@NAZEDNTAB", SqlDbType.Int, 4).Value = NazEdn;
        cmd.Parameters.Add("@NAZKOLTAB", SqlDbType.VarChar).Value = NazDoz;
        cmd.Parameters.Add("@NAZPRMTAB", SqlDbType.Int, 4).Value = NazTab;
        cmd.Parameters.Add("@NAZKRTTAB", SqlDbType.Int, 4).Value = NazKrt;
        cmd.Parameters.Add("@NAZDATNAZ", SqlDbType.VarChar).Value = "";  // NazDat;
        cmd.Parameters.Add("@NAZDNI", SqlDbType.Int, 4).Value = NazDni;
        cmd.Parameters.Add("@NAZRZPFLG", SqlDbType.Bit, 1).Value = NazFlg;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        NazIdn = Convert.ToInt32(e.Record["NAZIDN"]);
        if (e.Record["NAZNUMBLN"] == null | e.Record["NAZNUMBLN"] == "") NazNum = 0;
        else NazNum = Convert.ToInt32(e.Record["NAZNUMBLN"]);
        if (e.Record["NAZBLNKOD"] == null | e.Record["NAZBLNKOD"] == "") NazBln = 0;
        else NazBln = Convert.ToInt32(e.Record["NAZBLNKOD"]);
        if (e.Record["NAZPLNOBS"] == null | e.Record["NAZPLNOBS"] == "") NazObs = "";
        else NazObs = Convert.ToString(e.Record["NAZPLNOBS"]);
        if (e.Record["PRMKOD"] == null | e.Record["PRMKOD"] == "") NazTab = 0;
        else NazTab = Convert.ToInt32(e.Record["PRMKOD"]);
        if (e.Record["NAZEDNTAB"] == null | e.Record["NAZEDNTAB"] == "") NazEdn = 0;
        else NazEdn = Convert.ToInt32(e.Record["NAZEDNTAB"]);
        if (e.Record["NAZKOLTAB"] == null | e.Record["NAZKOLTAB"] == "") NazDoz = "";
        else NazDoz = Convert.ToString(e.Record["NAZKOLTAB"]);
        if (e.Record["KRTKOD"] == null | e.Record["KRTKOD"] == "") NazKrt = 0;
        else NazKrt = Convert.ToInt32(e.Record["KRTKOD"]);
        //    if (e.Record["NAZDATNAZ"] == null | e.Record["NAZDATNAZ"] == "") NazDat = null;
        //    else NazDat = Convert.ToDateTime(e.Record["NAZDATNAZ"]).ToString("dd.MM.yyyy");
        if (e.Record["NAZDNI"] == null | e.Record["NAZDNI"] == "") NazDni = 0;
        else NazDni = Convert.ToInt32(e.Record["NAZDNI"]);
        NazFlg = Convert.ToBoolean(e.Record["NAZRZPFLG"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbNazRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@NAZIDN", SqlDbType.Int, 4).Value = NazIdn;
        cmd.Parameters.Add("@NAZAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@NAZNUMBLN", SqlDbType.Int, 4).Value = NazNum;
        cmd.Parameters.Add("@NAZBLN", SqlDbType.Int, 4).Value = NazBln;
        cmd.Parameters.Add("@NAZPLNOBS", SqlDbType.VarChar).Value = NazObs;
        cmd.Parameters.Add("@NAZEDNTAB", SqlDbType.Int, 4).Value = NazEdn;
        cmd.Parameters.Add("@NAZKOLTAB", SqlDbType.VarChar).Value = NazDoz;
        cmd.Parameters.Add("@NAZPRMTAB", SqlDbType.Int, 4).Value = NazTab;
        cmd.Parameters.Add("@NAZKRTTAB", SqlDbType.Int, 4).Value = NazKrt;
        cmd.Parameters.Add("@NAZDATNAZ", SqlDbType.VarChar).Value = "";  // NazDat;
        cmd.Parameters.Add("@NAZDNI", SqlDbType.Int, 4).Value = NazDni;
        cmd.Parameters.Add("@NAZRZPFLG", SqlDbType.Bit, 1).Value = NazFlg;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        NazIdn = Convert.ToInt32(e.Record["NAZIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBNAZ WHERE NAZIDN=" + NazIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    // ==================================== поиск клиента по фильтрам  ============================================

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="HidAmbCrdTyp" runat="server" />
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАЗНАЧЕНИЯ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 400px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridNaz" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
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
                    <obout:Column ID="Column00" DataField="NAZIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="NAZNUMBLN" HeaderText="№ РЕЦ" Width="5%" Align="right" />
                    <obout:Column ID="Column02" DataField="NAZBLNKOD" HeaderText="БЛАНК" Width="5%" Align="right">
                        <TemplateSettings TemplateId="TemplateBlnNam" EditTemplateId="TemplateEditBlnNam" />
                    </obout:Column>
                    <obout:Column ID="Column03" DataField="NAZPLNOBS" HeaderText="НАЗНАЧЕНИЯ" Width="40%" >
                          <TemplateSettings HeaderTemplateID="TemplateCompanyName" />
				    </obout:Column>
                    <obout:Column ID="Column04" DataField="PRMKOD" HeaderText="ПРИМЕНЕН." Width="15%">
                        <TemplateSettings TemplateId="TemplatePrmNam" EditTemplateId="TemplateEditPrmNam" />
                    </obout:Column>

                    <obout:Column ID="Column05" DataField="NAZEDNTAB" HeaderText="ЕД.ИЗМ" Width="5%">
                        <TemplateSettings TemplateId="TemplateEdnNam" EditTemplateId="TemplateEditEdnNam" />
                    </obout:Column>
                    <obout:Column ID="Column06" DataField="NAZKOLTAB" HeaderText="КОЛ.ТАБ" Width="5%"  />

                    <obout:Column ID="Column07" DataField="KRTKOD" HeaderText="КРАТНОСТЬ" Width="10%">
                        <TemplateSettings TemplateId="TemplateKrtNam" EditTemplateId="TemplateEditKrtNam" />
                    </obout:Column>

                    <obout:Column ID="Column09" DataField="NAZDNI" HeaderText="ДНИ" Width="5%" />
                    <obout:Column ID="Column10" DataField="NAZRZPFLG" HeaderText="ПРОЦ." Width="5%">
                        <TemplateSettings TemplateId="TemplateFlgNam" EditTemplateId="TemplateEditFlgNam" />
                    </obout:Column>
                    <obout:Column ID="Column11" DataField="" HeaderText="Корр" Width="5%" AllowEdit="true" AllowDelete="true" />
                </Columns>
                <Templates>
                <obout:GridTemplate runat="server" ID="TemplateCompanyName">
					<Template>
						<b>Назначения</b>
					</Template>
				</obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateBlnNam">
                        <Template>
                            <%# Container.DataItem["NazBlnNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditBlnNam" ControlID="ddlBlnNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlBlnNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsBln" CssClass="ob_gEC" DataTextField="NAZBLNNAM" DataValueField="NAZBLNKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplatePrmNam">
                        <Template>
                            <%# Container.DataItem["PrmNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditPrmNam" ControlID="ddlPrmNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlPrmNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsPrm" CssClass="ob_gEC" DataTextField="PrmNam" DataValueField="PrmKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateKrtNam">
                        <Template>
                            <%# Container.DataItem["KrtNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKrtNam" ControlID="ddlKrtNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKrtNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKrt" CssClass="ob_gEC" DataTextField="KRTNAM" DataValueField="KRTKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateEdnNam">
                        <Template>
                            <%# Container.DataItem["EDNLEKNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditEdnNam" ControlID="ddlEdnNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlEdnNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNLEKNAM" DataValueField="EDNLEKKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="tplDatePicker" ControlID="txtOrderDate" ControlPropertyName="value">
                        <Template>
                            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                <tr>
                                    <td valign="middle">
                                        <obout:OboutTextBox runat="server" ID="txtOrderDate" Width="100%"
                                            FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                    </td>
                                    <td valign="bottom" width="30">
                                        <obout:Calendar ID="calBeg" runat="server"
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


                    <obout:GridTemplate runat="server" ID="TemplateFlgNam" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditFlgNam" ControlID="chkFlg" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkFlg" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
         <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                 <input type="button" value="Печать назначения"   onclick="PrtNazButton_Click()" />
                 <input type="button" value="Печать рецепта"   onclick="PrtRzpButton_Click()" />
                 <input type="button" value="Шаблон назначений"   onclick="SablonNaz()" />
            </center>
        </asp:Panel>


    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsBln" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsPrm" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">

      /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

       /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
               

			}
			a.pg:hover {
				color:crimson;
			}
    </style>

</body>
</html>



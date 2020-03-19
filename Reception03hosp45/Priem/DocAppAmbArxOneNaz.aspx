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

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
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


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
        sdsBln.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBln.SelectCommand = "SELECT NazBlnKod,NazBlnNam FROM SprNazBln";
        sdsPrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsPrm.SelectCommand = "SELECT PrmKod,PrmNam FROM SprNazPrm";
        sdsKrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrt.SelectCommand = "SELECT KrtKod,KrtNam FROM SprNazKrt";

        //=====================================================================================

        if (!Page.IsPostBack)
        {

            getGrid();
        }

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

        Grid1.DataSource = ds;
        Grid1.DataBind();

    }
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 500px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="Grid1" runat="server"
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
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="NAZIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="NAZNUMBLN" HeaderText="№ рецепт" Width="5%" Align="right" />
                    <obout:Column ID="Column2" DataField="NAZBLNKOD" HeaderText="Бланк" Width="5%" Align="right">
                        <TemplateSettings TemplateId="TemplateBlnNam" />
                    </obout:Column>
                    <obout:Column ID="Column3" DataField="NAZPLNOBS" HeaderText="Назначения" Width="47%" >
                          <TemplateSettings HeaderTemplateID="TemplateCompanyName" />
				    </obout:Column>
                    <obout:Column ID="Column4" DataField="PRMKOD" HeaderText="Применеие" Width="15%">
                        <TemplateSettings TemplateId="TemplatePrmNam" />
                    </obout:Column>
                    <obout:Column ID="Column5" DataField="KRTKOD" HeaderText="Кратность" Width="10%">
                        <TemplateSettings TemplateId="TemplateKrtNam"  />
                    </obout:Column>

                    <obout:Column ID="Column6" DataField="NAZDATNAZ" HeaderText="Начало" DataFormatString="{0:dd.MM.yy}" Width="8%" />

                    <obout:Column ID="Column7" DataField="NAZDNI" HeaderText="Дни" Width="5%" />
                    <obout:Column ID="Column8" DataField="NAZRZPFLG" HeaderText="Процедуры" Width="5%">
                        <TemplateSettings TemplateId="TemplateFlgNam"  />
                    </obout:Column>
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

                    <obout:GridTemplate runat="server" ID="TemplatePrmNam">
                        <Template>
                            <%# Container.DataItem["PrmNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateKrtNam">
                        <Template>
                            <%# Container.DataItem["KrtNam"]%>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateFlgNam" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsBln" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsPrm" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



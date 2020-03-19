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

    int PrsIdn;
    int PrsAmb;
    int PrsGrp;
    int PrsNum;
    int PrsUsl;
    int PrsUslExp;
    string PrsMem;
    bool PrsNprFlg;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
               
        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT StrUslKey,StrUslNam FROM SprStrUsl WHERE StrUslLvl=1 ORDER BY StrUslNam";

        sdsNpr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM SprUsl ORDER BY UslNam";
        
        sdsTrf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTrf.SelectCommand = "SELECT UslIdn,UslTrf,UslKod,UslNam," +
                               "CASE WHEN ISNULL(UslFrmZen, 0)>0 THEN 'Здесь' ELSE CASE WHEN LEN(ISNULL(UslFrmIin,'')) = 0 THEN '' ELSE UslFrmIin END END AS GDE " +
                               "FROM SprUsl INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                                           "INNER JOIN SprFrmStx ON SprUslFrm.UslFrmPrc=SprFrmStx.FrmStxPrc " +
                               "WHERE SprFrmStx.FrmStxKodStx=0 AND SprUslFrm.UslFrmHsp=" + BuxFrm +
                               " ORDER BY SprUsl.UslNam";
        
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
        SqlCommand cmd = new SqlCommand("HspAmbPrsIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbPrsIdn");

        con.Close();
        
        GridNap.DataSource = ds;
        GridNap.DataBind();

    }
    // ======================================================================================
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parPrsIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 500px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridNap" runat="server"
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
                    <obout:Column ID="Column0" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="PRSUSL" HeaderText="Код" Width="0%" />
                    <obout:Column ID="Column2" DataField="PRSNUM" HeaderText="НОМЕР" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column3" DataField="PRSTRF" HeaderText="ТАРИФ" Width="7%" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="PRSOBSTXT" HeaderText="НАПРАВЛЕНИЯ" Width="58%" />
                    <obout:Column ID="Column5" DataField="PRSUSLGDE" HeaderText="ГДЕ" Width="10%"  Align="center" ReadOnly="true"  ItemStyle-Font-Bold="true"/>
                    <obout:Column ID="Column6" DataField="PRSMEM" HeaderText="ПРИМЕЧАНИЕ" Width="20%"  Align="left" />
                 </Columns>

            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsTrf"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsNpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
	    <SelectParameters>
	        <asp:Parameter Name="STRUSLKEY" Type="String" />
	    </SelectParameters>	    
    </asp:SqlDataSource>		
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



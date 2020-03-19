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

</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UslIdn;
    int UslAmb;
    int UslKod;
    int UslKol;
    int UslSum;
    int UslKto;
    int UslLgt;
    string UslMem;



    int NumDoc;

    string AmbCrdIdn;
    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //           TxtDoc = (string)Request.QueryString["TxtSpr"];
  //      Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

        if (!Page.IsPostBack)
        {
            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

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
        SqlCommand cmd = new SqlCommand("HspPrzArxFio", con);
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


</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka"
            Text="АРХИВ ПРОЦЕДУР"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="400" />
                <Columns>
	        	    <obout:Column ID="Column0" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column1" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column2" DataField="GRFBEG" HeaderText="ВРЕМЯ"  DataFormatString="{0:hh:mm}" Width="5%" />
	                <obout:Column ID="Column3" DataField="GRFPTH" HeaderText="ФИО" Width="15%" />
	                <obout:Column ID="Column4" DataField="GRFPOL" HeaderText="КАРТА" Width="5%" />
	                <obout:Column ID="Column5" DataField="GRFBRTGOD" HeaderText="ГОД/Р" Width="5%" />
	                <obout:Column ID="Column6" DataField="USLNAM" HeaderText="ПРОЦЕДУРЫ" Width="65%"/>
                </Columns>
 		    	
            </obout:Grid>



          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
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



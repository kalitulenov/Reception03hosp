<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>

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
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string UslFrmIdn;
    string UslFrmNam;
    string BuxFrm;

    int RsxIdn;
    int RsxKod;
    decimal RsxSum;
    int RsxMat;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        UslFrmIdn = Convert.ToString(Request.QueryString["UslFrmIdn"]);
        UslFrmNam = Convert.ToString(Request.QueryString["UslNam"]);
        BuxFrm = (string)Session["BuxFrmKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
            GridRsx.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridRsx.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridRsx.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

            sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            Sapka.Text = UslFrmNam;

            if (UslFrmIdn == null | UslFrmIdn == "") RsxSum = 0;
            else GetGrid();
        }

    }


    void GetGrid()
    {

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprRsxMedIdn",con);
        cmd = new SqlCommand("HspSprRsxMedIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@USLFRMIDN", SqlDbType.VarChar).Value = UslFrmIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspSprRsxMedIdn");
        // ------------------------------------------------------------------------------заполняем второй уровень
        GridRsx.DataSource = ds;
        GridRsx.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();

    }

    void InsertRecord(object sender, GridRecordEventArgs e)
    {

        if (e.Record["RSXSUM"] == null | e.Record["RSXSUM"] == "") RsxSum = 0;
        else RsxSum = Convert.ToDecimal(e.Record["RSXSUM"]);

        if (e.Record["RSXMAT"] == null | e.Record["RSXMAT"] == "") RsxMat = 0;
        else RsxMat = Convert.ToInt32(e.Record["RSXMAT"]);

        if (e.Record["RSXKOD"] == null | e.Record["RSXKOD"] == "") RsxKod = 0;
        else RsxKod = Convert.ToInt32(e.Record["RSXKOD"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspSprRsxMedAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@RSXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@USLFRMIDN", SqlDbType.Int, 4).Value = UslFrmIdn;
        cmd.Parameters.Add("@RSXMAT", SqlDbType.Int, 4).Value = RsxMat;
        cmd.Parameters.Add("@RSXSUM", SqlDbType.VarChar).Value = RsxSum;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        RsxIdn = Convert.ToInt32(e.Record["RSXIDN"]);

        if (e.Record["RSXSUM"] == null | e.Record["RSXSUM"] == "") RsxSum = 0;
        else RsxSum = Convert.ToDecimal(e.Record["RSXSUM"]);

        if (e.Record["RSXMAT"] == null | e.Record["RSXMAT"] == "") RsxMat = 0;
        else RsxMat = Convert.ToInt32(e.Record["RSXMAT"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspSprRsxMedRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@RSXIDN", SqlDbType.Int, 4).Value = RsxIdn;
        cmd.Parameters.Add("@RSXMAT", SqlDbType.Int, 4).Value = RsxMat;
        cmd.Parameters.Add("@RSXSUM", SqlDbType.VarChar).Value = RsxSum;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        GetGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        RsxIdn = Convert.ToInt32(e.Record["RSXIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM SPRRSXMED WHERE RSXIDN=" + RsxIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }



    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="РАСХОДНЫЕ МАТЕРИАЛЫ"
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
            <obout:Grid ID="GridRsx" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                AllowSorting="true"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="RSXIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="RSXKOD" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="RSXMAT" HeaderText="МАТЕРИАЛ,УСЛУГА" Width="70%" Align="left" >
                           <TemplateSettings TemplateId="TemplateMatNam" EditTemplateId="TemplateEditMatNam"/>
                    </obout:Column>
                    <obout:Column ID="Column3" DataField="RSXEDN" HeaderText="ЕД.ИЗМ" Width="10%" Align="left" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="RSXSUM" HeaderText="КОЛ-ВО" Width="10%" />
                    <obout:Column ID="Column5" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>
            <Templates>

                <obout:GridTemplate runat="server" ID="TemplateMatNam">
                    <Template>
                        <%# Container.DataItem["MATNAM"]%>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditMatNam" ControlID="ddlMatNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlMatNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsMat" CssClass="ob_gEC" DataTextField="MATNAM" DataValueField="MATKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

            </Templates>

            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>


    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

    </style>

</body>
</html>



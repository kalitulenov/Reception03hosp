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
        /*
        function GridNap_Edit(sender, record) {

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }
        */

        function SablonWrite() {
                   alert("SablonWrite=");
            var Sablon = "";
            window.opener.HandlePopupResult(parSblNum.value + '002@' + Sablon);
            self.close();
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

    int PrsIdn;
    string PrsTrf;
    string PrsTxt;
    string PrsGde;
    int PrsUsl;
    bool PrsFlg;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);  //(string)Session["AmbCrdIdn"];
        parAmbCrdIdn.Value = AmbCrdIdn;
        //=====================================================================================
 //       sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
//        sdsUsl.SelectCommand = "SELECT UslKod,UslNam FROM SprUsl ORDER BY USLNAM";
     
        sdsTrf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTrf.SelectCommand = "SELECT UslTrf AS KodTrf,UslTrf As NamTrf FROM SprUsl WHERE LEN(ISNULL(USLTRF,''))>0 GROUP BY UslTrf";
        
        GridNap.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNap.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridNap.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

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
        SqlCommand cmd = new SqlCommand("HspAmbSblNap", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbSblNap");

        con.Close();

        GridNap.DataSource = ds;
        GridNap.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
  //      if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
 //       else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

  //      if (e.Record["PRSUSLGDE"] == null | e.Record["PRSUSLGDE"] == "") PrsGde = "";
 //       else PrsGde = Convert.ToString(e.Record["PRSUSLGDE"]);

        if (e.Record["PRSTRF"] == null | e.Record["PRSTRF"] == "") PrsTrf = "";
        else PrsTrf = Convert.ToString(e.Record["PRSTRF"]);

        if (e.Record["PRSTXT"] == null | e.Record["PRSTXT"] == "") PrsTxt = "";
        else PrsTxt = Convert.ToString(e.Record["PRSTXT"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbSblNapAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
//        cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = PrsTrf;
        cmd.Parameters.Add("@PRSTXT", SqlDbType.VarChar).Value = PrsTxt;
        // создание команды
        cmd.ExecuteNonQuery();
//     -----------------------------------------------------------------------------------------------------------------
        con.Close();
        
        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);
        
 //       if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
 //       else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

  //      if (e.Record["PRSUSLGDE"] == null | e.Record["PRSUSLGDE"] == "") PrsGde = "";
  //      else PrsGde = Convert.ToString(e.Record["PRSUSLGDE"]);

        if (e.Record["PRSTRF"] == null | e.Record["PRSTRF"] == "") PrsTrf = "";
        else PrsTrf = Convert.ToString(e.Record["PRSTRF"]);

        if (e.Record["PRSTXT"] == null | e.Record["PRSTXT"] == "") PrsTxt = "";
        else PrsTxt = Convert.ToString(e.Record["PRSTXT"]);
        
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbSblNapRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@PRSIDN", SqlDbType.Int, 4).Value = PrsIdn;
 //       cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = PrsTrf;
        cmd.Parameters.Add("@PRSTXT", SqlDbType.VarChar).Value = PrsTxt;

        // создание команды
        cmd.ExecuteNonQuery();
        //     -----------------------------------------------------------------------------------------------------------------        
        con.Close();

        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM TABSBLNAP WHERE PRSIDN=" + PrsIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void ZapSbl_click(object sender, EventArgs e)
    {
        string LstIdn = "";
//        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]); 

        if (GridNap.SelectedRecords != null)
        {
            foreach (Hashtable oRecord in GridNap.SelectedRecords)
            {
                LstIdn = LstIdn + Convert.ToInt32(oRecord["PRSIDN"]).ToString("D10") + ":"; // форматирование строки
            }

        }

      
        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbSblNapAmb", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = parAmbCrdIdn.Value;
        cmd.Parameters.Add("@LSTIDN", SqlDbType.VarChar).Value = LstIdn;
        cmd.ExecuteNonQuery();

        con.Close();

 //       System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "window.opener.HandlePopupPost(); self.close();", true);

    }

    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parAmbCrdIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="ШАБЛОН НАЗНАЧЕНИИ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 420px;">


            <%-- ============================  шапка экрана ============================================ 
                                   <obout:Column ID="Column2" DataField="PRSUSL" HeaderText="НАПРАВЛЕНИЯ" Width="25%" Wrap="true" >
                        <TemplateSettings TemplateId="TemplateUslNam" EditTemplateId="TemplateEditUslNam" />
				    </obout:Column>
                
                --%>
            <obout:Grid ID="GridNap" runat="server"
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
                    <obout:Column ID="Column0" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:CheckBoxSelectColumn ShowHeaderCheckBox="true" ControlType="Standard" Width="5%" />
                    <obout:Column ID="Column1" DataField="PRSTRF" HeaderText="ТАРИФ" Width="10%" >
                            <TemplateSettings EditTemplateId="TemplateEditTrfNam" />
                    </obout:Column>

                    <obout:Column ID="Column3" DataField="PRSTXT" HeaderText="НАПРАВЛЕНИЯ" Width="75%" Wrap="true" />
                    <obout:Column ID="Column4" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>
                <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateUslNam">
                        <Template>
                            <%# Container.DataItem["UslNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditUslNam" ControlID="ddlUslNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlUslNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsUsl" CssClass="ob_gEC" DataTextField="USLNAM" DataValueField="USLKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditTrfNam" ControlID="ddlTrfNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlTrfNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTrf" CssClass="ob_gEC" DataTextField="NAMTRF" DataValueField="KODTRF">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                   <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмеченные шаблоны перенести в амбулаторную карту" onclick="ZapSbl_click"/>
           </center>
        </asp:Panel>

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsTrf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



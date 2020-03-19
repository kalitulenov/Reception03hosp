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

        function SablonWrite() {
                   alert("SablonWrite=");
            var Sablon = "";
/*
            if (ChkSbl.checked) Sablon = Sablon + TxtSbl.innerHTML;
            if (ChkSbl001.checked) Sablon = Sablon + " " + TxtSbl001.innerHTML;
            if (ChkSbl002.checked) Sablon = Sablon + " " + TxtSbl002.innerHTML;
            if (ChkSbl003.checked) Sablon = Sablon + " " + TxtSbl003.innerHTML;
            if (ChkSbl004.checked) Sablon = Sablon + " " + TxtSbl004.innerHTML;
            if (ChkSbl005.checked) Sablon = Sablon + " " + TxtSbl005.innerHTML;
            if (ChkSbl006.checked) Sablon = Sablon + " " + TxtSbl006.innerHTML;
            if (ChkSbl007.checked) Sablon = Sablon + " " + TxtSbl007.innerHTML;
            if (ChkSbl008.checked) Sablon = Sablon + " " + TxtSbl008.innerHTML;
            if (ChkSbl009.checked) Sablon = Sablon + " " + TxtSbl009.innerHTML;
            */
            //         alert("SablonWrite=" + parSblNum.value + '  @  ' + TxtSbl.innerHTML);
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

    int NazIdn;
    int NazAmb;
    int NazNum;
    int NazBln;
    
    decimal NazKol;
    string NazEdn;
    
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
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);  //(string)Session["AmbCrdIdn"];
        //=====================================================================================
        sdsBln.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBln.SelectCommand = "SELECT NazBlnKod,NazBlnNam FROM SprNazBln";
        
        sdsPrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsPrm.SelectCommand = "SELECT PrmKod,PrmNam FROM SprNazPrm ORDER BY PRMNAM";
        
        sdsKrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrt.SelectCommand = "SELECT KrtKod,KrtNam FROM SprNazKrt ORDER BY KRTNAM";
        
        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EDNNAM FROM SPREDN ORDER BY EDNNAM";

  //      sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
  //      sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TabMat INNER JOIN SprGrpMat ON TabMat.MATGRP=SprGrpMat.GrpMatKod " +
  //                             "WHERE SprGrpMat.GrpMatGrp='Медикаменты' AND TabMat.MATFRM=" + BuxFrm + " ORDER BY MATNAM";

        GridNaz.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNaz.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridNaz.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

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
        SqlCommand cmd = new SqlCommand("HspAmbSblNaz", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbSblNaz");

        con.Close();

        GridNaz.DataSource = ds;
        GridNaz.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["NAZBLNKOD"] == null | e.Record["NAZBLNKOD"] == "") NazBln = 0;
        else NazBln = Convert.ToInt32(e.Record["NAZBLNKOD"]);
        
        if (e.Record["NAZPLNOBS"] == null | e.Record["NAZPLNOBS"] == "") NazObs = "";
        else NazObs = Convert.ToString(e.Record["NAZPLNOBS"]);

        if (e.Record["NAZEDNTAB"] == null | e.Record["NAZEDNTAB"] == "") NazEdn = "";
        else NazEdn = Convert.ToString(e.Record["NAZEDNTAB"]);
        if (e.Record["NAZKOLTAB"] == null | e.Record["NAZKOLTAB"] == "") NazKol = 0;
        else NazKol = Convert.ToDecimal(e.Record["NAZKOLTAB"]);
       
        if (e.Record["PRMKOD"] == null | e.Record["PRMKOD"] == "") NazTab = 0;
        else NazTab = Convert.ToInt32(e.Record["PRMKOD"]);
        if (e.Record["KRTKOD"] == null | e.Record["KRTKOD"] == "") NazKrt = 0;
        else NazKrt = Convert.ToInt32(e.Record["KRTKOD"]);
        if (e.Record["NAZDNI"] == null | e.Record["NAZDNI"] == "") NazDni = 0;
        else NazDni = Convert.ToInt32(e.Record["NAZDNI"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbSblNazAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
        cmd.Parameters.Add("@NAZBLN", SqlDbType.Int, 4).Value = NazBln;

        cmd.Parameters.Add("@NAZEDNTAB", SqlDbType.VarChar).Value = NazEdn;
        cmd.Parameters.Add("@NAZKOLTAB", SqlDbType.VarChar).Value = NazKol;

        cmd.Parameters.Add("@NAZPLNOBS", SqlDbType.VarChar).Value = NazObs;
        cmd.Parameters.Add("@NAZPRMTAB", SqlDbType.Int, 4).Value = NazTab;
        cmd.Parameters.Add("@NAZKRTTAB", SqlDbType.Int, 4).Value = NazKrt;
        cmd.Parameters.Add("@NAZDNI", SqlDbType.Int, 4).Value = NazDni;
        // создание команды
        cmd.ExecuteNonQuery();
//     -----------------------------------------------------------------------------------------------------------------
        con.Close();
        
        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        NazIdn = Convert.ToInt32(e.Record["NAZIDN"]);
        if (e.Record["NAZBLNKOD"] == null | e.Record["NAZBLNKOD"] == "") NazBln = 0;
        else NazBln = Convert.ToInt32(e.Record["NAZBLNKOD"]);
        if (e.Record["NAZPLNOBS"] == null | e.Record["NAZPLNOBS"] == "") NazObs = "";
        else NazObs = Convert.ToString(e.Record["NAZPLNOBS"]);

        if (e.Record["NAZEDNTAB"] == null | e.Record["NAZEDNTAB"] == "") NazEdn = "";
        else NazEdn = Convert.ToString(e.Record["NAZEDNTAB"]);
        if (e.Record["NAZKOLTAB"] == null | e.Record["NAZKOLTAB"] == "") NazKol = 0;
        else NazKol = Convert.ToDecimal(e.Record["NAZKOLTAB"]);

        if (e.Record["PRMKOD"] == null | e.Record["PRMKOD"] == "") NazTab = 0;
        else NazTab = Convert.ToInt32(e.Record["PRMKOD"]);
        if (e.Record["KRTKOD"] == null | e.Record["KRTKOD"] == "") NazKrt = 0;
        else NazKrt = Convert.ToInt32(e.Record["KRTKOD"]);
        if (e.Record["NAZDNI"] == null | e.Record["NAZDNI"] == "") NazDni = 0;
        else NazDni = Convert.ToInt32(e.Record["NAZDNI"]);
        
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbSblNazRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@NAZIDN", SqlDbType.Int, 4).Value = NazIdn;
        cmd.Parameters.Add("@NAZBLN", SqlDbType.Int, 4).Value = NazBln;
        cmd.Parameters.Add("@NAZPLNOBS", SqlDbType.VarChar).Value = NazObs;
        cmd.Parameters.Add("@NAZPRMTAB", SqlDbType.Int, 4).Value = NazTab;
        cmd.Parameters.Add("@NAZKRTTAB", SqlDbType.Int, 4).Value = NazKrt;
        cmd.Parameters.Add("@NAZDNI", SqlDbType.Int, 4).Value = NazDni;
        cmd.Parameters.Add("@NAZEDNTAB", SqlDbType.VarChar).Value = NazEdn;
        cmd.Parameters.Add("@NAZKOLTAB", SqlDbType.VarChar).Value = NazKol;

        // создание команды
        cmd.ExecuteNonQuery();
        //     -----------------------------------------------------------------------------------------------------------------        
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
        SqlCommand cmd = new SqlCommand("DELETE FROM TABSBLNAZ WHERE NAZIDN=" + NazIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void ZapSbl_click(object sender, EventArgs e)
    {
        string LstIdn = "";

        if (GridNaz.SelectedRecords != null)
        {
            foreach (Hashtable oRecord in GridNaz.SelectedRecords)
            {
                LstIdn = LstIdn + Convert.ToInt32(oRecord["NAZIDN"]).ToString("D10") + ":"; // форматирование строки
            }

        }

      
        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbSblNazAmb", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
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
                    <obout:Column ID="Column0" DataField="NAZIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:CheckBoxSelectColumn ShowHeaderCheckBox="true" ControlType="Standard" Width="5%" />
                    <obout:Column ID="Column2" DataField="NAZBLNKOD" HeaderText="РЕЦЕПТ" Width="5%" Align="right">
                        <TemplateSettings TemplateId="TemplateBlnNam" EditTemplateId="TemplateEditBlnNam" />
                    </obout:Column>
                    <obout:Column ID="Column3" DataField="NAZPLNOBS" HeaderText="НАЗНАЧЕНИЯ" Width="30%" />

                    <obout:Column ID="Column4" DataField="PRMKOD" HeaderText="ПРИМЕНЕНИЕ" Width="20%" >
                        <TemplateSettings TemplateId="TemplatePrmNam" EditTemplateId="TemplateEditPrmNam" />
				    </obout:Column>
                    <obout:Column ID="Column5" DataField="NAZEDNTAB" HeaderText="ЕД.ИЗМ" Width="10%">
                        <TemplateSettings EditTemplateId="TemplateEditEdnNam" />
                    </obout:Column>

                    <obout:Column ID="Column6" DataField="NAZKOLTAB" HeaderText="КОЛ.ЗА ПРИЕМ" Width="5%" />

                    <obout:Column ID="Column7" DataField="KRTKOD" HeaderText="КРАТНОСТЬ" Width="10%">
                        <TemplateSettings TemplateId="TemplateKrtNam" EditTemplateId="TemplateEditKrtNam" />
                    </obout:Column>
                    <obout:Column ID="Column8" DataField="NAZDNI" HeaderText="ДНЕЙ" Width="5%" />
                    <obout:Column ID="Column9" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>
                <Templates>

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
                            <asp:DropDownList ID="ddlPrmNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsPrm" CssClass="ob_gEC" DataTextField="PRMNAM" DataValueField="PRMKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditEdnNam" ControlID="ddlEdn" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlEdn" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNNAM">
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

    <asp:SqlDataSource runat="server" ID="sdsBln" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsPrm" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
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



<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
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

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->

    <script type="text/javascript">
        //    ------------------ смена логотипа ----------------------------------------------------------
        /*
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
        */
        // ==================================== при выборе клиента показывает его программу  ============================================

        function OnClientSelect(selectedRecords) {
        //    alert("DatDocIdn=" + DatDocIdn); 

            var FndRes = selectedRecords[0].MATKOD + "&" + selectedRecords[0].MATNAM + "&" + selectedRecords[0].MATEDN + "&" +
                         selectedRecords[0].MATZEN + "&" + selectedRecords[0].MATUPK + "&" + selectedRecords[0].MATPRZ + "&" +
                         selectedRecords[0].GRPMATNAM;
      //      alert("FndRes=" + FndRes); 
           // localStorage.setItem("FndRes", FndRes); //setter
            window.opener.HandlePopupResult(FndRes);
            self.close();
        }


    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string GlvDocIdn;
    string TabDtlIdn;
    string TabDtlIdnTek;
    string AmbDtlTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int MatIdn;
    string MatNam;
    string MatEdn;
    decimal MatZen;
    int MatUpk;
    decimal MatPrz;
    int MatGrp;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //    GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
        //    TabDtlIdn = Convert.ToString(Request.QueryString["TabDtlIdn"]);
        //    if (TabDtlIdn == "0") AmbDtlTyp = "ADD";
        //    else AmbDtlTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EDNNAM,EDNNAM AS EDNKOD FROM SPREDN ORDER BY EDNNAM";

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT GRPMATKOD,GRPMATNAM FROM SPRGRPMAT ORDER BY GRPMATNAM";

        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

        sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

        GridMat.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridMat.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridMat.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        if (!Page.IsPostBack)
        {


        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    protected void FndBtn_Click(object sender, EventArgs e)
    {
        string whereClause = "";

        whereClause = "";
        if (FndTxt.Text != "") whereClause += "%" + FndTxt.Text.Replace("'", "''") + "%";

        if (whereClause != "")
        {
            whereClause = whereClause.Replace("*", "%");

            if (whereClause.IndexOf("SELECT") != -1) return;
            if (whereClause.IndexOf("UPDATE") != -1) return;
            if (whereClause.IndexOf("DELETE") != -1) return;
            hidWhere.Value = whereClause;

            GetGrid();

        }
    }

    // ==================================== поиск клиента по фильтрам  ============================================
    protected void GetGrid()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        //            SqlCommand cmd = new SqlCommand("HspAmbDtlMat", con);
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlMat", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@CLAUSE", SqlDbType.VarChar).Value = hidWhere.Value;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxPrxDocDtlMat");

        GridMat.DataSource = ds;
        GridMat.DataBind();

        con.Close();

    }

    //------------------------------------------------------------------------

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        MatNam = Convert.ToString(e.Record["MATNAM"]);
        if (Convert.ToString(e.Record["MATNAM"]) == null || Convert.ToString(e.Record["MATNAM"]) == "") MatNam = "";
        else MatNam = Convert.ToString(e.Record["MATNAM"]);

        MatEdn = Convert.ToString(e.Record["MATEDN"]);

        if (Convert.ToString(e.Record["MATZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") MatZen = 0;
        else MatZen = Convert.ToDecimal(e.Record["MATZEN"]);

        if (Convert.ToString(e.Record["MATPRZ"]) == null || Convert.ToString(e.Record["MATPRZ"]) == "") MatPrz = 0;
        else MatPrz = Convert.ToDecimal(e.Record["MATPRZ"]);

        if (Convert.ToString(e.Record["MATGRP"]) == null || Convert.ToString(e.Record["MATGRP"]) == "") MatGrp = 0;
        else MatGrp = Convert.ToInt32(e.Record["MATGRP"]);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxSprMatAdd", con);
        cmd = new SqlCommand("BuxSprMatAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@MATNAM", SqlDbType.VarChar).Value = MatNam;
        cmd.Parameters.Add("@MATEDN", SqlDbType.VarChar).Value = MatEdn;
        cmd.Parameters.Add("@MATZEN", SqlDbType.Decimal).Value = MatZen;
        cmd.Parameters.Add("@MATUPK", SqlDbType.Int, 4).Value = MatUpk;
        cmd.Parameters.Add("@MATPRZ", SqlDbType.Int, 4).Value = MatPrz;
        cmd.Parameters.Add("@MATGRP", SqlDbType.Int, 4).Value = MatGrp;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        GetGrid();

    }


    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        MatIdn = Convert.ToInt32(e.Record["MATIDN"]);

        if (Convert.ToString(e.Record["MATNAM"]) == null || Convert.ToString(e.Record["MATNAM"]) == "") MatNam = "";
        else MatNam = Convert.ToString(e.Record["MATNAM"]);

        MatEdn = Convert.ToString(e.Record["MATEDN"]);

        if (Convert.ToString(e.Record["MATZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") MatZen = 0;
        else MatZen = Convert.ToDecimal(e.Record["MATZEN"]);

        if (Convert.ToString(e.Record["MATPRZ"]) == null || Convert.ToString(e.Record["MATPRZ"]) == "") MatPrz = 0;
        else MatPrz = Convert.ToDecimal(e.Record["MATPRZ"]);

        if (Convert.ToString(e.Record["MATGRP"]) == null || Convert.ToString(e.Record["MATGRP"]) == "") MatGrp = 0;
        else MatGrp = Convert.ToInt32(e.Record["MATGRP"]);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxSprMatRep", con);
        cmd = new SqlCommand("BuxSprMatRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@MATIDN", SqlDbType.Int, 4).Value = MatIdn;
        cmd.Parameters.Add("@MATNAM", SqlDbType.VarChar).Value = MatNam;
        cmd.Parameters.Add("@MATEDN", SqlDbType.VarChar).Value = MatEdn;
        cmd.Parameters.Add("@MATZEN", SqlDbType.Decimal).Value = MatZen;
        cmd.Parameters.Add("@MATUPK", SqlDbType.Int, 4).Value = MatUpk;
        cmd.Parameters.Add("@MATPRZ", SqlDbType.Int, 4).Value = MatPrz;
        cmd.Parameters.Add("@MATGRP", SqlDbType.Int, 4).Value = MatGrp;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        MatIdn = Convert.ToInt32(e.Record["MATIDN"]);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxSprMatDel", con);
        cmd = new SqlCommand("BuxSprMatDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@MATIDN", SqlDbType.Int, 4).Value = MatIdn;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();

    }

    // ------------------------------------------------------------------------------заполняем второй уровень

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDtlIdn" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <asp:HiddenField ID="hidWhere" runat="server" />
        <%-- ============================  верхний блок  ============================================ 
            
            
            
            --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 350px;">

        <asp:TextBox ID="Sapka" 
             Text="ВВОД МАТЕРИАЛА" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

            <hr />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="10%" class="PO_RowCap" align="center">Материалы:</td>
                    <td width="40%">
                        <asp:TextBox ID="FndTxt" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                            Style="font-weight: 700; font-size: large;" />
                    </td>

                    <td width="10%">
                        <asp:Button ID="FndBtn" runat="server"
                            OnClick="FndBtn_Click"
                            Width="100%" CommandName="Cancel"
                            Text="Поиск" Height="25px"
                            Style="top: 0px; left: 0px" />
                    </td>
                    <td width="50%">  </td>
                </tr>
            </table>

             <obout:Grid ID="GridMat"
                  runat="server"
                  CallbackMode="true"
                  Serialize="true"
                  AutoGenerateColumns="false"
                  FolderStyle="~/Styles/Grid/style_5"
	              FolderLocalization = "~/Localization"
	              Language = "ru"
                  AllowAddingRecords="true"
                  AllowPageSizeSelection="false"
                  AllowPaging="false"
                  EnableRecordHover="false"
                  AllowManualPaging="false"
                  ShowLoadingMessage="true"
                  ShowColumnsFooter="false"
	              ShowTotalNumberOfPages = "false"
                  KeepSelectedRecords="true"
                  AllowRecordSelection="true"
                  EnableTypeValidation="false"
                  Width="100%"
                  PageSize="-1">
                 <ScrollingSettings ScrollHeight="260" ScrollWidth="100%" />
                 <ClientSideEvents OnClientSelect="OnClientSelect" />
                 <Columns>
                      <obout:Column ID="Column0" DataField="MATIDN" HeaderText="Идн" Width="0%" Visible="false" />
	                  <obout:Column ID="Column1" DataField="MATKOD" HeaderText="Код" Visible="true" Width="10%" />
                      <obout:Column ID="Column2" DataField="MATNAM" HeaderText="Наименование" Width="40%"  Align="left"/>
                      <obout:Column ID="Column3" DataField="MATEDN" HeaderText="Ед.изм" Width="10%" Align="left" >
                             <TemplateSettings TemplateId="TemplateEdnNam" EditTemplateId="TemplateEditEdnNam" />
	            	  </obout:Column>
                      <obout:Column ID="Column4" DataField="MATZEN" HeaderText="Цена" Width="10%" Align="right" />
                      <obout:Column ID="Column5" DataField="MATUPK" HeaderText="В упак" Width="5%" Align="right" />
                      <obout:Column ID="Column6" DataField="MATPRZ" HeaderText="Надбавка" Width="5%" Align="right" />
                      <obout:Column ID="Column7" DataField="GRPMATNAM" HeaderText="Н" Width="0%" Visible="false" />
                      <obout:Column ID="Column8" DataField="MATGRP" HeaderText="Группа" Width="10%" Align="left" >
                             <TemplateSettings TemplateId="TemplateGrpNam" EditTemplateId="TemplateEditGrpNam" />
	            	  </obout:Column>
		              <obout:Column ID="Column9" DataField="" HeaderText="ИЗМ УДЛ" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>

	             <Templates>								
	                <obout:GridTemplate runat="server" ID="TemplateEdnNam" >
				       <Template>
				             <%# Container.DataItem["MATEDN"]%>			      		       
				       </Template>
				    </obout:GridTemplate>
				
				    <obout:GridTemplate runat="server" ID="TemplateEditEdnNam" ControlID="ddlEdnNam" ControlPropertyName="value">
				        <Template>
                           <asp:DropDownList ID="ddlEdnNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNNAM">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>	
				        </Template>
				    </obout:GridTemplate>

	                <obout:GridTemplate runat="server" ID="TemplateGrpNam" >
				       <Template>
				            <%# Container.DataItem["GRPMATNAM"]%>			      		       
				       </Template>
				    </obout:GridTemplate>
				
                     
				    <obout:GridTemplate runat="server" ID="TemplateEditGrpNam" ControlID="ddlGrpNam" ControlPropertyName="value">
				        <Template>
                            <asp:DropDownList ID="ddlGrpNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGrp" CssClass="ob_gEC" DataTextField="GRPMATNAM" DataValueField="GRPMATKOD">
                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                               </asp:DropDownList>	
				         </Template>
				    </obout:GridTemplate>	

	           	</Templates>

              </obout:Grid>  
            </asp:Panel>                  
    </form>

    <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
        .ob_iTIE {
            font-size: larger;
            font: bold 12px Tahoma !important; /* для увеличение корректируемого текста*/
        }
    </style>



</body>

</html>



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
    string GlvOrgKod;
    string BuxFrm;

    int BnkIdn;
    int BnkKod;
    string BnkIIK;
    string BnkMem;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        GlvOrgKod = Convert.ToString(Request.QueryString["GlvOrgKod"]);
        BuxFrm = (string)Session["BuxFrmKod"];
        //    AmbCrdIdn = (string)Session["AmbCrdIdn"];
        sdsBnk.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBnk.SelectCommand = "SELECT * FROM SPRBNK ORDER BY BNKNAM";

        GridBnk.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridBnk.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridBnk.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            GetGrid();
        }

    }


    void GetGrid()
    {
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT SPRORGBNK.*,SPRBNK.* " +
                                        "FROM SprOrgBnk INNER JOIN SprBnk ON SprOrgBnk.ORGBNKKOD=SprBnk.BNKKOD WHERE ORGBNKORG=" + GlvOrgKod, con);
        //    cmd = new SqlCommand("HspAmbUslBnkIdn", con);
        // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //    cmd.Parameters.Add("@ORGBnkOrg", SqlDbType.VarChar).Value = GlvOrgKod;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxSprOrgSel");
        // ------------------------------------------------------------------------------заполняем второй уровень
        GridBnk.DataSource = ds;
        GridBnk.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();

    }

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["ORGBNKKOD"] == null) BnkKod = 0;
        else BnkKod = Convert.ToInt32(e.Record["ORGBNKKOD"]);

        if (e.Record["ORGBNKIIK"] == null || e.Record["ORGBNKIIK"] == "") BnkIIK = "";
        else BnkIIK = Convert.ToString(e.Record["ORGBNKIIK"]);

        if (e.Record["ORGBNKMEM"] == null || e.Record["ORGBNKMEM"] == "") BnkMem = "";
        else BnkMem = Convert.ToString(e.Record["ORGBNKMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("INSERT INTO SPRORGBNK (ORGBNKORG,ORGBNKKOD,ORGBNKIIK,ORGBNKMEM) VALUES('"
                                        + GlvOrgKod + "',"  + BnkKod + ",'" + BnkIIK + "','" + BnkMem + "') ", con);
        // указать тип команды
        //     cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //      cmd.Parameters.Add("@ORGBNKOrg", SqlDbType.Int, 4).Value = GlvOrgKod;
        //      cmd.Parameters.Add("@ORGBNKIIK", SqlDbType.Int, 4).Value = BnkIIK;
        //      cmd.Parameters.Add("@ORGBNKMEM", SqlDbType.VarChar).Value = BnkMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        BnkIdn = Convert.ToInt32(e.Record["ORGBNKIDN"]);

        if (e.Record["ORGBNKKOD"] == null) BnkKod = 0;
        else BnkKod = Convert.ToInt32(e.Record["ORGBNKKOD"]);

        if (e.Record["ORGBNKIIK"] == null || e.Record["ORGBNKIIK"] == "") BnkIIK = "";
        else BnkIIK = Convert.ToString(e.Record["ORGBNKIIK"]);

        if (e.Record["ORGBNKMEM"] == null || e.Record["ORGBNKMEM"] == "") BnkMem = "";
        else BnkMem = Convert.ToString(e.Record["ORGBNKMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("UPDATE SPRORGBNK SET ORGBNKIIK='" + BnkIIK + "',ORGBNKKOD=" + BnkKod + ",ORGBNKMEM='" + BnkMem + "' WHERE ORGBNKIDN=" + BnkIdn, con);
        // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //    cmd.Parameters.Add("@ORGBNKIDN", SqlDbType.Int, 4).Value = BnkIdn;
        //     cmd.Parameters.Add("@ORGBnkOrg", SqlDbType.Int, 4).Value = GlvOrgKod;
        //     cmd.Parameters.Add("@ORGBnkIIK", SqlDbType.Int, 4).Value = BnkIIK;
        //    cmd.Parameters.Add("@ORGBNKMEM", SqlDbType.VarChar).Value = BnkMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        GetGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        BnkIdn = Convert.ToInt32(e.Record["ORGBNKIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM SPRORGBNK WHERE ORGBNKIDN=" + BnkIdn, con);
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
            Text="СЧЕТА В БАНКЕ"
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
            <obout:Grid ID="GridBnk" runat="server"
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
                    <obout:Column ID="Column0" DataField="ORGBNKIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="ORGBNKORG" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="BNKBIK" HeaderText="БИК" Width="15%" ReadOnly="true" />
                    <obout:Column ID="Column3" DataField="ORGBNKKOD" HeaderText="НАИМЕНОВАНИЕ БАНКА"  Width="35%" >
	                      <TemplateSettings TemplateId="TemplateBnkNam" EditTemplateId="TemplateEditBnkNam" />
	                </obout:Column>
                    <obout:Column ID="Column4" DataField="ORGBNKIIK" HeaderText="ИИК" Width="20%" />
                    <obout:Column ID="Column5" DataField="ORGBNKMEM" HeaderText="ПРИМЕЧАНИЕ" Width="20%" Align="left" />
                    <obout:Column ID="Column6" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateBnkNam" >
				                    <Template>
				                            <%# Container.DataItem["BNKNAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditBnkNam" ControlID="ddlBnkNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlBnkNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsBnk" CssClass="ob_gEC" DataTextField="BNKNAM" DataValueField="BNKKOD">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>

	                    		</Templates>


            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sdsBnk" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
<!--------------------------------------------------------  -->   
    </form>

    <%-- ============================  STYLES ============================================ --%>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

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



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

        function GridDry_ClientEdit(sender, record) {
            //           alert("GridDry_ClientEdit");
            var AmbDryIdn = record.DRYIDN;
            DryWindow.setTitle(AmbDryIdn);
            DryWindow.setUrl("DocAppAmbDryOne.aspx?AmbDryIdn=" + AmbDryIdn);
            DryWindow.Open();

            return false;
        }

        function GridDry_ClientInsert(sender, record) {
  //                    alert("GridDry_ClientInsert");
            var AmbDryIdn = 0;
            DryWindow.setTitle(AmbDryIdn);
            DryWindow.setUrl("DocAppAmbDryOne.aspx?AmbDryIdn=" + AmbDryIdn);
            DryWindow.Open();

            return false;
        }

        function WindowClose() {
  //          alert("GridDryClose");
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);
        //  __doPostBack('btnSave', e.innerHTML);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        //    ==========================  УДАЛИТЬ =============================================================================================
        function OnBeforeDelete(sender, record) {
          //           alert("OnBeforeDelete");
                    document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
                    document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                    myConfirmBeforeDelete.Open();
                    return false;
        }

        function findIndex(record) {
            var index = -1;
            for (var i = 0; i < GridDry.Rows.length; i++) {
                if (GridDry.Rows[i].Cells[0].Value == record.DRYIDN) {
                    index = i;
                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
                    alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            GridDry.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
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

    int DryIdn;
    int DryAmb;
    int DryNum;
    int DryBln;
    string DryObs;
    int DryTab;
    int DryKrt;
    string DryDat;
    int DryDni;
    bool DryFlg;
    
    int DryEdn;
    decimal DryDoz;
    
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
//        GridDry.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridDry.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
//        GridDry.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================
        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals("")) Session["AmbDryIdn"] = "Post";
        if (!Page.IsPostBack)
        {

        }
   
        getGrid();
        
        HidAmbCrdIdn.Value = AmbCrdIdn;


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
        SqlCommand cmd = new SqlCommand("HspAmbDryIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbDryIdn");

        con.Close();

        GridDry.DataSource = ds;
        GridDry.DataBind();

    }
    // ======================================================================================
    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        DryIdn = Convert.ToInt32(e.Record["DRYIDN"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbDryDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@DRYIDN", SqlDbType.Int, 4).Value = DryIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

/*
    protected void PrtDryButton_Click(object sender, EventArgs e)
    {
        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbDry&TekDocIdn=" + AmbCrdIdn);
    }

    protected void PrtRzpButton_Click(object sender, EventArgs e)
    {
        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn);
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
            Text="ДНЕВНИК"
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
            <obout:Grid ID="GridDry" runat="server"
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
                <ClientSideEvents 
		               OnBeforeClientEdit="GridDry_ClientEdit" 
		               OnBeforeClientAdd="GridDry_ClientInsert"
		               ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column0" DataField="DRYIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="DRYAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="DRYSTZ" HeaderText="Стц" Visible="false" Width="0%" />
                    <obout:Column ID="Column3" DataField="STZDRYNAM" HeaderText="Тип" Width="10%" />
 	                <obout:Column ID="Column4" DataField="DRYDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column5" DataField="DRYMEM" HeaderText="ОПИСАНИЕ" Width="55%" Wrap="true" />
                    <obout:Column ID="Column6" DataField="FI" HeaderText="ВРАЧ" Width="10%" />
                    <obout:Column ID="Column7" DataField="DLGNAM" HeaderText="СПЕЦ." Width="10%" />
                    <obout:Column ID="Column8" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	             

                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
       			<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridDry.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridDry.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridDry.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridDry.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridDry.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridDry.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridDry.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="DryWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="10" Height="420" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Назначения">

       </owd:Window>

<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Confirm" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>

    </form>

    <%-- ============================  STYLES ============================================ --%>

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



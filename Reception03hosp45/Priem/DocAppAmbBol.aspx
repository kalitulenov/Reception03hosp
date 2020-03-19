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

        function HandlePopupResult(result) {
            //                       alert("result of popup is: " + result);

            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);

        }

        function KltClose(result) {
            //    alert("KofClose=1" + result);
            BolWindow.Close();
        }

        function GridBol_ClientEdit(sender, record) {
        //               alert("GridBol_ClientEdit");
            var AmbBolIdn = record.BOLIDN;
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;

            BolWindow.setTitle(AmbBolIdn);
            BolWindow.setUrl("DocAppAmbBolOne.aspx?AmbBolIdn=" + AmbBolIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbRej=0");
            BolWindow.Open();

            return false;
        }

        function GridBol_ClientInsert(sender, record) {
        //              alert("GridBol_ClientInsert");
            var AmbBolIdn = 0;
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
       //     alert("AmbCrdIdn=" + AmbCrdIdn);

            BolWindow.setTitle(AmbBolIdn);
            BolWindow.setUrl("DocAppAmbBolOne.aspx?AmbBolIdn=0&AmbCrdIdn=" + AmbCrdIdn + "&AmbRej=0");
            BolWindow.Open();

            return false;
        }

        function WindowClose() {
        //    alert("GridBolClose");
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);
        }


        //    ==========================  ПЕЧАТЬ =============================================================================================
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

    int BolIdn;
    int BolAmb;
    int BolNum;
    int BolBln;
    string BolObs;
    int BolTab;
    int BolKrt;
    string BolDat;
    int BolDni;
    bool BolFlg;

    int BolEdn;
    decimal BolDoz;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
        //        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCrdTyp = Convert.ToString(Request.QueryString["AmbCrdTyp"]);
        //=====================================================================================

        //       GridBol.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        //       GridBol.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        //       GridBol.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================
        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals("")) Session["AmbBolIdn"] = "Post";
        if (!Page.IsPostBack)
        {

        }

        getGrid();

        HidAmbCrdIdn.Value = AmbCrdIdn;
        HidAmbCrdTyp.Value = AmbCrdTyp;


    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbBolIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.Parameters.Add("@BOLTYP", SqlDbType.VarChar).Value = "БОЛ";

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbBolIdn");

        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        GridBol.DataSource = ds;
        GridBol.DataBind();

    }
    // ======================================================================================

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        BolIdn = Convert.ToInt32(e.Record["BOLIDN"]);
        //=====================================================================================
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbBolDel", con);
        cmd = new SqlCommand("HspAmbBolDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@BOLBUX", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@BOLIDN", SqlDbType.Int, 4).Value = BolIdn;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень

        getGrid();
    }

    // =================================================================================================================================================
</script>


<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="HidAmbCrdTyp" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="БОЛЬНИЧНЫЕ ЛИСТЫ"
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
            <obout:Grid ID="GridBol" runat="server"
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
		               OnBeforeClientEdit="GridBol_ClientEdit" 
		               OnBeforeClientAdd="GridBol_ClientInsert"
		               ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="BOLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="BOLAMB" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="BOLNUM" HeaderText="№ Б\Л" Width="9%" />
                    <obout:Column ID="Column03" DataField="DOC000" HeaderText="0.ВРАЧ ОТКРЫЛ" Width="10%" />
                    <obout:Column ID="Column04" DataField="BOLBEG000" HeaderText="0.ДАТА ОТКРЫТИЕ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />
                    <obout:Column ID="Column05" DataField="BOLEND000" HeaderText="0.КОНЕЦ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />

                    <obout:Column ID="Column06" DataField="DOC001" HeaderText="1.ВРАЧ ПРОДЛИЛ" Width="10%" />
                    <obout:Column ID="Column07" DataField="BOLEND001" HeaderText="1.КОНЕЦ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />

                    <obout:Column ID="Column08" DataField="DOC002" HeaderText="2.ВРАЧ ПРОДЛИЛ" Width="10%" />
                    <obout:Column ID="Column09" DataField="BOLEND002" HeaderText="2.КОНЕЦ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />

                    <obout:Column ID="Column10" DataField="DOC003" HeaderText="3.ВРАЧ ПРОДЛИЛ" Width="10%" />
                    <obout:Column ID="Column11" DataField="BOLEND003" HeaderText="3.КОНЕЦ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />

                    <obout:Column ID="Column12" DataField="DOC009" HeaderText="4.ВРАЧ ЗАКРЫЛ" Width="10%" />
                    <obout:Column ID="Column13" DataField="BOLEND009" HeaderText="4.ДАТА ЗАКРЫТИЕ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />

                    <obout:Column ID="Column15" HeaderText="ИЗМЕН" Width="5%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
       			<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridBol.edit_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridBol.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridBol.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Открыть БЛ" onclick="GridBol.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridBol.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridBol.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="BolWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="5" Height="430" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Назначения">

       </owd:Window>

    </form>

    <%-- ============================  STYLES ============================================ --%>

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



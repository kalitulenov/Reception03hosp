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

        function HandlePopupPost(result) {
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }

        function GridNap_Edit(sender, record) {
            
 //           alert("record.STRUSLKEY=" + record.STRUSLKEY);
                TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
                TemplateGrpKey.value(record.STRUSLKEY);
                TemplateGrpKey._preventDetailLoading = false;
                TemplateGrpKey._populateDetail();

                return true;
        }

        // ==================================== корректировка данные клиента в отделном окне  ============================================
        function GridNap_ClientEdit(sender, record) {
            document.getElementById('parPrsIdn').value = record.PRSIDN;
            TrfWindow.Open();

            return false;
        }


        function GridNap_ClientAdd(sender, record) {

   //                    alert("GridUыд_ClientEdit");
//            document.getElementById('parPrsIdn').value = 0;
//            TrfWindow.Open();
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/DopAmb/DopAppAmbPrsGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                            "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/DopAmb/DopAppAmbPrsGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");

            return false;
        }

/*
        function OnClientDblClick(iRecordIndex) {
//                       alert('OnClientDblClick= ');
            var GrfDocRek;
            var GrfDocIdn = document.getElementById('parPrsIdn').value;
            var GrfDocKod = gridTrf.Rows[iRecordIndex].Cells[0].Value;

            // -------------------------- изменить GRID -------------------------------------------------
            var data = new Object();
            data.PRSIDN = GrfDocIdn;
            data.PRSUSL = GrfDocKod;
            data.PRSMEM = "";

            if (GrfDocIdn != 0) {
                GridNap.executeUpdate(data);
            }
            else {
                GridNap.executeInsert(data);
            }

            TrfWindow.Close();
        }

*/

        function OnClientSelect(selectedRecords) {
            //var AmbCrdIdn = selectedRecords[0].GRFIDN;
            //       alert("AmbCrdIdn=" + AmbCrdIdn);

            //                       alert('OnClientDblClick= ');
            var GrfDocRek;
            var GrfDocIdn = document.getElementById('parPrsIdn').value;
            var GrfDocKod = selectedRecords[0].USLKOD;

                        //alert('GrfDocIdn= ' + GrfDocIdn);
                        //alert('GrfDocKod= ' + GrfDocKod);

            // -------------------------- изменить GRID -------------------------------------------------
            var data = new Object();
            data.PRSIDN = GrfDocIdn;
            data.PRSUSL = GrfDocKod;
            data.PRSMEM = "";

            if (GrfDocIdn != 0) {
                                //alert('GrfDocKod2= ' + GrfDocKod);
                GridNap.executeUpdate(data);
            }
            else {
                //               alert('GrfDocKod3= ' + GrfDocKod);
                //                Contr = parseInt(Contr) + 1;
                //                document.getElementById('cntr').value = Contr;
                GridNap.executeInsert(data);
            }

            TrfWindow.Close();

        }


        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
 //           alert('AmbCrdIdn= ' );
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function PrtButtonAll_Click() {
            //           alert('AmbCrdIdn= ' );
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbPrsAll&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbPrsAll&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function SablonPrs() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
        //    alert('AmbCrdIdn=' + AmbCrdIdn);
            window.open("DocAppSblNap.aspx?AmbCrdIdn=" + AmbCrdIdn,"Browser=Desktop", "ModalPopUp", "toolbar=no,width=1100,height=600,left=150,top=100,location=no,modal=yes,status=no,scrollbars=no,resize=no");
        }

        function GridPrs_sbl(rowIndex) {
            //           alert("GridUsl_rsx=");
            var AmbPrsIdn = GridNap.Rows[rowIndex].Cells[0].Value;

  //          alert("AmbPrsIdn="+AmbPrsIdn);
 //           alert("BuxKod=" + document.getElementById('parBuxKod').value);

            $.ajax({
                type: 'POST',
                url: 'DocAppAmbPrs.aspx/ZapSablon',
                data: '{"AmbPrsIdn":"' + AmbPrsIdn + '", "BuxKod":"' + document.getElementById('parBuxKod').value + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("Ошибка!"); }
            });
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
        parBuxKod.Value = BuxKod;
        //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================
               
        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT StrUslKey,StrUslNam FROM SprStrUsl WHERE StrUslLvl=1 ORDER BY StrUslNam";

        sdsNpr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM SprUsl ORDER BY UslNam";
        
        sdsTrf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        
        GridNap.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNap.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridNap.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

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
        SqlCommand cmd = new SqlCommand("SELECT PRSIDN,PRSAMB,PRSNUM,PRSUSL,SprUsl.UslNam,PRSOBSTXT,PRSOBSEXP,PRSGRP,PRSTRF,PRSMEM,"+
                                               "PRSNPRKTO AS BUXKOD,PRSNPRFLG,SprBuxKdr.FIO,PRSMEM,PRSNPRFLG,SprOrgHsp.ORGHSPNAMSHR " +
                                        "FROM DOPPRS LEFT OUTER JOIN SprOrgHsp ON DOPPRS.PRSUSLGDE=SprOrgHsp.ORGHSPKOD " +
                                                    "LEFT OUTER JOIN SprUsl ON DOPPRS.PRSUSL=SprUsl.UslKod "+
                                                    "LEFT OUTER JOIN SprBuxKdr ON DOPPRS.PRSNPRKTO=SprBuxKdr.BuxKod "+
                                        "WHERE DOPPRS.PRSAMB=" + AmbCrdIdn + " ORDER BY PRSIDN", con);
        // указать тип команды
      //  cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
    //    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspDopPrsIdn");

        con.Close();
        
        GridNap.DataSource = ds;
        GridNap.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
        else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

        if (e.Record["PRSMEM"] == null | e.Record["PRSMEM"] == "") PrsMem = "";
        else PrsMem = Convert.ToString(e.Record["PRSMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspDopPrsAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@PRSAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSMEM", SqlDbType.VarChar).Value = PrsMem;

        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);
        
        if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
        else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

        if (e.Record["PRSMEM"] == null | e.Record["PRSMEM"] == "") PrsMem = "";
        else PrsMem = Convert.ToString(e.Record["PRSMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspDopPrsRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@PRSIDN", SqlDbType.Int, 4).Value = PrsIdn;
        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSMEM", SqlDbType.VarChar).Value = PrsMem;
        // создание команды
        cmd.ExecuteNonQuery();
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
        SqlCommand cmd = new SqlCommand("DELETE FROM DOPPRS WHERE PRSIDN=" + PrsIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

/*
    protected void PrtButton_Click(object sender, EventArgs e)
    {

        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn);
    }
*/
    
    protected void Detail_LoadingItems(object sender, ComboBoxLoadingItemsEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.Text))
        {
                sdsNpr.SelectParameters[0].DefaultValue = e.Text;
//                sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM  SprUsl WHERE ISNULL(SprUsl.UslNap,0)=1 AND SprUsl.UslKey='" + 
//                                        e.Text + "' " + "ORDER BY SprUsl.UslNam";
                sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM  SprUsl WHERE LEFT(SprUsl.UslKey,3)='" + e.Text + "' " + "ORDER BY SprUsl.UslNam";
        }
    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
    // ==================================== поиск клиента по фильтрам  ============================================
    protected void FndBtn_Click(object sender, EventArgs e)
    {
        int I = 0;
 //       string commandText = "SELECT * FROM SPRUSL ";
        string commandText = "SELECT UslIdn,UslTrf,UslKod,UslNam," +
                       "CASE WHEN ISNULL(UslFrmZen, 0)>0 THEN 'Здесь' ELSE CASE WHEN LEN(ISNULL(UslFrmIin,'')) = 0 THEN '' ELSE SprOrg.ORGNAMSHR END END AS GDE " +
                       "FROM SprUsl INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                                   "LEFT OUTER JOIN SprOrg ON SprUslFrm.UslFrmIin=SprOrg.ORGKOD " +
                       "WHERE SprUslFrm.UslFrmHsp=" + BuxFrm;
    
        string whereClause = "";

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        whereClause = "";
        if (FndTxt.Text != "")
        {
            I = I + 1;
            whereClause += " AND USLNAM LIKE '%" + FndTxt.Text.Replace("'", "''") + "%'";
        }
        if (FndKod.Text != "")
        {
            I = I + 1;
//            if (I > 1) whereClause += " AND ";
            whereClause += " AND USLTRF LIKE '" + FndKod.Text.Replace("'", "''") + "%'";
        }

        if (whereClause != "")
        {
            whereClause = whereClause.Replace("*", "%");

            if (whereClause.IndexOf("SELECT") != -1) return;
            if (whereClause.IndexOf("UPDATE") != -1) return;
            if (whereClause.IndexOf("DELETE") != -1) return;

            commandText += whereClause + " ORDER BY SprUsl.UslNam";
            SqlCommand cmd = new SqlCommand(commandText, con);
            con.Open();
            SqlDataReader myReader = cmd.ExecuteReader();
            gridTrf.DataSource = myReader;
            gridTrf.DataBind();
            con.Close();

        }
    }

    // =================================================================================================================================================

    [WebMethod]
    public static string ZapSablon(string AmbPrsIdn, string BuxKod)
    {

        if (!string.IsNullOrEmpty(AmbPrsIdn))
        {
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();

            SqlCommand cmd = new SqlCommand("HspAmbSblNapAmbSbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@PRSIDN", SqlDbType.VarChar).Value = AmbPrsIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        else
        {
            //          Otvet.Text = "Неверный пароль или входное имя";
            return "ERR";
        }
    }
                 
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parPrsIdn" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАПРАВЛЕНИЯ"
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
                <ClientSideEvents OnBeforeClientEdit="GridNap_ClientEdit"
                                  OnBeforeClientAdd="GridNap_ClientAdd" 
                                  ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column0" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="PRSUSL" HeaderText="Код" Width="0%" />
                    <obout:Column ID="Column2" DataField="PRSNUM" HeaderText="НОМЕР" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column3" DataField="PRSTRF" HeaderText="ТАРИФ" Width="7%" ReadOnly="true" />
                    <obout:Column ID="Column5" DataField="PRSOBSTXT" HeaderText="НАПРАВЛЕНИЯ" Width="66%"  Align="left" Wrap="true" />
                    <obout:Column ID="Column6" DataField="ORGHSPNAMSHR" HeaderText="ГДЕ" Width="10%"  Align="left" ReadOnly="true"  ItemStyle-Font-Bold="true"/>
                    <obout:Column ID="Column7" HeaderText="Коррек  Удаление" Width="7%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>	  

                    <obout:Column ID="Column8" DataField="SBLFLG" HeaderText="ШАБЛОН" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateSbl" />
				    </obout:Column>		
                   </Columns>

                   <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                   
                   <Templates>
                       <obout:GridTemplate runat="server" ID="editBtnTemplate">
                          <Template>
                             <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridNap.edit_record(this)"/>
                             <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridNap.delete_record(this)"/>
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                          <Template>
                             <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridNap.update_record(this)"/> 
                             <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridNap.cancel_edit(this)"/> 
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridNap.addRecord()"/>
                        </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridNap.insertRecord()"/> 
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridNap.cancelNewRecord()"/> 
                        </Template>
                      </obout:GridTemplate>	

                   <obout:GridTemplate runat="server" ID="TemplateSbl">
                       <Template>
                          <input type="button" id="btnSbl" class="tdTextSmall" value="->Шаблон" onclick="GridPrs_sbl(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <input type="button" value="Печать направления по одному"  onclick="PrtButtonAll_Click()" />
                 <input type="button" value="Печать направления"  onclick="PrtButton_Click()" />
                 <input type="button" value="Шаблон направлении"   onclick="SablonPrs()" />
             </center>
  </asp:Panel> 
        
           <%-- =================  окно для поиска клиента из базы  ============================================ --%>

        <owd:Window ID="TrfWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="200" Top="50" Height="400" Width="900" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Тарификатор">
           
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="10%" class="PO_RowCap" align="center">Код:</td>
                            <td width="20%">
                                <asp:TextBox ID="FndKod" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                    Style="font-weight: 700; font-size: large;" />
                            </td>

                            <td width="10%" class="PO_RowCap" align="center">Текст:</td>
                            <td width="50%">
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
                        </tr>
            </table>


            <oajax:CallbackPanel ID="CallbackPanelTrf" runat="server">
             <Content>           
              <obout:Grid ID="gridTrf"
                  runat="server"
                  CallbackMode="true"
                  Serialize="true"
                  AutoGenerateColumns="false"
                  FolderStyle="~/Styles/Grid/style_11"
                  AllowAddingRecords="false"
                  ShowLoadingMessage="true"
                  ShowColumnsFooter="false"
                  KeepSelectedRecords="true"
                  Width="100%"
                  PageSize="-1"
                  ShowFooter="false">
                 <ScrollingSettings ScrollHeight="295" ScrollWidth="100%" />
                 <ClientSideEvents OnClientSelect="OnClientSelect" />
                 <Columns>
                      <obout:Column ID="Column20" DataField="USLKOD" HeaderText="Код" ReadOnly="true" Width="0%" Visible="false" />
                      <obout:Column ID="Column21" DataField="USLTRF" HeaderText="Тариф" ReadOnly="true" Width="10%"  Align="left"/>
                      <obout:Column ID="Column22" DataField="USLNAM" HeaderText="Наименование" ReadOnly="true" Width="80%" Align="left" />
                      <obout:Column ID="Column23" DataField="GDE" HeaderText="Где" ReadOnly="true" Width="10%" Align="left" />
                </Columns>
              </obout:Grid>
              
             </Content>
           </oajax:CallbackPanel>
             
          </owd:Window>
         

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



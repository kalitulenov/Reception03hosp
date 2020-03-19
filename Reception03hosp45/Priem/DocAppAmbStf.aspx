<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>

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
        function GridStf_prt(rowIndex) {
            var AmbStfIdn = GridStf.Rows[rowIndex].Cells[0].Value;
            var AmbStfKod = GridStf.Rows[rowIndex].Cells[1].Value;
//            alert("GridUsl_rsx=" + AmbStfIdn);
 //           alert("GridUsl_rsx=" + AmbStfKod);
            var ua = navigator.userAgent;

    //        if (AmbStfKod == "Сертификат") 
               if (ua.search(/Chrome/) > -1)
                   window.open("/Report/DauaReports.aspx?ReportName=HspAmbStf&TekDocIdn=" + AmbStfIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
               else
                   window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbStf&TekDocIdn=" + AmbStfIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
    //        else 
    //            if (ua.search(/Chrome/) > -1)
    //                window.open("/Report/DauaReports.aspx?ReportName=HspAmbRpt&TekDocIdn=" + AmbStfIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
     //           else
     //               window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbRpt&TekDocIdn=" + AmbStfIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            return true;
        }


        function GridStf_ClientEdit(sender, record) {
            WindowStf.Open();

            document.getElementById('STFIDN').value = record.STFIDN;

  //          if (record.STFKOD == 2) document.getElementById('WindowStf_BoxDok_ob_CboBoxDokTB').value = "Рапорт";
  //          else document.getElementById('WindowStf_BoxDok_ob_CboBoxDokTB').value = "Сертификат";

            SuperForm1_STFMEM.value(record.STFMEM);

            return false;
        }

        function GridStf_ClientAdd(sender, record) {
            WindowStf.Open();
            document.getElementById('STFIDN').value = 0;
   //         document.getElementById('WindowStf_BoxDok_ob_CboBoxDokTB').value = "Рапорт";
   //         SuperForm1_STFKOD.value('Рапорт');
            SuperForm1_STFNUM.value(record.STFNUM);
            SuperForm1_STFMEM.value(record.STFMEM);
     //       SuperForm1_STFMEM.value("дана, в том, что ______________ находился на амбулаторной лечении с _____ по _____ ");

    //        document.getElementById('WindowStf$SuperForm1$SuperForm1_STFMEM') = "дана, в том, что ______________ находился на амбулаторной лечении с _____ по _____ ";

            //<textarea name="WindowStf$SuperForm1$SuperForm1_STFMEM" rows="2" cols="20" id="WindowStf$SuperForm1$SuperForm1_STFMEM" title="Описание"></textarea>
            return false;
        }

        function saveChanges() {
            WindowStf.Close();

            var STFIDN = document.getElementById('STFIDN').value;
            // -------------------------- изменить GRID -------------------------------------------------
            for (var i = 0; i < GridStf.Rows.length; i++) {
                if (GridStf.Rows[i].Cells[0].Value == STFIDN) {
                    GridStf.Rows[i].Cells[3].Value = SuperForm1_STFMEM.value();
                    break;
                }
            }
           
            // -------------------------- изменить GRID -------------------------------------------------

            var data = new Object();

            //       if (isNaN(parseInt(KDRCMB.options[KDRCMB.selectedIndex()].value))) // еслн не число
            //           data.DOCDTLKDR = document.getElementById('par').value;
            //       else
            //           data.DOCDTLKDR = KDRCMB.options[KDRCMB.selectedIndex()].value;
            //              alert('data.DOCDTLKDR: ' + data.DOCDTLKDR);

            data.STFMEM = SuperForm1_STFMEM.value();

            if (STFIDN != 0) {
                data.STFIDN = STFIDN;
                GridStf.executeUpdate(data);
            }
            else {
                GridStf.executeInsert(data);
            }
            

        }

        function Sablon() {
            var STFIDN = document.getElementById('STFIDN').value;
            SuperForm1_STFMEM.value("дана о том, что он(она) действительно находился(ась) на амбулаторном наблюдений с " +
                                    document.getElementById('parDatMin').value + " по " + document.getElementById('parDatMax').value + " по состоянию здоровья.Эпид.окружения по дому чиста");
        }

        function cancelChanges() {
            WindowStf.Close();
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var GrfDocVal;

            GrfDocVal = BoxDok.options[BoxDok.selectedIndex()].value;
//            alert("GrfDocVal=" + GrfDocVal);

            if (GrfDocVal == "1") document.getElementById('WindowStf_SuperForm1_SuperForm1_STFMEM').innerHTML=" дана о том, что пациент действительно находился на амбулаторном лечении с __.__.20__ по __.__.20__ г." +
                                                           " Эпид.окружение чистое. Освободить от физ.културы на две недели с __.__.20__ по __.__.20__ г.";
            if (GrfDocVal == "2") document.getElementById('WindowStf_SuperForm1_SuperForm1_STFMEM').innerHTML="Прошу оплатить стоимость медикаментов,консультации на сумму 00000 тенге клиенту _________________________  компании ________________  № страховой карточки _________ на основании (направления,рецепта,листа назначений) №__. Диагноз I06.1";
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

    int StfIdn;
    int StfAmb;
    int StfKod;
    int StfNum;
    string StfMem;


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
        sdsDok.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDok.SelectCommand = "SELECT DokKod,DokNam  AS STFNAM FROM SprDok";

        GridStf.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridStf.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridStf.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

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
        SqlCommand cmd = new SqlCommand("HspAmbStfIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@STFIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbStfIdn");

        con.Close();

      //  if (ds.Tables[0].Rows.Count > 0)
      //  {
            parDatMin.Value = Convert.ToString(ds.Tables[1].Rows[0]["DATMIN"]);
            parDatMax.Value = Convert.ToString(ds.Tables[1].Rows[0]["DATMAX"]);
      //  }

        GridStf.DataSource = ds.Tables[0];
        GridStf.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        //       if (e.Record["STFKOD"] == null | e.Record["STFKOD"] == "") StfKod = 0;
        //       else StfKod = Convert.ToInt32(e.Record["STFKOD"]);

        //     if (BoxDok.SelectedValue == null | BoxDok.SelectedValue == "") StfKod = 0;
        //     else StfKod = Convert.ToInt32(BoxDok.SelectedValue);

        if (e.Record["STFNUM"] == null | e.Record["STFNUM"] == "") StfNum = 0;
        else StfNum = Convert.ToInt32(e.Record["STFNUM"]);

        if (e.Record["STFMEM"] == null | e.Record["STFMEM"] == "") StfMem = "";
        else StfMem = Convert.ToString(e.Record["STFMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbStfAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@STFAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@STFKOD", SqlDbType.Int, 4).Value = 1; // StfKod;
        cmd.Parameters.Add("@STFMEM", SqlDbType.VarChar).Value = StfMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        StfIdn = Convert.ToInt32(e.Record["STFIDN"]);

        //        if (e.Record["STFKOD"] == null | e.Record["STFKOD"] == "") StfKod = 0;
        //        else StfKod = Convert.ToInt32(e.Record["STFKOD"]);

        //     if (BoxDok.SelectedValue == null | BoxDok.SelectedValue == "") StfKod = 0;
        //     else StfKod = Convert.ToInt32(BoxDok.SelectedValue);

        if (e.Record["STFNUM"] == null | e.Record["STFNUM"] == "") StfNum = 0;
        else StfNum = Convert.ToInt32(e.Record["STFNUM"]);

        if (e.Record["STFMEM"] == null | e.Record["STFMEM"] == "") StfMem = "";
        else StfMem = Convert.ToString(e.Record["STFMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbStfRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@STFIDN", SqlDbType.Int, 4).Value = StfIdn;
        cmd.Parameters.Add("@STFAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@STFKOD", SqlDbType.Int, 4).Value = 1; // StfKod;
        cmd.Parameters.Add("@STFMEM", SqlDbType.VarChar).Value = StfMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        StfIdn = Convert.ToInt32(e.Record["STFIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBSTF WHERE STFIDN=" + StfIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }


    //-------------------------- увеличение высоту полей описание и акции ----------------------------------------------
    protected void SuperForm1_DataBound(object sender, EventArgs e)
    {
        if (SuperForm1.CurrentMode == DetailsViewMode.Edit || SuperForm1.CurrentMode == DetailsViewMode.Insert)
        {
            OboutTextBox BoxOps = SuperForm1.GetFieldControl(0) as OboutTextBox;
            BoxOps.Height = Unit.Pixel(350);
            //            OboutTextBox BoxAkz = SuperForm1.GetFieldControl(2) as OboutTextBox;
            //            BoxAkz.Height = Unit.Pixel(100);
            //            OboutTextBox BoxIin = SuperForm1.GetFieldControl(3) as OboutTextBox;
            //            BoxIin.Height = Unit.Pixel(50);
        }
    }
    // ==================================== поиск клиента по фильтрам  ============================================


</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parDatMin" runat="server" />
        <asp:HiddenField ID="parDatMax" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="СПРАВКИ И СЕРТИФИКАТЫ"
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
            <obout:Grid ID="GridStf" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ClientSideEvents OnBeforeClientEdit="GridStf_ClientEdit"
                                  OnBeforeClientAdd="GridStf_ClientAdd" 
                                  ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column0" DataField="STFIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="STFNAM" HeaderText="Документ" Width="10%" Align="left" />
                    <obout:Column ID="Column2" DataField="STFNUM" HeaderText="Номер" Width="10%" ReadOnly="true" />
                    <obout:Column ID="Column3" DataField="STFMEM" Wrap="true" HeaderText="Примечание" Width="66%" />

                    <obout:Column ID="Column4" HeaderText="Коррек  Удаление" Width="7%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>	  
                                        
                    <obout:Column ID="Column5" DataField="STFFLG" HeaderText="Печать" Width="7%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplatePrt" />
				    </obout:Column>	

                </Columns>
   
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
                    
                       <obout:GridTemplate runat="server" ID="editBtnTemplate">
                          <Template>
                             <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridStf.edit_record(this)"/>
                             <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridStf.delete_record(this)"/>
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                          <Template>
                             <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridStf.update_record(this)"/> 
                             <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridStf.cancel_edit(this)"/> 
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridStf.addRecord()"/>
                        </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridStf.insertRecord()"/> 
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridStf.cancelNewRecord()"/> 
                        </Template>
                      </obout:GridTemplate>	

                    <obout:GridTemplate runat="server" ID="TemplatePrt">
                       <Template>
                          <input type="button" id="btnPrt" class="tdTextSmall" value="Печать" onclick="GridStf_prt(<%# Container.PageRecordIndex %>)"/>
 					</Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
        
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ 
                   <obout:ComboBox runat="server" ID="BoxDok" Width="100%" Height="40"
                   FolderStyle="/Styles/Combobox/Plain" EmptyText="Выберите документ...">
                   <Items>
                          <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="Справка" Value="1" />
                          <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="Рапорт" Value="2" />
                   </Items>
                   <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
            </obout:ComboBox>     
            --%>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    
     <owd:Window ID="WindowStf" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        RelativeElementID="WindowPositionHelper" Top="0" Left="300" Height="450" Width="650" VisibleOnLoad="false" StyleFolder="/Styles/Window/wdstyles/aura"
        Title="Справки">
            <input type="hidden" id="STFIDN" />
            <asp:TextBox ID="TextBox1"
                 Text="СПРАВКА"
                 BackColor="yellow"
                 Font-Names="Verdana"
                 Font-Size="24px"
                 Font-Bold="True"
                 ForeColor="Blue"
                 Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
                 runat="server"></asp:TextBox>

            <div class="super-form">
                <obout:SuperForm ID="SuperForm1" runat="server"
                    AutoGenerateRows="false"
                    AutoGenerateInsertButton ="false"
                    AutoGenerateEditButton="false"
                    AutoGenerateDeleteButton="false" 
                    FolderStyle="/Styles/SuperForm/plain"
                    InterfaceFolderStyle="/Styles/Interface/plain"
                    DataKeyNames="STFIDN" 
                    DefaultMode="Insert" 
                    OnDataBound="SuperForm1_DataBound"
                    Width="600" >
   
                    <EditRowStyle BackColor="#D5E2FF" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="#D5E2FF" ForeColor="Black" /> 
                                      
                    <Fields>
	                    <obout:MultiLineField DataField="STFMEM" HeaderText="Описание" FieldSetID="FieldSet1" ItemStyle-Height="200px" ControlStyle-Height="300px"/>
                 
                        <obout:TemplateField FieldSetID="FieldSet2">
                             <EditItemTemplate>
                                <obout:OboutButton ID="OboutButton3" runat="server" Text="Шаблон" OnClientClick="Sablon(); return false;" Width="120" FolderStyle="/Styles/Interface/plain/OboutButton" />
                                <obout:OboutButton ID="OboutButton1" runat="server" Text="Сохранить" OnClientClick="saveChanges(); return false;" Width="120" FolderStyle="/Styles/Interface/plain/OboutButton" />
                                <obout:OboutButton ID="OboutButton2" runat="server" Text="Отмена" OnClientClick="cancelChanges(); return false;" Width="100" FolderStyle="/Styles/Interface/plain/OboutButton" />
                            </EditItemTemplate>
                        </obout:TemplateField>
                     </Fields>
                  
                    <FieldSets>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet1"/>
                        </obout:FieldSetRow>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet2" ColumnSpan="1" CssClass="command-row" />
                        </obout:FieldSetRow>
                    </FieldSets>
                    
                    <CommandRowStyle Width="350" HorizontalAlign="Left" />
                </obout:SuperForm>
            </div>
    </owd:Window>  

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsDok" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



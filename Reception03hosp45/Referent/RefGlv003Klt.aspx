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
        
        var myconfirm = 0;

        // =============================== опрос до удаления клиента  ============================================
        function OnBeforeDelete(sender, record) {

            //                    alert("myconfirm=" + myconfirm);  
            if (myconfirm == 1) {
                return true;
            }
            else {
                /*
 if (confirm("Хотите удалить запись?") == true) {
     var retVal = prompt("Enter your name : ", "your name here");
     return true;
 }
 else alert("---");
 */
                document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                myConfirmBeforeDelete.Open();
                return false;
            }
        }

        function findIndex(record) {
            var index = -1;
            //            alert('1 index: ' + index);
            for (var i = 0; i < GridKlt.Rows.length; i++) {
                if (GridKlt.Rows[i].Cells[0].Value == record.KLTIDN) {
         //                                alert(record.KLTIDN);
                    index = i;
                    break;
                }
            }
            return index;
        }

        // =============================== удаления клиента после опроса  ============================================
        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridKlt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }
//======================================================================================================

        function GridKlt_ClientEdit(sender, record) {
            var GlvKltIdn = record.KLTIDN;
            var GlvKltIin = record.KLTIIN;
            var GlvCntIdn = record.CNTKLTIDN;

 //           alert("GlvKltIdn ="+GlvKltIdn);
 //           alert("GlvCntIdn ="+GlvCntIdn);

            KltOneWindow.setTitle(GlvKltIin);
            KltOneWindow.setUrl("RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn);
            KltOneWindow.Open();
            return false;
        }

        function GridKlt_ClientInsert(sender, record) {

            var GlvKltIdn = 0;
            var GlvCntIdn = 0;

            KltOneWindow.setTitle("Новая карта");
            KltOneWindow.setUrl("RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn);
            KltOneWindow.Open();

            return false;
        }

        function KltOneClose(KltFio) {
         //   alert("KofClose=1" + KltFio);
            document.getElementById('FndFio').value = KltFio;

            KltOneWindow.Close();
        }

        function OnClientSelect(sender, selectedRecords) {

            if (selectedRecords[0].KLTFIO.length == 0) {
                alert("Укажите ФИО");  
                return;
            }
            if (selectedRecords[0].KLTIIN.length == 0) {
                alert("Укажите ИИН");  
                return;
            }
            if (selectedRecords[0].KLTBRT.length == 0) {
                alert("Укажите день рождения");  
                return;
            }
            if (selectedRecords[0].KLTTEL.length < 10) {
                alert("Укажите телефон");  
                return;
            }
            if (selectedRecords[0].KLTSTX.length == 0) {
                alert("Укажите вид страхования");  
                return;
            }
            var GrfFio = selectedRecords[0].CNTKLTIDN+"&"+selectedRecords[0].KLTFIO+"&"+selectedRecords[0].KLTIIN+"&"+
                         selectedRecords[0].KLTBRT.substring(0,10) +"&"+selectedRecords[0].KLTTEL+"&"+" "+"&"+
                         selectedRecords[0].DSP+"&"+selectedRecords[0].KLTSTX+"&"+selectedRecords[0].CNTKLTKRTEND.substring(0,8)+"&"+selectedRecords[0].KLTINV;
            localStorage.setItem("FndFio", GrfFio); //setter
          //           alert("GrfFio=" + GrfFio); 
            //       window.opener.HandlePopupResult(GrfFio);
            //  self.close();
  
            window.parent.KltClose(GrfFio);
        }

// ===============================================================================================================================================================
        function GridKlt_prg(rowIndex) {
            var PrgCntIdn;
            var PrgCntKey;
            var PrgFio;
 //           alert("GridLab_rsx="+rowIndex);

            PrgCntIdn= GridKlt.Rows[rowIndex].Cells[1].Value;
//            alert("GridLab_rsx=1");
            PrgCntKey= GridKlt.Rows[rowIndex].Cells[1].Value;
 //           alert("GridLab_rsx=2");
            PrgFio= GridKlt.Rows[rowIndex].Cells[2].Value;
   //         alert("GridLab_rsx=3");

            InsWindow.setTitle(PrgFio);
            InsWindow.setUrl("/Spravki/SprCntKltGrdPrg.aspx?GlvCntIdn=" + PrgCntIdn); // + "&GlvKltKey=" + PrgKltKey);
            InsWindow.Open();               

            return true;
        }



    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";
    string Cond = "";

    string MdbNam = "HOSPBASE";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
 //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session["AmbCrdIdn"] = "0";


        //=====================================================================================
 
        GridKlt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridKlt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridKlt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            FndFio.Text = Convert.ToString(Request.QueryString["TextBoxFio"]);
            KltOneWindow.Url = "";

 //           string Cond = "";
            
            if (FndFio.Text != "")
            {
                Cond = FndFio.Text.Replace("*", "%");
//                Cond = Cond.Replace(" ", "%") + "%";
                Cond = Cond + "%";


                if (FndFio.Text.IndexOf("SELECT") != -1) return;
                if (FndFio.Text.IndexOf("UPDATE") != -1) return;
                if (FndFio.Text.IndexOf("DELETE") != -1) return;

                CondHid.Value = Cond;
                getGrid(Cond);
            }

        }

    }

    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
//        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
//        getGrid();
    }
    
    void RebindGrid(object sender, EventArgs e)
    {
 //       getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        int KltIdn = Convert.ToInt32(e.Record["KLTIDN"]);
        string ResUlt="";

  //      ConfirmOK.Visible = true;
 //       ConfirmOK.VisibleOnLoad = true; 


        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprKltDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KLTIDN", SqlDbType.VarChar).Value = KltIdn;
        cmd.Parameters.Add("@RESULT", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters["@RESULT"].Direction = ParameterDirection.Output;
        con.Open();
        try
        {
            int numAff = cmd.ExecuteNonQuery();

            ResUlt = Convert.ToString(cmd.Parameters["@RESULT"].Value);
        }
        finally
        {
            con.Close();
        }

        if (ResUlt == "0")
        {
 //           ConfirmOK.Visible = true;
 //           ConfirmOK.VisibleOnLoad = true;
            // ------------------------------------------------------------------------------заполняем второй уровень
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "Alert('Удалять нельзя!');", true);

        }
        
            Cond = CondHid.Value;
            getGrid(Cond);

    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
    protected void FndBtn_Click(object sender, EventArgs e)
    {
        KltOneWindow.Url = "";
        
 //       string Cond = "";
        
        if (FndFio.Text != "")
        {
            Cond = FndFio.Text.Replace("*", "%");
//            Cond = Cond.Replace(" ", "%") + "%";
            Cond = Cond + "%";

            if (FndFio.Text.IndexOf("SELECT") != -1) return;
            if (FndFio.Text.IndexOf("UPDATE") != -1) return;
            if (FndFio.Text.IndexOf("DELETE") != -1) return;

            CondHid.Value = Cond;
          
            getGrid(Cond);
       }

   }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid(string Cond)
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspRefGlf003Klt", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@FNDFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@FNDFIO", SqlDbType.VarChar).Value = Cond;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlf003Klt");

        con.Close();

        GridKlt.DataSource = ds;
        GridKlt.DataBind();
    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
             <asp:HiddenField ID="CondHid" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 540px;">
            <%-- ============================  шапка экрана ============================================ --%>
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="5%" class="PO_RowCap" align="left">Ф.И.О.:</td>
                            <td width="20%">
                                <asp:TextBox ID="FndFio" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>

                            <td width="5%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                  </table>

            <obout:Grid ID="GridKlt" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                KeepSelectedRecords="true"
                AllowSorting="true"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                AutoPostBackOnSelect="false"
                OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="450" ScrollWidth="100%" />
                <ClientSideEvents 
		                                OnBeforeClientEdit="GridKlt_ClientEdit" 
		                                OnBeforeClientAdd="GridKlt_ClientInsert"
                                        OnBeforeClientDelete="OnBeforeDelete"
                                        OnClientSelect="OnClientSelect"
		                                ExposeSender="true"/>
                 <Columns>
                    <obout:Column ID="Column00" DataField="KLTIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column01" DataField="CNTKLTIDN" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="KLTFIO" HeaderText="Фамилия" Width="20%" />
                    <obout:Column ID="Column03" DataField="KLTBRT" HeaderText="Дата.р" DataFormatString="{0:yyyy}" Width="5%" />
                    <obout:Column ID="Column04" DataField="KLTUCH" HeaderText="Участок" Width="5%" />
                    <obout:Column ID="Column05" DataField="KLTINV" HeaderText="Инв" Width="5%" Align="right" />
                    <obout:Column ID="Column06" DataField="KLTTEL" HeaderText="Телефон" Width="13%" />
                    <obout:Column ID="Column07" DataField="KLTIIN" HeaderText="ИИН" Width="10%" />
                    <obout:Column ID="Column08" DataField="KLTSTX" HeaderText="Страх" Width="9%" />
                    <obout:Column ID="Column09" DataField="CNTKLTSUM" HeaderText="Сумма" Width="7%" />
                    <obout:Column ID="Column10" DataField="CNTKLTKRTEND" DataFormatString="{0:dd/MM/yy}" HeaderText="Конец" Width="5%" />
                    <obout:Column ID="Column11" DataField="UBL" HeaderText="Удл" Width="4%" />
                    <obout:Column ID="Column12" DataField="DSP" HeaderText="Дсп" Width="4%" />
                   
                    <obout:Column ID="Column13" HeaderText="Кор Удл" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	  
                              
                    <obout:Column ID="Column14" DataField="FLG" HeaderText="Прог" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplatePrg" />
				    </obout:Column>				
              </Columns>
 		    	
               <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>	
               	<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                       <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridKlt.edit_record(this)"/>
                       <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridKlt.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridKlt.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridKlt.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridKlt.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridKlt.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridKlt.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
          
                  <obout:GridTemplate runat="server" ID="TemplatePrg">
                      <Template>
                         <input type="button" id="btnRsx" class="tdTextSmall" value="Прг" onclick="GridKlt_prg(<%# Container.PageRecordIndex %>)"/>
 					  </Template>
                 </obout:GridTemplate>                  			

                </Templates>
            </obout:Grid>
        </asp:Panel>

        <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltOneWindow" runat="server" Url="RefGlv003KltOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="40" Top="0" Height="575" Width="1100" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <owd:Window ID="InsWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="0" Height="550" Width="1100" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
        </owd:Window>
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
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
                                <input type="button" value="Назад" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>

<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>

    <%-- ============================  STYLES ============================================ --%>

<%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

     ------------------------------------- для удаления отступов в GRID --------------------------------%>
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



            a.pg
            {
                font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
            }

            a.pg:hover {
                color: crimson;
            }
    </style>

</body>
</html>



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
<%@ Import Namespace="System.Collections.Generic" %>

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
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
/* 
         window.onload = function () {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
             mySpl.loadPage("BottomContent", "DocAppAnlLst.aspx?AmbCrdIdn=" + AmbCrdIdn);
         };
*/
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

         function TstButton_Click() {
             alert("TstButton");
   //          alert(ob_spl_isElementInsideSplitter(document.getElementById('ctl00$MainContent$Sapka')));
             //           alert(ob_spl_isElementInsideSplitterContainer(document.getElementById('ctl00$MainContent$loginDialog$txtOrgNam').value));
   //          alert(ob_spl_isElementInsideSplitterContainer(document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam')).value);
             //     alert(ob_spl_elementGetPosition(document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam')));
   //          alert(mySpl.GetWindow("RightContent").document.getElementById('ctl00$MainContent$Sapka'));
  //           alert(Webbrowser1.Document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam').SetAttribute(value));
         }

         function GridAnl_Edit(sender, record) {
             //          alert("GridAnl_Edit=");

             //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
             TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
             TemplateGrpKey.value(record.STRUSLKEY);
             TemplateGrpKey._preventDetailLoading = false;
             TemplateGrpKey._populateDetail();

             return true;
         }

         function GridAnl_rsx(rowIndex) {
             alert("GridAnl_rsx=");
             var AmbUslIdn = GridAnl.Rows[rowIndex].Cells[0].Value;

             RsxWindow.setTitle(AmbUslIdn);
             RsxWindow.setUrl("DocAppAmbUslRsx.aspx?AmbUslIdn=" + AmbUslIdn);
             RsxWindow.Open();
             return true;
         }

                
         function GridAnl_ClientEdit(sender, record) {
             //           alert("GridAnl_ClientEdit");
             var AmbAnlIdn = record.USLIDN;
             AnlWindow.setTitle(AmbAnlIdn);
             AnlWindow.setUrl("DocAppAnlOne.aspx?AmbUslIdn=" + AmbAnlIdn);
             AnlWindow.Open();
             
             return false;
         }

         function GridAnl_ClientInsert(sender, record) {
             //          alert("GridAnl_ClientInsert");
             var AmbAnlIdn = 0;
             AnlWindow.setTitle(AmbAnlIdn);
             AnlWindow.setUrl("DocAppAnlOne.aspx?AmbUslIdn=" + AmbAnlIdn);
             AnlWindow.Open();

             return false;
         }

         function WindowClose() {
             //           alert("GridNazClose");
             var jsVar = "dotnetcurry.com";
             __doPostBack('callPostBack', jsVar);
         }

         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
  </script>

</head>



<script runat="server">

        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        
        int AnlIdn;
        int AnlAmb;
        int AnlKod;
        int AnlKol;
        int AnlSum;
        int AnlKto;
        int AnlLgt;
        string AnlMem;



        int NumDoc;
//        string TxtDoc;

//        DateTime GlvBegDat;
//        DateTime GlvEndDat;

        string AmbCrdIdn;
        string AmbCntIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
            //           TxtDoc = (string)Request.QueryString["TxtSpr"];
  //          Session.Add("AmbCrdIdn", AmbCrdIdn);
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];
            //=====================================================================================
 //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

            GridAnl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridAnl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

            string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
            string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
            if (par02 != null && !par02.Equals("") && AmbCrdIdn == "0")
            {
                Session["AmbUslIdn"] = "Post";
                AmbCrdIdn = parCrdIdn.Value;
            }
            //============= начало  ===========================================================================================
            
            if (!Page.IsPostBack)
            {

 //               GlvBegDat = (DateTime)Session["GlvBegDat"];
 //               GlvEndDat = (DateTime)Session["GlvEndDat"];
                //============= Установки ===========================================================================================
                if (AmbCrdIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "АНЛ";
                    cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = AmbCntIdn;
                    cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
                        parCrdIdn.Value = AmbCrdIdn;
                    }
                    finally
                    {
                        con.Close();
                    }
                }

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
                HidAmbCrdIdn.Value = AmbCrdIdn;
            }

   //             getDocNum();

                getGrid();


            //=====================================================================================
/*
            if (!Page.IsPostBack)
            {

                getGrid();
            }
*/

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
            SqlCommand cmd = new SqlCommand("HspAmbUslStxIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbUslStxIdn");

            con.Close();

            GridAnl.DataSource = ds;
            GridAnl.DataBind();
        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
        }

        // ============================ кнопка новый документ  ==============================================

        protected void AddButton_Click(object sender, EventArgs e)
        {
            //            localhost.Service1SoapClient ws = new localhost.Service1SoapClient();
            //            ws.ComDocAdd(BuxBas, BuxSid, GlvDocTyp);

            //           GlvDocIdn= Convert.ToInt32(ds.Tables[0].Rows[0]["GLVDOCIDN"]);
            //  передача через SESSION не работает
            //            Session.Add("CounterTxt", (string)"0");
            //  передача через ViewState не работает
            //            ViewState["CounterTxt"] = "0";

        }

        protected void CanButton_Click(object sender, EventArgs e)
        {
          Response.Redirect("~/GoBack/GoBack1.aspx");
          //  Response.Redirect("~/GlavMenu.aspx");

        }

        // ============================ чтение заголовка таблицы а оп ==============================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            getGrid();
        }

        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            AnlIdn = Convert.ToInt32(e.Record["USLIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmdDtl = new SqlCommand("DELETE FROM AMBUSLDTL WHERE USLDTLREF=" + AnlIdn, con);
            cmdDtl.ExecuteNonQuery();
            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE USLIDN=" + AnlIdn, con);
            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();
        }


        protected void PrtButton_Click(object sender, EventArgs e)
        {

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslBlnNum", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@NAZAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
            cmd.Parameters.Add("@NAZBUX", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@NAZTYPBLN", SqlDbType.Int, 4).Value = 4;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();

        }

        // ======================================================================================
</script>


<body>

    <form id="form1" runat="server">

      <asp:HiddenField ID="parCrdIdn" runat="server" />
      <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">

 <asp:TextBox ID="Sapka" 
             Text="СКАНИРОВАННЫЕ ДОКУМЕНТЫ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 400px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridAnl" runat="server"
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
                OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="460" />
                <ClientSideEvents 
		                                OnBeforeClientEdit="GridAnl_ClientEdit" 
		                                OnBeforeClientAdd="GridAnl_ClientInsert"
		                                ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="USLNUM" HeaderText="Номер" Width="5%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column3" DataField="USLKAS" HeaderText="№ КАСС" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="USLNAP" HeaderText="№ НАПР" Width="5%" />
                    <obout:Column ID="Column5" DataField="StxNam" HeaderText="ВИД ОПЛ" Width="5%" />
                    <obout:Column ID="Column6" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="35%" Align="left" />
                    <obout:Column ID="Column7" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="5%" />

                    <obout:Column ID="Column8" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column9" DataField="USLKTO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>
                    
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                    
                    <obout:Column ID="Column10" DataField="RSXFLG" HeaderText="РАСХОД" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateRsx" />
				    </obout:Column>				

                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>								
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridAnl.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridAnl.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridAnl.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridAnl.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridAnl.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridAnl.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridAnl.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
                   			
                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                       <Template>
                          <input type="button" id="btnRsx" class="tdTextSmall" value="Расход" onclick="GridAnl_rsx(<%# Container.PageRecordIndex %>)"/>
 					</Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateKtoNam">
                        <Template>
                            <%# Container.DataItem["FI"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKtoNam" ControlID="ddlKtoNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKtoNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKto" CssClass="ob_gEC" DataTextField="FI" DataValueField="BuxKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
 
       </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
                 <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
             </center>
             

  </asp:Panel>              
     
<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="RsxWindow" runat="server"  Url="DocAppAmbUslRsx.aspx" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
                    Left="300" Top="200" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
                    StyleFolder="~/Styles/Window/wdstyles/blue"
                    Title="График приема врача">



        </owd:Window>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="200" Top="0" Height="420" Width="1000" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>


    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
      </form>
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


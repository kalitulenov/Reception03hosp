<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

<%-- ============================  JAVA ============================================ --%>

     <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        var myconfirm = 0;

        function OnClientSelect(sender, selectedRecords) {
            var AmbBolIdn = selectedRecords[0].BOLIDN;
            var AmbCrdIdn = selectedRecords[0].BOLAMB;

           //       alert('AmbBolIdn=' + AmbBolIdn);
            //      alert('AmbCrdIdn=' + AmbCrdIdn);

            BolWindow.setTitle(AmbBolIdn);
            BolWindow.setUrl("/Priem/DocAppAmbBolOne.aspx?AmbBolIdn=" + AmbBolIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbRej=X");
            BolWindow.Open();
        }

        function OnBeforeDelete(sender, record) {
            if (confirm("Хотите удалить бол.лист № " + record.BOLNUM007 + "?") == false) {

                return false;
            }

            var Id = record.BOLIDN;
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/BuxBolLstOneDel',
                contentType: "application/json; charset=utf-8",
                data: '{"Id":"' + Id + '"}',
                dataType: "json",
                success: function (msg) {
                },
                error: function () { }
            });

            document.getElementById("MainContent_PushButton").click();

            return false;
        }

        function onBeforeClientEdit(sender,record) {
            if (confirm("Хотите очистит бол.лист № " + record.BOLNUM007 + "?") == false) {
                
                return false;
            }

            var Id =  record.BOLIDN;
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/BuxBolLstOneClr',
                contentType: "application/json; charset=utf-8",
                data: '{"Id":"' + Id + '"}',
                dataType: "json",
                success: function (msg) {
                },
                error: function () { }
            });

            document.getElementById("MainContent_PushButton").click();

            return false;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {

            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfBeg = document.getElementById('MainContent_txtDate1').value;
            var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocBolLst&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocBolLst&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

        }


        </script>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">

        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int AmbCrdIdn;
        //   string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //  GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            //   parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //    TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
            //      Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================


            GridBol.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridBol.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridBol.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            if (!Page.IsPostBack)
            {
                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();


                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                getGrid();
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbBolLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = "ALL";
            cmd.Parameters.Add("@BOLTYP", SqlDbType.VarChar).Value = "БОЛ";
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = txtDate1.Text;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = txtDate2.Text;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbBolLst");

            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            GridBol.DataSource = ds;
            GridBol.DataBind();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbBolLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = "DAT";
            cmd.Parameters.Add("@BOLTYP", SqlDbType.VarChar).Value = "БОЛ";
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = txtDate1.Text;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = txtDate2.Text;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbBolLst");

            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            GridBol.DataSource = ds;
            GridBol.DataBind();
        }

        protected void FreButton_Click(object sender, EventArgs e)
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbBolLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = "FRE";
            cmd.Parameters.Add("@BOLTYP", SqlDbType.VarChar).Value = "БОЛ";
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = txtDate1.Text;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = txtDate2.Text;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbBolLst");

            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            GridBol.DataSource = ds;
            GridBol.DataBind();
        }

        protected void AllButton_Click(object sender, EventArgs e)
        {
            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            string BolIdn;
            BolIdn = Convert.ToString(e.Record["BOLIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            //  SqlCommand cmd = new SqlCommand("DELETE FROM AMBBOL WHERE BOLIDN=" + BolIdn, con);
            //SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLPTH=NULL,BOLBRT=NULL,BOLADR=NULL,BOLRAB=NULL,BOLDIG=NULL," +
            //                          "BOLAMB=NULL,BOLIIN=NULL,BOLSTX=NULL,BOLBUX=NULL,BOLEXTFLG=NULL," +
            //                          "BOLDOC000=NULL,BOLBEG000=NULL,BOLEND000=NULL,BOLDOC001=NULL,BOLEND001=NULL," +
            //                                "BOLDOC002=NULL,BOLEND002=NULL,BOLDOC003=NULL,BOLEND003=NULL," +
            //                             "BOLDOC009=NULL,BOLEND009=NULL " +
            //                             "WHERE BOLIDN=" + BolIdn, con);
            SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLMEM='DELETE' WHERE BOLIDN=" + BolIdn, con);
            // указать тип команды
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            int NumBln;

            if (Convert.ToString(e.Record["BOLNUM007"]) == null || Convert.ToString(e.Record["BOLNUM007"]) == "") NumBln = 0;
            else NumBln = Convert.ToInt32(e.Record["BOLNUM007"]);


            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspAmbBolLstAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int,4).Value = BuxFrm;
            cmd.Parameters.Add("@BOLNUM", SqlDbType.Int,4).Value = NumBln;
            // Выполнить команду
            con.Open();
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //      ws.ComSprBuxAdd(MdbNam, BuxSid, BuxFrm, BuxTab, BuxDlg, BuxLog, BuxPsw);
            getGrid();

        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            string BolIdn;
            BolIdn = Convert.ToString(e.Record["BOLIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            //   SqlCommand cmd = new SqlCommand("DELETE FROM AMBBOL WHERE BOLIDN=" + BolIdn, con);
            //SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLPTH=NULL,BOLBRT=NULL,BOLADR=NULL,BOLRAB=NULL,BOLDIG=NULL," +
            //                          "BOLAMB=NULL,BOLIIN=NULL,BOLSTX=NULL,BOLBUX=NULL,BOLEXTFLG=NULL," +
            //                          "BOLDOC000=NULL,BOLBEG000=NULL,BOLEND000=NULL,BOLDOC001=NULL,BOLEND001=NULL," +
            //                                "BOLDOC002=NULL,BOLEND002=NULL,BOLDOC003=NULL,BOLEND003=NULL," +
            //                             "BOLDOC009=NULL,BOLEND009=NULL " +
            //                             "WHERE BOLIDN=" + BolIdn, con);
            SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLMEM='TEST' WHERE BOLIDN=" + BolIdn, con);
            // указать тип команды
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();
        }

        // ---------Суммация  ------------------------------------------------------------------------
        // ============================ дублировать амб.карту ==============================================

        // ======================================================================================

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parCrdIdn" runat="server" />
 <asp:HiddenField ID="parUpd" runat="server" />
   
 
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>
             <asp:Label ID="Label1" runat="server" Text="Период" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="За период" onclick="PushButton_Click"/>
             <asp:Button ID="AllButton" runat="server" CommandName="Push" Text="Все БЛ" onclick="AllButton_Click"/>
             <asp:Button ID="FreButton" runat="server" CommandName="Push" Text="Свободные" onclick="FreButton_Click"/>
         </center>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridBol" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
  AllowRecordSelection = "true"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "100"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
              FilterType="ProgrammaticOnly"     
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="370" />
                 <ClientSideEvents 
                     ExposeSender="true" 
                     OnClientSelect="OnClientSelect" 
                     OnBeforeClientDelete="OnBeforeDelete" 
                     OnBeforeClientEdit="onBeforeClientEdit" />
                <Columns>
                    <obout:Column ID="Column00" DataField="BOLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="BOLAMB" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="BOLNUM007" HeaderText="№ Б\Л" Width="6%" />
                    <obout:Column ID="Column03" DataField="BOLPTH" HeaderText="ФАМИЛИЯ И.О." Width="11%" ReadOnly="true" />
                    <obout:Column ID="Column04" DataField="BOLBRT" HeaderText="ДАТА/Р" Width="6%" ReadOnly="true" />
                    <obout:Column ID="Column05" DataField="BOLADR" HeaderText="АДРЕС" Width="18%" ReadOnly="true" />
                    <obout:Column ID="Column06" DataField="BOLRAB" HeaderText="РАБОТА" Width="10%" ReadOnly="true" />
                    <obout:Column ID="Column07" DataField="DOCBUX" HeaderText="ВРАЧ ЗАПИСАЛ" Width="8%" ReadOnly="true" />
                    <obout:Column ID="Column08" DataField="DOC000" HeaderText="ВРАЧ ОТКРЫЛ" Width="8%" ReadOnly="true" />
                    <obout:Column ID="Column09" DataField="DOC009" HeaderText="ВРАЧ ЗАКРЫЛ" Width="8%" ReadOnly="true" />
                    <obout:Column ID="Column10" DataField="BOLBEG000" HeaderText="ДАТА ОТКРЫТИЕ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" ReadOnly="true" />
                    <obout:Column ID="Column11" DataField="BOLEND009" HeaderText="ДАТА ЗАКРЫТИЕ" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" ReadOnly="true" />
                    <obout:Column ID="Column12" DataField="BOLDNI" HeaderText="ДНЕЙ" Width="5%" ReadOnly="true" />

                    <obout:Column HeaderText="ОЧИСТИТЬ" Width="8%" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	 
                    
		        </Columns>

               <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
             
               <Templates>
            	<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Оч." onclick="GridBol.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridBol.delete_record(this)"/>
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


  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <input type="button" name="PrtButton" value="Печать журнала БЛ" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel> 
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
     
<%-- =================  для удаление документа ============================================ --%>
     
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   --%>
       <owd:Window ID="BolWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="200" Height="430" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Назначения">

       </owd:Window>

        
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">

        /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
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
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

        /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
			}
			a.pg:hover {
				color:crimson;
			}

    </style>
 
</asp:Content>

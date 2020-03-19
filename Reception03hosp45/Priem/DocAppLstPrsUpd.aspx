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
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
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

 <script type="text/javascript">
     var myconfirm = 0;
//     myDialogDubl.visible = false;

     // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
     // при ExposeSender = "true" OnBeforeDelete(sender,record)

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'GRFPTH';
           GridPrs.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridPrs.executeFilter();
         }
         else {
             GridPrs.removeFilter();
         }
     }

     function GridPrsPic(rowIndex) {
    //     alert('GridKas_dbl='+rowIndex);
  //       var AmbCrdIdn000 = GridPrs.Rows[rowIndex].Cells[0].Value;

  //       document.getElementById('MainContent_parCrdIdn').value=AmbCrdIdn000;
    //     document.getElementById('MainContent_parDbl').value="DBL";
         //    myDialogDubl.Open();

         var AmbAnlIdn = GridPrs.Rows[rowIndex].Cells[0].Value;
         var AmbAnlPth = GridPrs.Rows[rowIndex].Cells[4].Value;
 //        ---------------------------------------------------
   //      alert("AmbAnlIdn="+AmbAnlIdn);          
         AnlWindow.setTitle(AmbAnlPth);
         AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslPth=" + AmbAnlPth);
         AnlWindow.Open();
         return false;
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
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
                //=====================================================================================
                BuxFrm = (string)Session["BuxFrmKod"];
                HidBuxFrm.Value = BuxFrm;

                BuxKod = (string)Session["BuxKod"];
                HidBuxKod.Value = BuxKod;

                BuxSid = (string)Session["BuxSid"];
                sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
                sdsOrg.SelectCommand = "SELECT ORGKOD,ORGNAMSHR FROM SPRORG WHERE ORGFRM=" + BuxFrm + " ORDER BY ORGNAMSHR";

                GridPrs.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //============= начало  ===========================================================================================

            if (GridPrs.IsCallback)
                {
                    Session["pgSize"] = GridPrs.CurrentPageIndex;
                }


            // ViewState
                // ViewState["text"] = "Artem Shkolovy";
                // string Value = (string)ViewState["name"];
  //              GridPrs.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //               GridPrs.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

                if (!Page.IsPostBack)
                {
                    if (Session["pgSize"] != null)
                    {
                        GridPrs.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
                    }

                    string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                    rptAlphabet.DataSource = alphabet;
                    rptAlphabet.DataBind();

                    getGrid();

                    GlvBegDat = (DateTime)Session["GlvBegDat"];
                    GlvEndDat = (DateTime)Session["GlvEndDat"];

                    txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                    txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
                }
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocAppLstPrsUpd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocAppLstPrsUpd");

            con.Close();
            /*
            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    GridPrs.DataSource = ds;
                    GridPrs.DataBind();
                }
            }
            catch
            {
            }
            */
            GridPrs.DataSource = ds;
            GridPrs.DataBind();
        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);


            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            // ============================ посуммировать  ==============================================

            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

// ============================ кнопка новый документ  ==============================================
        
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int PrsOrg;
            int PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);

            if (e.Record["ORGKOD"] == null | e.Record["ORGKOD"] == "") PrsOrg = 0;
            else PrsOrg = Convert.ToInt32(e.Record["ORGKOD"]);

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("UPDATE AMBPRS SET PRSUSLGDE=" + PrsOrg + " WHERE PRSIDN=" + PrsIdn, con);
            // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
        //    cmd.Parameters.Add("@PRSIDN", SqlDbType.Int, 4).Value = PrsIdn;
        //    cmd.Parameters.Add("@PRSMEM", SqlDbType.VarChar).Value = PrsMem;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

        // ======================================================================================


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
 <asp:HiddenField ID="parDbl" runat="server" />
   
 
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
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>


 <%-- ============================  OnClientDblClick  ============================================ 
      <ClientSideEvents ExposeSender="true"
                        OnClientDblClick="OnClientDblClick"
     --%>

 <%-- ============================  OnClientSelect  ============================================ 
       AllowRecordSelection = "true"
      <ClientSideEvents ExposeSender="false"
                          OnClientSelect="OnClientSelect"
     --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridPrs" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "100"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
               <Columns>
	        	    <obout:Column ID="Column00" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="PRSNUM" HeaderText="№ НАПР" ReadOnly="true" Width="3%" />
	                <obout:Column ID="Column02" DataField="GRFDAT" HeaderText="ДАТА" ReadOnly="true" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column03" DataField="GRFIIN" HeaderText="ИИН" ReadOnly="true" Width="8%" />
	                <obout:Column ID="Column04" DataField="GRFPTH" HeaderText="ФИО" ReadOnly="true" Width="19%" />
	                <obout:Column ID="Column05" DataField="USLTRF" HeaderText="КОД" ReadOnly="true" Width="7%" />
	                <obout:Column ID="Column06" DataField="USLNAM" HeaderText="УСЛУГА" ReadOnly="true" Width="32%" />
 	                <obout:Column ID="Column07" DataField="FI" HeaderText="ВРАЧ" ReadOnly="true" Width="9%" />
                    <obout:Column ID="Column08" DataField="ORGKOD" HeaderText="ГДЕ УСЛУГА" Width="7%">
                        <TemplateSettings TemplateId="TemplateOrgNam" EditTemplateId="TemplateEditOrgNam" />
                    </obout:Column>
                    <obout:Column ID="Column09" DataField="" HeaderText="КОРР" Width="5%" AllowEdit="true" AllowDelete="false" />
                   
                     <obout:Column ID="Column10" DataField="" HeaderText="ОБРАЗ" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateImg" />
				    </obout:Column>	
                </Columns>

                <Templates>
 
                    <obout:GridTemplate runat="server" ID="TemplateOrgNam">
                        <Template>
                            <%# Container.DataItem["ORGNAMSHR"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditOrgNam" ControlID="ddlOrgNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlOrgNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsOrg" CssClass="ob_gEC" DataTextField="ORGNAMSHR" DataValueField="ORGKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateImg">
                       <Template>
                          <input type="button" id="btnDbl" class="tdTextSmall" value="Образ" onclick="GridPrsPic(<%# Container.PageRecordIndex %>)"/>
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
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 
    
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
     
<%-- =================  для удаление документа ============================================ --%>

        <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="10" Top="10" Height="660" Width="1250" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource runat="server" ID="sdsOrg"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  
</asp:Content>

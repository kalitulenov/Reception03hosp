<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

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

     // Client-Side Events for Delete
     // при ExposeSender = "false" OnBeforeDelete(record)
     // при ExposeSender = "true" OnBeforeDelete(sender,record)
     function OnBeforeDelete(sender,record) {
 //         alert("OnBeforeDelete");
              if (myconfirm == 1) {
                  return true;
              }
              else {
                  document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить скрининг?";
                  document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                  myConfirmBeforeDelete.Open();
                  return false;
              }
     }

     function findIndex(record) 
     {
         var index = -1;
         for (var i = 0; i < GridKlt.Rows.length; i++) {
             if (GridKlt.Rows[i].Cells[1].Value == record.SCRIIN) 
             {
                 index = i;
                 break;
             }
         }
         return index;
     }

     function ConfirmBeforeDeleteOnClick() 
     {
         myconfirm = 1;
 //        alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         GridKlt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function OnClientSelect(sender, selectedRecords) {
         //      alert(document.getElementById('MainContent_parDbl').value);

         var ScrIIN = selectedRecords[0].SCRIIN;
    //           alert("ScrIIN=" + ScrIIN);

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
            window.open("/AIS/DocAisScrLstDocOne.aspx?KltIIN=" + ScrIIN, "ModalPopUp", "toolbar=no,width=1300,height=670,left=50,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/AIS/DocAisScrLstDocOne.aspx?KltIIN=" + ScrIIN, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:100px;dialogWidth:1300px;dialogHeight:670px;");
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'KLTFIO';
           GridKlt.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridKlt.executeFilter();
         }
         else {
             GridKlt.removeFilter();
         }
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

        int ScrIIN;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //     GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            //     parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //     TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
            //     Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================

            if (GridKlt.IsCallback)
            {
                Session["pgSize"] = GridKlt.CurrentPageIndex;
            }

            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridKlt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //               GridKlt.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

            if (!Page.IsPostBack)
            {
                if (Session["pgSize"] != null)
                {
                    GridKlt.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
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
            string TekDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            // =====================================================================================
            sdsUch.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsUch.SelectCommand = "SELECT KLTUCH FROM SPRKLT WHERE KLTFRM=" + BuxFrm + " GROUP BY KLTUCH ORDER BY KLTUCH";
            //=====================================================================================

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAisScrLstDoc", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BoxUch.SelectedText;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAisScrLstDoc");

            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //          Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]);
                }
            }
            catch
            {
            }



            con.Close();

            GridKlt.DataSource = ds;
            GridKlt.DataBind();

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

            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GlavMenu.aspx");
        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            string ScrIIN;
            ScrIIN = Convert.ToString(e.Record["SCRIIN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspAisScrLstDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXIIN", SqlDbType.VarChar).Value = ScrIIN;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

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
             Text="СКРИНИНГ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 5%; position: relative; width: 90%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
       
             <asp:Label id="Label2" Text="Участок:" runat="server"  Width="5%" Font-Bold="true" />                             
             <obout:ComboBox runat="server" ID="BoxUch" Width="20%" Height="150"
                    FolderStyle="/Styles/Combobox/Plain"
                    DataSourceID="sdsUch" DataTextField="KLTUCH" DataValueField="KLTUCH">
             </obout:ComboBox>

             <asp:Label ID="Label1" runat="server" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Период" ></asp:Label>  
             
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
           

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridKlt" runat="server" 
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
	            <ClientSideEvents ExposeSender="true" 
                          OnClientSelect="OnClientSelect"
	                      OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	                <obout:Column ID="Column0A" DataField="UCH" HeaderText="УЧАС" Width="4%" />
	        	    <obout:Column ID="Column00" DataField="SCRIIN" HeaderText="ИИН" Width="8%"/>
	                <obout:Column ID="Column01" DataField="KLTFIO" HeaderText="ФИО" Width="20%" />
	                <obout:Column ID="Column02" DataField="SCRSEX" HeaderText="ПОЛ" Width="4%" Align="center" />
	                <obout:Column ID="Column03" DataField="SCRLET" HeaderText="ВОЗРАСТ" Width="5%" Align="center" />
	                <obout:Column ID="Column04" DataField="БСК" HeaderText="БСК" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap000" />
				    </obout:Column>				
	                <obout:Column ID="Column05" DataField="глаз_давления" HeaderText="Глаукома" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap001" />
				    </obout:Column>				
	                <obout:Column ID="Column06" DataField="холестерин" HeaderText="Сах.диабет" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap002" />
				    </obout:Column>				
		
	                <obout:Column ID="Column08" DataField="цитология" HeaderText="РШМ" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap004" />
				    </obout:Column>				
	                <obout:Column ID="Column09" DataField="мамография" HeaderText="РМЖ" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap005" />
				    </obout:Column>				
	                <obout:Column ID="Column10" DataField="кала_на_кровь" HeaderText="Кал на кровь" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap006" />
				    </obout:Column>				
	                <obout:Column ID="Column11" DataField="ФГДС" HeaderText="РПЖ" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap007" />
				    </obout:Column>				
	                <obout:Column ID="Column13" DataField="ПСА" HeaderText="ПСА" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap009" />
				    </obout:Column>				
	                <obout:Column ID="Column07" DataField="ОАК" HeaderText="PROF" Width="4%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap003" />
				    </obout:Column>		
                    <obout:Column ID="Column14" DataField="SCRRESBEG" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column15" DataField="SCRINPTIM" HeaderText="В АИС"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column16" DataField="SCRRESDOC" HeaderText="ВРАЧ" Width="10%" />
		            <obout:Column ID="Column17" DataField="" HeaderText="КОРР" Width="3%" AllowEdit="false" AllowDelete="true" runat="server" />
		        </Columns>
                <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateSap000">
                      <Template>
                          БСК<br />Z13.6
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap001">
                      <Template>
                          Глаук<br />Z13.5
                      </Template>
                    </obout:GridTemplate>  

                    <obout:GridTemplate runat="server" ID="TemplateSap002">
                      <Template>
                           Диабет<br />Z13.1
                      </Template>
                    </obout:GridTemplate>   

                    <obout:GridTemplate runat="server" ID="TemplateSap003">
                      <Template>
                          Дети<br />Z00.0
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap004">
                      <Template>
                          РШМ<br />Z12.4
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap005">
                      <Template>
                          РМЖ<br />Z12.3
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap006">
                      <Template>
                          Кол.рак<br />Z12.8
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap007">
                      <Template>
                          РПЖ<br />Z12.0
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap009">
                      <Template>
                          ПСА<br />Z12.5
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
    
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Удаление" Width="300" IsModal="true">
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

<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
 <asp:SqlDataSource runat="server" ID="sdsUch" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

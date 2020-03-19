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

 <script type="text/javascript">
     var myconfirm = 0;
//     myDialogDubl.visible = false;

     function KltClose(result) {
    //             alert("KofClose=1" + result);
         KltWindow.Close();

         var hashes = result.split('&');
         //            alert("hashes=" + hashes);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;

         var AmbCntIdn = hashes[0];

         var ua = navigator.userAgent;
         var h = $(window).height() - 100;
         var w = $(window).width() - 60;
    //     if (ua.search(/OPR/) > -1) h = h + 100;
     //   alert("AmbCntIdn = " + AmbCntIdn + " & GlvDocTyp=" + GlvDocTyp);

         window.open("/Priem/DocAppAmb.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
     }


     // Client-Side Events for Delete
     // при ExposeSender = "false" OnBeforeDelete(record)
     // при ExposeSender = "true" OnBeforeDelete(sender,record)


     //    ==========================  ПЕЧАТЬ =============================================================================================

     //    ==========================  ПЕЧАТЬ =============================================================================================
     // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------

     // -------изменение как EXCEL-------------------------------------------------------------------          

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'GRFPTH';
           GridDsp.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridDsp.executeFilter();
         }
         else {
             GridDsp.removeFilter();
         }
     }


     function GridDsp_dbl(rowIndex) {
         //         alert('GridKas_dbl=');
         var AmbCrdIdn000 = GridDsp.Rows[rowIndex].Cells[0].Value;

       //  alert('GridKas_dbl=' + AmbCrdIdn000);
         document.getElementById('MainContent_parCrdIdn').value=AmbCrdIdn000;
      //   document.getElementById('MainContent_parDbl').value="DBL";
         myDialogDubl.Open();
     }


     function OpenDublCrd(AmbCrdIdnDbl) {
         //     alert('GlvDocIdnDbl=' + GlvDocIdnDbl);
         myDialogDubl.Close();

         var AmbCrdIdn = AmbCrdIdnDbl;
         var GlvDocTyp = "АМБ";
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;

         var ua = navigator.userAgent;
         var h = $(window).height() - 100;
         var w = $(window).width() - 60;
         //  if (ua.search(/OPR/) > -1) h = h + 100;

         window.open("/Priem/DocAppAmb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
     }

     function WindowRefresh() {
       //  alert("ExitFun");
         document.getElementById("MainContent_PushButton").click();
       //  var jsVar = "callPostBack";
       //  __doPostBack('callPostBack', jsVar);
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
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
     //       if (GlvDocTyp == "AMB") GlvDocTyp = "АМБ";
     //       Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================

            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            // GridDsp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //               GridDsp.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

            if (!Page.IsPostBack)
            {

                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();

                getGrid();

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
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

            TekDocTyp = GlvDocTyp;
            //      if (GlvDocTyp == "AMB") TekDocTyp = "АМБ";
            //      if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocAppLstDsp", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocAppLstDsp");

            /*
            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]) + " (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
                }
            }
            catch
            {
            }
            */

            con.Close();

            GridDsp.DataSource = ds;
            GridDsp.DataBind();
        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate1.Text);


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
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
            if (e.Row.Cells[03].Text.Length == 0) e.Row.Cells[04].ForeColor = System.Drawing.Color.Red;
        }
        // ======================================================================================
        // ============================ дублировать амб.карту ==============================================
        protected void DblButtonOK_Click(object sender, EventArgs e)
        {
            int AmbCrdIdn;
            string AmbCrdIdnDbl;

            //    myDialogDubl.Visible = false;
            //    myDialogDubl.VisibleOnLoad = false;

            AmbCrdIdn = Convert.ToInt32(parCrdIdn.Value);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstDspDbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GRFIDNOUT", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters["@GRFIDNOUT"].Direction = ParameterDirection.Output;

            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
                AmbCrdIdnDbl = Convert.ToString(cmd.Parameters["@GRFIDNOUT"].Value);
            }
            finally
            {
                con.Close();
            }

            ExecOnLoad("OpenDublCrd(" + AmbCrdIdnDbl + ");");

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
             Text="ДИСПАНСЕРИЗАЦИЯ" 
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
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">
	        
	        <obout:Grid id="GridDsp" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "false"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "-1"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
     OnRowDataBound="OnRowDataBound_Handle"
     FilterType="Normal"     
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="DSPIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="DSPUCH" HeaderText="УЧАСТОК" Width="10%" />
	                <obout:Column ID="Column02" DataField="DSPBEG" HeaderText="ДИСП"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column03" DataField="DSPIIN" HeaderText="ИИН" Align="center" Width="10%" />
	                <obout:Column ID="Column04" DataField="DSPFIO" HeaderText="ФИО" Width="20%" />
	                <obout:Column ID="Column05" DataField="DSPBRTGOD" HeaderText="ГОД/Р" Width="5%" />
	                <obout:Column ID="Column06" DataField="DSPENDDAT" HeaderText="СРОК"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column07" DataField="DSPMINDAT" HeaderText="АМБ.КРТ"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
 	                <obout:Column ID="Column08" DataField="DSPMKB" HeaderText="МКБ" Width="5%" />
                    <obout:Column ID="Column09" DataField="MKBNAM" HeaderText="МКБ НАИМЕНОВАНИЕ" Width="30%"/>
                    <obout:Column ID="Column10" DataField="DBL" HeaderText="АМБ" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateDbl" />
				    </obout:Column>				
		        </Columns>

                <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateDbl">
                       <Template>
                          <input type="button" id="btnDbl" class="tdTextSmall" value="АМБ" onmousedown="GridDsp_dbl(<%# Container.PageRecordIndex %>)"/>
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
    
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   
                  <input type="button" name="AddButton" value="Новая амб.карта" id="AddButton" onclick="AddButton_Click();">
      
        --%>
        <div class="RsxMatInp" title=" Укажите расходный материал">
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                   <td width="20%" style="vertical-align: central;" >
                        <asp:TextBox ID="txtRsxMat" Width="100%" runat="server" ></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>             

<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
     
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

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogDubl" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Дублирования амбулаторной карты" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите открыть амбулаторную карту?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="DblButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="myDialogDubl.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================       --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
  
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

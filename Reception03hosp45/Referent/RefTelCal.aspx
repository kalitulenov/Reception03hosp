<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ============================конец для почты  ============================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
   
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

                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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
    

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int TelCalIdn;
        //int TelCalTab;
        //DateTime TelCalDat;
        //DateTime TelCalTim;
        //string TelCalNum;
        //int TelCalMin;
        //string TelCalMem;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";
        DateTime GlvBegDat;
        DateTime GlvEndDat;


        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            parBuxFrm.Value = BuxFrm;
            BuxSid = (string)Session["BuxSid"];

            sdsBux.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsBux.SelectCommand = "SELECT BUXKOD AS BUXTAB,FIO FROM SprBuxKdr WHERE BUXFRM='" +BuxFrm + "' ORDER BY FIO";

            GridTelCal.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridTelCal.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridTelCal.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
                //string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;ВСЕ".Split(';');
                //rptAlphabet.DataSource = alphabet;
                //rptAlphabet.DataBind();

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDateBeg.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDateEnd.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                getGrid();
            }
        }

        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            int TelCalTab;
            string TelCalDatTxt;
            string TelCalNum="";
            int TelCalHhh;
            int TelCalMmm;
            int TelCalMin;
            string TelCalMem="";
            string SqlStr = "";

            TelCalTab = Convert.ToInt32(e.Record["TelCalTab"]);

            if (Convert.ToString(e.Record["TelCalMem"]) == null || Convert.ToString(e.Record["TelCalMem"]) == "") TelCalMem = "";
            else TelCalMem = Convert.ToString(e.Record["TelCalMem"]);

            if (Convert.ToString(e.Record["TelCalNum"]) == null || Convert.ToString(e.Record["TelCalNum"]) == "") TelCalNum = "";
            else TelCalNum = Convert.ToString(e.Record["TelCalNum"]);

            TelCalDatTxt = Convert.ToString(e.Record["TelCalDat"]);
            if (string.IsNullOrEmpty(TelCalDatTxt)) TelCalDatTxt = DateTime.Now.ToString("dd.MM.yyyy");
            else TelCalDatTxt = Convert.ToDateTime(e.Record["TelCalDat"]).ToString("dd.MM.yyyy");

            if (Convert.ToString(e.Record["TelCalHhh"]) == null || Convert.ToString(e.Record["TelCalHhh"]) == "") TelCalHhh = 0;
            else TelCalHhh = Convert.ToInt32(e.Record["TelCalHhh"]);
            if (TelCalHhh > 24) TelCalHhh = 0;

            if (Convert.ToString(e.Record["TelCalMmm"]) == null || Convert.ToString(e.Record["TelCalMmm"]) == "") TelCalMmm = 0;
            else TelCalMmm = Convert.ToInt32(e.Record["TelCalMmm"]);
            if (TelCalMmm > 60) TelCalMmm = 0;

            if (Convert.ToString(e.Record["TelCalMin"]) == null || Convert.ToString(e.Record["TelCalMin"]) == "") TelCalMin = 0;
            else TelCalMin = Convert.ToInt32(e.Record["TelCalMin"]);

            SqlStr = "INSERT INTO TabTelCal (TelCalFrm,TelCalTab,TelCalNum,TelCalMin,TelCalMem,TelCalDat,TelCalHhh,TelCalMmm) " +
                                            "VALUES (" + BuxFrm + ","+Convert.ToString(TelCalTab) + ",'" + TelCalNum+"',"+
                                                         Convert.ToString(TelCalMin)+",'"+TelCalMem+"'," +
                                                         "CONVERT(DATETIME,'" + TelCalDatTxt + "',104)," +
                                                         Convert.ToString(TelCalHhh) + ","+
                                                         Convert.ToString(TelCalMmm) + ")";

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand(SqlStr, con);
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int TelCalIdn;
            int TelCalTab;
            string TelCalDatTxt;
            string TelCalNum="";
            int TelCalHhh;
            int TelCalMmm;
            int TelCalMin;
            string TelCalMem="";
            string SqlStr = "";

            TelCalIdn = Convert.ToInt32(e.Record["TelCalIdn"]);
            TelCalTab = Convert.ToInt32(e.Record["TelCalTab"]);

            if (Convert.ToString(e.Record["TelCalMem"]) == null || Convert.ToString(e.Record["TelCalMem"]) == "") TelCalMem = "";
            else TelCalMem = Convert.ToString(e.Record["TelCalMem"]);

            if (Convert.ToString(e.Record["TelCalNum"]) == null || Convert.ToString(e.Record["TelCalNum"]) == "") TelCalNum = "";
            else TelCalNum = Convert.ToString(e.Record["TelCalNum"]);

            TelCalDatTxt = Convert.ToString(e.Record["TelCalDat"]);
            if (string.IsNullOrEmpty(TelCalDatTxt)) TelCalDatTxt = DateTime.Now.ToString("dd.MM.yyyy");
            else TelCalDatTxt = Convert.ToDateTime(e.Record["TelCalDat"]).ToString("dd.MM.yyyy");

            if (Convert.ToString(e.Record["TelCalHhh"]) == null || Convert.ToString(e.Record["TelCalHhh"]) == "") TelCalHhh = 0;
            else TelCalHhh = Convert.ToInt32(e.Record["TelCalHhh"]);
            if (TelCalHhh > 24) TelCalHhh = 0;

            if (Convert.ToString(e.Record["TelCalMmm"]) == null || Convert.ToString(e.Record["TelCalMmm"]) == "") TelCalMmm = 0;
            else TelCalMmm = Convert.ToInt32(e.Record["TelCalMmm"]);
            if (TelCalMmm > 60) TelCalMmm = 0;

            if (Convert.ToString(e.Record["TelCalMin"]) == null || Convert.ToString(e.Record["TelCalMin"]) == "") TelCalMin = 0;
            else TelCalMin = Convert.ToInt32(e.Record["TelCalMin"]);

            SqlStr = "UPDATE TabTelCal SET TelCalTab=" + Convert.ToString(TelCalTab) + "," +
                                                                 "TelCalNum='" + TelCalNum + "'," +
                                                                 "TelCalMin=" + Convert.ToString(TelCalMin) + "," +
                                                                 "TelCalMem='" + TelCalMem + "'," +
                                                                 "TelCalDat=CONVERT(DATETIME,'" + TelCalDatTxt + "', 104)" + "," +
                                                                 "TelCalHhh=" + Convert.ToString(TelCalHhh) + "," +
                                                                 "TelCalMmm=" + Convert.ToString(TelCalMmm) +
                                                                 " WHERE TelCalIdn=" + Convert.ToString(TelCalIdn);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand(SqlStr, con);
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int TelCalIdn;
            //string SqlStr = "";

            TelCalIdn = Convert.ToInt32(e.Record["TelCalIdn"]);
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM TabTelCal WHERE TelCalIdn=" + Convert.ToString(TelCalIdn), con);
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            Session["GlvBegDat"] = DateTime.Parse(txtDateBeg.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDateEnd.Text);

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocTelCal", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocTelCal");

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GridTelCal.DataSource = ds;
                    GridTelCal.DataBind();
                }
            }
            catch
            {
            }

            con.Close();
        }
        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            Session["GlvBegDat"] = DateTime.Parse(txtDateBeg.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDateEnd.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            getGrid();
        }

    </script>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

     <script type="text/javascript">

         var myconfirm = 0;

         // -------изменение как EXCEL-------------------------------------------------------------------          

         //function filterGrid(e) {
         //    var fieldName;
         //    //        alert("filterGrid=");

         //    if (e != 'ВСЕ') {
         //        fieldName = 'TelCalTab';
         //        GridTelCal.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
         //        GridTelCal.executeFilter();
         //    }
         //    else {
         //        GridTelCal.removeFilter();
         //    }
         //}

         //    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {

             //var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
             //var GrfBeg = document.getElementById('MainContent_txtDateBeg').value;
             //var GrfEnd = document.getElementById('MainContent_txtDateEnd').value;


             //var ua = navigator.userAgent;

             //if (ua.search(/Chrome/) > -1)
             //    window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
             //        "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             //else
             //    window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
             //        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

         // GRID присвоение значении
         function OnAdd(sender, selectedRecords) {
             //alert("OnAdd");
             //var currDate = new Date();
             //var year = currDate.getFullYear();
             //var month = currDate.getMonth()+1;
             //var day = currDate.getDate();
             //var hours = currDate.getHours();
             //var minutes = currDate.getMinutes();
             //selectedRecords.TelCalDat = "01.01.2019";

           //  alert("Y=" + year + " M=" + month + " D=" + day + " H=" + hours + " MIN=" + minutes);

             //var body = GridTelCal.GridBodyContainer.firstChild.firstChild.childNodes[1];
             //var cell = body.childNodes[body.childNodes.length-1].childNodes[1];
             //cell.firstChild.lastChild.innerHTML = currDate; //day + "." + month + "." + year;
             //var cel2 = body.childNodes[body.childNodes.length - 1].childNodes[2];
             //cel2.firstChild.lastChild.innerHTML = hours;
             //var cel3 = body.childNodes[body.childNodes.length - 1].childNodes[3];
             //cel3.firstChild.lastChild.innerHTML = minutes;

             // change data in all rows, third cell
             //for (var i = 0; i < body.childNodes.length; i++) {
             //    var cell = body.childNodes[i].childNodes[3];
             //    cell.firstChild.lastChild.innerHTML = "value " + i;
             //}
         }

 </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
   <!--------------------------------------------------------  -->   
     <asp:HiddenField ID="parBuxFrm" runat="server" />

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>  
 <asp:TextBox ID="Sapka" 
             Text="Таблица телефонных вызовов"
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
             
             <asp:TextBox runat="server" id="txtDateBeg" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDateBeg"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:TextBox runat="server" id="txtDateEnd" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDateEnd"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
               <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

    </asp:Panel>
            
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">
	        
            <obout:Grid ID="GridTelCal" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                Width="100%"
                 EnableTypeValidation="false"
             AllowFiltering="true" 
             FilterType="Normal" 
                AllowSorting="true"
                AllowPageSizeSelection="false"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                KeepSelectedRecords="true">
                <ScrollingSettings ScrollHeight="450" />
<%--                <ClientSideEvents ExposeSender="true" OnClientAdd="OnAdd" />--%>
                <Columns>
                    <obout:Column ID="Column0" DataField="TelCalIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="TelCalDat" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="7%" />
<%--                        <TemplateSettings EditTemplateId="tplDatePicker" />
                    </obout:Column>--%>
                    <obout:Column ID="Column2" DataField="TelCalHhh" HeaderText="ЧАС" Width="4%" />
                    <obout:Column ID="Column3" DataField="TelCalMmm" HeaderText="МИН" Width="4%" />
                    <obout:Column ID="Column4" DataField="TelCalTab" HeaderText="ФАМИЛИЯ И.О." Width="25%">
                        <TemplateSettings TemplateId="TemplateBuxNam" EditTemplateId="TemplateEditBuxNam" />
                    </obout:Column>
                    <obout:Column ID="Column5" DataField="TelCalNum" HeaderText="ТЕЛЕФОН" Width="20%" />
                    <obout:Column ID="Column6" DataField="TelCalMin" HeaderText="МИНУТ" Width="5%" />
                    <obout:Column ID="Column7" DataField="TelCalMem" HeaderText="ПРИМЕЧАНИЕ" Width="30%" />
   		            <obout:Column ID="Column8" DataField="" HeaderText="Корр" Width="5%" AllowEdit="true" AllowDelete="true" />
             </Columns>

                <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateBuxNam">
                        <Template>
                            <%# Container.DataItem["FIO"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditBuxNam" ControlID="ddlBuxNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlBuxNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsBux" CssClass="ob_gEC" DataTextField="FIO" DataValueField="BUXTAB">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="tplDatePicker" ControlID="txtOrderDate" ControlPropertyName="value">
                        <Template>
                            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                <tr>
                                    <td valign="middle">
                                        <obout:OboutTextBox runat="server" ID="txtOrderDate" Width="100%"
                                            FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                    </td>
                                    <td valign="bottom" width="30px">
                                        <obout:Calendar ID="calBeg" runat="server"
                                            StyleFolder="~/Styles/Calendar/styles/default"
                                            DatePickerMode="true"
                                            DateMin="01.01.2000"
                                            ShowYearSelector="true"
                                            YearSelectorType="DropDownList"
                                            TitleText="Выберите год: "
                                            TextBoxId="txtOrderDate"
                                            CultureName="ru-RU"
                                            DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                    </td>
                                </tr>
                            </table>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>


<%--            <div class="ob_gMCont" style=" width:100%; height: 20px;">
                <div class="ob_gFContent">
                    <asp:Repeater runat="server" ID="rptAlphabet">
                        <ItemTemplate>
                            <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                                <%# Container.DataItem %>
                            </a>&nbsp;
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>        --%>

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <input type="button" name="PrtButton" value="Печать отчета" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel> 
     
    <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>

   
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <asp:SqlDataSource runat="server" ID="sdsBux" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	

</asp:Content>
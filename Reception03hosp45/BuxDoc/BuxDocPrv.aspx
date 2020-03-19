<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <!-- для диалога -------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />
    <%-- ============================  JAVA ============================================ --%>
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
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
    </style>

    <script type="text/javascript">
        var myconfirm = 0;


        // Client-Side Events for Delete
        function OnBeforeDelete(sender, record) {
            if (record.PRVDOCNAM != 'Прв') {
                windowalert("Удалять проводку нельзя!", "Предупреждения", "warning");
                //       alert('Удалять проводку нельзя!');
                return false;
            }
            else {
                if (myconfirm == 1) {
                    return true;
                }
                else {
                    document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить проводку ?";
                    document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                    myConfirmBeforeDelete.Open();
                    return false;
                }
            }
        }

        function findIndex(record) {
            var index = -1;
            for (var i = 0; i < GridPrv.Rows.length; i++) {
                if (GridPrv.Rows[i].Cells[0].Value == record.PRVIDN) {
                    index = i;
                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            GridPrv.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        function OnClientSelect(sender, selectedRecords) {
            //        alert('OnClientSelect=');
            var GlvDocCmd = "";
            //        if (selectedRecords[0].KASOPR == "+") GlvDocTyp = "Прх";
            //        else GlvDocTyp = "Рсх";

            //      alert('GlvDocTyp=' + GlvDocTyp);

            var GlvPrvIdn = selectedRecords[0].PRVIDN;
            //        alert('OnClientSelect1=');
            var GlvDocTyp = selectedRecords[0].PRVDOCNAM;
            //        alert('OnClientSelect2=' + GlvDocTyp);
            var GlvDocIdn = selectedRecords[0].PRVDOCIDN;
            //        alert('OnClientSelect3=');
            var GlvDocDeb = selectedRecords[0].PRVDEB.substr(0, 4);
            //        alert('OnClientSelect4=' + GlvDocDeb);
            var GlvDocKrd = selectedRecords[0].PRVKRD.substr(0, 4);
            //         alert('GlvPrvIdn=' + GlvPrvIdn); 

            //      if (GlvDocPrv == '+') GlvDocPrv = 'проведен';

            switch (GlvDocTyp) {
                case 'Кас':
                    if (GlvDocDeb == "1010") PrvWindow.setUrl("/BuxDoc/BuxDocPrvKasPrx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=1");
                    else PrvWindow.setUrl("/BuxDoc/BuxDocPrvKasRsx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=1");
                    break;
                case 'Прв':
                    PrvWindow.setUrl("/BuxDoc/BuxDocPrvOne.aspx?GlvPrvIdn=" + GlvPrvIdn + "&GlvPrvPrv=''");
                    break;
            }
            PrvWindow.Open();

            /*
            if (GlvDocCmd.length > 0) {
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open(GlvDocCmd, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog(GlvDocCmd, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            }
            */

        }


        function PrvAdd() {
            //      PrvWindow.setTitle(BuxDtlIdn);
            PrvWindow.setUrl("/BuxDoc/BuxDocPrvOne.aspx?GlvPrvIdn=0&GlvPrvPrv=''");
            PrvWindow.Open();

            //            location.href = "/BuxDoc/BuxDocPrvOne.aspx?GlvPrvIdn=0&GlvPrvPrv=''";
        }

        function PrvClose() {
            //        alert("PrvClose");
            //        var jsVar = "dotnetcurry.com";
            //        __doPostBack('callPostBack', jsVar);

            PrvWindow.Close();
        }
        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {

            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
            var GrfTyp = "КАС";    // document.getElementById('MainContent_parDocTyp').value;
            var GrfBeg = document.getElementById('MainContent_txtDate1').value;
            var GrfEnd = document.getElementById('MainContent_txtDate2').value;

            //      var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;

         var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxPrvJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPrvJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function ExlButton_Click() {
            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
            var GrfTyp = "КАС";    // document.getElementById('MainContent_parDocTyp').value;
            var GrfBeg = document.getElementById('MainContent_txtDate1').value;
            var GrfEnd = document.getElementById('MainContent_txtDate2').value;

   //         location.href = "/Report/DauaReports.aspx?ReportName=BuxPrvExpExl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd;
        }

    </script>


    <script runat="server">

        //        Grid GridPrv = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int GlvDocIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSumPrx = 0;
        decimal ItgDocSumRsx = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //             GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            //             parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //             TxtDoc = (string)Request.QueryString["TxtSpr"];
            //             Sapka.Text = TxtDoc;
            //            Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================
            ItgDocSumPrx = 0;
            ItgDocSumRsx = 0;

            GridPrv.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridPrv.Rebind += new Obout.Grid.Grid.DefaultEventHandler(RebindGrid);


            //                string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
            //                string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
            //                if (par02 != null && !par02.Equals(""))  ItgDocSumRsx = 0;


            if (!Page.IsPostBack)
            {

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
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("BuxDocPrvLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@PRVFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxDocPrvLst");

            con.Close();

            GridPrv.DataSource = ds;
            GridPrv.DataBind();
        }
        /*
                protected void PushButton_Click(object sender, EventArgs e)
                {
                    ItgDocSumPrx = 0;
                    ItgDocSumRsx = 0;

                    Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
                    Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

                    GlvBegDat = (DateTime)Session["GlvBegDat"];
                    GlvEndDat = (DateTime)Session["GlvEndDat"];

                    Reception03hosp45.localhost.Service1 ws = new Reception03hosp45.localhost.Service1();
                    ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

                    getGrid();
                }
        */
        void RebindGrid(object sender, EventArgs e)
        {
            
            ItgDocSumPrx = 0;
            ItgDocSumRsx = 0;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

         getGrid();
                     }


        // ============================ кнопка новый документ  ==============================================.
        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");

        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int PrvIdn = Convert.ToInt32(e.Record["PRVIDN"]);
            //      int PrvDocIdn;

            //     if (Convert.ToString(e.Record["PRVDOCIDN"]) == null || Convert.ToString(e.Record["PRVDOCIDN"]) == "") PrvDocIdn = 0;
            //     else PrvDocIdn = Convert.ToInt32(e.Record["PRVDOCIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("BuxPrvDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@PRVDOCIDN", SqlDbType.VarChar).Value = PrvIdn;
            cmd.Parameters.Add("@PRVDOCNAM", SqlDbType.VarChar).Value = "Прв";
            cmd.Parameters.Add("@PRVBUX", SqlDbType.VarChar).Value = BuxKod;

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();
        }

        // ---------Суммация  ------------------------------------------------------------------------
        // ---------Суммация  ------------------------------------------------------------------------
        public void GridPrv_RowCreated(object sender, GridRowEventArgs e)
        {
            if (IsPostBack && e.Row.RowType == GridRowType.Header)
            {
                ItgDocSumPrx = 0;
                ItgDocSumRsx = 0;
            }
            //        if (e.Row.RowType == GridRowType.EmptyDataRow) Pusto.Value = "Pusto";
            //        if (e.Row.RowType == GridRowType.DataRow) Pusto.Value = "Itogo";
        }

        // ---------Суммация  ------------------------------------------------------------------------
        public void GridPrv_RowDataBound(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[6].Text == null | e.Row.Cells[6].Text == "") ItgDocSumPrx += 0;
                else ItgDocSumPrx += decimal.Parse(e.Row.Cells[6].Text);
                //               if (e.Row.Cells[5].Text == null | e.Row.Cells[5].Text == "") ItgDocSumRsx += 0;
                //               else ItgDocSumRsx += decimal.Parse(e.Row.Cells[5].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[5].Text = "Итого:";
                e.Row.Cells[6].Text = ItgDocSumPrx.ToString();
                //              e.Row.Cells[5].Text = ItgDocSumRsx.ToString();

            }
        }


        // ======================================================================================

    </script>


    <%-- ============================  для передач значении  ============================================ --%>
    <asp:HiddenField ID="parDocTyp" runat="server" />
    <asp:HiddenField ID="HidBuxFrm" runat="server" />
    <asp:HiddenField ID="HidBuxKod" runat="server" />

    <%-- ============================  шапка экрана ============================================ 
      <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />
    --%>
    <asp:TextBox ID="Sapka"
        Text="ЖУРНАЛ ПРОВОДОК"
        BackColor="#3CB371"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0px; position: relative; width: 100%; text-align: center"
        runat="server"></asp:TextBox>

    <%-- ============================  верхний блок  ============================================ --%>

    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">

        <%--             <div style="float:left;  width: 50%; position: relative; left: 20px; color: green; "> </div>   --%>
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
			 
             <ASP:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
                 <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
           </center>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>
    <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 500px;">

        <obout:Grid ID="GridPrv" runat="server"
            CallbackMode="true"
            Serialize="true"
            FolderStyle="~/Styles/Grid/style_1"
            AutoGenerateColumns="false"
            ShowTotalNumberOfPages="false"
            FolderLocalization="~/Localization"
            AllowAddingRecords="false"
            Language="ru"
            PageSize="-1"
            AllowRecordSelection="true"
            AllowPaging="false"
            Width="100%"
            OnRowCreated="GridPrv_RowCreated"
            OnRowDataBound="GridPrv_RowDataBound"
            OnRebind="RebindGrid"
            AllowPageSizeSelection="false"
            ShowColumnsFooter="true">
            <ScrollingSettings ScrollHeight="410" />
            <ClientSideEvents ExposeSender="true"
                OnClientSelect="OnClientSelect"
                OnBeforeClientDelete="OnBeforeDelete" />
            <Columns>
                <obout:Column ID="Column00" DataField="PRVIDN" HeaderText="Идн" Visible="false" Width="0%" />
                <obout:Column ID="Column01" DataField="PRVDOCIDN" HeaderText="Идн" Visible="false" Width="0%" />
                <obout:Column ID="Column02" DataField="PRVNUM" HeaderText="НОМЕР" Align="right" Width="5%" />
                <obout:Column ID="Column03" DataField="PRVDAT" HeaderText="ДАТА" DataFormatString="{0:dd/MM/yy}" Width="7%" />
                <obout:Column ID="Column04" DataField="PRVDEB" HeaderText="ДЕБЕТ" Width="6%" />
                <obout:Column ID="Column05" DataField="PRVKRD" HeaderText="КРЕДИТ" Width="6%" />
                <obout:Column ID="Column06" DataField="PRVSUM" HeaderText="СУММА" Width="8%" Align="right" DataFormatString="{0:F2}" />
                <obout:Column ID="Column07" DataField="PRVPOL" HeaderText="ПОЛУЧАТЕЛЬ" Width="10%" Align="left" />
                <obout:Column ID="Column08" DataField="PRVOTP" HeaderText="ОТПРАВИТЕЛЬ" Width="10%" Align="left" />
                <obout:Column ID="Column09" DataField="PRVMEM" HeaderText="НАЗНАЧЕНИЯ" Width="25%" Align="left" />
                <obout:Column ID="Column10" DataField="BUXSPZNAM" HeaderText="СПЕЦ." Width="8%" Align="left" />
                <obout:Column ID="Column11" DataField="FI" HeaderText="ОТВЕТ." Width="5%" Align="left" />
                <obout:Column ID="Column12" DataField="PRVDOCNAM" HeaderText="ДОК" Width="5%" />
                <obout:Column ID="Column13" DataField="" HeaderText="Удл" Width="5%" AllowEdit="false" AllowDelete="true" runat="server" />
            </Columns>
        </obout:Grid>
    </asp:Panel>

    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
    <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
        <center>
                 <input type="button" value="Новая" style="width:10%"  onclick="PrvAdd()" />
                 <input type="button" name="PrtButton" value="Журнал" id="PrtButton" onclick="PrtButton_Click();">
                 <input type="button" name="PrtButton" value="Экспрот в Excel" id="ExlButton" onclick="ExlButton_Click(); return false;">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
    </asp:Panel>


    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

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

    <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
    <owd:Window ID="PrvWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
        Left="220" Top="100" Height="430" Width="1000" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="ПРОВОДКА">
    </owd:Window>

</asp:Content>

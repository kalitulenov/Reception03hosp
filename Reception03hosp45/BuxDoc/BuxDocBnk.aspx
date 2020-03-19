<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

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

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function GridBnk_ClientEdit(sender, record) {
            //           alert("GridBnk_ClientEdit");
            var BuxBnkIdn = document.getElementById('MainContent_parDocIdn').value;
            var BuxDtlIdn = record.DTLIDN;
 //           alert("BuxBnkIdn ="+BuxBnkIdn);
  //          alert("BuxDtlIdn =" + BuxDtlIdn);
            //          var AmbBnkTyp = document.getElementById('HidAmbCrdTyp').value;

            BnkWindow.setTitle(BuxDtlIdn);
            BnkWindow.setUrl("BuxDocBnkOne.aspx?BuxBnkIdn=" + BuxBnkIdn + "&BuxDtlIdn=" + BuxDtlIdn);
            BnkWindow.Open();

            return false;
        }

        function GridBnk_ClientInsert(sender, record) {
   //                  alert("GridBnk_ClientInsert");
            var BuxBnkIdn = document.getElementById('MainContent_parDocIdn').value;
            var BuxDtlIdn = 0;
   //         var AmbBnkTyp = document.getElementById('HidAmbCrdTyp').value;
  //          alert("BuxBnkIdn=" + BuxBnkIdn);

            BnkWindow.setTitle(BuxDtlIdn);
            BnkWindow.setUrl("BuxDocBnkOne.aspx?BuxBnkIdn=" + BuxBnkIdn + "&BuxDtlIdn=" + BuxDtlIdn);
            //         BnkWindow.setUrl("DocAppAmbBnkOne.aspx?parDtlIdn=" + parDtlIdn);
            BnkWindow.Open();

            return false;
        }

        function WindowClose() {
  //          alert("GridBnkClose");
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);
        //  __doPostBack('btnSave', e.innerHTML);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtBnkButton_Click() {
            var AmbCrdIdn = document.getElementById('parDocIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbBnk&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbBnk&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtRzpButton_Click() {
            var AmbCrdIdn = document.getElementById('parDocIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
    </script>



<script runat="server">

    int GlvDocIdn;
    string GlvDocPrv;

    int DtlIdn;

    string DtlDeb;
    int DtlDebSpr;
    int DtlDebSprVal;
    string DtlKrd;
    int DtlKrdSpr;
    int DtlKrdSprVal;

    int DtlKod;
    Boolean DtlNdc;
    int DtlGrp;
    int DtlUpk;

    decimal DtlKol;
    decimal DtlPrz;
    string DtlEdn;
    string DtlNam;
    decimal DtlZen;
    decimal DtlSum;
    string DtlIzg;
    string DtlSrkSlb;

    string GlvDocTyp;
    DateTime GlvDocDat;
    string MdbNam = "HOSPBASE";

    string BuxSid;
    string BuxKod;
    string BuxFrm;
    string CountTxt;
    int CountInt;
    decimal ItgDocSum = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //============= Установки ===========================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        BuxFrm = (string)Session["BuxFrmKod"];


        GlvDocTyp = "Бнк";
        //=====================================================================================
        GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
        GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
        //============= начало  ===========================================================================================
        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))
        {
            Session["BuxDtlIdn"] = "Post";
        }
               
        if (GlvDocPrv != null && GlvDocPrv != "")
        {
            //               AddButton.Visible = false;
            //               PrvButton.Visible = false;
            //               GridAbn.Columns[8].Visible = false;
        }

        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCKOD LIKE '1040%' AND ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

        //           if (GlvDocIdn == 0) PrvButton.Visible = false;

        // ViewState
        // ViewState["text"] = "Artem Shkolovy";
        // string Value = (string)ViewState["name"];
  //      GridBnk.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
  //      GridBnk.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
  //      GridBnk.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
  //      GridBnk.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        if (!Page.IsPostBack)
        {

            //============= Установки ===========================================================================================
            if (GlvDocIdn == 0)  // новый документ
            {
                Session.Add("CounterTxt", "0");

                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrxDocAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Бнк";
                cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@GLVDOCIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    GlvDocIdn = Convert.ToInt32(cmd.Parameters["@GLVDOCIDN"].Value);
                    parDocIdn.Value = Convert.ToString(GlvDocIdn);

                }
                finally
                {
                    con.Close();
                }
                Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                Session.Add("GLVREJ", "ADD");

            }
            else
            {
                Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                Session.Add("GLVREJ", "ARP");

            }

            parDocIdn.Value = Convert.ToString(GlvDocIdn);
            getDocNum();
            //               getDocOct();

            //        ddlEdnNam.SelectedValue = "шт";
        }
            CreateGrid();


    }

    
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды

        SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOC WHERE DOCIDN=" + GlvDocIdn, con);

        con.Open();
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "GetDocNum");
        con.Close();
        TxtDocDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
        TxtDocNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);

        if (GlvDocIdn > 0)
        {
            //       BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
            BoxAcc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEB"]);
            //             BoxMol.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRDSPRVAL"]);
            //             TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMEM"]);
            //      TxtFktDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDATFKT"]);

        }

    }
      
    // ============================ чтение таблицы а оп ==============================================
    void CreateGrid()
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        
               //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("BuxDocSelIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = GlvDocIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxDocSelIdn");
        
        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            GridBnk.DataSource = ds;
            GridBnk.DataBind();
        }
        
    }

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        CreateGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        CreateGrid();
    }

    void RebindGrid(object sender, EventArgs e)
    {
        CreateGrid();
    }
    
    // ======================================================================================

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);

        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        con.Open();
        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
        }
        finally
        {
            con.Close();
        }


        //            localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //            ws.AptPrxDtlDel(MdbNam, BuxSid, DtlIdn);

        CreateGrid();
    }

    // ==================================== поиск клиента по фильтрам  ============================================
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        string KodErr = "";
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        if (TxtDocNum.Text.Length == 0)
        {
            Err.Text = "Не указан номер документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtDocDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxAcc.SelectedValue == "" || BoxAcc.SelectedValue == "0")
        {
            Err.Text = "Не указан счет";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        /*
                                if (BoxOrg.SelectedValue == "" || BoxOrg.SelectedValue == "0")
                                {
                                    Err.Text = "Не указан поставщик";
                                    ConfirmOK.Visible = true;
                                    ConfirmOK.VisibleOnLoad = true;
                                    return;
                                }
        */
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocDtlChk", con);
        cmd = new SqlCommand("BuxPrxDocDtlChk", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxPrxDocDtlChkVvd");

        //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //           DataSet ds = new DataSet("AptPrxDocChk");
        //           ds.Merge(ws.AptPrxDocChk(MdbNam, BuxSid, BuxKod));

        KodErr = Convert.ToString(ds.Tables[0].Rows[0]["KODERR"]);
        Err.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAMERR"]);

        if (KodErr == "ERR")
        {
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
        }
        else
        {
            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;
        }

    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnOK_click(object sender, EventArgs e)
    {
        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

        //          localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //          ws.AptPrxDocAddRep(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, BoxOrg.SelectedValue, BuxKod);
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxPrxDocAddRep", con);
        cmd = new SqlCommand("BuxPrxDocAddRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
        cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = TxtDocNum.Text;
        cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
        cmd.Parameters.Add("@DOCDEB", SqlDbType.VarChar).Value = BoxAcc.SelectedValue;                 // BoxOrg.SelectedValue;
        cmd.Parameters.Add("@DOCDEBSPR", SqlDbType.VarChar).Value = "2";                // BoxOrg.SelectedValue;
        cmd.Parameters.Add("@DOCDEBSPRVAL", SqlDbType.VarChar).Value = "0";                // BoxOrg.SelectedValue;
        cmd.Parameters.Add("@DOCKRD", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@DOCKRDSPR", SqlDbType.VarChar).Value = "0";
        cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = "0";
        cmd.Parameters.Add("@DOCNUMFKT", SqlDbType.VarChar).Value = "";                //TxtFkt.Text;
        cmd.Parameters.Add("@DOCDATFKT", SqlDbType.VarChar).Value = "";                //TxtFktDat.Text;
        cmd.Parameters.Add("@DOCMEM", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

        // ------------------------------------------------------------------------------заполняем первый уровень
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Бнк&TxtSpr=Выписка банка");
    }

    // ============================ отказ записи документа в базу ==============================================
    protected void CanButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Бнк&TxtSpr=Выписка банка");
    }
    // ============================ проводить записи документа в базу ==============================================
    //------------------------------------------------------------------------
    protected void PrtButton_Click(object sender, EventArgs e)
    {
        //       AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
        // --------------  печать ----------------------------
        //       Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbLab003&TekDocIdn=" + AmbUslIdn);
    }

    // ---------Суммация  ------------------------------------------------------------------------
    public void SumDoc(object sender, GridRowEventArgs e)
    {
        /*
        if (e.Row.RowType == GridRowType.DataRow)
        {
            if (e.Row.Cells[6].Text == null | e.Row.Cells[6].Text == "") ItgDocSum += 0;
            else ItgDocSum += decimal.Parse(e.Row.Cells[6].Text);
        }
        else if (e.Row.RowType == GridRowType.ColumnFooter)
        {
            e.Row.Cells[2].Text = "Итого:";
            e.Row.Cells[6].Text = ItgDocSum.ToString();

        }
         * */
    }
    
                
</script>

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Выписка банка" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 10%; position: relative; width: 80%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 35px;">

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td style="vertical-align: top; width: 5%">
                    <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="№ док.:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 25%">
                    <asp:TextBox ID="TxtDocNum" Width="20%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtDocDat" Width="80px" />
                    <obout:Calendar ID="CalDoc" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtDocDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                </td>
                <td style="vertical-align: top; width: 20%">
                    <asp:Label ID="Label4" runat="server" align="center" Style="font-weight: bold;" Text="Счет:"></asp:Label>
                    <obout:ComboBox runat="server" ID="BoxAcc" Width="60%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsAcc" DataTextField="ACCKOD" DataValueField="ACCKOD">
                    </obout:ComboBox>
                </td>
                <td style="vertical-align: top; width: 50%"> </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
        </table>


    </asp:Panel>


        <%-- ============================  средний блок  ============================================ --%>
      <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 450px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridBnk" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
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
               <ScrollingSettings ScrollHeight="370" ScrollWidth="100%" />
               <ClientSideEvents 
		               OnBeforeClientEdit="GridBnk_ClientEdit" 
		               OnBeforeClientAdd="GridBnk_ClientInsert"
		               ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="DTLIDN" Visible="false" HeaderText="Идн" Width="0%" />
                    <obout:Column ID="Column01" DataField="DTLNUM" HeaderText="НОМЕР" Align="right" Width="7%" />
                    <obout:Column ID="Column02" DataField="DTLDEB" HeaderText="СЧЕТ" Align="right" Width="7%" />
                    <obout:Column ID="Column03" DataField="PRXSUM" HeaderText="ПРИХОД" Align="right" Width="10%" DataFormatString="{0:F2}" />
                    <obout:Column ID="Column04" DataField="RSXSUM" HeaderText="РАСХОД" Align="right" Width="10%" DataFormatString="{0:F2}" />
                    <obout:Column ID="Column05" DataField="TXTNAM" HeaderText="НАИМЕНОВАНИЕ" Width="20%" />
                    <obout:Column ID="Column06" DataField="TXTANL" HeaderText="АНАЛИТИКА" Width="16%" />
                    <obout:Column ID="Column07" DataField="DTLMEM" HeaderText="ПРИМЕЧАНИЕ" Align="right" Width="10%" DataFormatString="{0:F0}" />
                    <obout:Column ID="Column08" DataField="DTLGRP" HeaderText="СПЕЦ" Width="10%" />
                    <obout:Column ID="Column09" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	             

                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
       			<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridBnk.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridBnk.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridBnk.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridBnk.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridBnk.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridBnk.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridBnk.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	

                </Templates>
            </obout:Grid>
        </asp:Panel>
  <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtBnkButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 


            <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="BnkWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="100" Height="500" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Назначения">

       </owd:Window>

 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
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
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
    
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>


    	    <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsSpz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
	        <asp:SqlDataSource ID="sdsDtl" runat="server"></asp:SqlDataSource>



    <%-- ============================  STYLES ============================================ --%>

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

</asp:Content>



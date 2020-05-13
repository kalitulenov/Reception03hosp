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

         function HandlePopupPost(result) {
             var jsVar = "dotnetcurry.com";
             __doPostBack('callPostBack', jsVar);
         }


         //    ---------------- ПРОСМОТР ОПИСАНИИ В ФОРМАТЕ EXCEL --------------------------------------------------------
         function MedDocXls(rowIndex) {
          //   alert("GridAnl_ClientEdit="+rowIndex);
             var SblYes = GridUsl.Rows[rowIndex].Cells[18].Value;
             var AmbDocTyp = SblYes;
           //  alert("SblYes=" + SblYes);
          //   var AmbDocTyp = document.getElementById('MainContent_parDocTyp').value;
           //  if (AmbDocTyp == "РНТ") SblYes = "+";

             if (SblYes != "") {
                 var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
            //     alert("AmbUslIdn = " + AmbUslIdn + " & AmbDocTyp =" + AmbDocTyp);
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Priem/DocAppFnkOneAspose.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbDocTyp=МЕД", "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Priem/DocAppFnkOneAspose.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbDocTyp=МЕД", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
             }
             else alert("Шаблон отстутствует");

             return false;
         }

         //    ---------------- обращение веб методу --------------------------------------------------------
         function WebCam(rowIndex) {
    //         alert("GridAnl_ClientEdit="+rowIndex);
             var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
             var AmbAnlPth = "";  //document.getElementById('parXlsFio').value;
             var AmbUslIIN = document.getElementById('parGrfIIN').value;

             AnlWindow.setTitle(AmbAnlPth);
             AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbUslPth=" + AmbAnlPth + "&AmbUslIIN=" + AmbUslIIN);
             AnlWindow.Open();
             return false;
         }

         function WindowClose() {
             var jsVar = "callPostBack";
             __doPostBack('callPostBack', jsVar);
             //  __doPostBack('btnSave', e.innerHTML);
         }
         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

         function PrtZnrButton_Click() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtDntZakNar&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtDntZakNar&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

         function updateSprUslSelection(sender, index) {
             document.getElementById('hiddenUslNam').value = sender.value();
         }

         // --------------------- РАСХОД МАТЕРИАЛОВ ПО ЭТОЙ УСЛУГЕ
         function GridUsl_rsx(rowIndex) {
    //                  alert("GridPrz_rsx=");
             var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
             var AmbCrdIdn = GridUsl.Rows[rowIndex].Cells[1].Value;

//             RsxWindow.setTitle(AmbUslNam);
//             RsxWindow.setUrl("DocAppAmbUslRsx.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbUslNam=" + AmbUslNam);
//             RsxWindow.Open();

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbUslRsxMat.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn,
                     "ModalPopUp", "toolbar=no,width=1000,height=650,left=150,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbUslRsxMat.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:150px;dialogtop:100px;dialogWidth:1000px;dialogHeight:650px;");

             return true;
         }

         function GridUsl_ClientAdd(sender, record) {

             //                    alert("GridUыд_ClientEdit");
             //            document.getElementById('parPrsIdn').value = 0;
             //            TrfWindow.Open();
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbUslSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                     "ModalPopUp", "toolbar=no,width=800,height=550,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbUslSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:550px;");

             return false;
         }



 </script>

</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UslIdn;
    int UslAmb;
    string UslNap;
    string UslStx;
    int UslLgt;
    int UslZen;
    int UslKol;
    int UslKod;
    int UslKto;
    string UslGde;

    string UslNam;
    string UslMem;

    int NumDoc;

    string AmbCrdIdn;
    string AmbCntIdn;
    string AmbUslIdn;

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
        //       Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];

        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE ISNULL(BUXUBL,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI"; //+ " AND DLGTYP='ФИЗ'"

        sdsGde.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGde.SelectCommand = "SELECT * FROM SprGdePrm ORDER BY GdePrmNam";

        GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // SELECT SttStrKey AS STTKEY, SttStrNam AS STTNAM FROM SprSttStr WHERE SttStrFrm=" + BuxFrm + " AND SttStrLvl = 1 ORDER BY SttStrNam";

        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        //=====================================================================================

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  // && parCrdIdn.Value == ""
        {
            Session["AmbUslIdn"] = "Post";
            PushButton();
        }
        else Session["PostBack"] = "no";

        //============= начало  ===========================================================================================
        if (!Page.IsPostBack)
        {
            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
            parCrdIdn.Value = AmbCrdIdn;
        }

        getGrid();
        //   getDocNum();

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        string StxKey;
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

        if (ds.Tables[0].Rows.Count > 0)
        {
            StxKey = Convert.ToString(ds.Tables[0].Rows[0]["STXKEY"]);
            parGrfIIN.Value = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);

            sdsUsl.SelectCommand = "SELECT SprUsl.UslKod,SprUsl.UslNam " +
                                   "FROM  SprUsl INNER JOIN SprUslFrm INNER JOIN SprBuxUsl ON SprUslFrm.UslFrmHsp=SprBuxUsl.BuxUslFrm AND SprUslFrm.UslFrmKod=SprBuxUsl.BuxUslPrcKod " +
                                                                                         " ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                                                "INNER JOIN SprFrmStx ON SprUslFrm.UslFrmHsp=SprFrmStx.FrmStxKodFrm AND SprUslFrm.UslFrmPrc=SprFrmStx.FrmStxPrc " +
                                   "WHERE SprBuxUsl.BuxUslFrm=" + BuxFrm + " AND SprBuxUsl.BuxUslDocKod=" + BuxKod + " AND SprFrmStx.FrmStxKodStx='" +StxKey + "' AND SprUslFrm.UslFrmZen>0 " +
                                   "ORDER BY SprUsl.UslNam";


        }

        con.Close();

        sdsStx.SelectCommand = "SELECT CntKey AS StxKod,CntNam AS StxNam FROM SprCnt WHERE CntLvl=0 AND CntFrm=" + BuxFrm + " ORDER BY CntNam";

        GridUsl.DataSource = ds;
        GridUsl.DataBind();
    }

    void PushButton()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspDocAppLstSumIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.ExecuteNonQuery();

        con.Close();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        if (e.Record["USLKOD"] == null | e.Record["USLKOD"] == "") UslKod = 0;
        else UslKod = Convert.ToInt32(e.Record["USLKOD"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 1;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["STXKEY"] == null | e.Record["STXKEY"] == "") UslStx = "00000";
        else UslStx = Convert.ToString(e.Record["STXKEY"]);

        if (e.Record["USLKTO"] == null | e.Record["USLKTO"] == "") UslKto =  Convert.ToInt32(BuxKod);
        else UslKto = Convert.ToInt32(e.Record["USLKTO"]);

        if (e.Record["USLPRMGDE"] == null | e.Record["USLPRMGDE"] == "") UslGde = "";
        else UslGde = Convert.ToString(e.Record["USLPRMGDE"]);

        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = "";
        else UslNap = Convert.ToString(e.Record["USLNAP"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslRepGde", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = UslKod;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = UslKol;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLNAP", SqlDbType.VarChar).Value = UslNap;
        cmd.Parameters.Add("@USLKTO", SqlDbType.Int, 4).Value = UslKto;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLGDE", SqlDbType.VarChar).Value = UslGde;
        cmd.Parameters.Add("@USLMEM", SqlDbType.VarChar).Value = "";
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void RebindGrid(object sender, EventArgs e)
    {
        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmdDtl = new SqlCommand("DELETE FROM AMBUSLDTL WHERE USLDTLREF=" + UslIdn, con);
        cmdDtl.ExecuteNonQuery();
        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE USLIDN=" + UslIdn, con);
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

    // ==================================== ШАБЛОНЫ  ============================================
    //------------------------------------------------------------------------
    protected void SablonPrvDig(object sender, EventArgs e) { SablonPrv("Dig"); }
    protected void SablonPrvDsp(object sender, EventArgs e) { SablonPrv("Dsp"); }

    void SablonPrv(string SblTyp)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbSblPrv", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = SblTyp;
        // Выполнить команду
        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();

        //  getDocNum();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    //void getDocNum()
    //{
    //    string TekDat;
    //    //------------       чтение уровней дерево
    //    DataSet ds = new DataSet();
    //    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
    //    SqlConnection con = new SqlConnection(connectionString);
    //    con.Open();
    //    SqlCommand cmd = new SqlCommand("HspAmbDocIdn", con);
    //    // указать тип команды
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    // передать параметр
    //    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

    //    // создание DataAdapter
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    // заполняем DataSet из хран.процедуры.
    //    da.Fill(ds, "HspAmbDocIdn");

    //    con.Close();

    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
    //        Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
    //        Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
    //        Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
    //        Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);
    //        MkbSop001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP001"]);
    //        MkbSop002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP002"]);
    //        MkbSop003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP003"]);
    //    }

    //    //          string name = value ?? string.Empty;
    //}    // ======================================================================================
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
         <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parGrfIIN" runat="server" />

        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />

            <%-- ============================  шапка экрана ============================================ --%>
            <asp:TextBox ID="Sapka"
                Text="УСЛУГИ"
                BackColor="yellow"
                Font-Names="Verdana"
                Font-Size="12px"
                Font-Bold="True"
                ForeColor="Blue"
                Style="top: 0px; left: 0px; position: relative; width: 100%; text-align: center"
                runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 380px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
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
                <ClientSideEvents OnBeforeClientAdd="GridUsl_ClientAdd" 
                                  ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="USLKOD" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column03" DataField="USLNAP" HeaderText="№ НАПР" Width="5%" />
                    <obout:Column ID="Column04" DataField="KASOPL" HeaderText="КАССА" Width="4%" ReadOnly="true" />
                    <obout:Column ID="Column05" DataField="USLTRF" HeaderText="ТАРИФ" Width="6%" ReadOnly="true" />
                    <obout:Column ID="Column06" DataField="STXNAM" HeaderText="ВИД ОПЛ" ReadOnly="true" Width="8%" />
                    <obout:Column ID="Column07" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" ReadOnly="true" Width="24%" Align="left" />
                    <obout:Column ID="Column08" DataField="USLEXP" HeaderText="ДОР" Width="3%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column09" DataField="USLPRMGDE" HeaderText="ГДЕ" Width="6%" Align="center">
                        <TemplateSettings EditTemplateId="TemplateEditGde" />
                    </obout:Column>
                    <obout:Column ID="Column10" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="3%" Align="right" />
                    <obout:Column ID="Column11" DataField="USLKOL" HeaderText="КОЛ" Width="3%" Align="right" />
                    <obout:Column ID="Column12" DataField="USLZEN" HeaderText="ЦЕНА" Width="5%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column13" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column14" DataField="USLKTO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%">
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>

                    <obout:Column ID="Column15" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>

                   <obout:Column ID="Column16" DataField="IMGFLG" HeaderText="ОБРАЗ" Width="5%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateImg" />
                    </obout:Column>

                    <obout:Column ID="Column17" DataField="RSXFLG" HeaderText="ОПИСАНИЕ" Width="5%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateRsx" />
                    </obout:Column>
                    <obout:Column ID="Column18" DataField="SBLYESALL" HeaderText="+" Visible="false" Width="0%" />
               
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

               <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridUsl.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохр" class="tdTextSmall" onclick="GridUsl.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateImg">
                        <Template>
                            <input type="button" id="btnImg" class="tdTextSmall" value="Образ" onclick="WebCam(<%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                   			
<%--                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                       <Template>
                          <input type="button" id="btnRsx" class="tdTextSmall" value="Расход" onclick="GridUsl_rsx(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>--%>
                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                        <Template>
                            <input type="button" id="btnRsx" class="tdTextSmall" value="Опис." onclick="MedDocXls(<%# Container.PageRecordIndex %>)" />
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

                    <obout:GridTemplate runat="server" ControlID="ddlGde" ID="TemplateEditGde" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlGde" Width="100%" Height="150" MenuWidth="200"
                                DataSourceID="sdsGde" DataTextField="GdePrmNam" DataValueField="GdePrmNam">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

<%--                    <obout:GridTemplate runat="server" ID="TemplateStxNam">
                        <Template>
                            <%# Container.DataItem["StxNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlStxNam" ID="TemplateEditStxNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlStxNam" Width="100%" Height="150" MenuWidth="200"
                                DataSourceID="sdsStx" DataTextField="StxNam" DataValueField="StxKod">
                                <ClientSideEvents OnSelectedIndexChanged="loadUsl" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>--%>

<%--                    <obout:GridTemplate runat="server" ID="TemplateUslNam">
                        <Template>
                            <%# Container.DataItem["UslNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUslNam" ControlPropertyName="value">
                        <Template>
                            <input type="hidden" id="hiddenUslNam" />
                            <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="300" MenuWidth="800">
                                <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>--%>

                </Templates>
            </obout:Grid>

        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
                     Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
                <center>
                    <input type="button" value="Печать заказ-наряда" onclick="PrtZnrButton_Click()" />
                    <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
                </center>
          </asp:Panel> 

        <!--  -----------------------------------------------------------------------------------------------------------------------  -->
        <%-- ============================  шапка экрана ============================================ --%>
        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="200" Top="10" Height="350" Width="700" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGde" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }

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
        .ob_iTIE {
            font-size: larger;
            font: bold 12px Tahoma !important; /* для увеличение корректируемого текста*/
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



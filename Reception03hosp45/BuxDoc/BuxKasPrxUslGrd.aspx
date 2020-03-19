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

        function loadDoc(sender, index) {
            var SndPar = ddlDocNam.options[index].value;
            //          alert("loadStx 3 =" + SndPar);
            PageMethods.GetSprUsl(SndPar, onSprUslLoaded, onSprUslLoadedError);
            //         alert("loadStx 2 =" + SndPar);
        }


        function onSprUslLoaded(SprUsl) {
 //           alert("onSprUslLoaded=" + SprUsl);

            SprUslComboBox.options.clear();
            ddlDocNam.options.add("");   //   без этой строки не работает !!!!!!!!!!!!!!!!!!!!!!!!

//            ddlDocNam.options.add("");
//          alert(SprUsl.length);
            for (var i = 0; i < SprUsl.length; i++) {
                SprUslComboBox.options.add(SprUsl[i]);
  //              alert(SprUsl[i]);
            }
        }

        function onSprUslLoadedError() {
        }

        function updateSprUslSelection(sender, index) {
            document.getElementById('hiddenUslNam').value = sender.value();
        }


        function ExpKasMem() {

            var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
            //                    alert("GrfFio=" + GrfFio); 
            localStorage.setItem("KasSumMem", KasSumMem); //setter
            window.opener.HandlePopupResult(KasSumMem);
            //            window.parent.KltClose();
            self.close();
        }


        function GridUsl_add() {
        //    alert("GridUsl_add=");
            var BuxFrm = document.getElementById('parBuxFrm').value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/BuxKasPrxSpr.aspx?KasIdn=" + document.getElementById("parKasIdn").value + "&KasIin=" + document.getElementById("parKasIin").value, 
                            "ModalPopUp", "toolbar=no,width=1100,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/BuxKasPrxSpr.aspx?KasIdn=" + document.getElementById("parKasIdn").value + "&KasIin=" + document.getElementById("parKasIin").value,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1100px;dialogHeight:650px;");

      //      return true;
        }
        // ------------------------  нажать на кнопку из программы  ------------------------------------------------------------------       
        function UslRef() {
    //        alert("UslRef=");
            document.getElementById("ButtonRef").click();
        }

        // ------------------------  нажать на кнопку  ------------------------------------------------------------------
        function HandlePopupResult(result) {
            //         alert("result of popup is: " + result);
  //          alert("UslRef=");
            document.getElementById("ButtonRef").click();
        }


// -----------------------------------------------------------------------------------------------------------------------------

    </script>

</head>


<script runat="server">

    string GlvDocIdn;
    string GlvDocPrv;
    
    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";
    string AmbKasIdn = "";
    string AmbKasIin = "";
    string AmbKasFio = "";


    string MdbNam = "HOSPBASE";

    int UslIdn;
    int UslAmb;
    int UslNap;
    int UslBux;
    string UslStx;
    int UslLgt;
    int UslKol;
    int UslZen;
    int UslSum;    
    string UslNam;
    string UslDat = "";
    
    decimal ItgDocSum = 0;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbKasIdn = Convert.ToString(Request.QueryString["KasIdn"]);
        AmbKasIin = Convert.ToString(Request.QueryString["KasIin"]);
        AmbKasFio = Convert.ToString(Request.QueryString["KasFio"]);
       
        //=====================================================================================
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        parCrdIdn.Value = AmbCrdIdn;
        parKasIdn.Value = AmbKasIdn;
        parKasIin.Value = AmbKasIin;
        parKasFio.Value = AmbKasFio;
        //=====================================================================================
 
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
   //     sdsKto.SelectCommand = "BuxKasDocSel";
        //    sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

        //=====================================================================================

        if (!Page.IsPostBack)
        {
            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
  //          getDocNum();
            getGridUsl();
        }
        
        
  //      SprUslComboBox.Items.Clear();
  //      SprUslComboBox.DataBind();
      //  SprUslComboBox.options.clear();

    }

    // ============================ чтение таблицы а оп ==============================================
    // ======================================================================================
    
    
    // ============================ чтение таблицы а оп ==============================================
    void getGridUsl()
    {
        TxtIin.Text = AmbKasIin;
        TxtPth.Text = AmbKasFio;

        
 //       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslKas", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = AmbKasIdn;
        cmd.Parameters.Add("@KASIIN", SqlDbType.VarChar).Value = AmbKasIin;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslKas");

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();


    }

    void InsertRecordUsl(object sender, GridRecordEventArgs e)
    {
        //        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        //        else UslNap = Convert.ToInt32(e.Record["USLNAP"]);
  //      GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);

   //     AmbCrdIdn = 0;

        UslBux = Convert.ToInt32(e.Record["GRFKOD"]);
        UslNap = 0;
        UslStx = "00000";

        if (Convert.ToString(e.Record["GRFDAT"]) == null || Convert.ToString(e.Record["GRFDAT"]) == "") UslDat = "";
        else UslDat = Convert.ToString(e.Record["GRFDAT"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 1;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLSUM"] == null | e.Record["USLSUM"] == "") UslSum = 0;
        else UslSum = Convert.ToInt32(e.Record["USLSUM"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspKasUslStxAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIIN", SqlDbType.VarChar).Value = AmbKasIin;
        cmd.Parameters.Add("@USLPTH", SqlDbType.VarChar).Value = AmbKasFio;
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = AmbKasIdn;
        cmd.Parameters.Add("@USLBUX", SqlDbType.Int, 4).Value = UslBux;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = UslDat;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = UslKol;
        cmd.Parameters.Add("@USLSUM", SqlDbType.Int, 4).Value = UslSum;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;

        // создание команды

        cmd.ExecuteNonQuery();
        con.Close();

        //    TabButton_Click(this, EventArgs.Empty);   // нажатие кнопки в программе
        //   ExecOnLoad("ClickBut();");
        getGridUsl();
        
    }

    void UpdateRecordUsl(object sender, GridRecordEventArgs e)
    {
        AmbCrdIdn = Convert.ToString(e.Record["GRFIDN"]);
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);
        //       if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        //       else UslNap = Convert.ToInt32(e.Record["USLNAP"]);

        UslBux = Convert.ToInt32(e.Record["GRFKOD"]);

        UslNap = 0;

        UslStx = "00000";

        if (Convert.ToString(e.Record["GRFDAT"]) == null || Convert.ToString(e.Record["GRFDAT"]) == "") UslDat = "";
        else UslDat = Convert.ToString(e.Record["GRFDAT"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 1;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLZEN"] == null | e.Record["USLZEN"] == "") UslZen = 0;
        else UslZen = Convert.ToInt32(e.Record["USLZEN"]);

        if (e.Record["USLSUM"] == null | e.Record["USLSUM"] == "") UslSum = 0;
        else UslSum = Convert.ToInt32(e.Record["USLSUM"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspKasUslStxRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLBUX", SqlDbType.Int, 4).Value = UslBux;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = UslDat;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = UslKol;
        cmd.Parameters.Add("@USLZEN", SqlDbType.Int, 4).Value = UslZen;
        cmd.Parameters.Add("@USLSUM", SqlDbType.Int, 4).Value = UslSum;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGridUsl();
        
    }
    
    void RebindGridUsl(object sender, EventArgs e)
    {
        getGridUsl();
    }

    void DeleteRecordUsl(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGridUsl();
       
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddKasButton_Click(object sender, EventArgs e)
    {
        parKasOpr.Value = "+";
        btnKasOK();
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void DelKasButton_Click(object sender, EventArgs e)
    {
        parKasOpr.Value = "-";
        btnKasOK();
    }

    // ============================ одобрение для записи документа в базу ==============================================
    //    protected void btnKasOK_click(object sender, EventArgs e)
    protected void btnKasOK()
    {
        string LstIdn = "";

        if (GridUsl.SelectedRecords != null)
        {
            foreach (Hashtable oRecord in GridUsl.SelectedRecords)
            {
                LstIdn = LstIdn + Convert.ToInt32(oRecord["USLIDN"]).ToString("D10") + ":"; // форматирование строки дополнение ведущими нулями
            }

        }

        if (LstIdn.Length == 0)
        {
            //          ConfirmDialogKas.Visible = false;
            //          ConfirmDialogKas.VisibleOnLoad = false;

            return;
        }

  //      GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);

        //   GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUslKasAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = AmbKasIdn;
        cmd.Parameters.Add("@KASIIN", SqlDbType.VarChar).Value = AmbKasIin;
        cmd.Parameters.Add("@LSTIDN", SqlDbType.VarChar).Value = LstIdn;
        cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = parKasOpr.Value;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslKasAdd");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            parKasSum.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
            parKasMem.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
        }
        else
        {
            parKasSum.Value = "";
            parKasMem.Value = "";
        }

  //      getGridUsl();

        //      ConfirmDialogKas.Visible = false;
        //       ConfirmDialogKas.VisibleOnLoad = false;


        //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        ExecOnLoad("ExpKasMem();");
    }

    //----------------  ПЕЧАТЬ  --------------------------------------------------------
    protected void ZapAllButton_Click(object sender, EventArgs e)
    {
        string LstIdn = "";
        Hashtable dataIt = null;

        foreach (Obout.Grid.GridRow row in GridUsl.Rows)   // читать GRID
            {
                dataIt = row.ToHashtable() as Hashtable;
     //           LstIdn = LstIdn + Convert.ToInt32(row.FindControl("USLIDN")).ToString("D10") + ":"; // форматирование строки дополнение ведущими нулями
    //            txt = dataIt["ShipName"].ToString();
                LstIdn = LstIdn + Convert.ToInt32(dataIt["USLIDN"]).ToString("D10") + ":"; // форматирование строки дополнение ведущими нулями
            }


        if (LstIdn.Length == 0)
        {
            return;
        }

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUslKasAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = AmbKasIdn;
        cmd.Parameters.Add("@KASIIN", SqlDbType.VarChar).Value = AmbKasIin;
        cmd.Parameters.Add("@LSTIDN", SqlDbType.VarChar).Value = LstIdn;
        cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslKasAdd");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            parKasSum.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
            parKasMem.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
        }
        else
        {
            parKasSum.Value = "";
            parKasMem.Value = "";
        }

        //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
        ExecOnLoad("ExpKasMem();");
        
    }
//==================================================================================================================================================

    // ---------Суммация  ------------------------------------------------------------------------
    public void GridUsl_RowCreated(object sender, GridRowEventArgs e)
    {
        if (IsPostBack && e.Row.RowType == GridRowType.Header)
        {
            ItgDocSum = 0;
        }
    }
    // ---------Суммация  ------------------------------------------------------------------------
    public void GridUsl_RowDataBound(object sender, GridRowEventArgs e)
    {
        if (e.Row.RowType == GridRowType.DataRow)
        {
            if (e.Row.Cells[10].Text == null | e.Row.Cells[10].Text == "") ItgDocSum += 0;
            else ItgDocSum += decimal.Parse(e.Row.Cells[10].Text);
        }
        else if (e.Row.RowType == GridRowType.ColumnFooter)
        {
            e.Row.Cells[6].Text = "ИТОГО:";
            e.Row.Cells[10].Text = ItgDocSum.ToString();

        }
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    // ============================ отказ записи документа в базу ==============================================
    //----------------  ПЕЧАТЬ  --------------------------------------------------------

    // ============================ одобрение для записи документа в базу ==============================================
   
    
// =================================================================================================================================================
    [WebMethod]
    public static List<string> GetSprUsl(string StxKod)
    {
        List<string> SprUsl = new List<string>();

        string[] MasLst = StxKod.Split(':');


        if (!string.IsNullOrEmpty(StxKod))
        {
            string SqlStr;
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("HspAmbUslPltSou", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = MasLst[0];
            // создание команды

            con.Open();

            SqlDataReader myReader = cmd.ExecuteReader();
            while (myReader.Read())
            {
                SprUsl.Add(myReader.GetString(0));
            }

            con.Close();
        }

        return SprUsl;
    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parKasIin" runat="server" />
        <asp:HiddenField ID="parKasFio" runat="server" />
        <asp:HiddenField ID="parKasOpr" runat="server" />
        <asp:HiddenField ID="parKasSum" runat="server" />
        <asp:HiddenField ID="parKasMem" runat="server" />
        <input type="hidden" id="hiddenUslNam" />

        <%-- ============================  шапка экрана ============================================ --%>
<%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  ----------------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="10%" style="vertical-align: top;">
                        <asp:Label ID="Label4" Text="ИИН:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtIin" Width="20%" Height="20" BorderStyle="None" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:Label ID="Label3" Text="ПАЦИЕНТ:" runat="server" BorderStyle="None" Width="10%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtPth" Width="50%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 350px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
                   <obout:Grid ID="GridUsl" runat="server"
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
                        Width="99%"
                        AllowPageSizeSelection="false"
                        EnableTypeValidation="false"
     OnRowCreated="GridUsl_RowCreated"
     OnRowDataBound="GridUsl_RowDataBound"
                        OnRebind="RebindGridUsl" OnInsertCommand="InsertRecordUsl" OnDeleteCommand="DeleteRecordUsl" OnUpdateCommand="UpdateRecordUsl"
                        ShowColumnsFooter="true">
                        <ScrollingSettings ScrollHeight="270" />
                        <Columns>
                            <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                            <obout:Column ID="Column01" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%" />
                            <obout:Column ID="Column02" DataField="KASNUM" HeaderText="№.КАС" Width="4%" ReadOnly="true" />
                            <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="9%">
                                <TemplateSettings EditTemplateId="tplDatePickerDat" />
                            </obout:Column>
                            <obout:Column ID="Column04" DataField="GRFKOD" HeaderText="ВРАЧ" Width="15%">
                                <TemplateSettings TemplateId="TemplateDocNam" EditTemplateId="TemplateEditDocNam" />
                            </obout:Column>
                            <obout:Column ID="Column05" DataField="DLGNAM" HeaderText="СПЕЦ." Width="9%" ReadOnly="true" />
                            <obout:Column ID="Column06" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="32%" Align="left">
                                <TemplateSettings TemplateId="TemplateUslNam" EditTemplateId="TemplateEditUslNam" />
                            </obout:Column>
                            <obout:Column ID="Column07" DataField="USLLGT" HeaderText="ЛЬГ." Width="4%" Align="right" />
                            <obout:Column ID="Column08" DataField="USLKOL" HeaderText="КОЛ" Width="3%" Align="right" />
                            <obout:Column ID="Column09" DataField="USLZEN" HeaderText="ЦЕНА" Width="5%" Align="right" />
                            <obout:Column ID="Column10" DataField="USLSUM" HeaderText="СУММА" Width="7%" Align="right" />
                            <obout:Column ID="Column11" HeaderText="Коррек  Удаление" Width="12%" AllowEdit="true" AllowDelete="true" runat="server">
                                <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                            </obout:Column>
                        </Columns>

                        <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                        <Templates>
                            <obout:GridTemplate runat="server" ID="tplDatePickerDat" ControlID="txtOrderDateDat" ControlPropertyName="value">
                                <Template>
                                    <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                        <tr>
                                            <td valign="top">
                                                <obout:OboutTextBox runat="server" ID="txtOrderDateDat" Width="100%"
                                                    FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                            </td>
                                            <td valign="top" width="30">
                                                <obout:Calendar ID="calDat" runat="server"
                                                    StyleFolder="~/Styles/Calendar/styles/default"
                                                    DatePickerMode="true"
                                                    ShowYearSelector="true"
                                                    YearSelectorType="DropDownList"
                                                    TitleText="Выберите год: "
                                                    CultureName="ru-RU"
                                                    DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                            </td>
                                        </tr>
                                    </table>
                                </Template>
                            </obout:GridTemplate>


                            <obout:GridTemplate runat="server" ID="editBtnTemplate">
                                <Template>
                                    <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridUsl.edit_record(this)" />
                                    <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                                <Template>
                                    <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)" />
                                    <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="addTemplate">
                                <Template>
                                    <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl_add()" />
                               </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="saveTemplate">
                                <Template>
                                    <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUsl.insertRecord()" />
                                    <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()" />
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ID="TemplateDocNam">
                                <Template>
                                    <%# Container.DataItem["BuxNam"]%>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ControlID="ddlDocNam" ID="TemplateEditDocNam" ControlPropertyName="value">
                                <Template>
                                    <obout:ComboBox runat="server" ID="ddlDocNam" Width="100%" Height="150"
                                        FolderStyle="/Styles/Combobox/premiere_blue"
                                        DataSourceID="sdsKto" DataTextField="BUXNAM" DataValueField="BUXKOD">
                                        <ClientSideEvents OnSelectedIndexChanged="loadDoc" />
                                    </obout:ComboBox>
                                </Template>
                            </obout:GridTemplate>


                            <obout:GridTemplate runat="server" ID="TemplateUslNam">
                                <Template>
                                    <%# Container.DataItem["UslNam"]%>
                                </Template>
                            </obout:GridTemplate>

                            <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUslNam" ControlPropertyName="value">
                                <Template>
                                    <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="300" 
                                        DataTextField="UslNam" DataValueField="UslNam"
                                        FolderStyle="/Styles/Combobox/premiere_blue">
                                        <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                                    </obout:ComboBox>
                                </Template>
                            </obout:GridTemplate>


                        </Templates>
                    </obout:Grid>
        </asp:Panel>
          <%-- ============================  для выбора нескольких строк из COMBOBOXa
                                        <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUslNam" ControlPropertyName="value">
                                <Template>
                                    <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="300" 
                                        MultiSelectionSeparator="&" SelectionMode="Multiple" 
                                        DataTextField="UslNam" DataValueField="UslNam"
                                        FolderStyle="/Styles/Combobox/premiere_blue">
                                        <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                                    </obout:ComboBox>
                                </Template>
                            </obout:GridTemplate> 
              
              
              ============================================ --%>
<%-- ============================  нижний блок  ============================================ --%>
       <asp:Panel ID="PanelAkt" runat="server" BorderStyle="Double"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                <asp:Button ID="ButtonRef" runat="server" CommandName="Cancel" Text="Обновить" OnClick="RebindGridUsl" BackColor="#F0E68C" />
                <asp:Button ID="Button5" runat="server" CommandName="Cancel" Text="Добавить в кассу (все)" onclick="ZapAllButton_Click" BackColor="#F0E68C"/>
                <asp:Button ID="Button1" runat="server" CommandName="Cancel" Text="Добавить в кассу (отмечанные)" OnClick="AddKasButton_Click" BackColor="#F0E68C" />
                <asp:Button ID="Button3" runat="server" CommandName="Cancel" Text="Добавить в кассу" OnClick="AddKasButton_Click" BackColor="#F0E68C"/>
                <asp:Button ID="Button6" runat="server" CommandName="Cancel" Text="Удалить из кассы" OnClick="DelKasButton_Click" BackColor="#F0E68C" />
           </center>
        </asp:Panel>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
       <owd:Window ID="SprWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="20" Top="10" Height="400" Width="850" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="ПРОВОДКА">
       </owd:Window>  


    </form>

    <%-- ============================  STYLES ============================================ --%>

      <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="BuxKasDocSel" SelectCommandType="StoredProcedure" 
             ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="BuxFrmKod" Name="BUXFRM" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
<%--  ------------------------------------- для удаления отступов в GRID --------------------------------%>
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



<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Aspose.Cells" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript"></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript"></script>

    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />



    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#BrtDat').mask('D9.M9.Y999');
        };
        /*------------------------- Изиять переданный параметр --------------------------------*/
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

        /*------------------------- Изиять переданный параметр --------------------------------*/
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        function ExitFun() {
            self.close();
            window.opener.WindowClose();
        }

        // -----------------------------------------------------------------------------------
        //    ---------------- обращение веб методу --------------------------------------------------------

        function WebCam() {
            //    alert("WebCamToy");
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("https://webcamtoy.com/ru/", "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("https://webcamtoy.com/ru/", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

            return false;
        }
        // -----------------------------------------------------------------------------------


        function Sho001(Num) {
            var EodIdn = document.getElementById('parEodIdn').value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

            return false;
        }

        //  -------------------------------------------------------------------------------------------------
        function Del001(Num) {
            //    alert("onChangeJlb="+Num);
            if (confirm("Уверены, что хотите удалить?")) { }
            else return;

            //        alert("onChangeJlb=");

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            //           var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parEodIdn').value;
            //         alert("SqlStr=" + SqlStr);

            var SqlStr = "UPDATE TABEOD SET EODIMG00" + Num + "='' WHERE EODIDN=" + DatDocIdn;
            //         alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------
        function RslFlg_CheckedChanged(sender, isChecked) {
       //     alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
       //   //  alert(document.getElementById('Picture').style.visibility);
       //     //if (isChecked == true) document.getElementById('Picture').style.display = 'block'; 
       //     //else document.getElementById('Picture').style.display = 'none'; 

       ////     if (isChecked == true) document.getElementById('Picture').style.visibility = "visible";
       ////     else document.getElementById('Picture').style.visibility = "hidden";


       //     if (isChecked == true) {
       //         alert("true1");
       //         $('#Picture').attr('style', 'visibility:visible');
       //         alert("true2");
       //       //  document.getElementById('Picture').setAttribute('style', 'visibility:visible');
       //         alert("true6");
       //         //   $("#Picture").attr("style", "visibility: visible")
            //}
            //else {
            //    //   $("#Picture").attr("style", "visibility: hidden")
            //    document.getElementById('Picture').setAttribute('style', 'visibility:hidden');
            //    alert("false");
            //}

            //alert(document.getElementById('Picture').style.visibility);
        }

    </script>


</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string EodIdn;
    string EodKey;
    string EodTxt;
    string CntOneIdn;

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        EodIdn = Convert.ToString(Request.QueryString["EodIdn"]);
        EodKey = Convert.ToString(Request.QueryString["EodKey"]);
        EodTxt = Convert.ToString(Request.QueryString["EodTxt"]);
        //       KltStx = EodIdn.Substring(0, 5);

        BoxTit.Text = EodTxt;

        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTyp.SelectCommand = "SELECT * FROM SPREDOTYP WHERE EDOTYPVID='=' ORDER BY EDOTYPNAM";

        sdsIsp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsIsp.SelectCommand = "SELECT BUXKOD,FI FROM SPRBUXKDR WHERE ISNULL(BUXUBL,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI";

        GridIsp.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecordIsp);
        GridIsp.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordIsp);
        GridIsp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecordIsp);

        if (!Page.IsPostBack)
        {
            parEodIdn.Value = Convert.ToString(EodIdn);
            GetGrid();
            GetGridIsp();
        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGridIsp()
    {
        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT TABEODDTL.EodDtlIdn,TABEODDTL.EodDtlEnd,SprBuxKdr.BUXKOD, SprBuxKdr.FI,SprBuxKdr.DLGNAM,TABEODDTL.EodDtlWho," +
                                        "CASE WHEN EodDtlTyp=1 THEN 'True' ELSE '' END AS EODDTLISP," +
                                        "CASE WHEN EodDtlTyp=2 THEN 'True' ELSE '' END AS EODDTLSVD " +
                                        "FROM SprBuxKdr INNER JOIN TABEODDTL ON SprBuxKdr.BuxKod=TABEODDTL.EodDtlWho " +
                                        "WHERE TABEODDTL.EodDtlRef="+parEodIdn.Value + "ORDER BY SprBuxKdr.FI", con);
        //   cmd = new SqlCommand("EodLstGrdOne", con);
        // указать тип команды
        //  cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //  cmd.Parameters.Add("@EodIdn", SqlDbType.VarChar).Value = parEodIdn.Value;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "EodLstGrdIsp");

        //     if (ds.Tables[0].Rows.Count > 0)
        //      {
        GridIsp.DataSource = ds;
        GridIsp.DataBind();
        //     }
        // ------------------------------------------------------------------------------заполняем второй уровень
        ds.Dispose();
        con.Close();
    }


    void InsertRecordIsp(object sender, GridRecordEventArgs e)
    {
        int IspKod;

        if (Convert.ToString(e.Record["EODDTLWHO"]) == null || Convert.ToString(e.Record["EODDTLWHO"]) == "") IspKod = 0;
        else IspKod = Convert.ToInt32(e.Record["EODDTLWHO"]);


        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("INSERT INTO TABEODDTL (EODDTLREF,EODDTLTYP,EODDTLWHO) VALUES("+parEodIdn.Value+",1,"+Convert.ToString(IspKod)+")", con);
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //      ws.ComSprBuxAdd(MdbNam, BuxSid, BuxFrm, BuxTab, BuxDlg, BuxLog, BuxPsw);
        GetGridIsp();

    }


    void UpdateRecordIsp(object sender, GridRecordEventArgs e)
    {
        int IspKod;
        int EodIdn;
        int EodTyp;
        bool EodFlgIsp;
        bool EodFlgSvd;

        EodIdn = Convert.ToInt32(e.Record["EODDTLIDN"]);

        if (Convert.ToString(e.Record["EODDTLWHO"]) == null || Convert.ToString(e.Record["EODDTLWHO"]) == "") IspKod = 0;
        else IspKod = Convert.ToInt32(e.Record["EODDTLWHO"]);

        EodFlgIsp = Convert.ToBoolean(e.Record["EODDTLISP"]);
        EodFlgSvd = Convert.ToBoolean(e.Record["EODDTLSVD"]);

        if (EodFlgSvd == true) EodTyp = 2;
        else EodTyp = 1;

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE TABEODDTL SET EODDTLWHO="+Convert.ToString(IspKod)+
                                        ",EODDTLTYP="+Convert.ToString(EodTyp)+
                                        " WHERE EODDTLIDN="+Convert.ToString(EodIdn), con);
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        GetGridIsp();

    }

    void DeleteRecordIsp(object sender, GridRecordEventArgs e)
    {
        int EodIdn;

        EodIdn = Convert.ToInt32(e.Record["EODDTLIDN"]);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM TABEODDTL WHERE EODDTLIDN="+Convert.ToString(EodIdn), con);
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        GetGridIsp();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {
        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("EodLstGrdOne", con);
        cmd = new SqlCommand("EodLstGrdOne", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@EodIdn", SqlDbType.VarChar).Value = parEodIdn.Value;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "EodLstGrdOne");

        if (ds.Tables[0].Rows.Count > 0)
        {
            TxtRegNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodNum"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodDat"].ToString())) TxtDat.Text = "";
            else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["EodDat"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodEndDat"].ToString())) TxtEndDat.Text = "";
            else TxtEndDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["EodEndDat"]).ToString("dd.MM.yyyy");

            TxtPrf.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodPrf"]);

            TxtNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodNam"]);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodTyp"].ToString())) BoxTyp.SelectedValue = "0";
            else BoxTyp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodTyp"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EODRSLWHO"].ToString()) || Convert.ToString(ds.Tables[0].Rows[0]["EODRSLWHO"])=="0")
            {
                RslFlg.Checked = false;
                //Picture.Visible = false;
            }
            else
            {
                RslFlg.Checked = true;
                //Picture.Visible = true;
            }
            // ------------------------------------------------------------------------------заполняем второй уровень
            ds.Dispose();
            con.Close();
        }
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (TxtNam.Text.Length == 0)
        {
            Err.Text = "Не указан наименование документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата регистраций";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtEndDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата исполнения";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxTyp.SelectedValue == "")
        {
            Err.Text = "Не указан тип документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //---------------------------------------------- запись --------------------------
        string EodNum = "";
        string EodNam = "";
        string EodDat = "";
        string EodEndDat = "";
        string EodTyp = "";
        int EodRsl = 0;
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtRegNum.Text) == null || Convert.ToString(TxtRegNum.Text) == "") EodNum = "";
        else EodNum = Convert.ToString(TxtRegNum.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") EodNam = "";
        else EodNam = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtDat.Text) == null || Convert.ToString(TxtDat.Text) == "") EodDat = "";
        else EodDat = Convert.ToString(TxtDat.Text);

        if (Convert.ToString(TxtEndDat.Text) == null || Convert.ToString(TxtEndDat.Text) == "") EodEndDat = "";
        else EodEndDat = Convert.ToString(TxtEndDat.Text);

        //     obout:ComboBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(BoxTyp.SelectedValue) == null || Convert.ToString(BoxTyp.SelectedValue) == "") EodTyp = "";
        else EodTyp = Convert.ToString(BoxTyp.SelectedValue);

        if (RslFlg.Checked == true) EodRsl = 9999;
        else EodRsl = 0;

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // ------------------------------------------------------------------------------заполняем второй уровень
        SqlCommand cmd = new SqlCommand("UPDATE TABEOD SET EODNUM="+EodNum+
                                                         ",EODNAM='"+EodNam+
                                                         "',EODRSLWHO="+EodRsl+
                                                         ",EODDAT=CONVERT(DATETIME,'" + EodDat + "',103)"+
                                                         ",EODENDDAT=CONVERT(DATETIME,'" + EodEndDat + "',103)"+
                                                         ",EODTYP="+EodTyp+" WHERE EODIDN="+Convert.ToString(EodIdn), con);

        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");
    }


    // ============================ загрузка EXCEL в базу ==============================================
    // ============================ загрузка EXCEL в базу ==============================================

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void NewButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (TxtNam.Text.Length == 0)
        {
            Err.Text = "Не указан наименование документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата регистраций";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtEndDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата исполнения";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxTyp.SelectedValue == "")
        {
            Err.Text = "Не указан тип документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //---------------------------------------------- запись --------------------------
        string EodNum = "";
        string EodNam = "";
        string EodDat = "";
        string EodEndDat = "";
        string EodTyp = "";
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtRegNum.Text) == null || Convert.ToString(TxtRegNum.Text) == "") EodNum = "";
        else EodNum = Convert.ToString(TxtRegNum.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") EodNam = "";
        else EodNam = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtDat.Text) == null || Convert.ToString(TxtDat.Text) == "") EodDat = "";
        else EodDat = Convert.ToString(TxtDat.Text);

        if (Convert.ToString(TxtEndDat.Text) == null || Convert.ToString(TxtEndDat.Text) == "") EodEndDat = "";
        else EodEndDat = Convert.ToString(TxtEndDat.Text);

        //     obout:ComboBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(BoxTyp.SelectedValue) == null || Convert.ToString(BoxTyp.SelectedValue) == "") EodTyp = "";
        else EodTyp = Convert.ToString(BoxTyp.SelectedValue);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // ------------------------------------------------------------------------------заполняем второй уровень
        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE TABEOD SET EODNUM="+EodNum+
                                                         ",EODNAM='"+EodNam+
                                                         "',EODSTS='6.3.1'"+
                                                         ",EODRSLWHO=0"+
                                                         ",EODDAT=CONVERT(DATETIME,'" + EodDat + "',103)"+
                                                         ",EODENDDAT=CONVERT(DATETIME,'" + EodEndDat + "',103)"+
                                                         ",EODTYP="+EodTyp+" WHERE EODIDN="+Convert.ToString(EodIdn), con);
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void IspButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (TxtNam.Text.Length == 0)
        {
            Err.Text = "Не указан наименование документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата регистраций";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TxtEndDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата исполнения";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxTyp.SelectedValue == "")
        {
            Err.Text = "Не указан тип документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (!RslFlg.Checked)
        {
            Err.Text = "Документ не одобрен для исполнения";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //---------------------------------------------- запись --------------------------
        string EodPrf = "";
        string EodNum = "";
        string EodNam = "";
        string EodDat = "";
        string EodEndDat = "";
        string EodTyp = "";
        int EodRsl = 0;
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtPrf.Text) == null || Convert.ToString(TxtPrf.Text) == "") EodPrf = "";
        else EodPrf = Convert.ToString(TxtPrf.Text);

        if (Convert.ToString(TxtRegNum.Text) == null || Convert.ToString(TxtRegNum.Text) == "") EodNum = "";
        else EodNum = Convert.ToString(TxtRegNum.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") EodNam = "";
        else EodNam = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtDat.Text) == null || Convert.ToString(TxtDat.Text) == "") EodDat = "";
        else EodDat = Convert.ToString(TxtDat.Text);

        if (Convert.ToString(TxtEndDat.Text) == null || Convert.ToString(TxtEndDat.Text) == "") EodEndDat = "";
        else EodEndDat = Convert.ToString(TxtEndDat.Text);

        //     obout:ComboBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(BoxTyp.SelectedValue) == null || Convert.ToString(BoxTyp.SelectedValue) == "") EodTyp = "";
        else EodTyp = Convert.ToString(BoxTyp.SelectedValue);

        if (Convert.ToString(RslFlg.Text) == "Checked = true") EodRsl = 9999;
        else EodRsl = 0;


        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // ------------------------------------------------------------------------------заполняем второй уровень
        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE TABEOD SET EODNUM="+EodNum+
                                                         ",EODPRF='"+EodPrf+
                                                         "',EODNAM='"+EodNam+
                                                         "',EODSTS='6.3.4'"+
                                                         ",EODRSLWHO="+EodRsl+
                                                         ",EODDAT=CONVERT(DATETIME,'" + EodDat + "',103)"+
                                                         ",EODENDDAT=CONVERT(DATETIME,'" + EodEndDat + "',103)"+
                                                         ",EODTYP="+EodTyp+" WHERE EODIDN="+parEodIdn.Value, con);
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");
    }


</script>


<body>

    <form id="form1" runat="server">


        <asp:HiddenField ID="parEodIdn" runat="server" />
        <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 510px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">

                <!--  Регистрационный номер ----------------------------------------------------------------------------------------------------------  -->
                <!--  Тип ----------------------------------------------------------------------------------------------------------  -->
                <!-- Кому  ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" class="PO_RowCap">&nbsp;Рег.номер:</td>
                    <td width="55%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtPrf" Width="15%" BackColor="White" Height="35px" ReadOnly="true"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        <obout:OboutTextBox runat="server" ID="TxtRegNum" Width="10%" BackColor="White" Height="35px" ReadOnly="true"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        &nbsp; от: 
                                 <obout:OboutTextBox runat="server" ID="TxtDat" Width="20%" BackColor="White" Height="35px" ReadOnly="true"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                                 </obout:OboutTextBox>
                        <obout:Calendar ID="Calendar1" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtDat"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                        &nbsp;&nbsp;&nbsp; до: 
                                 <obout:OboutTextBox runat="server" ID="TxtEndDat" Width="20%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                                 </obout:OboutTextBox>
                        <obout:Calendar ID="Calendar2" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtEndDat"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                    </td>
                    <td width="5%" class="PO_RowCap">&nbsp;Тип:</td>
                    <td width="30%" style="vertical-align: top;">
                        <obout:ComboBox runat="server" ID="BoxTyp" Width="85%" Height="200" MenuWidth="300" ReadOnly="true"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsTyp" DataTextField="EDOTYPNAM" DataValueField="EDOTYPKOD">
                        </obout:ComboBox>
                    </td>
                </tr>
            </table>

            <hr />

            <%-- ============================  верхний блок  ============================================ --%>
            <table border="0" cellspacing="0" width="100%" bgcolor="white" cellpadding="0">
                <!--  Поручение ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 10px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Поручение:</td>
                    <td width="85%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtNam" Width="99%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>


            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Исполнитель ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 65px;">
                    <td width="10%" style="vertical-align: top; background-color: white;" class="PO_RowCap">&nbsp;Исполнитель: 
                    </td>
                    <td width="85%" style="vertical-align: top;">
                        <asp:Panel ID="PanelIsp" runat="server" BorderStyle="Double"
                            Style="left: 0px; position: relative; top: 0px; width: 98%; height: 250px;">
                            <obout:Grid ID="GridIsp" runat="server"
                                CallbackMode="true"
                                Serialize="true"
                                FolderStyle="~/Styles/Grid/style_5"
                                AutoGenerateColumns="false"
                                ShowTotalNumberOfPages="false"
                                FolderLocalization="~/Localization"
                                Language="ru"
                                PageSize="-1"
                                AllowAddingRecords="false"
                                AllowFiltering="false"
                                ShowColumnsFooter="false"
                               ShowHeader="true"
                                AllowPaging="false"
                                Width="100%"
                                AllowPageSizeSelection="false">
                                <ScrollingSettings ScrollHeight="195" />
                                <Columns>
                                    <obout:Column ID="Column00" DataField="EODDTLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                                    <obout:Column ID="Column01" DataField="EODDTLREF" HeaderText="Идн" Visible="false" Width="0%" />
                                    <obout:Column ID="Column02" DataField="EODDTLWHO" HeaderText="ИСПОЛНИТЕЛЬ" Width="30%">
                                        <TemplateSettings TemplateId="TemplateIspNam" EditTemplateId="TemplateEditIspNam" />
                                    </obout:Column>
                                    <obout:Column ID="Column03" DataField="DLGNAM" HeaderText="СПЕЦ" ReadOnly="true" Width="35%" />
                                    <obout:Column ID="Column04" DataField="EODDTLISP" HeaderText="ИСПОЛНИТЕЛЬ" Align="center" Width="10%">
                                        <TemplateSettings TemplateId="TemplateIspFlg" EditTemplateId="TemplateEditIspFlg" />
                                    </obout:Column>
                                    <obout:Column ID="Column05" DataField="EODDTLSVD" HeaderText="К СВЕДЕНИЮ" Align="center" Width="10%">
                                        <TemplateSettings TemplateId="TemplateSvdFlg" EditTemplateId="TemplateEditSvdFlg" />
                                    </obout:Column>

                                    <obout:Column ID="Column06" DataField="EODDTLEND" HeaderText="ДАТА ВЫП." ReadOnly="true" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="10%" />

                                    <obout:Column HeaderText="ИЗМ" Width="5%" AllowEdit="false" AllowDelete="false" runat="server" />
                                </Columns>

                                <Templates>

                                    <obout:GridTemplate runat="server" ID="TemplateIspNam">
                                        <Template>
                                            <%# Container.DataItem["FI"]%>
                                        </Template>
                                    </obout:GridTemplate>

                                    <obout:GridTemplate runat="server" ID="TemplateEditIspNam" ControlID="ddlIspNam" ControlPropertyName="value">
                                        <Template>
                                            <asp:DropDownList ID="ddlIspNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsIsp" CssClass="ob_gEC" DataTextField="FI" DataValueField="BUXKOD">
                                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>
                                        </Template>
                                    </obout:GridTemplate>

                                    <obout:GridTemplate runat="server" ID="TemplateIspFlg" UseQuotes="true">
                                        <Template>
                                            <%# (Container.Value == "True" ? "+" : " ") %>
                                        </Template>
                                    </obout:GridTemplate>
                                    <obout:GridTemplate runat="server" ID="TemplateEditIspFlg" ControlID="chkIsp" ControlPropertyName="checked" UseQuotes="false">
                                        <Template>
                                            <input type="checkbox" id="chkIsp" />
                                        </Template>
                                    </obout:GridTemplate>

                                    <obout:GridTemplate runat="server" ID="TemplateSvdFlg" UseQuotes="true">
                                        <Template>
                                            <%# (Container.Value == "True" ? "+" : " ") %>
                                        </Template>
                                    </obout:GridTemplate>
                                    <obout:GridTemplate runat="server" ID="TemplateEditSvdFlg" ControlID="chkSvd" ControlPropertyName="checked" UseQuotes="false">
                                        <Template>
                                            <input type="checkbox" id="chkSvd" />
                                        </Template>
                                    </obout:GridTemplate>


                                </Templates>

                            </obout:Grid>

                        </asp:Panel>
                    </td>
                </tr>
            </table>


            <hr />
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Вложения ------------------------------------------------------------------------------------------------  -->
                
                <tr style="height: 20px">

                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">
                        <asp:Label ID="Lbl000" Text="Одобряю:" runat="server" Width="70%" Font-Bold="true" Font-Size="Medium" />
                         <obout:OboutCheckBox runat="server" ID="RslFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                                <ClientSideEvents OnCheckedChanged="RslFlg_CheckedChanged" />
		                 </obout:OboutCheckBox>  
                       </td>
                    <td width="35%" style="vertical-align: top;">
<%--                        <asp:Image  Enabled="True" Height="50px" ID="Picture" ImageUrl="../Logo/RFMCsign.jpg" Width="200px" runat="server" Visible="false"   />  --%>
<%--                        <img id="Picture" src="/Logo/RFMCsign.jpg" alt="Start" style="Height:25px; Width:150px; visibility:hidden;" runat="server"  />--%>
                    </td>

                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Вложения:</td>

                    <td width="35%" style="vertical-align: top;">
                        <table border="0" cellspacing="0" width="100%" cellpadding="0">
                            <%-- ============================  1  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Label3" Text="1.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
<%--                                    <asp:Button ID="ButUpl001" runat="server" OnClick="Import001_Click" Text="Загрузить" />--%>
                                    <button id="Swo1" onclick="Sho001(1);">
                                        <img id="img11" src="/Icon/Show.png" alt="Start"></button>
<%--                                    <button id="Del1" onclick="Del001(1);">
                                        <img id="img12" src="/Icon/DELETE.PNG" alt="Start"></button>--%>
                                </td>
                            </tr>
                            <%-- ============================  2  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl002" Text="2.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
<%--                                    <asp:Button ID="ButUpl002" runat="server" OnClick="Import002_Click" Text="Загрузить" />--%>
                                    <button id="Swo2" onclick="Sho001(2);">
                                        <img id="img21" src="/Icon/Show.png" alt="Start"></button>
<%--                                    <button id="Del2" onclick="Del001(2);">
                                        <img id="img22" src="/Icon/DELETE.PNG" alt="Start"></button>--%>
                                </td>
                            </tr>

                            <%-- ============================  3  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl003" Text="3.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
<%--                                    <asp:Button ID="ButUpl003" runat="server" OnClick="Import003_Click" Text="Загрузить" />--%>
                                    <button id="Swo3" onclick="Sho001(3);">
                                        <img id="img31" src="/Icon/Show.png" alt="Start"></button>
<%--                                    <button id="Del3" onclick="Del001(3);">
                                        <img id="img32" src="/Icon/DELETE.PNG" alt="Start"></button>--%>
                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>
            </table>


        </asp:Panel>

        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
            <center>
                <asp:Button ID="Button1" runat="server" CommandName="Add" Style="display: none" Text="1" />
                <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать" />
                <asp:Button ID="NewButton" runat="server" CommandName="Add" OnClick="NewButton_Click" Text="Вернуть на новый"/>
                <asp:Button ID="IspButton" runat="server" CommandName="Add" OnClick="IspButton_Click" Text="Отправить на исполнение"/>
            </center>
        </asp:Panel>

        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="KltWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="20" Height="450" Width="1000" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue"
            Title="">
        </owd:Window>
        <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
        <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
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
        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <%-- ============================  для windowalert ============================================ --%>
        <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    </form>

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
                                <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="AddButton_Click" OnClientClick="requestPermission();" />
                               <obout:OboutButton runat="server" ID="OboutButton0"   
                                   FolderStyle="styles/grand_gray/OboutButton" Text="ОК" OnClick="AddButton_Click"
		                           OnClientClick="requestPermission();" />
    --%>

    <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsIsp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	

    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
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

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        /*.ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
        }*/

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

        /*------------------------- для excel-textbox  --------------------------------*/
        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
        .ob_iTIE {
            font-size: xx-large;
            font: bold 14px Tahoma !important; /* для увеличение корректируемого текста*/
        }

        hr {
            border: none; /* Убираем границу */
            background-color: red; /* Цвет линии */
            color: red; /* Цвет линии для IE6-7 */
            height: 2px; /* Толщина линии */
        }
    </style>


</body>

</html>



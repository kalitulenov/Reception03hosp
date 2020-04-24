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
                window.open("https://webcamtoy.com/ru/", "ModalPopUp", "toolbar=no,width=1200,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("https://webcamtoy.com/ru/", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

            return false;
        }
        // -----------------------------------------------------------------------------------


        function Sho001(Num) {
            var EodIdn = document.getElementById('parEodIdn').value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "toolbar=no,width=1200,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

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

        //  -------------------------------------------------------------------------------------------------
        function ComboBox1_SelectedIndexChanged(sender, selectedIndex, param1, param2) {
            var DatDocIdn = document.getElementById('parEodIdn').value;
            var DatDocVal = BoxTyp.options[BoxTyp.selectedIndex()].value;
            //alert("DatDocIdn=" + DatDocIdn);
            //alert("DatDocVal=" + DatDocVal);

            var ParStr = DatDocIdn + ':' + DatDocVal + ':';

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/EodLstGrdOneNum',
                contentType: "application/json; charset=utf-8",
                data: '{"ParStr":"' + ParStr + '"}',
                dataType: "json",
                success: function (msg) {
                    //        alert("msg=" + msg);
                            //alert("msg.d=" + msg.d);
                    var hashes = msg.d.split(':');
                    document.getElementById("TxtPrf").value = hashes[0];
                    document.getElementById("TxtRegNum").value = hashes[1];
                },
                error: function () { }
            });
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
     //   parEodIdn.Value = EodIdn;

        BoxTit.Text = EodTxt;

        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTyp.SelectCommand = "SELECT * FROM SPREDOTYP WHERE EDOTYPVID='=' ORDER BY EDOTYPNAM";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm;

        sdsDst.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDst.SelectCommand = "SELECT * FROM SPREDODST ORDER BY EDODSTNAM";

        //sdsRsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //sdsRsl.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIO FROM SPRBUXKDR WHERE BUXFRM=" + BuxFrm + " ORDER BY FIO";

        //sdsSvd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //sdsSvd.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIO FROM SPRBUXKDR WHERE BUXFRM=" + BuxFrm + " ORDER BY FIO";

        sdsIsp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsIsp.SelectCommand = "SELECT BUXKOD,FI FROM SPRBUXKDR WHERE ISNULL(BUXUBL,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI";

        GridIsp.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecordIsp);
        GridIsp.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordIsp);
        GridIsp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecordIsp);

        //GridSvd.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecordSvd);
        //GridSvd.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordSvd);
        //GridSvd.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecordSvd);


        if (!Page.IsPostBack)
        {
            parEodIdn.Value = Convert.ToString(EodIdn);
            if (parEodIdn.Value == "0")  // новый документ
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("EodLstGrdOneAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                //    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@EODKEY", SqlDbType.VarChar).Value = EodKey;
                cmd.Parameters.Add("@EODVID", SqlDbType.VarChar).Value = "=";
                cmd.Parameters.Add("@EODIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@EODIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    parEodIdn.Value = Convert.ToString(cmd.Parameters["@EODIDN"].Value);
                }
                finally
                {
                    con.Close();
                }
                //                 Session["SprUslIdnTek"] = "Post";
            }

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
        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        ds.Dispose();
        con.Close();
    }

    protected void AllFlg_CheckedChanged(object sender, EventArgs e)
    {
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (AllFlg.Checked)
        {
            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO TABEODDTL (EODDTLREF,EODDTLTYP,EODDTLWHO) " +
                                            "SELECT " + parEodIdn.Value + ",1,BuxKod FROM SprBuxKdr WHERE BuxFrm=" + BuxFrm + " AND ISNULL(BuxUbl,0)=0", con);
            cmd.ExecuteNonQuery();
        }
        else
        {
            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM TABEODDTL WHERE EODDTLTYP=1 AND EODDTLREF=" + parEodIdn.Value, con);
            cmd.ExecuteNonQuery();
        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание команды
        con.Close();
        GetGridIsp();
    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        //if (TxtNam.Text.Length == 0)
        //{
        //    Err.Text = "Не указан наименование документа";
        //    ConfirmOK.Visible = true;
        //    ConfirmOK.VisibleOnLoad = true;
        //    return;
        //}

        //if (TxtDat.Text.Length == 0)
        //{
        //    Err.Text = "Не указан дата регистраций";
        //    ConfirmOK.Visible = true;
        //    ConfirmOK.VisibleOnLoad = true;
        //    return;
        //}

        //if (TxtEndDat.Text.Length == 0)
        //{
        //    Err.Text = "Не указан дата исполнения";
        //    ConfirmOK.Visible = true;
        //    ConfirmOK.VisibleOnLoad = true;
        //    return;
        //}

        //if (BoxTyp.SelectedValue == "")
        //{
        //    Err.Text = "Не указан тип документа";
        //    ConfirmOK.Visible = true;
        //    ConfirmOK.VisibleOnLoad = true;
        //    return;
        //}

        //---------------------------------------------- запись --------------------------
        string EodPrf = "";
        string EodNum = "";
        string EodNam = "";
        string EodDat = "";
        string EodEndDat = "";
        string EodTyp = "";
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtPrf.Text) == null || Convert.ToString(TxtPrf.Text) == "") EodNum = "";
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

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // ------------------------------------------------------------------------------заполняем второй уровень
        SqlCommand cmd = new SqlCommand("UPDATE TABEOD SET EODPRF='"+EodPrf+
                                                         "',EODNUM="+EodNum+
                                                         ",EODNAM='"+EodNam+
                                                         "',EODDAT=CONVERT(DATETIME,'" + EodDat + "',103)"+
                                                         ",EODENDDAT=CONVERT(DATETIME,'" + EodEndDat + "',103)"+
                                                         ",EODTYP="+EodTyp+" WHERE EODIDN="+parEodIdn.Value, con);

        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");
    }


    // ============================ загрузка EXCEL в базу ==============================================
    protected void Import001_Click(object sender, EventArgs e)
    {
        ImportImg("1");
    }
    protected void Import002_Click(object sender, EventArgs e)
    {
        ImportImg("2");
    }
    protected void Import003_Click(object sender, EventArgs e)
    {
        ImportImg("3");
    }
    protected void Import004_Click(object sender, EventArgs e)
    {
        ImportImg("4");
    }
    protected void Import005_Click(object sender, EventArgs e)
    {
        ImportImg("5");
    }
    // ============================ загрузка EXCEL в базу ==============================================
    protected void ImportImg(string NumImg)
    {
        string UplFilNam;
        string UplFilNamExt;

        EodIdn = Convert.ToString(Session["EodIdn"]);

        if (FilUpl001.FileName == "") return;
        else UplFilNam = FilUpl001.FileName;

        //           string file=""; // the file to upload</param>
        //           string host = @"ftp:\\178.162.199.27"; // the host we're uploading to</param>
        //	       string username=@""; //our login username</param>
        //	       string password=@""; //our login password</param>
        //           string folderToUploadTo = @"C:\BASEIMG"; //the folder we're uploading to</param>
        //           KeyStx = Convert.ToInt32(BoxStx.SelectedValue).ToString("D5");
        // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
        //            string Papka = @"C:\BASEIMG\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
        //            string ImgFil = Papka + @"\" + GrfPth.Substring(0, 12) + "_" + Convert.ToInt32(TekDocIdn).ToString("D10") + ".jpg";

        //  parGrfPth.Value = parGrfPth.Value + "____________";

        string Papka = @"C:\BASEDELO\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
        string ImgFil = Papka + @"\" + Convert.ToInt32(parEodIdn.Value).ToString("D10") + "_" + NumImg;
        int i = 0;

        System.IO.FileInfo fi = new System.IO.FileInfo(UplFilNam);
        UplFilNamExt = fi.Extension;

        if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0 ||
            fi.Extension.CompareTo(".doc") == 0 || fi.Extension.CompareTo(".docx") == 0 || fi.Extension.CompareTo(".rtf") == 0 ||
            fi.Extension.CompareTo(".xls") == 0 || fi.Extension.CompareTo(".xlsx") == 0 ||
            fi.Extension.CompareTo(".JPG") == 0 || fi.Extension.CompareTo(".JPEG") == 0 || fi.Extension.CompareTo(".pdf") == 0)
        {

            if (fi.Extension.CompareTo(".doc") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".docx") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".xls") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".xlsx") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".rtf") == 0) ImgFil = ImgFil + ".pdf";
            /*
            if (fi.Extension.CompareTo(".doc") == 0) ImgFil = ImgFil + ".doc";
            if (fi.Extension.CompareTo(".docx") == 0) ImgFil = ImgFil + ".docx";
            if (fi.Extension.CompareTo(".xls") == 0) ImgFil = ImgFil + ".xls";
            if (fi.Extension.CompareTo(".xlsx") == 0) ImgFil = ImgFil + ".xlsx";
            if (fi.Extension.CompareTo(".rtf") == 0) ImgFil = ImgFil + ".rtf";
            */

            if (fi.Extension.CompareTo(".pdf") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0) ImgFil = ImgFil + ".jpg";

            // поверить каталог, если нет создать ----------------------------------------------------------------
            if (Directory.Exists(Papka)) i = 0;
            else Directory.CreateDirectory(Papka);

            // сформировать имя фаила ----------------------------------------------------------------
            //            string ServerPath = Server.MapPath("~/Temp/" + parUslIdn.Value + ".jpg");
            string ServerPath = Server.MapPath("~/Temp/" + parEodIdn.Value + UplFilNamExt);
            // скачать фаил ----------------------------------------------------------------
            if (FilUpl001.FileName != "") FilUpl001.PostedFile.SaveAs(ServerPath);   //для upload  

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(ImgFil)) File.Delete(ImgFil);
            // скорировать скачанный файл ----------------------------------------------------------------

            if (FilUpl001.FileName != "")
            {
                if (fi.Extension.CompareTo(".doc") == 0 || fi.Extension.CompareTo(".docx") == 0 || fi.Extension.CompareTo(".rtf") == 0)
                {
                    Aspose.Words.Document document = new Aspose.Words.Document(ServerPath);
                    //Convert Word to PDF
                    document.Save(ImgFil);

                }
                else
                  if (fi.Extension.CompareTo(".xls") == 0 || fi.Extension.CompareTo(".xlsx") == 0)
                {
                    // Open an Excel file
                    Workbook workbook = new Workbook(ServerPath);

                    // Save the document in PDF format
                    workbook.Save(ImgFil, SaveFormat.Pdf);
                }
                else File.Copy(ServerPath, ImgFil); // для upload  
            }
            else File.Copy(UplFilNam, ImgFil);

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(ServerPath)) File.Delete(ServerPath);

            // ЗАПИСАТЬ НА ДИСК ----------------------------------------------------------------

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmdUsl = new SqlCommand("UPDATE TABEOD SET EODIMG00" + NumImg + "='" + ImgFil + "' WHERE EODIDN=" + parEodIdn.Value, con);
            cmdUsl.ExecuteNonQuery();
            con.Close();

            //      file = @"C:\SkoolTestAdm\" + Convert.ToString(fi);  для FTP
            //      UploadFileToFtp(file, host, username, password, folderToUploadTo);

            //              Response.Write("Успешно");

            //Force clean up
            GC.Collect();
        }
        else
        {
            Response.Write("Тип файла не верен");
        }
        //               string path = string.Concat(Server.MapPath("~/Temp/"), FileUpload1.FileName);
        //Save File as Temp then you can delete it if you want
        //               FileUpload1.SaveAs(path);
        //string path = @"C:\Users\Johnney\Desktop\ExcelData.xls";

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

        //---------------------------------------------- запись --------------------------
        string EodPrf = "";
        string EodNum = "";
        string EodNam = "";
        string EodDat = "";
        string EodEndDat = "";
        string EodTyp = "";
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

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // ------------------------------------------------------------------------------заполняем второй уровень
        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE TABEOD SET EODNUM="+EodNum+
                                                         ",EODPRF='"+EodPrf+
                                                         "',EODNAM='"+EodNam+
                                                         "',EODSTS='6.3.2'"+
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
                        <obout:OboutTextBox runat="server" ID="TxtPrf" Width="15%" BackColor="White" Height="35px"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        <obout:OboutTextBox runat="server" ID="TxtRegNum" Width="10%" BackColor="White" Height="35px"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        &nbsp; от: 
                                 <obout:OboutTextBox runat="server" ID="TxtDat" Width="20%" BackColor="White" Height="35px"
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
                        <obout:ComboBox runat="server" ID="BoxTyp" Width="85%" Height="200" MenuWidth="300"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsTyp" DataTextField="EDOTYPNAM" DataValueField="EDOTYPKOD">
                            <ClientSideEvents
                                  OnSelectedIndexChanged="function(sender, selectedIndex) { ComboBox1_SelectedIndexChanged(sender, selectedIndex, 'param 1', 'param 2'); }"
                              />
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
                        <obout:OboutTextBox runat="server" ID="TxtNam" Width="99%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>


            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Исполнитель ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 65px;">
                    <td width="10%" style="vertical-align: top; background-color: white;" class="PO_RowCap">&nbsp;Исполнитель: 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Все&nbsp;:
                        <obout:OboutCheckBox runat="server" ID="AllFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox" AutoPostBack="true"
		                       OnCheckedChanged="AllFlg_CheckedChanged" >
                        </obout:OboutCheckBox>
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
                                AllowAddingRecords="true"
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
                                    <obout:Column ID="Column03" DataField="DLGNAM" HeaderText="СПЕЦ" ReadOnly="true" Width="30%" />
                                    <obout:Column ID="Column04" DataField="EODDTLISP" HeaderText="ИСПОЛНИТЕЛЬ" Align="center" Width="10%">
                                        <TemplateSettings TemplateId="TemplateIspFlg" EditTemplateId="TemplateEditIspFlg" />
                                    </obout:Column>
                                    <obout:Column ID="Column05" DataField="EODDTLSVD" HeaderText="К СВЕДЕНИЮ" Align="center" Width="10%">
                                        <TemplateSettings TemplateId="TemplateSvdFlg" EditTemplateId="TemplateEditSvdFlg" />
                                    </obout:Column>

                                    <obout:Column ID="Column06" DataField="EODDTLEND" HeaderText="ДАТА ВЫП." ReadOnly="true" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="10%" />

                                    <obout:Column HeaderText="ИЗМ УДЛ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server" />
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

                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Выбор файла:</td>
                    <td width="35%" style="vertical-align: top;">
                        <asp:Label ID="Lbl000" Text="ФАЙЛ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:FileUpload ID="FilUpl001" Height="25px" runat="server" />
                        </br>
                        <asp:Label ID="Label1" Text="WEBCAM:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <button id="Web" onclick="WebCam();">Вкл.&nbsp;&nbsp;камеру&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                    </td>

                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Вложения:</td>

                    <td width="35%" style="vertical-align: top;">
                        <table border="0" cellspacing="0" width="100%" cellpadding="0">
                            <%-- ============================  1  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Label3" Text="1.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="ButUpl001" runat="server" OnClick="Import001_Click" Text="Загрузить" />
                                    <button id="Swo1" onclick="Sho001(1);">
                                        <img id="img11" src="/Icon/Show.png" alt="Start"></button>
                                    <button id="Del1" onclick="Del001(1);">
                                        <img id="img12" src="/Icon/DELETE.PNG" alt="Start"></button>
                                </td>
                            </tr>
                            <%-- ============================  2  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl002" Text="2.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="ButUpl002" runat="server" OnClick="Import002_Click" Text="Загрузить" />
                                    <button id="Swo2" onclick="Sho001(2);">
                                        <img id="img21" src="/Icon/Show.png" alt="Start"></button>
                                    <button id="Del2" onclick="Del001(2);">
                                        <img id="img22" src="/Icon/DELETE.PNG" alt="Start"></button>
                                </td>
                            </tr>

                            <%-- ============================  3  ============================================ --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl003" Text="3.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="ButUpl003" runat="server" OnClick="Import003_Click" Text="Загрузить" />
                                    <button id="Swo3" onclick="Sho001(3);">
                                        <img id="img31" src="/Icon/Show.png" alt="Start"></button>
                                    <button id="Del3" onclick="Del001(3);">
                                        <img id="img32" src="/Icon/DELETE.PNG" alt="Start"></button>
                                </td>
                            </tr>

                            <%-- ============================  4  ============================================ --%>
<%--                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl004" Text="4.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="ButUpl004" runat="server" OnClick="Import004_Click" Text="Загрузить" />
                                    <button id="Swo4" onclick="Sho001(4);">
                                        <img id="img41" src="/Icon/Show.png" alt="Start"></button>
                                    <button id="Del4" onclick="Del001(3);">
                                        <img id="img42" src="/Icon/DELETE.PNG" alt="Start"></button>
                                </td>
                            </tr>--%>

                            <%-- ============================  5  ============================================ --%>
<%--                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Label ID="Lbl005" Text="5.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="ButUpl005" runat="server" OnClick="Import005_Click" Text="Загрузить" />
                                    <button id="Swo5" onclick="Sho001(5);">
                                        <img id="img51" src="/Icon/Show.png" alt="Start"></button>
                                    <button id="Del5" onclick="Del001(3);">
                                        <img id="img52" src="/Icon/DELETE.PNG" alt="Start"></button>
                                </td>
                            </tr>--%>
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
                <asp:Button ID="RslButton" runat="server" CommandName="Add" OnClick="IspButton_Click" Text="Отправить на резолюцию"/>
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
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsDst" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
<%--    <asp:SqlDataSource runat="server" ID="sdsRsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsSvd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>--%>
    
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



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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript" ></script>

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
        //    window.opener.HandlePopupResult("UslRef");
            self.close();
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
        sdsTyp.SelectCommand = "SELECT * FROM SPREDOTYP WHERE EDOTYPVID='+' ORDER BY EDOTYPNAM";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm;

        sdsDst.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDst.SelectCommand = "SELECT * FROM SPREDODST ORDER BY EDODSTNAM";

        sdsRsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsRsl.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIO FROM SPRBUXKDR WHERE BUXFRM="+ BuxFrm + " ORDER BY FIO";

        sdsSvd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSvd.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIO FROM SPRBUXKDR WHERE BUXFRM="+ BuxFrm + " ORDER BY FIO";

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
                cmd.Parameters.Add("@EODVID", SqlDbType.VarChar).Value = "+";
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


            //            if (String.IsNullOrEmpty(EodIdn)) EodIdn = null;
            //            else
            GetGrid();
        }
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

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodOutDat"].ToString())) TxtIsxDat.Text = "";
            else TxtIsxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["EodOutDat"]).ToString("dd.MM.yyyy");

            TxtOrgKto.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodOutFio"]);
            TxtIsxNom.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodOutNum"]);
            TxtDstInf.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodSndInf"]);
            TxtNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodNam"]);
            TxtDopInf.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodDopInf"]);
            TxtOrg.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodOutOrg"]);
            TxtPrf.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodPrf"]);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodInpOrg"].ToString())) BoxKom.SelectedValue = "0";
            else BoxKom.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodInpOrg"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodTyp"].ToString())) BoxTyp.SelectedValue = "0";
            else BoxTyp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodTyp"]);

            //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodOutOrg"].ToString())) BoxOrg.SelectedValue = "0";
            //    else BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodOutOrg"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodSndTyp"].ToString())) BoxVidDst.SelectedValue = "0";
            else BoxVidDst.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodSndTyp"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodRslWho"].ToString())) BoxRslWho.SelectedValue = "0";
            else BoxRslWho.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodRslWho"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodSvd001"].ToString())) BoxSvd001.SelectedValue = "0";
            else BoxSvd001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodSvd001"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodSvd002"].ToString())) BoxSvd002.SelectedValue = "0";
            else BoxSvd002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodSvd002"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodSvd003"].ToString())) BoxSvd003.SelectedValue = "0";
            else BoxSvd003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodSvd003"]);
        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        ds.Dispose();
        con.Close();
    }


    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (TxtDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата рагистраций";
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

        //       ConfirmDialog.Visible = true;
        //       ConfirmDialog.VisibleOnLoad = true;

        //   }

        //    protected void AddButton_Click(object sender, EventArgs e)
        //    {
        //---------------------------------------------- запись --------------------------
        string EodNum = "";
        string EodDat = "";
        string EodOutDat = "";
        string EodOutFio = "";
        string EodOutNum = "";
        string EodSndInf = "";
        string EodNam = "";
        string EodDopInf = "";
        string EodAttDoc = "";

        string EodInpOrg = "";
        string EodTyp = "";
        string EodOutOrg = "";
        string EodSndTyp = "";
        string EodRslWho = "";
        string EodSvd001 = "";
        string EodSvd002 = "";
        string EodSvd003 = "";

        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtRegNum.Text) == null || Convert.ToString(TxtRegNum.Text) == "") EodNum = "";
        else EodNum = Convert.ToString(TxtRegNum.Text);

        if (Convert.ToString(TxtDat.Text) == null || Convert.ToString(TxtDat.Text) == "") EodDat = "";
        else EodDat = Convert.ToString(TxtDat.Text);

        if (Convert.ToString(TxtIsxDat.Text) == null || Convert.ToString(TxtIsxDat.Text) == "") EodOutDat = "";
        else EodOutDat = Convert.ToString(TxtIsxDat.Text);

        if (Convert.ToString(TxtOrgKto.Text) == null || Convert.ToString(TxtOrgKto.Text) == "") EodOutFio = "";
        else EodOutFio = Convert.ToString(TxtOrgKto.Text);

        if (Convert.ToString(TxtIsxNom.Text) == null || Convert.ToString(TxtIsxNom.Text) == "") EodOutNum = "";
        else EodOutNum = Convert.ToString(TxtIsxNom.Text);

        if (Convert.ToString(TxtDstInf.Text) == null || Convert.ToString(TxtDstInf.Text) == "") EodSndInf = "";
        else EodSndInf = Convert.ToString(TxtDstInf.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") EodNam = "";
        else EodNam = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtDopInf.Text) == null || Convert.ToString(TxtDopInf.Text) == "") EodDopInf = "";
        else EodDopInf = Convert.ToString(TxtDopInf.Text);

        if (Convert.ToString(TxtOrg.Text) == null || Convert.ToString(TxtOrg.Text) == "") EodOutOrg = "";
        else EodOutOrg = Convert.ToString(TxtOrg.Text);

        //     obout:ComboBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(BoxKom.SelectedValue) == null || Convert.ToString(BoxKom.SelectedValue) == "") EodInpOrg = "";
        else EodInpOrg = Convert.ToString(BoxKom.SelectedValue);

        if (Convert.ToString(BoxTyp.SelectedValue) == null || Convert.ToString(BoxTyp.SelectedValue) == "") EodTyp = "";
        else EodTyp = Convert.ToString(BoxTyp.SelectedValue);

        //     if (Convert.ToString(BoxOrg.SelectedValue) == null || Convert.ToString(BoxOrg.SelectedValue) == "") EodOutOrg = "";
        //     else EodOutOrg = Convert.ToString(BoxOrg.SelectedValue);

        if (Convert.ToString(BoxVidDst.SelectedValue) == null || Convert.ToString(BoxVidDst.SelectedValue) == "") EodSndTyp = "";
        else EodSndTyp = Convert.ToString(BoxVidDst.SelectedValue);

        if (Convert.ToString(BoxRslWho.SelectedValue) == null || Convert.ToString(BoxRslWho.SelectedValue) == "") EodRslWho = "";
        else EodRslWho = Convert.ToString(BoxRslWho.SelectedValue);

        if (Convert.ToString(BoxSvd001.SelectedValue) == null || Convert.ToString(BoxSvd001.SelectedValue) == "") EodSvd001 = "";
        else EodSvd001 = Convert.ToString(BoxSvd001.SelectedValue);

        if (Convert.ToString(BoxSvd002.SelectedValue) == null || Convert.ToString(BoxSvd002.SelectedValue) == "") EodSvd002 = "";
        else EodSvd002 = Convert.ToString(BoxSvd002.SelectedValue);

        if (Convert.ToString(BoxSvd003.SelectedValue) == null || Convert.ToString(BoxSvd003.SelectedValue) == "") EodSvd003 = "";
        else EodSvd003 = Convert.ToString(BoxSvd003.SelectedValue);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("EodLstGrdOneRep", con);
        cmd = new SqlCommand("EodLstGrdOneRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@EodIdn", SqlDbType.VarChar).Value = parEodIdn.Value;   // EodIdn;
        cmd.Parameters.Add("@EodNum", SqlDbType.VarChar).Value = EodNum;
        cmd.Parameters.Add("@EodDat", SqlDbType.VarChar).Value = EodDat;
        cmd.Parameters.Add("@EodOutDat", SqlDbType.VarChar).Value = EodOutDat;
        cmd.Parameters.Add("@EodOutFio", SqlDbType.VarChar).Value = EodOutFio;
        cmd.Parameters.Add("@EodOutNum", SqlDbType.VarChar).Value = EodOutNum;
        cmd.Parameters.Add("@EodSndInf", SqlDbType.VarChar).Value = EodSndInf;

        cmd.Parameters.Add("@EodNam", SqlDbType.VarChar).Value = EodNam;
        cmd.Parameters.Add("@EodDopInf", SqlDbType.VarChar).Value = EodDopInf;
        cmd.Parameters.Add("@EodAttDoc", SqlDbType.VarChar).Value = "";   // EodAttDoc;
        cmd.Parameters.Add("@EodInpOrg", SqlDbType.VarChar).Value = EodInpOrg;
        cmd.Parameters.Add("@EodTyp", SqlDbType.VarChar).Value = EodTyp;
        cmd.Parameters.Add("@EodOutOrg", SqlDbType.VarChar).Value = EodOutOrg;
        cmd.Parameters.Add("@EodSndTyp", SqlDbType.VarChar).Value = EodSndTyp;
        cmd.Parameters.Add("@EodRslWho", SqlDbType.VarChar).Value = EodRslWho;
        cmd.Parameters.Add("@EodSvd001", SqlDbType.VarChar).Value = EodSvd001;
        cmd.Parameters.Add("@EodSvd002", SqlDbType.VarChar).Value = EodSvd002;
        cmd.Parameters.Add("@EodSvd003", SqlDbType.VarChar).Value = EodSvd003;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

        //           ConfirmDialog.Visible = false;
        //           ConfirmDialog.VisibleOnLoad = false;
        //    SelFio.Value = KltFio;
        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void RslButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (TxtDat.Text.Length == 0)
        {
            Err.Text = "Не указан дата рагистраций";
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

        if (BoxRslWho.SelectedValue == "")
        {
            Err.Text = "Не указан резолютор";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }



        //       ConfirmDialog.Visible = true;
        //       ConfirmDialog.VisibleOnLoad = true;

        //   }

        //    protected void AddButton_Click(object sender, EventArgs e)
        //    {
        //---------------------------------------------- запись --------------------------
        string EodNum = "";
        string EodDat = "";
        string EodOutDat = "";
        string EodOutFio = "";
        string EodOutNum = "";
        string EodSndInf = "";
        string EodNam = "";
        string EodDopInf = "";
        string EodAttDoc = "";

        string EodInpOrg = "";
        string EodTyp = "";
        string EodOutOrg = "";
        string EodSndTyp = "";
        string EodRslWho = "";
        string EodSvd001 = "";
        string EodSvd002 = "";
        string EodSvd003 = "";

        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        if (Convert.ToString(TxtRegNum.Text) == null || Convert.ToString(TxtRegNum.Text) == "") EodNum = "";
        else EodNum = Convert.ToString(TxtRegNum.Text);

        if (Convert.ToString(TxtDat.Text) == null || Convert.ToString(TxtDat.Text) == "") EodDat = "";
        else EodDat = Convert.ToString(TxtDat.Text);

        if (Convert.ToString(TxtIsxDat.Text) == null || Convert.ToString(TxtIsxDat.Text) == "") EodOutDat = "";
        else EodOutDat = Convert.ToString(TxtIsxDat.Text);

        if (Convert.ToString(TxtOrgKto.Text) == null || Convert.ToString(TxtOrgKto.Text) == "") EodOutFio = "";
        else EodOutFio = Convert.ToString(TxtOrgKto.Text);

        if (Convert.ToString(TxtIsxNom.Text) == null || Convert.ToString(TxtIsxNom.Text) == "") EodOutNum = "";
        else EodOutNum = Convert.ToString(TxtIsxNom.Text);

        if (Convert.ToString(TxtDstInf.Text) == null || Convert.ToString(TxtDstInf.Text) == "") EodSndInf = "";
        else EodSndInf = Convert.ToString(TxtDstInf.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") EodNam = "";
        else EodNam = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtDopInf.Text) == null || Convert.ToString(TxtDopInf.Text) == "") EodDopInf = "";
        else EodDopInf = Convert.ToString(TxtDopInf.Text);

        if (Convert.ToString(TxtOrg.Text) == null || Convert.ToString(TxtOrg.Text) == "") EodOutOrg = "";
        else EodOutOrg = Convert.ToString(TxtOrg.Text);

        //     obout:ComboBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(BoxKom.SelectedValue) == null || Convert.ToString(BoxKom.SelectedValue) == "") EodInpOrg = "";
        else EodInpOrg = Convert.ToString(BoxKom.SelectedValue);

        if (Convert.ToString(BoxTyp.SelectedValue) == null || Convert.ToString(BoxTyp.SelectedValue) == "") EodTyp = "";
        else EodTyp = Convert.ToString(BoxTyp.SelectedValue);

        //     if (Convert.ToString(BoxOrg.SelectedValue) == null || Convert.ToString(BoxOrg.SelectedValue) == "") EodOutOrg = "";
        //     else EodOutOrg = Convert.ToString(BoxOrg.SelectedValue);

        if (Convert.ToString(BoxVidDst.SelectedValue) == null || Convert.ToString(BoxVidDst.SelectedValue) == "") EodSndTyp = "";
        else EodSndTyp = Convert.ToString(BoxVidDst.SelectedValue);

        if (Convert.ToString(BoxRslWho.SelectedValue) == null || Convert.ToString(BoxRslWho.SelectedValue) == "") EodRslWho = "";
        else EodRslWho = Convert.ToString(BoxRslWho.SelectedValue);

        if (Convert.ToString(BoxSvd001.SelectedValue) == null || Convert.ToString(BoxSvd001.SelectedValue) == "") EodSvd001 = "";
        else EodSvd001 = Convert.ToString(BoxSvd001.SelectedValue);

        if (Convert.ToString(BoxSvd002.SelectedValue) == null || Convert.ToString(BoxSvd002.SelectedValue) == "") EodSvd002 = "";
        else EodSvd002 = Convert.ToString(BoxSvd002.SelectedValue);

        if (Convert.ToString(BoxSvd003.SelectedValue) == null || Convert.ToString(BoxSvd003.SelectedValue) == "") EodSvd003 = "";
        else EodSvd003 = Convert.ToString(BoxSvd003.SelectedValue);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("EodLstGrdOneRsl", con);
        cmd = new SqlCommand("EodLstGrdOneRsl", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@EodIdn", SqlDbType.VarChar).Value = parEodIdn.Value;   // EodIdn;
        cmd.Parameters.Add("@EodNum", SqlDbType.VarChar).Value = EodNum;
        cmd.Parameters.Add("@EodDat", SqlDbType.VarChar).Value = EodDat;
        cmd.Parameters.Add("@EodOutDat", SqlDbType.VarChar).Value = EodOutDat;
        cmd.Parameters.Add("@EodOutFio", SqlDbType.VarChar).Value = EodOutFio;
        cmd.Parameters.Add("@EodOutNum", SqlDbType.VarChar).Value = EodOutNum;
        cmd.Parameters.Add("@EodSndInf", SqlDbType.VarChar).Value = EodSndInf;

        cmd.Parameters.Add("@EodNam", SqlDbType.VarChar).Value = EodNam;
        cmd.Parameters.Add("@EodDopInf", SqlDbType.VarChar).Value = EodDopInf;
        cmd.Parameters.Add("@EodAttDoc", SqlDbType.VarChar).Value = "";   // EodAttDoc;
        cmd.Parameters.Add("@EodInpOrg", SqlDbType.VarChar).Value = EodInpOrg;
        cmd.Parameters.Add("@EodTyp", SqlDbType.VarChar).Value = EodTyp;
        cmd.Parameters.Add("@EodOutOrg", SqlDbType.VarChar).Value = EodOutOrg;
        cmd.Parameters.Add("@EodSndTyp", SqlDbType.VarChar).Value = EodSndTyp;
        cmd.Parameters.Add("@EodRslWho", SqlDbType.VarChar).Value = EodRslWho;
        cmd.Parameters.Add("@EodSvd001", SqlDbType.VarChar).Value = EodSvd001;
        cmd.Parameters.Add("@EodSvd002", SqlDbType.VarChar).Value = EodSvd002;
        cmd.Parameters.Add("@EodSvd003", SqlDbType.VarChar).Value = EodSvd003;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

        //           ConfirmDialog.Visible = false;
        //           ConfirmDialog.VisibleOnLoad = false;
        //    SelFio.Value = KltFio;
        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

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


</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="parEodIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 495px;">

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
                        <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;Рег.номер:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtPrf"  width="15%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 <obout:OboutTextBox runat="server" ID="TxtRegNum"  width="40%" BackColor="White" Height="35px"
                                        FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; от: 
                                 <obout:OboutTextBox runat="server" ID="TxtDat"  width="25%" BackColor="White" Height="35px"
                                        FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 <obout:Calendar ID="Calendar1" runat="server"
			 				                    StyleFolder="/Styles/Calendar/styles/default" 
						                        DatePickerMode="true"
						                        ShowYearSelector="true"
						                        YearSelectorType="DropDownList"
						                        TitleText="Выберите год: "
						                        CultureName = "ru-RU"
						                        TextBoxId = "TxtDat"
						                        DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>

                             </td>                                                         
                             <td width="10%" class="PO_RowCap">&nbsp;Тип:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxTyp" Width="40%" Height="200" MenuWidth="300"  
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsTyp" DataTextField="EDOTYPNAM" DataValueField="EDOTYPKOD" >
                                 </obout:ComboBox>  
                                 &nbsp;Кому:
                                <obout:ComboBox runat="server" ID="BoxKom" Width="45%" Height="200" MenuWidth="300"  
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsOrg" DataTextField="ORGHSPNAM" DataValueField="ORGHSPKOD" >
                                 </obout:ComboBox>  
                            </td>
                        </tr>
</table>
            <hr />
                   <table border="0" cellspacing="0" width="100%" cellpadding="0">
<!--  Исходящий номер ----------------------------------------------------------------------------------------------------------  -->  
<!-- Вид доставки  ----------------------------------------------------------------------------------------------------------  -->  
<!--  Информация о доставке  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Исх.номер:</td>
                             <td width="35%" style="vertical-align: central;">
                                  <obout:OboutTextBox runat="server" ID="TxtIsxNom"  width="55%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; от: 
                                 <obout:OboutTextBox runat="server" ID="TxtIsxDat"  width="25%" BackColor="White" Height="35px"
                                        FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 <obout:Calendar ID="Calendar2" runat="server"
			 				                    StyleFolder="/Styles/Calendar/styles/default" 
						                        DatePickerMode="true"
						                        ShowYearSelector="true"
						                        YearSelectorType="DropDownList"
						                        TitleText="Выберите год: "
						                        CultureName = "ru-RU"
						                        TextBoxId = "TxtIsxDat"
						                        DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                             </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Вид доставки:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxVidDst" Width="95%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsDst" DataTextField="EDODSTNAM" DataValueField="EDODSTKOD" >
                                 </obout:ComboBox>  
                             </td>
                        </tr>

<!--  Наименование ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Наименование:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtNam"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Доставка:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtDstInf"  width="95%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>
                        </tr>

 <!--  От кого поступило ----------------------------------------------------------------------------------------------------------  -->  
  <!--  Кем подписан ----------------------------------------------------------------------------------------------------------  -->  
                        <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;От кого:</td>
                            <td width="35%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="TxtOrg"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Кем подписан:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtOrgKto"  width="95%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
</table>
            <hr />
                   <table border="0" cellspacing="0" width="100%" cellpadding="0">
 
<!--  Кто вносит резолюцию  Доп. информация ----------------------------------------------------------------------------------------------------------  -->  
                           <tr style="height:35px">                      
                             <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;В резолюцию:&nbsp;</br>Доп.инфо:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxRslWho" Width="100%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsRsl" DataTextField="FIO" DataValueField="BUXKOD" >
                                 </obout:ComboBox>    
                                 <obout:OboutTextBox runat="server" ID="TxtDopInf"  width="100%" BackColor="White" Height="50px"
                                        TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>            
                             </td>
<!--  Отправить к сведению ----------------------------------------------------------------------------------------------------------  --> 
                             <td width="10%"  style="vertical-align: top;" class="PO_RowCap">&nbsp;К сведению:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxSvd001" Width="95%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsSvd" DataTextField="FIO" DataValueField="BUXKOD" >
                                 </obout:ComboBox>                    
                                 <obout:ComboBox runat="server" ID="BoxSvd002" Width="95%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsSvd" DataTextField="FIO" DataValueField="BUXKOD" >
                                 </obout:ComboBox>     
                                 <obout:ComboBox runat="server" ID="BoxSvd003" Width="95%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="sdsSvd" DataTextField="FIO" DataValueField="BUXKOD" >
                                 </obout:ComboBox>     
                             </td>
                        </tr>
</table>
            <hr />
                   <table border="0" cellspacing="0" width="100%" cellpadding="0">
<!--  Вложения ------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">     
                             <td width="10%"  style="vertical-align: top;" class="PO_RowCap">&nbsp;Вложения:</td>                        

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
                                     <tr>
                                         <td style="width: 100%; height: 25px;">
                                             <asp:Label ID="Lbl004" Text="4.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                             <asp:Button ID="ButUpl004" runat="server" OnClick="Import004_Click" Text="Загрузить" />
                                             <button id="Swo4" onclick="Sho001(4);">
                                                 <img id="img41" src="/Icon/Show.png" alt="Start"></button>
                                             <button id="Del4" onclick="Del001(3);">
                                                 <img id="img42" src="/Icon/DELETE.PNG" alt="Start"></button>
                                         </td>
                                     </tr>

                                     <%-- ============================  5  ============================================ --%>
                                     <tr>
                                         <td style="width: 100%; height: 25px;">
                                             <asp:Label ID="Lbl005" Text="5.Документ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                             <asp:Button ID="ButUpl005" runat="server" OnClick="Import005_Click" Text="Загрузить" />
                                             <button id="Swo5" onclick="Sho001(5);">
                                                 <img id="img51" src="/Icon/Show.png" alt="Start"></button>
                                             <button id="Del5" onclick="Del001(3);">
                                                 <img id="img52" src="/Icon/DELETE.PNG" alt="Start"></button>
                                         </td>
                                     </tr>
                                 </table>
                             </td>
                             <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Выбор файла:</td>         
                             <td width="35%" style="vertical-align: top;">
                                 <asp:Label ID="Label1" Text="WEBCAM:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                 <button id="Web" onclick="WebCam();">Вкл. камеру&nbsp&nbsp&nbsp&nbsp&nbsp</button>
                                 </br>
                                 <asp:Label ID="Lbl000" Text="ФАЙЛ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                                 <asp:FileUpload ID="FilUpl001" Height="25px"  runat="server" />
                             </td>

                        </tr>
           </table>


         </asp:Panel>
 
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
                   <asp:Button ID="RslButton" runat="server" CommandName="Add" OnClick="RslButton_Click" Text="Отправить на резолюцию"/>
               </center>
           </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
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
    <asp:SqlDataSource runat="server" ID="sdsRsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsSvd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
           .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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



<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#DatBrt').mask('D9.M9.Y999');
            $('#TxtDokDat').mask('D9.M9.Y999');
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

        function ExitFun() {
     //       self.close();
        }

        // -----------------------------------------------------------------------------------
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KdrKod;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

        KdrKod = Convert.ToString(Request.QueryString["KdrKod"]);
        //       KdrStx = KdrOneIdn.Substring(0, 5);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        sdsNaz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNaz.SelectCommand = "SELECT NATKOD,NATNAM FROM SPRNAT ORDER BY NATNAM";

        sdsObr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsObr.SelectCommand = "SELECT EDUKOD,EDUNAM FROM SPREDU ORDER BY EDUNAM";

        sdsStp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsStp.SelectCommand = "SELECT STPKOD,STPNAM FROM SPRSTP ORDER BY STPNAM";

        sdsKat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKat.SelectCommand = "SELECT UCHKATKOD,UCHKATNAM FROM SPRUCHKAT ORDER BY UCHKATNAM";

        sdsZvn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsZvn.SelectCommand = "SELECT UCHZVNKOD,UCHZVNNAM FROM SPRUCHZVN ORDER BY UCHZVNNAM";

        sdsSem.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSem.SelectCommand = "SELECT FamKod,FamNam FROM SprFam ORDER BY FamKod";

        sdsDok.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDok.SelectCommand = "SELECT DOCVARKOD,DOCVARNAM FROM SPRDOCVAR ORDER BY DOCVARNAM";

        sdsBnk.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBnk.SelectCommand = "SELECT BNKKOD,BNKNAM FROM SPRBNK ORDER BY BNKNAM";

        if (!Page.IsPostBack)
        {
            GetGrid();
        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================

    void GetGrid()
    {

        //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT * FROM KDR WHERE KDRKOD=" + KdrKod, con);
        //        cmd = new SqlCommand("HspRefGlv003KdrOne", con);
        // указать тип команды
        //      cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //    cmd.Parameters.Add("@KdrONEIDN", SqlDbType.VarChar).Value = KdrOneIdn;
        //    cmd.Parameters.Add("@CNTONEIDN", SqlDbType.VarChar).Value = CntOneIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "KdrOne");

        if (ds.Tables[0].Rows.Count > 0)
        {

            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            TxtIin.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRIIN"]);
            TxtFam.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRFAM"]);
            TxtIma.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRIMA"]);
            TxtOtc.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDROTC"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRBRT"].ToString())) DatBrt.Text = "";
            else DatBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KDRBRT"]).ToString("dd.MM.yyyy");

            TxtInv.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRINV"]);
            TxtBnkKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRALT"]);
         //   TxtKat.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRUCHKAT"]);
            TxtDokNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRDNN"]);
 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRDDT"].ToString())) TxtDokDat.Text = "";
            else TxtDokDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KDRDDT"]).ToString("dd.MM.yyyy");

            TxtDokKto.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRDPL"]);
            TxtTelMob.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRCOT"]);
            TxtTelDom.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRTHN"]);
            TxtTelRab.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRTJN"]);
            TxtEml.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDREML"]);
            TxtPlcBrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRADRBRT"]);
            TxtPlcPrp.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRADRPRP"]);
            TxtPlcAdr.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRADR"]);
            TxtPlcInd.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRADRIND"]);
            
            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRNAT"].ToString())) BoxNaz.SelectedValue = "0";
            else BoxNaz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRNAT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRSEM"].ToString())) BoxSem.SelectedValue = "0";
            else BoxSem.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRSEM"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRALTBNK"].ToString())) BoxBnk.SelectedValue = "0";
            else BoxBnk.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRALTBNK"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDREDU"].ToString())) BoxObr.SelectedValue = "0";
            else BoxObr.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDREDU"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRUCHSTP"].ToString())) BoxUchStp.SelectedValue = "0";
            else BoxUchStp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRUCHSTP"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRUCHSVN"].ToString())) BoxUchZvn.SelectedValue = "0";
            else BoxUchZvn.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRUCHSVN"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRUCHKAT"].ToString())) BoxUchKat.SelectedValue = "0";
            else BoxUchKat.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRUCHKAT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRDOC"].ToString())) BoxDok.SelectedValue = "0";
            else BoxDok.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KDRDOC"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRPRIPNS"].ToString())) ChkPns.Checked = false;
            else ChkPns.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KDRPRIPNS"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRARMSLB"].ToString())) ChkBob.Checked = false;
            else ChkBob.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KDRARMSLB"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KDRSEX"].ToString())) SexFlg.Checked = false;
            else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KDRSEX"]);

        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        else
        {
            /*
            // создание команды
            SqlCommand cmdMax = new SqlCommand("HspSprKdrMaxIinInv", con);
            cmdMax = new SqlCommand("HspSprKdrMaxIinInv", con);
            // указать тип команды
            cmdMax.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            // передать параметр
            cmdMax.Parameters.Add("@BUXFRM", SqlDbType.Int,4).Value = BuxFrm;
            // создание DataAdapter
            SqlDataAdapter daMax = new SqlDataAdapter(cmdMax);
            // заполняем DataSet из хран.процедуры.
            daMax.Fill(dsMax, "HspSprKdrMaxIinInv");

            if (dsMax.Tables[0].Rows.Count > 0)
            {
                IinTxt.Text = Convert.ToString(dsMax.Tables[0].Rows[0]["KdrMAXIIN"]);
                InvTxt.Text = Convert.ToString(dsMax.Tables[0].Rows[0]["KdrMAXINV"]);
                TekCntIdn.Value = Convert.ToString(dsMax.Tables[0].Rows[0]["CNTIDN"]);
                TekKdrIdn.Value = Convert.ToString(dsMax.Tables[0].Rows[0]["KdrIDN"]);

            }
            */
        }

        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }


    //------------------------------------------------------------------------
    // ============================ проверка и опрос для записи документа в базу ==============================================
    
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        //---------------------------------------------- запись --------------------------
            string KdrIin = "";
            string KdrFam = "";
            string KdrIma = "";
            string KdrOtc = "";
            string KdrBrt = "";
            string KdrInv = "";
            string KdrBnkKrt = "";
            string KdrKat = "";
            string KdrDokNum = "";
            string KdrDokDat = "";
            string KdrDokKto = "";
            string KdrTelMob = "";
            string KdrTelDom = "";
            string KdrTelRab = "";
            string KdrEml = "";
            string KdrPlcBrt = "";
            string KdrPlcPrp = "";
            string KdrPlcAdr = "";
            string KdrPlcInd = "";
            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            string KdrNaz = "";
            string KdrSem = "";
            string KdrBnk = "";
            string KdrObr = "";
            string KdrUchStp = "";
            string KdrUchKat = "";
            string KdrUchZvn = "";
            string KdrDok = "";
            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            bool KdrChkPns;
            bool KdrChkBob;
            bool KdrSexFlg;
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          
            if (Convert.ToString(TxtIin.Text) == null || Convert.ToString(TxtIin.Text) == "") KdrIin = "";
            else KdrIin = Convert.ToString(TxtIin.Text);

            if (Convert.ToString(TxtFam.Text) == null || Convert.ToString(TxtFam.Text) == "") KdrFam = "";
            else KdrFam = Convert.ToString(TxtFam.Text);

            if (Convert.ToString(TxtIma.Text) == null || Convert.ToString(TxtIma.Text) == "") KdrIma = "";
            else KdrIma = Convert.ToString(TxtIma.Text);

            if (Convert.ToString(TxtOtc.Text) == null || Convert.ToString(TxtOtc.Text) == "") KdrOtc = "";
            else KdrOtc = Convert.ToString(TxtOtc.Text);

            if (Convert.ToString(DatBrt.Text) == null || Convert.ToString(DatBrt.Text) == "") KdrBrt = "";
            else KdrBrt = Convert.ToString(DatBrt.Text);

            if (Convert.ToString(TxtInv.Text) == null || Convert.ToString(TxtInv.Text) == "") KdrInv = "";
            else KdrInv = Convert.ToString(TxtInv.Text);

            if (Convert.ToString(TxtBnkKrt.Text) == null || Convert.ToString(TxtBnkKrt.Text) == "") KdrBnkKrt = "";
            else KdrBnkKrt = Convert.ToString(TxtBnkKrt.Text);

       //     if (Convert.ToString(TxtKat.Text) == null || Convert.ToString(TxtKat.Text) == "") KdrKat = "";
       //     else KdrKat = Convert.ToString(TxtKat.Text);

            if (Convert.ToString(TxtDokNum.Text) == null || Convert.ToString(TxtDokNum.Text) == "") KdrDokNum = "";
            else KdrDokNum = Convert.ToString(TxtDokNum.Text);

            if (Convert.ToString(TxtDokDat.Text) == null || Convert.ToString(TxtDokDat.Text) == "") KdrDokDat = "";
            else KdrDokDat = Convert.ToString(TxtDokDat.Text);

            if (Convert.ToString(TxtDokKto.Text) == null || Convert.ToString(TxtDokKto.Text) == "") KdrDokKto = "";
            else KdrDokKto = Convert.ToString(TxtDokKto.Text);

            if (Convert.ToString(TxtTelMob.Text) == null || Convert.ToString(TxtTelMob.Text) == "") KdrTelMob = "";
            else KdrTelMob = Convert.ToString(TxtTelMob.Text);

            if (Convert.ToString(TxtTelDom.Text) == null || Convert.ToString(TxtTelDom.Text) == "") KdrTelDom = "";
            else KdrTelDom = Convert.ToString(TxtTelDom.Text);

            if (Convert.ToString(TxtTelRab.Text) == null || Convert.ToString(TxtTelRab.Text) == "") KdrTelRab = "";
            else KdrTelRab = Convert.ToString(TxtTelMob.Text);

            if (Convert.ToString(TxtEml.Text) == null || Convert.ToString(TxtEml.Text) == "") KdrEml = "";
            else KdrEml = Convert.ToString(TxtEml.Text);

            if (Convert.ToString(TxtPlcBrt.Text) == null || Convert.ToString(TxtPlcBrt.Text) == "") KdrPlcBrt = "";
            else KdrPlcBrt = Convert.ToString(TxtPlcBrt.Text);

            if (Convert.ToString(TxtPlcPrp.Text) == null || Convert.ToString(TxtPlcPrp.Text) == "") KdrPlcPrp = "";
            else KdrPlcPrp = Convert.ToString(TxtPlcPrp.Text);

            if (Convert.ToString(TxtPlcAdr.Text) == null || Convert.ToString(TxtPlcAdr.Text) == "") KdrPlcAdr = "";
            else KdrPlcAdr = Convert.ToString(TxtPlcAdr.Text);

            if (Convert.ToString(TxtPlcInd.Text) == null || Convert.ToString(TxtPlcInd.Text) == "") KdrPlcInd = "";
            else KdrPlcInd = Convert.ToString(TxtPlcInd.Text);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (Convert.ToString(BoxNaz.SelectedValue) == null || Convert.ToString(BoxNaz.SelectedValue) == "") KdrNaz = "";
            else KdrNaz = Convert.ToString(BoxNaz.SelectedValue);
            
            if (Convert.ToString(BoxSem.SelectedValue) == null || Convert.ToString(BoxSem.SelectedValue) == "") KdrSem = "";
            else KdrSem = Convert.ToString(BoxSem.SelectedValue);
            
            if (Convert.ToString(BoxBnk.SelectedValue) == null || Convert.ToString(BoxBnk.SelectedValue) == "") KdrBnk = "";
            else KdrBnk = Convert.ToString(BoxBnk.SelectedValue);
            
            if (Convert.ToString(BoxObr.SelectedValue) == null || Convert.ToString(BoxObr.SelectedValue) == "") KdrObr = "";
            else KdrObr = Convert.ToString(BoxObr.SelectedValue);
            
            if (Convert.ToString(BoxUchStp.SelectedValue) == null || Convert.ToString(BoxUchStp.SelectedValue) == "") KdrUchStp = "";
            else KdrUchStp = Convert.ToString(BoxUchStp.SelectedValue);
            
            if (Convert.ToString(BoxUchKat.SelectedValue) == null || Convert.ToString(BoxUchKat.SelectedValue) == "") KdrUchKat = "";
            else KdrUchKat = Convert.ToString(BoxUchKat.SelectedValue);
            
            if (Convert.ToString(BoxUchZvn.SelectedValue) == null || Convert.ToString(BoxUchZvn.SelectedValue) == "") KdrUchZvn = "";
            else KdrUchZvn = Convert.ToString(BoxUchZvn.SelectedValue);
            
            if (Convert.ToString(BoxDok.SelectedValue) == null || Convert.ToString(BoxDok.SelectedValue) == "") KdrDok = "";
            else KdrDok = Convert.ToString(BoxDok.SelectedValue);
            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (Convert.ToString(ChkPns.Text) == "Checked = true") KdrChkPns = true;
            else KdrChkPns = ChkPns.Checked;

            if (Convert.ToString(ChkBob.Text) == "Checked = true") KdrChkBob = true;
            else KdrChkBob = ChkBob.Checked;

            if (Convert.ToString(SexFlg.Text) == "Checked = true") KdrSexFlg = true;
            else KdrSexFlg = SexFlg.Checked;

        // ------------------------------------------------------------------------------------------------------------------------     

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("ComSprKdrTitRep", con);
        cmd = new SqlCommand("ComSprKdrTitRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KDRKOD", SqlDbType.VarChar).Value = KdrKod;
        cmd.Parameters.Add("@KDRIIN", SqlDbType.VarChar).Value = KdrIin;
        cmd.Parameters.Add("@KDRFAM", SqlDbType.VarChar).Value = KdrFam;
        cmd.Parameters.Add("@KDRIMA", SqlDbType.VarChar).Value = KdrIma;
        cmd.Parameters.Add("@KDROTC", SqlDbType.VarChar).Value = KdrOtc;
        cmd.Parameters.Add("@KDRBRT", SqlDbType.VarChar).Value = KdrBrt;
        cmd.Parameters.Add("@KDRINV", SqlDbType.VarChar).Value = KdrInv;
        cmd.Parameters.Add("@KDRALT", SqlDbType.VarChar).Value = KdrBnkKrt;
        cmd.Parameters.Add("@KDRUCHKAT", SqlDbType.VarChar).Value = KdrUchKat;
        cmd.Parameters.Add("@KDRDNN", SqlDbType.VarChar).Value = KdrDokNum ;
        cmd.Parameters.Add("@KDRDDT", SqlDbType.VarChar).Value = KdrDokDat;
        cmd.Parameters.Add("@KDRDPL", SqlDbType.VarChar).Value = KdrDokKto;
        cmd.Parameters.Add("@KDRCOT", SqlDbType.VarChar).Value = KdrTelMob;
        cmd.Parameters.Add("@KDRTHN", SqlDbType.VarChar).Value = KdrTelDom;
        cmd.Parameters.Add("@KDRTJN", SqlDbType.VarChar).Value = KdrTelRab;
        cmd.Parameters.Add("@KDREML", SqlDbType.VarChar).Value = KdrEml;
        cmd.Parameters.Add("@KDRADRBRT", SqlDbType.VarChar).Value = KdrPlcBrt;
        cmd.Parameters.Add("@KDRADRPRP", SqlDbType.VarChar).Value = KdrPlcPrp;
        cmd.Parameters.Add("@KDRADR", SqlDbType.VarChar).Value = KdrPlcAdr;
        cmd.Parameters.Add("@KDRADRIND", SqlDbType.VarChar).Value = KdrPlcInd;
        cmd.Parameters.Add("@KDRNAT", SqlDbType.VarChar).Value = KdrNaz;
        cmd.Parameters.Add("@KDRSEM", SqlDbType.VarChar).Value = KdrSem;
        cmd.Parameters.Add("@KDRALTBNK", SqlDbType.VarChar).Value = KdrBnk;
        cmd.Parameters.Add("@KDREDU", SqlDbType.VarChar).Value = KdrObr;
        cmd.Parameters.Add("@KDRUCHSTP", SqlDbType.VarChar).Value = KdrUchStp;
        cmd.Parameters.Add("@KDRUCHSVN", SqlDbType.VarChar).Value = KdrUchZvn;
        cmd.Parameters.Add("@KDRDOC", SqlDbType.VarChar).Value = KdrDok;
        cmd.Parameters.Add("@KDRPRIPNS", SqlDbType.Bit, 1).Value = KdrChkPns;
        cmd.Parameters.Add("@KDRARMSLB", SqlDbType.Bit, 1).Value = KdrChkBob;
        cmd.Parameters.Add("@KDRSEX", SqlDbType.Bit, 1).Value = KdrSexFlg;

        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

    //    ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

    }
  

    //------------------------------------------------------------------------

</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekKdrIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 400px;">

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
 <!--  Фамилия ,Пол, Д/р, Национальн ----------------------------------------------------------------------------------------------------------  
     -->  
                         <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="TxtIin" width="25%" BackColor="White" Height="25px"></asp:TextBox>
                                 <asp:Label id="Label3" Text="&nbsp;Пол (муж):" runat="server" Width="25%"/> 
                                 <obout:OboutCheckBox runat="server" ID="SexFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                                 &nbsp;Д/р:&nbsp;

                                <obout:OboutTextBox runat="server" ID="DatBrt"  width="30%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                        </obout:OboutTextBox>
                             </td>                                                         
                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabStx" Text="&nbsp;Национальн:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxNaz" Width="90%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain"   
                                        DataSourceID="sdsNaz" DataTextField="NATNAM" DataValueField="NATKOD" >
                                </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Фамилия И.О, Сем.полож Пенсионер, Военно ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Фамилия:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtFam"  width="25%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 Имя:
                                 <obout:OboutTextBox runat="server" ID="TxtIma"  width="20%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 Отч:
                                 <obout:OboutTextBox runat="server" ID="TxtOtc"  width="30%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">
                                <asp:Label id="Label1" Text="Сем.полож.:" runat="server" Width="10%"/>  
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxSem" Width="50%" Height="100" MenuWidth="300"
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsSem" DataTextField="FamNam" DataValueField="FamKod" >
                                 </obout:ComboBox>  
                                 <asp:Label id="LabEmp" Text="&nbsp;Пенс:" runat="server" Width="10%"/> 
                                 <obout:OboutCheckBox runat="server" ID="ChkPns" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                                 <asp:Label id="Label6" Text="&nbsp;Воен:" runat="server" Width="10%"/> 
                                 <obout:OboutCheckBox runat="server" ID="ChkBob" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                            </td>

                        </tr>
 <!--  Статус, Груп.инв,  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                            <td width="10%" class="PO_RowCap">&nbsp;Статус:</td>
                            <td width="35%" style="vertical-align: central;">
                                 <obout:ComboBox runat="server" ID="BoxSoz"  Width="60%" Height="300" MenuWidth="600" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Дети до 18 лет" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Беременные" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Участники Великой Отечественной войны" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Инвалиды" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Многодетные матери, награжденные подвесками «Алтын алка», «Кумыс алка»" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Получатели адресной социальной помощи" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Пенсионеры по возрасту" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Больным инфекционными, социально-значимыми заболеваниями и заболеваниями, представляющими опасность для окружающих" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="По заболеванию" Value="9" />
                                         </Items>
                                 </obout:ComboBox>  
                                 <asp:Label id="Label4" Text="&nbsp;Груп.инв:" runat="server" Width="20%"/> 
                                 <obout:OboutTextBox runat="server" ID="TxtInv"  width="10%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
 <!--  Банк (карта), № карты , Срок ----------------------------------------------------------------------------------------------------------  -->  
                            <td width="10%" class="PO_RowCap">&nbsp;Банк (карта):</td>
                             <td width="35%" style="vertical-align: top;">
                                  <obout:ComboBox runat="server" ID="BoxBnk" Width="40%" Height="100" MenuWidth="300"
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsBnk" DataTextField="BNKNAM" DataValueField="BNKKOD" >
                                  </obout:ComboBox>  
                            
                                  &nbsp;№:
                                  <obout:OboutTextBox runat="server" ID="TxtBnkKrt"  width="45%" BackColor="White" Height="35px"
                                         FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                          </obout:OboutTextBox>

                             </td>
                        </tr>
</table>
            <hr />


       <table border="0" cellspacing="0" width="100%" cellpadding="0">
             <!--  Документ,№ док,Дата выдачи,Кем выдан ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Документ:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxDok" Width="40%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsDok" DataTextField="DOCVARNAM" DataValueField="DOCVARKOD" >
                                 </obout:ComboBox>       
                                 № док
                                 <obout:OboutTextBox runat="server" ID="TxtDokNum"  width="45%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Дата выдачи:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtDokDat"  width="30%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox> 
                                 Кем выдан
                                 <obout:OboutTextBox runat="server" ID="TxtDokKto"  width="30%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                        </tr>
                </table>

           <hr />

      <table border="0" cellspacing="0" width="100%" cellpadding="0">
              <!--  Тел.сотовый,Тел.дом.,Тел.раб,Email ----------------------------------------------------------------------------------------------------------  --> 
                      <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Тел.сотовый:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtTelMob"  width="40%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                                 Тел.дом.
                                 <obout:OboutTextBox runat="server" ID="TxtTelDom"  width="40%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Тел.раб:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtTelRab"  width="40%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                                 Email
                                 <obout:OboutTextBox runat="server" ID="TxtEml"  width="45%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                        </tr>

<!--  Место рожд, Место прописки ----------------------------------------------------------------------------------------------------------  -->  
                           <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Место рожд.:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtPlcBrt"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Прописан:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtPlcPrp"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>

   <!--  Место прожив,Индекс ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Место прожив:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtPlcAdr"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Индекс:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtPlcInd"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>
                 </table>
           <hr />


                  <table border="0" cellspacing="0" width="100%" cellpadding="0">
<!--  Образование , Категория,Уч.степень,Уч.звания  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                              <td width="10%" class="PO_RowCap">&nbsp;Образование:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxObr" Width="40%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsObr" DataTextField="EDUNAM" DataValueField="EDUKOD" >
                                 </obout:ComboBox> 
                                 Категория
                                 <obout:ComboBox runat="server" ID="BoxUchKat" Width="30%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsKat" DataTextField="UCHKATNAM" DataValueField="UCHKATKOD" >
                                 </obout:ComboBox>  
                             </td>

                            <td width="10%" class="PO_RowCap">&nbsp;Уч.степень:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxUchStp" Width="30%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsStp" DataTextField="StpNam" DataValueField="StpKod" >
                                 </obout:ComboBox>                         
                                 &nbsp; Уч.звания: 
                                 <obout:ComboBox runat="server" ID="BoxUchZvn" Width="30%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsZvn" DataTextField="UCHZVNNAM" DataValueField="UCHZVNKOD" >
                                 </obout:ComboBox>  
                             </td>
                        </tr>
                </table>

              </asp:Panel>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
               </center>
           </asp:Panel>

<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
                                <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="AddButton_Click" OnClientClick="requestPermission();" />
                               <obout:OboutButton runat="server" ID="OboutButton0"   
                                   FolderStyle="styles/grand_gray/OboutButton" Text="ОК" OnClick="AddButton_Click"
		                           OnClientClick="requestPermission();" />
    --%>

    <asp:SqlDataSource runat="server" ID="sdsNaz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsObr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    
    <asp:SqlDataSource runat="server" ID="sdsStp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsZvn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsSem" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsDok" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsBnk" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



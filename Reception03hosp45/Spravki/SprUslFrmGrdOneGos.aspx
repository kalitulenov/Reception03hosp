<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
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
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->

    <script type="text/javascript">
        //    ------------------ смена логотипа ----------------------------------------------------------
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

        // ==================================== при выборе клиента показывает его программу  ============================================

        function ExitFun() {
         //   var KltFio = document.getElementById('SelFio').value;
            //   alert(KltFio);
            //window.parent.KofClick();
            window.parent.PrcOneClose();
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        function GridPrc_rsx() {
            //                  alert("GridPrz_rsx=");
            var UslIdn = document.getElementById('parUslIdn').value;
            var UslFrmIdn = document.getElementById('parUslFrmIdn').value;
            var UslFrmNam = document.getElementById('TxtNam').value;
            /*
      //      RsxWindow.setTitle(UslFrmIdn);
            RsxWindow.setUrl("SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslFrmIdn);
            RsxWindow.Open();
*/

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn + "&UslNam=" + UslFrmNam, "ModalPopUp2", "width=900,height=480,left=250,top=210,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
            else
                window.showModalDialog("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn + "&UslNam=" + UslFrmNam, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:900px;dialogHeight:480px;");

            return true;
        }
    </script>

</head>


<script runat="server">
            string MdbNam = "HOSPBASE";
            string AmbCrdIdn;
            string SprUslIdn;
            string SprUslIdnTek;
            string SprUslCnt;
            string SprUslKey;
            string SprUslFrmIdn;
            string AmbNazTyp;
            string BuxFrm;
            string BuxKod;
            string BuxSid;

            //=============Установки===========================================================================================
            protected void Page_Load(object sender, EventArgs e)
            {

                //    if (SprUslIdn == "0") AmbNazTyp = "ADD";
                //    else AmbNazTyp = "REP";
                SprUslIdn = Convert.ToString(Request.QueryString["SprUslIdn"]);
                SprUslFrmIdn = Convert.ToString(Request.QueryString["SprUslFrmIdn"]);
                SprUslCnt = Convert.ToString(Request.QueryString["SprUslCnt"]);
                SprUslKey = Convert.ToString(Request.QueryString["SprUslKey"]);

                BuxFrm = (string)Session["BuxFrmKod"];
                BuxSid = (string)Session["BuxSid"];
                BuxKod = (string)Session["BuxKod"];

                AmbCrdIdn = (string)Session["AmbCrdIdn"];


                Session.Add("SprUslIdn ", SprUslIdn);

                SdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm + " ORDER BY ORGHSPNAM";

                SdsGrp001.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
                SdsGrp001.SelectCommand = "SELECT SprStrUsl.StrUslKey As StrUslKey001,SprStrUsl.StrUslNam As StrUslNam001 " +
                                          "FROM SprStrUslFrm INNER JOIN SprStrUsl ON SprStrUslFrm.StrUslFrmKey=SprStrUsl.StrUslKey " +
                                          "WHERE SprStrUslFrm.StrUslFrmHsp=" + BuxFrm + " AND LEN(SprStrUslFrm.StrUslFrmKey)=3 " +
                                          "ORDER BY SprStrUsl.StrUslNam";

                SdsGrp002.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SdsGrp003.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

                SdsPrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

                if (!Page.IsPostBack)
                {
                    parUslIdn.Value = SprUslIdn;
                    parUslFrmIdn.Value = SprUslFrmIdn;
                    parUslCnt.Value = SprUslCnt;
                    parUslKey.Value = SprUslKey;

                    //           TxtKol.Attributes.Add("onkeypress", "return isNumeric(event)");
                    //============= Установки ===========================================================================================
                    SprUslIdnTek = (string)Session["SprUslIdn"];
                    if (SprUslIdnTek != "Post")
                    {
                        if (SprUslIdn == "0")  // новый документ
                        {
                            // строка соединение
                            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                            // создание соединение Connection
                            SqlConnection con = new SqlConnection(connectionString);
                            // создание команды
                            SqlCommand cmd = new SqlCommand("SprUslFrmGrdOneAdd", con);
                            // указать тип команды
                            cmd.CommandType = CommandType.StoredProcedure;
                            // передать параметр
                            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
                            cmd.Parameters.Add("@USLCNT", SqlDbType.VarChar).Value = SprUslCnt;
                            cmd.Parameters.Add("@USLKEY", SqlDbType.VarChar).Value = SprUslKey;
                            cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = 0;
                            cmd.Parameters.Add("@USLFRMIDN", SqlDbType.Int, 4).Value = 0;
                            cmd.Parameters["@USLIDN"].Direction = ParameterDirection.Output;
                            cmd.Parameters["@USLFRMIDN"].Direction = ParameterDirection.Output;
                            con.Open();
                            try
                            {
                                int numAff = cmd.ExecuteNonQuery();
                                // Получить вновь сгенерированный идентификатор.
                                //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                                //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                                SprUslIdn = Convert.ToString(cmd.Parameters["@USLIDN"].Value);
                                SprUslFrmIdn = Convert.ToString(cmd.Parameters["@USLFRMIDN"].Value);
                            }
                            finally
                            {
                                con.Close();
                            }
                            //                 Session["SprUslIdnTek"] = "Post";

                        }
                    }

                    Session["SprUslIdn"] = Convert.ToString(SprUslIdn);
                    parUslIdn.Value = SprUslIdn;
                    parUslFrmIdn.Value = SprUslFrmIdn;

                    getDocNum();
                    //            GetGrid();
                }
            }

            // ============================ чтение заголовка таблицы а оп ==============================================
            void getDocNum()
            {
                // --------------------------  считать данные одного врача -------------------------
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("SprUslFrmGrdOneSel", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = SprUslIdn;
                if (SprUslFrmIdn == null || SprUslFrmIdn == "") cmd.Parameters.Add("@USLFRMIDN", SqlDbType.Int, 4).Value = 0;
                else cmd.Parameters.Add("@USLFRMIDN", SqlDbType.Int, 4).Value = SprUslFrmIdn;


                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "SprUslZap");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRNazNAM"]);
                    BoxGrp001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKEY001"]);
                    BoxGrp002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKEY002"]);
                    BoxGrp003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKEY003"]);

                    TxtTrf.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLTRF"]);
                    TxtNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAMFUL"]);
                    TxtEdn.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLEDN"]);
                    TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLZEN"]);
                    SprUslFrmIdn = Convert.ToString(ds.Tables[0].Rows[0]["USLFRMIDN"]);
                    parUslFrmIdn.Value = SprUslFrmIdn;

                    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLFRMZEN"].ToString()) || Convert.ToString(ds.Tables[0].Rows[0]["USLFRMZEN"]) == "0") ChkFlg.Checked = false;
                    else ChkFlg.Checked = true;

            // TxtZenDom.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLFRMZENDOM"]);
            //  TxtAkz.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLFRMAKZ"]);
            TxtKol.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLFRMIINKOL"]);
            TxtXyz.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLROWCOL"]);
            TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLMEM"]);
            TxtUslRdyPrz.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLRDYPRZ"]);

            BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLFRMIIN"]);

            BoxPrt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLPROTOK"]);

            SdsGrp002.SelectCommand = "SELECT SprStrUsl.StrUslKey As StrUslKey002,SprStrUsl.StrUslNam As StrUslNam002 " +
                                      "FROM SprStrUslFrm INNER JOIN SprStrUsl ON SprStrUslFrm.StrUslFrmKey=SprStrUsl.StrUslKey " +
                                      "WHERE SprStrUslFrm.StrUslFrmHsp=" + BuxFrm + " AND LEN(SprStrUslFrm.StrUslFrmKey)=7 AND LEFT(SprStrUslFrm.StrUslFrmKey,3)='" + BoxGrp001.SelectedValue +
                                      "' ORDER BY SprStrUsl.StrUslNam";

            SdsGrp003.SelectCommand = "SELECT SprStrUsl.StrUslKey As StrUslKey003,SprStrUsl.StrUslNam As StrUslNam003 " +
                                      "FROM SprStrUslFrm INNER JOIN SprStrUsl ON SprStrUslFrm.StrUslFrmKey=SprStrUsl.StrUslKey " +
                                      "WHERE SprStrUslFrm.StrUslFrmHsp=" + BuxFrm + " AND LEN(SprStrUslFrm.StrUslFrmKey)=11 AND LEFT(SprStrUslFrm.StrUslFrmKey,7)='" + BoxGrp002.SelectedValue +
                                      "' ORDER BY SprStrUsl.StrUslNam";

            SdsPrt.SelectCommand = "SELECT SPRMEDFRMKOD,SPRMEDFRMNAM FROM SPRMEDFRM WHERE SPRMEDFRMKEY='" + parUslKey.Value.Substring(0,3) + "' ORDER BY SPRMEDFRMNAM";
            BoxPrt.Items.Add(new Obout.ComboBox.ComboBoxItem("нет протокола", "0"));

        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            //         BoxNaz.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    // ==================================== поиск клиента по фильтрам  ============================================

    // ============================ кнопка новый документ  ==============================================
    protected void ZapButton_Click(object sender, EventArgs e)
    {
        string USLKEY001 = "";
        string USLKEY002 = "";
        string USLKEY003 = "";
        int USLPRT = 0;

        string USLTRF = "";
        string USLXYZ = "";
        string USLNAMFUL = "";
        string USLEDN = "";
        int USLFRMZEN = 0;
        int USLFRMAKZ = 0;
        int USLFRMZENDOM = 0;
        int USLFRMIINKOL = 0;
        string USLFRMIIN = "";
        string USLMEM = "";
        string USLRDYPRZ = "";

        if (Convert.ToString(BoxGrp001.SelectedValue) == null || Convert.ToString(BoxGrp001.SelectedValue) == "") USLKEY001 = "0";
        else USLKEY001 = Convert.ToString(BoxGrp001.SelectedValue);

        if (Convert.ToString(BoxGrp002.SelectedValue) == null || Convert.ToString(BoxGrp002.SelectedValue) == "") USLKEY002 = "0";
        else USLKEY002 = Convert.ToString(BoxGrp002.SelectedValue);

        if (Convert.ToString(BoxGrp003.SelectedValue) == null || Convert.ToString(BoxGrp003.SelectedValue) == "") USLKEY003 = "0";
        else USLKEY003 = Convert.ToString(BoxGrp003.SelectedValue);

        if (Convert.ToString(TxtTrf.Text) == null || Convert.ToString(TxtTrf.Text) == "") USLTRF = "";
        else USLTRF = Convert.ToString(TxtTrf.Text);

        if (Convert.ToString(TxtNam.Text) == null || Convert.ToString(TxtNam.Text) == "") USLNAMFUL = "";
        else USLNAMFUL = Convert.ToString(TxtNam.Text);

        if (Convert.ToString(TxtEdn.Text) == null || Convert.ToString(TxtEdn.Text) == "") USLEDN= "";
        else USLEDN = Convert.ToString(TxtEdn.Text);

        if (Convert.ToString(TxtZen.Text) == null || Convert.ToString(TxtZen.Text) == "") USLFRMZEN= 0;
        else USLFRMZEN = Convert.ToInt32(TxtZen.Text);

        if (ChkFlg.Checked == true) USLFRMZEN = Convert.ToInt32(TxtZen.Text);
        else USLFRMZEN= 0;

        //    if (Convert.ToString(TxtZenDom.Text) == null || Convert.ToString(TxtZenDom.Text) == "") USLFRMZENDOM= 0;
        USLFRMZENDOM = 0;

        //     if (Convert.ToString(TxtAkz.Text) == null || Convert.ToString(TxtAkz.Text) == "") USLFRMAKZ= 0;
        USLFRMAKZ = 0;

        if (Convert.ToString(TxtKol.Text) == null || Convert.ToString(TxtKol.Text) == "") USLFRMIINKOL= 0;
        else USLFRMIINKOL = Convert.ToInt32(TxtKol.Text);

        if (Convert.ToString(BoxOrg.SelectedValue) == null || Convert.ToString(BoxOrg.SelectedValue) == "") USLFRMIIN = "";
        else USLFRMIIN = Convert.ToString(BoxOrg.SelectedValue);

        if (Convert.ToString(BoxPrt.SelectedValue) == null || Convert.ToString(BoxPrt.SelectedValue) == "") USLPRT = 0;
        else USLPRT = Convert.ToInt32(BoxPrt.SelectedValue);

        if (Convert.ToString(TxtUslRdyPrz.Text) == null || Convert.ToString(TxtUslRdyPrz.Text) == "") USLRDYPRZ = "";
        else USLRDYPRZ = Convert.ToString(TxtUslRdyPrz.Text);

        if (Convert.ToString(TxtMem.Text) == null || Convert.ToString(TxtMem.Text) == "") USLMEM = "";
        else USLMEM = Convert.ToString(TxtMem.Text);


        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("SprUslFrmGrdOneRep", con);
        cmd = new SqlCommand("SprUslFrmGrdOneRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = parUslIdn.Value;
        cmd.Parameters.Add("@USLFRMIDN", SqlDbType.Int, 4).Value = parUslFrmIdn.Value;
        cmd.Parameters.Add("@USLKEY001", SqlDbType.VarChar).Value = USLKEY001;
        cmd.Parameters.Add("@USLKEY002", SqlDbType.VarChar).Value = USLKEY002;
        cmd.Parameters.Add("@USLKEY003", SqlDbType.VarChar).Value = USLKEY003;
        cmd.Parameters.Add("@USLTRF", SqlDbType.VarChar).Value = USLTRF;
        cmd.Parameters.Add("@USLXYZ", SqlDbType.VarChar).Value = USLXYZ;
        cmd.Parameters.Add("@USLNAMFUL", SqlDbType.VarChar).Value = USLNAMFUL;
        cmd.Parameters.Add("@USLEDN", SqlDbType.VarChar).Value = USLEDN;
        cmd.Parameters.Add("@USLFRMZEN", SqlDbType.Int, 4).Value = USLFRMZEN;
        cmd.Parameters.Add("@USLFRMZENDOM", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLFRMAKZ", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLFRMIINKOL", SqlDbType.Int, 4).Value = USLFRMIINKOL;
        cmd.Parameters.Add("@USLFRMIIN", SqlDbType.VarChar).Value = USLFRMIIN;
        cmd.Parameters.Add("@USLPRT", SqlDbType.Int, 4).Value = USLPRT;
        cmd.Parameters.Add("@USLMEM", SqlDbType.VarChar).Value = USLMEM;
        cmd.Parameters.Add("@USLRDYPRZ", SqlDbType.VarChar).Value = USLRDYPRZ;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень
        ExecOnLoad("ExitFun();");

    }


    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslFrmIdn" runat="server" />
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslCnt" runat="server" />
        <asp:HiddenField ID="parUslKey" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 380px;">
            
            <asp:TextBox ID="Sapka" 
             Text="СПРАВОЧНИК ЦЕН"
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; border-style:double; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>


            <table border="0" cellspacing="0" width="100%" cellpadding="0">

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label1" Text="РАЗДЕЛ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxGrp001"
                            Width="75%"
                            Height="200"
                            EmptyText="Выберите ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsGrp001"
                            Enabled="false"
                            DataTextField="StrUslNam001"
                            DataValueField="StrUslKey001" >
                        </obout:ComboBox>
                    </td>
                </tr>

               <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label12" Text="ГРУППА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            Enabled="false"
                            ID="BoxGrp002"
                            Width="75%"
                            Height="200"
                            EmptyText="Выберите  ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsGrp002"
                            DataTextField="StrUslNam002"
                            DataValueField="StrUslKey002" >
                        </obout:ComboBox>
                    </td>
                </tr>
  
               <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label13" Text="ПОДГРУППА" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            Enabled="false"
                            ID="BoxGrp003"
                            Width="75%"
                            Height="200"
                            EmptyText="Выберите  ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsGrp003"
                            DataTextField="StrUslNam003"
                            DataValueField="StrUslKey003" >
                        </obout:ComboBox>
                    </td>
                </tr>
  

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="ТАРИФ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtTrf" Width="75%" Height="20" runat="server" ReadOnly="true"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

                <tr>
                    <td width="100%" style="vertical-align: top;">
                        <asp:Label ID="Label2" Text="НАИМЕНОВАНИЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtNam" Width="75%" Height="40" TextMode="MultiLine" runat="server" ReadOnly="true" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

 
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label14" Text="ЕДН.ИЗМ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <span  style="width:75%">
                            <asp:TextBox ID="TxtEdn" Width="15%" Height="20" runat="server" ReadOnly="true" Style="position: relative; font-weight: 700; font-size: medium;" />
                            
                            <asp:Label ID="Label15" Text="ЦЕНА:" runat="server" ReadOnly="true" Width="7%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="TxtZen" Width="10%" Height="20" runat="server" ReadOnly="true" Style="position: relative; font-weight: 700; font-size: medium;" />
                            
                            <asp:Label ID="Label3" Text="ВКЛЮЧИТЬ (Да):" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />

                            <obout:OboutCheckBox runat="server" ID="ChkFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        </span>
                   </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="ОРГАНИЗАЦИЯ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxOrg"
                            Width="63%"
                            Height="200"
                            EmptyText="Выберите ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsOrg"
                            DataTextField="ORGHSPNAM"
                            DataValueField="ORGHSPKOD" >
                        </obout:ComboBox>
                         <asp:Label ID="Label10" Text="&nbsp;&nbsp;КОЛ.:" runat="server" Width="5%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtKol" Width="5%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                    </td>
                </tr>

                
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label6" Text="ПРОТОКОЛ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxPrt"
                            Width="63%"
                            Height="200"
                            EmptyText="Выберите ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsPrt"
                            DataTextField="SprMedFrmNam"
                            DataValueField="SprMedFrmKod" >
                        </obout:ComboBox>
                        <asp:Label ID="Label7" Text="&nbsp;&nbsp;XYZ:" runat="server" Width="5%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtXyz" Width="5%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                    </td>
                </tr>
 
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label8" Text="ПРИМЕЧАНИЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtMem" Width="75%" Height="30" TextMode="MultiLine" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                    </td>
                </tr> 
                
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label9" Text="ПОДГОТОВКА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtUslRdyPrz" Width="75%" Height="30" TextMode="MultiLine" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                    </td>
                </tr>

            </table>

        </asp:Panel>

        <asp:Panel ID="PanelBottom" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="ZapButton" runat="server" CommandName="Cancel" Text="Сохранить" onclick="ZapButton_Click"/>
                 <input type="button" name="PrtButton" value="Расход мат." runat="server"  id="PrtButton" onclick="GridPrc_rsx();"/>
                 <input type="button" name="PrtButton" value="Отмена" runat="server"  id="Button1" onclick="ExitFun();"/>
             </center>
        </asp:Panel>


       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
     <%-- =================  окно для поиска клиента из базы  ============================================ --%>
    </form>

   <!--  для источника ----------------------------------------------- 
       
       -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsPrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsGrp001" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsGrp002" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsGrp003" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

 
     <!--  для источника -----------------------------------------------  -->




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
            outline: 0;
            width: 100%;
            font-size: 12px !important;  /* для увеличения коррект поля */
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
    </style>



</body>

</html>



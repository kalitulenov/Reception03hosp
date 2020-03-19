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

        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        BoxTit.Text = EodTxt;

        sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTyp.SelectCommand = "SELECT * FROM SPREDOTYP WHERE EDOTYPVID='+' ORDER BY EDOTYPNAM";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm;

        sdsDst.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDst.SelectCommand = "SELECT * FROM SPREDODST ORDER BY EDODSTNAM";

        sdsRsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsRsl.SelectCommand = "SELECT * FROM SPREDORSL ORDER BY EDORSLNAM";

        sdsRes.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsRes.SelectCommand = "SELECT * FROM SPREDOBIP ORDER BY EDOBIPNAM";

        sdsSvd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSvd.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIO FROM SPRBUXKDR WHERE ISNULL(BUXUBL,0)=0 AND BUXFRM="+ BuxFrm + " ORDER BY FIO";

        if (!Page.IsPostBack)
        {
            parEodIdn.Value = Convert.ToString(EodIdn);
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
        if (EodKey == "6.1.5") cmd.Parameters.Add("@EodCnd", SqlDbType.VarChar).Value = "+";
        if (EodKey == "6.1.6") cmd.Parameters.Add("@EodCnd", SqlDbType.VarChar).Value = "-";
        if (EodKey == "6.1.7") cmd.Parameters.Add("@EodCnd", SqlDbType.VarChar).Value = ">";

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

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodRslEnd"].ToString())) TxtBipDat.Text = "";
            else TxtBipDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["EodRslEnd"]).ToString("dd.MM.yyyy");

            TxtIsxNom.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodOutNum"]);
            TxtNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodNam"]);
            TxtPor.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodRslPor"]);
            TxtPrf.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodPrf"]);

            TxtIspMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodBipMem"]);
            TxtIspDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["EodBipDat"]);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodTyp"].ToString())) BoxTyp.SelectedValue = "0";
            else BoxTyp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodTyp"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodRslTyp"].ToString())) BoxRsl.SelectedValue = "0";
            else BoxRsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodRslTyp"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodIspWho"].ToString())) BoxIspWho.SelectedValue = "0";
            else BoxIspWho.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["EodIspWho"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodRslRdy"].ToString())) FlgGot.Checked = false;
            else FlgGot.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["EodRslRdy"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodSvdFlg"].ToString())) FlgSvd.Checked = false;
            else FlgSvd.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["EodSvdFlg"]);

            // ----    Документы прикрепленные  ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodImg001"].ToString()))
            {
                Swo1.Visible = false;
                Lbl001.Visible = false;
            }
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodImg002"].ToString()))
            {
                Swo2.Visible = false;
                Lbl002.Visible = false;
            }
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodImg003"].ToString()))
            {
                Swo3.Visible = false;
                Lbl003.Visible = false;
            }
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodImg004"].ToString()))
            {
                Swo4.Visible = false;
                Lbl004.Visible = false;
            }
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["EodImg005"].ToString()))
            {
                Swo5.Visible = false;
                Lbl005.Visible = false;
            }


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
        string EodRsl = "";
        string EodRslEnd = "";
        string EodRslPor = "";
        string EodBipMem = "";
        string EodBipDat = "";
        string EodIspWho = "";
        string EodBipRes = "";
        bool FlgBip = false;
        bool FlgIsp = false;
        string EodRslMem = "";

        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(TxtBipDat.Text) == null || Convert.ToString(TxtBipDat.Text) == "") EodRslEnd = "";
        else EodRslEnd = Convert.ToString(TxtBipDat.Text);

        if (Convert.ToString(TxtPor.Text) == null || Convert.ToString(TxtPor.Text) == "") EodRslPor = "";
        else EodRslPor = Convert.ToString(TxtPor.Text);

        if (Convert.ToString(TxtIspMem.Text) == null || Convert.ToString(TxtIspMem.Text) == "") EodBipMem = "";
        else EodBipMem = Convert.ToString(TxtIspMem.Text);

        if (Convert.ToString(TxtIspDat.Text) == null || Convert.ToString(TxtIspDat.Text) == "") EodBipDat = "";
        else EodBipDat = Convert.ToString(TxtIspDat.Text);


        //     obout:ComboBox ------------------------------------------------------------------------------------ 

        if (Convert.ToString(BoxRsl.SelectedValue) == null || Convert.ToString(BoxRsl.SelectedValue) == "") EodRsl = "";
        else EodRsl = Convert.ToString(BoxRsl.SelectedValue);

        if (Convert.ToString(BoxIspWho.SelectedValue) == null || Convert.ToString(BoxIspWho.SelectedValue) == "") EodIspWho = "";
        else EodIspWho = Convert.ToString(BoxIspWho.SelectedValue);

        //     obout:CheckBox ------------------------------------------------------------------------------------ 
        if (Convert.ToString(FlgGot.Text) == "Checked = true") FlgBip = true;
        else FlgBip = FlgGot.Checked;

        if (Convert.ToString(FlgSvd.Text) == "Checked = true") FlgIsp = true;
        else FlgIsp = FlgSvd.Checked;

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("EodLstGrdOneRslIspRep", con);
        cmd = new SqlCommand("EodLstGrdOneRslIspRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@EodIdn", SqlDbType.VarChar).Value = parEodIdn.Value;   // EodIdn;
        cmd.Parameters.Add("@EodBipMem", SqlDbType.VarChar).Value = EodBipMem;
        cmd.Parameters.Add("@EodBipDat", SqlDbType.VarChar).Value = EodBipDat;
        cmd.Parameters.Add("@EodIspWho", SqlDbType.VarChar).Value = 0;
        cmd.Parameters.Add("@EodBipRes", SqlDbType.VarChar).Value = 5;
        cmd.Parameters.Add("@EodSvdWho", SqlDbType.VarChar).Value = EodIspWho;
        cmd.Parameters.Add("@EodSvdFlg", SqlDbType.Bit, 1).Value = FlgIsp;

        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");

    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    // ============================ загрузка EXCEL в базу ==============================================

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
                <tr style="height: 35px">
                    <td width="10%" class="PO_RowCap">&nbsp;Рег.номер:</td>
                    <td width="35%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtPrf" Width="15%" BackColor="White" Height="35px"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        <obout:OboutTextBox runat="server" ID="TxtRegNum" Width="40%" BackColor="White" Height="35px"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        &nbsp; от: 
                        <obout:OboutTextBox runat="server" ID="TxtDat" Width="25%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                    <td width="10%" class="PO_RowCap">&nbsp;Тип:</td>
                    <td width="35%" style="vertical-align: top;">
                        <obout:ComboBox runat="server" ID="BoxTyp" Width="95%" Height="200" MenuWidth="300"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsTyp" DataTextField="EDOTYPNAM" DataValueField="EDOTYPKOD">
                        </obout:ComboBox>
                    </td>
                </tr>
            </table>

            <hr />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Исходящий номер ----------------------------------------------------------------------------------------------------------  -->
                <!-- Вид доставки  ----------------------------------------------------------------------------------------------------------  -->
                <!--  Информация о доставке  ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" class="PO_RowCap">&nbsp;Исх.номер:</td>
                    <td width="35%" style="vertical-align: central;">
                        <obout:OboutTextBox runat="server" ID="TxtIsxNom" Width="55%" BackColor="White" Height="35px"
                            FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        &nbsp; от: 
                        <obout:OboutTextBox runat="server" ID="TxtIsxDat" Width="25%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                    <!--  Наименование ----------------------------------------------------------------------------------------------------------  -->
                    <td width="10%" class="PO_RowCap">&nbsp;Наименование:</td>
                    <td width="35%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtNam" Width="95%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>

            <hr />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">

                <!--  Резолюция ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Резолюция:</td>
                    <td width="35%" style="vertical-align: top;">
                        <obout:ComboBox runat="server" ID="BoxRsl" Width="100%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsRsl" DataTextField="EDORSLNAM" DataValueField="EDORSLKOD">
                        </obout:ComboBox>


                    </td>
                <!--  Подтверждения выполнения Дата выполнения----------------------------------------------------------------------------------------------------------  -->
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Подтв. выпол.:</td>
                    <td width="35%" style="vertical-align: top;">
                        <obout:OboutCheckBox runat="server" ID="FlgGot" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                        &nbsp;Срок выполнение:
                       <obout:OboutTextBox runat="server" ID="TxtBipDat" Width="25%" BackColor="White" Height="35px"
                                    FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                       </obout:OboutTextBox>
                    </td>
                </tr>
            </table>

           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                     <!--  Поручение ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Поручение:</td>
                    <td width="80%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtPor" Width="98%" BackColor="White" Height="80px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>

            <hr />

            <table border="0" cellspacing="0" width="100%" bgcolor="yellow" cellpadding="0">

                <!--  Исполнитель ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Исполнитель:</td>
                    <td width="35%" style="vertical-align: top;">
                       <obout:ComboBox runat="server" ID="BoxIspWho" Width="95%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsSvd" DataTextField="FIO" DataValueField="BUXKOD">
                        </obout:ComboBox>
                    </td>
                    <!--  Результат ----------------------------------------------------------------------------------------------------------  -->
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Ознакомлен:</td>
                    <td width="35%" style="vertical-align: top;">
                       <obout:OboutCheckBox runat="server" ID="FlgSvd" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                        &nbsp;Дата исп.:
                      <obout:OboutTextBox runat="server" ID="TxtIspDat" Width="25%" BackColor="White" Height="35px"
                                    FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                       </obout:OboutTextBox>
                       <obout:Calendar ID="Calendar4" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtIspDat"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                    </td>
                </tr>
            </table>

           <table border="0" cellspacing="0" width="100%" bgcolor="yellow" cellpadding="0">

                <!--  Примечание ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Примечание:</td>
                    <td width="80%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtIspMem" Width="98%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
            </table>

            <hr />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Вложения ------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="10%" style="vertical-align: top;" class="PO_RowCap">&nbsp;Вложения:</td>

                    <td width="85%" style="vertical-align: top;">
                        <table border="0" cellspacing="0" width="100%" cellpadding="0">
                            <%-- ============================  1  ============================================ 
                                      <button id="Swo1" onclick="Sho001(1);"> <img id="img11" src="/Icon/Show.png" alt="Start"></button>
                              
                                --%>
                            <tr>
                                <td style="width: 100%; height: 25px;">
                                    <asp:Button ID="Swo1" runat="server" Width="20px" OnClientClick="Sho001(1);" Style="background-image:url('/Icon/Show.png'); background-repeat:no-repeat"/>
                                    <asp:Label ID="Lbl001" Text="1.Документ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="Swo2" runat="server" Width="20px" OnClientClick="Sho001(2);" Style="background-image:url('/Icon/Show.png'); background-repeat:no-repeat"/>
                                    <asp:Label ID="Lbl002" Text="2.Документ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="Swo3" runat="server" Width="20px" OnClientClick="Sho001(3);" Style="background-image:url('/Icon/Show.png'); background-repeat:no-repeat"/>
                                    <asp:Label ID="Lbl003" Text="3.Документ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="Swo4" runat="server" Width="20px" OnClientClick="Sho001(4);" Style="background-image:url('/Icon/Show.png'); background-repeat:no-repeat"/>
                                    <asp:Label ID="Lbl004" Text="4.Документ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                                    <asp:Button ID="Swo5" runat="server" Width="20px" OnClientClick="Sho001(5);" Style="background-image:url('/Icon/Show.png'); background-repeat:no-repeat"/>
                                    <asp:Label ID="Lbl005" Text="5.Документ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <hr />


         </asp:Panel>
 
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Исполнен"/>
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
   <%-- =================  диалоговое окно для смены пароля  ============================================ --%>

    <%-- =================  Пароль успешно изменен  ============================================ --%>

        <%-- ============================  верхний блок  ============================================ --%>

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
    <asp:SqlDataSource runat="server" ID="sdsRes" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



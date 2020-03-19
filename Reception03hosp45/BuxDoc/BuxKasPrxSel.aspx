<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>

        <%-- ============================  для передач значении  ============================================ --%>
    <script type="text/javascript">

        function OnClientSelect(sender, selectedRecords) {
   //      alert('OnClientSelect=');
         var AmbCrdIdn = selectedRecords[0].GRFIDN;
                // var GlvDocDat = selectedRecords[0].GRFDAT;
                // var GlvDocPth = selectedRecords[0].GRFPTH;

                 mySpl.loadPage("RightContent", "/BuxDoc/BuxKasPrxSelUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
        }

    </script>
    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>



</head>


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam;
        int DayWek;

        string ComParDat = "";
        string whereClause = "";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            HidBuxFrm.Value = BuxFrm;
            HidBuxKod.Value = BuxKod;

            if (!Page.IsPostBack)
            {
                //=====================================================================================
                GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
                GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

                GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
                GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);

                TextBoxBegDat.Text = Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy");
                TextBoxEndDat.Text = Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");

                whereClause = "";

                LoadGrid();
            }
        }

        protected void LoadGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspKasPrxSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KASBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@KASENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            cmd.Parameters.Add("@KASCND", SqlDbType.VarChar).Value = whereClause;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspKasPrxSel");

            con.Close();

            GridDoc.DataSource = ds;
            GridDoc.DataBind();
        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------

        protected void PushButton_Click(object sender, EventArgs e)
        {
            Session["GlvBegDat"] = DateTime.Parse(TextBoxBegDat.Text);
            Session["GlvEndDat"] = DateTime.Parse(TextBoxEndDat.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            LoadGrid();
        }



        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            //   string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            //      SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndUsl.Text != "")
            {
                I = I + 1;
                whereClause += "AMBCRD.GRFPTH LIKE '%" + FndUsl.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
            }
            LoadGrid();

        }


     </script>


   <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************ HTML **************************************************** --%>
    <%-- ************************************ HTML **************************************************** --%>
 
<body>

    <form id="form1" runat="server">

        <%-- ============================  для передач значении  ============================================ --%>
        <input type="hidden" name="Index" id="par" />
        <asp:HiddenField ID="parPnl" runat="server" />
        <asp:HiddenField ID="parUpd" runat="server" />
        <asp:HiddenField ID="HidBuxFrm" runat="server" />
        <asp:HiddenField ID="HidBuxKod" runat="server" />


        <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        <!--  для хранения переменных -----------------------------------------------  -->
        <!--  для хранения переменных -----------------------------------------------  -->
        <!--  конец -----------------------------------------------  -->
        <asp:HiddenField ID="HidKltIdn" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="300">
                <Content>
                    <table border="1" cellspacing="0" width="100%">
                        <tr>
                            <td width="100%" class="PO_RowCap">
                                <asp:TextBox runat="server" ID="TextBoxBegDat" Width="70px" BackColor="#FFFFE0" />
                                <obout:Calendar ID="Cal1" runat="server"
                                    StyleFolder="/Styles/Calendar/styles/default"
                                    DatePickerMode="true"
                                    ShowYearSelector="true"
                                    YearSelectorType="DropDownList"
                                    TitleText="Выберите год: "
                                    CultureName="ru-RU"
                                    TextBoxId="TextBoxBegDat"
                                    DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                                <asp:TextBox runat="server" ID="TextBoxEndDat" Width="70px" BackColor="#FFFFE0" />
                                <obout:Calendar ID="Cal2" runat="server"
                                    StyleFolder="/Styles/Calendar/styles/default"
                                    DatePickerMode="true"
                                    ShowYearSelector="true"
                                    YearSelectorType="DropDownList"
                                    TitleText="Выберите год: "
                                    CultureName="ru-RU"
                                    TextBoxId="TextBoxEndDat"
                                    DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                                <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обн" OnClick="PushButton_Click" />

                            </td>

                        </tr>

                    </table>


                    <obout:Grid ID="GridDoc" runat="server"
                        ShowFooter="false"
                        AllowPaging="false"
                        AllowPageSizeSelection="false"
                        FolderLocalization="~/Localization"
                        Language="ru"
                        CallbackMode="true"
                        Serialize="true"
                        AutoGenerateColumns="false"
                        FolderStyle="~/Styles/Grid/style_5"
                        AllowAddingRecords="false"
                        ShowColumnsFooter="false"
                        AllowMultiRecordSelection="true"
                        AllowRecordSelection="true"
                        KeepSelectedRecords="true"
                        AllowSorting="true"
                        ShowHeader="true"
                        Width="100%"
                        PageSize="-1">
                        <ClientSideEvents ExposeSender="true" OnClientSelect="OnClientSelect" />
                        <ScrollingSettings ScrollHeight="410" />
                        <Columns>
                            <obout:Column ID="Column0" DataField="GRFIDN" HeaderText="ИДН" Visible="false" Width="0%" />
                            <obout:Column ID="Column1" DataField="GRFDAT" HeaderText="ДАТА" DataFormatString="{0:dd/MM/yy}" Width="20%" />
                            <obout:Column ID="Column2" DataField="GRFPTH" HeaderText="ФАМИЛИЯ И.О." Width="50%" />
                            <obout:Column ID="Column3" DataField="FI" HeaderText="ВРАЧ" Width="30%" />
                        </Columns>

                    </obout:Grid>

                    <table border="1" cellspacing="0" width="100%">
                        <tr>
                            <td width="100%" class="PO_RowCap">
                                <asp:TextBox ID="FndUsl" Width="60%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="30%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>

                        </tr>

                    </table>

                </Content>
            </LeftPanel>
            <RightPanel>
                <Content>
                </Content>
            </RightPanel>
        </spl:Splitter>



        <%-- ============================  для windowalert ============================================ 
    
    <div id="divBackground" style="position: fixed; z-index: 999; height: 100%; width: 100%;
        top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
    </div>
   
        --%>
        <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
        .ob_iTIE {
            font-size: xx-large;
            font: bold 12px Tahoma !important; /* для увеличение корректируемого текста*/
        }

        /*------------------------- для ГАЛОЧКИ  --------------------------------*/
        .hidden {
            display: none;
            width: 20px;
        }

        .visible {
            display:;
            width: 20px;
        }
        /*------------------------- для FLYOUT --------------------------------*/
        .tdTextLink {
            font: 11px Verdana;
            color: #315686;
            text-decoration: underline;
        }

        .tdText {
            font: 11px Verdana;
            color: red;
        }
    </style>


</body>
</html>


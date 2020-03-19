<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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
    </style>

    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
        .super-form {
            margin: 12px;
        }

        .ob_fC table td {
            white-space: normal !important;
        }

        .command-row .ob_fRwF {
            padding-left: 50px !important;
        }
    </style>


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;

        string ParSpr;
        string Html;
        string UslKey000;
        string UslKey003;
        string UslKey007;
        string UslKey011;
        string UslKey015;

        string ComParKey = "";
        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            ParSpr = Convert.ToString(Request.QueryString["ParSpr"]);
            parSpr.Value = Convert.ToString(Request.QueryString["ParSpr"]);

            //=====================================================================================
            if (!Page.IsPostBack)
            {
                PopulateGridDoc();
                parBuxFrm.Value = BuxFrm;
            }
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridDoc()
        {
            //            int Pol;
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM SprEdoBuxMnu WHERE BuxEdoNmuKod=" + BuxKod + " AND BuxEdoNmuFrm=" + BuxFrm + " ORDER BY BuxEdoNmuSwt", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //     cmd.Parameters.Add("@BUXAPP", SqlDbType.Int, 4).Value = Convert.ToInt32(Session["BuxApp"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            con.Open();

            da.Fill(ds, "Bux");
            GridDoc.DataSource = ds.Tables[0].DefaultView;
            GridDoc.DataBind();

            con.Close();
        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        //------------------------------------------------------------------------
    </script>

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function onNodeSelect(sender, args) {
      //      alert("sender=" + sender);
      //      alert("args=" + args);

            var NodKey = sender.getNodeValue(args.node);         // Отбросить с начало 4 символ
            var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
            if (NodKey == null) NodKey = "";
          //    alert("NodKey=" + NodKey);
          //    alert("NodTxt=" + NodTxt);

            mySpl.loadPage("RightContent", "EodLstGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt);
        }


    </script>

    <!--  конец -----------------------------------------------  -->
    <%-- ============================  для передач значении  ============================================ --%>
    <span id="WindowPositionHelper"></span>
    <asp:HiddenField ID="parUslKod" runat="server" />
    <asp:HiddenField ID="parUslNam" runat="server" />
    <asp:HiddenField ID="parBuxFrm" runat="server" />
    <asp:HiddenField ID="parPrcKod" runat="server" />
    <asp:HiddenField ID="parCntKod" runat="server" />
    <asp:HiddenField ID="parSpr" runat="server" />

    <input type="hidden" name="hhh" id="par" />
    <input type="hidden" name="aaa" id="cntr" value="0" />

    <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для источника -----------------------------------------------  -->

    <asp:TextBox ID="TxtUsl"
        Text="                                                            Справочник услуг"
        BackColor="#0099FF"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0px; position: relative; width: 100%"
        runat="server"></asp:TextBox>

    <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">


        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="250">
                <Content>
                    <div style="margin: 5px;">

                        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                                            Справочник врачей + меню" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 1250px"
             runat="server"></asp:TextBox>
        
     		           <obout:Grid id="GridDoc" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="100%"
	         		               AllowAddingRecords = "false"
	         		               AutoPostBackOnSelect = "true"
                                   AllowRecordSelection = "true"
                                   AllowFiltering = "false" >
           		           		<Columns>
	                    			<obout:Column ID="Column1" DataField="BuxKod" HeaderText="Код" ReadOnly ="true" Width="10%" Align="right" />
                    				<obout:Column ID="Column2" DataField="FI" HeaderText="Фамилия И.О."  Width="30%" />
                    				<obout:Column ID="Column3" DataField="DLGNAM" HeaderText="Специалист"  Width="60%" />
		                    	</Columns>
	                    	</obout:Grid>	
	                    	
   
       <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />


                    </div>
                    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

                </Content>
            </LeftPanel>
            <RightPanel>
                <Content>
                </Content>
            </RightPanel>
        </spl:Splitter>


    </asp:Panel>

    <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
</asp:Content>


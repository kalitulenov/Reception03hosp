<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="acw" Namespace="Aspose.Cells.GridWeb" Assembly="Aspose.Cells.GridWeb" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Aspose.Cells.GridWeb.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
          /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

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
          .ob_iTIE
    {
          font-size: xx-large;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }

        /*------------------------- для ГАЛОЧКИ  --------------------------------*/  
        .hidden
        {
            display: none;
            width: 20px;
        }
        .visible
        {
            display: ;
            width:20px;
        }
                /*------------------------- для FLYOUT --------------------------------*/  
        			.tdTextLink {
			    font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}
        .tdText {
            font: 11px Verdana;
            color: red;
        }

    </style>



    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>

        <%-- ============================  для передач значении  ============================================ --%>
    <script type="text/javascript">
        function OnClientSelectNam(selectedRecords) {
            var UslKod = selectedRecords[0].USLKOD;
            var UslNam = selectedRecords[0].USLNAM;
            var UslDat = document.getElementById('MainContent_txtDate1').value;
        //   alert("DocAppLabRegOne?UslKod=" + UslKod + "&UslDat=" + UslDat);
            document.getElementById('MainContent_parUslKod').value = UslKod;
            document.getElementById('MainContent_parUslNam').value = UslNam;

            mySpl.loadPage("RightContent", "/Priem/DocAppLabRegOne.aspx?UslKod=" + UslKod + "&UslNam=" + UslNam + "&UslDat=" + UslDat);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtBlnButton_Click() {

            var UslKod = document.getElementById('MainContent_parUslKod').value;
            var UslNam = document.getElementById('MainContent_parUslNam').value;
            var UslFrm = document.getElementById('MainContent_parBuxFrm').value;
            var UslDat = document.getElementById('MainContent_txtDate1').value;

        //   alert("DocAppLabRegOne?UslKod=" + UslKod + "&UslDat=" + UslDat);

            var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspAmbLabUslBln&TekDocKod=" + UslKod + "&TekDocFrm=" + UslFrm + "&TekDocBeg=" + UslDat,
                         "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbLabUslBln&TekDocKod=" + UslKod + "&TekDocFrm=" + UslFrm + "&TekDocBeg=" + UslDat,
                         "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }

    </script>



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

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            parBuxFrm.Value = BuxFrm;
            //     HidBuxKod.Value = BuxKod;

            //=====================================================================================
            if (!Page.IsPostBack)
            {
                GlvBegDat = (DateTime)Session["GlvBegDat"];
                //        GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                //       txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                LoadGrid();

            }
        }

        protected void LoadGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            //      GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            //       GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocAppLabReg", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            //      cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocAppLabReg");

            con.Close();

            GridLab.DataSource = ds;
            GridLab.DataBind();

            ds.Dispose();
            con.Close();

            //           if (ds.Tables[0].Rows.Count > 0)
            //           {
            //         }
        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------

        protected void GridDoc_RowDataBound(object sender, GridRowEventArgs e)
        {
            string id = e.Row.Cells[0].Text;
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[0].Attributes.Add("onclick", "OnRecordClick(" + id + ")");
            }
        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            //       Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvBegDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            LoadGrid();
        }


        //------------------------------------------------------------------------
        // ============================ кнопка новый документ  ==============================================

     </script>

    <%-- ============================  JAVA ============================================ --%>

    <!--  конец -----------------------------------------------  -->
    <%-- ============================  для передач значении  ============================================ --%>
    <span id="WindowPositionHelper"></span>
    <asp:HiddenField ID="parUslKod" runat="server" />
    <asp:HiddenField ID="parUslNam" runat="server" />
    <asp:HiddenField ID="parBuxFrm" runat="server" />
    <asp:HiddenField ID="parPrcKod" runat="server" />
    <asp:HiddenField ID="parCntKod" runat="server" />
    <asp:HiddenField ID="HidBuxFrm" runat="server" />

    <input type="hidden" name="hhh" id="par" />
    <input type="hidden" name="aaa" id="cntr" value="0" />

    <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для источника -----------------------------------------------  -->
    <%-- ============================  шапка экрана ============================================ --%>

   <asp:TextBox ID="TxtUsl"
        Text="                                                            Лабораторные анализы"
        BackColor="#0099FF"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0px; position: relative; width: 100%"
        runat="server"></asp:TextBox>

<%-- ============================  верхний блок  ============================================ --%>
     <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
        <center>
             <asp:Label ID="Label1" runat="server" Text="Дата анализа" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

    </asp:Panel>


 
    <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None" BorderStyle="Double" 
          Style="left: 10%; position: relative; top: 0px; width: 80%; height: 520px;">


        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="450" WidthMax="650" WidthDefault="550">
                <Content>
                    <div style="margin: 5px;">

                    <obout:Grid ID="GridLab" runat="server"
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
                    AllowMultiRecordSelection="false"
                    AllowRecordSelection="true"
                    KeepSelectedRecords="true"
                       OnRowDataBound="GridDoc_RowDataBound"
                    AllowSorting="true"
                    ShowHeader="true"
                    Width="100%"
                    PageSize="-1">
                    <ClientSideEvents OnClientSelect="OnClientSelectNam" />
                        <ScrollingSettings ScrollHeight="500" />
                        <Columns>
                            <obout:Column ID="Column01" DataField="USLKOD" HeaderText="КОД" Width="10%" />
                            <obout:Column ID="Column03" DataField="USLNAM" HeaderText="АНАЛИЗЫ" Width="75%" Align="left" />
                            <obout:Column ID="Column04" DataField="KOL" HeaderText="КОЛИЧЕСТВО" ReadOnly="true" Width="15%" Align="center" />
 
                        </Columns>

              </obout:Grid>

                </Content>
            </LeftPanel>
            <RightPanel>
                <Content>
                </Content>
            </RightPanel>
        </spl:Splitter>


    </asp:Panel>

    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <input type="button" name="PrtButton" value="Печать бланка" id="PrtButton" onclick="PrtBlnButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Сформировать" onclick="ExlButton_Click"/>
             </center>
  </asp:Panel> 
    <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
</asp:Content>


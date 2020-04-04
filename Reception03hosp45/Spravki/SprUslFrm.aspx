<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

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
            ParSpr = Convert.ToString(Request.QueryString["ParSpr"]);
            parSpr.Value = Convert.ToString(Request.QueryString["ParSpr"]);

            //=====================================================================================
            //=====================================================================================
            SdsPrc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;

            SdsPrc.SelectCommand = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprPrc INNER JOIN SprCnt ON SprPrc.PrcKod=SprCnt.CntPrc " +
                                   "WHERE SprCnt.CntLvl = 0 AND SprCnt.CntFrm =" + BuxFrm +
                                   " GROUP BY SprPrc.PrcKod, SprPrc.PrcNam";

            //SdsPrc.SelectCommand = "SELECT CntKod,CntNam " +
            //                       "FROM SprCnt WHERE CntLvl=0 And CntFrm=" + BuxFrm +
            //                       " ORDER BY CntKod";
            //=====================================================================================
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                getPrcNum();
                //           UslFrmChk();
                PopulateTree();
                parBuxFrm.Value = BuxFrm;
            }
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        private void PopulateTree()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            //SqlCommand cmd = new SqlCommand("SELECT SprStrUsl.StrUslNam,SprStrUsl.StrUslKey " +
            //     "FROM SprStrUsl INNER JOIN SprStrUslFrm ON SprStrUsl.StrUslKey=SprStrUslFrm.StrUslFrmKey " +
            //                    "INNER JOIN SprCnt ON SprStrUslFrm.StrUslFrmHsp=SprCnt.CntFrm " +
            //     "WHERE LEN(SprStrUsl.StrUslKey)=3 AND SprStrUslFrm.StrUslFrmHsp="+ BuxFrm + " AND SprCnt.CntLvl=0 AND SprCnt.CntKod=" + parCntKod.Value +
            //     " GROUP BY SprStrUsl.StrUslNam, SprStrUsl.StrUslKey " +
            //     "ORDER BY SprStrUsl.StrUslKey", con);

            SqlCommand cmd = new SqlCommand("SELECT SprStrUsl.StrUslNam, SprStrUsl.StrUslKey " +
                                            "FROM SprStrUsl INNER JOIN SprStrUslFrm ON SprStrUsl.StrUslKey=SprStrUslFrm.StrUslFrmKey " +
                                            "WHERE LEN(SprStrUsl.StrUslKey) = 3 AND SprStrUslFrm.StrUslFrmHsp="+ BuxFrm +
                                            "GROUP BY SprStrUsl.StrUslNam, SprStrUsl.StrUslKey " +
                                            "ORDER BY SprStrUsl.StrUslKey", con);

            //SprUslFrm.UslFrmZen>0 AND 
            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComTrePrc");

            con.Close();
            //=====================================================================================
            OboutTree.Nodes.Clear();
            //           Node rootNode = new Node() { Text = "ПРЕЙСКУРАНТ", Expanded = true };
            Node rootNode = new Node() { Text = "", Expanded = true };
            //            Node rootNode = new Node() ;
            OboutTree.Nodes.Add(rootNode);

            foreach (DataRow row in ds.Tables["ComTrePrc"].Rows)
            {
                Html = Convert.ToString(row["StrUslNam"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["StrUslKey"]);
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                this.OboutTree.Nodes.Add(newNode);
            }

        }

        protected void OboutTree_TreeNodeExpanded(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            int NodLen;
            int NodLen004;
            string NodVal;
            string SqlStr;

            NodVal = e.Node.Value;
            NodLen = e.Node.Value.Length;
            NodLen004 = NodLen + 4;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);

            con.Open();
            if (ParSpr == "UPD")
                SqlStr= "SELECT * FROM SPRSTRUSL INNER JOIN SprStrUslFrm ON SprStrUsl.StrUslKey = SprStrUslFrm.StrUslFrmKey " +
                    "WHERE SprStrUslFrm.StrUslFrmHsp="+ BuxFrm+ " AND LEFT(STRUSLKEY," + NodLen + ")='" + NodVal + "' AND LEN(STRUSLKEY)=" + NodLen004 + " ORDER BY STRUSLKEY";
            else
                /*
                SqlStr= "SELECT SprStrUsl.StrUslNam, dbo.SprStrUsl.StrUslKey " +
                        "FROM SprStrUsl INNER JOIN SprUsl ON SprStrUsl.StrUslKey=SprUsl.UslKey " +
                                        "INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                                        "INNER JOIN SprStrUslFrm ON SprStrUsl.StrUslKey=SprStrUslFrm.StrUslFrmKey " +
                        "WHERE LEFT(STRUSLKEY," + NodLen + ")='" + NodVal + "' AND LEN(STRUSLKEY)>0" +  //NodLen004 + 
                               " AND SprUslFrm.UslFrmZen>0 AND SprUslFrm.UslFrmHsp=" + BuxFrm +
                               " AND SprUslFrm.UslFrmPrc=" + BoxPrc.SelectedValue +
                        " GROUP BY SprStrUsl.StrUslNam, dbo.SprStrUsl.StrUslKey " +
                        "ORDER BY SprStrUsl.StrUslNam";
*/
                SqlStr = "SELECT SprStrUsl.StrUslNam, SprStrUsl.StrUslKey " +
                        "FROM SprStrUsl INNER JOIN SprStrUslFrm ON SprStrUsl.StrUslKey = SprStrUslFrm.StrUslFrmKey " +
                        "WHERE  SprStrUslFrm.StrUslFrmHsp="+ BuxFrm+ " AND LEFT(SprStrUsl.StrUslKey," + NodLen + ")='" + NodVal +
                        "' GROUP BY SprStrUsl.StrUslNam, SprStrUsl.StrUslKey " +
                        "ORDER BY SprStrUsl.StrUslNam";

            SqlCommand cmd = new SqlCommand(SqlStr, con);

            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComTrePrc");

            con.Close();
            //=====================================================================================
            foreach (DataRow row in ds.Tables["ComTrePrc"].Rows)
            {
                Html = Convert.ToString(row["StrUslNam"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["StrUslKey"]);
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                e.Node.ChildNodes.Add(newNode);
            }
        }


        // ============================ чтение заголовка таблицы а оп ==============================================
        void UslFrmChk()
        {
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSelUslFrmChk", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@NUMPRC", SqlDbType.Int,4).Value = BoxPrc.SelectedValue;
            // Выполнить команду

            cmd.ExecuteNonQuery();

            con.Close();
        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getPrcNum()
        {
            string SqlPrc;
            /*
            SqlPrc = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                     "FROM SprFrmStx INNER JOIN SprPrc ON SprFrmStx.FrmStxPrc=SprPrc.PrcKod " +
                     "WHERE SprFrmStx.FrmStxKodFrm=" + BuxFrm + " AND PATINDEX('%платно%',SprPrc.PrcNam) > 0 " +
                     " GROUP BY SprPrc.PrcKod,SprPrc.PrcNam";
            */
            SqlPrc = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprPrc INNER JOIN SprCnt ON SprPrc.PrcKod=SprCnt.CntPrc " +
                                   "WHERE SprCnt.CntLvl = 0 AND SprCnt.CntFrm =" + BuxFrm + " AND PATINDEX('%платно%',CntNam) > 0 ORDER BY CntKod";
            
            //SqlPrc = "SELECT CntKod,CntPrc,CntNam FROM SprCnt WHERE CntLvl=0 And CntFrm=" + BuxFrm + " AND PATINDEX('%платно%',CntNam) > 0 ORDER BY CntKod";

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(SqlPrc, con);
            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "SprPrc");

            con.Close();

            BoxPrc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PrcKod"]);
          //  parCntKod.Value = Convert.ToString(ds.Tables[0].Rows[0]["CntKod"]);
            parPrcKod.Value = Convert.ToString(ds.Tables[0].Rows[0]["PrcKod"]);

            //     UslFrmChk();

        }

        //------------------------------------------------------------------------
        protected void BoxPrc_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            parPrcKod.Value = BoxPrc.SelectedValue;

            //         if (BoxPrc.SelectedValue == null || BoxPrc.SelectedValue == "") TekPrc = "";
            //         else TekPrc = Convert.ToString(BoxPrc.SelectedValue);
            //     UslFrmChk();
            PopulateTree();

        }


        /*
                protected void PrtButton_Click(object sender, EventArgs e)
                {
                    string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
                    int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
                    // --------------  печать ---------------------------- BuxFrm
                    Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspSprZen&TekDocIdn=" + BuxFrm + "&TekDocKod=" + BoxPrc.SelectedValue);
                }
          */
    </script>

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function onNodeSelect(sender, args) {
      //      alert("sender=" + sender);
      //      alert("args=" + args);

            var ParSpr = document.getElementById('MainContent_parSpr').value;
            var NodKey = sender.getNodeValue(args.node);         // Отбросить с начало 4 символ
            var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
            var NumPrc = BoxPrc.value();         // Отбросить с начало 4 символ
            if (NodKey == null) NodKey = "";
            if (NodKey == null) NodKey = "";
              alert("NodKey=" + NodKey);
              alert("NodTxt=" + NodTxt);
              alert("NumPrc=" + NumPrc);
              alert("ParSpr=" + ParSpr);

              if (NumPrc == 1) 
                 if (ParSpr == "UPD") mySpl.loadPage("RightContent", "SprUslFrmGrdGos.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&NumPrc=" + NumPrc);
                 else mySpl.loadPage("RightContent", "SprUslFrmGrdRed.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&NumPrc=" + NumPrc);
              else
                 if (ParSpr == "UPD") mySpl.loadPage("RightContent", "SprUslFrmGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&NumPrc=" + NumPrc);
                 else mySpl.loadPage("RightContent", "SprUslFrmGrdRed.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&NumPrc=" + NumPrc);

        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
  //          alert('AmbCrdIdn= ' );
            var BuxFrm = document.getElementById('MainContent_parBuxFrm').value;
            var PrcKod = document.getElementById('MainContent_parPrcKod').value;

//            alert('AmbCrdIdn2= ' + BuxFrm);
//            alert('AmbCrdIdn3= ' + PrcKod);

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprZen&TekDocIdn=" + BuxFrm + "&TekDocKod=" + PrcKod, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprZen&TekDocIdn=" + BuxFrm + "&TekDocKod=" + PrcKod, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtAdvButton_Click() {
            //          alert('AmbCrdIdn= ' );
            var BuxFrm = document.getElementById('MainContent_parBuxFrm').value;
            var PrcKod = document.getElementById('MainContent_parPrcKod').value;

            //            alert('AmbCrdIdn2= ' + BuxFrm);
            //            alert('AmbCrdIdn3= ' + PrcKod);
            if (BuxFrm == 1) {
                var ua = navigator.userAgent;

                if (ua.search(/Chrome/) > -1)
                    window.open("/Report/DauaReports.aspx?ReportName=HspSprZenAdv&TekDocIdn=" + BuxFrm, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprZenAdv&TekDocIdn=" + BuxFrm, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            }
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
                        <obout:ComboBox runat="server" ID="BoxPrc" Width="100%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            AutoPostBack="true" OnSelectedIndexChanged="BoxPrc_OnSelectedIndexChanged"
                            DataSourceID="SdsPrc" DataTextField="PRCNAM" DataValueField="PRCKOD" />

                        <obout:Tree ID="OboutTree"
                            runat="server"
                            ClientObjectID="_OboutTree"
                            CssClass="vista"
                            EnableTheming="True"
                            NodeDropTargets=""
                            OnTreeNodeExpanded="OboutTree_TreeNodeExpanded"
                            OnNodeSelect="onNodeSelect"
                            ShowLines="false"
                            Height="100%"
                            Width="100%"
                            EnableViewState="true">
                        </obout:Tree>


                    </div>
                    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

                   <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
                       Style="left: 0%; position: relative; top: 130px; width: 97%; height: 50px;">
                       <center>
                          <input type="button" value="Печать прейскуранта"  onclick="PrtButton_Click()" />
                          <input type="button" value="Печать прейскуранта (расшир)"  onclick="PrtAdvButton_Click()" />
                       </center>
             

  </asp:Panel>              

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


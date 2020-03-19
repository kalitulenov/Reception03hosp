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

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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
            /*
            SdsPrc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsPrc.SelectCommand = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprFrmStx INNER JOIN SprPrc ON SprFrmStx.FrmStxPrc=SprPrc.PrcKod " +
                                   "WHERE SprFrmStx.FrmStxKodFrm=" + BuxFrm +
                                   " GROUP BY SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "ORDER BY SprPrc.PrcKod";
            */
            //=====================================================================================
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //               getPrcNum();
                //               UslFrmChk();
                parBuxFrm.Value = BuxFrm;
                PopulateTree();
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
            //           SqlCommand cmd = new SqlCommand("SELECT * FROM SPRSTRUSL WHERE LEN(STRUSLKEY)=3 ORDER BY STRUSLKEY", con);
            // SqlCommand cmd = new SqlCommand("SELECT GrpMatGrp FROM SprGrpMat GROUP BY GrpMatGrp ORDER BY GrpMatGrp", con);
            SqlCommand cmd = new SqlCommand("SELECT SprGrpMat.GrpMatGrp FROM TabMat INNER JOIN SprGrpMat ON TabMat.MATGRP=SprGrpMat.GrpMatKod " +
                                            "WHERE TabMat.MATFRM=" + parBuxFrm.Value +
                                            " GROUP BY SprGrpMat.GrpMatGrp", con);
            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComTreMat");

            con.Close();
            //=====================================================================================
            //           Node rootNode = new Node() { Text = "ПРЕЙСКУРАНТ", Expanded = true };
            Node rootNode = new Node() { Text = "ГРУППА МАТЕРИАЛОВ", Expanded = true };
            //            Node rootNode = new Node() ;
            OboutTree.Nodes.Add(rootNode);

            foreach (DataRow row in ds.Tables["ComTreMat"].Rows)
            {
                Html = Convert.ToString(row["GrpMatGrp"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["GrpMatGrp"]);
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
        //    SqlStr = "SELECT GrpMatKod,GrpMatNam FROM SprGrpMat WHERE GrpMatGrp='" + NodVal + "' ORDER BY GrpMatNam";
            SqlStr = "SELECT SprGrpMat.GrpMatKod,SprGrpMat.GrpMatNam " +
                     "FROM TabMat INNER JOIN SprGrpMat ON TabMat.MATGRP=SprGrpMat.GrpMatKod " +
                     "WHERE TabMat.MATFRM=10 AND SprGrpMat.GrpMatGrp='" + NodVal + 
                     "' GROUP BY SprGrpMat.GrpMatKod,SprGrpMat.GrpMatNam ORDER BY SprGrpMat.GrpMatNam";

            SqlCommand cmd = new SqlCommand(SqlStr, con);

            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComTreMat");

            con.Close();
            //=====================================================================================
            foreach (DataRow row in ds.Tables["ComTreMat"].Rows)
            {
                Html = Convert.ToString(row["GrpMatNam"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["GrpMatKod"]);
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                e.Node.ChildNodes.Add(newNode);
            }
        }


        // ============================ чтение заголовка таблицы а оп ==============================================
    </script>

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function onNodeSelect(sender, args) {

            var ParSpr = document.getElementById('MainContent_parSpr').value;
            var NodKey = sender.getNodeValue(args.node);         // Отбросить с начало 4 символ
            var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
//            var NumPrc = BoxPrc.value();         // Отбросить с начало 4 символ
            if (NodKey == null) NodKey = "";
    //        alert("NodKey=" + NodKey);
    //          alert("NodTxt=" + NodTxt);
            mySpl.loadPage("RightContent", "BuxSprMatGrd.aspx?NodKey=" + NodKey+ "&NodTxt=" + NodTxt);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
    </script>

    <!--  конец -----------------------------------------------  -->
    <%-- ============================  для передач значении  ============================================ --%>
    <span id="WindowPositionHelper"></span>
    <asp:HiddenField ID="parUslKod" runat="server" />
    <asp:HiddenField ID="parUslNam" runat="server" />
    <asp:HiddenField ID="parBuxFrm" runat="server" />
    <asp:HiddenField ID="parPrcKod" runat="server" />
    <asp:HiddenField ID="parSpr" runat="server" />

    <input type="hidden" name="hhh" id="par" />
    <input type="hidden" name="aaa" id="cntr" value="0" />

    <!--  для источника -----------------------------------------------  -->

    <asp:TextBox ID="TxtUsl"
        Text="                                                            Справочник материалов"
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


﻿<%@ Page Language="C#" AutoEventWireup="true" %>

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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>

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


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function onNodeSelect(sender, args) {
 //           alert("onNodeSelect=" + sender.getNodeValue(args.node));
 //           alert("onNodeSelect=" + sender.getNodeText(args.node));
            var NodKey = sender.getNodeValue(args.node);        
            var NodTxt = sender.getNodeText(args.node);         
            var CntKey = document.getElementById('parCntKey').value;
            if (NodKey == null) NodKey = "";
       //                 alert("NodKey=" + NodKey);
   //                     alert("NodTxt=" + NodTxt);
      //                  alert("CntKey=" + CntKey);
//            mySpl.loadPage("RightContent", "SprUslFrmGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&CntKey=" + CntKey);
            mySpl.loadPage("RightContent", "SprCntGrdTreOne.aspx?NodKey=" + NodKey + "&CntKey=" + CntKey);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            //          alert('AmbCrdIdn= ' );
            var BuxFrm = document.getElementById('parBuxFrm').value;
            var CntKey = document.getElementById('parCntKey').value;

            //            alert('AmbCrdIdn2= ' + BuxFrm);
            //            alert('AmbCrdIdn3= ' + PrcKod);

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprCntUsl&TekDocFrm=" + BuxFrm + "&TekDocKod=" + CntKey, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprCntUsl&TekDocFrm=" + BuxFrm + "&TekDocKod=" + CntKey, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
    </script>

</head>

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
        string ComParTxt = "";
        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
 //           ParSpr = Convert.ToString(Request.QueryString["ParSpr"]);
 //           parSpr.Value = Convert.ToString(Request.QueryString["ParSpr"]);

            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            parCntKey.Value = ComParKey;


            //=====================================================================================
            //=====================================================================================
            //=====================================================================================
            //=====================================================================================
            if (!Page.IsPostBack)
            {

        //        UslFrmChk();
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

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCntTre", con);
            cmd = new SqlCommand("HspSprCntTre", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@CNTKEY", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = "";
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprCntTre");

            con.Close();
            
            //=====================================================================================
 //           Node rootNode = new Node() { Text = "ПРЕЙСКУРАНТ", Expanded = true };
            Node rootNode = new Node() { Text = "", Expanded = true };
            //            Node rootNode = new Node() ;
            OboutTree.Nodes.Add(rootNode);

            foreach (DataRow row in ds.Tables["HspSprCntTre"].Rows)
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
//            NodLen = e.Node.Value.Length;
 //           NodLen004 = NodLen + 4;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            
            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCntTre", con);
            cmd = new SqlCommand("HspSprCntTre", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@CNTKEY", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = NodVal;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprCntTre");

            con.Close();
            //=====================================================================================
            foreach (DataRow row in ds.Tables["HspSprCntTre"].Rows)
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
            SqlCommand cmd = new SqlCommand("HspSprCntUslChk", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@CNTKEY", SqlDbType.VarChar).Value = ComParKey;
            // Выполнить команду

            cmd.ExecuteNonQuery();

            con.Close();
        }
    </script>


<body>
    <form id="form1" runat="server">

    <!--  конец -----------------------------------------------  -->
    <%-- ============================  для передач значении  ============================================ --%>
    <span id="WindowPositionHelper"></span>
    <asp:HiddenField ID="parUslKod" runat="server" />
    <asp:HiddenField ID="parUslNam" runat="server" />
    <asp:HiddenField ID="parBuxFrm" runat="server" />
    <asp:HiddenField ID="parCntKey" runat="server" />
    <asp:HiddenField ID="parSpr" runat="server" />

    <input type="hidden" name="hhh" id="par" />
    <input type="hidden" name="aaa" id="cntr" value="0" />

    <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для источника -----------------------------------------------  -->

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="250">
                <Content>
                    <div style="margin: 5px;">
                
                        <input type="button" value="Печать программы" style="width:100%"  onclick="PrtButton_Click()" />

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
                            Height="470px"
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
    </form>
</body>
    <script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>

</html>
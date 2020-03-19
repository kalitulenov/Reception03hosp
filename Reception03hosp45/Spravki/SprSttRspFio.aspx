<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true"%>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>
<%-- ================================================================================ --%>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

    <script runat="server">


        string BuxSid;
        string BuxFrm;
        string Html;
        string ComParKey = "";
        string ComParTxt = "";
        string ComStxKey = "";

        string ParKey = "";
        string MdbNam = "HOSPBASE";
        bool VisibleNo = false;
        bool VisibleYes = true;
        
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //------------------------------------------       чтение первых трех уровней дерево
                DataSet ds = GetTree();
                //------------------------------------------       чтение первых трех уровней дерево

                //                Node rootNode = new Node() { Text = "КОМПАНИИ", ImageUrl = "/Icon/ada.gif", Expanded = true };
                Node rootNode = new Node() { Text = "ШТАТНОЕ РАСПИСАНИЕ", Expanded = true };
                OboutTree.Nodes.Add(rootNode);

                foreach (DataRow row in ds.Tables["HspSprSttStr"].Rows)
                {
                    Html = Convert.ToString(row["STTSTRNAM"]);

                    Node newNode = new Node();
                    newNode.Text = Html;
                    newNode.ImageUrl = "/Icon/engineer-icon.png";
                    newNode.Value = Convert.ToString(row["STTSTRKEY"]);
                    newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                    this.OboutTree.Nodes.Add(newNode);
                }

            }


        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        private DataSet GetTree()
        {
            //          Service1 ws = new Service1();
            //           DataSet ds = new DataSet("Menu");
            //           ds.Merge(ws.InsSprCnt(MdbNam, BuxSid, BuxFrm));

            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();

            SqlCommand cmd = new SqlCommand("HspSprSttStr", con);
            cmd = new SqlCommand("HspSprSttStr", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = 0;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprSttStr");
            // ------------------------------------------------------------------------------заполняем второй уровень
            con.Close();

            return ds;
        }
        //=============Заполнение дерево с 2 его уровня и выше===========================================================================================

        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        // ======================================================================================
        //------------------------------------------------------------------------
        //=============При выборе узла дерево===========================================================================================
        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        protected void OboutTree_TreeNodeExpanded(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            int NodLen;
            int NodLen004;
            string NodVal;

            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
     //       TxtUsl.Text = e.Node.Value;

            NodVal = e.Node.Value;
            NodLen = e.Node.Value.Length;
            NodLen004 = NodLen + 6;

            if (NodLen == 11) return;
            //           if (NodLen == 5) ComStxKey = NodVal + ".";
            //           if (NodLen > 5) NodLen = NodLen + 6;

            //           Service1 ws = new Service1();
            //           DataSet ds = new DataSet("Menu");
            //            ds.Merge(ws.InsSprCntPop(MdbNam, BuxSid, BuxFrm, NodLen004, NodVal));
            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttStrPop", con);
            cmd = new SqlCommand("HspSprSttStrPop", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = NodLen;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = NodVal;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprSttStrPop");

            //=====================================================================================
            foreach (DataRow row in ds.Tables["HspSprSttStrPop"].Rows)
            {
                Html = Convert.ToString(row["STTSTRNAM"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["STTSTRKEY"]);
                if (newNode.Value.Length < 12) newNode.ImageUrl = "/Icon/help_book.gif";
                else newNode.ImageUrl = "/Icon/triangle_greenS.gif";
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                e.Node.ChildNodes.Add(newNode);
            }
        }

    </script>

<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         function onNodeSelect(sender, args) {
             var NodKey = sender.getNodeValue(args.node);         // Отбросить с начало 4 символ
             var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
             if (NodKey == null) NodKey = "";
             //      alert("NodKey=" + NodKey.length);
             //             alert("NodTxt=" + NodTxt);
             //     if (NodKey.length == 5)
             mySpl.loadPage("RightContent", "SprSttRspFioGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt);
         }
         // ------------------------  при выборе медуслуги в первой вкладке ------------------------------------------------------------------       
 </script>
 
   <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
       
<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
 
<!--  источники -----------------------------------------------------------  -->    
<!--  источники -----------------------------------------------------------  -->    
 <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None" Style="border-style: double; left: 10px;
            left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">

       
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


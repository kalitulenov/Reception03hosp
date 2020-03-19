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

                //          TxtBegDat.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                //           TxtEndDat.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                //------------------------------------------       чтение первых трех уровней дерево
                DataSet ds = GetTree();
                //------------------------------------------       чтение первых трех уровней дерево

                //                Node rootNode = new Node() { Text = "КОМПАНИИ", ImageUrl = "/Icon/ada.gif", Expanded = true };
                Node rootNode = new Node() { Text = "АНАЛИТИКА", ImageUrl = "/Icon/ada.gif", Expanded = true };
                OboutTree.Nodes.Add(rootNode);

                foreach (DataRow row in ds.Tables["BuxOctAnlTre"].Rows)
                {
                    Html = Convert.ToString(row["NAM"]);

                    Node newNode = new Node();
                    newNode.Text = Html;
                    newNode.ImageUrl = "/Icon/help_book.gif";
                    newNode.Value = Convert.ToString(row["KOD"]);
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

            SqlCommand cmd = new SqlCommand("BuxOctAnlTre", con);
            cmd = new SqlCommand("BuxOctAnlTre", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@ANLGOD", SqlDbType.VarChar).Value = BoxGod.SelectedValue;
            //          cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = TxtEndDat.Text;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxOctAnlTre");
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
            TxtUsl.Text = e.Node.Value;

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
            SqlCommand cmd = new SqlCommand("BuxOctAnlTre", con);
            cmd = new SqlCommand("BuxOctAnlTre", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = NodLen;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = NodVal;
            cmd.Parameters.Add("@ANLGOD", SqlDbType.VarChar).Value = BoxGod.SelectedValue;
            //          cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = TxtEndDat.Text;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxOctAnlTre");

            //=====================================================================================
            foreach (DataRow row in ds.Tables["BuxOctAnlTre"].Rows)
            {
                Html = Convert.ToString(row["NAM"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["KOD"]);
                if (newNode.Value.Length < 12) newNode.ImageUrl = "/Icon/help_obook.gif";
                else newNode.ImageUrl = "/Icon/triangle_greenS.gif";
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                e.Node.ChildNodes.Add(newNode);
            }
        }

        // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void GodButton_Click(object sender, EventArgs e)
        {
                //------------------------------------------       чтение первых трех уровней дерево
                DataSet ds = GetTree();
                //------------------------------------------       чтение первых трех уровней дерево
                Node rootNode = new Node() { Text = "АНАЛИТИКА", ImageUrl = "/Icon/ada.gif", Expanded = true };
                OboutTree.Nodes.Add(rootNode);

                foreach (DataRow row in ds.Tables["BuxGlvTre"].Rows)
                {
                    Html = Convert.ToString(row["NAM"]);

                    Node newNode = new Node();
                    newNode.Text = Html;
                    newNode.ImageUrl = "/Icon/help_book.gif";
                    newNode.Value = Convert.ToString(row["KOD"]);
                    newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                    this.OboutTree.Nodes.Add(newNode);
                }

        }
    </script>

<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         function onNodeSelect(sender, args) {
             var NodKey = sender.getNodeValue(args.node);         // Отбросить с начало 4 символ
             var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
             document.getElementById("MainContent_TxtUsl").value = NodTxt;
             alert("NodKey=" + NodKey);
             alert("NodKey=" + NodKey.length);
             alert("NodTxt=" + NodTxt);

             var NodAcc;
             var NodSpr;

             count = 0;
             var pos = NodKey.indexOf("/");
   //          alert("pos=" + pos);
             if (pos > 0)
             {
                 alert(NodKey.length - pos);
                 NodSpr = NodKey.substring(pos+1,NodKey.length);
  //               alert("NodSpr=" + NodSpr);
                 NodAcc = NodKey.substring(0,pos);
     //                alert("NodAcc=" + NodAcc);
                 }
             else {
                 NodSpr = "";
                 NodAcc = NodKey;
             }

             if (NodKey == null) NodKey = "";
    //         alert("NodSpr=" + NodSpr);
    //         alert("NodAcc=" + NodAcc);

             mySpl.loadPage("RightContent", "BuxOctAnlGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt + "&NodAcc=" + NodAcc + + "&NodSpr=" + NodSpr +
                            "&NodGod=" + document.getElementById("MainContent_mySpl_ctl00_ctl01_BoxGod").value);
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
        <asp:TextBox ID="TxtUsl" 
             Text="                                                            ГЛАВНАЯ КНИГА" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; align-items:center;"
             runat="server"></asp:TextBox>

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
           <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="250">
            <Content>
                <div style="margin: 5px;">
              
                  <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

           <table border="1" cellspacing="0" width="100%">
               <tr>
                   <td width="18%" class="PO_RowCap">
                      <asp:Label ID="Label17" Text="Год :" runat="server" Font-Bold="true" Font-Size="Large" width="50%"/>
                      <asp:DropDownList runat="server" ID="BoxGod" Width="10%"  Font-Size="Large" AutoPostBack="false" OnSelectedIndexChanged="GodButton_Click">
                            <Items>
                                <asp:ListItem Text="2017" Value="2017" />
                                <asp:ListItem Text="2018" Value="2018" />
                                <asp:ListItem Text="2019" Value="2019" />
                                <asp:ListItem Text="2020" Value="2020" />
                                <asp:ListItem Text="2021" Value="2021" />
                                <asp:ListItem Text="2022" Value="2022" />
                                <asp:ListItem Text="2023" Value="2023" />
                                <asp:ListItem Text="2024" Value="2024" />
                                <asp:ListItem Text="2025" Value="2025" />
                                <asp:ListItem Text="2026" Value="2026" />
                                <asp:ListItem Text="2027" Value="2027" />
                                <asp:ListItem Text="2028" Value="2028" />
                                <asp:ListItem Text="2029" Value="2029" />
                                <asp:ListItem Text="2030" Value="2030" />
                            </Items>
                        </asp:DropDownList>
                   </td>
               </tr>
           </table>


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


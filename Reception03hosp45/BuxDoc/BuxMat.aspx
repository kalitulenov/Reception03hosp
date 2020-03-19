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
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>

        <script type="text/javascript">
             // --------------  ИЗМЕНИТЬ ДАТУ ПРИЕМА ----------------------------
         function onDateChange(sender, selectedDate) {
        //               alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             if (dd < 10) dd = '0' + dd;
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;
          //   var DatDocValSes = new Date(DatDocVal);
         //    var DatDocValSes = '2017.11.01' + 'T00:00:00';
        //     var thisDateT = thisDate.substr(0, 10) + "T" + thisDate.substr(11, 8);

         //    alert(DatDocValSes);
         //    var jDate = new Date(DatDocValSes);

             // To Store
      //       $(function () {
      //           $.session.set("GlvBegDat", DatDocVal);
      //       });

             //             var GrfDocRek='GRFCTRDAT';
  //           alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
  //           alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
 //            alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

            }
       </script>

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

        string NumSpr;
        string TxtSpr;

        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            NumSpr =(string)Request.QueryString["NumSpr"];
            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            //=====================================================================================
            if (!Page.IsPostBack)
            {

                TxtBegDat.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                TxtEndDat.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                //------------------------------------------       чтение первых трех уровней дерево
                DataSet ds = GetTree();
                //------------------------------------------       чтение первых трех уровней дерево

                //                Node rootNode = new Node() { Text = "КОМПАНИИ", ImageUrl = "/Icon/ada.gif", Expanded = true };
                Node rootNode = new Node() { Text = "СЧЕТА ОРГАНИЗАЦИЙ ", ImageUrl = "/Icon/ada.gif", Expanded = true };
                OboutTree.Nodes.Add(rootNode);

                foreach (DataRow row in ds.Tables["BuxGlvTreMat"].Rows)
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

            SqlCommand cmd = new SqlCommand("BuxGlvTreMat", con);
            cmd = new SqlCommand("BuxGlvTreMat", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = 4;

            if (NumSpr=="МАТ") cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = "1310%";
            else cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = "2410%";

            cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = TxtBegDat.Text;
            cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = TxtEndDat.Text;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxGlvTreMat");
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
            Sapka.Text = e.Node.Value;

            NodVal = e.Node.Value;
            NodLen = e.Node.Value.Length;
            NodLen004 = NodLen + 6;
            NodLen = 10;

            //          if (NodLen == 11) return;
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
            SqlCommand cmd = new SqlCommand("BuxGlvTre", con);
            cmd = new SqlCommand("BuxGlvTre", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = NodLen;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = NodVal;
            cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = TxtBegDat.Text;
            cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = TxtEndDat.Text;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxGlvTre");

            //=====================================================================================
            foreach (DataRow row in ds.Tables["BuxGlvTre"].Rows)
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

        protected void OboutTree_SelectedTreeNodeChanged(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            int NodLvl;
            int NodVal;

            NodVal = Convert.ToInt32(e.Node.Value);
            Session["GrfKod"] = NodVal;
            NodLvl = e.Node.Level;

            //       TextBoxDoc.Text = e.Node.Text.PadLeft(10);      // добавляет слева пробел выравнивая общую длину до 1000
            //       getPostBackControlName();

        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            DateTime GlvBegDat;
            DateTime GlvEndDat;

            Session["GlvBegDat"] = DateTime.Parse(TxtBegDat.Text);
            Session["GlvEndDat"] = DateTime.Parse(TxtEndDat.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];


  //          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
  //          GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

        }
    </script>

<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         function onNodeSelect(sender, args) {
     //        alert("args=" + args.node);
             var NodKey = sender.getNodeValue(args.node);        // Отбросить с начало 4 символ
             var NodTxt = sender.getNodeText(args.node);         // Отбросить с начало 4 символ
             if (NodKey == null) NodKey = "";
      //       alert("NodKey=" + NodKey.length);
      //       alert("NodTxt=" + NodTxt);
             mySpl.loadPage("RightContent", "BuxMatGrd.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt +
                            "&BegDat=" + document.getElementById("MainContent_mySpl_ctl00_ctl01_TxtBegDat").value +
                            "&EndDat=" + document.getElementById("MainContent_mySpl_ctl00_ctl01_TxtEndDat").value);
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

        <asp:TextBox ID="Sapka" 
             Text="                                                            МАТЕРИАЛЫ" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
           <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="250">
            <Content>
                <div style="margin: 5px;">
              
                  <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

           <table border="1" cellspacing="0" width="100%">
               <tr>
                   <td width="18%" class="PO_RowCap">
                       <asp:TextBox runat="server" ID="TxtBegDat" Width="65px" BackColor="#FFFFE0" />
                       <obout:Calendar ID="cal1" runat="server"
                           StyleFolder="/Styles/Calendar/styles/default"
                           DatePickerMode="true"
                           ShowYearSelector="true"
                           YearSelectorType="DropDownList"
                           TitleText="Выберите год: "
                           CultureName="ru-RU"
                           TextBoxId="TxtBegDat"
                           OnClientDateChanged="onDateChange"   
                           DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                       <asp:TextBox runat="server" ID="TxtEndDat" Width="65px" BackColor="#FFFFE0" />
                       <obout:Calendar ID="cal2" runat="server"
                           StyleFolder="/Styles/Calendar/styles/default"
                           DatePickerMode="true"
                           ShowYearSelector="true"
                           YearSelectorType="DropDownList"
                           TitleText="Выберите год: "
                           CultureName="ru-RU"
                           TextBoxId="TxtEndDat"
                           OnClientDateChanged="onDateChange"   
                           DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                   </td>
               </tr>
   </table>
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" Width="100%" onclick="PushButton_Click"/>

                     <hr />

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


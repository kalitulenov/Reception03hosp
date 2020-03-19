<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ============================  для почты  ============================================ --%>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>
<%-- ============================конец для почты  ============================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%> 
 
    <style type="text/css">
     /* ------------------------------------- для удаления отступов в GRID -------------------------------- */
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
        
        /*------------------------- для TREE  --------------------------------*/
       .modalBackground 
       {
           background-color:Gray;
       }

        /*------------------------- для TREE  --------------------------------*/
       .modalPopup {
           background-color:#FFD9D5;
           border-width:3px;
           border-style:solid;
           border-color:Gray;
           padding:3px;
           width:250px;
       }

        /*------------------------- для TREE шрифт  --------------------------------*/
        input.c {height:13px; width:13px; margin-left:0px; margin-right:6px; margin-bottom:0px; margin-top:1px;} 
</style>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
        function Send(bSent) {
      //      var str;
      //      alert("bSent=" + bSent.length + "  " + bSent);
     //       str = bSent.replace(/[,]/g, 'T'); // заменть запятую на пробел
            ob_post.AddParam("LstChk", bSent);
            ob_post.post(null, "CreateChk", function () { });
            windowalert("Готова...", "Сообщение", "warning");
      //      alert("Готова...");
        }

        function PrtButton_Click() {
            var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprBuxMnu&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprBuxMnu&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

    </script>	


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int BuxKod = 0;
        int BuxFlg;
        string BuxSid;
        string BuxFrm;
        string BuxFio = "";
        string BuxDlg = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            parBuxFrm.Value = BuxFrm;

            // =====================================================================================
          

            //===================================================================================================
            if (!Page.IsPostBack)
            {

                PopulateGrid1();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComUslKey", 0);
            }

            if (grid1.SelectedRecords != null)
            {
                //=====================================================================================
                BuxSid = (string)Session["BuxSid"];
                BuxFrm = (string)Session["BuxFrmKod"];
                string Html;
                //=====================================================================================
                foreach (Hashtable oRecord in grid1.SelectedRecords)
                {
                    BuxKod = Convert.ToInt32(oRecord["BuxKod"]);
                    BuxFio = Convert.ToString(oRecord["FI"]);
                    BuxDlg = Convert.ToString(oRecord["DLGNAM"]);
                    Session.Add("ComBuxKod", (int)BuxKod);

                    //------------       чтение уровней дерево
                    DataSet ds = new DataSet();
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    SqlConnection con = new SqlConnection(connectionString);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("ComSprBuxMnu", con);
                    cmd = new SqlCommand("ComSprBuxMnu", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    // создать коллекцию параметров
                    cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.Int,4));
                    // передать параметр
                    cmd.Parameters["@BUXSID"].Value = BuxSid;
                    cmd.Parameters["@BUXFRM"].Value = BuxFrm;
                    cmd.Parameters["@BUXKOD"].Value = BuxKod;
                    // создание DataAdapter
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    // заполняем DataSet из хран.процедуры.
                    da.Fill(ds, "ComSprBuxMnu");
               
                    con.Close();

                    //=====================================================================================
                    TextBoxDoc.Text = BuxFio.PadLeft(10) + "  (" + BuxDlg + ")";
                    
                    obout_ASPTreeView_2_NET.Tree oTree = new obout_ASPTreeView_2_NET.Tree();

 //                   oTree.AddRootNode("<big><ins><b>" + BuxFio + "</b></ins></big>", true, "woman2S.gif");
                    
                    foreach (DataRow row in ds.Tables["ComSprBuxMnu"].Rows)
                        {
                         BuxFlg= Convert.ToInt32(row["StrUslFlg"]);

                         if (BuxFlg == 0)
                             Html = "<input class='c' type='checkbox' id='chk_" +
                                 Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslNam"];
                         else
                             Html = "<input class='c' type='checkbox' checked id='chk_" +
                                  Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslNam"];
                        
                         int count = new Regex(Regex.Escape(".")).Matches(Convert.ToString(row["StrUslKey"])).Count;
           //              int count = new Regex(Regex.Escape(needle)).Matches(haystack).Count;
 
//                         switch (Convert.ToString(row["StrUslKey"]).Length)
                         switch (count)
                            {
     //                       case 0:
     //                           break;
                            case 0:
                                Html = "<input class='c' type='checkbox' id='chk_" +
                                     Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'><b>" + row["StrUslNam"] + "</b>";
                                oTree.Add("root", row["StrUslKey"], Html, false, null, null);
                                BuxKey003 = Convert.ToString(row["StrUslKey"]); 
                                break;
                             case 1:
                                oTree.Add(BuxKey003, row["StrUslKey"], Html, false, null, null);
                                BuxKey007=Convert.ToString(row["StrUslKey"]); 
                                break;
                            case 2:
                                oTree.Add(BuxKey007, row["StrUslKey"], Html, false, "red_ball.gif", null);
                                BuxKey011=Convert.ToString(row["StrUslKey"]); 
                                break;
                            case 3:
                                oTree.Add(BuxKey011, row["StrUslKey"], Html, false, "red_ball.gif", null);
                                BuxKey015 = Convert.ToString(row["StrUslKey"]);
                                break;
                            default:
                                break;
                            }   
                        
                        }
                        
                    oTree.FolderIcons = "/Styles/tree2/icons";
                    oTree.FolderScript = "/Styles/tree2/script";
                    oTree.FolderStyle = "/Styles/tree2/style";
                    oTree.SelectedEnable = false;
                    //oTree.SelectedId = "a1_0";
                    oTree.ShowIcons = true;
                    oTree.Width = "600px";
                    oTree.Height = "520px";
                    oTree.EventList = "";
    
                    TreeView.Text = oTree.HTML();
                }

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGrid1()
        {
            //            int Pol;
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            /*
            SqlCommand cmd = new SqlCommand("SELECT BuxKod,ISNULL(KDR.KDRFAM, N'') + N' ' + ISNULL(KDR.KDRIMA, N'') + N' ' + ISNULL(KDR.KDROTC, N'') AS FIO, " +
                                 "ISNULL(KDR.KDRFAM, N'') + N' ' + LEFT(ISNULL(KDR.KDRIMA, N''), 1) + N' ' + LEFT(ISNULL(KDR.KDROTC, N''), 1) AS FI," +
                                 "SprDlg.DLGNAM,SprZan.ZANNAM,SprBux.BuxUbl,SprBux.BuxDlg " +
                                 "FROM SprDlg LEFT OUTER JOIN SprZan ON SprDlg.DLGZAN=SprZan.ZANKOD " +
                                 "RIGHT OUTER JOIN SprBux ON SprDlg.DLGKOD=SprBux.BuxDlg " +
                                 "LEFT OUTER JOIN KDR ON SprBux.BuxTab=KDR.KDRKOD " +
                                 "WHERE SprBux.BuxUbl=0 AND BUXFRM='" + BuxFrm + "' ORDER BY KDR.KDRFAM", con);
             */
            SqlCommand cmd = new SqlCommand("SELECT * FROM SprBuxKdr WHERE ISNULL(BuxUbl,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FIO", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //     cmd.Parameters.Add("@BUXAPP", SqlDbType.Int, 4).Value = Convert.ToInt32(Session["BuxApp"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            con.Open();

            da.Fill(ds, "Bux");
            grid1.DataSource = ds.Tables[0].DefaultView;
            grid1.DataBind();

            con.Close();
        }
        
        public void CreateChk(string LstChk)
        {
      //      string LstUsl;
      //      LstChk = LstChk.Replace(",", @" ");
            
            BuxKod = Convert.ToInt32(Session["ComBuxKod"]);
            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSprBuxMnuWrt", con);
            cmd = new SqlCommand("ComSprBuxMnuWrt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.Int,4));
            cmd.Parameters.Add(new SqlParameter("@BUXLSTMNU", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BuxSid;
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            cmd.Parameters["@BUXKOD"].Value = BuxKod;
            cmd.Parameters["@BUXLSTMNU"].Value = LstChk;
            // выполнить
            cmd.ExecuteNonQuery();
            con.Close();

        }
        // ======================================================================================
     </script> 
     
     
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
<!--  конец -----------------------------------------------  -->    
  <%-- ============================  для передач значении  ============================================ --%>
    <asp:HiddenField ID="parChkLst" runat="server" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />
    
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
        
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px;
                       left: 0px; position: relative; top: 0px; width: 30%; height: 450px;">
     		         
     		           <obout:Grid id="grid1" runat="server" 
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
	                    	
           </asp:Panel>
 
           <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="Both"
                      Style="left: 31%; position: relative; top: -455px; width: 70%; height: 450px;">
  
               <table border="0" cellspacing="0" width="100%">
                   <tr>
                       <td width="10%" class="PO_RowCap">
                           <input type="button" value="Записать" style="width: 100%; height: 28px;" id="ButtonWrt" onclick="Send(ob_t2_list_checked());" />
                       </td>
                       <td width="75%" class="PO_RowCap">
                           <asp:TextBox ID="TextBoxDoc"
                               Text="Меню врачей"
                               BackColor="White"
                               Font-Names="Verdana"
                               Font-Size="18px"
                               Font-Bold="True"
                               ForeColor="#0099FF"
                               Style="top: 0px; left: 0px; position: relative; width:100%"
                               runat="server"></asp:TextBox>
                       </td>
                       <td width="20%" class="PO_RowCap">
                           <input type="button" name="PrtButton" style="width: 100%; height:28px;" value="Печать справочника" id="PrtButton" onclick="PrtButton_Click();" />
                       </td>
                   </tr>
               </table>

            <table border="0">
	            <tr><td valign="top">
	        	<asp:Literal id="TreeView" EnableViewState="false" runat="server" />
            	</td><td width="50px">&nbsp;
            	</td><td valign="top" class="tdText">
    		    <br />
		        <br />
		        <br />
	            </td></tr>
            </table>

	      </asp:Panel> 
	
       </div>
   
       <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    
</asp:Content>

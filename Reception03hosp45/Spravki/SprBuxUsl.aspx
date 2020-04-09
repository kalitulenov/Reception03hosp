<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>


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
     //      alert("updateSent01=" + bSent.length + "  " + bSent);
     //       str = bSent.replace(/[,]/g, 'T'); // заменть запятую на пробел
     //       alert("parPrcKod=" + document.getElementById('MainContent_parPrcKod').value);
            ob_post.AddParam("LstChk", bSent);
            ob_post.AddParam("TekPrc", document.getElementById('MainContent_parPrcKod').value);
            
            ob_post.post(null, "CreateChk", function() { });
            windowalert("Готова...", "Сообщение", "warning");
      //      alert("Готова...");
        }


        function PrtButton_Click() {
            var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;
            var GrfPrc = document.getElementById('MainContent_parPrcKod').value;

          //  alert('GrfPrc =' + GrfPrc);

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprBuxUsl&TekDocIdn=" + GrfPrc + "&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprBuxUsl&TekDocIdn=" + GrfPrc + "&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

    </script>	


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int BuxKod = 0;
        int BuxFlg;
        int BuxTyp;
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
            SdsPrc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsPrc.SelectCommand = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprCnt INNER JOIN SprPrc ON SprCnt.CntPrc=SprPrc.PrcKod " +
                                   "WHERE CntLvl=0 And CntFrm=" + BuxFrm +
                                   "GROUP BY SprPrc.PrcKod,SprPrc.PrcNam " +
                                   " ORDER BY SprPrc.PrcKod";


            //===================================================================================================
            if (!Page.IsPostBack)
            {

                PopulateGridDoc();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComUslKey", 0);
                getPrcNum();
            }

            if (GridDoc.SelectedRecords != null)
            {
                //=====================================================================================
                BuxSid = (string)Session["BuxSid"];
                BuxFrm = (string)Session["BuxFrmKod"];
                string Html;
                //=====================================================================================
                foreach (Hashtable oRecord in GridDoc.SelectedRecords)
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
                    SqlCommand cmd = new SqlCommand("ComSprBuxUsl", con);
                    cmd = new SqlCommand("ComSprBuxUsl", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    // создать коллекцию параметров
                    cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.Int, 4));
                    cmd.Parameters.Add(new SqlParameter("@BUXPRC", SqlDbType.Int, 4));
                    // передать параметр
                    cmd.Parameters["@BUXSID"].Value = BuxSid;
                    cmd.Parameters["@BUXFRM"].Value = BuxFrm;
                    cmd.Parameters["@BUXKOD"].Value = BuxKod;
                    cmd.Parameters["@BUXPRC"].Value = parPrcKod.Value;

                    // создание DataAdapter
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    // заполняем DataSet из хран.процедуры.
                    da.Fill(ds, "ComSprBuxUsl");

                    if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0) { }  // проверка на пустой ds
                    else
                    {
                        //=====================================================================================
                        TextBoxDoc.Text = BuxFio.PadLeft(10) + "  (" + BuxDlg + ")";

                        obout_ASPTreeView_2_NET.Tree oTree = new obout_ASPTreeView_2_NET.Tree();

                        //                  oTree.AddRootNode("<big><ins><b>" + BuxFio + "</b></ins></big>", true, "woman2S.gif");

                        foreach (DataRow row in ds.Tables["ComSprBuxUsl"].Rows)
                        {
                            BuxFlg = Convert.ToInt32(row["StrUslFlg"]);
                            BuxTyp = Convert.ToInt32(row["StrUslTyp"]);

                            if (BuxFlg == 0)
                                Html = "<input class='c' type='checkbox' id='chk_" +
                                    Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslNam"];
                            else
                                Html = "<input class='c' type='checkbox' checked id='chk_" +
                                     Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslNam"];

                            switch (Convert.ToString(row["StrUslKey"]).Length)
                            {
                                case 0:
                                    break;
                                case 3:
                                    Html = "<input class='c' type='checkbox' id='chk_" +
                                         Convert.ToString(row["StrUslKod"]) + "' onclick='ob_t2c(this)'><b>" + row["StrUslNam"] + "</b>";
                                    oTree.Add("root", row["StrUslKey"], Html, false, null, null);
                                    BuxKey003 = Convert.ToString(row["StrUslKey"]);
                                    break;
                                case 7:
                                    if (BuxTyp == 0) oTree.Add(BuxKey003, row["StrUslKey"], Html, false, null, null);
                                    else oTree.Add(BuxKey003, row["StrUslKey"], Html, false, "red_ball.gif", null);

                                    BuxKey007 = Convert.ToString(row["StrUslKey"]);
                                    break;
                                case 11:
                                    if (BuxTyp == 0) oTree.Add(BuxKey007, row["StrUslKey"], Html, false, null, null);
                                    else oTree.Add(BuxKey007, row["StrUslKey"], Html, false, "red_ball.gif", null);

                                    BuxKey011 = Convert.ToString(row["StrUslKey"]);
                                    break;
                                case 15:
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
        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridDoc()
        {
            //            int Pol;
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM SprBuxKdr WHERE ISNULL(BuxUbl,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FIO", con);
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

        public void CreateChk(string LstChk,string TekPrc)
        {
            //      string LstUsl;
            //      LstChk = LstChk.Replace(",", @" ");

            BuxKod = Convert.ToInt32(Session["ComBuxKod"]);
            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSprBuxUslWrt", con);
            cmd = new SqlCommand("ComSprBuxUslWrt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.Int,4));
            cmd.Parameters.Add(new SqlParameter("@BUXPRC", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXLSTUSL", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BuxSid;
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            cmd.Parameters["@BUXKOD"].Value = BuxKod;
            cmd.Parameters["@BUXPRC"].Value = TekPrc;  // parPrcKod.Value;
            cmd.Parameters["@BUXLSTUSL"].Value = LstChk;
            // выполнить
            cmd.ExecuteNonQuery();
            con.Close();


        }

        //------------------------------------------------------------------------
        protected void BoxPrc_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            string TekPrc;
            parPrcKod.Value = BoxPrc.SelectedValue;
            Page_Load(null, EventArgs.Empty);  //  вызов Page_Load
        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getPrcNum()
        {
            string SqlPrc;
            SqlPrc = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                     "FROM SprCnt INNER JOIN SprPrc ON SprCnt.CntPrc=SprPrc.PrcKod " +
                     "WHERE CntLvl=0 And CntFrm=" + BuxFrm + " AND PATINDEX('%платно%',SprPrc.PrcNam) > 0 " +
                     "GROUP BY SprPrc.PrcKod,SprPrc.PrcNam " +
                     " ORDER BY SprPrc.PrcKod";
            // SqlPrc = "SELECT CntKod,CntPrc,CntNam FROM SprCnt WHERE CntLvl=0 And CntFrm=" + BuxFrm + " AND PATINDEX('%платно%',CntNam) > 0 ORDER BY CntKod";

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(SqlPrc, con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "SprPrc");

            con.Close();

            BoxPrc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PrcKod"]);
            parPrcKod.Value = Convert.ToString(ds.Tables[0].Rows[0]["PrcKod"]);
        }
        // ======================================================================================
     </script> 
     
     
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** 600
             <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px;
                       left: 0px; position: relative; top: 0px; width: 30%; height: 600px;">      
        --%>
<!--  конец -----------------------------------------------  -->    
  <%-- ============================  для передач значении  ============================================ --%>
     <asp:HiddenField ID="parChkLst" runat="server" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />
     <asp:HiddenField ID="parPrcKod" runat="server" />
    
    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                                            Справочник врачей + услуги" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>
        
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px;
                       left: 0px; position: relative; top: 0px; width: 30%; height: 450px;">
     		         
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
	                    			<obout:Column ID="Column1" DataField="BuxKod" HeaderText="Код" ReadOnly ="true" Width="10%" />
                    				<obout:Column ID="Column2" DataField="FI" HeaderText="Фамилия И.О."  Width="30%" />
                    				<obout:Column ID="Column3" DataField="DLGNAM" HeaderText="Специалист"  Width="60%" />
		                    	</Columns>
	                    	</obout:Grid>	
	                    	
           </asp:Panel>
 
           <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="Both"
                      Style="left: 31%; position: relative; top: -455px; width: 70%; height: 450px;">



               <table border="0" cellspacing="0" width="100%">
                   <tr>
                       <td width="15%" class="PO_RowCap">
                           <obout:ComboBox runat="server" ID="BoxPrc" Width="100%" Height="200"
                               FolderStyle="/Styles/Combobox/Plain"
                               AutoPostBack="true" OnSelectedIndexChanged="BoxPrc_OnSelectedIndexChanged"
                               DataSourceID="SdsPrc" DataTextField="PRCNAM" DataValueField="PRCKOD" />
                       </td>
                       <td width="10%" class="PO_RowCap">
                           <input type="button" value="Записать" style="width: 100%; height: 28px;" id="Button1" onclick="Send(ob_t2_list_checked());" />
                       </td>
                       <td width="55%" class="PO_RowCap">
                           <asp:TextBox ID="TextBoxDoc"
                               Text="Услуги врачей"
                               BackColor="White"
                               Font-Names="Verdana"
                               Font-Size="18px"
                               Font-Bold="True"
                               ForeColor="#0099FF"
                               Style="top: 0px; left: 0px; position: relative; width: 100%"
                               runat="server"></asp:TextBox>
                       </td>

                       <td width="10%" class="PO_RowCap">
                           <input type="button" name="PrtButton" style="width: 100%; height: 28px;" value="Печать справочника" id="PrtButton" onclick="PrtButton_Click();" />
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
     <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
     

</asp:Content>

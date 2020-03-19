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
      //     alert("updateSent01=" + bSent.length + "  " + bSent);
     //       str = bSent.replace(/[,]/g, 'T'); // заменть запятую на пробел
            ob_post.AddParam("LstChk", bSent);
            ob_post.post(null, "CreateChk", function() { });
            windowalert("Готова...", "Сообщение", "warning");
      //      alert("Готова...");
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

            // =====================================================================================


            //===================================================================================================
            if (!Page.IsPostBack)
            {

                Session.Add("ComBuxKod", 0);
                Session.Add("ComUslKey", 0);
            }

            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            string Html;
            //=====================================================================================

            //     BuxKod = Convert.ToInt32(oRecord["BuxKod"]);
            //      BuxFio = Convert.ToString(oRecord["FI"]);
            //      BuxDlg = Convert.ToString(oRecord["DLGNAM"]);
            //     Session.Add("ComBuxKod", (int)BuxKod);

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSprStrUslFrm", con);
            cmd = new SqlCommand("ComSprStrUslFrm", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BuxSid;
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprStrUslFrm");

            //=====================================================================================
         //   TextBoxDoc.Text = BuxFio.PadLeft(10) + "  (" + BuxDlg + ")";

            if (ds.Tables[0].Rows.Count > 0)
            {
                obout_ASPTreeView_2_NET.Tree oTree = new obout_ASPTreeView_2_NET.Tree();

                //                  oTree.AddRootNode("<big><ins><b>" + BuxFio + "</b></ins></big>", true, "woman2S.gif");

                foreach (DataRow row in ds.Tables["ComSprStrUslFrm"].Rows)
                {
                    BuxFlg = Convert.ToInt32(row["StrUslFrmFlg"]);
                    //    BuxTyp = Convert.ToInt32(row["StrUslFrmTyp"]);

                    if (BuxFlg == 0)
                        Html = "<input class='c' type='checkbox' id='chk_" +
                            Convert.ToString(row["StrUslFrmKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslFrmNam"];
                    else
                        Html = "<input class='c' type='checkbox' checked id='chk_" +
                             Convert.ToString(row["StrUslFrmKod"]) + "' onclick='ob_t2c(this)'>" + row["StrUslFrmNam"];

                    switch (Convert.ToString(row["StrUslFrmKey"]).Length)
                    {
                        case 0:
                            break;
                        case 3:
                            Html = "<input class='c' type='checkbox' id='chk_" + Convert.ToString(row["StrUslFrmKod"]) + "' onclick='ob_t2c(this)'><b>" + row["StrUslFrmNam"] + "</b>";
                            if (BuxFlg == 0) Html = "<input class='c' type='checkbox' id='chk_" + Convert.ToString(row["StrUslFrmKod"]) + "' onclick='ob_t2c(this)'><b>" + row["StrUslFrmNam"] + "</b>";
                            else Html = "<input class='c' type='checkbox' checked id='chk_" + Convert.ToString(row["StrUslFrmKod"]) + "' onclick='ob_t2c(this)'><b>" + row["StrUslFrmNam"] + "</b>";

                            oTree.Add("root", row["StrUslFrmKey"], Html, false, null, null);
                            BuxKey003 = Convert.ToString(row["StrUslFrmKey"]);
                            break;
                        case 7:
                            if (BuxTyp == 0) oTree.Add(BuxKey003, row["StrUslFrmKey"], Html, false, null, null);
                            else oTree.Add(BuxKey003, row["StrUslFrmKey"], Html, false, "red_ball.gif", null);

                            BuxKey007 = Convert.ToString(row["StrUslFrmKey"]);
                            break;
                        case 11:
                            if (BuxTyp == 0) oTree.Add(BuxKey007, row["StrUslFrmKey"], Html, false, null, null);
                            else oTree.Add(BuxKey007, row["StrUslFrmKey"], Html, false, "red_ball.gif", null);

                            BuxKey011 = Convert.ToString(row["StrUslFrmKey"]);
                            break;
                        case 15:
                            oTree.Add(BuxKey011, row["StrUslFrmKey"], Html, false, "red_ball.gif", null);
                            BuxKey015 = Convert.ToString(row["StrUslFrmKey"]);
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
                oTree.Width = "500px";
                oTree.Height = "520px";
                oTree.EventList = "";

                TreeView.Text = oTree.HTML();
            }
        }

        // ============================ чтение таблицы а оп ==============================================

        public void CreateChk(string LstChk)
        {
            //      string LstUsl;
            //      LstChk = LstChk.Replace(",", @" ");

            BuxKod = Convert.ToInt32(Session["ComBuxKod"]);
            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSprStrUslFrmWrt", con);
            cmd = new SqlCommand("ComSprStrUslFrmWrt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXLSTUSL", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BuxSid;
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            cmd.Parameters["@BUXLSTUSL"].Value = LstChk;
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
    
    <div>
        <asp:TextBox ID="TextBox1"
            Text="   Структура справочника прейскуранта цен"
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 30%; position: relative; width: 40%"
            runat="server"></asp:TextBox>

        <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 30%; position: relative; top: 0px; width: 40%; height: 600px;">

            <table border="0">
                <tr>
                    <td valign="top">
                        <asp:Literal ID="TreeView" EnableViewState="false" runat="server" />
                    </td>
                    <td width="50px">&nbsp;
                    </td>
                    <td valign="top" class="tdText">
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
             <hr />
             <center>
                       <input type="button" value="Записать" style="width: 40%; height: 25px;" id="Button1" onclick="Send(ob_t2_list_checked());" />
             </center>



        </asp:Panel>

    </div>

    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />
      

</asp:Content>

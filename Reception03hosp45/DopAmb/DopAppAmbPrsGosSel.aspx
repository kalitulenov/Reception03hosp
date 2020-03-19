<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

 


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
        function ExitFun() {
       //     var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
        //                        alert("GrfFio=" + GrfFio); 
       //     localStorage.setItem("KasSumMem", KasSumMem); //setter
            window.opener.HandlePopupPost("PrsRef");
            self.close();
        //   window.parent.UslRef();
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          

    </script>

</head>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int BuxKod = 0;
        int BuxPrs = 0;
        int BuxFlg;
        int BuxTyp;
        string BuxSid;
        string BuxFrm;
        string BuxStx;
        
        string BuxFio = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        string whereClause = "";
        
        string AmbCrdIdn = "";
   //     string AmbCrdFio = "";
       
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            // =====================================================================================
        //    BuxKod = Convert.ToInt32(Request.QueryString["BuxKod"]);
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //    AmbCrdFio = Convert.ToString(Request.QueryString["AmbCrdFio"]);
        //    sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //===================================================================================================
            if (!Page.IsPostBack)
            {

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

                whereClause = "";
                PopulateGridPrs();
          //      Sapka.Text = AmbCrdFio;
             
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridPrs()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprPrsAmbIdn", con);
            cmd = new SqlCommand("HspSprPrsAmbIdn", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int,4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXCND", SqlDbType.VarChar).Value = whereClause;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprPrsAmbIdn");

            GridPrs.DataSource = ds;
            GridPrs.DataBind();

            con.Close();
        }
        
        // ============================ чтение таблицы а оп ==============================================
        // ======================================================================================
        void WritePrs(object sender, EventArgs e)
        {
            string selectedOrderIds = "";
            int BuxLgt;

            for (int i = 0; i < GridPrs.RowsInViewState.Count; i++)
            {
                GridDataControlFieldCell cell = GridPrs.RowsInViewState[i].Cells[0] as GridDataControlFieldCell;
                CheckBox chk = cell.FindControl("ChkID") as CheckBox;

                if (chk.Checked == true)
                {
                    if (!string.IsNullOrEmpty(selectedOrderIds))
                        selectedOrderIds += "&";

                    selectedOrderIds += chk.ToolTip;
                }
            }

            if (!string.IsNullOrEmpty(selectedOrderIds))
            {
                //------------       чтение уровней дерево
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("DopAmbPrsStxAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
                cmd.Parameters.Add("@USLKODLST", SqlDbType.VarChar).Value = selectedOrderIds;
                // создание команды
                cmd.ExecuteNonQuery();
                con.Close();

                ExecOnLoad("ExitFun();");
            }
        }
        
        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            // создание команды
            whereClause = "";
            if (FndPrs.Text != "")
            {
                I = I + 1;
                whereClause += "UslNamFul LIKE '%" + FndPrs.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");

                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
                BuxKod = 0;
                PopulateGridPrs();

            }
        }       
        
        
        // ======================================================================================
        void GridPrs_RowDataBound(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow && GridPrs.RowsInViewState.Count > 0)
            {
                GridDataControlFieldCell cell = e.Row.Cells[0] as GridDataControlFieldCell;
                CheckBox chk = cell.FindControl("ChkID") as CheckBox;

                GridDataControlFieldCell cellInViewState = GridPrs.RowsInViewState[e.Row.RowIndex].Cells[0] as GridDataControlFieldCell;
                CheckBox chkInViewState = cellInViewState.FindControl("ChkID") as CheckBox;

                if (cell.Value == chkInViewState.ToolTip)
                {
                    chk.Checked = chkInViewState.Checked;
                }
            }
        }

        //------------------------------------------------------------------------
    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
     
<body>
    <form id="form1" runat="server">

        <!--  конец -----------------------------------------------  -->
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parChkLst" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

      
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None"
                Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td width="80%">
                            <asp:TextBox ID="FndPrs" Width="60%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                Style="position: relative; font-weight: 700; font-size: small;" />
                            <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="30%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                        <td width="10%">
                            <asp:Button ID="Button2" runat="server"
                                OnClick="WritePrs"
                                Width="100%" CommandName="Cancel"
                                Text="Записать" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                    </tr>
                </table>

                  
               <obout:Grid ID="GridPrs" runat="server"
                  CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_5" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "false"
  AllowMultiRecordSelection="false"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "-1"
	            AllowPaging="false"
          EnableRecordHover="false"
                AllowManualPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
                ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="510" />
                    <Columns>
                        <obout:Column ID="Column01" DataField="USLKOD" HeaderText="+" ReadOnly="true" Visible="true" Width="5%" runat="server" >
				             <TemplateSettings TemplateID="TemplateWithCheckbox" />
				        </obout:Column>
                        <obout:Column ID="Column02" DataField="USLTRF" HeaderText="ШИФР" Width="10%" Align="left" />
                        <obout:Column ID="Column03" DataField="USLNAM" HeaderText="УСЛУГА" Width="75%" />
                        <obout:Column ID="Column04" DataField="GDE" HeaderText="ГДЕ" Width="10%" />
                    </Columns>

			        <Templates>
			        	<obout:GridTemplate runat="server" ID="TemplateWithCheckbox">
				        	<Template>
				        		<asp:CheckBox runat="server" ID="ChkID" ToolTip="<%# Container.Value %>" />
				        	</Template>
				        </obout:GridTemplate>
		        	</Templates>

                </obout:Grid>

            </asp:Panel>
    </form>

   <%-- ************************************* стили **************************************************** 
                 OnRowDataBound="GridPrs_RowDataBound"
      
       --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <style type="text/css">
             /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

       /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
               

			}
			a.pg:hover {
				color:crimson;
			}

        /*------------------------- форма без scrollbara --------------------------------*/
          html { overflow-y: hidden; }
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
    </style>

</body>




</html>

<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

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
           window.opener.HandlePopupResult("UslRef");
           self.close();
        //   window.parent.UslRef();
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          

        function filterGrid(e) {
            var fieldName;
            //        alert("filterGrid=");

            if (e != 'ВСЕ') {
                fieldName = 'USLNAM';
                GridUsl.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                GridUsl.executeFilter();
            }
            else {
                GridUsl.removeFilter();
            }
        }

        function ExpKasMem() {

            var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
            //                    alert("GrfFio=" + GrfFio); 
            localStorage.setItem("KasSumMem", KasSumMem); //setter
            window.opener.HandlePopupResult(KasSumMem);
            //            window.parent.KltClose();
            self.close();
        }

    </script>

</head>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int BuxKod = 0;
        int BuxUsl = 0;
        int BuxFlg;
        int BuxTyp;
        string BuxSid;
        string BuxFrm;
        
        string BuxFio = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        string whereClause = "";
        
        string AmbKasIdn = "";
        string AmbKasIin = "";
       
        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            // =====================================================================================
            AmbKasIdn = Convert.ToString(Request.QueryString["KasIdn"]);
            AmbKasIin = Convert.ToString(Request.QueryString["KasIin"]);
            //===================================================================================================
            if (!Page.IsPostBack)
            {

                PopulateGridDoc();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComUslKey", 0);

                string[] alphabet = ";;;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();
   
                
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
                    parBuxKod.Value = Convert.ToString(oRecord["BuxKod"]);
                    
                    BuxFio = Convert.ToString(oRecord["FI"]);
                    Session.Add("ComBuxKod", (int)BuxKod);
                    //=====================================================================================
                    TextBoxDoc.Text = BuxFio.PadLeft(10);
                    whereClause = "";
                    PopulateGridUsl();
                }
            }
        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridUsl()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprUslDoc", con);
            cmd = new SqlCommand("HspSprUslDoc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BUXCND", SqlDbType.VarChar).Value = whereClause;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprUslDoc");

            GridUsl.DataSource = ds;
            GridUsl.DataBind();

            con.Close();
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
            SqlCommand cmd = new SqlCommand("SELECT * FROM SprBuxKdr WHERE ISNULL(DLGZAP,0)>0 AND BuxUbl=0 AND BUXFRM=" + BuxFrm + " ORDER BY FIO", con);
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
          
        // ======================================================================================
        void WriteKas(object sender, EventArgs e)
        {
            string selectedOrderIds = "";

            for (int i = 0; i < GridUsl.RowsInViewState.Count; i++)
            {
                GridDataControlFieldCell cell = GridUsl.RowsInViewState[i].Cells[0] as GridDataControlFieldCell;
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
                //   FndUsl.Text = selectedOrderIds;
                
                // ------------------------------------------------------------------------------заполняем второй уровень
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprUslDocCsh", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
                cmd.Parameters.Add("@USLKODLST", SqlDbType.VarChar).Value = selectedOrderIds;
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "HspSprUslDocCsh");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    parKasSum.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
                    parKasMem.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
                }
                else
                {
                    parKasSum.Value = "";
                    parKasMem.Value = "";
                }

                //      getGridUsl();

                //      ConfirmDialogKas.Visible = false;
                //       ConfirmDialogKas.VisibleOnLoad = false;


                //                       GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
                ExecOnLoad("ExpKasMem();");
            }


        }
        
        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

         //   string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
      //      SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndUsl.Text != "")
            {
                I = I + 1;
                whereClause += "SprUsl.UslNam LIKE '%" + FndUsl.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
                /*
                                Service1 ws = new Service1();
                                DataSet ds = new DataSet("Menu");
                                ds.Merge(ws.InsSprKltSelFil(MdbNam, BuxSid, BuxFrm, whereClause));
                                grid1.DataSource = ds;
                                grid1.DataBind();
                */
                //           sdsPrg.SelectCommand = "InsPlnFktOneKlt";
                BuxKod = 0;
                PopulateGridUsl();

            }
        }       
        
        
        // ======================================================================================
        /*
        void GridUsl_RowDataBound(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow && GridUsl.RowsInViewState.Count > 0)
            {
                GridDataControlFieldCell cell = e.Row.Cells[0] as GridDataControlFieldCell;
                CheckBox chk = cell.FindControl("ChkID") as CheckBox;

                GridDataControlFieldCell cellInViewState = GridUsl.RowsInViewState[e.Row.RowIndex].Cells[0] as GridDataControlFieldCell;
                CheckBox chkInViewState = cellInViewState.FindControl("ChkID") as CheckBox;

                if (cell.Value == chkInViewState.ToolTip)
                {
                    chk.Checked = chkInViewState.Checked;
                }
            }
        }
        */

     
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
        <asp:HiddenField ID="parKasSum" runat="server" />
        <asp:HiddenField ID="parKasMem" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>

      
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None"
                Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 30%; height: 600px;">

                <obout:Grid ID="GridDoc" runat="server"
                    CallbackMode="true"
                    Serialize="true"
                    FolderStyle="~/Styles/Grid/style_5"
                    AutoGenerateColumns="false"
                    ShowTotalNumberOfPages="false"
                    FolderLocalization="~/Localization"
                    Language="ru"
                    PageSize="-1"
                    Width="100%"
                    AllowAddingRecords="false"
                    AutoPostBackOnSelect="true"
                    AllowRecordSelection="true"
                    AllowFiltering="false">
                   <ScrollingSettings ScrollHeight="560" />
                   <Columns>
                        <obout:Column ID="Column1" DataField="BuxKod" HeaderText="Код" Visible="false" Width="0%" />
                        <obout:Column ID="Column2" DataField="FI" HeaderText="ФАМИЛИЯ И.О. " Width="50%" />
                        <obout:Column ID="Column3" DataField="DLGNAM" HeaderText="СПЕЦ." Width="45%" />
                    </Columns>
                </obout:Grid>

            </asp:Panel>

            <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="None" Style="left: 31%; position: relative; top: -605px; width: 70%; height: 600px;">
                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td width="45%">
                            <asp:TextBox ID="FndUsl" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                Style="position: relative; font-weight: 700; font-size: small;" />
                        </td>

                        <td width="5%">
                            <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="100%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                        <td width="50%">
                            <asp:TextBox ID="TextBoxDoc"
                                Text="Услуги врачей"
                                BackColor="White"
                                Font-Names="Verdana"
                                Font-Size="14px"
                                Font-Bold="True"
                                ForeColor="#0099FF"
                                BorderStyle="None"
                                Style="top: 2px; left: 0px; position: relative; width: 79%"
                                runat="server"></asp:TextBox>
                        </td>
                        <td width="5%">
                            <asp:Button ID="Button2" runat="server"
                                OnClick="WriteKas"
                                Width="100%" CommandName="Cancel"
                                Text="Записать" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                    </tr>
                </table>

      <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>      
                  
               <obout:Grid ID="GridUsl" runat="server"
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
	            Width="98%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
                ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="510" />
                    <Columns>
                        <obout:Column ID="Column01" DataField="DOCUSL" HeaderText="Код" ReadOnly="true" Visible="true" Width="5%" runat="server" >
				             <TemplateSettings TemplateID="TemplateWithCheckbox" />
				        </obout:Column>
                        <obout:Column ID="Column02" DataField="BuxUslDocKod" HeaderText="Код" Visible="false" Width="0%" />
                        <obout:Column ID="Column03" DataField="USLNAM" HeaderText="УСЛУГА" Width="73%" />
                        <obout:Column ID="Column04" DataField="USLFRMZEN" HeaderText="ЦЕНА" Width="7%" />
                        <obout:Column ID="Column05" DataField="FI" HeaderText="ВРАЧ" Width="15%" />
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
                 OnRowDataBound="GridUsl_RowDataBound"
      
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

    </style>

</body>




</html>

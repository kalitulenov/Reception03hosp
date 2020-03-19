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
           window.opener.HandlePopupResult("UslRef");
           self.close();
        //   window.parent.UslRef();
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          

        function filterGrid(e) {
            var fieldName;
                    alert("filterGrid=");

            if (e != 'ВСЕ') {
                fieldName = 'USLNAM';
                GridUsl.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                GridUsl.executeFilter();
            }
            else {
                GridUsl.removeFilter();
            }
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
        string BuxStx;
        string BuxGrp;

        string BuxFio = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        string whereClause = "";

        string AmbCrdIdn = "";
        string AmbCrdFio = "";

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
            AmbCrdFio = Convert.ToString(Request.QueryString["AmbCrdFio"]);
            sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //===================================================================================================
            if (!Page.IsPostBack)
            {
                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

                string[] alphabet = ";;;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();

                //      BuxKod = Convert.ToInt32(oRecord["BuxKod"]);
                //      parBuxKod.Value = Convert.ToString(oRecord["BuxKod"]);

                //      BuxFio = Convert.ToString(oRecord["FI"]);
                //=====================================================================================
                //     TextBoxDoc.Text = BuxFio.PadLeft(10);
                whereClause = "";
                BuxGrp = "";
                //       BoxStx.SelectedValue = "00001";
                getPrcNum();
                //      BuxStx = "00000";
                PopulateGridUsl();
                Sapka.Text = AmbCrdFio;
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridUsl()
        {
            if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") BuxStx = "00000";
            else BuxStx = BoxStx.SelectedValue;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprUslAmbIdn", con);
            cmd = new SqlCommand("HspSprUslAmbIdn", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
            cmd.Parameters.Add("@BUXSTX", SqlDbType.VarChar).Value = BuxStx;
            cmd.Parameters.Add("@BUXGRP", SqlDbType.VarChar).Value = BuxGrp;
            cmd.Parameters.Add("@BUXCND", SqlDbType.VarChar).Value = whereClause;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprUslAmbIdn");

            if (ds.Tables[0].Rows.Count > 0)
            {
                TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFLGT"]);
            }

                GridUsl.DataSource = ds;
                GridUsl.DataBind();

            con.Close();
        }

        // ============================ чтение таблицы а оп ==============================================
        // ======================================================================================
        void WriteKas(object sender, EventArgs e)
        {
            string selectedOrderIds = "";
            int BuxLgt;

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
                if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") BuxStx = "00000";
                else BuxStx = BoxStx.SelectedValue;

                if (TxtLgt.Text == null | TxtLgt.Text == "") BuxLgt = 0;
                else BuxLgt = Convert.ToInt32(TxtLgt.Text);

                //------------       чтение уровней дерево
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("HspAmbUslStxAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
                cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = BuxStx;
                cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = BuxLgt;
                cmd.Parameters.Add("@USLKODLST", SqlDbType.VarChar).Value = selectedOrderIds;
                // создание команды
                cmd.ExecuteNonQuery();
                con.Close();


                ExecOnLoad("ExitFun();");
                // ------------------------------------------------------------------------------заполняем второй уровень
                //        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);  

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
                whereClause += "SPRUSL.USLNAM LIKE '%" + FndUsl.Text.Replace("'", "''") + "%'";
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
                BuxGrp = "";
                PopulateGridUsl();
            }
        }


        // ======================================================================================
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

        //------------------------------------------------------------------------
        protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            whereClause = "";
            BuxGrp = "";
            PopulateGridUsl();
            BuxStx = BoxStx.SelectedValue;
        }


        //------------------------------------------------------------------------
        protected void BoxGrp_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            whereClause = "";
            BuxGrp = BoxGrp.SelectedValue;
            PopulateGridUsl();
            //      BuxStx = BoxStx.SelectedValue;
        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getPrcNum()
        {
            string SqlPrc;
            string KodPrc;

            //   SqlPrc = "SELECT CntKod,CntPrc,CntNam FROM SprCnt WHERE CntLvl=0 And CntFrm=" + BuxFrm + " AND PATINDEX('%платно%',CntNam) > 0 ORDER BY CntKod";
            SqlPrc = "SELECT (SELECT TOP (1) CntKod FROM SprCnt WHERE CntLvl=0 AND CntKey=LEFT(AMBCRD.GrfStx, 5)) AS KODSTX," +
                            "(SELECT TOP (1) CntPrc FROM SprCnt WHERE CntLvl=0 AND CntKey=LEFT(AMBCRD.GrfStx, 5)) AS KODPRC " +
                     "FROM AMBCRD WHERE GrfIdn="+AmbCrdIdn;

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(SqlPrc, con);
            // указать тип команды
            // cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //cmd.Parameters.Add("@CRPKOD", SqlDbType.VarChar).Value = CrpKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "SprPrc");

            con.Close();

            BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KODSTX"]);
            KodPrc = Convert.ToString(ds.Tables[0].Rows[0]["KODPRC"]);

            if (KodPrc != "") 
               sdsGrp.SelectCommand = "SELECT SprStrUsl002.StrUslKey,SprStrUsl002.StrUslNam " +
                                      "FROM SprUsl INNER JOIN SprBuxUsl ON SprUsl.UslKod=SprBuxUsl.BuxUslPrcKod " +
                                                  "INNER JOIN AMBCRD ON SprBuxUsl.BuxUslDocKod=AMBCRD.GrfKod " +
                                                  "INNER JOIN SprStrUsl002 ON SprUsl.UslKey002=SprStrUsl002.StrUslKey " +
                                      "WHERE SprUsl.UslPrc=" + KodPrc + " AND SprBuxUsl.BuxUslPrc=" + KodPrc + " AND AMBCRD.GrfIdn=" + AmbCrdIdn  +
                                      " GROUP BY SprStrUsl002.StrUslKey,SprStrUsl002.StrUslNam";

            BoxGrp.Items.Add(new Obout.ComboBox.ComboBoxItem("Все группы", "0"));

        }

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
        <asp:HiddenField ID="parStxKod" runat="server" />
        <asp:HiddenField ID="parPrcKod" runat="server" />
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
                Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 520px;">

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td width="25%">
                            <asp:TextBox ID="FndUsl" Width="60%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                Style="position: relative; font-weight: 700; font-size: small;" />
                            <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="30%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                        
                        <td width="30%"> 
                               <obout:ComboBox runat="server" ID="BoxGrp" Width="90%" Height="150"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="BoxGrp_OnSelectedIndexChanged"
                                FolderStyle="/Styles/Combobox/Plain"
                                DataSourceID="sdsGrp" DataTextField="StrUslNam" DataValueField="StrUslKey">
                            </obout:ComboBox>

                        </td>

                        <td width="25%"> 
                               <asp:Label ID="Label4" Text="Страх:" runat="server" BorderStyle="None" Width="30%" Font-Bold="true"  Font-Size="Medium"/>
                               <obout:ComboBox runat="server" ID="BoxStx" Width="60%" Height="150"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"
                                FolderStyle="/Styles/Combobox/Plain"
                                DataSourceID="sdsStx" DataTextField="StxNam" DataValueField="StxKod">
                            </obout:ComboBox>

                        </td>
                        
                        <td width="15%"> 
                               <asp:Label ID="Label1" Text="Льгота:" runat="server" BorderStyle="None" Width="50%" Font-Bold="true"  Font-Size="Medium"/>
                               <asp:TextBox ID="TxtLgt" Width="30%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                Style="position: relative; font-weight: 700; font-size: small;" />
                        </td>
                        
                        <td width="10%">
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
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
                ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="410" />
                    <Columns>
                        <obout:Column ID="Column01" DataField="USLKOD" HeaderText="+" ReadOnly="true" Visible="true" Width="5%" runat="server" >
				             <TemplateSettings TemplateID="TemplateWithCheckbox" />
				        </obout:Column>
                        <obout:Column ID="Column03" DataField="USLNAM" HeaderText="УСЛУГА" Width="82%" />
                        <obout:Column ID="Column04" DataField="USLFRMZEN" HeaderText="ЦЕНА" Width="10%" Align="right" />
                        <obout:Column ID="Column05" DataField="" HeaderText="" Width="3%" />
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

     <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSelNew" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

     <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            
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

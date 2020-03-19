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

        window.onload = function () {
            alert('HidKodDoc10=' + GridUsl.PageSelectedRecords.length);
            for (var j = 0; j < GridUsl.PageSelectedRecords.length; j++) {
              
                      selectedId = GridUsl.PageSelectedRecords[j].USLDOC;
                      alert('selectedId=' + selectedId);
                  }
            }

        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
        function ExitFun() {
       //     var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
        //                        alert("GrfFio=" + GrfFio); 
       //     localStorage.setItem("KasSumMem", KasSumMem); //setter
      //     window.opener.HandlePopupResult("UslRef");
           self.close();
        //   window.parent.UslRef();
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          

        function filterGrid(e) {
            var fieldName;
              //      alert("filterGrid=");

            if (e != 'ВСЕ') {
                fieldName = 'USLNAM';
                GridUsl.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                GridUsl.executeFilter();
            }
            else {
                GridUsl.removeFilter();
            }
        }

        function MrtLstButton_Click() {


            var GrfIin = document.getElementById("parKltIin").value;
            var GrfFrm = document.getElementById("parBuxFrm").value;
            var GrfDat = document.getElementById("parTekDat").value;

     //       alert("TekDocIdn = " + GrfIin + " & TekDocFrm=" + GrfFrm + " & TekDocBeg=" + GrfDat);

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspRefMrtLstIin&TekDocIdn=" + GrfIin + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfDat,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspRefMrtLstIin&TekDocIdn=" + GrfIin + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfDat,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

    </script>

</head>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int BuxUsl = 0;
        int BuxFlg;
        int BuxTyp;
        string BuxSid;
        string BuxFrm;
        string BuxKod = "";
        string BuxSbl;
        string BuxFio;

        string KltFio = "";
        string TekDat = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        string whereClause = "";

        string KltIin = "";
        string AmbCrdFio = "";

        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {

            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];

            KltIin = Convert.ToString(Request.QueryString["AmbCrdIIN"]);
            KltFio = Convert.ToString(Request.QueryString["KltFio"]);
            TekDat = Convert.ToString(Request.QueryString["TekDat"]);
            parKltIin.Value =  KltIin;
            parTekDat.Value =  TekDat;
            parBuxFrm.Value =  BuxFrm;


            // =====================================================================================
            sdsSbl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsSbl.SelectCommand = "SELECT * FROM SPRREF WHERE SPRREFFRM=" + BuxFrm + " ORDER BY SPRREFNAM";

            //===================================================================================================
            if (!Page.IsPostBack)
            {
                //    Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

                //=====================================================================================
                whereClause = "";
                BoxSbl.SelectedValue = "1";
                // getPrcNum();
                //      BuxSbl = "00000";
                PopulateGridUsl();
                Sapka.Text = KltFio;
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridUsl()
        {
            if (BoxSbl.SelectedValue == null | BoxSbl.SelectedValue == "") BuxSbl = "0";
            else BuxSbl = BoxSbl.SelectedValue;

            if (KltIin.Substring(6, 1) == "3" || KltIin.Substring(6, 1) == "5") TxtPol.Text = "Мужской";
            else TxtPol.Text = "Женский";
          //  TxtPol.Text = KltIin.Substring(6, 3);

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprSblIin", con);
            cmd = new SqlCommand("HspSprSblIin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@REFKOD", SqlDbType.Int, 4).Value = BuxSbl;
            cmd.Parameters.Add("@REFIIN", SqlDbType.VarChar).Value = parKltIin.Value;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprSblIin");

            if (ds.Tables[0].Rows.Count > 0)
            {
                //   TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFLGT"]);

                GridUsl.DataSource = ds;
                GridUsl.DataBind();
            }

            con.Close();

          //2  <input id="GridUsl_ob_GridUslBodyContainer_ctl02_1_ctl00_1_ChkID_1" type="checkbox" name="GridUsl$ob_GridUslBodyContainer$ctl03$ctl02$ctl00$ChkID">
          //5  <input id="GridUsl_ob_GridUslBodyContainer_ctl02_4_ctl00_4_ChkID_4" type="checkbox" name="GridUsl$ob_GridUslBodyContainer$ctl06$ctl02$ctl00$ChkID">
          //   <input id="GridUsl_ob_GridUslBodyContainer_ctl02_' + IndFix + '_ctl00_' + IndFix + '_ChkID_' + IndFix + '" type="checkbox" name="GridUsl$ob_GridUslBodyContainer$ctl06$ctl02$ctl00$ChkID">

          //  document.getElementById('MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = '<div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl09" class="ob_gCc2">
                                  //<input type="checkbox" onclick="updateSent01(this.checked,' + IndChk + ');">                            
                                  //</div><div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11" class="ob_gCd">False</div>';
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

        //        if (chk.Checked == true)
        //        {
                    if (!string.IsNullOrEmpty(selectedOrderIds))
                        selectedOrderIds += "&";

                    selectedOrderIds += chk.ToolTip;
        //        }
            }

            if (!string.IsNullOrEmpty(selectedOrderIds))
            {
                //   FndUsl.Text = selectedOrderIds;
                //   if (BoxSbl.SelectedValue == null | BoxSbl.SelectedValue == "") BuxSbl = "0";
                //   else BuxSbl = BoxSbl.SelectedValue;

                if (TxtLgt.Text == null | TxtLgt.Text == "") BuxLgt = 0;
                else BuxLgt = Convert.ToInt32(TxtLgt.Text);
                //=====================================================================================
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprSblIinWrt", con);
                cmd = new SqlCommand("HspSprSblIinWrt", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // создать коллекцию параметров
                cmd.Parameters.Add("@GRFFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@GRFIIN", SqlDbType.VarChar).Value = parKltIin.Value;
                cmd.Parameters.Add("@GRFSBL", SqlDbType.VarChar).Value = BoxSbl.SelectedValue;
                
                cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = BuxLgt;
                cmd.Parameters.Add("@USLKODLST", SqlDbType.VarChar).Value = selectedOrderIds;

                cmd.ExecuteNonQuery();
                con.Close();

             //   ExecOnLoad("ExitFun();");
                // ------------------------------------------------------------------------------заполняем второй уровень
                //        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);  

                // ------------------------------------------------------------------------------заполняем второй уровень
                //        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);  
            }


        }

        // ==================================== поиск клиента по фильтрам  ============================================
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
        protected void BoxSbl_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            whereClause = "";
            //     BuxGrp = "";
            BuxSbl = BoxSbl.SelectedValue;
            PopulateGridUsl();
        }
        // ============================ чтение заголовка таблицы а оп ==============================================

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
     
<body>
    <form id="form1" runat="server">

        <!--  конец -----------------------------------------------  -->
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parTekDat" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parKltIin" runat="server" />
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
                        <td width="15%">
                            <asp:Label ID="Label2" Text="Пол:" runat="server" BorderStyle="None" Width="25%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="TxtPol" Width="70%" Height="20" runat="server" ForeColor="Blue" Style="position: relative; font-weight: 700; border-style:none; font-size: small;" />
                        </td>
                        <td width="40%">
                            <asp:Label ID="Label4" Text="Шаблон:" runat="server" BorderStyle="None" Width="20%" Font-Bold="true" Font-Size="Medium" />
                            <obout:ComboBox runat="server" ID="BoxSbl" Width="70%" Height="150"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="BoxSbl_OnSelectedIndexChanged"
                                FolderStyle="/Styles/Combobox/Plain"
                                DataSourceID="sdsSbl" DataTextField="SPRREFNAM" DataValueField="SPRREFKOD">
                            </obout:ComboBox>
                        </td>

                        <td width="25%">
                            <asp:Label ID="Label1" Text="Льгота:" runat="server" BorderStyle="None" Width="30%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="TxtLgt" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: small;" />
                        </td>

                        <td width="25%">
                            <asp:Button ID="Button2" runat="server"
                                OnClick="WriteKas"
                                Width="50%" CommandName="Cancel"
                                Text="Записать" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />

                               <input type="button" name="ButpPrt002" value="Печать" onclick="MrtLstButton_Click();" id="ButPrt002" />              

                        </td>
                    </tr>
                </table>

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
                        <obout:Column ID="Column01" DataField="USLDOC" HeaderText="+" ReadOnly="true" Visible="true" Width="5%" runat="server" >
				             <TemplateSettings TemplateID="TemplateWithCheckbox" />
				        </obout:Column>
                        <obout:Column ID="Column02" DataField="SprRefUslNnn" HeaderText="№" Width="5%" />
                        <obout:Column ID="Column03" DataField="UslNam" HeaderText="УСЛУГА" Width="40%" />
                        <obout:Column ID="Column04" DataField="FI" HeaderText="ВРАЧ" Width="20%" />
                        <obout:Column ID="Column05" DataField="DLGNAM" HeaderText="СПЕЦ" Width="17%" />
                        <obout:Column ID="Column06" DataField="SprRefUslMin" HeaderText="ДЛИТ." Width="5%" />
                        <obout:Column ID="Column07" DataField="CABNAM" HeaderText="ГДЕ" Width="5%" />
                        <obout:Column ID="Column08" DataField="" HeaderText="" Width="3%" />
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

            <asp:SqlDataSource runat="server" ID="sdsSbl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


          
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

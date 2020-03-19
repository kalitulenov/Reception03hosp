<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
 
    
<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;

         // =============================== опрос до удаления клиента  ============================================
         function OnBeforeDelete(sender, record) {

             //                    alert("myconfirm=" + myconfirm);  
             if (myconfirm == 1) {
                 return true;
             }
             else {
                 document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                 document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                 myConfirmBeforeDelete.Open();
                 return false;
             }
         }

         function findIndex(record) {
             var index = -1;
 //            alert('1 index: ' + index);
             for (var i = 0; i < GridStt.Rows.length; i++) {
                 if (GridStt.Rows[i].Cells[0].Value == record.SttRspIdn) {
//                     alert(record.STTRSPIDN);
                     index = i;
                     break;
                 }
             }
             return index;
         }

         // =============================== удаления клиента после опроса  ============================================
         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridStt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

         // ==================================== чистка поле поиска  ============================================
         // ==================================== при выборе клиента показывает его программу  ============================================
         // ==================================== при выборе клиента показывает его программу  ============================================

 </script>
</head>
    
    
  <script runat="server">

        string BuxSid;
        string BuxFrm;
        string Html;
        
        int SttRspIdn;
        int BuxKod;
        int SttRspFin;
        int SttRspKod;
        int SttRspDlg;
        decimal SttRspStf;
        int SttRspKol;
        string SttRspMem;
        
        string ComKltIdn = "";
        string ComParKey = "";
        string ComParTxt = "";
        string whereClause = "";

        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //============= локолизация для календаря  ===========================================================================================
            //=====================================================================================


            sdsDlg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDlg.SelectCommand = "SELECT DLGKOD,DLGNAM FROM SPRDLG ORDER BY DLGNAM";

            sdsFin.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsFin.SelectCommand = "SELECT FINKOD,FINNAM FROM SPRFIN";

            //           GridStt.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            GridStt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridStt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridStt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            //=====================================================================================
            if (!Page.IsPostBack)
            {
                Session.Add("STTRSPIDN", (string)"");
                Session.Add("WHERE", (string)"");
            }
            
            ComParKey = (string)Request.QueryString["NodKey"];
            ComParKeyHid.Value = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            
            LoadGridNode();

   //         SttRspIdn = Convert.ToInt32(Session["STTRSPIDN"]);
  //          if (ComKltIdn != "")   LoadGridPrg();                
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        // ======================================================================================
        //------------------------------------------------------------------------
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            SttRspIdn = Convert.ToInt32(e.Record["SttRspIdn"]);
            
            if (Convert.ToString(e.Record["SttRspFin"]) == null || Convert.ToString(e.Record["SttRspFin"]) == "") SttRspFin = 0;
            else SttRspFin = Convert.ToInt32(e.Record["SttRspFin"]);
            if (Convert.ToString(e.Record["SttRspStf"]) == null || Convert.ToString(e.Record["SttRspStf"]) == "") SttRspStf = 1;
            else SttRspStf = Convert.ToDecimal(e.Record["SttRspStf"]);
            if (Convert.ToString(e.Record["SttRspKol"]) == null || Convert.ToString(e.Record["SttRspKol"]) == "") SttRspKol = 1;
            else SttRspKol = Convert.ToInt32(e.Record["SttRspKol"]);

            SttRspDlg = Convert.ToInt32(e.Record["SttRspDlg"]);
            
            SttRspMem = Convert.ToString(e.Record["SttRspMem"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttRspRep", con);
            cmd = new SqlCommand("HspSprSttRspRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@RSPIDN", SqlDbType.Int, 4).Value = SttRspIdn;
            cmd.Parameters.Add("@RSPDLG", SqlDbType.Int, 4).Value = SttRspDlg;
            cmd.Parameters.Add("@RSPSTF", SqlDbType.Decimal).Value = SttRspStf;
            cmd.Parameters.Add("@RSPKOL", SqlDbType.Int, 4).Value = SttRspKol;
            cmd.Parameters.Add("@RSPMEM", SqlDbType.VarChar).Value = SttRspMem;
            cmd.Parameters.Add("@RSPFIN", SqlDbType.Int, 4).Value = SttRspFin;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            LoadGridNode();
        }
        //------------------------------------------------------------------------
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            if (Convert.ToString(e.Record["SttRspFin"]) == null || Convert.ToString(e.Record["SttRspFin"]) == "") SttRspFin = 0;
            else SttRspFin = Convert.ToInt32(e.Record["SttRspFin"]);
            if (Convert.ToString(e.Record["SttRspStf"]) == null || Convert.ToString(e.Record["SttRspStf"]) == "") SttRspStf = 1;
            else SttRspStf = Convert.ToDecimal(e.Record["SttRspStf"]);
            if (Convert.ToString(e.Record["SttRspKol"]) == null || Convert.ToString(e.Record["SttRspKol"]) == "") SttRspKol = 1;
            else SttRspKol = Convert.ToInt32(e.Record["SttRspKol"]);

            SttRspDlg = Convert.ToInt32(e.Record["SttRspDlg"]);
            SttRspMem = Convert.ToString(e.Record["SttRspMem"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttRspAdd", con);
            cmd = new SqlCommand("HspSprSttRspAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@RSPDLG", SqlDbType.Int, 4).Value = SttRspDlg;
            cmd.Parameters.Add("@RSPSTF", SqlDbType.Decimal).Value = SttRspStf;
            cmd.Parameters.Add("@RSPKOL", SqlDbType.Int, 4).Value = SttRspKol;
            cmd.Parameters.Add("@RSPMEM", SqlDbType.VarChar).Value = SttRspMem;
            cmd.Parameters.Add("@RSPFIN", SqlDbType.Int, 4).Value = SttRspFin;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            
            LoadGridNode();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            SttRspIdn = Convert.ToInt32(e.Record["SttRspIdn"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttRspDel", con);
            cmd = new SqlCommand("HspSprSttRspDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@RSPIDN", SqlDbType.Int, 4).Value = SttRspIdn;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            LoadGridNode();

        }
        //=============При выборе узла дерево===========================================================================================


        protected void LoadGridNode()
        {
            int LenKey = ComParKey.Length;
            
            if (LenKey > 0) 
                {

                    // создание DataSet.
                    DataSet ds = new DataSet();

                    // строка соединение
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    con.Open();

                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspSprSttRsp", con);
                    cmd = new SqlCommand("HspSprSttRsp", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // создать коллекцию параметров
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
                    cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
                    // ------------------------------------------------------------------------------заполняем первый уровень
                    // создание DataAdapter
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    // заполняем DataSet из хран.процедуры.
                    da.Fill(ds, "HspSprSttRsp");
                    // ------------------------------------------------------------------------------заполняем второй уровень
            //        ds.Merge(InsSprSttRspSel(MdbNam, BuxFrm, LenKey, ComParKey));
                    GridStt.DataSource = ds;
                    GridStt.DataBind();
                }
        }

        //------------------------------------------------------------------------
        // ==================================== поиск клиента по фильтрам  ============================================
  </script>   
    
    
<body>
    <form id="form1" runat="server">
    <div>
<%-- ============================  для передач значении  ============================================ --%>
  <asp:HiddenField ID="ComParKeyHid" runat="server" />

   <span id="WindowPositionHelper"></span>
   
 <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="CUSTOM" Left="400" Top="200" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
       
<!--  конец -----------------------------------------------  -->  
<%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
<!--  источники -----------------------------------------------------------  -->    
	    <asp:SqlDataSource runat="server" ID="sdsDlg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsFin" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
<!--  источники -----------------------------------------------------------  -->    

    <div>
    <div style="position:relative; left:0px; top:0px; font-family:Verdana; font-size:10pt; 
         border-style:groove; border-width:1px; border-color: Black; padding:1px">
         
    </div>          
                        <obout:Grid id="GridStt" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="false" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               AllowRecordSelection="true"
	                               KeepSelectedRecords="true" 
	                               AllowMultiRecordSelection="true"
	                               Language = "ru"
	                		       PageSize = "20"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                             EnableTypeValidation="false"
                                   AllowPaging="true"
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                   <ScrollingSettings ScrollHeight="500" />
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true" />
          		           		<Columns>
	                    			<obout:Column ID="Column0" DataField="SttRspIdn" HeaderText="Идн" Visible="false" Width="0%" />
                                    <obout:Column ID="Column1" DataField="STT000" HeaderText="ГРУППА"  Width="10%" ReadOnly="true" />
                                    <obout:Column ID="Column2" DataField="STT001" HeaderText="ОТДЕЛ"  Width="10%" ReadOnly="true" />
                                    <obout:Column ID="Column3" DataField="SttRspKod" HeaderText="КОД"  Width="5%" ReadOnly="true" />
                    				<obout:Column ID="Column4" DataField="SttRspDlg" HeaderText="ДОЛЖНОСТЬ"  Width="25%" >
	            			              <TemplateSettings TemplateId="TemplateDlgNam" EditTemplateId="TemplateEditDlgNam" />
	            			        </obout:Column>    	                    	   
                    				<obout:Column ID="Column5" DataField="SttRspStf" HeaderText="СТАВКА"  Width="5%" DataFormatString="{0:F2}" Align="right" />
                    				<obout:Column ID="Column6" DataField="SttRspKol" HeaderText="КОЛ-ВО"  Width="5%" DataFormatString="{0:F2}" Align="right" />
                                    <obout:Column ID="Column7" DataField="SttRspMem" HeaderText="ПРИМЕЧАНИЕ" Width="15%" />											
                  				    <obout:Column ID="Column8" DataField="SttRspFin" HeaderText="ФИНАНС"  Width="15%" >
	            			              <TemplateSettings TemplateId="TemplateFin" EditTemplateId="TemplateEditFin" />
	            			        </obout:Column>

		                    		<obout:Column ID="Column9" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateFin" >
				                    <Template>
				                            <%# Container.DataItem["FINNAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditFin" ControlID="ddlFinNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlFinNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsFin" CssClass="ob_gEC" DataTextField="FinNam" DataValueField="FinKod">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>

	                    		<obout:GridTemplate runat="server" ID="TemplateDlgNam" >
				                    <Template>
				                            <%# Container.DataItem["DLGNAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditDlgNam" ControlID="ddlDlgNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlDlgNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsDlg" CssClass="ob_gEC" DataTextField="DLGNAM" DataValueField="DLGKOD">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>	

	                    		<obout:GridTemplate runat="server" ID="TemplateKol" >
				                    <Template>
				                            <%# Container.DataItem["KOLSTF"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditKol" ControlID="ddlKolNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlKolNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKol" CssClass="ob_gEC" DataTextField="KOLSTF" DataValueField="KOLSTF">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>	
				                   
	                    		</Templates>
	                    	</obout:Grid>	
       
                </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
	        </div>
	        
	         <%-- =================  окно для корректировки одной записи из GRIDa  
                                                          OnClientSelect="OnClientSelect" 

                 ============================================ --%>
    

    </form>

     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
            /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
              /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
    </style>
    
    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
        }
    </style>

</body>
</html>



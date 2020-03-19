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
 
    

     <script type="text/javascript">

         var myconfirm = 0;

         function OnBeforeDelete(sender, record) {

             //              alert("myconfirm=" + myconfirm);  
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
             for (var i = 0; i < GridBux.Rows.length; i++) {
                 if (GridBux.Rows[i].Cells[0].Value == record.BuxIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridBux.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }
      
       /* --------------------------------------------------------------------------------------------------------*/
 
         /* --------------------------------------------------------------------------------------------------------*/
         function OnBeforeInsertWrt(record) {
             SetWrtID();
             return true;
         }
         /* --------------------------------------------------------------------------------------------------------*/
         /*
                 function OnEditWrt(record) {
                     var WrtID = grid2.Rows[grid2.RecordInEditMode].Cells["Prm"].Value;
                     if (WrtID == "0") {
                         document.getElementById("rFemale").checked = true;
                     }
                     else {
                         document.getElementById("rMale").checked = true;
                     }
                     return true;
                 }
         */        
         /* --------------------------------------------------------------------------------------------------------*/

         function OnBeforeUpdateWrt(record) {
             SetWrtID();
             return true;
         }
         /* --------------------------------------------------------------------------------------------------------*/

         function SetWrtID() {
             if (document.getElementById("rFemale").checked) {
                 document.getElementById("hidWrt").value = "0";
             }
             else if (document.getElementById("rMale").checked) {
                 document.getElementById("hidWrt").value = "1";
             }
         }
         /* ---------------------------скрыть кнопки первый и последний----------------------------------------*/
        
         window.onload = function() {
             window.setTimeout(hidePagingButtons, 250);
         }

         function hidePagingButtons() {
             var pagingContainer = GridBux.getPagingButtonsContainer('');

             var elements = pagingContainer.getElementsByTagName('DIV');
             var pagingButtons = new Array();

             for (var i = 0; i < elements.length; i++) {
                 if (elements[i].className.indexOf('ob_gPBC') != -1) {
                     pagingButtons.push(elements[i]);
                 }
             }

             pagingButtons[0].style.display = 'none';
             pagingButtons[3].style.display = 'none';

         }    
         
 </script>
</head>
    
    
  <script runat="server">

  //       int ComBuxKod = 0;
        string ComPriOpr = "";
        int BuxIdn;
        int BuxKod;
        int BuxTab;
        int BuxDlg;
        decimal BuxStf;
        bool BuxStz;
        bool BuxUbl;
        string BuxLog;
        string BuxPsw;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";

        string ComKltIdn = "";
        string ComParKey = "";
        string ComParTxt = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            ComParKey = (string)Request.QueryString["NodKey"];
 //           ComParKeyHid.Value = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];


            sds1.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sds1.SelectCommand = "SELECT KOD AS BUXTAB,FIO FROM SprKdr WHERE KDRFRM='" + BuxFrm + "' ORDER BY FIO";

            sdsDlg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
         //   sdsDlg.SelectCommand = "SELECT DLGKOD AS BUXDLG,DLGNAM AS NAM FROM SPRDLG ORDER BY DLGNAM";
            sdsDlg.SelectCommand = "SELECT SprDlg.DLGKOD AS BUXDLG,SprDlg.DLGNAM AS NAM " +
                                 "FROM SprDlg INNER JOIN SprSttRsp ON SprDlg.DLGKOD=SprSttRsp.SttRspDlg " +
                                 "WHERE SprSttRsp.SttRspFrm='" + BuxFrm + "' AND SprSttRsp.SttRspKey='" + ComParKey +
                                 "' ORDER BY SprDlg.DLGNAM";

            sdsStf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsStf.SelectCommand = "SELECT STTRSPKOLSTF AS KOLSTF FROM SPRSTTRSPKOL";

            GridBux.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridBux.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridBux.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
                ParRadUbl.Value = "0";
                getGrid();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComPriOpr", "");
            }
            else
            {
                ComPriOpr = (string)Session["ComPriOpr"];
                if (ComPriOpr == "add") getGrid();

            }

        }

        //===========================================================================================================
        // Create the methods that will load the data into the templates

        //------------------------------------------------------------------------

        // ============================ первая таблица ==============================================
        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            BuxTab = Convert.ToInt32(e.Record["BuxTab"]);
            BuxDlg = Convert.ToInt32(e.Record["BuxDlg"]);
            if (Convert.ToString(e.Record["BuxStf"]) == null || Convert.ToString(e.Record["BuxStf"]) == "") BuxStf = 1;
            else BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);
            BuxLog = Convert.ToString(e.Record["BuxLog"]);
            BuxPsw = Convert.ToString(e.Record["BuxPsw"]);

             // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttRspFioAdd", con);
            cmd = new SqlCommand("HspSprSttRspFioAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKEY", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@BUXTAB", SqlDbType.Int, 4).Value = BuxTab;
            cmd.Parameters.Add("@BUXDLG", SqlDbType.Int, 4).Value = BuxDlg;
            cmd.Parameters.Add("@BUXSTF", SqlDbType.Decimal).Value = BuxStf;
            cmd.Parameters.Add("@BUXLOG", SqlDbType.VarChar).Value = BuxLog;
            cmd.Parameters.Add("@BUXPSW", SqlDbType.VarChar).Value = BuxPsw;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
      //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
      //      ws.ComSprBuxAdd(MdbNam, BuxSid, BuxFrm, BuxTab, BuxDlg, BuxLog, BuxPsw);
            getGrid();

        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);
            BuxTab = Convert.ToInt32(e.Record["BuxTab"]);
            BuxDlg = Convert.ToInt32(e.Record["BuxDlg"]);
            if (Convert.ToString(e.Record["BuxStf"]) == null || Convert.ToString(e.Record["BuxStf"]) == "") BuxStf = 1;
            else BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);
            BuxUbl = Convert.ToBoolean(e.Record["BuxUbl"]);
            BuxLog = Convert.ToString(e.Record["BuxLog"]);
            BuxPsw = Convert.ToString(e.Record["BuxPsw"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttRspFioRep", con);
            cmd = new SqlCommand("HspSprSttRspFioRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = BuxIdn;
            cmd.Parameters.Add("@BUXTAB", SqlDbType.Int, 4).Value = BuxTab;
            cmd.Parameters.Add("@BUXDLG", SqlDbType.Int, 4).Value = BuxDlg;
            cmd.Parameters.Add("@BUXSTF", SqlDbType.Decimal).Value = BuxStf;
            cmd.Parameters.Add("@BUXUBL", SqlDbType.Bit, 1).Value = BuxUbl;
            cmd.Parameters.Add("@BUXLOG", SqlDbType.VarChar).Value = BuxLog;
            cmd.Parameters.Add("@BUXPSW", SqlDbType.VarChar).Value = BuxPsw;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
    //        localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //        ws.ComSprBuxRep(MdbNam, BuxSid, BuxIdn, BuxTab, BuxDlg, BuxUbl, BuxLog, BuxPsw);
      
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBuxDel", con);
            cmd = new SqlCommand("ComSprBuxDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = BuxIdn;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            int LenKey = ComParKey.Length;

  //          if (LenKey > 0)
 //           {

                // создание DataSet.
                DataSet ds = new DataSet();

                // строка соединение
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprSttRspFio", con);
                cmd = new SqlCommand("HspSprSttRspFio", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // создать коллекцию параметров
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
                cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
                cmd.Parameters.Add("@BUXUBL", SqlDbType.VarChar).Value = ParRadUbl.Value;
                // ------------------------------------------------------------------------------заполняем первый уровень
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "HspSprSttRspFio");
                // ------------------------------------------------------------------------------заполняем второй уровень
                //        ds.Merge(InsSprSttRspSel(MdbNam, BuxFrm, LenKey, ComParKey));
                GridBux.DataSource = ds;
                GridBux.DataBind();
    //        }

        }



        // ====================================после удаления ============================================
        private string getPostBackControlName()
        {
            string PostBackerID = Request.Form.Get(Page.postEventSourceID);
            string PostBackerArg = Request.Form.Get(Page.postEventArgumentID);

            getGrid();


            return "";
        }

        protected void OboutRadioButton_CheckedChanged001(object sender, EventArgs e)
        {
   //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadUbl.Value = "0";
            getGrid();
        }
        protected void OboutRadioButton_CheckedChanged002(object sender, EventArgs e)
        {
            //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadUbl.Value = "1";
            getGrid();
        }

          </script>   
    
    
<body>
    <form id="form1" runat="server"> 
     <span id="WindowPositionHelper"></span>
  
   
       

     
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sds1" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    	    <asp:SqlDataSource runat="server" ID="sdsDlg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsStf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
<!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
 
    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                                                Справочник врачей" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 60%"
             runat="server"></asp:TextBox>

 		<obout:OboutRadioButton runat="server" ID="RadBut001" Width="10%" OnCheckedChanged="OboutRadioButton_CheckedChanged001"
		    FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Работающие" AutoPostBack="true" GroupName="g1" />
 		<obout:OboutRadioButton runat="server" ID="RadBut002" Width="10%" OnCheckedChanged="OboutRadioButton_CheckedChanged002"
		    FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Все" AutoPostBack="true" GroupName="g1" />
       <asp:TextBox ID="TextBox2" 
             Text="                                                                " 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 10%"
             runat="server"></asp:TextBox>

             <div id="div_cnt" style="position:relative;left:0%; width:100%; " >
     		           <obout:Grid id="GridBux" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="100%"
                                   AllowSorting="true"
                                   AllowPageSizeSelection="false"
	         		               AllowAddingRecords = "true"
                                   AllowRecordSelection = "true"
                                   KeepSelectedRecords = "true">
                                   <ScrollingSettings ScrollHeight="550" />
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
           		           		<Columns>
	                    			<obout:Column ID="Column01" DataField="BuxIdn" HeaderText="Идн" Visible="false" Width="0%" />
                                    <obout:Column ID="Column02" DataField="STT000" HeaderText="ГРУППА"  Width="11%" ReadOnly="true" />
                                    <obout:Column ID="Column03" DataField="STT001" HeaderText="ОТДЕЛ"  Width="11%" ReadOnly="true" />
	                    			<obout:Column ID="Column04" DataField="BuxKod" HeaderText="КОД" ReadOnly ="true" Width="5%" Align="right" />
    	                    	    <obout:Column ID="Column05" DataField="BuxLog" HeaderText="ЛОГИН" Width="8%" />											
                    				<obout:Column ID="Column06" DataField="BuxPsw" HeaderText="ПАРОЛЬ"  Width="8%" />
                				    <obout:Column ID="Column07" DataField="BuxTab" HeaderText="ФАМИЛИЯ И.О."  Width="20%" >
	            			              <TemplateSettings TemplateId="TemplateBuxNam" EditTemplateId="TemplateEditBuxNam" />
	            			        </obout:Column>
                    				<obout:Column ID="Column08" DataField="BuxDlg" HeaderText="СПЕЦИАЛИСТ"  Width="20%" >
	            			              <TemplateSettings TemplateId="TemplateDlgNam" EditTemplateId="TemplateEditDlgNam" />
	            			        </obout:Column>
                   				    <obout:Column ID="Column09" DataField="BuxStf" HeaderText="СТАВКА"  Width="5%" Align="right" >
	            			              <TemplateSettings EditTemplateId="TemplateEditStfNam" />
	            			        </obout:Column>
                                    <obout:Column ID="Column10" DataField="BuxUbl" HeaderText="УВОЛЕН" Align="center" Width="5%" >
	            			              <TemplateSettings TemplateId="TemplateUbl" EditTemplateId="TemplateEditUbl" />
	            			        </obout:Column>
		                    		<obout:Column ID="Column11" DataField="" HeaderText="КОРР" Width="7%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateBuxNam" >
				                    <Template>
				                            <%# Container.DataItem["FIO"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditBuxNam" ControlID="ddlBuxNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlBuxNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sds1" CssClass="ob_gEC" DataTextField="FIO" DataValueField="BUXTAB">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>

	                    		<obout:GridTemplate runat="server" ID="TemplateDlgNam" >
				                    <Template>
				                            <%# Container.DataItem["NAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditDlgNam" ControlID="ddlDlgNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlDlgNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsDlg" CssClass="ob_gEC" DataTextField="NAM" DataValueField="BUXDLG">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>	

				                   <obout:GridTemplate runat="server" ID="TemplateEditStfNam" ControlID="ddlStfNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlStfNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsStf" CssClass="ob_gEC" DataTextField="KOLSTF" DataValueField="KOLSTF">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>					                   

				                    <obout:GridTemplate runat="server" ID="TemplateUbl" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "У" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditUbl" ControlID="chkUbl" ControlPropertyName="checked" UseQuotes="false">
					                    <Template>
						                    <input type="checkbox" id="chkUbl"/>
					                    </Template>
				                    </obout:GridTemplate>				                   			                   
				                   
	                    		</Templates>
	                    	</obout:Grid>	
           </div>
 
       
           <div class="YesNo" title="Хотите удалить ?"  style="display: none">
                Хотите удалить запись ?
           </div>  
        
       </div>
   <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
       </form>
     
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="SCREEN_CENTER"  Top="700" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>

</body>

</html>


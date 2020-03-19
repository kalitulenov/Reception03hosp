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
             for (var i = 0; i < GridKlt.Rows.length; i++) {
                 if (GridKlt.Rows[i].Cells[0].Value == record.CNTKLTIDN) {
//                     alert(record.CNTKLTIDN);
                     index = i;
                     break;
                 }
             }
             return index;
         }

         // =============================== удаления клиента после опроса  ============================================
         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridKlt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

         
         // ==================================== при выборе клиента показывает его программу  ============================================
         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnClientDblClick(sender, iRecordIndex) {
      //       alert('onDoubleClick=' + recordIndex);
             var GlvCntIdn = GridKlt.Rows[iRecordIndex].Cells[0].Value;
             var GlvKltIdn = GridKlt.Rows[iRecordIndex].Cells[1].Value;
             var GlvCntKey = GridKlt.Rows[iRecordIndex].Cells[2].Value;
             var KltFio = GridKlt.Rows[iRecordIndex].Cells[6].Value;

             InsWindow.setTitle(KltFio);
             InsWindow.setUrl("SprCntKltGrdPrg.aspx?GlvCntIdn=" + GlvCntIdn + "&GlvCntKey=" + GlvCntKey);
             InsWindow.Open();
         }

         // ==================================== поиск клиента по фильтрам  ============================================
           // ==================================== корректировка данные клиента в отделном окне  ============================================
           function GridKlt_ClientEdit(sender, record) {
               var GlvKltIdn = record.KLTIDN;
 //              alert("GlvKltIdn=" + GlvKltIdn);

               var GlvCntIdn = record.CNTKLTIDN;
 //              alert("GlvCntIdn=" + GlvCntIdn);

//               var GlvCntKey = document.getElementById('ComParKeyHid').value;
//               InsWindow.setUrl("/Referent/RefGlv003KltOne.aspx?CntOneIdn=" + GlvCntIdn + "&CntOneKey=" + GlvCntKey);
//               InsWindow.Open();

               var ua = navigator.userAgent;
               if (ua.search(/Chrome/) > -1)
                   window.open("/Referent/RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
               else
                   window.showModalDialog("/Referent/RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
               /*
             var GlvCntIdn = record.CNTKLTIDN;
             var GlvCntKey = "";
             KltOneWindow.setTitle("Карта пациента " + GlvCntIdn);
             KltOneWindow.setUrl("/Referent/RefGlv003KltOne.aspx?CntOneIdn=" + GlvCntIdn + "&CntOneKey=" + GlvCntKey);
             KltOneWindow.Open();
*/

               return false;
           }


           function GridKlt_ClientAdd(sender, record) {

               //           alert("GridUыд_ClientEdit");
               var GlvKltIdn = 0;
               var GlvCntIdn = 0;

               var ua = navigator.userAgent;
               if (ua.search(/Chrome/) > -1)
                   window.open("/Referent/RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn, "ModalPopUp2", "width=1100,height=480,left=250,top=210,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
               else
                   window.showModalDialog("/Referent/RefGlv003KltOne.aspx?KltOneIdn=" + GlvKltIdn + "&CntOneIdn=" + GlvCntIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");

               return false;
             }

         // -------изменение как EXCEL-------------------------------------------------------------------          

           function filterGrid(e) {
               var fieldName;
               //        alert("filterGrid=");

               if (e != 'ВСЕ') {
                   fieldName = 'CNTKLTFIO';
                   GridKlt.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                   GridKlt.executeFilter();
               }
               else {
                   GridKlt.removeFilter();
               }
           }

           //    ==========================  ПЕЧАТЬ =============================================================================================
           function PrtButton_Click() {

               var GrfFrm = document.getElementById('HidBuxFrm').value;
               var GrfStx = document.getElementById('ComParKeyHid').value;

               alert("GrfFrm=" + GrfFrm);
               alert("GrfStx=" + GrfStx);

               var ua = navigator.userAgent;
               if (ua.search(/Chrome/) > -1)
                   window.open("/Report/DauaReports.aspx?ReportName=HspSttOrgRpt&TekDocIdn=0&TekDocKod=" + GrfStx + "&TekDocFrm=" + GrfFrm,
                       "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
               else
                   window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSttOrgRpt&TekDocIdn=0TekDocKod=" + GrfStx + " & TekDocFrm=" + GrfFrm,
                       "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
           }

          // ==================================== записать данные клиента с отдельного окна  ============================================

 </script>
</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string Html;
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
          HidBuxFrm.Value = BuxFrm;

          //============= локолизация для календаря  ===========================================================================================
          //=====================================================================================


          sdsReg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsReg.SelectCommand = "SELECT REGNAM AS KOD,REGNAM AS NAM FROM SPRREG ORDER BY REGNAM";

          sdsStf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsStf.SelectCommand = "SELECT STFKOD,STFNAM FROM SPRSTF";

          sdsPrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsPrt.SelectCommand = "SELECT PRTKOD,PRTNAM FROM SPRPRT";

          sdsVip.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsVip.SelectCommand = "SELECT VIPKOD,VIPNAM FROM SPRVIP";

          sdsPrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          //            sdsPrg.SelectCommand = "InsPlnFktOneKlt";

          //           GridKlt.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
          GridKlt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
          GridKlt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
          GridKlt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

          //=====================================================================================
          if (!Page.IsPostBack)
          {
              Session.Add("CNTKLTIDN", (string)"");
              Session.Add("WHERE", (string)"");
          }

          ComParKey = (string)Request.QueryString["NodKey"];
          ComParKeyHid.Value = (string)Request.QueryString["NodKey"];
          ComParTxt = (string)Request.QueryString["NodTxt"];

          LoadGridNode();

          ComKltIdn = Convert.ToString(Session["CNTKLTIDN"]);

          string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
          rptAlphabet.DataSource = alphabet;
          rptAlphabet.DataBind();

          //          if (ComKltIdn != "")   LoadGridPrg();                
      }

      //=============Заполнение массива первыми тремя уровнями===========================================================================================
      //=============При выборе узла дерево===========================================================================================
      // ====================================после удаления ============================================
      // ======================================================================================
      //------------------------------------------------------------------------
      void UpdateRecord(object sender, GridRecordEventArgs e)
      {
          LoadGridNode();
      }
      //------------------------------------------------------------------------
      void InsertRecord(object sender, GridRecordEventArgs e)
      {
          LoadGridNode();
      }

      void DeleteRecord(object sender, GridRecordEventArgs e)
      {
          int KltIdn;

          KltIdn = Convert.ToInt32(e.Record["KLTIDN"]);
          InsSprCntKltDel(MdbNam, KltIdn);
          LoadGridNode();

      }
      //=============При выборе узла дерево===========================================================================================


      protected void LoadGridNode()
      {
          int LenKey = ComParKey.Length;

          DataSet ds = new DataSet("Menu");

    //      whereClause = Convert.ToString(Session["WHERE"]);

          if (whereClause == null || whereClause == "")
          {
              if (LenKey > 0)
              {
                  Session["WHERE"] = "";
                  ds.Merge(InsSprCntKltSel(MdbNam, BuxFrm, LenKey, ComParKey));
                  GridKlt.DataSource = ds;
                  GridKlt.DataBind();
              }
          }
          else
          {
              ds.Merge(InsSprCntKltSel(MdbNam, BuxFrm, 0, whereClause));
              GridKlt.DataSource = ds;
              GridKlt.DataBind();
          }
      }

      //------------------------------------------------------------------------
      // ==================================== поиск клиента по фильтрам  ============================================
      protected void FndBtn_Click(object sender, EventArgs e)
      {
          int I = 0;

          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          whereClause = "";
          if (FndFio.Text != "")
          {
              I = I + 1;
              whereClause += "CNTKLTFIO LIKE '%" + FndFio.Text.Replace("'", "''") + "%'";
          }

          if (whereClause != "")
          {
              whereClause = whereClause.Replace("*", "%");


              if (whereClause.IndexOf("SELECT") != -1) return;
              if (whereClause.IndexOf("UPDATE") != -1) return;
              if (whereClause.IndexOf("DELETE") != -1) return;

              Session["WHERE"] = whereClause;

              LoadGridNode();

          }
      }


      // ==================================================================================================  
      public DataSet InsSprCntKltSel(string BUXMDB, string BUXFRM, int LENKEY, string TREKEY)
      {
          bool flag;

          // создание DataSet.
          DataSet ds = new DataSet();
          // строка соединение
          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspSprCntKltSel", con);
          cmd = new SqlCommand("HspSprCntKltSel", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
          cmd.Parameters.Add(new SqlParameter("@LENKEY", SqlDbType.Int, 4));
          cmd.Parameters.Add(new SqlParameter("@TREKEY", SqlDbType.VarChar));
          // ------------------------------------------------------------------------------заполняем первый уровень
          // передать параметр
          cmd.Parameters["@BUXFRM"].Value = BUXFRM;
          cmd.Parameters["@LENKEY"].Value = LENKEY;
          cmd.Parameters["@TREKEY"].Value = TREKEY;
          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspSprCntKltSel");
          // ------------------------------------------------------------------------------заполняем второй уровень

          // если запись найден
          try
          {
              flag = true;
          }
          // если запись не найден
          catch
          {
              flag = false;
          }
          // освобождаем экземпляр класса DataSet
          ds.Dispose();
          con.Close();
          // возвращаем значение
          return ds;
      }

      // ==================================================================================================  
      // удаление подразделении  (справочника SPRSTRFRM)
      public bool InsSprCntKltDel(string BUXMDB, int CNTKLTIDN)
      {

          string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("InsSprCntKltDel", con);
          cmd = new SqlCommand("InsSprCntKltDel", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add(new SqlParameter("@KLTIDN", SqlDbType.Int, 4));
          // ------------------------------------------------------------------------------заполняем первый уровень
          // передать параметр
          cmd.Parameters["@KLTIDN"].Value = CNTKLTIDN;
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();
          // ------------------------------------------------------------------------------заполняем второй уровень
          return true;

      }
  </script>   
    
    
<body>
    <form id="form1" runat="server">
    <div>
<%-- ============================  для передач значении  ============================================ --%>
  <asp:HiddenField ID="ComParKeyHid" runat="server" />
  <asp:HiddenField ID="HidBuxFrm" runat="server" />

   <span id="WindowPositionHelper"></span>
   
 <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="CUSTOM" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <owd:Window ID="InsWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="0" Height="550" Width="1100" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
        </owd:Window>
<!--  источники -----------------------------------------------------------  -->    
	    <asp:SqlDataSource runat="server" ID="sdsReg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsStf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsPrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsVip" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsUbl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
 		<asp:SqlDataSource runat="server" ID="sdsPrg" SelectCommand="InsPlnFktOneKlt" ConnectionString="" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure">
		    <SelectParameters>
                <asp:Parameter Name="CNTKLTIDN" Type="String" />
            </SelectParameters>
		</asp:SqlDataSource>
<!--  источники -----------------------------------------------------------  -->    

    <div>
    <div style="position:relative; left:0px; top:0px; font-family:Verdana; font-size:10pt; 
         border-style:groove; border-width:1px; border-color: Black; padding:1px">
         
           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="5%" class="PO_RowCap" align="left">Ф.И.О.:</td>
                            <td width="15%">
                                <asp:TextBox ID="FndFio" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="8%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>

                            <td width="8%">
                                <input type="button" name="PrtButton" value="Печать отчета" id="PrtAdvButton"  style="height:25px" onclick="PrtButton_Click();" />
                            </td>    
                            
                            <td>&nbsp;</td>
                        </tr>
        </table>
  </div>  

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
                
                        <obout:Grid id="GridKlt" runat="server" 
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
	                		       PageSize = "100"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="true"
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                  <ScrollingSettings ScrollHeight="400" />
                                   <ClientSideEvents 
                                         OnClientDblClick="OnClientDblClick"
                                         OnBeforeClientDelete="OnBeforeDelete" 
                                         OnBeforeClientEdit="GridKlt_ClientEdit"
                                         OnBeforeClientAdd="GridKlt_ClientAdd" 
                                         ExposeSender="true" />
      		                 <Columns>
	                    			<obout:Column ID="Column00" DataField="CNTKLTIDN" HeaderText="Идн" Visible="true" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="KLTIDN" HeaderText="Код" Visible="true" Width="5%" />
	                    			<obout:Column ID="Column02" DataField="CNTKLTKEY" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column03" DataField="CNTKLTSTX" HeaderText="ВИД ОПЛ" ReadOnly = "true" Width="6%" />											
	                    			<obout:Column ID="Column04" DataField="CNTKLTCMP" HeaderText="Фирма" ReadOnly = "true" Width="6%" />											
	                    			<obout:Column ID="Column06" DataField="CNTKLTFIO" HeaderText="ФИО" Width="26%" />											
                    				<obout:Column ID="Column07" DataField="CNTKLTIIN" HeaderText="ИИН" Width="9%" />
	         	        			<obout:Column ID="Column09" DataField="KLTTEL" HeaderText="Телефон" Width="9%" />
                    				<obout:Column ID="Column10" DataField="CNTKLTKRTEND" HeaderText="Конец"  DataFormatString = "{0:dd.MM.yyyy}" Width="6%" />
                    				<obout:Column ID="Column11" DataField="CNTKLTBRT" HeaderText="Д.рожд"  DataFormatString = "{0:yyyy}" Width="5%" />
                    				<obout:Column ID="Column12" DataField="CNTKLTIIN" HeaderText="ИИН"  Width="0%" />
                    				<obout:Column ID="Column13" DataField="CNTKLTADR" HeaderText="Адрес"  Width="0%" />
                    				<obout:Column ID="Column14" DataField="CNTKLTTHN" HeaderText="Телефон"  Width="0%" />
	            			        <obout:Column ID="Column15" DataField="KLTUCH" HeaderText="Участок" Width="6%" />
		              				<obout:Column ID="Column16" DataField="STF" HeaderText="Сотрудник" Width="4%" />
	            			        <obout:Column ID="Column17" DataField="VIP" HeaderText="VIP" Width="4%" />
                             		<obout:Column ID="Column18" DataField="UBL" HeaderText="Уволен" Width="6%" />
                                    <obout:Column ID="Column20" HeaderText="Кор Удл" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
				                            <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				                    </obout:Column>	           

      		                 </Columns>
	
		                        <Templates>
				                    <obout:GridTemplate runat="server" ID="TemplateStf" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "c" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    		                            		                            
				                    <obout:GridTemplate runat="server" ID="TemplateVip" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    		                            		                            
				                    <obout:GridTemplate runat="server" ID="TemplatePrt" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
                            
                                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                                        <Template>
                                            <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridKlt.edit_record(this)"/>
                                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridKlt.delete_record(this)"/>
                                        </Template>
                                    </obout:GridTemplate>

                                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                                        <Template>
                                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridKlt.update_record(this)"/> 
                                            <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridKlt.cancel_edit(this)"/> 
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

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }
              /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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



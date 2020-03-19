<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SprCntGrd.aspx.cs" Inherits="Reception03hosp45.Spravki.SprCntGrd" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>

 
    <%-- ============================  JAVA ============================================ --%>
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
             //             alert('1 index: ' + index);
             for (var i = 0; i < GridCnt.Rows.length; i++) {
                 if (GridCnt.Rows[i].Cells[0].Value == record.CNTIDN) {
                     index = i;
                     //                                   alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridCnt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function onDoubleClick(sender,recordIndex) {
        //    alert('onDoubleClick=' + recordIndex);
            var NodKey = GridCnt.Rows[recordIndex].Cells[1].Value;
            var NodTxt = GridCnt.Rows[recordIndex].Cells[2].Value;
             //             alert('GlvCntIdn=' + GlvCntIdn);
       //     alert(NodKey);

             //              ob_post.AddParam("GlvStdKod", GlvStdKod);
             //              ob_post.post(null, "SesLabIdn", function() { });

             //              ob_post.UpdatePanel('CallbackPanelStd');
             InsWindow.setTitle(NodTxt);
             InsWindow.setUrl("SprCntGrdTre.aspx?NodKey=" + NodKey+"&NodTxt=" + NodTxt);
             InsWindow.Open();

             //        location.href = "/Spravki/StdCrd.aspx?StdKod=" + GlvStdKod;
         }

         // ===============================================================================================================================================================
         function GridKlt_prg(rowIndex) {
             //    alert('onDoubleClick=' + recordIndex);
             var NodKey = GridCnt.Rows[rowIndex].Cells[1].Value;
             var NodTxt = GridCnt.Rows[rowIndex].Cells[2].Value;
             //             alert('GlvCntIdn=' + GlvCntIdn);
       //      alert(NodKey);
      //       alert(NodTxt);

             //              ob_post.AddParam("GlvStdKod", GlvStdKod);
             //              ob_post.post(null, "SesLabIdn", function() { });

             //              ob_post.UpdatePanel('CallbackPanelStd');
             InsWindow.setTitle(NodTxt);
             InsWindow.setUrl("SprCntGrdTre.aspx?NodKey=" + NodKey + "&NodTxt=" + NodTxt);
             InsWindow.Open();
         }

         // ==================================== поиск клиента по фильтрам  ============================================
         function OnClientSelect(arrSelectedRecords) {
 //            alert('OnClientSelect= ');
             var record = GridCnt.SelectedRecords[0];
             var GlvCntKey = record.CNTKEY;


             InsWindow.setTitle(record.CNTNAM);
             InsWindow.setUrl("SprCntGrdOne.aspx?GlvCntKey=" + GlvCntKey);
             InsWindow.Open();
         }

         // ------------------------  при выборе медуслуги в первой вкладке ------------------------------------------------------------------       
 </script>
 
</head>

<body>
    <form id="form1" runat="server">
    <div>

       
<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
 
<!--  источники -----------------------------------------------------------  -->    
	    <asp:SqlDataSource runat="server" ID="sdsOpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
        <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	    
        <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	    
        <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	

<!--  источники -----------------------------------------------------------  -->    
                       <obout:Grid id="GridCnt" runat="server" 
                                   CallbackMode="true" 
                                Serialize="false" 
                           	       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "20"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                 AllowRecordSelection="false"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="true"
                                   EnableTypeValidation="false" 
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
                                <Columns>
	                    			<obout:Column ID="Column00" DataField="CNTIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="CNTKEY" HeaderText="Код" ReadOnly = "true" Width="10%" />											
                    				<obout:Column ID="Column02" DataField="CNTNAM" HeaderText="Наименование" Width="48%" />
                    				<obout:Column ID="Column03" DataField="CNTABC" HeaderText="Обознач" Width="5%" />
                    				<obout:Column ID="Column04" DataField="CNTDAT" HeaderText="Дата"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="7%" />
	         	        			<obout:Column ID="Column05" DataField="CNTBEG" HeaderText="Начало"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="7%" />
                    				<obout:Column ID="Column06" DataField="CNTEND" HeaderText="Конец"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="7%" />
 		              				<obout:Column ID="Column07" DataField="CNTSTX" HeaderText="Страхователь"  Visible="false" Width="0%" >
		            			           <TemplateSettings TemplateId="TemplateStx" EditTemplateId="TemplateEditStx" />
	            			        </obout:Column>
                  				    <obout:Column ID="Column08" DataField="CNTUBL" HeaderText="Удл"  Width="4%" >
		            			           <TemplateSettings TemplateId="TemplateUbl" EditTemplateId="TemplateEditUbl" />
	            			        </obout:Column> 		            			        
		                    		<obout:Column ID="Column10" DataField="" HeaderText="Корр" Width="7%" AllowEdit="true" AllowDelete="true" />
                                    <obout:Column ID="Column11" DataField="FLG" HeaderText="Прог" Width="5%" ReadOnly="true" >
				                           <TemplateSettings TemplateId="TemplatePrg" />
				                    </obout:Column>				
		                    	</Columns>
		                    
		                        <Templates>	
		                        
	                    		     <obout:GridTemplate runat="server" ID="TemplateOpr" >
				                       <Template>
				                            <%# Container.DataItem["POLNAM"]%>			      		       
				                       </Template>
				                    </obout:GridTemplate>
				                    
				                    <obout:GridTemplate runat="server" ID="TemplateEditOpr" ControlID="ddlOpr" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlOpr" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsOpr" CssClass="ob_gEC" DataTextField="POLNAM" DataValueField="POLKOD">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>	
				          
				                    				                    
	                    		     <obout:GridTemplate runat="server" ID="TemplateEdn" >
				                       <Template>
				                            <%# Container.DataItem["EDNNAM"]%>			      		       
				                       </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditEdn" ControlID="ddlEdn" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlEdn" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNKOD">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>	
				                   
	                    		    <obout:GridTemplate runat="server" ID="TemplateTyp" >
				                      <Template>
				                           <%# Container.DataItem["TYPNAM"]%>			      		       
				                    </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditTyp" ControlID="ddlTyp" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlTyp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTyp" CssClass="ob_gEC" DataTextField="TYPNAM" DataValueField="TYPKOD">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>					                   
				                    		                            		                            
				                    <obout:GridTemplate runat="server" ID="TemplateUbl" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "X" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditUbl" ControlID="chkUbl" ControlPropertyName="checked" UseQuotes="false">
					                    <Template>
						                    <input type="checkbox" id="chkUbl"/>
					                    </Template>
				                    </obout:GridTemplate>					                    

	                    		     <obout:GridTemplate runat="server" ID="TemplateStx" >
				                       <Template>
				                            <%# Container.DataItem["STXNAM"]%>			      		       
				                       </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditStx" ControlID="ddlStx" ControlPropertyName="value">
				                        <Template>
                                            <asp:DropDownList ID="ddlStx" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsStx" CssClass="ob_gEC" DataTextField="STXNAM" DataValueField="STXKOD">
                                               <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                            </asp:DropDownList>	
				                        </Template>
				                    </obout:GridTemplate>

				                    <obout:GridTemplate runat="server" ID="tplDatePickerDat" ControlID="txtOrderDateDat" ControlPropertyName="value">
   		                               <Template>
   		                                     <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
   		                                         <tr>
  		                                            <td valign="middle">
      	                                                <obout:OboutTextBox runat="server" ID="txtOrderDateDat" Width="100%"
         	                                                                FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
       	                                            </td>
                                                    <td valign="bottom" width="30">			                        
                                                    <obout:Calendar ID="calDat" runat="server" 
                                                           StyleFolder="~/Styles/Calendar/styles/default" 
                                                           TextBoxId="txtOrderDateDat"
			                                               DatePickerMode="true"
			                                               ShowYearSelector="true"
			                                               YearSelectorType="DropDownList"
				                                           TitleText="Выберите год: "
				   	 	                                   CultureName = "ru-RU"
					                                       DatePickerImagePath ="~/Styles/Calendar/styles/icon2.gif"/>
                                                    </td>
				                                </tr>
					                        </table>
		                                </Template>
		                            </obout:GridTemplate>
		                            
				                    <obout:GridTemplate runat="server" ID="tplDatePickerBeg" ControlID="txtOrderDateBeg" ControlPropertyName="value">
   		                               <Template>
   		                                     <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
   		                                         <tr>
  		                                            <td valign="middle">
      	                                                <obout:OboutTextBox runat="server" ID="txtOrderDateBeg" Width="100%"
         	                                                                FolderStyle="~/Styles/Grid/grand_gray/interface/OboutTextBox" />
       	                                            </td>
                                                    <td valign="bottom" width="30">			                        
                                                    <obout:Calendar ID="calBeg" runat="server" 
                                                           StyleFolder="~/Styles/Calendar/styles/default" 
                                                           TextBoxId="txtOrderDateBeg"
			                                               DatePickerMode="true"
			                                               ShowYearSelector="true"
			                                               YearSelectorType="DropDownList"
				                                           TitleText="Выберите год: "
				   	 	                                   CultureName = "ru-RU"
					                                       DatePickerImagePath ="~/Styles/Calendar/styles/icon2.gif"/>
                                                    </td>
				                                </tr>
					                        </table>
		                                </Template>
		                            </obout:GridTemplate>
		                            		                            
				                    <obout:GridTemplate runat="server" ID="tplDatePickerEnd" ControlID="txtOrderDateEnd" ControlPropertyName="value">
   		                               <Template>
   		                                     <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
   		                                         <tr>
  		                                            <td valign="middle">
      	                                                <obout:OboutTextBox runat="server" ID="txtOrderDateEnd" Width="100%"
         	                                                                FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
       	                                            </td>
                                                    <td valign="bottom" width="30">			                        
                                                    <obout:Calendar ID="calEnd" runat="server" 
                                                           StyleFolder="~/Styles/Calendar/styles/default" 
                                                           TextBoxId="txtOrderDateEnd"
			                                               DatePickerMode="true"
			                                               ShowYearSelector="true"
			                                               YearSelectorType="DropDownList"
				                                           TitleText="Выберите год: "
				   	 	                                   CultureName = "ru-RU"
					                                       DatePickerImagePath ="~/Styles/Calendar/styles/icon2.gif"/>
                                                    </td>
				                                </tr>
					                        </table>
		                                </Template>
		                            </obout:GridTemplate>	
                                    
                                              
                                  <obout:GridTemplate runat="server" ID="TemplatePrg">
                                      <Template>
                                          <input type="button" id="btnRsx" class="tdTextSmall" value="Прг" onclick="GridKlt_prg(<%# Container.PageRecordIndex %>)"/>
 					                  </Template>
                                  </obout:GridTemplate>                  			

	                    		</Templates>
	                    	</obout:Grid>

<!--  источники -----------------------------------------------------------  -->    
    <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="SCREEN_CENTER" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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


         <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="InsWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="0" Height="550" Width="1000" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
        </owd:Window>

	        </div>


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

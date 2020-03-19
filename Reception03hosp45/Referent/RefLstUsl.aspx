<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="RefLstUsl.aspx.cs" Inherits="Reception03hosp45.Referent.RefLstUsl" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }
        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
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
            
 <%--  -----------------------  услуга  с использованием GRID --------------------------------           
            
        .ob_iCboICBC li, .ob_iCboICBC li b
        {
            height: 400px !important;
            color: #2b4c61;
        }  
        
        .ob_iCboICBC li.ih, .ob_iCboICBC li.ih b, .ob_iCboICBC li.ih i
        {
            background-image: none !important;
        }      
        
        .column
        {
            float: left;
            width: 130px;
            margin-right: 15px;
        }
        
        .column h4
        {
            font-size: 12px;
        }
        --------------------------------------------------------------------------------- --%>
   

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

 <script type="text/javascript">
     var myconfirm = 0;


     // Client-Side Events for Delete
     function OnBeforeDelete(sender, record) {
         if (myconfirm == 1) {
             return true;
         }
         else {
             document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
             document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
             myConfirmBeforeDelete.Open();
             return false;
         }
     }

     function findIndex(record) {
         var index = -1;
         for (var i = 0; i < Grid1.Rows.length; i++) {
             if (Grid1.Rows[i].Cells[0].Value == record.AMBIDN) {
                 index = i;
                 break;
             }
         }
         return index;
     }

     function ConfirmBeforeDeleteOnClick() {
         myconfirm = 1;
         //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         Grid1.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     /*  -----------------------  услуга  с использованием GRID --------------------------------
    
     var gridScrollTop = 0;
 
     function GridUsl_Select(sender, records) {
     gridScrollTop = GridUsl.GridBodyContainer.scrollTop;
     ComboBoxUsl.text(records[0].Kod + '>' + records[0].Grp + '>' + records[0].Usl, true);
     document.getElementById('= USLNAMHID.ClientID').value = records[0].Kod + '>' + records[0].Grp + '>' + records[0].Usl;
     ComboBoxUsl.close();
     }

        function ComboBoxUsl_Open() {
     window.setTimeout(restoreGridScrolling, 150);
     }

        function restoreGridScrolling() {
     GridUsl.GridBodyContainer.scrollTop = gridScrollTop;
     }

        window.onload = function() 
     {
     document.getElementById('gridContainer').onclick = stopEventPropagation;
     }

        function stopEventPropagation(e) {
     if (!e) { e = window.event; }
     if (!e) { return false; }
     e.cancelBubble = true;
     if (e.stopPropagation) { e.stopPropagation(); }
     return false;
     }
     ------------------------------------------------------------------------------------------  */
 </script>
 
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
     <%-- <asp:HiddenField ID="USLNAMHID" runat="server" />    --%>
    
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

       
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 1260px; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: 0px; position: relative; top: 0px; width: 100%; height: 30px;">
             
<%--             <div style="float:left;  width: 50%; position: relative; left: 20px; color: green; "> </div>   --%>
          <center>
             <asp:Label ID="Label1" runat="server" Text="Период" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" />
			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center> 
            
        </asp:Panel> 
<%-- ============================  средний блок  ============================================ --%>
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">
	        
	        <obout:Grid id="Grid1" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_5" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="true" 
	            AllowFiltering="true"
	            Language = "ru"
	            PageSize = "-1"
	            ShowColumnsFooter = "true" >
	            <ClientSideEvents ExposeSender="true" 
	               OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
                    <obout:Column ID="Column0" DataField="AMBIDN" HeaderText="Идн" Visible="false" />
	               	<obout:Column ID="Column1" DataField="AMBDAT" HeaderText="Дата" Width="80" DataFormatString = "{0:dd/MM/yy}">
 	            	       <TemplateSettings EditTemplateId="tplDatePicker1" />
	            	</obout:Column>
	            	<obout:Column ID="Column2" DataField="AMBBEG" HeaderText="Время" Width="50" DataFormatString="{0:HH:mm}" ApplyFormatInEditMode="true" />
                    <obout:Column ID="Column3" DataField="AMBPTH" HeaderText="Клиент" Width="200" />
                    <obout:Column ID="Column4" DataField="AMBTEL" HeaderText="Телефон" Width="100" />
	                <obout:Column ID="Column5" DataField="AMBUSL" HeaderText="Услуга"  Width="400" >
                           <TemplateSettings TemplateId="TempUsl" EditTemplateId="TempUslEdit" />
                    </obout:Column>
                    <obout:Column ID="Column6" DataField="AMBZEN" HeaderText="Сумма" Width="70" />
                    <obout:Column ID="Column7" DataField="AMBKOD" HeaderText="Мастер" Width="150"  >
	            	     <TemplateSettings TemplateId="TemplateBuxNam" EditTemplateId="TemplateEditBuxNam" />
	            	</obout:Column>
                    
                    <obout:Column ID="Column8" DataField="DLGNAM" HeaderText="Спец" ReadOnly="true" Width="80" />
		         	<obout:Column ID="Column9" DataField="" HeaderText="Корр" Width="80px" AllowEdit="true" AllowDelete="true" />
		        </Columns>
		        
		        <Templates>								
<%-- ------------------------  ФИО мастера  ----------------------------------- --%>
	              <obout:GridTemplate runat="server" ID="TemplateBuxNam" >
				      <Template>
				           <%# Container.DataItem["FIO"]%>			      		       
				      </Template>
				  </obout:GridTemplate>
				  <obout:GridTemplate runat="server" ID="TemplateEditBuxNam" ControlID="ddlBuxNam" ControlPropertyName="value">
				       <Template>
                          <asp:DropDownList ID="ddlBuxNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsFio" CssClass="ob_gEC" DataTextField="FIO" DataValueField="KOD">
                              <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                          </asp:DropDownList>	
				       </Template>
				  </obout:GridTemplate>
<%-- ------------------------  услуга  ----------------------------------- --%>
	              <obout:GridTemplate runat="server" ID="TempUsl" >
				      <Template>
				           <%# Container.DataItem["USL"]%>			      		       
				      </Template>
				  </obout:GridTemplate>
 				  <obout:GridTemplate runat="server" ID="TempUslEdit" ControlID="ddlUslNam" ControlPropertyName="value">
				       <Template>
                          <asp:DropDownList ID="ddlUslNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsUsl" CssClass="ob_gEC" DataTextField="USL" DataValueField="KOD">
                              <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                          </asp:DropDownList>	
				       </Template>
				  </obout:GridTemplate>

<%-- ------------------------  календарь  ----------------------------------- --%>
	              <obout:GridTemplate runat="server" ID="tplDatePicker1" ControlID="txtOrderDate1" ControlPropertyName="value">
	                 <Template>
	                   <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
	                       <tr>
	                         <td valign="middle">
		                        <obout:OboutTextBox runat="server" ID="txtOrderDate1" Width="100%"
		                               FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
		                     </td>
			                 <td valign="bottom" width="30">			                        
			                     <obout:Calendar ID="cal3" runat="server" 
					                    StyleFolder="~/Styles/Calendar/styles/default" 
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
		      	    
	          	</Templates>	
           	</obout:Grid>
  </asp:Panel> 				  
<%-- ------------------------  услуга  с использованием GRID ----------------------------------- 


				  <obout:GridTemplate runat="server" ID="TempUslEdit" ControlID="ComboBoxUsl">
                     <Template>
                      <obout:ComboBox runat="server" ID="ComboBoxUsl" Width="400" MenuWidth="650" EmptyText="Выберите услугу..."
                             AllowCustomText="true" AutoClose="false" AutoValidate="true" AllowEdit="false">
                            <ClientSideEvents OnOpen="ComboBoxUsl_Open" />
                                <Items>
                                    <obout:ComboBoxItem ID="ComboBoxItemUsl" runat="server" />
                                </Items>
                                
                                <ItemTemplate>
                                    <div id="gridContainer">
                                        <obout:Grid runat="server" ID="GridUsl" DataSourceID="sdsUsl" AutoGenerateColumns="false"
                                            AllowPaging="false" AllowPageSizeSelection="false" AllowSorting="false" PageSize="-1" 
                                            AllowMultiRecordSelection="false" AllowAddingRecords="false">
                                            <ClientSideEvents ExposeSender="true" OnClientSelect="GridUsl_Select" />
                                            <Columns>
                                                <obout:Column DataField="Kod" HeaderText="Код" Visible="false" />
                                                <obout:Column DataField="Rsd" HeaderText="Раздел" Width="200" />
                                                <obout:Column DataField="Grp" HeaderText="Группа" Width="200"/>
                                                <obout:Column DataField="Usl" HeaderText="Услуга" Width="200"/>
                                            </Columns>
                                            <ScrollingSettings ScrollHeight="300" />
                                            <PagingSettings ShowRecordsCount="false" />
                                        </obout:Grid>
                                     </div>
                                </ItemTemplate>
                        </obout:ComboBox>
                      </Template>   
                  </obout:GridTemplate>
--%>                  


<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
    
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
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
    
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
   
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
	</asp:SqlDataSource>	
   
    <asp:SqlDataSource runat="server" ID="sdsFio" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
	</asp:SqlDataSource>	
   
</asp:Content>

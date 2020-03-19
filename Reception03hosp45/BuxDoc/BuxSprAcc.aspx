<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxSprAcc.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxSprAcc" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>
    

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
             for (var i = 0; i < GridAcc.Rows.length; i++) {
                 if (GridAcc.Rows[i].Cells[0].Value == record.ACCIDN) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;

             GridAcc.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }
      
      
 </script>
 
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
       
 <script type="text/javascript">
      
/* --------------------------------------------------------------------------------------------------------*/
 
        function newDoPostBack(eventTarget, eventArgument) {
            var theForm = document.forms[0];

            if (!theForm) {
                theForm = document.aspnetForm;
            }
 //           alert("newDoPostBack");

            if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                document.getElementById("__EVENTTARGET").value = eventTarget;
                document.getElementById("__EVENTARGUMENT").value = eventArgument;
                theForm.submit();
            }
        }

 /* --------------------------------------------------------------------------------------------------------*/
/* 
        function OnBeforeInsert(record) {
            SetSexID();
            return true;
        }

        function OnEdit(record) {
            var sexID = grid2.Rows[grid2.RecordInEditMode].Cells["Flg"].Value;
            if (sexID == "0") {
                document.getElementById("rFemale").checked = true;
            }
            else {
                document.getElementById("rMale").checked = true;
            }
            return true;
        }

        function OnBeforeUpdate(record) {
            SetSexID();
            return true;
        }

        function SetSexID() {
            if (document.getElementById("rFemale").checked) {
                document.getElementById("hidSex").value = "0";
            }
            else if (document.getElementById("rMale").checked) {
                document.getElementById("hidSex").value = "1";
            }
        }
*/
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
            var pagingContainer = GridAcc.getPagingButtonsContainer('');

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
     
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sdsSpr001" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    	    <asp:SqlDataSource runat="server" ID="sdsSpr002" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    	    <asp:SqlDataSource runat="server" ID="sdsVal" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
<!--------------------------------------------------------  -->    
    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                                                План счетов" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>
        

        <div id="div_kdr" style="position:relative;left:10%; width:90%; " >
     		           <obout:Grid id="GridAcc" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
	         		               AllowAddingRecords = "true"
                                   AllowRecordSelection = "true"
                                   KeepSelectedRecords = "true"
                              EnableTypeValidation="false"
                                   Width="80%"
                                   AllowFiltering = "false" >
                                   <ScrollingSettings ScrollHeight="550" />
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
           		           		<Columns>
	                    			<obout:Column ID="Column0" DataField="ACCIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column1" DataField="ACCKOD" HeaderText="СЧЕТ" Width="5%" />
    	                    	    <obout:Column ID="Column2" DataField="ACCNAM" HeaderText="НАЙМЕНОВАНИЕ СЧЕТА" Width="40%" />											
                				    <obout:Column ID="Column3" DataField="ACCSPR001" HeaderText="СПРАВОЧНИК"  Width="10%" >
	            			              <TemplateSettings TemplateId="TemplateSpr001Nam" EditTemplateId="TemplateEditSpr001Nam" />
	            			        </obout:Column>
                    				<obout:Column ID="Column4" DataField="ACCSPR002" HeaderText="СПРАВОЧНИК"  Width="10%" >
	            			              <TemplateSettings TemplateId="TemplateSpr002Nam" EditTemplateId="TemplateEditSpr002Nam" />
	            			        </obout:Column>
                    				<obout:Column ID="Column5" DataField="ACCPRV" HeaderText="ПРОВОДКА" Align="center" Width="5%" >
	            			              <TemplateSettings TemplateId="TemplatePrv" EditTemplateId="TemplateEditPrv" />
	            			        </obout:Column>
                    				<obout:Column ID="Column6" DataField="ACCAMR" HeaderText="АМОРТ" Align="center" Width="5%" >
	            			              <TemplateSettings TemplateId="TemplateAmr" EditTemplateId="TemplateEditAmr" />
	            			        </obout:Column>

 	                                <obout:Column ID="Column7" DataField="ACCSUM" HeaderText="СУММА" Width="10%" Align="right" DataFormatString="{0:F2}"/>
                    				<obout:Column ID="Column8" DataField="ACCVAL" HeaderText="ВАЛЮТА"  Width="5%"  Align="centert" >
	            			              <TemplateSettings TemplateId="TemplateValNam" EditTemplateId="TemplateEditValNam" />
	            			        </obout:Column>
  		                    		<obout:Column ID="Column9" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateSpr001Nam" >
				                    <Template>
				                            <%# Container.DataItem["SprNam001"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditSpr001Nam" ControlID="ddlSpr001Nam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlSpr001Nam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsSpr001" CssClass="ob_gEC" DataTextField="SPRNAM001" DataValueField="DOCKOD">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>

	                    		<obout:GridTemplate runat="server" ID="TemplateSpr002Nam" >
				                    <Template>
				                            <%# Container.DataItem["SprNam002"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditSpr002Nam" ControlID="ddlSpr002Nam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlSpr002Nam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsSpr002" CssClass="ob_gEC" DataTextField="SPRNAM002" DataValueField="DOCKOD">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>	
				                   
				                    <obout:GridTemplate runat="server" ID="TemplatePrv" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditPrv" ControlID="chkPrv" ControlPropertyName="checked" UseQuotes="false">
					                    <Template>
						                    <input type="checkbox" id="chkPrv"/>
					                    </Template>
				                    </obout:GridTemplate>				                   			                   
				                   
				                    <obout:GridTemplate runat="server" ID="TemplateAmr" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditAmr" ControlID="chkAmr" ControlPropertyName="checked" UseQuotes="false">
					                    <Template>
						                    <input type="checkbox" id="chkAmr"/>
					                    </Template>
				                    </obout:GridTemplate>				                   			                   

	                    		<obout:GridTemplate runat="server" ID="TemplateValNam" >
				                    <Template>
				                            <%# Container.DataItem["ValNamTlx"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditValNam" ControlID="ddlValNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlValNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsVal" CssClass="ob_gEC" DataTextField="ValNamTlx" DataValueField="ValKod">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>	
                                    				                   
	                    		</Templates>
	                    	</obout:Grid>	
           </div>
 
       
           <div class="YesNo" title="Хотите удалить ?"  style="display: none">
                Хотите удалить запись ?
           </div>  
        
       </div>
       

</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxSprMol.aspx.cs" Inherits="Reception03hosp45.Spravki.BuxSprMol" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
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
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
	        font-size: 12px;
         }

 
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
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
             for (var i = 0; i < GridMol.Rows.length; i++) {
                 if (GridMol.Rows[i].Cells[0].Value == record.MolIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridMol.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
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
 /* --------------------------------------------------------------------------------------------------------*/
        function OnBeforeInsertWrt(record) {
            SetWrtID();
            return true;
        }
/* --------------------------------------------------------------------------------------------------------*/
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
            var pagingContainer = GridMol.getPagingButtonsContainer('');

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
    	    <asp:SqlDataSource runat="server" ID="sds1" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
		    </asp:SqlDataSource>	
    	    <asp:SqlDataSource runat="server" ID="sds2" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
		    </asp:SqlDataSource>	
<!--------------------------------------------------------  -->    
    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                                            Справочник МОЛ" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>
        

             <div id="div_cnt" style="position:relative;left:25%; width:50%; " >
     		           <obout:Grid id="GridMol" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="100%"
	         		               AllowAddingRecords = "true"
	         		               AutoPostBackOnSelect = "true"
                                   AllowRecordSelection = "true"
                                   KeepSelectedRecords = "true"
                                   AllowFiltering = "false" >
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
                                   
           		           		<Columns>
	                    			<obout:Column ID="Column1" DataField="MolIdn" HeaderText="Идн" Visible="false"  Width="0%"/>
	                    			<obout:Column ID="Column2" DataField="MolKod" HeaderText="Код" ReadOnly ="true" Width="10%" />
                				    <obout:Column ID="Column5" DataField="MolTab" HeaderText="Фамилия И.О."  Width="50%" >
	            			              <TemplateSettings TemplateId="TemplateMolNam" EditTemplateId="TemplateEditMolNam" />
	            			        </obout:Column>
                    				<obout:Column ID="Column6" DataField="MolOtd" HeaderText="Отделение"  Width="20%" >
	            			              <TemplateSettings TemplateId="TemplateOtdNam" EditTemplateId="TemplateEditOtdNam" />
	            			        </obout:Column>
                    				<obout:Column ID="Column7" DataField="MolUbl" HeaderText="Уволен"  Width="10%" >
	            			              <TemplateSettings TemplateId="TemplateUbl" EditTemplateId="TemplateEditUbl" />
	            			        </obout:Column>
		                    		<obout:Column ID="Column8" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateMolNam" >
				                    <Template>
				                            <%# Container.DataItem["FIO"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditMolNam" ControlID="ddlMolNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlMolNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sds1" CssClass="ob_gEC" DataTextField="FIO" DataValueField="MOLTAB">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>

	                    		<obout:GridTemplate runat="server" ID="TemplateOtdNam" >
				                    <Template>
				                            <%# Container.DataItem["NAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditOtdNam" ControlID="ddlOtdNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlOtdNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sds2" CssClass="ob_gEC" DataTextField="NAM" DataValueField="MOLOTD">
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
       

</asp:Content>

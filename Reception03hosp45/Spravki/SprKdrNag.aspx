<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="SprKdrNag.aspx.cs" Inherits="Reception03hosp45.Spravki.SprKdrNag" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_Net" %>

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

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            grid1.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            //           alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        function OnBeforeDelete(sender, record) {
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
             for (var i = 0; i < grid1.Rows.length; i++) {
                 if (grid1.Rows[i].Cells[0].Value == record.KDRKOD) {
                    index = i;
       //            alert('index: ' + index);
                      break;
                    }
                }
            return index;
        }

        
        
        function grid1_ClientEdit(sender, record) {
            Window1.Open();
 //           document.getElementById('KDRIDN').value = record.KDRIDN;
            document.getElementById('KDRKOD').value = record.KDRKOD;
            document.getElementById('<%= KDRKODHID.ClientID%>').value = record.KDRKOD;
 //           alert(document.getElementById('<%= KDRKODHID.ClientID%>').value);
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);

            return false;
        }

    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="KDRKOD" />
    <asp:HiddenField ID="KDRKODHID" runat="server" />

     
    <span id="WindowPositionHelper"></span>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    
     
<!--  конец -----------------------------------------------  -->    
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
  
        <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 1260px; text-align:center"
             runat="server"></asp:TextBox>
             
        <div id="div_kdr" style="position:relative;left:25%;" >
             <obout:Grid id="grid1" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
	         		               AllowAddingRecords = "false"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false" >
                                   <ClientSideEvents OnBeforeClientEdit="grid1_ClientEdit" ExposeSender="true"/>
		                      	<Columns>
	                    			<obout:Column ID="Column2" DataField="KDRKOD" HeaderText="Код" Width="100" ReadOnly="true" />											
	                    			<obout:Column ID="Column3" DataField="KDRFAM" HeaderText="Фамилия" Width="150" />											
                    				<obout:Column ID="Column4" DataField="KDRIMA" HeaderText="Имя" Width="100" />
                    				<obout:Column ID="Column5" DataField="KDROTC" HeaderText="Отчество" Width="100" />
		                    		<obout:Column ID="Column14" DataField="" HeaderText="Корр" Width="100" AllowEdit="true" AllowDelete="false" />
		                    	</Columns>
	        </obout:Grid>	
    
         </div>
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>

   
     <owd:Window ID="Window1" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        RelativeElementID="WindowPositionHelper" Top="25" Left="300" Height="550" Width="700" VisibleOnLoad="false" StyleFolder="/Styles/Window/wdstyles/aura"
        Title="Награды и поощрения">
 <%-- ============================  для отображение вкладок услуг ============================================ 
  --%>      
            <div class="super-form">
                         <obout:Grid id="grid2" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "false"
                                   AllowPageSizeSelection="false"
                                   ShowColumnsFooter = "true" >
		                      	<Columns>
	                    			<obout:Column ID="Column21" DataField="NGRIDN" HeaderText="Идн" Visible="false" />											
	                    			<obout:Column ID="Column22" DataField="NGRDAT" HeaderText="Дата диплома" Width="110" DataFormatString = "{0:dd/MM/yy}" >
	            			        	   <TemplateSettings EditTemplateId="tplDatePicker0" />
	            			        </obout:Column>
	            			        <obout:Column ID="Column23" DataField="NGRNAM" HeaderText="Учебное заведение" Width="500" />
		                    		<obout:Column ID="Column24" DataField="" HeaderText="Корр" Width="100" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
		                    	
 		                     <Templates>	
		               			<obout:GridTemplate runat="server" ID="tplDatePicker0" ControlID="txtOrderDate1" ControlPropertyName="value">
	                    		        <Template>
	                    		            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
	                    		                <tr>
	                    		                    <td valign="middle">
		                    	                        <obout:OboutTextBox runat="server" ID="txtOrderDate1" Width="100%"
		                    	                            FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
		                    	                    </td>
			                                        <td valign="bottom" width="30">			                        
			                                            <obout:Calendar ID="cal1" runat="server" 
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
	        
            </div>
    </owd:Window> 
     
    
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
             <asp:SqlDataSource  runat="server" ID="sds2" SelectCommand="" 
                 ConnectionString="" ProviderName="System.Data.SqlClient">
            </asp:SqlDataSource>
            
            <%-- 
            
            
            
           --%> 
</asp:Content>

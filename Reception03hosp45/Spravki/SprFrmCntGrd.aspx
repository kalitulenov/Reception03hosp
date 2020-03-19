<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="SprFrmCntGrd.aspx.cs" Inherits="Reception03hosp45.Spravki.SprFrmCntGrd" %>

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


         // ------------------------  при выборе медуслуги в первой вкладке ------------------------------------------------------------------       
 </script>
 
</head>

<body>
    <form id="form1" runat="server">
    <div>
   <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
<!--  источники -----------------------------------------------------------  -->    
	    <asp:SqlDataSource runat="server" ID="sdsOpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
        <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	    
        <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	    
        <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	    
<!--  источники -----------------------------------------------------------  -->    
                       <obout:Grid id="grid1" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/premiere_blue" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "20"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="true"
                                   EnableTypeValidation="false" 
                                   Width="100%"
                                   AllowPageSizeSelection="false">
      		                 <Columns>
	                    			<obout:Column ID="Column00" DataField="STRKLTIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="STRKLTKOD" HeaderText="Код" ReadOnly = "true" Width="5%" />											
                    				<obout:Column ID="Column02" DataField="STRKLTNAM" HeaderText="Наименование" Width="33%" />
                    				<obout:Column ID="Column03" DataField="STRKLTTXT" HeaderText="Для карты" Width="17%" />
                    				<obout:Column ID="Column04" DataField="STRKLTABC" HeaderText="Обознач" Width="12%" />
                    				<obout:Column ID="Column05" DataField="STRKLTDAT" HeaderText="Дата"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="15%" >
                        	               <TemplateSettings EditTemplateId="tplDatePickerDat" />
	                                </obout:Column>	
	         	        			<obout:Column ID="Column06" DataField="STRKLTBEG" HeaderText="Начало"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="15%" />
                    				<obout:Column ID="Column07" DataField="STRKLTEND" HeaderText="Конец"  DataFormatString = "{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="15%" />
		              				<obout:Column ID="Column10" DataField="POLKOD" HeaderText="Наименование" Width="44%" />
		              				<obout:Column ID="Column11" DataField="TYPKOD" HeaderText="Вид" Width="10%" />
		              				<obout:Column ID="Column12" DataField="EDNKOD" HeaderText="Ед.изм" Width="10%" />
                    				<obout:Column ID="Column13" DataField="STRKLTPOLSUM" HeaderText="Сумма"  Width="5%" />
		              				<obout:Column ID="Column14" DataField="STRKLTPOLUSL" HeaderText="Услуга" Width="20%" />
		                    		<obout:Column ID="Column15" DataField="" HeaderText="Корр" Width="7%" AllowEdit="true" AllowDelete="false" />
		                    	</Columns>
		                    
		                        <Templates>	
		                        
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
			                                               DatePickerMode="true"
			                                               ShowYearSelector="true"
			                                               YearSelectorType="DropDownList"
				                                           TitleText="Выберите год: "
				   	 	                                   CultureName = "ru-RU"
                                                           DatePickerSynchronize="true"
					                                       DatePickerImagePath ="~/Styles/Calendar/styles/icon2.gif"/>
                                                    </td>
				                                </tr>
					                        </table>
		                                </Template>
		                            </obout:GridTemplate>
		                            
	                    		</Templates>
	
	    
	                    	</obout:Grid>
	        </div>
    </form>
        <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
</body>
</html>

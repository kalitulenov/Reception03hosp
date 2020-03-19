<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SprSttStrGrd.aspx.cs" Inherits="Reception03hosp45.Spravki.SprSttStrGrd" %>

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
             for (var i = 0; i < GridStt.Rows.length; i++) {
                 if (GridStt.Rows[i].Cells[0].Value == record.STTSTRIDN) {
                     index = i;
                     //                                   alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridStt.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnClientSelect(arrSelectedRecords) {
 //            alert('OnClientSelect= ');
             var record = GridStt.SelectedRecords[0];
             var GlvSttStrKey = record.STTSTRKEY;


             InsWindow.setTitle(record.STTSTRNAM);
             InsWindow.setUrl("SprSttStrGrdOne.aspx?GlvSttStrKey=" + GlvSttStrKey);
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
                       <obout:Grid id="GridStt" runat="server" 
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
                                   ShowColumnsFooter = "false"
                                   AllowPaging="true"
                                   EnableTypeValidation="false" 
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                   <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true"/>
                                <Columns>
	                    			<obout:Column ID="Column00" DataField="STTSTRIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="STTSTRKEY" HeaderText="Код" ReadOnly = "true" Width="10%" />											
                    				<obout:Column ID="Column02" DataField="STTSTRNAM" HeaderText="Наименование" Width="80%" />
		                    		<obout:Column ID="Column10" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
		                    
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

	        </div>


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

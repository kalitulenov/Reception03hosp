<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxSprBnk.aspx.cs" Inherits="Reception03hosp45.Spravki.BuxSprBnk" %>

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
             for (var i = 0; i < GridBnk.Rows.length; i++) {
                 if (GridBnk.Rows[i].Cells[0].Value == record.BNKIDN) {
                     index = i;
                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridBnk.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
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
    </script>
     
<!--  источники -----------------------------------------------------------  -->    
<!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
 
    <div>
        <asp:TextBox ID="TextBox1" 
             Text="                                   Справочник банка" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 20%; position: relative; width: 60%"
             runat="server"></asp:TextBox>

             <div id="div_cnt" style="position:relative;left:20%; width:60%; " >
     		           <obout:Grid id="GridBnk" runat="server" 
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
	                    			<obout:Column ID="Column0" DataField="BNKIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column1" DataField="BNKKOD" HeaderText="КОД" ReadOnly ="true" Width="5%" />
    	                    	    <obout:Column ID="Column2" DataField="BNKBIN" HeaderText="БИН" Width="15%" />											
                    				<obout:Column ID="Column3" DataField="BNKBIK" HeaderText="БИК"  Width="15%" />
                				    <obout:Column ID="Column4" DataField="BNKNAM" HeaderText="НАИМЕНОВАНИЕ"  Width="55%" />
		                    		<obout:Column ID="Column5" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	
	                    	</obout:Grid>	
           </div>
 
       
           <div class="YesNo" title="Хотите удалить ?"  style="display: none">
                Хотите удалить запись ?
           </div>  
        
       </div>
       

</asp:Content>

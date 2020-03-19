<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="SprOrgHsp.aspx.cs" Inherits="Reception03hosp45.Spravki.SprOrgHsp" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
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

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridHsp.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
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
             for (var i = 0; i < GridHsp.Rows.length; i++) {
                 if (GridHsp.Rows[i].Cells[0].Value == record.ORGHSPKOD) {
                    index = i;
       //            alert('index: ' + index);
                      break;
                    }
                }
            return index;
        }

    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="KDRKOD" />
     
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
                                <input type="button" value="Назад" onclick="myConfirmBeforeDelete.Close();" />
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
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
        <div id="div_kdr" style="position:relative;left:5%; width:90%; " >
             <obout:Grid id="GridHsp" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       AllowRecordSelection="true"
                                   AllowColumnResizing="true"
                                   AllowSorting="true"
                                   AllowPaging="false"
                                   AllowPageSizeSelection="false"
                                   Width="100%"
                                   PageSize="-1"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "true" >
                                   <ScrollingSettings ScrollHeight="550" />
                                  <ClientSideEvents 
                                        OnBeforeClientDelete="OnBeforeDelete"
		                                ExposeSender="true"/>
		                        	<Columns>
	                    			<obout:Column ID="Column01" DataField="ORGHSPKOD" HeaderText="Код" Width="5%" ReadOnly="true" />											
	                    			<obout:Column ID="Column02" DataField="ORGHSPNAM" HeaderText="Наименование" Width="20%" />											
                    				<obout:Column ID="Column03" DataField="ORGHSPNAMSHR" HeaderText="Корот.наим" Width="10%" />
                    				<obout:Column ID="Column04" DataField="ORGHSPSURIDN" HeaderText="ID в СУРе" Width="10%" />
                    				<obout:Column ID="Column05" DataField="ORGHSPADR" HeaderText="Адрес" Width="20%" />
                    				<obout:Column ID="Column06" DataField="ORGHSPBIN" HeaderText="БИН" Width="10%" />
                    				<obout:Column ID="Column07" DataField="ORGHSPIIK" HeaderText="ИИК"  Width="10%" />
                    				<obout:Column ID="Column08" DataField="ORGHSPKNTTEL" HeaderText="Телефон"  Width="10%" />
		                    		<obout:Column ID="Column09" DataField="" HeaderText="Корр" Width="5%" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
	        </obout:Grid>	
    
         </div>
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>
</asp:Content>

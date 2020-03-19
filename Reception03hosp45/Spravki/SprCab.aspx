<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="SprCab.aspx.cs" Inherits="Reception03hosp45.Spravki.SprCab" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
   
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
             for (var i = 0; i < GridCab.Rows.length; i++) {
                 if (GridCab.Rows[i].Cells[0].Value == record.CabIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridCab.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }
      

         function updateSprDlgSelection(sender, index) {
             document.getElementById('hiddenDlgNam').value = sender.value();
         }
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

         window.onload = function () {
             window.setTimeout(hidePagingButtons, 250);
         }

         function hidePagingButtons() {
             var pagingContainer = GridCab.getPagingButtonsContainer('');

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

         function filterGrid(e) {
             var fieldName;
             //        alert("filterGrid=");

             if (e != 'ВСЕ') {
                 fieldName = 'FIO';
                 GridCab.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                 GridCab.executeFilter();
             }
             else {
                 GridCab.removeFilter();
             }
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
     
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sds1" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    <!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />

    <div>
        <asp:TextBox ID="TextBox1"
            Text="                                                                Справочник кабинетов"
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>

        <div id="div_cnt" style="position: relative; left: 15%; width: 70%;">
            <obout:Grid ID="GridCab" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                Width="100%"
                 EnableTypeValidation="false"
             AllowFiltering="true" 
             FilterType="ProgrammaticOnly" 
                AllowSorting="true"
                AllowPageSizeSelection="false"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                KeepSelectedRecords="true">
                <ScrollingSettings ScrollHeight="550" />
                <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column1" DataField="CabIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="CabKod" HeaderText="КОД" ReadOnly="true" Width="5%" />
                    <obout:Column ID="Column3" DataField="CabNam" HeaderText="ГДЕ ПРИЕМ" Width="60%" />
                    <obout:Column ID="Column4" DataField="CabMem" HeaderText="ПРИМАЧАНИЕ" Width="25%" />
                    <obout:Column ID="Column5" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>

            </obout:Grid>


        </div>

        <div class="ob_gMCont" style=" width:60%; height: 20px;left: 20%;">
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

        <div class="YesNo" title="Хотите удалить ?" style="display: none">
            Хотите удалить запись ?
        </div>


    </div>
       

</asp:Content>

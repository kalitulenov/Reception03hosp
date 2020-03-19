<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="SprBuxUch.aspx.cs" Inherits="Reception03hosp45.Spravki.SprBuxUch" %>

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
             for (var i = 0; i < GridBux.Rows.length; i++) {
                 if (GridBux.Rows[i].Cells[0].Value == record.UchIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridBux.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
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
         function OnBeforeInsertWrt(record) {
             SetWrtID();
             return true;
         }
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
             var pagingContainer = GridBux.getPagingButtonsContainer('');

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
                 GridBux.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
                 GridBux.executeFilter();
             }
             else {
                 GridBux.removeFilter();
             }
         }

      function PrtButton_Click() {
          var GrfSid = document.getElementById('MainContent_parBuxSid').value;
          var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;

          var ua = navigator.userAgent;

          if (ua.search(/Chrome/) > -1)
              window.open("/Report/DauaReports.aspx?ReportName=HspSprBux&TekDocIdn=" + GrfSid + "&TekDocKod=" + GrfUbl + "&TekDocFrm=" + GrfFrm,
                         "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
          else
              window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprBux&TekDocIdn=" + GrfSid + "&TekDocKod=" + GrfUbl + "&TekDocFrm=" + GrfFrm,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }
 </script>
 
  <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
      <%-- ============================  для передач значении  ============================================ --%>
  
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
    	    <asp:SqlDataSource runat="server" ID="sdsBux" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsUch" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
   <!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />
     <asp:HiddenField ID="parBuxSid" runat="server" />

    <div>
        <table border="0" cellspacing="0" width="100%">
            <tr>
                <td width="30%" class="PO_RowCap">  </td>
                <td width="40%" class="PO_RowCap">
                    <asp:TextBox ID="TextBox1"
                        Text="             Справочник участок + врач"
                        BackColor="#0099FF"
                        Font-Names="Verdana"
                        Font-Size="20px"
                        Font-Bold="True"
                        ForeColor="White"
                        Style="top: 0px; left: 0%; position: relative; width: 100%"
                        runat="server"></asp:TextBox>
                </td>
                <td width="30%" class="PO_RowCap">  </td>
           </tr>

        </table>
        
        <div id="div_cnt" style="position: relative; left: 30%; width: 40%;">
            <obout:Grid ID="GridBux" runat="server"
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
                <ScrollingSettings ScrollHeight="450" />
                <ClientSideEvents OnBeforeClientDelete="OnBeforeDelete" ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column1" DataField="UchIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="UchNam" HeaderText="УЧАСТОК" Align="left" Width="45%">
                        <TemplateSettings EditTemplateId="TemplateEditUch" />
                    </obout:Column>          
                    <obout:Column ID="Column5" DataField="UchDoc" HeaderText="ВРАЧ" Width="45%" Align="left">
                        <TemplateSettings TemplateId="TemplateBuxNam" EditTemplateId="TemplateEditBuxNam" />
                    </obout:Column>
 
                    <obout:Column ID="Column13" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                    <obout:Column ID="Column14" DataField="FIO" HeaderText="Идн" Visible="false" Width="0%" />
                </Columns>

                <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateBuxNam">
                        <Template>
                            <%# Container.DataItem["FIO"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditBuxNam" ControlID="ddlBuxNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlBuxNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsBux" CssClass="ob_gEC" DataTextField="FIO" DataValueField="BUXKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlUchNam" ID="TemplateEditUch" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlUchNam" Width="100%" Height="250"
                                DataSourceID="sdsUch" DataTextField="UchNam" DataValueField="UchNam">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>

        <div class="YesNo" title="Хотите удалить ?" style="display: none">
            Хотите удалить запись ?
        </div>


    </div>
       

</asp:Content>

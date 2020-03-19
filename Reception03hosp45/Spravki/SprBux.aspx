<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="SprBux.aspx.cs" Inherits="Reception03hosp45.Spravki.SprBux" %>

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
                 if (GridBux.Rows[i].Cells[0].Value == record.BuxIdn) {
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
      
         function loadDlg(sender, index) {
             //          alert("loadStx 0 =" + index);
             //          alert("loadStx 1 =" + document.getElementById('MainContent_parBuxFrm').value);
                 //      alert("sender.value =" + sender.value);
                //       var GrfDlg = BoxDoc001.options[BoxDoc001.selectedIndex()].value;

                       var SndPar = sender.value() + ':' + document.getElementById('MainContent_parBuxFrm').value;
              //         alert("loadStx 3 =" + SndPar);
               //        PageMethods.GetSprDlg(SndPar, onSprDlgLoaded, onSprDlgLoadedError);
                       $.ajax({
                           type: 'POST',
                           url: '/HspUpdDoc.aspx/GetSprDlg',
                           data: '{"SndPar":"' + SndPar + '"}',
                           contentType: "application/json; charset=utf-8",
                           dataType: "json",
                           success: function (SprDlg) {
                  //              alert("onSprUslLoaded=" + SprDlg.d);

                               SprDlgComboBox.options.clear();
                               SprDlgComboBox.options.add("");   //   без этой строки не работает !!!!!!!!!!!!!!!!!!!!!!!!
                               for (var i = 0; i < SprDlg.d.length; i = i + 2) {
                                   SprDlgComboBox.options.add(SprDlg.d[i], SprDlg.d[i + 1]);
                               }
                           },
                           error: function () { alert("ERROR="); }
                       });

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
          var GrfUbl = document.getElementById('MainContent_ParRadUbl').value;

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
    	    <asp:SqlDataSource runat="server" ID="sdsDlg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsStf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsStt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsUch" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
   <!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />
     <asp:HiddenField ID="parBuxSid" runat="server" />

    <div>
        <table border="0" cellspacing="0" width="100%">
            <tr>
                <td width="10%" class="PO_RowCap">  </td>
                <td width="60%" class="PO_RowCap">
                    <asp:TextBox ID="TextBox1"
                        Text="                                         Справочник сотрудников"
                        BackColor="#0099FF"
                        Font-Names="Verdana"
                        Font-Size="20px"
                        Font-Bold="True"
                        ForeColor="White"
                        Style="top: 0px; left: 0%; position: relative; width: 100%"
                        runat="server"></asp:TextBox>

                </td>
                <td width="10%" class="PO_RowCap">
                    <obout:OboutRadioButton runat="server" ID="RadBut001" Width="60%" OnCheckedChanged="OboutRadioButton_CheckedChanged001"
                        FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Работающие" AutoPostBack="true" GroupName="g1" />
                    <obout:OboutRadioButton runat="server" ID="RadBut002" Width="30%" OnCheckedChanged="OboutRadioButton_CheckedChanged002"
                        FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Все" AutoPostBack="true" GroupName="g1" />
                </td>
                <td width="10%" class="PO_RowCap">
                    <input type="button" name="PrtButton" style="width: 100%" value="Печать" id="PrtButton" onclick="PrtButton_Click();" />
                </td>
                <td width="30%" class="PO_RowCap">  </td>
            </tr>

        </table>
        
        <div id="div_cnt" style="position: relative; left: 10%; width: 80%;">
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
                    <obout:Column ID="Column1" DataField="BuxIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="BuxKod" HeaderText="КОД" ReadOnly="true" Width="5%" />
                    <obout:Column ID="Column3" DataField="BuxLog" HeaderText="ЛОГИН" Width="8%" />
                    <obout:Column ID="Column4" DataField="BuxPsw" HeaderText="ПАРОЛЬ" Width="8%" />
                    <obout:Column ID="Column5" DataField="BuxTab" HeaderText="ФАМИЛИЯ И.О." Width="20%">
                        <TemplateSettings TemplateId="TemplateBuxNam" EditTemplateId="TemplateEditBuxNam" />
                    </obout:Column>
                    <obout:Column ID="Column6" DataField="BuxKey" HeaderText="ШТАТКА" Width="10%">
                        <TemplateSettings TemplateId="TemplateSttNam" EditTemplateId="TemplateEditSttNam" />
                    </obout:Column>
                    <obout:Column ID="Column7" DataField="BuxDlg" HeaderText="СПЕЦИАЛИСТ" Width="25%">
                        <TemplateSettings TemplateId="TemplateDlgNam" EditTemplateId="TemplateEditDlgNam" />
                    </obout:Column>
                    <obout:Column ID="Column8" DataField="BuxPrz" HeaderText="%" Width="4%" />
                    <obout:Column ID="Column9" DataField="BuxStf" HeaderText="СТАВКА" Width="5%" Align="right">
                        <TemplateSettings EditTemplateId="TemplateEditStfNam" />
                    </obout:Column>
                    <obout:Column ID="Column10" DataField="BuxMol" HeaderText="МОЛ" Align="center" Width="4%">
                        <TemplateSettings TemplateId="TemplateMol" EditTemplateId="TemplateEditMol" />
                    </obout:Column>
                    <obout:Column ID="Column12" DataField="BuxUbl" HeaderText="УВОЛЕН" Align="center" Width="4%">
                        <TemplateSettings TemplateId="TemplateUbl" EditTemplateId="TemplateEditUbl" />
                    </obout:Column>
                    <obout:Column ID="Column13" DataField="" HeaderText="КОРР" Width="7%" AllowEdit="true" AllowDelete="false" />
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
                            <asp:DropDownList ID="ddlBuxNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsBux" CssClass="ob_gEC" DataTextField="FIO" DataValueField="BUXTAB">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSttNam">
                        <Template>
                            <%# Container.DataItem["STTNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlSttNam" ID="TemplateEditSttNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlSttNam" Width="100%" Height="250"
                                DataSourceID="sdsStt" DataTextField="SttNam" DataValueField="SttKey">
                                <ClientSideEvents OnSelectedIndexChanged="loadDlg" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateUch">
                        <Template>
                            <%# Container.DataItem["UchNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlUchNam" ID="TemplateEditUch" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlUchNam" Width="100%" Height="250"
                                DataSourceID="sdsUch" DataTextField="UchNam" DataValueField="UchNam">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateDlgNam">
                        <Template>
                            <%# Container.DataItem["NAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="hiddenDlgNam" ID="TemplateEditDlgNam" ControlPropertyName="value">
                        <Template>
                           <input type="hidden" id="hiddenDlgNam" />
                           <obout:ComboBox runat="server" ID="SprDlgComboBox" Width="100%" Height="300" MultiSelectionSeparator="&" SelectionMode="Multiple">
                                <ClientSideEvents OnSelectedIndexChanged="updateSprDlgSelection" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateEditStfNam" ControlID="ddlStfNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlStfNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsStf" CssClass="ob_gEC" DataTextField="KOLSTF" DataValueField="KOLSTF">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateMol" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "М" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditMol" ControlID="chkMol" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkMol" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateUbl" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "У" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditUbl" ControlID="chkUbl" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkUbl" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>

<asp:Literal runat="server" ID="Downloader" />
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

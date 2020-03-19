<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DocApp003Dsp.aspx.cs" Inherits="Reception03hosp45.Priem.DocApp003Dsp" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
 
         window.onload = function () {
             $.mask.definitions['H'] = '[012]';
             $.mask.definitions['S'] = '[012345]';

             $.mask.definitions['D'] = '[0123]';
             $.mask.definitions['M'] = '[01]';
             $.mask.definitions['Y'] = '[12]';

             $('#ctl00$MainContent$TextBoxDat').mask('D9.M9.Y999');
             $('#ctl00$MainContent$TextBoxTim').mask('H9:S9');

             //           alert("AmbCrdIdn=" + AmbCrdIdn);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocApp003Viz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         };

         function getQueryString() {
             var queryString = [];
             var vars = [];
             var hash;
             var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
  //           alert("hashes=" + hashes);
             for (var i = 0; i < hashes.length; i++) {
                 hash = hashes[i].split('=');
                 queryString.push(hash[0]);
                 vars[hash[0]] = hash[1];
                 queryString.push(hash[1]);
             }
             return queryString;
         }


         function onChangeTxt(sender, newText) {
             //               alert("onChangeJlb=" + sender + " " + newText);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Int';

             switch (sender) {
                 case 'ctl00$MainContent$TextBoxDat':
                     if (newText.length != 10) return
                     GrfDocRek = 'GRFDAT';
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), '" + newText + "', 104)+''+ LEFT(CONVERT(CHAR(12), GRFBEG, 114),8) ,103)";
                     break;
                 case 'ctl00$MainContent$TextBoxTim':
                     if (newText.length != 5) return
                     GrfDocRek = 'GRFBEG';
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), GRFDAT, 104)+" + " '" + newText + ":00',103)";
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }
         //    ------------------------------------------------------------------------------------------------------------------------

         function onChange(sender, newText) {
             //            alert("onChangeJlb=" + sender.ID);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID) {
                 case 'TxtTim':
                     GrfDocRek = 'GRFTIM'
                     break;
                 case 'TxtFio':
                     GrfDocRek = 'GRFPTH';
                     break;
                 case 'TxtIin':
                     GrfDocRek = 'GRFIIN';
                     break;
                 case 'TxtObl':
                     GrfDocRek = 'SMPADROBL';
                     break;
                 case 'TxtCty':
                     GrfDocRek = 'SMPADRCTY';
                     break;
                 case 'TxtStr':
                     GrfDocRek = 'SMPADRSTR';
                     break;
                 case 'TxtDom':
                     GrfDocRek = 'SMPADRDOM';
                     break;
                 case 'TxtApr':
                     GrfDocRek = 'SMPADRAPR';
                     break;
                 case 'TxtUgl':
                     GrfDocRek = 'SMPADRUGL';
                     break;
                 case 'TxtZsd':
                     GrfDocRek = 'SMPADRZSD';
                     break;
                 case 'TxtPod':
                     GrfDocRek = 'SMPADRPOD';
                     break;
                 case 'TxtEtg':
                     GrfDocRek = 'SMPADRETG';
                     break;
                 case 'TxtDmf':
                     GrfDocRek = 'SMPADRDMF';
                     break;
                 case 'TxtAlr':
                     GrfDocRek = 'SMPALR';
                     break;
                 case 'TxtTel':
                     GrfDocRek = 'GRFTEL';
                     break;
                 case 'TxtJlb':
                     GrfDocRek = 'GRFMEM';
                     break;
                 case 'TxtLpuNam':
                     GrfDocRek = 'SMPLPUNAM';
                     break;
                 case 'TxtLpuOtd':
                     GrfDocRek = 'SMPLPUOTD';
                     break;
                 case 'TxtLpuMkb':
                     GrfDocRek = 'SMPLPUMKB';
                     break;
                 case 'TxtLpuMkbNam':
                     GrfDocRek = 'SMPLPUMKBNAM';
                     break;
                 case 'TxtLpuRes':
                     GrfDocRek = 'SMPLPURES';
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }


         //    ------------------------------------------------------------------------------------------------------------------------

         function OnSelectedIndexChanged(sender, selectedIndex) {
             //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
             //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
             //           alert('SelectedIndexChanged: ' + selectedIndex);
             //             alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal;
             var GrfDocTyp = 'Int';

             switch (sender.ID) {
                 case 'BoxDocSmp':
                     GrfDocRek = 'GRFKOD';
                     GrfDocVal = BoxDocSmp.options[BoxDocSmp.selectedIndex()].value;
                     break;
                 case 'BoxResTyp':
                     GrfDocRek = 'SMPSPRTYP';
                     GrfDocVal = BoxResTyp.options[BoxResTyp.selectedIndex()].value;
                     break;
                 case 'BoxResCrm':
                     GrfDocRek = 'SMPSPRCRM';
                     GrfDocVal = BoxResCrm.options[BoxResCrm.selectedIndex()].value;
                     break;
                 case 'BoxResViz':
                     GrfDocRek = 'SMPSPRVIZ';
                     GrfDocVal = BoxResViz.options[BoxResViz.selectedIndex()].value;
                     break;
                 case 'BoxResRsl':
                     GrfDocRek = 'SMPSPRRSL';
                     GrfDocVal = BoxResRsl.options[BoxResRsl.selectedIndex()].value;
                     break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function OnClientDateChangedDat(sender, selectedDate) {

             var GrfDocRek = 'GRFDAT';
             var GrfDocVal = document.getElementById('TxtDat').value;
             var GrfDocTyp = 'Dat';

             //       alert("GrfDocVal " + GrfDocVal);

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         function OnClientDateChangedBrt(sender, selectedDate) {

             var GrfDocRek = 'GRFBRT';
             var GrfDocVal = document.getElementById('TxtBrt').value;
             var GrfDocTyp = 'Dat';

             //       alert("GrfDocVal " + GrfDocVal);

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBCRD';
             var DatDocKey = 'GRFIDN';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             if (DatDocRek.substring(0, 3) == "SMP") {
                 DatDocTab = 'AMBSMP';
                 DatDocKey = 'SMPAMB';
             }

             var QueryString = getQueryString();
   //          DatDocIdn = QueryString[1];
             DatDocIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;


   //                       alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
             switch (DatDocTyp) {
                 case 'Sql':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Str':
                     DatDocTyp = 'Str';
                     SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                     break;
                 case 'Dat':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Int':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 default:
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
   //                     alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR="); }
             });

         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnButton001Click() {
             parMkbNum.value = 1;
             MkbWindow.Open();
         }
         function OnButton002Click() {
             parMkbNum.value = 2;
             MkbWindow.Open();
         }
         function OnButton003Click() {
             parMkbNum.value = 3;
             MkbWindow.Open();
         }

         function OnClientDblClick(iRecordIndex) {
             //            alert('OnClientDblClick= ' + parMkbNum.value);
             var GrfDocRek;
             var GrfDocVal = gridMkb.Rows[iRecordIndex].Cells[1].Value;

             if (parMkbNum.value == 1) {
                 Mkb001.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                 GrfDocRek = 'DOCMKB001';
             }
             if (parMkbNum.value == 2) {
                 Mkb002.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                 GrfDocRek = 'DOCMKB002';
             }
             if (parMkbNum.value == 3) {
                 Mkb003.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                 GrfDocRek = 'DOCMKB003';
             }
             MkbWindow.Close();

             onChangeUpd(GrfDocRek, GrfDocVal);
         }

//    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrt003&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrt003&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }
         //    =======================================================================================================================
         function BckButton_Click() {
             location.href = "/GoBack/GoBack1.aspx";
         }


         // --------------  ИЗМЕНИТЬ ДАТУ ПРИЕМА ----------------------------
         function onDateChange(sender, selectedDate) {
             //          alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
             //            alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

         }



 </script>

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:2%; position: relative; top: 0px; width: 96%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="7%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="32%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№карты</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
              </tr>
              
               <tr>
                   <td width="7%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="80px" Height="20" RunAt="server" BackColor="#FFFFE0" />
			          <obout:Calendar ID="Calendar3" runat="server"
			 	                    	StyleFolder="/Styles/Calendar/styles/default" 
    	          					    DatePickerMode="true"
    	           					    ShowYearSelector="true"
                					    YearSelectorType="DropDownList"
    	           					    TitleText="Выберите год: "
    	           					    CultureName = "ru-RU"
                					    TextBoxId = "TextBoxDat"
                                        OnClientDateChanged="onDateChange"   
                					    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>


                      <asp:RegularExpressionValidator ID="regexTextBoxDat" ControlToValidate="TextBoxDat" SetFocusOnError="True" 
                           ValidationExpression="(0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.](19|20)\d\d" ErrorMessage="" runat="server" />

                 </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" Font-Bold="true" BackColor="#FFFFE0" />
                      <asp:RegularExpressionValidator ID="regexTextBoxTim" ControlToValidate="TextBoxTim" SetFocusOnError="True" 
                           ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ErrorMessage="" runat="server" />
                  </td>

                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="32%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTit" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="Семейный врач" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 550px;">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parGrfIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
      <br />
            <%-- ============================  шапка экрана ============================================ --%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">

                <!--  ФИО ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label03" runat="server" align="center" Style="font-weight: bold;" Text="Ф.И.О."></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtFio" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label21" runat="server" align="center" Style="font-weight: bold;" Text="ИИН &nbsp;&nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtIin" Width="20%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label04" runat="server" align="center" Style="font-weight: bold;" Text="Год/р"></asp:Label>
                        <asp:TextBox runat="server" ID="TxtBrt" Width="70px" BackColor="#FFFFE0" ReadOnly="true" />

                     <!--  Год рождения ----------------------------------------------------------------------------------------------------------  -->
                        <asp:RegularExpressionValidator ID="regexTxtBrt" ControlToValidate="TxtBrt" SetFocusOnError="True" 
                             ValidationExpression="(0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.](19|20)\d\d" ErrorMessage="Ошибка" runat="server" />

                    </td>
                    <td width="50%" align="center"></td>
                </tr>

                <!--  Область и нас.пункт ----------------------------------------------------------------------------------------------------------  -->
                 <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="Область"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtObl" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="Пункт"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtCty" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <!--  Дом ----------------------------------------------------------------------------------------------------------  -->
                    <td width="50%" style="vertical-align: top;" align="center"></td>
                </tr>
                
                              <!--  ИИН ----------------------------------------------------------------------------------------------------------  -->
                <!--  Улица ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label07" runat="server" align="center" Style="font-weight: bold;" Text="Улица"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtStr" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="Дом &nbsp;&nbsp;&nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtDom" Width="15%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <!--  Квартира ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="Label11" runat="server" align="center" Style="font-weight: bold;" Text="Квартира&nbsp;&nbsp;&nbsp;&nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtApr" Width="15%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <!--  Дом ----------------------------------------------------------------------------------------------------------  -->
                    <td width="50%" style="vertical-align: top;" align="center"></td>
                </tr>
                <tr>
                    <!--  Угол ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label08" runat="server" align="center" Style="font-weight: bold;" Text="Угол"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtUgl" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    <!--  Заезд ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="Label09" runat="server" align="center" Style="font-weight: bold;" Text="Заезд &nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtZsd" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                    </td>
                    <td width="50%" style="vertical-align: top;" align="center"></td>

                </tr>
                <!--  Подъезд ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label12" runat="server" align="center" Style="font-weight: bold;" Text="Подъезд"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtPod" Width="7%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label13" runat="server" align="center" Style="font-weight: bold;" Text="Этаж"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtEtg" Width="8%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label14" runat="server" align="center" Style="font-weight: bold;" Text="Домофон"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtDmf" Width="10%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label15" runat="server" align="center" Style="font-weight: bold;" Text="Тел. &nbsp;&nbsp;&nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtTel" Width="45%" BackColor="White" Height="60px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                    </td>
                    <!--  Этаж ----------------------------------------------------------------------------------------------------------  -->
                    <td width="50%" style="vertical-align: top;" align="center"></td>

                </tr>
                <!--  Домофон ----------------------------------------------------------------------------------------------------------  -->
                <!--  Телефон ----------------------------------------------------------------------------------------------------------  -->
                <!--  Услуга ----------------------------------------------------------------------------------------------------------  -->
                <!--  Аллергия----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label6" runat="server" align="center" Style="font-weight: bold;" Text="Аллергия"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtAlr" Width="98%" BackColor="White" Height="50px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td width="50%" style="vertical-align: top;" align="center"></td>

                </tr>

                <!--  Причина ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label17" runat="server" align="center" Style="font-weight: bold;" Text="Причина"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtJlb" Width="98%" BackColor="White" Height="50px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td width="50%" style="vertical-align: top;" align="center"></td>

                </tr>

                <!--  Дата ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label1" runat="server" align="center" Style="font-weight: bold;" Text="Врач"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:ComboBox runat="server" ID="BoxDocSmp" Width="44%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsCmp" DataTextField="Fio" DataValueField="BuxKod">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
                    </td>
                    <td width="50%" align="center"></td>
                </tr>

                <!--  Врач СМП ----------------------------------------------------------------------------------------------------------  -->
                <!--  Врач семейный ----------------------------------------------------------------------------------------------------------  -->
            </table>
            <!-- Результат ----------------------------------------------------------------------------------------------------------   -->


        </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 30px;">
             <center>
                 <input type="button" value="Назад к списку"  onclick="BckButton_Click()" />
                 <input type="button" value="Печать"  onclick="PrtButton_Click()" />
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
  <asp:SqlDataSource runat="server" ID="sdsCmp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsTyp"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsRes"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsCrm"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsViz"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  
</asp:Content>

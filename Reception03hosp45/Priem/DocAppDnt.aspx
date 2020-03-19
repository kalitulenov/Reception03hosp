<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrPusto.Master" AutoEventWireup="true" CodeBehind="DocAppDnt.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppDnt" %>

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
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
    <%-- ============================  JAVA ============================================ --%>
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
 //            alert("AmbCrdIdn=" + AmbCrdIdn);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocAppDntOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
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

         function OsmButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppDntOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LocButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppDntStt.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function PrsButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbPrs.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function NazButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbNaz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function UklButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUkl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function SttButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             //             mySpl.loadPage("BottomContent", "http://www.apt.pharmonweb.kz");
             mySpl.loadPage("BottomContent", "DocAppAmbLab.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LabButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbLab.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function DigButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbDigNoz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function UslButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             //            alert('AmbCrdIdn =' + AmbCrdIdn);
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

          function UziXryButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUziXry.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function StfButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbStf.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

          function ArxAmbButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonPrs').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDig').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonSpr').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = 'bold';

              mySpl.loadPage("BottomContent", "DocAppAmbArx.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }


         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
         function OK_click() {
             // Номер элемента
             var IndFix = document.getElementById('MainContent_parIndFix').value;
             // Номер строки
             var IndChk = document.getElementById('MainContent_parIndChk').value;

             $(".EmlDialog").dialog(
             {
                 autoOpen: true,
                 width: 500,
                 height: 300,
                 modal: true,
                 zIndex: 20000,
                 buttons:
                 {
                     "ОК": function () {
                         var bValid = Page_ClientValidate();
                         if (bValid) {
                             Eml_OK_click();
                             $(this).dialog("close");
                         }
                     },
                     "Отмена": function () {
                         document.getElementById('MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = '<div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl09" class="ob_gCc2">                                <input type="checkbox" onclick="updateSent01(this.checked,' + IndChk + ');">                            </div><div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11" class="ob_gCd">False</div>';
                         $(this).dialog("close");
                     }
                 }
             });
         }


         //    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;
 //            alert('AmbCrdIdn ='+AmbCrdIdn);

             if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtDnt&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtDnt&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
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

             //             var GrfDocRek='GRFCTRDAT';
             //           alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //           alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
     //                    alert("SqlStr=" + SqlStr);

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
                  <td width="10%" class="PO_RowCap">
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
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="29%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>                  <td width="8%" class="PO_RowCap">
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
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 430px;">

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
				    <Content>
                     <asp:Button ID="ButtonOsm" runat="server" Width="9%" CommandName="Push" Text="Прием и осмотр" OnClientClick="OsmButton_Click(); return false;"/>
                     <asp:Button ID="ButtonLoc" runat="server" Width="8%" CommandName="Push" Text="Статус" OnClientClick="LocButton_Click(); return false;"/>
                     <asp:Button ID="ButtonDig" runat="server" Width="7%" CommandName="Push" Text="Диагнозы" OnClientClick="DigButton_Click(); return false"/>
                     <asp:Button ID="ButtonUsl" runat="server" Width="5%" CommandName="Push" Text="Услуги" OnClientClick="UslButton_Click(); return false"/>
                     <asp:Button ID="ButtonPrs" runat="server" Width="9%" CommandName="Push" Text="Направления" OnClientClick="PrsButton_Click(); return false"/>
                     <asp:Button ID="ButtonNaz" runat="server" Width="9%" CommandName="Push" Text="Назначения" OnClientClick="NazButton_Click(); return false"/>
                     <asp:Button ID="ButtonUkl" runat="server" Width="9%" CommandName="Push" Text="В проц. кабинет" OnClientClick="UklButton_Click(); return false"/>
                     <asp:Button ID="ButtonLab" runat="server" Width="9%" CommandName="Push" Text="Лаборатория" OnClientClick="LabButton_Click(); return false"/>
                     <asp:Button ID="ButtonUzi" runat="server" Width="9%" CommandName="Push" Text="УЗИ,рентген" OnClientClick="UziXryButton_Click(); return false"/>
                     <asp:Button ID="ButtonSpr" runat="server" Width="9%" CommandName="Push" Text="Справки" OnClientClick="StfButton_Click(); return false"/>
                     <asp:Button ID="ButtonArxAmb" runat="server" Width="9%" CommandName="Push" Text="Архив приемов" OnClientClick="ArxAmbButton_Click(); return false"/>
				    </Content>
			    </TopPanel>
                <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
				    <Content>
					   

				    </Content>
			    </BottomPanel>
       </obspl:HorizontalSplitter>
  
            
        </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 20px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
                 <input type="button" value="Печать амб.карты" onclick="PrtButton_Click()" />
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
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
    
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

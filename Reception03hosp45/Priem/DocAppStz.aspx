<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DocAppStz.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppStz" %>

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
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             StzButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
 
         window.onload = function () {
  //           alert("AmbCrdIdn=" + AmbCrdIdn);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocAppStzOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
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

         function StzButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             /*
             alert("QueryString[0]=" + QueryString[0]);
             alert("QueryString[1]=" + QueryString[1]);
             alert("QueryString[2]=" + QueryString[2]);
             alert("QueryString[3]=" + QueryString[3]);
*/
 //            var property = document.getElementById("MainContent_mySpl_ctl00_ctl01_ButtonStz");
 //            property.style.backgroundColor = "#7FFF00";
 //            property.style.fontStyle.bold = true;
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonEpi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppStzOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function OsmButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LocButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
  //           alert("LocButton_Click=");

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbSttDop.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }


         function DryButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //           alert("LocButton_Click=");

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbDry.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function NazButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbNaz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCrdTyp=СТЦ");
         }

         function UklButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

 //            mySpl.loadPage("BottomContent", "DocAppAmbUkl.aspx?AmbCrdIdn=" + AmbCrdIdn);
             mySpl.loadPage("BottomContent", "DocAppLstNazDtl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=");
         }

         function SttButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             //             mySpl.loadPage("BottomContent", "http://www.apt.pharmonweb.kz");
             mySpl.loadPage("BottomContent", "DocAppAmbLab.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LabButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbLab.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function UslButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             //            alert('AmbCrdIdn =' + AmbCrdIdn);
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppStzUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

          function UziXryButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUziXry.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function ArxAmbButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = 'bold';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = '';

              mySpl.loadPage("BottomContent", "DocAppAmbArx.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function ArxPrzButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonStz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDry').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonNaz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUkl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLab').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUzi').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxPrz').style.fontWeight = 'bold';

              mySpl.loadPage("BottomContent", "DocAppAmbArxPrz.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
         function PrtAmbButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

         function PrtStzButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtStz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtStz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

         // -------------- ---------------------------------------------------
         //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
         function onChange(sender, newText) {
        //               alert("onChangeJlb=" + sender + " = " + newText);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocVal = newText;
             var DatDocTyp = 'Sql';
             var DatDocIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             var SqlStr = "";
             switch (sender) {
                 case 'MainContent_TextBoxNum':
                     //                   alert("TxtNap=" + sender.ID);
                     SqlStr = "UPDATE AMBCRD SET GRFNUM=" + DatDocVal + " WHERE GRFIDN=" + DatDocIdn;
                     break;
                 default:
                     break;
             }
          //                        alert("SqlStr=" + SqlStr);
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
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ Ист.болезни</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="22%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="18%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№страх.полиса</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox ID="TextBoxNum" Width="100%" Height="20" runat="server" BorderStyle="None" Style="position: relative; font-weight: 700; font-size: medium;" />
                 </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="22%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>                  
                   <td width="18%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>


              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="ИСТОРИЯ БОЛЕЗНИ СТАЦИОНАРНОГО ПАЦИЕНТА" 
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

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
				    <Content>
                     <asp:Button ID="ButtonUsl" runat="server" Width="8%" CommandName="Push" Text="Услуги" OnClientClick="UslButton_Click(); return false"/>
                     <asp:Button ID="ButtonStz" runat="server" Width="8%" CommandName="Push" Text="Мед.карта" OnClientClick="StzButton_Click(); return false;"/>
                     <asp:Button ID="ButtonOsm" runat="server" Width="9%" CommandName="Push" Text="Осмотр" OnClientClick="OsmButton_Click(); return false"/>
                     <asp:Button ID="ButtonLoc" runat="server" Width="9%" CommandName="Push" Text="Status presents" OnClientClick="LocButton_Click(); return false;"/>
                     <asp:Button ID="ButtonDry" runat="server" Width="8%" CommandName="Push" Text="Дневник" OnClientClick="DryButton_Click(); return false"/>
                     <asp:Button ID="ButtonNaz" runat="server" Width="8%" CommandName="Push" Text="Назначения" OnClientClick="NazButton_Click(); return false"/>
                     <asp:Button ID="ButtonUkl" runat="server" Width="9%" CommandName="Push" Text="В проц. кабинет" OnClientClick="UklButton_Click(); return false"/>
                     <asp:Button ID="ButtonLab" runat="server" Width="8%" CommandName="Push" Text="Лаборатория" OnClientClick="LabButton_Click(); return false"/>
                     <asp:Button ID="ButtonUzi" runat="server" Width="8%" CommandName="Push" Text="УЗИ,рентген" OnClientClick="UziXryButton_Click(); return false"/>
                     <asp:Button ID="ButtonArxAmb" runat="server" Width="9%" CommandName="Push" Text="Архив приемов" OnClientClick="ArxAmbButton_Click(); return false"/>
                     <asp:Button ID="ButtonArxPrz" runat="server" Width="9%" CommandName="Push" Text="Архив процедур" OnClientClick="ArxPrzButton_Click(); return false"/>
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
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
                 <input type="button" value="Печать мед.карты стац.больного" onclick="PrtStzButton_Click()" />
                 <input type="button" value="Печать приемного покоя" onclick="PrtAmbButton_Click()" />
            </center>

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
</asp:Content>

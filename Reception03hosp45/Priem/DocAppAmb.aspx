<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrPusto.Master" AutoEventWireup="true" CodeBehind="DocAppAmb.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppAmb" %>

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

         //$(document).ready ( function(){
         //    alert("ok");
         // //   OsmButton_Click();
         //});​
         

         //    ------------------ смена логотипа ----------------------------------------------------------
         window.onload = function () {
  //           alert("AmbCrdIdn=" + AmbCrdIdn);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var AmbPovObr = document.getElementById('MainContent_parPovObr').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = 'bold';

             //if (AmbPovObr == "4") mySpl.loadPage("BottomContent", "DocAppAmbOsmPrv.aspx?AmbCrdIdn=" + AmbCrdIdn);
             //else
                 mySpl.loadPage("BottomContent", "DocAppAmbOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
             var AmbPovObr = document.getElementById('MainContent_parPovObr').value;
             /*
             alert("QueryString[0]=" + QueryString[0]);
             alert("QueryString[1]=" + QueryString[1]);
             alert("QueryString[2]=" + QueryString[2]);
             alert("QueryString[3]=" + QueryString[3]);
*/
 //            var property = document.getElementById("MainContent_mySpl_ctl00_ctl01_ButtonOsm");
 //            property.style.backgroundColor = "#7FFF00";
 //            property.style.fontStyle.bold = true;
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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             if (AmbPovObr == "4") mySpl.loadPage("BottomContent", "DocAppAmbOsmPrv.aspx?AmbCrdIdn=" + AmbCrdIdn);
             else mySpl.loadPage("BottomContent", "DocAppAmbOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LocButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var AmbPovObr = document.getElementById('MainContent_parPovObr').value;

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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             if (document.getElementById('MainContent_Sapka').value == "Семейный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач общей практики" ||
                 document.getElementById('MainContent_Sapka').value == "ВОП" ||
                 document.getElementById('MainContent_Sapka').value == "Врач педиатр" ||
                 document.getElementById('MainContent_Sapka').value == "Дежурный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач терапевт")
                 if (AmbPovObr == "4") mySpl.loadPage("BottomContent", "DocAppAmbSttPrv.aspx?AmbCrdIdn=" + AmbCrdIdn);
                 else mySpl.loadPage("BottomContent", "DocAppAmbSttDop.aspx?AmbCrdIdn=" + AmbCrdIdn);
             else
                 if (document.getElementById('MainContent_Sapka').value == "Врач эндокринолог") mySpl.loadPage("BottomContent", "DocAppAmbSttDop.aspx?AmbCrdIdn=" + AmbCrdIdn);
                 else mySpl.loadPage("BottomContent", "DocAppAmbSttSpz.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             var BuxFrm = document.getElementById('MainContent_parBuxFrm').value;
             mySpl.loadPage("BottomContent", "DocAppAmbPrsGos.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
  //           document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             var BuxFrm = document.getElementById('MainContent_parBuxFrm').value;
          //   alert("BuxFrm =" + BuxFrm);
             if (BuxFrm == "12") mySpl.loadPage("BottomContent", "DocAppAmbNazGrd.aspx?AmbCrdIdn=" + AmbCrdIdn);
             else mySpl.loadPage("BottomContent", "DocAppAmbNaz.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
  //           document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
  //           document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbLab.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function UslButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

           //              alert('AmbCrdIdn =' + AmbCrdIdn);
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
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function DigButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             //            alert('AmbCrdIdn =' + AmbCrdIdn);
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
             // document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
 //            document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbDigNoz.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
//             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

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
//             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

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
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

              mySpl.loadPage("BottomContent", "DocAppAmbArx.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function DigUtcButton_Click() {
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
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = 'bold';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

              mySpl.loadPage("BottomContent", "DocAppAmbDig.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }


          function BolButton_Click() {
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
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = 'bold';
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

              mySpl.loadPage("BottomContent", "DocAppAmbBol.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function S95Button_Click() {
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
              //              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = 'bold';

              mySpl.loadPage("BottomContent", "DocAppAmb095.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }

          function DspButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
              var AmbCrdIIN = document.getElementById('MainContent_TextBoxIIN').value;

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
 //             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
 //             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = 'bold';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

     //         mySpl.loadPage("BottomContent", "DocAppAmbTlk.aspx?AmbCrdIdn=" + AmbCrdIdn);
              mySpl.loadPage("BottomContent", "DocAppAmbDsp.aspx?KltIIN=" + AmbCrdIIN);
      
          }

         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

          function ScrButton_Click() {
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
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = 'bold';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDigUtc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonBol').style.fontWeight = '';
//              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonDsp').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_Button095').style.fontWeight = '';

              mySpl.loadPage("BottomContent", "DocAppAmbScr.aspx?AmbCrdIdn=" + AmbCrdIdn);
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
             var AmbPovObr = document.getElementById('MainContent_parPovObr').value;


             var ua = navigator.userAgent;

             var BuxFrm = document.getElementById('MainContent_parBuxFrm').value;
        //     alert(BuxFrm);
             if (document.getElementById('MainContent_Sapka').value == "Семейный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач общей практики" ||
                 document.getElementById('MainContent_Sapka').value == "Врач педиатр" ||
                 document.getElementById('MainContent_Sapka').value == "Дежурный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач терапевт")
                 if (AmbPovObr == "4") window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPrv&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else 
                 if (BuxFrm == "1")
                     if (document.getElementById('MainContent_Sapka').value == "Врач эндокринолог")
                         window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtEnd&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                     else
                         window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtSpz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPed&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         }

         function PrtPthButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

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

         // --------------  ИЗМЕНИТЬ ВРЕМЯ ПРИЕМА ----------------------------
         function onTimeChange() {
            // alert("onTimeChange ");
           //  SET @BEG = CAST('01.01.2018 08:00' AS TIME) 
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var DatDocVal = "CAST('01.01.2020 " + document.getElementById("MainContent_TextBoxTim").value + ":00' AS TIME)";

                  //      alert("DatDocVal " + DatDocVal);

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
                //    alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFBEG=" + DatDocVal + " WHERE GRFIDN=" + AmbCrdIdn;
              //           alert("SqlStr=" + SqlStr);

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

         // --------------  ИЗМЕНИТЬ ТЕЛЕФОН ----------------------------
         function onChange(sender, newText) {
      //       alert("onChange=");
       //      alert("sender=" + sender + "  " + newText);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocVal = newText;
             var DatDocTyp = 'Sql';

             SqlStr = "UPDATE SPRKLT SET KLTTEL='" + DatDocVal + "' WHERE KLTIIN='" + document.getElementById('MainContent_TextBoxIIN').value + "'";

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

         function FindKlt() {
           //  alert("FindKlt");
             KltWindow.setTitle("Поиск клиентов");
             KltWindow.setUrl("/Referent/RefGlv003Klt.aspx");
             KltWindow.Open();
         }

         // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
         function KltClose(result) {
           //  alert("KofClose=1" + result);
             KltWindow.Close();

             document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите заменить ФИО ?";
             document.getElementById('myConfirmBeforeDeleteHidden').value = result;
             myConfirmBeforeDelete.Open(result);
     }


         function ConfirmBeforeDeleteOnClick() {
             var result = document.getElementById('myConfirmBeforeDeleteHidden').value;

             var hashes = result.split('&');
          //   alert("hashes=" + hashes);


             // document.getElementById('MainContent_HidCntIdn').value = hashes[0];
             document.getElementById('MainContent_TextBoxFio').value = hashes[1];
             document.getElementById('MainContent_TextBoxIIN').value = hashes[2];
             document.getElementById('MainContent_TextBoxBrt').value = hashes[3];
             document.getElementById('MainContent_TextBoxTel').value = hashes[4];
             // document.getElementById('MainContent_TextBoxKrt').value = hashes[5];
             //  document.getElementById('MainContent_DspFlg').value = hashes[6];
             document.getElementById('MainContent_TextBoxIns').value = hashes[7];
             // document.getElementById('MainContent_TextBoxEnd').value = hashes[8];
             document.getElementById('MainContent_TextBoxNum').value = hashes[9];
             if (hashes[9].length == 0) {
                 document.getElementById('MainContent_TextBoxNum').value = "0";
             }

             var DatDocMdb = 'HOSPBASE';
             var DatDocTyp = 'Sql';
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
           //  alert("AmbCrdIdn " + AmbCrdIdn);
             SqlStr = "UPDATE AMBCRD SET GRFNUM=" + document.getElementById('MainContent_TextBoxNum').value +
                 ",GRFIIN='" + document.getElementById('MainContent_TextBoxIIN').value +
                 "',GRFPTH=N'" + document.getElementById('MainContent_TextBoxFio').value +
                 "',GRFBRT=CONVERT(DATETIME,'" + document.getElementById('MainContent_TextBoxBrt').value + "',103)," +
                 "GRFSTX=(SELECT CNTKLTKEY FROM SprCntKlt WHERE CNTKLTIDN=" + hashes[0] + ") WHERE GRFIDN=" + AmbCrdIdn;

          //   alert("SqlStr =" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

             myConfirmBeforeDelete.Close();
         }


         // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
         function PrtKltTit() {
             //           alert('AmbCrdIdn= ' );
             var TekKltIin = document.getElementById('MainContent_TextBoxIIN').value;
             if (TekKltIin.length == 12) {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIin, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIin, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
             }
         }

         // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

         function HandleResult(result) {
            // alert("result of popup is: " + result);
            // var hashes = result.split('&');
             //         alert("hashes=" + hashes[0]);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //if (result == "Прививка") {
             //    mySpl.loadPage("BottomContent", "DocAppAmbOsmPrv.aspx?AmbCrdIdn=" + AmbCrdIdn);
             //}
             //if (result == "Заболевание") {
                 mySpl.loadPage("BottomContent", "DocAppAmbOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
             //}

         }

         function SetData_Click(rowIndex) {
             //         alert('GridKas_dbl=');
           //  document.getElementById('parPrsIdn').value = GridNap.Rows[rowIndex].Cells[0].Value;
             // document.getElementById('parPrsIdn').value = record.PRSIDN;

             //document.getElementById('MainContent_parCrdIdn').value = AmbCrdIdn000;
             //document.getElementById('MainContent_parDbl').value = "DBL";
             myDialogAPP.Open();
         }

     </script>

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parPovObr" runat="server" />
        <asp:HiddenField ID="Sapka" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:2%; position: relative; top: 0px; width: 96%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="13%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="30%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="14%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страх.</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Соц.</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дисп.</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Прикрепление</td>
              </tr>
              
               <tr>
                  <td width="13%" class="PO_RowCap">
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
<%--                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />--%>
                      <input type="time" id="TextBoxTim" name="appt" min="08:00" max="20:00" runat="server" style="width:100%; height:25px; background-color:#FFFFE0; font-size:15px;" onblur="onTimeChange()"   required>
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server"  BackColor="#FFFFE0" />
                  </td> 
                  <td width="30%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="75%" Height="20" RunAt="server" ReadOnly="true" Font-Size="Large" BackColor="#FFFFE0" />
                      <input type="button" value="ФИО" style="width:17%; height:30px;"  onclick="FindKlt()" />
                  </td>
                   <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="14%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                       <asp:TextBox id="TextBoxNum" BorderStyle="None" Width="0%" Height="20" RunAt="server" BackColor="#FFFFE0" Visible="false" />
                  </td>
                   <td width="5%" align="center" class="PO_RowCap">
                       <obout:OboutCheckBox runat="server" ID="StsFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                  </td> 
                  <td width="5%" align="center" class="PO_RowCap">
                      <obout:OboutCheckBox runat="server" ID="SozFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                  </td>
                  <td width="5%" align="center" class="PO_RowCap">
                      <obout:OboutCheckBox runat="server" ID="DspFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="0%" Height="20" RunAt="server" BackColor="#FFFFE0" Visible="false" />
                      <asp:TextBox id="TextBoxPrk" BorderStyle="None" Width="100%" Height="20" RunAt="server"  BackColor="#FFFFE0" />
                  </td>
              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ 
      
                          <obout:OboutTextBox runat="server" ID="TextBoxTel"  width="100%" BackColor="White" Height="20px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
      
 <asp:TextBox ID="Sapka" 
             Text="Семейный врач" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
--%>
        </asp:Panel>     
<%-- ============================  средний блок  ============================================ 
                     <asp:Button ID="ButtonTlk" runat="server" Width="6%" CommandName="Push" Text="Форум" OnClientClick="TlkButton_Click(); return false"/>
    --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="None" 
             Style="left: 2%; position: relative; top: -10px; width: 96%; height: 490px;">

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
				    <Content>
                     <asp:Button ID="ButtonOsm" runat="server" Width="6%" CommandName="Push" Text="Осмотр" OnClientClick="OsmButton_Click(); return false;"/>
                     <asp:Button ID="ButtonLoc" runat="server" Width="6%" CommandName="Push" Text="Статус" OnClientClick="LocButton_Click(); return false;"/>
                     <asp:Button ID="ButtonDig" runat="server" Width="7%" CommandName="Push" Text="Диагнозы" OnClientClick="DigButton_Click(); return false"/>
                     <asp:Button ID="ButtonUsl" runat="server" Width="5%" CommandName="Push" Text="Услуги" OnClientClick="UslButton_Click(); return false"/>
                     <asp:Button ID="ButtonPrs" runat="server" Width="8%" CommandName="Push" Text="Направления" OnClientClick="PrsButton_Click(); return false"/>
                     <asp:Button ID="ButtonNaz" runat="server" Width="7%" CommandName="Push" Text="Назначения" OnClientClick="NazButton_Click(); return false"/>
                     <asp:Button ID="ButtonUkl" runat="server" Width="7%" CommandName="Push" Text="В проц.каб." OnClientClick="UklButton_Click(); return false"/>
                     <asp:Button ID="ButtonBol" runat="server" Width="7%" CommandName="Push" Text="Бол.лист" OnClientClick="BolButton_Click(); return false"/>
                     <asp:Button ID="Button095" runat="server" Width="4%" CommandName="Push" Text="095/у" OnClientClick="S95Button_Click(); return false"/>
                     <asp:Button ID="ButtonSpr" runat="server" Width="6%" CommandName="Push" Text="Справки" OnClientClick="StfButton_Click(); return false"/>
                     <asp:Button ID="ButtonLab" runat="server" Width="9%" CommandName="Push" Text="Лаб.анал / Скан" OnClientClick="LabButton_Click(); return false"/>
                     <asp:Button ID="ButtonUzi" runat="server" Width="7%" CommandName="Push" Text="Функ.диагн." OnClientClick="UziXryButton_Click(); return false"/>
                     <asp:Button ID="ButtonDigUtc" runat="server" Width="8%" CommandName="Push" Text="Все диагнозы" OnClientClick="DigUtcButton_Click(); return false"/>
                     <asp:Button ID="ButtonScr" runat="server" Width="6%" CommandName="Push" Text="Скрининг" OnClientClick="ScrButton_Click(); return false"/>
<%--                     <asp:Button ID="ButtonDsp" runat="server" Width="8%" CommandName="Push" Text="Диспансеризация" OnClientClick="DspButton_Click(); return false"/>--%>
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
             Style="left: 2%; position: relative; top: -10px; width: 96%; height: 30px;">
             <center>
                 <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Пред.карта" onclick="TopButton_Click"/>
                 <input type="button" value="Печать амб.карты" onclick="PrtButton_Click()" />
                 <input type="button" value="Печать для пациента" onclick="PrtPthButton_Click()" />
                 <input type="button" value="Печать титульного листа" onclick="PrtKltTit()" />
                 <asp:Button ID="Button1" runat="server" CommandName="Cancel" Text="След.карта" onclick="BotButton_Click"/>
                 <input type="button" value="Отправить в АПП" onclick="SetData_Click()" />
            </center>

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  
                         <asp:Button ID="ButtonUpl" runat="server" Width="7%" CommandName="Push" Text="Загрузка обр." OnClientClick="UplButton_Click(); return false"/>
    ============================================ --%>
     
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

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogAPP" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="ПРИЕМ В ПС" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите отправить прием в ПС?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="SetData_Click" />
                              <input type="button" value="Отмена" onclick="myDialogAPP.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 


     <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================       --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
   
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

 <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;
         //         alert("DocAppAmbPsm");


         //    ------------------ смена логотипа ----------------------------------------------------------
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


         function onChange(sender, newText) {
      //       alert("onChange=" + sender + "   " + newText + "  " + newText.checked);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID) {
                 case 'Jlb003':
                     GrfDocRek = 'DOCJLB';
                     break;
                 case 'Anm003':
                     GrfDocRek = 'DOCANM'
                     break;
                 case 'AnmLif003':
                     GrfDocRek = 'DOCANMLIF'
                     break;
                 case 'Stt003':
                     GrfDocRek = 'DOCLOC';
                     break;
                 case 'Dig003':
                     GrfDocRek = 'DOCDIG';
                     break;
                 case 'Dsp003':
                     GrfDocRek = 'DOCDIGSOP';
                     break;
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 case 'Mkb001':
                     GrfDocRek = 'DOCMKB001';
                     break;
                 case 'Mkb002':
                     GrfDocRek = 'DOCMKB002';
                     break;
                 case 'Mkb003':
                     GrfDocRek = 'DOCMKB003';
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp,"AMBDOC","DOCAMB");
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeASP(sender, newText) {
        //     alert("onChangeASP=" + document.getElementById("NazIdn"+"002").value);
       //      alert("onChangeASP=" + sender + "   " + newText + "  " + newText.checked);
        //     alert("onChangeASP-Kol" + document.getElementById("TxtKol005").value);
        //     alert("onChangeASP-1" + document.getElementById("BoxUsl001").value);
        //     alert("onChangeASP-2" + document.getElementById("BoxUsl002").value);
         //    alert("onChangeASP-3" + document.getElementById("BoxUsl003").value);
         //    alert("onChangeASP-4" + document.getElementById("BoxUsl004").value);
         //    alert("onChangeASP-5" + document.getElementById("BoxUsl005").value);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Cmd';
             var GrfDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

        //     GrfDocRek = sender;
        //     if (sender.substring(0, 2) == "Chk") GrfDocVal = newText.checked;
        //     else GrfDocVal = newText;
           //  alert("BoxUsl1=" + sender.substring(0, 6));
           //  alert("BoxUsl2=" + sender.substring(6, 9));

             switch (sender.substring(0, 6)) {
                 case 'BoxUsl':       //  ----------------------------------------------------------------------------------------- УСЛУГА
                     GrfDocIdn = document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     if (GrfDocIdn == "") SqlStr = "INSERT INTO AMBUSL (USLAMB,USLKOD) VALUES(" + DatDocIdn + "," + newText + ")";
                     else SqlStr = "UPDATE AMBUSL SET USLKOD=" + newText + " WHERE USLIDN=" + document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtKol':
                     SqlStr = "UPDATE AMBUSL SET USLKOL=" + newText + " WHERE USLIDN=" + document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtSum':
                     SqlStr = "UPDATE AMBUSL SET USLSUM=" + newText + " WHERE USLIDN=" + document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'ChkRzp':     //        ------------------------------------------------------------------------------------------ НАЗНАЧЕНИЕ
                     if (newText.checked) SqlStr = "UPDATE AMBNAZ SET NAZBLN=1 WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     else SqlStr = "UPDATE AMBNAZ SET NAZBLN=0 WHERE NAZIDN=" + document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtNaz':
                     SqlStr = "UPDATE AMBNAZ SET NAZPLNOBS='" + newText + "' WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'BoxPrm':
                     SqlStr = "UPDATE AMBNAZ SET NAZPRMTAB=" + newText + " WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'BoxEdn':
                     SqlStr = "UPDATE AMBNAZ SET NAZEDNTAB=" + newText + " WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtLek':
                     SqlStr = "UPDATE AMBNAZ SET NAZKOLTAB=" + newText + " WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'BoxKrt':
                     SqlStr = "UPDATE AMBNAZ SET NAZKRTTAB=" + newText + " WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtDni':
                     SqlStr = "UPDATE AMBNAZ SET NAZDNI=" + newText + " WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'ChkPrz':
                     if (newText.checked) SqlStr = "UPDATE AMBNAZ SET NAZRZPFLG=1 WHERE NAZIDN=" + document.getElementById("NazIdn" + sender.substring(6, 9)).value;
                     else SqlStr = "UPDATE AMBNAZ SET NAZRZPFLG=0 WHERE NAZIDN=" + document.getElementById("UslIdn" + sender.substring(6, 9)).value;
                     break;
                 case 'TxtNap': //        ------------------------------------------------------------------------------------------ НАПРАВЛЕНИЯ
                     SqlStr = "UPDATE AMBPRS SET PRSOBSTXT='" + newText + "' WHERE PRSIDN=" + document.getElementById("PrsIdn" + sender.substring(6, 9)).value;
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, SqlStr, GrfDocTyp, "AMBDOC", "DOCAMB");
        }


         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeTxt(sender, newText) {
             //            alert("onChangeJlb=" + sender);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender) {
                 case 'Jlb003':
                     GrfDocRek = 'DOCJLB';
                     break;
                 case 'Anm003':
                     GrfDocRek = 'DOCANM'
                     break;
                 case 'AnmLif003':
                     GrfDocRek = 'DOCANMLIF'
                     break;
                 case 'Stt003':
                     GrfDocRek = 'DOCLOC';
                     break;
                 case 'Dig003':
                     GrfDocRek = 'DOCDIG';
                     break;
                 case 'Dsp003':
                     GrfDocRek = 'DOCDIGSOP';
                     break;
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 case 'Mkb001':
                     GrfDocRek = 'DOCMKB001';
                     break;
                 case 'Mkb002':
                     GrfDocRek = 'DOCMKB002';
                     break;
                 case 'Mkb003':
                     GrfDocRek = 'DOCMKB003';
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, "AMBDOC", "DOCAMB");
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
                 case 'BoxDocNoz':
                     GrfDocRek = 'DOCNOZ';
                     GrfDocVal = BoxDocNoz.options[BoxDocNoz.selectedIndex()].value;
                     //           alert('GrfDocVal: ' + GrfDocVal);
                     break;
                 case 'BoxDocPvd':
                     GrfDocRek = 'DOCOBRPVD'
                     GrfDocVal = BoxDocPvd.options[BoxDocPvd.selectedIndex()].value;
                     break;
                 case 'BoxDocNpr':
                     GrfDocRek = 'DOCOBRNPR';
                     GrfDocVal = BoxDocNpr.options[BoxDocNpr.selectedIndex()].value;
                     break;
                 case 'BoxDocVid':
                     GrfDocRek = 'DOCOBRVID';
                     GrfDocVal = BoxDocVid.options[BoxDocVid.selectedIndex()].value;
                     break;
                 case 'BoxDig001':
                     GrfDocRek = 'DOCMKBDG1';
                     GrfDocVal = BoxDig001.options[BoxDig001.selectedIndex()].value;
                     break;
                 case 'BoxDig002':
                     GrfDocRek = 'DOCMKBDG2';
                     GrfDocVal = BoxDig002.options[BoxDig002.selectedIndex()].value;
                     break;
                 case 'BoxDig003':
                     GrfDocRek = 'DOCMKBDG3';
                     GrfDocVal = BoxDig003.options[BoxDig003.selectedIndex()].value;
                     break;
                 case 'BoxDocResObr':
                     GrfDocRek = 'DOCRESOBR';
                     GrfDocVal = BoxDocResObr.options[BoxDocResObr.selectedIndex()].value;
                     break;
                 //              case 'Mkb001':
                 //                  GrfDocRek = 'DOCMKB001';
                 //                  GrfDocVal = Mkb001.options[Mkb001.selectedIndex()].value;
                 //                   GrfDocTyp = 'Txt';
                 //                   break;
                 //               case 'Mkb002':
                 //                  GrfDocRek = 'DOCMKB002';
                 //                  GrfDocVal = Mkb002.options[Mkb002.selectedIndex()].value;
                 //                  GrfDocTyp = 'Txt';
                 //                  break;
                 //               case 'Mkb001':
                 //                  GrfDocRek = 'DOCMKB003';
                 //                   GrfDocVal = Mkb003.options[Mkb003.selectedIndex()].value;
                 //                  GrfDocTyp = 'Txt';
                 //                   break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, "AMBDOC", "DOCAMB");

         }

         //    ------------------------------------------------------------------------------------------------------------------------
         function onCheckedChangedSMS(sender, isChecked) {
   //                alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocVal = isChecked;
             var DatDocTyp = 'Str';

             if (isChecked == true) {
                 if (parent.document.getElementById('ctl00$MainContent$TextBoxTel').value.length < 11) {
                     alert("Ошибка в номере телефона!");
                     ChkBoxSMS.checked(false);    // CheckBox  удалить галочку
                     DatDocVal == false;
                     return;
                 }
             }

             var QueryString = getQueryString();
             var DatDocIdn = QueryString[1];
             //              alert("DatDocIdn " + DatDocIdn);
             var DatDocDat = document.getElementById('txtDatCtr').value;
             //               alert("DatDocDat " + DatDocDat);

             if (DatDocVal == true) SqlStr = "HspAmbSmsChkRep&@GRFIDN&" + DatDocIdn + "&@GRFCTRDAT&" + DatDocDat + "&@GRFKRT&00&@GRFSMS&1";
             else SqlStr = "HspAmbSmsChkRep&@GRFIDN&" + DatDocIdn + "&@GRFCTRDAT&" + DatDocDat + "&@GRFKRT&00&@GRFSMS&0";

             //      alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { }
             });

         }


         //    ------------------------------------------------------------------------------------------------------------------------
         function onCheckedChangedPov(sender, isChecked) {
             //       alert("You've selected=" + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocTyp = 'Sql';
             var DatDocVal = isChecked;

             var QueryString = getQueryString();
             var DatDocIdn = QueryString[1];
             //                 alert("DatDocIdn " + DatDocIdn);
             SqlStr = "UPDATE AMBCRD SET GRFRSD='" + DatDocVal + "' WHERE GRFIDN=" + DatDocIdn;
             //                alert("SqlStr=" + SqlStr);

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

         //    ------------------------------------------------------------------------------------------------------------------------


         function onCheckedChanged(sender, isChecked) {
             //    alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
             //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
             //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
             //            alert('SelectedIndexChanged: ' + selectedIndex);
             //            alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal = isChecked;
             var GrfDocTyp = 'Bit';

             switch (sender.ID) {
                 case 'ChkBox001':
                     GrfDocRek = 'DOCRESNPR001';
                     break;
                 case 'ChkBox002':
                     GrfDocRek = 'DOCRESNPR002'
                     break;
                 case 'ChkBox003':
                     GrfDocRek = 'DOCRESNPR003';
                     break;
                 case 'ChkBox004':
                     GrfDocRek = 'DOCRESNPR004';
                     break;
                 case 'ChkBoxEnd':
                     GrfDocRek = 'DOCRESCPO';
                     break;
                 case 'ChkBoxSMS':
                     GrfDocRek = 'DOCCTRDATSMS';
                     break;
                 default:
                     break;

             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, "AMBDOC", "DOCAMB");

         }


         function onDateChange(sender, selectedDate) {
             //       alert("You've selected=" + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             //             var GrfDocRek='GRFCTRDAT';
             //             alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var QueryString = getQueryString();
             var DatDocIdn = QueryString[1];
             //           alert("DatDocIdn " + DatDocIdn);

             SqlStr = "UPDATE AMBCRD SET GRFCTRDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + DatDocIdn;
                              alert("SqlStr4=" + SqlStr);
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

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocTab, GrfDocKey) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = GrfDocTab; //'AMBDOC';
             var DatDocKey = GrfDocKey; //'DOCAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;
             var i;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

             for (i = 0; i < 7; i++) {DatDocVal = DatDocVal.replace("\\", "\u002F");}
             for (i = 0; i < 7; i++) {DatDocVal = DatDocVal.replace("\"", "\\u0022");}
             for (i = 0; i < 15; i++) { DatDocVal = DatDocVal.replace("\"", "\\u0022"); }


             //           alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
                 case 'Cmd':
                     DatDocTyp = 'Sql';
                     SqlStr = DatDocVal;
                     break;
                 default:
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
                      alert("SqlStr1=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });


             /*
             //   ----------------------------------- НОЗОЛОГИЮ ПОВТОРИТЬ В УСЛУГЕ
             if (DatDocKey == 'DOCNOZ') {
                 DatDocTyp = 'Sql';
                 SqlStr = "UPDATE AMBUSL SET USLNOZ=" + DatDocVal + " WHERE USLAMB=" + DatDocIdn;
                 //          alert("SqlStr=" + SqlStr);
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
             //   ----------------------------------- НОЗОЛОГИЮ ПОВТОРИТЬ В УСЛУГЕ
             */

         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnButton001Click() {
             parMkbNum.value = 1;
             //             MkbWindow.Open();
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=1",
                     "ModalPopUp", "toolbar=no,width=800,height=550,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=1",
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:550px;");

         }
         function OnButton002Click() {
             parMkbNum.value = 2;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=2",
                     "ModalPopUp", "toolbar=no,width=800,height=550,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=2",
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:550px;");
         }

         //    ------------------------------------------------------------------------------------------------------------------------
         function Speech(event) {
             var ParTxt = "Жалобы";
             window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

         function HandlePopupResult(result) {
             //           alert("result of popup is: " + result);
             var MasPar = result.split('@');

             //   ========================================================================= ГОЛОС
             if (MasPar[0] == 'GrfJlb') {
                 document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + MasPar[1] + '.';
                 onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
             }
             if (MasPar[0] == 'GrfAnm') {
                 document.getElementById('Anm003').value = document.getElementById('Anm003').value + MasPar[1] + '.';
                 onChangeTxt('Anm003', document.getElementById('Anm003').value);
             }
             if (MasPar[0] == 'GrfAnmLif') {
                 document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + MasPar[1] + '.';
                 onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
             }
             if (MasPar[0] == 'GrfStt') {
                 document.getElementById('Stt003').value = document.getElementById('Stt003').value + MasPar[1] + '.';
                 onChangeTxt('Stt003', document.getElementById('Stt003').value);
             }
             if (MasPar[0] == 'GrfDig') {
                 document.getElementById('Dig003').value = document.getElementById('Dig003').value + MasPar[1] + '.';
                 onChangeTxt('Dig003', document.getElementById('Dig003').value);
             }
             if (MasPar[0] == 'GrfDsp') {
                 document.getElementById('Dsp003').value = document.getElementById('Dsp003').value + MasPar[1] + '.';
                 onChangeTxt('Dsp003', document.getElementById('Dsp003').value);
             }
             if (MasPar[0] == 'GrfLch') {
                 document.getElementById('Lch003').value = document.getElementById('Lch003').value + MasPar[1] + '.';
                 onChangeTxt('Lch003', document.getElementById('Lch003').value);
             }

             //   ========================================================================= ШАБЛОНЫ
             if (MasPar[0] == 'Jlb002') {
                 document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + MasPar[1] + '.';
                 onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
             }
             if (MasPar[0] == 'Anm002') {
                 document.getElementById('Anm003').value = document.getElementById('Anm003').value + MasPar[1] + '.';
                 onChangeTxt('Anm003', document.getElementById('Anm003').value);
             }
             if (MasPar[0] == 'Stt002') {
                 document.getElementById('Stt003').value = document.getElementById('Stt003').value + MasPar[1] + '.';
                 onChangeTxt('Stt003', document.getElementById('Stt003').value);
             }
             if (MasPar[0] == 'Dig002') {
                 document.getElementById('Dig003').value = document.getElementById('Dig003').value + MasPar[1] + '.';
                 onChangeTxt('Dig003', document.getElementById('Dig003').value);
             }
             if (MasPar[0] == 'Dsp002') {
                 document.getElementById('Dsp003').value = document.getElementById('Dsp003').value + MasPar[1] + '.';
                 onChangeTxt('Dsp003', document.getElementById('Dsp003').value);
             }
             if (MasPar[0] == 'Lch002') {
                 document.getElementById('Lch003').value = document.getElementById('Lch003').value + MasPar[1] + '.';
                 onChangeTxt('Lch003', document.getElementById('Lch003').value);
             }
             if (MasPar[0] == 'GrfMkb') {
                 var QueryString = getQueryString();
                 var DatDocIdn = QueryString[1];

                 if (parMkbNum.value == 1) {
                     var ParStr = DatDocIdn + '@1@' + result + '@@@@';
                               alert("ParStr=" + ParStr);

                     $.ajax({
                         type: 'POST',
                         url: '/HspUpdDoc.aspx/DocAppAmbOsmMkb',
                         contentType: "application/json; charset=utf-8",
                         data: '{"ParStr":"' + ParStr + '"}',
                         dataType: "json",
                         success: function (msg) {
                             //              alert("msg=" + msg);
                             //     alert("msg.d=" + msg.d);
                             //    alert("msg.d=" + MasPar[0] + ' * ' + MasPar[1] + ' * ' + MasPar[2] + ' * ' + MasPar[3]);
                             //                                alert("msg.d2=" + msg.d.substring(0, 3));
                             //                                alert("msg.d3=" + msg.d.substring(3, 7));
                             //               Mkb001.options[Mkb001.selectedIndex()].value = MasPar[1];
                             //               Mkb002.options[Mkb002.selectedIndex()].value = MasPar[2];
                             //               Mkb003.options[Mkb003.selectedIndex()].value = MasPar[3];

                             document.getElementById('Dig003').value = document.getElementById('Dig003').value + msg.d + '.';
                             document.getElementById('Mkb001').value = MasPar[1];
                             document.getElementById('Mkb002').value = MasPar[2];
                             document.getElementById('Mkb003').value = MasPar[3];
                         },
                         error: function () { }
                     });
                 }
                 else {
                     var ParStr = DatDocIdn + '@2@' + result + '@@@@';
                               alert("ParStr3=" + ParStr);

                     $.ajax({
                         type: 'POST',
                         url: '/HspUpdDoc.aspx/DocAppAmbOsmMkb',
                         contentType: "application/json; charset=utf-8",
                         data: '{"ParStr":"' + ParStr + '"}',
                         dataType: "json",
                         success: function (msg) {
                             //       alert("msg=" + msg);
                             //        alert("msg.d=" + msg.d);
                             //                                alert("msg.d2=" + msg.d.substring(0, 3));
                             //                                alert("msg.d3=" + msg.d.substring(3, 7));
                             //   var hashes = msg.d.split(':');
                             document.getElementById('Dsp003').value = document.getElementById('Dsp003').value + msg.d + '.';
                             document.getElementById('MkbSop001').value = MasPar[1];
                             document.getElementById('MkbSop002').value = MasPar[2];
                             document.getElementById('MkbSop003').value = MasPar[3];
                         },
                         error: function () { }
                     });
                 }
             }
         }
         // --------------------- клише на анамнез жизни 
         function SablonLif() {
             document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + 'Аллергии нет. Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
             onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
         }
         function SablonJlb() {
             //       alert('SablonJlb_1');
             //    ob_post.ResetParams();
             //     parSblNum.value = "Jlb";
             SablonWin("Jlb");
         }
         function SablonAnm() {
             SablonWin("Anm");
         }
         function SablonSts() {
             SablonWin("Stt");
         }
         function SablonDig() {
             SablonWin("Dig");
         }
         function SablonDsp() {
             SablonWin("Dsp");
         }
         function SablonLch() {
             SablonWin("Lch");
         }

         function SablonWin(SblTyp) {
             //      alert('SblTyp=' + SblTyp);
             window.open("DocAppSblFlg.aspx?SblTyp=" + SblTyp + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=1000,height=600,left=200,top=100,location=no,modal=yes,status=no,scrollbars=no,resize=no");
         }


         function NapButton_Click() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             RabWindow.setTitle("НАПРАВЛЕНИЯ");
             RabWindow.setUrl("DocAppAmbPrsGos.aspx?AmbCrdIdn=" + AmbCrdIdn);
             RabWindow.Open();
         }

         function NazButton_Click() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;

             RabWindow.setTitle("НАЗНАЧЕНИЯ");
             RabWindow.setUrl("DocAppAmbNaz.aspx?AmbCrdIdn=" + AmbCrdIdn);
             RabWindow.Open();
         }

         function UslButton_Click() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;

             RabWindow.setTitle("УСЛУГИ");
             RabWindow.setUrl("DocAppAmbUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
             RabWindow.Open();
         }

         function SablonPrs() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             //    alert('AmbCrdIdn=' + AmbCrdIdn);
             window.open("DocAppSblNap.aspx?AmbCrdIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
         }


         function SablonNaz() {
             //      alert('SblTyp=' + SblTyp);
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             window.open("DocAppSblNaz.aspx?AmbCrdIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
         }

         function HandlePopupPost(result) {
      //       alert("result of popup is: " + result);
             window.parent.ButtonClick();
//                  document.getElementById("MainContent_mySpl_ctl00_ctl01_ButtonOsm").click();

         }

         function ExitFun() {
     //        alert("rExitFun ");
             window.parent.ButtonClick();
         }

         //    ---------------- обращение веб методу --------------------------------------------------------
         function SablonXls() {
     //                alert("SablonXls=");
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             var DocStsXls = document.getElementById('parStsImg').value;

             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1) window.open("DocAppSblSttAspose.aspx?AmbCrdIdn=" + AmbCrdIdn + "&DocStsXls=" + DocStsXls, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else window.showModalDialog("DocAppSblSttAspose.aspx?AmbCrdIdn=" + AmbCrdIdn + "&DocStsXls=" + DocStsXls, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");

             return false;
         }

         function HandlePopupStatus(result) {
   //          alert(result);
             document.getElementById('Stt003').value = result;
             onChangeTxt('Stt003', document.getElementById('Stt003').value);
         }

         </script>

</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string BuxKod;
      string AmbCrdIdn = "";
      string whereClause = "";

      string MdbNam = "HOSPBASE";
      //=============Установки===========================================================================================
      protected void Page_Load(object sender, EventArgs e)
      {
          //=====================================================================================
          BuxSid = (string)Session["BuxSid"];
          BuxFrm = (string)Session["BuxFrmKod"];
          BuxKod = (string)Session["BuxKod"];
          parBuxKod.Value = BuxKod;
          //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
          AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          parCrdIdn.Value = AmbCrdIdn;

          //        ------------------------------------------------------------------------------------------ УСЛУГА
          //       BoxUsl001.Attributes.Add("onchange", "onChangeASP('BoxUsl001',BoxUsl001.value);");
          //      BoxUsl002.Attributes.Add("onchange", "onChangeASP('BoxUsl002',BoxUsl002.value);");
          //      BoxUsl003.Attributes.Add("onchange", "onChangeASP('BoxUsl003',BoxUsl003.value);");
          //      BoxUsl004.Attributes.Add("onchange", "onChangeASP('BoxUsl004',BoxUsl004.value);");
          //      BoxUsl005.Attributes.Add("onchange", "onChangeASP('BoxUsl005',BoxUsl005.value);");

          TxtKol001.Attributes.Add("onchange", "onChangeASP('TxtKol001',TxtKol001.value);");
          TxtKol002.Attributes.Add("onchange", "onChangeASP('TxtKol002',TxtKol002.value);");
          TxtKol003.Attributes.Add("onchange", "onChangeASP('TxtKol003',TxtKol003.value);");
          TxtKol004.Attributes.Add("onchange", "onChangeASP('TxtKol004',TxtKol004.value);");
          TxtKol005.Attributes.Add("onchange", "onChangeASP('TxtKol005',TxtKol005.value);");

          TxtSum001.Attributes.Add("onchange", "onChangeASP('TxtSum001',TxtSum001.value);");
          TxtSum002.Attributes.Add("onchange", "onChangeASP('TxtSum002',TxtSum002.value);");
          TxtSum003.Attributes.Add("onchange", "onChangeASP('TxtSum003',TxtSum003.value);");
          TxtSum004.Attributes.Add("onchange", "onChangeASP('TxtSum004',TxtSum004.value);");
          TxtSum005.Attributes.Add("onchange", "onChangeASP('TxtSum005',TxtSum005.value);");

          //        ------------------------------------------------------------------------------------------ НАЗНАЧЕНИЕ
          ChkRzp001.Attributes.Add("onclick", "onChangeASP('ChkRzp001',this);");
          ChkRzp002.Attributes.Add("onclick", "onChangeASP('ChkRzp002',this);");
          ChkRzp003.Attributes.Add("onclick", "onChangeASP('ChkRzp003',this);");
          ChkRzp004.Attributes.Add("onclick", "onChangeASP('ChkRzp004',this);");
          ChkRzp005.Attributes.Add("onclick", "onChangeASP('ChkRzp005',this);");

          //    TxtNaz001.Attributes.Add("onchange", "onChangeASP('TxtNaz001',TxtNaz001.value);");
          //    TxtNaz002.Attributes.Add("onchange", "onChangeASP('TxtNaz002',TxtNaz002.value);");
          //    TxtNaz003.Attributes.Add("onchange", "onChangeASP('TxtNaz003',TxtNaz003.value);");
          //    TxtNaz004.Attributes.Add("onchange", "onChangeASP('TxtNaz004',TxtNaz004.value);");
          //    TxtNaz005.Attributes.Add("onchange", "onChangeASP('TxtNaz005',TxtNaz005.value);");

          BoxPrm001.Attributes.Add("onchange", "onChangeASP('BoxPrm001',BoxPrm001.value);");
          BoxPrm002.Attributes.Add("onchange", "onChangeASP('BoxPrm002',BoxPrm002.value);");
          BoxPrm003.Attributes.Add("onchange", "onChangeASP('BoxPrm003',BoxPrm003.value);");
          BoxPrm004.Attributes.Add("onchange", "onChangeASP('BoxPrm004',BoxPrm004.value);");
          BoxPrm005.Attributes.Add("onchange", "onChangeASP('BoxPrm005',BoxPrm005.value);");

          BoxEdn001.Attributes.Add("onchange", "onChangeASP('BoxEdn001',BoxEdn001.value);");
          BoxEdn002.Attributes.Add("onchange", "onChangeASP('BoxEdn002',BoxEdn002.value);");
          BoxEdn003.Attributes.Add("onchange", "onChangeASP('BoxEdn003',BoxEdn003.value);");
          BoxEdn004.Attributes.Add("onchange", "onChangeASP('BoxEdn004',BoxEdn004.value);");
          BoxEdn005.Attributes.Add("onchange", "onChangeASP('BoxEdn005',BoxEdn005.value);");

          TxtLek001.Attributes.Add("onchange", "onChangeASP('TxtLek001',TxtLek001.value);");
          TxtLek002.Attributes.Add("onchange", "onChangeASP('TxtLek002',TxtLek002.value);");
          TxtLek003.Attributes.Add("onchange", "onChangeASP('TxtLek003',TxtLek003.value);");
          TxtLek004.Attributes.Add("onchange", "onChangeASP('TxtLek004',TxtLek004.value);");
          TxtLek005.Attributes.Add("onchange", "onChangeASP('TxtLek005',TxtLek005.value);");

          BoxKrt001.Attributes.Add("onchange", "onChangeASP('BoxKrt001',BoxKrt001.value);");
          BoxKrt002.Attributes.Add("onchange", "onChangeASP('BoxKrt002',BoxKrt002.value);");
          BoxKrt003.Attributes.Add("onchange", "onChangeASP('BoxKrt003',BoxKrt003.value);");
          BoxKrt004.Attributes.Add("onchange", "onChangeASP('BoxKrt004',BoxKrt004.value);");
          BoxKrt005.Attributes.Add("onchange", "onChangeASP('BoxKrt005',BoxKrt005.value);");

          TxtDni001.Attributes.Add("onchange", "onChangeASP('TxtDni001',TxtDni001.value);");
          TxtDni002.Attributes.Add("onchange", "onChangeASP('TxtDni002',TxtDni002.value);");
          TxtDni003.Attributes.Add("onchange", "onChangeASP('TxtDni003',TxtDni003.value);");
          TxtDni004.Attributes.Add("onchange", "onChangeASP('TxtDni004',TxtDni004.value);");
          TxtDni005.Attributes.Add("onchange", "onChangeASP('TxtDni005',TxtDni005.value);");

          ChkPrz001.Attributes.Add("onclick", "onChangeASP('ChkPrz001',this);");
          ChkPrz002.Attributes.Add("onclick", "onChangeASP('ChkPrz002',this);");
          ChkPrz003.Attributes.Add("onclick", "onChangeASP('ChkPrz003',this);");
          ChkPrz004.Attributes.Add("onclick", "onChangeASP('ChkPrz004',this);");
          ChkPrz005.Attributes.Add("onclick", "onChangeASP('ChkPrz005',this);");

          //        ------------------------------------------------------------------------------------------ НАПРАВЛЕНИЯ
          //    TxtNap001.Attributes.Add("onchange", "onChangeASP('TxtNap001',TxtNap001.value);");
          //    TxtNap002.Attributes.Add("onchange", "onChangeASP('TxtNap002',TxtNap002.value);");
          //    TxtNap003.Attributes.Add("onchange", "onChangeASP('TxtNap003',TxtNap003.value);");
          //    TxtNap004.Attributes.Add("onchange", "onChangeASP('TxtNap004',TxtNap004.value);");
          //   TxtNap005.Attributes.Add("onchange", "onChangeASP('TxtNap005',TxtNap005.value);");


          if (!Page.IsPostBack)
          {

              //=====================================================================================
              sdsPrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //             sdsPrm.SelectCommand = "SELECT PrmKod,PrmNam FROM SprNazPrm ORDER By PrmNam";
              sdsKrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //             sdsKrt.SelectCommand = "SELECT KrtKod,KrtNam FROM SprNazKrt";
              sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //             sdsEdn.SelectCommand = "SELECT EdnLekKod,EdnLekNam FROM SprEdnLek";
              sdsMkb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              sdsMkb.SelectCommand = "SELECT TOP 100 * FROM MKB10 ORDER BY MkbNam";
              sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //=====================================================================================

              Session.Add("KLTIDN", (string)"");
              Session.Add("WHERE", (string)"");

              getDocNum();
              getDocUsl();
              getDocNaz();
              getDocNap();
          }
          //               filComboBox();

      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNum()
      {
          string TekDat;
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbDocIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbDocIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              //     obout:OboutTextBox ------------------------------------------------------------------------------------      
              Jlb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCJLB"]);
              Anm003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANM"]);
              AnmLif003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANMLIF"]);
              Stt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCLOC"]);
              Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
              //       Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
              Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
              //       Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
              //       Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);
              //       MkbSop001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP001"]);
              //       MkbSop002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP002"]);
              //       MkbSop003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP003"]);

              TekDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFCTRDAT"]);

              if (string.IsNullOrEmpty(TekDat)) txtDatCtr.Text = null;
              else txtDatCtr.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFCTRDAT"]).ToString("dd.MM.yyyy");

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFCTRDATSMS"].ToString())) ChkBoxSMS.Checked = false;
              else ChkBoxSMS.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["GRFCTRDATSMS"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFRSD"].ToString())) ChkBoxPov.Checked = false;
              else ChkBoxPov.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["GRFRSD"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              //       if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCNOZ"].ToString())) BoxDocNoz.SelectedValue = "0";
              //       else BoxDocNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCNOZ"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRPVD"].ToString())) BoxDocPvd.SelectedIndex = 0;
              else BoxDocPvd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRPVD"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRNPR"].ToString())) BoxDocNpr.SelectedIndex = 0;
              else BoxDocNpr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRNPR"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRVID"].ToString())) BoxDocVid.SelectedIndex = 0;
              else BoxDocVid.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRVID"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESOBR"].ToString())) BoxDocResObr.SelectedIndex = 0;
              else BoxDocResObr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCRESOBR"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR001"].ToString())) ChkBox001.Checked = false;
              else ChkBox001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR001"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR002"].ToString())) ChkBox002.Checked = false;
              else ChkBox002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR002"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR003"].ToString())) ChkBox003.Checked = false;
              else ChkBox003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR003"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR004"].ToString())) ChkBox004.Checked = false;
              else ChkBox004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR004"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESCPO"].ToString())) ChkBoxEnd.Checked = false;
              else ChkBoxEnd.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESCPO"]);

              parCrdStx.Value = Convert.ToString(ds.Tables[0].Rows[0]["GRFSTX"]).Substring(0,5);
              parStsImg.Value = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSXLS"]);
          }

          //          string name = value ?? string.Empty;
      }



      // ============================ чтение заголовка таблицы а оп ==============================================
      public void getDocUsl()
      {
          int KolUsl;

          UslIdn001.Value = "";
          UslIdn002.Value = "";
          UslIdn003.Value = "";
          UslIdn004.Value = "";
          UslIdn005.Value = "";

          TxtKol001.Text = "";
          TxtKol002.Text = "";
          TxtKol003.Text = "";
          TxtKol004.Text = "";
          TxtKol005.Text = "";

          TxtSum001.Text = "";
          TxtSum002.Text = "";
          TxtSum003.Text = "";
          TxtSum004.Text = "";
          TxtSum005.Text = "";

          //====================================================================================================================
          DataSet dsUsl = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmdUsl = new SqlCommand("HspAmbUslKodSou", con);
          // указать тип команды
          cmdUsl.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmdUsl.Parameters.Add("@BUXFRMKOD", SqlDbType.VarChar).Value = BuxFrm;
          cmdUsl.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
          cmdUsl.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = parCrdStx.Value;
          cmdUsl.Parameters.Add("@AMBCRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          cmdUsl.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = "0";

          // создание DataAdapter
          SqlDataAdapter daUsl = new SqlDataAdapter(cmdUsl);
          // заполняем DataSet из хран.процедуры.
          daUsl.Fill(dsUsl, "HspAmbUslKodSou");

          BoxUsl001.Items.Clear();
          BoxUsl001.Items.Insert(0, new ListItem("", ""));
          BoxUsl001.DataSource = dsUsl;
          BoxUsl001.DataBind();

          BoxUsl002.Items.Clear();
          BoxUsl002.Items.Insert(0, new ListItem("", ""));
          BoxUsl002.DataSource = dsUsl;
          BoxUsl002.DataBind();

          BoxUsl003.Items.Clear();
          BoxUsl003.Items.Insert(0, new ListItem("", ""));
          BoxUsl003.DataSource = dsUsl;
          BoxUsl003.DataBind();

          BoxUsl004.Items.Clear();
          BoxUsl004.Items.Insert(0, new ListItem("", ""));
          BoxUsl004.DataSource = dsUsl;
          BoxUsl004.DataBind();

          BoxUsl005.Items.Clear();
          BoxUsl005.Items.Insert(0, new ListItem("", ""));
          BoxUsl005.DataSource = dsUsl;
          BoxUsl005.DataBind();

          //        con.Close();

          //====================================================================================================================

          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          //   string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          //   SqlConnection con = new SqlConnection(connectionString);
          //        con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbUslIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbUslIdn");

          con.Close();

          KolUsl = ds.Tables[0].Rows.Count;  // запись об предмете найден

          if (KolUsl > 0)
          {
              UslIdn001.Value = Convert.ToString(ds.Tables[0].Rows[0]["USLIDN"]);
              BoxUsl001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);
              TxtKol001.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLKOL"]);
              TxtSum001.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLSUM"]);
          }
          if (KolUsl > 1)
          {
              UslIdn002.Value = Convert.ToString(ds.Tables[0].Rows[1]["USLIDN"]);
              BoxUsl002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[1]["USLKOD"]);
              TxtKol002.Text = Convert.ToString(ds.Tables[0].Rows[1]["USLKOL"]);
              TxtSum002.Text = Convert.ToString(ds.Tables[0].Rows[1]["USLSUM"]);
          }
          if (KolUsl > 2)
          {
              UslIdn003.Value = Convert.ToString(ds.Tables[0].Rows[2]["USLIDN"]);
              BoxUsl003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[2]["USLKOD"]);
              TxtKol003.Text = Convert.ToString(ds.Tables[0].Rows[2]["USLKOL"]);
              TxtSum003.Text = Convert.ToString(ds.Tables[0].Rows[2]["USLSUM"]);
          }
          if (KolUsl > 3)
          {
              UslIdn004.Value = Convert.ToString(ds.Tables[0].Rows[3]["USLIDN"]);
              BoxUsl004.SelectedValue = Convert.ToString(ds.Tables[0].Rows[3]["USLKOD"]);
              TxtKol004.Text = Convert.ToString(ds.Tables[0].Rows[3]["USLKOL"]);
              TxtSum004.Text = Convert.ToString(ds.Tables[0].Rows[3]["USLSUM"]);
          }
          if (KolUsl > 4)
          {
              UslIdn005.Value = Convert.ToString(ds.Tables[0].Rows[4]["USLIDN"]);
              BoxUsl005.SelectedValue = Convert.ToString(ds.Tables[0].Rows[4]["USLKOD"]);
              TxtKol005.Text = Convert.ToString(ds.Tables[0].Rows[4]["USLKOL"]);
              TxtSum005.Text = Convert.ToString(ds.Tables[0].Rows[4]["USLSUM"]);
          }

      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNaz()
      {
          int KolNaz;

          //====================================================================================================================
          NazIdn001.Value = "";
          NazIdn002.Value = "";
          NazIdn003.Value = "";
          NazIdn004.Value = "";
          NazIdn005.Value = "";

          TxtNaz001.Text = "";
          TxtNaz002.Text = "";
          TxtNaz003.Text = "";
          TxtNaz004.Text = "";
          TxtNaz005.Text = "";

          TxtLek001.Text = "";
          TxtLek002.Text = "";
          TxtLek003.Text = "";
          TxtLek004.Text = "";
          TxtLek005.Text = "";

          TxtDni001.Text = "";
          TxtDni002.Text = "";
          TxtDni003.Text = "";
          TxtDni004.Text = "";
          TxtDni005.Text = "";

          ChkRzp001.Checked = false;
          ChkRzp002.Checked = false;
          ChkRzp003.Checked = false;
          ChkRzp004.Checked = false;
          ChkRzp005.Checked = false;

          ChkPrz001.Checked = false;
          ChkPrz002.Checked = false;
          ChkPrz003.Checked = false;
          ChkPrz004.Checked = false;
          ChkPrz005.Checked = false;

          //        ====================================================================================================
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          DataSet dsEdn = new DataSet();
          SqlCommand cmdEdn = new SqlCommand("SELECT EDNLEKKOD,EDNLEKNAM FROM SPREDNLEK ORDER BY EDNLEKNAM", con);
          // указать тип команды
          //   cmd.CommandType = CommandType.StoredProcedure;

          // создание DataAdapter
          SqlDataAdapter daEdn = new SqlDataAdapter(cmdEdn);
          // заполняем DataSet из хран.процедуры.
          daEdn.Fill(dsEdn, "SprEdnLek");

          BoxEdn001.Items.Clear();
          BoxEdn001.Items.Insert(0, new ListItem("", ""));
          BoxEdn001.DataSource = dsEdn;
          BoxEdn001.DataBind();

          BoxEdn002.Items.Clear();
          BoxEdn002.Items.Insert(0, new ListItem("", ""));
          BoxEdn002.DataSource = dsEdn;
          BoxEdn002.DataBind();

          BoxEdn003.Items.Clear();
          BoxEdn003.Items.Insert(0, new ListItem("", ""));
          BoxEdn003.DataSource = dsEdn;
          BoxEdn003.DataBind();

          BoxEdn004.Items.Clear();
          BoxEdn004.Items.Insert(0, new ListItem("", ""));
          BoxEdn004.DataSource = dsEdn;
          BoxEdn004.DataBind();

          BoxEdn005.Items.Clear();
          BoxEdn005.Items.Insert(0, new ListItem("", ""));
          BoxEdn005.DataSource = dsEdn;
          BoxEdn005.DataBind();

          //        ====================================================================================================
          //      string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          //      SqlConnection con = new SqlConnection(connectionString);
          //      con.Open();
          DataSet dsKrt = new DataSet();
          SqlCommand cmdKrt = new SqlCommand("SELECT KRTKOD,KRTNAM FROM SPRNAZKRT ORDER BY KRTNAM", con);
          // указать тип команды
          //   cmd.CommandType = CommandType.StoredProcedure;

          // создание DataAdapter
          SqlDataAdapter daKrt = new SqlDataAdapter(cmdKrt);
          // заполняем DataSet из хран.процедуры.
          daKrt.Fill(dsKrt, "SprNazKrt");

          BoxKrt001.Items.Clear();
          BoxKrt001.Items.Insert(0, new ListItem("", ""));
          BoxKrt001.DataSource = dsKrt;
          BoxKrt001.DataBind();

          BoxKrt002.Items.Clear();
          BoxKrt002.Items.Insert(0, new ListItem("", ""));
          BoxKrt002.DataSource = dsKrt;
          BoxKrt002.DataBind();

          BoxKrt003.Items.Clear();
          BoxKrt003.Items.Insert(0, new ListItem("", ""));
          BoxKrt003.DataSource = dsKrt;
          BoxKrt003.DataBind();

          BoxKrt004.Items.Clear();
          BoxKrt004.Items.Insert(0, new ListItem("", ""));
          BoxKrt004.DataSource = dsKrt;
          BoxKrt004.DataBind();

          BoxKrt005.Items.Clear();
          BoxKrt005.Items.Insert(0, new ListItem("", ""));
          BoxKrt005.DataSource = dsKrt;
          BoxKrt005.DataBind();

          //        ====================================================================================================
          //      string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          //      SqlConnection con = new SqlConnection(connectionString);
          //      con.Open();
          DataSet dsPrm = new DataSet();
          SqlCommand cmdPrm = new SqlCommand("SELECT PRMKOD,PRMNAM FROM SPRNAZPRM ORDER BY PRMNAM", con);
          // указать тип команды
          //   cmd.CommandType = CommandType.StoredProcedure;

          // создание DataAdapter
          SqlDataAdapter daPrm = new SqlDataAdapter(cmdPrm);
          // заполняем DataSet из хран.процедуры.
          daPrm.Fill(dsPrm, "SprNazPrm");

          BoxPrm001.Items.Clear();
          BoxPrm001.Items.Insert(0, new ListItem("", ""));
          BoxPrm001.DataSource = dsPrm;
          BoxPrm001.DataBind();

          BoxPrm002.Items.Clear();
          BoxPrm002.Items.Insert(0, new ListItem("", ""));
          BoxPrm002.DataSource = dsPrm;
          BoxPrm002.DataBind();

          BoxPrm003.Items.Clear();
          BoxPrm003.Items.Insert(0, new ListItem("", ""));
          BoxPrm003.DataSource = dsPrm;
          BoxPrm003.DataBind();

          BoxPrm004.Items.Clear();
          BoxPrm004.Items.Insert(0, new ListItem("", ""));
          BoxPrm004.DataSource = dsPrm;
          BoxPrm004.DataBind();

          BoxPrm005.Items.Clear();
          BoxPrm005.Items.Insert(0, new ListItem("", ""));
          BoxPrm005.DataSource = dsPrm;
          BoxPrm005.DataBind();

          //====================================================================================================================
          //   string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          //   SqlConnection con = new SqlConnection(connectionString);
          //   con.Open();
          DataSet ds = new DataSet();
          SqlCommand cmdNaz = new SqlCommand("HspAmbNazIdn", con);
          // указать тип команды
          cmdNaz.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmdNaz.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter daNaz = new SqlDataAdapter(cmdNaz);
          // заполняем DataSet из хран.процедуры.
          daNaz.Fill(ds, "HspAmbNazIdn");

          con.Close();

          KolNaz = ds.Tables[0].Rows.Count;  // запись об предмете найден

          if (KolNaz > 0)
          {
              NazIdn001.Value = Convert.ToString(ds.Tables[0].Rows[0]["NAZIDN"]);
              ChkRzp001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["NAZREZ"]);
              TxtNaz001.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZPLNOBS"]);
              BoxPrm001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZPRMTAB"]);
              BoxEdn001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZEDNTAB"]);
              TxtLek001.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZKOLTAB"]);
              BoxKrt001.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZKRTTAB"]);
              TxtDni001.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZDNI"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["NAZRZPFLG"].ToString())) ChkPrz001.Checked = false;
              else ChkPrz001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["NAZRZPFLG"]);
          }
          if (KolNaz > 1)
          {
              NazIdn002.Value = Convert.ToString(ds.Tables[0].Rows[1]["NAZIDN"]);
              ChkRzp002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[1]["NAZREZ"]);
              TxtNaz002.Text = Convert.ToString(ds.Tables[0].Rows[1]["NAZPLNOBS"]);
              BoxPrm002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[1]["NAZPRMTAB"]);
              BoxEdn002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[1]["NAZEDNTAB"]);
              TxtLek002.Text = Convert.ToString(ds.Tables[0].Rows[1]["NAZKOLTAB"]);
              BoxKrt002.SelectedValue = Convert.ToString(ds.Tables[0].Rows[1]["NAZKRTTAB"]);
              TxtDni002.Text = Convert.ToString(ds.Tables[0].Rows[1]["NAZDNI"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[1]["NAZRZPFLG"].ToString())) ChkPrz002.Checked = false;
              else ChkPrz002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[1]["NAZRZPFLG"]);
          }
          if (KolNaz > 2)
          {
              NazIdn003.Value = Convert.ToString(ds.Tables[0].Rows[2]["NAZIDN"]);
              ChkRzp003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[2]["NAZREZ"]);
              TxtNaz003.Text = Convert.ToString(ds.Tables[0].Rows[2]["NAZPLNOBS"]);
              BoxPrm003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[2]["NAZPRMTAB"]);
              BoxEdn003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[2]["NAZEDNTAB"]);
              TxtLek003.Text = Convert.ToString(ds.Tables[0].Rows[2]["NAZKOLTAB"]);
              BoxKrt003.SelectedValue = Convert.ToString(ds.Tables[0].Rows[2]["NAZKRTTAB"]);
              TxtDni003.Text = Convert.ToString(ds.Tables[0].Rows[2]["NAZDNI"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[2]["NAZRZPFLG"].ToString())) ChkPrz003.Checked = false;
              else ChkPrz003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[2]["NAZRZPFLG"]);
          }
          if (KolNaz > 3)
          {
              NazIdn004.Value = Convert.ToString(ds.Tables[0].Rows[3]["NAZIDN"]);
              ChkRzp004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[3]["NAZREZ"]);
              TxtNaz004.Text = Convert.ToString(ds.Tables[0].Rows[3]["NAZPLNOBS"]);
              BoxPrm004.SelectedValue = Convert.ToString(ds.Tables[0].Rows[3]["NAZPRMTAB"]);
              BoxEdn004.SelectedValue = Convert.ToString(ds.Tables[0].Rows[3]["NAZEDNTAB"]);
              TxtLek004.Text = Convert.ToString(ds.Tables[0].Rows[3]["NAZKOLTAB"]);
              BoxKrt004.SelectedValue = Convert.ToString(ds.Tables[0].Rows[3]["NAZKRTTAB"]);
              TxtDni004.Text = Convert.ToString(ds.Tables[0].Rows[3]["NAZDNI"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[3]["NAZRZPFLG"].ToString())) ChkPrz004.Checked = false;
              else ChkPrz004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[3]["NAZRZPFLG"]);
          }
          if (KolNaz > 4)
          {
              NazIdn005.Value = Convert.ToString(ds.Tables[0].Rows[4]["NAZIDN"]);
              ChkRzp005.Checked = Convert.ToBoolean(ds.Tables[0].Rows[4]["NAZREZ"]);
              TxtNaz005.Text = Convert.ToString(ds.Tables[0].Rows[4]["NAZPLNOBS"]);
              BoxPrm005.SelectedValue = Convert.ToString(ds.Tables[0].Rows[4]["NAZPRMTAB"]);
              BoxEdn005.SelectedValue = Convert.ToString(ds.Tables[0].Rows[4]["NAZEDNTAB"]);
              TxtLek005.Text = Convert.ToString(ds.Tables[0].Rows[4]["NAZKOLTAB"]);
              BoxKrt005.SelectedValue = Convert.ToString(ds.Tables[0].Rows[4]["NAZKRTTAB"]);
              TxtDni005.Text = Convert.ToString(ds.Tables[0].Rows[4]["NAZDNI"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[4]["NAZRZPFLG"].ToString())) ChkPrz005.Checked = false;
              else ChkPrz005.Checked = Convert.ToBoolean(ds.Tables[0].Rows[4]["NAZRZPFLG"]);
          }
      }


      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNap()
      {
          int KolNap;

          //====================================================================================================================
          NapIdn001.Value = "";
          NapIdn002.Value = "";
          NapIdn003.Value = "";
          NapIdn004.Value = "";
          NapIdn005.Value = "";

          TxtNap001.Text = "";
          TxtNap002.Text = "";
          TxtNap003.Text = "";
          TxtNap004.Text = "";
          TxtNap005.Text = "";

          //        ====================================================================================================
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          DataSet ds = new DataSet();
          SqlCommand cmdNap = new SqlCommand("HspAmbPrsIdn", con);
          // указать тип команды
          cmdNap.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmdNap.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter daNap = new SqlDataAdapter(cmdNap);
          // заполняем DataSet из хран.процедуры.
          daNap.Fill(ds, "HspAmbPrsIdn");

          con.Close();

          KolNap = ds.Tables[0].Rows.Count;  // запись об предмете найден

          if (KolNap > 0)
          {
              NapIdn001.Value = Convert.ToString(ds.Tables[0].Rows[0]["PRSIDN"]);
              TxtNap001.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRSOBSTXT"]);
          }
          if (KolNap > 1)
          {
              NapIdn002.Value = Convert.ToString(ds.Tables[0].Rows[1]["PRSIDN"]);
              TxtNap002.Text = Convert.ToString(ds.Tables[0].Rows[1]["PRSOBSTXT"]);
          }
          if (KolNap > 2)
          {
              NapIdn003.Value = Convert.ToString(ds.Tables[0].Rows[2]["PRSIDN"]);
              TxtNap003.Text = Convert.ToString(ds.Tables[0].Rows[2]["PRSOBSTXT"]);
          }
          if (KolNap > 3)
          {
              NapIdn004.Value = Convert.ToString(ds.Tables[0].Rows[3]["PRSIDN"]);
              TxtNap004.Text = Convert.ToString(ds.Tables[0].Rows[3]["PRSOBSTXT"]);
          }
          if (KolNap > 4)
          {
              NapIdn005.Value = Convert.ToString(ds.Tables[0].Rows[4]["PRSIDN"]);
              TxtNap005.Text = Convert.ToString(ds.Tables[0].Rows[4]["PRSOBSTXT"]);
          }
      }


      //------------------------------------------------------------------------
      // ==================================== ШАБЛОНЫ  ============================================
      //------------------------------------------------------------------------
      protected void SablonPrvJlb(object sender, EventArgs e) { SablonPrv("Jlb");}
      protected void SablonPrvAnm(object sender, EventArgs e) { SablonPrv("Anm"); }
      protected void SablonPrvLif(object sender, EventArgs e) { SablonPrv("Lif"); }
      protected void SablonPrvStt(object sender, EventArgs e) { SablonPrv("Stt"); }
      protected void SablonPrvDig(object sender, EventArgs e) { SablonPrv("Dig"); }
      protected void SablonPrvDsp(object sender, EventArgs e) { SablonPrv("Dsp"); }
      protected void SablonPrvLch(object sender, EventArgs e) { SablonPrv("Lch"); }

      protected void SablonPrvPrs(object sender, EventArgs e) { SablonPrv("Prs"); }
      protected void SablonPrvNaz(object sender, EventArgs e) { SablonPrv("Naz"); }


      void SablonPrv(string SblTyp)
      {
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbSblPrv", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = SblTyp;
          // Выполнить команду
          con.Open();
          cmd.ExecuteNonQuery();

          con.Close();

          getDocNum();
      }


      protected void UslSel001(object sender, EventArgs e)
      {
          UpdateRecordUsl(UslIdn001.Value, BoxUsl001.SelectedValue);
      }

      protected void UslSel002(object sender, EventArgs e)
      {
          UpdateRecordUsl(UslIdn002.Value, BoxUsl002.SelectedValue);
      }

      protected void UslSel003(object sender, EventArgs e)
      {
          UpdateRecordUsl(UslIdn003.Value, BoxUsl003.SelectedValue);
      }

      protected void UslSel004(object sender, EventArgs e)
      {
          UpdateRecordUsl(UslIdn004.Value, BoxUsl004.SelectedValue);
      }

      protected void UslSel005(object sender, EventArgs e)
      {
          UpdateRecordUsl(UslIdn005.Value, BoxUsl005.SelectedValue);
      }

      void UpdateRecordUsl(string UslIdn,string UslKod)
      {
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbUslRepAcm", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = UslIdn;
          cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = parCrdIdn.Value;
          cmd.Parameters.Add("@USLKOD", SqlDbType.VarChar).Value = UslKod;
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();

          getDocUsl();
      }


      protected void NazTxt001(object sender, EventArgs e)
      {
          UpdateRecordNaz(NazIdn001.Value, TxtNaz001.Text);
      }

      protected void NazTxt002(object sender, EventArgs e)
      {
          UpdateRecordNaz(NazIdn002.Value, TxtNaz002.Text);
      }

      protected void NazTxt003(object sender, EventArgs e)
      {
          UpdateRecordNaz(NazIdn003.Value, TxtNaz003.Text);
      }

      protected void NazTxt004(object sender, EventArgs e)
      {
          UpdateRecordNaz(NazIdn004.Value, TxtNaz004.Text);
      }

      protected void NazTxt005(object sender, EventArgs e)
      {
          UpdateRecordNaz(NazIdn005.Value, TxtNaz005.Text);
      }

      void UpdateRecordNaz(string NazIdn,string NazNam)
      {
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbNazRepAcm", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@NAZIDN", SqlDbType.VarChar).Value = NazIdn;
          cmd.Parameters.Add("@NAZAMB", SqlDbType.VarChar).Value = parCrdIdn.Value;
          cmd.Parameters.Add("@NAZNAM", SqlDbType.VarChar).Value = NazNam;
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();

          getDocNaz();

        // if (String.IsNullOrEmpty(NazNam)) ExecOnLoad("ExitFun();");
          ExecOnLoad("ExitFun();");

      }

      protected void NapTxt001(object sender, EventArgs e)
      {
          UpdateRecordNap(NapIdn001.Value, TxtNap001.Text);
      }

      protected void NapTxt002(object sender, EventArgs e)
      {
          UpdateRecordNap(NapIdn002.Value, TxtNap002.Text);
      }

      protected void NapTxt003(object sender, EventArgs e)
      {
          UpdateRecordNap(NapIdn003.Value, TxtNap003.Text);
      }

      protected void NapTxt004(object sender, EventArgs e)
      {
          UpdateRecordNap(NapIdn004.Value, TxtNap004.Text);
      }

      protected void NapTxt005(object sender, EventArgs e)
      {
          UpdateRecordNap(NapIdn005.Value, TxtNap005.Text);
      }

      void UpdateRecordNap(string NapIdn,string NapNam)
      {
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbNapRepAcm", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@PRSIDN", SqlDbType.VarChar).Value = NapIdn;
          cmd.Parameters.Add("@PRSAMB", SqlDbType.VarChar).Value = parCrdIdn.Value;
          cmd.Parameters.Add("@PRSNAM", SqlDbType.VarChar).Value = NapNam;
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();

          getDocNap();

//          if (String.IsNullOrEmpty(NapNam)) ExecOnLoad("ExitFun();");
          ExecOnLoad("ExitFun();");

      }

  </script>   
    
    
<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parSblNum" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parCrdStx" runat="server" />

        <asp:HiddenField ID="NazIdn001" runat="server" />
        <asp:HiddenField ID="NazIdn002" runat="server" />
        <asp:HiddenField ID="NazIdn003" runat="server" />
        <asp:HiddenField ID="NazIdn004" runat="server" />
        <asp:HiddenField ID="NazIdn005" runat="server" />

        <asp:HiddenField ID="NapIdn001" runat="server" />
        <asp:HiddenField ID="NapIdn002" runat="server" />
        <asp:HiddenField ID="NapIdn003" runat="server" />
        <asp:HiddenField ID="NapIdn004" runat="server" />
        <asp:HiddenField ID="NapIdn005" runat="server" />

        <asp:HiddenField ID="UslIdn001" runat="server" />
        <asp:HiddenField ID="UslIdn002" runat="server" />
        <asp:HiddenField ID="UslIdn003" runat="server" />
        <asp:HiddenField ID="UslIdn004" runat="server" />
        <asp:HiddenField ID="UslIdn005" runat="server" />

        <asp:HiddenField ID="parStsImg" runat="server" />

        <span id="WindowPositionHelper"></span>
        <%-- ============================  шапка экрана ============================================ --%>

        <div style="position: relative; top: -10px;">
            <%-- ============================  шапка экрана ============================================ 

        <asp:TextBox ID="Sapka" 
             Text="ПРИЕМ И ОСМОТР ВРАЧА" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
            --%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace">
                <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="100%" style="vertical-align: central;">
                        <asp:Label ID="LblPvd" Text="Повод:" runat="server" Width="3%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDocPvd" Width="8%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Заболевание" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Профосмотр" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Диспансеризация" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Прививка" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Медико-социальный" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Прочие" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Травма на производстве" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Травма в сель.хоз." Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="Травма ДТП на производстве" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem19" runat="server" Text="Травма прочая на производстве" Value="10" />
                                <obout:ComboBoxItem ID="ComboBoxItem20" runat="server" Text="Травма бытовая" Value="11" />
                                <obout:ComboBoxItem ID="ComboBoxItem21" runat="server" Text="Травма уличная" Value="12" />
                                <obout:ComboBoxItem ID="ComboBoxItem22" runat="server" Text="Травма в ДТП" Value="13" />
                                <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text="Травма спортивная" Value="14" />
                                <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="Травма школьная" Value="15" />
                            </Items>
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <asp:Label ID="LblNpr" Text="Напр:" runat="server" Width="3%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDocNpr" Width="8%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="АДА(СВА)" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="Скорая помощью" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="Стационаром" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Самостоятельно" Value="4" />
                            </Items>
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <asp:Label ID="LblVid" Text="Посящ:" runat="server" Width="3%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDocVid" Width="8%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="Поликлиника" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="Дома" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="В школе (д/с)" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="В учреждении" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="Дневой стационар" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Стационар на дому" Value="6" />
                            </Items>
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>




                        <!-- Результат---------------------------------------------------------------------------------------------------------- <hr>    -->

                        <asp:Label ID="Label4" Text="Исход:" runat="server" Width="3%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDocResObr" Width="8%" Height="250"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="Выздоровление" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text="Без перемен" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="Улучшение" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="Госпитализация" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="Смерть" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="Отказ больного" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="Выезд" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem45" runat="server" Text="Привит" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem46" runat="server" Text="Прочие" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem47" runat="server" Text="Продолжение СПО" Value="10" />
                            </Items>
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <asp:Label ID="Label5" Text="Напр:" runat="server" Width="3%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="ChkBox001"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label7" Text="МСЭ" runat="server" />

                        <obout:OboutCheckBox runat="server" ID="ChkBox002"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label8" Text="КДП" runat="server" />

                        <obout:OboutCheckBox runat="server" ID="ChkBox003"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label9" Text="Туб.дсп" runat="server" />

                        <obout:OboutCheckBox runat="server" ID="ChkBox004"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label10" Text="Онкол" runat="server" />

                        <asp:Label ID="Label6" Text="СПО завершен:" runat="server" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkBoxEnd"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
                        </obout:OboutCheckBox>

                        <asp:Label ID="Label28" runat="server" align="center" Style="font-weight: bold;" Text="К/дата"></asp:Label>
                        <asp:TextBox runat="server" ID="txtDatCtr" Width="70px" BackColor="#FFFFE0" />

                        <obout:Calendar ID="CtrDat" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="txtDatCtr"
                            OnClientDateChanged="onDateChange"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                        <asp:Label ID="Label1" Text="SMS:" runat="server" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkBoxSMS"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChangedSMS" />
                        </obout:OboutCheckBox>

                        <asp:Label ID="LblDbl" Text="П:" runat="server" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkBoxPov"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChangedPov" />
                        </obout:OboutCheckBox>

                    </td>


                </tr>
            </table>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Jlb001" runat="server"
                            OnClick="SablonPrvJlb"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px;" />
                    </td>
                    <td width="7%" style="vertical-align: top;">
                        <asp:Button ID="Jlb002" runat="server"
                            OnClientClick="SablonJlb()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Жалобы" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="Jlb003" Width="100%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Jlb" onclick="Speech('GrfJlb')">
                            <img id="start_img1" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>
                <!--  Анамнез болезни ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Anm001" runat="server"
                            OnClick="SablonPrvAnm"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="20px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="7%" style="vertical-align: top;">
                        <asp:Button ID="Anm002" runat="server"
                            OnClientClick="SablonAnm()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Анамнез" Height="20px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="Anm003" Width="100%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Anm" onclick="Speech('GrfAnm')">
                            <img id="start_img2" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>

                <!--  Анамнез жизни----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="AnmLif001" runat="server"
                            OnClick="SablonPrvLif"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="20px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="7%" style="vertical-align: top;">
                        <asp:Button ID="AnmLif002" runat="server"
                            OnClientClick="SablonLif()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Анамнез жизни" Height="20px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="AnmLif003" Width="100%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_AnmLif" onclick="Speech('GrfAnmLif')">
                            <img id="start_imgLif" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>
                <!--  Статус ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Stt001" runat="server"
                            OnClick="SablonPrvStt"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="4%" style="vertical-align: top;">
                        <asp:Button ID="Stt002" runat="server"
                            OnClientClick="SablonSts()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Статус" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                        <asp:Button ID="Stt002x" runat="server"
                            OnClientClick="SablonXls()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Шаблон" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="Stt003" Width="100%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Stt" onclick="Speech('GrfStt')">
                            <img id="start_img3" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>


                <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Lch001" runat="server"
                            OnClick="SablonPrvLch"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="7%" style="vertical-align: top;">
                        <asp:Button ID="Lch002" runat="server"
                            OnClientClick="SablonLch()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Лечение" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="Lch003" Width="100%" BackColor="White" Height="60px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Lch" onclick="Speech('GrfLch')">
                            <img id="start_img4" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>


                <!-- Диагноз ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Button7" runat="server"
                            OnClick="SablonPrvLch"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                        <input type="button" id="btnCancel" value="МКБ" class="tdTextSmall" onclick="OnButton001Click()" />
                    </td>
                    <td width="7%" style="vertical-align: top;">
                        <asp:Button ID="Button8" runat="server"
                            OnClientClick="SablonLch()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Диагноз" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                        <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->
                        <asp:TextBox ID="Mkb001" Width="95%" Height="20" runat="server" Font-Bold="true" Style="font-size: small;" />
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="Dig003" Width="100%" BackColor="White" Height="50px"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Dig" onclick="Speech('GrfLch')">
                            <img id="start_img5" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>
            </table>

            <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  УСЛУГИ ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Button5" runat="server"
                            OnClick="SablonPrvLch"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                    </td>
                    <td width="9%" style="vertical-align: top;">
                        <asp:Button ID="Button6" runat="server" 
                            OnClientClick="UslButton_Click()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Услуги" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                    </td>
                    <td width="88%" style="vertical-align: top;">

                        <asp:UpdatePanel runat="server" ID="UpdPanel01">
                            <ContentTemplate>
                                <%-- ====================================================================== --%>
                                <table border="1" cellspacing="0" width="100%" cellpadding="0">
                                    <!--  УСЛУГИ шапка ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="80%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label11" Text="Услуга" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label2" Text="Кол-во" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label3" Text="Сумма" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                    </tr>
                                    <!--  УСЛУГИ 1 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="80%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxUsl001" Width="100%" Font-Size="small" 
                                                AutoPostBack="true"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                OnSelectedIndexChanged="UslSel001"
                                                DataTextField="UslNam"
                                                DataValueField="UslKod" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtKol001" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtSum001" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                    </tr>

                                    <!--  УСЛУГИ 2 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="15" width="80%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxUsl002" Width="100%" Font-Size="small"
                                                AutoPostBack="true"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="UslNam"
                                                OnSelectedIndexChanged="UslSel002"
                                                DataValueField="UslKod" />
                                        </td>
                                        <td height="15" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtKol002" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="15" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtSum002" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  УСЛУГИ 3 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="80%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxUsl003" Width="100%" Font-Size="small"
                                                AutoPostBack="true"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                OnSelectedIndexChanged="UslSel003"
                                                DataTextField="UslNam"
                                                DataValueField="UslKod" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtKol003" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtSum003" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  УСЛУГИ 4 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="80%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxUsl004" Width="100%" Font-Size="small"
                                                AutoPostBack="true"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="UslNam"
                                                OnSelectedIndexChanged="UslSel004"
                                                DataValueField="UslKod" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtKol004" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtSum004" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  УСЛУГИ 5 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="80%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxUsl005" Width="100%" Font-Size="small"
                                                AutoPostBack="true"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="UslNam"
                                                OnSelectedIndexChanged="UslSel005"
                                                DataValueField="UslKod" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtKol005" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtSum005" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                    </tr>


                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <button id="start_Usl" onclick="Speech('GrfLch')">
                            <img id="start_img6" src="/Icon/Microphone.png" alt="Start" /></button>
                    </td>
                </tr>
            </table>



            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Назначения ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Button3" runat="server"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="9%" style="vertical-align: top;">
                        <asp:Button ID="Button4" runat="server"
                            OnClientClick="SablonNaz()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Назначения" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>

                    <td width="88%" style="vertical-align: top;">
                        <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                                <%-- ============================  Назначения шапка ============================================ --%>
                                <table border="1" cellspacing="0" width="100%" cellpadding="0">
                                    <!--  Язык ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>

                                        <td height="21" width="50%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label13" Text="Назначения" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                         <td height="21" width="5%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label12" Text="Рецепт" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td> 
                                        <td height="21" width="10%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label19" Text="Применение" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>

                                        <td height="21" width="10%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label20" Text="Ед.изм" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>

                                        <td height="21" width="5%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label14" Text="Кол-во" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                        <td height="21" width="10%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label15" Text="Кратность" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                        <td height="21" width="5%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label16" Text="Дни" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                        <td height="21" width="5%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label21" Text="Проц" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                    </tr>
                                    <!--  Назначения 1 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>

                                        <td height="20" width="50%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNaz001" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NazTxt001" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtIdn001" Width="100%" Height="20" runat="server" Visible="false" />
                                            <asp:CheckBox ID="ChkRzp001" class="largerCheckbox" runat="server" />
                                        </td> 
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxPrm001" Width="100%" Font-Size="small"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="PRMNAM"
                                                DataValueField="PRMKOD" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxEdn001" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="EDNLEKNAM"
                                                DataValueField="EDNLEKKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtLek001" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxKrt001" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="KRTNAM"
                                                DataValueField="KRTKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtDni001" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkPrz001" class="largerCheckbox" runat="server" />
                                        </td>
                                    </tr>

                                    <!--  Назначения 2 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>

                                        <td height="20" width="50%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNaz002" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NazTxt002" Style="font-size: small;" />
                                        </td>
                                         <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkRzp002" class="largerCheckbox" runat="server" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxPrm002" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="PRMNAM"
                                                DataValueField="PRMKOD" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxEdn002" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="EDNLEKNAM"
                                                DataValueField="EDNLEKKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtLek002" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxKrt002" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="KRTNAM"
                                                DataValueField="KRTKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtDni002" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkPrz002" class="largerCheckbox" runat="server" />
                                        </td>
                                    </tr>

                                    <!--  Назначения 3 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="50%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNaz003" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NazTxt003" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkRzp003" class="largerCheckbox" runat="server" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxPrm003" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="PRMNAM"
                                                DataValueField="PRMKOD" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxEdn003" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="EDNLEKNAM"
                                                DataValueField="EDNLEKKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtLek003" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxKrt003" Width="100%" Font-Size="small"
                                                Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="KRTNAM"
                                                DataValueField="KRTKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtDni003" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkPrz003" class="largerCheckbox" runat="server" />
                                        </td>
                                    </tr>

                                    <!--  Назначения 4 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>

                                        <td height="20" width="50%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNaz004" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NazTxt004" Style="font-size: small;" />
                                        </td>
                                         <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkRzp004" class="largerCheckbox" runat="server" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxPrm004" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="PRMNAM"
                                                DataValueField="PRMKOD" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxEdn004" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="EDNLEKNAM"
                                                DataValueField="EDNLEKKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtLek004" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxKrt004" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="KRTNAM"
                                                DataValueField="KRTKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtDni004" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkPrz004" class="largerCheckbox" runat="server" />
                                        </td>
                                    </tr>

                                    <!--  Назначения 5 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>

                                        <td height="20" width="50%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNaz005" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NazTxt005" Style="font-size: small;" />
                                        </td>
                                         <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkRzp005" class="largerCheckbox" runat="server" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxPrm005" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="PRMNAM"
                                                DataValueField="PRMKOD" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxEdn005" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="EDNLEKNAM"
                                                DataValueField="EDNLEKKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtLek005" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="10%" style="vertical-align: top;">
                                            <asp:DropDownList runat="server" ID="BoxKrt005" Width="100%" Font-Size="small"
                                                 Height="23px"
                                                AppendDataBoundItems="true"
                                                DataTextField="KRTNAM"
                                                DataValueField="KRTKOD" />
                                        </td>
                                        <td height="15" width="5%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtDni005" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: small;" />
                                        </td>
                                        <td height="20" width="5%" style="vertical-align: top;">
                                            <asp:CheckBox ID="ChkPrz005" class="largerCheckbox" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <asp:Button ID="Button9" runat="server"
                            OnClientClick="NazButton_Click()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Наз" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>
            </table>

           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Направления ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="3%" style="vertical-align: top;">
                        <asp:Button ID="Button1" runat="server"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="<<<" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="9%" style="vertical-align: top;">
                        <asp:Button ID="Button2" runat="server"
                            OnClientClick="SablonPrs()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Направления" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td width="88%" style="vertical-align: top;">

                        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                            <ContentTemplate>
                                <%-- ============================  Направления шапка ============================================ --%>
                                <table border="1" cellspacing="0" width="100%" cellpadding="0">
                                    <!--  Язык ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="21" width="100%" style="vertical-align: top; background-color: lightgray">
                                            <asp:Label ID="Label18" Text="Направления" runat="server" Width="100%" Font-Bold="true" Font-Size="small" />
                                        </td>
                                    </tr>

                                    <!--  Направления 1----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="100%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNap001" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NapTxt001" Style="font-size: small;" />
                                        </td>
                                    </tr>

                                    <!--  Направления 2----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="100%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNap002" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NapTxt002" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  Направления 3----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="100%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNap003" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NapTxt003" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  Направления 4 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="100%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNap004" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NapTxt004" Style="font-size: small;" />
                                        </td>
                                    </tr>
                                    <!--  Направления 5 ----------------------------------------------------------------------------------------------------------  -->
                                    <tr>
                                        <td height="20" width="100%" style="vertical-align: top;">
                                            <asp:TextBox ID="TxtNap005" Width="100%" Height="20" BorderStyle="None" runat="server" AutoPostBack="true" OnTextChanged="NapTxt005" Style="font-size: small;" />
                                        </td>
                                    </tr>

                                </table>

                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </td>
                    <td style="vertical-align: top; width: 7%">
                        <asp:Button ID="Button10" runat="server"
                            OnClientClick="NapButton_Click()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Нап" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>
            </table>

            <!-- Как сделать длинный пробел? ---------------------------------------------------------------------------------------------------------- 
     &nbsp; неразрывный пробел
&thinsp; узкий пробел (применяют в двойных словах)
&ensp; средний, разрывной пробел
&emsp; длинный разрывной пробел (примеяют в конце предложений)

      <span style='padding-left:10px;'> </span>
       -->


        </div>
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
        <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <%-- =================  окно для поиска клиента из базы  ============================================  --%>
     <%-- ======================================================================================================== --%>
       <owd:Window ID="RabWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="520" Width="1100" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>  
    </form>

    <%-- ============================  STYLES ============================================ --%>
    <style type="text/css">
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

  /*   For multiline textbox control:  */
       .ob_iTaMC textarea
    {
        font-size: 14px !important;
        font-family: Arial !important;
    }
      
 /*   For oboutButton Control: color: #0000FF !important; */

    .ob_iBC
    {
        font-size: 12px !important;
    }

 /*  For oboutTextBox Control: */

    .ob_iTIE
    {
        font-size: 12px !important;
    }
      
      /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }
    
        hr {
    border: none; /* Убираем границу */
    background-color: gray; /* Цвет линии */
    color: gray; /* Цвет линии для IE6-7 */
    height: 2px; /* Толщина линии */
   }
</style>

    <asp:SqlDataSource runat="server" ID="sdsMkb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
    <asp:SqlDataSource runat="server" ID="sdsPrm" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl002" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

</body>
</html>



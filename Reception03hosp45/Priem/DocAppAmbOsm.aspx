<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
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

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChange(sender, newText) {
 //            alert("onChangeJlb=" + sender.ID);
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
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
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
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

          //   if (sender.ID == 'BoxDocPvd') {
          ////       alert("GrfDocVal ==" + GrfDocVal);
          //       if (GrfDocVal == "2") {
          //           document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + ' жалоб нет.';
          //           onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
          //           document.getElementById('Anm003').value = document.getElementById('Anm003').value + ' Хронические заболевания отрицает.';
          //           onChangeTxt('Anm003', document.getElementById('Anm003').value);
          //           document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + 'Аллергии нет. Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
          //           onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
          //           document.getElementById('Stt003').value = document.getElementById('Stt003').value + 'Общее состояние удовлетворительное. Сознание ясное.';
          //           onChangeTxt('Stt003', document.getElementById('Stt003').value);

          //           onChangeTxt('Dig003', 'Рутинная общая проверка');
          //           onChangeTxt('Mkb001', 'Z10.8');
          //       }

          //       if (GrfDocVal == "4") {
          //                window.parent.HandleResult("Прививка");
          //       }
          //       if (GrfDocVal == "1") {
          //           window.parent.HandleResult("Заболевание");
          //       }
          //   }

         }

         //    ------------------------------------------------------------------------------------------------------------------------
         function onCheckedChangedSMS(sender, isChecked) {
           //      alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
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
                     if (isChecked == true) document.getElementById('txtDatCtr').value = null;
                     break;
                 case 'ChkBoxSMS':
                     GrfDocRek = 'DOCCTRDATSMS';
                     break;
                 default:
                     break;

             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

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

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function ()
                 {
                     //alert("ERROR=" + SqlStr);
                 }
             });

         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {
       //      alert("onChangeUpd=" + GrfDocRek + " # " + GrfDocVal + " # " + GrfDocTyp);
             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBDOC';
             var DatDocKey = 'DOCAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

             if (GrfDocTyp != 'Bit') {
                 DatDocVal = DatDocVal.replace("\\", "\u002F");
                 DatDocVal = DatDocVal.replace("\\", "\u002F");
                 DatDocVal = DatDocVal.replace("\\", "\u002F");
                 DatDocVal = DatDocVal.replace("\\", "\u002F");
                 DatDocVal = DatDocVal.replace("\\", "\u002F");
                 DatDocVal = DatDocVal.replace("\\", "\u002F");

                 DatDocVal = DatDocVal.replace("\"", "\\u0022");
                 DatDocVal = DatDocVal.replace("\"", "\\u0022");
                 DatDocVal = DatDocVal.replace("\"", "\\u0022");
                 DatDocVal = DatDocVal.replace("\"", "\\u0022");
                 DatDocVal = DatDocVal.replace("\"", "\\u0022");
                 DatDocVal = DatDocVal.replace("\"", "\\u0022");

                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
                 DatDocVal = DatDocVal.replace("\'", "\\u0022");
             }

         //   alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
       //    alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () 
                    { 
                     // alert("ERROR=" + SqlStr); 
                    }
             });

             //   ----------------------------------- ОЧИСТИТЬ КОНТР ДАТА ЕСЛИ СПО=да
             if (GrfDocRek == 'DOCRESCPO' && GrfDocVal == true)
             {
                 DatDocTyp='Sql';
                 SqlStr = "UPDATE AMBCRD SET GRFCTRDAT=NULL WHERE GRFIDN="+DatDocIdn;
               //  alert("SqlStr=" + SqlStr);

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

         }

         // ==================================== при выборе клиента показывает его программу  ============================================
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
           //          alert("ParStr=" + ParStr);

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
                 else
                 {
                     var ParStr = DatDocIdn + '@2@' + result + '@@@@';
           //          alert("ParStr=" + ParStr);

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
             //   alert(document.getElementById('parBuxKod').value);
                if (document.getElementById('parBuxKod').value == '1260')   
                    document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + 'Росла и развивалася соответственно возрасту.Наследственность: не отягощена. Аллергоанамнез: _______________.Tbs и вен.заболевания отрицает.';
                else
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
             window.open("DocAppSblFlg.aspx?SblTyp=" + SblTyp + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=1000,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
         }

         //    ---------------- обращение веб методу --------------------------------------------------------
         function SablonXls() {
             //                alert("SablonXls=");
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             var DocStsXls = document.getElementById('parStsImg').value;
             var DlgSts = document.getElementById('parDlgSts').value;

             if (DlgSts != "") {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1) window.open("DocAppSblSttAspose.aspx?AmbCrdIdn=" + AmbCrdIdn + "&DocStsXls=" + DocStsXls, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else window.showModalDialog("DocAppSblSttAspose.aspx?AmbCrdIdn=" + AmbCrdIdn + "&DocStsXls=" + DocStsXls, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");

                 return false;
             }
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


          if (!Page.IsPostBack)
          {

              //=====================================================================================
              //     sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //     sdsNoz.SelectCommand = "SELECT NozKod,NozNam FROM SprNoz ORDER BY NozNam";
          //    sdsMkb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          //    sdsMkb.SelectCommand = "SELECT TOP 100 * FROM MKB10 ORDER BY MkbNam";
              //=====================================================================================
              Session.Add("KLTIDN", (string)"");
              Session.Add("WHERE", (string)"");

              getDocNum();
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
       //       Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
       //       Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
       //       Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
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

              parStsImg.Value = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSXLS"]);
              parDlgSts.Value = Convert.ToString(ds.Tables[0].Rows[0]["DLGSTS"]);

          }

          //          string name = value ?? string.Empty;
      }
      // ============================ чтение заголовка таблицы а оп ==============================================
      void filComboBox()
      {
          int i;

          String[] MasPvd = {"Заболевание", "Профосмотр", "Диспансеризация", "Прививка", "Медико-социальный", "Прочие",
                               "Травма на производстве","Травма в сель.хоз.","Травма ДТП на производстве","Травма прочая на производстве",
                               "Травма бытовая","Травма уличная","Травма в ДТП","Травма спортивная","Травма школьная"};
          String[] MasNpr = {"АДА(СВА)", "Скорая помощью", "Стационаром", "Самостоятельно"};
          String[] MasVid = {"Поликлиника", "Дома", "В школе (д/с)", "В учреждении", "Дневой стационар", "Стационар на дому"};
          String[] MasRes = { "Здоров", "Выздоровление", "Без перемен", "Улучшение", "Госпитализация", "Смерть", "Отказ больного", "Выезд", "Привит", "Прочие", "Продолжение СПО" };
          String[] MasDig = { "Предварительный", "Клинический", "Окончательный"};

          // looping through the full names array and adding each state to the first combobox
          BoxDocPvd.Items.Clear();
          BoxDocPvd.SelectedIndex = -1;
          BoxDocPvd.SelectedValue = "";
          for (i = 0; i < MasPvd.Length; i++)
          {
              BoxDocPvd.Items.Add(new ComboBoxItem(MasPvd[i], Convert.ToString(i+1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasNpr.Length; i++)
          {
              BoxDocNpr.Items.Add(new ComboBoxItem(MasNpr[i], Convert.ToString(i+1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasVid.Length; i++)
          {
              BoxDocVid.Items.Add(new ComboBoxItem(MasVid[i], Convert.ToString(i+1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasRes.Length; i++)
          {
              BoxDocResObr.Items.Add(new ComboBoxItem(MasRes[i], Convert.ToString(i + 1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasDig.Length; i++)
          {
              //              BoxDig001.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
              //              BoxDig002.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
              //              BoxDig003.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
          }
          //           BoxDocPvd.SelectedIndex = 3;
          //           BoxDocNpr.SelectedIndex = 4;
          //           BoxDocVid.SelectedIndex = 5;

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

  </script>   
    
    
<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
            <asp:HiddenField ID="parMkbNum" runat="server" />
            <asp:HiddenField ID="parSblNum" runat="server" />
            <asp:HiddenField ID="parBuxKod" runat="server" />
            <asp:HiddenField ID="parCrdIdn" runat="server" />
            <asp:HiddenField ID="parStsImg" runat="server" />
            <asp:HiddenField ID="parDlgSts" runat="server" />

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
         <table border="0" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace" >
 <!--  Повод обращения ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                              <td width="100%" style="vertical-align: central;" >
                                 <asp:Label id="LblPvd" Text="Повод обращения:" runat="server"  Width="12%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocPvd"  Width="31%" Height="300" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxIt00" runat="server" Text="Любой кроме <Платные профосмотры>" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxIt01" runat="server" Text="Острое заболевание (состояние)/Обострение хронического заболевания" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxIt02" runat="server" Text="Подозрение на социально-значимое заболевание" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxIt03" runat="server" Text="Консультирование дистанционное по поводу заболевания" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxIt04" runat="server" Text="Актив" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxIt05" runat="server" Text="Медицинская реабилитация (3 этап)" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxIt06" runat="server" Text="Стоматологическая помощь" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxIt07" runat="server" Text="Острая травма (Травмпункт, АПО)" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxIt08" runat="server" Text="Последствия травмы (АПО)" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxIt09" runat="server" Text="Обращение с профилактической целью (кроме скрининга)" Value="9" />
                                            <obout:ComboBoxItem ID="ComboBoxIt10" runat="server" Text="Иммунопрофилактика" Value="10" />
                                            <obout:ComboBoxItem ID="ComboBoxIt11" runat="server" Text="Скрининг (Профосмотр)" Value="11" />
                                            <obout:ComboBoxItem ID="ComboBoxIt12" runat="server" Text="Патронаж" Value="12" />
                                            <obout:ComboBoxItem ID="ComboBoxIt13" runat="server" Text="Услуги по вопросам планирования семьи" Value="13" />
                                            <obout:ComboBoxItem ID="ComboBoxIt14" runat="server" Text="Прием при антенатальном наблюдении" Value="14" />
                                            <obout:ComboBoxItem ID="ComboBoxIt15" runat="server" Text="Прием при постнатальном наблюдении" Value="15" />
                                            <obout:ComboBoxItem ID="ComboBoxIt16" runat="server" Text="Услуги по охране здоровья обучающихся (школьная медицина)" Value="16" />
                                            <obout:ComboBoxItem ID="ComboBoxIt17" runat="server" Text="Мероприятия по здоровому образу жизни" Value="17" />
                                            <obout:ComboBoxItem ID="ComboBoxIt18" runat="server" Text="Платные медосмотры" Value="18" />
                                            <obout:ComboBoxItem ID="ComboBoxIt19" runat="server" Text="Стоматологические услуги" Value="19" />
                                            <obout:ComboBoxItem ID="ComboBoxIt20" runat="server" Text="Динамическое наблюдение с хроническими заболеваниями" Value="20" />
                                            <obout:ComboBoxItem ID="ComboBoxIt21" runat="server" Text="Медико-социальная поддержка" Value="21" />
                                            <obout:ComboBoxItem ID="ComboBoxIt22" runat="server" Text="Психологическая поддержка" Value="22" />
                                            <obout:ComboBoxItem ID="ComboBoxIt23" runat="server" Text="Административный" Value="23" />
                                            <obout:ComboBoxItem ID="ComboBoxIt24" runat="server" Text="Оформление документов на медико-социальную экспертизу" Value="24" />
                                            <obout:ComboBoxItem ID="ComboBoxIt25" runat="server" Text="Выписка рецептов" Value="25" />
                                         </Items>
                                         <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>  
                                 
                                 <asp:Label id="LblNpr" Text="Кем напр.:" runat="server"  Width="8%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocNpr"  Width="16%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain">
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="АДА(СВА)" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Скорая помощью" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="Стационаром" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem0" runat="server" Text="Самостоятельно" Value="4" />
                                        </Items>
                                        <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>  

                                 <asp:Label id="LblVid" Text="Вид посящ:" runat="server"  Width="8%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocVid"  Width="15%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain">
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="Поликлиника" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="Дома" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="В школе (д/с)" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="В учреждении" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Дневой стационар" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="Стационар на дому" Value="6" />
                                        </Items>
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>  
                             
                                 <asp:Label id="LblDbl" Text="Повтор:" runat="server" Font-Bold="true"  />                             
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
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="SablonJlb()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Жалобы" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="85px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Jlb" onclick="Speech('GrfJlb')">
                                <img id="start_img1" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
<!--  Анамнез болезни ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Anm001" runat="server"
                                    OnClick="SablonPrvAnm"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Anm002" runat="server"
                                    OnClientClick="SablonAnm()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез бол" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="85px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Anm" onclick="Speech('GrfAnm')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 

 <!--  Анамнез жизни----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif001" runat="server"
                                    OnClick="SablonPrvLif"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif002" runat="server"
                                    OnClientClick="SablonLif()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез жизни" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmLif003"  width="100%" BackColor="White" Height="65px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Anm" onclick="Speech('GrfAnmLif')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>               

             <!--  Статус ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Stt001" runat="server"
                                    OnClick="SablonPrvStt"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="SablonSts()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Статус" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                               <asp:Button ID="Stt002x" runat="server"
                                    OnClientClick="SablonXls()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Шаблон" Height="25px" 
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="65px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('GrfStt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
                                                 
 <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Lch001" runat="server"
                                    OnClick="SablonPrvLch"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="SablonLch()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лечение" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="100px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Lch" onclick="Speech('GrfLch')">
                                 <img id="start_img6" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 
        </table>
  
           
<!-- Результат---------------------------------------------------------------------------------------------------------- <hr>    -->    
               <table border="0" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace" >
                        <tr> 
                             <td width="20%" style="vertical-align: central;" >
                                        <asp:Label id="Label4" Text="Исход обращ.:" runat="server"  Width="40%" Font-Bold="true" />                             
                                        <obout:ComboBox runat="server" ID="BoxDocResObr"  Width="55%" Height="250"
                                               FolderStyle="/Styles/Combobox/Plain" >
                                               <Items>
                                                   <obout:ComboBoxItem ID="ComboBoxItem48" runat="server" Text="" Value="0" />
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
                              </td>
                                 <td width="5%" style="vertical-align: central;" >    
                                        <asp:Label id="Label5" Text="Направлены:" runat="server" Width="10%" Font-Bold="true" />  
                              </td>
                                 <td width="5%" style="vertical-align: central;" >
                                            <obout:OboutCheckBox runat="server" ID="ChkBox001"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                       <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                                </obout:OboutCheckBox>                           
                                        <asp:Label id="Label7" Text="МСЭ" runat="server" />  
                                </td>
                                     <td width="5%" style="vertical-align: central;"  >
                                        <obout:OboutCheckBox runat="server" ID="ChkBox002"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                       <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                                </obout:OboutCheckBox>                                   
                                         <asp:Label id="Label8" Text="КДП" runat="server" />  
                              </td>
                                     <td width="5%" style="vertical-align: central;" >
                                              <obout:OboutCheckBox runat="server" ID="ChkBox003"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                       <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                                </obout:OboutCheckBox>                                   
                                        <asp:Label id="Label9" Text="Туб.дсп" runat="server" /> 
                                     </td>     
                               <td width="5%" style="vertical-align: central;" >
                                           <obout:OboutCheckBox runat="server" ID="ChkBox004"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                       <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                                </obout:OboutCheckBox>  
                                         <asp:Label id="Label10" Text="Онкол" runat="server" />  
                              </td>
                               <td width="8%" style="vertical-align: central;  " >
                                        <asp:Label id="Label6" Text="СПО завершен:" runat="server"  Font-Bold="true"  />                             
                                        <obout:OboutCheckBox runat="server" ID="ChkBoxEnd"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                       <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                                </obout:OboutCheckBox>  
                               </td>
 
                               <td width="15%" style="vertical-align: central;  " >
                                       <asp:Label ID="Label28" runat="server" align="center" Style="font-weight: bold;" Text="Конт.дата"></asp:Label>
                                       <asp:TextBox runat="server" id="txtDatCtr" Width="80px" BackColor="#FFFFE0" />

			                           <obout:Calendar ID="CtrDat" runat="server"
			 			                   	StyleFolder="/Styles/Calendar/styles/default" 
    	            					    DatePickerMode="true"
    	            					    ShowYearSelector="true"
                						    YearSelectorType="DropDownList"
    	            					    TitleText="Выберите год: "
    	            					    CultureName = "ru-RU"
                						    TextBoxId = "txtDatCtr"
                                            OnClientDateChanged="onDateChange"   
                   						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>

                                     <asp:Label id="Label1" Text="SMS:" runat="server"  Font-Bold="true"  />                             
                                           <obout:OboutCheckBox runat="server" ID="ChkBoxSMS"
		                                          FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                          <ClientSideEvents OnCheckedChanged="onCheckedChangedSMS" />
		                                   </obout:OboutCheckBox>  

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

  <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



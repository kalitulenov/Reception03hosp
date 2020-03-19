<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

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
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

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
                 error: function () { alert("ERROR=" + SqlStr); }
             });

         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBDOC';
             var DatDocKey = 'DOCAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

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
                 default:
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
     //        alert("SqlStr=" + SqlStr);

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

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnButton001Click() {
             parMkbNum.value = 1;
             //             MkbWindow.Open();
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=1",
                             "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=1",
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");

         }
         function OnButton002Click() {
             parMkbNum.value = 2;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=2",
                             "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + document.getElementById("parCrdIdn").value + "&MkbNum=2",
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");
         }

      //    ------------------------------------------------------------------------------------------------------------------------
         function Speech(event) {
             var ParTxt = "Жалобы";
             window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

         function HandlePopupResult(result) {
 //                    alert("result of popup is: " + result);
             var MasPar = result.split('@');

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

             //         =========================================================================
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
                             //        alert("msg.d=" + msg.d);
                             //                                alert("msg.d2=" + msg.d.substring(0, 3));
                             //                                alert("msg.d3=" + msg.d.substring(3, 7));
                          //   var hashes = msg.d.split(':');
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
         function SablonLif()
         {
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

         //    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;

                 if (ua.search(/Chrome/) > -1)
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

         function PrtPthButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

 
         </script>

</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string BuxKod;
      string AmbCrdIdn = "";
      string AmbCntIdn = "";
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
              sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              sdsUsl.SelectCommand = "SELECT SprUsl.UslKod,SprUsl.UslNam " +
                                     "FROM SprBuxUsl INNER JOIN SprUsl ON SprBuxUsl.BuxUslPrcKod=SprUsl.UslKod " +
                                                    "INNER JOIN SprUslFrm ON SprBuxUsl.BuxUslFrm=SprUslFrm.UslFrmHsp AND SprBuxUsl.BuxUslPrcKod=SprUslFrm.UslFrmKod " +
                                                    "INNER JOIN SprFrmStx ON SprUslFrm.UslFrmPrc=SprFrmStx.FrmStxPrc AND SprBuxUsl.BuxUslFrm=SprFrmStx.FrmStxKodFrm " +
                                     "WHERE SprBuxUsl.BuxUslFrm=" + BuxFrm +" AND SprBuxUsl.BuxUslDocKod=" + BuxKod + 
                                      " AND SprUslFrm.UslFrmZen>0 AND LEN(SprUsl.UslTrf)=11 AND SprFrmStx.FrmStxKodStx=1";
              //=====================================================================================
              sdsNap.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              sdsNap.SelectCommand = "SELECT SprUsl.UslKod,SprUsl.UslNam " +
                                     "FROM SprBuxUsl INNER JOIN SprUsl ON SprBuxUsl.BuxUslPrcKod=SprUsl.UslKod " +
                                                    "INNER JOIN SprUslFrm ON SprBuxUsl.BuxUslFrm=SprUslFrm.UslFrmHsp AND SprBuxUsl.BuxUslPrcKod=SprUslFrm.UslFrmKod " +
                                                    "INNER JOIN SprFrmStx ON SprUslFrm.UslFrmPrc=SprFrmStx.FrmStxPrc AND SprBuxUsl.BuxUslFrm=SprFrmStx.FrmStxKodFrm " +
                                     "WHERE SprBuxUsl.BuxUslFrm=" + BuxFrm +" AND SprBuxUsl.BuxUslDocKod=" + BuxKod + 
                                      " AND SprUslFrm.UslFrmZen>0 AND LEN(SprUsl.UslTrf)=11 AND SprFrmStx.FrmStxKodStx=1";
              //=====================================================================================
           //   Session.Add("KLTIDN", (string)"");
           //   Session.Add("WHERE", (string)"");


                 //============= Установки ===========================================================================================
                if (AmbCrdIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "АМБ";
                    cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = 0;
                    cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
                        AmbCntIdn = Convert.ToString(cmd.Parameters["@CNTIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
                HidAmbCrdIdn.Value = AmbCrdIdn;

              getSapka();
              getDocNum();
          }
          //               filComboBox();

      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getSapka()
      {
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbCrdIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbCrdIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

            TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
       //     TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["HURMIN"]).ToString("hh:mm");
       //     TextBoxKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
            TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
       //     TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["RABNAM"]);
            TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
            TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
          }

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
              Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
              Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
              Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
              Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);
              MkbSop001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP001"]);
              MkbSop002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP002"]);
              MkbSop003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP003"]);

              TekDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFCTRDAT"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 

              //               if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG1"].ToString())) BoxDig001.SelectedIndex = 0;
              //               else BoxDig001.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG1"]);

              //               if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG2"].ToString())) BoxDig002.SelectedIndex = 0;
              //               else BoxDig002.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG2"]);

              //               if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG3"].ToString())) BoxDig003.SelectedIndex = 0;
              //               else BoxDig003.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG3"]);

         //     if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESOBR"].ToString())) BoxDocResObr.SelectedIndex = 0;
         //     else BoxDocResObr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCRESOBR"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 
          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR001"].ToString())) ChkBox001.Checked = false;
          //    else ChkBox001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR001"]);
          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR002"].ToString())) ChkBox002.Checked = false;
          //    else ChkBox002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR002"]);
          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR003"].ToString())) ChkBox003.Checked = false;
          //    else ChkBox003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR003"]);
          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR004"].ToString())) ChkBox004.Checked = false;
          //    else ChkBox004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR004"]);

          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESCPO"].ToString())) ChkBoxEnd.Checked = false;
          //    else ChkBoxEnd.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESCPO"]);

          }

          //          string name = value ?? string.Empty;
      }
      // ============================ чтение заголовка таблицы а оп ==============================================

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
            <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
            <span id="WindowPositionHelper"></span>
     <%-- ============================  шапка экрана ============================================ 
                      <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ Карты</td>
     
         --%>

                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:5%; position: relative; top: 0px; width: 90%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="13%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="30%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="25%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="15%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="90px" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
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
                   <td width="15%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                  </td> 
                  <td width="30%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="75%" Height="20" RunAt="server" ReadOnly="true" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="25%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="15%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ 
      
                          <obout:OboutTextBox runat="server" ID="TextBoxTel"  width="100%" BackColor="White" Height="20px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
      --%>
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
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="None" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 510px;">
          <%-- ============================  шапка экрана ============================================
                     OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
         
               --%>

               <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="460" />
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="USLKOD" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column06" DataField="StxNam" HeaderText="ВИД ОПЛ" Width="10%" />
                    <obout:Column ID="Column07" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="54%" Align="left" />
                    <obout:Column ID="Column09" DataField="USLKOL" HeaderText="КОЛ" Width="6%" Align="right"  />
                    <obout:Column ID="Column12" DataField="USLKTO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="15%" />
                    
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server" />
                </Columns>
 		    	
               <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateKtoNam">
                        <Template>
                            <%# Container.DataItem["FI"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKtoNam" ControlID="ddlKtoNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKtoNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKto" CssClass="ob_gEC" DataTextField="FI" DataValueField="BuxKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>


       <table border="0" cellspacing="0"  width="100%" cellpadding="0">  
 <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                             
                            <td width="3%" style="vertical-align: top;">
                                    <input type="button" id="btnCancel" value="МКБ" class="tdTextSmall" onclick="OnButton001Click()"/> 
                            </td>
                            <td width="9%" style="vertical-align: top;">
                                <asp:TextBox ID="Mkb001" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                                <asp:TextBox ID="Mkb002" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                                <asp:TextBox ID="Mkb003" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dig003"  width="100%" BackColor="White" Height="50px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                             </td>

                             <td style="vertical-align: top; width:7%" >
                                <button id="start_Dig" onclick="Speech('GrfDig')">
                                 <img id="start_img4" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
                      </table>
    <hr/>

 <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->  
            <table border="0" cellspacing="0" width="100%" cellpadding="0">  
                        <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Jlb001" runat="server"
                                    OnClick="SablonPrvJlb"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="SablonJlb()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Жалобы" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="50px"
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
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="Anm002" runat="server"
                                    OnClientClick="SablonAnm()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез бол" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="50px"
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
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif002" runat="server"
                                    OnClientClick="SablonLif()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез жизни" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmLif003"  width="100%" BackColor="White" Height="50px"
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
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="SablonSts()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Статус" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="50px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('GrfStt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
                                                 
                
 <!--  Диагноз сопутствующий ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Dsp001" runat="server"
                                    OnClick="SablonPrvDsp"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />

                                    <input type="button" id="btnCancel" value="МКБ" class="tdTextSmall" onclick="OnButton002Click()"/> 
                            </td>
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="Dsp002" runat="server"
                                    OnClientClick="SablonDsp()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз соп" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                   <asp:TextBox ID="MkbSop001" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                                   <asp:TextBox ID="MkbSop002" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                                   <asp:TextBox ID="MkbSop003" Width="27%" Height="20" runat="server" ReadOnly="true" Font-Bold="true" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Ridge" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dsp003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Dsp" onclick="Speech('GrfDsp')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
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
                            <td width="9%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="SablonLch()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лечение" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="80px"
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

     <hr/>
 
                <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                   <tr>   
                    <td width="99%" style="vertical-align: top;" >
                        <asp:Label id="Label1" Text="НАП:" runat="server"  Width="4%" Font-Bold="true" />                             
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="ComboBox3"
                            Width="28%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsNap"
                            DataTextField="USLNAM"
                            DataValueField="USLKOD" />

                       <asp:Label id="Label3" Text="НАП:" runat="server"  Width="4%" Font-Bold="true" />                             
                         <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="ComboBox4"
                            Width="28%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsNap"
                            DataTextField="USLNAM"
                            DataValueField="USLKOD" />
                       <asp:Label id="Label12" Text="НАП:" runat="server"  Width="4%" Font-Bold="true" />                             
                         <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="ComboBox5"
                            Width="28%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsNap"
                            DataTextField="USLNAM"
                            DataValueField="USLKOD" />

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
         </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <input type="button" value="Печать амб.карты" onclick="PrtButton_Click()" />
                 <input type="button" value="Печать для пациента" onclick="PrtPthButton_Click()" />
            </center>

  </asp:Panel>              
              
 
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
    background-color: red; /* Цвет линии */
    color: red; /* Цвет линии для IE6-7 */
    height: 2px; /* Толщина линии */
   }
</style>

  <asp:SqlDataSource runat="server" ID="sdsNap"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



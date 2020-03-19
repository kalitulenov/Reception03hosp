<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="RefGlv003MedFrm.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlv003MedFrm" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%@ Import Namespace="System.Web.Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }


    </style>



    <%-- ============================  для передач значении  ============================================ --%>
    <input type="hidden" name="Index" id="par" />
    <asp:HiddenField ID="parPnl" runat="server" />
    <asp:HiddenField ID="parUpd" runat="server" />
    <%-- ============================  для передач значении  ============================================ --%>
    <script type="text/javascript">

        window.onload = function () {
            localStorage.setItem("CntIdn", ""); //setter
            localStorage.setItem("GrfPth", ""); //setter
            localStorage.setItem("GrfIIN", ""); //setter
            localStorage.setItem("GrfTel", ""); //setter
            localStorage.setItem("GrfBrt", ""); //setter
            localStorage.setItem("GrfKrt", ""); //setter
            localStorage.setItem("GrfCmp", ""); //setter
            localStorage.setItem("GrfStx", ""); //setter
            localStorage.setItem("GrfEnd", ""); //setter
            localStorage.setItem("GrfInv", ""); //setter
        }

        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
        function HandlePopupResult(result) {
    //              alert("result of popup is: " + result);

            var hashes = result.split('&');

//            alert("hashes=" + hashes);

            document.getElementById('MainContent_HidCntIdn').value = hashes[0];
            document.getElementById('MainContent_TextBoxTel').value = hashes[4];
            document.getElementById('MainContent_TextBoxIIN').value = hashes[2];
            document.getElementById('ctl00$MainContent$TextBoxFio').value = hashes[1];
            document.getElementById('MainContent_TextBoxBrt').value = hashes[3];
    //        document.getElementById('MainContent_TextBoxKrt').value = hashes[5];
    //        document.getElementById('MainContent_TextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_TextBoxStx').value = hashes[7];
     //       document.getElementById('MainContent_TextBoxEnd').value = hashes[8];
            document.getElementById('MainContent_TextBoxInv').value = hashes[9];

            document.getElementById('MainContent_HidTextBoxTel').value = hashes[4];
            document.getElementById('MainContent_HidTextBoxIIN').value = hashes[2];
            document.getElementById('MainContent_HidTextBoxFio').value = hashes[1];
            document.getElementById('MainContent_HidTextBoxBrt').value = hashes[3];
            document.getElementById('MainContent_HidTextBoxKrt').value = "";  //hashes[5];
            document.getElementById('MainContent_HidTextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_HidTextBoxStx').value = hashes[7];
            document.getElementById('MainContent_HidTextBoxEnd').value = "";   //hashes[8];
            document.getElementById('MainContent_HidTextBoxInv').value = hashes[9];

            localStorage.setItem("CntIdn", hashes[0]); //setter
            localStorage.setItem("GrfPth", hashes[1]); //setter
            localStorage.setItem("GrfIIN", hashes[2]); //setter
            localStorage.setItem("GrfTel", hashes[4]); //setter
            localStorage.setItem("GrfBrt", hashes[3]); //setter
            localStorage.setItem("GrfKrt", hashes[5]); //setter
            localStorage.setItem("GrfCmp", hashes[6]); //setter
            localStorage.setItem("GrfStx", hashes[7]); //setter
            localStorage.setItem("GrfEnd", hashes[8]); //setter
            localStorage.setItem("GrfInv", hashes[9]); //setter

         //   document.getElementById('ctl00$MainContent$TextBoxFio').value = result;
         //   document.getElementById('MainContent_HidTextBoxFio').value = result;
        }
        

       
        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function FindKlt() {
 //           alert("FindKlt=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);

            KltWindow.setTitle("Поиск клиентов");
            KltWindow.setUrl("RefGlv003Klt.aspx?TextBoxFio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            KltWindow.Open();

 /*
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1) 
               window.open("RefGlv003Klt.aspx?TextBoxFio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value, "ModalPopUp", "toolbar=no,width=1200,height=620,left=200,top=110,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else 
               window.showModalDialog("RefGlv003Klt.aspx?TextBoxFio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:110px;dialogWidth:1200px;dialogHeight:600px;");
*/
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function RpnKlt() {
          //  alert("RpnKlt1=");
            //              alert("result of popup is: " + result);
            document.getElementById('MainContent_HidCntIdn').value = 9176;   // CNTIDN  в спр SPRCNT
          //  alert("Tel=" + document.getElementById('MainContent_TextBoxTel').value);
            document.getElementById('MainContent_HidTextBoxTel').value = document.getElementById('MainContent_TextBoxTel').value;
          //  alert("IIN=" + document.getElementById('MainContent_TextBoxIIN').value);
            document.getElementById('MainContent_HidTextBoxIIN').value = document.getElementById('MainContent_TextBoxIIN').value;
          //  alert("Fio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            document.getElementById('MainContent_HidTextBoxFio').value = document.getElementById('ctl00$MainContent$TextBoxFio').value;
          //  alert("Brt=" + document.getElementById('MainContent_TextBoxBrt').value);
            document.getElementById('MainContent_HidTextBoxBrt').value = document.getElementById('MainContent_TextBoxBrt').value;
            document.getElementById('MainContent_HidTextBoxKrt').value = "";  //hashes[5];
            document.getElementById('MainContent_HidTextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_HidTextBoxStx').value = document.getElementById('MainContent_TextBoxStx').value;
            document.getElementById('MainContent_HidTextBoxEnd').value = "";   //hashes[8];
            document.getElementById('MainContent_HidTextBoxInv').value = document.getElementById('MainContent_TextBoxInv').value;

        //    alert("RpnKlt2=");
     //       localStorage.setItem("CntIdn", hashes[0]); //setter
            localStorage.setItem("GrfPth", document.getElementById('ctl00$MainContent$TextBoxFio').value);
            localStorage.setItem("GrfIIN", document.getElementById('MainContent_TextBoxIIN').value);
            localStorage.setItem("GrfTel", document.getElementById('MainContent_TextBoxTel').value);
            localStorage.setItem("GrfBrt", document.getElementById('MainContent_TextBoxBrt').value);
     //       localStorage.setItem("GrfKrt", hashes[5]); //setter
     //       localStorage.setItem("GrfCmp", hashes[6]); //setter
            localStorage.setItem("GrfStx", document.getElementById('MainContent_TextBoxStx').value);
     //       localStorage.setItem("GrfEnd", hashes[8]); //setter
            localStorage.setItem("GrfInv", document.getElementById('MainContent_TextBoxInv').value);
       //     alert("RpnKlt3=");
        }

        function KltClose(result) {
    //        alert("KofClose=1" + result);
            KltWindow.Close();

            var hashes = result.split('&');
            //            alert("hashes=" + hashes);

            document.getElementById('MainContent_HidCntIdn').value = hashes[0];
            document.getElementById('MainContent_TextBoxTel').value = hashes[4];
            document.getElementById('MainContent_TextBoxIIN').value = hashes[2];
            document.getElementById('ctl00$MainContent$TextBoxFio').value = hashes[1];
            document.getElementById('MainContent_TextBoxBrt').value = hashes[3];
      //      document.getElementById('MainContent_TextBoxKrt').value = hashes[5];
     //       document.getElementById('MainContent_TextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_TextBoxStx').value = hashes[7];
     //       document.getElementById('MainContent_TextBoxEnd').value = hashes[8];
            document.getElementById('MainContent_TextBoxInv').value = hashes[9];

            document.getElementById('MainContent_HidTextBoxTel').value = hashes[4];
            document.getElementById('MainContent_HidTextBoxIIN').value = hashes[2];
            document.getElementById('MainContent_HidTextBoxFio').value = hashes[1];
            document.getElementById('MainContent_HidTextBoxBrt').value = hashes[3];
            document.getElementById('MainContent_HidTextBoxKrt').value = "";    //hashes[5];
            document.getElementById('MainContent_HidTextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_HidTextBoxStx').value = hashes[7];
            document.getElementById('MainContent_HidTextBoxEnd').value = "";    //hashes[8];
            document.getElementById('MainContent_HidTextBoxInv').value = hashes[9];

            localStorage.setItem("CntIdn", hashes[0]); //setter
            localStorage.setItem("GrfPth", hashes[1]); //setter
            localStorage.setItem("GrfIIN", hashes[2]); //setter
            localStorage.setItem("GrfTel", hashes[4]); //setter
            localStorage.setItem("GrfBrt", hashes[3]); //setter
            localStorage.setItem("GrfKrt", hashes[5]); //setter
            localStorage.setItem("GrfCmp", hashes[6]); //setter
            localStorage.setItem("GrfStx", hashes[7]); //setter
            localStorage.setItem("GrfEnd", hashes[8]); //setter
            localStorage.setItem("GrfInv", hashes[9]); //setter
   //         RpnKlt();
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function PrtKltTit() {
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            if (TekKltIIN.length == 12)
            {
            //  alert("TekKltIIN=" + TekKltIIN);
             //   KltWindow.setTitle("Печать");
             //   KltWindow.setUrl("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIIN);
             //   KltWindow.Open();
                
                
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIIN, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIIN, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
                

            }
         } 

        function LoadModalDiv() {
            var bcgDiv = document.getElementById("divBackground");
            bcgDiv.style.display = "block";
 //           alert("LoadModalDiv=");
        }
        function HideModalDiv() {
  //          alert("HideModalDiv=");
            var bcgDiv = document.getElementById("divBackground");
            bcgDiv.style.display = "none";
        }

        function OnUnload() {
   //         alert("OnUnload=");
            if (false == popUpObj.closed) {
                popUpObj.close();
            }
        }
 //       window.onunload = OnUnload;

        function OnClientDblClick(iRecordIndex) {
            myWindow.Close();
            document.getElementById('MainContent_ButHid').click(); // нажитие скрытой кнопки для POSTBACK
            //		        $("#ButHid").mouseup();
            // 		        $("#ButHid").triggerHandler('click');
        }

        // ==================================== 33333333333333333333333333333333333333333===========================================
        function BoxDoc003_SelectedIndexChanged(sender, selectedIndex) {
            //      alert("selectedIndex=" + selectedIndex);
            //       var GrfDlg = BoxDoc003.value();
            var MedDocKod = BoxDoc003.options[BoxDoc003.selectedIndex()].value;
            document.getElementById('MainContent_HidBoxDoc003').value = MedDocKod;
     //           alert("MedDocKod=" + MedDocKod);
            localStorage.setItem("FndFio", document.getElementById('ctl00$MainContent$TextBoxFio').value); //setter
            mySpl0301.loadPage("BottomContent", "RefGlv003086.aspx?MedDocKod=" + MedDocKod);
        }

        function ButPst003_Click() {
            //        alert("ButPst003_Click()=");
            var MedDocKod = document.getElementById('MainContent_HidBoxDoc003').value;
     //       alert("MedDocKod=" + MedDocKod);
            mySpl0301.loadPage("BottomContent", "RefGlv003086.aspx?MedDocKod=" + MedDocKod);
        }

        function ButWrt003_Click() {
            var MedDocKod = document.getElementById('MainContent_HidBoxDoc003').value;
            //     alert("GrfKod=" + GrfKod);
            if (MedDocKod == "") {
                windowalert("Мед.форма не выбран!", "Предупреждения", "warning");
                return;
            }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("Пациент не выбран!", "Предупреждения", "warning");
                return;
            }

            var SndPar = document.getElementById('MainContent_HidBuxFrm').value + ":" +
                         document.getElementById('MainContent_HidBuxKod').value + ":" +
                         MedDocKod + ":" +
                         document.getElementById('MainContent_HidTextBoxFio').value + ":" +
                         document.getElementById('MainContent_HidTextBoxIIN').value + ":" +
                         document.getElementById('MainContent_HidTextBoxTel').value + ":" +
                         document.getElementById('MainContent_HidTextBoxBrt').value + ":" +
                         document.getElementById('MainContent_HidTextBoxKrt').value + ":" +
                         document.getElementById('MainContent_HidCntIdn').value;

    //        alert("SndPar=" + SndPar);

            //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/RefZapTekTim086',
                data: '{"SndPar":"' + SndPar + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });

            ButPst003_Click();
        }


        function ButGrp003_Click() {
   //         alert("ButGrp003_Click");
   //         var MedDocKod = document.getElementById('MainContent_HidBoxDoc003').value;
   //         if (MedDocKod == "") {
   //             windowalert("Мед.форма не выбран!", "Предупреждения", "warning");
   //             return;
   //         }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("Пациент не выбран!", "Предупреждения", "warning");
                return;
            }

            var SndPar = document.getElementById('MainContent_HidBuxFrm').value + ":" +
                         document.getElementById('MainContent_HidBuxKod').value + ":" +
                         "0:" +
                         document.getElementById('MainContent_HidTextBoxFio').value + ":" +
                         document.getElementById('MainContent_HidTextBoxIIN').value + ":" +
                         document.getElementById('MainContent_HidTextBoxTel').value + ":" +
                         document.getElementById('MainContent_HidTextBoxBrt').value + ":" +
                         document.getElementById('MainContent_HidTextBoxKrt').value + ":" +
                         document.getElementById('MainContent_HidCntIdn').value;

         //           alert("SndPar=" + SndPar);
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("RefGlv003Grp.aspx?SndPar=" + SndPar, "ModalPopUp", "toolbar=no,width=900,height=420,left=300,top=210,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("RefGlv003Grp.aspx?SndPar=" + SndPar, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:300px;dialogtop:210px;dialogWidth:900px;dialogHeight:420px;");

            ButPst003_Click();
        }
        // ==================================== ppppppppppppppppppppppppppppppppp============================
        function ButPrt003_Click() {
            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
           var GrfBeg = document.getElementById('MainContent_TextBoxBegDat').value;
           var GrfEnd = document.getElementById('MainContent_TextBoxEndDat').value;
           var MedDocKod = document.getElementById('MainContent_HidBoxDoc003').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst086Prt&TekDocKod=" + MedDocKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst086Prt&TekDocKod=" + MedDocKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
        // ==================================== при выборе клиента показывает его программу  ============================================
/*
        function OnButtonTitClick() {
            KltOneWindow.setTitle("Карта пациента");
            KltOneWindow.setUrl("RefGlv003KltOneSel.aspx?KltOneIdn=" + KltOneIdn);
            KltOneWindow.Open();
            return false;
        }
*/
        function OnClientDateChangedBeg(sender, selectedDate) {
            var StartDate = document.getElementById('MainContent_TextBoxBegDat').value;
            var EndDate = document.getElementById('MainContent_TextBoxEndDat').value;
            //     alert(StartDate + '  ' + EndDate);

            $.ajax({
                type: 'POST',
                url: '/Operation/DatBegEnd.aspx/BegEndDatOk',
                data: '{"StartDate":"' + StartDate + '","EndDate":"' + EndDate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------
        function OnClientDateChangedEnd(sender, selectedDate) {
  //          alert("OnClientDateChanged=" + document.getElementById('MainContent_TextBoxEndDat').value);
            var StartDate = document.getElementById('MainContent_TextBoxBegDat').value;
            var EndDate = document.getElementById('MainContent_TextBoxEndDat').value;
 //           alert(StartDate + '  ' + EndDate);

            $.ajax({
                type: 'POST',
                url: '/Operation/DatBegEnd.aspx/BegEndDatOk',
                data: '{"StartDate":"' + StartDate + '","EndDate":"' + EndDate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
        }

        // ------------------------  отправить запись в кассу  -------------------------------------------------------------
        /*
        function KasKltTit() {
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var BuxKod = document.getElementById('MainContent_HidBuxKod').value;

            if (TekKltIIN.length == 12)
                if (confirm("Хотите передать в кассу?")) {

                    var DatDocMdb = 'HOSPBASE';
                    var DatDocRek;
                    var DatDocTyp = 'Str';

                    SqlStr = "HspRefKasAdd&@KASFRM&" + BuxFrm + "&@KASBUX&" + BuxKod + "&@KASIIN&" + TekKltIIN;
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
        }
        */

        // ------------------------  показать архив в 3 колонке  -------------------------------------------------------------
        function ArxKltTit() {
            //              alert('AmbCrdIdn= ' );
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
   //         alert('TekKltIIN= ' + TekKltIIN);
            if (TekKltIIN.length == 12) {

                KltWindow.setTitle("АРХИВ");
                KltWindow.setUrl("/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm);
                KltWindow.Open();


  /*
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm,
                        "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm,
                        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
*/

  //              mySpl0201.loadPage("BottomContent", "/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm);
            }
        }

        // ------------------------  показать архив в 3 колонке  -------------------------------------------------------------
        function SblZapPrm() {
            //              alert('AmbCrdIdn= ' );  
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var TekDat = document.getElementById('MainContent_TextBoxBegDat').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var BuxFio = document.getElementById('ctl00$MainContent$TextBoxFio').value;
            //     alert('TekDat= ' + TekDat);
            if (TekKltIIN.length == 12) {

                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Priem/BuxKasPrxSprDocSbl.aspx?AmbCrdIIN=" + TekKltIIN + "&KltFio=" + BuxFio + "&TekDat=" + TekDat,
                        "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Priem/BuxKasPrxSprDocSbl.aspx?AmbCrdIIN=" + TekKltIIN + "&KltFio=" + BuxFio + "&TekDat=" + TekDat,
                        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");
            }
            else windowalert("Клиент не указан", "Предупреждения", "warning");

        }

    </script>



    <asp:SqlDataSource runat="server" ID="SdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsMedDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  конец -----------------------------------------------  -->

    <asp:HiddenField ID="HidTextBoxFio" runat="server" />
    <asp:HiddenField ID="HidTextBoxIIN" runat="server" />
    <asp:HiddenField ID="HidTextBoxTel" runat="server" />
    <asp:HiddenField ID="HidTextBoxBrt" runat="server" />
    <asp:HiddenField ID="HidTextBoxKrt" runat="server" />
    <asp:HiddenField ID="HidTextBoxStx" runat="server" />
    <asp:HiddenField ID="HidTextBoxDsp" runat="server" />
    <asp:HiddenField ID="HidTextBoxEnd" runat="server" />
    <asp:HiddenField ID="HidTextBoxInv" runat="server" />

    <asp:HiddenField ID="HidCntIdn" runat="server" />
    <asp:HiddenField ID="HidKltIdn" runat="server" />
    <asp:HiddenField ID="HidBuxFrm" runat="server" />
    <asp:HiddenField ID="HidBuxKod" runat="server" />
    
    <asp:HiddenField ID="HidBoxDoc001" runat="server" />
    <asp:HiddenField ID="HidBoxFio001" runat="server" />
    <asp:HiddenField ID="HidBoxDoc002" runat="server" />
    <asp:HiddenField ID="HidBoxFio002" runat="server" />
    <asp:HiddenField ID="HidBoxDoc003" runat="server" />
    <asp:HiddenField ID="HidBoxFio003" runat="server" />

<div >
          <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="21%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Период</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="25%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О., ИИН</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Год.р</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="18%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страховат.</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Запись</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Архив</td>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
              </tr>
              
               <tr>
                   <td width="21%" class="PO_RowCap">
                       <asp:TextBox runat="server" ID="TextBoxBegDat" Width="70px" BackColor="#FFFFE0" />
                       <obout:Calendar ID="cal1" runat="server"
                           StyleFolder="/Styles/Calendar/styles/default"
                           DatePickerMode="true"
                           ShowYearSelector="true"
                           YearSelectorType="DropDownList"
                           TitleText="Выберите год: "
                           CultureName="ru-RU"
                           TextBoxId="TextBoxBegDat"
                           OnClientDateChanged="OnClientDateChangedBeg"
                           DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                       <asp:TextBox runat="server" ID="TextBoxEndDat" Width="70px" BackColor="#FFFFE0" />
                       <obout:Calendar ID="cal2" runat="server"
                           StyleFolder="/Styles/Calendar/styles/default"
                           DatePickerMode="true"
                           ShowYearSelector="true"
                           YearSelectorType="DropDownList"
                           TitleText="Выберите год: "
                           CultureName="ru-RU"
                           TextBoxId="TextBoxEndDat"
                           OnClientDateChanged="OnClientDateChangedEnd"
                           DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                   </td>

                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="25%" class="PO_RowCap">
                      <obout:OboutTextBox runat="server" ID="TextBoxFio" Width="78%" BackColor="White" Height="25px"
                             TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                     <ClientSideEvents OnTextChanged="FindKlt" />
                      </obout:OboutTextBox>
                      
                      <input type="button" value="Поиск" style="width:17%"  onclick="FindKlt()" />
                      <input type="button" value="РПН" style="display:none;"  onclick="RpnKlt()" />
                                            
                  </td>

                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxInv" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                   </td> 

                   <td width="18%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 
                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxStx" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td>

                  <td width="6%" class="PO_RowCap">
                      <input type="button" value="Зап.по шаблону" style="width:100%"  onclick="SblZapPrm();" />
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <input type="button" value="Архив" style="width:100%"  onclick="ArxKltTit()" />
                  </td>
                  <td width="4%" class="PO_RowCap">
                      <input type="button" value="Титул" style="width:100%"  onclick="PrtKltTit()" />
                  </td>

               </tr>
            
   </table>

<!--
        <asp:TextBox ID="TextBoxDoc"
            Text=""
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="2px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: -3px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>
-->

        <asp:Panel ID="PanelTop" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 25%; position: relative; top: 0px; width: 50%; height: 550px;">
            <asp:ScriptManager ID="ScriptManager3" runat="server"></asp:ScriptManager>

            <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl01">
                <LeftPanel WidthMin="900" WidthMax="1100" WidthDefault="1000">
                    <Content>
                                    <obspl:HorizontalSplitter ID="mySpl0301" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                                        <TopPanel  HeightMin="40" HeightMax="100" HeightDefault="52">
                                            <Content>
    <%-- ==============================================================================================================================--%>
                                            <input type="button" name="ButPst003" value="Обновить" 
                                                   onclick="ButPst003_Click();" id="ButPst003" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px" />
                                            <input type="button" name="ButWrt003" value="Записать" 
                                                   onclick="ButWrt003_Click();" id="ButWrt003" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px;" />
                                            <input type="button" name="ButPrt003" value="Печать отчета" 
                                                   onclick="ButPrt003_Click();" id="ButPrt003" 
                                                   style="height:20px;width:38%;position: relative; top: 0px; left: 0px" />

                                            <obout:ComboBox runat="server" ID="BoxDoc003" Width="100%" Height="400"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="Выберите медицинскую форму ..."
                                                DataSourceID="SdsMedDoc" DataTextField="SprMedFrmNam" DataValueField="SprMedFrmKod">
                                                <ClientSideEvents OnSelectedIndexChanged="BoxDoc003_SelectedIndexChanged" />
                                            </obout:ComboBox>
    <%-- ==============================================================================================================================--%>
                                            </Content>
                                        </TopPanel>
                                        <BottomPanel HeightMin="300" HeightMax="500" HeightDefault="400">
                                            <Content>
                                            </Content>
                                        </BottomPanel>
                                    </obspl:HorizontalSplitter>
                    </Content>
                </LeftPanel>
            </spl:Splitter>
        </asp:Panel>
    </div>

    <div id="divBackground" style="position: fixed; z-index: 999; height: 100%; width: 100%;
        top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
    </div>

   <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>


    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

</asp:Content>


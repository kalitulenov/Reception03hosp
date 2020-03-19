<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="RefGlv003.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlv003" %>

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
     <!--  ������ �� JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ------------------------------------- ��� �������� �������� � GRID --------------------------------%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- ��� ���������� ������ GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

        /*------------------------- ��� ���������� ������ COMBOBOX  --------------------------------*/

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

        /*------------------------- ��� OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* ��� ���������� ��������������� ������*/
          
    }


    </style>



    <%-- ============================  ��� ������� ��������  ============================================ --%>
    <input type="hidden" name="Index" id="par" />
    <asp:HiddenField ID="parPnl" runat="server" />
    <asp:HiddenField ID="parUpd" runat="server" />
    <%-- ============================  ��� ������� ��������  ============================================ --%>
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

        function HandlePopupPost(FioLst) {
        //    alert("HandlePopupPost ");
          //  var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;

          //  alert("BuxFrm: " + BuxFrm);
          //  var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
            //         alert('TekKltIIN= ' + TekKltIIN);
         //  console.log(FioLst);
          //  console.log(BuxFrm);

                KltWindow.setTitle("�����");
                KltWindow.setUrl("/Priem/DocAppAmbArxFio.aspx?AmbCrdFioLst=" + FioLst + "&BuxFrm=" + BuxFrm);
                KltWindow.Open();


            //var ua = navigator.userAgent;

            //if (ua.search(/Chrome/) > -1)
            //    window.open("/Priem/DocAppAmbArxFio.aspx?AmbCrdFioLst=" + FioLst + "&BuxFrm=" + BuxFrm, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            //else
            //    window.showModalDialog("/Priem/DocAppAmbArxFio.aspx?AmbCrdFioLst=" + FioLst + "&BuxFrm=" + BuxFrm, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

        }

               // ------------------------  �������� �������� �� ����������� ����  ------------------------------------------------------------------
        function HandlePopupResult(result) {
           //       alert("result of popup is: " + result);

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
         //   document.getElementById('MainContent_HidTextBoxFio').value = result;
        }
        
                // ------------------------  ���������� �� ���� ���������� � ���� ��� ������ � ����� �� ����������� ����  ------------------------------------------------------------------
        function FindRPN() {
            //     alert("FindRPN=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            var GlvKltIin = document.getElementById('ctl00$MainContent$TextBoxFio').value;

            if (GlvKltIin == "") { alert("��� �� ������ "); return false; }
            if (GlvKltIin.length != 12) { alert("����� ��� �� ����� " + GlvKltIin); return false; }

            var strCheck = "0123456789";
            var i;

            for (var i = 0; i < GlvKltIin.length; i++) {
                //          alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                if (strCheck.indexOf(GlvKltIin[i]) == -1) { alert("������ � ��� " + GlvKltIin); return false; }
            }

            KltOneWindow.setTitle("����� �������� � ��� " + GlvKltIin);
            KltOneWindow.setUrl("RefGlv003rpnAPI.aspx?KltOneIin=" + GlvKltIin);
     //       KltOneWindow.setUrl("RefGlv003RpnInsApi.aspx?KltOneIin=" + GlvKltIin);
            KltOneWindow.Open();
            // return false;
        }

       
        // ------------------------  ���������� �� ���� ���������� � ���� ��� ������ � ����� �� ����������� ����  ------------------------------------------------------------------
        function FindKlt() {
       //     alert("FindKlt=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);

            KltWindow.setTitle("����� ��������");
            KltWindow.setUrl("RefGlv003Klt.aspx?TextBoxFio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            KltWindow.Open();
        }


        // ------------------------  ���������� �� ���� ���������� � ���� ��� ������ � ����� �� ����������� ����  ------------------------------------------------------------------
        function RpnKlt() {
    //        alert("RpnKlt1=");
            //              alert("result of popup is: " + result);
            document.getElementById('MainContent_HidCntIdn').value = 9176;   // CNTIDN  � ��� SPRCNT
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
        //    alert("KofClose=1" + result);
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

       function KltCloseRPN(result) {
          //  alert("KltCloseRPN=" + result);
            KltOneWindow.Close();

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


        // ------------------------  ���������� �� ���� ���������� � ���� ��� ������ � ����� �� ����������� ����  ------------------------------------------------------------------
        function PrtKltTit() {
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            if (TekKltIIN.length == 12)
            {
            //  alert("TekKltIIN=" + TekKltIIN);
             //   KltWindow.setTitle("������");
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
       //     alert("LoadModalDiv=");
        }
        function HideModalDiv() {
       //     alert("HideModalDiv=");
            var bcgDiv = document.getElementById("divBackground");
            bcgDiv.style.display = "none";
        }

        function OnUnload() {
      //      alert("OnUnload=");
            if (false == popUpObj.closed) {
                popUpObj.close();
            }
        }
 //       window.onunload = OnUnload;

        function OnClientDblClick(iRecordIndex) {
            myWindow.Close();
            document.getElementById('MainContent_ButHid').click(); // ������� ������� ������ ��� POSTBACK
            //		        $("#ButHid").mouseup();
            // 		        $("#ButHid").triggerHandler('click');
        }

        // ==================================== 11111111111111111111111111111111111111  ============================================
        function BoxDoc001_SelectedIndexChanged(sender, selectedIndex) {
     //       alert("selectedIndex=" + selectedIndex);
     //       var GrfDlg = BoxDoc001.value();
            var GrfDlg = BoxDoc001.options[BoxDoc001.selectedIndex()].value;
            document.getElementById('MainContent_HidBoxDoc001').value = GrfDlg;
            document.getElementById('MainContent_HidBoxFio001').value = "0";
            var GrfKod = "0";
        //    alert("GrfDlg=" + GrfDlg);
            localStorage.setItem("FndFio", document.getElementById('ctl00$MainContent$TextBoxFio').value); //setter
            mySpl0101.loadPage("BottomContent", "RefGlv003001.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
            //      		        alert("GrfDlg=" + GrfDlg);
        //    document.getElementById("MainContent_mySpl01_ctl00_ctl01_mySpl0101_ctl00_ctl01_ButPst001").Click();
            var DlgFrm = GrfDlg + ":" + document.getElementById('MainContent_HidBuxFrm').value;
        //    alert("DlgFrm=" + DlgFrm);

            //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/RefGetSprDoc',
                data: '{"DlgFrm":"' + DlgFrm + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (SprDoc) {
              //      alert("onSprUslLoaded=" + SprDoc.d);

                    BoxFio001.options.clear();
                    BoxDoc001.options.add("");   //   ��� ���� ������ �� �������� !!!!!!!!!!!!!!!!!!!!!!!!
                    for (var i = 0; i < SprDoc.d.length; i=i+2) {
                        BoxFio001.options.add(SprDoc.d[i], SprDoc.d[i+1]);
                       }
                },
                error: function () { alert("ERROR="); }
            });

        }

        function BoxFio001_SelectedIndexChanged(sender, selectedIndex) {
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc001').value;
            var GrfKod = BoxFio001.options[BoxFio001.selectedIndex()].value;
            document.getElementById('MainContent_HidBoxFio001').value = GrfKod;

      //      alert("GrfKod=" + GrfKod);
      //      alert("GrfDlg=" + GrfDlg);
            localStorage.setItem("FndFio", document.getElementById('ctl00$MainContent$TextBoxFio').value); //setter
            mySpl0101.loadPage("BottomContent", "RefGlv003001.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
        }

        function ButPst001_Click() {
    //        alert("ButPst001_Click()=");
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc001').value;
            var GrfKod = document.getElementById('MainContent_HidBoxFio001').value;

   //         alert("GrfDlg=" + GrfDlg);
  //          alert("GrfKod=" + GrfKod);

            if (GrfKod != "") mySpl0101.loadPage("BottomContent", "RefGlv003001.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
            else if (GrfDlg != "") mySpl0101.loadPage("BottomContent", "RefGlv003001.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + "0");
        }

        function ButWrt001_Click() {
            var GrfKod = document.getElementById('MainContent_HidBoxFio001').value;
       //     alert("GrfKod=" + GrfKod);
            if (GrfKod == "") {
                windowalert("���� �� ������!", "��������������", "warning");
                return;
            }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("������� �� ������!", "��������������", "warning");
                return;
            }

            var SndPar = document.getElementById('MainContent_HidBuxFrm').value + ":" +
                         document.getElementById('MainContent_HidBuxKod').value + ":" +
                         GrfKod + ":" +
                         document.getElementById('MainContent_HidTextBoxFio').value + ":" +
                         document.getElementById('MainContent_HidTextBoxIIN').value + ":" +
                         document.getElementById('MainContent_HidTextBoxTel').value + ":" +
                         document.getElementById('MainContent_HidTextBoxBrt').value + ":" +
                         document.getElementById('MainContent_HidTextBoxKrt').value + ":" +
                         document.getElementById('MainContent_HidCntIdn').value;

            //    alert("DlgFrm=" + DlgFrm);

            //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/RefZapTekTim',
                data: '{"SndPar":"' + SndPar + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });

            ButPst001_Click();
        }


        // ==================================== 2222222222222222222222222222===============================================
        function BoxDoc002_SelectedIndexChanged(sender, selectedIndex) {
            //      alert("selectedIndex=" + selectedIndex);
            //       var GrfDlg = BoxDoc002.value();
            var GrfDlg = BoxDoc002.options[BoxDoc002.selectedIndex()].value;
            document.getElementById('MainContent_HidBoxDoc002').value = GrfDlg;
            document.getElementById('MainContent_HidBoxFio002').value = "0";
            var GrfKod = "0";
            //    alert("GrfDlg=" + GrfDlg);
            localStorage.setItem("FndFio", document.getElementById('ctl00$MainContent$TextBoxFio').value); //setter
            mySpl0201.loadPage("BottomContent", "RefGlv003002.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
            //      		        alert("GrfDlg=" + GrfDlg);
            //    document.getElementById("MainContent_mySpl01_ctl00_ctl01_mySpl0101_ctl00_ctl01_ButPst002").Click();
            var DlgFrm = GrfDlg + ":" + document.getElementById('MainContent_HidBuxFrm').value;
            //    alert("DlgFrm=" + DlgFrm);

            //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/RefGetSprDoc',
                data: '{"DlgFrm":"' + DlgFrm + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (SprDoc) {
                    //      alert("onSprUslLoaded=" + SprDoc.d);

                    BoxFio002.options.clear();
                    BoxDoc002.options.add("");   //   ��� ���� ������ �� �������� !!!!!!!!!!!!!!!!!!!!!!!!
                    for (var i = 0; i < SprDoc.d.length; i = i + 2) {
                        BoxFio002.options.add(SprDoc.d[i], SprDoc.d[i + 1]);
                    }
                },
                error: function () { alert("ERROR="); }
            });

        }

        function BoxFio002_SelectedIndexChanged(sender, selectedIndex) {
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc002').value;
            var GrfKod = BoxFio002.options[BoxFio002.selectedIndex()].value;
            document.getElementById('MainContent_HidBoxFio002').value = GrfKod;

            //      alert("GrfKod=" + GrfKod);
            //      alert("GrfDlg=" + GrfDlg);
            localStorage.setItem("FndFio", document.getElementById('ctl00$MainContent$TextBoxFio').value); //setter
            mySpl0201.loadPage("BottomContent", "RefGlv003002.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
        }

        function ButPst002_Click() {
            //        alert("ButPst002_Click()=");
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc002').value;
            var GrfKod = document.getElementById('MainContent_HidBoxFio002').value;

            //         alert("GrfDlg=" + GrfDlg);
            //          alert("GrfKod=" + GrfKod);

            if (GrfKod != "") mySpl0201.loadPage("BottomContent", "RefGlv003002.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + GrfKod);
            else if (GrfDlg != "") mySpl0201.loadPage("BottomContent", "RefGlv003002.aspx?GrfDlg=" + GrfDlg + "&GrfKod=" + "0");
        }

        function ButWrt002_Click() {
            var GrfKod = document.getElementById('MainContent_HidBoxFio002').value;
            //     alert("GrfKod=" + GrfKod);
            if (GrfKod == "") {
                windowalert("���� �� ������!", "��������������", "warning");
                return;
            }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("������� �� ������!", "��������������", "warning");
                return;
            }

            var SndPar = document.getElementById('MainContent_HidBuxFrm').value + ":" +
                         document.getElementById('MainContent_HidBuxKod').value + ":" +
                         GrfKod + ":" +
                         document.getElementById('MainContent_HidTextBoxFio').value + ":" +
                         document.getElementById('MainContent_HidTextBoxIIN').value + ":" +
                         document.getElementById('MainContent_HidTextBoxTel').value + ":" +
                         document.getElementById('MainContent_HidTextBoxBrt').value + ":" +
                         document.getElementById('MainContent_HidTextBoxKrt').value + ":" +
                         document.getElementById('MainContent_HidCntIdn').value;

            //    alert("DlgFrm=" + DlgFrm);

            //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/RefZapTekTim',
                data: '{"SndPar":"' + SndPar + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });

            ButPst002_Click();
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
                windowalert("���.����� �� ������!", "��������������", "warning");
                return;
            }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("������� �� ������!", "��������������", "warning");
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
   //             windowalert("���.����� �� ������!", "��������������", "warning");
   //             return;
   //         }
            if (document.getElementById('ctl00$MainContent$TextBoxFio').value == "") {
                windowalert("������� �� ������!", "��������������", "warning");
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

        function ButPrt001_Click() {
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc001').value;
            var GrfKod = document.getElementById('MainContent_HidBoxFio001').value;
            if (GrfDlg == "") GrfDlg = "0";
            if (GrfKod == "") GrfKod = "0";

            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfBeg = document.getElementById('MainContent_TextBoxBegDat').value;
            var GrfEnd = document.getElementById('MainContent_TextBoxEndDat').value;

 //           alert("GrfDlg =" + GrfDlg);
 //           alert("GrfEnd =" + GrfEnd)


            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function ButPrt002_Click() {
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc002').value;
            var GrfKod = document.getElementById('MainContent_HidBoxFio002').value;
            if (GrfDlg == "") GrfDlg = "0";
            if (GrfKod == "") GrfKod = "0";

            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfBeg = document.getElementById('MainContent_TextBoxBegDat').value;
            var GrfEnd = document.getElementById('MainContent_TextBoxEndDat').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function ButPrt003_Click() {
            var GrfDlg = document.getElementById('MainContent_HidBoxDoc003').value;
            var GrfKod = document.getElementById('MainContent_HidBoxFio003').value;
            if (GrfDlg == "") GrfDlg = "0";
            if (GrfKod == "") GrfKod = "0";

            var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var GrfBeg = document.getElementById('MainContent_TextBoxBegDat').value;
            var GrfEnd = document.getElementById('MainContent_TextBoxEndDat').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspRefGlvScr&TekDocIdn=" + GrfDlg + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
        // ==================================== ��� ������ ������� ���������� ��� ���������  ============================================
/*
        function OnButtonTitClick() {
            KltOneWindow.setTitle("����� ��������");
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

        // ------------------------  ��������� ������ � �����  -------------------------------------------------------------
        /*
        function KasKltTit() {
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
            var BuxKod = document.getElementById('MainContent_HidBuxKod').value;

            if (TekKltIIN.length == 12)
                if (confirm("������ �������� � �����?")) {

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

        // ------------------------  �������� ����� � 3 �������  -------------------------------------------------------------
        function ArxKltTit() {
                          alert('ArxKltTit= ' );
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            var BuxFrm = document.getElementById('MainContent_HidBuxFrm').value;
   //         alert('TekKltIIN= ' + TekKltIIN);
            if (TekKltIIN.length == 12) {

                KltWindow.setTitle("�����");
                KltWindow.setUrl("/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm);
                KltWindow.Open();

  //              mySpl0201.loadPage("BottomContent", "/Priem/DocAppAmbArxIIN.aspx?AmbCrdIIN=" + TekKltIIN + "&BuxFrm=" + BuxFrm);
            }
        }

        // ------------------------  �������� ����� � 3 �������  -------------------------------------------------------------
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
            else windowalert("������ �� ������", "��������������", "warning");

        }

        //  �������� ������ ����������� ���
        function SelFioCnd() {
            var FioCnd = document.getElementById('ctl00$MainContent$TextBoxFio').value;
         //   alert("FioCnd=" + FioCnd);
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1) {
                window.open("/Referent/RefGlv003SelFio.aspx?SelFioCnd=" + FioCnd,
                    "ModalPopUp", "toolbar=no,width=800,height=545,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            }
            else
            {
                window.showModalDialog("/Referent/RefGlv003SelFio.aspx?SelFioCnd=" + FioCnd,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:545px;");
            }
            return false;
        }

    </script>



    <asp:SqlDataSource runat="server" ID="SdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsMedDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  ��� �������� ���������� -----------------------------------------------  -->
    <!--  ��� �������� ���������� -----------------------------------------------  -->
    <!--  ����� -----------------------------------------------  -->

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
                  <td width="19%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">������</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">���</td>
                  <td width="32%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">������� �.�., ���</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">���.�</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">� ���</td>
                  <td width="17%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">�������</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">���������.</td>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">������</td>
<%--                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">�����</td>--%>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">�����</td>
              </tr>
              
               <tr>
                   <td width="19%" class="PO_RowCap">
                       <asp:TextBox runat="server" ID="TextBoxBegDat" Width="70px" BackColor="#FFFFE0" />
                       <obout:Calendar ID="cal1" runat="server"
                           StyleFolder="/Styles/Calendar/styles/default"
                           DatePickerMode="true"
                           ShowYearSelector="true"
                           YearSelectorType="DropDownList"
                           TitleText="�������� ���: "
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
                           TitleText="�������� ���: "
                           CultureName="ru-RU"
                           TextBoxId="TextBoxEndDat"
                           OnClientDateChanged="OnClientDateChangedEnd"
                           DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                   </td>

                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="32%" class="PO_RowCap">
                      <obout:OboutTextBox runat="server" ID="TextBoxFio" Width="59%" BackColor="White" Height="25px"
                             TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
<%--		                     <ClientSideEvents OnTextChanged="FindKlt" />--%>
                      </obout:OboutTextBox>
                      
                      <input type="button" value="��" style="width:10%"  onclick="FindKlt()" />
                      <input type="button" value="���" style="width:10%"  onclick="FindRPN()" />
                      <input type="button" value="�����" style="width:15%"  onclick="SelFioCnd()" />
                      <input type="button" value="SPC" style="display:none;" onclick="FindKlt()" />
                  </td>

                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxInv" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                   </td> 

                   <td width="17%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 
                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxStx" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td>

                  <td width="4%" class="PO_RowCap">
                      <input type="button" value="�� �������" style="width:100%"  onclick="SblZapPrm();" />
                  </td>
<%--                  <td width="3%" class="PO_RowCap">
                      <input type="button" value="�����" style="width:100%"  onclick="ArxKltTit()" />
                      <input type="button" value="�����" style="width:100%"  onclick="SelFioCnd()" />
                  </td>--%>
                  <td width="4%" class="PO_RowCap">
                      <input type="button" value="�����" style="width:100%"  onclick="PrtKltTit()" />
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

        <asp:Panel ID="PanelTop" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 5px; position: relative; top: 0px; width: 99%; height: 550px;">
            <asp:ScriptManager ID="ScriptManager3" runat="server"></asp:ScriptManager>

            <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl01">
                <LeftPanel WidthMin="400" WidthMax="600" WidthDefault="500">
                    <Content>
                        <obspl:HorizontalSplitter ID="mySpl0101" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                            <TopPanel HeightMin="40" HeightMax="100" HeightDefault="52">
                                <Content>
                                            <input type="button" name="ButPst001" value="��������" 
                                                   onclick="ButPst001_Click();" id="ButPst001" 
                                                   style="height:20px;width:35%;position: relative; top: 0px; left: 0px" />
                                            <input type="button" name="ButWrt001" value="������ �� ���.�����" 
                                                   onclick="ButWrt001_Click();" id="ButWrt001"   
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px; display:none;" />
                                            <input type="button" name="ButpPrt001" value="������" 
                                                   onclick="ButPrt001_Click();" id="ButPrt001" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px" />
                                            <obout:ComboBox runat="server" ID="BoxDoc001" Width="50%" Height="400"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="�������� ������������� ..."
                                                DataSourceID ="SdsDoc" DataTextField="DLGNAM" DataValueField="BuxDlg">
                                                <ClientSideEvents OnSelectedIndexChanged="BoxDoc001_SelectedIndexChanged" />
                                            </obout:ComboBox>
                                            <obout:ComboBox runat="server" ID="BoxFio001" Width="45%" Height="300"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="�������� ����� ..."
                                                DataSourceID="SdsFio" DataTextField="FIO" DataValueField="BUXKOD">
                                                <ClientSideEvents OnSelectedIndexChanged="BoxFio001_SelectedIndexChanged" />
                                            </obout:ComboBox>
                                </Content>
                            </TopPanel>
                            <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                                <Content>
                                </Content>
                            </BottomPanel>
                        </obspl:HorizontalSplitter>
                    </Content>
                </LeftPanel>
                <RightPanel>
                    <Content>
                        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl02">
                            <LeftPanel WidthMin="400" WidthMax="600" WidthDefault="500">
                                <Content>
                                    <obspl:HorizontalSplitter ID="mySpl0201" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                                        <TopPanel HeightMin="40" HeightMax="100" HeightDefault="52">
                                            <Content>

                                            <input type="button" name="ButPst002" value="��������" 
                                                   onclick="ButPst002_Click();" id="ButPst002" 
                                                   style="height:20px;width:35%;position: relative; top: 0px; left: 0px" />
                                            <input type="button" name="ButWrt002" value="������ �� ���.�����" 
                                                   onclick="ButWrt002_Click();" id="ButWrt002" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px; display:none;" />
                                            <input type="button" name="ButpPrt002" value="������" 
                                                   onclick="ButPrt002_Click();" id="ButPrt002" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px" />

                                            <obout:ComboBox runat="server" ID="BoxDoc002" Width="50%" Height="400"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="�������� ������������� ..."
                                                DataSourceID="SdsDoc" DataTextField="DLGNAM" DataValueField="BuxDlg">
                                                <ClientSideEvents OnSelectedIndexChanged="BoxDoc002_SelectedIndexChanged" />
                                            </obout:ComboBox>

                                            <obout:ComboBox runat="server" ID="BoxFio002" Width="45%" Height="300"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="�������� ����� ..."
                                                DataSourceID="SdsFio" DataTextField="FIO" DataValueField="BUXKOD">
                                                <ClientSideEvents OnSelectedIndexChanged="BoxFio002_SelectedIndexChanged" />
                                            </obout:ComboBox>


                                            </Content>
                                        </TopPanel>
                                        <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                                            <Content>
                                            </Content>
                                        </BottomPanel>
                                    </obspl:HorizontalSplitter>
                                </Content>
                            </LeftPanel>
                            <RightPanel>
                                <Content>
                                    <obspl:HorizontalSplitter ID="mySpl0301" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                                        <TopPanel  HeightMin="40" HeightMax="100" HeightDefault="52">
                                            <Content>
    <%-- ==============================================================================================================================--%>
                                            <input type="button" name="ButPst003" value="��������" 
                                                   onclick="ButPst003_Click();" id="ButPst003" 
                                                   style="height:20px;width:30%;position: relative; top: 0px; left: 0px" />
                                            <input type="button" name="ButWrt003" value="������" 
                                                   onclick="ButWrt003_Click();" id="ButWrt003" 
                                                   style="height:20px;width:20%;position: relative; top: 0px; left: 0px;" />
                                            <input type="button" name="ButWrt003" value="������" 
                                                   onclick="ButGrp003_Click();" id="ButGrp003" 
                                                   style="height:20px;width:20%;position: relative; top: 0px; left: 0px" />
                                            <input type="button" name="ButPrt003" value="������" 
                                                   onclick="ButPrt003_Click();" id="ButPrt003" 
                                                   style="height:20px;width:25%;position: relative; top: 0px; left: 0px" />

                                            <obout:ComboBox runat="server" ID="BoxDoc003" Width="100%" Height="400"
                                                FolderStyle="/Styles/Combobox/Plain" EmptyText="�������� ����������� ����� ..."
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
                            </RightPanel>
                        </spl:Splitter>

                    </Content>
                </RightPanel>
            </spl:Splitter>
        </asp:Panel>
    </div>

    <div id="divBackground" style="position: fixed; z-index: 999; height: 100%; width: 100%;
        top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
    </div>

   <%-- ============================  ��� windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

  <%-- ============================  ��� ����������� ������� ������ �� ���� ���� � ���� ���� geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
  <%-- ============================  ��� ����������� ������� ������ �� ���� ���� � ���� ���� geryon============================================ --%>
       <owd:Window ID="KltOneWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="400" Top="125" Height="470" Width="610" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="������ �� ���">
       </owd:Window>


    <%-- ============================  ��� ����������� ������� ������ �� ���� ���� � ���� ���� geryon============================================ --%>

</asp:Content>


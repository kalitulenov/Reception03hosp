<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET"%>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>

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

        /*------------------------- для ГАЛОЧКИ  --------------------------------*/  
        .hidden
        {
            display: none;
            width: 20px;
        }
        .visible
        {
            display: ;
            width:20px;
        }
                /*------------------------- для FLYOUT --------------------------------*/  
        			.tdTextLink {
			    font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}
        .tdText {
            font: 11px Verdana;
            color: red;
        }

    </style>



    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>

        <%-- ============================  для передач значении  ============================================ --%>
    <script type="text/javascript">

        function OnRecordClick(e) {
    //        alert('OnRecordClick');
            var img = document.getElementById("SelectImage_" + e);
            if (img) {
                if (img.className == 'visible') {
                    img.className = 'hidden';
                }
                else {
                    img.className = 'visible';
                }
            }
        }

        function OnSelect(arrSelectedRecords) {
            SelectWithImage();
        }

        function SelectWithImage() {
            //        
            var BuxInd = "";
            var BuxIndOne = "";
            var iRowIndex = 0;
            var Pole;
            var images = document.getElementsByName('SelectImage');


            var k = 0;
            if (document.getElementById('MainContent_HidKodDoc').value.substring(0, 3) == 'xxx')
                document.getElementById('MainContent_HidKodDoc').value = document.getElementById('MainContent_HidKodDoc').value.substring(0, 3);

     //       alert('HidKodDoc10=' + document.getElementById('MainContent_HidKodDoc').value);
            for (var i = 0; i < images.length; i++)
            {
                images[i].className = 'hidden';
                for (var j = 0; j < GridDoc.PageSelectedRecords.length; j++)
                {
                    selectedId = 'SelectImage_' + GridDoc.PageSelectedRecords[j].BUXKOD;
                    if (images[i].id == selectedId)
                    {
                        images[i].className = 'visible';
                        //   iRowIndex = i;
                        k = k + 1;

                        BuxIndOne = ('000' + i).slice(-3);
      //                  alert('BuxIndOne=' + BuxIndOne);
                        var y = 0;
                        for (var x = 0; x < document.getElementById('MainContent_HidKodDoc').value.length / 3; x++)
                        {
                            if (document.getElementById('MainContent_HidKodDoc').value.substring(x*3, (x+1)*3) == BuxIndOne) {
                                y = 1;
                                break;
                            }
                        }
                        if (y == 0) document.getElementById('MainContent_HidKodDoc').value = document.getElementById('MainContent_HidKodDoc').value + BuxIndOne; 

                    }
                }
            }

     //       alert('HidKodDoc20=' + k + ' == ' +document.getElementById('MainContent_HidKodDoc').value);

            if (k == 1) {
                Pole = BuxIndOne + 'xxx';
                iRowIndex = parseInt(Pole.substring(0, 3));
                document.getElementById('MainContent_HidKodDoc').value = BuxIndOne;
                document.getElementById('MainContent_HidKodDocCop').value = 'xxxxxx';
            }
            else
            {
                Pole = document.getElementById('MainContent_HidKodDoc').value.substring(0, 3) + document.getElementById('MainContent_HidKodDoc').value.slice(-3);
                iRowIndex = parseInt(Pole.substring(3, 6));
            }
         //   alert('Pole=' + Pole);

            //  погасить галочки
            for (i = 0; i < images.length; i++) {
                images[i].className = 'hidden';
            }

            //  поставить галочки
            if (Pole.substring(0, 3) != 'xxx') { i = parseInt(Pole.substring(0, 3)); images[i].className = 'visible'; }
            if (Pole.substring(3, 6) != 'xxx') { i = parseInt(Pole.substring(3, 6)); images[i].className = 'visible'; }

        //    alert('Pole=' + Pole);
        //    alert('HidKodDoc30=' + document.getElementById('MainContent_HidKodDoc').value);
        //    alert('iRowIndex =' + iRowIndex);

            var BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
            var BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
            var BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
            var BuxDat = document.getElementById('MainContent_HidTekDat').value;
            document.getElementById('MainContent_HidBuxKod').value = BuxKod;
            //   alert('BuxKod =' + BuxKod);

            // =========================  АНАЛИЗ ВЕРХНЕГО ОКНА=============================================================================

            if (Pole.substring(0, 3) != document.getElementById('MainContent_HidKodDocCop').value.substring(0, 3)) {
                document.getElementById('TxtDoc001').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("TopContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
            if (Pole.substring(3, 6) != 'xxx') {
                document.getElementById('TxtDoc002').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("BottomContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }

            // =========================  СОХРАНИТЬ ДАННЫЕ =============================================================================
            document.getElementById('MainContent_HidKodDocCop').value = document.getElementById('MainContent_HidKodDoc').value;

            var TopLen = mySpl0101.GetPanelSize("TopContent", "height");

            if (Pole.substring(3, 6) == 'xxx') {
                if (TopLen < 300) mySpl0101.MoveSeparatorByValue("top", -290);
            }
            else {
                TopLen = mySpl0101.GetPanelSize("TopContent", "height");
                if (TopLen > 500) mySpl0101.MoveSeparatorByValue("top", 290);
            }
        }


        window.onload = function () {
            window.onload = SelectWithImage;

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
        // ------------------------------------------------------------------------------------------
        function FindKlt() {
             //         alert("FindKlt=");
            KltWindow.setTitle("Поиск клиентов");
            KltWindow.setUrl("RefGlv003Klt.aspx?TextBoxFio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            KltWindow.Open();
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function RpnKlt() {
            //    alert("RpnKlt1=");
            //              alert("result of popup is: " + result);
            document.getElementById('MainContent_HidCntIdn').value = 9176;   // CNTIDN  в спр SPRCNT
            //     alert("Tel=" + document.getElementById('MainContent_TextBoxTel').value);
            document.getElementById('MainContent_HidTextBoxTel').value = document.getElementById('MainContent_TextBoxTel').value;
            //     alert("IIN=" + document.getElementById('MainContent_TextBoxIIN').value);
            document.getElementById('MainContent_HidTextBoxIIN').value = document.getElementById('MainContent_TextBoxIIN').value;
            //    alert("Fio=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);
            document.getElementById('MainContent_HidTextBoxFio').value = document.getElementById('ctl00$MainContent$TextBoxFio').value;
            //     alert("Brt=" + document.getElementById('MainContent_TextBoxBrt').value);
            document.getElementById('MainContent_HidTextBoxBrt').value = document.getElementById('MainContent_TextBoxBrt').value;
            document.getElementById('MainContent_HidTextBoxKrt').value = "";  //hashes[5];
            document.getElementById('MainContent_HidTextBoxDsp').value = hashes[6];
            document.getElementById('MainContent_HidTextBoxStx').value = document.getElementById('MainContent_TextBoxStx').value;
            document.getElementById('MainContent_HidTextBoxEnd').value = "";   //hashes[8];
            document.getElementById('MainContent_HidTextBoxInv').value = document.getElementById('MainContent_TextBoxInv').value;

            //      alert("RpnKlt2=");
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
            //      alert("RpnKlt3=");
        }

        function KltClose(result) {
            //    alert("KofClose=1" + result);
            KltWindow.Close();

            var hashes = result.split('&');
            //                 alert("hashes=" + hashes);

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
            //           alert('AmbCrdIdn= ' );
            var TekKltIIN = document.getElementById('MainContent_TextBoxIIN').value;
            if (TekKltIIN.length == 12) {

                KltWindow.setTitle("Печать");
                KltWindow.setUrl("/Report/DauaReports.aspx?ReportName=HspAmbKrtTit&TekDocIdn=" + TekKltIIN);
                KltWindow.Open();
            }
        }

        function OnClientDateChangedBeg(sender, selectedDate) {
            var BuxKod;
            var BuxFio;
            var BuxDlg;
            var iRowIndex = 0;
         //               alert("You've selected=" + selectedDate);
            var dd = selectedDate.getDate();
            if (dd < 10) dd = '0' + dd;

            var mm = selectedDate.getMonth() + 1;
            if (mm < 10) mm = '0' + mm;
            var yy = selectedDate.getFullYear();

            var BuxDat = dd + "." + mm + "." + yy;
        //    alert("You've selected=" + DatDocVal);

            document.getElementById('MainContent_HidTekDat').value = BuxDat;

            var BuxKod001 = document.getElementById('MainContent_HidKodDoc').value.substring(0, 3);
            var BuxKod002 = document.getElementById('MainContent_HidKodDoc').value.substring(3, 6);

   //         alert("BuxKod001 =" + BuxKod001);
   //         alert("BuxKod002 =" + BuxKod002);
   //         alert("BuxDat =" + BuxDat);

            if (BuxKod001 != 'xxx') {
                iRowIndex = parseInt(BuxKod001);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc001').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("TopContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
            if (BuxKod002 != 'xxx') {
                iRowIndex = parseInt(BuxKod002);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc002').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("BottomContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
        }

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
            }
        }

        // ------------------------  при выборе ячейки строки  -------------------------------------
        // ------------------------  показать рекламу Клиникаа   ---------------------------------------
        // ------------------------  показать рекламу врача    ---------------------------------------
        // ------------------------  показать описание         ---------------------------------------
        // ------------------------  показать акции            ---------------------------------------  
        // ------------------------  показать третью вкладку (график врача)  -----------------------      
        /*
        function OnClientSelect(sender, selectedRecords) {
            alert("sender=" + sender.ID);
            alert("selectedRecords=" + selectedRecords.cellIndex);

            var AmbCrdIdn = selectedRecords[0].BUXKOD;
            alert("AmbCrdIdn=" + AmbCrdIdn);
        }
        */

        /* календарь назад -----------------------------------------------------------------------*/
        function PrvButton_Click() {
            var BuxKod;
            var BuxFio;
            var BuxDlg;
            var iRowIndex = 0;
            //    alert("PrvButton_Click");
            var PrvDat = document.getElementById('MainContent_HidTekDat').value;
        //    alert("PrvDat=" + PrvDat);
            var PrvDatTxt = PrvDat.substring(3, 5) + "." + PrvDat.substring(0, 2) + "." + PrvDat.substring(6,10);
        //    alert("PrvDatTxt=" + PrvDatTxt);
            var PrvDat000 = new Date(PrvDatTxt);

            PrvDat000.setDate(PrvDat000.getDate() - 7);
            
            var dd = PrvDat000.getDate();
            if (dd < 10) dd = '0' + dd;
            var mm = PrvDat000.getMonth() + 1;
            if (mm < 10) mm = '0' + mm;
            var yy = PrvDat000.getFullYear();

            var BuxDat = dd + "." + mm + "." +  yy;
//            alert(BuxDat);

            document.getElementById('MainContent_HidTekDat').value = BuxDat;
            document.getElementById('MainContent_TextBoxBegDat').value = BuxDat;

           // var BuxKod = document.getElementById('MainContent_HidBuxKod').value;
            var BuxKod001 = document.getElementById('MainContent_HidKodDoc').value.substring(0, 3);
            var BuxKod002 = document.getElementById('MainContent_HidKodDoc').value.substring(3, 6);


    //        alert("BuxKod001 =" + BuxKod001);
    //        alert("BuxKod002 =" + BuxKod002);
   //         alert("BuxDat =" + BuxDat);

            if (BuxKod001 != 'xxx') {
                iRowIndex = parseInt(BuxKod001);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc001').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("TopContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
            if (BuxKod002 != 'xxx') {
                iRowIndex = parseInt(BuxKod002);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc002').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("BottomContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
       
        }

        /* календарь вперед -----------------------------------------------------------------------*/
        function NxtButton_Click() {
            var BuxKod;
            var BuxFio;
            var BuxDlg;
            var iRowIndex = 0;

            //    alert("PrvButton_Click");
            var PrvDat = document.getElementById('MainContent_HidTekDat').value;
            //    alert("PrvDat=" + PrvDat);
            var PrvDatTxt = PrvDat.substring(3, 5) + "." + PrvDat.substring(0, 2) + "." + PrvDat.substring(6, 10);
            //    alert("PrvDatTxt=" + PrvDatTxt);
            var PrvDat000 = new Date(PrvDatTxt);

            PrvDat000.setDate(PrvDat000.getDate() + 7);

            var dd = PrvDat000.getDate();
            if (dd < 10) dd = '0' + dd;
            var mm = PrvDat000.getMonth() + 1;
            if (mm < 10) mm = '0' + mm;
            var yy = PrvDat000.getFullYear();

            var BuxDat = dd + "." + mm + "." + yy;
            //      alert(BuxDat);


            document.getElementById('MainContent_HidTekDat').value = BuxDat;
            document.getElementById('MainContent_TextBoxBegDat').value = BuxDat;

            var BuxKod001 = document.getElementById('MainContent_HidKodDoc').value.substring(0, 3);
            var BuxKod002 = document.getElementById('MainContent_HidKodDoc').value.substring(3, 6);

   //         alert("BuxKod001 =" + BuxKod001);
   //         alert("BuxKod002 =" + BuxKod002);
   //         alert("BuxDat =" + BuxDat);

            if (BuxKod001 != 'xxx') {
                iRowIndex = parseInt(BuxKod001);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc001').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("TopContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
            if (BuxKod002 != 'xxx') {
                iRowIndex = parseInt(BuxKod002);
                BuxKod = GridDoc.Rows[iRowIndex].Cells[0].Value;
                BuxFio = GridDoc.Rows[iRowIndex].Cells[3].Value;
                BuxDlg = GridDoc.Rows[iRowIndex].Cells[4].Value;
                document.getElementById('TxtDoc002').value = BuxFio + ' ' + BuxDlg;
                mySpl0101.loadPage("BottomContent", "RefGlv003ZuxOne.aspx?BuxKod=" + BuxKod + "&BuxDat=" + BuxDat);
            }
        }

        // ------------------------  выбор врача  ------------------------------------------------------------------
// ===============================================================================================================================================================
        function attachFlyoutToLink(oLink, index) {
            try {
		            <%=Flyout1.getClientID()%>.Close();
		            <%=Flyout1.getClientID()%>.AttachTo(oLink.id);
              //   alert('oLink, index=' + oLink + '-'+ index);
                    var sNewHtml = getRecordInfo(oLink, index);
                   document.getElementById("divFlyoutContent").innerHTML = sNewHtml;
		            <%=Flyout1.getClientID()%>.Open();
            } catch (ex) { }
        }

        function closeFlyout() {
            try {
		            <%=Flyout1.getClientID()%>.Close();
                } catch (ex) { };
            }

            function getRecordInfo(oLink, iIndex) {

                var sBUXFIO = GridDoc.Rows[iIndex].Cells[3].Value;
                var sTEL = GridDoc.Rows[iIndex].Cells[5].Value;
             //   alert('sTEL=' + sTEL);

                var sNewHtml = "<table>";
                sNewHtml += "<tr><td class='tdText' nowrap><b>ВРАЧ:</b></td><td class='tdText'>" + sBUXFIO + "</td></tr>";
                sNewHtml += "<tr><td class='tdText' nowrap><b>ТЕЛ:</b></td><td class='tdText'>" + sTEL + "</tr>";
                sNewHtml += "</table>";

                return sNewHtml;
            }
            function ClearKlt() {
                //    alert("KofClose=1" + result);

                document.getElementById('MainContent_HidCntIdn').value = "";
                document.getElementById('MainContent_TextBoxTel').value = "";
                document.getElementById('MainContent_TextBoxIIN').value = "";
                document.getElementById('ctl00$MainContent$TextBoxFio').value = "";
                document.getElementById('MainContent_TextBoxBrt').value = "";
                document.getElementById('MainContent_TextBoxStx').value = "";
                document.getElementById('MainContent_TextBoxInv').value = "";

                document.getElementById('MainContent_HidTextBoxTel').value = "";
                document.getElementById('MainContent_HidTextBoxIIN').value = "";
                document.getElementById('MainContent_HidTextBoxFio').value = "";
                document.getElementById('MainContent_HidTextBoxBrt').value = "";
                document.getElementById('MainContent_HidTextBoxKrt').value = "";    //hashes[5];
                document.getElementById('MainContent_HidTextBoxDsp').value = "";    //hashes[6];
                document.getElementById('MainContent_HidTextBoxStx').value = "";
                document.getElementById('MainContent_HidTextBoxEnd').value = "";    //hashes[8];
                document.getElementById('MainContent_HidTextBoxInv').value = "";;

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
                //         RpnKlt();
            }
    </script>



    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam;
        int DayWek;

        string ComParKey = "0012";
        string ComParCty = "";
        string ComParDat = "";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            HidBuxFrm.Value = BuxFrm;
            HidBuxKod.Value = BuxKod;

            //=====================================================================================
            DayWek =(int) DateTime.Now.DayOfWeek;
            if (DayWek > 0) ComParDat = Convert.ToDateTime(DateTime.Today.AddDays(-DayWek+1)).ToString("dd.MM.yyyy");  // (string)Request.QueryString["GrfDat"];
            else ComParDat = Convert.ToDateTime(DateTime.Today.AddDays(DayWek-6)).ToString("dd.MM.yyyy");
                                                                                                           //      hidBuxDat.Value = ComParDat;
            GlvBegDat = Convert.ToDateTime(ComParDat);
            TextBoxBegDat.Text = ComParDat;
            HidTekDat.Value = ComParDat;
            //=====================================================================================
            //         GridPrc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //            getDocNum();
                //              PopulateTree();

                HidKodDoc.Value = "";
                HidKodDocCop.Value = "xxxxxx";
                LoadGrid();

            }
        }

        protected void LoadGrid()
        {
            //    if (ComParKey == "_tree1") return;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BUXKOD,FI,DLGNAM,KDRTHN FROM SprBuxKdr WHERE BuxUbl=0 AND DLGZAP=1 AND BuxFrm=" + BuxFrm + " ORDER BY FI", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //  cmd.Parameters.Add("@HSPKOD", SqlDbType.VarChar).Value = BuxFrm;
            //  cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = ComParDat;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspRefDoc");

            GridDoc.DataSource = ds;
            GridDoc.DataBind();

            ds.Dispose();
            con.Close();

            //           if (ds.Tables[0].Rows.Count > 0)
            //           {
            //         }
        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------

        protected void GridDoc_RowDataBound(object sender, GridRowEventArgs e)
        {
            string id = e.Row.Cells[0].Text;
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[0].Attributes.Add("onclick", "OnRecordClick(" + id + ")");
            }
        }
     </script>


   <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************ HTML **************************************************** --%>
    <%-- ************************************ HTML **************************************************** --%>
    
    
    <%-- ============================  для передач значении  ============================================ --%>
    <input type="hidden" name="Index" id="par" />
    <asp:HiddenField ID="parPnl" runat="server" />
    <asp:HiddenField ID="parUpd" runat="server" />


    <asp:SqlDataSource runat="server" ID="SdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsMedDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  конец -----------------------------------------------  -->
    <asp:HiddenField ID="hidBuxDat" runat="server" />

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
    <asp:HiddenField ID="HidTekDat" runat="server" />
    <asp:HiddenField ID="HidKodDoc" runat="server" />
    <asp:HiddenField ID="HidKodDocCop" runat="server" />
    
    <asp:HiddenField ID="HidBoxDoc001" runat="server" />
    <asp:HiddenField ID="HidBoxFio001" runat="server" />

          <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="14%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Период</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="30%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О., ИИН</td>
                  <td width="9%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Год.р</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="20%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="9%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страховат.</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Архив</td>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
              </tr>
              
               <tr>
                   <td width="14%" class="PO_RowCap">
                       <input type="button" value="<" style="height: 20px; width: 25px" onclick="PrvButton_Click();" />
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
                       <input type="button" value=">" style="height: 20px; width: 25px" onclick="NxtButton_Click();" />
                   </td>

                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="30%" class="PO_RowCap">
                      <obout:OboutTextBox runat="server" ID="TextBoxFio" Width="68%" BackColor="White" Height="25px"
                             TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                     <ClientSideEvents OnTextChanged="FindKlt" />
                      </obout:OboutTextBox>
                      
                      <input type="button" value="Поиск" style="width:12%"  onclick="FindKlt()" />
                      <input type="button" value="Очистка" style="width:13%"  onclick="ClearKlt()" />
                      <input type="button" value="РПН" style="display:none;"  onclick="RpnKlt()" />
                                            
                  </td>

                  <td width="9%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxInv" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                   </td> 

                   <td width="20%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 
                  <td width="9%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxStx" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
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

                    <asp:Panel ID="Panel1" runat="server" ScrollBars="None" Style="border-style: none; left: 0px; left: 0px; position: relative; top: 0px; width: 100%; height: 20px;">   
                        <input type="button" value="*" style="height: 20px; width: 9%" onclick="ClrButton_Click();" />
                        <input type="button" value="ВРАЧ" style="height: 20px; width: 39%" />
                        <input type="button" value="СПЕЦ"  style="height: 20px; width: 46%" />
                    </asp:Panel>
-->
        <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">

           <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="300">
                <Content>


                   <obout:Grid ID="GridDoc" runat="server"
                    ShowFooter="false"
                    AllowPaging="false"
                    AllowPageSizeSelection="false"
                    FolderLocalization="~/Localization"
                    Language="ru"
                    CallbackMode="true"
                    Serialize="true"
                    AutoGenerateColumns="false"
                    FolderStyle="~/Styles/Grid/style_5"
                    AllowAddingRecords="false"
                    ShowColumnsFooter="false"
                    AllowMultiRecordSelection="true"
                    AllowRecordSelection="true"
                    KeepSelectedRecords="true"
                       OnRowDataBound="GridDoc_RowDataBound"
                    AllowSorting="true"
                    ShowHeader="true"
                    Width="100%"
                    PageSize="-1">
                    <ClientSideEvents OnClientSelect="OnSelect" OnClientCallback="SelectWithImage" />
                        <ScrollingSettings ScrollHeight="500" />
                        <Columns>

                            <obout:Column ID="Column01" DataField="BUXKOD" HeaderText="Врач" ReadOnly="true" Visible="false" Width="0%" />
                            <obout:Column ID="Column02" Width="10%" HeaderText="+">
                                   <TemplateSettings TemplateId="ImageTemplate" />
                            </obout:Column>
                             <obout:Column HeaderText="*" Width="5%" runat="server">
				                  <TemplateSettings  TemplateId="TemplateKdrTel" />
				            </obout:Column>         
                            <obout:Column ID="Column03" DataField="FI" HeaderText="ВРАЧ" Width="40%" Wrap="false" Align="left" />
                            <obout:Column ID="Column04" DataField="DLGNAM" HeaderText="СПЕЦ" ReadOnly="true" Width="45%" Align="left" />
                            <obout:Column ID="Column05" DataField="KDRTHN" HeaderText="" Visible="false" Width="0%" />
 
                        </Columns>

               <Templates>
                    <obout:GridTemplate runat="server" ID="ImageTemplate">
                       <Template>
                             <img src="/Icon/Save.png" name="SelectImage" id="SelectImage_<%# Container.DataItem["BUXKOD"] %>"  alt="" class="hidden" />
                       </Template>
                    </obout:GridTemplate>
                  
                   <obout:GridTemplate runat="server" ID="TemplateKdrTel">
					    <Template>					    
					         <span class="tdTextLink" id="grid_link_<%# Container.DataItem["BUXKOD"] %>" onmouseover="attachFlyoutToLink(this, <%# Container.PageRecordIndex.ToString() %>)" onmouseout="closeFlyout()">*</span>
					    </Template>
				   </obout:GridTemplate>

                </Templates>

              </obout:Grid>

                </Content>
            </LeftPanel>
            <RightPanel>
                <Content>
                      <obspl:HorizontalSplitter ID="mySpl0101" CookieDays="0" runat="server" IsResizable="true" StyleFolder="~/Styles/Splitter">
                            <TopPanel HeightMin="100" HeightMax="400" HeightDefault="300">
                                 <header height="17">
                                     <input type="text" readonly="readonly" id="TxtDoc001" style="background-color:LightYellow;border-style:None;font-weight:bold;height:17px;width:100%;text-align: center" />
				                </header>
                                <Content>
                                </Content>
                            </TopPanel>
                            <BottomPanel HeightDefault="0" HeightMin="600" HeightMax="300">
                                 <header height="17">
                                       <input type="text" readonly="readonly" id="TxtDoc002" style="background-color:LightYellow;border-style:None;font-weight:bold;height:17px;width:100%;text-align: center" />
				                </header>
                                <Content>
                                </Content>
                            </BottomPanel>
                        </obspl:HorizontalSplitter>
                </Content>
            </RightPanel>
        </spl:Splitter>


    </asp:Panel>

	    	<obout:Flyout runat="server" ID="Flyout1" zIndex="100" Align="LEFT" Position="BOTTOM_RIGHT" CloseEvent="NONE" OpenEvent="NONE" DelayTime="500">
		      <div id="divFlyoutContent" style="width: 200px; height: 40px; background-color: #EEEEEE; border: 1px solid #000000;" class="tdText"> 
		        test               
            </div>
        </obout:Flyout>

   <%-- ============================  для windowalert ============================================ 
    
    <div id="divBackground" style="position: fixed; z-index: 999; height: 100%; width: 100%;
        top: 0; left:0; background-color: Black; filter: alpha(opacity=60); opacity: 0.6; -moz-opacity: 0.8;display:none">
    </div>
   
       --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

</asp:Content>


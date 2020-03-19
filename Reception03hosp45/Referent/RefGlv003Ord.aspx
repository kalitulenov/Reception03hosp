<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="RefGlv003Ord.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlv003Ord" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
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
        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function FindKlt() {
 //           alert("FindKlt=" + document.getElementById('ctl00$MainContent$TextBoxFio').value);

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
            else windowalert("Клиент не указан", "Предупреждения", "warning"); 
         } 

        function OnClientDateChangedBeg(sender, selectedDate) {
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
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
            else windowalert("Клиент не указан", "Предупреждения", "warning"); 
        }

        // ------------------------  при выборе ячейки строки  -------------------------------------
        // ------------------------  показать рекламу Клиникаа   ---------------------------------------
        // ------------------------  показать рекламу врача    ---------------------------------------
        // ------------------------  показать описание         ---------------------------------------
        // ------------------------  показать акции            ---------------------------------------  
        // ------------------------  показать третью вкладку (график врача)  -----------------------      
        function onClick(rowIndex, cellIndex) {

       //              alert("cellIndex=" + cellIndex);
       //     var ParBuxHsp = GridGrfDoc.Rows[rowIndex].Cells[2].Value;

            // Панель график по дням
            if (cellIndex > 2 && cellIndex < 16) {
               if (GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value == "") return;

               var ParKltIdn = document.getElementById('MainContent_HidCntIdn').value;
      //         alert("ParKltIdn=" + ParKltIdn);
               var ParKltFio = document.getElementById('ctl00$MainContent$TextBoxFio').value;
        //       alert("ParKltFio=" + ParKltFio);
               var ParKltIin = document.getElementById('MainContent_TextBoxIIN').value;
        //       alert("ParKltIin=" + ParKltIin);
               var ParKltTel = document.getElementById('MainContent_TextBoxTel').value;
       //        alert("ParKltTel=" + ParKltTel);
                //                alert("cellIndex=" + cellIndex + "*" + GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value+"*");
               var ParKltStx = document.getElementById('MainContent_TextBoxStx').value;

                // Проверить на отсутствие графика


                // код врача
                var ParBuxKod = GridGrfDoc.Rows[rowIndex].Cells[0].Value;
        //        alert("ParBuxKod=" + ParBuxKod);
                // Дата
                var ParBuxDat = document.getElementById('MainContent_TextBoxBegDat').value.substring(0,10);
         //                             alert("ParBuxDat=" + ParBuxDat);
                // день
                var ParBuxDay = cellIndex - 2;
         //       alert("ParBuxDay=" + ParBuxDay);

                WinGrfDocDay.setTitle("ГРАФИК ВРАЧА");
                WinGrfDocDay.setUrl("RefGlv003OrdDoc.aspx?ParBuxKod=" + ParBuxKod + "&ParBuxDay=" + ParBuxDay + "&ParBuxDat=" + ParBuxDat +
                                    "&ParKltIdn=" + ParKltIdn + "&ParKltFio=" + ParKltFio + "&ParKltIin=" + ParKltIin + "&ParKltTel=" + ParKltTel);
                WinGrfDocDay.Open();
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
    
    <asp:HiddenField ID="HidBoxDoc001" runat="server" />
    <asp:HiddenField ID="HidBoxFio001" runat="server" />

<div >
          <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="11%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Период</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="30%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О., ИИН</td>
                  <td width="9%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Год.р</td>
                  <td width="20%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страховат.</td>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Запись</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Архив</td>
                  <td width="4%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
              </tr>
              
               <tr>
                   <td width="11%" class="PO_RowCap">
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

                   </td>

                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" ReadOnly="true" />
                  </td> 

                  <td width="30%" class="PO_RowCap">
                      <obout:OboutTextBox runat="server" ID="TextBoxFio" Width="78%" BackColor="White" Height="25px" Font-Size="Large"
                             TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                      </obout:OboutTextBox>
 <!--		                     <ClientSideEvents OnTextChanged="FindKlt" /> -->
                     
                      <input type="button" value="Поиск" style="width:17%"  onclick="FindKlt()" />
                      <input type="button" value="РПН" style="display:none;"  onclick="RpnKlt()" />
                                            
                  </td>

                  <td width="9%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" Font-Size="Large" RunAt="server" BackColor="#FFFFE0" />
                  </td> 

                  <td width="20%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" Font-Size="Large" RunAt="server" BackColor="#FFFFE0" />
                  </td> 

                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxInv" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" Font-Size="Large" RunAt="server" BackColor="#FFFFE0" />
                  </td> 

                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxStx" BorderStyle="None" Width="100%" Height="20" Font-Bold="true" RunAt="server" BackColor="#FFFFE0" />
                  </td>

                  <td width="4%" class="PO_RowCap">
                      <input type="button" value="Зап.по шаблону" style="width:100%"  onclick="SblZapPrm();" />
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <input type="button" value="Архив" style="width:100%"  onclick="ArxKltTit();" />
                  </td>
                  <td width="4%" class="PO_RowCap">
                      <input type="button" value="Титул" style="width:100%"  onclick="PrtKltTit();" />
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

                   <obout:Grid ID="GridGrfDoc" runat="server"
                        ShowFooter="false"
                        CallbackMode="true"
                        Serialize="true"
                        FolderLocalization="~/Localization"
                        Language="ru"
                        AutoGenerateColumns="false"
                        FolderStyle="~/Styles/Grid/style_5"
                        AllowAddingRecords="false"
                        ShowColumnsFooter="false"
                        AllowRecordSelection="false"
                        KeepSelectedRecords="false"
                        OnRowDataBound="OnRowDataBound_Handle"
                        AutoPostBackOnSelect="false"
                        AllowColumnResizing="true"
                        AllowSorting="false"
                        Width="100%"
                        AllowPaging="false"
                        AllowPageSizeSelection="false"
                        PageSize="-1">
                        <ScrollingSettings ScrollHeight="500" />
                        <Columns>
                            <obout:Column ID="Column00" DataField="BUXKOD" HeaderText="Врач" ReadOnly="true" Visible="false" Width="0%" />
                            <obout:Column ID="Column01" DataField="FI" HeaderText="ВРАЧ" Width="8%" Wrap="false" Align="left" />
                            <obout:Column ID="Column02" DataField="DLGNAM" HeaderText="СПЕЦ" ReadOnly="true" Width="7%" Align="left" />
                            <obout:Column ID="Column03" DataField="DAY01" HeaderText="001" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column04" DataField="DAY02" HeaderText="002" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column05" DataField="DAY03" HeaderText="003" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column06" DataField="DAY04" HeaderText="004" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column07" DataField="DAY05" HeaderText="005" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column08" DataField="DAY06" HeaderText="006" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column09" DataField="DAY07" HeaderText="007" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column10" DataField="DAY08" HeaderText="008" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column11" DataField="DAY09" HeaderText="009" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column12" DataField="DAY10" HeaderText="010" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column13" DataField="DAY11" HeaderText="011" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column14" DataField="DAY12" HeaderText="012" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column15" DataField="DAY13" HeaderText="013" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            <obout:Column ID="Column16" DataField="GDE" HeaderText="ГДЕ" ReadOnly="true" Width="7%" Align="left" />
                        </Columns>
                    </obout:Grid>

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
    <owd:Window ID="WinGrfDocDay" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
        Left="300" Top="130" Height="550" Width="800" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="График приема врача">
    </owd:Window>


    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

</asp:Content>


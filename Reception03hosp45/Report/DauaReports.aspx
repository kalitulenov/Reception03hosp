<%@ Page Title="" Language="C#" AutoEventWireup="True" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0,Culture=neutral, PublicKeyToken=89845dcd8080cc91" 
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%-- ================================================================================ 
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
    <%-- ************************************* JQUERY **************************************************** --%>
    <%-- ************************************* JQUERY **************************************************** --%>
    <%-- ************************************* JQUERY **************************************************** --%>

    <!-- для диалога проядок важен --------------------------------------------       -->
   <!-- для диалога проядок важен --------------------------------------------       -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
     <!-- -------------------------------------------------------------------------------- -->

    <%-- ************************************* STYLES **************************************************** --%>
    <%-- ************************************* STYLES **************************************************** --%>
    <%-- ************************************* STYLES **************************************************** --%>

    <style type="text/css">
           html, body, form  
            {  
              margin: 0;  
              padding: 0;  
              height: 100%;  
              overflow: hidden;  
              font-family: Verdana, Tahoma, Arial;  
              font-size: small;  
             }
             
            .spinner {
            	position: fixed;
            	top: 50%;
            	left: 50%;
            	margin-left: -50px; /* half width of the spinner gif */
            	margin-top: -50px; /* half height of the spinner gif */
            	text-align:center;
            	z-index:1234;
            	overflow: auto;
            	width: 150px; /* width of the spinner gif */
            	height: 62px; /*height of the spinner gif +2px to fix IE8 issue */
            	background-color:#E1E1D7; 
            	border:1px solid black;
            }
     </style>


    <%-- ************************************* JAVASCRIPT **************************************************** --%>
    <%-- ************************************* JAVASCRIPT **************************************************** --%>
    <%-- ************************************* JAVASCRIPT **************************************************** --%>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            $(function () {
        //        document.body.innerHTML = document.body.innerHTML.replace('LCID=1033', 'LCID=1049');
        //        document.body.innerHTML = document.body.innerHTML.replace('LCID=1033', 'LCID=1049');

     //           showDatePickerBegin();
     //           showDatePickerEnd();
     //           showDatePickerDate();
            });
        });

        //===========================================================================================
        //=====================     НАЧАЛО                    =======================================
        //===========================================================================================
        function showDatePickerBegin() {
     //       alert("showDatePickerBegin");
            var parameterRow = $("#DauaReport");
            alert('parameterRow: ' + parameterRow.length);
            var innerTable = $(parameterRow).find("table").find("table");
            alert('innerTable: ' + innerTable.length);
            var span = innerTable.find("span:contains('Начало')");
            if (span) {
                alert('Начало: ' + span.length);
                /*   наити начало периода */
                var innerRow = $(span).parent();
                alert('innerRow: ' + innerRow.length);
                var innerCell = innerRow.next("td");
                alert('innerCell: ' + innerCell.length);
                var textFrom = innerCell.find("input[type=text]");
                alert('textFrom: ' + textFrom.length);
                /*   перевод на русский язык */
                $(textFrom).datepicker({ monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
                                                 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
                    dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
                    dateFormat: 'dd.mm.yy',
                    firstDay: 1
                });
                /*   показ начало календаря */
                $(textFrom).datepicker({
                    changeMonth: true,
                    numberOfMonths: 1,
                    onClose: function(selectedDate) {
                        $(textTo).datepicker("option", "minDate", selectedDate);
                    }
                });

                // Для начала нам необходимо отобразить текущую дату:
              //  $(textFrom).datepicker().datepicker("setDate", new Date());

                // показать:
                $(textFrom).focus(function(e) {
                    e.preventDefault();
                    $(textFrom).datepicker("show");
                });

            }
        }

        //===========================================================================================
        //=====================     КОНЕЦ                    =======================================
        //===========================================================================================
        function showDatePickerEnd() {
            var parameterRow = $("#DauaReport");
            var innerTable = $(parameterRow).find("table").find("table");
            var span = innerTable.find("span:contains('Конец')");
            //        $(span).css('color', 'red');
            if (span) {
                /*   наити начало периода */
                var innerRow = $(span).parent();
                var innerCell = innerRow.next("td");
                var textFrom = innerCell.find("input[type=text]");
                /*   перевод на русский язык */
                $(textFrom).datepicker({ monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
                                                 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
                    dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
                    dateFormat: 'dd.mm.yy',
                    firstDay: 1
                });
                /*   показ начало календаря */
                $(textFrom).datepicker({
                    changeMonth: true,
                    numberOfMonths: 1,
                    onClose: function(selectedDate) {
                        $(textTo).datepicker("option", "minDate", selectedDate);
                    }
                });

                // Для начала нам необходимо отобразить текущую дату:
          //      $(textFrom).datepicker().datepicker("setDate", new Date());

                // показать:
                $(textFrom).focus(function(e) {
                    e.preventDefault();
                    $(textFrom).datepicker("show");
                });
            }
        }


        //===========================================================================================
        //=====================     ДАТА                      =======================================
        //===========================================================================================
        function showDatePickerDate() {
            var parameterRow = $("#ctl00$MainContent$DauaReport");
            var innerTable = $(parameterRow).find("table").find("table");
            var span = innerTable.find("span:contains('Дата')");
            if (span) {
                /*   наити начало периода */
                var innerRow = $(span).parent();
                var innerCell = innerRow.next("td");
                var textFrom = innerCell.find("input[type=text]");
                /*   перевод на русский язык */
                $(textFrom).datepicker({ monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
                                                 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
                    dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
                    dateFormat: 'dd.mm.yy',
                    firstDay: 1
                });
                /*   показ начало календаря */
                $(textFrom).datepicker({
                    changeMonth: true,
                    numberOfMonths: 1,
                    onClose: function(selectedDate) {
                        $(textTo).datepicker("option", "minDate", selectedDate);
                    }
                });

                // Для начала нам необходимо отобразить текущую дату:
                $(textFrom).datepicker().datepicker("setDate", new Date());

                // показать:
                $(textFrom).focus(function(e) {
                    e.preventDefault();
                    $(textFrom).datepicker("show");
                });
            }
        }
    </script>

</head>



    <script runat="server">

        string ReportName;
        string ReportPath = "/DauaReports";
        string BuxFrm;
        string TekDocIdn;
        string TekDocKod;
        string TekDocFrm;
        string TekDocBeg;
        string TekDocEnd;
        string TekDocTxt;
        string TekIinBeg;
        string TekIinEnd;
        string TekUchTxt;
        string Cond;
        string MimTyp;
        string GrfIin;
        string UslKod;
        string ImgFil;
        int i = 0;
        string NamTab;


        //       string outputPath = @"C:\Temp\";

        string UsrNam=@"win-sdlrad9r4at\Администратор";
        //       string UsrPss="Siramak70";
        //string UsrPss = "RpJl&LzQ$Kl6";
        string UsrPss = "PANAsonic2018=";

        //     string UsrNam = @"BIGSERVER\Администратор";
        //     string UsrPss = "Acc600900529562";

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];

            ReportName = Convert.ToString(Request.QueryString["ReportName"]);
            TekDocIdn = Convert.ToString(Request.QueryString["TekDocIdn"]);
            TekDocKod = Convert.ToString(Request.QueryString["TekDocKod"]);
            TekDocFrm = Convert.ToString(Request.QueryString["TekDocFrm"]);
            TekDocBeg = Convert.ToString(Request.QueryString["TekDocBeg"]);
            TekDocEnd = Convert.ToString(Request.QueryString["TekDocEnd"]);
            TekIinBeg = Convert.ToString(Request.QueryString["TekIinBeg"]);
            TekIinEnd = Convert.ToString(Request.QueryString["TekIinEnd"]);
            TekDocTxt = Convert.ToString(Request.QueryString["TekDocTxt"]);
            TekUchTxt = Convert.ToString(Request.QueryString["TekUchTxt"]);

            this.Page.Title = ReportName;

            if ((!Page.IsPostBack))
            {

                DauaReport.ServerReport.ReportServerCredentials = new ReportViewerCredentials(UsrNam, UsrPss);
                DauaReport.ServerReport.ReportPath = ReportPath + "/" + ReportName;


                //      Server.MapPath
                //Export to File
                string mimeType, encoding, extension, deviceInfo;
                string[] streamids;
                Microsoft.Reporting.WebForms.Warning[] warnings;
                // А4 вертикаль
                //21 cm - 1.5 cm - 0.5 cm - 0.5 cm = 18.5 cm

                deviceInfo = "<DeviceInfo> " +
                             "<SimplePageHeaders>True</SimplePageHeaders>" +
                             "<OutputFormat>PDF</OutputFormat> " +
                             "<PageWidth>21cm</PageWidth> " +
                             "<PageHeight>29.7cm</PageHeight> " +
                             "<MarginTop>0.5cm</MarginTop> " +
                             "<MarginLeft>0.5cm</MarginLeft> " +
                             "<MarginRight>0.0cm</MarginRight> " +
                             "<MarginBottom>0.0cm</MarginBottom> " +
                             "</DeviceInfo>";

                /*
                               deviceInfo = "<DeviceInfo> " +
                                            "<SimplePageHeaders>True</SimplePageHeaders>" +
                                            "<OutputFormat>PDF</OutputFormat> " +
                                            "<PageWidth>18.5cm</PageWidth> " +
                                            "<PageHeight>29.7cm</PageHeight> " +
                                            "<MarginTop>0.5cm</MarginTop> " +
                                            "<MarginLeft>0.5cm</MarginLeft> " +
                                            "<MarginRight>0.0cm</MarginRight> " +
                                            "<MarginBottom>0.0cm</MarginBottom> " +
                                            "</DeviceInfo>";
               */
                Cond = "NO";
                MimTyp = "jpg";
                NamTab = "AMBUSL";

                string format = "PDF"; //Desired format goes here (PDF, Excel, or Image)

                switch (ReportName)
                {
                    case "HspAmbPrs":
                        ReportParameter[] parameters01 = new ReportParameter[1];
                        parameters01[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters01);
                        break;
                    case "HspAmbNaz":
                        ReportParameter[] parameters02 = new ReportParameter[1];
                        parameters02[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters02);
                        break;
                    case "HspAmbRzp":
                        NamTab = "AMBCRD";
                        Cond = "YES";
                        ReportParameter[] parameters03 = new ReportParameter[2];
                        parameters03[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        parameters03[1] = new ReportParameter("NAZBLN", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters03);
                        break;
                    case "HspAmbNazPrz":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters04 = new ReportParameter[1];
                        parameters04[0] = new ReportParameter("GLVDOCIDN", TekDocIdn, false);
                        this.DauaReport.ServerReport.SetParameters(parameters04);
                        break;
                    case "HspAmbKrtCem":
                        ReportParameter[] parameters05 = new ReportParameter[1];
                        parameters05[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters05);
                        //        format = "Word";
                        break;
                    case "HspAmbStf":
                        ReportParameter[] parameters06 = new ReportParameter[2];
                        parameters06[0] = new ReportParameter("STFIDN", TekDocIdn.ToString(), false);
                        parameters06[1] = new ReportParameter("STFKOD", "1", false);
                        this.DauaReport.ServerReport.SetParameters(parameters06);
                        break;
                    case "HspAmbRpt":
                        ReportParameter[] parameters07 = new ReportParameter[2];
                        parameters07[0] = new ReportParameter("STFIDN", TekDocIdn.ToString(), false);
                        parameters07[1] = new ReportParameter("STFKOD", "2", false);
                        this.DauaReport.ServerReport.SetParameters(parameters07);
                        break;
                    case "HspAmbUzi":
                        Cond = "YES";
                        ReportParameter[] parameters09 = new ReportParameter[1];
                        parameters09[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters09);
                        break;
                    case "HspAmbXry":
                        Cond = "YES";
                        ReportParameter[] parameters10 = new ReportParameter[1];
                        parameters10[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters10);
                        break;
                    case "HspSprZen":
                        ReportParameter[] parameters11 = new ReportParameter[2];
                        parameters11[0] = new ReportParameter("KODHSP", TekDocIdn.ToString(), false);
                        parameters11[1] = new ReportParameter("KODPRC", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters11);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbKrt003":
                        ReportParameter[] parameters12 = new ReportParameter[1];
                        parameters12[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters12);
                        break;
                    case "HspAmbKrtSpz":
                        ReportParameter[] parameters13 = new ReportParameter[1];
                        parameters13[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters13);
                        break;
                    case "HspAmbLab":
                        Cond = "YES";
                        ReportParameter[] parameters14 = new ReportParameter[1];
                        parameters14[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters14);
                        break;
                    case "HspAmbLab002":
                        Cond = "YES";
                        ReportParameter[] parameters15 = new ReportParameter[1];
                        parameters15[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters15);
                        break;
                    case "HspAmbLab003":
                        Cond = "YES";
                        ReportParameter[] parameters16 = new ReportParameter[1];
                        parameters16[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters16);
                        break;
                    case "HspAmbKrtTit":
                        ReportParameter[] parameters17 = new ReportParameter[1];
                        parameters17[0] = new ReportParameter("KLTIIN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters17);
                        break;
                    case "BuxKasPrxOrd":
                        ReportParameter[] parameters18 = new ReportParameter[1];
                        parameters18[0] = new ReportParameter("KASIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters18);
                        break;
                    case "HspAmbKrtDnt":
                        ReportParameter[] parameters19 = new ReportParameter[1];
                        parameters19[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters19);
                        break;
                    case "HspRefGlvScr":
                        ReportParameter[] parameters20 = new ReportParameter[5];
                        parameters20[0] = new ReportParameter("GRFDLG", TekDocIdn.ToString(), false);
                        parameters20[1] = new ReportParameter("GRFKOD", TekDocKod.ToString(), false);
                        parameters20[2] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters20[3] = new ReportParameter("GRFBEGRAS", TekDocBeg.ToString(), false);
                        parameters20[4] = new ReportParameter("GRFENDRAS", TekDocEnd.ToString(), false);
                        //          parameters20[3] = new ReportParameter("GRFBEGRAS", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //          parameters20[4] = new ReportParameter("GRFENDRAS", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        //                  parameters20[3] = new ReportParameter("GRFBEGRAS", Convert.ToDateTime(BegDat).ToString("dd.MM.yyyy"), false);
                        //                  parameters20[4] = new ReportParameter("GRFENDRAS", Convert.ToDateTime(EndDat).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters20);
                        break;
                    case "HspDocAppLst":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters21 = new ReportParameter[5];
                        parameters21[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters21[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters21[2] = new ReportParameter("GLVDOCTYP", TekDocIdn.ToString(), false);
                        parameters21[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters21[4] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters21);
                        break;
                    case "HspAmbUzi001":
                        Cond = "YES";
                        MimTyp = "pdf";
                        ReportParameter[] parameters22 = new ReportParameter[1];
                        parameters22[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters22);
                        break;
                    case "HspAmbUzi002":
                        Cond = "YES";
                        MimTyp = "pdf";
                        ReportParameter[] parameters23 = new ReportParameter[1];
                        parameters23[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters23);
                        break;
                    case "HspAmbUzi003":
                        Cond = "YES";
                        MimTyp = "pdf";
                        ReportParameter[] parameters24 = new ReportParameter[1];
                        parameters24[0] = new ReportParameter("AMBUSLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters24);
                        break;
                    case "HspAmbPrsAll":
                        ReportParameter[] parameters25 = new ReportParameter[1];
                        parameters25[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters25);
                        break;
                    case "HspSttZapPrm":
                        ReportParameter[] parameters26 = new ReportParameter[3];
                        //           parameters26[0] = new ReportParameter("GRFDLG", TekDocIdn.ToString(), false);
                        //           parameters26[1] = new ReportParameter("GRFKOD", TekDocKod.ToString(), false);
                        parameters26[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters26[1] = new ReportParameter("GRFBEGRAS", TekDocBeg.ToString(), false);
                        parameters26[2] = new ReportParameter("GRFENDRAS", TekDocEnd.ToString(), false);
                        //          parameters20[3] = new ReportParameter("GRFBEGRAS", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //          parameters20[4] = new ReportParameter("GRFENDRAS", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        //                  parameters20[3] = new ReportParameter("GRFBEGRAS", Convert.ToDateTime(BegDat).ToString("dd.MM.yyyy"), false);
                        //                  parameters20[4] = new ReportParameter("GRFENDRAS", Convert.ToDateTime(EndDat).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters26);
                        break;
                    case "HspAmbStzDry":
                        ReportParameter[] parameters27 = new ReportParameter[1];
                        parameters27[0] = new ReportParameter("DRYIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters27);
                        break;
                    case "HspAmbStzEpi":
                        ReportParameter[] parameters28 = new ReportParameter[1];
                        parameters28[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters28);
                        break;
                    case "HspAmbKrtStz":
                        ReportParameter[] parameters29 = new ReportParameter[1];
                        parameters29[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters29);
                        break;
                    case "BuxPrxDoc":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters30 = new ReportParameter[1];
                        parameters30[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters30);
                        break;
                    case "BuxPrmDoc":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters31 = new ReportParameter[1];
                        parameters31[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters31);
                        break;
                    case "HspSttPltUsl":
                        ReportParameter[] parameters32 = new ReportParameter[3];
                        parameters32[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters32[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters32[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters32);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "BuxDovDoc":
                        ReportParameter[] parameters33 = new ReportParameter[1];
                        parameters33[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters33);
                        break;
                    case "BuxAktDoc":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters34 = new ReportParameter[1];
                        parameters34[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters34);
                        break;
                    case "BuxFktDoc":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters35 = new ReportParameter[1];
                        parameters35[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters35);
                        break;
                    case "BuxVozDoc":
                        ReportParameter[] parameters36 = new ReportParameter[1];
                        parameters36[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters36);
                        break;
                    case "HspDocAppRsx":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters37 = new ReportParameter[6];
                        parameters37[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters37[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters37[2] = new ReportParameter("GLVDOCTYP", TekDocIdn.ToString(), false);
                        parameters37[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters37[4] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        parameters37[5] = new ReportParameter("RSXTXT", TekDocTxt.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters37);
                        break;
                    case "BuxKasRsxOrd":
                        ReportParameter[] parameters38 = new ReportParameter[1];
                        parameters38[0] = new ReportParameter("KASIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters38);
                        break;
                    case "BuxKasJrn":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters39 = new ReportParameter[5];
                        parameters39[0] = new ReportParameter("KASFRM", TekDocFrm.ToString(), false);
                        parameters39[1] = new ReportParameter("KASACC", TekDocIdn.ToString(), false);
                        parameters39[2] = new ReportParameter("KASBUX", TekDocKod.ToString(), false);
                        parameters39[3] = new ReportParameter("KASBEGDAT", TekDocBeg.ToString(), false);
                        parameters39[4] = new ReportParameter("KASENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters39);
                        //       format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "BuxAbn":
                        ReportParameter[] parameters40 = new ReportParameter[1];
                        parameters40[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters40);
                        break;
                    case "HspSttDocStx":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters41 = new ReportParameter[3];
                        parameters41[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters41[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters41[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters41);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbKrtCemAll":
                        ReportParameter[] parameters42 = new ReportParameter[5];
                        parameters42[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters42[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters42[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        parameters42[3] = new ReportParameter("GLVBEGIIN", TekIinBeg.ToString(), false);
                        parameters42[4] = new ReportParameter("GLVENDIIN", TekIinEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters42);
                        break;
                    case "HspAmbKrtCemOne":
                        ReportParameter[] parameters43 = new ReportParameter[2];
                        parameters43[0] = new ReportParameter("FIOLST", TekDocIdn, false);
                        parameters43[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters43);
                        break;
                    case "BuxAktDocKas":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters44 = new ReportParameter[1];
                        parameters44[0] = new ReportParameter("KASIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters44);
                        break;
                    case "BuxKasBok":
                        ReportParameter[] parameters45 = new ReportParameter[5];
                        parameters45[0] = new ReportParameter("KASFRM", TekDocFrm.ToString(), false);
                        parameters45[1] = new ReportParameter("KASACC", TekDocIdn.ToString(), false);
                        parameters45[2] = new ReportParameter("KASBUX", TekDocKod.ToString(), false);
                        parameters45[3] = new ReportParameter("KASBEGDAT", TekDocBeg.ToString(), false);
                        parameters45[4] = new ReportParameter("KASENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters45);
                        break;
                    case "HspSttStxDoc":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters46 = new ReportParameter[3];
                        parameters46[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters46[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters46[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters46);
                        break;
                    case "HspSttStxDocSvd":
                        ReportParameter[] parameters47 = new ReportParameter[3];
                        parameters47[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters47[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters47[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters47);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttDocStxUslSvd":
                        ReportParameter[] parameters48 = new ReportParameter[3];
                        parameters48[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters48[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters48[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters48);
                        break;
                    case "BuxKasAnl":
                        ReportParameter[] parameters49 = new ReportParameter[4];
                        parameters49[0] = new ReportParameter("KASFRM", TekDocFrm.ToString(), false);
                        parameters49[1] = new ReportParameter("KASBUX", TekDocKod.ToString(), false);
                        parameters49[2] = new ReportParameter("KASBEGDAT", TekDocBeg.ToString(), false);
                        parameters49[3] = new ReportParameter("KASENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters49);
                        break;
                    case "HspSttUslFioDoc":
                        if (BuxFrm == "12") DauaReport.ServerReport.ReportPath = ReportPath + "/HspSttUslFioDocKrd";
                        ReportParameter[] parameters50 = new ReportParameter[2];
                        parameters50[0] = new ReportParameter("BUXFRM", BuxFrm.ToString(), false);
                        parameters50[1] = new ReportParameter("BUXFRM2", BuxFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters50);

                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "BuxKasExpExl":
                        ReportParameter[] parameters51 = new ReportParameter[4];
                        parameters51[0] = new ReportParameter("KASFRM", TekDocFrm.ToString(), false);
                        parameters51[1] = new ReportParameter("KASBUX", TekDocKod.ToString(), false);
                        parameters51[2] = new ReportParameter("KASBEGDAT", TekDocBeg.ToString(), false);
                        parameters51[3] = new ReportParameter("KASENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters51);
                        format = "Excel";
                        break;
                    case "BuxPrvJrn":
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters52 = new ReportParameter[4];
                        parameters52[0] = new ReportParameter("PRVFRM", TekDocFrm.ToString(), false);
                        parameters52[1] = new ReportParameter("PRVBUX", TekDocKod.ToString(), false);
                        parameters52[2] = new ReportParameter("PRVBEGDAT", TekDocBeg.ToString(), false);
                        parameters52[3] = new ReportParameter("PRVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters52);
                        break;
                    case "BuxChtDoc":
                        ReportParameter[] parameters53 = new ReportParameter[1];
                        parameters53[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters53);
                        break;
                    case "HspDocFioLst":
                        ReportParameter[] parameters54 = new ReportParameter[4];
                        parameters54[0] = new ReportParameter("FIOLST", TekDocIdn.ToString(), false);
                        parameters54[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters54[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters54[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters54);
                        break;
                    case "HspSttDocUslAdv":
                        ReportParameter[] parameters55 = new ReportParameter[1];
                        parameters55[0] = new ReportParameter("BUXFRM", BuxFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters55);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspPrfKrt":
                        ReportParameter[] parameters56 = new ReportParameter[1];
                        parameters56[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters56);
                        break;
                    case "HspAmbKrtPth":
                        ReportParameter[] parameters57 = new ReportParameter[1];
                        parameters57[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters57);
                        break;
                    case "HspAmbKrtDntZakNar":
                        ReportParameter[] parameters58 = new ReportParameter[1];
                        parameters58[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters58);
                        break;
                    case "HspDocFioLstAdv":
                        ReportParameter[] parameters59 = new ReportParameter[4];
                        parameters59[0] = new ReportParameter("FIOLST", TekDocIdn.ToString(), false);
                        parameters59[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters59[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters59[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters59);
                        break;
                    case "HspTblGrf":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters60 = new ReportParameter[4];
                        parameters60[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters60[1] = new ReportParameter("LENKEY", TekDocKod.ToString(), false);
                        parameters60[2] = new ReportParameter("TREKEY", TekDocTxt.ToString(), false);
                        parameters60[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters60);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)

                        break;
                    case "HspDocFioLstDoc":
                        ReportParameter[] parameters61 = new ReportParameter[4];
                        parameters61[0] = new ReportParameter("FIOLST", TekDocIdn.ToString(), false);
                        parameters61[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters61[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters61[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters61);
                        break;
                    case "HspSttStxUslFio":
                        ReportParameter[] parameters62 = new ReportParameter[1];
                        parameters62[0] = new ReportParameter("BUXFRM", BuxFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters62);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttUslSvd":
                        ReportParameter[] parameters63 = new ReportParameter[3];
                        parameters63[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters63[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters63[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters63);
                        break;
                    case "BuxCshPrxOrd":
                        ReportParameter[] parameters64 = new ReportParameter[1];
                        parameters64[0] = new ReportParameter("KASIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters64);
                        break;
                    case "HspDocAppLstStz":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters65 = new ReportParameter[5];
                        parameters65[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters65[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters65[2] = new ReportParameter("GLVDOCTYP", TekDocIdn.ToString(), false);
                        parameters65[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters65[4] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters65);
                        break;
                    case "HspGrfRab":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters66 = new ReportParameter[4];
                        parameters66[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters66[1] = new ReportParameter("LENKEY", TekDocKod.ToString(), false);
                        parameters66[2] = new ReportParameter("TREKEY", TekDocTxt.ToString(), false);
                        parameters66[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters66);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprZenAdv":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";
                        ReportParameter[] parameters67 = new ReportParameter[1];
                        parameters67[0] = new ReportParameter("KODHSP", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters67);
                        break;
                    case "BuxPltPor":
                        ReportParameter[] parameters68 = new ReportParameter[1];
                        parameters68[0] = new ReportParameter("BNKIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters68);
                        break;
                    case "HspDocAisSvd":
                        ReportParameter[] parameters69 = new ReportParameter[4];
                        parameters69[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters69[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters69[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters69[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters69);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisKrt":
                        ReportParameter[] parameters70 = new ReportParameter[4];
                        parameters70[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters70[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters70[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters70[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters70);
                        break;
                    case "HspRefMrtLst":
                        ReportParameter[] parameters71 = new ReportParameter[1];
                        parameters71[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters71);
                        break;
                    case "HspSttDocErr":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";
                        ReportParameter[] parameters72 = new ReportParameter[4];
                        parameters72[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters72[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters72[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        parameters72[3] = new ReportParameter("BUXTYP", "PRT", false);
                        this.DauaReport.ServerReport.SetParameters(parameters72);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisSvdMkb":
                        ReportParameter[] parameters73 = new ReportParameter[4];
                        parameters73[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters73[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters73[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters73[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters73);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisSvdIin":
                        ReportParameter[] parameters74 = new ReportParameter[4];
                        parameters74[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters74[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters74[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters74[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters74);
                        break;
                    case "HspDocAisSvdDoc":
                        ReportParameter[] parameters75 = new ReportParameter[4];
                        parameters75[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters75[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters75[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters75[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters75);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttZapPrmSvd":
                        ReportParameter[] parameters76 = new ReportParameter[3];
                        parameters76[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters76[1] = new ReportParameter("GRFBEGRAS", TekDocBeg.ToString(), false);
                        parameters76[2] = new ReportParameter("GRFENDRAS", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters76);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttDocStxSvd":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters77 = new ReportParameter[3];
                        parameters77[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters77[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters77[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters77);
                        break;
                    case "HspDocAis025":
                        ReportParameter[] parameters78 = new ReportParameter[2];
                        parameters78[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters78[1] = new ReportParameter("KLTIIN", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters78);
                        break;
                    case "HspDopKrtCem":
                        ReportParameter[] parameters79 = new ReportParameter[1];
                        parameters79[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters79);
                        break;
                    case "HspDopKrtTit":
                        ReportParameter[] parameters80 = new ReportParameter[1];
                        parameters80[0] = new ReportParameter("KLTIIN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters80);
                        break;
                    case "HspDocAisErrKrt":
                        ReportParameter[] parameters81 = new ReportParameter[4];
                        parameters81[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters81[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters81[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters81[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters81);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbKrtQrc":
                        ReportParameter[] parameters82 = new ReportParameter[1];
                        parameters82[0] = new ReportParameter("KLTIIN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters82);
                        break;
                    case "HspDocAppLstDoc":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters83 = new ReportParameter[5];
                        parameters83[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters83[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters83[2] = new ReportParameter("GLVDOCTYP", TekDocIdn.ToString(), false);
                        parameters83[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters83[4] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters83);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAppLstIIN":
                        ReportParameter[] parameters84 = new ReportParameter[1];
                        parameters84[0] = new ReportParameter("BUXFRM", BuxFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters84);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttOrgRpt":
                        ReportParameter[] parameters85 = new ReportParameter[2];
                        parameters85[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters85[1] = new ReportParameter("BUXKEYORG", TekDocKod.ToString(), false);
                        //          parameters85[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        //          parameters85[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters85);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocBolLst":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters86 = new ReportParameter[3];
                        parameters86[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters86[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters86[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters86);
                        break;
                    case "HspAmbBolIdnPrt":
                        ReportParameter[] parameters87 = new ReportParameter[1];
                        parameters87[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters87);
                        break;
                    case "HspAmb095Prt":
                        ReportParameter[] parameters88 = new ReportParameter[1];
                        parameters88[0] = new ReportParameter("BOLIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters88);
                        break;
                    case "HspSprBux":
                        ReportParameter[] parameters89 = new ReportParameter[3];
                        parameters89[0] = new ReportParameter("BUXSID", TekDocIdn.ToString(), false);
                        parameters89[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters89[2] = new ReportParameter("BUXUBL", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters89);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprBuxMnu":
                        ReportParameter[] parameters90 = new ReportParameter[1];
                        parameters90[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters90);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprBuxUsl":
                        ReportParameter[] parameters91 = new ReportParameter[2];
                        parameters91[0] = new ReportParameter("BUXPRC", TekDocIdn.ToString(), false);
                        parameters91[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters91);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprBuxGrf":
                        ReportParameter[] parameters92 = new ReportParameter[1];
                        parameters92[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters92);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprKdr":
                        ReportParameter[] parameters93 = new ReportParameter[1];
                        parameters93[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters93);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSprCntUsl":
                        ReportParameter[] parameters94 = new ReportParameter[2];
                        parameters94[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters94[1] = new ReportParameter("BUXCNTKEY", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters94);
                        //      format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbLabUslBln":
                        ReportParameter[] parameters95 = new ReportParameter[3];
                        parameters95[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters95[1] = new ReportParameter("USLDAT", TekDocBeg.ToString(), false);
                        parameters95[2] = new ReportParameter("USLKOD", TekDocKod.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters95);
                        //      format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "BuxKasSvd":
                        ReportParameter[] parameters96 = new ReportParameter[3];
                        parameters96[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters96[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters96[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters96);
                        break;
                    case "HspRefMrtLstIin":
                        ReportParameter[] parameters97 = new ReportParameter[3];
                        parameters97[0] = new ReportParameter("GRFIIN", TekDocIdn.ToString(), false);
                        parameters97[1] = new ReportParameter("GRFFRM", TekDocFrm.ToString(), false);
                        parameters97[2] = new ReportParameter("GRFDAT", TekDocBeg.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters97);
                        break;
                    case "HspAisScrLst":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters98 = new ReportParameter[6];
                        parameters98[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters98[1] = new ReportParameter("BUXCHL", TekDocKod.ToString(), false);
                        parameters98[2] = new ReportParameter("BUXUCH", TekDocIdn.ToString(), false);
                        parameters98[3] = new ReportParameter("BUXBEG", TekDocBeg.ToString(), false);
                        parameters98[4] = new ReportParameter("BUXEND", TekDocEnd.ToString(), false);
                        parameters98[5] = new ReportParameter("BUXSEX", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters98);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttMkbSvd":
                        ReportParameter[] parameters99 = new ReportParameter[3];
                        parameters99[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters99[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters99[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters99);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttZapPrmKrd":
                        ReportParameter[] parameters100 = new ReportParameter[3];
                        parameters100[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters100[1] = new ReportParameter("GRFBEGRAS", TekDocBeg.ToString(), false);
                        parameters100[2] = new ReportParameter("GRFENDRAS", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters100);
                        break;
                    case "HspSttPltUslFil":
                        ReportParameter[] parameters101 = new ReportParameter[3];
                        parameters101[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters101[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters101[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters101);
                        break;
                    case "HspSttPltUslKrd":
                        ReportParameter[] parameters102 = new ReportParameter[3];
                        parameters102[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters102[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters102[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters102);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttStxDocSvdKrd":
                        ReportParameter[] parameters103 = new ReportParameter[3];
                        parameters103[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters103[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters103[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        //                        parameters21[3] = new ReportParameter("GLVBEGDAT", Convert.ToDateTime(TekDocBeg).ToString("dd.MM.yyyy"), false);
                        //                        parameters21[4] = new ReportParameter("GLVENDDAT", Convert.ToDateTime(TekDocEnd).ToString("dd.MM.yyyy"), false);
                        this.DauaReport.ServerReport.SetParameters(parameters103);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttDocStxUslSvdKrd":
                        ReportParameter[] parameters104 = new ReportParameter[3];
                        parameters104[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters104[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters104[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters104);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbKrtPed":
                        ReportParameter[] parameters105 = new ReportParameter[1];
                        parameters105[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters105);
                        break;
                    case "HspAmbLabUslFio":
                        ReportParameter[] parameters106 = new ReportParameter[1];
                        parameters106[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters106);
                        break;
                    case "HspAmbPrsOne":
                        ReportParameter[] parameters107 = new ReportParameter[1];
                        parameters107[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters107);
                        break;
                    case "HspAmbKrtPrv":
                        ReportParameter[] parameters108 = new ReportParameter[1];
                        parameters108[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters108);
                        break;
                    case "HspAmbKrtEnd":
                        ReportParameter[] parameters109 = new ReportParameter[1];
                        parameters109[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters109);
                        break;
                    case "HspDopKrtCemAll":
                        ReportParameter[] parameters110 = new ReportParameter[6];
                        parameters110[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters110[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters110[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        parameters110[3] = new ReportParameter("GLVBEGIIN", TekIinBeg.ToString(), false);
                        parameters110[4] = new ReportParameter("GLVENDIIN", TekIinEnd.ToString(), false);
                        parameters110[5] = new ReportParameter("BUXUCH", TekUchTxt.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters110);
                        break;
                    case "HspAmbKrtTitAll":
                        ReportParameter[] parameters111 = new ReportParameter[2];
                        parameters111[0] = new ReportParameter("GLVBEGIIN", TekIinBeg.ToString(), false);
                        parameters111[1] = new ReportParameter("GLVENDIIN", TekIinEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters111);
                        break;
                    case "BuxKasChk":
                        ReportParameter[] parameters112 = new ReportParameter[1];
                        parameters112[0] = new ReportParameter("KASIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters112);
                        break;
                    case "HspDocAisFioKrt":
                        ReportParameter[] parameters113 = new ReportParameter[4];
                        parameters113[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters113[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters113[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters113[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters113);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisDocKrt":
                        ReportParameter[] parameters114 = new ReportParameter[4];
                        parameters114[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters114[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters114[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters114[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters114);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisTrfKrt":
                        ReportParameter[] parameters115 = new ReportParameter[4];
                        parameters115[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters115[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters115[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters115[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters115);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAppLst086Prt":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";
                        ReportParameter[] parameters116 = new ReportParameter[4];
                        parameters116[0] = new ReportParameter("GLVDOCTYP", TekDocKod.ToString(), false);
                        parameters116[1] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters116[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters116[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters116);
                        break;
                    case "HspDopAppLst":
                        // А4 горизонталь

                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters117 = new ReportParameter[5];
                        parameters117[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters117[1] = new ReportParameter("BUXKOD", TekDocKod.ToString(), false);
                        parameters117[2] = new ReportParameter("GLVDOCTYP", TekDocIdn.ToString(), false);
                        parameters117[3] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters117[4] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters117);
                        break;
                    case "HspSttIinUsl":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters118 = new ReportParameter[3];
                        parameters118[0] = new ReportParameter("BUXFRM", TekDocFrm.ToString(), false);
                        parameters118[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters118[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters118);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspSttNapVopUsk":
                        // А4 горизонталь
                        deviceInfo = "<DeviceInfo> " +
                                     "<SimplePageHeaders>True</SimplePageHeaders>" +
                                     "<OutputFormat>PDF</OutputFormat> " +
                                     "<PageWidth>29.7cm</PageWidth> " +
                                     "<PageHeight>21cm</PageHeight> " +
                                     "<MarginTop>0.5cm</MarginTop> " +
                                     "<MarginLeft>0.5cm</MarginLeft> " +
                                     "<MarginRight>0.0cm</MarginRight> " +
                                     "<MarginBottom>0.0cm</MarginBottom> " +
                                     "</DeviceInfo>";

                        ReportParameter[] parameters119 = new ReportParameter[3];
                        parameters119[0] = new ReportParameter("GRFFRM", TekDocFrm.ToString(), false);
                        parameters119[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters119[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters119);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAisNap":
                        ReportParameter[] parameters120 = new ReportParameter[1];
                        parameters120[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters120);
                        break;
                    case "HspSttNaz":
                        // А4 горизонталь
                        //deviceInfo = "<DeviceInfo> " +
                        //             "<SimplePageHeaders>True</SimplePageHeaders>" +
                        //             "<OutputFormat>PDF</OutputFormat> " +
                        //             "<PageWidth>29.7cm</PageWidth> " +
                        //             "<PageHeight>21cm</PageHeight> " +
                        //             "<MarginTop>0.5cm</MarginTop> " +
                        //             "<MarginLeft>0.5cm</MarginLeft> " +
                        //             "<MarginRight>0.0cm</MarginRight> " +
                        //             "<MarginBottom>0.0cm</MarginBottom> " +
                        //             "</DeviceInfo>";

                        ReportParameter[] parameters121 = new ReportParameter[3];
                        parameters121[0] = new ReportParameter("GRFFRM", TekDocFrm.ToString(), false);
                        parameters121[1] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters121[2] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters121);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocStzNap":
                        ReportParameter[] parameters122 = new ReportParameter[1];
                        parameters122[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters122);
                        break;
                    case "HspSttNazPrz":
                        ReportParameter[] parameters123 = new ReportParameter[4];
                        parameters123[0] = new ReportParameter("GRFFRM", TekDocFrm.ToString(), false);
                        parameters123[1] = new ReportParameter("GRFKOD", TekDocKod.ToString(), false);
                        parameters123[2] = new ReportParameter("GLVBEGDAT", TekDocBeg.ToString(), false);
                        parameters123[3] = new ReportParameter("GLVENDDAT", TekDocEnd.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters123);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspDocAppLstDocAll":
                        ReportParameter[] parameters124 = new ReportParameter[1];
                        parameters124[0] = new ReportParameter("BUXFRM", BuxFrm.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters124);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "EodLstGrdOne061":
                        ReportParameter[] parameters125 = new ReportParameter[1];
                        parameters125[0] = new ReportParameter("EODIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters125);
                        format = "NONE"; //Desired format goes here (PDF, Excel, or Image)
                        break;
                    case "HspAmbSgnKrt":
                        ReportParameter[] parameters126 = new ReportParameter[1];
                        parameters126[0] = new ReportParameter("GLVDOCIDN", TekDocIdn.ToString(), false);
                        this.DauaReport.ServerReport.SetParameters(parameters126);
                        break;
                    default:
                        break;
                }

                if (format != "NONE")
                {
                    //      string format = "PDF"; //Desired format goes here (PDF, Excel, or Image)

                    //      string format = "Excel";

                    //                string format = "Image";
                    //                encoding = String.Empty;
                    //               mimeType = "image/jpeg";
                    //               extension = "jpeg";
                    //               deviceInfo = "<DeviceInfo>" + "<SimplePageHeaders>True</SimplePageHeaders>" + "</DeviceInfo>";
                    byte[] bytes = DauaReport.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                    Response.Clear();
                    Response.Buffer = true;

                    if (format == "PDF")
                    {
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("Content-disposition", "filename=" + ReportName + ".pdf");
                    }
                    if (format == "Excel")
                    {
                        Response.ContentType = "application/excel";
                        Response.AddHeader("Content-disposition", "filename=" + ReportName + ".xls");
                    }
                    if (format == "IMAGE")
                    {
                        Response.ContentType = "application/jpeg";
                        Response.AddHeader("Content-disposition", "filename=" + ReportName + ".jpeg");
                    }
                    if (format == "Word")
                    {
                        Response.ContentType = "application/msword";
                        Response.AddHeader("Content-disposition", "filename=" + ReportName + ".doc");
                    }

                    Response.OutputStream.Write(bytes, 0, bytes.Length);
                    Response.OutputStream.Flush();
                    Response.OutputStream.Close();
                    Response.Flush();
                    //            Response.Close();


                    //To View Report
                    //   this.DauaReport.ServerReport.Refresh();


                    // ============================= ЗАПИСЬ НА ДИСК ========================================================
                    if (Cond == "YES")
                    {

                        // ПОЛУЧИТЬ ДАННЫЕ ИЗ БАЗЫ ===========================================================================================
                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("HspAmbUslPrt", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = TekDocIdn;
                        cmd.Parameters.Add("@NAMTAB", SqlDbType.VarChar).Value = NamTab;

                        // создание DataAdapter
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "HspAmbUslPrt");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            BuxFrm = Convert.ToString(ds.Tables[0].Rows[0]["GRFFRM"]);
                            GrfIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]) + "____________";

                            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
                            string Papka = @"C:\BASEIMG\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
                            ImgFil = Papka + @"\" + GrfIin.Substring(0, 12) + "_" + Convert.ToInt32(TekDocIdn).ToString("D10");
                            if (MimTyp == "jpg") ImgFil = ImgFil + ".jpg";
                            if (MimTyp == "pdf") ImgFil = ImgFil + ".pdf";

                            // поверить каталог, если нет создать ----------------------------------------------------------------
                            if (Directory.Exists(Papka)) i = 0;
                            else Directory.CreateDirectory(Papka);

                            // проверить если фаил есть удалить ----------------------------------------------------------------
                            if (File.Exists(ImgFil)) File.Delete(ImgFil);

                            // КОПИРОВАТЬ ФАЙЛ НА ДИСК ===========================================================================================
                            if (MimTyp == "jpg")
                            {
                                format = "Image";
                                encoding = String.Empty;
                                mimeType = "image/jpeg";
                                extension = "jpeg";
                            }

                            if (MimTyp == "pdf")
                            {
                                format = "PDF";
                                encoding = String.Empty;
                                mimeType = "";
                                extension = "pdf";
                            }

                            byte[] bytesImg = DauaReport.ServerReport.Render(format, string.Empty, out mimeType, out encoding, out extension, out streamids, out warnings);
                            using (FileStream fs = new FileStream(ImgFil, FileMode.Create))
                            {
                                fs.Write(bytesImg, 0, bytesImg.Length);
                                fs.Close();
                            }

                            // ЗАПИСАТЬ НА ДИСК МЕСТОПОЛОЖЕНИЕ ===========================================================================================
                            if (NamTab == "AMBCRD")
                            {
                                SqlCommand cmdUsl = new SqlCommand("UPDATE AMBCRD SET GRFPRSJPG='" + ImgFil + "' WHERE GRFIDN=" + TekDocIdn, con);
                                cmdUsl.ExecuteNonQuery();
                                con.Close();
                            }
                            else
                            {
                                SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLXLS='" + ImgFil + "' WHERE USLIDN=" + TekDocIdn, con);
                                cmdUsl.ExecuteNonQuery();
                                con.Close();
                            }
                        }

                    }

                    // =====================================================================================
                }


            }
        }

        string returnValue;
        /*
                string ICallbackEventHandler.GetCallbackResult()
                {
                    return returnValue;
                }


                void ICallbackEventHandler.RaiseCallbackEvent(string eventArgument)
                {
                    //      returnValue = AjaxCall(eventArgument);
                }  

         * */

  </script>
               

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML ****************************************************  
                <div id="divMain">
               <rsweb:ReportViewer ID="DauaReport" 
                      runat="server" 
                      Width="100%" 
                      Height="100%"
        ShowRefreshButton="False"
                      ProcessingMode="Remote" ShowBackButton="false" ShowPrintButton="true" ShowReportBody="true"  ShowExportControls="true" >
             <ServerReport ReportServerUrl="http://localhost:8080/ReportServer" />
         </rsweb:ReportViewer> 
           </div>
        <iframe id="frmPrint" name="frmPrint" runat="server" style = "display:none"></iframe>
      
           <div id="spinner" class="spinner" style="display:none;">
               <table align="center" style="height:100%;width:100%">
                   <tr>
                      <td><img id="img-spinner" src="/Logo/ajax-loader.gif" alt="Печатается..."/></td>
                      <td><span style="font-family:Verdana; font-weight:bold;font-size:10pt;width:86px;">Printing...</span></td>
                   </tr>
              </table>
          </div>
  
        --%>

<body>

    <form id="form1" runat="server">    

       <asp:ScriptManager ID="ScriptManager1"  EnablePageMethods="true" EnablePartialRendering="true" runat="server"> </asp:ScriptManager>

        <div id="divMain">
             <rsweb:ReportViewer ID="DauaReport" 
                    runat="server" 
                    Width="100%" 
                    Height="950px"
                    ShowRefreshButton="False"
                    ProcessingMode="Remote" 
                    ShowBackButton="false" 
                    ShowPrintButton="true" 
                    ShowReportBody="true"  
                    ShowExportControls="true" >
                    <ServerReport ReportServerUrl="http://localhost/ReportServer" />
             </rsweb:ReportViewer> 
        </div>

   
        <div id="spinner" class="spinner" style="display:none;">
             <table align="center" style="height:100%;width:100%">
                 <tr>
                    <td><img id="img-spinner" src="/JS/ajax-loader.gif" alt="Печатается..."/></td>
                    <td><span style="font-family:Verdana; font-weight:bold;font-size:10pt;width:86px;">Printing...</span></td>
                 </tr>
             </table>
        </div>
 
     
    <%-- ************************************* Конец **************************************************** --%>
    <%-- ************************************* Конец **************************************************** --%>
    <%-- ************************************* Конец **************************************************** --%>
    </form>

</body>
</html>
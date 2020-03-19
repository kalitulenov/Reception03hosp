<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">

        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
        //    alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var GrfDocRek;
            var GrfDocVal = newText;
            var GrfDocTyp = 'Str';

            switch (sender) {
                case 'DigSbl':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&01&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl':
                   // TxtSbl.innerHTML = GrfDocVal;
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&02&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl001':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&11&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl002':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&21&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl003':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&31&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl004':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&41&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl005':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&51&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl006':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&61&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl007':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&71&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl008':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&81&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl009':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&91&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl009':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&91&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl010':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&101&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl011':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&111&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl012':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&121&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl013':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&131&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl014':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&141&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl015':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&151&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl016':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&161&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl017':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&171&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl018':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&181&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl019':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&191&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'DigSbl020':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&201&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;


                case 'TxtSbl001':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&12&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl002':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&22&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl003':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&32&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl004':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&42&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl005':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&52&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl006':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&62&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl007':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&72&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl008':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&82&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl009':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&92&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl010':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&102&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl011':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&112&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl012':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&122&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl013':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&132&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl014':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&142&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl015':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&152&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl016':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&162&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl017':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&172&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl018':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&182&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl019':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&192&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'TxtSbl020':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&202&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;

                case 'MkbSbl':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&03&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl001':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&13&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl002':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&23&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl003':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&33&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl004':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&43&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl005':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&53&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl006':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&63&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl007':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&73&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl008':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&83&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl009':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&93&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl010':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&103&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl011':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&113&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl012':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&123&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl013':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&133&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl014':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&143&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl015':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&153&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl016':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&163&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl017':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&173&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl018':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&183&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl019':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&193&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                case 'MkbSbl020':
                    SqlStr = "HspAmbSblFlgRep&@BUXNUM&203&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
                    break;
                default:
                    break;
            }


  //          TxtSbl.innerHTML = GrfDocVal;

  //          SqlStr = "HspAmbSblRep&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
   //         alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + GrfDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });
        }

        function SablonWrite() {
     //       alert("SablonWrite=");
            var Sablon = "";

            if (ChkSbl.checked) Sablon = Sablon + TxtSbl.innerHTML;
            if (ChkSbl001.checked) Sablon = Sablon + " " + TxtSbl001.innerHTML;
            if (ChkSbl002.checked) Sablon = Sablon + " " + TxtSbl002.innerHTML;
            if (ChkSbl003.checked) Sablon = Sablon + " " + TxtSbl003.innerHTML;
            if (ChkSbl004.checked) Sablon = Sablon + " " + TxtSbl004.innerHTML;
            if (ChkSbl005.checked) Sablon = Sablon + " " + TxtSbl005.innerHTML;
            if (ChkSbl006.checked) Sablon = Sablon + " " + TxtSbl006.innerHTML;
            if (ChkSbl007.checked) Sablon = Sablon + " " + TxtSbl007.innerHTML;
            if (ChkSbl008.checked) Sablon = Sablon + " " + TxtSbl008.innerHTML;
            if (ChkSbl009.checked) Sablon = Sablon + " " + TxtSbl009.innerHTML;
            if (ChkSbl010.checked) Sablon = Sablon + " " + TxtSbl010.innerHTML;
            if (ChkSbl011.checked) Sablon = Sablon + " " + TxtSbl011.innerHTML;
            if (ChkSbl012.checked) Sablon = Sablon + " " + TxtSbl012.innerHTML;
            if (ChkSbl013.checked) Sablon = Sablon + " " + TxtSbl013.innerHTML;
            if (ChkSbl014.checked) Sablon = Sablon + " " + TxtSbl014.innerHTML;
            if (ChkSbl015.checked) Sablon = Sablon + " " + TxtSbl015.innerHTML;
            if (ChkSbl016.checked) Sablon = Sablon + " " + TxtSbl016.innerHTML;
            if (ChkSbl017.checked) Sablon = Sablon + " " + TxtSbl017.innerHTML;
            if (ChkSbl018.checked) Sablon = Sablon + " " + TxtSbl018.innerHTML;
            if (ChkSbl019.checked) Sablon = Sablon + " " + TxtSbl019.innerHTML;
            if (ChkSbl020.checked) Sablon = Sablon + " " + TxtSbl020.innerHTML;

   //         alert("SablonWrite=" + parSblNum.value + '  @  ' + TxtSbl.innerHTML);
            window.opener.HandlePopupResult(parSblNum.value + '002@' + Sablon);
            self.close();
        }


    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslIdnTek;
    string ParTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

//    string Col003;
//    string Col004;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        ParTyp = Convert.ToString(Request.QueryString["SblTyp"]);
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
        parSblNum.Value = ParTyp;

        if (ParTyp == "Jlb") TxtSap.Text = "ЖАЛОБА";
        if (ParTyp == "Anm") TxtSap.Text = "АНАМНЕЗ БОЛЕЗНИ";
        if (ParTyp == "Stt") TxtSap.Text = "СТАТУС ЛОКАЛИУС";
        if (ParTyp == "Dig") TxtSap.Text = "ДИАГНОЗ";
        if (ParTyp == "Dsp") TxtSap.Text = "ДИАГНОЗ ДОПОЛНИТЕЛЬНЫЙ";
        if (ParTyp == "Lch") TxtSap.Text = "ПЛАН ЛЕЧЕНИЯ";
        if (ParTyp == "Ops") TxtSap.Text = "ОПИСАНИЕ ИССЛЕДОВАНИЯ";
        if (ParTyp == "Zak") TxtSap.Text = "ЗАКЛЮЧЕНИЕ";
        if (ParTyp == "Rek") TxtSap.Text = "РЕКОМЕНДАЦИЙ";

        if (!Page.IsPostBack)
        {
            DigSbl.Attributes.Add("onchange", "onChange('DigSbl',DigSbl.value);");
            TxtSbl.Attributes.Add("onchange", "onChange('TxtSbl',TxtSbl.value);");
            DigSbl001.Attributes.Add("onchange", "onChange('DigSbl001',DigSbl001.value);");
            TxtSbl001.Attributes.Add("onchange", "onChange('TxtSbl001',TxtSbl001.value);");
            DigSbl002.Attributes.Add("onchange", "onChange('DigSbl002',DigSbl002.value);");
            TxtSbl002.Attributes.Add("onchange", "onChange('TxtSbl002',TxtSbl002.value);");
            DigSbl003.Attributes.Add("onchange", "onChange('DigSbl003',DigSbl003.value);");
            TxtSbl003.Attributes.Add("onchange", "onChange('TxtSbl003',TxtSbl003.value);");
            DigSbl004.Attributes.Add("onchange", "onChange('DigSbl004',DigSbl004.value);");
            TxtSbl004.Attributes.Add("onchange", "onChange('TxtSbl004',TxtSbl004.value);");
            DigSbl005.Attributes.Add("onchange", "onChange('DigSbl005',DigSbl005.value);");
            TxtSbl005.Attributes.Add("onchange", "onChange('TxtSbl005',TxtSbl005.value);");
            DigSbl006.Attributes.Add("onchange", "onChange('DigSbl006',DigSbl006.value);");
            TxtSbl006.Attributes.Add("onchange", "onChange('TxtSbl006',TxtSbl006.value);");
            DigSbl007.Attributes.Add("onchange", "onChange('DigSbl007',DigSbl007.value);");
            TxtSbl007.Attributes.Add("onchange", "onChange('TxtSbl007',TxtSbl007.value);");
            DigSbl008.Attributes.Add("onchange", "onChange('DigSbl008',DigSbl008.value);");
            TxtSbl008.Attributes.Add("onchange", "onChange('TxtSbl008',TxtSbl008.value);");
            DigSbl009.Attributes.Add("onchange", "onChange('DigSbl009',DigSbl009.value);");
            TxtSbl009.Attributes.Add("onchange", "onChange('TxtSbl009',TxtSbl009.value);");

            MkbSbl.Attributes.Add("onchange", "onChange('MkbSbl',MkbSbl.value);");
            MkbSbl001.Attributes.Add("onchange", "onChange('MkbSbl001',MkbSbl001.value);");
            MkbSbl002.Attributes.Add("onchange", "onChange('MkbSbl002',MkbSbl002.value);");
            MkbSbl003.Attributes.Add("onchange", "onChange('MkbSbl003',MkbSbl003.value);");
            MkbSbl004.Attributes.Add("onchange", "onChange('MkbSbl004',MkbSbl004.value);");
            MkbSbl005.Attributes.Add("onchange", "onChange('MkbSbl005',MkbSbl005.value);");
            MkbSbl006.Attributes.Add("onchange", "onChange('MkbSbl006',MkbSbl006.value);");
            MkbSbl007.Attributes.Add("onchange", "onChange('MkbSbl007',MkbSbl007.value);");
            MkbSbl008.Attributes.Add("onchange", "onChange('MkbSbl008',MkbSbl008.value);");
            MkbSbl009.Attributes.Add("onchange", "onChange('MkbSbl009',MkbSbl009.value);");

            DigSbl010.Attributes.Add("onchange", "onChange('DigSbl010',DigSbl010.value);");
            TxtSbl010.Attributes.Add("onchange", "onChange('TxtSbl010',TxtSbl010.value);");
            MkbSbl010.Attributes.Add("onchange", "onChange('MkbSbl010',MkbSbl010.value);");
            DigSbl011.Attributes.Add("onchange", "onChange('DigSbl011',DigSbl011.value);");
            TxtSbl011.Attributes.Add("onchange", "onChange('TxtSbl011',TxtSbl011.value);");
            MkbSbl011.Attributes.Add("onchange", "onChange('MkbSbl011',MkbSbl011.value);");
            DigSbl012.Attributes.Add("onchange", "onChange('DigSbl012',DigSbl012.value);");
            TxtSbl012.Attributes.Add("onchange", "onChange('TxtSbl012',TxtSbl012.value);");
            MkbSbl012.Attributes.Add("onchange", "onChange('MkbSbl012',MkbSbl012.value);");
            DigSbl013.Attributes.Add("onchange", "onChange('DigSbl013',DigSbl013.value);");
            TxtSbl013.Attributes.Add("onchange", "onChange('TxtSbl013',TxtSbl013.value);");
            MkbSbl013.Attributes.Add("onchange", "onChange('MkbSbl013',MkbSbl013.value);");
            DigSbl014.Attributes.Add("onchange", "onChange('DigSbl014',DigSbl014.value);");
            TxtSbl014.Attributes.Add("onchange", "onChange('TxtSbl014',TxtSbl014.value);");
            MkbSbl014.Attributes.Add("onchange", "onChange('MkbSbl014',MkbSbl014.value);");
            DigSbl015.Attributes.Add("onchange", "onChange('DigSbl015',DigSbl015.value);");
            TxtSbl015.Attributes.Add("onchange", "onChange('TxtSbl015',TxtSbl015.value);");
            MkbSbl015.Attributes.Add("onchange", "onChange('MkbSbl015',MkbSbl015.value);");
            DigSbl016.Attributes.Add("onchange", "onChange('DigSbl016',DigSbl016.value);");
            TxtSbl016.Attributes.Add("onchange", "onChange('TxtSbl016',TxtSbl016.value);");
            MkbSbl016.Attributes.Add("onchange", "onChange('MkbSbl016',MkbSbl016.value);");
            DigSbl017.Attributes.Add("onchange", "onChange('DigSbl017',DigSbl017.value);");
            TxtSbl017.Attributes.Add("onchange", "onChange('TxtSbl017',TxtSbl017.value);");
            MkbSbl017.Attributes.Add("onchange", "onChange('MkbSbl017',MkbSbl017.value);");
            DigSbl018.Attributes.Add("onchange", "onChange('DigSbl018',DigSbl018.value);");
            TxtSbl018.Attributes.Add("onchange", "onChange('TxtSbl018',TxtSbl018.value);");
            MkbSbl018.Attributes.Add("onchange", "onChange('MkbSbl018',MkbSbl018.value);");
            DigSbl019.Attributes.Add("onchange", "onChange('DigSbl019',DigSbl019.value);");
            TxtSbl019.Attributes.Add("onchange", "onChange('TxtSbl019',TxtSbl019.value);");
            MkbSbl019.Attributes.Add("onchange", "onChange('MkbSbl019',MkbSbl019.value);");
            DigSbl020.Attributes.Add("onchange", "onChange('DigSbl020',DigSbl020.value);");
            TxtSbl020.Attributes.Add("onchange", "onChange('TxtSbl020',TxtSbl020.value);");
            MkbSbl020.Attributes.Add("onchange", "onChange('MkbSbl020',MkbSbl020.value);");

            // --------------------------  считать данные одного врача -------------------------
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbSbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@BUXTYP", SqlDbType.VarChar).Value = ParTyp;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbSbl");
            con.Close();

            TxtSbl.Text = "";
            if (ds.Tables[0].Rows.Count > 0)
            {
                DigSbl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG"]);
                TxtSbl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT"]);
                DigSbl001.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG001"]);
                TxtSbl001.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT001"]);
                DigSbl002.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG002"]);
                TxtSbl002.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT002"]);
              
                DigSbl003.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG003"]);
                TxtSbl003.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT003"]);
                DigSbl004.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG004"]);
                TxtSbl004.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT004"]);
                DigSbl005.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG005"]);
                TxtSbl005.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT005"]);
                DigSbl006.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG006"]);
                TxtSbl006.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT006"]);
                DigSbl007.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG007"]);
                TxtSbl007.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT007"]);
                DigSbl008.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG008"]);
                TxtSbl008.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT008"]);
                DigSbl009.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG009"]);
                TxtSbl009.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT009"]);

                MkbSbl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB"]);
                MkbSbl001.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB001"]);
                MkbSbl002.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB002"]);
                MkbSbl003.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB003"]);
                MkbSbl004.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB004"]);
                MkbSbl005.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB005"]);
                MkbSbl006.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB006"]);
                MkbSbl007.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB007"]);
                MkbSbl008.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB008"]);
                MkbSbl009.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB009"]);

                DigSbl010.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG010"]);
                TxtSbl010.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT010"]);
                MkbSbl010.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB010"]);
                DigSbl011.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG011"]);
                TxtSbl011.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT011"]);
                MkbSbl011.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB011"]);
                DigSbl012.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG012"]);
                TxtSbl012.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT012"]);
                MkbSbl012.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB012"]);
                DigSbl013.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG013"]);
                TxtSbl013.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT013"]);
                MkbSbl013.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB013"]);
                DigSbl014.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG014"]);
                TxtSbl014.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT014"]);
                MkbSbl014.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB014"]);
                DigSbl015.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG015"]);
                TxtSbl015.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT015"]);
                MkbSbl015.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB015"]);
                DigSbl016.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG016"]);
                TxtSbl016.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT016"]);
                MkbSbl016.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB016"]);
                DigSbl017.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG017"]);
                TxtSbl017.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT017"]);
                MkbSbl017.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB017"]);
                DigSbl018.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG018"]);
                TxtSbl018.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT018"]);
                MkbSbl018.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB018"]);
                DigSbl019.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG019"]);
                TxtSbl019.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT019"]);
                MkbSbl019.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB019"]);
                DigSbl020.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLDIG020"]);
                TxtSbl020.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT020"]);
                MkbSbl020.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLMKB020"]);

                
            }
        }
    }

    //===============================================================================================================

</script>


<body>
    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parSblNum" runat="server" />

        <%-- ============================  верхний блок  ============================================ 
                  <tr>
                    <td width="100%">
                        <asp:TextBox ID="TxtSbl" Width="100%" Height="300" TextMode="MultiLine" runat="server" Style="font-weight: 700; font-size: large;" />

                    </td>
                </tr>
         
            --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <asp:TextBox ID="TxtSap" Width="100%" Height="30" runat="server" Style="font-weight: 700; font-size: large; text-align:center" />
    </asp:Panel>


    <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 510px;">
        
            <table border = "1" cellspacing="0" width="100%" cellpadding="0">
               <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
               </tr>
                <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl001"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl001" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl001" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl001" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
               </tr>
                <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl002"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl002" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl002" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl002" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
               </tr>
 
                <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl003"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl003" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl003" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl003" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                </tr>                
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl004"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl004" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl004" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl004" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl005"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl005" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl005" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl005" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl006"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl006" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl006" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl006" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl007"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl007" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl007" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl007" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>

                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl008"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl008" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl008" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl008" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl009"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl009" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl009" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl009" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl010"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl010" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl010" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl010" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl011"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl011" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl011" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl011" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl012"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl012" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl012" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl012" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl013"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl013" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl013" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl013" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl014"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl014" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl014" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl014" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl015"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl015" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl015" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl015" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl016"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl016" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl016" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl016" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl017"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl017" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl017" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl017" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl018"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl018" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl018" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl018" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>               
                
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl019"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl019" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl019" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl019" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                  </tr>               
               
                 <tr>
                    <td  height="20" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="ChkSbl020"  runat="server" />
                    </td>
                    <td  height="20" width="12%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="DigSbl020" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="75%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtSbl020" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                    <td  height="20" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="MkbSbl020" Width="100%" Height="50" TextMode="MultiLine" BorderStyle="None" runat="server" Style="font-size: medium;" />
                    </td>
                 </tr>     
                                
             </table>
 </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                       <asp:Button ID="Button1" runat="server"
                            OnClientClick="SablonWrite()"
                            Width="40%" CommandName="Cancel"
                            Text="Отмеченные шаблоны перенести в амбулаторную карту" Height="25px"
                            Style="top: 0px; left: 0px;" />
             </center>
  </asp:Panel> 

    </form>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            width: 100%;
            font-size: 12px !important;  // для увеличения коррект поля
            padding-top: 4px;
            padding-bottom: 4px;
        }


        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;

    white-space: -moz-pre-wrap !important;
    white-space: -pre-wrap; 
    white-space: -o-pre-wrap; 
    white-space: pre-wrap;
    word-wrap: break-word;


        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }

    </style>



</body>

</html>



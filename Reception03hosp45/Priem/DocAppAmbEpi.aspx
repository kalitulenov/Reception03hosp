<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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

        window.onload = function () {
            parBrowser.value = "Desktop";
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                parBrowser.value = "Android";
            }
        };

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

        //    ------------------ смена логотипа ----------------------------------------------------------
        // -------изменение как EXCEL-------------------------------------------------------------------          
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        function onChange(sender, newText) {
            //       alert("onChangeJlb=" + sender.ID + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';

            var QueryString = getQueryString();
            var DatDocIdn = QueryString[1];

            var SqlStr = "";

            switch (sender.ID) {
                case 'TxtEpi':
                    //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBSTZ SET STZEPI='" + DatDocVal + "' WHERE STZAMB=" + DatDocIdn;
                    break;
                default:
                    break;
            }
    //      alert("SqlStr=" + SqlStr);

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

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';

            var QueryString = getQueryString();
            var DatDocIdn = QueryString[1];

            switch (sender.ID) {
                case 'BoxKto':
                    DatDocVal = BoxKto.options[BoxKto.selectedIndex()].value;
                    SqlStr = "UPDATE AMBSTZ SET STZEPIDOC=" + DatDocVal + " WHERE STZAMB=" + DatDocIdn;
                    break;
                default:
                    break;
            }
    //       alert("SqlStr=" + SqlStr);

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

        //    ---------------- обращение веб методу --------------------------------------------------------


        function OnClientDateChanged(sender, selectedDate) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek = 'DRYDAT';
            var DatDocVal = TxtDat.value;
            var DatDocTyp = 'Sql';

            var QueryString = getQueryString();
            var DatDocIdn = QueryString[1];

            SqlStr = "UPDATE AMBSTZ SET STZEPIDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE STZAMB=" + DatDocIdn;
   //         alert("SqlStr=" + SqlStr);

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
        function Speech(event) {
            //          alert("OnButtonTitClick=" + event);
            var ParTxt = "Жалобы";
            window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=" + parBrowser.value, "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
            //            alert("OnButtonTitClick=" + event);
            //                 SpeechWindow.setTitle("Голосовой блокнот");
            //                 SpeechWindow.setUrl("Speech_03.aspx?ParTxt=GrfJlb");
            //                 SpeechWindow.Open();

            return false;
        }

        function HandlePopupResult(result) {
            //                    alert("result of popup is: " + result);
            var MasPar = result.split('@');

            if (MasPar[0] == 'SpzEpi') {
                document.getElementById('StzEpi').value = document.getElementById('TxtEpi').value + MasPar[1] + '.';
                onChangeTxt('TxtEpi', document.getElementById('TxtEpi').value);
            }
            //         document.getElementById('ctl00$MainContent$HidTextBoxFio').value = result;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {

            var QueryString = getQueryString();
            var DatDocIdn = QueryString[1];

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbStzEpi&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbStzEpi&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }


    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbDryIdn;
    string AmbDryIdnTek;
    string AmbPrzTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);


        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ'";

        //=====================================================================================
        //=====================================================================================

        if (!Page.IsPostBack)
        {
            getDocNum();
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
        SqlCommand cmd = new SqlCommand("HspAmbStzIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbStzIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZEPIDAT"].ToString())) TxtDat.Text = "";
            else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["STZEPIDAT"]).ToString("dd.MM.yyyy");

            BoxKto.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZEPIDOC"]);

            TxtEpi.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZEPI"]);
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================

    //------------------------------------------------------------------------

                // ------------------------------------------------------------------------------заполняем второй уровень

        // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDryIdn" runat="server" />
        <asp:HiddenField ID="parBrowser" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: -10px; width: 100%; height: 330px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                     <td style="width: 20%; height: 30px;">
                        <asp:Label ID="Label5" Text="ДАТА:" runat="server" Width="20%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtDat" Width="40%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="calNaz" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtDat"
                               OnClientDateChanged="OnClientDateChanged"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                    <td style="width: 20%; height: 30px;"">
                        <asp:Label ID="Label7" Text="ВРАЧ:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server"
                            ID="BoxKto"
                            Width="75%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsKto"
                            DataTextField="FI"
                            DataValueField="BUXKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>   
                   </td>
                        <td style="vertical-align: top; width:20%" >
                                  <button id="start_Anm" onclick="Speech('StzEpi')">
                                  <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                        </td>
                        <td style="vertical-align: top; width:40%" >
                        </td>  

                </tr>
             </table>
          
                                 <obout:OboutTextBox runat="server" ID="TxtEpi"  width="99%" BackColor="White" Height="300px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
        </asp:Panel>

       <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: -10px; width: 100%; height: 30px;">
            <center>
                <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
            </center>
        </asp:Panel>
    </form>
<%-- 
   --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>



</body>

</html>



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
        // -------изменение как EXCEL-------------------------------------------------------------------          
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        function onChange(sender, newText) {
     //       alert("onChangeJlb=" + sender.ID + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
//            var QueryString = getQueryString();
//            var DatDocIdn = QueryString[1];
            var DatDocIdn = document.getElementById('parDryIdn').value;

            var SqlStr = "";


            switch (sender.ID) {
                case 'TxtMem':
 //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBSTZDRY SET DRYMEM='" + DatDocVal + "' WHERE DRYIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
   //               alert("SqlStr=" + SqlStr);

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
            var DatDocIdn = document.getElementById('parDryIdn').value;

            switch (sender.ID) {
                case 'BoxKto':
                    DatDocVal = BoxKto.options[BoxKto.selectedIndex()].value;
                    SqlStr = "UPDATE AMBSTZDRY SET DRYDOC=" + DatDocVal + " WHERE DRYIDN=" + DatDocIdn;
                    break;
                case 'BoxDry':
                    DatDocVal = BoxDry.options[BoxDry.selectedIndex()].value;
                    SqlStr = "UPDATE AMBSTZDRY SET DRYTYP=" + DatDocVal + " WHERE DRYIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
   //                           alert("SqlStr=" + SqlStr);

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
            var DatDocIdn = document.getElementById('parDryIdn').value;

            SqlStr = "UPDATE AMBSTZDRY SET DRYDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE DRYIDN=" + DatDocIdn;
                      alert("SqlStr=" + SqlStr);

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

            if (MasPar[0] == 'DryMem') {
                document.getElementById('TxtMem').value = document.getElementById('TxtMem').value + MasPar[1] + '.';
                onChangeTxt('TxtMem', document.getElementById('TxtMem').value);
            }
            //         document.getElementById('ctl00$MainContent$HidTextBoxFio').value = result;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {

            var DatDocIdn = document.getElementById('parDryIdn').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbStzDry&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbStzDry&TekDocIdn=" + DatDocIdn,
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

    string Col001;
    string Col002;
    string Col003;
    string Col004;
    string Col005;
    string Col006;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbDryIdn = Convert.ToString(Request.QueryString["AmbDryIdn"]);
        if (AmbDryIdn == "0") AmbPrzTyp = "ADD";
        else AmbPrzTyp = "REP";
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbDryIdn ", AmbDryIdn);

        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ'";

        sdsDry.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsDry.SelectCommand = "SELECT STZDRYKOD,STZDRYNAM FROM SprStzDry";

        if (!Page.IsPostBack)
        {
 //           TxtNap.Attributes.Add("onchange", "onChange('TxtNap',TxtNap.value);");
 //           TxtLgt.Attributes.Add("onchange", "onChange('TxtLgt',TxtLgt.value);");
 //           TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
//            Dig003.Attributes.Add("onchange", "onChange('Dig003',Dig003.value);");
//            Dsp003.Attributes.Add("onchange", "onChange('Dsp003',Dsp003.value);");
//            Lch003.Attributes.Add("onchange", "onChange('Lch003',Lch003.value);");
            //============= Установки ===========================================================================================
              AmbDryIdnTek = (string)Session["AmbDryIdn"];
              if (AmbDryIdnTek != "Post")
              {
                  if (AmbDryIdn == "0")  // новый документ
                  {

                      // строка соединение
                      string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                      // создание соединение Connection
                      SqlConnection con = new SqlConnection(connectionString);
                      // создание команды
                      SqlCommand cmd = new SqlCommand("HspAmbDryAdd", con);
                      // указать тип команды
                      cmd.CommandType = CommandType.StoredProcedure;
                      // передать параметр
                      cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                      cmd.Parameters.Add("@DRYIDN", SqlDbType.Int, 4).Value = 0;
                      cmd.Parameters["@DRYIDN"].Direction = ParameterDirection.Output;
                      con.Open();
                      try
                      {
                          int numAff = cmd.ExecuteNonQuery();
                          // Получить вновь сгенерированный идентификатор.
                          //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                          //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                          AmbDryIdn = Convert.ToString(cmd.Parameters["@DRYIDN"].Value);
                      }
                      finally
                      {
                          con.Close();
                      }
                  }

              }
            Session["AmbDryIdn"] = Convert.ToString(AmbDryIdn);
            parDryIdn.Value = AmbDryIdn;

            getDocNum();
//            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM AMBSTZDRY WHERE DRYIDN=" + AmbDryIdn, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "PrzOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            // ============================================================================================

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DRYDAT"].ToString())) TxtDat.Text = "";
            else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DRYDAT"]).ToString("dd.MM.yyyy");
            
            BoxDry.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DRYTYP"]);
            BoxKto.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DRYDOC"]);
            TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["DRYMEM"]);

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
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 330px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                     <td style="width: 25%; height: 30px;">
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

                    <td style="width: 30%; height: 30px;"">
                        <asp:Label ID="Label1" Text="ТИП:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server"
                            ID="BoxDry"
                            Width="80%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsDry"
                            DataTextField="STZDRYNAM"
                            DataValueField="STZDRYKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>   
                   </td>

                    <td style="width: 30%; height: 30px;"">
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
                        <td style="vertical-align: top; width:10%" >
                                  <button id="start_Anm" onclick="Speech('DryMem')">
                                  <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                        </td>
                  </tr>
             </table>
          
                                 <obout:OboutTextBox runat="server" ID="TxtMem"  width="99%" BackColor="White" Height="300px"
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
    <asp:SqlDataSource runat="server" ID="sdsDry" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



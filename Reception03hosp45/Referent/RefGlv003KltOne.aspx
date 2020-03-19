<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript" ></script>

   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#BrtDat').mask('D9.M9.Y999');
        };
        /*------------------------- Изиять переданный параметр --------------------------------*/
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

        /*------------------------- Изиять переданный параметр --------------------------------*/
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
  //                    alert("onChange=" + sender + " = " + newText);
            var DatDocVal = newText;
 //           alert("onChange=" + sender + " = " + newText);
            //         DatDocVal = DatDocVal.replace(",", ".");

            if (DatDocVal == "") { alert("ИИН не указан " + DatDocVal); return false; }
            if (DatDocVal.length != 12) { alert("длина ИИН не верен " + DatDocVal); return false; }

            var strCheck = "0123456789";
            var i;

            for (var i = 0; i < DatDocVal.length; i++) {
              //          alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                if (strCheck.indexOf(DatDocVal[i]) == -1) { alert("Ошибка в ИИН " + DatDocVal + " i=" + i ); return false; }
            }
        }
 
        function IinButton_Click() {
    //        var QueryString = getQueryString();
    //        KltIin = QueryString[1];

            ConfirmDialog.Close();

            //    alert("OK_click_Chk="+document.getElementById('parIndChk').value);
            // Номер элемента
            //      var IndFix = document.getElementById('parIndFix').value;
            // Номер строки
            //       var IndChk = document.getElementById('parIndChk').value;
            
            $(".IinDialog").dialog(
            {
                autoOpen: true,
                width: 500,
                height: 400,
                modal: true,
                zIndex: 20000,
                buttons:
                {
                    "ОК": function ()
                        {
                      //            alert("OK_1=" + document.getElementById('IinTxt').value);
                      //            alert("OK_2=" + document.getElementById('txtIinNew').value);
                                  var DatDocVal = document.getElementById('txtIinNew').value;
                        // ===========================================================================================================================================
                                  if (DatDocVal == "") { alert("ИИН не указан " + DatDocVal); return false; }
                                  if (DatDocVal.length != 12) { alert("длина ИИН не верен " + DatDocVal); return false; }

                                  var strCheck = "0123456789";
                                  var i;

                                  for (var i = 0; i < DatDocVal.length; i++) {
                                      //          alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                                      if (strCheck.indexOf(DatDocVal[i]) == -1) { alert("Ошибка в ИИН " + DatDocVal + " i=" + i); return false; }
                                  }
                           var ParStr = document.getElementById('IinTxt').value + ':' + document.getElementById('txtIinNew').value + ':';
                        //          alert("ParStr =" + ParStr);
                        // ===========================================================================================================================================
                            $.ajax({
                                type: 'POST',
                                url: '/HspUpdDoc.aspx/HspSprKltIinMrg',
                                data: '{"ParStr":"' + ParStr + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function () { },
                                error: function () { alert("ERROR=" + SqlStr); }
                            });
                           
                            document.getElementById('IinTxt').value = document.getElementById('txtIinNew').value;
                            // ---------------------------------------------------------------------------------------------
                            IIN_OK_click();
                            $(this).dialog("close");


                        }
                    },
                    "Отмена": function () {
                        $(this).dialog("close");
                    }
                
            });
        }


        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------       
        function IIN_OK_click() {
            //                    alert(" Eml_OK_click(1)=");
            $(".OkSuccess").dialog(
                {
                    autoOpen: true,
                    width: 300,
                    height: 170,
                    modal: true,
                    zIndex: 2000,
                    buttons:
                      {
                          "ОК": function () {
                              $(this).dialog("close");
                              //                             OK_message();
                          }

                      }
                });
        }

        function ExitFun() {
            var KltFio = document.getElementById('SelFio').value;
         //   alert(KltFio);
            //window.parent.KofClick();
            window.parent.KltOneClose(KltFio);
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        // -----------------------------------------------------------------------------------
        function PrtKltQrc() {
            var TekKltIIN = document.getElementById('IinTxt').value;
      //      alert('AmbCrdIdn= ' + TekKltIIN );
            if (TekKltIIN.length == 12)
            {
                KltWindow.setTitle("Экстренная карта");
                KltWindow.setUrl("/Report/DauaReports.aspx?ReportName=HspAmbKrtQrc&TekDocIdn=" + TekKltIIN);
                KltWindow.Open();
            }
        } 

        //    ---------------- обращение веб методу --------------------------------------------------------
        function WebCam() {
             //          alert("GridAnl_ClientEdit");
            var KltIin = document.getElementById('IinTxt').value;

            KltWindow.setTitle(KltIin);
            KltWindow.setUrl("/WebCam/DocAppWebCamJpg.aspx?KltIin=" + KltIin);
            KltWindow.Open();
            return false;
        }

        // -----------------------------------------------------------------------------------
        function SMSsend() {
            var KltIin = document.getElementById('IinTxt').value;
            var KltFio = document.getElementById('FioTxt').value;
            var KltSex = document.getElementById('SexFlg').value;
            var KltTel = document.getElementById('TelTxt').value.slice(-10);

       //          alert("RefGlv003KltOneSms.aspx?KltFio=" + KltFio + "&KltSex=" + KltSex + "&KltTel=" + KltTel);

                 document.getElementById('TxtTelSms').value = KltTel;
            if (document.getElementById('SexFlg').checked) document.getElementById('TxtSmsTxt').value = "Уважаемый, " + KltFio;
            else document.getElementById('TxtSmsTxt').value = "Уважаемая, " + KltFio;

            $(".SmsDialog").dialog(
                {
                    autoOpen: true,
                    width: 800,
                    height: 380,
                    modal: true,
                    zIndex: 20000,
                    buttons:
                    {
                        "Отправить СМС": function () {
                            //--------------------------------------------------------------------------------------------------
                            var PolFio = KltFio;
                            var PolTelChr = document.getElementById('TxtTelSms').value;
                            if (PolTelChr.length != 10) {
                                windowalert("Ошибка в номере телефона!", "Предупреждения", "warning");

                                return;
                            }

                            var SmsTxt = document.getElementById('TxtSmsTxt').value;
                            if (SmsTxt.length == 0) {
                                windowalert("Сообщение пусто!", "Предупреждения", "warning");
                                return;
                            }
                            var PolTel = "7" + parseInt(PolTelChr.replace(/\D+/g, ""));
                        //              alert(PolTel);
                            //            alert(typeof PolTel);

                            var bValid = Page_ClientValidate('');
                   //         alert("bValid=" +bValid);
                  //          if (bValid) {
                                //   Eml_OK_click();

                                //  document.getElementById('parSndSms').value = SmsTxt;
                                //  SmsTxt = "Код подтверждения записи к врачу " + SmsTxt;
                             //           alert("SmsTxt=" + SmsTxt);

                                // ----------------------------------------------------  отправка СМС сообщения ------------------------------------------------------
                                $.ajax({
                                    type: 'POST',
                                    url: '/HspUpdDoc.aspx/SendSms',
                                    contentType: "application/json; charset=utf-8",
                                    data: '{"PolTel":"' + PolTel + '", "SmsTxt":"' + SmsTxt + '"}',
                                    dataType: "json",
                                    success: function () {

                                        windowalert("СМС отправлен!", "Предупреждения", "warning");

                                        $(this).dialog("close");
                                    },
                                    error: function () { alert("ERROR"); }

                                });
                                // -------------------------  отправка СМС сообщения  ------------------------------------------------------


                                //    ------------------ исправить телефон   ---------------------------------------------------------------
                                if (KltTel.length != 10) {
                           //         alert("PolTel=" + PolTel);
                                    document.getElementById('TelTxt').value = PolTel;

                                    SqlStr = "UPDATE SPRKLT SET KLTTEL='" + PolTel + "' WHERE KLTIIN='" + KltIin + "'";
                                    //                alert("SqlStr=" + SqlStr);
                                    $.ajax({
                                        type: 'POST',
                                        url: '/HspUpdDoc.aspx/UpdateOrder',
                                        contentType: "application/json; charset=utf-8",
                                        data: '{"DatDocMdb":"HOSPBASE","SqlStr":"' + SqlStr + '","DatDocTyp":"Sql"}',
                                        dataType: "json",
                                        success: function () { },
                                        error: function () { alert("ERROR=" + SqlStr); }
                                    });
                                }


                                $(this).dialog("close");
                     //       }
                        },
                        "Отмена": function () {
                            $(this).dialog("close");
                        }
                    }
                });
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KltOneIdn;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        KltOneIdn = Convert.ToString(Request.QueryString["KltOneIdn"]);
        CntOneIdn = Convert.ToString(Request.QueryString["CntOneIdn"]);
        //       KltStx = KltOneIdn.Substring(0, 5);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //        sdsStx.SelectCommand = "SELECT CNTKEY AS STXKOD,CNTNAM AS STXNAM " +
        //                               "FROM SprFrmStx INNER JOIN SprCnt ON SprFrmStx.FrmStxKodStx=SprCnt.CntKod AND SprFrmStx.FrmStxKodFrm=SprCnt.CntFrm " +
        //                               "WHERE SprCnt.CntLvl=0 AND SprFrmStx.FrmStxKodFrm=" + BuxFrm + " ORDER BY CNTNAM";
        sdsStx.SelectCommand = "SELECT CNTKEY AS STXKOD,CNTNAM AS STXNAM " +
                               "FROM SprCnt WHERE CntLvl=0 AND CntFrm=" + BuxFrm + " ORDER BY CNTNAM";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsOrg.SelectCommand = "SELECT CntKod As OrgKod,CntNam As OrgNam FROM SprCnt WHERE CntLvl=1 And Left(CntKey,5)='00002' ORDER BY CntNam";

        sdsCnt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //        sdsCnt.SelectCommand = "SELECT CntKod As CntKod,CntNam As CntNam FROM SprCnt WHERE CntKey=LEFT(KLTKEY,17) ORDER BY CntNam";

        sdsVar.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsVar.SelectCommand = "SELECT CntKod As VarKod,CntNam As VarNam FROM SprCnt WHERE CntKey=LEFT(KLTKEY,23) ORDER BY CntNam";
        //       sdsFam.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsFam.SelectCommand = "SELECT FamKod,FamNam FROM SprFam ORDER BY FamKod";

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT KrvGrpKod,KrvGrpNam FROM SprKrvGrp ORDER BY KrvGrpNam";

        sdsRes.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsRes.SelectCommand = "SELECT KrvResKod,KrvResNam FROM SprKrvRes ORDER BY KrvResNam";


        if (!Page.IsPostBack)
        {
            //          TxtIinNew.Attributes.Add("onchange", "onChange('TxtIinNew',TxtIinNew.value);");

            //          Session["KLTONEIDN"] = Convert.ToString(KltOneIdn);
            //          Session["CntOneIdn"] = Convert.ToString(CntOneIdn);

            TekKltIdn.Value = Convert.ToString(KltOneIdn);
            TekCntIdn.Value = Convert.ToString(CntOneIdn);

            if (String.IsNullOrEmpty(KltOneIdn) || KltOneIdn == "0") IinTxt.ReadOnly = false;
            else IinTxt.ReadOnly = true;

            if (String.IsNullOrEmpty(CntOneIdn)) CntOneIdn = null;
            else GetGrid();

            if (BuxFrm == "7")
            {
                AdrPodTxt.Visible = false;
                AdrEtgTxt.Visible = false;
                AdrDmfTxt.Visible = false;
                AdrUglTxt.Visible = false;
                AdrZsdTxt.Visible = false;
                //        LabOrg.Visible = false;
                LabOrg.Text = "&nbsp;Вид спорта";
                //        BoxOrg.Visible = false;
                LabStx.Text = "&nbsp;Спортсмены";
                LabEmp.Text = "&nbsp;Разряд";
                LabDlg.Visible = false;
                DlgTxt.Visible = false;

                LabBeg.Visible = false;
                BegDat.Visible = false;
                CalBeg.Visible = false;

                LabEnd.Visible = false;
                EndDat.Visible = false;

                LabKrt.Visible = false;
                //      UchTxt.Visible = false;
                //      ButKrt.Visible = false;

                //       LabSemKrt.Visible = false;
                //       SplTxt.Visible = false;

                LabSot.Visible = false;
                StfFlg.Visible = false;

                LabVip.Visible = false;
                VipFlg.Visible = false;

                //      LabUbl.Visible = false;
                DspFlg.Visible = false;

            }

            if (BuxFrm == "9")
            {
                LabOrg.Text = "&nbsp;Факультет";

                //       LabEmp.Visible = false;
                //       EmpTxt.Visible = false;

                LabBeg.Text = "&nbsp;Дата поступ";

                //     LabEnd.Visible = false;
                //     EndDat.Visible = false;

                //     LabKrt.Visible = false;
                //     UchTxt.Visible = false;

                //      LabSot.Visible = false;
                //      StfFlg.Visible = false;

                //      LabVip.Visible = false;
                //      VipFlg.Visible = false;

                //      DspFlg.Visible = false;

            }


        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {

        //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspRefGlv003KltOne", con);
        cmd = new SqlCommand("HspRefGlv003KltOne", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@KLTONEIDN", SqlDbType.VarChar).Value = KltOneIdn;
        cmd.Parameters.Add("@CNTONEIDN", SqlDbType.VarChar).Value = CntOneIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlv003KltOne");

        if (ds.Tables[0].Rows.Count > 0)
        {

            //           BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTFAM"]) + " " +
            //                         Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]) + " " +
            //                         Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);
            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            FioTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //           ImaTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]);
            //            OtcTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);
            //            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTIIN"].ToString())  ) IinTxt.Enabled = true;

            if (Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]) != null && Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]) != "")
            {
                IinTxt.Enabled = false;
                ButIIN.Visible = false;
                ButIINKor.Visible = true;
            }

            IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTBRT"].ToString())) BrtDat.Text = "";
            else BrtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KLTBRT"]).ToString("dd.MM.yyyy");

            InvTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTINV"]);

            TelTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);

            AdrOblTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADROBL"]);
            //            AdrRaiTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRRAI"]);
            AdrPnkTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPNK"]);
            AdrStrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRSTR"]);
            AdrDomTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDOM"]);
            AdrAprTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRAPR"]);
            AdrUglTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRUGL"]);
            AdrEtgTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRETG"]);
            AdrPodTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPOD"]);
            AdrDmfTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDMF"]);
            AdrZsdTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRZSD"]);

            UchTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTUCH"]);
            //   SplTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSEMKRT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"].ToString())) BegDat.Text = "";
            else BegDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTEND"].ToString())) EndDat.Text = "";
            else EndDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTEND"]).ToString("dd.MM.yyyy");

            DlgTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTDLG"]);
            EmpTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);


            AlrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTALR"]);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTX"].ToString())) BoxStx.SelectedValue = "0";
            else BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSTX"]);

            sdsOrg.SelectCommand = "SELECT CntKey As OrgKod,CntNam As OrgNam FROM SprCnt WHERE Left(CntKey,5)='" + BoxStx.SelectedValue + "' AND CNTLVL=1 ORDER BY CntNam";

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTCMP"].ToString())) BoxOrg.SelectedValue = "0";
            else BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTCMP"]);

            sdsCnt.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,11)='" + BoxOrg.SelectedValue + "' AND CNTLVL=2 ORDER BY CntNam";

            //          if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTCNT"].ToString())) BoxCnt.SelectedValue = "0";
            //          else BoxCnt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTCNT"]);

            //           sdsVar.SelectCommand = "SELECT CntKey As VarKod,CntNam As VarNam FROM SprCnt WHERE Left(CntKey,17)='" + BoxCnt.SelectedValue + "' AND CNTLVL=3 ORDER BY CntNam";

            //           if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTVAR"].ToString())) BoxVar.SelectedValue = "0";
            //           else BoxVar.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTVAR"]);

            //   if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTFAM"].ToString())) BoxFam.SelectedValue = "0";
            //   else BoxFam.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTFAM"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSOZLGT"].ToString())) BoxSoz.SelectedValue = "0";
            else BoxSoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTSOZLGT"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTDSP"].ToString())) DspFlg.Checked = false;
            else DspFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTDSP"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTUCHTYP"].ToString())) CtyVilFlg.Checked = false;
            else CtyVilFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTUCHTYP"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTF"].ToString())) StfFlg.Checked = false;
            else StfFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTSTF"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTVIP"].ToString())) VipFlg.Checked = false;
            else VipFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTVIP"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSEX"].ToString())) SexFlg.Checked = false;
            else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTSEX"]);

            //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTRSD"].ToString())) RsdFlg.Checked = false;
            //    else RsdFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTRSD"]);

            // -------------------------------------------------------------------------------------------------------------------
            TxtKnt001.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTKNT001"]);
            TxtKnt001Tel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTKNT001TEL"]);
            TxtKnt002.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTKNT002"]);
            TxtKnt002Tel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTKNT002TEL"]);
            TxtBol.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTBOL"]);
            TxtLek.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTLEK"]);
            TxtPrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTPRT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTKRVGRP"].ToString())) BoxKrvGrp.SelectedValue = "0";
            else BoxKrvGrp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTKRVGRP"]);
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTKRVRES"].ToString())) BoxKrvRes.SelectedValue = "0";
            else BoxKrvRes.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTKRVRES"]);

            TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTMEM"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSUM"]);
            TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTLGT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTS"].ToString())) TxtSts.Text = "";
            else
                if (Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSTS"]) == "1") TxtSts.Text = "ЗАСТРАХОВАН";
            else TxtSts.Text = "НЕ ЗАСТРАХОВАН";
        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        else
        {
            // создание команды
            SqlCommand cmdMax = new SqlCommand("HspSprKltMaxIinInv", con);
            cmdMax = new SqlCommand("HspSprKltMaxIinInv", con);
            // указать тип команды
            cmdMax.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            // передать параметр
            cmdMax.Parameters.Add("@BUXFRM", SqlDbType.Int,4).Value = BuxFrm;
            // создание DataAdapter
            SqlDataAdapter daMax = new SqlDataAdapter(cmdMax);
            // заполняем DataSet из хран.процедуры.
            daMax.Fill(dsMax, "HspSprKltMaxIinInv");

            if (dsMax.Tables[0].Rows.Count > 0)
            {
                IinTxt.Text = Convert.ToString(dsMax.Tables[0].Rows[0]["KLTMAXIIN"]);
                InvTxt.Text = Convert.ToString(dsMax.Tables[0].Rows[0]["KLTMAXINV"]);
                TekCntIdn.Value = Convert.ToString(dsMax.Tables[0].Rows[0]["CNTIDN"]);
                TekKltIdn.Value = Convert.ToString(dsMax.Tables[0].Rows[0]["KLTIDN"]);

            }
        }

        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }


    //------------------------------------------------------------------------
    protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxStx.SelectedIndex > -1)
        {
            //           KeyStx = Convert.ToInt32(BoxStx.SelectedValue).ToString("D5");
            //===============================================================================================================
            BoxOrg.Items.Clear();
            sdsOrg.SelectCommand = "SELECT CntKey As OrgKod,CntNam As OrgNam FROM SprCnt WHERE Left(CntKey,5)='" + BoxStx.SelectedValue + "' AND CNTLVL=1 ORDER BY CntNam";
            //           BoxOrg.SelectedValue = "";
            //===============================================================================================================
            //           BoxCnt.Items.Clear();
            //           BoxCnt.SelectedIndex = -1;
            //           BoxVar.Items.Clear();
            //           BoxVar.SelectedIndex = -1;
            //===============================================================================================================
            con.Close();
        }
    }

    //------------------------------------------------------------------------
    protected void BoxOrg_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxOrg.SelectedIndex > -1)
        {
            //===============================================================================================================
            //           BoxCnt.Items.Clear();
            //           sdsCnt.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,11)='" + BoxOrg.SelectedValue + "' AND CNTLVL=2 ORDER BY CntNam";
            //===============================================================================================================
            //          BoxVar.Items.Clear();
            //          BoxVar.SelectedIndex = -1;
            //===============================================================================================================
            con.Close();
        }
    }


    //------------------------------------------------------------------------
    /*
    protected void BoxCnt_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxCnt.SelectedIndex > -1)
        {
            //===============================================================================================================
            BoxVar.Items.Clear();
            sdsVar.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,17)='" + BoxOrg.SelectedValue + "' AND CNTLVL=3 ORDER BY CntNam";
            //===============================================================================================================
            con.Close();
        }

    }
*/

    //------------------------------------------------------------------------
    protected void IinTxt_OnTextChanged(object sender, EventArgs e)
    {
        string IIN = IinTxt.Text;
        if (String.IsNullOrEmpty(IIN)) return;
        if (IIN.Length != 12) return;

        //        if (String.IsNullOrEmpty(KltOneIdn) || KltOneIdn == "0") return;

        //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspRefGlv003KltIin", con);
        cmd = new SqlCommand("HspRefGlv003KltIin", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //        cmd.Parameters.Add("@KLTIDN", SqlDbType.VarChar).Value = KltOneIdn;
        cmd.Parameters.Add("@KLTIIN", SqlDbType.VarChar).Value = IIN;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlv003KltIin");

        if (ds.Tables[0].Rows.Count > 0)
        {

            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            FioTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //            ImaTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]);
            //            OtcTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BRT"].ToString())) BrtDat.Text = "";
            else BrtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BRT"]).ToString("dd.MM.yyyy");

            InvTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTINV"]);
            IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);
            TelTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);

            AdrOblTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADROBL"]);
            //            AdrRaiTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRRAI"]);
            AdrPnkTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPNK"]);
            AdrStrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRSTR"]);
            AdrDomTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDOM"]);
            AdrAprTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRAPR"]);
            AdrUglTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRUGL"]);
            AdrEtgTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRETG"]);
            AdrPodTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPOD"]);
            AdrDmfTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDMF"]);

            EmpTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);

            AlrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTALR"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSEX"].ToString())) SexFlg.Checked = false;
            else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTSEX"]);

            //   if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTRSD"].ToString())) RsdFlg.Checked = false;
            //   else RsdFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTRSD"]);

            BoxStx.SelectedIndex = 0;

            //           if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTUBLFLG"].ToString())) SexFlg.Checked = false;
            //           else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTUBLFLG"]);

            //           if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTUBLFLG"].ToString())) SexFlg.Checked = false;
            //           else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTUBLFLG"]);

        }
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();

    }

    //------------------------------------------------------------------------
    protected void RepKltIin_Click(object sender, EventArgs e)
    {
        ConfirmDialog.Visible = true;
        ConfirmDialog.VisibleOnLoad = true;

    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (FioTxt.Text.Length == 0)
        {
            Err.Text = "Не указан фамилия";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }
        /*
                if (ImaTxt.Text.Length == 0)
                {
                    Err.Text = "Не указан имя";
                    ConfirmOK.Visible = true;
                    ConfirmOK.VisibleOnLoad = true;
                    return;
                }
         */
        if (IinTxt.Text.Length != 12)
        {
            Err.Text = "Ошибка в ИИН";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (BoxStx.SelectedValue == "")
        {
            Err.Text = "Не указан страхователь";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        if (TelTxt.Text.Length == 0)
        {
            Err.Text = "Не указан телефон";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //       ConfirmDialog.Visible = true;
        //       ConfirmDialog.VisibleOnLoad = true;

        //   }

        //    protected void AddButton_Click(object sender, EventArgs e)
        //    {
        //---------------------------------------------- запись --------------------------
        string KltStx = "";
        string KltFam = "";
        string KltCmp = "";
        string KltCnt = "";
        string KltVar = "";
        string KltUch = "";
        //      string KltSemKrt = "";
        string KltKrtBeg = "";
        string KltKrtEnd = "";
        //       string KltReg = "";
        string KltEmp = "";
        string KltDlg = "";
        bool KltStf = false;
        bool KltVip = false;
        bool KltDspFlg = false;
        bool KltUchTypFlg = false;
        string KltDspDat = "";

        string KltFio = "";
        //       string KltFam = "";
        //        string KltIma = "";
        //        string KltOtc = "";
        bool KltSex = false;
        bool KltRsd = false;
        string KltBrt = "";
        string KltIin = "";
        string KltInv = "";
        string KltTel = "";
        string KltAlr = "";
        string KltAdrObl = "";
        //       string KltAdrRai = "";
        string KltAdrPnk = "";
        string KltAdrStr = "";
        string KltAdrDom = "";
        string KltAdrApr = "";
        string KltAdrUgl = "";
        string KltAdrPod = "";
        string KltAdrEtg = "";
        string KltAdrDmf = "";
        string KltAdrZsd = "";
        string KltKnt001 = "";
        string KltKnt001Tel = "";
        string KltKnt002 = "";
        string KltKnt002Tel = "";
        string KltBol = "";
        string KltLek = "";
        string KltPrt = "";
        string KltKrvGrp = "";
        string KltKrvRes = "";
        string KltMem = "";
        string KltSum = "";
        string KltLgt = "";
        string KltSoz = "";

        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(BoxStx.SelectedValue) == null || Convert.ToString(BoxStx.SelectedValue) == "") KltStx = "";
        else KltStx = Convert.ToString(BoxStx.SelectedValue);

        if (Convert.ToString(BoxOrg.SelectedValue) == null || Convert.ToString(BoxOrg.SelectedValue) == "") KltCmp = "";
        else KltCmp = Convert.ToString(BoxOrg.SelectedValue);

        //        if (Convert.ToString(BoxCnt.SelectedValue) == null || Convert.ToString(BoxCnt.SelectedValue) == "") KltCnt = "";
        //        else KltCnt = Convert.ToString(BoxCnt.SelectedValue);

        //        if (Convert.ToString(BoxVar.SelectedValue) == null || Convert.ToString(BoxVar.SelectedValue) == "") KltVar = "";
        //        else KltVar = Convert.ToString(BoxVar.SelectedValue);

        //       if (Convert.ToString(BoxFam.SelectedValue) == null || Convert.ToString(BoxFam.SelectedValue) == "") KltFam = "";
        //       else KltFam = Convert.ToString(BoxFam.SelectedValue);

        if (Convert.ToString(BoxSoz.SelectedValue) == null || Convert.ToString(BoxSoz.SelectedValue) == "") KltSoz = "";
        else KltSoz = Convert.ToString(BoxSoz.SelectedValue);

        if (Convert.ToString(BegDat.Text) == null || Convert.ToString(BegDat.Text) == "") KltKrtBeg = "";
        else KltKrtBeg = Convert.ToString(BegDat.Text);

        if (Convert.ToString(EndDat.Text) == null || Convert.ToString(EndDat.Text) == "") KltKrtBeg = "";
        else KltKrtEnd = Convert.ToString(EndDat.Text);

        if (Convert.ToString(UchTxt.Text) == null || Convert.ToString(UchTxt.Text) == "") KltUch = "";
        else KltUch = Convert.ToString(UchTxt.Text);

        //     if (Convert.ToString(SplTxt.Text) == null || Convert.ToString(SplTxt.Text) == "") KltSemKrt = "";
        //     else KltSemKrt = Convert.ToString(SplTxt.Text);

        if (Convert.ToString(EmpTxt.Text) == null || Convert.ToString(EmpTxt.Text) == "") KltEmp = "";
        else KltEmp = Convert.ToString(EmpTxt.Text);

        if (Convert.ToString(DlgTxt.Text) == null || Convert.ToString(DlgTxt.Text) == "") KltDlg = "";
        else KltDlg = Convert.ToString(DlgTxt.Text);

        if (Convert.ToString(DspFlg.Text) == "Checked = true") KltDspFlg = true;
        else KltDspFlg = DspFlg.Checked;

        if (Convert.ToString(CtyVilFlg.Text) == "Checked = true") KltUchTypFlg = true;
        else KltUchTypFlg = CtyVilFlg.Checked;

        //       if (Convert.ToString(UblDat.Text) == null || Convert.ToString(UblDat.Text) == "") KltDspDat = "";
        //      else KltDspDat = Convert.ToString(UblDat.Text);

        //       if (Convert.ToString(StfFlg.Text) == null || Convert.ToString(StfFlg.Text) == "") KltStf = false;
        //       else KltStf = Convert.ToBoolean(StfFlg.Text);
        if (Convert.ToString(StfFlg.Text) == "Checked = true") KltStf = true;
        else KltStf = StfFlg.Checked;

        //       if (Convert.ToString(VipFlg.Text) == null || Convert.ToString(VipFlg.Text) == "") KltVip = false;
        //       else KltVip = Convert.ToBoolean(VipFlg.Text);
        if (Convert.ToString(VipFlg.Text) == "Checked = true") KltVip = true;
        else KltVip = VipFlg.Checked;

        // ------------------------------------------------------------------------------------------------------------------------     

        if (Convert.ToString(FioTxt.Text) == null || Convert.ToString(FioTxt.Text) == "") KltFio = "";
        else KltFio = Convert.ToString(FioTxt.Text);

        //        if (Convert.ToString(ImaTxt.Text) == null || Convert.ToString(ImaTxt.Text) == "") KltIma = "";
        //        else KltIma = Convert.ToString(ImaTxt.Text);

        //        if (Convert.ToString(OtcTxt.Text) == null || Convert.ToString(OtcTxt.Text) == "") KltOtc = "";
        //        else KltOtc = Convert.ToString(OtcTxt.Text);


        //        if (Convert.ToString(SexFlg.Text) == null || Convert.ToString(SexFlg.Text) == "") KltSex = false;
        //        else KltSex = Convert.ToBoolean(SexFlg.Text);
        if (Convert.ToString(SexFlg.Text) == "Checked = true") KltSex = true;
        else KltSex = SexFlg.Checked;

        //if (Convert.ToString(RsdFlg.Text) == "Checked = true") KltRsd = true;
        //else KltRsd = RsdFlg.Checked;
        KltRsd = false;

        if (Convert.ToString(BrtDat.Text) == null || Convert.ToString(BrtDat.Text) == "") KltBrt = "";
        else KltBrt = Convert.ToString(BrtDat.Text);

        if (Convert.ToString(IinTxt.Text) == null || Convert.ToString(IinTxt.Text) == "") KltIin = "";
        else KltIin = Convert.ToString(IinTxt.Text);

        if (Convert.ToString(InvTxt.Text) == null || Convert.ToString(InvTxt.Text) == "") KltInv = "";
        else KltInv = Convert.ToString(InvTxt.Text);

        if (Convert.ToString(TelTxt.Text) == null || Convert.ToString(TelTxt.Text) == "") KltTel = "";
        else KltTel = Convert.ToString(TelTxt.Text);

        if (Convert.ToString(AlrTxt.Text) == null || Convert.ToString(AlrTxt.Text) == "") KltAlr = "";
        else KltAlr = Convert.ToString(AlrTxt.Text);

        if (Convert.ToString(AdrPnkTxt.Text) == null || Convert.ToString(AdrPnkTxt.Text) == "") KltAdrPnk = "";
        else KltAdrPnk = Convert.ToString(AdrPnkTxt.Text);

        if (Convert.ToString(AdrOblTxt.Text) == null || Convert.ToString(AdrOblTxt.Text) == "") KltAdrObl = "";
        else KltAdrObl = Convert.ToString(AdrOblTxt.Text);

        if (Convert.ToString(AdrStrTxt.Text) == null || Convert.ToString(AdrStrTxt.Text) == "") KltAdrStr = "";
        else KltAdrStr = Convert.ToString(AdrStrTxt.Text);

        if (Convert.ToString(AdrDomTxt.Text) == null || Convert.ToString(AdrDomTxt.Text) == "") KltAdrDom = "";
        else KltAdrDom = Convert.ToString(AdrDomTxt.Text);

        if (Convert.ToString(AdrAprTxt.Text) == null || Convert.ToString(AdrAprTxt.Text) == "") KltAdrApr = "";
        else KltAdrApr = Convert.ToString(AdrAprTxt.Text);

        if (Convert.ToString(AdrEtgTxt.Text) == null || Convert.ToString(AdrEtgTxt.Text) == "") KltAdrEtg = "";
        else KltAdrEtg = Convert.ToString(AdrEtgTxt.Text);

        if (Convert.ToString(AdrDmfTxt.Text) == null || Convert.ToString(AdrDmfTxt.Text) == "") KltAdrDmf = "";
        else KltAdrDmf = Convert.ToString(AdrDmfTxt.Text);

        if (Convert.ToString(AdrUglTxt.Text) == null || Convert.ToString(AdrUglTxt.Text) == "") KltAdrUgl = "";
        else KltAdrUgl = Convert.ToString(AdrUglTxt.Text);

        if (Convert.ToString(AdrPodTxt.Text) == null || Convert.ToString(AdrPodTxt.Text) == "") KltAdrPod = "";
        else KltAdrPod = Convert.ToString(AdrPodTxt.Text);

        if (Convert.ToString(AdrZsdTxt.Text) == null || Convert.ToString(AdrZsdTxt.Text) == "") KltAdrZsd = "";
        else KltAdrZsd = Convert.ToString(AdrZsdTxt.Text);

        //      ---------------------------------------------------------------------------------------------------------
        if (Convert.ToString(TxtKnt001.Text) == null || Convert.ToString(TxtKnt001.Text) == "") KltKnt001 = "";
        else KltKnt001 = Convert.ToString(TxtKnt001.Text);
        if (Convert.ToString(TxtKnt001Tel.Text) == null || Convert.ToString(TxtKnt001Tel.Text) == "") KltKnt001Tel = "";
        else KltKnt001Tel = Convert.ToString(TxtKnt001Tel.Text);
        if (Convert.ToString(TxtKnt002.Text) == null || Convert.ToString(TxtKnt002.Text) == "") KltKnt002 = "";
        else KltKnt002 = Convert.ToString(TxtKnt002.Text);
        if (Convert.ToString(TxtKnt002Tel.Text) == null || Convert.ToString(TxtKnt002Tel.Text) == "") KltKnt002Tel = "";
        else KltKnt002Tel = Convert.ToString(TxtKnt002Tel.Text);

        if (Convert.ToString(TxtBol.Text) == null || Convert.ToString(TxtBol.Text) == "") KltBol = "";
        else KltBol = Convert.ToString(TxtBol.Text);
        if (Convert.ToString(TxtLek.Text) == null || Convert.ToString(TxtLek.Text) == "") KltLek = "";
        else KltLek = Convert.ToString(TxtLek.Text);
        if (Convert.ToString(TxtPrt.Text) == null || Convert.ToString(TxtPrt.Text) == "") KltPrt = "";
        else KltPrt = Convert.ToString(TxtPrt.Text);

        if (Convert.ToString(BoxKrvGrp.SelectedValue) == null || Convert.ToString(BoxKrvGrp.SelectedValue) == "") KltKrvGrp = "";
        else KltKrvGrp = Convert.ToString(BoxKrvGrp.SelectedValue);
        if (Convert.ToString(BoxKrvRes.SelectedValue) == null || Convert.ToString(BoxKrvRes.SelectedValue) == "") KltKrvRes = "";
        else KltKrvRes = Convert.ToString(BoxKrvRes.SelectedValue);

        if (Convert.ToString(TxtMem.Text) == null || Convert.ToString(TxtMem.Text) == "") KltMem = "";
        else KltMem = Convert.ToString(TxtMem.Text);

        if (Convert.ToString(TxtSum.Text) == null || Convert.ToString(TxtSum.Text) == "") KltSum = "";
        else KltSum = Convert.ToString(TxtSum.Text);

        if (Convert.ToString(TxtLgt.Text) == null || Convert.ToString(TxtLgt.Text) == "") KltLgt = "";
        else KltLgt = Convert.ToString(TxtLgt.Text);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("InsSprCntKltRep", con);
        cmd = new SqlCommand("InsSprCntKltRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KltIdn", SqlDbType.VarChar).Value = TekKltIdn.Value;   // KltOneIdn;
        cmd.Parameters.Add("@CntIdn", SqlDbType.VarChar).Value = TekCntIdn.Value; /// CntOneIdn;
        cmd.Parameters.Add("@KltStx", SqlDbType.VarChar).Value = KltStx;
        cmd.Parameters.Add("@KltCmp", SqlDbType.VarChar).Value = KltCmp;
        cmd.Parameters.Add("@KltCnt", SqlDbType.VarChar).Value = KltCnt;
        cmd.Parameters.Add("@KltVar", SqlDbType.VarChar).Value = KltVar;
        cmd.Parameters.Add("@KltUch", SqlDbType.VarChar).Value = KltUch;
        //      cmd.Parameters.Add("@KltSemKrt", SqlDbType.VarChar).Value = KltSemKrt;
        cmd.Parameters.Add("@KltKrtBeg", SqlDbType.VarChar).Value = KltKrtBeg;
        cmd.Parameters.Add("@KltKrtEnd", SqlDbType.VarChar).Value = KltKrtEnd;
        cmd.Parameters.Add("@KltEmp", SqlDbType.VarChar).Value = KltEmp;
        cmd.Parameters.Add("@KltDlg", SqlDbType.VarChar).Value = KltDlg;
        cmd.Parameters.Add("@KltStf", SqlDbType.Bit, 1).Value = KltStf;
        cmd.Parameters.Add("@KltVip", SqlDbType.Bit, 1).Value = KltVip;
        cmd.Parameters.Add("@KltDspFlg", SqlDbType.Bit, 1).Value = KltDspFlg;
        cmd.Parameters.Add("@KltDspDat", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KltFio", SqlDbType.NVarChar).Value = KltFio;
        //           cmd.Parameters.Add("@KltIma", SqlDbType.VarChar).Value = KltIma;
        //           cmd.Parameters.Add("@KltOtc", SqlDbType.VarChar).Value = KltOtc;
        cmd.Parameters.Add("@KltSex", SqlDbType.Bit, 1).Value = KltSex;
        cmd.Parameters.Add("@KltRsd", SqlDbType.Bit, 1).Value = KltRsd;
        cmd.Parameters.Add("@KltBrt", SqlDbType.VarChar).Value = KltBrt;
        cmd.Parameters.Add("@KltIin", SqlDbType.VarChar).Value = KltIin;
        cmd.Parameters.Add("@KltInv", SqlDbType.VarChar).Value = KltInv;
        cmd.Parameters.Add("@KltTel", SqlDbType.VarChar).Value = KltTel;
        cmd.Parameters.Add("@KltAlr", SqlDbType.VarChar).Value = KltAlr;
        cmd.Parameters.Add("@KltAdrObl", SqlDbType.VarChar).Value = KltAdrObl;
        cmd.Parameters.Add("@KltAdrPnk", SqlDbType.VarChar).Value = KltAdrPnk;
        cmd.Parameters.Add("@KltAdrStr", SqlDbType.VarChar).Value = KltAdrStr;
        cmd.Parameters.Add("@KltAdrDom", SqlDbType.VarChar).Value = KltAdrDom;
        cmd.Parameters.Add("@KltAdrApr", SqlDbType.VarChar).Value = KltAdrApr;
        cmd.Parameters.Add("@KltAdrUgl", SqlDbType.VarChar).Value = KltAdrUgl;
        cmd.Parameters.Add("@KltAdrPod", SqlDbType.VarChar).Value = KltAdrPod;
        cmd.Parameters.Add("@KltAdrEtg", SqlDbType.VarChar).Value = KltAdrEtg;
        cmd.Parameters.Add("@KltAdrDmf", SqlDbType.VarChar).Value = KltAdrDmf;
        cmd.Parameters.Add("@KltAdrZsd", SqlDbType.VarChar).Value = KltAdrZsd;
        //        cmd.Parameters.Add("@KltFam", SqlDbType.VarChar).Value = KltFam;
        cmd.Parameters.Add("@KltSoz", SqlDbType.VarChar).Value = KltSoz;

        cmd.Parameters.Add("@KltKnt001", SqlDbType.VarChar).Value = KltKnt001;
        cmd.Parameters.Add("@KltKnt001Tel", SqlDbType.VarChar).Value = KltKnt001Tel;
        cmd.Parameters.Add("@KltKnt002", SqlDbType.VarChar).Value = KltKnt002;
        cmd.Parameters.Add("@KltKnt002Tel", SqlDbType.VarChar).Value = KltKnt002Tel;
        cmd.Parameters.Add("@KltBol", SqlDbType.VarChar).Value = KltBol;
        cmd.Parameters.Add("@KltLek", SqlDbType.VarChar).Value = KltLek;
        cmd.Parameters.Add("@KltPrt", SqlDbType.VarChar).Value = KltPrt;
        cmd.Parameters.Add("@KltKrvGrp", SqlDbType.VarChar).Value = KltKrvGrp;
        cmd.Parameters.Add("@KltKrvRes", SqlDbType.VarChar).Value = KltKrvRes;
        cmd.Parameters.Add("@KltMem", SqlDbType.VarChar).Value = KltMem;
        cmd.Parameters.Add("@KltSum", SqlDbType.VarChar).Value = KltSum;
        cmd.Parameters.Add("@KltLgt", SqlDbType.VarChar).Value = KltLgt;
        cmd.Parameters.Add("@KltUchTyp", SqlDbType.Bit, 1).Value = KltUchTypFlg;
        
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

        //           ConfirmDialog.Visible = false;
        //           ConfirmDialog.VisibleOnLoad = false;
        SelFio.Value = KltFio;
        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

    }


    //------------------------------------------------------------------------
    protected void MaxKrtNum_Click(object sender, EventArgs e)
    {
        string KltStx = "";
        string KltUch = "";
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(BoxStx.SelectedValue) == null || Convert.ToString(BoxStx.SelectedValue) == "") KltStx = "";
        else KltStx = Convert.ToString(BoxStx.SelectedValue);


        if (KltStx != "")
        {
            //      if (BoxTit.Text == "Запись не найден") return;
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprCntKltMaxKrt", con);
            cmd = new SqlCommand("InsSprCntKltMaxKrt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@KltStx", SqlDbType.VarChar).Value = KltStx;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "InsSprCntKltMaxKrt");

            if (ds.Tables[0].Rows.Count > 0)
            {
                UchTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KRTMAXNUM"]);
            }
            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();
        }
    }



    //------------------------------------------------------------------------
    protected void MaxKrtIin_Click(object sender, EventArgs e)
    {
        string KltStx = "";
        string KltUch = "";
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("InsSprCntKltMaxIin", con);
        cmd = new SqlCommand("InsSprCntKltMaxIin", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //      cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "InsSprCntKltMaxIin");

        if (ds.Tables[0].Rows.Count > 0)
        {
            IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTMAXIIN"]);
        }
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();

    }


    // ==================================================================================================  
    //------------------------------------------------------------------------

    protected void MrgKltIin_Click(object sender, EventArgs e)
    {
        ConfirmDialog.Visible = true;
        ConfirmDialog.VisibleOnLoad = true;

    }

    protected void btnOK_click(object sender, EventArgs e)
    {
        string KltStx = "";
        string KltUch = "";
        int res;

        ConfirmDialog.Visible = false;
        ConfirmDialog.VisibleOnLoad = false;
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprKltIinMrg", con);
        cmd = new SqlCommand("HspSprKltIinMrg", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@IINOLD", SqlDbType.VarChar).Value = IinTxt.Text;
        //       cmd.Parameters.Add("@IINNEW", SqlDbType.VarChar).Value = TxtIinNew.Text;
        // создание DataAdapter

        cmd.ExecuteNonQuery();
        con.Close();

        // ------------------------------------------------------------------------------заполняем второй уровень
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
    }

    //------------------------------------------------------------------------


</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekKltIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 495px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Фамилия , Страховщик ----------------------------------------------------------------------------------------------------------  
     -->  
                         <tr style="height:35px"> 
                            <td width="10%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="IinTxt" width="22%" BackColor="White" Height="25px"
                                     AutoPostBack="true" ontextchanged="IinTxt_OnTextChanged">
		                         </asp:TextBox>

                                 <asp:Button ID="Button3" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                                 <asp:Button ID="ButIIN" runat="server" CommandName="Add" Visible="true" Height="30px" OnClick="MaxKrtIin_Click" Text="Пол.ИИН"/>
                                 <asp:Button ID="ButIINKor" runat="server" CommandName="Add" Visible="false" Height="30px" OnClick="RepKltIin_Click" Text="Изм.ИИН"/>

<%--                                 &nbsp; № инв.--%>
                                 <obout:OboutTextBox runat="server" ID="InvTxt"  width="20%" BackColor="White" Visible="false"
                                      FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                  &nbsp; Город
                                 <obout:OboutCheckBox runat="server" ID="CtyVilFlg" Height="30px"
		                                     FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>  
                                                                  
                                  &nbsp; Дисп.
                                 <obout:OboutCheckBox runat="server" ID="DspFlg" Height="30px"
		                                     FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>  

                             </td>                                                         
                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabStx" Text="&nbsp;Прикрепление:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxStx" Width="100%" Height="200" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain" OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"   
                                        DataSourceID="SdsStx" DataTextField="StxNam" DataValueField="StxKod" >
                                </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Имя , Фирма страхователь ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Фамилия И.О:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="FioTxt"  width="65%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
<%--                                 <obout:OboutTextBox runat="server" ID="TxtSts" width="30%" BackColor="Yellow" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>--%>
                                 <asp:TextBox ID="TxtSts" Width="30%" Height="35" runat="server" Style="position: relative; border:none; font-weight: 700; font-size: small; color: red" />

                            </td>
                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabOrg" Text="&nbsp;Фирма:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxOrg" Width="100%" Height="200" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain" OnSelectedIndexChanged="BoxOrg_OnSelectedIndexChanged" 
                                        DataSourceID="SdsOrg" DataTextField="OrgNam" DataValueField="OrgKod" >
                                 </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Отчество , Договор ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;Пол (муж):</td>
                            <td width="35%" style="vertical-align: central;">
                                 <obout:OboutCheckBox runat="server" ID="SexFlg" Width="5%" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>
                                 &nbsp;Д/р:&nbsp;

                                <obout:OboutTextBox runat="server" ID="BrtDat"  width="22%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                <asp:RegularExpressionValidator ID="regexBrtDat" ControlToValidate="BrtDat" SetFocusOnError="True" 
                                     ValidationExpression="(0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.](19|20)\d\d" ErrorMessage="Ошибка" runat="server" />
                                
                                <asp:Label id="Label1" Text="Статус:&nbsp;" runat="server" Width="10%"/>  

                                 <obout:ComboBox runat="server" ID="BoxSoz"  Width="35%" Height="300" MenuWidth="600" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Дети до 18 лет" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Беременные" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Участники Великой Отечественной войны" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Инвалиды" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Многодетные матери, награжденные подвесками «Алтын алка», «Кумыс алка»" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Получатели адресной социальной помощи" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Пенсионеры по возрасту" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Больным инфекционными, социально-значимыми заболеваниями и заболеваниями, представляющими опасность для окружающих" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="По заболеванию" Value="9" />
                                         </Items>
                                 </obout:ComboBox>  
 <!--  Иност  

                                     <obout:ComboBox runat="server" ID="BoxFam" Width="23%" Height="100" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsFam" DataTextField="FamNam" DataValueField="FamKod" >
                                 </obout:ComboBox>  
     -------------------------------------  -->  

                            </td>
                            <td width="10%" class="PO_RowCap"> 
                                 <asp:Label id="LabEmp" Text="&nbsp;Мест работы:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="EmpTxt"  width="90%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>

                        </tr>
 <!--  Пол, Год рождения , Вариант договора ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Область:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrOblTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 &nbsp;Город:
                                 <obout:OboutTextBox runat="server" ID="AdrPnkTxt"  width="45%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>

                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabDlg" Text="&nbsp;Должность:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="DlgTxt"  width="90%" BackColor="White" Height="60px"
                                     TextMode="SingleLine"  FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>

                        </tr>
 <!-- ИИН , Инвен. номер , Начало страхования, Конец страхования  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                               <td width="10%" class="PO_RowCap">&nbsp;Улица:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrStrTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp;Дом: &nbsp;&nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrDomTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp;Кв:
                                <obout:OboutTextBox runat="server" ID="AdrAprTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                             

                             <td width="10%" class="PO_RowCap">
                                  <asp:Label id="LabBeg" Text="&nbsp;Начало:" runat="server" Width="100%"/> 
                            </td>
                            <td width="35%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="BegDat"  width="35%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 <obout:Calendar ID="CalBeg" runat="server"
			 				                    StyleFolder="/Styles/Calendar/styles/default" 
						                        DatePickerMode="true"
						                        ShowYearSelector="true"
						                        YearSelectorType="DropDownList"
						                        TitleText="Выберите год: "
						                        CultureName = "ru-RU"
						                        TextBoxId = "BegDat"
						                        DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                                
                                <asp:Label id="LabEnd" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Конец:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" runat="server" Width="15%"/> 
                                <obout:OboutTextBox runat="server" ID="EndDat"  width="30%" BackColor="White" Height="35px" 
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                             
                             </td>                                                     
                        </tr>

<!--  Телефон , Карта, Сем.карта----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Подъезд:</td>
                             <td width="35%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="AdrPodTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Этаж: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrEtgTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Д-фон: 
                                 <obout:OboutTextBox runat="server" ID="AdrDmfTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
 

                             <td width="10%" class="PO_RowCap">
                                <asp:Label id="LabKrt" Text="&nbsp;Участок:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="UchTxt"  width="35%" BackColor="White" Height="30px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 <asp:Label id="Label2S" Text="&nbsp; Сотр.:" runat="server" Width="12%"/> 
                                 <obout:OboutCheckBox runat="server" ID="StfFlg" Height="30px"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>                                         
                                 <asp:Label id="LabVip" Text="&nbsp; VIP:" runat="server" Width="10%"/> 
                                 <obout:OboutCheckBox runat="server" ID="VipFlg" Height="30px"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox> 
                            

                                 <asp:Button ID="Button2" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                             </td>


                        </tr>
 <!-- Угол: , Сотрудник и Дата увол.  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Угол:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrUglTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                                 
                                 &nbsp; Заезд: 
                                 <obout:OboutTextBox runat="server" ID="AdrZsdTxt"  width="45%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>
                                                         
                             <td width="10%" class="PO_RowCap">
                                  <asp:Label id="LabSot" Text="&nbsp;Сумма:" runat="server" Width="100%"/> 
                             </td>
                            <td width="35%" style="vertical-align: top;">

                                 <obout:OboutTextBox runat="server" ID="TxtSum"  width="35%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                
                                <asp:Label id="Label02" Text="&nbsp; Льгота (%):" runat="server" Width="25%"/> 
                                
                                 <obout:OboutTextBox runat="server" ID="TxtLgt"  width="10%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

 

 

                            </td>

                        </tr>
</table>
            <hr />
                   <table border="0" cellspacing="0" width="100%" cellpadding="0">

<!--  Телефон: , Группа крови.  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                              <td width="10%" class="PO_RowCap">&nbsp;Телефон:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TelTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>

                            <td width="10%" class="PO_RowCap">&nbsp;Группа крови:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxKrvGrp" Width="40%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsGrp" DataTextField="KrvGrpNam" DataValueField="KrvGrpKod" >
                                 </obout:ComboBox>                         
                                 &nbsp; Резус: 
                                 <obout:ComboBox runat="server" ID="BoxKrvRes" Width="45%" Height="100" 
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsRes" DataTextField="KrvResNam" DataValueField="KrvResKod" >
                                 </obout:ComboBox>  
                             </td>
                        </tr>

             <!--  Экстренные контакты ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Экст.контакты:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtKnt001"  width="40%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                                 <asp:Label id="Label21" Text="Тел:" runat="server" Width="10%"/> 
                                 <obout:OboutTextBox runat="server" ID="TxtKnt001Tel"  width="45%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Экст.контакты:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtKnt002"  width="40%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                                <asp:Label id="Label31" Text="Тел:" runat="server" Width="10%"/> 
                                 <obout:OboutTextBox runat="server" ID="TxtKnt002Tel"  width="45%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>  
                             </td>

                        </tr>
<!--  Заболевания  ----------------------------------------------------------------------------------------------------------  -->  
                           <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Заболевания:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtBol"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Приним.лекарства:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtLek"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>

             <!--  Аллергия,Противопоказания ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Аллерг.на лек:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AlrTxt"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Противопоказания:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtPrt"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>
                 </table>

           <hr />
                   <table border="0" cellspacing="0" width="100%" cellpadding="0">
<!--  Особенности ------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Примечание:</td>
                             <td width="85%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtMem"  width="100%" BackColor="White" Height="60px"
                                        TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>            
                             </td>
                        </tr>
      </table>

         </asp:Panel>
 
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ 
                                            <td width="10%" class="PO_RowCap">&nbsp;Область:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrOblTxt"  width="40%" BackColor="White" Height="60px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
    
                                 &nbsp; Район: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrRaiTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>
               
               
               
               --%>
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
                   <input type="button" value="Экстренная карта помощи" style="width:30%"  onclick="PrtKltQrc()" />
                   <input type="button" value="Фото" style="width:20%"  onclick="WebCam();" />
                   <input type="button" value="SMS" style="width:20%"  onclick="SMSsend();" />
               </center>
           </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="50" Top="20" Height="450" Width="1000" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>
<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>  
              <!--     Dialog должен быть раньше Window-->
      <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите изменить ИИН ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                                <input type="button" value="ОК" onclick="IinButton_Click();" />
                                <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

   <%-- =================  диалоговое окно для смены пароля  ============================================ --%>
    <div class="IinDialog" title="Смена ИИН" style="display: none">
        <%--        <asp:ValidationSummary runat="server" ID="ValidationSummary" CssClass="ValidationSummary" />  --%>
        <table>
            <tr>
                <td>Новый ИИН:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtIinNew"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegExTxtIinNew"
                                        ControlToValidate="txtIinNew"
                                        ValidationExpression="\d+"
                                        Display="Static"
                                        EnableClientScript="true"
                                        ErrorMessage="Ошибка"
                                        runat="server" />

            </tr>
        </table>
    </div>

    <%-- =================  Пароль успешно изменен  ============================================ --%>
    <div class="OkSuccess" title=" Смена ИИН " style="display: none">
        <table>
            <tr>
                <td>ИИН успешно изменен! 
               </td>
            </tr>
        </table>
    </div>

        <%-- ============================  верхний блок  ============================================ --%>
     <div class="SmsDialog" title="Отправка SMS сообщения" style="display: none">
          <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="ТЕЛЕФОН:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox runat="server" ID="TxtTelSms" Width="80%" onkeypress="OnlyNumeric();" MaxLength="13" onfocus="getIt(this);"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                                                  runat="server" 
                                                  ControlToValidate="TxtTelSms"
                                                  Display="None" 
                                                  ErrorMessage="Invalid phone number" 
                                                  SetFocusOnError="True" 
                                                  ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$">
                        </asp:RegularExpressionValidator>  
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label4" Text="ТЕКСТ СООБЩЕНИЯ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtSmsTxt" Width="80%" Height="200" TextMode="MultiLine" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                   </td>
                </tr>
        </table>
    </div>

   <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    </form>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
                                <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="AddButton_Click" OnClientClick="requestPermission();" />
                               <obout:OboutButton runat="server" ID="OboutButton0"   
                                   FolderStyle="styles/grand_gray/OboutButton" Text="ОК" OnClick="AddButton_Click"
		                           OnClientClick="requestPermission();" />
    --%>

    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    
    <asp:SqlDataSource runat="server" ID="sdsCnt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsVar" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsFam" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsRes" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
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
            font-size: 12px;
            outline: 0;
            width: 100%;
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
        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
        .ob_iTIE {
            font-size: xx-large;
            font: bold 12px Tahoma !important; /* для увеличение корректируемого текста*/
        }
        /*------------------------- для OBOUTTEXTBOX  КРАСНЫЙ ЦВЕТ ------------------------*/
        .container-red input {
            color: #FF0000 !important;
        }

        hr {
            border: none; /* Убираем границу */
            background-color: red; /* Цвет линии */
            color: red; /* Цвет линии для IE6-7 */
            height: 2px; /* Толщина линии */
        }
    </style>


</body>

</html>



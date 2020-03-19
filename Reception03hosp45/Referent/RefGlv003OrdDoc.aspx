<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
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


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        
        var myconfirm = 0;

        function KltOneClose() {
        //    alert("KofClose=1");
            KltOneWindow.Close();
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function onchanged(checkbox, iRowIndex) {
    //        alert("checkbox1=" + checkbox + "  " + iRowIndex);

            document.getElementById('parInd').value = iRowIndex;

            var FndIdn = document.getElementById('HidParKltIdn').value;
     //       alert('FIO1=' + FndIdn);
            var FndFio = document.getElementById('HidParKltFio').value;
      //      alert('FIO2=' + FndFio);
            var FndIIN = document.getElementById('HidParKltIin').value;
      //      alert('FIO3=' + FndIIN);
            var FndTel = document.getElementById('HidParKltTel').value;
       //     var FndBrt = localStorage.GrfBrt; //getter
       //     var FndKrt = localStorage.GrfKrt; //getter
       //     var FndCmp = localStorage.GrfCmp; //getter
        //    var FndStx = localStorage.GrfStx; //getter

        //           alert('FIO4=' + FndTel);

         //   document.getElementById('parUpd').value = "0";
            var oRecord = new Object();
            oRecord.GRFIDN = GridDocOneDay.Rows[iRowIndex].Cells[0].Value;
            var GrfDocIdn = GridDocOneDay.Rows[iRowIndex].Cells[0].Value;
   //       oRecord.GRFWWW = GridDocOneDay.Rows[iRowIndex].Cells[6].Value;
            oRecord.GRFBUS = GridDocOneDay.Rows[iRowIndex].Cells[2].Value;

            if (checkbox == false) {
                //             alert("checkbox == false");
                // ----------------------------установит флажок-----------------------------------------------------------------------
                 if (FndFio == "" || FndFio == null) {windowalert("Клиент не указан", "Предупреждения", "warning");}
                    // ---------------------------------------------------------------------------------------------------
                else {
                    var GrfDocRek = 'GRFBUS';
                    var GrfDocVal = true;
                    var GrfDocTyp = 'Bit';

                     // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------
/*
                    var result = ""
                    var d = document.getElementsByTagName("div");
                    for (var i = 0; i < d.length; i++) {
                        result += "i=" + i + " id=" + d[i].id + " Text= " + d[i].innerText + "\n"
                    }
                    alert(result);
*/
                     // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------	
                     // записать флажок
                    var body = GridDocOneDay.GridBodyContainer.firstChild.firstChild.childNodes[1];
                    
                    var cell = body.childNodes[iRowIndex].childNodes[2];
                    cell.firstChild.innerHTML = "<div class='ob_gCc2'>" +
                                                "<input type='checkbox' onmousedown='onchanged(this.checked, " + iRowIndex + ")' checked='checked' /></div>" +
                                                "<div class='ob_gCd'>True</div>";

                    //                    onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocIdn);

                    // записать пациента
                    cell = body.childNodes[iRowIndex].childNodes[5];
                    cell.firstChild.lastChild.innerHTML = FndFio;

                    cell = body.childNodes[iRowIndex].childNodes[6];
                    cell.firstChild.lastChild.innerHTML = FndTel;
                    // запись ФИО
                   //                    alert("=1=" + FndFio + "=2=" + FndIIN + "=3=" + FndTel + "=4=" + FndBrt + "=5=" + FndKrt + "=6=" + FndCmp + "=7=" + FndStx);
                    var BuxKod = document.getElementById('HidParDocKod').value;
                 //                      alert("BuxKod_зап =" + BuxKod);

                    var GrfDocRek2 = "UPDATE AMBCRD SET GRFBUS=1,GRFBUX=" + BuxKod + ",GRFPTH=N'" + FndFio + "',GRFIIN='" + FndIIN + "',GRFTEL=LEFT('" + FndTel +
                                     "',50),GRFSTX=(SELECT TOP 1 CNTKLTKEY FROM SPRCNTKLT WHERE CNTKLTIDN=" + FndIdn + ") WHERE GRFIDN=" + GrfDocIdn;

                    onChangeUpd(GrfDocRek2, '0', 'Upd', GrfDocIdn);

                //     alert("GrfDocRek2=" + GrfDocRek2);
                   // ====================================== ОКНО УСЛУГИ ==============================================================================================================
                   //            alert("OnClientDblClick=" + iRecordIndex);
                     var GrfOneIdn = GridDocOneDay.Rows[iRowIndex].Cells[0].Value;
                     var GrfOneKod = GridDocOneDay.Rows[iRowIndex].Cells[1].Value;
                   //        alert("GrfOneIdn=" + GrfOneIdn);
                   //         alert("GrfOneKod=" + GrfOneKod);

                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=900,height=450,left=250,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                    else {
                        window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:450px;");
                    }

                    // ====================================== ОКНО УСЛУГИ ==============================================================================================================

                    return false;
                 }

            }
                // ------------------------------снять флажок---------------------------------------------------
            else {
                //               alert("checkbox == true");
                //                if (oRecord.GRFWWW == '@') {
                //                    alert("Записан через Интернет!");
                //                }
                //                else {

                // ------------------------------Услуга оказано ?--------------------------------------------------
                $.ajax({
                    type: 'POST',
                    url: '/HspUpdDoc.aspx/CndAmbCrdAmbUsl',
                    contentType: "application/json; charset=utf-8",
                    data: '{"SndPar":"' + GrfDocIdn + '"}',
                    dataType: "json",
                    success: function (response) {
                          //  alert("response=" + response.d);
                            // ------------------------------Услуга оказано ?--------------------------------------------------
                            if (response.d == "No") {
                                ConfirmDialog.screenCenter();
                                ConfirmDialog.Open();  // запрос на снятие флажка
                            }
                            else alert("Удалять нельзя, услуга уже оказано!");
                    },
                    error: function () { alert("ERROR="); }
                });
                //                }
            }
        }

// ===============================================================================================================================================================

        // запрос на снятие флажка отказ
        function Cancel_click() {
            ConfirmDialog.Close();
        }
        // зап        рос на снятие флажка отказ
        function CancelBus_click() {
            ConfirmDialogBus.Close();
        }

        // запрос на снятие флажка согласие
        function OK_click() {
            //           	        alert("OK_click=");
            var Ind = document.getElementById('parInd').value;
            //           alert("checkbox2=" + Ind);

            var body = GridDocOneDay.GridBodyContainer.firstChild.firstChild.childNodes[1];
            var cell = body.childNodes[Ind].childNodes[2];

            cell.firstChild.innerHTML = "<div class='ob_gCc2'>" +
                                         "<input type='checkbox' onmousedown='onchanged(this.checked," + Ind + ")' /></div>" +
                                         "<div class='ob_gCd'>False</div>";

            //  обнулить признак ИНтернета
            //            cell = body.childNodes[Ind].childNodes[6];
            //            cell.firstChild.lastChild.innerHTML = "";
            //  обнулить признак услуги
            var cell = body.childNodes[Ind].childNodes[4];
            cell.firstChild.lastChild.innerHTML = "";

            //  обнулить признак
            cell = body.childNodes[Ind].childNodes[5];
            cell.firstChild.lastChild.innerHTML = "";

            // обнулить признак GRFPTH
            cell = body.childNodes[Ind].childNodes[6];
            cell.firstChild.lastChild.innerHTML = "";

            // обнулить признак GRFPTH
            cell = body.childNodes[Ind].childNodes[7];
            cell.firstChild.lastChild.innerHTML = "";


            // -------------------------------------------------------------------------------- запись в базу удаленных ------------------------------
            var BuxKod = document.getElementById('HidParBuxKod').value;
            //            alert("BuxKod_удал =" + BuxKod);
            var GrfDocIdn = GridDocOneDay.Rows[Ind].Cells[0].Value;
            var GrfDocRek = "INSERT INTO AMBCRDDEL (GrfIdn,GrfRef,GrfFrm,GrfCab,GrfTyp,GrfDocNam,GrfDocIdn,GrfKod,GrfDat,GrfBeg,GrfTimBeg,GrfTimPrb,GrfTimEvk,GrfTimLpu,GrfTimFre,GrfTimEnd, " +
                                                   "GrfPth,GrfBrt,GrfStx,GrfIIN,GrfPol,GrfNnn,GrfNoz,GrfZen,GrfBus,GrfPrzLgt,GrfPrg,GrfBux,GrfTim,GrfDelFlg,GrfDelTim,GrfDelBux) " +
                            "SELECT GrfIdn,GrfRef,GrfFrm,GrfCab,GrfTyp,GrfDocNam,GrfDocIdn,GrfKod,GrfDat,GrfBeg,GrfTimBeg,GrfTimPrb,GrfTimEvk,GrfTimLpu,GrfTimFre,GrfTimEnd, " +
                                   "GrfPth,GrfBrt,GrfStx,GrfIIN,GrfPol,GrfNnn,GrfNoz,GrfZen,GrfBus,GrfPrzLgt,'Реф',GrfBux,GrfTim,1,GETDATE()," + BuxKod +
                            " FROM AMBCRD WHERE GRFIDN=" + GrfDocIdn;
            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);

            // -------------------------------------------------------------------------------- обнулить запись ------------------------------
            GrfDocRek = "UPDATE AMBCRD SET GRFBUS=0,GRFPTH='',GRFIIN='',GRFPOL='',GRFSTX='',GRFINTFLG=0,GRFINTBEG=NULL,GRFINTEND=NULL,GRFEML='',GRFTEL='',GRFTIM=NULL WHERE GRFIDN=" + GrfDocIdn;

            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);

            // -------------------------------------------------------------------------------- удалить услуги ------------------------------
            GrfDocRek = "DELETE FROM AMBUSL WHERE USLAMB=" + GrfDocIdn;

            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);



            ConfirmDialog.Close();

        }

        // запрос на снятие флажка согласие

        //    ------------------------------------------------------------------------------------------------------------------------

        function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocIdn) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBCRD';
            var DatDocKey = 'GRFIDN';
            var DatDocRek = GrfDocRek;
            var DatDocVal = GrfDocVal;
            var DatDocTyp = GrfDocTyp;
            var DatDocIdn = GrfDocIdn;

            //         var QueryString = getQueryString();
            //         DatDocIdn = QueryString[1];
            //         alert("DatDocTyp=" + DatDocTyp);

            //         alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
            switch (DatDocTyp) {
                case 'Sql':
                    DatDocTyp = 'Sql';
                    //   if (DatDocRek.substring(0,6) == 'UPDATE' || DatDocRek.substring(0,6) == 'SELECT' || DatDocRek.substring(0,6) == 'DELETE') SqlStr = DatDocRek;
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
                case 'Upd':
                    DatDocTyp = 'Sql';
                    SqlStr = DatDocRek;
                    break;
                default:
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
            }
          //            alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });

            ConfirmDialog.Close();
        }

        function ButWrtTek_Click() {
            var GrfKod = document.getElementById('HidParDocKod').value;
            //     alert("GrfKod=" + GrfKod);
        //    if (GrfKod == "") {
        //        windowalert("Врач не выбран!", "Предупреждения", "warning");
        //        alert("Врач не выбран!");
        //        return;
        //    }
            if (document.getElementById('HidParKltFio').value == "") {
           //     windowalert("Пациент не выбран!", "Предупреждения", "warning");
                alert("Пациент не выбран!");
                return;
            }

            var SndPar = document.getElementById('HidParFrmKod').value + ":" +
                         document.getElementById('HidParBuxKod').value + ":" +
                         document.getElementById('HidParDocKod').value + ":" +
                         document.getElementById('HidParKltFio').value + ":" +
                         document.getElementById('HidParKltIin').value + ":" +
                         document.getElementById('HidParKltTel').value + ":" +
                         "" + ":" +
                         "" + ":" +
                         document.getElementById('HidParKltTel').value;

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

   //         ButPst001_Click();
        }


        function BusButton_Click() {
            ConfirmDialogBus.screenCenter();
            ConfirmDialogBus.Open();  
       //     alert('11');
        }

        function OnClientDblClick(sender, iRecordIndex) {
             //         alert("OnClientDblClick=" + iRecordIndex);
            var GrfOneIdn = GridDocOneDay.Rows[iRecordIndex].Cells[0].Value;
            var GrfOneKod = GridDocOneDay.Rows[iRecordIndex].Cells[1].Value;
            //       alert("GrfOneIdn=" + GrfOneIdn);
            //        alert("GrfOneKod=" + GrfOneKod);

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=900,height=450,left=250,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
            else {
                window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:450px;");
            }
            return false;
        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";

    string MdbNam = "HOSPBASE";

    string ParBuxKod = "";
    string ParBuxDay = "";
    string ParBuxDat = "";
    string ParKltIdn = "";
    string ParKltFio = "";
    string ParKltIin = "";
    string ParKltTel = "";


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        HidParFrmKod.Value =BuxFrm;
        HidParBuxKod.Value =BuxKod;
        HidParDocKod.Value = Convert.ToString(Request.QueryString["ParBuxKod"]);
        HidParBuxDay.Value = Convert.ToString(Request.QueryString["ParBuxDay"]);
        HidParBuxDat.Value = Convert.ToString(Request.QueryString["ParBuxDat"]).Substring(0,10);
        HidParKltIdn.Value = Convert.ToString(Request.QueryString["ParKltIdn"]);
        HidParKltFio.Value = Convert.ToString(Request.QueryString["ParKltFio"]);
        HidParKltIin.Value = Convert.ToString(Request.QueryString["ParKltIin"]);
        HidParKltTel.Value = Convert.ToString(Request.QueryString["ParKltTel"]);
        //      HidParKltStx.Value = Convert.ToString(Request.QueryString["ParKltStx"]);

        GetGrid();

        //=====================================================================================

        //      if (!Page.IsPostBack)
       
        /*
        int Day = 0;
        DateTime TekDat;
        string TekDatTxt;

        Day = Convert.ToInt32(HidParBuxDay.Value);

        TekDatTxt = Convert.ToDateTime(HidParBuxDat.Value).ToString("dd.MM.yyyy");
        TekDat = DateTime.Parse(TekDatTxt);
        TekDat = TekDat.AddDays(Day-1);

        TekDatTxt = Convert.ToDateTime(TekDat).ToString("dd.MM.yyyy");

        // --------------------------  окно за текущии день ? -------------------------
        if (TekDat != DateTime.Today) ButWrtTek.Visible = false;
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspUslHspDocGrfFio", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = HidParDocKod.Value;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = TekDatTxt;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspUslHspDocGrfFio");

        BoxFio.Text = TekDatTxt+": " + Convert.ToString(ds.Tables[0].Rows[0]["FIODOC"]) + " ("+Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
        //    BoxHsp.Text = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);
        //   BoxDat.Text = TekDatTxt;
        //    BoxStg.Text = Convert.ToString(ds.Tables[0].Rows[0]["STG"]);
        //    ImgDocOne.ImageUrl = "~/DoctorFoto/" + Convert.ToString(ds.Tables[0].Rows[0]["KDRPIC"]);

        con.Close();

        GridDocOneDay.DataSource = ds;
        GridDocOneDay.DataBind();

        con.Close();
        */

    }

    //=============Установки===========================================================================================
    protected void GetGrid()
    {
        int Day = 0;
        DateTime TekDat;
        string TekDatTxt;

        Day = Convert.ToInt32(HidParBuxDay.Value);

        TekDatTxt = Convert.ToDateTime(HidParBuxDat.Value).ToString("dd.MM.yyyy");
        TekDat = DateTime.Parse(TekDatTxt);
        TekDat = TekDat.AddDays(Day-1);

        TekDatTxt = Convert.ToDateTime(TekDat).ToString("dd.MM.yyyy");

        // --------------------------  окно за текущии день ? -------------------------
        if (TekDat != DateTime.Today) ButWrtTek.Visible = false;
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspUslHspDocGrfFio", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = HidParDocKod.Value;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = TekDatTxt;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspUslHspDocGrfFio");

        BoxFio.Text = TekDatTxt+": " + Convert.ToString(ds.Tables[0].Rows[0]["FIODOC"]) + " ("+Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";

        con.Close();

        GridDocOneDay.DataSource = ds;
        GridDocOneDay.DataBind();

        con.Close();
    }


    // ============================ кнопка новый документ  ==============================================

    protected void BusButtonOK_Click(object sender, EventArgs e)
    {
        string LstIdn="";

        if (GridDocOneDay.SelectedRecords != null)
        {
            //=====================================================================================
            foreach (Hashtable oRecord in GridDocOneDay.SelectedRecords)
            {
                LstIdn = LstIdn +  Convert.ToInt32(oRecord["GRFIDN"]).ToString("D10");
            }

            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspRefOrdLstBusWrt", con);
            cmd = new SqlCommand("HspRefOrdLstBusWrt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.Int,4));
            cmd.Parameters.Add(new SqlParameter("@BUXLSTIDN", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BuxSid;
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            cmd.Parameters["@BUXKOD"].Value = BuxKod;
            cmd.Parameters["@BUXLSTIDN"].Value = LstIdn;
            // выполнить
            cmd.ExecuteNonQuery();
            con.Close();

            GetGrid();

        }


    }

    // ======================================================================================

    // ==================================== поиск клиента по фильтрам  ============================================

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
             <asp:HiddenField ID="parInd" runat="server" />
             <asp:HiddenField ID="HidParFrmKod" runat="server" />
             <asp:HiddenField ID="HidParDocKod" runat="server" />
             <asp:HiddenField ID="HidParBuxKod" runat="server" />
             <asp:HiddenField ID="HidParBuxDat" runat="server" />
             <asp:HiddenField ID="HidParBuxDay" runat="server" />
             <asp:HiddenField ID="HidParKltIdn" runat="server" />
             <asp:HiddenField ID="HidParKltIin" runat="server" />
             <asp:HiddenField ID="HidParKltFio" runat="server" />
             <asp:HiddenField ID="HidParKltTel" runat="server" />
             <asp:HiddenField ID="HidParKltStx" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>


        <%-- ============================  средний блок  ============================================ --%>
            <%-- ============================  шапка экрана ============================================ --%>
                <asp:TextBox ID="BoxFio"
                    Text=""
                    BackColor="#DB7093"
                    Font-Names="Verdana"
                    Font-Size="16px"
                    Font-Bold="True"
                    ForeColor="White"
                    Style="top: 0px; left: 0px; position: relative; width: 65%"
                    runat="server"></asp:TextBox>
               <asp:Button runat="server" ID="ButWrtTek" Width="20%" Text="Зап.тек.время" OnClientClick="ButWrtTek_Click();" 
                   style="height:25px;width:15%;position: relative; top: 0px; left: 0px"/>

               <asp:Button runat="server" ID="ButBus" Text="Занят" OnClick="BusButtonOK_Click"
                   style="height:25px; width:10%;position: relative; top: 0px; left: 0px"/>

                <obout:Grid ID="GridDocOneDay" runat="server"
                    ShowFooter="false"
                    AllowSorting="false"
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
                    KeepSelectedRecords="false"
                    Width="100%"
                    PageSize="-1">
                    <ScrollingSettings ScrollHeight="400" />
   	                <ClientSideEvents ExposeSender="true" OnClientDblClick="OnClientDblClick" />
                   <Columns>
                        <obout:Column ID="Column0" DataField="GRFIDN" HeaderText="Идн" ReadOnly="true" Visible="false" Width="0%" />
                        <obout:Column ID="Column1" DataField="BEGTIM" DataFormatString="{0:HH:mm}" HeaderText="ВРЕМЯ" ReadOnly="true" Width="5%" />
                        <obout:Column ID="Column2" DataField="GRFBUS" HeaderText="ЗАНЯТ" ReadOnly="true" Width="5%">
                            <TemplateSettings TemplateId="tplBus" />
                        </obout:Column>
                        <obout:Column ID="Column3" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="5%" />
                        <obout:Column ID="Column4" DataField="USLKOL" HeaderText="УСЛ"  Width="5%" />
                        <obout:Column ID="Column5" DataField="GRFPTH" HeaderText="ПАЦИЕНТ" ReadOnly="true" Width="40%" />
                        <obout:Column ID="Column6" DataField="GRFTEL" HeaderText="ТЕЛЕФОН" ReadOnly="true" Width="30%" />
                        <obout:Column ID="Column7" DataField="ORGSTX" HeaderText="СТРАХ." ReadOnly="true" Width="10%" />
                    </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus">
                        <Template>
                            <input type="checkbox" onmousedown="onchanged(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                       </Template>
                    </obout:GridTemplate>
                </Templates>

                </obout:Grid>


<%-- =================  для удаление документа ============================================ --%>
               <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialog" runat="server" Visible="true" VisibleOnLoad="false" IsModal="true" Position="CUSTOM" 
                    Top="50" Left="100" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" 
                    Title="Cнять прием" zIndex="10" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите снять прием ?</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <input type="button" value="OK" onclick="OK_click()" />
                              <input type="button" value="Отмена" onclick="Cancel_click()" />
                        </td>
                    </tr>
                </table> 
            </center>
        </owd:Dialog>

       <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialogBus" runat="server" Visible="true" VisibleOnLoad="false" IsModal="true" Position="CUSTOM" 
                    Top="50" Left="100" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" 
                    Title="Занять график" zIndex="10" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите занять график ?</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="ОК" onclick="BusButtonOK_Click"/>
                              <input type="button" value="Отмена" onclick="CancelBus_click()" />
                        </td>
                    </tr>
                </table> 
            </center>
        </owd:Dialog>

<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
            <%-- ============================  для windowalert ============================================ --%>
     <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    </form>

    <%-- ============================  STYLES ============================================ --%>

<%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

     ------------------------------------- для удаления отступов в GRID --------------------------------%>
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



            a.pg
            {
                font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
            }

            a.pg:hover {
                color: crimson;
            }
    </style>

</body>
</html>



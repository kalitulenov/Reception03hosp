<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- для диалога -------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
<%-- ============================  JAVA ============================================ --%>
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
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
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

       /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
			}
			a.pg:hover {
				color:crimson;
			}

    </style>

 <script type="text/javascript">
     var myconfirm = 0;
     myDialogDubl.visible = false;

     // Client-Side Events for Delete
     function OnBeforeDelete(sender, record)
     {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;

    //     alert(GrfFrm + '  ' + GrfKod);
         if (GrfFrm == 3)
         {

             if (GrfKod != 934) {
                 windowalert("Удалять документ нельзя!", "Предупреждения", "warning");
                 return false;
             }
         }

         if (myconfirm == 1) 
         {
             return true;
         }
         else {
             document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
             document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
             myConfirmBeforeDelete.Open();
             return false;
         }
     }

     function findIndex(record) 
     {
         var index = -1;
         for (var i = 0; i < GridKas.Rows.length; i++) {
             if (GridKas.Rows[i].Cells[0].Value == record.KASIDN) 
             {
                 index = i;
                 break;
             }
         }
         return index;
     }

     function ConfirmBeforeDeleteOnClick() 
     {
         myconfirm = 1;
         document.getElementById('MainContent_parKasDbl').value="";

  //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         GridKas.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function OnClientDblClick(sender, iRecordIndex) {
     //    alert('OnClientDblClick=' + iRecordIndex);
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;

         if (GridKas.Rows[iRecordIndex].Cells[1].Value == "+") GlvDocTyp = "Прх";
         else GlvDocTyp = "Рсх";

         //      alert('GlvDocTyp=' + GlvDocTyp);

         var GlvDocIdn = GridKas.Rows[iRecordIndex].Cells[0].Value;
         var GlvDocPrv = GridKas.Rows[iRecordIndex].Cells[13].Value;
         //          alert('GlvDocIdn=' + GlvDocIdn + GlvDocPrv); 

         if (GlvDocPrv == '+') GlvDocPrv = 'проведен';

         switch (GlvDocTyp) {
             case 'Прх': KasWindow.setUrl("/BuxDoc/BuxKasPrx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv); break;
             case 'Рсх': KasWindow.setUrl("/BuxDoc/BuxKasRsx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv); break;
         }
         KasWindow.Open();
     }


     function OnClientSelect(sender, selectedRecords) {
     //    alert('OnClientSelect=');
         //        var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (document.getElementById('MainContent_parKasDbl').value == "DUBL")
         {
             document.getElementById('MainContent_parKasDbl').value = ""; return;
         }

         var GlvDocTyp;
         if (selectedRecords[0].KASOPR == "+") GlvDocTyp = "Прх";
         else GlvDocTyp = "Рсх";


         var GlvDocIdn = selectedRecords[0].KASIDN;
         var GlvDocPrv = selectedRecords[0].VIP;
         //          alert('GlvDocIdn=' + GlvDocIdn + GlvDocPrv); 

         if (GlvDocPrv == '+') GlvDocPrv = 'проведен';

         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         switch (GlvDocTyp) {
             //            case 'Прх': location.href = "/BuxDoc/BuxKasPrxStd.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv; break;
             //            case 'Рсх': location.href = "/BuxDoc/BuxKasRsxStd.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv; break;
             case 'Прх':
                 if (GrfFrm == 6)
                 {
                     KasWindow.setPosition(300, 150);
                     KasWindow.setSize(800, 200);
                     KasWindow.setUrl("/BuxDoc/BuxKasPrxDat.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv);
                 }
                 else {
                     KasWindow.setUrl("/BuxDoc/BuxKasPrx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv);
                 }
                 break;
             case 'Рсх': KasWindow.setUrl("/BuxDoc/BuxKasRsx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=" + GlvDocPrv); break;
         }
         KasWindow.Open();
     }


     function PrxOrdAdd() {
//         alert("PrxOrdAdd");
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         if (GrfFrm == 6) {
             KasWindow.setPosition(300, 150);
             KasWindow.setSize(800, 200);
             KasWindow.setUrl("/BuxDoc/BuxKasPrxDat.aspx?GlvDocIdn=0&GlvDocPrv=''");
             KasWindow.Open();
         }
         else
         {
             KasWindow.setUrl("/BuxDoc/BuxKasPrx.aspx?GlvDocIdn=0&GlvDocPrv=''");
             KasWindow.Open();
         }
         //         location.href = "/BuxDoc/BuxKasPrxStd.aspx?GlvDocIdn=0&GlvDocPrv=''";
     }

     function RsxOrdAdd() {
         KasWindow.setUrl("/BuxDoc/BuxKasRsx.aspx?GlvDocIdn=0&GlvDocPrv=''");
         KasWindow.Open();
         //        location.href = "/BuxDoc/BuxKasRsxStd.aspx?GlvDocIdn=0&GlvDocPrv=''";
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtJrnButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parKasAcc').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         if (GrfTyp == '0000') { windowalert("Счет не указан", "Предупреждения", "warning"); return; }

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxKasJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtBokButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parKasAcc').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         if (GrfTyp == '0000') { windowalert("Счет не указан", "Предупреждения", "warning"); return; }

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxKasBok&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasBok&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtAnlButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parKasAcc').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxKasAnl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasAnl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSvdButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parKasAcc').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxKasSvd&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasSvd&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function ExlButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = "КАС";    // document.getElementById('MainContent_parDocTyp').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         location.href = "/Report/DauaReports.aspx?ReportName=BuxKasExpExl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd;
/*
         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=BuxKasExpExl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasExpExl&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
*/
     }




     function KasClose() {
          KasWindow.Close();
     }

     function KasPostBack() {
         var jsVar = "dotnetcurry.com";
         __doPostBack('callPostBack', jsVar);

     }

     function GridKas_dbl(rowIndex) {
   //      alert('GridKas_dbl=1');
         document.getElementById('MainContent_parKasDbl').value = "DUBL";


         var AmbKasOpr = GridKas.Rows[rowIndex].Cells[1].Value;
//         if (AmbKasOpr == "+")
 //        {
             var AmbKasIdn = GridKas.Rows[rowIndex].Cells[0].Value;
             document.getElementById('MainContent_parKasIdn').value=AmbKasIdn;
             document.getElementById('MainContent_parKasOpr').value=AmbKasOpr;
             myDialogDubl.Open();
         //         }
     }

     function OpenDublKas(GlvDocIdnDbl) {
      //   alert('GlvDocIdnDbl=' + GlvDocIdnDbl);
         if (document.getElementById('MainContent_parKasOpr').value == "+")   
             KasWindow.setUrl("/BuxDoc/BuxKasPrx.aspx?GlvDocIdn=" + GlvDocIdnDbl + "&GlvDocPrv='проведен'");
         else
             KasWindow.setUrl("/BuxDoc/BuxKasRsx.aspx?GlvDocIdn=" + GlvDocIdnDbl + "&GlvDocPrv='проведен'");

         KasWindow.Open();
 }

     // -------изменение как EXCEL-------------------------------------------------------------------          

     function filterGrid(e) {
         var fieldName;
         //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
             fieldName = 'KASFIONAM';
             GridKas.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
             GridKas.executeFilter();
         }
         else {
             GridKas.removeFilter();
         }
     }

     //    ====================================================================================================================
     function UslButton_Click() {
         //           alert("OnClientDblClick=" + iRecordIndex);

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/BuxDoc/BuxKasPrxSel.aspx", "ModalPopUp", "toolbar=no,width=1200,height=600,left=100,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/BuxDoc/BuxKasPrxSel.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:100px;dialogtop:100px;dialogWidth:1200px;dialogHeight:600px;");

         //      return true;
         return false;
     }     

 </script>

        <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int GlvDocIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSumRsx = 0;
        decimal ItgDocSumPrx = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtDoc;
            Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            HidBuxFrm.Value = BuxFrm;
            HidBuxKod.Value = BuxKod;
            //============= начало  ===========================================================================================


            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridKas.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //        GridKas.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);
            sdsKas.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            //          sdsKas.SelectCommand = "SELECT ACCKOD,ACCNAM FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,2)='10' AND ACCPRV=1 ORDER BY ACCKOD";

            if (!Page.IsPostBack)
            {

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();

                getKasNum();
                getGrid();

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("BuxKasLstAcc", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@KASACC", SqlDbType.VarChar).Value = parKasAcc.Value;
            cmd.Parameters.Add("@KASBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@KASENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxKasLstAcc");

            con.Close();

            GridKas.DataSource = ds;
            GridKas.DataBind();

            TxtInpOct.Text = Convert.ToString(ds.Tables[0].Rows[0]["OSTBEG"]);
            TxtOutOct.Text = Convert.ToString(ds.Tables[0].Rows[0]["OSTEND"]);
        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);
            // строка соединение
            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int KasIdn;
            KasIdn = Convert.ToInt32(e.Record["KASIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("BuxKasDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = KasIdn;
            cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

        // ---------Суммация  ------------------------------------------------------------------------
        public void GridKas_RowCreated(object sender, GridRowEventArgs e)
        {
            if (IsPostBack && e.Row.RowType == GridRowType.Header)
            {
                ItgDocSumPrx = 0;
                ItgDocSumRsx = 0;
            }
        }
        // ---------Суммация  ------------------------------------------------------------------------
        public void GridKas_RowDataBound(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[9].Text == null | e.Row.Cells[9].Text == "") ItgDocSumRsx += 0;
                else ItgDocSumPrx += decimal.Parse(e.Row.Cells[9].Text);

                if (e.Row.Cells[10].Text == null | e.Row.Cells[10].Text == "") ItgDocSumPrx += 0;
                else ItgDocSumRsx += decimal.Parse(e.Row.Cells[10].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[3].Text = "Итого:";
                e.Row.Cells[9].Text = ItgDocSumPrx.ToString();
                e.Row.Cells[10].Text = ItgDocSumRsx.ToString();

            }
        }

        //------------------------------------------------------------------------

        // ============================ отказ записи документа в базу ==============================================
        protected void DblButtonOK_Click(object sender, EventArgs e)
        {
            string GlvDocIdnDbl;

            myDialogDubl.Visible = false;
            myDialogDubl.VisibleOnLoad = false;

            GlvDocIdn = Convert.ToInt32(parKasIdn.Value);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxKasOrdDbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
            cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@KASIDNOUT", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters["@KASIDNOUT"].Direction = ParameterDirection.Output;

            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
                GlvDocIdnDbl = Convert.ToString(cmd.Parameters["@KASIDNOUT"].Value);
            }
            finally
            {
                con.Close();
            }

            ExecOnLoad("OpenDublKas("+GlvDocIdnDbl+");");

        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getKasNum()
        {
            string SqlKas;

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxKasKod", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxKasKod");

            con.Close();


            BoxKas.Items.Clear();
            BoxKas.SelectedIndex = 0;
            int i = 0;
            foreach (DataRow row in ds.Tables["BuxKasKod"].Rows)
            {
                i = i + 1;
                if (i == 1) parKasAcc.Value = Convert.ToString(row["ACCKOD"]);
                BoxKas.Items.Add(new ComboBoxItem(row["ACCKOD"].ToString(),row["ACCKOD"].ToString()));
            }
            BoxKas.Items.Add(new Obout.ComboBox.ComboBoxItem("Все cчета", "0000"));

        }

                //------------------------------------------------------------------------
        protected void BoxKas_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            parKasAcc.Value = BoxKas.SelectedValue;
            getGrid();
        }

        // ======================================================================================

 </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parKasIdn" runat="server" />
 <asp:HiddenField ID="parKasDbl" runat="server" />
 <asp:HiddenField ID="parKasOpr" runat="server" />
 <asp:HiddenField ID="parFixDbl" runat="server" />
 <asp:HiddenField ID="parKasAcc" runat="server" />

     <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />
  
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 15%; position: relative; top: 0px; width: 70%; height: 30px;">

        <table border="0" cellspacing="0" width="100%">
            <tr>
                <td width="20%" class="PO_RowCap">
                 <asp:Label ID="Label4" runat="server" Text="Счет:"></asp:Label>
                 <obout:ComboBox runat="server"
                            ID="BoxKas"
                            Width="60%"
                            Height="200"
                            Font-Bold="true"
                            EmptyText="Выберите кассу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxKas_OnSelectedIndexChanged"
                            DataSourceID="sdsKas"
                            DataTextField="ACCNAM"
                            DataValueField="ACCKOD" >
                 </obout:ComboBox> 
                </td>
                <td width="35%" class="PO_RowCap">
                    <asp:Label ID="Label1" runat="server" Text="Период"></asp:Label>
                    <asp:TextBox runat="server" ID="txtDate1" Width="80px" BackColor="#FFFFE0" />
                    <obout:Calendar ID="cal1" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="txtDate1"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                    <asp:TextBox runat="server" ID="txtDate2" Width="80px" BackColor="#FFFFE0" />
                    <obout:Calendar ID="cal2" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="txtDate2"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                    <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" OnClick="PushButton_Click" />
                </td>
                <td width="25%" class="PO_RowCap">
                   <asp:Label ID="Label2" runat="server" Text="Вх.ост"></asp:Label>
                   <asp:TextBox runat="server" ID="TxtInpOct" Width="80px" BackColor="#FFFFE0" />
                   <asp:Label ID="Label3" runat="server" Text="Исх.ост"></asp:Label>
                   <asp:TextBox runat="server" ID="TxtOutOct" Width="80px" BackColor="#FFFFE0" />

                </td>
            </tr>
        </table>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 15%; position: relative; top: 0px; width: 70%; height: 500px;">
	        
	        <obout:Grid id="GridKas" runat="server" 
                 CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
	            Language = "ru"
	            PageSize = "-1"
  AllowRecordSelection = "true"
	            AllowPaging="false"
	            Width="100%"
     OnRowCreated="GridKas_RowCreated"
     OnRowDataBound="GridKas_RowDataBound"
                AllowPageSizeSelection="false"
          AllowFiltering="true" 
          FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "true" >
	            <ScrollingSettings ScrollHeight="95%" />
                <ClientSideEvents ExposeSender="true" 
                        OnClientSelect="OnClientSelect"  
                        OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="KASIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column01" DataField="KASOPR" HeaderText="+"  Visible="false" Width="0%"/>
                    <obout:Column ID="Column02" DataField="KASNUM" HeaderText="НОМЕР" Align="center" Width="6%"/>
	                <obout:Column ID="Column03" DataField="KASDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="8%" Align="center" />
	                <obout:Column ID="Column04" DataField="KASACCKAS" HeaderText="ДЕБЕТ" Width="6%" />
	                <obout:Column ID="Column05" DataField="KASACC" HeaderText="КРЕДИТ"  Align="center" Width="6%" />
	                <obout:Column ID="Column07" DataField="KASIIN" HeaderText="ИИН/БИН" Width="0%" />
	                <obout:Column ID="Column08" DataField="KASFIZ" HeaderText="ФИЗ/ЮР" Width="0%" />
	                <obout:Column ID="Column09" DataField="KASFIONAM" HeaderText="ФАМИЛИЯ И.О." Width="21%" />
	                <obout:Column ID="Column10" DataField="KASSUMPRX" HeaderText="ПРИХОД" Width="8%" Align="right" DataFormatString="{0:F2}"/>
	                <obout:Column ID="Column11" DataField="KASSUMRSX" HeaderText="РАСХОД" Width="8%" Align="right" DataFormatString="{0:F2}"/>
	                <obout:Column ID="Column12" DataField="DOC" HeaderText="ВРАЧ" Width="15%" />
	                <obout:Column ID="Column13" DataField="BUX" HeaderText="КАССИР" Width="10%" />
	                <obout:Column ID="Column14" DataField="VIP" HeaderText="ПРОВ" Width="4%" />
		            <obout:Column ID="Column15" DataField="" HeaderText="УДЛ" Width="4%" AllowEdit="false" AllowDelete="true" runat="server" />
                    <obout:Column ID="Column16" DataField="DBL" HeaderText="ДУБЛ" Width="4%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateRsx" />
				    </obout:Column>				
                </Columns>

              <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                       <Template>
                          <input type="button" id="btnDbl" class="tdTextSmall" value="Дбл" onmousedown="GridKas_dbl(<%# Container.PageRecordIndex %>)"/>
 					</Template>
                    </obout:GridTemplate>
                </Templates>
           	</obout:Grid>


       <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ 
                              OnClientSelect="OnClientSelect"   	                      OnClientDblClick="OnClientDblClick" 

    --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 15%; position: relative; top: 0px; width: 70%; height: 30px;">
             <center>
                 <input type="button" value="Приход" style="width:10%"  onclick="PrxOrdAdd()" />
                 <input type="button" value="Расход" style="width:10%"  onclick="RsxOrdAdd()" />
                 <input type="button" name="PrtButton" value="Кассовый журнал" id="PrtJrnButton" onclick="PrtJrnButton_Click();" />
                 <input type="button" name="PrtButton" value="Кассовая книга" id="PrtBokButton" onclick="PrtBokButton_Click();" />
                 <input type="button" name="PrtButton" value="Свод по кассе" id="PrSvdButton" onclick="PrtSvdButton_Click();" />
                 <input type="button" name="PrtButton" value="Экспрот в Excel" id="ExlButton" onclick="ExlButton_Click(); return false;" />
                 <input type="button" name="PrtButton" value="Неопл. услуги" id="UslButton" onclick="UslButton_Click();" />
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click" />
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
      <owd:Dialog ID="myDialogDubl" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Дублирования приходного ордера" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите дублировать приходный ордер?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="DblButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="myDialogDubl.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 


       <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
       <owd:Window ID="KasWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="100" Top="150" Height="350" Width="1100" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="ПРОВОДКА">
       </owd:Window>  

    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    
<%-- =================  источник  для ГРИДА============================================ --%>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
    <asp:SqlDataSource runat="server" ID="sdsKas" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

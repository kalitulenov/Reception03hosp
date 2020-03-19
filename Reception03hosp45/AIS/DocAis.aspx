<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
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
//     myDialogDubl.visible = false;

     // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
     // Client-Side Events for Delete
     // при ExposeSender = "false" OnBeforeDelete(record)
     // при ExposeSender = "true" OnBeforeDelete(sender,record)
     function OnBeforeDelete(sender,record) {
 //         alert("OnBeforeDelete");
          if (record.GRFDOCNAM == 'НАЗ') {
              alert('Удалять процедуры нельзя!');
              return false;
          }
          else {
              if (myconfirm == 1) {
                  return true;
              }
              else {
                  document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
                  document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                  myConfirmBeforeDelete.Open();
                  return false;
              }
          }
     }

     function findIndex(record) 
     {
         var index = -1;
         for (var i = 0; i < GridAis.Rows.length; i++) {
             if (GridAis.Rows[i].Cells[0].Value == record.GRFIDN) 
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
 //        alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         GridAis.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function KofButton_Click() {
          //    alert("GridKlt_ClientInsert");
              var KltOneIdn = 0;
              var BegDat = document.getElementById('MainContent_txtDate1').value;
              var EndDat = document.getElementById('MainContent_txtDate2').value;
         //     alert("GridKlt_ClientInsert=2");

              KofWindow.setTitle("Коэффициент");
              KofWindow.setUrl("DocAisKof.aspx?BegDat=" + BegDat + "&EndDat=" + EndDat);
              KofWindow.Open();
     }

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'GRFPTH';
           GridAis.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridAis.executeFilter();
         }
         else {
             GridAis.removeFilter();
         }
     }

     function KofClose() {
      //   alert("KofClose=1" + result);
         KofWindow.Close();
         KofClick();

     }

     function KofClick() {
         document.getElementById("MainContent_PushButton").click();
     }

    //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtJurButton_Click() 
     {
     }
//    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSvdButton_Click() 
     {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisSvd&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisSvd&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSvdMkbButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisSvdMkb&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisSvdMkb&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSvdIinButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisSvdIin&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisSvdIin&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSvdDocButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisSvdDoc&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisSvdDoc&TekDocIdn=" + GrfTyp + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }


//    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtSttCrdButton_Click() 
     {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisTrfErr&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisTrfErr&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtErrButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisErrKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisErrKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     function PrtFioButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisFioKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisFioKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     function PrtDocButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisDocKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisDocKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }
     function PrtTrfButton_Click() {
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
         var GrfTyp = "AIS";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAisTrfKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAisTrfKrt&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
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

        int AmbCrdIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgSum = 0;
        decimal ItgPmc = 0;
        decimal ItgKdu = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //          GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            //           parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //           TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
            //          Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================
  //          ConfirmOK.Visible = false;
  //          ConfirmOK.VisibleOnLoad = false;

            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
 //           GridAis.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //           GridAis.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
  //          GridAis.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

            if (!Page.IsPostBack)
            {
                if (Session["pgSize"] != null)
                {
                    GridAis.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
                }

                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();

                getGrid();

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
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

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocStt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = 0;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocStt");

            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //          Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]) + " (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
                    TxtPmc.Text = Convert.ToString(ds.Tables[0].Rows[0]["PMCSUM"]);
                    TxtPmcPrz.Text = Convert.ToString(ds.Tables[0].Rows[0]["PMCPRZ"]);
                    TxtKdu.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDUSUM"]);
                    TxtKduPrz.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDUPRZ"]);
                    TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["ALLSUM"]);
                }
            }
            catch
            {
            }



            con.Close();

            GridAis.DataSource = ds;
            GridAis.DataBind();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            getGrid();
        }

        // ======================================================================================
        protected void ImpButton_Click(object sender, EventArgs e)
        {
            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;
        }

        // ============================ одобрение для записи документа в базу ==============================================
        protected void ImpBtnOK_click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocSttImp", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание команды
            cmd.CommandTimeout = 120;
            cmd.ExecuteNonQuery();
            con.Close();

            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;

            getGrid();
        }
        // ======================================================================================
        protected void AnlButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       анализ 
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocSttAnl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание команды
            cmd.CommandTimeout = 120;
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

                // ======================================================================================
        protected void FinButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       анализ 
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmdFin = new SqlCommand("HspTabSttExpAppGbmOsm", con);
            // указать тип команды
            cmdFin.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmdFin.Parameters.Add("@BUXFRMKOD", SqlDbType.VarChar).Value = BuxFrm;
            cmdFin.Parameters.Add("@BUXBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmdFin.Parameters.Add("BUXENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание команды
            cmdFin.CommandTimeout = 120;
            cmdFin.ExecuteNonQuery();
            con.Close();

            getGrid();
        }


        // ======================================================================================
        protected void TrfButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocSttTrf", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
        // ======================================================================================
        protected void KofButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocSttTrf", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
        // ======================================================================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            getGrid();
        }
        // ======================================================================================

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            string AmbCrdIdn;
            AmbCrdIdn = Convert.ToString(e.Record["GRFIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

        // ---------Суммация  ------------------------------------------------------------------------
        // ---------Суммация  ------------------------------------------------------------------------
        // ============================ дублировать амб.карту ==============================================

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parCrdIdn" runat="server" />
 <asp:HiddenField ID="parDbl" runat="server" />
   
 
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="ЖУРНАЛ ПО СТАТИСТИКЕ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 2%; position: relative; top: 0px; width: 96%; height: 30px;">

        <table border="0" cellspacing="0" width="100%">
            <tr>
                <td width="25%" class="PO_RowCap">
                </td>
                <td width="30%" class="PO_RowCap">
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
                <td width="2%" class="PO_RowCap">
                </td>
                <td width="13%" class="PO_RowCap">
                    <asp:Label ID="Label5" runat="server" Text="Сумма:"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtSum" Width="80px" BackColor="#FFFFE0" />
                </td>
                <td width="15%" class="PO_RowCap">
                    <asp:Label ID="Label6" runat="server" Text="ПМСП:"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtPmc" Width="80px" BackColor="#FFFFE0" />
                    <asp:TextBox runat="server" ID="TxtPmcPrz" Width="20px" BackColor="#FFFFE0" />%
                </td>
                <td width="15%" class="PO_RowCap">
                    <asp:Label ID="Label7" runat="server" Text="КДУ:"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtKdu" Width="80px" BackColor="#FFFFE0" />
                    <asp:TextBox runat="server" ID="TxtKduPrz" Width="20px" BackColor="#FFFFE0" />%
               </td>
            </tr>
        </table>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>


 <%-- ============================  OnClientDblClick  ============================================ 
      <ClientSideEvents ExposeSender="true"
                        OnClientDblClick="OnClientDblClick"
     --%>

 <%-- ============================  OnClientSelect  ============================================ 
       AllowRecordSelection = "true"
      <ClientSideEvents ExposeSender="false"
                          OnClientSelect="OnClientSelect"
     --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 460px;">
	        
	        <obout:Grid id="GridAis" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
               AllowSorting="true"
	            Language = "ru"
	            PageSize = "500"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFPRG" HeaderText="ПРГ" Width="3%" />
	                <obout:Column ID="Column02" DataField="NAMDOCFIO" HeaderText="ВРАЧ" Width="5%" />
	                <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="4%" />
	                <obout:Column ID="Column04" DataField="GRFPTH" HeaderText="ФИО" Width="15%" />
	                <obout:Column ID="Column06" DataField="GRFIIN" HeaderText="ИИН" Width="7%" />
	                <obout:Column ID="Column07" DataField="GRFMKB" HeaderText="МКБ" Width="5%" />
	                <obout:Column ID="Column08" DataField="GRFTRF" HeaderText="ТАРИФ"  Width="6%"/>
 	                <obout:Column ID="Column09" DataField="GRFERR" HeaderText="ОШИБ." Width="10%"/>
	                <obout:Column ID="Column10" DataField="NAMUSL" HeaderText="УСЛУГА" Width="10%" />
	                <obout:Column ID="Column11" DataField="GRFSTTFIN" HeaderText="ФИНАНСИР" Width="13%" />
	                <obout:Column ID="Column12" DataField="GRFKOL" HeaderText="КОЛ" Width="3%" />
	                <obout:Column ID="Column13" DataField="GRFKOF" HeaderText="КОФ" Width="3%" />
  	                <obout:Column ID="Column14" DataField="GRFZEN" HeaderText="СУММА" Width="4%" Align="right"/>
	                <obout:Column ID="Column15" DataField="PMCP" HeaderText="ПМСП" Width="4%" Align="right" />
	                <obout:Column ID="Column16" DataField="KDU" HeaderText="КДУ" Width="4%" Align="right"/>
	                <obout:Column ID="Column17" DataField="AIS" HeaderText="АИС" Width="4%" Align="center"/>
		        </Columns>

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

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 30px;">
             <center>
                 <asp:Button runat="server" Text="Импорт" id="ImpButton" onclick="ImpButton_Click"/>
                 <asp:Button runat="server" Text="Анализ" id="AnlButton" onclick="AnlButton_Click"/>
                 <asp:Button runat="server" Text="Финанс." id="TrfButton" onclick="FinButton_Click"/>

                 <input type="button" name="PrtButton" value="Протокол ошибок" id="PrtErrKrt" onclick="PrtErrButton_Click();">
                 <input type="button" name="PrtButton" value="Печать по врачам" id="PrtDocKrt" onclick="PrtDocButton_Click();">
                 <input type="button" name="PrtButton" value="Печать по пациен" id="PrtFioKrt" onclick="PrtFioButton_Click();">
                 <input type="button" name="PrtButton" value="Печать по тарифу" id="PrtTrfKrt" onclick="PrtTrfButton_Click();">
                 <input type="button" name="PrtButton" value="Печать свода (тариф)" id="PrtSvdTrf" onclick="PrtSvdButton_Click();">
                 <input type="button" name="PrtButton" value="Печать свода (МКБ)" id="PrtSvdMkb" onclick="PrtSvdMkbButton_Click();">
                 <input type="button" name="PrtButton" value="Печать свода (врачам)" id="PrtSvdDoc" onclick="PrtSvdDocButton_Click();">
<%--                 <input type="button" name="PrtButton" value="Печать стт.карт" id="PrtSttCrd" onclick="PrtSttCrdButton_Click();">--%>
<%--                  <input type="button" name="PrtButton" value="Коэфф." id="KofButton" onclick="KofButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>--%>
             </center>
  </asp:Panel> 
    
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   
       
        
        --%>
  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите очистить и записать стат карты? </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="ImpBtnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Удаление" Width="300" IsModal="true">
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

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KofWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status="" 
             Left="400" Top="200" Height="200" Width="380" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Укажите коэффициент">
       </owd:Window>

<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

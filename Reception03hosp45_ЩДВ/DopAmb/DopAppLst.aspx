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
     function HandlePopupResult(result) {
  //       alert("result of popup is: " + result);
         var hashes = result.split('&');
//        alert("hashes=" + hashes[0]);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var AmbCntIdn = hashes[0];

         switch (GlvDocTyp)
         {
             case 'АМБ': location.href = "/DopAmb/DopAppAmb.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'ПРЦ': location.href = "/DopAmb/DopAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНТ': location.href = "/DopAmb/DopAppAnt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФНК': location.href = "/DopAmb/DopAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'РНТ': location.href = "/DopAmb/DopAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФИЗ': location.href = "/DopAmb/DopAppFiz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'УЗИ': location.href = "/DopAmb/DopAppUzi.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'МАС': location.href = "/DopAmb/DopAppMas.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'ЛАБ': location.href = "/DopAmb/DopAppLab.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'СТМ': location.href = "/DopAmb/DopAppDnt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'СМП': location.href = "/DopAmb/DopApp003.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/DopAmb/DopAppAkt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНЛ': location.href = "/DopAmb/DopAppAnl.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'ВЫС': location.href = "/DopAmb/DopApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=СМП"; break;
             case 'ВЫД': location.href = "/DopAmb/DopApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/DopAmb/DopAppDom.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/DopAmb/DopAppLab.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/DopAmb/DopAppStz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=СТЦ"; break;
             case 'ПРФ': location.href = "/DopAmb/DopAppPrf.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case '061': 
             case '062': 
             case '086': 
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1) 
                    window.open("/DopAmb/DopApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else 
                    window.showModalDialog("/DopAmb/DopApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
                break;
         }
     }


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
         for (var i = 0; i < GridCrd.Rows.length; i++) {
             if (GridCrd.Rows[i].Cells[0].Value == record.GRFIDN) 
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
         GridCrd.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function OnClientSelect(sender,selectedRecords) {
   //      alert(document.getElementById('MainContent_parDbl').value);
         
         if (document.getElementById('MainContent_parDbl').value == "DBL")
         {
             document.getElementById('MainContent_parDbl').value = ""; 
             return;
         }

         var AmbCrdIdn = selectedRecords[0].GRFIDN;
//        alert("AmbCrdIdn=" + AmbCrdIdn);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;

 //        var AmbCrdIdn = GridCrd.Rows[iRecordIndex].Cells[0].Value;
         //        var GlvDocPrv = GridCrd.Rows[iRecordIndex].Cells[1].Value;
    //     alert("GlvDocTyp=" + GlvDocTyp);


         switch (GlvDocTyp) {
             case 'АМБ': location.href = "/DopAmb/DopAppAmb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ПРЦ': location.href = "/DopAmb/DopAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНТ': location.href = "/DopAmb/DopAppAnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФНК': location.href = "/DopAmb/DopAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'РНТ': location.href = "/DopAmb/DopAppXry.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФИЗ': location.href = "/DopAmb/DopAppFiz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'УЗИ': location.href = "/DopAmb/DopAppUzi.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'МАС': location.href = "/DopAmb/DopAppMas.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ЛАБ': location.href = "/DopAmb/DopAppLab.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'СТМ': location.href = "/DopAmb/DopAppDnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'СМП': location.href = "/DopAmb/DopApp003.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/DopAmb/DopAppAkt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНЛ': location.href = "/DopAmb/DopAppAnl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ВЫС': location.href = "/DopAmb/DopApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СМП"; break;
             case 'ВЫД': location.href = "/DopAmb/DopApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/DopAmb/DopAppDom.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/DopAmb/DopAppLbr.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/DopAmb/DopAppStz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СТЦ"; break;
             case 'ПРФ': location.href = "/DopAmb/DopAppPrf.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case '061': 
             case '062': 
             case '086': 
                         var ua = navigator.userAgent;
                         if (ua.search(/Chrome/) > -1) 
                             window.open("/DopAmb/DopApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                         else 
                             window.showModalDialog("/DopAmb/DopApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
                         break;
         }

     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtDopButton_Click() {

         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = "ДОП"; //document.getElementById('MainContent_parDocTyp').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;

         var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }



/*  ПРИМЕР
     function onClientSelect(selectedRecords) {
         var index = -1;

         for (var i = 0; i < grid1.Rows.length; i++) {
             if (grid1.Rows[i].Cells[0].Value == selectedRecords[0].OrderID) {
                 index = i;
                 break;
             }
         }

         if (index != -1) {
             grid1.editRecord(index);
         }
     }
*/

     // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'GRFPTH';
           GridCrd.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridCrd.executeFilter();
         }
         else {
             GridCrd.removeFilter();
         }
     }



     /* ПЕЧАТЬ РАСХОДА  -----------------------------------------------------------------------*/

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
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
            Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================

            if (GridCrd.IsCallback)
            {
                Session["pgSize"] = GridCrd.CurrentPageIndex;
            }

            switch (GlvDocTyp)
            {
                case "АМБ":
                    //   GridCrd.Columns[3].HeaderText = "Организация";
                    //    GridCrd.Columns[11].Visible= true;
                    //    GridCrd.Columns[12].Visible = false;
                    break;
                case "ПРЦ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "РНТ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "ФИЗ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "УЗИ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "ЛАБ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "МАС":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "СТМ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                default:
                    // Do nothing.
                    break;
            }


            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridCrd.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //               GridCrd.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

            if (!Page.IsPostBack)
            {
                if (Session["pgSize"] != null)
                {
                    GridCrd.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
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
            string TekDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";
            else TekDocTyp = GlvDocTyp;


            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDopAppLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = TekDocTyp;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDopAppLst");

            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]) + " (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
                }
            }
            catch
            {
            }



            con.Close();

            GridCrd.DataSource = ds;
            GridCrd.DataBind();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";
            else TekDocTyp = GlvDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            // ============================ посуммировать  ==============================================
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDopAppLstSum", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = TekDocTyp;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();
            // ============================ посуммировать  ==============================================

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
            string AmbCrdIdn;
            AmbCrdIdn = Convert.ToString(e.Record["GRFIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDopAppLstDel", con);
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
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[13].Text == null | e.Row.Cells[13].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[13].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[11].Text = "Итого:";
                e.Row.Cells[13].Text = ItgDocSum.ToString();
            }
        }

        // ============================ дублировать амб.карту ==============================================

        // ======================================================================================

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
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>
             <asp:Label ID="Label1" runat="server" Text="Период" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

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
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridCrd" runat="server" 
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
	            PageSize = "100"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
	            <ClientSideEvents ExposeSender="true" 
                          OnClientSelect="OnClientSelect"
	                      OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFFLGREP" HeaderText="Проведен" Visible="false" Width="0%" />
	                <obout:Column ID="Column02" DataField="GRFDOCNAM" HeaderText="НАЗ" Visible="false" Width="0%" />
	                <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column04" DataField="TIMBEG" HeaderText="ВРЕМЯ" Width="4%" />
	                <obout:Column ID="Column05" DataField="GRFIIN" HeaderText="ИИН" Width="10%" />
	                <obout:Column ID="Column06" DataField="GRFPTH" HeaderText="ФИО" Width="30%" />
	                <obout:Column ID="Column07" DataField="GRFBRTGOD" HeaderText="ГОД/Р" Width="5%" />
	                <obout:Column ID="Column08" DataField="ORGSTXNAM" HeaderText="СТРАХОВЩИК" Width="8%" />
	                <obout:Column ID="Column09" DataField="KLTINV" HeaderText="ИНВ" Width="5%" />
	                <obout:Column ID="Column10" DataField="GRFCMPTXT" HeaderText="МЕСТО РАБОТЫ" Width="8%" />
	                <obout:Column ID="Column11" DataField="GRFERR" HeaderText="ОШИБКИ" Width="15%"/>
	                <obout:Column ID="Column12" DataField="GRFSUM" HeaderText="Сумма" Align="right" Width="5%"/>
 	                <obout:Column ID="Column13" DataField="FI" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" Visible="false"/>
	                <obout:Column ID="Column14" DataField="TIMCMP" HeaderText="ПРИНЯЛ" DataFormatString = "{0:hh:mm}" Width="5%" Visible="false" />
  	                <obout:Column ID="Column15" DataField="TIMPRB" HeaderText="ПРИБЫЛ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false"/>
	                <obout:Column ID="Column16" DataField="TIMEVK" HeaderText="ЭВАК." DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column17" DataField="TIMLPU" HeaderText="ЛПУ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column18" DataField="TIMFRE" HeaderText="ОСВОБ." DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column19" DataField="TIMEND" HeaderText="КОНЕЦ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
		            <obout:Column ID="Column20" DataField="" HeaderText="КОРР" Width="5%" AllowEdit="false" AllowDelete="true" runat="server" />
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
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <input type="button" name="PrtButton" value="Печать отчета" id="PrtButton" onclick="PrtDopButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 
    
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   --%>
     
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

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

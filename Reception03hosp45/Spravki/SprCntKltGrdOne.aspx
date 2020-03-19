<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
 
     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
    </style>
    
    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
        }
    </style>
    
<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;

         // =============================== опрос до удаления клиента  ============================================
         function OnBeforeDelete(sender, record) {

             //                    alert("myconfirm=" + myconfirm);  
             if (myconfirm == 1) {
                 return true;
             }
             else {
                 document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                 document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                 myConfirmBeforeDelete.Open();
                 return false;
             }
         }

         function findIndex(record) {
             var index = -1;
 //            alert('1 index: ' + index);
             for (var i = 0; i < GridUsl.Rows.length; i++) {
                 if (GridUsl.Rows[i].Cells[0].Value == record.KLTIDN) {
//                     alert(record.KLTIDN);
                     index = i;
                     break;
                 }
             }
             return index;
         }

         // =============================== удаления клиента после опроса  ============================================
         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridUsl.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

         // ==================================== чистка поле поиска  ============================================
         function clearfilter() {
             //             document.getElementById('ctl00$MainContent$FndFio').value = '';
             //             document.getElementById('ctl00$MainContent$FndKrt').value = '';
             document.getElementById('FndFio').value = '';
             document.getElementById('FndKrt').value = '';
             document.getElementById('FndSem').value = '';

             return false;
         }
         
         // ==================================== при выборе клиента показывает его программу  ============================================
         // ==================================== поиск клиента по фильтрам  ============================================
         function OnClientSelect(arrSelectedRecords) {
             //            alert('OnClientSelect= ');
             var record = GridUsl.SelectedRecords[0];
             var GlvKltIdn = record.KLTIDN;

             InsWindow.setTitle(record.STRKLTNAM);
             InsWindow.setUrl("SprKltGrdPrg.aspx?GlvKltIdn=" + GlvKltIdn);
             InsWindow.Open();
         }


           // ==================================== корректировка данные клиента в отделном окне  ============================================
           function GridUsl_ClientEdit(sender, record) {

               //           alert("GridUыд_ClientEdit");
               var GlvKltIdn = record.KLTIDN;
               InsWindow.setTitle(GlvKltIdn);
               InsWindow.setUrl("SprKltGrdOne.aspx?GlvKltIdn=" + GlvKltIdn);
               InsWindow.Open();

               return false;
           }


           function GridUsl_ClientAdd(sender, record) {

               //           alert("GridUыд_ClientEdit");
               var GlvKltIdn = 0;
               InsWindow.setTitle(GlvKltIdn);
               InsWindow.setUrl("SprKltGrdOne.aspx?GlvKltIdn=" + GlvKltIdn);
               InsWindow.Open();

               return false;
             }
         
          // ==================================== записать данные клиента с отдельного окна  ============================================

 </script>
</head>
    
    
  <script runat="server">

        string BuxSid;
        string BuxFrm;
        string Html;
        string ComKltIdn = "";
        string ComParKey = "";
        string ComParTxt = "";
        string whereClause = "";

        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //============= локолизация для календаря  ===========================================================================================
 /*           
            OboutInc.Calendar2.Calendar orderDateCalendar4 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[4].Cells[1].Controls[0].Controls[1].Controls[0]);
            orderDateCalendar4.CultureName = "ru-RU";
            orderDateCalendar4.ShowYearSelector = true;
            orderDateCalendar4.YearSelectorType = 0;
            orderDateCalendar4.TitleText = "Выберите год: ";
            
            OboutInc.Calendar2.Calendar orderDateCalendar7 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[7].Cells[1].Controls[0].Controls[1].Controls[0]);
            orderDateCalendar7.CultureName = "ru-RU";
            orderDateCalendar7.ShowYearSelector = true;
            orderDateCalendar7.YearSelectorType = 0;
            orderDateCalendar7.TitleText = "Выберите год: ";

            OboutInc.Calendar2.Calendar orderDateCalendar8 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[8].Cells[1].Controls[0].Controls[1].Controls[0]);
            orderDateCalendar8.CultureName = "ru-RU";
            orderDateCalendar8.ShowYearSelector = true;
            orderDateCalendar8.YearSelectorType = 0;
            orderDateCalendar8.TitleText = "Выберите год: ";

            OboutInc.Calendar2.Calendar orderDateCalendar16 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[16].Cells[1].Controls[0].Controls[1].Controls[0]);
            orderDateCalendar16.CultureName = "ru-RU";
            orderDateCalendar16.ShowYearSelector = true;
            orderDateCalendar16.YearSelectorType = 0;
            orderDateCalendar16.TitleText = "Выберите год: ";
  */
            //=====================================================================================

            
            sdsReg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsReg.SelectCommand = "SELECT REGNAM AS KOD,REGNAM AS NAM FROM SPRREG ORDER BY REGNAM";

            sdsStf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsStf.SelectCommand = "SELECT STFKOD,STFNAM FROM SPRSTF";
            
            sdsPrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsPrt.SelectCommand = "SELECT PRTKOD,PRTNAM FROM SPRPRT";
            
            sdsVip.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsVip.SelectCommand = "SELECT VIPKOD,VIPNAM FROM SPRVIP";
          
            sdsPrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
//            sdsPrg.SelectCommand = "InsPlnFktOneKlt";

            //           GridUsl.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            //=====================================================================================
            if (!Page.IsPostBack)
            {
                Session.Add("KLTIDN", (string)"");
                Session.Add("WHERE", (string)"");
            }
            
            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            
            LoadGridNode();

            ComKltIdn = Convert.ToString(Session["KLTIDN"]);
  //          if (ComKltIdn != "")   LoadGridPrg();                
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        // ======================================================================================
        //------------------------------------------------------------------------
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;
            //          int KltKod;
            string KltStx = "";
            string KltCnt = "";
            string KltFio = "";
            string KltKrt = "";
            string KltSemKrt = "";
            string KltBrt = "";
            string KltKrtBeg = "";
            string KltKrtEnd = "";
            string KltIin = "";
            string KltAdr = "";
            string KltThn = "";
            string KltReg = "";
            bool KltStf = false;
            bool KltVip = false;
            bool KltPrt = false;
            bool KltUblFlg = false;
            string KltUblDat = "";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            KltIdn = Convert.ToInt32(e.Record["KLTIDN"]);
            //=====================================================================================
            // KLTIDN,KLTSTX,KLTCNT,KLTFIO,KLTKRT,KLTSEMKRT,KLTKRTBEG,KLTKRTEND,KLTBRT,KLTIIN,KLTADR,KLTTHN,KLTREG,KLTSTF,KLTVIP,KLTUBLFLG
            if (Convert.ToString(e.Record["KLTFIO"]) == null || Convert.ToString(e.Record["KLTFIO"]) == "")
                KltFio = "";
            else
                KltFio = Convert.ToString(e.Record["KLTFIO"]);

            if (Convert.ToString(e.Record["KLTKRT"]) == null || Convert.ToString(e.Record["KLTKRT"]) == "")
                KltKrt = "";
            else
                KltKrt = Convert.ToString(e.Record["KLTKRT"]);

            if (Convert.ToString(e.Record["KLTSEMKRT"]) == null || Convert.ToString(e.Record["KLTSEMKRT"]) == "")
                KltSemKrt = "";
            else
                KltSemKrt = Convert.ToString(e.Record["KLTSEMKRT"]);

            if (Convert.ToString(e.Record["KLTBRT"]) == null || Convert.ToString(e.Record["KLTBRT"]) == "")
                KltBrt = "";
            else
                KltBrt = Convert.ToString(e.Record["KLTBRT"]);

            if (Convert.ToString(e.Record["KLTKRTBEG"]) == null || Convert.ToString(e.Record["KLTKRTBEG"]) == "")
                KltKrtBeg = "";
            else
                KltKrtBeg = Convert.ToString(e.Record["KLTKRTBEG"]);

            if (Convert.ToString(e.Record["KLTKRTEND"]) == null || Convert.ToString(e.Record["KLTKRTEND"]) == "")
                KltKrtEnd = "";
            else
                KltKrtEnd = Convert.ToString(e.Record["KLTKRTEND"]);

            if (Convert.ToString(e.Record["KLTIIN"]) == null || Convert.ToString(e.Record["KLTIIN"]) == "")
                KltIin = "";
            else
                KltIin = Convert.ToString(e.Record["KLTIIN"]);

            if (Convert.ToString(e.Record["KLTADR"]) == null || Convert.ToString(e.Record["KLTADR"]) == "")
                KltAdr = "";
            else
                KltAdr = Convert.ToString(e.Record["KLTADR"]);

            if (Convert.ToString(e.Record["KLTTHN"]) == null || Convert.ToString(e.Record["KLTTHN"]) == "")
                KltThn = "";
            else
                KltThn = Convert.ToString(e.Record["KLTTHN"]);


            if (Convert.ToString(e.Record["KLTREG"]) == null || Convert.ToString(e.Record["KLTREG"]) == "")
                KltReg = "";
            else
                KltReg = Convert.ToString(e.Record["KLTREG"]);


            if (Convert.ToString(e.Record["STF"]) == null || Convert.ToString(e.Record["STF"]) == "") KltStf = false;
            else KltStf = true;

            if (Convert.ToString(e.Record["VIP"]) == null || Convert.ToString(e.Record["VIP"]) == "") KltVip = false;
            else KltVip = true;

            if (Convert.ToString(e.Record["PRT"]) == null || Convert.ToString(e.Record["PRT"]) == "") KltPrt = false;
            else KltPrt = true;

  //          KltStf = Convert.ToBoolean(e.Record["STF"]);
  //          KltVip = Convert.ToBoolean(e.Record["VIP"]);
  //          KltPrt = Convert.ToBoolean(e.Record["FLGPRT"]);
            KltUblFlg = Convert.ToBoolean(e.Record["KLTUBLFLG"]);

            if (Convert.ToString(e.Record["KLTUBLDAT"]) == null || Convert.ToString(e.Record["KLTUBLDAT"]) == "")
                KltUblDat = "";
            else
                KltUblDat = Convert.ToString(e.Record["KLTUBLDAT"]);

            if (KltFio != "")
            {
//                Service1 ws = new Service1();
//                ws.InsSprKltRep(MdbNam, BuxSid, BuxFrm, KltIdn, KltStx, KltCnt, KltFio, KltKrt, KltSemKrt, KltBrt, KltKrtBeg, KltKrtEnd, KltIin, KltAdr, KltThn, KltReg, KltStf, KltPrt, KltVip, KltUblFlg, KltUblDat);
                InsSprKltRep(MdbNam, BuxFrm, KltIdn, KltStx, KltCnt, KltFio, KltKrt, KltSemKrt, KltBrt, KltKrtBeg, KltKrtEnd, KltIin, KltAdr, KltThn, KltReg, KltStf, KltPrt, KltVip, KltUblFlg, KltUblDat);
                LoadGridNode();
            }
        }
        //------------------------------------------------------------------------
        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            //         int KltIdn;
            //          int KltKod;
            string KltStx = "";
            string KltCnt = "";
            string KltFio = "";
            string KltKrt = "";
            string KltSemKrt = "";
            string KltBrt = "";
            string KltKrtBeg = "";
            string KltKrtEnd = "";
            string KltIin = "";
            string KltAdr = "";
            string KltThn = "";
            string KltReg = "";
            bool KltStf = false;
            bool KltVip = false;
            bool KltPrt = false;
            bool KltUblFlg = false;
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
             // KLTIDN,KLTSTX,KLTCNT,KLTFIO,KLTKRT,KLTSEMKRT,KLTKRTBEG,KLTKRTEND,KLTBRT,KLTIIN,KLTADR,KLTTHN,KLTREG,KLTSTF,KLTVIP,KLTUBLFLG
            if (Convert.ToString(e.Record["KLTFIO"]) == null || Convert.ToString(e.Record["KLTFIO"]) == "")
               KltFio = "";
            else
               KltFio = Convert.ToString(e.Record["KLTFIO"]);

            if (Convert.ToString(e.Record["KLTKRT"]) == null || Convert.ToString(e.Record["KLTKRT"]) == "")
                KltKrt = "";
            else
                KltKrt = Convert.ToString(e.Record["KLTKRT"]);

            if (Convert.ToString(e.Record["KLTSEMKRT"]) == null || Convert.ToString(e.Record["KLTSEMKRT"]) == "")
                KltSemKrt = "";
            else
                KltSemKrt = Convert.ToString(e.Record["KLTSEMKRT"]);

            if (Convert.ToString(e.Record["KLTBRT"]) == null || Convert.ToString(e.Record["KLTBRT"]) == "")
                KltBrt = "";
            else
                KltBrt = Convert.ToString(e.Record["KLTBRT"]);

            if (Convert.ToString(e.Record["KLTKRTBEG"]) == null || Convert.ToString(e.Record["KLTKRTBEG"]) == "")
                KltKrtBeg = "";
            else
                KltKrtBeg = Convert.ToString(e.Record["KLTKRTBEG"]);

            if (Convert.ToString(e.Record["KLTKRTEND"]) == null || Convert.ToString(e.Record["KLTKRTEND"]) == "")
                KltKrtEnd = "";
            else
                KltKrtEnd = Convert.ToString(e.Record["KLTKRTEND"]);

            if (Convert.ToString(e.Record["KLTIIN"]) == null || Convert.ToString(e.Record["KLTIIN"]) == "")
                KltIin = "";
            else
                KltIin = Convert.ToString(e.Record["KLTIIN"]);

            if (Convert.ToString(e.Record["KLTADR"]) == null || Convert.ToString(e.Record["KLTADR"]) == "")
                KltAdr = "";
            else
                KltAdr = Convert.ToString(e.Record["KLTADR"]);

            if (Convert.ToString(e.Record["KLTTHN"]) == null || Convert.ToString(e.Record["KLTTHN"]) == "")
                KltThn = "";
            else
                KltThn = Convert.ToString(e.Record["KLTTHN"]);


            if (Convert.ToString(e.Record["KLTREG"]) == null || Convert.ToString(e.Record["KLTREG"]) == "")
                KltReg = "";
            else
                KltReg = Convert.ToString(e.Record["KLTREG"]);

            if (Convert.ToString(e.Record["STF"]) == null || Convert.ToString(e.Record["STF"]) == "") KltStf = false;
            else KltStf = true;

            if (Convert.ToString(e.Record["VIP"]) == null || Convert.ToString(e.Record["VIP"]) == "") KltVip = false;
            else KltVip = true;

            if (Convert.ToString(e.Record["PRT"]) == null || Convert.ToString(e.Record["PRT"]) == "") KltPrt = false;
            else KltPrt = true;

//            KltStf = Convert.ToBoolean(e.Record["STF"]);
//            KltPrt = Convert.ToBoolean(e.Record["PRT"]);
//            KltVip = Convert.ToBoolean(e.Record["VIP"]);
            KltUblFlg = Convert.ToBoolean(e.Record["KLTUBLFLG"]);

            if (KltFio != "")
            {
//                Service1 ws = new Service1();
//                ws.InsSprKltAdd(MdbNam, BuxSid, BuxFrm, ComParKey, KltStx, KltCnt, KltFio, KltKrt, KltSemKrt, KltBrt, KltKrtBeg, KltKrtEnd, KltIin, KltAdr, KltThn, KltReg, KltStf, KltPrt, KltVip, KltUblFlg);
                InsSprKltAdd(MdbNam, BuxFrm, ComParKey, KltStx, KltCnt, KltFio, KltKrt, KltSemKrt, KltBrt, KltKrtBeg, KltKrtEnd, KltIin, KltAdr, KltThn, KltReg, KltStf, KltPrt, KltVip, KltUblFlg);
                LoadGridNode();
            }

        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;

            KltIdn = Convert.ToInt32(e.Record["KLTIDN"]);

//            Service1 ws = new Service1();
//            ws.InsSprKltDel(MdbNam, BuxSid, KltIdn);
            InsSprKltDel(MdbNam, KltIdn);
            LoadGridNode();

        }
        //=============При выборе узла дерево===========================================================================================


        protected void LoadGridNode()
        {

//            Service1 ws = new Service1();
            DataSet ds = new DataSet("Menu");

            whereClause = Convert.ToString(Session["WHERE"]);

            if (whereClause == null || whereClause == "") 
               switch (ComParKey.Length)
               {
                  case 0:
                      break;
                  case 5:
                      Session["WHERE"]="";
//                      ds.Merge(ws.InsSprKltSel(MdbNam, BuxSid, BuxFrm, 5, ComParKey));
                      ds.Merge(InsSprKltSel(MdbNam, BuxFrm, 5, ComParKey));
                      GridUsl.DataSource = ds;
                      GridUsl.DataBind();
            //        TxtUsl.Text = e.Node.Parent.Text + " > " + e.Node.Text;
                      break;
                  case 11:
                      Session["WHERE"] = "";
//                      ds.Merge(ws.InsSprKltSel(MdbNam, BuxSid, BuxFrm, 11, ComParKey));
                      ds.Merge(InsSprKltSel(MdbNam, BuxFrm, 11, ComParKey));
                      GridUsl.DataSource = ds;
                      GridUsl.DataBind();
                      //        TxtUsl.Text = e.Node.Parent.Text + " > " + e.Node.Text;
                      break;
                  case 17:
                      Session["WHERE"] = "";
//                      ds.Merge(ws.InsSprKltSel(MdbNam, BuxSid, BuxFrm, 17, ComParKey));
                      ds.Merge(InsSprKltSel(MdbNam, BuxFrm, 17, ComParKey));
                      GridUsl.DataSource = ds;
                      GridUsl.DataBind();
            //        TxtUsl.Text = e.Node.Parent.Text + " > " + e.Node.Text;
                      break;
                  case 23:
                      Session["WHERE"] = "";
//                      ds.Merge(ws.InsSprKltSel(MdbNam, BuxSid, BuxFrm, 23, ComParKey));
                      ds.Merge(InsSprKltSel(MdbNam, BuxFrm, 23, ComParKey));
                      GridUsl.DataSource = ds;
                      GridUsl.DataBind();
                      //        TxtUsl.Text = e.Node.Parent.Text + " > " + e.Node.Text;
                      break;
                  default:
                      break;
                }
             else
                {
//                 ds.Merge(ws.InsSprKltSel(MdbNam, BuxSid, BuxFrm, 0, whereClause));
                 ds.Merge(InsSprKltSel(MdbNam, BuxFrm, 0, whereClause));
                 GridUsl.DataSource = ds;
                 GridUsl.DataBind();
                }
        }

        //------------------------------------------------------------------------
 /*     
        protected void LoadGridPrg()
        {

            DataSet ds = new DataSet("Menu");
            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("InsPlnFktOneKlt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KLTIDN", SqlDbType.VarChar).Value = ComKltIdn;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "InsPlnFktOneKlt");
            con.Close();

            gridPrg.DataSource = ds;
            gridPrg.DataBind();


            Session.Add("KLTIDN", (string)"");   


        }
  */
        //------------------------------------------------------------------------

        //-------------------------- увеличение высоту полей описание и акции ----------------------------------------------
  //      protected void SuperForm1_DataBound(object sender, EventArgs e)
  //      {
  //          if (SuperForm1.CurrentMode == DetailsViewMode.Edit || SuperForm1.CurrentMode == DetailsViewMode.Insert)
  //          {
     //           OboutTextBox BoxOps = SuperForm1.GetFieldControl(4) as OboutTextBox;
     //           BoxOps.Height = Unit.Pixel(100);
     //           OboutTextBox BoxAkz = SuperForm1.GetFieldControl(5) as OboutTextBox;
     //           BoxAkz.Height = Unit.Pixel(100);
  //          }
  //      }

        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndFio.Text != "")
            {
                I = I + 1;
                whereClause += "KLTFIO LIKE '" + FndFio.Text.Replace("'", "''") + "%'";
            }
            if (FndKrt.Text != "")
            {
                I = I + 1;
                if (I > 1) whereClause += " AND ";
                whereClause += "KLTKRT LIKE '" + FndKrt.Text.Replace("'", "''") + "%'";
            }
            if (FndSem.Text != "")
            {
                I = I + 1;
                if (I > 1) whereClause += " AND ";
                whereClause += "KLTSEMKRT LIKE '" + FndSem.Text.Replace("'", "''") + "%'";
            }
            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
                /*
                                Service1 ws = new Service1();
                                DataSet ds = new DataSet("Menu");
                                ds.Merge(ws.InsSprKltSelFil(MdbNam, BuxSid, BuxFrm, whereClause));
                                GridUsl.DataSource = ds;
                                GridUsl.DataBind();
                */
                sdsPrg.SelectCommand = "InsPlnFktOneKlt";

                LoadGridNode();

            }
        }


        // ==================================================================================================  
        public DataSet InsSprKltSel(string BUXMDB, string BUXFRM, int LENKEY, string TREKEY)
        {
            bool flag;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprKltSel", con);
            cmd = new SqlCommand("InsSprKltSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@LENKEY", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@TREKEY", SqlDbType.VarChar));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@LENKEY"].Value = LENKEY;
            cmd.Parameters["@TREKEY"].Value = TREKEY;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "InsSprKltSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            try
            {
                flag = true;
            }
            // если запись не найден
            catch
            {
                flag = false;
            }
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
            return ds;
        }
        
        // ==================================================================================================  
        public bool InsSprKltAdd(string BUXMDB, string BUXFRM, string KLTKEY, string KLTSTX, string KLTCNT, string KLTFIO, string KLTKRT, string KLTSEMKRT, string KLTBRT, string KLTKRTBEG, string KLTKRTEND, string KLTIIN, string KLTADR, string KLTTHN, string KLTREG, bool KLTSTF, bool KLTPRT, bool KLTVIP, bool KLTUBLFLG)
        {
            //                ws.InsSprKltAdd(MdbNam, BuxSid,                                        BuxFrm, ParKey,KltStx,KltCnt,KltFio                          ,KltKrt,KltSemKrt,KltBrt,KltBeg,KltEnd,                    KltIin,          KltAdr,                      KltThn,KltReg,KltStf,KltVip,KltUblFlg);
            //   KLTIDN,KLTSTX,KLTCNT,KLTFIO,KLTKRT,KLTSEMKRT,KLTKRTBEG,KLTKRTEND,KLTBRT,KLTIIN,KLTADR,KLTTHN,
            //   KLTREG,KLTSTF,KLTVIP,KLTUBLFLG


            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprKltAdd", con);
            cmd = new SqlCommand("InsSprKltAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKEY", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTFIO", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTSEMKRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRTBEG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRTEND", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTBRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTIIN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTADR", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTTHN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTREG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTSTF", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTPRT", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTVIP", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTUBLFLG", SqlDbType.Bit, 1));
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@KLTKEY"].Value = KLTKEY;
            cmd.Parameters["@KLTFIO"].Value = KLTFIO;
            cmd.Parameters["@KLTKRT"].Value = KLTKRT;
            cmd.Parameters["@KLTSEMKRT"].Value = KLTSEMKRT;
            cmd.Parameters["@KLTKRTBEG"].Value = KLTKRTBEG;
            cmd.Parameters["@KLTKRTEND"].Value = KLTKRTEND;
            cmd.Parameters["@KLTBRT"].Value = KLTBRT;
            cmd.Parameters["@KLTIIN"].Value = KLTIIN;
            cmd.Parameters["@KLTADR"].Value = KLTADR;
            cmd.Parameters["@KLTTHN"].Value = KLTTHN;
            cmd.Parameters["@KLTREG"].Value = KLTREG;
            cmd.Parameters["@KLTSTF"].Value = KLTSTF;
            cmd.Parameters["@KLTPRT"].Value = KLTPRT;
            cmd.Parameters["@KLTVIP"].Value = KLTVIP;
            cmd.Parameters["@KLTUBLFLG"].Value = KLTUBLFLG;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }

        // ==================================================================================================  
        public bool InsSprKltRep(string BUXMDB, string BUXFRM, int KLTIDN, string KLTSTX, string KLTCNT, string KLTFIO, string KLTKRT, string KLTSEMKRT, string KLTBRT, string KLTKRTBEG, string KLTKRTEND, string KLTIIN, string KLTADR, string KLTTHN, string KLTREG, bool KLTSTF, bool KLTPRT, bool KLTVIP, bool KLTUBLFLG, string KLTUBLDAT)
        {
            //                ws.InsSprKltAdd(MdbNam, BuxSid,                                        BuxFrm, ParKey,KltStx,KltCnt,KltFio                          ,KltKrt,KltSemKrt,KltBrt,KltBeg,KltEnd,                    KltIin,          KltAdr,                      KltThn,KltReg,KltStf,KltVip,KltUblFlg);
            //   KLTIDN,KLTSTX,KLTCNT,KLTFIO,KLTKRT,KLTSEMKRT,KLTKRTBEG,KLTKRTEND,KLTBRT,KLTIIN,KLTADR,KLTTHN,
            //   KLTREG,KLTSTF,KLTVIP,KLTUBLFLG


            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды8
            SqlCommand cmd = new SqlCommand("InsSprKltRep", con);
            cmd = new SqlCommand("InsSprKltRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTIDN", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@KLTFIO", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTSEMKRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRTBEG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKRTEND", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTBRT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTIIN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTADR", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTTHN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTREG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTSTF", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTPRT", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTVIP", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTUBLFLG", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTUBLDAT", SqlDbType.VarChar));
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@KLTIDN"].Value = KLTIDN;
            cmd.Parameters["@KLTFIO"].Value = KLTFIO;
            cmd.Parameters["@KLTKRT"].Value = KLTKRT;
            cmd.Parameters["@KLTSEMKRT"].Value = KLTSEMKRT;
            cmd.Parameters["@KLTKRTBEG"].Value = KLTKRTBEG;
            cmd.Parameters["@KLTKRTEND"].Value = KLTKRTEND;
            cmd.Parameters["@KLTBRT"].Value = KLTBRT;
            cmd.Parameters["@KLTIIN"].Value = KLTIIN;
            cmd.Parameters["@KLTADR"].Value = KLTADR;
            cmd.Parameters["@KLTTHN"].Value = KLTTHN;
            cmd.Parameters["@KLTREG"].Value = KLTREG;
            cmd.Parameters["@KLTSTF"].Value = KLTSTF;
            cmd.Parameters["@KLTPRT"].Value = KLTPRT;
            cmd.Parameters["@KLTVIP"].Value = KLTVIP;
            cmd.Parameters["@KLTUBLFLG"].Value = KLTUBLFLG;
            cmd.Parameters["@KLTUBLDAT"].Value = KLTUBLDAT;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }

        // ==================================================================================================  
        // удаление подразделении  (справочника SPRSTRFRM)
        public bool InsSprKltDel(string BUXMDB, int KLTIDN)
        {

            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprKltDel", con);
            cmd = new SqlCommand("InsSprKltDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@KLTIDN", SqlDbType.Int, 4));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@KLTIDN"].Value = KLTIDN;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }
  </script>   
    
    
<body>
    <form id="form1" runat="server">
    <div>
<%-- ============================  для передач значении  ============================================ --%>
  <input type="hidden" name="hhh" id="par" />
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
   <span id="WindowPositionHelper"></span>
   
 <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="CUSTOM" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
       
<!--  конец -----------------------------------------------  -->  
<%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <owd:Window ID="InsWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="0" Height="600" Width="1000" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
        </owd:Window>

<!--  источники -----------------------------------------------------------  -->    
	    <asp:SqlDataSource runat="server" ID="sdsReg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsStf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsPrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsVip" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
	    <asp:SqlDataSource runat="server" ID="sdsUbl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"> </asp:SqlDataSource>	
 		<asp:SqlDataSource runat="server" ID="sdsPrg" SelectCommand="InsPlnFktOneKlt" ConnectionString="" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure">
		    <SelectParameters>
                <asp:Parameter Name="KLTIDN" Type="String" />
            </SelectParameters>
		</asp:SqlDataSource>
<!--  источники -----------------------------------------------------------  -->    

    <div>
    <div style="position:relative; left:0px; top:0px; font-family:Verdana; font-size:10pt; 
         border-style:groove; border-width:1px; border-color: Black; padding:1px">
         
           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="8%">
                                <asp:Button ID="ButClr" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Очистить" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="12%" class="PO_RowCap" align="left">Ф.И.О.:</td>
                            <td width="20%">
                                <asp:TextBox ID="FndFio" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="10%" class="PO_RowCap" align="right">№ карты:</td>
                            <td width="15%">
                                <asp:TextBox ID="FndKrt" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="12%" class="PO_RowCap" align="right">№ сем.крт:</td>
                            <td width="15%">
                                <asp:TextBox ID="FndSem" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="8%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            
                            <td>&nbsp;</td>
                        </tr>
        </table>
  </div>          
                        <obout:Grid id="GridUsl" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="false" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               AllowRecordSelection="true"
	                               KeepSelectedRecords="true" 
	                               AllowMultiRecordSelection="true"
	                               Language = "ru"
	                		       PageSize = "20"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="true"
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                   <ClientSideEvents 
                                         OnClientSelect="OnClientSelect" 
                                         OnBeforeClientDelete="OnBeforeDelete" 
                                         OnBeforeClientEdit="GridUsl_ClientEdit"
                                         OnBeforeClientAdd="GridUsl_ClientAdd" 
                                         ExposeSender="true" />
      		                 <Columns>
	                    			<obout:Column ID="Column00" DataField="KLTIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="KLTSTX" HeaderText="ВИД ОПЛ" ReadOnly = "true" Width="6%" />											
	                    			<obout:Column ID="Column02" DataField="KLTCMP" HeaderText="Фирма" ReadOnly = "true" Width="8%" />											
	                    			<obout:Column ID="Column03" DataField="KLTCNT" HeaderText="Договор" ReadOnly = "true" Width="8%" />											
	                    			<obout:Column ID="Column04" DataField="KLTFIO" HeaderText="ФИО" Width="15%" />											
                    				<obout:Column ID="Column05" DataField="KLTKRT" HeaderText="Карта" Width="7%" />
                    				<obout:Column ID="Column06" DataField="KLTSEMKRT" HeaderText="Сем.карта" Width="7%" />
	         	        			<obout:Column ID="Column07" DataField="KLTKRTBEG" HeaderText="Начало"  DataFormatString = "{0:dd.MM.yyyy}" Width="6%" />
                    				<obout:Column ID="Column08" DataField="KLTKRTEND" HeaderText="Конец"  DataFormatString = "{0:dd.MM.yyyy}" Width="6%" />
                    				<obout:Column ID="Column09" DataField="KLTBRT" HeaderText="Д.рожд"  DataFormatString = "{0:yyyy}" Width="5%" />
                    				<obout:Column ID="Column10" DataField="KLTIIN" HeaderText="ИИН"  Width="0%" />
                    				<obout:Column ID="Column11" DataField="KLTADR" HeaderText="Адрес"  Width="0%" />
                    				<obout:Column ID="Column12" DataField="KLTTHN" HeaderText="Телефон"  Width="0%" />
	            			        <obout:Column ID="Column13" DataField="KLTREG" HeaderText="Регион" Width="6%" />
		              				<obout:Column ID="Column14" DataField="STF" HeaderText="Сотрудник" Width="4%" />
	            			        <obout:Column ID="Column15" DataField="VIP" HeaderText="VIP" Width="4%" />
	            			        <obout:Column ID="Column16" DataField="PRT" HeaderText="Печ" Width="4%" />
                             		<obout:Column ID="Column17" DataField="KLTUBLFLG" HeaderText="Уволен" Width="0%" />
                    				<obout:Column ID="Column18" DataField="KLTUBLDAT" HeaderText="Дата увол"  DataFormatString = "{0:dd.MM.yyyy}" Width="6%" />
                                    <obout:Column ID="Column19" HeaderText="Кор Удл" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
				                            <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				                    </obout:Column>	           

      		                 </Columns>
	
		                        <Templates>
				                    <obout:GridTemplate runat="server" ID="TemplateStf" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "c" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    		                            		                            
				                    <obout:GridTemplate runat="server" ID="TemplateVip" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    		                            		                            
				                    <obout:GridTemplate runat="server" ID="TemplatePrt" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "+" : " ") %>
    					                </Template>
				                    </obout:GridTemplate>
                            
                                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                                        <Template>
                                            <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridUsl.edit_record(this)"/>
                                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)"/>
                                        </Template>
                                    </obout:GridTemplate>

                                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                                        <Template>
                                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)"/> 
                                            <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)"/> 
                                        </Template>
                                    </obout:GridTemplate>

	                    		</Templates>
	
	                    	</obout:Grid>	
       
                </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
	        </div>
	        
	         <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    

    </form>
</body>
</html>



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

<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.Common" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
 
    

     <script type="text/javascript">

         var myconfirm = 0;

         function OnBeforeDelete(sender, record) {

             //              alert("myconfirm=" + myconfirm);  
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
             for (var i = 0; i < GridTbl.Rows.length; i++) {
                 if (GridTbl.Rows[i].Cells[0].Value == record.BuxIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridTbl.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }
      
       /* --------------------------------------------------------------------------------------------------------*/
 
         /* --------------------------------------------------------------------------------------------------------*/
         function OnBeforeInsertWrt(record) {
             SetWrtID();
             return true;
         }
         /* --------------------------------------------------------------------------------------------------------*/
         /*
                 function OnEditWrt(record) {
                     var WrtID = grid2.Rows[grid2.RecordInEditMode].Cells["Prm"].Value;
                     if (WrtID == "0") {
                         document.getElementById("rFemale").checked = true;
                     }
                     else {
                         document.getElementById("rMale").checked = true;
                     }
                     return true;
                 }
         */        
         /* --------------------------------------------------------------------------------------------------------*/

         function OnBeforeUpdateWrt(record) {
             SetWrtID();
             return true;
         }
         /* --------------------------------------------------------------------------------------------------------*/

         function SetWrtID() {
             if (document.getElementById("rFemale").checked) {
                 document.getElementById("hidWrt").value = "0";
             }
             else if (document.getElementById("rMale").checked) {
                 document.getElementById("hidWrt").value = "1";
             }
         }
         /* ---------------------------скрыть кнопки первый и последний----------------------------------------*/
        
         window.onload = function() {
             window.setTimeout(hidePagingButtons, 250);
         }

         function hidePagingButtons() {
             var pagingContainer = GridTbl.getPagingButtonsContainer('');

             var elements = pagingContainer.getElementsByTagName('DIV');
             var pagingButtons = new Array();

             for (var i = 0; i < elements.length; i++) {
                 if (elements[i].className.indexOf('ob_gPBC') != -1) {
                     pagingButtons.push(elements[i]);
                 }
             }

             pagingButtons[0].style.display = 'none';
             pagingButtons[3].style.display = 'none';

         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnClientDblClick(sender, iRecordIndex) {
  //       function OnClientSelect(sender, iRecordIndex) {
    //                alert('onDoubleClick=' + iRecordIndex);
             var TblIdn = GridTbl.Rows[iRecordIndex].Cells[0].Value;
             var TblFio = GridTbl.Rows[iRecordIndex].Cells[3].Value;
             var TblDlg = GridTbl.Rows[iRecordIndex].Cells[4].Value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Spravki/SprTblGrdOne.aspx?TblIdn=" + TblIdn+"&TblFio=" + TblFio+"&TblDlg=" + TblDlg, "ModalPopUp2", "width=500,height=620,left=450,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
             else
                 window.showModalDialog("/Spravki/SprTblGrdOne.aspx?TblIdn=" + TblIdn + "&TblFio=" + TblFio + "&TblDlg=" + TblDlg, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:450px;dialogtop:100px;dialogWidth:500px;dialogHeight:620px;");

     //        TblWindow.setTitle(TblIdn);
     //        TblWindow.setUrl("SprTblGrdOne.aspx?TblIdn=" + TblIdn);
     //        TblWindow.Open();
         }

         //  -----------------------------------------------------------------

         function PrtTblButton_Click() {
                 var GlvTblFrm = document.getElementById('parBuxFrm').value;
                 var GlvTblLen = document.getElementById('parLenKey').value;
                 var GlvTblKey = document.getElementById('parTxtKey').value;
                 var GlvTblDat = document.getElementById('parTekDat').value;

         //        alert("GlvTblFrm=" + GlvTblFrm);
          //       alert("GlvTblLen=" + GlvTblLen);
          //       alert("GlvTblKey=" + GlvTblKey);
             //       alert("GlvTblDat=" + GlvTblDat);

                 if (GlvTblLen == 0) GlvTblKey = "00000";

                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Report/DauaReports.aspx?ReportName=HspTblGrf&TekDocFrm=" + GlvTblFrm + "&TekDocKod=" + GlvTblLen + "&TekDocTxt=" + GlvTblKey + "&TekDocBeg=" + GlvTblDat,
                         "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspTblGrf&TekDocFrm=" + GlvTblFrm + "&TekDocKod=" + GlvTblLen + "&TekDocTxt=" + GlvTblKey + "&TekDocBeg=" + GlvTblDat,
                         "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }


         function PrtGrfButton_Click() {
             var GlvTblFrm = document.getElementById('parBuxFrm').value;
             var GlvTblLen = document.getElementById('parLenKey').value;
             var GlvTblKey = document.getElementById('parTxtKey').value;
             var GlvTblDat = document.getElementById('parTekDat').value;

     //               alert("GlvTblFrm=" + GlvTblFrm);
     //               alert("GlvTblLen=" + GlvTblLen);
     //               alert("GlvTblKey=" + GlvTblKey);
     //               alert("GlvTblDat=" + GlvTblDat);

             if (GlvTblLen == 0) GlvTblKey = "00000";

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspGrfRab&TekDocFrm=" + GlvTblFrm + "&TekDocKod=" + GlvTblLen + "&TekDocTxt=" + GlvTblKey + "&TekDocBeg=" + GlvTblDat,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspGrfRab&TekDocFrm=" + GlvTblFrm + "&TekDocKod=" + GlvTblLen + "&TekDocTxt=" + GlvTblKey + "&TekDocBeg=" + GlvTblDat,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }


        function OnClientSelect(sender,selectedRecords) {
            //      alert(document.getElementById('MainContent_parDbl').value);
            //       function OnClientSelect(sender, iRecordIndex) {
            //                alert('onDoubleClick=' + iRecordIndex);
            var TblIdn = selectedRecords[0].TABIDN;
            var TblFio = selectedRecords[0].FI;
            var TblDlg = selectedRecords[0].DLGNAM;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Spravki/SprTblGrdOne.aspx?TblIdn=" + TblIdn + "&TblFio=" + TblFio + "&TblDlg=" + TblDlg, "ModalPopUp2", "width=500,height=620,left=450,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
            else
                window.showModalDialog("/Spravki/SprTblGrdOne.aspx?TblIdn=" + TblIdn + "&TblFio=" + TblFio + "&TblDlg=" + TblDlg, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:450px;dialogtop:100px;dialogWidth:500px;dialogHeight:620px;");
     }

 </script>
</head>
    
    
  <script runat="server">

      //       int ComBuxKod = 0;
      string ComPriOpr = "";
      int BuxIdn;
      int BuxKod;
      int BuxTab;
      int BuxDlg;
      decimal BuxStf;
      bool BuxStz;
      bool BuxUbl;
      string BuxLog;
      string BuxPsw;

      DateTime GlvBegDat;
      DateTime GlvEndDat;

      string BuxFrm;
      string BuxSid;
      string MdbNam = "HOSPBASE";

      string ComKltIdn = "";
      string ComParKey = "";
      string ComParTxt = "";

      protected void Page_Load(object sender, EventArgs e)
      {
          //=====================================================================================
          BuxFrm = (string)Session["BuxFrmKod"];
          BuxSid = (string)Session["BuxSid"];

          ComParKey = (string)Request.QueryString["NodKey"];
          //           ComParKeyHid.Value = (string)Request.QueryString["NodKey"];
          ComParTxt = (string)Request.QueryString["NodTxt"];

          //           sdsGrf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          //           sdsGrf.SelectCommand = "SELECT VARRABBEG+'-'+VARRABEND AS GRF FROM SPRRABGRF WHERE VARRABFRM='" + BuxFrm + "' ORDER BY VARRABBEG";

          //           GridTbl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
          //           GridTbl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
          //           GridTbl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
          // =====================================================================================
          //===================================================================================================
          //-------------------------------------------------------
          if (!Page.IsPostBack)
          {
              //               ParRadUbl.Value = "0";
              getGrid();

              Session.Add("ComBuxKod", 0);
              Session.Add("ComPriOpr", "");

              GlvBegDat = (DateTime)Session["GlvBegDat"];
              txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
          }
          else
          {
              //   ComPriOpr = (string)Session["ComPriOpr"];
              //   if (ComPriOpr == "add") getGrid();
              getGrid();

          }

      }

      //===========================================================================================================
      // Create the methods that will load the data into the templates

      //------------------------------------------------------------------------

      // ============================ первая таблица ==============================================
      void RebindGrid(object sender, EventArgs e)
      {
          getGrid();

      }

      // ============================ чтение таблицы а оп ==============================================
      void getGrid()
      {
          int LenKey = ComParKey.Length;

          string GlvBegDatTxt;

          GlvBegDat = (DateTime)Session["GlvBegDat"];

          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");

          // ----------------------- для печати --------------------------
          parBuxFrm.Value = BuxFrm;
          parLenKey.Value = Convert.ToString(LenKey);
          parTxtKey.Value = ComParKey;
          parTekDat.Value = GlvBegDatTxt;

          //          if (LenKey > 0)
          //           {

          // создание DataSet.
          DataSet ds = new DataSet();

          // строка соединение
          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspSprTbl", con);
          cmd = new SqlCommand("HspSprTbl", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
          cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
          cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
          // ------------------------------------------------------------------------------заполняем первый уровень
          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspSprTbl");
          // ------------------------------------------------------------------------------заполняем второй уровень
          //        ds.Merge(InsSprSttRspSel(MdbNam, BuxFrm, LenKey, ComParKey));
          GridTbl.DataSource = ds;
          GridTbl.DataBind();
          //        }

      }

      protected void PushButton_Click(object sender, EventArgs e)
      {
          string GlvBegDatTxt;
          //        string GlvEndDatTxt;

          Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
          //       Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

          GlvBegDat = (DateTime)Session["GlvBegDat"];
          //       GlvEndDat = (DateTime)Session["GlvEndDat"];
          //       txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");

          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
          //       GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

          //         localhost.Service1Soap ws = new localhost.Service1SoapClient();
          //         ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

          getGrid();
      }


      // ============================ загрузка EXCEL в базу ==============================================
      // ============================ загрузка TEXT в базу ==============================================
      protected void CmpButton_Click(object sender, EventArgs e)
      {
          int LenKey = ComParKey.Length;

          string GlvBegDatTxt;

          GlvBegDat = (DateTime)Session["GlvBegDat"];

          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");

          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          // создание команды
          SqlCommand cmd = new SqlCommand("HspSprTblGrdCmp", con);
          cmd = new SqlCommand("HspSprTblGrdCmp", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
          cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
          cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
          // ------------------------------------------------------------------------------заполняем первый уровень
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();
          // ------------------------------------------------------------------------------заполняем второй уровень


          getGrid();
      }

      // ============================ загрузка TEXT в базу ==============================================
      protected void UplButton_Click(object sender, EventArgs e)
      {

          string[] MasPol = new string[5000];
          string Pol = "";
          string TxtFil = "";
          string TxtIin = "";
          string TxtFio = "";
          string TxtAnl = "";
          string TxtVal = "";
          int I = 0;
          int J = 0;
          int N = 0;
          int Nxt = 0;
          long Res;
          bool IsInt;

          //        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

          // --------------------------------------------------------------------------------------
          if (FileUpload1.HasFile)
          {
              StreamReader reader = new StreamReader(FileUpload1.FileContent, Encoding.Default);
              string Stroka = reader.ReadToEnd();

              //    ----------------------------- запись в массив -------------------------------------------
              int Dlin = Stroka.Length;
              int MasInd = 0;
              while (1 == 1)
              {
                  Pol = "";

                  for (J = 0; J < Dlin; J++)
                  {
                      if (Stroka.Substring(J, 1) != "\n")
                      {
                          Pol = Pol + Stroka.Substring(J, 1);
                      }
                      else
                      {
                          //                                       I = J + 4;
                          MasInd = MasInd + 1;
                          MasPol[MasInd] = Pol.Substring(0, Pol.Length - 1);
                          Pol = "";
                      }
                  }
                  break;
              }


              //       ======================================= ЕСЛИ ЕСТЬ ДАННЫЕ =======================================================
              if (MasInd > 1)
              {

                  //       ======================================= УДАЛИТЬ РЕЗУЛЬТАТ =======================================================
                  string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                  SqlConnection con = new SqlConnection(connectionString);
                  con.Open();

                  //       ======================================= ОТКРЫТЬ ТАБЛИЦУ =======================================================
                  //          ----------------------------------------------------------------------------------
                  // создание команды
                  SqlCommand cmd = new SqlCommand("HspSprTblGrdUpl", con);
                  cmd = new SqlCommand("HspSprTblGrdUpl", con);
                  // указать тип команды
                  cmd.CommandType = CommandType.StoredProcedure;
                  //        ------------------------------------------------------------------------
                  // создать коллекцию параметров , передать параметр
                  cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar);
                  cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar);
                  cmd.Parameters.Add("@UPLNNN", SqlDbType.Int, 4);
                  cmd.Parameters.Add("@UPLTXT", SqlDbType.VarChar);

                  N = 0;
                  //       ======================================= ЗАПИСАТЬ В ЦИКЛЕ  =======================================================
                  for (J = 1; J <= MasInd; J++)
                  {
                      //       ======================================= ЗАПИСАТЬ В БАЗУ  =======================================================
                      // создать коллекцию параметров , передать параметр
                      cmd.Parameters["@BUXSID"].Value = BuxSid;
                      cmd.Parameters["@BUXFRM"].Value = BuxFrm;
                      cmd.Parameters["@UPLNNN"].Value = N;
                      cmd.Parameters["@UPLTXT"].Value = MasPol[J];
                      // создание DataAdapter
                      SqlDataAdapter da = new SqlDataAdapter(cmd);
                      // ------------------------------------------------------------------------------заполняем первый уровень
                      // передать параметр
                      // ------------------------------------------------------------------------------заполняем второй уровень
                      cmd.ExecuteNonQuery();
                      N = N + 1;
                      //       ======================================= ЗАПИСАТЬ В БАЗУ  =======================================================
                  }


              }

              getGrid();

          }
      }

      // ============================ одобрение для записи документа в базу ==============================================
      protected void NxtButton_Click(object sender, EventArgs e)
      {
          ConfirmDialog.Visible = true;
          ConfirmDialog.VisibleOnLoad = true;
      }

      // ============================ загрузка TEXT в базу ==============================================
      protected void btnNxtOK_click(object sender, EventArgs e)
      {
          int LenKey = ComParKey.Length;

          string GlvBegDatTxt;

          ConfirmDialog.Visible = false;
          ConfirmDialog.VisibleOnLoad = false;


          GlvBegDat = (DateTime)Session["GlvBegDat"];

          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");

          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          // создание команды
          SqlCommand cmd = new SqlCommand("HspSprTblGrdNxt", con);
          cmd = new SqlCommand("HspSprTblGrdNxt", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
          cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
          cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
          // ------------------------------------------------------------------------------заполняем первый уровень
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();
          // ------------------------------------------------------------------------------заполняем второй уровень


          getGrid();
      }

      // ============================ одобрение для записи документа в базу ==============================================
      protected void SttButton_Click(object sender, EventArgs e)
      {
          ConfirmDialogStt.Visible = true;
          ConfirmDialogStt.VisibleOnLoad = true;
      }

      // ============================ загрузка TEXT в базу ==============================================
      protected void btnSttOK_click(object sender, EventArgs e)
      {
          int LenKey = ComParKey.Length;

          string GlvBegDatTxt;

          ConfirmDialogStt.Visible = false;
          ConfirmDialogStt.VisibleOnLoad = false;


          GlvBegDat = (DateTime)Session["GlvBegDat"];

          GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");

          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          // создание команды
          SqlCommand cmd = new SqlCommand("HspSprTblGrdSprBux", con);
          cmd = new SqlCommand("HspSprTblGrdSprBux", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@LENKEY", SqlDbType.Int, 4).Value = LenKey;
          cmd.Parameters.Add("@TREKEY", SqlDbType.VarChar).Value = ComParKey;
          cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
          // ------------------------------------------------------------------------------заполняем первый уровень
          // создание команды
          cmd.ExecuteNonQuery();
          con.Close();
          // ------------------------------------------------------------------------------заполняем второй уровень


          getGrid();
      }

      // ------------------------------------------------------------------------------ЗАГРУЗКА ТАБЕЛЯ ИЗ EXCEL

      protected void btnUpload_Click(object sender, EventArgs e)
      {
          if (FileUpload1.HasFile)
          {
              string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
              string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
              string FolderPath = ConfigurationManager.AppSettings["FolderPath"];
              //  string FilePath = Server.MapPath(FolderPath + FileName);

              string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

              FileUpload1.SaveAs(FilePath);
              //                GetExcelSheets(FilePath, Extension, "Yes");

              ImportDataFromExcel(FilePath);

          }
      }

      public void ImportDataFromExcel(string excelFilePath)
      {
          //declare variables - edit these based on your particular situation 
          string ssqltable = "TAB_TABEL";
          // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have different 
          string myexceldataquery = "SELECT '" + BuxFrm + "',* FROM [Стат$]";
          try
          {
              //create our connection strings 
              //                string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=yes;\""; 
              string sexcelconnectionstring = @"provider=Microsoft.ACE.OLEDB.12.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";

              //      string ssqlconnectionstring = "Data Source=SAYYED;Initial Catalog=SyncDB;Integrated Security=True"; 
              string ssqlconnectionstring = ConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

            //              ----------------------------------------------------------  очистить таблицу -----------------------
            //execute a query to erase any previous data from our destination table 
            string sclearsql = "DELETE FROM TAB_TABEL WHERE FRM='" + BuxFrm + "'";
            SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
            SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
            sqlconn.Open();
            sqlcmd.ExecuteNonQuery();
            //        sqlconn.Close();

              //              ----------------------------------------------------------  загрузить таблицу -----------------------
              //series of commands to bulk copy data from the excel file into our sql table 
              OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
              OleDbCommand oledbcmd = new OleDbCommand(myexceldataquery, oledbconn);
              oledbconn.Open();
              OleDbDataReader dr = oledbcmd.ExecuteReader();
              SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
              bulkcopy.DestinationTableName = ssqltable;
              while (dr.Read())
              {
                  bulkcopy.WriteToServer(dr);
              }
              dr.Close();
              oledbconn.Close();
              //              ----------------------------------------------------------  слить в базу данных -----------------------
              //              ----------------------------------------------------------  очистить таблицу -----------------------
              //execute a query to erase any previous data from our destination table 
              //string sclearsql = "DELETE FROM TAB_RPN WHERE FRM='" + BuxFrm + "'";
             // SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
              //SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
              //sqlconn.Open();
              //sqlcmd.ExecuteNonQuery();
              //        sqlconn.Close();

              //execute a query to erase any previous data from our destination table 
              // string sclearsql = "DELETE FROM TAB_RPN WHERE FRM='" + BuxFrm + "'";
              SqlConnection sqlconnMrg = new SqlConnection(ssqlconnectionstring);
              SqlCommand sqlcmdMrg = new SqlCommand("HspSprTblGrdUplExl", sqlconn);
              sqlcmdMrg.CommandType = CommandType.StoredProcedure;
              sqlcmdMrg.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;

              sqlconnMrg.Open();
              sqlcmdMrg.ExecuteNonQuery();
              sqlconnMrg.Close();

              sqlconn.Close();

              //lblMessage.Text = "РПН ЗАГРУЖЕН В БАЗУ.";

              getGrid();

              // проверить если фаил есть удалить ----------------------------------------------------------------
              if (File.Exists(excelFilePath)) File.Delete(excelFilePath);
          }
          catch (Exception ex)
          {
              //handle exception 
              //lblMessage.Text = ex.Message;
          }
      }


      // ============================ одобрение для записи документа в базу ==============================================

          </script>   
    
    
<body>
    <form id="form1" runat="server"> 
     <span id="WindowPositionHelper"></span>
     
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sdsGrf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
<!--------------------------------------------------------  -->   
     <asp:HiddenField ID="parBuxFrm" runat="server" />
     <asp:HiddenField ID="parLenKey" runat="server" />
     <asp:HiddenField ID="parTxtKey" runat="server" />
     <asp:HiddenField ID="parTekDat" runat="server" />
<!--------------------------------------------------------  -->   
 
    <div>
      <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
        <center>
             <asp:Label ID="Label1" runat="server" Text="Укажи месяц,год" ></asp:Label>  
             
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
			 
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

    </asp:Panel>

        <%-- ============================  верхний блок  ============================================ --%>
             <div id="div_cnt" style="position:relative;left:0%; width:100%; " >
     		           <obout:Grid id="GridTbl" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_11" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="200%"
                                   AllowSorting="false"
                                   AllowPageSizeSelection="false"
	         		               AllowAddingRecords = "true"
                                   AllowRecordSelection = "true"
                                   KeepSelectedRecords = "true">
                                   <ClientSideEvents OnClientSelect="OnClientSelect" ExposeSender="true"/>
           		           		<Columns>
	                    			<obout:Column ID="Column90" DataField="TABIDN" HeaderText="Идн" Visible="false" Width="00" />
	                    			<obout:Column ID="Column91" DataField="TABKOD" HeaderText="КОД" ReadOnly ="true" Width="00" Align="right" />
    	                    	    <obout:Column ID="Column92" DataField="TABNNN" HeaderText="№" Width="00" />											
                    				<obout:Column ID="Column93" DataField="FI" HeaderText="ФИО"  Width="100" />
                				    <obout:Column ID="Column94" DataField="DLGNAM" HeaderText="ДОЛЖНОСТЬ"  Width="70" />
                				    <obout:Column ID="Column95" DataField="TABODX" HeaderText="Обед"  Width="40" />
                    				<obout:Column ID="Column01" DataField="TAB001" HeaderText="01"  Width="75"/>
                    				<obout:Column ID="Column02" DataField="TAB002" HeaderText="02"  Width="75" />
                    				<obout:Column ID="Column03" DataField="TAB003" HeaderText="03"  Width="75" />
                       				<obout:Column ID="Column04" DataField="TAB004" HeaderText="04"  Width="75" />
                    				<obout:Column ID="Column05" DataField="TAB005" HeaderText="05"  Width="75" />
                    				<obout:Column ID="Column06" DataField="TAB006" HeaderText="06"  Width="75" />
                       				<obout:Column ID="Column07" DataField="TAB007" HeaderText="07"  Width="75" />
                    				<obout:Column ID="Column08" DataField="TAB008" HeaderText="08"  Width="75" />
                    				<obout:Column ID="Column09" DataField="TAB009" HeaderText="09"  Width="75" />
                    				<obout:Column ID="Column10" DataField="TAB010" HeaderText="10"  Width="75" />
                       				<obout:Column ID="Column11" DataField="TAB011" HeaderText="11"  Width="75" />
                    				<obout:Column ID="Column12" DataField="TAB012" HeaderText="12"  Width="75" />
                    				<obout:Column ID="Column13" DataField="TAB013" HeaderText="13"  Width="75" />
                    				<obout:Column ID="Column14" DataField="TAB014" HeaderText="14"  Width="75" />
                       				<obout:Column ID="Column15" DataField="TAB015" HeaderText="15"  Width="75" />
                    				<obout:Column ID="Column16" DataField="TAB016" HeaderText="16"  Width="75" />
                    				<obout:Column ID="Column17" DataField="TAB017" HeaderText="17"  Width="75" />
                    				<obout:Column ID="Column18" DataField="TAB018" HeaderText="18"  Width="75" />
                       				<obout:Column ID="Column19" DataField="TAB019" HeaderText="19"  Width="75" />
                    				<obout:Column ID="Column20" DataField="TAB020" HeaderText="20"  Width="75" />
                    				<obout:Column ID="Column21" DataField="TAB021" HeaderText="21"  Width="75" />
                    				<obout:Column ID="Column22" DataField="TAB022" HeaderText="22"  Width="75" />
                       				<obout:Column ID="Column23" DataField="TAB023" HeaderText="23"  Width="75" />
                    				<obout:Column ID="Column24" DataField="TAB024" HeaderText="24"  Width="75" />
                    				<obout:Column ID="Column25" DataField="TAB025" HeaderText="25"  Width="75" />
                    				<obout:Column ID="Column26" DataField="TAB026" HeaderText="26"  Width="75" />
                       				<obout:Column ID="Column27" DataField="TAB027" HeaderText="27"  Width="75" />
                    				<obout:Column ID="Column28" DataField="TAB028" HeaderText="28"  Width="75" />
                    				<obout:Column ID="Column29" DataField="TAB029" HeaderText="29"  Width="75" />
                    				<obout:Column ID="Column30" DataField="TAB030" HeaderText="30"  Width="75" />
                       				<obout:Column ID="Column31" DataField="TAB031" HeaderText="31"  Width="75" />
		                    	</Columns>
                                <ScrollingSettings ScrollHeight="450" ScrollWidth="1250" NumberOfFixedColumns="5" FixedColumnsPosition="Left"/>
	
	                    	</obout:Grid>	
           </div>
       </div>
          <div id="div_cnt2" style="position:relative;left:0%; width:100%; border-style:double">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="Button4" runat="server" onclick="NxtButton_Click" Text="Из пред.мес" />
                   <asp:Button ID="Button6" runat="server" onclick="SttButton_Click" Text="Из штатки" />
                   <asp:FileUpload ID="FileUpload1" runat="server" />
                   <asp:Button ID="ButtonUpl" runat="server" onclick="btnUpload_Click" Text="Загрузка" />
                   <asp:Button ID="Button2" runat="server" onclick="CmpButton_Click" Text="Расчет" />
                   <input type="button" name="PrtGrfButton" value="Печать графика" id="PrtGrfButton" onclick="PrtGrfButton_Click();">
                   <input type="button" name="PrtTblButton" value="Печать табеля" id="PrtTblButton" onclick="PrtTblButton_Click();">
                   <asp:Button ID="Button3" runat="server" onclick="NxtButton_Click" Text="Перевод на слд.месяц" />
              </center>
           </div>

         <div class="YesNo" title="Хотите удалить ?"  style="display: none">
                Хотите удалить запись ?
           </div>  
   <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa 

        ============================================ 
 --%>
               <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Top="400" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите перевести табель на след. месяц?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnNxtOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

              <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialogStt" runat="server" Visible="false" IsModal="true" Top="400" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите сгенерировать из штатки?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button5" Text="ОК" OnClick="btnSttOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialogStt.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

       </form>
     
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="SCREEN_CENTER"  Top="700" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
 
 

     
      <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <owd:Window ID="TblWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="0" Height="550" Width="500" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Табель сотрудника">
        </owd:Window>
    
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

       /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>

</body>

</html>


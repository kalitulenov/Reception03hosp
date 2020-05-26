<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%@ Register TagPrefix="acw" Namespace="Aspose.Cells.GridWeb" Assembly="Aspose.Cells.GridWeb" %>
<%-- ================================================================================ --%>


<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Aspose.Cells.GridWeb.Data" %>

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
        //  предупреждение перед закрытикм страницы --------------------------------------------------------------------------
        /*
        $(document).ready(function () {
            $(window).bind("beforeunload", function () {
         //       window.parent.WindowClose();
               return confirm("Do you really want to close?");
            });
        });
        */
        /*
        window.onbeforeunload = WindowCloseHanlder;
        function WindowCloseHanlder() {
            window.alert('My Window is reloading');
        }
        */

        //    ------------------ ------------------------------------------------------
        function CloseWin() {
            window.opener.HandlePopupResult("Закрыть");
            self.close();
      }

        //    ------------------ смена логотипа ----------------------------------------------------------
        function Print(grid) {
    //        alert("Print=");
            //Get Id of GridWeb
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            //Call print
            grid.print();
        }

        //    ------------------ смена логотипа ----------------------------------------------------------
        function SaveGrid() {
            //Get Id of GridWeb
     //       alert("onclick=");
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            grid.updateData();
            if (grid.validateAll()) { alert("Yes"); return true; }
            else { alert("No"); return false; }
            //Call print
           // grid.print();
        }
//  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        //    ---------------- обращение веб методу --------------------------------------------------------
        window.onbeforeunload = function () {
            alert("unload");
        }

        function onCellSelected(cell, isOriginal) {
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
         //   alert("cell2=" + cell.id);
            var row = grid.getCellRow(cell);
            var col = grid.getCellColumn(cell);

            document.getElementById("parExl001").value = row;
            document.getElementById("parExl002").value = col;
        }

        function MyOnPageChange(index) {
            alert("current page is:" + index);
        //    console.log("current page is:" + index);
        }

        //    ------------------------------------------------------------------------------------------------------------------------
        function Speech() {
        //    alert("ROW=" + document.getElementById("parExl001").value + "Col=" + document.getElementById("parExl002").value)
            KltOneWindow.setTitle("Блокнот");
            KltOneWindow.setUrl("SpeechAmb.aspx?ParTxt=NotePad@" + document.getElementById("parExl001").value + "@" + document.getElementById("parExl002").value + "&Browser=Desktop");
            KltOneWindow.Open();
            return false;
        }


        function ondblclickcell(cell) {
     //         alert("cell=" + cell.id);
            document.getElementById("parExlXyz").value = cell.id;
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            var row = grid.getCellRow(cell);
            var col = grid.getCellColumn(cell);
            grid.setCellValue(row, col, cell.id);   // изменеие ячейки в JAVE
        }

        function WinClose(result) {
         //   result = "NotePad@13@0@2222222222222222@3333333333333";
         //   alert("result of popup is: " + result );
            var MasPar = result.split('@');
            var row = MasPar[1];
            var col = MasPar[2];

        //    alert("ROW=" + row + " Col=" + col + " Next= " + MasPar[3]);
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            var Rek= grid.getCellValue(row, col);
         //   alert("Значение=" + Dan);

            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            grid.setCellValue(row, col, Rek + " " + MasPar[3]);   // изменеие ячейки в JAVE
            KltOneWindow.Close();
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbDocTyp;
    string AmbUslIdnTek;
    string AmbUziTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;
    /*
    */
    string XlsFil;

    int i = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        AmbDocTyp = Convert.ToString(Request.QueryString["AmbDocTyp"]);
        if (AmbUslIdn == "0") AmbUziTyp = "ADD";
        else AmbUziTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbUslIdn ", AmbUslIdn);

        if (!Page.IsPostBack)
        {
            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;
            parDocTyp.Value = AmbDocTyp;
            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {
        int TekUsl;
        int UziXlsKod = 0;
        string UziXlsNam = "";
        string UziXlsImg = "";
        string UziXlsOrg = "";
        string UziXlsAdr = "";
        string UziXlsDat = "";
        string UziXlsFio = "";
        string UziXlsIin = "";
        string UziXlsBrt = "";
        string UziXlsDoc = "";

        string UziXlsKltAdr = "";
        string UziXlsKltRabNam = "";
        string UziXlsKltRabDol = "";
        string UziXlsKlTel = "";
        string UziXlsKltSex = "";

        string UziXlsDocDig = "";
        string UziXlsDocAnm = "";

        string UziXlsBolNum = "";
        string UziXlsBolDni = "";


        //string UziXlsOrgXyz = "";
        //string UziXlsAdrXyz = "";
        //string UziXlsDatXyz = "";
        //string UziXlsFioXyz = "";
        //string UziXlsBrtXyz = "";
        string UziXlsDocXyz = "";
        string UslNam = "";

        //int startCell = 0;
        //int StartRow = 0;
        //int EndColumn = 0;
        //int EndRow = 0;
        string Papka = "";
        string Sablon = "";
        string XlsFlg = "";

        double ColWdt = 0;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
        TekUsl = 0;

        //      if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        //      else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        //if first visit this page clear GridWeb1 
        if (!IsPostBack && !GridWeb1.IsPostBack)
        {
            // LoadData();
            GridWeb1.WorkSheets.Clear();
            GridWeb1.WorkSheets.Add();
        }


        //       if (TekUsl > 0)
        //       {

        //  ==================================================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbFnkOneAspose", con);
        cmd = new SqlCommand("HspAmbFnkOneAspose", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbFnkOneAspose");

        if (ds.Tables[0].Rows.Count > 0)
        {
            XlsFlg = Convert.ToString(ds.Tables[0].Rows[0]["XLSFLG"]);
            UziXlsKod = Convert.ToInt32(ds.Tables[0].Rows[0]["XLSKOD"]);
            UziXlsNam = Convert.ToString(ds.Tables[0].Rows[0]["XLSNAMSBL"]);
            UziXlsImg = Convert.ToString(ds.Tables[0].Rows[0]["UZINAMXLS"]);
            UziXlsOrg = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);    // #НаимОрг#
            UziXlsAdr = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTADR"]);
            UziXlsDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFDAT"]);       // #ДатаТек#
            UziXlsFio = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);       // #Фио#
            UziXlsIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);       // #ИИН#
            UziXlsBrt = Convert.ToString(ds.Tables[0].Rows[0]["GRFBRT"]);       // #ДатаРож#
            UziXlsDoc = Convert.ToString(ds.Tables[0].Rows[0]["GRFDOC"]);       // #ФиоВрч#
            UslNam = Convert.ToString(ds.Tables[0].Rows[0]["USLNAM"]);
            UziXlsKltAdr = Convert.ToString(ds.Tables[0].Rows[0]["KLTADR"]);       // #Адрес#
            UziXlsKltRabNam = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);       // #МестоРаб#
            UziXlsKltRabDol = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABDOL"]);       // #Долж#
            UziXlsKlTel = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);       // #Тел#
            UziXlsKltSex = Convert.ToString(ds.Tables[0].Rows[0]["KLTSEX"]);       // #Пол#

            UziXlsDocDig = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);       // #Диагноз#
            UziXlsDocAnm = Convert.ToString(ds.Tables[0].Rows[0]["DOCANM"]);       // #Анамнез#

            UziXlsBolNum = Convert.ToString(ds.Tables[0].Rows[0]["BOLNUM"]);       // #БЛномер#
            UziXlsBolDni = Convert.ToString(ds.Tables[0].Rows[0]["BOLDNI"]);       // #БЛдни#
            //							
            //  				     

            //      UziXlsOrgXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSORGNAM"]);
            //      UziXlsAdrXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSORGADR"]);
            //      UziXlsDatXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSDAT"]);
            //      UziXlsFioXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSFIO"]);
            //      UziXlsBrtXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSBRT"]);
            UziXlsDocXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSDOC"]);
            parXlsFio.Value = UziXlsFio;
        }
        ds.Dispose();
        //            con.Close();

        //  ==================================================================================================================

        if (UziXlsImg == "")
        {
            //Protect Workbook
            //         book.Protect("abc-123");

            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
            if (parDocTyp.Value == "УЗИ") Papka = @"C:\BASEUZI\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            if (parDocTyp.Value == "ФНК") Papka = @"C:\BASEUZI\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            if (parDocTyp.Value == "РНТ") Papka = @"C:\BASEXRY\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            if (parDocTyp.Value == "ЛАБ") Papka = @"C:\BASELAB\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            if (parDocTyp.Value == "МЕД") Papka = @"C:\BASEMEDFORM\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");

            if (XlsFlg == "")
            {
                //  Создать имя образа
                XlsFil = Papka + @"\" + UziXlsIin + "_" + Convert.ToInt32(AmbCrdIdn).ToString("D10") + "_" + Convert.ToInt32(UziXlsKod).ToString("D4");
                //  Добавить расширение xls
                parXlsFil.Value = XlsFil + ".xls";
                //  Добавить расширение pdf
                parXlsFilPdf.Value = XlsFil + ".pdf";
                UziXlsImg = XlsFil;

                //  показывает в виде HTML без корректировки             
                //              string XlsFil = Papka + @"\" + UziXlsFio.Substring(0, 12) + "_" + Convert.ToInt32(AmbUslIdn).ToString("D10") + ".html";

                // поверить каталог, если нет создать ----------------------------------------------------------------
                if (Directory.Exists(Papka)) i = 0;
                else Directory.CreateDirectory(Papka);


                // ЗАПИСАТЬ НА ДИСК ===========================================================================================
                //Save and Launch
                //       book.SaveToFile(XlsFil, ExcelVersion.Version97to2003);
                //        book.Worksheets[0].SaveToHtml(XlsFil);    // тоже работает
                // скорировать скачанный файл ----------------------------------------------------------------
                if (parDocTyp.Value == "УЗИ") Sablon = @"C:\BASEUZI\UziSablon\" + UziXlsNam + ".xls";
                if (parDocTyp.Value == "ФНК") Sablon = @"C:\BASEUZI\UziSablon\" + UziXlsNam + ".xls";
                if (parDocTyp.Value == "РНТ") Sablon = @"C:\BASEXRY\XrySablon\Рентген.xls";
                if (parDocTyp.Value == "ЛАБ") Sablon = @"C:\BASELAB\LabSablon\" + UziXlsNam + ".xls";
                if (parDocTyp.Value == "МЕД") Sablon = @"C:\BASEMEDFORM\MedFormSablon\" + UziXlsNam + ".xls";

                  // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(parXlsFil.Value)) File.Delete(parXlsFil.Value);
                File.Copy(Sablon, parXlsFil.Value);

                //        sheet.SaveToHtml(XlsFil);

                // ЗАПИСАТЬ НА ДИСК МЕСТОПОЛОЖЕНИЕ ===========================================================================================
                SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLIG1='',USLXLS='" + XlsFil + "' WHERE USLIDN=" + AmbUslIdn, con);
                cmdUsl.ExecuteNonQuery();
                con.Close();

                GridWeb1.ImportExcelFile(parXlsFil.Value);
                this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2007);
            }
            else
            {
                XlsFil = XlsFlg;
                parXlsFil.Value = XlsFil + ".xls";
                parXlsFilPdf.Value = XlsFil + ".pdf";
                GridWeb1.ImportExcelFile(parXlsFil.Value);
            }
        }
        else
        {
            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            //           BoxStx.Enabled = false;
            //           BoxUsl.Enabled = false;

            parXlsFil.Value = UziXlsImg + ".xls";
            parXlsFilPdf.Value = UziXlsImg + ".pdf";
            GridWeb1.ImportExcelFile(parXlsFil.Value);
        }

        // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
        //      BoxStx.Enabled = false;
        //      BoxUsl.Enabled = false;

        //     parXlsFil.Value = UziXlsImg + ".xls";
        //     parXlsFilPdf.Value = UziXlsImg + ".pdf";
        //     GridWeb1.ImportExcelFile(parXlsFil.Value);

        // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
        // Imports from a excel file.
        GridWeb1.EnableAJAX = true;

        //Accessing the active sheet
        GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

        if (parDocTyp.Value == "РНТ") sheet.Cells["A5"].PutValue(UslNam);

        //Putting value to "A1" cell
        //sheet.Cells["B6"].PutValue(UziXlsDat.Substring(0, 10));
        //sheet.Cells["B2"].PutValue(UziXlsOrg);
        //sheet.Cells["B7"].PutValue(UziXlsFio);
        //sheet.Cells["B8"].PutValue(UziXlsBrt.Substring(0, 10));

        //   if (UziXlsBrt.Length > 9) sheet.Cells["B8"].PutValue(UziXlsBrt.Substring(0, 10));

        // Accessing the cells collection of the worksheet that is currently active
        GridCells cells = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex].Cells;

        //   ---------------------------  ФАМИЛИЯ ВРАЧА ---------------------------------
        for (i = 1; i < cells.MaxDataRow+1; i++)
        {
            for (int j = 0; j <= cells.MaxDataColumn; j++)
            {
                GridCell cellDoc = sheet.Cells[i, j];
                string Pol = cellDoc.StringValue;
                if (Pol.IndexOf("#НаимОрг#") > -1) sheet.Cells[i, j].PutValue(UziXlsOrg);
                if (Pol.IndexOf("#ДатаТек#") > -1) sheet.Cells[i, j].PutValue(UziXlsDat);
                if (Pol.IndexOf("#Фио#") > -1) sheet.Cells[i, j].PutValue(UziXlsFio);
                if (Pol.IndexOf("#ИИН#") > -1) sheet.Cells[i, j].PutValue(UziXlsIin);
                if (Pol.IndexOf("#ДатаРож#") > -1) sheet.Cells[i, j].PutValue(UziXlsBrt);
                if (Pol.IndexOf("#ФиоВрч#") > -1) sheet.Cells[i, j].PutValue(UziXlsDoc);
                if (Pol.IndexOf("#Адрес#") > -1) sheet.Cells[i, j].PutValue(UziXlsKltAdr);
                if (Pol.IndexOf("#МестоРаб#") > -1) sheet.Cells[i, j].PutValue(UziXlsKltRabNam);
                if (Pol.IndexOf("#Долж#") > -1) sheet.Cells[i, j].PutValue(UziXlsKltRabDol);
                if (Pol.IndexOf("#Тел#") > -1) sheet.Cells[i, j].PutValue(UziXlsKlTel);
                if (Pol.IndexOf("#Пол#") > -1) sheet.Cells[i, j].PutValue(UziXlsKltSex);
                if (Pol.IndexOf("#Диагноз#") > -1) sheet.Cells[i, j].PutValue(UziXlsDocDig);
                if (Pol.IndexOf("#Анамнез#") > -1) sheet.Cells[i, j].PutValue(UziXlsDocAnm);
                if (Pol.IndexOf("#БЛномер#") > -1) sheet.Cells[i, j].PutValue(UziXlsBolNum);
                if (Pol.IndexOf("#БЛдни#") > -1) sheet.Cells[i, j].PutValue(UziXlsBolDni);
            }
        }

        // Accessing the cells collection of the worksheet that is currently active
        //  GridCells cells = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex].Cells;

        sheet.SetAllCellsEditable();

        for (i = 9; i < cells.MaxDataRow; i++)
        {
            int L = 0;
            int Ind = 0;
            int Prz = 0;
            int KolCol = 0;
            int KolColFin = 0;
            int KolSim = 0;
            string CellText = "";
            double VisotaCol = 0;
            //     int NumCol = 0;
            ColWdt = 0;
            //Autofit rows
            // Auto-fitting the 3rd row of the worksheet
            sheet.AutoFitColumn(1);

            GridCell cellDoc = sheet.Cells[i, 0];

            //   if (cellDoc.StringValue == "Врач") sheet.Cells[i,1].PutValue(UziXlsDoc);
            //	#ДатаТек#	#ФиоВрч#	#Фио#	#ДатаРож#	#Адрес#	#МестоРаб#	#Долж#
            //  #Диагноз#		#БЛномер#	#БЛдни#	#Пол# #Тел# #НаимОрг# #Анамнез#  


            for (int j = 0; j <= cells.MaxDataColumn; j++)
            {
                GridCell cell = sheet.Cells[i, j];
                Aspose.Cells.GridWeb.GridTableItemStyle cellstyle = sheet.Cells[i, j].Style;
                //      cellstyle.Font.Size = new FontUnit("10pt");
                //    cellstyle.Font.Bold = true;
                //    cellstyle.HorizontalAlign = HorizontalAlign.Center;
                //    cellstyle.BorderWidth = 1;
                cellstyle.Wrap = true;

                //// Sets the column width.
                //sheet.Cells.SetColumnWidth(0, New Unit(80, UnitType.Point));
                ////set the row height
                //sheet.Cells.SetRowHeight(0, New Unit(40, UnitType.Point));

                /*
                //Create workbook
                Workbook workbook = new Workbook();
                //Access worksheet
                Worksheet worksheet = workbook.Worksheets[0];
 
                //Place some text in cell A1 without wrapping
                Cell cellA1 = worksheet.Cells["A1"];
                cellA1.PutValue("Some Text Unwrapped");
                //Place some text in cell A5 wrapping
                Cell cellA5 = worksheet.Cells["A5"];
                cellA5.PutValue("Some Text Wrapped");
                Style style = cellA5.GetStyle();
                style.IsTextWrapped = true;
                cellA5.SetStyle(style);
 
                //Autofit rows
                worksheet.AutoFitRows();
                */

                // ===================================================     корректируемые ячейки 
                //       if (sheet.Cells[i, j].Style.BackColor.Name == "ffffff99") sheet.SetReadonlyRange(i, j, 1, 1);
                //    {
                // ===================================================  

                // поиск в обединен ячейках
                Prz = 0;

                for (int t = 0; t < cells.MergedCells.Count; t++)
                {
                    GridCellArea ca = (GridCellArea)cells.MergedCells[t];
                    if (i == ca.StartRow && j >= ca.StartColumn && j <= ca.EndColumn)
                    {
                        Prz = 9;
                        if (Ind != t)
                        {
                            ColWdt = cells.GetColumnWidth(j);
                            KolSim = cell.StringValue.Length;
                            CellText = cell.StringValue;
                            Ind = t;
                        }
                        else
                        {
                            ColWdt = ColWdt + cells.GetColumnWidth(j);
                            KolSim = KolSim + cell.StringValue.Length;
                        }
                        // проверить своиства след. ячейки
                        if (i == ca.StartRow && (j + 1) >= ca.StartColumn && (j + 1) <= ca.EndColumn) KolCol = 0;
                        else if (ColWdt > 0) KolCol = KolSim / Convert.ToInt32(ColWdt);
                        break;
                    }
                }   // ttttttttt

                if (Prz == 0)
                {
                    ColWdt = cells.GetColumnWidth(j);
                    KolSim = cell.StringValue.Length;
                    CellText = cell.StringValue;
                    if (ColWdt > 0) KolCol = KolSim / Convert.ToInt32(ColWdt);
                    else KolCol = 0;
                }

                if (KolCol > KolColFin) KolColFin = KolCol;
                //         }
                //         else
                //         {
                // Finally, Setting selected cells of the worksheet to Readonly
                //            sheet.SetReadonlyRange(i, j, 1, 1);
                //        }


            }   ///// JJJJJJJJJJJJJJJJJJ
                //   ------------------------------  УСТАНОВИТЬ ВЫСОТУ ЯЧЕЙКИ -------------------------------------------------
                //cells.SetRowHeight(i, j7 * (L * 1.1 / ColWdt + 1));  //пример
      //      VisotaCol = 17 * (KolSim * 1.2 /ColWdt + 1);
            VisotaCol = 8 * (KolSim * 1.2 /ColWdt + 1);
            //  VisotaCol = 17 * (KolColFin * 1.7 + 1);
            if (KolColFin > 0) cells.SetRowHeight(i, VisotaCol);
            else cells.SetRowHeight(i, 17);

        }  // IIII


        //      }   // if (TekUsl > 0)
    }



    //===============================================================================================================

    protected void GridWeb1_SaveCommand(object sender, EventArgs e)
    {
        //        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2007);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFilPdf.Value, GridSaveFormat.PDF);
    }
    /*
        protected void GridWeb1_CellDoubleClick(object sender, Aspose.Cells.GridWeb.CellEventArgs e)
        {
            // Displaying the name of the cell (that is double clicked) in GridWeb's Message Box
            string msg = "You just clicked <";
            msg += "Row: " + (e.Cell.Row + 1) + " Column: " + (e.Cell.Column + 1) + " Cell Name: " + e.Cell.Name + ">";
            GridWeb1.Message = msg;

        }
        */
    protected void GridWeb1_SubmitCommand(object sender, EventArgs e)
    {
        double ColWdt=0;
        string Pol;

        parExl001.Value = "";
        parExl002.Value = "";

        //Accessing the active sheet
        GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];
        // Accessing the cells collection of the worksheet that is currently active
        GridCells cells = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex].Cells;

        sheet.SetAllCellsEditable();
        for (i = 10; i < cells.MaxDataRow; i++)
        {
            int L = 0;
            int Ind = 0;
            int Prz = 0;
            int KolCol = 0;
            int KolColFin = 0;
            int KolSim = 0;
            int NumCol = 0;
            ColWdt = 0;

            for (int j = 0; j <= cells.MaxDataColumn; j++)
            {
                GridCell cell = sheet.Cells[i, j];
                // Aspose.Cells.GridWeb.GridTableItemStyle cellstyle = sheet.Cells[i, j].Style;
                //      cellstyle.Font.Size = new FontUnit("10pt");
                //    cellstyle.Font.Bold = true;
                //    cellstyle.HorizontalAlign = HorizontalAlign.Center;
                //    cellstyle.BorderWidth = 1;
                //cellstyle.Wrap = true;
                //sheet.Cells[i, j].Style = cellstyle;

                // ===================================================     корректируемые ячейки 
                //      if (sheet.Cells[i, j].Style.BackColor.Name != "ffffff99")  sheet.SetReadonlyRange(i, j, 1, 1);
                // ===================================================   
                // поиск в обединен ячейках
                Prz = 0;

                for (int t = 0; t < cells.MergedCells.Count; t++)
                {
                    GridCellArea ca = (GridCellArea)cells.MergedCells[t];
                    if (i == ca.StartRow && j >= ca.StartColumn && j <= ca.EndColumn)
                    {
                        Prz = 9;
                        if (Ind != t)
                        {
                            ColWdt = cells.GetColumnWidth(j);
                            KolSim = cell.StringValue.Length;
                            Ind = t;
                        }
                        else
                        {
                            ColWdt = ColWdt + cells.GetColumnWidth(j);
                            KolSim = KolSim + cell.StringValue.Length;
                        }
                        // проверить своиства след. ячейки
                        if (i == ca.StartRow && (j + 1) >= ca.StartColumn && (j + 1) <= ca.EndColumn) KolCol = 0;
                        else if (ColWdt > 0) KolCol = KolSim / Convert.ToInt32(ColWdt);
                        break;
                    }
                }   // ttttttttt

                if (Prz == 0)
                {
                    ColWdt = cells.GetColumnWidth(j);
                    KolSim = cell.StringValue.Length;
                    if (ColWdt > 0) KolCol = KolSim / Convert.ToInt32(ColWdt);
                    else KolCol = 0;
                }

                if (KolCol > KolColFin) KolColFin = KolCol;
                //    }
                //    else
                //    {
                // Finally, Setting selected cells of the worksheet to Readonly
                //        sheet.SetReadonlyRange(i, j, 1, 1);
                //    }


            }   ///// JJJJJJJJJJJJJJJJJJ
                //cells.SetRowHeight(i, j7 * (L * 1.1 / ColWdt + 1));
            if (KolColFin > 0) cells.SetRowHeight(i, 17 * (KolSim * 1.2 /ColWdt + 1));
            else cells.SetRowHeight(i, 17);

        }  // IIII


        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2007);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFilPdf.Value, GridSaveFormat.PDF);
    }


    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parXlsFio" runat="server" />
        <asp:HiddenField ID="parXlsFil" runat="server" />
        <asp:HiddenField ID="parXlsFilPdf" runat="server" />
        <asp:HiddenField ID="parExl001" runat="server" />
        <asp:HiddenField ID="parExl002" runat="server" />
        <asp:HiddenField ID="parPrv001" runat="server" />
        <asp:HiddenField ID="parPrv002" runat="server" />
        <asp:HiddenField ID="parDocTyp" runat="server" />
       <%-- ============================  верхний блок  ============================================ 
        <asp:TextBox ID="Sapka" 
             Text="НАЗНАЧЕНИЯ ВРАЧЕЙ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
--%>
        <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
            <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
                <Content>

                    <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td style="width: 70%; height: 30px;">
                            </td>
                            <td style="width: 25%; height: 30px;">
                                <asp:Button ID="Button0" runat="server" Width="24%" Text="Сохранить" OnClick="GridWeb1_SubmitCommand" />
                                <asp:Button ID="Button2" runat="server" Width="24%" Text="Печать" OnClientClick="Print();" />
                                <asp:Button ID="Button3" runat="server" Width="24%" Text="Микрофон" OnClientClick="Speech('GrfDig');" />
                                <asp:Button ID="Button1" runat="server" Width="24%" Text="Закрыть" OnClientClick="CloseWin();" />
                            </td>
                        </tr>

                    </table>

                </Content>
            </TopPanel>
            <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                <Content>

                    <div>
                        <acw:GridWeb ID="GridWeb1" runat="server" Width="100%" Height="100%" 
                            OnSaveCommand="GridWeb1_SaveCommand"
                            OnCellSelectedClientFunction="onCellSelected" 
                            PresetStyle="Professional1" 
                            EnableAsync="false">
                        </acw:GridWeb>
                    </div>

                </Content>
            </BottomPanel>
        </obspl:HorizontalSplitter>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="300" Top="100" Height="200" Width="600" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
     <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltOneWindow" runat="server" Url="SpeechAmb.aspx?ParTxt=NotePad&Browser=Desktop" IsModal="true" ShowCloseButton="true" Status=""
             Left="200" Top="100" Height="500" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

   <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
</body>

</html>



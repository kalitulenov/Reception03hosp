<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="acw" Namespace="Aspose.Cells.GridWeb" Assembly="Aspose.Cells.GridWeb" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Aspose.Cells.GridWeb.Data" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ============================  JAVA ============================================ --%>

     <script type="text/javascript">
         //    ------------------ смена логотипа ----------------------------------------------------------
         function Print(grid) {
             //Get Id of GridWeb
             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
             //Call print
             grid.print();
         }

         function SaveGrid() {
             //Get Id of GridWeb

        //     alert("SaveGrid");
             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
      //       grid = document.getElementById("_ctl0_mySpl_ctl01_ctl01_GridWeb1");
       //      alert("grid =" + grid);
             grid.updateData(true);
         }

         //    ------------------------------------------------------------------------------------------------------------------------
         function Speech() {
             KltOneWindow.setTitle("Блокнот");
             KltOneWindow.setUrl("SpeechAmb.aspx?ParTxt=NotePad@"+document.getElementById("parExl001").value +"@"+document.getElementById("parExl002").value+"&Browser=Desktop");
             KltOneWindow.Open();
             return false;
         }

         function ondblclickcell(cell) {
           //  alert("cell=" + cell.id);
             document.getElementById("parExlXyz").value = cell.id;
             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
             var row = grid.getCellRow(cell);
             var col = grid.getCellColumn(cell);
             grid.setCellValue(row, col, cell.id);   // изменеие ячейки в JAVE
         }

         function onCellSelected(cell, isOriginal) {
       //      alert("cell2=");
             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
             var row = grid.getCellRow(cell);
             var col = grid.getCellColumn(cell);

             document.getElementById("parExl001").value = row;
             document.getElementById("parExl002").value = col;
         }

         /*
         function onCellUpdated(cell, isOriginal) {
             //    alert("cell3=" + cell.id);
             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
             grid.setCellValue(row, col, grid.getCellValueByCell(cell));   // изменеие ячейки в JAVE
         }
         */

         function WinClose(result) {
          //   alert("result of popup is: " + result);
             var MasPar = result.split('@');
             var row = document.getElementById("parExl001").value;
             var col = document.getElementById("parExl002").value;

             var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
             grid.setCellValue(row, col, MasPar[3]);   // изменеие ячейки в JAVE
             KltOneWindow.Close();
         }

 </script>

    
</head>
    
    
<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UziIdn;
    int UziAmb;
    int UziKod;
    int UziKol;
    int UziSum;
    int UziKto;
    int UziLgt;
    string UziMem;

    int NumDoc;

    string AmbCrdIdn;
    string AmbUslIdn;
    //      string AmbCntIdn;
    string AmbDocTyp;
    int AmbUslKod;
    string AmbUslNam;

    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    string XlsFil;

    int[,] MasPos = new int[500, 2];
    int PosKol;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbDocTyp = Convert.ToString(Request.QueryString["AmbDocTyp"]);
        //   AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        //   AmbUslKod = Convert.ToInt32(Request.QueryString["AmbUslKod"]);
        //   AmbUslNam = Convert.ToString(Request.QueryString["AmbUslNam"]);
        HidAmbCrdIdn.Value = AmbCrdIdn;

        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        if (HidAmbCrdIdn.Value == "")
        {
            AmbCrdIdn = (string)Session["AmbCrdIdn"];
            AmbDocTyp = (string)Session["AmbDocTyp"];
            HidAmbCrdIdn.Value = AmbCrdIdn;
        }
        else
        {
            Session.Add("AmbCrdIdn", AmbCrdIdn);
            Session.Add("AmbDocTyp", AmbDocTyp);

            if (!Page.IsPostBack)
            {
                SubmitButton.Attributes["onclick"] = "SaveGrid();";
                //============= Установки ===========================================================================================
                if (AmbDocTyp == "061")
                {
                    TxtSap.Text = "ВРАЧЕБНО – КОНТРОЛЬНАЯ КАРТА физкультурника (форма 061)";
                    AmbUslKod = 3896;
                }
                if (AmbDocTyp == "062")
                {
                    TxtSap.Text = "ВРАЧЕБНО – КОНТРОЛЬНАЯ КАРТА спортсмена (форма 062)";
                    AmbUslKod = 3897;
                }
                if (AmbDocTyp == "086")
                {
                    TxtSap.Text = "МЕДИЦИНСКАЯ СПРАВКА (форма 086/у)";
                    AmbUslKod = 2518;
                }

                getHidRow();
                getGrid();
            }
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getHidRow()
    {
        int i = 0;
        //    AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("SELECT SprMedFrmUsl.SprMedUslBeg,SprMedFrmUsl.SprMedUslEnd " +
                                        "FROM SprBuxKdr INNER JOIN SprMedFrmUsl ON SprBuxKdr.DLGKOD=SprMedFrmUsl.SprMedUslDlg " +
                                                       "INNER JOIN SprMedFrm ON SprMedFrmUsl.SprMedUslKod=SprMedFrm.SprMedFrmKod " +
                                        "WHERE SprBuxKdr.BuxKod=" + BuxKod + " AND SprMedFrm.SprMedFrmKodPrc=" + AmbUslKod, con);

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "MedFrmOneSap");

        con.Close();

        i = 0;
        PosKol = 0;
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow rowPos in ds.Tables[0].Rows)
            {
                MasPos[i, 0] = Convert.ToInt32(rowPos["SprMedUslBeg"]);
                MasPos[i, 1] = Convert.ToInt32(rowPos["SprMedUslEnd"]);
                i = i + 1;
            }
            PosKol = i;
            ds.Dispose();
        }
    }
    //------------------------------------------------------------------------
    //------------------------------------------------------------------------
    protected void CanButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/GoBack/GoBack1.aspx");
        //  Response.Redirect("~/GlavMenu.aspx");

    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    protected void GridWeb1_SubmitCommand(object sender, EventArgs e)
    {
        // Saves to the file.
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2003);
    }

    void getGrid()
    {
        int TekUsl;
        int i = 0;
        int j = 0;

        string UziXlsNamXls = "";
        string UziXlsImg = "";
        string UziXlsOrg = "";
        string UziXlsAdr = "";
        string UziXlsCmp = "";
        string UziXlsDat = "";
        string UziXlsFio = "";
        string UziXlsIin = "";
        string UziXlsBrt = "";
        string UziXlsDoc = "";

        string UziXlsOrgXyz = "";
        string UziXlsAdrXyz = "";
        string UziXlsDatXyz = "";
        string UziXlsFioXyz = "";
        string UziXlsBrtXyz = "";
        string UziXlsDocXyz = "";

        //     AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        //     if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        //     else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        //if first visit this page clear GridWeb1 
        if (!IsPostBack && !GridWeb1.IsPostBack)
        {
            // LoadData();
            GridWeb1.WorkSheets.Clear();
            GridWeb1.WorkSheets.Add();
            
           
            //          GridWeb1.EnableDoubleClickEvent = true;
            //       GridWeb1.MaxColumn = 7;
            //       GridWeb1.MaxRow = 151;
        }

        //       if (TekUsl > 0)
        //       {
        //  ==================================================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmb061One", con);
        cmd = new SqlCommand("HspAmb061One", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@AMBCRDIDN", SqlDbType.VarChar).Value = HidAmbCrdIdn.Value; // HidAmbUslIdn.Value;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmb061One");

        if (ds.Tables[0].Rows.Count > 0)
        {
            UziXlsNamXls = Convert.ToString(ds.Tables[0].Rows[0]["MEDFRMNAMFUL"]);
            UziXlsImg = Convert.ToString(ds.Tables[0].Rows[0]["MEDFRMNAMXLS"]);
            UziXlsOrg = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);
            UziXlsAdr = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTADR"]);
            UziXlsCmp = Convert.ToString(ds.Tables[0].Rows[0]["ORGCMPTXT"]);
            UziXlsDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFDAT"]);
            UziXlsFio = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            UziXlsIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            UziXlsBrt = Convert.ToString(ds.Tables[0].Rows[0]["GRFBRT"]);
            UziXlsDoc = Convert.ToString(ds.Tables[0].Rows[0]["GRFDOC"]);
            UziXlsDoc = Convert.ToString(ds.Tables[0].Rows[0]["GRFDOC"]);
            /*
                            UziXlsOrgXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSORGNAM"]);
                            UziXlsAdrXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSORGADR"]);
                            UziXlsDatXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSDAT"]);
                            UziXlsFioXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSFIO"]);
                            UziXlsBrtXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSBRT"]);
                            UziXlsDocXyz = Convert.ToString(ds.Tables[0].Rows[0]["XLSDOC"]);
            */
        }
        ds.Dispose();
        //            con.Close();

        //  ==================================================================================================================


        if (UziXlsImg == "")
        {
            // ЗАГРУЗИТЬ ШАБЛОН ===========================================================================================
            //       sheet.Range[UziXlsOrgXyz].Text = UziXlsOrg;
            //      sheet.Range[UziXlsAdrXyz].Text = UziXlsAdr;
            //     sheet.Range[UziXlsDatXyz].Text = UziXlsDat;
            //     sheet.Range[UziXlsFioXyz].Text = UziXlsFio;
            //       sheet.Range[UziXlsBrtXyz].Text = UziXlsBrt;
            //       sheet.Range[UziXlsDocXyz].Text = UziXlsDoc;


            //Protect Workbook
            //         book.Protect("abc-123");

            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
            string Papka = @"C:\BASEMEDFORM\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            XlsFil = Papka + @"\" + UziXlsIin + "_" + Convert.ToInt32(HidAmbCrdIdn.Value).ToString("D10") + ".xls";
            parXlsFil.Value = XlsFil;

            //  показывает в виде HTML без корректировки             
            //              string XlsFil = Papka + @"\" + UziXlsFio.Substring(0, 12) + "_" + Convert.ToInt32(AmbUslIdn).ToString("D10") + ".html";

            // поверить каталог, если нет создать ----------------------------------------------------------------
            if (Directory.Exists(Papka)) i = 0;
            else Directory.CreateDirectory(Papka);

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(XlsFil)) File.Delete(XlsFil);

            // ЗАПИСАТЬ НА ДИСК ===========================================================================================
            //Save and Launch
            //       book.SaveToFile(XlsFil, ExcelVersion.Version97to2003);
            //        book.Worksheets[0].SaveToHtml(XlsFil);    // тоже работает
            // скорировать скачанный файл ----------------------------------------------------------------
            string Sablon = @"C:\BASEMEDFORM\MedFormSablon\" + UziXlsNamXls + ".xls";
            File.Copy(Sablon, XlsFil);

            //        sheet.SaveToHtml(XlsFil);

            // ЗАПИСАТЬ НА ДИСК МЕСТОПОЛОЖЕНИЕ ===========================================================================================
            SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLIG1='',USLXLS='" + XlsFil + "' WHERE USLAMB=" + HidAmbCrdIdn.Value, con);
            cmdUsl.ExecuteNonQuery();
            con.Close();

            // ЗАПИСАТЬ НА ДИСК В ВИДЕ ОБРАЗА ===========================================================================================
            //     Worksheet sheetImg = book.Worksheets[0];
            //     sheet.SaveToImage("MyImage.jpg");  

            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            // Imports from a excel file.
            GridWeb1.EnableAJAX = true;
            // Opening an Excel file as a stream
            //       FileStream fs = File.OpenRead(XlsFil);
            GridWeb1.ImportExcelFile(XlsFil);

            //     GridWeb1.MaxColumn = 6;

            //Accessing the active sheet
            GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

            // Hiding the 3rd row of the worksheet
            //   sheet.Cells.HideRow(2);

            // Hiding the 2nd column of the worksheet
            //  sheet.Cells.HideColumn(1);

            //Putting value to "A1" cell
            if (AmbUslKod == 3896)
            {
                sheet.Cells["A10"].PutValue(UziXlsDat);
                sheet.Cells["A11"].PutValue(UziXlsOrg);
                sheet.Cells["A12"].PutValue(UziXlsCmp);
                sheet.Cells["B16"].PutValue(UziXlsFio);
                sheet.Cells["B17"].PutValue(UziXlsBrt);
            }

            if (AmbUslKod == 3897)
            {
                sheet.Cells["A10"].PutValue(UziXlsDat);
                sheet.Cells["A11"].PutValue(UziXlsOrg);
                sheet.Cells["A12"].PutValue(UziXlsCmp);
                sheet.Cells["B14"].PutValue(UziXlsFio);
                sheet.Cells["B17"].PutValue(UziXlsBrt);
            }

            if (AmbUslKod == 2518)
            {
                sheet.Cells["B10"].PutValue(UziXlsDat);
                sheet.Cells["C2"].PutValue(UziXlsOrg);
                sheet.Cells["B12"].PutValue(UziXlsCmp);
                sheet.Cells["B14"].PutValue(UziXlsFio);
                sheet.Cells["B16"].PutValue(UziXlsBrt);
            }


            // =========================== СКРЫТЬ СТРОКИ =======================================================
            if (PosKol > 0)
            {
                for (i = 0; i < PosKol; i++)
                {
                    for (j = MasPos[i, 0]; j <= MasPos[i, 1]; j++)
                    {
                        sheet.Cells.HideRow(j);
                    }
                }
            }

            // Setting the width of the second column to 17.5
            /*
            sheet.Cells.SetColumnWidth(0, 100);
            sheet.Cells.SetColumnWidth(1, 100);
            sheet.Cells.SetColumnWidth(2, 100);
            sheet.Cells.SetColumnWidth(3, 40);
            sheet.Cells.SetColumnWidth(4, 40);
            sheet.Cells.SetColumnWidth(5, 40);
            sheet.Cells.SetColumnWidth(6, 40);
            */

            //       GridWeb1.WorkSheets.RemoveAt(1);
            //      GridWeb1.WorkSheets.RemoveAt(2);
            //       GridWeb1.WorkSheets.RemoveAt(3);
            //       parXlsFil.Value = UziXlsImg + ".xls";
            this.GridWeb1.WebWorksheets.SaveToExcelFile(XlsFil);
        }
        else
        {
            parXlsFil.Value = UziXlsImg;
            GridWeb1.ImportExcelFile(UziXlsImg);

            //Accessing the active sheet
            GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

            // =========================== ПОКАЗАТЬ СТРОКИ =======================================================
            if (AmbUslKod == 3896) i = 150;
            if (AmbUslKod == 3897) i = 355;

            for (j = 0; j <= i; j++)
            {
                sheet.Cells.UnhideRow(j);
            }

            // =========================== СКРЫТЬ СТРОКИ =======================================================

            if (PosKol > 0)
            {
                for (i = 0; i < PosKol; i++)
                {
                    for (j = MasPos[i, 0]; j <= MasPos[i, 1]; j++)
                    {
                        sheet.Cells.HideRow(j);
                    }
                }
            }


        }


    }

    //===============================================================================================================

    protected void GridWeb1_SaveCommand(object sender, EventArgs e)
    {

        // Saves to the file.
        //      this.GridWeb1.SaveToExcelFile(filename, GridSaveFormat.Excel2007);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value);
        //   this.GridWeb1.WebWorksheets.SaveToExcelFile(filenamePdf, GridSaveFormat.PDF);
        /*
        */
    }

    // For complete examples and data files, please go to https://github.com/aspose-cells/Aspose.Cells-for-.NET
    // Event Handler for CellDoubleClick event
    protected void GridWeb1_CellDoubleClick(object sender, Aspose.Cells.GridWeb.CellEventArgs e)
    {
        // Displaying the name of the cell (that is double clicked) in GridWeb's Message Box
     //   string msg = "You just clicked <";
     //   msg += "Row: " + (e.Cell.Row + 1) + " Column: " + (e.Cell.Column + 1) + " Cell Name: " + e.Cell.Name + ">";
   //     GridWeb1.Message = msg;
        //Accessing the active sheet
    }


    /*
// For complete examples and data files, please go to https://github.com/aspose-cells/Aspose.Cells-for-.NET
// Get row index entered by user
int rowIndex = Convert.ToInt16(txtRowIndex.Text.Trim());

// Get row height entered by user
int rowHeight = Convert.ToInt16(txtRowHeight.Text.Trim());

// Accessing the cells collection of the worksheet that is currently active
GridCells cells = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex].Cells;

// Resize row at specified index to specified height
cells.SetRowHeight(rowIndex, rowHeight);

        */
           //---------------------------- запись в таблицу DOCGRF о занятости --------------------------------------------
        public void UpdateDocGrf(string DocGrf)
        {
            //           int GrfIdn;
                        //Accessing the active sheet
            GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];
            sheet.Cells["A10"].PutValue(DocGrf);
        }

    // ======================================================================================
</script>
    
<body>

    <form id="form1" runat="server">

      <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
      <asp:HiddenField ID="HidAmbUslIdn" runat="server" />
      <asp:HiddenField ID="parXlsFil" runat="server" />
      <asp:HiddenField ID="parUslKod" runat="server" />
      <asp:HiddenField ID="parExl001" runat="server" />
      <asp:HiddenField ID="parExl002" runat="server" />

<%-- ============================  средний блок  ============================================ --%>
    <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
        <TopPanel HeightMin="26" HeightMax="400" HeightDefault="30">
            <Content>

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td style="width: 70%; height: 23px;">
                            <asp:TextBox ID="TxtSap" Width="95%" Height="23" runat="server"
                                Style="position: relative; font-weight: 700; font-size: large;" />
                        </td>
                        <td style="width: 25%; height: 23px;">
                            <asp:Button ID="SubmitButton" runat="server" Height="23px" Width="35%" Text="Сохранить" OnClick="GridWeb1_SubmitCommand" />
                            <asp:Button ID="Button2" runat="server"  Height="23px" Width="35%" Text="Печать" OnClientClick="Print();" />
<%--                            <asp:Button ID="ButtonV" runat="server"  Height="23px" Width="35%" Text="Голос" OnClick="Speech('GrfDig')" />--%>
                            <button id="btnFind" style="width:70px; height: 23px" onclick="Speech('GrfDig')">Голос</button>
<%--                                 <img id="start_img4" src="/Icon/Microphone.png" alt="Start"></button>--%>
                        </td>
                    </tr>

                </table>

            </Content>
        </TopPanel>
        <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
            <Content>

                <%-- ============================  шапка экрана ============================================ --%>
                <div>
                    <acw:GridWeb ID="GridWeb1" runat="server" Width="100%" Height="100%" OnSaveCommand="GridWeb1_SaveCommand"
                         OnCellSelectedClientFunction="onCellSelected" 
                         PresetStyle="Professional1" OnSubmitCommand="GridWeb1_SubmitCommand" EnableAsync="false">
                    </acw:GridWeb>
                </div>

            </Content>
        </BottomPanel>
    </obspl:HorizontalSplitter>

     <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltOneWindow" runat="server" Url="SpeechAmb.aspx?ParTxt=NotePad&Browser=Desktop" IsModal="true" ShowCloseButton="true" Status=""
             Left="200" Top="100" Height="500" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>

<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

    </form>


 
</body>
</html>
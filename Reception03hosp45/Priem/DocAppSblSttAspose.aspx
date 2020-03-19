<%@ Page Language="C#"   Inherits="OboutInc.oboutAJAXPage" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
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

        //    ------------------ ------------------------------------------------------
        function CloseWin() {
            window.opener.HandlePopupResult("Закрыть");
            self.close();
        }

        var inFormOrLink;
        $('a').live('click', function () { inFormOrLink = true; });
        $('form').bind('submit', function () { inFormOrLink = true; });

        $(window).bind("beforeunload", function () {
            return inFormOrLink ? "Do you really want to close?" : null;
        })

        //    ------------------ смена логотипа ----------------------------------------------------------
        function Print(grid) {
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

        function ExitFun() {
            var result = document.getElementById("parFulPol").value;
        //    alert("ExitFun=" + result);
        //    window.parent.HandlePopupStatus(result);
            window.opener.HandlePopupStatus(result);
        }
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string DocStsXls;
    string BuxFrm;
    string BuxKod;
    string BuxSid;
    string XlsFil;

    int i = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        DocStsXls = Convert.ToString(Request.QueryString["DocStsXls"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {
            SubmitButton.Attributes["onclick"] = "SubmitButton.updateData(); return SubmitButton.validateAll();";
            //============= Установки ===========================================================================================
            parCrdIdn.Value = AmbCrdIdn;
            parStsXls.Value = DocStsXls;

            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {
        int TekUsl;
        int UslIdn;

        string StsXlsNam = "";
        string StsXlsIin = "";
        string StsXlsImg = "";
        string MasCol = "BEH";
        string NxtCol = "CFI";
        string TekCel = "";
        string NxtCel = "";

        //if first visit this page clear GridWeb1 
        if (!IsPostBack && !GridWeb1.IsPostBack)
        {
            // LoadData();
            GridWeb1.WorkSheets.Clear();
            GridWeb1.WorkSheets.Add();
        }

        //  ==================================================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbDocStsXls", con);
        cmd = new SqlCommand("HspAmbDocStsXls", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@AmbCrdIdn", SqlDbType.VarChar).Value = AmbCrdIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbDocStsXls");

        if (ds.Tables[0].Rows.Count > 0)
        {
            StsXlsNam = Convert.ToString(ds.Tables[0].Rows[0]["XLSNAMSBL"]);
            StsXlsImg = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSXLS"]);
            StsXlsIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            //  parXlsFio.Value = StsXlsFio;
        }
        ds.Dispose();
        //            con.Close();

        //  ==================================================================================================================
        if (StsXlsImg == "")
        {
            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
            string Papka = @"C:\BASESTATUS\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            XlsFil = Papka + @"\" + StsXlsIin + "_" + Convert.ToInt32(AmbCrdIdn).ToString("D10");

            parXlsFil.Value = XlsFil+ ".xls";
            parXlsFilPdf.Value = XlsFil+ ".pdf";

            // поверить каталог, если нет создать ----------------------------------------------------------------
            if (Directory.Exists(Papka)) i = 0;
            else Directory.CreateDirectory(Papka);

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(XlsFil)) File.Delete(XlsFil);

            // скорировать скачанный файл ----------------------------------------------------------------
            string Sablon = @"C:\BASESTATUS\StatusSablon\" + StsXlsNam + ".xls";
            File.Copy(Sablon, parXlsFil.Value);

            // ЗАПИСАТЬ НА ДИСК МЕСТОПОЛОЖЕНИЕ ===========================================================================================
            SqlCommand cmdUsl = new SqlCommand("UPDATE AMBDOC SET DOCSTSXLS='" + XlsFil + "' WHERE DOCAMB=" + AmbCrdIdn, con);
            cmdUsl.ExecuteNonQuery();
            con.Close();

            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            // Imports from a excel file.
            GridWeb1.EnableAJAX = true;
            GridWeb1.ImportExcelFile(XlsFil + ".xls");

            //Accessing the active sheet
            //   GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

            //Putting value to "A1" cell
            //   sheet.Cells["B2"].PutValue(StsXlsOrg);
            //   sheet.Cells["B5"].PutValue(StsXlsDat.Substring(0,10));
            //   sheet.Cells["B6"].PutValue(StsXlsFio);
            //     sheet.Cells["B7"].PutValue(StsXlsBrt.Substring(0,10));
            //   if (StsXlsBrt.Length > 9) sheet.Cells["B7"].PutValue(StsXlsBrt.Substring(0,10));

            //Create a Style 
            //       sheet.SetReadonlyRange(1,1,10,1);
            //     sheet.AutoFitColumn(2, 39, 41);
            //      sheet.Cells[39,1].Style.Wrap = true;
            //   sheet.Cells[39,0].Style.Wrap = true;
            //     WebCell cell = sheet.Cells[39,2];

            /*
            GridCell cell = sheet.Cells["A20"];
            var style = cell.Style;

            // Setting font, color and alignment of cell
            //   style.Font.Size = new FontUnit("12pt");
            //    style.Font.Bold = true;
            style.ForeColor = System.Drawing.Color.Blue;
            style.BackColor = System.Drawing.Color.Aqua;
            style.IsLocked = true;
            style.Wrap = true;
            //    style.HorizontalAlign = HorizontalAlign.Center;
            */

            //        GridWeb1.WorkSheets.RemoveAt(1);
            //         GridWeb1.WorkSheets.RemoveAt(2);
            //         GridWeb1.WorkSheets.RemoveAt(3);
        }
        else
        {
            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            //      BoxStx.Enabled = false;
            //      BoxUsl.Enabled = false;

            parXlsFil.Value = StsXlsImg + ".xls";
            parXlsFilPdf.Value = StsXlsImg + ".pdf";
            GridWeb1.ImportExcelFile(parXlsFil.Value);
        }

        GridWorksheetCollection sheets = GridWeb1.WorkSheets;
        // Sets cell validation.
        GridValidationCollection gridValidationCollection = sheets[0].Validations;

        GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

        GridCells cells = GridWeb1.WorkSheets[0].Cells;

        //       GridValidation B7 = gridValidationCollection.Add();
        //       B7.AddACell("B7");
        //       B7.ValidationType = GridValidationType.CheckBox;
        // =========================== СКРЫТЬ СТРОКИ =======================================================
        for (int j = 0; j <= 2; j++)
        {
            for (int i = 1; i < cells.MaxRow+1; i++)
            {
                //Set the value of the cell and its style
                TekCel=MasCol.Substring(j,1)+Convert.ToString(i);
                GridCell cell = sheet.Cells[TekCel];
                cell = sheet.Cells[TekCel];
                if (cell.StringValue == "true" || cell.StringValue == "false" || cell.StringValue == "FALSE" ||
                    cell.StringValue == "TRUE" || cell.StringValue == "ЛОЖЬ"  || cell.StringValue == "ИСТИНА")
                {
                    GridValidation BX = gridValidationCollection.Add();
                    BX.AddACell(TekCel);
                    BX.ValidationType = GridValidationType.CheckBox;
                    if (cell.StringValue == "true" || cell.StringValue == "TRUE" || cell.StringValue == "ИСТИНА")
                    {
                        cell.Value = true;
                        //       GridCell cell = sheet.Cells["A20"];
                        NxtCel = NxtCol.Substring(j, 1) + Convert.ToString(i);
                        GridCell Ncell = sheet.Cells[NxtCel];
                        //     Ncell = sheet.Cells[NxtCel];
                        var style = Ncell.Style;

                        style.BackColor = System.Drawing.Color.Orange;
                        //   style.ForeColor = System.Drawing.Color.Aqua;
                        // Set the cell style
                        Ncell.CopyStyle(style);
                    }
                    else cell.Value = false;
                }
            }
        }
    }

    //===============================================================================================================

    // ============================ чтение заголовка таблицы а оп ==============================================
    void Refresh()
    {
        int TekUsl;
        int UslIdn;

        string StsXlsNam = "";
        string StsXlsIin = "";
        string StsXlsImg = "";
        string MasCol = "BEH";
        string NxtCol = "CFI";
        string TekCel = "";
        string NxtCel = "";

        //if first visit this page clear GridWeb1 
            // LoadData();
//            GridWeb1.WorkSheets.Clear();
//            GridWeb1.WorkSheets.Add();

            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            // Imports from a excel file.
 //           GridWeb1.EnableAJAX = true;
 //           GridWeb1.ImportExcelFile(XlsFil + ".xls");

//            parXlsFil.Value = StsXlsImg + ".xls";
//            parXlsFilPdf.Value = StsXlsImg + ".pdf";
            GridWeb1.ImportExcelFile(parXlsFil.Value);

        GridWorksheetCollection sheets = GridWeb1.WorkSheets;
        // Sets cell validation.
        GridValidationCollection gridValidationCollection = sheets[0].Validations;
        GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];
        GridCells cells = GridWeb1.WorkSheets[0].Cells;

        // =========================== СКРЫТЬ СТРОКИ =======================================================
        for (int j = 0; j <= 2; j++)
        {
            for (int i = 1; i < cells.MaxRow+1; i++)
            {
                //Set the value of the cell and its style
                TekCel=MasCol.Substring(j,1)+Convert.ToString(i);
                GridCell cell = sheet.Cells[TekCel];
                cell = sheet.Cells[TekCel];
                if (cell.StringValue == "true" || cell.StringValue == "false" || cell.StringValue == "FALSE" ||
                    cell.StringValue == "TRUE" || cell.StringValue == "ЛОЖЬ"  || cell.StringValue == "ИСТИНА")
                {
                    GridValidation BX = gridValidationCollection.Add();
                    BX.AddACell(TekCel);
                    BX.ValidationType = GridValidationType.CheckBox;
                    if (cell.StringValue == "true" || cell.StringValue == "TRUE" || cell.StringValue == "ИСТИНА")
                    {
                        cell.Value = true;
                        //       GridCell cell = sheet.Cells["A20"];
                        NxtCel = NxtCol.Substring(j, 1) + Convert.ToString(i);
                        GridCell Ncell = sheet.Cells[NxtCel];
                        //     Ncell = sheet.Cells[NxtCel];
                        var style = Ncell.Style;

                        style.BackColor = System.Drawing.Color.Orange;
                        //   style.ForeColor = System.Drawing.Color.Aqua;
                        // Set the cell style
                        Ncell.CopyStyle(style);
                    }
                    else cell.Value = false;
                }
            }
        }
    }
    //===============================================================================================================


    protected void GridWeb1_SaveCommand(object sender, EventArgs e)
    {
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value);
    }

    protected void GridWeb1_SubmitCommand_OLD(object sender, EventArgs e)
    {
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2003);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFilPdf.Value, GridSaveFormat.PDF);
    }


    protected void GridWeb1_SubmitCommand(object sender, EventArgs e)
    {
        string MasCol = "BEH";
        string NxtCol = "CFI";
        string TekCel = "";
        string NxtCel = "";
        string FulPol = "";
        string PrtPol = "";
        int N = 0;


        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFil.Value, GridSaveFormat.Excel2003);
        this.GridWeb1.WebWorksheets.SaveToExcelFile(parXlsFilPdf.Value, GridSaveFormat.PDF);

        //   GridWeb1.ImportExcelFile(parXlsFil.Value);

        GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];
        GridWorksheetCollection sheets = GridWeb1.WorkSheets;
        // Sets cell validation.
        GridValidationCollection gridValidationCollection = sheets[0].Validations;

        GridCells cells = GridWeb1.WorkSheets[0].Cells;

        // =========================== СКРЫТЬ СТРОКИ =======================================================
        for (int j = 0; j <= 2; j++)
        {
            for (int i = 1; i < cells.MaxRow+1; i++)
            {
                //Set the value of the cell and its style
                TekCel=MasCol.Substring(j,1)+Convert.ToString(i);
                GridCell cell = sheet.Cells[TekCel];
                cell = sheet.Cells[TekCel];
                var style = cell.Style;

                if (cell.StringValue.Length > 0)
                {
                    if (style.Font.Size == 11)
                    {
                        if (N > 0) FulPol = FulPol + PrtPol;
                        PrtPol = cell.StringValue + ": ";
                        N = 0;
                    }
                    else
                    {
                        NxtCel = NxtCol.Substring(j, 1) + Convert.ToString(i);
                        GridCell Ncell = sheet.Cells[NxtCel];

                        if (cell.StringValue == "true" || cell.StringValue == "TRUE" || cell.StringValue == "ИСТИНА")
                        {
                            N = N + 1;
                            PrtPol = PrtPol + Ncell.StringValue + "; ";
                        }
                        else
                        {
                            if (cell.StringValue != "false" && cell.StringValue != "FALSE" && cell.StringValue != "ЛОЖЬ")
                            {
                               N = N + 1;
                               if (Ncell.StringValue.Length > 0) PrtPol = PrtPol + cell.StringValue + ": " + Ncell.StringValue + "; ";
                               else  PrtPol = PrtPol + cell.StringValue + "; ";
                            }
                        }
                    }
                }

            }  // i
        }      // j

        parFulPol.Value = FulPol;
        //      Page.ClientScript.RegisterStartupScript(this.GetType(), "JsFunc", "javascript:alert('" + parFulPol.Value + "');",true);

        ExecOnLoad("ExitFun();");
        //     Page.ClientScript.RegisterStartupScript(this.GetType(),"CallMyFunction","ExitFun()",true);
        //     ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:ExitFun(); ", true);
        Refresh();
    }
    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parStsXls" runat="server" />
        <asp:HiddenField ID="parFulPol" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parXlsFio" runat="server" />
        <asp:HiddenField ID="parXlsFil" runat="server" />
        <asp:HiddenField ID="parXlsFilPdf" runat="server" />
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
                            <td style="width: 13%; height: 30px;">
                                <asp:Button ID="SubmitButton" runat="server" Width="45%" Text="Сохранить" OnClick="GridWeb1_SubmitCommand" />
                                <asp:Button ID="Button2" runat="server" Width="45%" Text="Печать" OnClientClick="Print();" />
                            </td>

                            <td style="width: 6%; height: 30px;">
                                <asp:Button ID="Button3" runat="server" Width="100%" Text="Образ" OnClientClick="WebCam();" />
                            </td>

                            <td style="width: 10%; height: 30px;">
                                <asp:Button ID="Button1" runat="server" Width="100%" Text="Закрыть" OnClientClick="CloseWin();" />
                            </td>

                             <td style="width: 20%; height: 30px;">
                            </td>
                            <td style="width: 45%; height: 30px;">
                            </td>
                            <td style="width: 15%; height: 30px;">
                            </td>
                       </tr>

                    </table>
                </Content>
            </TopPanel>
            <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                <Content>

                    <div>
                        <acw:GridWeb ID="GridWeb1" runat="server" Width="100%" Height="100%" OnSaveCommand="GridWeb1_SaveCommand"
                            PresetStyle="Professional1" OnSubmitCommand="GridWeb1_SubmitCommand" EnableAsync="false">
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



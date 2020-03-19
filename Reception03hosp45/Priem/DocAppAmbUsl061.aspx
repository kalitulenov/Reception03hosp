<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Mstr0000.Master" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="acw" Namespace="Aspose.Cells.GridWeb" Assembly="Aspose.Cells.GridWeb" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Aspose.Cells.GridWeb.Data" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ============================  JAVA ============================================ --%>

    <%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
         //    ------------------ смена логотипа ----------------------------------------------------------
         function Print(grid) {
             //Get Id of GridWeb
             var grid = document.getElementById("<%= GridWeb1.ClientID %>");
             //Call print
             grid.print();
         }

         function SaveGrid() {
             //Get Id of GridWeb

        //     alert("SaveGrid");
             var grid = document.getElementById("<%= GridWeb1.ClientID %>");
      //       grid = document.getElementById("_ctl0_MainContent_GridWeb1");
       //      alert("grid =" + grid);
             grid.updateData(true);
         }
 </script>

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
    string GlvDocTyp;
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
        //        AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        AmbUslKod = Convert.ToInt32(Request.QueryString["AmbUslKod"]);
        AmbUslNam = Convert.ToString(Request.QueryString["AmbUslNam"]);

        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        if (!Page.IsPostBack)
        {
            SubmitButton.Attributes["onclick"] = "SaveGrid();";
            //============= Установки ===========================================================================================
            TxtSap.Text = AmbUslNam;
            HidAmbUslIdn.Value = AmbUslIdn;
            getHidRow();
            getGrid();
        }

    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getHidRow()
    {
        int i = 0;
        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("SELECT SprMedFrmUsl.SprMedUslBeg,SprMedFrmUsl.SprMedUslEnd " +
                                        "FROM AMBCRD INNER JOIN SprBuxKdr ON AMBCRD.GrfKod=SprBuxKdr.BuxKod " +
                                                    "INNER JOIN SprMedFrmUsl ON SprBuxKdr.DLGKOD=SprMedFrmUsl.SprMedUslDlg " +
                                                    "INNER JOIN SprMedFrm ON SprMedFrmUsl.SprMedUslKod=SprMedFrm.SprMedFrmKod " +
                                        "WHERE AMBCRD.GrfIdn=" + AmbCrdIdn + " AND SprMedFrm.SprMedFrmKodPrc=" + AmbUslKod, con);

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

        string UziXlsNam = "";
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

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        //     if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        //     else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        //if first visit this page clear GridWeb1 
        if (!IsPostBack && !GridWeb1.IsPostBack)
        {
            // LoadData();
            GridWeb1.WorkSheets.Clear();
            GridWeb1.WorkSheets.Add();
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
        cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = HidAmbUslIdn.Value;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmb061One");

        if (ds.Tables[0].Rows.Count > 0)
        {
            UziXlsNam = Convert.ToString(ds.Tables[0].Rows[0]["MEDFRMNAM"]);
            UziXlsImg = Convert.ToString(ds.Tables[0].Rows[0]["MEDFRMNAMXLS"]);
            UziXlsOrg = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);
            UziXlsAdr = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTADR"]);
            UziXlsCmp = Convert.ToString(ds.Tables[0].Rows[0]["ORGCMPTXT"]);
            UziXlsDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFDAT"]);
            UziXlsFio = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            UziXlsIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            UziXlsBrt = Convert.ToString(ds.Tables[0].Rows[0]["GRFBRT"]);
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
            XlsFil = Papka + @"\" + UziXlsIin + "_" + Convert.ToInt32(HidAmbUslIdn.Value).ToString("D10") + ".xls";
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
            string Sablon = @"C:\BASEMEDFORM\MedFormSablon\" + UziXlsNam + ".xls";
            File.Copy(Sablon, XlsFil);

            //        sheet.SaveToHtml(XlsFil);

            // ЗАПИСАТЬ НА ДИСК МЕСТОПОЛОЖЕНИЕ ===========================================================================================
            SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLIG1='',USLXLS='" + XlsFil + "' WHERE USLIDN=" + HidAmbUslIdn.Value, con);
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
            this.GridWeb1.WebWorksheets.SaveToExcelFile(XlsFil);
        }
        else
        {
            parXlsFil.Value = UziXlsImg;
            GridWeb1.ImportExcelFile(UziXlsImg);
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

    // ======================================================================================
</script>

      <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
      <asp:HiddenField ID="HidAmbUslIdn" runat="server" />
      <asp:HiddenField ID="parXlsFil" runat="server" />
      <asp:HiddenField ID="parUslKod" runat="server" />

<%-- ============================  средний блок  ============================================ --%>
                               
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 75%; height: 30px;">
                        <asp:TextBox ID="TxtSap" Width="100%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: large;" />
                    </td>
                  <td style="width: 25%; height: 30px;">
                     <asp:Button ID="SubmitButton" runat="server"  Width="45%" Text="Сохранить" OnClick="GridWeb1_SubmitCommand" />
                     <asp:Button ID="Button2" runat="server"  Width="45%" Text="Печать" OnClientClick="Print();" />
                  </td>
                </tr>

            </table>
            <%-- ============================  шапка экрана ============================================ --%>
      <div>
            <acw:GridWeb ID="GridWeb1" runat="server" Width="100%" Height="100%" OnSaveCommand="GridWeb1_SaveCommand"
                 PresetStyle="Professional1" OnSubmitCommand="GridWeb1_SubmitCommand" EnableAsync="false">
            </acw:GridWeb>
     </div>

<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
  
</asp:Content>

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
       //     alert('My Window is reloading');
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
        function onChange(sender, newText) {
 //           alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
//            var QueryString = getQueryString();
//            var DatDocIdn = QueryString[1];
            var DatDocIdn = document.getElementById('parUslIdn').value;

            var SqlStr = "";


            switch (sender) {
                case 'TxtNap':
 //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBUSL SET USLNAP=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtLgt':
                    if (DatDocVal == null || DatDocVal == "" || DatDocVal <= "0" || DatDocVal > "99") {
               //         alert("DatDocVal=" + DatDocVal + " " + TxtZen.value);
                        SqlStr = "UPDATE AMBUSL SET USLLGT=0,USLSUM=USLZEN WHERE USLIDN=" + DatDocIdn;
              //          alert("DatDocVal2=" + DatDocVal + " " + TxtZen.value);
                        TxtSum.value = TxtZen.value;
                    }
                    else
                        SqlStr = "UPDATE AMBUSL SET USLLGT=" + DatDocVal + ",USLSUM=(100-" + DatDocVal + ")*USLZEN/100 WHERE USLIDN=" + DatDocIdn;
                    TxtSum.value = Math.round(TxtSum.value * (100-TxtLgt.value)/100);
                    break;
                case 'TxtSum':
                    SqlStr = "UPDATE AMBUSL SET USLSUM=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'Dig003':
                    DatDocIdn = DigIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                case 'Dsp003':
                    DatDocIdn = OpsIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                case 'Lch003':
                    DatDocIdn = ZakIdn.value;
                    SqlStr = "UPDATE AMBUSLDTL SET USLDTLVAL='" + DatDocVal + "' WHERE USLDTLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
//                  alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parUslIdn').value;

            switch (sender.ID) {
                case 'BoxNoz':
                    DatDocVal = BoxNoz.options[BoxNoz.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLNOZ=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'BoxKto':
                    DatDocVal = BoxKto.options[BoxKto.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLKTO=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
   //                           alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });

        }

        //    ---------------- обращение веб методу --------------------------------------------------------
        function WebCam() {
            //           alert("GridAnl_ClientEdit");
            var AmbAnlIdn = document.getElementById('parUslIdn').value;
            var AmbAnlPth = document.getElementById('parXlsFio').value;
            AnlWindow.setTitle(AmbAnlPth);
            AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslPth=" + AmbAnlPth);
            AnlWindow.Open();
            return false;
        }

        window.onbeforeunload = function () {
            alert("unload");
        }

 /*       
        function onCellUpdated(cell, isOriginal) {
               alert("cell3=" + cell.id);
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
            var znach = grid.getCellValueByCell(cell);
            alert("*" + znach + "*");
            grid.setCellValue(row, col, grid.getCellValueByCell(cell));   // изменеие ячейки в JAVE
        }
 */

        function onCellSelected(cell, isOriginal) {
            
            var grid = document.getElementById("mySpl_ctl01_ctl01_GridWeb1");
     //       alert("cell2=" + cell.id);
/*
            var PrvRow = document.getElementById("parExl001").value;
            var x = (typeof PrvRow !== 'string') ? String(PrvRow) : PrvRow;
            if (x == null || x == "") {
     //           alert("cell2=" + cell);
            }
            else {
                var x = document.getElementById("parExl001").value;
                var y = document.getElementById("parExl002").value;

                var PrvVal = grid.getCellValue(x, y);
            //    alert("PrvPol=" + PrvVal + " l=" + PrvVal.length+" x="+x + " y=" + y);

                if (PrvVal.length == 0) {
              //      alert("PrvPol=" + PrvVal + " l=" + PrvVal.length + " x=" + x + " y=" + y);
                    grid.setCellValue(x, y, ".................");
                }
            }
*/
            var row = grid.getCellRow(cell);
            var col = grid.getCellColumn(cell);

            document.getElementById("parExl001").value = row;
            document.getElementById("parExl002").value = col;
        }

        function MyOnPageChange(index) {
            alert("current page is:" + index);
        //    console.log("current page is:" + index);
        }
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
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
        if (AmbUslIdn == "0") AmbUziTyp = "ADD";
        else AmbUziTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbUslIdn ", AmbUslIdn);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";


        if (!Page.IsPostBack)
        {
            //          TxtNap.Attributes.Add("onchange", "onChange('TxtNap',TxtNap.value);");
            //       TxtLgt.Attributes.Add("onchange", "onChange('TxtLgt',TxtLgt.value);");
            TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
            //       SubmitButton.Attributes.Add("onclick", "onclick();");

            /*          
          //Adding javascript function to onclick attribute of Button control
          SubmitButton.Attributes["onclick"] = GridWeb1.ClientID +
                                      ".updateData(); if (" +
                                      GridWeb1.ClientID +
                                      ".validateAll()) return true; else return false;";
          */

            SubmitButton.Attributes["onclick"] = "SubmitButton.updateData(); return SubmitButton.validateAll();";
            //============= Установки ===========================================================================================
            //       AmbUslIdnTek = (string)Session["AmbUslIdn"];
            //       if (AmbUslIdnTek != "Post")
            //       {
            if (AmbUslIdn == "0")  // новый документ
            {

                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspAmbUslWinAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@USLIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    AmbUslIdn = Convert.ToString(cmd.Parameters["@USLIDN"].Value);
                }
                finally
                {
                    con.Close();
                }
                //         }
            }

            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;

            getDocNum();
            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("SELECT AMBUSL.USLKOD,AMBUSL.USLNOZ,AMBUSL.USLSTX,AMBUSL.USLLGT,AMBUSL.USLSUM,AMBUSL.USLNAP,AMBUSL.USLZEN," +
                                               "SprUsl.UslNam,SprUzi.SprUziNam," +
                                               "SprUzi.SprUziLen001,SprUzi.SprUziLen002,SprUzi.SprUziLen003," +
                                               "SprUzi.SprUziLen004,SprUzi.SprUziLen005,SprUzi.SprUziLen006 " +
                                        "FROM AMBUSL LEFT OUTER JOIN SprUsl ON AMBUSL.USLKOD=SprUsl.UslKod " +
                                                    "LEFT OUTER JOIN SprUzi ON AMBUSL.USLLAB=SprUzi.SprUziKod " +
                                        "WHERE AMBUSL.USLIDN=" + AmbUslIdn, con);        // указать тип команды

        /*     
        SqlCommand cmd = new SqlCommand("SELECT AMBUSL.USLKOD,AMBUSL.USLNOZ,AMBUSL.USLSTX,AMBUSL.USLLGT,AMBUSL.USLSUM,AMBUSL.USLNAP,AMBUSL.USLZEN,SprUsl.UslNam,SprOleXls.xlsNAM " + 
                                        "FROM  AMBUSL INNER JOIN SprOleXls ON AMBUSL.USLLAB=SprOleXls.XLSKOD " +
                                                     "LEFT OUTER JOIN SprUsl ON AMBUSL.USLKOD=SprUsl.UslKod " +
                                        "WHERE AMBUSL.USLIDN=" + AmbUslIdn, con);        // указать тип команды
        */
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "UziOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            // ============================================================================================
            sdsUsl.SelectCommand = "HspAmbUslKodSou";
            sdsUsl.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            sdsUsl.SelectParameters.Clear();
            Parameter par1 = new Parameter("BUXFRMKOD", TypeCode.String, BuxFrm);
            par1.Size = 10;
            sdsUsl.SelectParameters.Add(par1);
            Parameter par2 = new Parameter("BUXKOD", TypeCode.String, BuxKod);
            par2.Size = 10;
            sdsUsl.SelectParameters.Add(par2);
            Parameter par3 = new Parameter("USLSTX", TypeCode.String, Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]));
            par3.Size = 10;
            sdsUsl.SelectParameters.Add(par3);
            Parameter par4 = new Parameter("AMBCRDIDN", TypeCode.String, AmbCrdIdn);
            par4.Size = 10;
            sdsUsl.SelectParameters.Add(par4);
            Parameter par5 = new Parameter("AMBUSLIDN", TypeCode.String, AmbUslIdn);
            par5.Size = 10;
            sdsUsl.SelectParameters.Add(par5);
            sdsUsl.DataBind();                    //???
            BoxUsl.Items.Clear();
            BoxUsl.DataBind();
            // ============================================================================================

            //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZINAM"]);
            BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]);
            BoxUsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);
            //          BoxNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLNOZ"]);
            //          TxtNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAP"]);
            //       TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLLGT"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLSUM"]);
            TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLZEN"]);
            //         Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAM"]);

        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            BoxUsl.SelectedValue = "";
        }

        parUslKod.Value = BoxUsl.SelectedValue;

    }



    // ============================ чтение заголовка таблицы а оп ==============================================

    //------------------------------------------------------------------------
    protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string TekStx;
        int TekUsl;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
        cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
        cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
        cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        //===============================================================================================================

        getDocNum();

        //      GetGrid();
    }

    //------------------------------------------------------------------------
    protected void BoxUsl_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int TekUsl;
        string TekStx;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (parUslKod.Value == BoxUsl.SelectedValue) return;


        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        if (TekUsl > 0)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
            cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
            cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
            cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            //===============================================================================================================

            getDocNum();

            GetGrid();
        }
    }
    //------------------------------------------------------------------------

    void GetGrid()
    {
        int TekUsl;
        string UziXlsNam = "";
        string UziXlsImg = "";
        string UziXlsOrg = "";
        string UziXlsAdr = "";
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

        int startCell = 0;
        int StartRow = 0;
        int EndColumn = 0;
        int EndRow = 0;

        double ColWdt = 0;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

        //if first visit this page clear GridWeb1 
        if (!IsPostBack && !GridWeb1.IsPostBack)
        {
            // LoadData();
            GridWeb1.WorkSheets.Clear();
            GridWeb1.WorkSheets.Add();
        }


        if (TekUsl > 0)
        {

            //  ==================================================================================================================
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmd = new SqlCommand("HspAmbUziOneDtlSpire", con);
            cmd = new SqlCommand("HspAmbUziOneDtlSpire", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbUziOneDtlSpire");

            if (ds.Tables[0].Rows.Count > 0)
            {
                UziXlsNam = Convert.ToString(ds.Tables[0].Rows[0]["XLSNAMSBL"]);
                UziXlsImg = Convert.ToString(ds.Tables[0].Rows[0]["UZINAMXLS"]);
                UziXlsOrg = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);
                UziXlsAdr = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTADR"]);
                UziXlsDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFDAT"]);
                UziXlsFio = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
                UziXlsIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
                UziXlsBrt = Convert.ToString(ds.Tables[0].Rows[0]["GRFBRT"]);
                UziXlsDoc = Convert.ToString(ds.Tables[0].Rows[0]["GRFDOC"]);

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
                string Papka = @"C:\BASEUZI\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
                XlsFil = Papka + @"\" + UziXlsIin + "_" + Convert.ToInt32(AmbUslIdn).ToString("D10");
                parXlsFil.Value = XlsFil + ".xls";
                parXlsFilPdf.Value = XlsFil + ".pdf";
                UziXlsImg = XlsFil;

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
                string Sablon = @"C:\BASEUZI\UziSablon\" + UziXlsNam + ".xls";
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
                // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
                //           BoxStx.Enabled = false;
                //           BoxUsl.Enabled = false;

                parXlsFil.Value = UziXlsImg + ".xls";
                parXlsFilPdf.Value = UziXlsImg + ".pdf";
                GridWeb1.ImportExcelFile(parXlsFil.Value);
            }

            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            BoxStx.Enabled = false;
            BoxUsl.Enabled = false;

            //     parXlsFil.Value = UziXlsImg + ".xls";
            //     parXlsFilPdf.Value = UziXlsImg + ".pdf";
            //     GridWeb1.ImportExcelFile(parXlsFil.Value);

            // ПОКАЗАТЬ ДЛЯ КОРРЕКТИРОВКИ =================================================================================
            // Imports from a excel file.
            GridWeb1.EnableAJAX = true;

            //Accessing the active sheet
            GridWorksheet sheet = GridWeb1.WorkSheets[GridWeb1.ActiveSheetIndex];

            //Putting value to "A1" cell
            sheet.Cells["B6"].PutValue(UziXlsDat.Substring(0, 10));
            sheet.Cells["B2"].PutValue(UziXlsOrg);
            sheet.Cells["B7"].PutValue(UziXlsFio);

            if (UziXlsBrt.Length > 9) sheet.Cells["B8"].PutValue(UziXlsBrt.Substring(0, 10));

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
                    Aspose.Cells.GridWeb.GridTableItemStyle cellstyle = sheet.Cells[i, j].Style;
                    //      cellstyle.Font.Size = new FontUnit("10pt");
                    //    cellstyle.Font.Bold = true;
                    //    cellstyle.HorizontalAlign = HorizontalAlign.Center;
                    //    cellstyle.BorderWidth = 1;
                    cellstyle.Wrap = true;
                    //sheet.Cells[i, j].Style = cellstyle;

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
           //         }
           //         else
           //         {
                        // Finally, Setting selected cells of the worksheet to Readonly
            //            sheet.SetReadonlyRange(i, j, 1, 1);
            //        }


                }   ///// JJJJJJJJJJJJJJJJJJ
                    //cells.SetRowHeight(i, 17 * (L * 1.1 / ColWdt + 1));
                if (KolColFin > 0) cells.SetRowHeight(i, 17 * (KolColFin * 1.8 + 1));
                else cells.SetRowHeight(i, 17);

            }  // IIII


        }   // if (TekUsl > 0)
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
                //cells.SetRowHeight(i, 17 * (L * 1.1 / ColWdt + 1));
            if (KolColFin > 0) cells.SetRowHeight(i, 17 * (KolColFin * 1.3 + 1));
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
                            <td style="width: 20%; height: 30px;">
                                <asp:Label ID="Label1" Text="СТРАХ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <obout:ComboBox runat="server"
                                    AutoPostBack="true"
                                    ID="BoxStx"
                                    Width="65%"
                                    Height="200"
                                    EmptyText="Выберите услугу ..."
                                    FolderStyle="/Styles/Combobox/Plain"
                                    OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"
                                    DataSourceID="sdsStx"
                                    DataTextField="StxNam"
                                    DataValueField="StxKod" />
                            </td>
                            <td style="width: 45%; height: 30px;">
                                <asp:Label ID="Label6" Text="УСЛУГА:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                                <obout:ComboBox runat="server"
                                    AutoPostBack="true"
                                    ID="BoxUsl"
                                    Width="80%"
                                    Height="200"
                                    EmptyText="Выберите услугу ..."
                                    FolderStyle="/Styles/Combobox/Plain"
                                    OnSelectedIndexChanged="BoxUsl_OnSelectedIndexChanged"
                                    DataSourceID="sdsUsl"
                                    DataTextField="USLNAM"
                                    DataValueField="USLKOD" />
                            </td>
                            <td style="width: 15%; height: 30px;">
                                <asp:TextBox ID="TxtZen" Width="0%" Height="20" runat="server" Style="position: relative; display: none; font-weight: 700; font-size: medium;" />

                                <asp:Label ID="Label4" Text="СУММА:" runat="server" Width="40%" Font-Bold="true" Font-Size="Medium" />
                                <asp:TextBox ID="TxtSum" Width="55%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
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



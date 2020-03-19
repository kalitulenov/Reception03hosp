<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>

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
        //    ------------------ смена логотипа ----------------------------------------------------------
        /*------------------------- при нажатии на поле текст --------------------------------*/
        /*------------------------- при выходе запомнить Идн --------------------------------*/

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
                    TxtSum.value = Math.round(TxtSum.value * (100 - TxtLgt.value) / 100);
                    break;
                case 'TxtSum':
                    SqlStr = "UPDATE AMBUSL SET USLSUM=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtImg001':
                    SqlStr = "UPDATE AMBUSL SET USLIG1='" + DatDocVal + "' WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtImg002':
                    SqlStr = "UPDATE AMBUSL SET USLIG2='" + DatDocVal + "' WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtImg003':
                    SqlStr = "UPDATE AMBUSL SET USLIG3='" + DatDocVal + "' WHERE USLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
  //          alert("SqlStr=" + SqlStr);

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

        //  -------------------------------------------------------------------------------------------------
        function Del001(Num) {
     //        alert("onChangeJlb="+Num);
            if (confirm("Уверены, что хотите удалить?")) {  }
            else return;

    //        alert("onChangeJlb=");

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
 //           var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parUslIdn').value;
   //         alert("SqlStr=" + SqlStr);

            var SqlStr = "UPDATE AMBUSL SET USLIG" + Num +"='' WHERE USLIDN=" + DatDocIdn;
   //         alert("SqlStr=" + SqlStr);

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
                case 'BoxLab':
                    DatDocVal = BoxLab.options[BoxLab.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLBINGDE='" + DatDocVal + "' WHERE USLIDN=" + DatDocIdn;
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

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBUSLDTL';
            var DatDocKey = 'USLDTLIDN';

            SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
            //           alert("SqlStr=" + SqlStr);

            //          alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
            switch (DatDocTyp) {
                case 'Sql':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                case 'Str':
                    DatDocTyp = 'Str';
                    SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                    break;
                case 'Dat':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                case 'Int':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                default:
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
            }
            //           alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
        }


        function Sho001(Num) {
 //           alert("ButSho001");
            var AmbAnlIdn = document.getElementById('parUslIdn').value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num, "ModalPopUp", "toolbar=no,width=1200,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

/*
            ShoWindow.setTitle(AmbAnlIdn);
            ShoWindow.setUrl("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum="+Num);
            ShoWindow.Open();
*/
            return false;
        }



    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslIdnTek;
    string AmbAnlTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        if (AmbUslIdn == "0") AmbAnlTyp = "ADD";
        else AmbAnlTyp = "REP";
        
         
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbUslIdn ", AmbUslIdn);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " AND DLGTYP='ДСП'";

        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        
        sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";

        sdsLab.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsLab.SelectCommand = "SELECT ORGLABBIN,ORGLABNAMSHR FROM SPRORGLAB ORDER BY ORGLABNAMSHR";


        if (!Page.IsPostBack)
        {
            TxtNap.Attributes.Add("onchange", "onChange('TxtNap',TxtNap.value);");
            TxtLgt.Attributes.Add("onchange", "onChange('TxtLgt',TxtLgt.value);");
            TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
 //           TxtImg001.Attributes.Add("onchange", "onChange('TxtImg001',TxtImg001.value);");
 //           TxtImg002.Attributes.Add("onchange", "onChange('TxtImg002',TxtImg002.value);");
//            TxtImg003.Attributes.Add("onchange", "onChange('TxtImg003',TxtImg003.value);");
            //============= Установки ===========================================================================================
             AmbUslIdnTek = (string)Session["AmbUslIdn"];
             if (AmbUslIdnTek != "Post")
             {
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
                 }
             }
            
            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;

            getDocNum();
//            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT AMBUSL.*,AMBCRD.GRFPTH FROM AMBUSL INNER JOIN AMBCRD ON AMBUSL.USLAMB=AMBCRD.GrfIdn WHERE USLIDN=" + AmbUslIdn, con);        // указать тип команды
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "AnlOneSap");

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
            //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRAnlNAM"]);
            BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]);
            BoxUsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);
            BoxLab.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLBINGDE"]);
            //            BoxNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLNOZ"]);
            BoxKto.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKTO"]);
            TxtNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAP"]);
            TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLLGT"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLSUM"]);
            TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLZEN"]);
            parGrfPth.Value = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            parUslKod.Value = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);

            if (BoxUsl.SelectedValue != "")
            {
            }

        }
        else
        {
 //           BoxTit.Text = "Новая запись";
            BoxUsl.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================
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

//        if (TekStx > 0)
//        {
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

 //           GetGrid();

  //      }
    }

    //------------------------------------------------------------------------
    protected void BoxUsl_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int TekUsl;
        string TekStx;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
        
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

  //          GetGrid();

        }
    }
    //===============================================================================================================

        // ============================ загрузка EXCEL в базу ==============================================
        protected void Import001_Click(object sender, EventArgs e)
        {
            ImportImg("1");
        }
        protected void Import002_Click(object sender, EventArgs e)
        {
            ImportImg("2");
        }
        protected void Import003_Click(object sender, EventArgs e)
        {
            ImportImg("3");
        }
        
        // ============================ загрузка EXCEL в базу ==============================================
        protected void ImportImg(string NumImg)
        {
            AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
            
//           string file=""; // the file to upload</param>
//           string host = @"ftp:\\178.162.199.27"; // the host we're uploading to</param>
//	       string username=@""; //our login username</param>
//	       string password=@""; //our login password</param>
//           string folderToUploadTo = @"C:\BASEIMG"; //the folder we're uploading to</param>
//           KeyStx = Convert.ToInt32(BoxStx.SelectedValue).ToString("D5");
            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
//            string Papka = @"C:\BASEIMG\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
//            string ImgFil = Papka + @"\" + GrfPth.Substring(0, 12) + "_" + Convert.ToInt32(TekDocIdn).ToString("D10") + ".jpg";

            parGrfPth.Value = parGrfPth.Value + "____________";

            string Papka = @"C:\BASEIMG\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");
            string ImgFil = Papka + @"\" + parGrfPth.Value.Substring(0, 12) + "_" + Convert.ToInt32(AmbUslIdn).ToString("D10") + "_" + NumImg + ".jpg";
            int i = 0;

            if (FilUpl001.FileName == "") return;
                
            System.IO.FileInfo fi = new System.IO.FileInfo(FilUpl001.FileName);
            if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0 || fi.Extension.CompareTo(".JPG") == 0 || fi.Extension.CompareTo(".JPEG") == 0)
            {
                // поверить каталог, если нет создать ----------------------------------------------------------------
                if (Directory.Exists(Papka)) i = 0;
                else Directory.CreateDirectory(Papka);

                // сформировать имя фаила ----------------------------------------------------------------
                string ServerPath = Server.MapPath("~/Temp/" + parUslIdn.Value + ".jpg");
                 // скачать фаил ----------------------------------------------------------------
                FilUpl001.PostedFile.SaveAs(ServerPath);
                
                // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(ImgFil)) File.Delete(ImgFil);
                // скорировать скачанный файл ----------------------------------------------------------------
                File.Copy(ServerPath, ImgFil);
                
                // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(ServerPath)) File.Delete(ServerPath);

                // ЗАПИСАТЬ НА ДИСК ----------------------------------------------------------------

                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLIG" + NumImg + "='" + ImgFil + "' WHERE USLIDN=" + parUslIdn.Value, con);
                cmdUsl.ExecuteNonQuery();
                con.Close();
               
          //      file = @"C:\SkoolTestAdm\" + Convert.ToString(fi);  для FTP
          //      UploadFileToFtp(file, host, username, password, folderToUploadTo);
                
  //              Response.Write("Успешно");
            }
            else
            {
                Response.Write("Тип файла не верен");
            }
         //               string path = string.Concat(Server.MapPath("~/Temp/"), FileUpload1.FileName);
                        //Save File as Temp then you can delete it if you want
         //               FileUpload1.SaveAs(path);
                        //string path = @"C:\Users\Johnney\Desktop\ExcelData.xls";
        }

        
        /// <summary>
	/// method for uyploading a file to a specified folder on an
	/// FTP server using the FtpWebRequest class
	/// </summary>
	/// <param name="file">the file to upload</param>
	/// <param name="host">the host we're uploading to</param>
	/// <param name="username">our login username</param>
	/// <param name="password">our login password</param>
	/// <param name="folderToUploadTo">the folder we're uploading to</param>
	/// <returns></returns>
	void UploadFileToFtp(string file, string host, string username, string password, string folderToUploadTo)
	{
	    try
	    {
	        //create an FtpRequest object
	        FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri(host + "/" + Path.GetFileName(folderToUploadTo)));
	        //set the method to Upload, since we're uploading a file
	        ftpRequest.Method = WebRequestMethods.Ftp.UploadFile;
	        //pass in our login credentials
	        ftpRequest.Credentials = new NetworkCredential(username, password);
	        //don't use passive mode
	        ftpRequest.UsePassive = true;
	        //unless we're uploading a file like an image
	        //we need to set this to false as we're not uploading
	        //binary data
	        ftpRequest.UseBinary = true;
	        //set KeepAlive to false
	        ftpRequest.KeepAlive = false;
	 
	        //now create a new FileStream, then open the file we're uploading
	        //this allows us to get the size of the file for our buffer
	        FileStream stream = File.OpenRead(file);
	        //create a byte[] array buffer the size of the file
	        //we're uploading
	        byte[] buffer = new byte[stream.Length];
	 
	        //read in our file into the FileStream
	        stream.Read(buffer, 0, buffer.Length);
	        //close the FileStream
	        stream.Close();
	 
	        //create a new stream, this will be used to write to the
	        //FTP server
	        Stream requestStream = ftpRequest.GetRequestStream();
	        //write the data to the FTP server
	        requestStream.Write(buffer, 0, buffer.Length);
	        //close the stream
	        requestStream.Close();
	        //since we made it this far return true
//	        return true;
	    }
	    catch (Exception ex)
	    {
	        //something went wront so let the user know
	        Response.Write("Error uploading file: " + ex.Message);
	        //return false
//	        return false;
	    }           
	}
    
                // ------------------------------------------------------------------------------заполняем второй уровень

        // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parGrfPth" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="№ НАПР:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtNap" Width="10%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label1" Text="СТРАХ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxStx"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"
                            DataSourceID="sdsStx"
                            DataTextField="StxNam"
                            DataValueField="StxKod" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label6" Text="УСЛУГА:" runat="server" Width="15%" Font-Bold="true"  Font-Size="Medium"/>
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
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label2" Text="ЛЬГОТ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtLgt" Width="10%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                            ControlToValidate="TxtLgt"
                            ValidationExpression="\d+"
                            Display="Static"
                            EnableClientScript="true"
                            ErrorMessage="*"
                            runat="server" />
                        <asp:TextBox ID="TxtZen" Width="0%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="СУММА:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtSum" Width="10%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        </br>
                        <asp:Label ID="Lbl000" Text="0.ФАЙЛ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:FileUpload ID="FilUpl001" Height="25px"  runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Label3" Text="1.ОБРАЗ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl001" runat="server" onclick="Import001_Click" Text="Загрузить 1обр" />
                        <asp:Button ID="ButDel001" runat="server" CommandName="Add" Text="Удалить 1обр" OnClientClick="Del001(1);" />
                        <asp:Button ID="ButSho001" runat="server" CommandName="Add" Text="Показать 1обр" OnClientClick="Sho001(1);" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl002" Text="2.ОБРАЗ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl002" runat="server" onclick="Import002_Click" Text="Загрузить 2обр" />
                        <asp:Button ID="ButDel002" runat="server" CommandName="Add" Text="Удалить 2обр" OnClientClick="Del001(2);" />
                        <asp:Button ID="ButSho002" runat="server" CommandName="Add" Text="Показать 2обр" OnClientClick="Sho001(2);" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl003" Text="3.ОБРАЗ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl003" runat="server" onclick="Import003_Click" Text="Загрузить 3обр" />
                        <asp:Button ID="ButDel003" runat="server" CommandName="Add" Text="Удалить 3обр" OnClientClick="Del001(3);" />
                        <asp:Button ID="ButSho003" runat="server" CommandName="Add" Text="Показать 3обр" OnClientClick="Sho001(3);" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        </br>
                        <asp:Label id="LabGde" Text="ЛАБОРАТОРИЯ:" runat="server"  Width="15%" Font-Bold="true" /> 
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxLab"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите лабораторию ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsLab"
                            DataTextField="ORGLABNAMSHR"
                            DataValueField="ORGLABBIN" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>   
                   </td>
                </tr>


                <tr>
                    <td style="width: 100%; height: 30px;""> 
                        <asp:Label ID="Label7" Text="ОТВЕТСТВЕН:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server"
                            ID="BoxKto"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsKto"
                            DataTextField="FI"
                            DataValueField="BUXKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>   
                   </td>
                </tr>

            </table>

        </asp:Panel>

    </form>

    <owd:Window ID="ShoWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
        Left="100" Top="-5" Height="450" Width="800" Visible="true" VisibleOnLoad="false" 
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="Образ">

     </owd:Window>

<%-- 
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="HspAmbUslKodSou" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
        <SelectParameters>
            <asp:SessionParameter SessionField="BUXFRMKOD" Name="BuxFrmKod" Type="String" />
            <asp:SessionParameter SessionField="BUXKOD" Name="BuxKod" Type="String" />
            <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
            <asp:SessionParameter SessionField="AMBUSLIDN" Name="AmbUslIdn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
 --%>
      
     <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsLab" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>




    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
        }

        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            width: 100%;
            font-size: 12px !important;  /* для увеличения коррект поля */
            padding-top: 4px;
            padding-bottom: 4px;
        }


        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>



</body>

</html>



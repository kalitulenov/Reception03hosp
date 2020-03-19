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
<%@ Import Namespace="System.Net.Mail" %>

<%@ Import Namespace="Aspose.Words" %>

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

        //  -------------------------------------------------------------------------------------------------
        function Del001(Num) {
         //    alert("onChangeJlb="+Num);
            if (confirm("Уверены, что хотите удалить?")) {  }
            else return;

    //        alert("onChangeJlb=");

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var SqlStr;
 //           var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parUslIdn').value;
   //         alert("SqlStr=" + SqlStr);
            if (Num == "X") SqlStr = "UPDATE AMBUSL SET USLXLS='' WHERE USLIDN=" + DatDocIdn;
            else SqlStr = "UPDATE AMBUSL SET USLIG" + Num + "='' WHERE USLIDN=" + DatDocIdn;
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
        function Sho001(Num) {
            var AmbAnlIdn = document.getElementById('parUslIdn').value;
      //      alert("AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num);
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num, "ModalPopUp", "toolbar=no,width=1200,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

//            ShoWindow.setTitle(AmbAnlIdn);
//            ShoWindow.setUrl("/Priem/DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslImgNum=" + Num);
//            ShoWindow.Open();

            return false;
        }
        

        function WebCam()
        {
        //    alert("WebCamToy");
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("https://webcamtoy.com/ru/", "ModalPopUp", "toolbar=no,width=1200,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("https://webcamtoy.com/ru/", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1200px;dialogHeight:650px;");

            return false;
        }

        //    ------------------------------------------------------------------------------------------------------------------------
        function Vis000() {
            var cboxes;
     //       var len = cboxes.length;
            for (var i = 1; i < 8; i++) {

             //   var s = document.getElementById('ChkBox00' + i);
                var x = document.getElementById("ChkBox00" + i);
                x.style.visibility = "visible";
           //    alert(i + (x.checked ? ' checked ' : ' unchecked ') + x.value);
                if (x.checked == true)
                    alert('checked'+i);
                 //   x.style.visibility = "hidden"; // or x.style.display = "none";
                else
                    alert('UNchecked'+i);
                 //   x.style.visibility = "visible"; //or x.style.display = "block";

            }
        }
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslPth;
    string AmbUslIIN;
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
        AmbUslPth = Convert.ToString(Request.QueryString["AmbUslPth"]);
        AmbUslIIN = Convert.ToString(Request.QueryString["AmbUslIIN"]);
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
            //============= Установки ===========================================================================================
            AmbUslIdnTek = (string)Session["AmbUslIdn"];

            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;
            parGrfPth.Value = AmbUslPth;
            parGrfIIN.Value = AmbUslIIN;

            //            GetGrid();
        }
        getDocNum(0);
    }

    //===============================================================================================================
    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum(int X)
    {
        int KodOrg = 0;
        int KodCnt = 0;

        string KeyOrg;
        string KeyCnt;
        int LenCnt;
        string SqlCnt;
        int NxtVis = 0;


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM AMBUSL WHERE USLIDN=@USLIDN", con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = parUslIdn.Value;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbCrdIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLXLS"].ToString())) ChkBox00X.Checked = false;
            else ChkBox00X.Checked = true;
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG1"].ToString())) ChkBox001.Checked = false;
            else ChkBox001.Checked = true;

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG2"].ToString()))
            {
                Lbl002.Visible = false;
                ButUpl002.Visible = false;
                Swo2.Visible = false;
                TxtEml002.Visible = false;
                REV02.Visible = false;
                Eml2.Visible = false;
                Del2.Visible = false;
                ChkBox002.Checked = false;
                ChkBox002.Visible = false;

                if (X == 1)
                {
                    X = 0;
                    Lbl002.Visible = true;
                    ButUpl002.Visible = true;
                    Swo2.Visible = true;
                    TxtEml002.Visible = true;
                    REV02.Visible = true;
                    Eml2.Visible = true;
                    Del2.Visible = true;
                    ChkBox002.Visible = true;
                }
            }
            else
            {
                Lbl002.Visible = true;
                ButUpl002.Visible = true;
                Swo2.Visible = true;
                TxtEml002.Visible = true;
                REV02.Visible = true;
                Eml2.Visible = true;
                Del2.Visible = true;
                ChkBox002.Visible = true;
                ChkBox002.Checked = true;
            }

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG3"].ToString()))
            {
                Lbl003.Visible = false;
                ButUpl003.Visible = false;
                Swo3.Visible = false;
                TxtEml003.Visible = false;
                REV03.Visible = false;
                Eml3.Visible = false;
                Del3.Visible = false;
                ChkBox003.Checked = false;
                ChkBox003.Visible = false;

                if (X == 1)
                {
                    X = 0;
                    Lbl003.Visible = true;
                    ButUpl003.Visible = true;
                    Swo3.Visible = true;
                    TxtEml003.Visible = true;
                    REV03.Visible = true;
                    Eml3.Visible = true;
                    Del3.Visible = true;
                    ChkBox003.Visible = true;
                }
            }
            else
            {
                Lbl003.Visible = true;
                ButUpl003.Visible = true;
                Swo3.Visible = true;
                TxtEml003.Visible = true;
                REV03.Visible = true;
                Eml3.Visible = true;
                Del3.Visible = true;
                ChkBox003.Visible = true;
                ChkBox003.Checked = true;
            }

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG4"].ToString()))
            {
                Lbl004.Visible = false;
                ButUpl004.Visible = false;
                Swo4.Visible = false;
                TxtEml004.Visible = false;
                REV04.Visible = false;
                Eml4.Visible = false;
                Del4.Visible = false;
                ChkBox004.Checked = false;
                ChkBox004.Visible = false;

                if (X == 1)
                {
                    X = 0;
                    Lbl004.Visible = true;
                    ButUpl004.Visible = true;
                    Swo4.Visible = true;
                    TxtEml004.Visible = true;
                    REV04.Visible = true;
                    Eml4.Visible = true;
                    Del4.Visible = true;
                    ChkBox004.Visible = true;
                }
            }
            else
            {
                Lbl004.Visible = true;
                ButUpl004.Visible = true;
                Swo4.Visible = true;
                TxtEml004.Visible = true;
                REV04.Visible = true;
                Eml4.Visible = true;
                Del4.Visible = true;
                ChkBox004.Visible = true;
                ChkBox004.Checked = true;
            }

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG5"].ToString()))
            {
                Lbl005.Visible = false;
                ButUpl005.Visible = false;
                Swo5.Visible = false;
                TxtEml005.Visible = false;
                REV05.Visible = false;
                Eml5.Visible = false;
                Del5.Visible = false;
                ChkBox005.Checked = false;
                ChkBox005.Visible = false;

                if (X == 1)
                {
                    X = 0;
                    Lbl005.Visible = true;
                    ButUpl005.Visible = true;
                    Swo5.Visible = true;
                    TxtEml005.Visible = true;
                    REV05.Visible = true;
                    Eml5.Visible = true;
                    Del5.Visible = true;
                    ChkBox005.Visible = true;
                }
            }
            else
            {
                Lbl005.Visible = true;
                ButUpl005.Visible = true;
                Swo5.Visible = true;
                TxtEml005.Visible = true;
                REV05.Visible = true;
                Eml5.Visible = true;
                Del5.Visible = true;
                ChkBox005.Visible = true;
                ChkBox005.Checked = true;
            }


            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG6"].ToString()))
            {
                Lbl006.Visible = false;
                ButUpl006.Visible = false;
                Swo6.Visible = false;
                TxtEml006.Visible = false;
                REV06.Visible = false;
                Eml6.Visible = false;
                Del6.Visible = false;
                ChkBox006.Checked = false;
                ChkBox006.Visible = false;

                if (X == 1)
                {
                    Lbl006.Visible = true;
                    ButUpl006.Visible = true;
                    Swo6.Visible = true;
                    TxtEml006.Visible = true;
                    REV06.Visible = true;
                    Eml6.Visible = true;
                    Del6.Visible = true;
                    ChkBox006.Visible = true;
                }
            }
            else
            {
                Lbl006.Visible = true;
                ButUpl006.Visible = true;
                Swo6.Visible = true;
                TxtEml006.Visible = true;
                REV06.Visible = true;
                Eml6.Visible = true;
                Del6.Visible = true;
                ChkBox006.Visible = true;
                ChkBox006.Checked = true;
            }


            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG7"].ToString()))
            {
                Lbl007.Visible = false;
                ButUpl007.Visible = false;
                Swo7.Visible = false;
                TxtEml007.Visible = false;
                REV07.Visible = false;
                Eml7.Visible = false;
                Del7.Visible = false;
                ChkBox007.Checked = false;
                ChkBox007.Visible = false;

                if (X == 1)
                {
                    X = 0;
                    Lbl007.Visible = true;
                    ButUpl007.Visible = true;
                    Swo7.Visible = true;
                    TxtEml007.Visible = true;
                    REV07.Visible = true;
                    Eml7.Visible = true;
                    Del7.Visible = true;
                    ChkBox007.Visible = true;
                }
            }
            else
            {
                Lbl007.Visible = true;
                ButUpl007.Visible = true;
                Swo7.Visible = true;
                TxtEml007.Visible = true;
                REV07.Visible = true;
                Eml7.Visible = true;
                Del7.Visible = true;
                ChkBox007.Visible = true;
                ChkBox007.Checked = true;
            }

            //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG8"].ToString())) ChkBox008.Checked = false;
            //      else ChkBox008.Checked = true;
            //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["USLIG9"].ToString())) ChkBox009.Checked = false;
            //      else ChkBox009.Checked = true;
        }
    }

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
    protected void Import004_Click(object sender, EventArgs e)
    {
        ImportImg("4");
    }
    protected void Import005_Click(object sender, EventArgs e)
    {
        ImportImg("5");
    }
    protected void Import006_Click(object sender, EventArgs e)
    {
        ImportImg("6");
    }
    protected void Import007_Click(object sender, EventArgs e)
    {
        ImportImg("7");
    }
    protected void Import008_Click(object sender, EventArgs e)
    {
        ImportImg("8");
    }
    protected void Import009_Click(object sender, EventArgs e)
    {
        ImportImg("9");
    }
    // ============================ загрузка EXCEL в базу ==============================================
    protected void ImportImg(string NumImg)
    {
        string UplFilNam;
        string UplFilNamExt;

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
        string ImgFil = Papka + @"\" + parGrfIIN.Value.Substring(0, 12) + "_" + Convert.ToInt32(parUslIdn.Value).ToString("D10") + "_" + NumImg;
        int i = 0;


        if (FilUpl001.FileName == "")
        {
            return;
            //UplFilNam = "C:\\Webcam.jpg";
        }
        else UplFilNam = FilUpl001.FileName;

        System.IO.FileInfo fi = new System.IO.FileInfo(UplFilNam);
        UplFilNamExt = fi.Extension;

        //          System.IO.FileInfo fi = new System.IO.FileInfo("C:\\Webcam.jpg");
        if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0 ||
            fi.Extension.CompareTo(".doc") == 0 || fi.Extension.CompareTo(".docx") == 0 || fi.Extension.CompareTo(".rtf") == 0 ||
            fi.Extension.CompareTo(".JPG") == 0 || fi.Extension.CompareTo(".JPEG") == 0 || fi.Extension.CompareTo(".pdf") == 0)
        {
            if (fi.Extension.CompareTo(".doc") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".docx") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".rtf") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".pdf") == 0) ImgFil = ImgFil + ".pdf";
            if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0) ImgFil = ImgFil + ".jpg";

            // поверить каталог, если нет создать ----------------------------------------------------------------
            if (Directory.Exists(Papka)) i = 0;
            else Directory.CreateDirectory(Papka);

            // сформировать имя фаила ----------------------------------------------------------------
            //            string ServerPath = Server.MapPath("~/Temp/" + parUslIdn.Value + ".jpg");
            string ServerPath = Server.MapPath("~/Temp/" + parUslIdn.Value + UplFilNamExt);
            // скачать фаил ----------------------------------------------------------------
            if (FilUpl001.FileName != "") FilUpl001.PostedFile.SaveAs(ServerPath);   //для upload  

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(ImgFil)) File.Delete(ImgFil);
            // скорировать скачанный файл ----------------------------------------------------------------

            if (FilUpl001.FileName != "")
            {
                if (fi.Extension.CompareTo(".doc") == 0 || fi.Extension.CompareTo(".docx") == 0 || fi.Extension.CompareTo(".rtf") == 0)
                {
                    /* для просмотра DOC,DOCX,RTF ============================================================================ */
                    /*
                    Spire.Doc.Document document = new Spire.Doc.Document();
                    document.LoadFromFile(ServerPath);
                    //Convert Word to PDF
                    document.SaveToFile(ImgFil, FileFormat.PDF);
                    */
                    Aspose.Words.Document document = new Aspose.Words.Document(ServerPath);
                    //Convert Word to PDF
                    document.Save(ImgFil);

                }
                else File.Copy(ServerPath, ImgFil); // для upload  
            }
            else File.Copy(UplFilNam, ImgFil);

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

            //Force clean up
            GC.Collect();
        }
        else
        {
            Response.Write("Тип файла не верен");
        }
        //               string path = string.Concat(Server.MapPath("~/Temp/"), FileUpload1.FileName);
        //Save File as Temp then you can delete it if you want
        //               FileUpload1.SaveAs(path);
        //string path = @"C:\Users\Johnney\Desktop\ExcelData.xls";
        getDocNum(0);

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
            stream.Dispose();

            //create a new stream, this will be used to write to the
            //FTP server
            Stream requestStream = ftpRequest.GetRequestStream();
            //write the data to the FTP server
            requestStream.Write(buffer, 0, buffer.Length);
            //close the stream
            requestStream.Close();
            requestStream.Dispose();
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

    public void SendEmail0X(object sender, EventArgs e)
    {
        if (TxtEml00X.Text.Length == 0) TxtEml00X.Text="укажите email";
        else SendEmail("X");
    }

    public void SendEmail01(object sender, EventArgs e)
    {
        if (TxtEml001.Text.Length == 0) TxtEml001.Text="укажите email";
        else SendEmail("1");
    }

    public void SendEmail02(object sender, EventArgs e)
    {
        if (TxtEml002.Text.Length == 0) TxtEml002.Text="укажите email";
        else SendEmail("2");
    }

    public void SendEmail03(object sender, EventArgs e)
    {
        if (TxtEml003.Text.Length == 0) TxtEml003.Text = "укажите email";
        else SendEmail("3");
    }

    public void SendEmail04(object sender, EventArgs e)
    {
        if (TxtEml004.Text.Length == 0) TxtEml004.Text = "укажите email";
        else SendEmail("4");
    }
    public void SendEmail05(object sender, EventArgs e)
    {
        if (TxtEml005.Text.Length == 0) TxtEml005.Text = "укажите email";
        else SendEmail("5");
    }
    public void SendEmail06(object sender, EventArgs e)
    {
        if (TxtEml006.Text.Length == 0) TxtEml006.Text = "укажите email";
        else SendEmail("6");
    }
    public void SendEmail07(object sender, EventArgs e)
    {
        if (TxtEml007.Text.Length == 0) TxtEml007.Text = "укажите email";
        else SendEmail("7");
    }
    public void SendEmail08(object sender, EventArgs e)
    {
        //     if (TxtEml008.Text.Length == 0) TxtEml008.Text = "укажите email";
        //     else SendEmail("8");
    }
    public void SendEmail09(object sender, EventArgs e)
    {
        //    if (TxtEml009.Text.Length == 0) TxtEml009.Text = "укажите email";
        //    else SendEmail("9");
    }
    // ------------------------------------------------------------------------------заполняем второй уровень
    protected void SendEmail(string NumImg)
    {
        SqlDataReader rdr;
        string Path = "";
        string UslNam = "";
        string EmlTo = "";

        // Open connection to the database
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT AMBUSL.*,SprUsl.UslNam FROM AMBUSL INNER JOIN SprUsl ON AMBUSL.USLKOD = SprUsl.UslKod WHERE AMBUSL.USLIDN=" + AmbUslIdn, con);

            // Execute the query
            rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                UslNam = rdr["USLNAM"].ToString();
                if (NumImg == "1")
                {
                    Path = rdr["USLIG1"].ToString();
                    EmlTo = TxtEml001.Text;
                }
                if (NumImg == "2")
                {
                    Path = rdr["USLIG2"].ToString();
                    EmlTo = TxtEml002.Text;
                }
                if (NumImg == "3")
                {
                    Path = rdr["USLIG3"].ToString();
                    EmlTo = TxtEml003.Text;
                }

                rdr.Close();
                cmd.Dispose();
                con.Close();


                if (Path.Length > 0)
                {
                    string EmlFrom = "dauasoft@gmail.com";
                    //    string EmlTo = "kalitulenov@mail.ru";
                    string EmlSubject = (string)UslNam;
                    string EmlBody = "Пациент " + (string)parGrfPth.Value;

                    var msg = new MailMessage(EmlFrom, EmlTo, EmlSubject, EmlBody);
                    var smtpClient = new SmtpClient("smtp.gmail.com", 25);
                    smtpClient.Credentials = new NetworkCredential("dauasoft@gmail.com", "janayTKB2015=");

                    System.Net.Mail.Attachment attachment;
                    //             attachment = new System.Net.Mail.Attachment(@"C:\IMAGES\20170224102800_20186_CHEST PA.JPG");
                    attachment = new System.Net.Mail.Attachment(Path);
                    msg.Attachments.Add(attachment);

                    smtpClient.EnableSsl = true;
                    smtpClient.Send(msg);
                }
            }
        }
        catch (Exception ex)
        {
            //          MessageBox.Show("Can not open connection ! ");
        }
    }


    // ------------------------------------------------------------------------------заполняем второй уровень

    protected void Vis001(object sender, EventArgs e)
    {
        getDocNum(1);
    }
    // ==================================================================================================  
    // ------------------------------------------------------------------------------заполняем второй уровень

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parGrfPth" runat="server" />
        <asp:HiddenField ID="parGrfIIN" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

            <hr />
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Label1" Text="ФАИЛ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:FileUpload ID="FilUpl001" Height="25px" Width="60%"  runat="server" />

                        <button id="Web" onclick="WebCam();">Вкл.камеру</button>
                   </td>
                </tr>
            </table>

            <hr />
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
        <%-- ============================  0  ============================================ --%>
                <tr>
                    <td style="width: 100%; height: 25px;">   
                        <asp:Label ID="Label2" Text="X.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TextBox1" Width="10%" Height="20" runat="server" />
                        <asp:Button ID="SwoX" runat="server" OnClientClick="Sho001('X');" Text="Просмотр" />
                       
                        <obout:OboutCheckBox runat="server" ID="ChkBox00X" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml00X" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml00X"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
                        
                        <asp:Button ID="EmlX" runat="server" onclick="SendEmail0X" Text="Email" />
                        <asp:Button ID="DelX" runat="server" OnClientClick="Del001('X');" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>
        <%-- ============================  1  ============================================ --%>
                <tr>
                    <td style="width: 100%; height: 25px;">   
                        <asp:Label ID="Lbl001" Text="1.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl001" runat="server" onclick="Import001_Click" Text="Загрузить" />
                        <asp:Button ID="Swo1" runat="server" OnClientClick="Sho001(1);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox runat="server" ID="ChkBox001" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml001" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV01" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml001"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
                        
                        <asp:Button ID="Eml1" runat="server" onclick="SendEmail01" Text="Email" />
                        <asp:Button ID="Del1" runat="server" OnClientClick="Del001(1);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>
        <%-- ============================  2  ============================================ --%>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl002" Text="2.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl002" runat="server" onclick="Import002_Click" Text="Загрузить" />
                        <asp:Button ID="Swo2" runat="server" OnClientClick="Sho001(2);" Text="Просмотр" />
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox002" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml002" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV02" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml002"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
                       
                        <asp:Button ID="Eml2" runat="server" onclick="SendEmail02" Text="Email" />
                        <asp:Button ID="Del2" runat="server" OnClientClick="Del001(2);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

         <%-- ============================  3  ============================================ --%>
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl003" Text="3.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl003" runat="server" onclick="Import003_Click" Text="Загрузить" />
                        <asp:Button ID="Swo3" runat="server" OnClientClick="Sho001(3);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox003" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml003" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV03" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml003"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
 
                        <asp:Button ID="Eml3" runat="server" onclick="SendEmail03" Text="Email" />
                        <asp:Button ID="Del3" runat="server" OnClientClick="Del001(3);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

         <%-- ============================  4  ============================================ --%>
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl004" Text="4.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl004" runat="server" onclick="Import004_Click" Text="Загрузить" />
                        <asp:Button ID="Swo4" runat="server" OnClientClick="Sho001(4);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox004" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml004" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV04" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml004"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
 
                        <asp:Button ID="Eml4" runat="server" onclick="SendEmail04" Text="Email" />
                        <asp:Button ID="Del4" runat="server" OnClientClick="Del001(4);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

         <%-- ============================  5  ============================================ --%>
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl005" Text="5.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl005" runat="server" onclick="Import005_Click" Text="Загрузить" />
                        <asp:Button ID="Swo5" runat="server" OnClientClick="Sho001(5);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox005" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml005" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV05" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml005"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
 
                        <asp:Button ID="Eml5" runat="server" onclick="SendEmail05" Text="Email" />
                        <asp:Button ID="Del5" runat="server" OnClientClick="Del001(5);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

         <%-- ============================  6  ============================================ --%>
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl006" Text="6.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl006" runat="server" onclick="Import006_Click" Text="Загрузить" />
                        <asp:Button ID="Swo6" runat="server" OnClientClick="Sho001(6);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox006" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml006" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV06" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml006"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
 
                        <asp:Button ID="Eml6" runat="server" onclick="SendEmail06" Text="Email" />
                        <asp:Button ID="Del6" runat="server" OnClientClick="Del001(6);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

        <%-- ============================  7  ============================================ --%>

                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl007" Text="7.ОБРАЗ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl007" runat="server" onclick="Import007_Click" Text="Загрузить" />
                        <asp:Button ID="Swo7" runat="server" OnClientClick="Sho001(7);" Text="Просмотр" />
                        
                        <obout:OboutCheckBox CssClass="ChkCls" runat="server" ID="ChkBox007" FolderStyle="~/Styles/Interface/plain/OboutCheckBox"> </obout:OboutCheckBox>  

                        <asp:TextBox ID="TxtEml007" Width="30%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="REV07" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml007"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
 
                        <asp:Button ID="Eml7" runat="server" onclick="SendEmail07" Text="Email" />
                        <asp:Button ID="Del7" runat="server" OnClientClick="Del001(7);" style="background-image:url('/Icon/DELETE.PNG'); background-color:white; background-repeat:no-repeat; height:20px; width:30px;" />

                   </td>
                </tr>

            </table>

            <hr />

           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <center>
                              <asp:Button ID="Button2" runat="server" onclick="Vis001" Text="Добавить" />
                        </center>
                   </td>
                </tr>
            </table>
        </asp:Panel>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon
                              <asp:Button ID="Button1" runat="server" OnClientClick="Vis000();" Text="Добавить" />
     
      ============================================ --%>
       <owd:Window ID="ShoWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="10" Top="10" Height="550" Width="950" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>

    </form>

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



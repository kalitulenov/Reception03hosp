<%@ Page Language="C#" AutoEventWireup="true"%>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            /*
            SqlConnection con = new SqlConnection
                          (@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");
            string qry = "insert into Photos (title,photo) values(@title, @photo)";
            SqlCommand cmd = new SqlCommand(qry, con);
            // create Parameters
            cmd.Parameters.AddWithValue("@title", Request.Form["title"]);
            SqlParameter photoParam = new SqlParameter("@photo", SqlDbType.Image);
            String source = Request.Form["photo"];
            // remove extra chars at the beginning
            source = source.Substring(source.IndexOf(",") + 1);
            byte[] data = Convert.FromBase64String(source);
            photoParam.Value = data;
            cmd.Parameters.Add(photoParam);

            //Open connection and execute insert query.
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            */

            String NumImg = Request.Form["Num"];
            String source = Request.Form["photo"];
            // remove extra chars at the beginning
            source = source.Substring(source.IndexOf(",") + 1);

            byte[] photo = Convert.FromBase64String(source);
            FileStream fs = new FileStream("C:\\Webcam.jpg", FileMode.OpenOrCreate, FileAccess.Write);
            BinaryWriter br = new BinaryWriter(fs);
            br.Write(photo);
            br.Flush();
            br.Close();
            fs.Close();

            ImportImg(NumImg);


        }
        catch (Exception ex)
        {
            Trace.Write(ex.Message);
        }

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
        string ImgFil = Papka + @"\" + parGrfPth.Value.Substring(0, 12) + "_" + Convert.ToInt32(AmbUslIdn).ToString("D10") + "_" + NumImg;
        int i = 0;


        if (FilUpl001.FileName == "") UplFilNam = "C:\\Webcam.jpg";
        else UplFilNam = FilUpl001.FileName;

        System.IO.FileInfo fi = new System.IO.FileInfo(UplFilNam);
        UplFilNamExt = fi.Extension;

        //          System.IO.FileInfo fi = new System.IO.FileInfo("C:\\Webcam.jpg");
        if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0 ||
            fi.Extension.CompareTo(".JPG") == 0 || fi.Extension.CompareTo(".JPEG") == 0 || fi.Extension.CompareTo(".pdf") == 0)
        {
            if (fi.Extension.CompareTo(".pdf") == 0) ImgFil = ImgFil + ".pdf";
            else ImgFil = ImgFil + ".jpg";

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

            if (FilUpl001.FileName != "") File.Copy(ServerPath, ImgFil); // для upload   
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
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
           <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parGrfPth" runat="server" />
   </form>
</body>
</html>

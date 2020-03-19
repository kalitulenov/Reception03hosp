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


        function Sho001(Num) {
 //           alert("ButSho001");
            var AmbAnlIdn = document.getElementById('parUslIdn').value;

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



    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslPth;
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

            //            getDocNum();
            //            GetGrid();
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

    public void SendEmail01(object sender, EventArgs e)
    {
        SendEmail("1");
    }

    public void SendEmail02(object sender, EventArgs e)
    {
        SendEmail("2");
    }

    public void SendEmail03(object sender, EventArgs e)
    {
        SendEmail("3");
    }
    // ------------------------------------------------------------------------------заполняем второй уровень
    protected void SendEmail(string NumImg)
    {
        SqlDataReader rdr;
        string Path = @"C:\IMAGES\201410\00042886A.JPG";

        // Open connection to the database
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM AMBUSL WHERE USLIDN=" + AmbUslIdn, con);

            // Execute the query
            rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                if (NumImg == "1") Path = rdr["USLIG1"].ToString();
                if (NumImg == "2") Path = rdr["USLIG2"].ToString();
                if (NumImg == "3") Path = rdr["USLIG3"].ToString();
            }
            rdr.Close();
            cmd.Dispose();
            con.Close();


            if (Path.IndexOf(".jpg") > 0)
            {
                /* для просмотра IMAGE ============================================================================ */
                //   if (Path.Length > 0)  Path;
            }

            string EmlFrom = "dauasoft@gmail.com";
            string EmlTo = "kalitulenov@mail.ru";
            string EmlSubject = (string)parGrfPth.Value;
            string EmlBody = "Пациент" + (string)parGrfPth.Value;

            var msg = new MailMessage(EmlFrom, EmlTo, EmlSubject, EmlBody);
            var smtpClient = new SmtpClient("smtp.gmail.com", 25);
            smtpClient.Credentials = new NetworkCredential("dauasoft@gmail.com", "janayTKB2015=");

            System.Net.Mail.Attachment attachment;
            attachment = new System.Net.Mail.Attachment(@"C:\IMAGES\20170224102800_20186_CHEST PA.JPG");
            msg.Attachments.Add(attachment);

            smtpClient.EnableSsl = true;
            smtpClient.Send(msg);
        }
        catch (Exception ex)
        {
            //          MessageBox.Show("Can not open connection ! ");
        }
    }


    // ------------------------------------------------------------------------------заполняем второй уровень
    public void SendEmail(object sender, EventArgs e)
    {
        //           int GrfIdn;
        // string GrfEml = "kalitulenov@mail.ru";

        // ===================== отправить через LOCALHOST ================================================================================
        /*
        SmtpClient smtp = new SmtpClient();
        //Формирование письма
        MailMessage msg = new MailMessage();
        msg.From = new MailAddress("kalitulenov@gmail.com");
        msg.To.Add(new MailAddress(GrfEml));
        msg.Subject = "Запись к врачу";

        System.Net.Mail.Attachment attachment;
        attachment = new System.Net.Mail.Attachment(@"C:\IMAGES\20170224102800_20186_CHEST PA.JPG");
        msg.Attachments.Add(attachment);

        msg.Body = "Пациент " + (string)parGrfPth.Value;
        smtp.Send(msg);
        msg.Dispose();
        */

        /*
    using (MailMessage mail = new MailMessage())
{
    mail.From = new MailAddress("email@gmail.com");
    mail.To.Add("somebody@domain.com");
    mail.Subject = "Hello World";
    mail.Body = "<h1>Hello</h1>";
    mail.IsBodyHtml = true;
    mail.Attachments.Add(new Attachment("C:\\file.zip"));

    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
    {
        smtp.Credentials = new NetworkCredential("email@gmail.com", "password");
        smtp.EnableSsl = true;
        smtp.Send(mail);
    }
}
         */


        string EmlFrom = "dauasoft@gmail.com";
        string EmlTo = "kalitulenov@mail.ru";
        string EmlSubject = (string)parGrfPth.Value;
        string EmlBody = "Пациент" + (string)parGrfPth.Value;


        var msg = new MailMessage(EmlFrom, EmlTo, EmlSubject, EmlBody);
        var smtpClient = new SmtpClient("smtp.gmail.com", 25);
        smtpClient.Credentials = new NetworkCredential("dauasoft@gmail.com", "janayTKB2015=");


        /*
        var msg = new MailMessage("kalitulenov@gmail.com", "kalitulenov@mail.ru", "Запись к врачу", "Пациент");
        var smtpClient = new SmtpClient("smtp.gmail.com", 25);
        smtpClient.Credentials = new NetworkCredential("kalitulenov@gmail.com", "janayTKB2015=");
        */

        System.Net.Mail.Attachment attachment;
        attachment = new System.Net.Mail.Attachment(@"C:\IMAGES\20170224102800_20186_CHEST PA.JPG");
        msg.Attachments.Add(attachment);

        smtpClient.EnableSsl = true;
        smtpClient.Send(msg);

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
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl000" Text="0.ФАЙЛ:" runat="server" Width="7%" Font-Bold="true" Font-Size="Medium" />
                        <asp:FileUpload ID="FilUpl001" Height="25px"  runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Label3" Text="1.ОБРАЗ:" runat="server" Width="7%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl001" runat="server" onclick="Import001_Click" Text="Загрузить" />
                        <button id="Swo1" onclick="Sho001(1);"><img id="img11" src="/Icon/Show.png" alt="Start"></button>
                        <button id="Del1" onclick="Del001(1);"><img id="img12" src="/Icon/DELETE.PNG" alt="Start"></button>
                        <asp:Button ID="Eml1" runat="server" onclick="SendEmail01" Text="Email" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl002" Text="2.ОБРАЗ:" runat="server" Width="7%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl002" runat="server" onclick="Import002_Click" Text="Загрузить" />
                        <button id="Swo2" onclick="Sho001(2);"><img id="img21" src="/Icon/Show.png" alt="Start"></button>
                        <button id="Del2" onclick="Del001(2);"><img id="img22" src="/Icon/DELETE.PNG" alt="Start"></button>
                        <asp:Button ID="Eml2" runat="server" onclick="SendEmail02" Text="Email" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Label ID="Lbl003" Text="3.ОБРАЗ:" runat="server" Width="7%" Font-Bold="true" Font-Size="Medium" />
                        <asp:Button ID="ButUpl003" runat="server" onclick="Import003_Click" Text="Загрузить" />
                        <button id="Swo3" onclick="Sho001(3);"><img id="img31" src="/Icon/Show.png" alt="Start"></button>
                        <button id="Del3" onclick="Del001(3);"><img id="img32" src="/Icon/DELETE.PNG" alt="Start"></button>
                        <asp:Button ID="Eml3" runat="server" onclick="SendEmail03" Text="Email" />
                   </td>
                </tr>

            </table>

            <hr />

        </asp:Panel>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
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



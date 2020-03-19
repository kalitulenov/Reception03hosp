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

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslNam;
    string AmbUslPth;
    string AmbUslIIN;
    string AmbUslIdnTek;
    string AmbAnlTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int ItgSum = 0;

    string getFileName;
    string VrtKat = "";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        AmbUslNam = Convert.ToString(Request.QueryString["AmbUslNam"]);
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

        if (!Page.IsPostBack)
        {
            //============= Установки ===========================================================================================
            AmbUslIdnTek = (string)Session["AmbUslIdn"];

            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;
            parUslNam.Value = AmbUslNam;
            parGrfPth.Value = AmbUslPth;
            parGrfIIN.Value = AmbUslIIN;
            Sapka.Text = AmbUslNam;

            //            getDocNum();
            //            GetGrid();
            //          ImportImg("1");
        }

        //       FileUpload1.Attributes["onchange"] = "UploadFile(this)";
        TxtEml001.Text = "doc.smart.heath@gmail.com; zeinep.tuleutayeva@mail.ru;";
    }

    protected void Upload(object sender, EventArgs e)
    {
        // поверить каталог, если нет создать ----------------------------------------------------------------
        VrtKat = Server.MapPath("~/Temp/" + BuxKod + "/");
        parVrtKat.Value = VrtKat;

        if (Directory.Exists(VrtKat)) ItgSum = 0;
        else Directory.CreateDirectory(VrtKat);


        // список всех файлов в директории VrtKat
        string[] files = Directory.GetFiles(VrtKat, "*.*");

        // удалить все файлы в каталоге
        if (files.Length > 0)
        {
            for (int i = 0; i < files.Length; i++)
            {
                File.Delete(files[i]);
            }
        }

        // список всех файлов в директории VrtKat
        foreach (HttpPostedFile htfiles in FileUpload1.PostedFiles)
        {
            getFileName = Path.GetFileName(htfiles.FileName);
            htfiles.SaveAs(VrtKat+getFileName);
        }
        //  FileUpload1.SaveAs(Server.MapPath("~/Temp/" + Path.GetFileName(FileUpload1.FileName)));
        ImportImg("1");
    }

    // ============================ загрузка EXCEL в базу ==============================================
    protected void ImportImg(string NumImg)
    {
        string UplFilNam;
        string UplFilNamExt;
        string ServerPath = "";
        int j;
        int ImgKol=0;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        parGrfPth.Value = parGrfPth.Value + "____________";

        string Papka = @"C:\BASEIMG\" + Convert.ToInt32(BuxFrm).ToString("D5") + @"\" + Convert.ToDateTime(DateTime.Today).ToString("yyyy.MM");

        // поверить каталог, если нет создать ----------------------------------------------------------------
        if (Directory.Exists(Papka)) j = 0;
        else Directory.CreateDirectory(Papka);

        // список всех файлов в директории VrtKat
        string[] files = Directory.GetFiles(VrtKat, "*.*");

        // перебрать все файлы в каталоге
        if (files.Length > 0)
        {
            ImgKol = 0;
            for (int i = 0; i < files.Length; i++)
            {
                string ImgFil = Papka + @"\" + parGrfIIN.Value.Substring(0, 12) + "_" + Convert.ToString(i+1) + "_" + Convert.ToInt32(parUslIdn.Value).ToString("D10") + "_" + NumImg;
                //  int i = 0;

                //  =========================================== загрузка фаила
                ServerPath = files[i];   // FileUpload1.FileName;
                                         // ============================================================
                System.IO.FileInfo fi = new System.IO.FileInfo(ServerPath);
                UplFilNamExt = fi.Extension;

                if (fi.Extension.CompareTo(".jpg") == 0 || fi.Extension.CompareTo(".jpeg") == 0 ||
                    fi.Extension.CompareTo(".JPG") == 0 || fi.Extension.CompareTo(".JPEG") == 0)
                {
                    ImgFil = ImgFil + ".jpg";

                    // сформировать имя фаила ----------------------------------------------------------------
                    // ServerPath = Server.MapPath("~/Temp/" + FileUpload1.FileName);
                    // скачать фаил ----------------------------------------------------------------
                    // if (FilUpl001.FileName != "") FilUpl001.PostedFile.SaveAs(ServerPath);   //для upload  

                    // проверить если фаил есть удалить ----------------------------------------------------------------
                    if (File.Exists(ImgFil)) File.Delete(ImgFil);
                    // скорировать скачанный файл ----------------------------------------------------------------

                    //   if (FilUpl001.FileName != "") File.Copy(ServerPath, ImgFil); // для upload   
                    File.Copy(ServerPath, ImgFil);

                    ImgKol = ImgKol + 1;

                    if (ImgKol < 4)
                    {
                        // ЗАПИСАТЬ НА ДИСК ----------------------------------------------------------------
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();

                        // создание команды
                        SqlCommand cmdUsl = new SqlCommand("UPDATE AMBUSL SET USLIG" + Convert.ToString(ImgKol) + "='" + ImgFil + "' WHERE USLIDN=" + parUslIdn.Value, con);
                        cmdUsl.ExecuteNonQuery();
                        con.Close();
                    }
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
        }
    }

    public void SendEmail01(object sender, EventArgs e)
    {
        string Path = "";
        string UslNam = "";
        string EmlTo = "";
        int i = 0;

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT AMBUSL.*,SprUsl.UslNam FROM AMBUSL INNER JOIN SprUsl ON AMBUSL.USLKOD = SprUsl.UslKod WHERE AMBUSL.USLIDN=" + AmbUslIdn, con);
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslImg");

        if (ds.Tables[0].Rows.Count > 0)
        {
            UslNam = Convert.ToString(ds.Tables[0].Rows[0]["USLNAM"]);
            
            EmlTo = "doc.smart.heath@gmail.com";  //   EmlTo = "dauasoft@gmail.com";
            string EmlFrom = "lab.smart.heath@gmail.com";
            string EmlSubject = (string)UslNam;
            string EmlBody = "Пациент " + (string)parGrfPth.Value;

            var msg = new MailMessage(EmlFrom, EmlTo, EmlSubject, EmlBody);
            msg.To.Add("zeinep.tuleutayeva@mail.ru");   // msg.To.Add("kalitulenov@mail.ru");
            
            var smtpClient = new SmtpClient("smtp.gmail.com", 25);
            smtpClient.Credentials = new NetworkCredential("lab.smart.heath@gmail.com", "Az1234567");  // smtpClient.Credentials = new NetworkCredential("dauasoft@gmail.com", "janay");

            System.Net.Mail.Attachment attachment;

            for (i = 0; i < 3; i++)
            {
                Path = Convert.ToString(ds.Tables[0].Rows[0]["USLIG" + Convert.ToString(i+1)]);
                if (Path.Length > 0)
                {
                    attachment = new System.Net.Mail.Attachment(Path);
                    msg.Attachments.Add(attachment);
                }
            }

            smtpClient.EnableSsl = true;
            smtpClient.Send(msg);

        }

        cmd.Dispose();
        con.Close();

        //     ds.Dispose();

    }
    // ------------------------------------------------------------------------------заполняем второй уровень

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslNam" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parGrfPth" runat="server" />
        <asp:HiddenField ID="parGrfIIN" runat="server" />
        <asp:HiddenField ID="parVrtKat" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">
              <%-- ============================  шапка экрана ============================================ 
                          <asp:Button ID="btnUpload" Text="Upload" runat="server" OnClick="Upload" Style="display: none" />
                
                  --%>
              <hr />
          <asp:TextBox ID="Sapka" 
             Text="РЕНТГЕН ИССЛЕДОВАНИЕ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
         
             <hr />
             <br />  
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
               <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" />
                        <asp:Button ID="Button1" runat="server" Text="Загрузить" OnClick="Upload" />  
                     </td>
                </tr>
 
            </table>

            <hr />
            <br />  
                       <table border="0" cellspacing="0" width="100%" cellpadding="0">
              <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Button ID="Eml1" runat="server" onclick="SendEmail01" Text="Email" />                     
                        <asp:TextBox ID="TxtEml001" Width="80%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
 
                    </td>
                </tr>
            </table>

            <hr />

        </asp:Panel>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon
                             <asp:RegularExpressionValidator ID="REV01" runat="server"
                             ErrorMessage="e-mail адрес не верен" ControlToValidate="TxtEml001"
                             ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$" SetFocusOnError="true">*</asp:RegularExpressionValidator>
      ============================================ --%>
    </form>

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



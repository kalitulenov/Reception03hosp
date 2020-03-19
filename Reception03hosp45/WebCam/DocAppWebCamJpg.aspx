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
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string KltIin;
    string KltIinTek;
    string AmbAnlTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        KltIin = Convert.ToString(Request.QueryString["KltIin"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {

        }

        parKltIin.Value = KltIin;
    }

    //===============================================================================================================
    protected void ImportImg(object sender, EventArgs e)
    {
        string UplFilNam;
        string UplFilNamExt;

        KltIin = Convert.ToString(Session["KltIin"]);

        string Papka = @"C:\BASEPICKLT\";
        string ImgFil = Papka + @"\" + parKltIin.Value + ".jpg";
        int i = 0;

        UplFilNam = "C:\\Webcam.jpg";

        // поверить каталог, если нет создать ----------------------------------------------------------------
        if (Directory.Exists(Papka)) i = 0;
        else Directory.CreateDirectory(Papka);

        // проверить если фаил есть удалить ----------------------------------------------------------------
        if (File.Exists(ImgFil)) File.Delete(ImgFil);
        // скорировать скачанный файл ----------------------------------------------------------------

        File.Copy(UplFilNam, ImgFil);

        //Force clean up
        GC.Collect();
    }


</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parKltIin" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

             <object width="405" height="190">
		             <param name="movie" value="/WebCam/WebcamResources/save_picture.swf">
		             <embed src="/WebCam/WebcamResources/save_picture.swf" width="405" height="190"></embed>
	         </object>
            <hr />
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 25px;">
                        <asp:Button ID="ButUpl001" runat="server" Font-Size="X-Large" onclick="ImportImg" Text="Загрузить" />
                    </td>
                </tr>
            </table>

            <hr />

        </asp:Panel>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>
</body>

</html>



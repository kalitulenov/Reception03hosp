<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register Assembly="obout_ImageZoom_NET" Namespace="OboutInc.ImageZoom" TagPrefix="obout" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslImgNum;
    string BuxFrm;
    string BuxKod;
    int ItgSum = 0;
    string Path=@"C:\IMAGES\201410\00042886A.JPG";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataReader rdr;

        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        AmbUslImgNum = Convert.ToString(Request.QueryString["AmbUslImgNum"]);
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        //   AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
        //       sdsImg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsImg.SelectCommand = "SELECT ANLREF1,ANLREF2 FROM AMBANL WHERE ANLIDN=6484";
        // --------------------------  считать данные одного врача -------------------------

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
                if (AmbUslImgNum == "X")
                {
                    Path = rdr["USLXLS"].ToString();
                    if (Path.IndexOf(".jpg") < 0 && Path.IndexOf(".pdf") < 0) Path = Path + ".pdf";
                    else ItgSum = 0;
                }
                if (AmbUslImgNum == "1") Path = rdr["USLIG1"].ToString();
                if (AmbUslImgNum == "2") Path = rdr["USLIG2"].ToString();
                if (AmbUslImgNum == "3") Path = rdr["USLIG3"].ToString();
                if (AmbUslImgNum == "4") Path = rdr["USLIG4"].ToString();
                if (AmbUslImgNum == "5") Path = rdr["USLIG5"].ToString();
                if (AmbUslImgNum == "6") Path = rdr["USLIG6"].ToString();
                if (AmbUslImgNum == "7") Path = rdr["USLIG7"].ToString();
                if (AmbUslImgNum == "8") Path = rdr["USLIG8"].ToString();
                if (AmbUslImgNum == "9") Path = rdr["USLIG9"].ToString();
            }
            rdr.Close();
            cmd.Dispose();
            con.Close();

            //Создание объекта для генерации чисел
            Random rnd = new Random();

            //Получить случайное число (в диапазоне от 0 до 1000000000)
            int Rnd = rnd.Next(0, 1000000000);

            if (Path.IndexOf(".jpg") > 0)
            {
                /* для просмотра IMAGE ============================================================================ */
                if (Path.Length > 0) ImageAnl.ImageUrl = "DynamicImage.aspx?path=" + Path;
                ImageAnl.Width = 950;
                ImageAnl.Height = 750;
            }
            if (Path.IndexOf(".pdf") > 0 || Path.IndexOf(".doc") > 0 || Path.IndexOf(".xls") > 0)
            {
                /* для просмотра PDF ============================================================================ */
                //      string FilNam = Path.Substring(Path.Length-32);
                string FilNam = Convert.ToInt32(Rnd).ToString("D10")+".pdf";
                //string FilNam = Convert.ToInt32(BuxKod).ToString("D6")+".pdf";
                //            string PathNew = Server.MapPath(@"~\Temp\" + Path.Substring(Path.Length-27));  // выделить символ с конца
                string PathNew = Server.MapPath(@"~\Temp\" + FilNam);

                // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(PathNew)) File.Delete(PathNew);
                //    File.Delete(PathNew);
                // скорировать скачанный файл ----------------------------------------------------------------
                File.Copy(Path, PathNew);

                //         Path = @"C:\BASEIMG\00001\2016.02\Колесникова _0005251651.pdf";
                //         Path = Path.Substring(11, Path.Length - 11);27
                Literal1.Text = "<object width='900' height='600'  type='application/pdf' data='/Temp/" + FilNam +
                               "'?#zoom=85,250,100&scrollbar=0&toolbar=0&navpanes=0&highlight=0,0,0,0' id='pdf_content' > </object> ";
            }
            //C:\BASEIMG\00002\2015.12\КАЛПАКИДИ НА_0000142969.jpg      height"] = "400"       
            //123456789012345678901234567890
        }
        catch (Exception ex)
        {
            //          MessageBox.Show("Can not open connection ! ");
        }

        if (!Page.IsPostBack)
        {
            //       getDocNum();
        }
    }

    // ======================================================================================
    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">
        <div id="pdf" >
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </div>

        <div id="jpg" style="overflow-y: auto; max-width: 1200px; max-height: 600px;"   
              onclick='document.write("<div onClick=print(); />"+document.getElementById("jpg").innerHTML+"</div>");' title="Печать" > 
              <asp:Image ID="ImageAnl" runat="server" ImageUrl="file://localhost/D://IMAGES/201410/00042885A.JPG"  Width="100%"  Height="100%" />
         </div> 

        <%-- ============================  ПРИМЕР  ============================================ 
             <object width="100%" height="550" type="application/pdf" data="Кожаканова А_0005250039.pdf?#zoom=85&scrollbar=0&toolbar=0&navpanes=0" id="pdf_content" >
                <p>Insert your error message here, if the PDF cannot be displayed.</p>
              </object>
       --%>

    </form>

    <%-- -------------------------------------  для просмотра IMAGE
         <div id="large"  
              onclick='document.write("<div onClick=print(); />"+document.getElementById("large").innerHTML+"</div>");' title="Печать" > 
              <asp:Image ID="ImageAnl" runat="server" ImageUrl="file://localhost/D://IMAGES/201410/00042885A.JPG"  Width="100%"  Height="100%" />
         </div> 
        --------------------------------%>

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
    </style>

</body>
</html>



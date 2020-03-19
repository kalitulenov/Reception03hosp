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
    string EodIdn;
    string EodImgNum;
    string EodBuxKod;
    string BuxFrm;
    string BuxKod;
    int ItgSum = 0;
    string Path=@"C:\IMAGES\201410\00042886A.JPG";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataReader rdr;
        string TypApp = "";

        EodBuxKod = Convert.ToString(Request.QueryString["EodBuxKod"]);
        EodIdn = Convert.ToString(Request.QueryString["EodIdn"]);
        EodImgNum = Convert.ToString(Request.QueryString["EodImgNum"]);
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
            SqlCommand cmd = new SqlCommand("SELECT * FROM TABEOD WHERE EODIDN=" + EodIdn, con);

            // Execute the query
            rdr = cmd.ExecuteReader();

            while (rdr.Read())
            {
                if (EodImgNum == "1") Path = rdr["EODIMG001"].ToString();
                if (EodImgNum == "2") Path = rdr["EODIMG002"].ToString();
                if (EodImgNum == "3") Path = rdr["EODIMG003"].ToString();
                if (EodImgNum == "4") Path = rdr["EODIMG004"].ToString();
                if (EodImgNum == "5") Path = rdr["EODIMG005"].ToString();
                if (EodImgNum == "6") Path = rdr["EODIMG006"].ToString();
                if (EodImgNum == "7") Path = rdr["EODIMG007"].ToString();
                if (EodImgNum == "8") Path = rdr["EODIMG008"].ToString();
                if (EodImgNum == "9") Path = rdr["EODIMG009"].ToString();
            }
            rdr.Close();
            cmd.Dispose();
            //     con.Close();

            if (Path.IndexOf(".jpg") > 0)
            {
                /* для просмотра IMAGE ============================================================================ */
                if (Path.Length > 0) ImageAnl.ImageUrl = "/Priem/DynamicImage.aspx?path=" + Path;
                ImageAnl.Width = 950;
                ImageAnl.Height = 750;
            }

            //     if (Path.IndexOf(".pdf") > 0) TypApp = "application/pdf";
            //     if (Path.IndexOf(".doc") > 0) TypApp = "application/msword";
            //     if (Path.IndexOf(".xls") > 0) TypApp = "application/excel";

            if (Path.IndexOf(".pdf") > 0)
            {
                TypApp = "application/pdf";
                /* для просмотра PDF ============================================================================ */
                string FilNam = Path.Substring(Path.Length-16);
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
                Literal1.Text = "<object width='900' height='600'  type='" + TypApp + "' data='/Temp/" + FilNam +
                               "'?#zoom=85,250,100&scrollbar=0&toolbar=0&navpanes=0&highlight=0,0,0,0' id='pdf_content' > </object> ";
            }
            //C:\BASEIMG\00002\2015.12\КАЛПАКИДИ НА_0000142969.jpg      height"] = "400"       
            //123456789012345678901234567890
            //  -----------------------------------------------  ОТМЕТИТЬ О ПРОСМОТРЕ ДОКУМЕНТА --------------------------
            //if (EodBuxKod != "0")
            //{  

            //    // строка соединение
            //   // string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //   // SqlConnection con = new SqlConnection(connectionString);
            //   // con.Open();
            //    // ------------------------------------------------------------------------------заполняем второй уровень
            //    // создание команды
            //    SqlCommand cmdEod = new SqlCommand("UPDATE TABEODDTL SET EODDTLRDY=1,EODDTLEND=GETDATE() " +
            //                                       "WHERE EODDTLREF=" + EodIdn + " AND EODDTLWHO=" + BuxKod, con);
            //    // создание команды
            //    cmdEod.ExecuteNonQuery();
            //}
            //  -----------------------------------------------  ОТМЕТИТЬ О ПРОСМОТРЕ ДОКУМЕНТА --------------------------

            con.Close();

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



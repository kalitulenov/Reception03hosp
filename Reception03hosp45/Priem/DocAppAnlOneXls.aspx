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
<%@ Import Namespace="Spire.Xls" %>
<%@ Import Namespace="Spire.Xls.Converter" %>

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
    int ItgSum = 0;
    string Path=@"C:\IMAGES\201410\00042886A.JPG";
    
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataReader rdr;
        
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        AmbUslImgNum = Convert.ToString(Request.QueryString["AmbUslImgNum"]);
        BuxFrm = (string)Session["BuxFrmKod"];
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
            SqlCommand cmd = new SqlCommand("SELECT USLXLS FROM AMBUSL WHERE USLIDN=" + AmbUslIdn, con);

            // Execute the query
            rdr = cmd.ExecuteReader();
            
            while (rdr.Read())
            {
                Path = rdr["USLXLS"].ToString();
            }
            rdr.Close();
            cmd.Dispose();
            con.Close();

            Workbook workbook = new Workbook();
            workbook.LoadFromFile(Path);
            Worksheet sheet = workbook.Worksheets[0];

            // СФОРМИРОВАТЬ ПУТЬ ===========================================================================================
            string XlsFil = @"C:\TMPBASE\" + Convert.ToInt32(AmbUslIdn).ToString("D10") + ".jpg";

            // проверить если фаил есть удалить ----------------------------------------------------------------
            if (File.Exists(XlsFil)) File.Delete(XlsFil);

            // ЗАПИСАТЬ НА ДИСК ===========================================================================================
            //Save and Launch
            sheet.SaveToImage(XlsFil);

            if (Path.Length > 0) ImageAnl.ImageUrl = "DynamicImage.aspx?path=" + XlsFil;
            ImageAnl.Width = 950;
            ImageAnl.Height = 950;
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

        <%-- ============================  верхний блок  ============================================ --%>
        <div id="large"  
            onclick='document.write("<div onClick=print(); />"+document.getElementById("large").innerHTML+"</div>");' title="Печать" > 
           <asp:Image ID="ImageAnl" runat="server" ImageUrl="file://localhost/D://IMAGES/201410/00042885A.JPG"  Width="100%"  Height="100%" />
       </div> 

       

    </form>

    <%-- ------------------------------------- 
              <img src="example/big/image01.jpg" /> 
      
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



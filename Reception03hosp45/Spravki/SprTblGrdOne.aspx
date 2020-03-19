<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['H'] = '[012 ]';
            $.mask.definitions['M'] = '[0123456789 ]';
            $('#Txt011').mask('H9:M9-H9:M9');
            $('#Txt012').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt021').mask('H9:M9-H9:M9');
            $('#Txt022').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt031').mask('H9:M9-H9:M9');
            $('#Txt032').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt041').mask('H9:M9-H9:M9');
            $('#Txt042').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt051').mask('H9:M9-H9:M9');
            $('#Txt052').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt061').mask('H9:M9-H9:M9');
            $('#Txt062').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt071').mask('H9:M9-H9:M9');
            $('#Txt072').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt081').mask('H9:M9-H9:M9');
            $('#Txt082').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt091').mask('H9:M9-H9:M9');
            $('#Txt092').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt101').mask('H9:M9-H9:M9');
            $('#Txt102').mask('HM:MM-HM:MM', {placeholder: " " });

            $('#Txt111').mask('H9:M9-H9:M9');
            $('#Txt112').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt121').mask('H9:M9-H9:M9');
            $('#Txt122').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt131').mask('H9:M9-H9:M9');
            $('#Txt132').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt141').mask('H9:M9-H9:M9');
            $('#Txt142').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt151').mask('H9:M9-H9:M9');
            $('#Txt152').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt161').mask('H9:M9-H9:M9');
            $('#Txt162').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt171').mask('H9:M9-H9:M9');
            $('#Txt172').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt181').mask('H9:M9-H9:M9');
            $('#Txt182').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt191').mask('H9:M9-H9:M9');
            $('#Txt192').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt201').mask('H9:M9-H9:M9');
            $('#Txt202').mask('HM:MM-HM:MM', {placeholder: " " });

            $('#Txt211').mask('H9:M9-H9:M9');
            $('#Txt212').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt221').mask('H9:M9-H9:M9');
            $('#Txt222').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt231').mask('H9:M9-H9:M9');
            $('#Txt232').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt241').mask('H9:M9-H9:M9');
            $('#Txt242').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt251').mask('H9:M9-H9:M9');
            $('#Txt252').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt261').mask('H9:M9-H9:M9');
            $('#Txt262').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt271').mask('H9:M9-H9:M9');
            $('#Txt272').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt281').mask('H9:M9-H9:M9');
            $('#Txt282').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt291').mask('H9:M9-H9:M9');
            $('#Txt292').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt301').mask('H9:M9-H9:M9');
            $('#Txt302').mask('HM:MM-HM:MM', {placeholder: " " });
            $('#Txt311').mask('H9:M9-H9:M9');
            $('#Txt312').mask('HM:MM-HM:MM', {placeholder: " " });
        };

        /*------------------------- Изиять переданный параметр --------------------------------*/
 
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string TblIdn;
    string TblFio;
    string TblDlg;
    
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

        TblIdn = Convert.ToString(Request.QueryString["TblIdn"]);
        TblFio = Convert.ToString(Request.QueryString["TblFio"]);
        TblDlg = Convert.ToString(Request.QueryString["TblDlg"]);

        BoxTit.Text = TblFio + " " + TblDlg;

        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];


        if (!Page.IsPostBack)
        {
            TekTblIdn.Value = Convert.ToString(TblIdn);

            GetGrid();
        }
    }
    

    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {
        int God;
        int Mes;

        DataSet ds = new DataSet();
        
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT * FROM TABGRFTBL WHERE TABIDN="+TblIdn, con);

    //    cmd = new SqlCommand("SprTblGrdOne", con);
        // указать тип команды
   //     cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
   //     cmd.Parameters.Add("@TBLKOD", SqlDbType.VarChar).Value = TblIdn;
        
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "SprTblGrdOne");
     
        if (ds.Tables[0].Rows.Count > 0)
        {

       //     BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["TABFIO"]) + " " + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]);
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
           // FioTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["TblFIO"]);
            TxtOdx.Text = Convert.ToString(ds.Tables[0].Rows[0]["TABODX"]);
                 
            Txt011.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB001"]);
            Txt012.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP001"]);
            Txt013.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES001"]);
            Txt021.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB002"]);
            Txt022.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP002"]);
            Txt023.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES002"]);
            Txt031.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB003"]);
            Txt032.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP003"]);
            Txt033.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES003"]);
            Txt041.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB004"]);
            Txt042.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP004"]);
            Txt043.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES004"]);
            Txt051.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB005"]);
            Txt052.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP005"]);
            Txt053.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES005"]);
            Txt061.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB006"]);
            Txt062.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP006"]);
            Txt063.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES006"]);
            Txt071.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB007"]);
            Txt072.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP007"]);
            Txt073.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES007"]);
            Txt081.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB008"]);
            Txt082.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP008"]);
            Txt083.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES008"]);
            Txt091.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB009"]);
            Txt092.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP009"]);
            Txt093.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES009"]);
            Txt101.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB010"]);
            Txt102.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP010"]);
            Txt103.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES010"]);

            Txt111.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB011"]);
            Txt112.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP011"]);
            Txt113.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES011"]);
            Txt121.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB012"]);
            Txt122.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP012"]);
            Txt123.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES012"]);
            Txt131.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB013"]);
            Txt132.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP013"]);
            Txt133.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES013"]);
            Txt141.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB014"]);
            Txt142.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP014"]);
            Txt143.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES014"]);
            Txt151.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB015"]);
            Txt152.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP015"]);
            Txt153.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES015"]);
            Txt161.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB016"]);
            Txt162.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP016"]);
            Txt163.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES016"]);
            Txt171.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB017"]);
            Txt172.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP017"]);
            Txt173.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES017"]);
            Txt181.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB018"]);
            Txt182.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP018"]);
            Txt183.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES018"]);
            Txt191.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB019"]);
            Txt192.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP019"]);
            Txt193.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES019"]);
            Txt201.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB020"]);
            Txt202.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP020"]);
            Txt203.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES020"]);

            Txt211.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB021"]);
            Txt212.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP021"]);
            Txt213.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES021"]);
            Txt221.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB022"]);
            Txt222.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP022"]);
            Txt223.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES022"]);
            Txt231.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB023"]);
            Txt232.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP023"]);
            Txt233.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES023"]);
            Txt241.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB024"]);
            Txt242.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP024"]);
            Txt243.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES024"]);
            Txt251.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB025"]);
            Txt252.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP025"]);
            Txt253.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES025"]);
            Txt261.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB026"]);
            Txt262.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP026"]);
            Txt263.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES026"]);
            Txt271.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB027"]);
            Txt272.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP027"]);
            Txt273.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES027"]);
            Txt281.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB028"]);
            Txt282.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP028"]);
            Txt283.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES028"]);
            Txt291.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB029"]);
            Txt292.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP029"]);
            Txt293.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES029"]);
            Txt301.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB030"]);
            Txt302.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP030"]);
            Txt303.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES030"]);
            Txt311.Text = Convert.ToString(ds.Tables[0].Rows[0]["TAB031"]);
            Txt312.Text = Convert.ToString(ds.Tables[0].Rows[0]["SUP031"]);
            Txt313.Text = Convert.ToString(ds.Tables[0].Rows[0]["RES031"]);

            Txt014.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM001"]);
            Txt024.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM002"]);
            Txt034.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM003"]);
            Txt044.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM004"]);
            Txt054.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM005"]);
            Txt064.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM006"]);
            Txt074.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM007"]);
            Txt084.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM008"]);
            Txt094.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM009"]);
            Txt104.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM010"]);
            Txt114.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM011"]);
            Txt124.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM012"]);
            Txt134.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM013"]);
            Txt144.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM014"]);
            Txt154.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM015"]);
            Txt164.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM016"]);
            Txt174.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM017"]);
            Txt184.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM018"]);
            Txt194.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM019"]);
            Txt204.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM020"]);
            Txt214.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM021"]);
            Txt224.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM022"]);
            Txt234.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM023"]);
            Txt244.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM024"]);
            Txt254.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM025"]);
            Txt264.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM026"]);
            Txt274.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM027"]);
            Txt284.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM028"]);
            Txt294.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM029"]);
            Txt304.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM030"]);
            Txt314.Text = Convert.ToString(ds.Tables[0].Rows[0]["TIM031"]);

            God = Convert.ToInt32(ds.Tables[0].Rows[0]["TABGOD"]);
            Mes = Convert.ToInt32(ds.Tables[0].Rows[0]["TABMES"]);
            
            DateTime dateValue = new DateTime(God, Mes, 1);
            Lbl001.Text = "01: " + dateValue.ToString("ddd");
            Lbl002.Text = "02: " + dateValue.AddDays(01).ToString("ddd");
            Lbl003.Text = "03: " + dateValue.AddDays(02).ToString("ddd");
            Lbl004.Text = "04: " + dateValue.AddDays(03).ToString("ddd");
            Lbl005.Text = "05: " + dateValue.AddDays(04).ToString("ddd");
            Lbl006.Text = "06: " + dateValue.AddDays(05).ToString("ddd");
            Lbl007.Text = "07: " + dateValue.AddDays(06).ToString("ddd");
            Lbl008.Text = "08: " + dateValue.AddDays(07).ToString("ddd");
            Lbl009.Text = "09: " + dateValue.AddDays(08).ToString("ddd");
            Lbl010.Text = "10: " + dateValue.AddDays(09).ToString("ddd");
            Lbl011.Text = "11: " + dateValue.AddDays(10).ToString("ddd");
            Lbl012.Text = "12: " + dateValue.AddDays(11).ToString("ddd");
            Lbl013.Text = "13: " + dateValue.AddDays(12).ToString("ddd");
            Lbl014.Text = "14: " + dateValue.AddDays(13).ToString("ddd");
            Lbl015.Text = "15: " + dateValue.AddDays(14).ToString("ddd");
            Lbl016.Text = "16: " + dateValue.AddDays(15).ToString("ddd");
            Lbl017.Text = "17: " + dateValue.AddDays(16).ToString("ddd");
            Lbl018.Text = "18: " + dateValue.AddDays(17).ToString("ddd");
            Lbl019.Text = "19: " + dateValue.AddDays(18).ToString("ddd");
            Lbl020.Text = "20: " + dateValue.AddDays(19).ToString("ddd");
            Lbl021.Text = "21: " + dateValue.AddDays(20).ToString("ddd");
            Lbl022.Text = "22: " + dateValue.AddDays(21).ToString("ddd");
            Lbl023.Text = "23: " + dateValue.AddDays(22).ToString("ddd");
            Lbl024.Text = "24: " + dateValue.AddDays(23).ToString("ddd");
            Lbl025.Text = "25: " + dateValue.AddDays(24).ToString("ddd");
            Lbl026.Text = "26: " + dateValue.AddDays(25).ToString("ddd");
            Lbl027.Text = "27: " + dateValue.AddDays(26).ToString("ddd");
            Lbl028.Text = "28: " + dateValue.AddDays(27).ToString("ddd");
            Lbl029.Text = "29: " + dateValue.AddDays(28).ToString("ddd");
            Lbl030.Text = "30: " + dateValue.AddDays(29).ToString("ddd");
            Lbl031.Text = "31: " + dateValue.AddDays(30).ToString("ddd");
          
        }
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }
    //------------------------------------------------------------------------
    
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {
            int BuxOdx;
            int myNum = 0;

            if (Int32.TryParse(TxtOdx.Text, out BuxOdx))
            {
                BuxOdx = Convert.ToInt32(TxtOdx.Text);
            }
            else
            {
                BuxOdx = 0;
            }

  //          if (Convert.ToString(TxtOdx.Text) == null || Convert.ToString(TxtOdx.Text) == "") BuxOdx = 1;
  //          else BuxOdx = Convert.ToInt32(TxtOdx.Text);
         
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprTblGrdOne", con);
            cmd = new SqlCommand("HspSprTblGrdOne", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@TABIDN", SqlDbType.VarChar).Value = TblIdn;
            cmd.Parameters.Add("@TABODX", SqlDbType.VarChar).Value = BuxOdx;
            cmd.Parameters.Add("@TAB011", SqlDbType.VarChar).Value = Txt011.Text;
            cmd.Parameters.Add("@TAB012", SqlDbType.VarChar).Value = Txt012.Text;
            cmd.Parameters.Add("@TAB013", SqlDbType.VarChar).Value = Txt013.Text;
            cmd.Parameters.Add("@TAB021", SqlDbType.VarChar).Value = Txt021.Text;
            cmd.Parameters.Add("@TAB022", SqlDbType.VarChar).Value = Txt022.Text;
            cmd.Parameters.Add("@TAB023", SqlDbType.VarChar).Value = Txt023.Text;
            cmd.Parameters.Add("@TAB031", SqlDbType.VarChar).Value = Txt031.Text;
            cmd.Parameters.Add("@TAB032", SqlDbType.VarChar).Value = Txt032.Text;
            cmd.Parameters.Add("@TAB033", SqlDbType.VarChar).Value = Txt033.Text;
            cmd.Parameters.Add("@TAB041", SqlDbType.VarChar).Value = Txt041.Text;
            cmd.Parameters.Add("@TAB042", SqlDbType.VarChar).Value = Txt042.Text;
            cmd.Parameters.Add("@TAB043", SqlDbType.VarChar).Value = Txt043.Text;
            cmd.Parameters.Add("@TAB051", SqlDbType.VarChar).Value = Txt051.Text;
            cmd.Parameters.Add("@TAB052", SqlDbType.VarChar).Value = Txt052.Text;
            cmd.Parameters.Add("@TAB053", SqlDbType.VarChar).Value = Txt053.Text;
            cmd.Parameters.Add("@TAB061", SqlDbType.VarChar).Value = Txt061.Text;
            cmd.Parameters.Add("@TAB062", SqlDbType.VarChar).Value = Txt062.Text;
            cmd.Parameters.Add("@TAB063", SqlDbType.VarChar).Value = Txt063.Text;
            cmd.Parameters.Add("@TAB071", SqlDbType.VarChar).Value = Txt071.Text;
            cmd.Parameters.Add("@TAB072", SqlDbType.VarChar).Value = Txt072.Text;
            cmd.Parameters.Add("@TAB073", SqlDbType.VarChar).Value = Txt073.Text;
            cmd.Parameters.Add("@TAB081", SqlDbType.VarChar).Value = Txt081.Text;
            cmd.Parameters.Add("@TAB082", SqlDbType.VarChar).Value = Txt082.Text;
            cmd.Parameters.Add("@TAB083", SqlDbType.VarChar).Value = Txt083.Text;
            cmd.Parameters.Add("@TAB091", SqlDbType.VarChar).Value = Txt091.Text;
            cmd.Parameters.Add("@TAB092", SqlDbType.VarChar).Value = Txt092.Text;
            cmd.Parameters.Add("@TAB093", SqlDbType.VarChar).Value = Txt093.Text;
            cmd.Parameters.Add("@TAB101", SqlDbType.VarChar).Value = Txt101.Text;
            cmd.Parameters.Add("@TAB102", SqlDbType.VarChar).Value = Txt102.Text;
            cmd.Parameters.Add("@TAB103", SqlDbType.VarChar).Value = Txt103.Text;

            cmd.Parameters.Add("@TAB111", SqlDbType.VarChar).Value = Txt111.Text;
            cmd.Parameters.Add("@TAB112", SqlDbType.VarChar).Value = Txt112.Text;
            cmd.Parameters.Add("@TAB113", SqlDbType.VarChar).Value = Txt113.Text;
            cmd.Parameters.Add("@TAB121", SqlDbType.VarChar).Value = Txt121.Text;
            cmd.Parameters.Add("@TAB122", SqlDbType.VarChar).Value = Txt122.Text;
            cmd.Parameters.Add("@TAB123", SqlDbType.VarChar).Value = Txt123.Text;
            cmd.Parameters.Add("@TAB131", SqlDbType.VarChar).Value = Txt131.Text;
            cmd.Parameters.Add("@TAB132", SqlDbType.VarChar).Value = Txt132.Text;
            cmd.Parameters.Add("@TAB133", SqlDbType.VarChar).Value = Txt133.Text;
            cmd.Parameters.Add("@TAB141", SqlDbType.VarChar).Value = Txt141.Text;
            cmd.Parameters.Add("@TAB142", SqlDbType.VarChar).Value = Txt142.Text;
            cmd.Parameters.Add("@TAB143", SqlDbType.VarChar).Value = Txt143.Text;
            cmd.Parameters.Add("@TAB151", SqlDbType.VarChar).Value = Txt151.Text;
            cmd.Parameters.Add("@TAB152", SqlDbType.VarChar).Value = Txt152.Text;
            cmd.Parameters.Add("@TAB153", SqlDbType.VarChar).Value = Txt153.Text;
            cmd.Parameters.Add("@TAB161", SqlDbType.VarChar).Value = Txt161.Text;
            cmd.Parameters.Add("@TAB162", SqlDbType.VarChar).Value = Txt162.Text;
            cmd.Parameters.Add("@TAB163", SqlDbType.VarChar).Value = Txt163.Text;
            cmd.Parameters.Add("@TAB171", SqlDbType.VarChar).Value = Txt171.Text;
            cmd.Parameters.Add("@TAB172", SqlDbType.VarChar).Value = Txt172.Text;
            cmd.Parameters.Add("@TAB173", SqlDbType.VarChar).Value = Txt173.Text;
            cmd.Parameters.Add("@TAB181", SqlDbType.VarChar).Value = Txt181.Text;
            cmd.Parameters.Add("@TAB182", SqlDbType.VarChar).Value = Txt182.Text;
            cmd.Parameters.Add("@TAB183", SqlDbType.VarChar).Value = Txt183.Text;
            cmd.Parameters.Add("@TAB191", SqlDbType.VarChar).Value = Txt191.Text;
            cmd.Parameters.Add("@TAB192", SqlDbType.VarChar).Value = Txt192.Text;
            cmd.Parameters.Add("@TAB193", SqlDbType.VarChar).Value = Txt193.Text;
            cmd.Parameters.Add("@TAB201", SqlDbType.VarChar).Value = Txt201.Text;
            cmd.Parameters.Add("@TAB202", SqlDbType.VarChar).Value = Txt202.Text;
            cmd.Parameters.Add("@TAB203", SqlDbType.VarChar).Value = Txt203.Text;

            cmd.Parameters.Add("@TAB211", SqlDbType.VarChar).Value = Txt211.Text;
            cmd.Parameters.Add("@TAB212", SqlDbType.VarChar).Value = Txt212.Text;
            cmd.Parameters.Add("@TAB213", SqlDbType.VarChar).Value = Txt213.Text;
            cmd.Parameters.Add("@TAB221", SqlDbType.VarChar).Value = Txt221.Text;
            cmd.Parameters.Add("@TAB222", SqlDbType.VarChar).Value = Txt222.Text;
            cmd.Parameters.Add("@TAB223", SqlDbType.VarChar).Value = Txt223.Text;
            cmd.Parameters.Add("@TAB231", SqlDbType.VarChar).Value = Txt231.Text;
            cmd.Parameters.Add("@TAB232", SqlDbType.VarChar).Value = Txt232.Text;
            cmd.Parameters.Add("@TAB233", SqlDbType.VarChar).Value = Txt233.Text;
            cmd.Parameters.Add("@TAB241", SqlDbType.VarChar).Value = Txt241.Text;
            cmd.Parameters.Add("@TAB242", SqlDbType.VarChar).Value = Txt242.Text;
            cmd.Parameters.Add("@TAB243", SqlDbType.VarChar).Value = Txt243.Text;
            cmd.Parameters.Add("@TAB251", SqlDbType.VarChar).Value = Txt251.Text;
            cmd.Parameters.Add("@TAB252", SqlDbType.VarChar).Value = Txt252.Text;
            cmd.Parameters.Add("@TAB253", SqlDbType.VarChar).Value = Txt253.Text;
            cmd.Parameters.Add("@TAB261", SqlDbType.VarChar).Value = Txt261.Text;
            cmd.Parameters.Add("@TAB262", SqlDbType.VarChar).Value = Txt262.Text;
            cmd.Parameters.Add("@TAB263", SqlDbType.VarChar).Value = Txt263.Text;
            cmd.Parameters.Add("@TAB271", SqlDbType.VarChar).Value = Txt271.Text;
            cmd.Parameters.Add("@TAB272", SqlDbType.VarChar).Value = Txt272.Text;
            cmd.Parameters.Add("@TAB273", SqlDbType.VarChar).Value = Txt273.Text;
            cmd.Parameters.Add("@TAB281", SqlDbType.VarChar).Value = Txt281.Text;
            cmd.Parameters.Add("@TAB282", SqlDbType.VarChar).Value = Txt282.Text;
            cmd.Parameters.Add("@TAB283", SqlDbType.VarChar).Value = Txt283.Text;
            cmd.Parameters.Add("@TAB291", SqlDbType.VarChar).Value = Txt291.Text;
            cmd.Parameters.Add("@TAB292", SqlDbType.VarChar).Value = Txt292.Text;
            cmd.Parameters.Add("@TAB293", SqlDbType.VarChar).Value = Txt293.Text;
            cmd.Parameters.Add("@TAB301", SqlDbType.VarChar).Value = Txt301.Text;
            cmd.Parameters.Add("@TAB302", SqlDbType.VarChar).Value = Txt302.Text;
            cmd.Parameters.Add("@TAB303", SqlDbType.VarChar).Value = Txt303.Text;
            cmd.Parameters.Add("@TAB311", SqlDbType.VarChar).Value = Txt311.Text;
            cmd.Parameters.Add("@TAB312", SqlDbType.VarChar).Value = Txt312.Text;
            cmd.Parameters.Add("@TAB313", SqlDbType.VarChar).Value = Txt313.Text;

            cmd.Parameters.Add("@TIM001", SqlDbType.VarChar).Value = Txt014.Text;
            cmd.Parameters.Add("@TIM002", SqlDbType.VarChar).Value = Txt024.Text;
            cmd.Parameters.Add("@TIM003", SqlDbType.VarChar).Value = Txt034.Text;
            cmd.Parameters.Add("@TIM004", SqlDbType.VarChar).Value = Txt044.Text;
            cmd.Parameters.Add("@TIM005", SqlDbType.VarChar).Value = Txt054.Text;
            cmd.Parameters.Add("@TIM006", SqlDbType.VarChar).Value = Txt064.Text;
            cmd.Parameters.Add("@TIM007", SqlDbType.VarChar).Value = Txt074.Text;
            cmd.Parameters.Add("@TIM008", SqlDbType.VarChar).Value = Txt084.Text;
            cmd.Parameters.Add("@TIM009", SqlDbType.VarChar).Value = Txt094.Text;
            cmd.Parameters.Add("@TIM010", SqlDbType.VarChar).Value = Txt104.Text;
            cmd.Parameters.Add("@TIM011", SqlDbType.VarChar).Value = Txt114.Text;
            cmd.Parameters.Add("@TIM012", SqlDbType.VarChar).Value = Txt124.Text;
            cmd.Parameters.Add("@TIM013", SqlDbType.VarChar).Value = Txt134.Text;
            cmd.Parameters.Add("@TIM014", SqlDbType.VarChar).Value = Txt144.Text;
            cmd.Parameters.Add("@TIM015", SqlDbType.VarChar).Value = Txt154.Text;
            cmd.Parameters.Add("@TIM016", SqlDbType.VarChar).Value = Txt164.Text;
            cmd.Parameters.Add("@TIM017", SqlDbType.VarChar).Value = Txt174.Text;
            cmd.Parameters.Add("@TIM018", SqlDbType.VarChar).Value = Txt184.Text;
            cmd.Parameters.Add("@TIM019", SqlDbType.VarChar).Value = Txt194.Text;
            cmd.Parameters.Add("@TIM020", SqlDbType.VarChar).Value = Txt204.Text;
            cmd.Parameters.Add("@TIM021", SqlDbType.VarChar).Value = Txt214.Text;
            cmd.Parameters.Add("@TIM022", SqlDbType.VarChar).Value = Txt224.Text;
            cmd.Parameters.Add("@TIM023", SqlDbType.VarChar).Value = Txt234.Text;
            cmd.Parameters.Add("@TIM024", SqlDbType.VarChar).Value = Txt244.Text;
            cmd.Parameters.Add("@TIM025", SqlDbType.VarChar).Value = Txt254.Text;
            cmd.Parameters.Add("@TIM026", SqlDbType.VarChar).Value = Txt264.Text;
            cmd.Parameters.Add("@TIM027", SqlDbType.VarChar).Value = Txt274.Text;
            cmd.Parameters.Add("@TIM028", SqlDbType.VarChar).Value = Txt284.Text;
            cmd.Parameters.Add("@TIM029", SqlDbType.VarChar).Value = Txt294.Text;
            cmd.Parameters.Add("@TIM030", SqlDbType.VarChar).Value = Txt304.Text;
            cmd.Parameters.Add("@TIM031", SqlDbType.VarChar).Value = Txt314.Text;

            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();

            // ------------------------------------------------------------------------------заполняем второй уровень
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
    
    }


    //------------------------------------------------------------------------

    //------------------------------------------------------------------------


</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekTblIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 570px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>
         
            <table border="0" cellspacing="0" width="90%" cellpadding="0">
                       <tr style="Height:15px"> 
                            <td width="12%" class="PO_RowCap">
                            </td>
                             <td width="21%" style="vertical-align: top;">
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="TextBox9" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="Обед (минут)" ReadOnly="true"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="TxtOdx" width="100%" BackColor="White" Font-Bold="true" Height="15px" ></asp:TextBox>
                            </td>
                              <td width="21%" style="vertical-align: top;">
                            </td>
                       </tr>
         </table>

        <table border="0" cellspacing="0" width="90%" cellpadding="0">
                       <tr style="Height:15px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="TextBox4" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="Дни" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="TextBox5" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="График" ReadOnly="true"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="TextBox6" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="Табель" ReadOnly="true"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="TextBox10" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="Приказы, БЛ" ReadOnly="true"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="TextBox11" width="100%" BackColor="White" Font-Bold="true" Height="15px" Text="Расчетная время" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
 <!--  Фамилия , Страховщик ------------------------------------------------------------------------------------------------------  -->  
                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl001" width="100%" BackColor="White" Height="10px" Text="01:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt011" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt012" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt014" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt013" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl002" width="100%" BackColor="White" Height="10px" Text="02:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt021" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt022" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt024" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td> 
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt023" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl003" width="100%" BackColor="White" Height="10px" Text="03:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt031" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt032" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt034" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt033" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl004" width="100%" BackColor="White" Height="10px" Text="04:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt041" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt042" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt044" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt043" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl005" width="100%" BackColor="White" Height="10px" Text="05:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt051" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt052" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt054" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt053" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl006" width="100%" BackColor="White" Height="10px" Text="06:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt061" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt062" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt064" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt063" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl007" width="100%" BackColor="White" Height="10px" Text="07:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt071" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt072" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt074" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt073" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl008" width="100%" BackColor="White" Height="10px" Text="08:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt081" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt082" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt084" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt083" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl009" width="100%" BackColor="White" Height="10px" Text="09:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt091" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt092" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt094" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt093" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl010" width="100%" BackColor="White" Height="10px" Text="10:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt101" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt102" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt104" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt103" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl011" width="100%" BackColor="White" Height="10px" Text="11:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt111" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt112" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt114" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt113" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl012" width="100%" BackColor="White" Height="10px" Text="12:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt121" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt122" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt124" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt123" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl013" width="100%" BackColor="White" Height="10px" Text="13:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt131" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt132" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt134" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt133" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl014" width="100%" BackColor="White" Height="10px" Text="14:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt141" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt142" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt144" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt143" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl015" width="100%" BackColor="White" Height="10px" Text="15:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt151" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt152" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt154" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt153" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl016" width="100%" BackColor="White" Height="10px" Text="16:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt161" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt162" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt164" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt163" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl017" width="100%" BackColor="White" Height="10px" Text="17:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt171" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt172" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt174" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt173" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl018" width="100%" BackColor="White" Height="10px" Text="18:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt181" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt182" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt184" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt183" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl019" width="100%" BackColor="White" Height="10px" Text="19:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt191" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt192" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt194" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt193" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl020" width="100%" BackColor="White" Height="10px" Text="20:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt201" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt202" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt204" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt203" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl021" width="100%" BackColor="White" Height="10px" Text="21:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt211" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt212" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt214" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt213" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl022" width="100%" BackColor="White" Height="10px" Text="22:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt221" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt222" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                              <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt224" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt223" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl023" width="100%" BackColor="White" Height="10px" Text="23:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt231" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt232" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt234" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt233" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl024" width="100%" BackColor="White" Height="10px" Text="24:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt241" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt242" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt244" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt243" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>


                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl025" width="100%" BackColor="White" Height="10px" Text="25:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt251" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt252" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt254" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt253" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl026" width="100%" BackColor="White" Height="10px" Text="26:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt261" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt262" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt264" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt263" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl027" width="100%" BackColor="White" Height="10px" Text="27:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt271" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt272" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt274" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt273" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl028" width="100%" BackColor="White" Height="10px" Text="28:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt281" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt282" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt284" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt283" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl029" width="100%" BackColor="White" Height="10px" Text="29:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt291" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt292" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt294" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt293" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl030" width="100%" BackColor="White" Height="10px" Text="30:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt301" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt302" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt304" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt303" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>

                         <tr style="Height:10px"> 
                            <td width="12%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Lbl031" width="100%" BackColor="White" Height="10px" Text="31:" ReadOnly="true"></asp:TextBox>
                            </td>
                             <td width="21%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="Txt311" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>                                                         
                             <td width="21%" class="PO_RowCap">
                                 <asp:TextBox runat="server" ID="Txt312" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt314" width="100%" BackColor="White" Font-Bold="true" Height="10px"></asp:TextBox>
                             </td>
                             <td width="21%" style="vertical-align: top;">
                                  <asp:TextBox runat="server" ID="Txt313" width="100%" BackColor="White" Height="10px"></asp:TextBox>
                            </td>
                        </tr>
      </table>
         </asp:Panel>
 
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 30px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
               </center>
           </asp:Panel>


<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>


    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
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
            font-size: 12px;
            outline: 0;
            width: 100%;
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
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
         .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
       
    }

    </style>


</body>

</html>



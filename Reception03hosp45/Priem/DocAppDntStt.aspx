<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

 <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;
         //         alert("DocAppAmbPsm");

         //    ------------------ смена логотипа ----------------------------------------------------------
         function getQueryString() {
             var queryString = [];
             var vars = [];
             var hash;
             var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
             //           alert("hashes=" + hashes);
             for (var i = 0; i < hashes.length; i++) {
                 hash = hashes[i].split('=');
                 queryString.push(hash[0]);
                 vars[hash[0]] = hash[1];
                 queryString.push(hash[1]);
             }
             return queryString;
         }
         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

  //           alert("  GrfDocRek=" + GrfDocRek + "  GrfDocVal=" + GrfDocVal + "  GrfDocTyp=" + GrfDocTyp);

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBSTTDNT';
             var DatDocKey = 'ZUBAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

//             alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
             DatDocTyp = 'Sql';
             SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;

 //            alert("SqlStr=" + SqlStr);

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

         // ==================================== при выборе клиента показывает его программу  ============================================
 
         function OnClientDblClick(iRecordIndex) {
 //            alert("OnClientDblClick= " + iRecordIndex);
 //            alert("parDntNum.value= " + parDntNum.value);
             var GrfDocRek;
             var GrfDocVal = gridDnt.Rows[iRecordIndex].Cells[1].Value;

             if (parDntNum.value == '018') { Txt018.value = GrfDocVal; GrfDocRek = 'ZUB018'; }
             if (parDntNum.value == '017') { Txt017.value = GrfDocVal; GrfDocRek = 'ZUB017'; }
             if (parDntNum.value == '016') { Txt016.value = GrfDocVal; GrfDocRek = 'ZUB016'; }
             if (parDntNum.value == '015') { Txt015.value = GrfDocVal; GrfDocRek = 'ZUB015'; }
             if (parDntNum.value == '014') { Txt014.value = GrfDocVal; GrfDocRek = 'ZUB014'; }
             if (parDntNum.value == '013') { Txt013.value = GrfDocVal; GrfDocRek = 'ZUB013'; }
             if (parDntNum.value == '012') { Txt012.value = GrfDocVal; GrfDocRek = 'ZUB012'; }
             if (parDntNum.value == '011') { Txt011.value = GrfDocVal; GrfDocRek = 'ZUB011'; }
             if (parDntNum.value == '021') { Txt021.value = GrfDocVal; GrfDocRek = 'ZUB021'; }
             if (parDntNum.value == '022') { Txt022.value = GrfDocVal; GrfDocRek = 'ZUB022'; }
             if (parDntNum.value == '023') { Txt023.value = GrfDocVal; GrfDocRek = 'ZUB023'; }
             if (parDntNum.value == '024') { Txt024.value = GrfDocVal; GrfDocRek = 'ZUB024'; }
             if (parDntNum.value == '025') { Txt025.value = GrfDocVal; GrfDocRek = 'ZUB025'; }
             if (parDntNum.value == '026') { Txt026.value = GrfDocVal; GrfDocRek = 'ZUB026'; }
             if (parDntNum.value == '027') { Txt027.value = GrfDocVal; GrfDocRek = 'ZUB027'; }
             if (parDntNum.value == '028') { Txt028.value = GrfDocVal; GrfDocRek = 'ZUB028'; }

             if (parDntNum.value == '038') { Txt038.value = GrfDocVal; GrfDocRek = 'ZUB038'; }
             if (parDntNum.value == '037') { Txt037.value = GrfDocVal; GrfDocRek = 'ZUB037'; }
             if (parDntNum.value == '036') { Txt036.value = GrfDocVal; GrfDocRek = 'ZUB036'; }
             if (parDntNum.value == '035') { Txt035.value = GrfDocVal; GrfDocRek = 'ZUB035'; }
             if (parDntNum.value == '034') { Txt034.value = GrfDocVal; GrfDocRek = 'ZUB034'; }
             if (parDntNum.value == '033') { Txt033.value = GrfDocVal; GrfDocRek = 'ZUB033'; }
             if (parDntNum.value == '032') { Txt032.value = GrfDocVal; GrfDocRek = 'ZUB032'; }
             if (parDntNum.value == '031') { Txt031.value = GrfDocVal; GrfDocRek = 'ZUB031'; }
             if (parDntNum.value == '041') { Txt041.value = GrfDocVal; GrfDocRek = 'ZUB041'; }
             if (parDntNum.value == '042') { Txt042.value = GrfDocVal; GrfDocRek = 'ZUB042'; }
             if (parDntNum.value == '043') { Txt043.value = GrfDocVal; GrfDocRek = 'ZUB043'; }
             if (parDntNum.value == '044') { Txt044.value = GrfDocVal; GrfDocRek = 'ZUB044'; }
             if (parDntNum.value == '045') { Txt045.value = GrfDocVal; GrfDocRek = 'ZUB045'; }
             if (parDntNum.value == '046') { Txt046.value = GrfDocVal; GrfDocRek = 'ZUB046'; }
             if (parDntNum.value == '047') { Txt047.value = GrfDocVal; GrfDocRek = 'ZUB047'; }
             if (parDntNum.value == '048') { Txt048.value = GrfDocVal; GrfDocRek = 'ZUB048'; }


             if (parDntNum.value == '118') { Txt118.value = GrfDocVal; GrfDocRek = 'ZUB118'; }
             if (parDntNum.value == '117') { Txt117.value = GrfDocVal; GrfDocRek = 'ZUB117'; }
             if (parDntNum.value == '116') { Txt116.value = GrfDocVal; GrfDocRek = 'ZUB116'; }
             if (parDntNum.value == '115') { Txt115.value = GrfDocVal; GrfDocRek = 'ZUB115'; }
             if (parDntNum.value == '114') { Txt114.value = GrfDocVal; GrfDocRek = 'ZUB114'; }
             if (parDntNum.value == '113') { Txt113.value = GrfDocVal; GrfDocRek = 'ZUB113'; }
             if (parDntNum.value == '112') { Txt112.value = GrfDocVal; GrfDocRek = 'ZUB112'; }
             if (parDntNum.value == '111') { Txt111.value = GrfDocVal; GrfDocRek = 'ZUB111'; }
             if (parDntNum.value == '121') { Txt121.value = GrfDocVal; GrfDocRek = 'ZUB121'; }
             if (parDntNum.value == '122') { Txt122.value = GrfDocVal; GrfDocRek = 'ZUB122'; }
             if (parDntNum.value == '123') { Txt123.value = GrfDocVal; GrfDocRek = 'ZUB123'; }
             if (parDntNum.value == '124') { Txt124.value = GrfDocVal; GrfDocRek = 'ZUB124'; }
             if (parDntNum.value == '125') { Txt125.value = GrfDocVal; GrfDocRek = 'ZUB125'; }
             if (parDntNum.value == '126') { Txt126.value = GrfDocVal; GrfDocRek = 'ZUB126'; }
             if (parDntNum.value == '127') { Txt127.value = GrfDocVal; GrfDocRek = 'ZUB127'; }
             if (parDntNum.value == '128') { Txt128.value = GrfDocVal; GrfDocRek = 'ZUB128'; }

             if (parDntNum.value == '138') { Txt138.value = GrfDocVal; GrfDocRek = 'ZUB138'; }
             if (parDntNum.value == '137') { Txt137.value = GrfDocVal; GrfDocRek = 'ZUB137'; }
             if (parDntNum.value == '136') { Txt136.value = GrfDocVal; GrfDocRek = 'ZUB136'; }
             if (parDntNum.value == '135') { Txt135.value = GrfDocVal; GrfDocRek = 'ZUB135'; }
             if (parDntNum.value == '134') { Txt134.value = GrfDocVal; GrfDocRek = 'ZUB134'; }
             if (parDntNum.value == '133') { Txt133.value = GrfDocVal; GrfDocRek = 'ZUB133'; }
             if (parDntNum.value == '132') { Txt132.value = GrfDocVal; GrfDocRek = 'ZUB132'; }
             if (parDntNum.value == '131') { Txt131.value = GrfDocVal; GrfDocRek = 'ZUB131'; }
             if (parDntNum.value == '141') { Txt141.value = GrfDocVal; GrfDocRek = 'ZUB141'; }
             if (parDntNum.value == '142') { Txt142.value = GrfDocVal; GrfDocRek = 'ZUB142'; }
             if (parDntNum.value == '143') { Txt143.value = GrfDocVal; GrfDocRek = 'ZUB143'; }
             if (parDntNum.value == '144') { Txt144.value = GrfDocVal; GrfDocRek = 'ZUB144'; }
             if (parDntNum.value == '145') { Txt145.value = GrfDocVal; GrfDocRek = 'ZUB145'; }
             if (parDntNum.value == '146') { Txt146.value = GrfDocVal; GrfDocRek = 'ZUB146'; }
             if (parDntNum.value == '147') { Txt147.value = GrfDocVal; GrfDocRek = 'ZUB147'; }
             if (parDntNum.value == '148') { Txt148.value = GrfDocVal; GrfDocRek = 'ZUB148'; }

             DntWindow.Close();

             onChangeUpd(GrfDocRek, GrfDocVal, 'Sql');
         }
         //    ------------------------------------------------------------------------------------------------------------------------

         function Txt018_Clicked() { parDntNum.value = '018'; DntWindow.Open(); }
         function Txt017_Clicked() { parDntNum.value = '017'; DntWindow.Open(); }
         function Txt016_Clicked() { parDntNum.value = '016'; DntWindow.Open(); }
         function Txt015_Clicked() { parDntNum.value = '015'; DntWindow.Open(); }
         function Txt014_Clicked() { parDntNum.value = '014'; DntWindow.Open(); }
         function Txt013_Clicked() { parDntNum.value = '013'; DntWindow.Open(); }
         function Txt012_Clicked() { parDntNum.value = '012'; DntWindow.Open(); }
         function Txt021_Clicked() { parDntNum.value = '011'; DntWindow.Open(); }
         function Txt021_Clicked() { parDntNum.value = '021'; DntWindow.Open(); }
         function Txt022_Clicked() { parDntNum.value = '022'; DntWindow.Open(); }
         function Txt023_Clicked() { parDntNum.value = '023'; DntWindow.Open(); }
         function Txt024_Clicked() { parDntNum.value = '024'; DntWindow.Open(); }
         function Txt025_Clicked() { parDntNum.value = '025'; DntWindow.Open(); }
         function Txt026_Clicked() { parDntNum.value = '026'; DntWindow.Open(); }
         function Txt027_Clicked() { parDntNum.value = '027'; DntWindow.Open(); }
         function Txt028_Clicked() { parDntNum.value = '028'; DntWindow.Open(); }

         function Txt038_Clicked() { parDntNum.value = '038'; DntWindow.Open(); }
         function Txt037_Clicked() { parDntNum.value = '037'; DntWindow.Open(); }
         function Txt036_Clicked() { parDntNum.value = '036'; DntWindow.Open(); }
         function Txt035_Clicked() { parDntNum.value = '035'; DntWindow.Open(); }
         function Txt034_Clicked() { parDntNum.value = '034'; DntWindow.Open(); }
         function Txt033_Clicked() { parDntNum.value = '033'; DntWindow.Open(); }
         function Txt032_Clicked() { parDntNum.value = '032'; DntWindow.Open(); }
         function Txt031_Clicked() { parDntNum.value = '031'; DntWindow.Open(); }
         function Txt041_Clicked() { parDntNum.value = '041'; DntWindow.Open(); }
         function Txt042_Clicked() { parDntNum.value = '042'; DntWindow.Open(); }
         function Txt043_Clicked() { parDntNum.value = '043'; DntWindow.Open(); }
         function Txt044_Clicked() { parDntNum.value = '044'; DntWindow.Open(); }
         function Txt045_Clicked() { parDntNum.value = '045'; DntWindow.Open(); }
         function Txt046_Clicked() { parDntNum.value = '046'; DntWindow.Open(); }
         function Txt047_Clicked() { parDntNum.value = '047'; DntWindow.Open(); }
         function Txt048_Clicked() { parDntNum.value = '048'; DntWindow.Open(); }


         function Txt118_Clicked() { parDntNum.value = '118'; DntWindow.Open(); }
         function Txt117_Clicked() { parDntNum.value = '117'; DntWindow.Open(); }
         function Txt116_Clicked() { parDntNum.value = '116'; DntWindow.Open(); }
         function Txt115_Clicked() { parDntNum.value = '115'; DntWindow.Open(); }
         function Txt114_Clicked() { parDntNum.value = '114'; DntWindow.Open(); }
         function Txt113_Clicked() { parDntNum.value = '113'; DntWindow.Open(); }
         function Txt112_Clicked() { parDntNum.value = '112'; DntWindow.Open(); }
         function Txt121_Clicked() { parDntNum.value = '111'; DntWindow.Open(); }
         function Txt121_Clicked() { parDntNum.value = '121'; DntWindow.Open(); }
         function Txt122_Clicked() { parDntNum.value = '122'; DntWindow.Open(); }
         function Txt123_Clicked() { parDntNum.value = '123'; DntWindow.Open(); }
         function Txt124_Clicked() { parDntNum.value = '124'; DntWindow.Open(); }
         function Txt125_Clicked() { parDntNum.value = '125'; DntWindow.Open(); }
         function Txt126_Clicked() { parDntNum.value = '126'; DntWindow.Open(); }
         function Txt127_Clicked() { parDntNum.value = '127'; DntWindow.Open(); }
         function Txt128_Clicked() { parDntNum.value = '128'; DntWindow.Open(); }

         function Txt138_Clicked() { parDntNum.value = '138'; DntWindow.Open(); }
         function Txt137_Clicked() { parDntNum.value = '137'; DntWindow.Open(); }
         function Txt136_Clicked() { parDntNum.value = '136'; DntWindow.Open(); }
         function Txt135_Clicked() { parDntNum.value = '135'; DntWindow.Open(); }
         function Txt134_Clicked() { parDntNum.value = '134'; DntWindow.Open(); }
         function Txt133_Clicked() { parDntNum.value = '133'; DntWindow.Open(); }
         function Txt132_Clicked() { parDntNum.value = '132'; DntWindow.Open(); }
         function Txt131_Clicked() { parDntNum.value = '131'; DntWindow.Open(); }
         function Txt141_Clicked() { parDntNum.value = '141'; DntWindow.Open(); }
         function Txt142_Clicked() { parDntNum.value = '142'; DntWindow.Open(); }
         function Txt143_Clicked() { parDntNum.value = '143'; DntWindow.Open(); }
         function Txt144_Clicked() { parDntNum.value = '144'; DntWindow.Open(); }
         function Txt145_Clicked() { parDntNum.value = '145'; DntWindow.Open(); }
         function Txt146_Clicked() { parDntNum.value = '146'; DntWindow.Open(); }
         function Txt147_Clicked() { parDntNum.value = '147'; DntWindow.Open(); }
         function Txt148_Clicked() { parDntNum.value = '148'; DntWindow.Open(); }
         
         </script>

</head>
    
    
  <script runat="server">

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string AmbCrdIdn = "";
        string whereClause = "";
        
        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //=====================================================================================
            sdsDnt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDnt.SelectCommand = "SELECT * FROM SPRDNT ORDER BY DNTNAMSHR";
            //=====================================================================================
            
            if (!Page.IsPostBack)
            {
                getDocNum();
            }
            
        }
      
        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNum()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbSttIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbSttIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                Txt018.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB018"]);
                Txt017.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB017"]);
                Txt016.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB016"]);
                Txt015.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB015"]);
                Txt014.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB014"]);
                Txt013.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB013"]);
                Txt012.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB012"]);
                Txt011.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB011"]);
                Txt021.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB021"]);
                Txt022.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB022"]);
                Txt023.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB023"]);
                Txt024.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB024"]);
                Txt025.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB025"]);
                Txt026.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB026"]);
                Txt027.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB027"]);
                Txt028.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB028"]);
                
                Txt038.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB038"]);
                Txt037.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB037"]);
                Txt036.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB036"]);
                Txt035.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB035"]);
                Txt034.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB034"]);
                Txt033.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB033"]);
                Txt032.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB032"]);
                Txt031.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB031"]);
                Txt041.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB041"]);
                Txt042.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB042"]);
                Txt043.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB043"]);
                Txt044.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB044"]);
                Txt045.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB045"]);
                Txt046.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB046"]);
                Txt047.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB047"]);
                Txt048.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB048"]);

                Txt118.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB118"]);
                Txt117.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB117"]);
                Txt116.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB116"]);
                Txt115.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB115"]);
                Txt114.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB114"]);
                Txt113.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB113"]);
                Txt112.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB112"]);
                Txt111.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB111"]);
                Txt121.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB121"]);
                Txt122.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB122"]);
                Txt123.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB123"]);
                Txt124.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB124"]);
                Txt125.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB125"]);
                Txt126.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB126"]);
                Txt127.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB127"]);
                Txt128.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB128"]);

                Txt138.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB138"]);
                Txt137.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB137"]);
                Txt136.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB136"]);
                Txt135.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB135"]);
                Txt134.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB134"]);
                Txt133.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB133"]);
                Txt132.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB132"]);
                Txt131.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB131"]);
                Txt141.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB141"]);
                Txt142.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB142"]);
                Txt143.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB143"]);
                Txt144.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB144"]);
                Txt145.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB145"]);
                Txt146.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB146"]);
                Txt147.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB147"]);
                Txt148.Text = Convert.ToString(ds.Tables[0].Rows[0]["ZUB148"]);

            }

  //          string name = value ?? string.Empty;
        }
        // ============================ чтение заголовка таблицы а оп ==============================================
                
  </script>   
    
    
<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDntNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>


            <%-- ============================  шапка экрана ============================================ 


            --%>
            <asp:Panel ID="PanelSum" runat="server" BorderStyle="Double" ScrollBars="None"
                Style="position: relative; left: 20%; top: 10px; width: 60%; height: 200px;">
                <asp:TextBox ID="Sapka"
                    Text="ФОРМУЛА ЗУБОВ"
                    BackColor="yellow"
                    Font-Names="Verdana"
                    Font-Size="12px"
                    Font-Bold="True"
                    ForeColor="Blue"
                    Style="top: 0px; left: 0px; position: relative; width: 100%; text-align: center"
                    runat="server"></asp:TextBox>
                <br />
                <br />
                
                <table border="0" cellspacing="0" width="99%" cellpadding="0">
                  <!--  01 ряд =====================================================================================  -->
                    <tr>
                      <!--  01 левая ----------------------------------------------------------------------------------------------------------  -->
                      <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt018" Width="100%" BackColor="White" Height="20px" onClick="Txt018_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt017" Width="100%" BackColor="White" Height="20px" onClick="Txt017_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt016" Width="100%" BackColor="White" Height="20px" onClick="Txt016_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt015" Width="100%" BackColor="White" Height="20px" onClick="Txt015_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt014" Width="100%" BackColor="White" Height="20px" onClick="Txt014_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt013" Width="100%" BackColor="White" Height="20px" onClick="Txt013_Clicked()" Style="font-weight: 700; font-size: large; text-align: center">  </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt012" Width="100%" BackColor="White" Height="20px" onClick="Txt012_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt011" Width="100%" BackColor="White" Height="20px" onClick="Txt011_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;"></td>
                    <!--  01 правая----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt021" Width="100%" BackColor="White" Height="20px" onClick="Txt021_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt022" Width="100%" BackColor="White" Height="20px" onClick="Txt022_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt023" Width="100%" BackColor="White" Height="20px" onClick="Txt023_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt024" Width="100%" BackColor="White" Height="20px" onClick="Txt024_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt025" Width="100%" BackColor="White" Height="20px" onClick="Txt025_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt026" Width="100%" BackColor="White" Height="20px" onClick="Txt026_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt027" Width="100%" BackColor="White" Height="20px" onClick="Txt027_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt028" Width="100%" BackColor="White" Height="20px" onClick="Txt028_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                    </tr>

                  <!--  02 ряд ========================================================================================================  -->
                    <tr>
                      <!--  02 левая ----------------------------------------------------------------------------------------------------------  -->
                      <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt038" Width="100%" BackColor="White" Height="20px" onClick="Txt038_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt037" Width="100%" BackColor="White" Height="20px" onClick="Txt037_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt036" Width="100%" BackColor="White" Height="20px" onClick="Txt036_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt035" Width="100%" BackColor="White" Height="20px" onClick="Txt035_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt034" Width="100%" BackColor="White" Height="20px" onClick="Txt034_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt033" Width="100%" BackColor="White" Height="20px" onClick="Txt033_Clicked()" Style="font-weight: 700; font-size: large; text-align: center">  </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt032" Width="100%" BackColor="White" Height="20px" onClick="Txt032_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt031" Width="100%" BackColor="White" Height="20px" onClick="Txt031_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;"></td>
                    <!--  02 правая----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt041" Width="100%" BackColor="White" Height="20px" onClick="Txt041_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt042" Width="100%" BackColor="White" Height="20px" onClick="Txt042_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt043" Width="100%" BackColor="White" Height="20px" onClick="Txt043_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt044" Width="100%" BackColor="White" Height="20px" onClick="Txt044_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt045" Width="100%" BackColor="White" Height="20px" onClick="Txt045_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt046" Width="100%" BackColor="White" Height="20px" onClick="Txt046_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt047" Width="100%" BackColor="White" Height="20px" onClick="Txt047_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt048" Width="100%" BackColor="White" Height="20px" onClick="Txt048_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                    </tr>

                  <!--  СРЕДНИИ РЯД ========================================================================================================  -->
                    <tr>
                      <!--  СРЕДНИИ левая ----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label00" runat="server" align="center" Style="font-weight: bold;" Text="8"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center">
                            <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="7"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label02" runat="server" align="center" Style="font-weight: bold;" Text="6"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label03" runat="server" align="center" Style="font-weight: bold;" Text="5"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label04" runat="server" align="center" Style="font-weight: bold;" Text="4"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label05" runat="server" align="center" Style="font-weight: bold;" Text="3"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label06" runat="server" align="center" Style="font-weight: bold;" Text="2"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label07" runat="server" align="center" Style="font-weight: bold;" Text="1"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;"></td>
                    <!--  СРЕДНИИ правая----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label08" runat="server" align="center" Style="font-weight: bold;" Text="1"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label09" runat="server" align="center" Style="font-weight: bold;" Text="2"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="3"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label11" runat="server" align="center" Style="font-weight: bold;" Text="4"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label12" runat="server" align="center" Style="font-weight: bold;" Text="5"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label13" runat="server" align="center" Style="font-weight: bold;" Text="6"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label14" runat="server" align="center" Style="font-weight: bold;" Text="7"></asp:Label>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:Label ID="Label15" runat="server" align="center" Style="font-weight: bold;" Text="8"></asp:Label>
                          </td>
                    </tr>



                  <!--  03 ряд =====================================================================================  -->
                    <tr>
                      <!--  03 левая ----------------------------------------------------------------------------------------------------------  -->
                      <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt118" Width="100%" BackColor="White" Height="20px" onClick="Txt118_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt117" Width="100%" BackColor="White" Height="20px" onClick="Txt117_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt116" Width="100%" BackColor="White" Height="20px" onClick="Txt116_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt115" Width="100%" BackColor="White" Height="20px" onClick="Txt115_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt114" Width="100%" BackColor="White" Height="20px" onClick="Txt114_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt113" Width="100%" BackColor="White" Height="20px" onClick="Txt113_Clicked()" Style="font-weight: 700; font-size: large; text-align: center">  </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt112" Width="100%" BackColor="White" Height="20px" onClick="Txt112_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt111" Width="100%" BackColor="White" Height="20px" onClick="Txt111_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;"></td>
                    <!--  03 правая----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt121" Width="100%" BackColor="White" Height="20px" onClick="Txt121_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt122" Width="100%" BackColor="White" Height="20px" onClick="Txt122_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt123" Width="100%" BackColor="White" Height="20px" onClick="Txt123_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt124" Width="100%" BackColor="White" Height="20px" onClick="Txt124_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt125" Width="100%" BackColor="White" Height="20px" onClick="Txt125_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt126" Width="100%" BackColor="White" Height="20px" onClick="Txt126_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt127" Width="100%" BackColor="White" Height="20px" onClick="Txt127_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt128" Width="100%" BackColor="White" Height="20px" onClick="Txt128_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                    </tr>

                  <!--  04 ряд ========================================================================================================  -->
                    <tr>
                      <!--  04 левая ----------------------------------------------------------------------------------------------------------  -->
                      <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt138" Width="100%" BackColor="White" Height="20px" onClick="Txt138_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt137" Width="100%" BackColor="White" Height="20px" onClick="Txt137_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt136" Width="100%" BackColor="White" Height="20px" onClick="Txt136_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt135" Width="100%" BackColor="White" Height="20px" onClick="Txt135_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt134" Width="100%" BackColor="White" Height="20px" onClick="Txt134_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt133" Width="100%" BackColor="White" Height="20px" onClick="Txt133_Clicked()" Style="font-weight: 700; font-size: large; text-align: center">  </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt132" Width="100%" BackColor="White" Height="20px" onClick="Txt132_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt131" Width="100%" BackColor="White" Height="20px" onClick="Txt131_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;"></td>
                    <!--  04 правая----------------------------------------------------------------------------------------------------------  -->
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt141" Width="100%" BackColor="White" Height="20px" onClick="Txt141_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt142" Width="100%" BackColor="White" Height="20px" onClick="Txt142_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt143" Width="100%" BackColor="White" Height="20px" onClick="Txt143_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt144" Width="100%" BackColor="White" Height="20px" onClick="Txt144_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt145" Width="100%" BackColor="White" Height="20px" onClick="Txt145_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt146" Width="100%" BackColor="White" Height="20px" onClick="Txt146_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt147" Width="100%" BackColor="White" Height="20px" onClick="Txt147_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                        <td width="5%" style="text-align:center;">
                            <asp:TextBox runat="server" ID="Txt148" Width="100%" BackColor="White" Height="20px" onClick="Txt148_Clicked()" Style="font-weight: 700; font-size: large; text-align: center"> </asp:TextBox>
                        </td>
                    </tr>

                </table>
            </asp:Panel>
            <!-- Результат ---------------------------------------------------------------------------------------------------------- 
     
       -->
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
        <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="DntWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="500" Top="0" Height="500" Width="300" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Справочник">

            <oajax:CallbackPanel ID="CallbackPanelDnt" runat="server">
                <Content>

                    <obout:Grid ID="gridDnt"
                        runat="server"
                        CallbackMode="true"
                        Serialize="true"
                        AutoGenerateColumns="false"
                        FolderStyle="~/Styles/Grid/style_5"
                        AllowAddingRecords="false"
                        ShowLoadingMessage="true"
                        ShowColumnsFooter="false"
                        KeepSelectedRecords="true"
                        DataSourceID="sdsDnt"
                        Width="100%"
                        PageSize="-1"
                        ShowFooter="false">
                        <ClientSideEvents OnClientDblClick="OnClientDblClick"/>
                        <Columns>
                            <obout:Column ID="Column20" DataField="DNTKOD" HeaderText="Идн" ReadOnly="true" Width="0%" Visible="false" />
                            <obout:Column ID="Column21" DataField="DNTNAMSHR" HeaderText="Код" ReadOnly="true" Width="7%" Align="left" />
                            <obout:Column ID="Column22" DataField="DNTNAM" HeaderText="Наименование" ReadOnly="true" Width="93%" Align="left" />
                        </Columns>
                        <ScrollingSettings ScrollHeight="400" ScrollWidth="100%" />
                    </obout:Grid>

                </Content>
            </oajax:CallbackPanel>

        </owd:Window>

    </form>

    <%-- ============================  STYLES ============================================ --%>
    <style type="text/css">
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

  /*   For multiline textbox control:  */
       .ob_iTaMC textarea
    {
        font-size: 14px !important;
        font-family: Arial !important;
    }
      
 /*   For oboutButton Control: color: #0000FF !important; */

    .ob_iBC
    {
        font-size: 12px !important;
    }

 /*  For oboutTextBox Control: */

    .ob_iTIE
    {
        font-size: 12px !important;
    }
      
      /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }
    
        hr {
    border: none; /* Убираем границу */
    background-color: gray; /* Цвет линии */
    color: gray; /* Цвет линии для IE6-7 */
    height: 2px; /* Толщина линии */
   }
</style>

  <asp:SqlDataSource runat="server" ID="sdsDnt"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
 
</body>
</html>



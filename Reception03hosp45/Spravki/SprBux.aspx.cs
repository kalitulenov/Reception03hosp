using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using Obout.Interface;
using System.Web.Configuration;
using System.Collections;   // для Hashtable

using System.Web.Services;

namespace Reception03hosp45.Spravki
{
    public partial class SprBux : System.Web.UI.Page
    {
 //       int ComBuxKod = 0;
        string ComPriOpr = "";
        int BuxIdn;
        int BuxKod;
        int BuxTab;
        int BuxDlg;
        int BuxPrz;
        decimal BuxStf;
        bool BuxStz;
        bool BuxUbl;
        bool BuxMol;
        string BuxLog;
        string BuxPsw;
        string BuxKey;
        string BuxUch;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";


        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            parBuxFrm.Value = BuxFrm;
            parBuxSid.Value = BuxSid;

            sdsBux.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsBux.SelectCommand = "SELECT KOD AS BUXTAB,FIO FROM SprKdr WHERE KDRFRM='" + BuxFrm + "' ORDER BY FIO";

            sdsDlg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDlg.SelectCommand = "SELECT DLGKOD AS BUXDLG,DLGNAM AS NAM FROM SPRDLG ORDER BY DLGNAM";

            sdsStf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsStf.SelectCommand = "SELECT STTRSPKOLSTF AS KOLSTF FROM SPRSTTRSPKOL";

            sdsStt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsStt.SelectCommand = "SELECT SttStrKey AS STTKEY, SttStrNam AS STTNAM FROM SprSttStr WHERE SttStrFrm=" + BuxFrm + " AND SttStrLvl = 1 ORDER BY SttStrNam";

    //        sdsUch.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
    //        sdsUch.SelectCommand = "SELECT UCHNAM FROM SPRUCH WHERE UCHFRM=" + BuxFrm + " ORDER BY UCHNAM";

            GridBux.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridBux.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridBux.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
                ParRadUbl.Value = "0";

                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();

                getGrid();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComPriOpr", "");
            }
            else
            {
                ComPriOpr = (string)Session["ComPriOpr"];
                if (ComPriOpr == "add") getGrid();

            }

        }

        //===========================================================================================================
        // Create the methods that will load the data into the templates

        //------------------------------------------------------------------------

        // ============================ первая таблица ==============================================
        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            BuxTab = Convert.ToInt32(e.Record["BuxTab"]);
            BuxDlg = Convert.ToInt32(e.Record["BuxDlg"]);
            BuxKey = Convert.ToString(e.Record["BuxKey"]);

            if (Convert.ToString(e.Record["BuxPrz"]) == null || Convert.ToString(e.Record["BuxPrz"]) == "") BuxPrz = 0;
            else BuxPrz = Convert.ToInt32(e.Record["BuxPrz"]);

            if (Convert.ToString(e.Record["BuxStf"]) == null || Convert.ToString(e.Record["BuxStf"]) == "") BuxStf = 1;
            else BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);

            BuxLog = Convert.ToString(e.Record["BuxLog"]);
            BuxPsw = Convert.ToString(e.Record["BuxPsw"]);
            BuxMol = Convert.ToBoolean(e.Record["BuxMol"]);
       //     BuxUch = Convert.ToString(e.Record["BuxUch"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBuxAdd", con);
            cmd = new SqlCommand("ComSprBuxAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXTAB", SqlDbType.Int, 4).Value = BuxTab;
            cmd.Parameters.Add("@BUXKEY", SqlDbType.VarChar).Value = BuxKey;
            cmd.Parameters.Add("@BUXDLG", SqlDbType.Int, 4).Value = BuxDlg;
            cmd.Parameters.Add("@BUXPRZ", SqlDbType.Int, 4).Value = BuxPrz;
            cmd.Parameters.Add("@BUXSTF", SqlDbType.Decimal).Value = BuxStf;
            cmd.Parameters.Add("@BUXLOG", SqlDbType.VarChar).Value = BuxLog;
            cmd.Parameters.Add("@BUXPSW", SqlDbType.VarChar).Value = BuxPsw;
            cmd.Parameters.Add("@BUXMOL", SqlDbType.Bit, 1).Value = BuxMol;
            //    cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BuxUch;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
      //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
      //      ws.ComSprBuxAdd(MdbNam, BuxSid, BuxFrm, BuxTab, BuxDlg, BuxLog, BuxPsw);
            getGrid();

        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);
            BuxTab = Convert.ToInt32(e.Record["BuxTab"]);
            BuxDlg = Convert.ToInt32(e.Record["BuxDlg"]);
            BuxKey = Convert.ToString(e.Record["BuxKey"]);

            if (Convert.ToString(e.Record["BuxPrz"]) == null || Convert.ToString(e.Record["BuxPrz"]) == "") BuxPrz = 0;
            else BuxPrz = Convert.ToInt32(e.Record["BuxPrz"]);

            if (Convert.ToString(e.Record["BuxStf"]) == null || Convert.ToString(e.Record["BuxStf"]) == "") BuxStf = 1;
            else BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);

            BuxUbl = Convert.ToBoolean(e.Record["BuxUbl"]);
            BuxLog = Convert.ToString(e.Record["BuxLog"]);
            BuxPsw = Convert.ToString(e.Record["BuxPsw"]);
            BuxMol = Convert.ToBoolean(e.Record["BuxMol"]);
       //     BuxUch = Convert.ToString(e.Record["BuxUch"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBuxRep", con);
            cmd = new SqlCommand("ComSprBuxRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = BuxIdn;
            cmd.Parameters.Add("@BUXTAB", SqlDbType.Int, 4).Value = BuxTab;
            cmd.Parameters.Add("@BUXKEY", SqlDbType.VarChar).Value = BuxKey;
            cmd.Parameters.Add("@BUXDLG", SqlDbType.Int, 4).Value = BuxDlg;
            cmd.Parameters.Add("@BUXPRZ", SqlDbType.Int, 4).Value = BuxPrz;
            cmd.Parameters.Add("@BUXSTF", SqlDbType.Decimal).Value = BuxStf;
            cmd.Parameters.Add("@BUXUBL", SqlDbType.Bit, 1).Value = BuxUbl;
            cmd.Parameters.Add("@BUXLOG", SqlDbType.VarChar).Value = BuxLog;
            cmd.Parameters.Add("@BUXPSW", SqlDbType.VarChar).Value = BuxPsw;
            cmd.Parameters.Add("@BUXMOL", SqlDbType.Bit, 1).Value = BuxMol;
       //     cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BuxUch;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
    //        localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //        ws.ComSprBuxRep(MdbNam, BuxSid, BuxIdn, BuxTab, BuxDlg, BuxUbl, BuxLog, BuxPsw);
      
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprBuxDel(MdbNam, BuxSid, BuxIdn);
            getGrid();

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            // создание DataSet.
            DataSet ds = new DataSet();

            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprBux", con);
            cmd = new SqlCommand("HspSprBux", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXUBL", SqlDbType.VarChar).Value = ParRadUbl.Value;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprBux");
            // ------------------------------------------------------------------------------заполняем второй уровень
       //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
       //     DataSet ds = new DataSet("SprBux");
       //     ds.Merge(ws.ComSprBux(MdbNam, BuxSid, BuxFrm));
            
            GridBux.DataSource = ds;
            GridBux.DataBind();
        }



        // ====================================после удаления ============================================
        private string getPostBackControlName()
        {
            string PostBackerID = Request.Form.Get(Page.postEventSourceID);
            string PostBackerArg = Request.Form.Get(Page.postEventArgumentID);

            getGrid();


            return "";
        }

        protected void OboutRadioButton_CheckedChanged001(object sender, EventArgs e)
        {
   //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadUbl.Value = "0";
            getGrid();
        }
        protected void OboutRadioButton_CheckedChanged002(object sender, EventArgs e)
        {
            //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadUbl.Value = "1";
            getGrid();
        }

        protected void ExlButton_Click(object sender, EventArgs e)
        {
            string fileName = GridBux.ExportToExcel();

            Downloader.Text = "The Grid has been exported to an Excel file on the server. <br /><a href=\"/Temp/" + fileName + "\">Click here to download the file.</a>";
        }


        protected void PrtButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }


    }
}

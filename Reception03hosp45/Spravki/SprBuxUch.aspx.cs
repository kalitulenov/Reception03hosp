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
    public partial class SprBuxUch : System.Web.UI.Page
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
            sdsBux.SelectCommand = "SELECT BUXKOD,FIO FROM SprBuxKdr WHERE (DLGZAN=2 OR DLGZAN=3) AND ISNULL(BUXUBL,0)=0 AND BUXFRM='" + BuxFrm + "' ORDER BY FIO";
            sdsUch.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsUch.SelectCommand = "SELECT SprKlt.KLTUCH AS UCHNAM FROM SprCntKlt INNER JOIN SprKlt ON SprCntKlt.CNTKLTIIN=SprKlt.KLTIIN " +
                                   "WHERE SprCntKlt.CNTKLTFRM=" + BuxFrm + " AND ISNULL(SprCntKlt.CNTKLTUBLFLG, 0) = 0 AND LEFT(SprCntKlt.CNTKLTKEY, 5) = '00001' AND LEN(SprKlt.KLTUCH) > 0 " +
                                   "GROUP BY SprKlt.KLTUCH ORDER BY SprKlt.KLTUCH"; 

            GridBux.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridBux.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridBux.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
                ParRadUbl.Value = "0";

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
            if (Convert.ToString(e.Record["UchDoc"]) == null || Convert.ToString(e.Record["UchDoc"]) == "") BuxKod = 0;
            else BuxKod = Convert.ToInt32(e.Record["UchDoc"]);

            if (Convert.ToString(e.Record["UchNam"]) == null || Convert.ToString(e.Record["UchNam"]) == "") BuxUch = "";
            else BuxUch = Convert.ToString(e.Record["UchNam"]);


            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO SPRUCH (UCHFRM,UCHDOC,UCHNAM) VALUES(@BUXFRM,ISNULL(@BUXKOD,0),ISNULL(@BUXUCH,''))", con);
          //  cmd = new SqlCommand("ComSprBuxUchAdd", con);
            // указать тип команды
         //   cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
         //   cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BuxUch;
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
            BuxIdn = Convert.ToInt32(e.Record["UchIdn"]);

            if (Convert.ToString(e.Record["UchDoc"]) == null || Convert.ToString(e.Record["UchDoc"]) == "") BuxKod = 0;
            else BuxKod = Convert.ToInt32(e.Record["UchDoc"]);

            if (Convert.ToString(e.Record["UchNam"]) == null || Convert.ToString(e.Record["UchNam"]) == "") BuxUch = "";
            else BuxUch = Convert.ToString(e.Record["UchNam"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("UPDATE SPRUCH SET UCHDOC= ISNULL(@BUXKOD,0),UCHNAM = ISNULL(@BUXUCH,'') WHERE UCHIDN = @BUXIDN", con);
          //  cmd = new SqlCommand("ComSprBuxUchRep", con);
            // указать тип команды
          //  cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
          //  cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = BuxIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BuxUch;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            BuxIdn = Convert.ToInt32(e.Record["UchIdn"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRUCH WHERE UCHIDN = @BUXIDN", con);
            //  cmd = new SqlCommand("ComSprBuxUchRep", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            //  cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = BuxIdn;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
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
            SqlCommand cmd = new SqlCommand("SELECT SPRUCH.*, SPRBUXKDR.FIO FROM SPRUCH LEFT OUTER JOIN SPRBUXKDR ON SPRUCH.UCHDOC = SPRBUXKDR.BUXKOD " +
                                            "WHERE UCHFRM=@BUXFRM ORDER BY UCHNAM", con);
          //  cmd = new SqlCommand("HspSprBuxUch", con);
            // указать тип команды
          //  cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
          //  cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprBuxUch");
            // ------------------------------------------------------------------------------заполняем второй уровень
            //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //     DataSet ds = new DataSet("SprBux");
            //     ds.Merge(ws.ComSprBux(MdbNam, BuxSid, BuxFrm));
            if (ds.Tables[0].Rows.Count > 0)
            {
                GridBux.DataSource = ds;
                GridBux.DataBind();
            }
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

 
        protected void PrtButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }


    }
}

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
    public partial class SprOrgHsp : System.Web.UI.Page
    {
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        int HspIdn;
        string HspSurIdn;
        int HspKod;
        string HspNam;
        string HspNamShr;
        string HspAdr;
        string HspBin;
        string HspIik;
        string HspKntTel;
        string HspKntEml;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
             //============= локолизация для календаря  ===========================================================================================
  
          //   NumSpr = (string)Request.QueryString["NumSpr"];
            //         if (Session["HspKODSES"] == null) Session.Add("HspKODSES", (string)"0");

            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            GridHsp.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridHsp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridHsp.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            getGrid();
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm + " ORDER BY ORGHSPKOD", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprHsp");
            GridHsp.DataSource = ds;
            GridHsp.DataBind();
       
            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();

        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            HspNam = Convert.ToString(e.Record["ORGHSPNAM"]);
            HspNamShr = Convert.ToString(e.Record["ORGHSPNAMSHR"]);
            HspAdr = Convert.ToString(e.Record["ORGHSPADR"]);

            HspBin = Convert.ToString(e.Record["ORGHSPBIN"]);
            HspIik = Convert.ToString(e.Record["ORGHSPIIK"]);
            HspSurIdn = Convert.ToString(e.Record["ORGHSPSURIDN"]);
            HspKntTel = Convert.ToString(e.Record["ORGHSPKNTTEL"]);

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprOrgHspAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@ORGHSPNAM", SqlDbType.VarChar).Value = HspNam;
            cmd.Parameters.Add("@ORGHSPNAMSHR", SqlDbType.VarChar).Value = HspNamShr;
            cmd.Parameters.Add("@ORGHSPADR", SqlDbType.VarChar).Value = HspAdr;
            cmd.Parameters.Add("@ORGHSPBIN", SqlDbType.VarChar).Value = HspBin;
            cmd.Parameters.Add("@ORGHSPIIK", SqlDbType.VarChar).Value = HspIik;
            cmd.Parameters.Add("@ORGHSPSURIDN", SqlDbType.VarChar).Value = HspSurIdn;
            cmd.Parameters.Add("@ORGHSPKNTTEL", SqlDbType.VarChar).Value = HspKntTel;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            HspKod = Convert.ToInt32(e.Record["ORGHSPKOD"]);
            HspNam = Convert.ToString(e.Record["ORGHSPNAM"]);
            HspNamShr = Convert.ToString(e.Record["ORGHSPNAMSHR"]);
            HspAdr = Convert.ToString(e.Record["ORGHSPADR"]);

            HspBin = Convert.ToString(e.Record["ORGHSPBIN"]);
            HspIik = Convert.ToString(e.Record["ORGHSPIIK"]);
            HspSurIdn = Convert.ToString(e.Record["ORGHSPSURIDN"]);
            HspKntTel = Convert.ToString(e.Record["ORGHSPKNTTEL"]);

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprOrgHspRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@ORGHSPKOD", SqlDbType.Int, 4).Value = HspKod;
            cmd.Parameters.Add("@ORGHSPNAM", SqlDbType.VarChar).Value = HspNam;
            cmd.Parameters.Add("@ORGHSPNAMSHR", SqlDbType.VarChar).Value = HspNamShr;
            cmd.Parameters.Add("@ORGHSPADR", SqlDbType.VarChar).Value = HspAdr;
            cmd.Parameters.Add("@ORGHSPBIN", SqlDbType.VarChar).Value = HspBin;
            cmd.Parameters.Add("@ORGHSPIIK", SqlDbType.VarChar).Value = HspIik;
            cmd.Parameters.Add("@ORGHSPSURIDN", SqlDbType.VarChar).Value = HspSurIdn;
            cmd.Parameters.Add("@ORGHSPKNTTEL", SqlDbType.VarChar).Value = HspKntTel;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
       
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            HspKod = Convert.ToInt32(e.Record["ORGHSPKOD"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRORGHSP WHERE ORGHSPKOD=" + HspKod, con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

    }
}

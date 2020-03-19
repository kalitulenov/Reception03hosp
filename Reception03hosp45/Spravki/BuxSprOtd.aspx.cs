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
    public partial class BuxSprOtd : System.Web.UI.Page
    {
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        int OtdIdn;
        int OtdKod;
        string OtdNam;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
             //============= локолизация для календаря  ===========================================================================================
  
          //   NumSpr = (string)Request.QueryString["NumSpr"];
            //         if (Session["OtdKODSES"] == null) Session.Add("OtdKODSES", (string)"0");

            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            GridOtd.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridOtd.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridOtd.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
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
            SqlCommand cmd = new SqlCommand("SELECT * FROM SPROTD WHERE OTDFRM=" + BuxFrm + " ORDER BY OTDNAM", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprOtd");
            GridOtd.DataSource = ds;
            GridOtd.DataBind();
       
            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();

        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            OtdNam = Convert.ToString(e.Record["OTDNAM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprOtdAdd", con);
            cmd = new SqlCommand("ComSprOtdAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@OTDNAM", SqlDbType.VarChar).Value = OtdNam;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень

            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            OtdKod = Convert.ToInt32(e.Record["OTDKOD"]);
            OtdNam = Convert.ToString(e.Record["OTDNAM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprOtdRep", con);
            cmd = new SqlCommand("ComSprOtdRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@OTDKOD", SqlDbType.Int, 4).Value = OtdKod;
            cmd.Parameters.Add("@OTDNAM", SqlDbType.VarChar).Value = OtdNam;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
       
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            OtdKod = Convert.ToInt32(e.Record["OTDKOD"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprOtdDel", con);
            cmd = new SqlCommand("ComSprOtdDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@OTDKOD", SqlDbType.Int, 4).Value = OtdKod;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень

            getGrid();
        }

    }
}

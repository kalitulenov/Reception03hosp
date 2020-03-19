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
    public partial class BuxSprBnk : System.Web.UI.Page
    {
 //       int ComBuxKod = 0;
        string ComPriOpr = "";
        int BnkIdn;
        int BnkKod;
        string BnkBin;
        string BnkBik;
        string BnkNam;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";


        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            GridBnk.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridBnk.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridBnk.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
              //  ParRadUbl.Value = "0";
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
        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
      //      BnkKod = Convert.ToInt32(e.Record["BNKKOD"]);
            BnkBin = Convert.ToString(e.Record["BNKBIN"]);
            BnkBik = Convert.ToString(e.Record["BNKBIK"]);
            BnkNam = Convert.ToString(e.Record["BNKNAM"]);

             // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBnkAdd", con);
            cmd = new SqlCommand("ComSprBnkAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BNKBIN", SqlDbType.VarChar).Value = BnkBin;
            cmd.Parameters.Add("@BNKBIK", SqlDbType.VarChar).Value = BnkBik;
            cmd.Parameters.Add("@BNKNAM", SqlDbType.VarChar).Value = BnkNam;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            BnkIdn = Convert.ToInt32(e.Record["BNKIDN"]);

            BnkBin = Convert.ToString(e.Record["BNKBIN"]);
            BnkBik = Convert.ToString(e.Record["BNKBIK"]);
            BnkNam = Convert.ToString(e.Record["BNKNAM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBnkRep", con);
            cmd = new SqlCommand("ComSprBnkRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BNKIDN", SqlDbType.Int, 4).Value = BnkIdn;
            cmd.Parameters.Add("@BNKBIN", SqlDbType.VarChar).Value = BnkBin;
            cmd.Parameters.Add("@BNKBIK", SqlDbType.VarChar).Value = BnkBik;
            cmd.Parameters.Add("@BNKNAM", SqlDbType.VarChar).Value = BnkNam;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            BnkIdn = Convert.ToInt32(e.Record["BNKIDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprBnkDel", con);
            cmd = new SqlCommand("ComSprBnkDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BNKIDN", SqlDbType.Int, 4).Value = BnkIdn;
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
            SqlCommand cmd = new SqlCommand("SELECT * FROM SPRBNK ORDER BY BNKNAM", con);
       //     cmd = new SqlCommand("ComSprBnk", con);
            // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
       //     cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprBnk");
            // ------------------------------------------------------------------------------заполняем второй уровень
            
            GridBnk.DataSource = ds;
            GridBnk.DataBind();
        }



    }
}

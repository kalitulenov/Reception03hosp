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
    public partial class SprCabDoc : System.Web.UI.Page
    {
 //       int ComGrfKod = 0;
        string ComPriOpr = "";
        int GrfIdn;
        int GrfKod;
        string GrfCab;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            parGrfFrm.Value = BuxFrm;

            sds1.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sds1.SelectCommand = "SELECT BUXKOD,FIO+' '+DLGNAM AS FIODLG FROM SprBuxKdr WHERE BUXFRM='" + BuxFrm + "' ORDER BY FIO";

            GridGrf.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridGrf.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridGrf.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
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

            if (Convert.ToString(e.Record["GrfKod"]) == null || Convert.ToString(e.Record["GrfKod"]) == "") GrfKod = 0;
            else GrfKod = Convert.ToInt32(e.Record["GrfKod"]);

            if (Convert.ToString(e.Record["GrfCab"]) == null || Convert.ToString(e.Record["GrfCab"]) == "") GrfCab = "";
            else GrfCab = Convert.ToString(e.Record["GrfCab"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCabDocAdd", con);
            cmd = new SqlCommand("HspSprCabDocAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = GrfKod;
            cmd.Parameters.Add("@BUXCAB", SqlDbType.VarChar).Value = GrfCab;
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

            GrfIdn = Convert.ToInt32(e.Record["GrfIdn"]);

            if (Convert.ToString(e.Record["GrfKod"]) == null || Convert.ToString(e.Record["GrfKod"]) == "") GrfKod = 0;
            else GrfKod = Convert.ToInt32(e.Record["GrfKod"]);

            if (Convert.ToString(e.Record["GrfCab"]) == null || Convert.ToString(e.Record["GrfCab"]) == "") GrfCab ="";
            else GrfCab = Convert.ToString(e.Record["GrfCab"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCabDocRep", con);
            cmd = new SqlCommand("HspSprCabDocRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = GrfIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = GrfKod;
            cmd.Parameters.Add("@BUXCAB", SqlDbType.VarChar).Value = GrfCab;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
    //        localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //        ws.ComSprGrfRep(MdbNam, BuxSid, BuxIdn, BuxTab, BuxDlg, BuxUbl, BuxLog, BuxPsw);
      
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            GrfIdn = Convert.ToInt32(e.Record["GrfIdn"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCabDocDel", con);
            cmd = new SqlCommand("HspSprCabDocDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXIDN", SqlDbType.Int, 4).Value = GrfIdn;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

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
            SqlCommand cmd = new SqlCommand("HspSprCabDoc", con);
            cmd = new SqlCommand("HspSprCabDoc", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprCabDoc");
            // ------------------------------------------------------------------------------заполняем второй уровень
       //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
       //     DataSet ds = new DataSet("SprBux");
       //     ds.Merge(ws.ComSprBux(MdbNam, BuxSid, BuxFrm));
            
            GridGrf.DataSource = ds;
            GridGrf.DataBind();
        }



        // ====================================после удаления ============================================


    }
}

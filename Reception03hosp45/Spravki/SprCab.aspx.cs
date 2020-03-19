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
    public partial class SprCab : System.Web.UI.Page
    {
 //       int ComCabKod = 0;
        string ComPriOpr = "";
        int CabIdn;
        int CabKod;
        string CabNam;
        string CabMem;
        string CabKey;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";


        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            parBuxFrm.Value = BuxFrm;

            GridCab.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridCab.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridCab.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {
                getGrid();

                Session.Add("ComCabKod", 0);
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

            if (Convert.ToString(e.Record["CabNam"]) == null) CabNam = "";
            else CabNam = Convert.ToString(e.Record["CabNam"]);

            if (Convert.ToString(e.Record["CabMem"]) == null) CabMem = "";
            else CabMem = Convert.ToString(e.Record["CabMem"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprCabAdd", con);
            cmd = new SqlCommand("ComSprCabAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@CABNAM", SqlDbType.VarChar).Value = CabNam;
            cmd.Parameters.Add("@CABMEM", SqlDbType.VarChar).Value = CabMem;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
      //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
      //      ws.ComSprCabAdd(MdbNam, CabSid, CabFrm, CabTab, CabDlg, CabNam, CabMem);
            getGrid();

        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            CabIdn = Convert.ToInt32(e.Record["CabIdn"]);

            if (Convert.ToString(e.Record["CabNam"]) == null) CabNam = "";
            else CabNam = Convert.ToString(e.Record["CabNam"]);

            if (Convert.ToString(e.Record["CabMem"]) == null) CabMem = "";
            else CabMem = Convert.ToString(e.Record["CabMem"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprCabRep", con);
            cmd = new SqlCommand("ComSprCabRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@CABIDN", SqlDbType.Int, 4).Value = CabIdn;
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@CABNAM", SqlDbType.VarChar).Value = CabNam;
            cmd.Parameters.Add("@CABMEM", SqlDbType.VarChar).Value = CabMem;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
    //        localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //        ws.ComSprCabRep(MdbNam, CabSid, CabIdn, CabTab, CabDlg, CabUbl, CabNam, CabMem);
      
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            CabIdn = Convert.ToInt32(e.Record["CabIdn"]);

            // создание DataSet.
            DataSet ds = new DataSet();

            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRCAB WHERE CABIDN=" + CabIdn, con);
            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();

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
            SqlCommand cmd = new SqlCommand("SELECT * FROM SPRCAB WHERE CABFRM=" + BuxFrm, con);
          //  cmd = new SqlCommand("HspSprCab", con);
            // указать тип команды
         //   cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
         //   cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        //    cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprCab");
            // ------------------------------------------------------------------------------заполняем второй уровень
       //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
       //     DataSet ds = new DataSet("SprCab");
       //     ds.Merge(ws.ComSprCab(MdbNam, CabSid, CabFrm));
            
            GridCab.DataSource = ds;
            GridCab.DataBind();
        }


    }
}

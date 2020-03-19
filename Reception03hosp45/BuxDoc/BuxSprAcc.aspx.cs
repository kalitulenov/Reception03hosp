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

namespace Reception03hosp45.BuxDoc
{
    public partial class BuxSprAcc : System.Web.UI.Page
    {
 //       int ComBuxKod = 0;
        int AccIdn;
        string AccKod;
        string AccNam;
        int AccSpr001;
        int AccSpr002;
        bool AccPrv;
        bool AccAmr;
        int AccVal;
        decimal AccSum;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            sdsSpr001.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsSpr001.SelectCommand = "SELECT DOCKOD,DOCNAM AS SPRNAM001 FROM SPRDOCTYP";

            sdsSpr002.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsSpr002.SelectCommand = "SELECT DOCKOD,DOCNAM AS SPRNAM002 FROM SPRDOCTYP";

            sdsVal.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsVal.SelectCommand = "SELECT VALKOD,VALNAMTLX FROM SPRVAL ORDER BY VALKOD";

            GridAcc.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridAcc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridAcc.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {

                getGrid();

                Session.Add("ComBuxKod", 0);
                Session.Add("ComPriOpr", "");
            }
            else
            {
     //           ComPriOpr = (string)Session["ComPriOpr"];
    //            if (ComPriOpr == "add") getGrid();

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

            AccKod = Convert.ToString(e.Record["ACCKOD"]);
            AccNam = Convert.ToString(e.Record["ACCNAM"]);

            if ((string)e.Record["ACCSPR001"] == "") AccSpr001 = 0;
            else AccSpr001 = Convert.ToInt32(e.Record["ACCSPR001"]);

            if ((string)e.Record["ACCSPR002"] == "") AccSpr002 = 0;
            else AccSpr002 = Convert.ToInt32(e.Record["ACCSPR002"]);

            AccPrv = Convert.ToBoolean(e.Record["ACCPRV"]);
 //           if ((string)e.Record["ACCPRV"] == "0") AccPrv = false;
 //           else AccPrv = true;

            AccAmr = Convert.ToBoolean(e.Record["ACCAMR"]);
            //           if ((string)e.Record["ACCAMR"] == "0") AccAmr = false;
            //           else AccAmr = true;

            if ((string)e.Record["ACCVAL"] == "") AccVal = 0;
            else AccVal = Convert.ToInt32(e.Record["ACCVAL"]);

            if ((string)e.Record["ACCSUM"] == "") AccSum = 0;
            else AccSum = Convert.ToDecimal(e.Record["ACCSUM"]);
            
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprAccAdd", con);
            cmd = new SqlCommand("BuxSprAccAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = AccKod;
            cmd.Parameters.Add("@ACCNAM", SqlDbType.VarChar).Value = AccNam;
            cmd.Parameters.Add("@ACCSPR001", SqlDbType.VarChar).Value = AccSpr001;
            cmd.Parameters.Add("@ACCSPR002", SqlDbType.VarChar).Value = AccSpr002;
            cmd.Parameters.Add("@ACCPRV", SqlDbType.Bit, 1).Value = AccPrv;
            cmd.Parameters.Add("@ACCAMR", SqlDbType.Bit, 1).Value = AccAmr;
            cmd.Parameters.Add("@ACCVAL", SqlDbType.VarChar).Value = AccVal;
            cmd.Parameters.Add("@ACCSUM", SqlDbType.Decimal).Value = AccSum;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------

            getGrid();
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            AccIdn = Convert.ToInt32(e.Record["ACCIDN"]);
            AccKod = Convert.ToString(e.Record["ACCKOD"]);
            AccNam = Convert.ToString(e.Record["ACCNAM"]);

            if ((string)e.Record["ACCSPR001"] == "") AccSpr001 = 0;
            else AccSpr001 = Convert.ToInt32(e.Record["ACCSPR001"]);

            if ((string)e.Record["ACCSPR002"] == "") AccSpr002 = 0;
            else AccSpr002 = Convert.ToInt32(e.Record["ACCSPR002"]);

            AccPrv = Convert.ToBoolean(e.Record["ACCPRV"]);
 //           if ((string)e.Record["ACCPRV"] == "0") AccPrv = false;
 //           else AccPrv = true;

            AccAmr = Convert.ToBoolean(e.Record["ACCAMR"]);
            //            if ((string)e.Record["ACCAMR"] == "0") AccAmr = false;
            //            else AccAmr = true;

            if ((string)e.Record["ACCVAL"] == "") AccVal = 0;
            else AccVal = Convert.ToInt32(e.Record["ACCVAL"]);

            if ((string)e.Record["ACCSUM"] == "") AccSum = 0;
            else AccSum = Convert.ToDecimal(e.Record["ACCSUM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprAccRep", con);
            cmd = new SqlCommand("BuxSprAccRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@ACCIDN", SqlDbType.VarChar).Value = AccIdn;
            cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = AccKod;
            cmd.Parameters.Add("@ACCNAM", SqlDbType.VarChar).Value = AccNam;
            cmd.Parameters.Add("@ACCSPR001", SqlDbType.VarChar).Value = AccSpr001;
            cmd.Parameters.Add("@ACCSPR002", SqlDbType.VarChar).Value = AccSpr002;
            cmd.Parameters.Add("@ACCPRV", SqlDbType.Bit, 1).Value = AccPrv;
            cmd.Parameters.Add("@ACCAMR", SqlDbType.Bit, 1).Value = AccAmr;
            cmd.Parameters.Add("@ACCVAL", SqlDbType.VarChar).Value = AccVal;
            cmd.Parameters.Add("@ACCSUM", SqlDbType.Decimal).Value = AccSum;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            AccIdn = Convert.ToInt32(e.Record["ACCIDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprAccDel", con);
            cmd = new SqlCommand("BuxSprAccDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@ACCIDN", SqlDbType.VarChar).Value = AccIdn;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
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
            SqlCommand cmd = new SqlCommand("SELECT TabAcc.*,SPRDOCTYP.DocNam AS SprNam001,SprVal.ValNamTlx, SPRDOCTYP_1.DocNam AS SprNam002 " +
                                            "FROM TabAcc LEFT OUTER JOIN SprVal ON TabAcc.AccVal = SprVal.ValKod " +
                                                        "LEFT OUTER JOIN SPRDOCTYP AS SPRDOCTYP_1 ON TabAcc.AccSpr002=SPRDOCTYP_1.DocKod " +
                                                        "LEFT OUTER JOIN SPRDOCTYP ON TabAcc.AccSpr001=SPRDOCTYP.DocKod " +
                                            "WHERE ACCFRM=" + BuxFrm + " ORDER BY ACCKOD", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxSprAcc");
            GridAcc.DataSource = ds;
            GridAcc.DataBind();

            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();
        }



        // ====================================после удаления ============================================
        private string getPostBackControlName()
        {
            string PostBackerID = Request.Form.Get(Page.postEventSourceID);
            string PostBackerArg = Request.Form.Get(Page.postEventArgumentID);

            getGrid();


            return "";
        }


    }
}

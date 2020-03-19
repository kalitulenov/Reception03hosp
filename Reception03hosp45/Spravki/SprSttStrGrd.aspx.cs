using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Configuration;
using Obout.Grid;
//using Obout.Interface;

namespace Reception03hosp45.Spravki
{
    public partial class SprSttStrGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
     //   string Html;
        string ComParKey = "";
        string ComParTxt = "";

    //    string ParKey = "";
        string MdbNam = "HOSPBASE";
    //    bool VisibleNo = false;
     //   bool VisibleYes = true;

        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //=====================================================================================
            sdsOpr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsOpr.SelectCommand = "SELECT USLKATKOD AS POLKOD,USLKATNAM AS POLNAM FROM SPRUSLKAT WHERE USLKATFRM='" + BuxFrm + "' ORDER BY USLKATNAM";

            sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsTyp.SelectCommand = "SELECT TYPSTXKOD AS TYPKOD,TYPSTXNAM AS TYPNAM FROM SPRTYPSTX ORDER BY TYPSTXKOD";

            sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsEdn.SelectCommand = "SELECT EDNKATKOD AS EDNKOD,EDNKATNAM AS EDNNAM FROM SPREDNKAT ORDER BY EDNKATKOD";

            sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsStx.SelectCommand = "SELECT SprSttStr.SttStrKod As STXKOD,SprSttStr.SttStrNam AS STXNAM " +
                                   "FROM SprFrmStx INNER JOIN SprSttStr ON SprFrmStx.FrmStxKodStx=SprSttStr.SttStrKod " +
                                   "WHERE SprSttStr.SttStrLvl=0 AND SprFrmStx.FrmStxKodFrm=" + BuxFrm + " ORDER BY SprSttStr.SttStrNam";

            //           GridStt.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            GridStt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridStt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridStt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            LoadGridNode();


        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {

            //      ComParKey = Convert.ToString(Session["HidNodKey"]);
            //      ComParTxt = Convert.ToString(Session["HidNodTxt"]);

 //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
            int LenKey = ComParKey.Length;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprSttStrSel", con);
            cmd = new SqlCommand("HspSprSttStrSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@LENKEY", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@TREKEY", SqlDbType.VarChar));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BuxFrm;
            cmd.Parameters["@LENKEY"].Value = LenKey;
            cmd.Parameters["@TREKEY"].Value = ComParKey;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprSttStrSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            ds.Dispose();
            con.Close();
            // возвращаем значение

            GridStt.DataSource = ds;
            GridStt.DataBind();


        }

               
        // ======================================================================================
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;
            //        int KltKod;
            string KltNam = "";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            KltIdn = Convert.ToInt32(e.Record["STTSTRIDN"]);
            //=====================================================================================
            if (Convert.ToString(e.Record["STTSTRNAM"]) == null || Convert.ToString(e.Record["STTSTRNAM"]) == "") KltNam = "";
            else KltNam = Convert.ToString(e.Record["STTSTRNAM"]);


            if (KltNam != "")
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("UPDATE SPRSTTSTR SET STTSTRNAM='" + KltNam + "' WHERE STTSTRIDN=" +KltIdn, con);
                // ------------------------------------------------------------------------------заполняем второй уровень
                cmd.ExecuteNonQuery();
                con.Close();

 //               HspSprSttStrRep(MdbNam, BuxFrm, BuxKod, KltIdn, ComParKey, KltNam, KltNum, KltTxt, KltAbc, KltDat, KltBeg, KltEnd, KltUbl, KltSum, KltStx);
                LoadGridNode();
            }
        }

// ======================================================================================
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            string KltNam = "";
   //         string KltNum = "";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            //=====================================================================================
            if (Convert.ToString(e.Record["STTSTRNAM"]) == null || Convert.ToString(e.Record["STTSTRNAM"]) == "") KltNam = "";
            else KltNam = Convert.ToString(e.Record["STTSTRNAM"]);

            if (KltNam != "")
            {

                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprSttStrAdd", con);
                cmd = new SqlCommand("HspSprSttStrAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // создать коллекцию параметров
                cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
                cmd.Parameters.Add(new SqlParameter("@KLTKEY", SqlDbType.VarChar));
                cmd.Parameters.Add(new SqlParameter("@KLTNAM", SqlDbType.VarChar));
                // ------------------------------------------------------------------------------заполняем первый уровень
                // передать параметр
                cmd.Parameters["@BUXFRM"].Value = BuxFrm;
                cmd.Parameters["@KLTKEY"].Value = ComParKey;
                cmd.Parameters["@KLTNAM"].Value = KltNam;
                // ------------------------------------------------------------------------------заполняем второй уровень
                cmd.ExecuteNonQuery();
                con.Close();

   //             HspSprSttStrAdd(MdbNam, BuxFrm, BuxKod, ComParKey, KltNam, KltNum);
                LoadGridNode();
            }

        }

// ======================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;

            KltIdn = Convert.ToInt32(e.Record["STTSTRIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRSTTSTR WHERE STTSTRIDN=" +KltIdn, con);
            // ------------------------------------------------------------------------------заполняем первый уровень
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close(); 

            LoadGridNode();

        }


        // ======================================================================================
        // ======================================================================================
        // ======================================================================================
        // ==================================================================================================  

    }
}

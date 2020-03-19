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
using Obout.Interface;

namespace Reception03hosp45.Spravki
{
    public partial class SprCntGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string Html;
        string ComParKey = "";
        string ComParTxt = "";

        string ParKey = "";
        string MdbNam = "HOSPBASE";
        bool VisibleNo = false;
        bool VisibleYes = true;

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
            sdsStx.SelectCommand = "SELECT SprCnt.CntKod As STXKOD,SprCnt.CntNam AS STXNAM " +
                                   "FROM SprFrmStx INNER JOIN SprCnt ON SprFrmStx.FrmStxKodStx=SprCnt.CntKod " +
                                   "WHERE SprCnt.CntLvl=0 AND SprFrmStx.FrmStxKodFrm=" + BuxFrm + " ORDER BY SprCnt.CntNam";

            //           GridCnt.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            GridCnt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridCnt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridCnt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

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
            DataSet ds = new DataSet("Menu");

            ds.Merge(InsSprCntSel(MdbNam, BuxFrm, LenKey, ComParKey));
            GridCnt.DataSource = ds;
            GridCnt.DataBind();


        }

               
        // ======================================================================================
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;
            //        int KltKod;
            string KltNam = "";
            string KltNum = "";
            string KltTxt = "";
            string KltAbc = "";
            string KltDat = "";
            string KltBeg = "";
            string KltEnd = "";
            int KltStx = 0;
            int KltSum = 0;
            bool KltUbl = false;
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];

            KltIdn = Convert.ToInt32(e.Record["CNTIDN"]);
            //=====================================================================================
                    if (Convert.ToString(e.Record["CNTNAM"]) == null || Convert.ToString(e.Record["CNTNAM"]) == "") KltNam = "";
                    else KltNam = Convert.ToString(e.Record["CNTNAM"]);

                    if (Convert.ToString(e.Record["CNTNUM"]) == null || Convert.ToString(e.Record["CNTNUM"]) == "") KltNum = "";
                    else KltNum = Convert.ToString(e.Record["CNTNUM"]);

                    if (Convert.ToString(e.Record["CNTTXT"]) == null || Convert.ToString(e.Record["CNTTXT"]) == "") KltTxt = "";
                    else KltTxt = Convert.ToString(e.Record["CNTTXT"]);

                    if (Convert.ToString(e.Record["CNTABC"]) == null || Convert.ToString(e.Record["CNTABC"]) == "") KltAbc = "";
                    else KltAbc = Convert.ToString(e.Record["CNTABC"]);

                    if (Convert.ToString(e.Record["CNTDAT"]) == null || Convert.ToString(e.Record["CNTDAT"]) == "") KltDat = "";
                    else KltDat = Convert.ToString(e.Record["CNTDAT"]);

                    if (Convert.ToString(e.Record["CNTBEG"]) == null || Convert.ToString(e.Record["CNTBEG"]) == "") KltBeg = "";
                    else KltBeg = Convert.ToString(e.Record["CNTBEG"]);

                    if (Convert.ToString(e.Record["CNTEND"]) == null || Convert.ToString(e.Record["CNTEND"]) == "") KltEnd = "";
                    else KltEnd = Convert.ToString(e.Record["CNTEND"]);

                    if (Convert.ToString(e.Record["CNTSTX"]) == null || Convert.ToString(e.Record["CNTSTX"]) == "") KltStx = 0;
                    else KltStx = Convert.ToInt32(e.Record["CNTSTX"]);

            //            if (Convert.ToString(e.Record["CNTSUM"]) == null || Convert.ToString(e.Record["CNTSUM"]) == "") KltSum = 0;
            //            else KltSum = Convert.ToInt32(e.Record["CNTSUM"]);
            KltSum = 0;

            KltUbl = Convert.ToBoolean(e.Record["CNTUBL"]);

            if (KltNam != "")
            {
                InsSprCntRep(MdbNam, BuxFrm, BuxKod, KltIdn, ComParKey, KltNam, KltNum, KltTxt, KltAbc, KltDat, KltBeg, KltEnd, KltUbl, KltSum, KltStx);
                LoadGridNode();
            }
        }

// ======================================================================================
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            //         int KltIdn;
            //          int KltKod;
            string KltNam = "";
            string KltNum = "";
            string KltTxt = "";
            string KltAbc = "";
            string KltDat = "";
            string KltBeg = "";
            string KltEnd = "";
            bool KltUbl = false;
            int KltSum = 0;
            int KltStx = 0;
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            //=====================================================================================
            if (Convert.ToString(e.Record["CNTNAM"]) == null || Convert.ToString(e.Record["CNTNAM"]) == "") KltNam = "";
            else KltNam = Convert.ToString(e.Record["CNTNAM"]);

            if (Convert.ToString(e.Record["CNTNUM"]) == null || Convert.ToString(e.Record["CNTNUM"]) == "") KltNum = "";
            else KltNum = Convert.ToString(e.Record["CNTNUM"]);

            if (Convert.ToString(e.Record["CNTTXT"]) == null || Convert.ToString(e.Record["CNTTXT"]) == "") KltTxt = "";
            else KltTxt = Convert.ToString(e.Record["CNTTXT"]);

            if (Convert.ToString(e.Record["CNTABC"]) == null || Convert.ToString(e.Record["CNTABC"]) == "") KltAbc = "";
            else KltAbc = Convert.ToString(e.Record["CNTABC"]);

            if (Convert.ToString(e.Record["CNTDAT"]) == null || Convert.ToString(e.Record["CNTDAT"]) == "") KltDat = "";
            else KltDat = Convert.ToString(e.Record["CNTDAT"]);

            if (Convert.ToString(e.Record["CNTBEG"]) == null || Convert.ToString(e.Record["CNTBEG"]) == "") KltBeg = "";
            else KltBeg = Convert.ToString(e.Record["CNTBEG"]);

            if (Convert.ToString(e.Record["CNTEND"]) == null || Convert.ToString(e.Record["CNTEND"]) == "") KltEnd = "";
            else KltEnd = Convert.ToString(e.Record["CNTEND"]);

            if (Convert.ToString(e.Record["CNTSTX"]) == null || Convert.ToString(e.Record["CNTSTX"]) == "") KltStx = 0;
            else KltStx = Convert.ToInt32(e.Record["CNTSTX"]);

            //      if (Convert.ToString(e.Record["CNTSUM"]) == null || Convert.ToString(e.Record["CNTSUM"]) == "") KltSum = 0;
            //       else KltSum = Convert.ToInt32(e.Record["CNTSUM"]);
            KltSum = 0;

                   KltUbl = Convert.ToBoolean(e.Record["CNTUBL"]);

            if (KltNam != "")
            {
                InsSprCntAdd(MdbNam, BuxFrm, BuxKod, ComParKey, KltNam, KltNum, KltTxt, KltAbc, KltDat, KltBeg, KltEnd, KltUbl, KltSum, KltStx);
                LoadGridNode();
            }

        }

// ======================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int KltIdn;

            KltIdn = Convert.ToInt32(e.Record["CNTIDN"]);

            InsSprCntDel(MdbNam, KltIdn, BuxKod);
            LoadGridNode();

        }


        // ======================================================================================
        public DataSet InsSprCntSel(string BUXMDB, string BUXFRM, int LENKEY, string TREKEY)
        {
            bool flag;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprCntSel", con);
            cmd = new SqlCommand("InsSprCntSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@LENKEY", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@TREKEY", SqlDbType.VarChar));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@LENKEY"].Value = LENKEY;
            cmd.Parameters["@TREKEY"].Value = TREKEY;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "InsSprCntSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            try
            {
                flag = true;
            }
            // если запись не найден
            catch
            {
                flag = false;
            }
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
            return ds;
        }

        // ======================================================================================
        public bool InsSprCntRep(string BUXMDB, string BUXFRM, string BUXKOD, int KLTIDN, string KLTKEY, string KLTNAM, string KLTNUM, string KLTTXT, string KLTABC, string KLTDAT, string KLTBEG, string KLTEND, bool KLTUBL, int KLTSUM, int KLTSTX)
        {
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprCntRep", con);
            cmd = new SqlCommand("InsSprCntRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKEY", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTIDN", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@KLTNAM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTNUM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTTXT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTABC", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTDAT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTBEG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTEND", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTSTX", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@KLTSUM", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@KLTUBL", SqlDbType.Bit, 1));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@BUXKOD"].Value = BUXKOD;
            cmd.Parameters["@KLTKEY"].Value = KLTKEY;
            cmd.Parameters["@KLTIDN"].Value = KLTIDN;
            cmd.Parameters["@KLTNAM"].Value = KLTNAM;
            cmd.Parameters["@KLTNUM"].Value = KLTNUM;
            cmd.Parameters["@KLTTXT"].Value = KLTTXT;
            cmd.Parameters["@KLTABC"].Value = KLTABC;
            cmd.Parameters["@KLTDAT"].Value = KLTDAT;
            cmd.Parameters["@KLTBEG"].Value = KLTBEG;
            cmd.Parameters["@KLTEND"].Value = KLTEND;
            cmd.Parameters["@KLTSUM"].Value = KLTSUM;
            cmd.Parameters["@KLTSTX"].Value = KLTSTX;
            cmd.Parameters["@KLTUBL"].Value = KLTUBL;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }

        // добавление подразделении  (справочника SPRSTRFRM)
        // ======================================================================================
        public bool InsSprCntAdd(string BUXMDB, string BUXFRM, string BUXKOD, string KLTKEY, string KLTNAM, string KLTNUM, string KLTTXT, string KLTABC, string KLTDAT, string KLTBEG, string KLTEND, bool KLTUBL, int KLTSUM, int KLTSTX)
        {
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprCntAdd", con);
            cmd = new SqlCommand("InsSprCntAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTKEY", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTNAM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTNUM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTTXT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTABC", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTDAT", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTBEG", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTEND", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@KLTUBL", SqlDbType.Bit, 1));
            cmd.Parameters.Add(new SqlParameter("@KLTSUM", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@KLTSTX", SqlDbType.Int, 4));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@BUXKOD"].Value = BUXKOD;
            cmd.Parameters["@KLTKEY"].Value = KLTKEY;
            cmd.Parameters["@KLTNAM"].Value = KLTNAM;
            cmd.Parameters["@KLTNUM"].Value = KLTNUM;
            cmd.Parameters["@KLTTXT"].Value = KLTTXT;
            cmd.Parameters["@KLTABC"].Value = KLTABC;
            cmd.Parameters["@KLTDAT"].Value = KLTDAT;
            cmd.Parameters["@KLTBEG"].Value = KLTBEG;
            cmd.Parameters["@KLTEND"].Value = KLTEND;
            cmd.Parameters["@KLTUBL"].Value = KLTUBL;
            cmd.Parameters["@KLTSUM"].Value = KLTSUM;
            cmd.Parameters["@KLTSTX"].Value = KLTSTX;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }

        // ==================================================================================================  

        // удаление подразделении  (справочника SPRSTRFRM)
        public bool InsSprCntDel(string BUXMDB, int BUXIDN, string BUXKOD)
        {

            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("InsSprCntDel", con);
            cmd = new SqlCommand("InsSprCntDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXIDN", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@BUXKOD", SqlDbType.VarChar));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXIDN"].Value = BUXIDN;
            cmd.Parameters["@BUXKOD"].Value = BUXKOD;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;

        }
       

    }
}

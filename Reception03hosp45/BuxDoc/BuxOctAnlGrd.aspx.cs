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

namespace Reception03hosp45.BuxDoc
{
    public partial class BuxOctAnlGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string Html;
        string ComParKey = "";
        string ComParTxt = "";

        string ComGod = "";
        string ComAcc = "";
        string ComSpr = "";
        int OctGod;
        int OctSpr;
        int OctSprVal;
        string OctAcc="";
        decimal OctSum;

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

            sdsAnl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

            GridAcc.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridAcc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridAcc.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            ComAcc = (string)Request.QueryString["NodAcc"];
            ComSpr = (string)Request.QueryString["NodSpr"];
            ComGod = (string)Request.QueryString["NodGod"];

            if (ComSpr == "1") sdsAnl.SelectCommand = "SELECT KOD,FIO AS NAM FROM SprKdr WHERE KDRFRM='" + BuxFrm + "' ORDER BY FIO";
            if (ComSpr == "2") sdsAnl.SelectCommand = "SELECT ORGKOD AS KOD,ORGNAM AS NAM FROM SPRORG WHERE ORGFRM='" + BuxFrm + "' ORDER BY ORGNAM";
            if (ComSpr == "3") sdsAnl.SelectCommand = "SELECT KLTIIN AS KOD,KLTFIO AS NAM FROM SPRKLT WHERE KLTFRM='" + BuxFrm + "' ORDER BY KLTFIO";
            if (ComSpr == "6") sdsAnl.SelectCommand = "SELECT SPRMOLKDR.MOLKOD AS KOD,FI AS NAM FROM SPRMOLKDR.MOLKOD WHERE KDRFRM='" + BuxFrm + "' ORDER BY FIO";

            //     parAcc..value = ComParKey;
            parFrmKod.Value = BuxFrm;
            parAcc.Value = ComParKey;
            parAccTxt.Value = ComParTxt;
            parGod.Value = ComGod;

            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {

            //      ComParKey = Convert.ToString(Session["HidNodKey"]);
            //      ComParTxt = Convert.ToString(Session["HidNodTxt"]);
            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxOctAnl", con);
            cmd = new SqlCommand("BuxOctAnl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@ACCGOD", SqlDbType.VarChar).Value = ComGod;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxOctAnl");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();

            GridAcc.DataSource = ds;
            GridAcc.DataBind();
            // возвращаем значение
        }
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            /*
            OctAccSprVal = Convert.ToInt32(e.Record["OCTACCSPRVAL"]);
            OctSum = Convert.ToDecimal(e.Record["OCTSUM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxOctAnlAdd", con);
            cmd = new SqlCommand("BuxOctAnlAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@OCTACC", SqlDbType.Int, 4).Value = OctAcc;
            cmd.Parameters.Add("@OCTACCSPR", SqlDbType.Int, 4).Value = OctAccSpr;
            cmd.Parameters.Add("@OCTACCSPRVAL", SqlDbType.Int, 4).Value = OctAccSprVal;
            cmd.Parameters.Add("@OCTSUM", SqlDbType.Decimal).Value = OctSum;
            cmd.Parameters.Add("@OCTGOD", SqlDbType.Int, 4).Value = OctGod;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            //     localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //      ws.ComSprBuxAdd(MdbNam, BuxSid, BuxFrm, OctKod, BuxDlg, BuxLog, BuxPsw);
            LoadGridNode();
            */
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            /*
            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);
            OctKod = Convert.ToInt32(e.Record["OctKod"]);
            BuxDlg = Convert.ToInt32(e.Record["BuxDlg"]);
            // BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);

            if (Convert.ToString(e.Record["BuxStf"]) == null || Convert.ToString(e.Record["BuxStf"]) == "") BuxStf = 1;
            else BuxStf = Convert.ToDecimal(e.Record["BuxStf"]);

            BuxUbl = Convert.ToBoolean(e.Record["BuxUbl"]);
            BuxLog = Convert.ToString(e.Record["BuxLog"]);
            BuxPsw = Convert.ToString(e.Record["BuxPsw"]);

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
            cmd.Parameters.Add("@OctKod", SqlDbType.Int, 4).Value = OctKod;
            cmd.Parameters.Add("@BUXDLG", SqlDbType.Int, 4).Value = BuxDlg;
            cmd.Parameters.Add("@BUXSTF", SqlDbType.Decimal).Value = BuxStf;
            cmd.Parameters.Add("@BUXUBL", SqlDbType.Bit, 1).Value = BuxUbl;
            cmd.Parameters.Add("@BUXLOG", SqlDbType.VarChar).Value = BuxLog;
            cmd.Parameters.Add("@BUXPSW", SqlDbType.VarChar).Value = BuxPsw;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            //        localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //        ws.ComSprBuxRep(MdbNam, BuxSid, BuxIdn, OctKod, BuxDlg, BuxUbl, BuxLog, BuxPsw);

            LoadGridNode();
            */
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            /*
            BuxIdn = Convert.ToInt32(e.Record["BuxIdn"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprBuxDel(MdbNam, BuxSid, BuxIdn);
            LoadGridNode();
*/
        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        // ======================================================================================
        // добавление подразделении  (справочника SPRSTRFRM)
        // ======================================================================================
    }
}

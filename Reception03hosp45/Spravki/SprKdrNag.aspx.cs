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
    public partial class SprKdrNag : System.Web.UI.Page
    {
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        string KdrKodTxt;

        int NgrIdn;
        int NgrKod;
        string NgrNam;
        string NgrDat;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            //       KDRKODHID.Value = "0";
            if (KDRKODHID.Value == null) KDRKODHID.Value = "0";
            if (KDRKODHID.Value == "") KDRKODHID.Value = "0";
            KdrKodTxt = KDRKODHID.Value;

            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            grid2.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord2);
            grid2.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord2);
            grid2.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord2);
            //=====================================================================================
            if (IsPostBack)
            {
                getGrid2();
            }
            else
            {
                getGrid();
            }
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
            SqlCommand cmd = new SqlCommand("SELECT * FROM KDR WHERE KDRFRM=" + BuxFrm + " ORDER BY KDRFAM", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprKdr");
            grid1.DataSource = ds;
            grid1.DataBind();

        }
        // ============================ чтение таблицы а оп ==============================================
        void getGrid2()
        {
            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM KDRNGR WHERE NGRKOD=" + KdrKodTxt, con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprKdrNgr");
            grid2.DataSource = ds;
            grid2.DataBind();

        }

        // ======================================================================================

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            getGrid();
        }

        // ======================================================================================

        void InsertRecord2(object sender, GridRecordEventArgs e)
        {
            string NgrDatTxt;

            NgrKod = Convert.ToInt32(KdrKodTxt);
            NgrNam = Convert.ToString(e.Record["NGRNAM"]);

            NgrDatTxt = Convert.ToString(e.Record["NGRDAT"]);
            if (string.IsNullOrEmpty(NgrDatTxt))
            { NgrDatTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { NgrDatTxt = Convert.ToDateTime(e.Record["NGRDAT"]).ToString("dd.MM.yyyy"); }

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprKdrNgrAdd(MdbNam, BuxSid, NgrKod, NgrNam, NgrDatTxt);
            getGrid2();
        }

        void UpdateRecord2(object sender, GridRecordEventArgs e)
        {
            string NgrDatTxt;

            NgrIdn = Convert.ToInt32(e.Record["NGRIDN"]);
            NgrNam = Convert.ToString(e.Record["NGRNAM"]);

            NgrDatTxt = Convert.ToString(e.Record["NGRDAT"]);
            if (string.IsNullOrEmpty(NgrDatTxt))
            { NgrDatTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { NgrDatTxt = Convert.ToDateTime(e.Record["NGRDAT"]).ToString("dd.MM.yyyy"); }

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprKdrNgrRep(MdbNam, BuxSid, NgrIdn, NgrNam, NgrDatTxt);
            getGrid2();
        }

        void DeleteRecord2(object sender, GridRecordEventArgs e)
        {
            NgrIdn = Convert.ToInt32(e.Record["NGRIDN"]);
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprKdrNgrDel(MdbNam, BuxSid, NgrIdn);
            getGrid2();
        }


    }
}

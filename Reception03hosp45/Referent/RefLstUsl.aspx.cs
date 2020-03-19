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

namespace Reception03hosp45.Referent
{
    public partial class RefLstUsl : System.Web.UI.Page
    {
        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int AmbIdn;
        DateTime AmbDat;
        string AmbBeg;
        string AmbPth;
        string AmbTel;
        int AmbUsl;
        int AmbZen;
        int AmbKod;

        int ItgUsl = 0;

        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Sapka.Text = "Журнал приема врачей за период с ".PadLeft(50) +
                        Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy") +
                        " по " + Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
            //=====================================================================================
            sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsUsl.SelectCommand = "SELECT LvlKod AS Kod,SprStrUsl.StrUslNam+' > '+SprStrUsl_1.StrUslNam+' > '+SprUsl.UslNam AS Usl " +
                                   "FROM SprUsl RIGHT OUTER JOIN SprUslFrmLvl ON SprUsl.UslKod=SprUslFrmLvl.LvlKod " +
                                   "LEFT OUTER JOIN SprStrUsl AS SprStrUsl_1 ON SprUslFrmLvl.Lvl002 = SprStrUsl_1.StrUslKey " +
                                   "LEFT OUTER JOIN SprStrUsl ON SprUslFrmLvl.Lvl001=SprStrUsl.StrUslKey " +
                                   "WHERE SprUslFrmLvl.LvlZen IS NOT NULL AND  SprUslFrmLvl.LvlHsp=" + BuxFrm +
                                   " ORDER BY SprUslFrmLvl.LvlKey,Usl";

            sdsFio.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsFio.SelectCommand = "SELECT BUXKOD AS KOD,FIO FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " ORDER BY FIO";
            //=====================================================================================
            Grid1.RowDataBound += new Obout.Grid.GridRowEventHandler(SumUsl);
            Grid1.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            Grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            Grid1.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            if (!Page.IsPostBack)
            {
                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
            }



            getGrid();
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("Spr000");

            ds.Merge(ws.AmbCrdTab(MdbNam, BuxSid, BuxFrm, GlvBegDat, GlvEndDat));
            Grid1.DataSource = ds;
            Grid1.DataBind();
        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            getGrid();
        }

        // ---------Суммация оплаты ------------------------------------------------------------------------
        public void SumUsl(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {

                if (e.Row.Cells[6].Text == null | e.Row.Cells[6].Text == "") ItgUsl += 0;
                else ItgUsl += int.Parse(e.Row.Cells[6].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[5].Text = "Итого:";
                e.Row.Cells[6].Text = ItgUsl.ToString();

            }
        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            string RabDat;

            RabDat = Convert.ToString(e.Record["AMBDAT"]);
            if (string.IsNullOrEmpty(RabDat)) AmbDat = DateTime.Now;
            else AmbDat = DateTime.Parse(RabDat);

            RabDat = Convert.ToString(e.Record["AMBBEG"]);
            if (string.IsNullOrEmpty(RabDat)) AmbBeg = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            else AmbBeg = RabDat;

            AmbDat = Convert.ToDateTime(e.Record["AMBDAT"]);
            AmbPth = Convert.ToString(e.Record["AMBPTH"]);
            AmbTel = Convert.ToString(e.Record["AMBTEL"]);
            AmbUsl = Convert.ToInt32(e.Record["AMBUSL"]);
            AmbZen = Convert.ToInt32(e.Record["AMBZEN"]);
            AmbKod = Convert.ToInt32(e.Record["AMBKOD"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.AmbCrdTabAdd(MdbNam, BuxSid, BuxFrm, AmbKod, AmbDat, AmbBeg, AmbPth, AmbTel, AmbUsl, AmbZen);
            getGrid();
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            string RabDat;

            RabDat = Convert.ToString(e.Record["AMBDAT"]);
            if (string.IsNullOrEmpty(RabDat)) AmbDat = DateTime.Now;
            else AmbDat = DateTime.Parse(RabDat);

            RabDat = Convert.ToString(e.Record["AMBBEG"]);
            if (string.IsNullOrEmpty(RabDat)) AmbBeg = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            else AmbBeg = RabDat;

     //       AmbUslTxt = Convert.ToString(USLNAMHID.Value);
     //       int Index = AmbUslTxt.IndexOf(@">");
     //       if (Index == -1) AmbUsl = 0;
     //       else AmbUsl = Convert.ToInt32(AmbUslTxt.Substring(0, Index));

            AmbIdn = Convert.ToInt32(e.Record["AMBIDN"]);
            AmbDat = Convert.ToDateTime(e.Record["AMBDAT"]);
            AmbPth = Convert.ToString(e.Record["AMBPTH"]);
            AmbTel = Convert.ToString(e.Record["AMBTEL"]);
            AmbUsl = Convert.ToInt32(e.Record["AMBUSL"]);
            AmbZen = Convert.ToInt32(e.Record["AMBZEN"]);
            AmbKod = Convert.ToInt32(e.Record["AMBKOD"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.AmbCrdTabRep(MdbNam, BuxSid, AmbIdn, AmbKod, AmbDat, AmbBeg, AmbPth, AmbTel, AmbUsl, AmbZen);
            getGrid();
        }

        //============= удаление записи после опроса  ===========================================================================================

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            AmbIdn = Convert.ToInt32(e.Record["AMBIDN"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.AmbCrdTabDel(MdbNam, BuxSid, AmbIdn);
            getGrid();

        }

    }
}

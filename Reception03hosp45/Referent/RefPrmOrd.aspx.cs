using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Obout.ComboBox;
using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using System.Web.Configuration;
using System.Collections;   // для Hashtable
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Text;

namespace Reception03hosp45.Referent
{
    public partial class RefPrmOrd : System.Web.UI.Page
    {
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg001;
        int GrfDlg002;
        int GrfDlg003;

        int GrfKod001;
        int GrfKod002;
        int GrfKod003;

        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Sapka.Text = "График приема врачей за период с ".PadLeft(70) +
                        Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy") +
                        " по " + Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
            //=====================================================================================
            SdsDoc001.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsDoc002.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsDoc003.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsDoc001.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM " +
                                   "FROM SprZan RIGHT OUTER JOIN SprDlg ON SprZan.ZANKOD=SprDlg.DLGZAN " +
                                   "RIGHT OUTER JOIN SprBux ON SprDlg.DLGKOD=SprBux.BuxDlg " +
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (SprZan.ZANFLG = 1) AND (SprBux.BuxFrm="+ BuxFrm +") "+
                                   "GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg " +
                                   "ORDER BY SprDlg.DLGNAM";
            SdsDoc002.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM " +
                                   "FROM SprZan RIGHT OUTER JOIN SprDlg ON SprZan.ZANKOD=SprDlg.DLGZAN " +
                                   "RIGHT OUTER JOIN SprBux ON SprDlg.DLGKOD=SprBux.BuxDlg " +
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (SprZan.ZANFLG = 1) AND (SprBux.BuxFrm=" + BuxFrm + ") " +
                                   "GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg " +
                                   "ORDER BY SprDlg.DLGNAM";
            SdsDoc003.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM " +
                                   "FROM SprZan RIGHT OUTER JOIN SprDlg ON SprZan.ZANKOD=SprDlg.DLGZAN " +
                                   "RIGHT OUTER JOIN SprBux ON SprDlg.DLGKOD=SprBux.BuxDlg " +
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (SprZan.ZANFLG = 1) AND (SprBux.BuxFrm=" + BuxFrm + ") " +
                                   "GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg " +
                                   "ORDER BY SprDlg.DLGNAM";

            SdsFio001.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsFio001.SelectCommand = "SELECT BuxKod,FIO FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                   "WHERE SprBux.BuxDlg=" + GrfDlg001 + " ORDER BY SprKdr.FIO";
            SdsFio002.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsFio002.SelectCommand = "SELECT BuxKod,FIO FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                   "WHERE SprBux.BuxDlg=" + GrfDlg002 + " ORDER BY SprKdr.FIO";
            SdsFio003.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsFio003.SelectCommand = "SELECT BuxKod,FIO FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                   "WHERE SprBux.BuxDlg=" + GrfDlg003 + " ORDER BY SprKdr.FIO";

            SdsKlt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            //          sdsEdn.SelectCommand = "SELECT EDNKOD AS KOD,EDNNAM AS NAM FROM SPREDNUSL ORDER BY EDNNAM";
            //================================== GodNam ===============================================================
            grid01.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            grid02.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            grid03.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            //=====================================================================================
            if (!Page.IsPostBack)
            {
            }
            else
            {
                if (parBtn.Value == "OK" && grid2.SelectedRecords == null)
                   {
                     GetGrid2();
                     parBtn.Value = "";
                   }
            }
        }

        // ==================================== поиск клиента по фильтрам  ============================================
        void GetGrid2()
        {
            int I = 0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            string commandText = "SELECT * FROM KLT ";
            string whereClause = "";

            if (FndFio.Text != "")
            {
                I = I + 1;
                whereClause += "KLTFAM LIKE '" + FndFio.Text.Replace("'", "''") + "%'";
            }
            if (FndTel.Text != "")
            {
                I = I + 1;
                if (I > 1) whereClause += " AND ";
                whereClause += "KLTTHN LIKE '%" + FndTel.Text.Replace("'", "''") + "%'";
            } 
              
            if (whereClause != "")
            {
                commandText += " where " + whereClause;
                SqlCommand cmd = new SqlCommand(commandText, con);
                con.Open();
                SqlDataReader myReader = cmd.ExecuteReader();
                grid2.DataSource = myReader;
                grid2.DataBind();
                con.Close();
            }
        }

        // ======================================================================================
        //------------------------------------------------------------------------KLTADR
        void UpdateRecordXX(object sender, GridRecordEventArgs e)
        {
            int GrfIdn;
            Boolean GrfBus;
            int GrfKolZap;

            GrfIdn = Convert.ToInt32(e.Record["GRFIDN"]);
            GrfBus = Convert.ToBoolean(e.Record["GRFBUS"]);

  //          if (parKol.Value == "0" || parKol.Value == "") GrfKolZap = 1;
  //          else GrfKolZap = Convert.ToInt32(parKol.Value);
            GrfKolZap = 1;

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            if (parUpd.Value == "0")
            {
                ws.RefGlvScrRep(MdbNam, BuxSid, BuxFrm, GrfIdn, GrfBus, FndFio.Text, "", FndTel.Text, "", GrfKolZap);
            }
            else ws.RefGlvScrRepBus(MdbNam, BuxSid, BuxFrm, GrfIdn);

            if (parPnl.Value == "1") getBox001();
            if (parPnl.Value == "2") getBox002();
            if (parPnl.Value == "3") getBox003();
        }

        //------------------------------------------------------------------------
        protected void BoxDoc001_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (BoxDoc001.SelectedValue == "") GrfDlg001 = 0;
            else GrfDlg001 = Convert.ToInt32(BoxDoc001.SelectedValue);

            BoxFio001.Enabled = true;
            BoxFio001.Items.Clear();
            BoxFio001.SelectedIndex = -1;
            BoxFio001.SelectedValue = "";
            BoxFio001.DataBind();

 //           SdsFio001.SelectCommand = "SELECT BuxKod,FIO FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
 //                                 "WHERE SprBux.BuxDlg=" + GrfDlg001 + " ORDER BY SprKdr.FIO";
            SdsFio001.SelectCommand = "SELECT BuxKod,SprKdr.FIO " +
                                      "FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                      "WHERE SprBux.BuxDlg=" + GrfDlg001 + " AND ISNULL(SprBux.BuxUbl,0)=0 "+
                                      " AND SprBux.BuxFrm=" + BuxFrm +
                                      " ORDER BY SprKdr.FIO ";
            GrfKod001 = 0;
            getBox001();

        }
        //------------------------------------------------------------------------
        protected void BoxFio001_OnSelectedIndexChanged(object sender, EventArgs e)
        {

            if (BoxFio001.SelectedValue == "") GrfKod001 = 0;
            else GrfKod001 = Convert.ToInt32(BoxFio001.SelectedValue);
            getBox001();

        }
        //------------------------------------------------------------------------
        private string getBox001()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc001.SelectedValue == "") GrfDlg001 = 0;
            else GrfDlg001 = Convert.ToInt32(BoxDoc001.SelectedValue);
            if (BoxFio001.SelectedValue == "") GrfKod001 = 0;
            else GrfKod001 = Convert.ToInt32(BoxFio001.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg001, GrfKod001, GlvBegDat, GlvEndDat));
            grid01.DataSource = ds;
            grid01.DataBind();

            return "";
        }

        //------------------------------------------------------------------------
        protected void BoxDoc002_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (BoxDoc002.SelectedValue == "") GrfDlg002 = 0;
            else GrfDlg002 = Convert.ToInt32(BoxDoc002.SelectedValue);

            BoxFio002.Enabled = true;
            BoxFio002.Items.Clear();
            BoxFio002.SelectedIndex = -1;
            BoxFio002.SelectedValue = "";
            BoxFio002.DataBind();

            SdsFio001.SelectCommand = "SELECT BuxKod,SprKdr.FIO " +
                                      "FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                      "WHERE SprBux.BuxDlg=" + GrfDlg002 + " AND ISNULL(SprBux.BuxUbl,0)=0 " +
                                      " AND SprBux.BuxFrm=" + BuxFrm + 
                                      " ORDER BY SprKdr.FIO ";
            GrfKod002 = 0;
            getBox002();

        }

        //------------------------------------------------------------------------
        protected void BoxFio002_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (BoxFio002.SelectedValue == "") GrfKod002 = 0;
            else GrfKod002 = Convert.ToInt32(BoxFio002.SelectedValue);
            getBox002();

        }

        //------------------------------------------------------------------------
        private string getBox002()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc002.SelectedValue == "") GrfDlg002 = 0;
            else GrfDlg002 = Convert.ToInt32(BoxDoc002.SelectedValue);
            if (BoxFio002.SelectedValue == "") GrfKod002 = 0;
            else GrfKod002 = Convert.ToInt32(BoxFio002.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg002, GrfKod002, GlvBegDat, GlvEndDat));
            grid02.DataSource = ds;
            grid02.DataBind();

            return "";
        }
        


        //------------------------------------------------------------------------
        protected void BoxDoc003_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (BoxDoc003.SelectedValue == "") GrfDlg003 = 0;
            else GrfDlg003 = Convert.ToInt32(BoxDoc003.SelectedValue);

            BoxFio003.Enabled = true;
            BoxFio003.Items.Clear();
            BoxFio003.SelectedIndex = -1;
            BoxFio003.SelectedValue = "";
            BoxFio003.DataBind();

            SdsFio001.SelectCommand = "SELECT BuxKod,SprKdr.FIO " +
                                      "FROM SprBux LEFT OUTER JOIN SprKdr ON SprBux.BuxTab=SprKdr.KOD " +
                                      "WHERE SprBux.BuxDlg=" + GrfDlg003 + " AND ISNULL(SprBux.BuxUbl,0)=0 " +
                                      " AND SprBux.BuxFrm=" + BuxFrm +
                                      " ORDER BY SprKdr.FIO ";
            GrfKod003 = 0;
            getBox003();

        }

        //------------------------------------------------------------------------
        protected void BoxFio003_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (BoxFio003.SelectedValue == "") GrfKod003 = 0;
            else GrfKod003 = Convert.ToInt32(BoxFio003.SelectedValue);
            getBox003();

        }
        //------------------------------------------------------------------------
        private string getBox003()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc003.SelectedValue == "") GrfDlg003 = 0;
            else GrfDlg003 = Convert.ToInt32(BoxDoc003.SelectedValue);
            if (BoxFio003.SelectedValue == "") GrfKod003 = 0;
            else GrfKod003 = Convert.ToInt32(BoxFio003.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg003, GrfKod003, GlvBegDat, GlvEndDat));
            grid03.DataSource = ds;
            grid03.DataBind();

            return "";
        }
        //------------------------------------------------------------------------
        protected void ButHid_Click(object sender, EventArgs e)
        {

            FndFio.Text = "";
   //         FndIma.Text = "";
            FndTel.Text = "";
    //        FndEml.Text = "";

            if (grid2.SelectedRecords != null)
            {
                foreach (Hashtable oRecord in grid2.SelectedRecords)
                {
                    FndFio.Text += oRecord["KLTFAM"];
  //                  FndIma.Text += oRecord["KLTIMA"];
                    FndTel.Text += oRecord["KLTTHN"];
 //                   FndEml.Text += oRecord["KLTEML"];
                }

            }
            grid2.SelectedRecords = null;
        }

        //------------------------------------------------------------------------
        protected void ButPst001_Click(object sender, EventArgs e)
        {
            getBox001();
        }

        //------------------------------------------------------------------------
        protected void ButPrt001_Click(object sender, EventArgs e)
        {
        }

        //------------------------------------------------------------------------
        protected void ButPst002_Click(object sender, EventArgs e)
        {
            getBox002();
        }

        //------------------------------------------------------------------------
        protected void ButPrt002_Click(object sender, EventArgs e)
        {
        }

        //------------------------------------------------------------------------
        protected void ButPst003_Click(object sender, EventArgs e)
        {
            getBox003();
        }

        //------------------------------------------------------------------------
        protected void ButPrt003_Click(object sender, EventArgs e)
        {
        }
        //------------------------------------------------------------------------
    }
}

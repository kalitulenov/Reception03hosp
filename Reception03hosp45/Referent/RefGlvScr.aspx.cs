using System;
using System.Collections.Generic;
using System.Linq;
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
    public partial class RefGlvScr : System.Web.UI.Page
    {
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

            GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);


            Sapka.Text = "График приема врачей за период с ".PadLeft(70) +
                        Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy") +
                        " по " + Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
            //=====================================================================================
            SdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsDoc.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM "+
                                   "FROM SprBux LEFT OUTER JOIN SprDlg ON SprBux.BuxDlg=SprDlg.DLGKOD "+
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (SprDlg.DLGZAN=2 OR SprDlg.DLGZAN=3) "+
                                   "GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg "+
                                   "ORDER BY SprDlg.DLGNAM";
            SdsFio.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";

            SdsKlt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            //          sdsEdn.SelectCommand = "SELECT EDNKOD AS KOD,EDNNAM AS NAM FROM SPREDNUSL ORDER BY EDNNAM";
            //================================== GodNam ===============================================================
            grid01.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            grid02.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            grid03.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
 //           grid04.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordXX);
            //            grid1.Rebind += new Obout.Grid.Grid.DefaultEventHandler(RebindGrid);
            //=====================================================================================
            if (!Page.IsPostBack)
            {


            }
            else
            {
                if (grid2.SelectedRecords == null)
                {
//                    myWindow.Visible = true;
                    GetGrid2();
                }
            }
        }

        // ====================================после удаления ============================================
        void GetGrid2()
        {
            int I=0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            //           OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));

            string commandText = "SELECT * FROM KLT ";
            string whereClause = "";

            if (FndFio.Text != "")
                {
                    I=I+1;
                    whereClause += "KLTFAM LIKE '" + FndFio.Text.Replace("'", "''") + "%'";
                }
            if (FndIma.Text != "")
                {
                  I=I+1;
                  if (I>1) whereClause += " AND ";
                  whereClause += "KLTIMA LIKE '%" + FndIma.Text.Replace("'", "''") + "%'";
                }
            if (FndKrt.Text != "")
                {
                  I=I+1;
                  if (I>1) whereClause += " AND ";
                  whereClause += "KLTKRT LIKE '%" + FndKrt.Text.Replace("'", "''") + "%'";
                }
            if (FndFrm.Text != "")
                {
                  I=I+1;
                  if (I>1) whereClause += " AND ";
                  whereClause += "KLTFRMTXT LIKE '%" + FndFrm.Text.Replace("'", "''") + "%'";
                }
            if (FndTel.Text != "")
            {
                I = I + 1;
                if (I > 1) whereClause += " AND ";
                whereClause += "KLTTHN LIKE '%" + FndTel.Text.Replace("'", "''") + "%'";
            } if (FndAdr.Text != "")
            {
                I = I + 1;
                if (I > 1) whereClause += " AND ";
                whereClause += "KLTADR LIKE '%" + FndAdr.Text.Replace("'", "''") + "%'";
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
        //------------------------------------------------------------------------
        void UpdateRecordXX(object sender, GridRecordEventArgs e)
        {
            int GrfIdn;
        //    Boolean GrfBus;
            string GrfPth;
            string GrfAdr;
            string GrfPol;
            string GrfBrt;
            string GrfFrm;
            string GrfTel;
            string GrfBus;

            GrfIdn = Convert.ToInt32(e.Record["GRFIDN"]);
            GrfBus = Convert.ToString(e.Record["GRFBUS"]);
            GrfPth = Convert.ToString(e.Record["GRFPTH"]);
            GrfAdr = Convert.ToString(e.Record["GRFADR"]);
            GrfTel = Convert.ToString(e.Record["GRFTEL"]);

            GrfPol = Convert.ToString(e.Record["GRFPOL"]);
            GrfBrt = Convert.ToString(e.Record["GRFBRT"]);
            GrfFrm = Convert.ToString(e.Record["GRFFRM"]);

            if (parUpd.Value == "1") GrfBus = "CONST";

            // ===================== записать в базу ================================================================================
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();

 //           GrfBus = (string)DocGrf[1];

            // создание команды
            //             SqlCommand cmd = new SqlCommand("UPDATE DOCGRF SET GRFBUS=1,GRFINTFLG=1,GRFINTBEG=GETDATE(),GRFINTEND=DATEADD(MINUTE,60,GETDATE()),GRFPTH=@GRFPTH,GRFEML=@GRFEML,GRFTEL=@GRFTEL WHERE GRFIDN=@GRFIDN", con);
            SqlCommand cmd = new SqlCommand("HspDocGrfRepRef", con);
            cmd = new SqlCommand("HspDocGrfRepRef", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            if (string.IsNullOrEmpty(GrfPth)) GrfPth = "-";
            if (string.IsNullOrEmpty(GrfTel)) GrfTel = "-";
            if (string.IsNullOrEmpty(GrfAdr)) GrfAdr = "-";

            cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = GrfIdn;
            cmd.Parameters.Add("@GRFBUS", SqlDbType.VarChar).Value = GrfBus;
            cmd.Parameters.Add("@GRFPTH", SqlDbType.VarChar).Value = GrfPth;
            cmd.Parameters.Add("@GRFADR", SqlDbType.VarChar).Value = GrfAdr;
            cmd.Parameters.Add("@GRFTEL", SqlDbType.VarChar).Value = GrfTel;
            cmd.Parameters.Add("@GRFPOL", SqlDbType.VarChar).Value = GrfPol;
            cmd.Parameters.Add("@GRFBRT", SqlDbType.VarChar).Value = GrfBrt;
            cmd.Parameters.Add("@GRFFRMTXT", SqlDbType.VarChar).Value = GrfFrm;

            // Выполнить команду
            cmd.ExecuteNonQuery();
            con.Close();


//            localhost.Service1Soap ws = new localhost.Service1SoapClient();

//            if (parUpd.Value == "0") ws.RefGlvScrRep(BuxSid, BuxFrm, GrfIdn, GrfBus, FndFio.Text, FndIma.Text, FndBrt.Text, FndKrt.Text, FndFrm.Text, FndTel.Text, FndAdr.Text);
//            else ws.RefGlvScrRepBus(BuxSid, BuxFrm, GrfIdn);

            if (parPnl.Value == "1") getBox001();
            if (parPnl.Value == "2") getBox002();
            if (parPnl.Value == "3") getBox003();
 //           if (parPnl.Value == "4") getBox004();

        }
        //------------------------------------------------------------------------
        private string getBox001()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc001.SelectedValue == "") GrfDlg = 0;
            else GrfDlg = Convert.ToInt32(BoxDoc001.SelectedValue);
            if (BoxFio001.SelectedValue == "") GrfKod = 0;
            else GrfKod = Convert.ToInt32(BoxFio001.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg, GrfKod, GlvBegDat, GlvEndDat));
            grid01.DataSource = ds;
            grid01.DataBind();

            return "";
        }
        protected void BoxDoc001_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfDlg = Convert.ToInt32(BoxDoc001.SelectedValue);

            BoxFio001.Enabled = true;
            BoxFio001.Items.Clear();
            BoxFio001.SelectedIndex = -1;
            BoxFio001.SelectedValue = "";
            BoxFio001.DataBind();
            
            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";
           
            GrfKod = 0;
            getBox001();

        }

        protected void BoxFio001_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfKod = Convert.ToInt32(BoxFio001.SelectedValue);
            getBox001();

        }
        //------------------------------------------------------------------------
        private string getBox002()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc002.SelectedValue == "") GrfDlg = 0;
            else GrfDlg = Convert.ToInt32(BoxDoc002.SelectedValue);
            if (BoxFio002.SelectedValue == "") GrfKod = 0;
            else GrfKod = Convert.ToInt32(BoxFio002.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg, GrfKod, GlvBegDat, GlvEndDat));
            grid02.DataSource = ds;
            grid02.DataBind();


            return "";
        }

        protected void BoxDoc002_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfDlg = Convert.ToInt32(BoxDoc002.SelectedValue);

            BoxFio002.Enabled = true;
            BoxFio002.Items.Clear();
            BoxFio002.SelectedIndex = -1;
            BoxFio002.SelectedValue = "";
            BoxFio002.DataBind();

            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";

            GrfKod = 0;
            getBox002();

        }

        protected void BoxFio002_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfKod = Convert.ToInt32(BoxFio002.SelectedValue);
            getBox002();

        } 
      
        //------------------------------------------------------------------------
        private string getBox003()
        {
            DataSet ds = new DataSet("Menu");
            localhost.Service1Soap ws = new localhost.Service1SoapClient();

            if (BoxDoc003.SelectedValue == "") GrfDlg = 0;
            else GrfDlg = Convert.ToInt32(BoxDoc003.SelectedValue);
            if (BoxFio003.SelectedValue == "") GrfKod = 0;
            else GrfKod = Convert.ToInt32(BoxFio003.SelectedValue);

            ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg, GrfKod, GlvBegDat, GlvEndDat));
            grid03.DataSource = ds;
            grid03.DataBind();



            return "";
        }

        protected void BoxDoc003_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfDlg = Convert.ToInt32(BoxDoc003.SelectedValue);

            BoxFio003.Enabled = true;
            BoxFio003.Items.Clear();
            BoxFio003.SelectedIndex = -1;
            BoxFio003.SelectedValue = "";
            BoxFio003.DataBind();

            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";

            GrfKod = 0;
            getBox003();

        }

        protected void BoxFio003_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            GrfKod = Convert.ToInt32(BoxFio003.SelectedValue);
            getBox003();

        }       
        //------------------------------------------------------------------------
        protected void ButHid_Click(object sender, EventArgs e)
        {

            FndFio.Text = "";
            FndIma.Text = "";
            FndKrt.Text = "";
            FndBrt.Text = "";
            FndFrm.Text = "";
            FndTel.Text = "";
            FndAdr.Text = "";

            if (grid2.SelectedRecords != null)
            {
                foreach (Hashtable oRecord in grid2.SelectedRecords)
                {
                    FndFio.Text += oRecord["KLTFAM"];
                    FndIma.Text += oRecord["KLTIMA"];
                    FndBrt.Text += oRecord["KLTBRT"];
                    FndBrt.Text = FndBrt.Text.Substring(0, 10);
                    FndKrt.Text += oRecord["KLTKRT"];
                    FndFrm.Text += oRecord["KLTFRMTXT"];
                    FndTel.Text += oRecord["KLTTHN"];
                    FndAdr.Text += oRecord["KLTADR"];
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
        protected void ButPrt004_Click(object sender, EventArgs e)
        {
        }
    }
}

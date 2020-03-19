using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using System.Web.Configuration;
using System.Collections;   // для Hashtable
using System.Web.Services;
using System.Web.UI.HtmlControls;
using Obout.Ajax.UI.TreeView;

using System.Text;

namespace Reception03hosp45.Spravki
{
    public partial class SprGrfDoc : System.Web.UI.Page
    {
        //        Grid GridGrf = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxFrmNam;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int ParKey;
        string Html;

 //       string ComParKey = "";
 //       int ComKolVip;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxFrmNam = (string)Session["BuxFrmNam"];
            parBuxFrm.Value = BuxFrm;

            //            Sapka.Text ="График врачей за период с ".PadLeft(70)+
            //                        Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy")+
            //                        " по " + Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
            //            Sapka.Text = "График врачей";
            //=====================================================================================
            GridGrf.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridGrf.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridGrf.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //=====================================================================================
            sdsNed.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNed.SelectCommand = "SELECT DNINEDKOD AS NEDKOD,DNINEDNAM AS NEDNAM FROM SPRDNINED ORDER BY DNINEDKOD";
            sdsCab.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsCab.SelectCommand = "SELECT CABKOD,CABNAM FROM SPRCAB WHERE CABFRM="+ BuxFrm + " ORDER BY CABNAM";

            sdsTimBeg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsTimBeg.SelectCommand = "SELECT TIMNAM AS TIMBEG FROM SPRTIM ORDER BY TIMNAM";
            sdsTimEnd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsTimEnd.SelectCommand = "SELECT TIMNAM AS TIMEND FROM SPRTIM ORDER BY TIMNAM";

            sdsTimBegNon.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsTimBegNon.SelectCommand = "SELECT TIMNAM AS TIMBEGNON FROM SPRTIM ORDER BY TIMNAM";
            sdsTimEndNon.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsTimEndNon.SelectCommand = "SELECT TIMNAM AS TIMENDNON FROM SPRTIM ORDER BY TIMNAM";

            if (!Page.IsPostBack)
            {

                //------------       чтение уровней дерево
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("ComSprGrfDoc", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@DLGKOD", SqlDbType.Int, 4).Value = 0;
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "ComSprGrfDoc");

                con.Close();
                //=====================================================================================
                Node rootNode = new Node() { Text = "Клиника " + BuxFrmNam.ToString(), Expanded = true };
                OboutTree.Nodes.Add(rootNode);

                foreach (DataRow row in ds.Tables["ComSprGrfDoc"].Rows)
                {
                    Html = Convert.ToString(row["DlgNam"]);

                    Node newNode = new Node();
                    newNode.Text = Html;
                    newNode.Value = Convert.ToString(row["DlgKod"]);
                    newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                    this.OboutTree.Nodes.Add(newNode);
                }

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");


            }
            else
            {
 //               getPostBackControlName();
            }

            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;

        }

        // ====================================после удаления ============================================
        void getPostBackControlName()
        {

            int NodLvl;
            int NodVal;

            NodVal = Convert.ToInt32(OboutTree.SelectedNode.Value);
            NodLvl = OboutTree.SelectedNode.Level;

 //           localhost.Service1Soap ws = new localhost.Service1SoapClient();

 //           DataSet ds = new DataSet("Menu");

  //          TextBoxDoc.Text = e.Node.Text.PadLeft(100);      // добавляет слева пробел выравнивая общую длину до 1000

            if (NodLvl == 1)
            {
                //------------       чтение уровней дерево
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("HspSprGrfDocSel", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@GRFKOD", SqlDbType.Int,4).Value = NodVal;

                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "HspSprGrfDocSel");

                con.Close();

                GridGrf.DataSource = ds;
                GridGrf.DataBind();

 //               ds.Merge(ws.ComSprGrfDocTreNod(MdbNam, BuxSid, BuxFrm, NodVal));
 //               GridGrf.DataSource = ds;
 //               GridGrf.DataBind();

                Button01.Enabled  = true;
            }
            else Button01.Enabled = false;

    //        return "";
        }
   

        // ======================================================================================
        //------------------------------------------------------------------------
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int GrfIdn;
            int GrfDni;
            string GrfBeg;
            string GrfEnd;
            string GrfBegNon;
            string GrfEndNon; 
            int GrfCab;
            int GrfDlt;
            Boolean GrfFlg;
            Boolean GrfWww;

            GrfIdn = Convert.ToInt32(e.Record["GRFIDN"]);
            GrfDni = Convert.ToInt32(e.Record["NEDKOD"]);
            GrfBeg = Convert.ToString(e.Record["TIMBEG"]);
            GrfEnd = Convert.ToString(e.Record["TIMEND"]);
            GrfBegNon = Convert.ToString(e.Record["TIMBEGNON"]);
            GrfEndNon = Convert.ToString(e.Record["TIMENDNON"]);
            
            if (Convert.ToString(e.Record["GRFCAB"]) == null || Convert.ToString(e.Record["GRFCAB"]) == "") GrfCab = 0;
            else GrfCab = Convert.ToInt32(e.Record["GRFCAB"]);

            GrfDlt = Convert.ToInt32(e.Record["GRFDLT"]);
            GrfFlg = Convert.ToBoolean(e.Record["GRFFLG"]);
            GrfWww = Convert.ToBoolean(e.Record["GRFWWW"]);

            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprGrfDocRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GRFIDN", SqlDbType.Int, 4).Value = GrfIdn;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GRFDNI", SqlDbType.Int, 4).Value = GrfDni;
            cmd.Parameters.Add("@GRFBEG", SqlDbType.VarChar).Value = GrfBeg;
            cmd.Parameters.Add("@GRFEND", SqlDbType.VarChar).Value = GrfEnd;
            cmd.Parameters.Add("@GRFCAB", SqlDbType.Int, 4).Value = GrfCab;
            cmd.Parameters.Add("@GRFBEGNON", SqlDbType.VarChar).Value = GrfBegNon;
            cmd.Parameters.Add("@GRFENDNON", SqlDbType.VarChar).Value = GrfEndNon;
            cmd.Parameters.Add("@GRFDLT", SqlDbType.Int, 4).Value = GrfDlt;
            cmd.Parameters.Add("@GRFFLG", SqlDbType.Bit,1).Value = GrfFlg;
            cmd.Parameters.Add("@GRFWWW", SqlDbType.Bit, 1).Value = GrfWww;

            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

   //         localhost.Service1Soap ws = new localhost.Service1SoapClient();
   //         ws.ComSprGrfDocRep(MdbNam,BuxSid, BuxFrm, GrfIdn, GrfBeg, GrfEnd, GrfBegNon, GrfEndNon, GrfCab, GrfDlt, GrfFlg);
            getPostBackControlName();
        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            int GrfKod;
            int GrfDni;
            string GrfBeg;
            string GrfEnd;
            string GrfBegNon;
            string GrfEndNon;
            int GrfCab;
            int GrfDlt;
            Boolean GrfFlg;
            Boolean GrfWww;

//            GrfIdn = Convert.ToInt32(e.Record["GRFIDN"]);
//            GrfKod = Convert.ToInt32(e.Node.Value);
            GrfKod = Convert.ToInt32(Session["GrfKod"]);

            GrfDni = Convert.ToInt32(e.Record["NEDKOD"]);
            GrfBeg = Convert.ToString(e.Record["TIMBEG"]);
            GrfEnd = Convert.ToString(e.Record["TIMEND"]);
            GrfBegNon = Convert.ToString(e.Record["TIMBEGNON"]);
            GrfEndNon = Convert.ToString(e.Record["TIMENDNON"]);

            if (Convert.ToString(e.Record["GRFCAB"]) == null || Convert.ToString(e.Record["GRFCAB"]) == "") GrfCab = 0;
            else GrfCab = Convert.ToInt32(e.Record["GRFCAB"]);

            GrfDlt = Convert.ToInt32(e.Record["GRFDLT"]);
            GrfFlg = Convert.ToBoolean(e.Record["GRFFLG"]);
            GrfWww = Convert.ToBoolean(e.Record["GRFWWW"]);

            //------------       чтение уровней дерево
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspSprGrfDocAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
 //           cmd.Parameters.Add("@GRFIDN", SqlDbType.Int, 4).Value = GrfIdn;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GRFKOD", SqlDbType.Int, 4).Value = GrfKod;
            cmd.Parameters.Add("@GRFDNI", SqlDbType.Int, 4).Value = GrfDni;
            cmd.Parameters.Add("@GRFBEG", SqlDbType.VarChar).Value = GrfBeg;
            cmd.Parameters.Add("@GRFEND", SqlDbType.VarChar).Value = GrfEnd;
            cmd.Parameters.Add("@GRFBEGNON", SqlDbType.VarChar).Value = GrfBegNon;
            cmd.Parameters.Add("@GRFENDNON", SqlDbType.VarChar).Value = GrfEndNon;
            cmd.Parameters.Add("@GRFCAB", SqlDbType.Int, 4).Value = GrfCab;
            cmd.Parameters.Add("@GRFDLT", SqlDbType.Int, 4).Value = GrfDlt;
            cmd.Parameters.Add("@GRFFLG", SqlDbType.Bit, 1).Value = GrfFlg;
            cmd.Parameters.Add("@GRFWWW", SqlDbType.Bit, 1).Value = GrfWww;

            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getPostBackControlName();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int GrfIdn;

            GrfIdn = Convert.ToInt32(e.Record["GRFIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRDOCGRF WHERE GRFIDN=" + GrfIdn, con);
            cmd.ExecuteNonQuery();
            con.Close();

            getPostBackControlName();
    
        }       
        protected void CompOne_Click(object sender, EventArgs e)
        {
            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;

        }
     
        protected void OboutTree_TreeNodeExpanded(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            int NodVal;

            NodVal = Convert.ToInt32(e.Node.Value);
 //           NodLen = e.Node.Value.Length;
 //           NodLen004 = NodLen + 4;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComSprGrfDoc", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@DLGKOD", SqlDbType.Int, 4).Value = NodVal;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprGrfDoc");

            con.Close();
            //=====================================================================================
            foreach (DataRow row in ds.Tables["ComSprGrfDoc"].Rows)
            {
                Html = Convert.ToString(row["FIO"]);

                Node newNode = new Node();
                newNode.Text = Html;
                newNode.Value = Convert.ToString(row["BuxKod"]);
                newNode.ExpandMode = NodeExpandMode.ServerSideCallback;
                e.Node.ChildNodes.Add(newNode);
            }
        }

        protected void OboutTree_SelectedTreeNodeChanged(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            int NodLvl;
            int NodVal;

            NodVal = Convert.ToInt32(e.Node.Value);
            Session["GrfKod"] = NodVal;
            NodLvl = e.Node.Level;

            TextBoxDoc.Text = e.Node.Text.PadLeft(10);      // добавляет слева пробел выравнивая общую длину до 1000
            getPostBackControlName();

        }
        // ============================ одобрение для записи документа в базу ==============================================
        protected void btnOK_click(object sender, EventArgs e)
        {

            int NodLvl;
            int NodVal;

            NodVal = Convert.ToInt32(OboutTree.SelectedNode.Value);
            NodLvl = OboutTree.SelectedNode.Level;

            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;


  //          GlvBegDat = (DateTime)Session["GlvBegDat"];
  //          GlvEndDat = (DateTime)Session["GlvEndDat"];

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = DateTime.Parse(txtDate1.Text);
            GlvEndDat = DateTime.Parse(txtDate2.Text);

            if (NodLvl == 1)
            {
              localhost.Service1Soap ws = new localhost.Service1SoapClient();
              ws.ComSprGrfDocCmpAll(MdbNam, BuxSid, BuxFrm, NodVal, GlvBegDat, GlvEndDat);
            }

  //          getPostBackControlName();

        }

        //-------------------------- меню для страницы ----------------------------------------------

        // ============================= Old ======================================================================
        // ====================================при выборе студента ============================================

        // ============================= Old ======================================================================


    }
}



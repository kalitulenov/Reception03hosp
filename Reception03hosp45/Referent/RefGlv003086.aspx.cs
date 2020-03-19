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
    public partial class RefGlv003086 : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;

        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        string MedDocKod;
        string GrfKod;
        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            parBuxKod.Value = BuxKod;

            GridGrf.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

            GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);

            MedDocKod = (string)Request.QueryString["MedDocKod"];

            getGrid();
        }

        //------------------------------------------------------------------------
        void getGrid()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspRefGlvScr086", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = MedDocKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDat;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDat;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspRefGlvScr086");

            con.Close();

            GridGrf.DataSource = ds;
            GridGrf.DataBind();

        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            string AmbCrdIdn;
            AmbCrdIdn = Convert.ToString(e.Record["GRFIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstDelGrp", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GRFTYP", SqlDbType.VarChar).Value = Convert.ToString(e.Record["GRFTYP"]);
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

    }
}
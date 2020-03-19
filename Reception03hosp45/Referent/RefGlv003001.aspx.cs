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
    public partial class RefGlv003001 : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;

        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        string GrfDlg;
        string GrfKod;
        string MdbNam;

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            parBuxKod.Value = BuxKod;
            MdbNam = "HOSPBASE";

            GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

 //           GridGrf.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

            GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);

            GrfDlg = (string)Request.QueryString["GrfDlg"];
            GrfKod = (string)Request.QueryString["GrfKod"];
 /*
            GrfDlg = "0";
            GrfKod = "824";
            GlvBegDat = Convert.ToDateTime("01.01.2015");
            GlvEndDat = Convert.ToDateTime("31.01.2015");
            BuxFrm = "1";
*/
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
            SqlCommand cmd = new SqlCommand("HspRefGlvScr", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GRFDLG", SqlDbType.VarChar).Value = GrfDlg;
            cmd.Parameters.Add("@GRFKOD", SqlDbType.VarChar).Value = GrfKod;
            cmd.Parameters.Add("@GRFBEGRAS", SqlDbType.Date, 10).Value = GlvBegDat;
            cmd.Parameters.Add("@GRFENDRAS", SqlDbType.Date, 10).Value = GlvEndDat;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspRefGlvScr");

            con.Close();

            GridGrf.DataSource = ds;
            GridGrf.DataBind();

  //          ds.Merge(ws.RefGlvScr(MdbNam, BuxSid, BuxFrm, GrfDlg, GrfKod, GlvBegDat, GlvEndDat));
        }

    }
}
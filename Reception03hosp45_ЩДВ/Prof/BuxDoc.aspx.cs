using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Obout.Grid;
using System.Text;
using System.Web.Configuration;



namespace Reception03hosp45.Prof
{
    public partial class BuxDoc : System.Web.UI.Page
    {

//        Grid GridDoc = new Grid();

        string BuxSid;
        string BuxFrm;
        

        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;
        
        int GlvDocIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
                GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
                parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
                TxtDoc = (string)Request.QueryString["TxtSpr"];
                Sapka.Text = TxtDoc;
                Session.Add("GlvDocTyp", GlvDocTyp.ToString());
                //=====================================================================================
                BuxFrm = (string)Session["BuxFrmKod"];    
                BuxSid = (string)Session["BuxSid"];
                //============= начало  ===========================================================================================
                switch (GlvDocTyp)
                {
                    case "Прф":
                        GridDoc.Columns[3].HeaderText = "Организация";
                        break;
                    default:
                        // Do nothing.
                        break;
                }

            // ViewState
                // ViewState["text"] = "Artem Shkolovy";
                // string Value = (string)ViewState["name"];
                GridDoc.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            if (!Page.IsPostBack)
            {

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
              
                getGrid();

            }

        }

// ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];
           
   //         localhost.Service1Soap ws = new localhost.Service1SoapClient();
   //         DataSet ds = new DataSet("Spr000");
    //        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("SELECT TabDoc.*,SprBuxKdr.FI AS BUX, (CASE WHEN ISNULL(TabDoc.DOCFLGVIP, 0)= 0 THEN '' ELSE '+' END) AS FLG " +
                                            "FROM TabDoc LEFT OUTER JOIN SprBuxKdr ON dbo.TabDoc.DOCBUX = dbo.SprBuxKdr.BuxKod " +
                                            "WHERE TabDoc.DOCFRM =" +BuxFrm + " AND TabDoc.DOCTYP = 'ПРФ' " + //AND DOCDAT>='" +  GlvBegDat + "' AND DOCDAT<='" + GlvEndDat + 
                                            " ORDER BY TabDoc.DOCDAT", con);
            con.Open();
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "GetDocNum");

            con.Close();

    //        ds.Merge(ws.ComDocGet(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvBegDat, GlvEndDat));
            GridDoc.DataSource = ds;
            GridDoc.DataBind();
        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            getGrid();
        }

// ============================ кнопка новый документ  ==============================================
        
        protected void AddButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Prof/BuxDocPrf.aspx?GlvDocIdn=0&GlvDocPrv=");
           
        }

        protected void CanButton_Click(object sender, EventArgs e)
        {
 //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");

        }

 //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int GlvDocIdn;
            GlvDocIdn = Convert.ToInt32(e.Record["DOCIDN"]);
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComDocDel(MdbNam, BuxSid, GlvDocIdn);
            getGrid();

        }

        // ---------Суммация  ------------------------------------------------------------------------



    }
}

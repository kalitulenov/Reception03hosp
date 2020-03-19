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
using System.Web.Services;



namespace Reception03hosp45.Priem
{
    public partial class DocAppLstNazLek : System.Web.UI.Page
    {

//        Grid GridNaz = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        

        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;
        
        int AmbCrdIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
   //             GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
  //              parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
   //             TxtDoc = (string)Request.QueryString["TxtSpr"];
   //             Sapka.Text = TxtDoc;
   //             Session.Add("GlvDocTyp", GlvDocTyp.ToString());
                //=====================================================================================
                BuxFrm = (string)Session["BuxFrmKod"];
                HidBuxFrm.Value = BuxFrm;

                BuxKod = (string)Session["BuxKod"];
                HidBuxKod.Value = BuxKod;

                BuxSid = (string)Session["BuxSid"];
                //============= начало  ===========================================================================================
            
                if (GridNaz.IsCallback)
                {
                    Session["pgSize"] = GridNaz.CurrentPageIndex;
                }


            // ViewState
                // ViewState["text"] = "Artem Shkolovy";
                // string Value = (string)ViewState["name"];
  //              GridNaz.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //               GridNaz.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

                if (!Page.IsPostBack)
                {
                    if (Session["pgSize"] != null)
                    {
                        GridNaz.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
                    }

                    string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                    rptAlphabet.DataSource = alphabet;
                    rptAlphabet.DataBind();

                    getGrid();

                    GlvBegDat = (DateTime)Session["GlvBegDat"];
                    GlvEndDat = (DateTime)Session["GlvEndDat"];

                    txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                    txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
                }

        }

// ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string LenCol;
            DateTime TekBegDat;

            string GlvBegDatTxt;
            string GlvEndDatTxt;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbNazDatKol", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXBEG", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@BUXEND", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbNazDatKol");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                GridNaz.Columns[02].HeaderText = Convert.ToDateTime(GlvBegDat).ToString("dd.MM");
                GridNaz.Columns[03].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(1)).ToString("dd.MM");
                GridNaz.Columns[04].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(2)).ToString("dd.MM");
                GridNaz.Columns[05].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(3)).ToString("dd.MM");
                GridNaz.Columns[06].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(4)).ToString("dd.MM");
                GridNaz.Columns[07].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(5)).ToString("dd.MM");
                GridNaz.Columns[08].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(6)).ToString("dd.MM");
                GridNaz.Columns[09].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(7)).ToString("dd.MM");
                GridNaz.Columns[10].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(8)).ToString("dd.MM");
                GridNaz.Columns[11].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(9)).ToString("dd.MM");
                GridNaz.Columns[12].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(10)).ToString("dd.MM");
                GridNaz.Columns[13].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(11)).ToString("dd.MM");
                GridNaz.Columns[14].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(12)).ToString("dd.MM");
                GridNaz.Columns[15].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(13)).ToString("dd.MM");
                GridNaz.Columns[16].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(14)).ToString("dd.MM");
            }

            GridNaz.DataSource = ds;
            GridNaz.DataBind();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            getGrid();
        }

// ============================ кнопка новый документ  ==============================================
        
        protected void CanButton_Click(object sender, EventArgs e)
        {
 //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

 //============= удаление записи после опроса  ===========================================================================================

    }
}

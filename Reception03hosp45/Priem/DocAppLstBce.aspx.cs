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
    public partial class DocAppLstBce : System.Web.UI.Page
    {

//        Grid GridCrd = new Grid();

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
                GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
                parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
                TxtDoc = (string)Request.QueryString["TxtSpr"];
                Sapka.Text = TxtDoc;
                Session.Add("GlvDocTyp", GlvDocTyp.ToString());
                //=====================================================================================
                BuxFrm = (string)Session["BuxFrmKod"];
                HidBuxFrm.Value = BuxFrm;

                BuxKod = (string)Session["BuxKod"];
                HidBuxKod.Value = BuxKod;

                BuxSid = (string)Session["BuxSid"];
                //============= начало  ===========================================================================================
            
                if (GridCrd.IsCallback)
                {
                    Session["pgSize"] = GridCrd.CurrentPageIndex;
                }


            // ViewState
                // ViewState["text"] = "Artem Shkolovy";
                // string Value = (string)ViewState["name"];
//                GridCrd.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //               GridCrd.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

                if (!Page.IsPostBack)
                {
                    if (Session["pgSize"] != null)
                    {
                        GridCrd.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
                    }

                    string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                    rptAlphabet.DataSource = alphabet;
                    rptAlphabet.DataBind();

                    getGrid();

                    GlvBegDat = (DateTime)Session["GlvBegDat"];
                    GlvEndDat = (DateTime)Session["GlvEndDat"];

                    txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                    txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                   sdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
                   sdsDoc.SelectCommand = "SELECT BUXKOD AS DOCKOD,FI+' '+DLGNAM AS DOCNAM FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI";
                   BoxDoc.Items.Add(new Obout.ComboBox.ComboBoxItem("Все врачи", "0"));
              //     BoxDoctor.Items.Add(new ComboBoxItem("Все", "0"));

            }

        }

// ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";
            else TekDocTyp = GlvDocTyp;
           

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocAppLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BoxDoc.SelectedValue;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "ALL";
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            cmd.CommandTimeout = 120;    // задержка
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocAppLst");

            con.Close();
            /*
            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    GridCrd.DataSource = ds;
                    GridCrd.DataBind();
                }
            }
            catch
            {
            }
            */
            GridCrd.DataSource = ds;
            GridCrd.DataBind();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";
            else TekDocTyp = GlvDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            /*
            // ============================ посуммировать  ==============================================
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstSum", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BoxDoc.SelectedIndex;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = TekDocTyp;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();
            // ============================ посуммировать  ==============================================
            */

            getGrid();
        }

// ============================ кнопка новый документ  ==============================================
        
        protected void CanButton_Click(object sender, EventArgs e)
        {
  //          Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

 //============= удаление записи после опроса  ===========================================================================================
        // ---------Суммация  ------------------------------------------------------------------------
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[13].Text == null | e.Row.Cells[13].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[13].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[11].Text = "Итого:";
                e.Row.Cells[13].Text = ItgDocSum.ToString();
            }
        }

    }
}

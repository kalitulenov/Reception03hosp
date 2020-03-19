using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using Obout.ComboBox;
using System.Web.Configuration;
using OboutInc.Window;
using System.Text;


namespace Reception03hosp45.BuxDoc
{
    public partial class BuxKasPrxSel_OLD : System.Web.UI.Page
    {
        string GlvDocIdn;
        string GlvDocPrv;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        string GlvDocTyp;
        string MdbNam = "HOSPBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;
        string CountTxt;
        int CountInt;
        decimal ItgDocSum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
           //============= Установки ===========================================================================================
           BuxSid = (string)Session["BuxSid"];
           BuxKod = (string)Session["BuxKod"];
           BuxFrm = (string)Session["BuxFrmKod"];    
           //=====================================================================================
           GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
           GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);


           GlvDocTyp = "PAY";
           if (!Page.IsPostBack)
           {

               //============= начало  ===========================================================================================
               GlvBegDat = (DateTime)Session["GlvBegDat"];
               GlvEndDat = (DateTime)Session["GlvEndDat"];

               txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
               txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
               Session["KASSPL"] = "SEL";

           }            
            CreateGrid();
            
        }


             void CreateGrid()
                    {
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
                        SqlCommand cmd = new SqlCommand("HspKasPrxSel", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
                        cmd.Parameters.Add("@KASBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
                        cmd.Parameters.Add("@KASENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

                        // создание DataAdapter
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "HspKasPrxSel");

                        con.Close();

                        GridUsl.DataSource = ds;
                        GridUsl.DataBind();
                    }
           
             //============= ввод записи после опроса  ===========================================================================================

             protected void PushButton_Click(object sender, EventArgs e)
             {
                 Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
                 Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

                 GlvBegDat = (DateTime)Session["GlvBegDat"];
                 GlvEndDat = (DateTime)Session["GlvEndDat"];

                 localhost.Service1Soap ws = new localhost.Service1SoapClient();
                 ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

                 CreateGrid();
             }


       }
    }   




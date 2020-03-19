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



namespace Reception03hosp45.BuxDoc
{
    public partial class BuxDoc : System.Web.UI.Page
    {

//        Grid GridMat = new Grid();

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
                    case "Прх":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Прс":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Воз":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Спс":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Прм":
                        GridDoc.Columns[3].HeaderText = "МОЛ";
                        break;
                    case "Рсх":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Бсп":
                        GridDoc.Columns[3].HeaderText = "ФАМИЛИЯ И.О.";
                        break;
                    case "Пер":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Дов":
                        GridDoc.Columns[3].HeaderText = "ФАМИЛИЯ И.О.";
                        break;
                    case "Акт":
                        GridDoc.Columns[3].HeaderText = "ОРГАНИЗАЦИЯ";
                        break;
                    case "Авн":
                        GridDoc.Columns[3].HeaderText = "ФАМИЛИЯ И.О.";
                        break;
                    case "Бнк":
                        GridDoc.Columns[3].HeaderText = "СЧЕТ";
                        break;
                    case "Счт":
                        GridDoc.Columns[3].HeaderText = "СЧЕТ";
                        break;
                    case "Амр":
                        GridDoc.Columns[3].HeaderText = "СЧЕТ";
                        break;
                default:
                        // Do nothing.
                        break;
                }

            // ViewState
                // ViewState["text"] = "Artem Shkolovy";
                // string Value = (string)ViewState["name"];
                GridDoc.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
                GridDoc.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);
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
           
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("Spr000");

            ds.Merge(ws.ComDocGet(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvBegDat, GlvEndDat));
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
//            localhost.Service1SoapClient ws = new localhost.Service1SoapClient();
//            ws.ComDocAdd(BuxBas, BuxSid, GlvDocTyp);

 //           GlvDocIdn= Convert.ToInt32(ds.Tables[0].Rows[0]["GLVDOCIDN"]);
//  передача через SESSION не работает
//            Session.Add("CounterTxt", (string)"0");
//  передача через ViewState не работает
//            ViewState["CounterTxt"] = "0";
            switch (GlvDocTyp)
            {
                case "Прх":
                    Response.Redirect("~/BuxDoc/BuxDocPrx.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Прс":
                    Response.Redirect("~/BuxDoc/BuxDocPrxSrd.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Спс":
                    Response.Redirect("~/BuxDoc/BuxDocSps.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Прм":
                    Response.Redirect("~/BuxDoc/BuxDocPrmSpl.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Рсх":
                    Response.Redirect("~/BuxDoc/BuxDocRsx.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Бсп":
                    Response.Redirect("~/BuxDoc/BuxDocBsp.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Пер":
                    Response.Redirect("~/BuxDoc/BuxDocPer.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Воз":
                    Response.Redirect("~/BuxDoc/BuxDocVoz.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Дов":
                    Response.Redirect("~/BuxDoc/BuxDocDov.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Акт":
                    Response.Redirect("~/BuxDoc/BuxDocAkt.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Авн":
                    Response.Redirect("~/BuxDoc/BuxDocAbn.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Бнк":
                    Response.Redirect("~/BuxDoc/BuxDocBnk.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Счт":
                    Response.Redirect("~/BuxDoc/BuxDocCht.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                case "Амр":
                    Response.Redirect("~/BuxDoc/BuxDocAmr.aspx?GlvDocIdn=0&GlvDocPrv=");
                    break;
                default:
                    break;
            }
           
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
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {

                if (e.Row.Cells[5].Text == null | e.Row.Cells[5].Text == "") ItgDocKol += 0;
                else ItgDocKol += decimal.Parse(e.Row.Cells[5].Text);

                if (e.Row.Cells[6].Text == null | e.Row.Cells[6].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[6].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[4].Text = "Итого:";
                e.Row.Cells[5].Text = ItgDocKol.ToString();
          
                e.Row.Cells[6].Text = ItgDocSum.ToString();

            }
        }


        // ======================================================================================



    }
}

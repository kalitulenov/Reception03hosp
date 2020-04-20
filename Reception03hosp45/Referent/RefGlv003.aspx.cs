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
using System.Net;
using Newtonsoft.Json;
using System.Globalization;

namespace Reception03hosp45.Referent
{
    public class RespData
    {
        public string requestId { get; set; }
        public string responseId { get; set; }
        public string requestDate { get; set; }
        public string responseStatus { get; set; }
        public string errorData { get; set; }
        public string iin { get; set; }
        public RequestData insuredData { get; set; }
    }

    public class RequestData
    {
        public string insuredStatus { get; set; }

        public string statusDescriptionKZ { get; set; }

        public string statusDescriptionRu { get; set; }
    }

    public partial class RefGlv003 : System.Web.UI.Page
    {
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            HidBuxFrm.Value = BuxFrm;
            HidBuxKod.Value = BuxKod;

            GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

            GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);

            /*            TextBoxPer.Text = "График приема врачей за период с ".PadLeft(70) +
                                    Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy") +
                                    " по " + Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
            */
            TextBoxBegDat.Text = Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy");
            TextBoxEndDat.Text = Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
            //=====================================================================================
            SdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SdsDoc.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM " +
                                   "FROM SprBux INNER JOIN SprDlg ON SprBux.BuxDlg=SprDlg.DLGKOD " +
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (ISNULL(SprDlg.DLGZAP,0)=1) AND (SprBux.BuxFrm=" + BuxFrm +
                                   ") GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg " +
                                   "ORDER BY SprDlg.DLGNAM";

            SdsFio.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";

            SdsKlt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

            SdsMedDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SdsMedDoc.SelectCommand = "SELECT * FROM SprMedFrm WHERE SprMedFrmKey='230' ORDER BY SprMedFrmNam";
            //=====================================================================================
            //================================== GodNam ===============================================================
            //=====================================================================================
            if (!Page.IsPostBack)
            {


            }
            else
            {

            }
        }


        // ======================================================================================
        protected void GetSqt_Click(object sender, EventArgs e)
        {
            string TokenIns = "";
            string HtmlResultIns;


            // ******************************************************* ПОЛУЧИТЬ ТОКЕН ***************************************************************************
            DataSet dsTkn = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            SqlConnection conTkn = new SqlConnection(connectionString);
            conTkn.Open();

            SqlCommand cmdTkn = new SqlCommand("SELECT TOP 1 * FROM TABTKN WHERE TKNFRM=" + BuxFrm, conTkn);
            SqlDataAdapter daTkn = new SqlDataAdapter(cmdTkn);
            // заполняем DataSet из хран.процедуры.
            daTkn.Fill(dsTkn, "HspTkn");
            if (dsTkn.Tables[0].Rows.Count > 0)
            {
                //  Token = Convert.ToString(dsIin.Tables[0].Rows[0]["TKNRPN"]);
                TokenIns = Convert.ToString(dsTkn.Tables[0].Rows[0]["TKNINS"]);
            }

            conTkn.Close();

            // ******************************************************* ИЗ БАЗЫ ПОЛУЧИТЬ ДАННЫЕ ПО ИИН ***************************************************************************

            //------------       чтение уровней дерево
            DataSet dsIin = new DataSet();
            // string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection conIin = new SqlConnection(connectionString);
            conIin.Open();
            SqlCommand cmdIin = new SqlCommand("SELECT TOP 1 *,(SELECT TOP 1 CntKltPrkMo FROM SprCntKlt WHERE CntKltFrm=" + BuxFrm + " AND CntKltIin=SPRKLT.KLTIIN) AS PRKNAM FROM SPRKLT WHERE KLTIIN = " + TextBoxFio.Text, conIin);
            SqlDataAdapter daIin = new SqlDataAdapter(cmdIin);
            // заполняем DataSet из хран.процедуры.
            daIin.Fill(dsIin, "KltIin");
            if (dsIin.Tables[0].Rows.Count > 0)
            {
                TextBoxPrk.Text = Convert.ToString(dsIin.Tables[0].Rows[0]["PRKNAM"]);
                TextBoxFio.Text = Convert.ToString(dsIin.Tables[0].Rows[0]["KLTFIO"]);
                TextBoxIIN.Text = Convert.ToString(dsIin.Tables[0].Rows[0]["KLTIIN"]);
                TextBoxTel.Text = Convert.ToString(dsIin.Tables[0].Rows[0]["KLTTEL"]);

                //if (Convert.ToString(dsIin.Tables[0].Rows[0]["STSNAM"]) == null ||
                //    Convert.ToString(dsIin.Tables[0].Rows[0]["STSNAM"]) == "" ||
                //    Convert.ToString(dsIin.Tables[0].Rows[0]["STSNAM"]) == "0" ||
                //    Convert.ToString(dsIin.Tables[0].Rows[0]["STSNAM"]) == "2") StsFlg.Checked = false;
                //else StsFlg.Checked = true;

                if (Convert.ToString(dsIin.Tables[0].Rows[0]["KLTSOZLGT"]) == null ||
                    Convert.ToString(dsIin.Tables[0].Rows[0]["KLTSOZLGT"]) == "" ||
                    Convert.ToString(dsIin.Tables[0].Rows[0]["KLTSOZLGT"]) == "0") SozFlg.Checked = false;
                else SozFlg.Checked = true;

                if (String.IsNullOrEmpty(dsIin.Tables[0].Rows[0]["KLTDSP"].ToString())) DspFlg.Checked = false;
                else DspFlg.Checked = Convert.ToBoolean(dsIin.Tables[0].Rows[0]["KLTDSP"]);

            }

            //        /*  ОБРАЩЕНИЕ К САКТАНДЫРУ ДЛЯ ОПРЕДЕЛЕНИЯ СТАТУСА ИИН */
            // Отключить проверку сертификата
            System.Net.ServicePointManager.ServerCertificateValidationCallback += (se, cert, chain, sslerror) => { return true; };

            //string apiUrlIns = "http://87.255.215.3:4000///statusservice//getInsuranceStatus?iin=" + KltOneIin + "&requestId=1&requestDate=" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.CreateSpecificCulture("en-US"));
            string apiUrlIns = "https://gateway.iss.fms.kz//statusservice//getInsuranceStatus?iin=" + TextBoxIIN.Text + "&requestId=1&requestDate=" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.CreateSpecificCulture("en-US"));
            using (WebClient clientIns = new WebClient())
            {
                try
                {
                    clientIns.Headers.Add("Content-Type", "text");
                    clientIns.Headers[HttpRequestHeader.Authorization] = "Bearer " + TokenIns;
                    clientIns.Encoding = Encoding.UTF8;
                    HtmlResultIns = clientIns.DownloadString(apiUrlIns);
                    // HtmlResult = client.UploadString(apiUrl,"");


                    if (HtmlResultIns != "[]")
                    {
                        // List<RespData> respData = new List<RespData>();
                        RespData respData = new RespData();

                        respData = JsonConvert.DeserializeObject<RespData>(HtmlResultIns);

                        if (respData.insuredData.insuredStatus == "100")
                        {
                            //Status.Value = "1";
                            StsFlg.Checked = true;
                            // StsTxt.Text = "ЗАСТРАХОВАН";
                        }
                        else
                        {
                            //Status.Value = "2";
                            StsFlg.Checked = false;
                            // StsTxt.Text = "НЕ ЗАСТРАХОВАН";
                        }


                    }
                }
                catch
                {
                    TextBoxFio.Text = "ТОКЕН ИСТЕК";
                }



            }
        }


        // ============================================================================================
    }
}

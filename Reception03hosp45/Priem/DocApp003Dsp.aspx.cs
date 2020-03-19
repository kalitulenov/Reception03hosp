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
    public partial class DocApp003Dsp : System.Web.UI.Page
    {
        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;

        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        string AmbCrdIdn;
        string AmbCrdIdnSes;
        string AmbCntIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
            GlvDocTyp = Convert.ToString(Request.QueryString["GlvDocTyp"]);
            AmbCrdIdnSes = (string)Session["AmbCrdIdn"];

            if (AmbCrdIdn == "0")
               if (AmbCrdIdnSes != "0") AmbCrdIdn = AmbCrdIdnSes;

            //       parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
   //         TxtDoc = (string)Request.QueryString["TxtSpr"];
   //         Sapka.Text = TxtDoc;
   //         Session.Add("AmbCrdIdn", AmbCrdIdn);
            Session.Add("AmbCntIdn", AmbCntIdn);
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //=====================================================================================
            sdsCmp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            if (GlvDocTyp == "СМП") sdsCmp.SelectCommand = "SELECT BuxKod,Fio FROM SprBuxKdr WHERE DLGTYP='СМП' AND BuxFrm=" + BuxFrm + " ORDER BY Fio";
            else sdsCmp.SelectCommand = "SELECT BuxKod,Fio FROM SprBuxKdr WHERE DLGTYP='АМБ' AND BuxFrm=" + BuxFrm + " ORDER BY Fio";
            sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            sdsTyp.SelectCommand = "SELECT * FROM Spr003Typ ORDER BY SmpTypNam";
            sdsRes.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            sdsRes.SelectCommand = "SELECT * FROM Spr003Res ORDER BY SmpResNam";
            sdsCrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            sdsCrm.SelectCommand = "SELECT * FROM Spr003Crm ORDER BY SmpCrmNam";
            sdsViz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            sdsViz.SelectCommand = "SELECT * FROM Spr003Viz ORDER BY SmpVizNam";

            //============= начало  ===========================================================================================
            if (!Page.IsPostBack)
            {
                TextBoxDat.Attributes.Add("onchange", "onChangeTxt('ctl00$MainContent$TextBoxDat',ctl00$MainContent$TextBoxDat.value);");
                TextBoxTim.Attributes.Add("onchange", "onChangeTxt('ctl00$MainContent$TextBoxTim',ctl00$MainContent$TextBoxTim.value);");

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];
                //============= Установки ===========================================================================================
                if (AmbCrdIdn == "0")  // новый документ
                {
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = GlvDocTyp;
                    cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = AmbCntIdn;
                    cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
                        AmbCntIdn = Convert.ToString(cmd.Parameters["@CNTIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
                Session["AmbCntIdn"] = Convert.ToString(AmbCntIdn);
                HidAmbCrdIdn.Value = AmbCrdIdn;

                getDocNumSap();
                getDocNum();
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
        }

        // ============================ кнопка новый документ  ==============================================
/*
        protected void PrtButton_Click(object sender, EventArgs e)
        {
            string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
            int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
            // --------------  печать ----------------------------
            Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbKrt003&TekDocIdn=" + AmbCrdIdn);
        }


        protected void CanButton_Click(object sender, EventArgs e)
        {
                       Response.Redirect("~/GoBack/GoBack1.aspx");
          //  Response.Redirect("~/GlavMenu.aspx");

        }
*/    
        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNumSap()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbCrdIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbCrdIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
                TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["HURMIN"]).ToString("hh:mm");
                TextBoxKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
                TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
                TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["RABNAM"]);
                TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
                TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
        //        TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
                Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]);
            }
        }


        // ============================ чтение заголовка таблицы а оп ==============================================
        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNum()
        {

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("Hsp003CrdIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "Hsp003CrdIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {

                //     obout:OboutTextBox ------------------------------------------------------------------------------------      
                //                TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
                //                TxtTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFBEG"]).Substring(0,5); //ToString("hh:mm");
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFKOD"].ToString())) BoxDocSmp.SelectedValue = "0";
                else BoxDocSmp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["GRFKOD"]);

                TxtFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);

                TxtIin.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFBRT"].ToString())) TxtBrt.Text = "";
                else TxtBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFBRT"]).ToString("dd.MM.yyyy");

                //               TxtFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFCMP"]);
                //               TxtCrd.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
                TxtObl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADROBL"]);
                TxtCty.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRCTY"]);
                TxtStr.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRSTR"]);
                TxtDom.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRDOM"]);
                TxtApr.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRAPR"]);
                TxtUgl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRUGL"]);
                TxtZsd.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRZSD"]);
                TxtPod.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRPOD"]);
                TxtEtg.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRETG"]);
                TxtDmf.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRDMF"]);
                TxtTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTEL"]);
                TxtJlb.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFMEM"]);
                TxtAlr.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPALR"]);

                //    ------------------------------------------------------------------------------------------------------------ 
            }

            //          string name = value ?? string.Empty;
        }

        //------------------------------------------------------------------------
        protected void ButBeg_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMBEG=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        //------------------------------------------------------------------------
        protected void ButPrb_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMPRB=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        //------------------------------------------------------------------------
        protected void ButEvk_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMEVK=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        //------------------------------------------------------------------------
        protected void ButLpu_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMLPU=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }


        //------------------------------------------------------------------------
        protected void ButFre_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMFRE=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        //------------------------------------------------------------------------
        protected void ButEnd_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMEND=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

    }
}

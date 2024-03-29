﻿using System;
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


namespace Reception03hosp45.AIS
{
    public partial class DocAisScrLstDocOne : System.Web.UI.Page
    {
        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;

        //int NumDoc;
        //string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        string KltIIN;
        //string KltIINSes;
        //string AmbCntIdn;
        //string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        //decimal ItgDocSum = 0;
        //decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            KltIIN = Convert.ToString(Request.QueryString["KltIIN"]);
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================
            if (!Page.IsPostBack)
            {
                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];
                //============= Установки ===========================================================================================
                HidKltIIN.Value = KltIIN;
                HidBuxFrm.Value = BuxFrm;

                getDocNum();
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getDocNum()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAisScrLstDocIin", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KLTIIN", SqlDbType.VarChar).Value = KltIIN;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAisScrLstDocIin");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["SCRRESBEG"]).ToString("dd.MM.yyyy");
        //        if (Convert.ToString(ds.Tables[0].Rows[0]["GRFBEG"]) == null || Convert.ToString(ds.Tables[0].Rows[0]["GRFBEG"]) == "")
        //            TextBoxTim.Text = "";
        //        else
       //         {
        //          TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFBEG"].ToString().Substring(0, 5)).ToString("hh:mm");
        //        }

                if (Convert.ToString(ds.Tables[0].Rows[0]["KLTBRT"]) == null || Convert.ToString(ds.Tables[0].Rows[0]["KLTBRT"]) == "") TextBoxBrt.Text = "";
                else TextBoxBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KLTBRT"]).ToString("dd.MM.yyyy");
                TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);
           //     TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
          //      TextBoxNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFNUM"]);
                TextBoxNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTINV"]);
                TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
                TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);
                TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
             //   Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FI"]) + "(" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) +")";
             //   Sapka.Value = Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]);
            }
        }

        // ============================ дублировать амб.карту ==============================================
        protected void ExpButtonOK_Click(object sender, EventArgs e)
        {
            KltIIN = Convert.ToString(Request.QueryString["KltIIN"]);


            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspAis025ExpAmb", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@KLTIIN", SqlDbType.VarChar).Value = KltIIN;
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                }
                finally
                {
                    con.Close();
                }
        }


    }
}

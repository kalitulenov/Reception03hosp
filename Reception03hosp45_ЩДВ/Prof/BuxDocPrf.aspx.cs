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


namespace Reception03hosp45.Prof
{
    public partial class BuxDocPrf : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;

        int DtlIdn;
        string DtlNam;
        string DtlNomNum;
        bool DtlFlg;

        string GlvDocTyp;
        DateTime GlvDocDat;
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


            GlvDocTyp = "Прф";
            //=====================================================================================
            GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            Grid1.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            Grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            Grid1.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //          Grid1.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);


            sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsOrg.SelectCommand = "SELECT CntKod AS ORGKOD,CntNam AS ORGNAM FROM SprCnt " +
                                   "WHERE (CntLvl=1) AND (LEFT(CntKey, 5)=(SELECT CntKey FROM SprCnt AS SprCnt_1 WHERE (CntLvl=0) AND (CntNam=N'ПРОФОСМОТРЫ')))";
            //============= Соединение ===========================================================================================
            sdsDtl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //============= Источник для ГРИДа  ===========================================================================================

            if (!Page.IsPostBack)
            {

                //============= Установки ===========================================================================================
                if (GlvDocIdn == 0)  // новый документ
                {
                    Session.Add("CounterTxt", "0");

                    DataSet ds = new DataSet();
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspPrfDocAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Прф";
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@GLVDOCIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        GlvDocIdn = Convert.ToInt32(cmd.Parameters["@GLVDOCIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                    Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                    Session.Add("GLVREJ", "ADD");

                }
                else
                {
                    Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                    Session.Add("GLVREJ", "ARP");

                }

                getDocNum();

                CreateGrid();
                //        ddlEdnNam.SelectedValue = "шт";
            }
        }


        void CreateGrid()
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOCDTL WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);

            con.Open();
            SqlDataReader myReader = cmd.ExecuteReader();

            Grid1.DataSource = myReader;
            Grid1.DataBind();

            con.Close();
        }

        //============= ввод записи после опроса  ===========================================================================================
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "") DtlNam = "";
            else DtlNam = Convert.ToString(e.Record["DTLNAM"]);

            if (Convert.ToString(e.Record["DTLNOMNUM"]) == null || Convert.ToString(e.Record["DTLNOMNUM"]) == "") DtlNomNum = "";
            else DtlNomNum = Convert.ToString(e.Record["DTLNOMNUM"]);

            DtlFlg = Convert.ToBoolean(e.Record["DTLFLG"]);


            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspPrfDocDtlAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLNOMNUM", SqlDbType.Decimal).Value = DtlNomNum;
            cmd.Parameters.Add("@DTLFLG", SqlDbType.Bit).Value = DtlFlg;

            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            con.Open();
            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
            }
            finally
            {
                con.Close();
            }

            CreateGrid();
        }


        //============= изменение записи после опроса  ===========================================================================================
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
            DtlNam = Convert.ToString(e.Record["DTLNAM"]);
            if (Convert.ToString(e.Record["DTLNOMNUM"]) == null || Convert.ToString(e.Record["DTLNOMNUM"]) == "") DtlNomNum = "";
            else DtlNomNum = Convert.ToString(e.Record["DTLNOMNUM"]);
            DtlFlg = Convert.ToBoolean(e.Record["DTLFLG"]);

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspPrfDocDtlRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLNOMNUM", SqlDbType.Decimal).Value = DtlNomNum;
            cmd.Parameters.Add("@DTLFLG", SqlDbType.Bit).Value = DtlFlg;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            con.Open();
            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
            }
            finally
            {
                con.Close();
            }

            CreateGrid();
        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
            DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspPrfDocDtlDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            con.Open();
            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
            }
            finally
            {
                con.Close();
            }

            CreateGrid();
        }
        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNum()
        {

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOC WHERE DOCIDN=" + GlvDocIdn, con);

            con.Open();
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "GetDocNum");

            con.Close();
            
            DOCDAT.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
            DOCNUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);

            if (GlvDocIdn > 0) BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
        }
        // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void AddButton_Click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (DOCNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (DOCDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxOrg.SelectedText.Length == 0)
            {
                Err.Text = "Не указан организация";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("UPDATE TABDOC SET DOCNUM=" + DOCNUM.Text + ",DOCDEBSPRVAL=" + BoxOrg.SelectedValue + ",DOCDAT= '" + DOCDAT.Text + "' WHERE DocIdn=" + GlvDocIdn, con);
            //          cmd = new SqlCommand("HspPrfDocDtlGnr", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            // выполнить
            cmd.ExecuteNonQuery();

            con.Close();

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;

            Response.Redirect("~/Prof/BuxDoc.aspx?NumSpr=ПРФ&TxtSpr=ПРОФОСМОТР");
        }

        // ============================ одобрение для записи документа в базу ==============================================
        protected void btnOK_click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.AptPrxDocAddRep(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, BoxOrg.SelectedValue, BuxKod);
            Response.Redirect("~/Prof/BuxDoc.aspx?NumSpr=ПРФ&TxtSpr=ПРОФОСМОТР");
        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Prof/BuxDoc.aspx?NumSpr=ПРФ&TxtSpr=ПРОФОСМОТР");
        }
        // ============================ проводить записи документа в базу ==============================================
        protected void GnrButton_Click(object sender, EventArgs e)
        {

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (DOCNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (DOCDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxOrg.SelectedText.Length == 0)
            {
                Err.Text = "Не указан организация";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            // ------------ удалить загрузку оператора ---------------------------------------
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO TABDOCDTL (DTLDOCNUM,DTLDOCIDN,DTLNOMNUM,DTLNAM) " +
                                            "SELECT 'ПРФ' AS PRF," + GlvDocIdn + " AS IDN,SprCntKlt.CNTKLTIIN, SprCntKlt.CNTKLTFIO " +
                                            "FROM  SprCnt INNER JOIN TabDoc ON SprCnt.CntKod = TabDoc.DOCDEBSPRVAL " +
                                                         "INNER JOIN SprCntKlt ON SprCnt.CntKey = SprCntKlt.CNTKLTKEY " +
                                            "WHERE LEN(SprCnt.CntKey) = 11 AND SprCnt.CntLvl=1 AND SprCntKlt.CNTKLTFRM=1 AND TabDoc.DocIdn=" + GlvDocIdn, con);
  //          cmd = new SqlCommand("HspPrfDocDtlGnr", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            // выполнить
            cmd.ExecuteNonQuery();

            con.Close();

            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;

            CreateGrid();
        }

        // ============================ проводить записи документа в базу ==============================================
        protected void PrvButton_Click(object sender, EventArgs e)
        {

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (DOCNUM.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (DOCDAT.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxOrg.SelectedText.Length == 0)
            {
                Err.Text = "Не указан организация";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("UPDATE TABDOCDTL SET TABDOCDTL.DTLNAM=SprCntKlt.CNTKLTFIO " +
                                            "FROM  SprCnt,SprCntKlt,TABDOC,TABDOCDTL " +
                                            "WHERE SprCnt.CntKod = TabDoc.DOCDEBSPRVAL AND SprCnt.CntKey = SprCntKlt.CNTKLTKEY AND TABDOCDTL.DTLNOMNUM=SprCntKlt.CNTKLTIIN " +
                                                  "AND LEN(SprCnt.CntKey) = 11 AND SprCnt.CntLvl=1 AND SprCntKlt.CNTKLTFRM=1 AND TabDoc.DocIdn=" + GlvDocIdn, con);
            //          cmd = new SqlCommand("HspPrfDocDtlGnr", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            // выполнить
            cmd.ExecuteNonQuery();

            con.Close();

            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;

            CreateGrid();
        }



        // ============================ конец текста ==============================================
    }
}




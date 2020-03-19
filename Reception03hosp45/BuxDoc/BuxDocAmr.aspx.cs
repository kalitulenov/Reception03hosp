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
    public partial class BuxDocAmr : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;

        //int DtlIdn;

        //string DtlDeb;
        //int DtlDebSpr;
        //int DtlDebSprVal;
        //string DtlKrd;
        //int DtlKrdSpr;
        //int DtlKrdSprVal;

        //int DtlKod;
        //Boolean DtlNdc;
        //int DtlGrp;
        //int DtlUpk;

        //decimal DtlKol;
        //decimal DtlPrz;
        //string DtlEdn;
        //string DtlNam;
        //decimal DtlZen;
        //decimal DtlSum;
        //string DtlIzg;
        //string DtlSrkSlb;


        string GlvDocTyp;
        //DateTime GlvDocDat;
        string MdbNam = "HOSPBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;
        //string CountTxt;
        //int CountInt;
        //decimal ItgDocSum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            //============= Установки ===========================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            BuxFrm = (string)Session["BuxFrmKod"];


            GlvDocTyp = "Амр";
            //=====================================================================================
            GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            if (GlvDocPrv != null && GlvDocPrv != "")
            {
                //               AddButton.Visible = false;
                //               PrvButton.Visible = false;
                //               GridAmr.Columns[8].Visible = false;
            }
            //           if (GlvDocIdn == 0) PrvButton.Visible = false;


            sdsRsx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsRsx.SelectCommand = "SELECT RSXKOD,RSXNAM FROM SPRRSXBUX ORDER BY RSXNAM";

         //   GridAmr.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;

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
                    SqlCommand cmd = new SqlCommand("BuxPrxDocAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Амр";
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
                        parDocIdn.Value = Convert.ToString(GlvDocIdn);

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

                parDocIdn.Value = Convert.ToString(GlvDocIdn);
                getDocNum();

                //        ddlEdnNam.SelectedValue = "шт";
            }
                CreateGrid();


        }



        void CreateGrid()
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды


            SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SprDep.SttStrNam " +
                                            "FROM TabDocDtl INNER JOIN TabDoc ON TabDocDtl.DTLDOCIDN=TabDoc.DOCIDN " +
                                                           "LEFT OUTER JOIN SprDep ON TabDoc.DOCFRM=SprDep.SttStrFrm AND " +
                                                                                     "TabDocDtl.DTLGRP=SprDep.SttStrKod " +
                                            "WHERE TabDocDtl.DTLDOCIDN=" + GlvDocIdn + " AND TabDoc.DOCFRM=" + BuxFrm +
                                            " ORDER BY dbo.TabDocDtl.DTLIDN", con);
            
            
            con.Open();
            SqlDataReader myReader = cmd.ExecuteReader();

            GridAmr.DataSource = myReader;
            GridAmr.DataBind();

            con.Close();
        }

        //============= ввод записи после опроса  ===========================================================================================
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

            TxtDocDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
            TxtDocNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);

            if (GlvDocIdn > 0)
            {
                BoxRsx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRDSPRVAL"]);
            }


        }
        // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void CmpButton_Click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            string KodErr = "";
            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (TxtDocNum.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (TxtDocDat.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxRsx.SelectedValue == "" || BoxRsx.SelectedValue == "0")
            {
                Err.Text = "Не указан расход";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxAmrDocCmp", con);
            cmd = new SqlCommand("BuxAmrDocCmp", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
            cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = BoxRsx.SelectedValue;

            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();

            CreateGrid();

            //     Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Амр&TxtSpr=РАСЧЕТ АМОРТИЗАЦИЙ");
        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Амр&TxtSpr=РАСЧЕТ АМОРТИЗАЦИЙ");
        }
        // ============================ проводить записи документа в базу ==============================================
        //------------------------------------------------------------------------
        protected void AddButton_Click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            string KodErr = "";
            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (TxtDocNum.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (TxtDocDat.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxRsx.SelectedValue == "" || BoxRsx.SelectedValue == "0")
            {
                Err.Text = "Не указан расход";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;
        }

        // ============================ одобрение для записи документа в базу ==============================================
        protected void btnOK_click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            //          localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //          ws.AptPrxDocAddRep(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, BoxOrg.SelectedValue, BuxKod);
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxAmrDocAddRep", con);
            cmd = new SqlCommand("BuxAmrDocAddRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = TxtDocNum.Text;
            cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
            cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = BoxRsx.SelectedValue;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Амр&TxtSpr=РАСЧЕТ АМОРТИЗАЦИЙ");
        }






    }
}
 




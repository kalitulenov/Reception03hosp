﻿using System;
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
    public partial class BuxDocPrxFix : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;

        int DtlIdn;

        string DtlDeb;
        int DtlDebSpr;
        int DtlDebSprVal;
        string DtlKrd;
        int DtlKrdSpr;
        int DtlKrdSprVal;

        int DtlKod;
        Boolean DtlNdc;
        int DtlGrp;
        int DtlGrpNal;
        int DtlUpk;

        decimal DtlKol;
        decimal DtlPrz;
        decimal DtlBxdIzn;
        string DtlEdn;
        string DtlNam;
        decimal DtlZen;
        decimal DtlSum;
        string DtlIzg;
        string DtlNumIzg;
        string DtlSrkSlb;
        string DtlDatIzg;


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
            if (GlvDocPrv != null && GlvDocPrv != "")
            {
                //               AddButton.Visible = false;
                //               PrvButton.Visible = false;
                //               GridMat.Columns[8].Visible = false;
            }
            //           if (GlvDocIdn == 0) PrvButton.Visible = false;

            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridMat.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridMat.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridMat.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridMat.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

            //           GlvDocIdn = 350;
            sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsEdn.SelectCommand = "SELECT EDNNAM FROM SPREDN ORDER BY EDNNAM";

            sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsOrg.SelectCommand = "SELECT ORGKOD,ORGNAM FROM SPRORG WHERE ORGFRM='" + BuxFrm + "' ORDER BY ORGNAM";

            sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsMol.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMol.SelectCommand = "SELECT MOLKOD,SprBuxKdr.FIO AS MOLNAM " +
                                   "FROM SprMol INNER JOIN SprBuxKdr ON SprMol.MolTab = dbo.SprBuxKdr.BuxKod " +
                                   "WHERE SprMol.MolFrm='" + BuxFrm + "' ORDER BY SprBuxKdr.FIO";

            sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

            sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsGrp.SelectCommand = "SELECT AmrKod,AmrNam+'.'+AmrNamGrp AS NamAmr FROM SPRGRPAMR ORDER BY AMRNAM";

            sdsNal.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNal.SelectCommand = "SELECT NalKod,NalNam+'.'+NalNamGrp AS NamNal FROM SPRGRPNAL ORDER BY NALNAM";

            //============= Соединение ===========================================================================================
            sdsDtl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //============= Источник для ГРИДа  ===========================================================================================
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

            //                       SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPMAT.GRPMATNAM,TABMAT.MATNAM " +
            //                                                       "FROM TABDOCDTL LEFT OUTER JOIN TABMAT ON TABDOCDTL.DTLKOD = TABMAT.MATKOD LEFT OUTER JOIN SPRGRPMAT ON TABDOCDTL.DTLGRP = SPRGRPMAT.GRPMATKOD WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);
            SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPAMR.AMRNAMGRP AS NAMAMR,SPRGRPNAL.NALNAMGRP AS NAMNAL " +
                                            "FROM TABDOCDTL LEFT OUTER JOIN SPRGRPAMR ON TABDOCDTL.DTLGRP = SPRGRPAMR.AMRKOD " + 
                                                           "LEFT OUTER JOIN SPRGRPNAL ON TABDOCDTL.DTLGRPNAL = SPRGRPNAL.NALKOD WHERE DTLDOCIDN =" + GlvDocIdn + " ORDER BY DTLIDN", con);

            con.Open();
            SqlDataReader myReader = cmd.ExecuteReader();

            GridMat.DataSource = myReader;
            GridMat.DataBind();

            con.Close();
        }

        //============= ввод записи после опроса  ===========================================================================================
        
        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            DateTime dt;
            string Pol;
            bool parse;

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

     //       DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
            if (Convert.ToString(e.Record["DTLDEB"]) == null || Convert.ToString(e.Record["DTLDEB"]) == "") DtlDeb = "";
            else DtlDeb = Convert.ToString(e.Record["DTLDEB"]);

            if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "") DtlNam = "";
            else DtlNam = Convert.ToString(e.Record["DTLNAM"]);

            if (Convert.ToString(e.Record["DTLKOL"]) == null || Convert.ToString(e.Record["DTLKOL"]) == "") DtlKol = 0;
            else DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);

            DtlNdc = Convert.ToBoolean(e.Record["DTLNDC"]);

            DtlEdn = Convert.ToString(e.Record["DTLEDN"]);

            if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
            else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

            if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
            else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

            if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
            else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

            if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
            else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

            if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
            else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

            DtlSum = DtlKol * DtlZen;

            if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
            else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

            Pol = Convert.ToString(e.Record["DTLDATIZG"]);
            parse = DateTime.TryParse(Pol, out dt);//parse=false

            if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
            else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

            Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
            parse = DateTime.TryParse(Pol, out dt);//parse=false

            if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
            else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

            //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
            //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

            if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
            else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);



            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("BuxPrxDocDtlAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;

            cmd.Parameters.Add("@DTLDEB", SqlDbType.VarChar).Value = DtlDeb;
            cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 2;
            cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

            cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
            cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
            cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
            cmd.Parameters.Add("@DTLPRZ", SqlDbType.Decimal).Value = 0;
            cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = DtlUpk;
            cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
            cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
            cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = DtlSrkSlb;

            cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = DtlBxdIzn;
            cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = DtlDatIzg;
            cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = DtlIzg;
            cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = DtlGrpNal;
            cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = DtlNumIzg;

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


            //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);

            CreateGrid();
        }
        

        //============= изменение записи после опроса  ===========================================================================================
        
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            DateTime dt;
            string Pol;
            bool parse;

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
            if (Convert.ToString(e.Record["DTLDEB"]) == null || Convert.ToString(e.Record["DTLDEB"]) == "") DtlDeb = "";
            else DtlDeb = Convert.ToString(e.Record["DTLDEB"]);

            if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "") DtlNam = "";
            else DtlNam = Convert.ToString(e.Record["DTLNAM"]);

            if (Convert.ToString(e.Record["DTLKOL"]) == null || Convert.ToString(e.Record["DTLKOL"]) == "") DtlKol = 0;
            else DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);

            DtlNdc = Convert.ToBoolean(e.Record["DTLNDC"]);

            DtlEdn = Convert.ToString(e.Record["DTLEDN"]);

            if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
            else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

            if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
            else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

            if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
            else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

            if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
            else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

            if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
            else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

            DtlSum = DtlKol * DtlZen;

            if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
            else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

            if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
            else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

            Pol = Convert.ToString(e.Record["DTLDATIZG"]);
            parse = DateTime.TryParse(Pol, out dt);//parse=false

            if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
            else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

            Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
            parse = DateTime.TryParse(Pol, out dt);//parse=false

            if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
            else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

            //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
            //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

            if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
            else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);


            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("BuxPrxDocDtlRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;

            cmd.Parameters.Add("@DTLDEB", SqlDbType.VarChar).Value = DtlDeb;
            cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 6;
            cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

            cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
            cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
            cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
            cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
            cmd.Parameters.Add("@DTLPRZ", SqlDbType.Int, 4).Value = DtlPrz;
            cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = DtlUpk;
            cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
            cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
            cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = DtlSrkSlb;

            cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = DtlBxdIzn;
            cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = DtlDatIzg;
            cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = DtlIzg;
            cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = DtlGrpNal;
            cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = DtlNumIzg;

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

            //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);

            CreateGrid();
        }
        

        // ============================ чтение заголовка таблицы а оп ==============================================

        void RebindGrid(object sender, EventArgs e)
        {
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
            SqlCommand cmd = new SqlCommand("BuxPrxDocDtlDel", con);
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


            //            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //            ws.AptPrxDtlDel(MdbNam, BuxSid, DtlIdn);

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

            //       SqlDataReader myReader = cmd.ExecuteReader();
            //       GridMat.DataSource = myReader;
            //       GridMat.DataBind();

            con.Close();

            //                        localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //                        DataSet ds = new DataSet("ComDocGetBux");

            //                        ds.Merge(ws.ComDocGetBux(MdbNam, BuxSid));
            TxtDocDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
            TxtDocNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);

            if (GlvDocIdn > 0)
            {
                BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRDSPRVAL"]);
                BoxAcc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCKRD"]);
                BoxMol.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
                TxtFkt.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUMFKT"]);
                TxtFktDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDATFKT"]);
            }


        }
        // ============================ запись заголовка таблицы а оп ==============================================
        //                  void setDocNum()
        //                  {
        //                      localhost.Service1Soap ws = new localhost.Service1SoapClient();
        //                      DataSet ds = new DataSet("ComDocSetBux");
        //         //             ws.ComDocSetBux(MdbNam, BuxSid, DOCNUM.Text, DOCDAT.Text, BuxKod);
        //                  }

        // ============================ проверка и опрос для записи документа в базу ==============================================
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

            if (BoxAcc.SelectedValue == "" || BoxAcc.SelectedValue == "0")
            {
                Err.Text = "Не указан кредитовый счет";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxMol.SelectedValue == "" || BoxMol.SelectedValue == "0")
            {
                Err.Text = "Не указан МОЛ";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (BoxOrg.SelectedValue == "" || BoxOrg.SelectedValue == "0")
            {
                Err.Text = "Не указан поставщик";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmd = new SqlCommand("BuxPrxDocDtlChk", con);
            cmd = new SqlCommand("BuxPrxDocDtlChk", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxPrxDocDtlChk");

            //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //           DataSet ds = new DataSet("AptPrxDocChk");
            //           ds.Merge(ws.AptPrxDocChk(MdbNam, BuxSid, BuxKod));

            KodErr = Convert.ToString(ds.Tables[0].Rows[0]["KODERR"]);
            Err.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAMERR"]);

            if (KodErr == "ERR")
            {
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
            }
            else
            {
                ConfirmDialog.Visible = true;
                ConfirmDialog.VisibleOnLoad = true;
            }

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
            SqlCommand cmd = new SqlCommand("BuxPrxDocAddRep", con);
            cmd = new SqlCommand("BuxPrxDocAddRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = TxtDocNum.Text;
            cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
            cmd.Parameters.Add("@DOCDEB", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DOCDEBSPR", SqlDbType.VarChar).Value = "6";                // BoxOrg.SelectedValue;
            cmd.Parameters.Add("@DOCDEBSPRVAL", SqlDbType.VarChar).Value = BoxMol.SelectedValue;
            cmd.Parameters.Add("@DOCKRD", SqlDbType.VarChar).Value = BoxAcc.SelectedValue;
            cmd.Parameters.Add("@DOCKRDSPR", SqlDbType.VarChar).Value = "2";
            cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = BoxOrg.SelectedValue;
            cmd.Parameters.Add("@DOCNUMFKT", SqlDbType.VarChar).Value = TxtFkt.Text;
            cmd.Parameters.Add("@DOCDATFKT", SqlDbType.VarChar).Value = TxtFktDat.Text;
            cmd.Parameters.Add("@DOCMEM", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прф&TxtSpr=Приходные накладные (основные средства)");
        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прф&TxtSpr=Приходные накладные (основные средства)");
        }
        // ============================ проводить записи документа в базу ==============================================
        //------------------------------------------------------------------------
        protected void PrtButton_Click(object sender, EventArgs e)
        {
            //       AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
            // --------------  печать ----------------------------
            //       Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbLab003&TekDocIdn=" + AmbUslIdn);
        }

        // ---------Суммация  ------------------------------------------------------------------------
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            /*
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[6].Text == null | e.Row.Cells[6].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[6].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[2].Text = "Итого:";
                e.Row.Cells[6].Text = ItgDocSum.ToString();

            }
             * */
        }

        // ============================ конец текста ==============================================




    }
}
 




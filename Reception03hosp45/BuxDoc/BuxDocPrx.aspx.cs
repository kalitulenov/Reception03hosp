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

using System.Data.OleDb;
using System.Web.Services;
using System.Configuration;
using System.IO;

namespace Reception03hosp45.BuxDoc
{
    public partial class BuxDocPrx : System.Web.UI.Page
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


            GlvDocTyp = "Прх";
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

            sdsAccOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsAccOrg.SelectCommand = "SELECT ACCKOD,ACCKOD+'.  '+ACCNAM AS ACCTXT FROM TABACC " +
                                      "WHERE (ACCKOD LIKE '33%' OR ACCKOD LIKE '12%') AND ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsAcc.SelectCommand = "SELECT ACCKOD,ACCKOD+'.  '+ACCNAM AS ACCTXT FROM TABACC " +
                                   " WHERE (ACCKOD LIKE '13%' OR ACCKOD LIKE '24%') AND ACCPRV=1 AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsMol.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMol.SelectCommand = "SELECT BUXKOD AS MOLKOD,FI AS MOLNAM FROM SprBuxKdr WHERE ISNULL(BuxMol,0)=1 AND BuxFrm=" + BuxFrm + " ORDER BY SprBuxKdr.FIO";

            sdsMat.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMat.SelectCommand = "SELECT MATKOD,MATNAM FROM TABMAT WHERE MATFRM='" + BuxFrm + "' ORDER BY MATNAM";

            sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsGrp.SelectCommand = "SELECT GrpMatKod,GrpMatNam FROM SPRGRPMAT ORDER BY GRPMATNAM";

            //     sdsNal.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            //     sdsNal.SelectCommand = "SELECT NalKod,NalNam+'.'+NalNamGrp AS NamNal FROM SPRGRPNAL ORDER BY NALNAM";

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
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Прх";
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

            SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPMAT.GRPMATNAM,TABMAT.MATNAM " +
                                            "FROM TABDOCDTL LEFT OUTER JOIN TABMAT ON TABDOCDTL.DTLKOD = TABMAT.MATKOD " +
                                                           "LEFT OUTER JOIN SPRGRPMAT ON TABDOCDTL.DTLGRP = SPRGRPMAT.GRPMATKOD " +
                                            "WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);
          //  SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,SPRGRPAMR.AMRNAMGRP AS NAMAMR,SPRGRPNAL.NALNAMGRP AS NAMNAL " +
          //                                  "FROM TABDOCDTL LEFT OUTER JOIN SPRGRPAMR ON TABDOCDTL.DTLGRP = SPRGRPAMR.AMRKOD " + 
          //                                                 "LEFT OUTER JOIN SPRGRPNAL ON TABDOCDTL.DTLGRPNAL = SPRGRPNAL.NALKOD WHERE DTLDOCIDN =" + GlvDocIdn + " ORDER BY DTLIDN", con);

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

     //       if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
     //       else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

            if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
            else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

            if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
            else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

            if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
            else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

   //         if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
   //         else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

            DtlSum = DtlKol * DtlZen;

   //         if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
   //         else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

  //          Pol = Convert.ToString(e.Record["DTLDATIZG"]);
  //          parse = DateTime.TryParse(Pol, out dt);//parse=false

  //          if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
  //          else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

   //         Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
   //         parse = DateTime.TryParse(Pol, out dt);//parse=false

   //         if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
   //         else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

            //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
            //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

    //        if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
    //        else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);



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
            cmd.Parameters.Add("@DTLDEBSPR", SqlDbType.Int, 4).Value = 6;
            cmd.Parameters.Add("@DTLDEBSPRVAL", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRD", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DTLKRDSPR", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLKRDSPRVAL", SqlDbType.Int, 4).Value = 0;

            cmd.Parameters.Add("@DTLKOD", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
            cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
            cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
            cmd.Parameters.Add("@DTLPRZ", SqlDbType.Decimal).Value = DtlPrz;
            cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = 0;  // DtlUpk;
            cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
            cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
            cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = "";  // DtlSrkSlb;

            cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = 0;  // DtlBxdIzn;
            cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = "";  // DtlDatIzg;
            cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = "";   // DtlIzg;
            cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = 0;  // DtlGrpNal;
            cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = "";   // DtlNumIzg;

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

  //          if (Convert.ToString(e.Record["DTLBXDIZN"]) == null || Convert.ToString(e.Record["DTLBXDIZN"]) == "") DtlBxdIzn = 0;
  //          else DtlBxdIzn = Convert.ToDecimal(e.Record["DTLBXDIZN"]);

            if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "") DtlZen = 0;
            else DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);

            if (Convert.ToString(e.Record["DTLPRZ"]) == null || Convert.ToString(e.Record["DTLPRZ"]) == "") DtlPrz = 0;
            else DtlPrz = Convert.ToDecimal(e.Record["DTLPRZ"]);

            if (Convert.ToString(e.Record["DTLGRP"]) == null || Convert.ToString(e.Record["DTLGRP"]) == "") DtlGrp = 0;
            else DtlGrp = Convert.ToInt32(e.Record["DTLGRP"]);

  //          if (Convert.ToString(e.Record["DTLGRPNAL"]) == null || Convert.ToString(e.Record["DTLGRPNAL"]) == "") DtlGrpNal = 0;
  //          else DtlGrpNal = Convert.ToInt32(e.Record["DTLGRPNAL"]);

            DtlSum = DtlKol * DtlZen;

  //          if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
  //          else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

  //          if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "") DtlIzg = "";
  //          else DtlIzg = Convert.ToString(e.Record["DTLIZG"]);

  //          Pol = Convert.ToString(e.Record["DTLDATIZG"]);
  //          parse = DateTime.TryParse(Pol, out dt);//parse=false

  //          if (parse == true) DtlDatIzg = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
  //          else DtlDatIzg = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");

  //          Pol = Convert.ToString(e.Record["DTLSRKSLB"]);
  //          parse = DateTime.TryParse(Pol, out dt);//parse=false

  //          if (parse == true) DtlSrkSlb = Convert.ToDateTime(Pol).ToString("dd.MM.yyyy");
  //          else DtlSrkSlb = Convert.ToDateTime(DateTime.Today.AddDays(3650)).ToString("dd.MM.yyyy");

            //      if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "") DtlSrkSlb = "";
            //      else DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");

  //          if (Convert.ToString(e.Record["DTLNUMIZG"]) == null || Convert.ToString(e.Record["DTLNUMIZG"]) == "") DtlNumIzg = "";
  //          else DtlNumIzg = Convert.ToString(e.Record["DTLNUMIZG"]);


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
            cmd.Parameters.Add("@DTLUPK", SqlDbType.Int, 4).Value = 0;  // DtlUpk;
            cmd.Parameters.Add("@DTLGRP", SqlDbType.Int, 4).Value = DtlGrp;
            cmd.Parameters.Add("@DTLNDC", SqlDbType.Bit, 1).Value = DtlNdc;
            cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = "";  //DtlSrkSlb;

            cmd.Parameters.Add("@DTLBXDIZN", SqlDbType.Int, 4).Value = 0;   // DtlBxdIzn;
            cmd.Parameters.Add("@DTLDATIZG", SqlDbType.VarChar).Value = "";  // DtlDatIzg;
            cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = "";  // DtlIzg;
            cmd.Parameters.Add("@DTLGRPNAL", SqlDbType.Int, 4).Value = 0;  // DtlGrpNal;
            cmd.Parameters.Add("@DTLNUMIZG", SqlDbType.VarChar).Value = 0; // DtlNumIzg;

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

            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходная накладная");
        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходная накладная");
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
           
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[9].Text == null | e.Row.Cells[9].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[9].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[2].Text = "Итого:";
                e.Row.Cells[9].Text = ItgDocSum.ToString();
            }
             
        }

        protected void Import_Click_OLD(object sender, EventArgs e)
        {
            int[,] MasLek = new Int32[5000, 2];
            int LekKol;

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
            //            string StrBeg = "=";
            //            string StrEnd  =  "";

            string ExcelContentType = "application/vnd.ms-excel";
            string Excel2010ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            // --------------------------------------------------------------------------------------
            if (FileUpload1.HasFile)
            {
                //Check the Content Type of the file
                if (FileUpload1.PostedFile.ContentType == ExcelContentType || FileUpload1.PostedFile.ContentType == Excel2010ContentType)
                {
                    try
                    {
                        //Save file path
                        //                                    string path = string.Concat(Server.MapPath("~/Temp/"), FileUpload1.FileName);
                        string path = string.Concat(Server.MapPath(""), FileUpload1.FileName);
                        //Save File as Temp then you can delete it if you want
                        FileUpload1.SaveAs(path);
                        DataSet DtSet;
                        DtSet = new DataSet();

                        //  ========================================================================================================================
                        string LstIdn = "";
                        int i = 1;
                        int n = 0;
                        foreach (DataRow row in DtSet.Tables[0].Rows)
                        {
                            i = 1;
                            for (int j = 0; j < DtSet.Tables[0].Columns.Count; j++)  // количество колонок в GRID
                            {
                                if (row[j].ToString() == Convert.ToString(i))
                                {
                                    MasLek[i, 0] = j;
                                    MasLek[i, 1] = i;
                                    i = i + 1;
                                }
                            }

                            if (i > 8) break;
                        }

                        n = 0;
                    }

                    catch (Exception ex)
                    {
                        Err.Text = ex.Message;
                        ConfirmOK.Visible = true;
                        ConfirmOK.VisibleOnLoad = true;
                    }
                }

            }
        }
        // ============================ проверка и очистка таблицы документа в базе ==============================================
        protected void ClrButton_Click(object sender, EventArgs e)
        {
            CreateGrid();
        }

        // ============================ конец текста ==============================================

        protected void Import_Click(object sender, EventArgs e)
        {
            string conStr = "";
            String[] PagNam;

            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

            string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

            FileUpload1.SaveAs(FilePath);

            PagNam = GetExcelSheetNames(FilePath);

            //declare variables - edit these based on your particular situation 
            string ssqltable = "TAB_EXCEL";
            // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have    different 
          //  string myexceldataquery = "SELECT '" + BuxKod + "',* FROM [" + ddlSheets.SelectedItem.Text + "]";
            string myexceldataquery = "SELECT '" + BuxKod + "',* FROM [" + PagNam[0] +"]";
            try
            {
                //create our connection strings 
                //                string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=yes;\""; 
                string sexcelconnectionstring = @"provider=Microsoft.ACE.OLEDB.12.0;data source=" + FilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";

                //      string ssqlconnectionstring = "Data Source=SAYYED;Initial Catalog=SyncDB;Integrated Security=True"; 
                string ssqlconnectionstring = ConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

                //              ----------------------------------------------------------  очистить таблицу -----------------------
                //execute a query to erase any previous data from our destination table 
                string sclearsql = "DELETE FROM TAB_EXCEL WHERE BUX='" + BuxKod + "'";
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                //        sqlconn.Close();

                //              ----------------------------------------------------------  загрузить таблицу -----------------------
                //series of commands to bulk copy data from the excel file into our sql table 
                OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
                OleDbCommand oledbcmd = new OleDbCommand(myexceldataquery, oledbconn);
                oledbconn.Open();
                OleDbDataReader dr = oledbcmd.ExecuteReader();
                SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
                bulkcopy.DestinationTableName = ssqltable;
                while (dr.Read())
                {
                    bulkcopy.WriteToServer(dr);
                }
                dr.Close();
                oledbconn.Close();
                /*
                //              ----------------------------------------------------------  слить в базу данных -----------------------
                //execute a query to erase any previous data from our destination table 
                // string sclearsql = "DELETE FROM TAB_RPN WHERE FRM='" + BuxFrm + "'";
                SqlConnection sqlconnMrg = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmdMrg = new SqlCommand("HspRpnImpExl", sqlconn);
                sqlcmdMrg.CommandType = CommandType.StoredProcedure;
                sqlcmdMrg.Parameters.Add("@KLTFRM", SqlDbType.Int, 4).Value = BuxFrm;

                sqlconnMrg.Open();
                sqlcmdMrg.ExecuteNonQuery();
                sqlconnMrg.Close();
                */

                sqlconn.Close();

        //        lblMessage.Text = "РПН ЗАГРУЖЕН В БАЗУ.";



                // проверить если фаил есть удалить ----------------------------------------------------------------
                if (File.Exists(FilePath)) File.Delete(FilePath);

                Err.Text = "Таблица загружен";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
            }
            catch (Exception ex)
            {
                //handle exception 
          //      lblMessage.Text = ex.Message;
            }
           
        }

        // ============================ конец текста ==============================================

        protected void SelectSheed(object sender, EventArgs e)
        {
            string conStr = "";
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

            string FilePath = string.Concat(Server.MapPath("~/Temp/" + FileUpload1.FileName));

            FileUpload1.SaveAs(FilePath);

            //Get the Sheets in Excel WorkBoo
            conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
            conStr = String.Format(conStr, FilePath, "yes");
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            cmdExcel.Connection = connExcel;
            connExcel.Open();
            
            //Bind the Sheets to DropDownList
        //    ddlSheets.Items.Clear();
        //    ddlSheets.Items.Add(new ListItem("Выберите лист...", ""));
        //    ddlSheets.DataSource = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        //    ddlSheets.DataTextField = "TABLE_NAME";
        //    ddlSheets.DataValueField = "TABLE_NAME";
        //    ddlSheets.DataBind();
            connExcel.Close();
        }

        /// <span class="code-SummaryComment"><summary></span>
        /// This mehtod retrieves the excel sheet names from 
        /// an excel workbook.
        /// <span class="code-SummaryComment"></summary></span>
        /// <span class="code-SummaryComment"><param name="excelFile">The excel file.</param></span>
        /// <span class="code-SummaryComment"><returns>String[]</returns></span>

        private String[] GetExcelSheetNames(string excelFile)
        {
            OleDbConnection objConn = null;
            System.Data.DataTable dt = null;

            try
            {
                // Connection String. Change the excel file to the file you
                // will search.
                //     String connString = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
                String connString = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
                // Create connection object by using the preceding connection string.
                objConn = new OleDbConnection(connString);
                // Open connection with the database.
                objConn.Open();
                // Get the data table containg the schema guid.
                dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                if (dt == null)
                {
                    return null;
                }

                String[] excelSheets = new String[dt.Rows.Count];
                int i = 0;

                // Add the sheet name to the string array.
                foreach (DataRow row in dt.Rows)
                {
                    excelSheets[i] = row["TABLE_NAME"].ToString();
                    i++;
                    break;
                }

                // Loop through all of the sheets if you want too...
              //  for (int j = 0; j < excelSheets.Length; j++)
              //  {
              //      // Query each excel sheet.
              //  }

                return excelSheets;
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                // Clean up.
                if (objConn != null)
                {
                    objConn.Close();
                    objConn.Dispose();
                }
                if (dt != null)
                {
                    dt.Dispose();
                }
            }
        }




    }
}
 




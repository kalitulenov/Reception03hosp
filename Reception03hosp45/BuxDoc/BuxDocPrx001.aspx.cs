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
    public partial class BuxDocPrx001 : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;

        int DtlIdn;
        string DtlNam;
        decimal DtlKol;
        string DtlEdn;
        decimal DtlZen;
        decimal DtlSum;
        string DtlIzg;
        string DtlSrkSlb;


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
                AddButton.Visible = false;
                PrvButton.Visible = false;
                GridMat.Columns[9].Visible = false;
            }
            if (GlvDocIdn == 0) PrvButton.Visible = false;
            
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

           //============= Соединение ===========================================================================================
           sdsDtl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
           //============= Источник для ГРИДа  ===========================================================================================
      //     sdsDtl.SelectCommand = "SELECT * FROM TMPDOCDTL WHERE DTLBUX='" + BuxKod + "' ORDER BY DTLIDN";
           //============= команды для  ГРИДа  WHERE DOCDTLBUX='" + BuxKod +===========================================================================================
      //     sdsDtl.InsertCommand = "INSERT INTO TMPDOCDTL(DTLNAM,DTLKOL,DTLEDN,DTLZEN,DTLSUM,DTLIZG,DTLSRKSLB,DTLBUX)" +
      //                                    "VALUES (@DTLNAM,@DTLKOL,@DTLEDN,@DTLZEN,@DTLZEN*@DTLKOL,@DTLIZG," +
      //                                    "CONVERT(DATETIME,@DTLSRKSLB, 104),'" + BuxKod + "')";
      //     sdsDtl.UpdateCommand = "UPDATE TMPDOCDTL SET DTLIDN=@DTLIDN,DTLNAM=@DTLNAM,DTLKOL=@DTLKOL,DTLEDN=@DTLEDN," +
      //                                    "DTLZEN=@DTLZEN,DTLSUM=@DTLSUM,DTLIZG=@DTLIZG,DTLSRKSLB=@DTLSRKSLB,DTLBUX=@DTLBUX " +
      //                                    "WHERE DTLIDN=@DTLIDN";
           //          SqlDataSource1.DeleteCommand = "DELETE TMP_DOCDTL WHERE DOCDTLIDN=@DOCDTLIDN";
       
           //============= локолизация для календаря  ===========================================================================================
   //        OboutInc.Calendar2.Calendar orderDateCalendar1 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[9].Cells[1].Controls[0].Controls[1].Controls[0]);
   //        orderDateCalendar1.CultureName = "ru-RU";

   //        OboutInc.Calendar2.Calendar orderDateCalendar2 = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[10].Cells[1].Controls[0].Controls[1].Controls[0]);
   //        orderDateCalendar2.CultureName = "ru-RU";
           //=====================================================================================
           string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
           string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
           if (par02 != null && !par02.Equals("") && GlvDocIdn == 0)
           {
 //              Session["AmbUslIdn"] = "Post";
               GlvDocIdn = Convert.ToInt32(parDocIdn.Value);
           }

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
             
           } 
              getDocNum();
          
              CreateGrid();
               //        ddlEdnNam.SelectedValue = "шт";


         }



             void CreateGrid()
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        // создание команды

                        SqlCommand cmd = new SqlCommand("SELECT TABDOCDTL.*,TABMAT.MATNAM,SPRGRPMAT.GRPMATNAM," +
                                                        "CASE WHEN DTLNDC=0 THEN '+' ELSE '' END AS NDC " +
                                                        "FROM TABDOCDTL LEFT OUTER JOIN TABMAT ON TABDOCDTL.DTLKOD = TABMAT.MATKOD " +
                                                                      " LEFT OUTER JOIN SPRGRPMAT ON TABDOCDTL.DTLGRP = SPRGRPMAT.GRPMATKOD WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);

                        con.Open();
                        SqlDataReader myReader = cmd.ExecuteReader();

                        GridMat.DataSource = myReader;
                        GridMat.DataBind();

                        con.Close();
                    }
           
             //============= ввод записи после опроса  ===========================================================================================
             void InsertRecord(object sender, GridRecordEventArgs e)
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
                        
                         if (Convert.ToString(e.Record["DTLNAM"]) == null || Convert.ToString(e.Record["DTLNAM"]) == "")
                            DtlNam = "";
                        else
                            DtlNam = Convert.ToString(e.Record["DTLNAM"]);
                        if (Convert.ToString(e.Record["DTLKOL"]) == null || Convert.ToString(e.Record["DTLKOL"]) == "")
                            DtlKol = 0;
                        else
                            DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);
                        DtlEdn = Convert.ToString(e.Record["DTLEDN"]);
                        if (Convert.ToString(e.Record["DTLZEN"]) == null || Convert.ToString(e.Record["DTLZEN"]) == "")
                            DtlZen = 0;
                        else
                            DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);
                        DtlSum = DtlKol * DtlZen;
                        if (Convert.ToString(e.Record["DTLIZG"]) == null || Convert.ToString(e.Record["DTLIZG"]) == "")
                            DtlIzg = "";
                        else
                            DtlIzg = Convert.ToString(e.Record["DTLIZG"]);
                        if (Convert.ToString(e.Record["DTLSRKSLB"])==null || Convert.ToString(e.Record["DTLSRKSLB"])=="")
                            DtlSrkSlb = "";
                        else 
                            DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy"); 


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
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
            cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
            cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
            cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
            cmd.Parameters.Add("@DTLSUM", SqlDbType.Decimal).Value = DtlSum;
            cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = DtlIzg;
            cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = DtlSrkSlb;
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


    //                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
    //                    ws.AptPrxDtlAdd(MdbNam, BuxSid, BuxFrm,DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);
                        
                 CreateGrid();
                    }


                    //============= изменение записи после опроса  ===========================================================================================
             void UpdateRecord(object sender, GridRecordEventArgs e)
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);
                        DtlNam = Convert.ToString(e.Record["DTLNAM"]);
                        DtlKol = Convert.ToDecimal(e.Record["DTLKOL"]);
                        DtlEdn = Convert.ToString(e.Record["DTLEDN"]);
                        DtlZen = Convert.ToDecimal(e.Record["DTLZEN"]);
                        DtlSum = DtlKol * DtlZen;
                        DtlIzg = Convert.ToString(e.Record["DTLIZG"]);
                        if (Convert.ToString(e.Record["DTLSRKSLB"]) == null || Convert.ToString(e.Record["DTLSRKSLB"]) == "")
                            DtlSrkSlb = "";
                        else
                            DtlSrkSlb = Convert.ToDateTime(e.Record["DTLSRKSLB"]).ToString("dd.MM.yyyy");
                 
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
                        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
                        cmd.Parameters.Add("@DTLNAM", SqlDbType.VarChar).Value = DtlNam;
                        cmd.Parameters.Add("@DTLKOL", SqlDbType.Decimal).Value = DtlKol;
                        cmd.Parameters.Add("@DTLEDN", SqlDbType.VarChar).Value = DtlEdn;
                        cmd.Parameters.Add("@DTLZEN", SqlDbType.Decimal).Value = DtlZen;
                        cmd.Parameters.Add("@DTLSUM", SqlDbType.Decimal).Value = DtlSum;
                        cmd.Parameters.Add("@DTLIZG", SqlDbType.VarChar).Value = DtlIzg;
                        cmd.Parameters.Add("@DTLSRKSLB", SqlDbType.VarChar).Value = DtlSrkSlb;
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


           //             localhost.Service1Soap ws = new localhost.Service1SoapClient();
           //             ws.AptPrxDtlRep(MdbNam, BuxSid, DtlIdn, DtlNam, DtlKol, DtlEdn, DtlZen, DtlSum, DtlIzg, DtlSrkSlb);
                      
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

                        if (GlvDocIdn > 0) BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
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
                        cmd.Parameters.Add("@DOCORG", SqlDbType.VarChar).Value = BoxOrg.SelectedValue;
                        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                        // ------------------------------------------------------------------------------заполняем первый уровень
                        cmd.ExecuteNonQuery();
                        con.Close();

                        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходные накладные");
                    }

                    // ============================ отказ записи документа в базу ==============================================
                    protected void CanButton_Click(object sender, EventArgs e)
                    {
                        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходные накладные");
                    }
                    // ============================ проводить записи документа в базу ==============================================
                    protected void PrvButton_Click(object sender, EventArgs e)
                    {
                        PrvConfirmDialog.Visible = true;
                        PrvConfirmDialog.VisibleOnLoad = true;
                    }
                    // ============================ одобрение для проведения документа в базу ==============================================
                    protected void btnPrvOK_click(object sender, EventArgs e)
                    {
            //            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //            ws.AptPrxDocPrv(MdbNam, BuxSid, BuxFrm, GlvDocIdn, BuxKod);
                        // строка соединение
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();

                        // создание команды
                        SqlCommand cmd = new SqlCommand("BuxPrxDocPrv", con);
                        cmd = new SqlCommand("BuxPrxDocPrv", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // создать коллекцию параметров
                        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
                        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                        // ------------------------------------------------------------------------------заполняем первый уровень
                        cmd.ExecuteNonQuery();
                        con.Close(); Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходные накладные");
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




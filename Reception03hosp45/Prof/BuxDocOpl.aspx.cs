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
using System.IO;

namespace SkoolTstAdm.SklDoc
{
    public partial class BuxDocOpl : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;



        string GlvDocTyp;
        DateTime GlvDocDat;
        string MdbNam = "TESTBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;
        string CountTxt;
        int CountInt;
        decimal ItgDocSum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
           //============= Установки ===========================================================================================
    //       BuxSid = (string)Session["BuxSid"];
           BuxKod = (string)Session["BuxKod"];
           BuxFrm = (string)Session["BuxFrmKod"];    


           GlvDocTyp = "Опл";
           //=====================================================================================
            GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
           //============= начало  ===========================================================================================
            sdsObl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsObl.SelectCommand = "SELECT STRSKLKEY AS OBLKOD,STRSKLNAM AS OBLNAM FROM SPRSTRSKL WHERE STRSKLLVL=1 ORDER BY STRSKLNAM";

            sdsRai.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsRai.SelectCommand = "SELECT STRSKLKEY AS RAIKOD,STRSKLNAM AS RAINAM FROM SPRSTRSKL WHERE STRSKLLVL=2 ORDER BY STRSKLNAM";
            //============= начало  ===========================================================================================


            if (GlvDocPrv != null && GlvDocPrv != "")
            {
                AddButton.Visible = false;
 //               PrvButton.Visible = false;
  //              GridPss.Columns[9].Visible = false;
            }
 //           if (GlvDocIdn == 0) PrvButton.Visible = false;
            
            // ViewState
           // ViewState["text"] = "Artem Shkolovy";
           // string Value = (string)ViewState["name"];
  //         GridPss.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
  //         GridPss.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

           if (!Page.IsPostBack)
           {

               if (GlvDocIdn == 0)  // новый документ
               {
                   Session.Add("CounterTxt", "0");

                   DataSet ds = new DataSet();
                   // строка соединение
                   string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                   // создание соединение Connection
                   SqlConnection con = new SqlConnection(connectionString);
                   // создание команды
                   SqlCommand cmd = new SqlCommand("TstDocOpl", con);
                   // указать тип команды
                   cmd.CommandType = CommandType.StoredProcedure;
                   // передать параметр
                   cmd.Parameters.Add("@DOCIDN", SqlDbType.Int, 4).Value = 0;
                   cmd.Parameters["@DOCIDN"].Direction = ParameterDirection.Output;
                   con.Open();
                   try
                   {
                       int numAff = cmd.ExecuteNonQuery();
                       // Получить вновь сгенерированный идентификатор.
                       //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                       //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                       GlvDocIdn = Convert.ToInt32(cmd.Parameters["@DOCIDN"].Value);
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


        // ============================ чтение заголовка таблицы а оп ==============================================

             void CreateGrid()
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        // создание команды

                        SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOCOPL WHERE DTLDOCIDN=" + GlvDocIdn + " ORDER BY DTLIDN", con);

                        con.Open();
                        SqlDataReader myReader = cmd.ExecuteReader();

                        GridPss.DataSource = myReader;
                        GridPss.DataBind();

                        con.Close();
                    }
           
        // ============================ чтение заголовка таблицы а оп ==============================================
             void getDocNum()
             {
                 string KeyObl;
                 string SqlCnt;

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
                 DOCKOL.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCKOL"]);


                 if (Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]).Length > 4)
                 {
                    
                     BoxObl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]).Substring(0, 5);

                     //============================= читать дату договора ====================================================================
            //         KeyObl = Convert.ToInt32(BoxObl.SelectedValue).ToString("D5");

                     //============================= читать дату договора ====================================================================
             //        SqlCnt = "SELECT STRSKLKEY AS RAIKOD,STRSKLNAM AS RAINAM FROM SPRSTRSKL WHERE STRSKLLVL=2  " + " AND LEFT(STRSKLKEY,5)='" + KeyObl + "' ORDER BY STRSKLNAM";
                     SqlCnt = "SELECT STRSKLKEY AS RAIKOD,STRSKLNAM AS RAINAM FROM SPRSTRSKL WHERE STRSKLLVL=2  ORDER BY STRSKLNAM";
                     // ------------------------------------------------------------------------------заполняем второй уровень
                     // создание команды
                     DataSet dsCnt = new DataSet();
                     SqlCommand cmdCnt = new SqlCommand(SqlCnt, con);
                     SqlDataAdapter daCnt = new SqlDataAdapter(cmdCnt);
                     daCnt.Fill(dsCnt, "Cnt");
                     BoxRai.Items.Clear();
                     BoxRai.DataSource = dsCnt;
                     BoxRai.DataBind();
                     //===============================================================================================================
                     con.Close();

                     BoxRai.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCDEBSPRVAL"]);
                 }


/*
                 // создание командыISNULL(STRKLTUBL,0)=0 AND 
                 DataSet dsCnt = new DataSet();
                 SqlCommand cmdCnt = new SqlCommand("SELECT STRSKLKEY AS RAIKOD,STRSKLNAM AS RAINAM FROM SPRSTRSKL WHERE STRSKLLVL=2 ORDER BY STRSKLNAM", con);
                 SqlDataAdapter daCnt = new SqlDataAdapter(cmdCnt);
                 daCnt.Fill(dsCnt, "Cnt");
                 BoxRai.Items.Clear();

                 if (dsCnt.Tables[0].Rows.Count > 0)
                 {
                     BoxRai.DataSource = dsCnt;
                     BoxRai.DataBind();
                 }
                 //===============================================================================================================
                 con.Close();
*/


             }

                    // ============================ проверка и опрос для записи документа в базу ==============================================
                    protected void AddButton_Click(object sender, EventArgs e)
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        string KodErr = "";

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

                        if (DOCKOL.Text.Length == 0)
                        {
                            Err.Text = "Не указан количество паролей";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        if (BoxObl.Text.Length == 0)
                        {
                            Err.Text = "Не указана область";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        if (BoxRai.Text.Length == 0)
                        {
                            Err.Text = "Не указан район";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
                        
     //                   localhost.Service1Soap ws = new localhost.Service1SoapClient();
                        TstDocAddRep(MdbNam, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, DOCKOL.Text, BoxRai.SelectedValue);
                        Response.Redirect("~/SklDoc/BuxDoc.aspx?NumSpr=Тст&TxtSpr=Генерация паролей");

          //               ConfirmOK.Visible = true;
          //               ConfirmOK.VisibleOnLoad = true;

                    }

                    // ============================ отказ записи документа в базу ==============================================
                    protected void CanButton_Click(object sender, EventArgs e)
                    {
                        Response.Redirect("~/SklDoc/BuxDoc.aspx?NumSpr=Тст&TxtSpr=Генерация паролей");
                    }


                    // ============================ расчет документа ==============================================
                    protected void GnrButton_Click(object sender, EventArgs e)
                    {
                        string KeyObl;
                        string KolObl;

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

                        if (DOCKOL.Text.Length == 0)
                        {
                            Err.Text = "Не указан количество паролей";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        if (BoxObl.Text.Length == 0)
                        {
                            Err.Text = "Не указана область";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        if (BoxRai.Text.Length == 0)
                        {
                            Err.Text = "Не указан район";
                            ConfirmOK.Visible = true;
                            ConfirmOK.VisibleOnLoad = true;
                            return;
                        }

                        KeyObl = Convert.ToInt32(BoxObl.SelectedValue).ToString("D5");
                        KolObl = DOCKOL.Text;

                        // ------------ удалить загрузку оператора ---------------------------------------
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("TstDocGnr", con);
                        cmd = new SqlCommand("TstDocGnr", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        // создать коллекцию параметров
                        cmd.Parameters.Add("@DOCIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                        cmd.Parameters.Add("@DOCOBL", SqlDbType.VarChar).Value = KeyObl;
                        cmd.Parameters.Add("@DOCKOL", SqlDbType.VarChar).Value = KolObl;
                        // выполнить
                        cmd.ExecuteNonQuery();

                        con.Close();

                        ConfirmOK.Visible = true;
                        ConfirmOK.VisibleOnLoad = true;

                        CreateGrid();
                    }


                    //------------------------------------------------------------------------
                    protected void BoxObl_OnSelectedIndexChanged(object sender, EventArgs e)
                    {
                        string KeyObl;
                        string SqlCnt;

                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                       
                        if (Convert.ToInt32(BoxObl.SelectedValue) > 0)
                        {
                            KeyObl = Convert.ToInt32(BoxObl.SelectedValue).ToString("D5");

                            //============================= читать дату договора ====================================================================
                            SqlCnt = "SELECT STRSKLKEY AS RAIKOD,STRSKLNAM AS RAINAM FROM SPRSTRSKL WHERE STRSKLLVL=2  " +
                                     " AND LEFT(STRSKLKEY,5)='" + KeyObl + "' ORDER BY STRSKLNAM";
                            // ------------------------------------------------------------------------------заполняем второй уровень
                            // создание команды
                            DataSet dsCnt = new DataSet();
                            SqlCommand cmdCnt = new SqlCommand(SqlCnt, con);
                            SqlDataAdapter daCnt = new SqlDataAdapter(cmdCnt);
                            daCnt.Fill(dsCnt, "Cnt");
                            BoxRai.Items.Clear();
                            BoxRai.DataSource = dsCnt;
                            BoxRai.DataBind();
                            //===============================================================================================================
                            con.Close();
                        }
                         
                    }

                    // ==================================================================================================  

                    public bool TstDocAddRep(string BUXMDB, int GLVDOCIDN, string DOCNUM, string DOCDAT, string DOCKOL, string DOCRAI)
                    {
                        // строка соединение
                        string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();

                        // создание команды
                        SqlCommand cmd = new SqlCommand("TstDocAddRep", con);
                        cmd = new SqlCommand("TstDocAddRep", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // создать коллекцию параметров
                        cmd.Parameters.Add(new SqlParameter("@GLVDOCIDN", SqlDbType.Int, 4));
                        cmd.Parameters.Add(new SqlParameter("@DOCNUM", SqlDbType.VarChar));
                        cmd.Parameters.Add(new SqlParameter("@DOCDAT", SqlDbType.VarChar));
                        cmd.Parameters.Add(new SqlParameter("@DOCKOL", SqlDbType.VarChar));
                        cmd.Parameters.Add(new SqlParameter("@DOCRAI", SqlDbType.VarChar));
                        // ------------------------------------------------------------------------------заполняем первый уровень
                        // передать параметр
                        cmd.Parameters["@GLVDOCIDN"].Value = GLVDOCIDN;
                        cmd.Parameters["@DOCNUM"].Value = DOCNUM;
                        cmd.Parameters["@DOCDAT"].Value = DOCDAT;
                        cmd.Parameters["@DOCKOL"].Value = DOCKOL;
                        cmd.Parameters["@DOCRAI"].Value = DOCRAI;
                        // ------------------------------------------------------------------------------заполняем второй уровень
                        cmd.ExecuteNonQuery();
                        con.Close();
                        // ------------------------------------------------------------------------------заполняем второй уровень
                        return true;
                    }
                    //------------------------------------------------------------------------

               // ============================ конец текста ==============================================
       }
    }   


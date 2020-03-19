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

namespace Reception03hosp45.Priem
{
    public partial class DocAppLabUpl001 : System.Web.UI.Page
    {
        int GlvDocIdn;
        string GlvDocPrv;



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


            GlvDocTyp = "Л01";
            //=====================================================================================
            GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
  //          GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            GridLab.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
//            GridLab.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

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
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Л01";
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
                //               getDocOct();

                //        ddlEdnNam.SelectedValue = "шт";
            }
            CreateGrid();
        }
        



             void CreateGrid()
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        //------------       чтение уровней дерево
                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("BuxDocSelIdn", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = GlvDocIdn;

                        // создание DataAdapter
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "BuxDocSelIdn");

                        con.Close();

                //        if (ds.Tables[0].Rows.Count > 0)
                //        {
                            GridLab.DataSource = ds;
                            GridLab.DataBind();
                 //       }
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
             }                    

                    // ============================ проверка и опрос для записи документа в базу ==============================================
                    protected void ImpButton_Click(object sender, EventArgs e)
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


                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        // создание команды
                        SqlCommand cmd = new SqlCommand("HspAmbLabUplImp", con);
                        cmd = new SqlCommand("HspAmbLabUplImp", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // создать коллекцию параметров
                        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                        cmd.Parameters.Add("@DOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
                        // создание DataAdapter

                        cmd.ExecuteNonQuery();
                        con.Close();

                        //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
                        //           DataSet ds = new DataSet("AptPrxDocChk");
                        //           ds.Merge(ws.AptPrxDocChk(MdbNam, BuxSid, BuxKod));

                        //           KodErr = Convert.ToString(ds.Tables[0].Rows[0]["KODERR"]);
                        //           Err.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAMERR"]);

                        ConfirmOK.Visible = true;
                        ConfirmOK.VisibleOnLoad = true;

                    }

                    // ============================ одобрение для записи документа в базу ==============================================
                    // ============================ отказ записи документа в базу ==============================================
                    protected void CanButton_Click(object sender, EventArgs e)
                    {
                        Response.Redirect("~/Priem/DocAppLabUpl.aspx?NumSpr=Л01&TxtSpr=БИОХИМЧЕСКИЙ АНАЛИЗАТОР");
                    }
                    // ============================ проводить записи документа в базу ==============================================
                    protected void btnPrvOK_click(object sender, EventArgs e)
                    {
                        localhost.Service1Soap ws = new localhost.Service1SoapClient();
                        ws.AptPrxDocPrv(MdbNam, BuxSid, BuxFrm, GlvDocIdn, BuxKod);
                        Response.Redirect("~/Priem/DocAppLabUpl.aspx?NumSpr=Л01&TxtSpr=БИОХИМЧЕСКИЙ АНАЛИЗАТОР");
                    }

                   // ============================ одобрение для проведения документа в базу ==============================================
 

                    // ============================ проверка и очистка таблицы документа в базе ==============================================
                    protected void ClrButton_Click(object sender, EventArgs e)
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        // ------------ удалить загрузку оператора ---------------------------------------
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        // создание команды
                        SqlCommand cmd = new SqlCommand("DELETE FROM TABDOCDTL WHERE DTLDOCNUM='Л01' AND DTLDOCIDN=" + GlvDocIdn, con);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        CreateGrid();
                    }


                    // ============================ расчет документа ==============================================
                    protected void ChkButton_Click(object sender, EventArgs e)
                    {
                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        // ------------ удалить загрузку оператора ---------------------------------------
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("HspAmbLabUplChk", con);
                        cmd = new SqlCommand("HspAmbLabUplChk", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@DOCIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                        // выполнить
                        cmd.ExecuteNonQuery();

                        con.Close();

                        CreateGrid();
                    }

                    // ============================ загрузка TEXT в базу ==============================================
                    protected void UplButton_Click(object sender, EventArgs e)
                    {
                        
                        string [] MasPol = new string[5000];
                        string Pol="";
                        string TxtFil="";
                        string TxtIin="";
                        string TxtFio = "";
                        string TxtAnl = "";
                        string TxtVal = "";
                        int I=0;
                        int J=0;
                        int N=0;
                        int Nxt=0;
                        long Res;
                        bool IsInt;

                        GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

                        // --------------------------------------------------------------------------------------
                        if (FileUpload1.HasFile)
                        {
                            StreamReader reader = new StreamReader(FileUpload1.FileContent,Encoding.Default);
                            string Stroka = reader.ReadToEnd();

                          //    ----------------------------- запись в массив -------------------------------------------
                            int Dlin = Stroka.Length;
                            int MasInd = 0;
                            while (1 == 1)
                            {
                                 Pol = "";
                                 
                                 for (J=0; J < Dlin;J++)
                                 {
                                     if (Stroka.Substring(J, 1) !=  "\n")
                                          {
                                                Pol = Pol + Stroka.Substring(J, 1);
                                          }
                                     else
                                     {
//                                       I = J + 4;
                                       MasInd = MasInd + 1;
                                       MasPol[MasInd] = Pol.Substring(5, Pol.Length-6); 
                                       Pol = "";
                                     }
                                  }
                                  break;
                            }

                            //       ======================================= ЕСЛИ ЕСТЬ ДАННЫЕ =======================================================
                            if (MasInd > 1)
                            {

                                //       ======================================= УДАЛИТЬ РЕЗУЛЬТАТ =======================================================
                                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                                SqlConnection con = new SqlConnection(connectionString);
                                con.Open();

                                // создание команды
                                SqlCommand cmdDel = new SqlCommand("HspAmbLabUplDel", con);
                                cmdDel = new SqlCommand("HspAmbLabUplDel", con);
                                // указать тип команды
                                cmdDel.CommandType = CommandType.StoredProcedure;
                                // создать коллекцию параметров , передать параметр
                                cmdDel.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                                cmdDel.Parameters.Add("@DOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
                                // создание DataAdapter
                                SqlDataAdapter daDel = new SqlDataAdapter(cmdDel);
                                // ------------------------------------------------------------------------------заполняем первый уровень
                                // передать параметр
                                // ------------------------------------------------------------------------------заполняем второй уровень
                                cmdDel.ExecuteNonQuery();


                                //       ======================================= ОТКРЫТЬ ТАБЛИЦУ =======================================================
                                //          ----------------------------------------------------------------------------------
                                // создание команды
                                SqlCommand cmd = new SqlCommand("HspAmbLabUplAdd", con);
                                cmd = new SqlCommand("HspAmbLabUplAdd", con);
                                // указать тип команды
                                cmd.CommandType = CommandType.StoredProcedure;
                                //        ------------------------------------------------------------------------
                                // создать коллекцию параметров , передать параметр
                                cmd.Parameters.Add("@DOCIDN", SqlDbType.Int, 4);
                                cmd.Parameters.Add("@DTLTYP", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLNUM", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLDAT", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLIIN", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLFIO", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLANL", SqlDbType.VarChar);
                                cmd.Parameters.Add("@DTLVAL", SqlDbType.VarChar);


                                //       ======================================= ЗАПИСАТЬ В ЦИКЛЕ  =======================================================
                                for (J = 1; J <= MasInd; J++)
                                {
                                    TxtIin = "";
                                    TxtFio = "";
                                    TxtAnl = "";
                                    TxtVal = "";

                                    //        -----------ИИН  ФИО------------------------------------------------------------
                                    I = MasPol[J].IndexOf(@", Assay:");
                                    if (I > -1)
                                    {
                                        Pol = MasPol[J].Substring(0, I);
                                        Nxt = J;
                                        //        -----------ИИН------------------------------------------------------------
                                        if (Pol.Length > 11)
                                        {
                                            TxtIin = Pol.Substring(0, 12);
                                            IsInt = long.TryParse(TxtIin, out Res);  // проверка на число 
                                            if (IsInt == true)
                                            {
                                          //      TxtIin = Pol.Substring(0, 12);
                                                TxtFio = Pol.Substring(13, Pol.Length - 13);
                                            }
                                            else
                                            {
                                                TxtIin = "";
                                                TxtFio = Pol;
                                            }
                                        }
                                        else
                                        {
                                            TxtIin = "";
                                            TxtFio = Pol;
                                        }
                                    }
                                    else
                                    {
                                        TxtIin = "";
                                        TxtFio = "Ошибка в стуктуре ИИН";
                                        goto DALSE;
                                    }
                                  
                                    //        -----------АНАЛИЗ------------------------------------------------------------
                                    N = MasPol[J].IndexOf(@"(BioSys)");
                                    if (N > -1)
                                    {
                                        TxtAnl = MasPol[J].Substring(I + 8, N - I - 8);
                                    }
                                    else
                                    {
                                        TxtAnl = "Ошибка в стуктуре анализе";
                                        goto ZAPIS;
                                    }

                                    /*
                                    //        -----------ЗНАЧЕНИЕ АНАЛИЗА ------------------------------------------------------------
                                    N = MasPol[J].IndexOf(@"(BioSys)");
                                    if (N > -1)
                                    {
                                        TxtVal = MasPol[J].Substring(N + 9, MasPol[J].Length - N - 9);
                                    }
                                    else
                                    {
                                        TxtVal = "Ошибка в стуктуре";
                                        goto ZAPIS;
                                    }
                                    */

                                    //        -----------ЗНАЧЕНИЕ АНАЛИЗА ------------------------------------------------------------
                                    N = MasPol[J].IndexOf(@"Conc:");
                                    if (N > -1)
                                    {
                                        TxtVal = MasPol[J].Substring(N + 5, MasPol[J].Length - N - 6);
                                    }
                                    else
                                    {
                                        TxtVal = "Ошибка в стуктуре значений";
                                        goto ZAPIS;
                                    }

                                ZAPIS:
                                    //       ======================================= ЗАПИСАТЬ В БАЗУ  =======================================================
                                    // создать коллекцию параметров , передать параметр

                                    cmd.Parameters["@DOCIDN"].Value = GlvDocIdn;
                                    cmd.Parameters["@DTLTYP"].Value = "Л01";
                                    cmd.Parameters["@DTLDAT"].Value = DOCDAT.Text;
                                    cmd.Parameters["@DTLNUM"].Value = DOCNUM.Text;
                                    cmd.Parameters["@DTLIIN"].Value = TxtIin;
                                    cmd.Parameters["@DTLFIO"].Value = TxtFio;
                                    cmd.Parameters["@DTLANL"].Value = TxtAnl;
                                    cmd.Parameters["@DTLVAL"].Value = TxtVal;
                                    // создание DataAdapter
                                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                                    // ------------------------------------------------------------------------------заполняем первый уровень
                                    // передать параметр
                                    // ------------------------------------------------------------------------------заполняем второй уровень
                                    cmd.ExecuteNonQuery();
                                    //       ======================================= ЗАПИСАТЬ В БАЗУ  =======================================================
                                DALSE:
                                    N = 0;
                                }


                            }

                            CreateGrid();

                    }
                 }

                    void UpdateRecord(object sender, GridRecordEventArgs e)
                    {
                        string TxtIin = "";
                        string TxtFio = "";
                        string TxtAnl = "";
                        string TxtVal = "";
                        int DtlIdn;

                        DtlIdn = Convert.ToInt32(e.Record["DTLIDN"]);


                        if (e.Record["DTLNOMNUM"] == null | e.Record["DTLNOMNUM"] == "") TxtIin = "";
                        else TxtIin = Convert.ToString(e.Record["DTLNOMNUM"]);

                        if (e.Record["DTLNUMIZG"] == null | e.Record["DTLNUMIZG"] == "") TxtFio = "";
                        else TxtFio = Convert.ToString(e.Record["DTLNUMIZG"]);

                        if (e.Record["DTLNAM"] == null | e.Record["DTLNAM"] == "") TxtAnl = "";
                        else TxtAnl = Convert.ToString(e.Record["DTLNAM"]);

                        if (e.Record["DTLMEM"] == null | e.Record["DTLMEM"] == "") TxtVal = "";
                        else TxtVal = Convert.ToString(e.Record["DTLMEM"]);

                        //------------       чтение уровней дерево
                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("HspAmbLabUplRep", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = DtlIdn;
                        cmd.Parameters.Add("@DTLIIN", SqlDbType.VarChar).Value = TxtIin;
                        cmd.Parameters.Add("@DTLFIO", SqlDbType.VarChar).Value = TxtFio;
                        cmd.Parameters.Add("@DTLANL", SqlDbType.VarChar).Value = TxtAnl;
                        cmd.Parameters.Add("@DTLVAL", SqlDbType.VarChar).Value = TxtVal;

                        // создание команды
                        cmd.ExecuteNonQuery();
                        con.Close();


                        CreateGrid();
                    }

               // ============================ конец текста ==============================================
       }
    }   


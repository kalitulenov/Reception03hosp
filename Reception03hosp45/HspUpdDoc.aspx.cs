using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;

namespace Reception03hosp45
{
    public partial class HspUpdDoc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // ======================================================================================
        [WebMethod]
        public static bool UpdateOrder(string DatDocMdb, string SqlStr, string DatDocTyp)
        {
            string[] MasPar = SqlStr.Split('&');
            int MasDln = MasPar.GetLength(0);

            if (!string.IsNullOrEmpty(SqlStr))
            {
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings[DatDocMdb].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();


                // ------------ SQL  ---------------------------------------
                if (DatDocTyp == "Sql")
                {
                    SqlCommand cmdSql = new SqlCommand(SqlStr, con);
                    cmdSql.ExecuteNonQuery();
                }

                // ------------ Хранимая процедура ---------------------------------------
                if (DatDocTyp == "Str")
                {

                    SqlCommand cmdStr = new SqlCommand(MasPar[0], con);
                    cmdStr.CommandType = CommandType.StoredProcedure;
                    // создать коллекцию параметров
                    if (MasDln > 1) cmdStr.Parameters.Add(MasPar[1], SqlDbType.VarChar).Value = MasPar[2];
                    if (MasDln > 3) cmdStr.Parameters.Add(MasPar[3], SqlDbType.VarChar).Value = MasPar[4];
                    if (MasDln > 5) cmdStr.Parameters.Add(MasPar[5], SqlDbType.VarChar).Value = MasPar[6];
                    if (MasDln > 7) cmdStr.Parameters.Add(MasPar[7], SqlDbType.VarChar).Value = MasPar[8];
                    if (MasDln > 9) cmdStr.Parameters.Add(MasPar[9], SqlDbType.VarChar).Value = MasPar[10];

                    cmdStr.ExecuteNonQuery();
                }

   //             SqlCommand cmd = new SqlCommand(SqlStr, con);
  //              cmd.ExecuteNonQuery();
                con.Close();
                return true;


            }
            else return false;
       }

        // ======================================================================================
        [WebMethod]
        public static string SelectOrder(string DatDocMdb, string SqlStr)
        {
            string Result;
            if (!string.IsNullOrEmpty(SqlStr))
            {
                DataSet ds = new DataSet();
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings[DatDocMdb].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();
                // ------------ SQL  ---------------------------------------
                SqlCommand cmdSql = new SqlCommand(SqlStr, con);
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmdSql);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "SelOrd");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Result = Convert.ToString(ds.Tables[0].Rows[0][0]);
                }
                else Result = "";
                // -----------закрыть соединение --------------------------
                ds.Dispose();
                con.Close();

                return Result;
            }
            else return "";
        }

        // ======================================================================================
        [WebMethod]
        public static string Translate(string DatDocMdb, string TxtRus, string DatDocIdn)
        {
            string Result;
            if (!string.IsNullOrEmpty(TxtRus))
            {
                DataSet ds = new DataSet();
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings[DatDocMdb].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();
                // ------------ SQL  ---------------------------------------
                SqlCommand cmdSql = new SqlCommand("HspLekRusLat", con);
                cmdSql.CommandType = CommandType.StoredProcedure;

                cmdSql.Parameters.Add("@DOCAMB", SqlDbType.VarChar).Value = DatDocIdn;
                cmdSql.Parameters.Add("@LEKNAMRUS", SqlDbType.VarChar).Value = TxtRus;

                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmdSql);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "TxtLat");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Result = Convert.ToString(ds.Tables[0].Rows[0][0]);
                }
                else Result = "";
                // -----------закрыть соединение --------------------------
                ds.Dispose();
                con.Close();

                return Result;
            }
            else return "";
        }

        // ============================ чтение заголовка таблицы а оп ==============================================

        [WebMethod]
        public static bool BuxUpdateDeb(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {

                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrmDocDebPay", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = MasLst[2];
                cmd.Parameters.Add("@MATKOD", SqlDbType.Int, 4).Value = Convert.ToInt32(MasLst[3]);
                cmd.Parameters.Add("@MATDOCNUM", SqlDbType.VarChar).Value = MasLst[4];
                cmd.Parameters.Add("@MATDOCIDN", SqlDbType.Int, 4).Value = Convert.ToInt32(MasLst[5]);
                cmd.Parameters.Add("@MATZEN", SqlDbType.Decimal).Value = MasLst[6];
                cmd.Parameters.Add("@MATKOL", SqlDbType.Decimal).Value = MasLst[7];
                cmd.Parameters.Add("@MATPAY", SqlDbType.Decimal).Value = MasLst[8];
                cmd.Parameters.Add("@MATDEB", SqlDbType.VarChar).Value = MasLst[9];
                cmd.Parameters.Add("@MATDEBSPR", SqlDbType.Int, 4).Value = Convert.ToInt32(MasLst[10]);
                cmd.Parameters.Add("@MATDEBSPRVAL", SqlDbType.VarChar).Value = MasLst[11];
                cmd.Parameters.Add("@MATKRD", SqlDbType.VarChar).Value = MasLst[12];
                cmd.Parameters.Add("@MATKRDSPR", SqlDbType.Int, 4).Value = Convert.ToInt32(MasLst[13]);
                cmd.Parameters.Add("@MATKRDSPRVAL", SqlDbType.Int, 4).Value = Convert.ToInt32(MasLst[14]);


                //           cmd.Parameters.Add("@MDVIDN", SqlDbType.Int, 4).Value = 0;
                //           cmd.Parameters["@MDVIDN"].Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;
        }


        // ============================ чтение заголовка таблицы а оп ==============================================

        [WebMethod]
        public static bool BuxUpdateKrd(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrmDocKrdPay", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@MATIDN", SqlDbType.Int, 4).Value = MasLst[1];
                cmd.Parameters.Add("@MATDOCIDN", SqlDbType.Int, 4).Value = MasLst[2];
                cmd.Parameters.Add("@MATKOL", SqlDbType.Decimal).Value = MasLst[3];
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;
        }

          /*------------------------- при нажатии на поле текст --------------------------------*/
 
      //            var ParStr =  document.getElementById('parBuxFrm').value + ':' + document.getElementById('parBuxKod').value + 
      //                          ':Прм:' + document.getElementById('parDocIdn').value + ':' + TekPrxIdn + ':' + TekAccKrd + ':1:' + TekMolKrd;

       [WebMethod]
       public static bool BuxUpdatePrm(string ParStr)
        {
            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrmDocAddPrx", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = MasLst[2];
                cmd.Parameters.Add("@PRXIDN", SqlDbType.VarChar).Value = MasLst[3];
                cmd.Parameters.Add("@MATKRD", SqlDbType.VarChar).Value = MasLst[4];
                cmd.Parameters.Add("@MATKRDSPR", SqlDbType.VarChar).Value = MasLst[5];
                cmd.Parameters.Add("@MATKRDSPRVAL", SqlDbType.VarChar).Value = MasLst[6];
                
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;

        }

//       =======================================  по счету определить аналитику (номер справочника =======================================================
       [WebMethod]
       public static string BuxAccKodSpr(string ParStr)
       {
           //  List<string> SprUsl = new List<string>();

           string[] MasLst = ParStr.Split(':');


           if (!string.IsNullOrEmpty(ParStr))
           {

               // создание DataSet.
               DataSet ds = new DataSet();
               // строка соединение
               string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
               // создание соединение Connection
               SqlConnection con = new SqlConnection(connectionString);
               // создание команды
               SqlCommand cmd = new SqlCommand("BuxAccKodSpr", con);
               // указать тип команды
               cmd.CommandType = CommandType.StoredProcedure;
               // передать параметр
               cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = MasLst[0];
               cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[1];
               cmd.Parameters.Add("@BUXACC", SqlDbType.VarChar).Value = MasLst[2];
               cmd.Parameters.Add("@BUXIDN", SqlDbType.VarChar).Value = MasLst[3];
               con.Open();
               // создание DataAdapter
               // создание DataAdapter
               SqlDataAdapter da = new SqlDataAdapter(cmd);
               // заполняем DataSet из хран.процедуры.
               da.Fill(ds, "BuxAccKodSpr");

               con.Close();

               if (ds.Tables[0].Rows.Count > 0)
               {
                   return Convert.ToString(ds.Tables[0].Rows[0][0]) + ":" + Convert.ToString(ds.Tables[0].Rows[0][1]) + ":" + Convert.ToString(ds.Tables[0].Rows[0][2]);
               }
               else return "0:0:0";
           }
           else return "0:0:0";
       }



       //       =======================================  изменение ИИН =======================================================
       [WebMethod]
       public static bool HspSprKltIinMrg(string ParStr)
       {
           //  List<string> SprUsl = new List<string>();

           string[] MasLst = ParStr.Split(':');


           if (!string.IsNullOrEmpty(ParStr))
           {
               // создание DataSet.
               DataSet ds = new DataSet();
               // строка соединение
               string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
               // создание соединение Connection
               SqlConnection con = new SqlConnection(connectionString);
               con.Open();
               // создание команды
               SqlCommand cmd = new SqlCommand("HspSprKltIinMrg", con);
               // указать тип команды
               cmd.CommandType = CommandType.StoredProcedure;
               // передать параметр
   //            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[0];
               cmd.Parameters.Add("@IINOLD", SqlDbType.VarChar).Value = MasLst[0];
               cmd.Parameters.Add("@IINNEW", SqlDbType.VarChar).Value = MasLst[1];

               cmd.ExecuteNonQuery();
               con.Close();
               return true;
           }
           else return false;
       }



        // =================================================================================================================================================
        [WebMethod]
        public static List<string> RefGetSprDoc(string DlgFrm)
        {
            List<string> SprDoc = new List<string>();

            string[] MasLst = DlgFrm.Split(':');
            int MasDln = MasLst.GetLength(0);

            if (!string.IsNullOrEmpty(DlgFrm))
            {
                string SqlStr;
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды

                SqlCommand cmd = new SqlCommand("SELECT BuxKod,FIO FROM SprBuxKdr " +
                                                "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + MasLst[0] + " AND BuxFrm=" + MasLst[1] + " ORDER BY FIO", con);
                // указать тип команды
                //   cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                //    cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = MasLst[0];
                // создание команды

                con.Open();

                SqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    SprDoc.Add(myReader.GetString(1));                    // текст
                    SprDoc.Add(Convert.ToString( myReader.GetInt32(0)));  // значения
                }

                con.Close();
            }

            return SprDoc;
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static bool RefZapTekTim(string SndPar)
        {

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                // ===================== записать в базу ================================================================================
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();

                SqlCommand cmd = new SqlCommand("HspDocGrfWrtNow", con);
                cmd = new SqlCommand("HspDocGrfWrtNow", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр

                cmd.Parameters.Add("@GRFFRM", SqlDbType.VarChar).Value = MasLst[0];   //BuxFrm;
                cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = MasLst[1];   //BuxKod;
                cmd.Parameters.Add("@GRFKOD", SqlDbType.Int, 4).Value = MasLst[2];    //GrfKod;
                cmd.Parameters.Add("@GRFPTH", SqlDbType.VarChar).Value = MasLst[3];   //HidTextBoxFio.Value;
                cmd.Parameters.Add("@GRFIIN", SqlDbType.VarChar).Value = MasLst[4];   //HidTextBoxIin.Value;
                cmd.Parameters.Add("@GRFTEL", SqlDbType.VarChar).Value = MasLst[5];   //HidTextBoxTel.Value;
                cmd.Parameters.Add("@GRFBRT", SqlDbType.VarChar).Value = MasLst[6];   // 
                cmd.Parameters.Add("@GRFPOL", SqlDbType.VarChar).Value = MasLst[7];   //дата после которой идет запись
                cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = MasLst[8];   //HidCntIdn.Value;

                // Выполнить команду
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static bool RefZapTekTim086(string SndPar)
        {

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                // ===================== записать в базу ================================================================================
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();

                SqlCommand cmd = new SqlCommand("HspDocGrfWrtNow086", con);
                cmd = new SqlCommand("HspDocGrfWrtNow086", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр

                cmd.Parameters.Add("@GRFFRM", SqlDbType.VarChar).Value = MasLst[0];   //BuxFrm;
                cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = MasLst[1];   //BuxKod;
                cmd.Parameters.Add("@GRFTYP", SqlDbType.VarChar).Value = MasLst[2];    //GrfKod;
                cmd.Parameters.Add("@GRFPTH", SqlDbType.VarChar).Value = MasLst[3];   //HidTextBoxFio.Value;
                cmd.Parameters.Add("@GRFIIN", SqlDbType.VarChar).Value = MasLst[4];   //HidTextBoxIin.Value;
                cmd.Parameters.Add("@GRFTEL", SqlDbType.VarChar).Value = MasLst[5];   //HidTextBoxTel.Value;
                cmd.Parameters.Add("@GRFBRT", SqlDbType.VarChar).Value = MasLst[6];   //HidTextBoxBrt.Value;
                cmd.Parameters.Add("@GRFPOL", SqlDbType.VarChar).Value = MasLst[7];   //HidTextBoxKrt.Value;
                cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = MasLst[8];   //HidCntIdn.Value;

                // Выполнить команду
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static string BuxPltOneKrd(string ParStr)
        {
            string[] MasLst = ParStr.Split(':');

            if (!string.IsNullOrEmpty(ParStr))
            {

                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPltOneKrd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@BNKKOD", SqlDbType.VarChar).Value = MasLst[1];
                con.Open();
                // создание DataAdapter
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "BuxPltOneKrd");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds.Tables[0].Rows[0][0]) + ":" + 
                           Convert.ToString(ds.Tables[0].Rows[0][1]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][2]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][3]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][4]);
                }
                else return "0:0:0:0:0";
            }
            else return "0:0:0:0:0";
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static string BuxPltOneDeb(string ParStr)
        {
            string[] MasLst = ParStr.Split(':');

            if (!string.IsNullOrEmpty(ParStr))
            {

                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPltOneDeb", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@ORGKOD", SqlDbType.VarChar).Value = MasLst[0];
                con.Open();
                // создание DataAdapter
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "BuxPltOneDeb");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds.Tables[0].Rows[0][0]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][1]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][2]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][3]) + ":" +
                           Convert.ToString(ds.Tables[0].Rows[0][4]);
                }
                else return "0:0:0:0:0";
            }
            else return "0:0:0:0:0";
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static string DocAppAmbOsmMkb(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split('@');


            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprMkbSel", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@MKBNUM", SqlDbType.Int,4).Value = "1";
                cmd.Parameters.Add("@MKB001", SqlDbType.VarChar).Value = MasLst[3];
                cmd.Parameters.Add("@MKB002", SqlDbType.VarChar).Value = MasLst[4];
                cmd.Parameters.Add("@MKB003", SqlDbType.VarChar).Value = MasLst[5];
                con.Open();
                // создание DataAdapter
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "HspSprMkbSel");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds.Tables[0].Rows[0]["MKBNAM"]);
                }
                else return "";
            }
            else return "";
        }

        // =================================================================================================================================================
        [WebMethod]
        public static List<string> GetSprDlg(string SndPar)
        {
            List<string> SprDlg = new List<string>();

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                string SqlStr;
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды

                SqlCommand cmd = new SqlCommand("SELECT SprDlg.DLGKOD, dbo.SprDlg.DLGNAM " +
                                                "FROM SprSttRsp INNER JOIN SprDlg ON SprSttRsp.SttRspDlg=SprDlg.DLGKOD " +
                                                "WHERE SprSttRsp.SttRspFrm=" + MasLst[1] + " AND SprSttRsp.SttRspKey='" + MasLst[0] + "' ORDER BY DLGNAM", con);
                // указать тип команды
                //  cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                //   cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = MasLst[2];
                //   cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = MasLst[1];
                //   cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = MasLst[0];
                // создание команды

                con.Open();

                SqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    SprDlg.Add(myReader.GetString(1));                    // текст
                    SprDlg.Add(Convert.ToString(myReader.GetInt32(0)));  // значения
                }

                con.Close();
            }

            return SprDlg;
        }


        // =================================================================================================================================================
        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static bool HspSttPrtErrGnr(string SndPar)
        {

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                // ===================== записать в базу ================================================================================
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();

                SqlCommand cmd = new SqlCommand("HspSttPrtErrGnr", con);
                cmd = new SqlCommand("HspSttPrtErrGnr", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр

                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[0];       //BuxFrm;
                cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = MasLst[1];    
                cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = MasLst[2];

                // Выполнить команду
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;
        }

        // =================================================================================================================================================
        [WebMethod]
        public static List<string> GetSprStxUsl(string SndPar)
        {
            List<string> SprUsl = new List<string>();

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                string SqlStr;
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                 con.Open();

                SqlCommand cmd = new SqlCommand("HspAmbUslKodSou", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
//                cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = MasLst[2];
//                cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = MasLst[1];
//                cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = MasLst[0];

                cmd.Parameters.Add("@BUXFRMKOD", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = MasLst[2];
                cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@AMBCRDIDN", SqlDbType.VarChar).Value = MasLst[3];
                cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = "";
                // создание команды

                SqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    SprUsl.Add(myReader.GetString(1));                    // текст
                    SprUsl.Add(Convert.ToString(myReader.GetInt32(0)));  // значения
                }

                con.Close();
            }

            return SprUsl;
        }

        // =================================================================================================================================================
        [WebMethod]
        public static List<string> GetSprGrpUsl(string SndPar)
        {
            List<string> SprUsl = new List<string>();

            string[] MasLst = SndPar.Split(':');


            if (!string.IsNullOrEmpty(SndPar))
            {
                string SqlStr;
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                con.Open();
                /*
                SqlCommand cmd = new SqlCommand("SELECT SprUsl.UslKod,SprUsl.UslNamFul as UslNam " +
                       "FROM SprUsl INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                                   "INNER JOIN SprPrc ON SprUslFrm.UslFrmPrc=SprPrc.PrcKod " +
                       "WHERE SprUslFrm.UslFrmHsp=" + MasLst[1] + " AND LEFT(SprPrc.PrcNam, 6)='платно' AND SprUslFrm.UslFrmZen>0 AND SprUsl.UslKey001='" + MasLst[0] +
                       "' ORDER BY SprUsl.UslNamFul", con);
                */
                SqlCommand cmd = new SqlCommand("SELECT SprUsl.UslKod,SprUsl.UslNamFul as UslNam " +
                      "FROM SprUsl INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                      "WHERE SprUslFrm.UslFrmHsp=" + MasLst[1] + " AND SprUsl.UslPrc=1 AND SprUslFrm.UslFrmZen>0 AND SprUsl.UslKey001='" + MasLst[0] +
                      "' ORDER BY SprUsl.UslNamFul", con);
                // указать тип команды
                //cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр

                SqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                   SprUsl.Add(myReader.GetString(1));                    // текст
                   SprUsl.Add(Convert.ToString(myReader.GetInt32(0)));  // значения
                }

                con.Close();
            }

            return SprUsl;
        }

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static string BuxKasPrxDatDoc(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split('@');
            string OutPar = "";

            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды

                SqlCommand cmd = new SqlCommand("SELECT GRFKOD,FIO " +
                                                "FROM SprCabDoc INNER JOIN SprBuxKdr ON SprCabDoc.GrfKod=SprBuxKdr.BuxKod " +
                                                "WHERE SprCabDoc.GrfHsp=" + MasLst[0] + " AND SprCabDoc.GrfCab='" + MasLst[1] + "'", con);
                // указать тип команды

                con.Open();

                OutPar = "";
                SqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    OutPar = Convert.ToString(myReader.GetInt32(0)) + ";" + myReader.GetString(1);
                }
                return OutPar;

                con.Close();
            }
            else return "";
        }


        // var ParStr = DatDocIdn + ':' + DatDocFrm + ':' + DatDocCnt + ':' + DatDocKod + ':' + dataField + ':' + DatDocVal + ':';

        [WebMethod]
        public static bool HspSprCntUslWrt(string ParStr)
        {
            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprCntUslWrt", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXIDN", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@BUXCNTKEY", SqlDbType.VarChar).Value = MasLst[2];
                cmd.Parameters.Add("@BUXPRCKOD", SqlDbType.VarChar).Value = MasLst[3];
                cmd.Parameters.Add("@BUXREK", SqlDbType.VarChar).Value = MasLst[4];
                cmd.Parameters.Add("@BUXVAL", SqlDbType.VarChar).Value = MasLst[5];
                cmd.Parameters.Add("@BUXZEN", SqlDbType.VarChar).Value = MasLst[6];

                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;

        }

            // =================================================================================================================================================
    [WebMethod]
    public static string GetSprMat(string SndPar)
    {
        //  List<string> SprMat = new List<string>();

        //   string[] MasLst = StxKod.Split(':');
        string SprMat="";


        if (!string.IsNullOrEmpty(SndPar))
        {
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT TABMAT.*,SPRGRPMAT.GRPMATNAM FROM TABMAT LEFT OUTER JOIN SPRGRPMAT ON TABMAT.MATGRP = SPRGRPMAT.GRPMATKOD WHERE MATKOD=" + SndPar, con);
            con.Open();
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "GetDocNum");

            if (ds.Tables[0].Rows.Count > 0)
            {
                SprMat = Convert.ToString(ds.Tables[0].Rows[0]["MATKOD"])+ "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["MATNAM"]) + "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["MATEDN"]) + "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["MATZEN"]) + "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["MATUPK"]) + "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["MATPRZ"]) + "&" + 
                         Convert.ToString(ds.Tables[0].Rows[0]["GRPMATNAM"]);
            }


            con.Close();
        }

        return SprMat;
    }


        // ======================================================================================
        [WebMethod]
        public static bool SendSms(string PolTel, string SmsTxt)
        {
            //       string SmsKod;
            //       int TelInt;
            //are required fields filled in:
            if (PolTel == "")
            {
                return false;
            }

            //         Random random = new Random();
            //         SmsKod = Convert.ToInt32(random.Next(9999)).ToString("D4");

            //we creating the necessary URL string:
            string ozSURL = "http://212.124.121.186"; //where the SMS Gateway is running
            string ozSPort = "9501"; //port number where the SMS Gateway is listening
            string ozUser = HttpUtility.UrlEncode("dauasoft"); //username for successful login
            string ozPassw = HttpUtility.UrlEncode("EJwHTLWSB"); //user's password
            string ozMessageType = "SMS:TEXT"; //type of message
            string ozRecipients = HttpUtility.UrlEncode(PolTel); //who will get the message
            string ozMessageData = HttpUtility.UrlEncode(SmsTxt); //body of message

            string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                "?action=sendMessage" +
                "&username=" + ozUser +
                "&password=" + ozPassw +
                "&messageType=" + ozMessageType +
                "&recipient=" + ozRecipients +
                "&messageData=" + ozMessageData;

            try
            {

                //Create the request and send data to the SMS Gateway Server by HTTP connection
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                //Get response from the SMS Gateway Server and read the answer
                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                string responseString = respStreamReader.ReadToEnd();
                respStreamReader.Close();
                myResp.Close();

                return true;

                //inform the user
                //         textboxError.Text = responseString;
                //         textboxError.Visible = true;
            }
            catch (Exception)
            {
                return false;
            }


        }


        // =================================================================================================================================================

        [WebMethod]
        public static bool HspDocAppLabRegUslWrt(string ParStr)
        {
            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                // создание команды
                SqlCommand cmd = new SqlCommand("HspDocAppLabRegUslWrt", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@USLMEM", SqlDbType.VarChar).Value = MasLst[2];

                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            else return false;

        }

        // =================================================================================================================================================
        [WebMethod]
        public static string CndAmbCrdAmbUsl(string SndPar)
        {
            string CndVal = "No";

            if (!string.IsNullOrEmpty(SndPar))
            {
                DataSet ds = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("SELECT AMBUSL.USLIDN FROM AMBCRD INNER JOIN AMBUSL ON AMBCRD.GrfIdn=AMBUSL.USLAMB WHERE AMBCRD.GrfIdn=" + SndPar, con);
                con.Open();
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "AmbCrdAmbUsl");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    CndVal = "Yes";
                }
                con.Close();
            }

            return CndVal;
        }

        //       ======================================= Обнулить БОЛ.ЛИСТ =======================================================
        [WebMethod]
        public static string BuxBolLstOneClr(string Id)
        {
            if (!string.IsNullOrEmpty(Id))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды

                SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLPTH=NULL,BOLBRT=NULL,BOLADR=NULL,BOLRAB=NULL,BOLDIG=NULL," +
                                                "BOLAMB=NULL,BOLIIN=NULL,BOLSTX=NULL,BOLBUX=NULL,BOLEXTFLG=NULL," +
                                                "BOLDOC000=NULL,BOLBEG000=NULL,BOLEND000=NULL,BOLDOC001=NULL,BOLEND001=NULL," +
                                                "BOLDOC002=NULL,BOLEND002=NULL,BOLDOC003=NULL,BOLEND003=NULL," +
                                                "BOLDOC009=NULL,BOLEND009=NULL " +
                                                "WHERE BOLIDN=" + Id, con);
              //  SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLMEM='TEST' WHERE BOLIDN=" + Id, con);
                // указать тип команды

                con.Open();

                cmd.ExecuteNonQuery();

                con.Close();

                return "";
            }
            else return "";
        }

        //       ======================================= УДАЛИТЬ БОЛ.ЛИСТ =======================================================
        [WebMethod]
        public static string BuxBolLstOneDel(string Id)
        {
            if (!string.IsNullOrEmpty(Id))
            {
                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                // ------------ удалить загрузку оператора ---------------------------------------
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды

                SqlCommand cmd = new SqlCommand("DELETE FROM AMBBOL WHERE BOLIDN=" + Id, con);
                // указать тип команды

                con.Open();

                cmd.ExecuteNonQuery();

                con.Close();

                return "";
            }
            else return "";
        }
        // =================================================================================================================================================

        //       =======================================  по счету определить аналитику (номер справочника =======================================================
        [WebMethod]
        public static string EodLstGrdOneNum(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {

                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("EodGetDocNum", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@EODIDN", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@EODTYP", SqlDbType.VarChar).Value = MasLst[1];
                con.Open();
                // создание DataAdapter
                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "EodGetDocNum");

                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds.Tables[0].Rows[0][0]) + ":" + Convert.ToString(ds.Tables[0].Rows[0][1]);
                }
                else return " :1";
            }
            else return " :1";
        }


    }
}


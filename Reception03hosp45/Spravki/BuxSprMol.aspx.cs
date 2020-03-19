using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using Obout.Interface;
using System.Web.Configuration;
using System.Collections;   // для Hashtable

using System.Web.Services;

namespace Reception03hosp45.Spravki
{
    public partial class BuxSprMol : System.Web.UI.Page
    {
        string ComPriOpr = "";
        int MolIdn;
        int MolKod;
        int MolTab;
        int MolOtd;
        bool MolUbl;

        string BuxFrm;
        string BuxSid;
        string MdbNam = "HOSPBASE";


        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            sds1.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sds1.SelectCommand = "SELECT BUXKOD AS MOLTAB,FIO FROM SprBuxKdr WHERE BUXFRM='" + BuxFrm + "' ORDER BY FIO";

            sds2.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
//            sds2.SelectCommand = "SELECT OTDKOD AS MOLOTD,OTDNAM AS NAM FROM SPROTD  WHERE OTDFRM='" + BuxFrm + "' ORDER BY OTDNAM";
            sds2.SelectCommand = "SELECT STTSTRKOD AS MOLOTD,STTSTRNAM AS NAM  FROM SPRDEP WHERE STTSTRFRM=" + BuxFrm + "  ORDER BY STTSTRNAM";

            GridMol.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridMol.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            GridMol.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            // =====================================================================================
            //===================================================================================================
            //-------------------------------------------------------
            if (!Page.IsPostBack)
            {

                getGrid();

                Session.Add("ComMolKod", 0);
                Session.Add("ComPriOpr", "");
            }
            else
            {
                ComPriOpr = (string)Session["ComPriOpr"];
                if (ComPriOpr == "add") getGrid();

            }

        }

        //===========================================================================================================
        // Create the methods that will load the data into the templates

        //------------------------------------------------------------------------

        // ============================ первая таблица ==============================================
        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();

        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            MolTab = Convert.ToInt32(e.Record["MolTab"]);
            MolOtd = Convert.ToInt32(e.Record["MolOtd"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprMolAdd(MdbNam, BuxSid, BuxFrm, MolTab, MolOtd);
            getGrid();
        }


        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            MolIdn = Convert.ToInt32(e.Record["MolIdn"]);
            MolTab = Convert.ToInt32(e.Record["MolTab"]);
            MolOtd = Convert.ToInt32(e.Record["MolOtd"]);
            MolUbl = Convert.ToBoolean(e.Record["MolUbl"]);
  //          MolLog = Convert.ToString(e.Record["MolLog"]);
  //          MolPsw = Convert.ToString(e.Record["MolPsw"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprMolRep(MdbNam, BuxSid, MolIdn, MolTab, MolOtd, MolUbl);
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            MolIdn = Convert.ToInt32(e.Record["MolIdn"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprMolDel(MdbNam, BuxSid, MolIdn);
            getGrid();

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("SprMol");

            ds.Merge(ws.ComSprMol(MdbNam, BuxSid, BuxFrm));
            GridMol.DataSource = ds;
            GridMol.DataBind();
        }



        // ====================================после удаления ============================================
        private string getPostBackControlName()
        {
            string PostBackerID = Request.Form.Get(Page.postEventSourceID);
            string PostBackerArg = Request.Form.Get(Page.postEventArgumentID);

            getGrid();


            return "";
        }

        //================== удаление строк из SPRMol ===============================================================

        [WebMethod]
        public static bool DeleteRecordJava(string MolIdn)
        {
            string MdbNam = "HOSPBASE";

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRMol WHERE MolIDN=@MolIDN", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@MolIDN", SqlDbType.Int, 4).Value = MolIdn;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

   //         cmd.CommandType = CommandType.Text;
   //         cmd.CommandText = "DELETE FROM SPRMolMNU WHERE MolKOD=@MolKOD";

   //         cmd.ExecuteNonQuery();
            con.Close();

            HttpContext.Current.Session["ComPriOpr"] = "add";

            return true;
        }


        //===========================================================================================================



    }
}

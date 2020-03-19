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
    public partial class BuxSprOrg : System.Web.UI.Page
    {
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        int OrgKod;
        string OrgNam;
        string OrgNamShr;
        string OrgAdr;
        string OrgBin;
        string OrgBik;
        string OrgIik;
        string OrgNdc;
        string OrgKnp;
        string OrgLat;
        string OrgLng;
        string OrgDogNum;
        string OrgDogPnt;
        string OrgRukFio;
        string OrgBuxFio;


        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            GridOrg.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridOrg.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridOrg.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            getGrid();
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
          /*
            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM SPRORG ORDER BY ORGNAM", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprOrg");
            GridOrg.DataSource = ds;
            GridOrg.DataBind();

            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();
            */

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("SprOrg");

            ds.Merge(ws.ComSprOrg(MdbNam, BuxSid, BuxFrm));

            GridOrg.DataSource = ds;
            GridOrg.DataBind();

        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            //  OrgKod = Convert.ToInt32(e.Record["ORGKOD"]);
            OrgNam = Convert.ToString(e.Record["ORGNAM"]);
            OrgNamShr = Convert.ToString(e.Record["ORGNAMSHR"]);
            OrgAdr = Convert.ToString(e.Record["ORGADR"]);
            OrgBin = Convert.ToString(e.Record["ORGBIN"]);
            OrgBik = Convert.ToString(e.Record["ORGBIK"]);
            OrgIik = Convert.ToString(e.Record["ORGIIK"]);
            OrgNdc = Convert.ToString(e.Record["ORGNDC"]);
            OrgKnp = Convert.ToString(e.Record["ORGKNP"]);
            OrgLat = "";
            OrgLng = "";
            OrgDogNum = Convert.ToString(e.Record["ORGDOGNUM"]);
            OrgDogPnt = Convert.ToString(e.Record["ORGDOGPNT"]);
            OrgRukFio = Convert.ToString(e.Record["ORGRUKFIO"]);
            OrgBuxFio = Convert.ToString(e.Record["ORGBUXFIO"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprOrgAdd(MdbNam, BuxSid, BuxFrm, OrgNam, OrgNamShr, OrgAdr, OrgBin, OrgBik, OrgIik, OrgNdc, OrgKnp, OrgLat, OrgLng, OrgDogNum, OrgDogPnt, OrgRukFio, OrgBuxFio);
            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            OrgKod = Convert.ToInt32(e.Record["ORGKOD"]);
            OrgNam = Convert.ToString(e.Record["ORGNAM"]);
            OrgNamShr = Convert.ToString(e.Record["ORGNAMSHR"]);
            OrgAdr = Convert.ToString(e.Record["ORGADR"]);
            OrgBin = Convert.ToString(e.Record["ORGBIN"]);
            OrgBik = Convert.ToString(e.Record["ORGBIK"]);
            OrgIik = Convert.ToString(e.Record["ORGIIK"]);
            OrgNdc = Convert.ToString(e.Record["ORGNDC"]);
            OrgKnp = Convert.ToString(e.Record["ORGKNP"]);
            OrgLat = "";
            OrgLng = "";
            OrgDogNum = Convert.ToString(e.Record["ORGDOGNUM"]);
            OrgDogPnt = Convert.ToString(e.Record["ORGDOGPNT"]); 
            OrgRukFio = Convert.ToString(e.Record["ORGRUKFIO"]);
            OrgBuxFio = Convert.ToString(e.Record["ORGBUXFIO"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprOrgRep(MdbNam, BuxSid, OrgKod, OrgNam, OrgNamShr, OrgAdr, OrgBin, OrgBik, OrgIik, OrgNdc, OrgKnp, OrgLat, OrgLng, OrgDogNum, OrgDogPnt, OrgRukFio, OrgBuxFio);
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            OrgKod = Convert.ToInt32(e.Record["ORGKOD"]);
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprOrgDel(MdbNam, BuxSid, OrgKod);
            getGrid();
        }

    }
}

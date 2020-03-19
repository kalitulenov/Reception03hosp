using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Obout.Grid;
using System.Web.Configuration;


namespace Reception03hosp45.Spravki
{
    public partial class Spr000 : System.Web.UI.Page
    {

        Grid GridSpr = new Grid();

        string BuxSid;


        string NumSpr;
        string TxtSpr;

        int KodSpr;
        string NamSpr;
        int IdnSpr;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            
            NumSpr=(string)Request.QueryString["NumSpr"];
            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            GridSpr.ID = "GridSpr";
            GridSpr.CallbackMode = true;
            GridSpr.Serialize = true;
            GridSpr.AutoGenerateColumns = false;

            GridSpr.FolderStyle = "~/Styles/Grid/style_5";
            GridSpr.AllowFiltering = true;
            GridSpr.ShowLoadingMessage = true;
            GridSpr.FolderLocalization = "~/Localization";
            GridSpr.Language = "ru";

 //           GridSpr.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            GridSpr.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridSpr.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridSpr.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //          GridSpr.Rebind += new Obout.Grid.Grid.DefaultEventHandler(RebindGrid);

            //------------------------------------------------------------------------  
            // creating the columns
            Column oCol1 = new Column();
            oCol1.DataField = "SPRIDN";
            oCol1.HeaderText = "Идн";
            oCol1.ReadOnly = true;
            oCol1.Visible= false;

            Column oCol2 = new Column();
            oCol2.DataField = "SPRKOD";
            oCol2.HeaderText = "Код";
            oCol2.Width = "100";

            Column oCol3 = new Column();
            oCol3.DataField = "SPRNAM";
            oCol3.HeaderText = "Наименование";
            oCol3.Width = "500";

            Column oCol4 = new Column();
            oCol4.HeaderText = "Операции";
            oCol4.Width = "100";
            oCol4.AllowEdit = true;
            oCol4.AllowDelete = true;

            // add the columns to the Columns collection of the grid
            GridSpr.Columns.Add(oCol1);
            GridSpr.Columns.Add(oCol2);
            GridSpr.Columns.Add(oCol3);
            GridSpr.Columns.Add(oCol4);
            GridSpr.PageSize = 25;
            phGridSpr.Controls.Add(GridSpr);
            //=====================================================================================
 //           if (Session["BuxSid"] == null) Session.Add("BuxSid", (string)Request.QueryString["AppKod"]);

            BuxSid = (string)Session["BuxSid"];
            //=====================================================================================
            getGrid();
  
        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("Spr000");

            ds.Merge(ws.ComSpr000(MdbNam, BuxSid, NumSpr));
            GridSpr.DataSource = ds;
            GridSpr.DataBind();

        }       
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            KodSpr = Convert.ToInt32(e.Record["SPRKOD"]);
            NamSpr = Convert.ToString(e.Record["SPRNAM"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSpr000Add(MdbNam, BuxSid, NumSpr, KodSpr, NamSpr);
            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {

            KodSpr = Convert.ToInt32(e.Record["SPRKOD"]);
            NamSpr = Convert.ToString(e.Record["SPRNAM"]);
            IdnSpr = Convert.ToInt32(e.Record["SPRIDN"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSpr000Rep(MdbNam, BuxSid, NumSpr, KodSpr, NamSpr, IdnSpr);
            getGrid();

        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            IdnSpr = Convert.ToInt32(e.Record["SPRIDN"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSpr000Del(MdbNam, BuxSid, NumSpr, IdnSpr);
            getGrid();


        }


        //-------------------------- меню для страницы ----------------------------------------------


    }
}

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Obout.Grid;
using System.Web.Configuration;


namespace Reception03hosp45.Spravki
{
    public partial class SprPar : System.Web.UI.Page
    {

        Grid grid1 = new Grid();

        string BuxFrm;
        string BuxSid;

        int ParNum;
        string ParVal;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            //=====================================================================================
           
            
            grid1.ID = "grid1";
            grid1.CallbackMode = true;
            grid1.Serialize = true;
            grid1.AutoGenerateColumns = false;
            grid1.AllowAddingRecords = false;

            grid1.FolderStyle = "~/Styles/Grid/style_5";
            grid1.AllowFiltering = true;
            grid1.ShowLoadingMessage = true;
            grid1.FolderLocalization = "~/Localization";
            grid1.Language = "ru";

            //           grid1.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
      //      grid1.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
      //      grid1.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //          grid1.Rebind += new Obout.Grid.Grid.DefaultEventHandler(RebindGrid);

            //------------------------------------------------------------------------  
            // creating the columns
            Column oCol1 = new Column();
            oCol1.DataField = "PARNUM";
            oCol1.HeaderText = "Код";
            oCol1.ReadOnly = true;
            oCol1.Visible = false; 

            Column oCol2 = new Column();
            oCol2.DataField = "PARNAM";
            oCol2.HeaderText = "Наименование";
            oCol2.ReadOnly = true;
            oCol2.Width = "300";

            Column oCol3 = new Column();
            oCol3.DataField = "PARVAL";
            oCol3.HeaderText = "Значения";
            oCol3.Width = "300";
            
            Column oCol4 = new Column();
            oCol4.HeaderText = "Операции";
            oCol4.Width = "100";
            oCol4.AllowEdit = true;

            // add the columns to the Columns collection of the grid
            grid1.Columns.Add(oCol1);
            grid1.Columns.Add(oCol2);
            grid1.Columns.Add(oCol3);
            grid1.Columns.Add(oCol4);
            grid1.PageSize = 20;
            phGrid1.Controls.Add(grid1);

            getGrid();

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("SprPar");

            ds.Merge(ws.ComSprPar(MdbNam, BuxFrm, BuxSid));
            grid1.DataSource = ds;
            grid1.DataBind();

        }
        // ======================================================================================

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            ParNum = Convert.ToInt32(e.Record["PARNUM"]);
            ParVal = Convert.ToString(e.Record["PARVAL"]);

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            ws.ComSprParRep(MdbNam, BuxFrm, BuxSid, ParNum, ParVal);
            getGrid();
        }
        //-------------------------- меню для страницы ----------------------------------------------


    }
}
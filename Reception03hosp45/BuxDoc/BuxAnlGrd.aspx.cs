using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Configuration;
using Obout.Grid;
//using Obout.Interface;

namespace Reception03hosp45.BuxDoc
{
    public partial class BuxAnlGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
     //   string Html;
        string ComParKey = "";
        string ComParTxt = "";

        string ComBegDat = "";
        string ComEndDat = "";

   //    string ParKey = "";
        string MdbNam = "HOSPBASE";
        //bool VisibleNo = false;
        //bool VisibleYes = true;

        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //=====================================================================================

            //           GridAcc.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
 //           GridAcc.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
 //           GridAcc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
  //          GridAcc.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            ComBegDat = (string)Request.QueryString["BegDat"];
            ComEndDat = (string)Request.QueryString["EndDat"];

            //     parAcc..value = ComParKey;
            parFrmKod.Value = BuxFrm;
            parAcc.Value = ComParKey;
            parAccTxt.Value = ComParTxt;
            parBeg.Value = ComBegDat;
            parEnd.Value = ComEndDat;

            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {

            //      ComParKey = Convert.ToString(Session["HidNodKey"]);
            //      ComParTxt = Convert.ToString(Session["HidNodTxt"]);
            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxAnlTreAccSel", con);
            cmd = new SqlCommand("BuxAnlTreAccSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = ComParKey;
            cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = ComBegDat;
            cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = ComEndDat;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxAnlTreAccSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();

            GridAcc.DataSource = ds;
            GridAcc.DataBind();
            // возвращаем значение
        }

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
            e.Row.Cells[2].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[2].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal';";
            e.Row.Cells[2].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",2)");
        }

        // ======================================================================================
        // добавление подразделении  (справочника SPRSTRFRM)
        // ======================================================================================
    }
}

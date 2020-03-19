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
    public partial class BuxMatGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string Html;
        string ComParAccPrv = "";
        string ComParAcc = "";
        string ComParMol = "";
        string ComParTxt = "";

        string ComBegDat = "";
        string ComEndDat = "";

        string ParKey = "";
        string MdbNam = "HOSPBASE";
        bool VisibleNo = false;
        bool VisibleYes = true;

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
            ComParAcc = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            ComBegDat = (string)Request.QueryString["BegDat"];
            ComEndDat = (string)Request.QueryString["EndDat"];

            parFrmKod.Value = BuxFrm;
            parAccPrv.Value = ComParAccPrv;
            parAcc.Value = ComParAcc;
            parAccTxt.Value = ComParTxt;
            parBeg.Value = ComBegDat;
            parEnd.Value = ComEndDat;

            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {

            //      ComParAcc = Convert.ToString(Session["HidNodKey"]);
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
            SqlCommand cmd = new SqlCommand("BuxMatTreAccSel", con);
            cmd = new SqlCommand("BuxMatTreAccSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = ComParAcc;
            cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = ComBegDat;
            cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = ComEndDat;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxMatTreAccSel");
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
            e.Row.Cells[0].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[0].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal';";
            e.Row.Cells[0].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",0)");

            e.Row.Cells[7].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[7].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal';";
            e.Row.Cells[7].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",7)");

            e.Row.Cells[8].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[8].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal';";
            e.Row.Cells[8].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",8)");


            /*
            if (args.Row.Cells[4].Text == "USA" || args.Row.Cells[4].Text == "Denmark" || args.Row.Cells[4].Text == "Germany")
            {
                for (int i = 1; i < args.Row.Cells.Count; i++)
                {
                    args.Row.Cells[i].BackColor = System.Drawing.Color.DarkGray;
                }
            }
    */
        }

        // ======================================================================================
        // добавление подразделении  (справочника SPRSTRFRM)
        // ======================================================================================
    }
}

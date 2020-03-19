using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Obout.ComboBox;
using System.Data.SqlClient;
using System.Data;
using Obout.Grid;
using System.Web.Configuration;
using System.Collections;   // для Hashtable
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Text;


namespace Reception03hosp45.Referent
{
    public class aspnet_basebaseclass : OboutInc.oboutAJAXPage
    {

    }

    public partial class RefGlv003Ord : System.Web.UI.Page
    {
        //        Grid grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam;

        string ComParKey = "0012";
        string ComParCty = "";
        string ComParDat = "";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            
            HidBuxFrm.Value = BuxFrm;
            HidBuxKod.Value = BuxKod;

            //          GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            //          GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

            //         GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            //         GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);



            /*            TextBoxPer.Text = "График приема врачей за период с ".PadLeft(70) +
                                    Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy") +
                                    " по " + Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
            */
            //=====================================================================================
            //    ComParCty = "2"; // (string)Request.QueryString["GrfCty"];

            //  ComParDat = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");   // (string)Request.QueryString["GrfDat"];
            if (TextBoxBegDat.Text == "") TextBoxBegDat.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
           
            ComParDat = TextBoxBegDat.Text;  // (string)Request.QueryString["GrfDat"];
                                                                                      //      hidBuxDat.Value = ComParDat;
            GlvBegDat = Convert.ToDateTime(ComParDat);
         //   TextBoxBegDat.Text = ComParDat;
           //=====================================================================================
            //         GridPrc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //            getDocNum();
                //              PopulateTree();
            }

                GridGrfDoc.Columns[03].HeaderText = (Convert.ToDateTime(GlvBegDat).ToString("dd.MM dddd")+"..........").Substring(0,19);
                GridGrfDoc.Columns[04].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(01)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[05].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(02)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[06].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(03)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[07].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(04)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[08].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(05)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[09].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(06)).ToString("dd.MM dddd") + "..........").Substring(0, 19);

                GridGrfDoc.Columns[10].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(07)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[11].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(08)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[12].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(09)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[13].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(10)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[14].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(11)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[15].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(12)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
            //    GridGrfDoc.Columns[16].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(13)).ToString("dd.MM dddd") + "..........").Substring(0, 19);

                LoadGrid();

        }

        protected void LoadGrid()
        {
        //    if (ComParKey == "_tree1") return;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspRefGlvScrOrd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@HSPKOD", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = ComParDat;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspRefGlvScrOrd");

            GridGrfDoc.DataSource = ds;
            GridGrfDoc.DataBind();

            ds.Dispose();
            con.Close();

            //           if (ds.Tables[0].Rows.Count > 0)
            //           {
            //         }
        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {

            e.Row.Cells[03].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[03].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[03].Text.Length > 5 && e.Row.Cells[03].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[03].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[03].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[03].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",03)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[04].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[04].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[04].Text.Length > 5 && e.Row.Cells[04].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[04].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[04].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[04].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",04)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[05].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[05].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[05].Text.Length > 5 && e.Row.Cells[05].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[05].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[05].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[05].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",05)");
//---------------------------------------------------------------------------------------------------
            e.Row.Cells[06].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[06].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[06].Text.Length > 5 && e.Row.Cells[06].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[06].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[06].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[06].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",06)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[07].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[07].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[07].Text.Length > 5 && e.Row.Cells[07].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[07].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[07].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[07].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",07)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[08].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[08].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[08].Text.Length > 5 && e.Row.Cells[08].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[08].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[08].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[08].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",08)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[09].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[09].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[09].Text.Length > 5 && e.Row.Cells[09].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[09].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[09].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[09].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",09)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[10].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[10].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[10].Text.Length > 5 && e.Row.Cells[10].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[10].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[10].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[10].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",10)");

            e.Row.Cells[11].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[11].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[11].Text.Length > 5 && e.Row.Cells[11].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[11].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[11].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[11].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",11)");

            e.Row.Cells[12].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[12].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[12].Text.Length > 5 && e.Row.Cells[12].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[12].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[12].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[12].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",12)");

            e.Row.Cells[13].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[13].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[13].Text.Length > 5 && e.Row.Cells[13].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[13].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[13].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[13].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",13)");

            e.Row.Cells[14].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[14].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[14].Text.Length > 5 && e.Row.Cells[14].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[14].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[14].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[14].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",14)");

            e.Row.Cells[15].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[15].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[15].Text.Length > 5 && e.Row.Cells[15].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[15].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[15].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[15].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",15)");
/*
            e.Row.Cells[16].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[16].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (e.Row.Cells[16].Text.Length > 5 && e.Row.Cells[16].Text.Substring(5, 1) == " ")
            {
                e.Row.Cells[16].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[16].Attributes["onmouseout"] = "this.style.fontSize = '12px';this.style.fontWeight = 'normal'; this.style.color = 'red';";
            }
            e.Row.Cells[16].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",16)");
*/
        }


        //------------------------------------------------------------------------

        //------------------------------------------------------------------------

        // ============================ кнопка новый документ  ==============================================
    }
}

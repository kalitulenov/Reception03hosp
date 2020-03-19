using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace Reception03hosp45.Operation
{
    public partial class DatBegEnd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("$(function() {$('.InpBegEndDat').dialog('open');});");

            Page.ClientScript.RegisterStartupScript(typeof(Page), "myscript2", sb.ToString(), true);

            //        txtEventStartDate.Text = Session["GlvDatRas"].ToString("dd.MM.yyyy");
            txtEventStartDate.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            txtEventEndDate.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

        }
 
        [WebMethod]
        public static bool BegEndDatOk(string StartDate, string EndDate)
        {
            DateTime date;
            DateTime GlvBegDat;
            DateTime GlvEndDat;

 //           string BuxFrm;
            string BuxSid;
            string MdbNam = "HOSPBASE";

 //           BuxFrm = (string)HttpContext.Current.Session["BuxFrm"];
            BuxSid = (string)HttpContext.Current.Session["BuxSid"];

            if (DateTime.TryParse(StartDate, out date))
            {
                HttpContext.Current.Session["GlvBegDat"] = date;
                GlvBegDat = date;

                if (DateTime.TryParse(EndDate, out date))
                {
                    HttpContext.Current.Session["GlvEndDat"] = date;
                    GlvEndDat = date;

//=====================================================================================
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    con.Open();

                    // создание команды
                    SqlCommand cmd = new SqlCommand("ComGlvBegEndDat", con);
                    cmd = new SqlCommand("ComGlvBegEndDat", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // создать коллекцию параметров
 //                   cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
                    cmd.Parameters.Add(new SqlParameter("@GLVBEGDAT", SqlDbType.Date, 10));
                    cmd.Parameters.Add(new SqlParameter("@GLVENDDAT", SqlDbType.Date, 10));
                    // ------------------------------------------------------------------------------заполняем первый уровень
                    // передать параметр
  //                  cmd.Parameters["@BUXFRM"].Value = BuxFrm;
                    cmd.Parameters["@BUXSID"].Value = BuxSid;
                    cmd.Parameters["@GLVBEGDAT"].Value = GlvBegDat;
                    cmd.Parameters["@GLVENDDAT"].Value = GlvEndDat;
                    cmd.ExecuteNonQuery();
                    con.Close();
//=====================================================================================
                    return true;
                }
                else { return false; }
            }
            else
            {
                return false;
            }
















        }


    }
}

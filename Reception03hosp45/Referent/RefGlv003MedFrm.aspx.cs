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
    public partial class RefGlv003MedFrm : System.Web.UI.Page
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
            
            GlvBegDatTxt = Convert.ToString(Session["GlvBegDat"]);
            GlvEndDatTxt = Convert.ToString(Session["GlvEndDat"]);

            GlvBegDat = Convert.ToDateTime(GlvBegDatTxt);
            GlvEndDat = Convert.ToDateTime(GlvEndDatTxt);

/*            TextBoxPer.Text = "График приема врачей за период с ".PadLeft(70) +
                        Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy") +
                        " по " + Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
*/
            TextBoxBegDat.Text = Convert.ToDateTime(GlvBegDatTxt).ToString("dd.MM.yyyy");
            TextBoxEndDat.Text = Convert.ToDateTime(GlvEndDatTxt).ToString("dd.MM.yyyy");
            //=====================================================================================
            SdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            SdsDoc.SelectCommand = "SELECT SprBux.BuxDlg,SprDlg.DLGNAM "+
                                   "FROM SprBux INNER JOIN SprDlg ON SprBux.BuxDlg=SprDlg.DLGKOD "+
                                   "WHERE (ISNULL(SprBux.BuxUbl,0)=0) AND (ISNULL(SprDlg.DLGZAP,0)=1) AND (SprBux.BuxFrm=" + BuxFrm + 
                                   ") GROUP BY SprDlg.DLGNAM,SprBux.BuxDlg "+
                                   "ORDER BY SprDlg.DLGNAM";

            SdsFio.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            SdsFio.SelectCommand = "SELECT BuxKod,FIO FROM SprBuxKdr " +
                                  "WHERE Isnull(BuxUbl,0)=0 And DlgKod=" + GrfDlg + " AND BuxFrm=" + BuxFrm + " ORDER BY FIO";

            SdsKlt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 

            SdsMedDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; 
            SdsMedDoc.SelectCommand = "SELECT * FROM SprMedFrm WHERE SprMedFrmKey='230' ORDER BY SprMedFrmNam";
            //=====================================================================================
            //================================== GodNam ===============================================================
            //=====================================================================================
            if (!Page.IsPostBack)
            {


            }
            else
            {
 
            }
        }

 
        //------------------------------------------------------------------------

        //------------------------------------------------------------------------

        // ============================ кнопка новый документ  ==============================================
    }
}

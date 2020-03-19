using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OboutInc.EasyMenu_Pro;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Reception03hosp45.Masters
{
    public partial class MsrPusto : System.Web.UI.MasterPage
    {
        string MdbNam = "HOSPBASE";
        string BuxFrmKod;
        string BuxSid;
// ---------------------------------------------------------------------------

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrmKod = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
        }
    }
}

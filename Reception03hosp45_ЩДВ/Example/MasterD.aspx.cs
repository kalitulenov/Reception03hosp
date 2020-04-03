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
using System.Web.UI.HtmlControls;
using System.Text;

namespace Reception03hosp45.Example
{
    public partial class MasterD : System.Web.UI.Page
    {
        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            sdsQst.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsAns.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

            //=====================================================================================
            if (!Page.IsPostBack)
            {

            }
        }

    }
}



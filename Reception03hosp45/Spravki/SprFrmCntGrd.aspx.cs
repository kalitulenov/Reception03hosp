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
using Obout.Interface;

namespace Reception03hosp45.Spravki
{
    public partial class SprFrmCntGrd : System.Web.UI.Page
    {
        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string Html;
        string ComParKey = "";
        string ComParTxt = "";

        string ParKey = "";
        string MdbNam = "INSURBASE";
        bool VisibleNo = false;
        bool VisibleYes = true;

        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
 


    }
}

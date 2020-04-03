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
    public partial class MsrMain : System.Web.UI.MasterPage
    {
        string MdbNam = "HOSPBASE";
        string BuxFrmKod;
        string BuxSid;

        /*
                private void Page_Init(object sender, System.EventArgs e)
                {

                    BuxFrmKod = (string)Session["BuxFrmKod"];
                    BuxSid = (string)Session["BuxSid"];

                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
                    DataSet ds = new DataSet("Menu");

                    ds.Merge(ws.ComRedUsrMnu(MdbNam, BuxFrmKod, BuxSid));
                    //-------------------------------------------------------------------------------------
                    string lastMenuId = "";
                    string CurMenuId = "";
                    EasyMenu oem = null;
                    // Заполнить EM в цикле
                    foreach (DataRow row in ds.Tables["ComRedUsrMnu"].Rows)
                            {
                            // Initialising a new EM
                            CurMenuId = row["MnuBarApp"].ToString();
                            if (CurMenuId != lastMenuId)
                               {
                                oem = new EasyMenu();
                                oem.ID = row["MnuBarApp"].ToString();
                                // if an attachto property is set, this is not the main menu
                           //     if (row["MnuBarAtt"].ToString() != null)
                                if (!row["MnuBarAtt"].Equals(System.DBNull.Value))
                                   {
                                       oem.AttachTo = row["MnuBarAtt"].ToString();
                                     // we add the menus to the page controls
                                     PlaceHolderMenu.Controls.Add(oem);
                                   }
                                // otherwise this is the main menu
                                else
                                   {
                                    // we add the menu to the placeholder (to display it where we need in the page)
                                    PlaceHolderMenu.Controls.Add(oem);
                                   }
                                Session["EasyMenu_" + oem.ID] = oem;

                                lastMenuId = row["MnuBarApp"].ToString();
                               }
                            }

                }
        */
        // ---------------------------------------------------------------------------

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrmKod = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            //    if (!Page.IsPostBack)
            //     {



            //        this.Page.Title = "Лекарства через Интернет";
            if (BuxFrmKod == "1") ImageLog.ImageUrl = "~/Logo/LogoSofi.jpg";
            else ImageLog.ImageUrl = "~/Logo/LogoDauaBig.jpg";


            // ===================  Подобрать ЛОГОТИП ==================================================
            switch (BuxFrmKod)
            {
                case "1":
                    ImageLog.ImageUrl = "~/Logo/LogoSofi.jpg";
                    break;
                //     case "3":
                //         ImageLog.ImageUrl = "~/Logo/LogoAvtorMed.jpg";
                //         break;
                default:
                    ImageLog.ImageUrl = "~/Logo/LogoDauaBig.jpg";
                    break;
            }
            // ===================  Подобрать ЛОГОТИП ==================================================

            // ===================Page_Init==================================================

            localhost.Service1Soap ws = new localhost.Service1SoapClient();
            DataSet ds = new DataSet("Menu");

            ds.Merge(ws.ComRedUsrMnu(MdbNam, BuxFrmKod, BuxSid));
            //-------------------------------------------------------------------------------------
            string lastMenuId = "";
            string CurMenuId = "";
            EasyMenu oem = null;
            // Заполнить EM в цикле
            foreach (DataRow row in ds.Tables["ComRedUsrMnu"].Rows)
            {
                // Initialising a new EM
                CurMenuId = row["MnuBarApp"].ToString();
                if (CurMenuId != lastMenuId)
                {
                    oem = new EasyMenu();
                    oem.ID = row["MnuBarApp"].ToString();
                    // if an attachto property is set, this is not the main menu
                    //     if (row["MnuBarAtt"].ToString() != null)
                    if (!row["MnuBarAtt"].Equals(System.DBNull.Value))
                    {
                        oem.AttachTo = row["MnuBarAtt"].ToString();
                        // we add the menus to the page controls
                        PlaceHolderMenu.Controls.Add(oem);
                    }
                    // otherwise this is the main menu
                    else
                    {
                        // we add the menu to the placeholder (to display it where we need in the page)
                        PlaceHolderMenu.Controls.Add(oem);
                    }
                    Session["EasyMenu_" + oem.ID] = oem;

                    lastMenuId = row["MnuBarApp"].ToString();
                }
            }

            // ========================Page_Init=============================================

            // ==========================================================================================================================================
            //           if (!Page.IsPostBack)
            //         {
            ds.Merge(ws.ComRedUsrMnu(MdbNam, BuxFrmKod, BuxSid));
            //-------------------------------------------------------------------------------------
            // Заполнить EM в цикле

            foreach (DataRow row in ds.Tables["ComRedUsrMnu"].Rows)
            {
                // Initialising a new EM
                CurMenuId = row["MnuBarApp"].ToString();
                if (CurMenuId != lastMenuId)
                {
                    oem = (EasyMenu)Session["EasyMenu_" + CurMenuId];
                    oem.Position = MenuPosition.Horizontal;
                    oem.Width = "20%";
                    //           oem.IconsFolder = "Icons";
                    //            oem.StyleFolder = oReader.GetString(oReader.GetOrdinal("style"));
                    oem.StyleFolder = "~/Styles/Menu";
                    // если свойствао AttachTo установлен, это не главное меню
                    if (!row["MnuBarAtt"].Equals(System.DBNull.Value))
                    //        if (row["MnuBarAtt"].ToString() != null)
                    {
                        oem.ShowEvent = MenuShowEvent.MouseClick; //показывает при шелчке правой кнопки
                                                                  //             oem.ShowEvent = MenuShowEvent.ContextMenu;   // показывает при шелчке правой кнопки
                                                                  //             oem.ShowEvent = MenuShowEvent.MouseOver;   // показывает при наведении курсора  (работает неустоичиво)

                        if (oem.AttachTo != "item01" && oem.AttachTo != "item02" && oem.AttachTo != "item03" && oem.AttachTo != "item04" && oem.AttachTo != "item05" && oem.AttachTo != "item06" && oem.AttachTo != "item07" && oem.AttachTo != "item08" && oem.AttachTo != "item09")
                            oem.Align = MenuAlign.Right;
                        else
                            oem.Align = MenuAlign.Under;

                        oem.Position = MenuPosition.Vertical;
                    }
                    // иначе это главное меню
                    else
                    {
                        oem.ShowEvent = MenuShowEvent.Always;
                        //              oem.ShowEvent = MenuShowEvent.ContextMenu;
                        oem.Width = "100%";
                    }
                }
                // Adding either a Separator or an Item
                if (row["MnuBarTyp"].ToString() == "S")
                    oem.AddSeparator(row["ID"].ToString(),
                    (row["HTML"].Equals(System.DBNull.Value)) ? "" : row["HTML"].ToString());
                else
                    if (row["MnuBarTyp"].ToString() == "I")
                    oem.AddMenuItem(row["MnuBarKod"].ToString(),
                    (row["MnuBarTxt"].Equals(System.DBNull.Value) ? "" : row["MnuBarTxt"].ToString()),
                    (row["MnuBarIcn"].Equals(System.DBNull.Value) ? "" : row["MnuBarIcn"].ToString()),
                    (row["MnuBarUrl"].Equals(System.DBNull.Value) ? "" : row["MnuBarUrl"].ToString()),
                    (row["MnuBarUrlTrg"].Equals(System.DBNull.Value) ? "" : row["MnuBarUrlTrg"].ToString()),
                    (row["MnuBarClk"].Equals(System.DBNull.Value) ? "" : row["MnuBarClk"].ToString()));

                lastMenuId = row["MnuBarApp"].ToString();

            }
            //            }
            // ==========================================================================================================================================
            //System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Open_Window", "EodWindow.Open();", true);

        }



    }
}

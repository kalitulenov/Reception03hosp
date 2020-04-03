using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

namespace Reception03hosp45
{
    public partial class AccChn : System.Web.UI.Page
    {
        string OrgNam;
        string LogNam;
        string PswNam;
        string PswNamNew;
        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            OrgNam = Convert.ToString(Request.QueryString["OrgNam"]);
            LogNam = Convert.ToString(Request.QueryString["LogNam"]);
            PswNam = Convert.ToString(Request.QueryString["PswNam"]);
            //============= начало  ===========================================================================================

            if (IsPostBack)
            {
                if (parOtmBut.Value == "OkBut" || parOtmBut.Value == "OtmBut")
                {
                    HttpContext.Current.Response.Redirect("/Default.aspx");
                }

                if (txtPswNamNew001.Text == txtPswNamNew002.Text && txtPswNamNew001.Text.Length>0)
                {
                    PswNamNew = txtPswNamNew002.Text;
                    localhost.Service1Soap ws = new localhost.Service1SoapClient();
                    DataSet ds = new DataSet("Login");
                    ds.Merge(ws.ComUpdUsrPsw(MdbNam, OrgNam, LogNam, PswNam, PswNamNew));

                    try
                    {
                        loginDialog.Visible = true;
                        succeedNotice.Visible = true;
                   //     HttpContext.Current.Response.Redirect("/Default.aspx");
                    }
                    catch
                    {
                        //Wrong password
                        txtPswNamNew001.Text = "";
                        txtPswNamNew002.Text = "";
                        loginDialog.Visible = true;
                        failNotice.Visible = true;
                    }
                }
                else
                {
                    //Wrong password
                    txtPswNamNew001.Text = "";
                    txtPswNamNew002.Text = "";
                    loginDialog.Visible = true;
                    failNotice.Visible = true;

                }


            }
            else
            {
                txtPswNamNew001.Text = "";
                txtPswNamNew002.Text = "";
            }
        }


        protected void OtmButton_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Redirect("/Default.aspx");
        }
        protected void OkButton_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Redirect("/Default.aspx");
        }
    }
}

<%@ Page Language="C#" ASPCOMPAT="TRUE" Debug="true"%>

<%@ Import Namespace="obout_ASPTreeView_2_NET" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>


<script language="C#" runat="server">
	void Page_Load(object sender, EventArgs e) {
		obout_ASPTreeView_2_NET.Tree oTree = new obout_ASPTreeView_2_NET.Tree();

		// These 3 lines prevent from browser caching. They are optional.
		// Useful when your data changes frequently. 
		Response.AddHeader("pragma","no-cache");
		Response.AddHeader("cache-control","private");
		Response.CacheControl = "no-cache";
		
		// For non-English characters. See MSDN for your language settings. 
		// http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/reference/charsets/charset4.asp
		
		//Response.CodePage = 1252;
		//Response.CharSet = "windows-1252";

		// IMPORTANT:  For loaded SubTree set to TRUE.
		oTree.SubTree = true;

        string KeyNod = Convert.ToString(Page.Request["KeyNod"]);
        string KeyLen = Convert.ToString(Page.Request["KeyLen"]);


        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        //          SqlCommand cmd = new SqlCommand("ComSprBuxMnu", con);
        SqlCommand cmd = new SqlCommand("SELECT USLKEY+'.'+RIGHT('0000'+LTRIM(STR(USLKOD)),4) AS USLKEYKOD,USLNAM FROM SPRUSL WHERE ISNULL(USL002,0)=0 AND LEFT(USLKEY," + KeyLen + ")='" + KeyNod + "' ORDER BY USLNNN", con);
 //       SqlCommand cmd = new SqlCommand("SELECT * FROM SPRUSL WHERE LEFT(USLKEY,3)='001' ORDER BY USLNAM", con);
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "ComSprUsl");

        con.Close();

        //=====================================================================================
        foreach (DataRow row in ds.Tables["ComSprUsl"].Rows)
        {
            oTree.Add("root", "nod_"+row["UslKeyKod"]+"v", Convert.ToString(row["UslNam"]), false, "triangle_greenS.gif", null);
        }

        oTree.FolderIcons = "/Styles/tree2/icons";
        oTree.FolderScript = "/Styles/tree2/script";
        oTree.FolderStyle = "/Styles/tree2/style/Classic";
        oTree.SelectedEnable = true;
        //oTree.SelectedId = "a1_0";
   //     oTree.ShowIcons = true;
    //    oTree.Width = "600px";
    //    oTree.Height = "600px";
    //    oTree.EventList = "";
        
     //   oTree.FolderIcons = "tree2/icons";
		//oTree.FolderScript = "tree2/script";
	//	oTree.FolderStyle = "tree2/style/MSDN";
		Response.Write(oTree.HTML());
}

</script>
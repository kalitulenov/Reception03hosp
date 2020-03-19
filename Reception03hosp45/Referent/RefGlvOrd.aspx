<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%-- ============================  для фото  ============================================ --%>

<%@ Import Namespace="obout_ASPTreeView_2_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <!--  ссылка на JQUERY -------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />
    <!-- -------------------------------------------------------------------------------- -->
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
     	td.link{
			padding-left:30px;
			width:250px;			
		}
		
    </style>
    

 
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">

        string CrpKod;
        
        int UslKod;
        int BuxKod;
        string HspKod;
        DateTime GlvBegDat;
        DateTime GlvEndDat;

        string ComParKey = "";
        int ComKolVip;
        string MdbNam = "HOSPBASE";
        string Html;
        string UslKey000;
        string UslKey003;
        string UslKey007;
        string UslKey011;
        string UslKey015;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            // CrpKod = Convert.ToInt32(Request.QueryString["val"]);
  //          CrpKod = "0001"; // Interteach
  //          Session.Add("CRPKOD", CrpKod);
            //=====================================================================================
            //=====================================================================================
          
            if (!Page.IsPostBack && !IsCallback)
            {
     //           Session.Clear();
                HspKod = Convert.ToString(Session["BUXFRMKOD"]);
                BuxKod = Convert.ToInt32(Session["BUXKOD"]);
                parFlg.Value = "Начало";

    //            sdsCty.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
    //            sdsCty.SelectCommand = "SELECT * FROM SPRCTY ORDER BY CTYNAM";

    //            Session.Add("CTYKOD", (string)"0");
                Session.Add("USLKOD", (string)"0");
    //            Session.Add("BUXKOD", (string)"0");
    //            Session.Add("TABITM", (string)"Tab1");
                //          ---------------------------  работа с датой -------------------------
                Session["USLDAT"] = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy"); //DateTime.Today;        // указывает на начало
                Session["USLDATDAY"] = Session["USLDAT"];    // указывает на выбранную дату
                //=====================================================================================
 //               BoxCty.SelectedValue = Convert.ToString(Session["CTYKOD"]);
                
                GetTree();
                //------------------------------------------       чтение первых трех уровней дерево
                // Перебираем записи категории
   //            TreeNode nodeRoot = new TreeNode("ПРЕЙСКУРАНТ".ToString(), "000".ToString());

            }
            else
            {
                //               getPostBackControlName();
            }

            //=====================================================================================

            txtDate1.Text = Convert.ToDateTime(Session["USLDAT"]).ToString("dd.MM.yyyy");

            GlvBegDat = Convert.ToDateTime(Session["USLDAT"]);

            grid2.Columns[10].HeaderText = Convert.ToDateTime(GlvBegDat).ToString("dd.MM");
            grid2.Columns[11].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(1)).ToString("dd.MM");
            grid2.Columns[12].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(2)).ToString("dd.MM");
            grid2.Columns[13].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(3)).ToString("dd.MM");
            grid2.Columns[14].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(4)).ToString("dd.MM");
            grid2.Columns[15].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(5)).ToString("dd.MM");
            grid2.Columns[16].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(6)).ToString("dd.MM");
            grid2.Columns[17].HeaderText = Convert.ToDateTime(GlvBegDat.AddDays(7)).ToString("dd.MM");
        }
        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        void GetTree()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("ComTrePrcHsp", con);
            //         SqlCommand cmd = new SqlCommand("SELECT * FROM SPRSTRUSL ORDER BY STRUSLKEY", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@HSPKOD", SqlDbType.VarChar).Value = HspKod;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComTrePrcHsp");

            con.Close();

            //=====================================================================================
            obout_ASPTreeView_2_NET.Tree oTree = new obout_ASPTreeView_2_NET.Tree();

            oTree.AddRootNode("<big><ins><b>" + "ПРЕЙСКУРАНТ" + "</b></ins></big>", true, "tree.gif");

            foreach (DataRow row in ds.Tables["ComTrePrcHsp"].Rows)
            {
                Html = Convert.ToString(row["StrUslNam"]);
                switch (Convert.ToString(row["StrUslKey"]).Length)
                {
                    case 0:
                        break;
                    case 3:
                        UslKey003 = "nod_" + Convert.ToString(row["StrUslKey"]);
                        oTree.Add("root", "nod_" + row["StrUslKey"], Html, false, "woman1S.gif", "/Spravki/TreSub.aspx?KeyNod=" + Convert.ToString(row["StrUslKey"]) + "&KeyLen=3");
                        break;
                    case 7:
                        UslKey007 = "nod_" + Convert.ToString(row["StrUslKey"]);
                        oTree.Add(UslKey003, "nod_" + row["StrUslKey"], Html, false, "woman2S.gif", "/Spravki/TreSub.aspx?KeyNod=" + Convert.ToString(row["StrUslKey"]) + "&KeyLen=7");
                        break;
                    case 11:
                        UslKey011 = "nod_" + Convert.ToString(row["StrUslKey"]);
                        oTree.Add(UslKey007, "nod_" + row["StrUslKey"], Html, false, "woman3S.gif", "/Spravki/TreSub.aspx?KeyNod=" + Convert.ToString(row["StrUslKey"]) + "&KeyLen=11");
                        break;
                    case 15:
                        UslKey015 = "nod_" + Convert.ToString(row["StrUslKey"]);
                        oTree.Add(UslKey011, "nod_" + row["StrUslKey"], Html, false, "woman1S.gif", "/Spravki/TreSub.aspx?KeyNod=" + Convert.ToString(row["StrUslKey"]) + "&KeyLen=15");
                        break;
                    default:
                        break;
                }

            }

            oTree.ShowIcons = false;
            oTree.FolderIcons = "/Styles/tree2/icons";
            oTree.FolderScript = "/Styles/tree2/script";
            oTree.FolderStyle = "/Styles/tree2/style";
            oTree.SelectedEnable = true;
            oTree.EditNodeEnable = false;
            oTree.DragAndDropEnable = false;
            oTree.MultiSelectEnable = false;
            //oTree.SelectedId = "a1_0";
            oTree.ShowIcons = true;
            oTree.Width = "100%";
            oTree.Height = "600px";
            //       oTree.EventList = "OnNodeSelect";

            TreeView1.Text = oTree.HTML();

        }
        //=============При выборе узла дерево===========================================================================================
        //---------------------------- запись в таблицу DOCGRF о занятости --------------------------------------------
        public void UpdateDocGrf(string[] DocGrf)
        {
            //           int GrfIdn;
            string GrfBus;

            // ===================== записать в базу ================================================================================
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();
            GrfBus = (string)DocGrf[1];

            // создание команды
            //             SqlCommand cmd = new SqlCommand("UPDATE DOCGRF SET GRFBUS=1,GRFINTFLG=1,GRFINTBEG=GETDATE(),GRFINTEND=DATEADD(MINUTE,60,GETDATE()),GRFPTH=@GRFPTH,GRFEML=@GRFEML,GRFTEL=@GRFTEL WHERE GRFIDN=@GRFIDN", con);
            SqlCommand cmd = new SqlCommand("HspDocGrfRepRef", con);
            cmd = new SqlCommand("HspDocGrfRepRef", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            if (string.IsNullOrEmpty(DocGrf[2])) DocGrf[2] = "-";
            if (string.IsNullOrEmpty(DocGrf[3])) DocGrf[3] = "-";
            if (string.IsNullOrEmpty(DocGrf[4])) DocGrf[4] = "-";

            cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = DocGrf[0];
            cmd.Parameters.Add("@GRFBUS", SqlDbType.VarChar).Value = DocGrf[1];
            cmd.Parameters.Add("@GRFPTH", SqlDbType.VarChar).Value = DocGrf[2];
            cmd.Parameters.Add("@GRFADR", SqlDbType.VarChar).Value = DocGrf[4];
            cmd.Parameters.Add("@GRFTEL", SqlDbType.VarChar).Value = DocGrf[3];
            cmd.Parameters.Add("@GRFPOL", SqlDbType.VarChar).Value = DocGrf[5];
            cmd.Parameters.Add("@GRFBRT", SqlDbType.VarChar).Value = DocGrf[6];
            cmd.Parameters.Add("@GRFFRMTXT", SqlDbType.VarChar).Value = DocGrf[7];

            // Выполнить команду
            cmd.ExecuteNonQuery();
            con.Close();
        }
        
        //------------------------------------------------------------------------

        // 2222222222222222222222222222222222222222222222222222222222222222222222222222222222
        //----------------------------- фото с размером 300х250 -------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
                //-------------- для высвечивания графика при подводе курсора ----------------------------------------------------------
   
                e.Row.Attributes["onmouseover"] = "handleMouseOver(" + e.Row.RowIndex.ToString() + ")";

                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    e.Row.Cells[i].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + "," + i + ")");
                }

                //-------------- для фото ----------------------------------------------------------
        //        ImageZoom iz = (ImageZoom)e.Row.Cells[3].FindControl("imagez");
        //        iz.ImageUrl = "~/DoctorFoto/" + e.Row.Cells[3].Text;

        }

        //------------------------- при выборе мелуслуги в первой вкладке -----------------------------------------------
        public void CreateMedUslHsp(string USLKOD)
        {
            Session["USLKOD"] = USLKOD;
        }
        //------------------------- при выборе мелуслуги в первой вкладке со сдвигом на 5 дней-----------------------------------------------

        public void CreateMedUslHsp005(string USLKOD, string USLTYP, string USLDAT005)
        {
            Session["USLKOD"] = USLKOD;

            if (USLTYP == "г") Session["CTYKOD"] = Convert.ToString(USLDAT005);
            if (USLTYP == "к")
               {
                 GlvBegDat = Convert.ToDateTime(USLDAT005);
                       
                 if (GlvBegDat < DateTime.Today)
                    {
                      GlvBegDat = Convert.ToDateTime(DateTime.Today);
                      Session["USLDAT"] = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                      Session["USLDATDAY"] = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                      txtDate1.Text = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                    }
                 else
                    {
                      Session["USLDAT"] = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                      Session["USLDATDAY"] = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                      txtDate1.Text = Convert.ToDateTime(GlvBegDat).ToString("dd.MM.yyyy");
                    }
                 cal1.SelectedDate = GlvBegDat;
               }

        }

        // 333333333333333333333333333333333333333333333333333333333333333333333333333333333333
        //------------------------------------------------------------------------
        public void CreateMedUslDocGrf(string BUXKOD, string BUXDAY)
        {

            int Day = 0;
            DateTime TekDat;
            string TekDatTxt;
            string TEKBUXKOD;

   //         Session["TABITM"] = "Tab0";

//            TEKBUXKOD = BUXKOD.Substring(0, BUXKOD.Length - 2);
//            Day = Convert.ToInt32(BUXKOD.Substring(BUXKOD.Length - 1, 1));
            TEKBUXKOD = BUXKOD;
            Day = Convert.ToInt32(BUXDAY);

            TekDatTxt = Convert.ToDateTime(Session["USLDAT"]).ToString("dd.MM.yyyy");
            TekDat = DateTime.Parse(TekDatTxt);
            TekDat = TekDat.AddDays(Day - 1);

            Session["USLDATDAY"] = Convert.ToDateTime(TekDat).ToString("dd.MM.yyyy");
 //           Session["USLDATDAY"] = Convert.ToDateTime(Session["USLDAT"]).ToString("dd.MM.yyyy");
            Session["BUXKOD"] = TEKBUXKOD;

            // --------------------------  считать данные одного врача -------------------------
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BuxKod, DLGNAM,UchKatNam,FIO,KDRPIC,ORGKLTNAM,STG " +
                                            "FROM SprBuxKdr WHERE BuxKod='" + TEKBUXKOD + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);

            Session["BUXFIO"] = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]);
            Session["BUXHSP"] = Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]);
            Session["BUXSPZ"] = Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]);
            Session["BUXSTG"] = Convert.ToString(ds.Tables[0].Rows[0]["STG"]);

            ImgDocOne.ImageUrl = "~/DoctorFoto/" +Convert.ToString(ds.Tables[0].Rows[0]["KDRPIC"]);
   //         ImgDocOne.Description = Convert.ToString(Session["BUXFIO"]);
            BoxFio.Text = Convert.ToString(Session["BUXFIO"]);
            BoxHsp.Text = Convert.ToString(Session["BUXHSP"]);
            BoxSpz.Text = Convert.ToString(Session["BUXSPZ"]);
            BoxStg.Text = Convert.ToString(Session["BUXSTG"]);

            con.Close();

      //      sdsGrfDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
      //      sdsGrfDoc.SelectCommand = "ShpUslHspDocGrf";
      //      sdsGrfDoc.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            //       sdsGrfDoc.SelectParameters.Add("USLKOD","Int32");
            //       sdsGrfDoc.SelectParameters.Add("BUXKOD","Int32");
            //       sdsGrfDoc.SelectParameters.Add("USLDAT","String");

            UpdatePanel("CallbackPanel12");

        }
        
        //---------------------   окно рекламы врача ---------------------------------------------------

        public void CreateDocMem(string BUXKOD)
        {
            String Header = "";
            String Education = "";
            String Nagradi = "";
            String ImgUrl = "";
      //      int LenImg;

            // --------------------------  считать данные одного врача --- фото с размером 300х500 ----------------------
            DataSet ds000 = new DataSet();
            DataSet dsEdu = new DataSet();
            DataSet dsNgr = new DataSet();

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd000 = new SqlCommand("SELECT BuxKod, DLGNAM,UchKatNam,FIO,KDRPIC,KDRTHN,ORGKLTNAM,STG " +
                                            "FROM SprBuxKdr WHERE BuxKod='" + BUXKOD + "'", con);
            SqlCommand cmdEdu = new SqlCommand("SELECT EDUNAM,YEAR(EDUDIPDAT) AS EDUYAR " + "FROM KDREDU WHERE EDUKOD='" + BUXKOD + "' ORDER BY EDUDIPDAT DESC", con);
            SqlCommand cmdNgr = new SqlCommand("SELECT NGRNAM,YEAR(NGRDAT) AS NGRYAR " + "FROM KDRNGR WHERE NGRKOD='" + BUXKOD + "' ORDER BY NGRDAT DESC", con);
            SqlDataAdapter da000 = new SqlDataAdapter(cmd000);
            da000.Fill(ds000,"KDR");


            ImgUrl = "/DoctorFoto/" + Convert.ToString(ds000.Tables[0].Rows[0]["KDRPIC"]);
    //        ImgUrl = "DoctorFoto/" + Convert.ToString(ds000.Tables[0].Rows[0]["KDRPIC"]) + "_big.jpg";
            //       ImgUrl = ImgUrl.Remove(ImgUrl.LastIndexOf(@".")) + "_big.jpg";
     //       LenImg = ImgUrl.Length - 2;
     //       ImgUrl = ImgUrl.Substring(3, LenImg);
            
            Header = @"<input name='Lab1' type='text' value='"+
                       Convert.ToString(ds000.Tables[0].Rows[0]["FIO"])+
                     @"' readonly='readonly' id='Lab1' style='color:White;background-color:PaleVioletRed;font-family:Verdana;font-size:20px;font-weight:bold;top: 0px; left: 0px; position: relative; width: 100%' />          
                <div style='text-align: left; float: left;'>
                    <img id='ImgDocOneMem' src='"+
                         ImgUrl+
                    @"' style='height:200px;width:200px;border-width:0px;' />
                </div>
                 <table width='650px'>
                    <tr>
                        <td style='width: 5%; font-weight: bold;'>Клиника:</td>
                        <td>"+
                           Convert.ToString(ds000.Tables[0].Rows[0]["ORGKLTNAM"])+           
                        @"</td>
                    </tr>
                    <tr>
                        <td style='width: 5%; font-weight: bold;'>Врач:</td>
                        <td>"+
                            Convert.ToString(ds000.Tables[0].Rows[0]["DLGNAM"])+
                        @"</td>
                    </tr>
                    <tr>
                        <td style='width: 5%; font-weight: bold;'>Стаж:</td>
                        <td>"+
                            Convert.ToString(ds000.Tables[0].Rows[0]["STG"])+
                        @"</td>
                    </tr>
                    <tr>
                        <td style='width: 5%; font-weight: bold;'>Контактные<br />телефоны:</td>
                        <td>"+
                            Convert.ToString(ds000.Tables[0].Rows[0]["KDRTHN"])+
                        @"</td>
                    </tr>";
            
              SqlDataAdapter daEdu = new SqlDataAdapter(cmdEdu);
              daEdu.Fill(dsEdu,"EDU");
               
              Education = @"<tr><td valign='top' style='width: 5%; font-weight: bold;'>Образование:</td>
                            <td><ul style='margin-left:20px;'>";

              foreach (DataRow row in dsEdu.Tables["EDU"].Rows)
               {
                // пропуск пустого значения	 	
                if (row["EDUNAM"].ToString().Trim().Length == 0) continue;
                Education = Education + "<li>" + row["EDUYAR"].ToString() + " - "+ row["EDUNAM"].ToString()+"</li>";
              }
				Education =Education + "</ul></td></tr>";
            
            
              SqlDataAdapter daNgr = new SqlDataAdapter(cmdNgr);
              daNgr.Fill(dsNgr,"NGR");
               
              Nagradi = @"<tr><td valign='top' style='width: 5%; font-weight: bold;'>Награды:</td>
                            <td><ul style='margin-left:20px;'>";
            
              foreach (DataRow row in dsNgr.Tables["NGR"].Rows)
               {
                // пропуск пустого значения	 	
                if (row["NGRNAM"].ToString().Trim().Length == 0) continue;
				Nagradi =Nagradi + "<li>"+row["NGRYAR"].ToString()+" - " +row["NGRNAM"].ToString()+"</li>";
              }
				Nagradi =Nagradi + "</ul></td></tr></table>";

            // construct the final script
                Literal1.Text = Header + Education + Nagradi;
           
            UpdatePanel("CallbackPanelDoc");
        }


        //---------------------   окно описание услуги ---------------------------------------------------
        public void CreateUslMem(string BUXKOD)
        {
            String Header = "";
            String ImgUrl = "";
            String UslKodTxt = "";
            int KodOrg = 0;
            

            // --------------------------  считать данные Клиникаа ---- фото с размером 300х500 ---------------------
            DataSet ds = new DataSet();
            DataSet dsUsl = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BuxKod, DLGNAM,UchKatNam,FIO,KDRPIC,KDRTHN,ORGKLTNAM,STG " +
                                            "FROM SprBuxKdr WHERE BuxKod='" + BUXKOD + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            con.Close();

            ImgUrl = "/DoctorFoto/" + Convert.ToString(ds.Tables[0].Rows[0]["KDRPIC"]);            
// получить код организации
  //          KodOrg = Convert.ToInt32(ds.Tables[0].Rows[0]["ORGKLTKOD"]);
            KodOrg = Convert.ToInt32(Session["BUXFRMKOD"]);

  //          ImgUrl = "/SalonFoto/" + Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTPIC"]) + ".jpg";
      //      ImgUrl = "DoctorFoto/ErmIra_big.jpg";
            
            // --------------------------  считать данные из спр-ка о описаниях услуги ---------------------
            if (Convert.ToString(Session["USLKOD"]).IndexOf("v") > 0)
            {
                UslKodTxt = Convert.ToString(Session["USLKOD"]).Substring(Convert.ToString(Session["USLKOD"]).LastIndexOf(".") + 1, 4);
                SqlCommand cmdUsl = new SqlCommand("SELECT * FROM SprUslFrm WHERE UslFrmHsp=" + KodOrg + " AND UslFrmKod=" + UslKodTxt, con);
                SqlDataAdapter daUsl = new SqlDataAdapter(cmdUsl);
                daUsl.Fill(dsUsl);

                Header = @"<input name='Lab1' type='text' value='" +
                          Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]) +
                        @"' readonly='readonly' id='Lab1' style='color:White;background-color:PaleVioletRed;font-family:Verdana;font-size:20px;font-weight:bold;top: 0px; left: 0px; position: relative; width: 100%' />          
                <div style='text-align: left; float: left;'>
                    <img id='ImgDocOneMem' src='" +
                            ImgUrl +
                       @"' style='height:300px;width:300px;border-width:0px;' />
                </div>
                 <table width='650px'>
                    <tr>
                        <td>" +
                              Convert.ToString(dsUsl.Tables[0].Rows[0]["USLFRMMEM"]) +
                           @"</td>
                    </tr>";

                // construct the final script
                Literal1.Text = Header + "</table>";
            }

            UpdatePanel("CallbackPanelDoc");

        }
        //---------------------   окно описание акции ---------------------------------------------------
        public void CreateAkzMem(string BUXKOD)
        {
            String Header = "";
            String ImgUrl = "";
            String UslKodTxt = "";
            int KodOrg = 0;


            // --------------------------  считать данные Клиникаа ---- фото с размером 300х500 ---------------------
            DataSet ds = new DataSet();
            DataSet dsUsl = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BuxKod, DLGNAM,UchKatNam,FIO,KDRPIC,KDRTHN,ORGKLTNAM,STG " +
                                            "FROM SprBuxKdr WHERE BuxKod='" + BUXKOD + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            con.Close();

            ImgUrl = "/DoctorFoto/" + Convert.ToString(ds.Tables[0].Rows[0]["KDRPIC"]);
            
            // получить код организации
            KodOrg = Convert.ToInt32(Session["BUXFRMKOD"]);

            // --------------------------  считать данные из спр-ка о описаниях услуги ---------------------
            if (Convert.ToString(Session["USLKOD"]).IndexOf("v") > 0)
            {
                UslKodTxt = Convert.ToString(Session["USLKOD"]).Substring(Convert.ToString(Session["USLKOD"]).LastIndexOf(".") + 1, 4);
                SqlCommand cmdUsl = new SqlCommand("SELECT * FROM SprUslFrm WHERE UslFrmHsp=" + KodOrg + " AND UslFrmKod=" + UslKodTxt, con);
                SqlDataAdapter daUsl = new SqlDataAdapter(cmdUsl);
                daUsl.Fill(dsUsl);

                Header = @"<input name='Lab1' type='text' value='" +
                           Convert.ToString(ds.Tables[0].Rows[0]["ORGKLTNAM"]) +
                         @"' readonly='readonly' id='Lab1' style='color:White;background-color:PaleVioletRed;font-family:Verdana;font-size:20px;font-weight:bold;top: 0px; left: 0px; position: relative; width: 100%' />          
                <div style='text-align: left; float: left;'>
                    <img id='ImgDocOneMem' src='" +
                             ImgUrl +
                        @"' style='height:300px;width:300px;border-width:0px;' />
                </div>
                 <table width='650px'>
                    <tr>
                        <td>" +
                               Convert.ToString(dsUsl.Tables[0].Rows[0]["USLFRMAKZ"]) +
                            @"</td>
                    </tr>";

                // construct the final script
                Literal1.Text = Header + "</table>";

            }
            UpdatePanel("CallbackPanelDoc");
        }

        //------------------------------------------------------------------------
        public void FindKlt(string KLTFIO)
        {

            Session["KLTFIO"] = KLTFIO;

   //         sdsFnd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
   //         sdsFnd.SelectCommand = "HspKltFlt";
   //         sdsFnd.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;

            UpdatePanel("CallbackPanelFnd");

        }
        
        // -------------------------------------------------------

    </script>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
    
        $('button').mousedown(function(e) {
        alert("button");
            bool = !bool;
            if (bool) {
                $(this).unbind('click');
            }
            else {
                $(this).click(buttonClick);
            }
        });
   //     var windownumber = 0;
     //    ------------------ смена логотипа ----------------------------------------------------------
   //       var LogStr = getQueryString();
   //       document.getElementById("ctl00_Image2").src = "Logo/" + LogStr + ".jpg";
          
          function getQueryString() {
              var queryString = [];
              var vars = [];
              var hash;
              var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
              for (var i = 0; i < hashes.length; i++) {
                  hash = hashes[i].split('=');
           //     queryString.push(hash[0]);
           //     vars[hash[0]] = hash[1];
                  queryString.push(hash[1]);
              }
              return queryString;
          }
//    ----------------------------------------------------------------------------
        function ClientDate_Changed(sender, selectedDate) {
            var formattedDate;
   //         ob_em_SelectItem("item1");
  //          ContainerVisibility("divMedUslHsp", true);
  //          ContainerVisibility("divMedUslHspMap", false);

            formattedDate = sender.formatDate(selectedDate, "dd.MM.yyyy");
            LoadMedUsl005(USLKOD = document.getElementById('ctl00$MainContent$parUslKod').value, USLTYP = "к", USLDAT005 = formattedDate);
        }
        // ------------------------  проверка на выбор мед услуги в первой вкладке ------------------------------------------------------------------       
        // 1111111111111111111111111111111111111111111111111111111111111111111111111111111111 
        // ------------------------  при выборе первой вкладке (медуслуги)  ------------------------------------------------------------------       
        // ------------------------  при сдвиге даты на 5 дней на второй вкладке ------------------------------------------------------------------       
        function LoadMedUsl005(id, typ, dlt) {
            //     alert("LoadMedUsl005=" + id);
            if (id == '') id = '0';
            ob_post.AddParam("USLKOD", id);
            ob_post.AddParam("USLTYP", typ);
            ob_post.AddParam("USLDAT005", dlt);
            ob_post.post(null, "CreateMedUslHsp005", LoadMedUslHsp);
        }

        // 2222222222222222222222222222222222222222222222222222222222222222222222222222222
        // 333333333333333333333333333333333333333333333333333333333333333333333333333333333333
        // ------------------------  при выборе врача во второй вкладке ------------------------------------------------------------------       
        function LoadMedUslDoc(id, den) {
       //     alert("LoadMedUslDoc="+id);
            
            ob_post.AddParam("BUXKOD", id);
            ob_post.AddParam("BUXDAY", den);

            ob_post.post(null, "CreateMedUslDocGrf", function() { });
            //           document.getElementById('ctl00$MainContent$WinGrfDocDay_BoxDat').value=document.getElementById('ctl00$MainContent$grid2_ob_grid2HeaderContainer_ctl02_ctl'+(41+(den-1)*4)).textContent;
            WinGrfDocDay.Open();
/*
            //oWindowManager.newWindow(txtWinID,[txtUrl],[bClose],[bMaximize],[bStatusBar],[bResizable],[bDraggable],[bIsModal]); 
            var oWin = oWindowManager.newWindow("win" + windownumber, "http://www.google.com.vn");
            oWin.setTitle("obout Window " + windownumber);
            oWin.setPosition(250, 100);
            oWin.Open();
            windownumber++;
*/            
        }
        // ------------------------  окно рекламы врача ------------------------------------------------------------------       
        function LoadDocMem(id) {
            //                  alert("LoadMedUslDoc="+id);
            ob_post.AddParam("BUXKOD", id);
            ob_post.post(null, "CreateDocMem", function() { });
            WinDocMem.setTitle("ВРАЧ");
            WinDocMem.Open();
        }
        // ------------------------  окно рекламы клиники ------------------------------------------------------------------       

        // ------------------------  окно описание услуг ------------------------------------------------------------------       
        function LoadUslMem(id) {
            //                  alert("LoadMedUslDoc="+id);
   //         ob_post.AddParam("HSPNAM", id);
            ob_post.AddParam("BUXKOD", id);
            ob_post.post(null, "CreateUslMem", function() { });
            WinDocMem.setTitle("ОПИСАНИЕ УСЛУГИ");
            WinDocMem.Open();
        }
        // ------------------------  окно акции ------------------------------------------------------------------       
        function LoadAkzMem(id) {
            //                  alert("LoadMedUslDoc="+id);
     //       ob_post.AddParam("HSPNAM", id);
            ob_post.AddParam("BUXKOD", id);
            ob_post.post(null, "CreateAkzMem", function() { });
            WinDocMem.setTitle("ОПИСАНИЕ АКЦИИ");
            WinDocMem.Open();
        }
        // ------------------------  при выборе ячейки строки  -------------------------------------
        // ------------------------  показать рекламу Клиникаа   ---------------------------------------
        // ------------------------  показать рекламу врача    ---------------------------------------
        // ------------------------  показать описание         ---------------------------------------
        // ------------------------  показать акции            ---------------------------------------  
        // ------------------------  показать третью вкладку (график врача)  -----------------------      
        function onClick(rowIndex, cellIndex) {
            /*
            // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------
            
            var result = ""
            var d=document.getElementsByTagName("div");
            for (var i=0;i<d.length;i++)
            {
            result += "i="+i+" id="+d[i].id + " Text= " + d[i].innerText  + "\n"
            }
            alert(result);
              
            // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------	
            */
            //      alert("rowIndex=" + rowIndex + " cellIndex=" + cellIndex);
            //      alert('grid2.Rows[rowIndex].Cells[cellIndex].Value' + grid2.Rows[rowIndex].Cells[cellIndex].Value);

            var Ind = rowIndex + 2;
            var IndFix = ('0000' + Ind).slice(-2);   // с конца выделяем 2 символа

            // Панель клиники
   //         if (cellIndex == 2) {
   //             document.getElementById('ctl00$MainContent$parGrfHsp').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl04').textContent;
   //             LoadHspMem(HSPNAM = document.getElementById('ctl00$MainContent$parGrfHsp').value);
   //         }
            // Панель врача
            if (cellIndex == 4) {
                document.getElementById('ctl00$MainContent$parBuxKod').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl01').textContent;
                LoadDocMem(BUXKOD = document.getElementById('ctl00$MainContent$parBuxKod').value);
            }
            // Рейтинг врача
            
            // Панель описание услуг
            if (cellIndex == 6) {
                document.getElementById('ctl00$MainContent$parGrfHsp').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl04').textContent;
          //      LoadUslMem(HSPNAM = document.getElementById('ctl00$MainContent$parGrfHsp').value);
                LoadUslMem(BUXKOD = document.getElementById('ctl00$MainContent$parBuxKod').value);
            }
            // Панель акция
            if (cellIndex == 7) {
                document.getElementById('ctl00$MainContent$parGrfHsp').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl04').textContent;
                LoadAkzMem(BUXKOD = document.getElementById('ctl00$MainContent$parBuxKod').value);
        //        LoadAkzMem(HSPNAM = document.getElementById('ctl00$MainContent$parGrfHsp').value);
            }
            // Цена 8
            
            // Продолжительность 9

            // Панель график по дням
            if (cellIndex > 9) {
                // Проверить на отсутствие графика
                if (document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl' + (21 + (cellIndex - 8) * 2)).textContent == '') return;

                // код врача
                document.getElementById('ctl00$MainContent$parBuxKod').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl01').textContent;
                // день
                document.getElementById('ctl00$MainContent$parBuxDay').value = cellIndex - 9;
                // город
                document.getElementById('ctl00$MainContent$parGrfCty').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl02').textContent;
                // клиника
                document.getElementById('ctl00$MainContent$parGrfHsp').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl04').textContent;
                // Врач
                document.getElementById('ctl00$MainContent$parGrfDoc').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl16').textContent;
                // цена
                document.getElementById('ctl00$MainContent$parGrfZen').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl17').textContent;
                // дата
                //          document.getElementById('ctl00$MainContent$parGrfDat').value = document.getElementById('ctl00$MainContent$grid3_ob_grid3BodyContainer_ctl'+IndFix+'_ctl13').textContent;
                // время
                //          document.getElementById('ctl00$MainContent$parGrfTim').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl15').textContent;
                // длительность
                document.getElementById('ctl00$MainContent$parGrfMinMax').value = document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl23').textContent;               


                //              alert("клиника="+document.getElementById('ctl00$MainContent$parGrfHsp').value);
                //              alert("Врач="+document.getElementById('ctl00$MainContent$parGrfDoc').value);
                //              alert("цена="+document.getElementById('ctl00$MainContent$parGrfZen').value);
                //              alert("время="+document.getElementById('ctl00$MainContent$parGrfTim').value);   
                //              alert("врач="+document.getElementById('ctl00$MainContent$parBuxKod').value);   
                //              alert("день="+document.getElementById('ctl00$MainContent$parBuxDay').value);   

                LoadMedUslDoc(BUXKOD = document.getElementById('ctl00$MainContent$parBuxKod').value, BUXDAY = document.getElementById('ctl00$MainContent$parBuxDay').value);

            }

        }
        // 44444444444444444444444444444444444444444444444444444444444444444444444444444444444
        // --------------- при подводе курсора высвечивается график за день во втором окне  ------------------------------------------------------------------
        function handleMouseOver(rowIndex) {

            var Ind = rowIndex + 2;
            var IndFix = ('0000' + Ind).slice(-2);   // с конца выделяем 2 символа

            // Клиника 
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl05').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl05').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // Врач
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl11').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl11').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // Фото
            //     document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl15').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            //     document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl15').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // Рейтинг
            //      document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl13').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            //      document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl13').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // Описание
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl17').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl17').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // Акция
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl19').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl19').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // цена
            //         document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl21').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            //         document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl21').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // время
            //         document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl23').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            //         document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl23').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 1
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl25').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl25').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 2
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl27').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl27').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 3
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl29').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl29').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 4
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl31').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl31').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 5
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl33').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl33').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 6
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl35').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl35').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 7
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl37').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl37').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
            // 8
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl39').onmouseover = function() { this.style.fontSize = '14px'; this.style.color = 'red'; };
            document.getElementById('ctl00$MainContent$grid2_ob_grid2BodyContainer_ctl' + IndFix + '_ctl39').onmouseout = function() { this.style.fontSize = '12px'; this.style.color = 'black'; }
        }

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function onchanged01(checkbox, iRowIndex) 
        {
 //               alert("onchanged01=" + checkbox + " i=" + iRowIndex);
            var Ind = iRowIndex + 2;
            var IndFix = ('0000' + Ind).slice(-2);   // с конца выделяем 2 символа
            var TekBus = document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl16').textContent;
            var TekHtml008 = document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML;
            var TekHtml011 = document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11').innerHTML;

            // идентификатор записи
            var GrfIdn = document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl00').textContent;
            //            alert("GrfIdn="+GrfIdn);
            document.getElementById('ctl00$MainContent$parGrfIdn').value = GrfIdn;
            // Номер элемента
            document.getElementById('ctl00$MainContent$parIndFix').value = IndFix;
            // checkbox
            document.getElementById('ctl00$MainContent$parIndChk').value = checkbox;
            // Html
            document.getElementById('ctl00$MainContent$parIndHtml').value = TekHtml008;

            //           document.getElementById('ctl00$MainContent$FndFio').value = "";  // Ержигит О

            //            alert("checkbox1=" + checkbox + "  iRowIndex=" + iRowIndex);
            //            alert("GRFIDN=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl00').textContent);
            //            alert("GRFDAT=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl03').textContent);
            //            alert("GRFTIM=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl06').textContent);
            //            alert("GRFBUS=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').textContent);
            //            alert("GRFBUS=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11').textContent);
            //            alert("GRFPTH=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl12').textContent);
            //            alert("GRFPTH=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl13').textContent);
            //            alert("GRFWWW=" + document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl14').textContent);
            // --------------------------------------- если график занят (снять из приема) ---------------------------------------
 //           alert("onchanged02=" + checkbox + " TekBus=" + TekBus);
            if (checkbox == true) {
                if (TekBus == '@') {
                    checkbox = true;
        //            document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = TekHtml008;
        //            document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11').innerHTML = TekHtml011;
                    alert("Записан через Интернет!");
                }
                else {
                    $(".ConfirmDialogDel").dialog(
                          {
                              autoOpen: true,
                              width: 300,
                              height: 150,
                              modal: true,
                              zIndex: 20000,
                              buttons:
                              {
                                  "ОК": function() {
                                      document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl12').textContent = "";
                                      document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl14').textContent = "";
                                      OK_update();
                                      $(this).dialog("close");
                                      //           return true;
                                  },
                                  "Отмена": function() {
                               //       document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = TekHtml008;
                               //       document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11').innerHTML = TekHtml011;
                                      checkbox = false;
                                      $(this).dialog("close");
                                  }
                              }
                          });
                }

            }
            // --------------------------------------- если график пустой (записать на прием) ---------------------------------------            
            else {
                //              alert("checkbox4=" + checkbox + "  iRowIndex=" + iRowIndex);
                if (document.getElementById('ctl00$MainContent$FndFio').value == "") {
                    document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = TekHtml008;
                    document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11').innerHTML = TekHtml011;
                    alert("Клиент не указан ");
                }
                else {
                    //                   alert("checkbox5=" + checkbox + "  iRowIndex=" + iRowIndex);
                    document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl12').textContent = document.getElementById('ctl00$MainContent$FndFio').value;
                    document.getElementById('ctl00$MainContent$WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl14').textContent = document.getElementById('ctl00$MainContent$FndTel').value;
                    OK_update();
                }
            }
        }
        //------------------------  после ОК из окна сообщеня для почты  -------------------------------
        function OK_update() {
 //           alert("OK_update=");

            var iRecord = new Array();
            iRecord[0] = document.getElementById('ctl00$MainContent$parGrfIdn').value;
 //           alert("oRecord.GRFIDN=" + iRecord[0]);
            iRecord[1] = document.getElementById('ctl00$MainContent$parIndChk').value;
 //           alert("oRecord.GRFBUS=" + iRecord[1]);
            iRecord[2] = document.getElementById('ctl00$MainContent$FndFio').value;
 //           alert("oRecord.GRFPTH=" + iRecord[2]);
            iRecord[3] = document.getElementById('ctl00$MainContent$FndTel').value;
 //           alert("oRecord.GRFTEL=" + iRecord[3]);
            iRecord[4] = document.getElementById('ctl00$MainContent$FndAdr').value;
            //           alert("oRecord.GRFTEL=" + iRecord[3]);
            iRecord[5] = document.getElementById('ctl00$MainContent$FndCrd').value;
            //           alert("oRecord.GRFTEL=" + iRecord[3]);
            iRecord[6] = document.getElementById('ctl00$MainContent$FndFrm').value;
            //           alert("oRecord.GRFTEL=" + iRecord[3]);
            iRecord[7] = document.getElementById('ctl00$MainContent$FndBrt').value;
            //           iRecord[5] = document.getElementById('ctl00$MainContent$parGrfHsp').value;
            //           iRecord[6] = document.getElementById('ctl00$MainContent$parGrfDoc').value;
            //           iRecord[7] = "специальность";   //document.getElementById('ctl00$MainContent$parGrfSpz').value;
            //           iRecord[8] = "категория";   //document.getElementById('ctl00$MainContent$parGrfKat').value;
            //           iRecord[9] = document.getElementById('ctl00$MainContent$parGrfZen').value;
            //           iRecord[10] = document.getElementById('ctl00$MainContent$parGrfDat').value;
            //          iRecord[11] = document.getElementById('ctl00$MainContent$parGrfTim').value;
            //          iRecord[12] = "длительность";   //document.getElementById('ctl00$MainContent$parGrfMinMax').value;

 //           alert("oRecord.GRFADR=" + iRecord[4]);
            /*           
            alert("oRecord.GRFHSP="+iRecord[5]);
            alert("oRecord.GRFDOC="+iRecord[6]);
            alert("oRecord.GRFSPZ="+iRecord[7]);
            alert("oRecord.GRFKAT="+iRecord[8]);
            alert("oRecord.GRFZEN="+iRecord[9]);
            alert("oRecord.GRFDAT="+iRecord[10]);
            alert("oRecord.GRFTIM="+iRecord[11]);
            */
            ob_post.AddParam("DocGrf", iRecord);
 //           alert("OK_update2=");
            ob_post.post(null, "UpdateDocGrf", function() { });
 //           alert("OK_update3=");

            //         WinGrfDocDay.Close();
        }

        function ob_OnNodeSelect(id) {
        //    alert("OnNodeSelect id= " + id);
            // --------------------------------------------------------------
            // удалил из  скрипта ob_events_2041.js  функцию ob_OnNodeSelect
            // ---------------------------------------------------------------

            var UslKod = id.slice(4);         // Отбросить с начало 4 символ
//            var UslPar = id.slice(-1);
//            if (UslPar == "v") UslKod = id.slice(-5, -1); // выделить с конца с 5 по 1 символ

                document.getElementById('ctl00$MainContent$parUslKod').value = UslKod;
    //            ContainerVisibility("divMedUslHsp", true);
    //            ContainerVisibility("divMedUslHspMap", false);
    //            alert("UslKod= " + UslKod);

                ob_post.AddParam("USLKOD", UslKod);
                ob_post.post(null, "CreateMedUslHsp", LoadMedUslHsp);
            }
        
        // ------------------------  при выборе медуслуги в первой вкладке ------------------------------------------------------------------       
        function LoadMedUslHsp() {
            ob_post.UpdatePanel('CallbackPanel11');
        }
        //============== очистить фильтр ================================================================================
        function ClearFilter() {
   //         document.getElementById('ctl00$MainContent$FndFio').value = '';
            document.getElementById('ctl00$MainContent$FndTel').value = '';
            document.getElementById('ctl00$MainContent$FndAdr').value = '';
            document.getElementById('ctl00$MainContent$FndCrd').value = '';
            document.getElementById('ctl00$MainContent$FndFrm').value = '';
            document.getElementById('ctl00$MainContent$FndBrt').value = '';
            return false;
        }
        // ==================================== поиск клиента по фильтрам  ============================================
        function BuildFilter() {
            //                    alert("BuildFilter");
            ClearFilter();

            var KltFio = "";
            if (document.getElementById('ctl00$MainContent$FndFio').value != '') {
                KltFio = document.getElementById('ctl00$MainContent$FndFio').value;
 //               alert("KltFio=" + KltFio);
                ob_post.AddParam("KLTFIO", KltFio);
                ob_post.post(null, "FindKlt", function() { });
                FindWindow.Open();
            }

        }

   // ==================================== выбор из поискового окна  ============================
        function OnClientDblClick(iRecordIndex) {
 //           alert("OnClientDblClick2=" + iRecordIndex);
            var Ind = iRecordIndex + 2;
            var IndFix = ('0000' + Ind).slice(-2);   // с конца выделяем 2 символа
 //           alert("IndFix=" + IndFix);

/*
            alert("Idn_00,01=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl00').textContent);
            alert("Fam_02,03=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl02').textContent);
            alert("Ima_04,05=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl04').textContent);
            alert("Krt_06,07=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl06').textContent);
            alert("Frm_08,09=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl08').textContent);
            alert("Tel_10,11=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl10').textContent);
            alert("Adr_12,13=" + document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl12').textContent);
*/
            document.getElementById('ctl00$MainContent$FndFio').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl02').textContent+' '+
                                                                        document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl04').textContent;
            document.getElementById('ctl00$MainContent$FndCrd').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl06').textContent;
            document.getElementById('ctl00$MainContent$FndFrm').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl08').textContent;
            document.getElementById('ctl00$MainContent$FndTel').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl10').textContent;
            document.getElementById('ctl00$MainContent$FndAdr').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl12').textContent;
            document.getElementById('ctl00$MainContent$FndBrt').value = document.getElementById('ctl00$MainContent$FindWindow_gridFnd_ob_gridFndBodyContainer_ctl' + IndFix + '_ctl14').textContent.substr(0, 8);
            
            FindWindow.Close();
        }
                      
        function createNewWindow() {
            //oWindowManager.newWindow(txtWinID,[txtUrl],[bClose],[bMaximize],[bStatusBar],[bResizable],[bDraggable],[bIsModal]); 
            var oWin = oWindowManager.newWindow("win" + windownumber, "http://www.google.com.vn");
            oWin.setTitle("obout Window " + windownumber);
            oWin.setPosition(250, 100);
            oWin.Open();
            windownumber++;
        }
        
 		       
    </script>


    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>


    <%-- ============================  для передач значении  ============================================ --%>
    <asp:HiddenField ID="parFlg" runat="server" />
    <asp:HiddenField ID="parGrfIdn" runat="server" />
    <asp:HiddenField ID="parGrfCty" runat="server" />
    <asp:HiddenField ID="parGrfHsp" runat="server" />
    <asp:HiddenField ID="parGrfDoc" runat="server" />
    <asp:HiddenField ID="parGrfSpz" runat="server" />
    <asp:HiddenField ID="parGrfKat" runat="server" />
    <asp:HiddenField ID="parGrfZen" runat="server" />
    <asp:HiddenField ID="parGrfDat" runat="server" />
    <asp:HiddenField ID="parGrfTim" runat="server" />
    <asp:HiddenField ID="parGrfMinMax" runat="server" />
    <asp:HiddenField ID="parIndFix" runat="server" />
    <asp:HiddenField ID="parIndChk" runat="server" />
    <asp:HiddenField ID="parIndHtml" runat="server"/>

    <asp:HiddenField ID="parBuxKod" runat="server" />
    <asp:HiddenField ID="parBuxDay" runat="server" />
    <asp:HiddenField ID="parUslKod" runat="server" />
    <%-- ============================  для передач значении  ============================================ --%>

    <%-- =================  диалоговое окно для подтверждения записи документа  ============================================ --%>
   <div class="ConfirmDialogDel" title="Снятие записи на прием" style="display: none">
        Хотите снять прием ?
    </div>
    <%-- =================  Окно об отправки EMAIL на адрес клиента ============================================ --%>
    <div class="OkMessage" title=" Вы записались к врачу " style="display: none">
        <table>
            <tr>
                <td>На Ваш электронный адрес отправлен письмо о записи на прием. 
                    <br />
                    <br />
                    Откройте письмо и подтвердите запись к врачу в течений 30 минут.
                    <br />
                    <br />
                     Неподтвержденная запись снимается с записи к врачу через 30 минут
               </td>
            </tr>
        </table>
    </div>

   <%-- ============================  черта  ============================================#FF69B4 --%>
       <asp:TextBox ID="TextBox1"
            Text=""
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="1px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: -10px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>
 <%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
             Style="left: 0; position: relative; top: -10px; width: 100%; height: 30px;">
                   
         <asp:Label ID="Label1" runat="server" Text="Дата:" ></asp:Label>  
                   
         <asp:TextBox runat="server" ID="txtDate1" Width="70px" ReadOnly="true"/>
         <%-- ============================  первый календарь  ============================================ --%>
         <obout:Calendar ID="cal1" runat="server"
                StyleFolder="/Styles/Calendar/styles/default"
                DatePickerMode="true"
                ShowYearSelector="true"
                YearSelectorType="DropDownList"
                TitleText="Выберите год: "
                CultureName="ru-RU"
                OnClientDateChanged="ClientDate_Changed"
                TextBoxId="txtDate1"
                DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                                      
        <input id="ButClr" type="button" value="Поиск" 
               style="width: 50px; height: 25px;" onclick="BuildFilter()" />
                   
        <asp:Label ID="Label2" runat="server" Text="ФИО:" ></asp:Label>  
        
        <asp:TextBox id="FndFio" Width="150px" Height="20" RunAt="server" BackColor="#FFFFE0"  />
        
        <asp:Label ID="Label3" runat="server" Text="Тел.:" ></asp:Label>  
                  
        <asp:TextBox runat="server" id="FndTel" Width="100px" BackColor="#FFFFE0" />
        
        <asp:Label ID="Label4" runat="server" Text="Адр.:" ></asp:Label>  
                   
        <asp:TextBox runat="server" id="FndAdr" Width="170px" BackColor="#FFFFE0"/>
        
        <asp:Label ID="Label5" runat="server" Text="Карта:" ></asp:Label>  
                   
        <asp:TextBox runat="server" id="FndCrd" Width="50px" BackColor="#FFFFE0"/>
      
        <asp:Label ID="Label6" runat="server" Text="Фирма:" ></asp:Label>  
                   
        <asp:TextBox runat="server" id="FndFrm" Width="150px" BackColor="#FFFFE0"/>
      
        <asp:Label ID="Label7" runat="server" Text="Д/р:" ></asp:Label>  
                   
        <asp:TextBox runat="server" id="FndBrt" Width="70px" BackColor="#FFFFE0"/>

   </asp:Panel>               


  <%-- ============================  черта  ============================================ --%>

           <asp:TextBox ID="TextBox4" 
            Text=""
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="1px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: -20px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>

        <%-- ============================  для отображение дерево  #DB7093============================================ --%>

        <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Auto" Style="border-style: outset; border-width:1px; left: -5px; position: relative; top: -15px; width: 20%; height: 630px;">

          	<asp:Literal id="TreeView1" EnableViewState="false" runat="server"  />

        </asp:Panel>

        <%-- ============================  для отображение вкладок услуг и врачей 0680 ============================================ --%>

        <asp:Panel ID="PanelRight" runat="server" ScrollBars="None" Style="border-style:  none; border-width:1px; left: 21%; position: relative; top: -650px; width: 79%; height: 630px;">

            <input type="hidden" id="hiddenServerEvent" runat="server" />

                <oajax:CallbackPanel ID="CallbackPanel11" runat="server" >
                    <Content>

                        <obout:Grid ID="grid2" runat="server"
                            ShowFooter="false"
                            CallbackMode="true"
                            Serialize="true" 
                            FolderLocalization="~/Localization"
                            Language="ru"
                            AutoGenerateColumns="false"
                            FolderStyle="~/Styles/Grid/style_5"
                            AllowAddingRecords="false"
                            ShowColumnsFooter="false"
                            AllowRecordSelection="false"
                            KeepSelectedRecords="false"
                            OnRowDataBound="OnRowDataBound_Handle"
                            AutoPostBackOnSelect="false"
                            AllowColumnResizing="true"
                            AllowSorting="false"
                            DataSourceID="sdsTab002"
                            Width="100%"
                            AllowPaging="false"
                            AllowPageSizeSelection="false"
                            PageSize="-1">
                            <ScrollingSettings ScrollHeight="600" />
                            <Columns>
                                <obout:Column ID="Column20" DataField="BUXKOD" HeaderText="Врач" ReadOnly="true" Visible="false"  Width="0%"/>
                                <obout:Column ID="Column21" DataField="CITY" HeaderText="Город" ReadOnly="true" Width="0%" Wrap="true"  Align="center"/>
                                <obout:Column ID="Column22" DataField="ORGKLTNAM" HeaderText="Клиника" ReadOnly="true" Width="0%" Wrap="true" Align="center" />
                                <obout:Column ID="Column23" DataField="KDRPIC" HeaderText="Фото" Width="14%" Align="center">
                                    <TemplateSettings TemplateId="ImageTemplate" />
                                </obout:Column>
                                <obout:Column ID="Column24" DataField="FIODLG" HeaderText="Врач" Width="17%" Wrap="true" Align="center">
                                    <TemplateSettings TemplateId="TemplateFIO" />
                                </obout:Column>
                                <obout:Column ID="Column25" DataField="KDRRAT" HeaderText="Рейт" ReadOnly="true" Visible="false"  Width="0%"/>
                                <obout:Column ID="Column26" DataField="MEM" HeaderText="Усл" ReadOnly="true" Width="5%" Align="center" />
                                <obout:Column ID="Column27" DataField="AKZ" HeaderText="Акц" ReadOnly="true" Width="5%" Align="center" />
                                <obout:Column ID="Column28" DataField="UslFrmZen" HeaderText="Цена" ReadOnly="true" Width="6%" Align="center" />
                                <obout:Column ID="Column29" DataField="TIMMINMAX" HeaderText="Минут" ReadOnly="true" Width="5%" Align="center"/>
                                <obout:Column ID="Column301" DataField="DAY1" HeaderText="001" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column302" DataField="DAY2" HeaderText="002" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column303" DataField="DAY3" HeaderText="003" ReadOnly="true" Width="6%" Wrap="true" Align="center"/>
                                <obout:Column ID="Column304" DataField="DAY4" HeaderText="004" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column305" DataField="DAY5" HeaderText="005" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column306" DataField="DAY6" HeaderText="006" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column307" DataField="DAY7" HeaderText="007" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                                <obout:Column ID="Column308" DataField="DAY8" HeaderText="008" ReadOnly="true" Width="6%" Wrap="true" Align="center" />
                            </Columns>
                           <Templates>
                                <obout:GridTemplate runat="server" ID="ImageTemplate">
				                	<Template>
				                	        <img src="/DoctorFoto/<%# Container.Value %>" alt="" width="100" height="100" />
				              	    </Template>
		                		</obout:GridTemplate>
                                 <obout:GridTemplate runat="server" ID="TemplateFIO">
                                    <Template>
                                        <b><%# Container.Value %></b>
                                    </Template>
                                </obout:GridTemplate>

                            </Templates>
                        </obout:Grid>
                    </Content>

                </oajax:CallbackPanel>
<%-- ============================  для отображение карты с клиниками ============================================ 
--%>

        </asp:Panel>
        
        <%-- ============================  для отображение рекламы правая колонка ============================================ --%>

          <%-- ============================  источники записей  ============================================ --%>
            <asp:SqlDataSource runat="server" ID="sdsTab002"
                SelectCommand="HspDocDatTimHsp" SelectCommandType="StoredProcedure"
                ConnectionString="Data Source=localhost;Integrated Security=SSPI; Initial Catalog=HOSPBASE;"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="BUXFRMKOD" Name="BUXFRMKOD" Type="String" />
                    <asp:SessionParameter SessionField="USLKOD" Name="USLKOD" Type="String" />
                    <asp:SessionParameter SessionField="USLDAT" Name="USLDAT" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource runat="server" ID="sdsGrfDoc" 
                 SelectCommand="ShpUslHspDocGrf" SelectCommandType="StoredProcedure"
                ConnectionString="Data Source=localhost;Integrated Security=SSPI; Initial Catalog=HOSPBASE;"
                ProviderName="System.Data.SqlClient">
               <SelectParameters>
                    <asp:SessionParameter SessionField="BUXKOD" Name="BUXKOD" Type="String" />
                    <asp:SessionParameter SessionField="USLDATDAY" Name="USLDAT" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

             <asp:SqlDataSource runat="server" ID="sdsFnd" 
                  SelectCommand="HspKltFlt" SelectCommandType="StoredProcedure"
                  ConnectionString="Data Source=localhost;Integrated Security=SSPI; Initial Catalog=HOSPBASE;"
                  ProviderName="System.Data.SqlClient">
               <SelectParameters>
                    <asp:SessionParameter SessionField="KLTFIO" Name="KLTFIO" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            
            <asp:SqlDataSource runat="server" ID="sdsCty" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    <owd:Window ID="WinGrfDocDay" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        Left="400" Top="100" Height="800" Width="550" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="График приема врача">

        <oajax:CallbackPanel ID="CallbackPanel12" runat="server">
            <Content>

                <asp:TextBox ID="BoxFio"
                    Text=""
                    BackColor="#DB7093"
                    Font-Names="Verdana"
                    Font-Size="20px"
                    Font-Bold="True"
                    ForeColor="White"
                    Style="top: 0px; left: 0px; position: relative; width: 100%"
                    runat="server"></asp:TextBox>

                <div style="text-align: left; float: left">

                <asp:Image ID="ImgDocOne" runat="server" Width="120" Height="120" ImageUrl="" />
 
                        
                </div>

                <table>
                    <tr>
                        <td>Клиника:</td>
                        <td>
                            <asp:TextBox runat="server" ID="BoxHsp" Text="" Font-Bold="true" Style="top: 0px; left: 0px; position: relative; border-style: none; width: 250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Врач:</td>
                        <td>
                            <asp:TextBox runat="server" ID="BoxSpz" Text="" Font-Bold="true" Style="top: 0px; left: 0px; position: relative; border-style: none; width: 250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Стаж:</td>
                        <td>
                            <asp:TextBox runat="server" ID="BoxStg" Text="" Font-Bold="true" Style="top: 0px; left: 0px; position: relative; border-style: none; width: 250px" />
                        </td>
                    </tr>
                </table>

                <asp:TextBox ID="BoxDat"
                    Text=""
                    BackColor="#DB7093"
                    Font-Names="Verdana"
                    Font-Size="20px"
                    Font-Bold="True"
                    ForeColor="White"
                    Style="top: 0px; left: 0px; position: relative; width: 1250px"
                    runat="server"></asp:TextBox>

                <obout:Grid ID="grid4" runat="server"
                    ShowFooter="false"
                    AllowSorting="false"
                    AllowPaging="false"
                    AllowPageSizeSelection="false"
                    FolderLocalization="~/Localization"
                    Language="ru"
                    CallbackMode="false"
                    Serialize="true"
                    AutoGenerateColumns="false"
                    FolderStyle="~/Styles/Grid/style_5"
                    AllowAddingRecords="false"
                    ShowColumnsFooter="false"
                    AllowMultiRecordSelection="false"
                    KeepSelectedRecords="false"
                    DataSourceID="sdsGrfDoc"
                    Width="100%"
                    PageSize="-1">
                    <Columns>
                        <obout:Column ID="Column1" DataField="GRFIDN" HeaderText="Идн" ReadOnly="true" Visible="false" />
                        <obout:Column ID="Column2" DataField="GRFDAT" DataFormatString="{0:dd.MM}" HeaderText="Дата" ReadOnly="true" Width="10%" />
                        <obout:Column ID="Column3" DataField="GRFBEG" DataFormatString="{0:HH:mm}" HeaderText="Время" ReadOnly="true" Width="8%" />
                        <obout:Column ID="Column4" DataField="GRFBUS" HeaderText="Занят" Width="7%">
                            <TemplateSettings TemplateId="tplBus04" />
                        </obout:Column>
                        <obout:Column ID="Column5" DataField="FIO" HeaderText="Пациент" ReadOnly="true" Width="40%" />
                        <obout:Column ID="Column6" DataField="GRFTEL" HeaderText="Телефон" ReadOnly="true" Width="30%" />
                        <obout:Column ID="Column7" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="5%" />
                    </Columns>
                    <Templates>
                        <obout:GridTemplate runat="server" ID="tplBus04">
                            <Template>
                                 <input type="checkbox" onmousedown="onchanged01(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                            </Template>
                      </obout:GridTemplate>
                    </Templates>

                </obout:Grid>

            </Content>
        </oajax:CallbackPanel>

    </owd:Window>
<%--
                                 <input type="checkbox" onclick="updateSent01(this.checked, <%# Container.PageRecordIndex %>);" <%# Container.Value == "True" ? "checked='checked'" : "" %> /> 
     
--%>
     <%-- =================  диалоговое окно для подтверждения снятие записи с приема  ============================================ --%> 
     <!--     Dialog должен быть раньше Window-->
     <owd:Dialog ID="ConfirmDialogDel" runat="server" Visible="true" VisibleOnLoad="false" 
                 IsModal="true" Position="CUSTOM" Top="200" Left="600" Width="300" 
                 Height="180" StyleFolder="/Styles/Window/wdstyles/default" 
                 Title="Снять клиента с записи" zIndex="10" ShowCloseButton="false">
           <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите снять запись ? </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <asp:Button runat="server" ID="OK" Text="ОК" OnClientClick="OK_click()"  />
                              <input type="button" value="Отмена" onclick="Cancel_click()" />
                        </td>
                    </tr>
                </table> 
            </center>
    </owd:Dialog>
    
     <%-- ============================  для отображение рекламы клиники ============================================ --%>
     <%-- ============================  для отображение рекламы врача ============================================      --%>
     <%-- ============================  для отображение описание услуги ============================================      --%>
     <%-- ============================  для отображение акции ============================================      --%>
     
    <owd:Window ID="WinDocMem" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        Left="200" Top="100" Height="500" Width="1000" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="">

        <oajax:CallbackPanel ID="CallbackPanelDoc" runat="server">
            <Content>
                        <%--Place holder to fill with javascript by server side code--%>
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <%--Place for google to show your MAP--%>

            </Content>
        </oajax:CallbackPanel>

      </owd:Window> 
     
   <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="FindWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="200" Top="100" Height="500" Width="1000" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Поиcк клиента">
        
            <oajax:CallbackPanel ID="CallbackPanelFnd" runat="server">
             <Content>           
              <obout:Grid ID="gridFnd"
                  runat="server"
                  CallbackMode="true"
                  Serialize="true"
                  AutoGenerateColumns="false"
                  FolderStyle="~/Styles/Grid/style_5"
                  AllowAddingRecords="false"
                  ShowLoadingMessage="true"
                  ShowColumnsFooter="false"
                  KeepSelectedRecords="true"
                  PageSize="-1"
                  DataSourceID="sdsFnd"
                  ShowFooter="false">
                  <ClientSideEvents OnClientDblClick="OnClientDblClick" />
                  <Columns>
                    <obout:Column DataField="KLTIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column DataField="KLTFAM" HeaderText="Фамилия" Width="120" />
                    <obout:Column DataField="KLTIMA" HeaderText="Имя" Width="120" />
                    <obout:Column DataField="KLTKRT" HeaderText="Карта" Width="120" />
                    <obout:Column DataField="KLTFRMTXT" HeaderText="Фирма" Width="120" />
                    <obout:Column DataField="KLTTHN" HeaderText="Телефон" Width="120" />
                    <obout:Column DataField="KLTADR" HeaderText="Адрес" Width="120" />
                    <obout:Column DataField="KLTBRT" DataFormatString="{0:dd.MM.yy}" HeaderText="Дата рож" Width="150" />
                </Columns>
                <ScrollingSettings ScrollHeight="460" ScrollWidth="920" />
              </obout:Grid>
              
             </Content>
           </oajax:CallbackPanel>
             
          </owd:Window>
          
        

</asp:Content>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

 <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;
         //         alert("DocAppAmbPsm");


         //    ------------------ смена логотипа ----------------------------------------------------------
         function getQueryString() {
             var queryString = [];
             var vars = [];
             var hash;
             var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
             //           alert("hashes=" + hashes);
             for (var i = 0; i < hashes.length; i++) {
                 hash = hashes[i].split('=');
                 queryString.push(hash[0]);
                 vars[hash[0]] = hash[1];
                 queryString.push(hash[1]);
             }
             return queryString;
         }

         </script>

</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string BuxKod;
      string KltIIN = "";
      string whereClause = "";

      string MdbNam = "HOSPBASE";
      //=============Установки===========================================================================================
      protected void Page_Load(object sender, EventArgs e)
      {
          //=====================================================================================
          BuxSid = (string)Session["BuxSid"];
          BuxFrm = (string)Session["BuxFrmKod"];
          BuxKod = (string)Session["BuxKod"];
          parBuxKod.Value = BuxKod;
          //           KltIIN = (string)Session["KltIIN"];
          KltIIN = Convert.ToString(Request.QueryString["KltIIN"]);
          parCrdIdn.Value = KltIIN;


          if (!Page.IsPostBack)
          {
              getDocNum();
          }
      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNum()
      {
          string TekDat;
          int Z13_6=0;
          int Z13_5=0;
          int Z13_1=0;
          int Z12_4=0;
          int Z12_3=0;
          int Z12_8=0;
          int Z12_5=0;
          int Z12_0=0;
          int Z00_0=0;
          int Sex=0;

          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAisScrLstDocIin", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@KLTIIN", SqlDbType.VarChar).Value = KltIIN;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAisScrLstDocIin");

          con.Close();

          if (ds.Tables[1].Rows.Count > 0)
          {
              if (KltIIN.Substring(6, 1) == "1" || KltIIN.Substring(6, 1) == "3" || KltIIN.Substring(6, 1) == "5") Sex = 1;

              //  28. Қанайналым жүйесі және қант диабеті ауруларын анықтайтын тексерудің нәтижесі (Результаты обследования на выявление болезней системы кровообращения и сахарного диабета) (18,25,30,35,40,42,44,46,48,50,52,54,56,58,60,62,64 жылғы/года)
              foreach (DataRow row in ds.Tables[1].Rows)
              {
                  if (row["ScrDtlDig"].ToString() == "Z13.6") Z13_6 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z13.5") Z13_5 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z13.1") Z13_1 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z12.4") Z12_4 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z12.3") Z12_3 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z12.8") Z12_8 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z12.0") Z12_0 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z12.5") Z12_5 = 1;
                  if (row["ScrDtlDig"].ToString() == "Z00.0") Z00_0 = 1;
              }
          }

          //  27. Тек әйелдер үшін (Только для женщин): ----------------------------------------------------------------------------------------------------------  -->
          if (Sex == 1)
          {
              LabKrv.Visible = false;
              BoxKrv.Visible = false;
          }
          //  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
          if (Z13_6 == 0)
          {
              LabEkg.Visible = false;
              BoxEkg.Visible = false;
          }
          //  28.2 Уровень холестерина ----------------------------------------------------------------------------------------------------------  -->
          if (Z13_1 == 0)
          {
              LabEkg.Visible = false;
              LabSax.Visible = false;
              BoxXol.Visible = false;
              BoxSax.Visible = false;
          }
          // 29.Результаты обследования на выявление глаукомы: ----------------------------------------------------------------------------------------------------------  -->
          if (Z13_5 == 0)
          {
              LabZrnDav.Visible = false;
              BoxZrnDav.Visible = false;
          }
         // 30.1 Цитологическое исследование мазков:  ----------------------------------------------------------------------------------------------------------  -->
          if (Z12_4 == 0)
          {
              LabZit.Visible = false;
              LabKol.Visible = false;
              LabBio.Visible = false;
              BoxZit.Visible = false;
              BoxKol.Visible = false;
              BoxBio.Visible = false;
          }
          // 30.4 Маммография (Маммография (50,52,54,56,58,60 жастан/лет):   ----------------------------------------------------------------------------------------------------------  -->
          if (Z12_3 == 0)
          {
              LabMam.Visible = false;
              LabMamScr.Visible = false;
              BoxMam.Visible = false;
              BoxMamScr.Visible = false;
          }
          // 30.6 Гемокульт-тест:  ----------------------------------------------------------------------------------------------------------  -->
          if (Z12_8 == 0)
          {
              LabGem.Visible = false;
              LabGemTst.Visible = false;
              LabGemKol.Visible = false;
              BoxGem.Visible = false;
              BoxGemTst.Visible = false;
              BoxGemKol.Visible = false;
          }
          // 30.9 Эзофагоскопия  ----------------------------------------------------------------------------------------------------------  -->
          if (Z12_0 == 0)
          {
              LabEzo.Visible = false;
              LabFgs.Visible = false;
              BoxEzo.Visible = false;
              BoxFgs.Visible = false;
          }
          // 30.11 Результаты ПСА (ерлер 50,54,58,62,66 жас)  ----------------------------------------------------------------------------------------------------------  -->
          if (Z12_5 == 0)
          {
              LabPca.Visible = false;
              LabPca001.Visible = false;
              LabPca002.Visible = false;
              LabPca003.Visible = false;
              BoxPca.Visible = false;
              BoxPca001.Visible = false;
              BoxPca002.Visible = false;
              BoxPca003.Visible = false;
          }



          if (ds.Tables[0].Rows.Count > 0)
          {
              //     obout:OboutTextBox ------------------------------------------------------------------------------------      

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKrv"].ToString())) BoxKrv.SelectedIndex = 0;
              else BoxKrv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKrv"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrEkg"].ToString())) BoxEkg.SelectedIndex = 0;
              else BoxEkg.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrEkg"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrXol"].ToString())) BoxXol.SelectedIndex = 0;
              else BoxXol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrXol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrSax"].ToString())) BoxSax.SelectedIndex = 0;
              else BoxSax.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrSax"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnDav"].ToString())) BoxZrnDav.SelectedIndex = 0;
              else BoxZrnDav.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnDav"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZit"].ToString())) BoxZit.SelectedIndex = 0;
              else BoxZit.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZit"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKol"].ToString())) BoxKol.SelectedIndex = 0;
              else BoxKol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrBio"].ToString())) BoxBio.SelectedIndex = 0;
              else BoxBio.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrBio"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrMam"].ToString())) BoxMam.SelectedIndex = 0;
              else BoxMam.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrMam"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrMamScr"].ToString())) BoxMamScr.SelectedIndex = 0;
              else BoxMamScr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrMamScr"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGem"].ToString())) BoxGem.SelectedIndex = 0;
              else BoxGem.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGem"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGemTst"].ToString())) BoxGemTst.SelectedIndex = 0;
              else BoxGemTst.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGemTst"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKln"].ToString())) BoxGemKol.SelectedIndex = 0;
              else BoxGemKol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKln"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrEzo"].ToString())) BoxEzo.SelectedIndex = 0;
              else BoxEzo.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrEzo"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrFgs"].ToString())) BoxFgs.SelectedIndex = 0;
              else BoxFgs.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrFgs"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPca"].ToString())) BoxPca.SelectedIndex = 0;
              else BoxPca.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPca"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPca001"].ToString())) BoxPca001.SelectedIndex = 0;
              else BoxPca001.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPca001"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPca002"].ToString())) BoxPca002.SelectedIndex = 0;
              else BoxPca002.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPca002"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPca003"].ToString())) BoxPca003.SelectedIndex = 0;
              else BoxPca003.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPca003"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResZdr"].ToString())) BoxZdr.SelectedIndex = 0;
              else BoxZdr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResZdr"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResNas"].ToString())) Chk001.Checked = false;
              else Chk001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResNas"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip001"].ToString())) Chk002.Checked = false;
              else Chk002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip001"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip002"].ToString())) Chk003.Checked = false;
              else Chk003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip002"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResGip003"].ToString())) Chk004.Checked = false;
              else Chk004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrResGip003"]);

          }

          //          string name = value ?? string.Empty;
      }

      // ============================ проверка и опрос для записи документа в базу ==============================================
      protected void Save_Click(object sender, EventArgs e)
      {
          bool ScrResNas = false;
          bool ScrResGip001 = false;
          bool ScrResGip002 = false;
          bool ScrResGip003 = false;
          //=====================================================================================
          //        BuxSid = (string)Session["BuxSid"];
          BuxFrm = (string)Session["BuxFrmKod"];
          //=====================================================================================
          if (Convert.ToString(Chk001.Text) == "Checked = true") ScrResNas = true;
          else ScrResNas = Chk001.Checked;
          if (Convert.ToString(Chk002.Text) == "Checked = true") ScrResGip001 = true;
          else ScrResGip001 = Chk002.Checked;
          if (Convert.ToString(Chk003.Text) == "Checked = true") ScrResGip002 = true;
          else ScrResGip002 = Chk003.Checked;
          if (Convert.ToString(Chk004.Text) == "Checked = true") ScrResGip003 = true;
          else ScrResGip003 = Chk004.Checked;

          //      if (Convert.ToString(TxtXol.Text) == null || Convert.ToString(TxtXol.Text) == "") TxtXol.Text = "0";
          //      if (Convert.ToString(TxtSax.Text) == null || Convert.ToString(TxtSax.Text) == "") TxtSax.Text = "0";

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisScr002Upd", con);
          cmd = new SqlCommand("HspAisScr002Upd", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@SCRIIN", SqlDbType.VarChar).Value = KltIIN;
          cmd.Parameters.Add("@ScrXolVal", SqlDbType.Decimal).Value = "0.0";
          cmd.Parameters.Add("@ScrSaxVal", SqlDbType.Decimal).Value = "0.0";

          cmd.Parameters.Add("@ScrKrv", SqlDbType.VarChar).Value = BoxKrv.SelectedIndex;
          cmd.Parameters.Add("@ScrEkg", SqlDbType.VarChar).Value = BoxEkg.SelectedIndex;
          cmd.Parameters.Add("@ScrXol", SqlDbType.VarChar).Value = BoxXol.SelectedIndex;
          cmd.Parameters.Add("@ScrSax", SqlDbType.VarChar).Value = BoxSax.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnDav", SqlDbType.VarChar).Value = BoxZrnDav.SelectedIndex;

          cmd.Parameters.Add("@ScrZit", SqlDbType.VarChar).Value = BoxZit.SelectedIndex;
          cmd.Parameters.Add("@ScrKol", SqlDbType.VarChar).Value = BoxKol.SelectedIndex;
          cmd.Parameters.Add("@ScrBio", SqlDbType.VarChar).Value = BoxBio.SelectedIndex;
          cmd.Parameters.Add("@ScrMam", SqlDbType.VarChar).Value = BoxMam.SelectedIndex;
          cmd.Parameters.Add("@ScrMamScr", SqlDbType.VarChar).Value = BoxMamScr.SelectedIndex;

          cmd.Parameters.Add("@ScrGem", SqlDbType.VarChar).Value = BoxGem.SelectedIndex;
          cmd.Parameters.Add("@ScrGemTst", SqlDbType.VarChar).Value = BoxGemTst.SelectedIndex;
          cmd.Parameters.Add("@ScrKln", SqlDbType.VarChar).Value = BoxGemKol.SelectedIndex;

          cmd.Parameters.Add("@ScrEzo", SqlDbType.VarChar).Value = BoxEzo.SelectedIndex;
          cmd.Parameters.Add("@ScrFgs", SqlDbType.VarChar).Value = BoxFgs.SelectedIndex;
          cmd.Parameters.Add("@ScrPca", SqlDbType.VarChar).Value = BoxPca.SelectedIndex;
          cmd.Parameters.Add("@ScrPca001", SqlDbType.VarChar).Value = BoxPca001.SelectedIndex;
          cmd.Parameters.Add("@ScrPca002", SqlDbType.VarChar).Value = BoxPca002.SelectedIndex;
          cmd.Parameters.Add("@ScrPca003", SqlDbType.VarChar).Value = BoxPca003.SelectedIndex;

          cmd.Parameters.Add("@ScrResZdr", SqlDbType.VarChar).Value = BoxZdr.SelectedIndex;

          cmd.Parameters.Add("@ScrResNas", SqlDbType.Bit, 1).Value = ScrResNas;
          cmd.Parameters.Add("@ScrResGip001", SqlDbType.Bit, 1).Value = ScrResGip001;
          cmd.Parameters.Add("@ScrResGip002", SqlDbType.Bit, 1).Value = ScrResGip002;
          cmd.Parameters.Add("@ScrResGip003", SqlDbType.Bit, 1).Value = ScrResGip003;

          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();
      }

  </script>   
    
<body>
    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parSblNum" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <span id="WindowPositionHelper"></span>
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ 

        <asp:TextBox ID="Sapka" 
             Text="ПРИЕМ И ОСМОТР ВРАЧА" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
        --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: -5px; width: 100%; height: 500px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                <!--  27. Тек әйелдер үшін (Только для женщин): Сізде жыныстық қатынастан кейінгі қан кетулер болады ма (бывают ли у Вас контактные кровотечения):  ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="LabKrv" Text="Только для женщин: бывают ли у Вас контактные кровотечения:" runat="server" Width="50%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKrv" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem129" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem130" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem131" runat="server" Text="да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

               <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label1" Text="28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета:" runat="server" Width="100%" Font-Bold="true" ForeColor="#0000cc" />
                    </td>
                </tr>
                <tr>
                    <td class="fics" >
                        <asp:Label ID="LabEkg" Text="28.1 ЭКГ:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxEkg" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="норма" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="патология" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="не проведена" Value="3" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LabXol" Text=" 28.2 Уровень холестерина:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxXol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="5.2 ммоль/л" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text=">5.2 ммоль/л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text=">состоит на дисп у" Value="3" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="LabSax" Text=" 28.3 Глюкоза:" runat="server" Width="10%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxSax" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="3.88-5.55 ммоль/л" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text=">5.5 ммоль/л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="состоит на дисп у." Value="3" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <!--  29.Результаты обследования на выявление глаукомы: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label7" Text="29.Результаты обследования на выявление глаукомы:" runat="server" Width="40%" Font-Bold="true" />
                        <asp:Label ID="LabZrnDav" Text="29.1 Глазное давление:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnDav" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem45" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem46" runat="server" Text="Норма" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem47" runat="server" Text=">Повышение" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem75" runat="server" Text=">Состоит на дисп у." Value="3" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

                 <!--  30.Результаты обследования на выявление предопухлевых и опухолевых заболеваний ----------------------------------------------------------------------------------------------------------  -->
                 <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label2" Text="30.Результаты обследования на выявление предопухлевых и опухолевых заболеваний:" runat="server" Width="100%" Font-Bold="true" ForeColor="#0000cc" />
                    </td>
                </tr>

                <!--  30.1 Цитологическое исследование мазков: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="LabZit" Text="30.1 Цитологическое исследование мазков:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZit" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="норма" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="микроорганизмы" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="другие изменения эпителиальных клеток" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem48" runat="server" Text="ASC-US" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem49" runat="server" Text="ASC-H" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem50" runat="server" Text="LSIL" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem51" runat="server" Text="HSIL" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem52" runat="server" Text="CIS" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem53" runat="server" Text="рак" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem54" runat="server" Text="другое (эндометриальные клетки у женщин старше 40 лет)" Value="10" />
                                <obout:ComboBoxItem ID="ComboBoxItem55" runat="server" Text="не проведена" Value="11" />
                                <obout:ComboBoxItem ID="ComboBoxItem56" runat="server" Text="состоит на диспансерном учете" Value="13" />
                            </Items>
                        </obout:ComboBox>

                <!--  30.2 Кольпоскопия по показаниям: ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabKol" Text="30.2 Кольпоскопия по показаниям:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem9" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="проведена" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="не проведена" Value="2" />
                            </Items>
                        </obout:ComboBox>

                <!--  30.3 Результат биопсии шейки матки (по показаниям): ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabBio" Text="30.3 Результат биопсии шейки матки (по показаниям):" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxBio" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="другое" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="CIN I" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="CIN II" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="CIN III" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem57" runat="server" Text="CIS" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem58" runat="server" Text="AIS" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem59" runat="server" Text="рак" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem60" runat="server" Text="не проведена" Value="8" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
 
                <!--  30.4 Маммография (50,52,54,56,58 и 60 лет): ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="LabMam" Text="30.4 Маммография (50,52,54,56,58 и 60 лет):" runat="server" Width="30%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxMam" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="М1" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem19" runat="server" Text=">М2" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem20" runat="server" Text=">M3" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem61" runat="server" Text=">M4" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem62" runat="server" Text=">M5" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem63" runat="server" Text=">M6a" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem64" runat="server" Text=">M6б" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem65" runat="server" Text=">не проведена" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem66" runat="server" Text="Состоит на дисп у." Value="9" />
                            </Items>
                        </obout:ComboBox>
  
                <!--  30.5 Обследована маммографически по скринингу: ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabMamScr" Text="30.5 Обследована маммографически по скринингу:" runat="server" Width="30%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxMamScr" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem21" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem22" runat="server" Text="впервые" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text=">повторно" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                                             
                 <!--  30.6 Гемокульт-тест: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" >
                        <asp:Label ID="LabGem" Text="30.6 Гемокульт-тест:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGem" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem76" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem77" runat="server" Text="Положительный" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem78" runat="server" Text="Отрицательный" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem79" runat="server" Text="Не проведен" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem80" runat="server" Text="Состоит на дисп. учете" Value="4" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LabGemTst" Text="30.7 Гемокульт-тест по скринингу:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGemTst" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem81" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem82" runat="server" Text="Впервые" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem83" runat="server" Text="Повторно" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LabGemKol" Text="30.8 Колоноскопия:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGemKol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem84" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem85" runat="server" Text="KS1" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem86" runat="server" Text="KS2" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem87" runat="server" Text="KS3" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem88" runat="server" Text="KS4" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem89" runat="server" Text="KS5а" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem90" runat="server" Text="KS5б" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem91" runat="server" Text="KS6" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem92" runat="server" Text="KS8" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem93" runat="server" Text="Не проведена" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem94" runat="server" Text="Отказ пациента" Value="10" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

  
                <!--  30.9 Эзофагоскопия: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="LabEzo" Text="30.9 Эзофагоскопия:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxEzo" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="ESI" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="ES2" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="ES3" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="ES4" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem67" runat="server" Text="ES5" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem68" runat="server" Text="ES6" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem69" runat="server" Text="ES7" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem70" runat="server" Text="ES8" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem71" runat="server" Text="ES9" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem72" runat="server" Text="ES10" Value="10" />
                                <obout:ComboBoxItem ID="ComboBoxItem73" runat="server" Text="ES11" Value="11" />
                                <obout:ComboBoxItem ID="ComboBoxItem74" runat="server" Text="ES12" Value="12" />
                                <obout:ComboBoxItem ID="ComboBoxItem98" runat="server" Text="не проведена" Value="13" />
                                <obout:ComboBoxItem ID="ComboBoxItem99" runat="server" Text="состоит на диспансерском учете" Value="14" />
                          </Items>
                        </obout:ComboBox>
  
                <!--  30.10 Гастродуоденоскопия: ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabFgs" Text="30.10 Гастродуоденоскопия:" runat="server" Width="35%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxFgs" Width="25%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="GSI" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="GS2" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="GS3" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem100" runat="server" Text="GS4" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem101" runat="server" Text="GS5" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem102" runat="server" Text="GS6" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem103" runat="server" Text="GS7" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem104" runat="server" Text="GS8" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem105" runat="server" Text="GS9" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem106" runat="server" Text="GS10" Value="10" />
                                <obout:ComboBoxItem ID="ComboBoxItem107" runat="server" Text="GS11" Value="11" />
                                <obout:ComboBoxItem ID="ComboBoxItem108" runat="server" Text="не проведена" Value="12" />
                                <obout:ComboBoxItem ID="ComboBoxItem109" runat="server" Text="состоит на диспансерском учете" Value="13" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
  
                <!--  30.11 Результаты ПСА (ерлер 50,54,58,62,66 жас): : ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="LabPca" Text="30.11 Результаты ПСА:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPca" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="< 4нг/мл/" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="от 4 до 10нг/мл" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="> 10нг/мл;" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem110" runat="server" Text="не проведена" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem111" runat="server" Text="состоит на диспансерском учете" Value="5" />
                            </Items>
                        </obout:ComboBox>
  
                <!--  30.12 бос ПАА және [-2] проПАА (айғақтары бойынша)/ Свободный и [-2] проПСА (по показаниям):  ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabPca001" Text="30.12 Свободный и [-2] проПСА (по показаниям):" runat="server" Width="35%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPca001" Width="25%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem112" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem113" runat="server" Text="проведен" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem114" runat="server" Text="не проведен" Value="2" />
                            </Items>
                        </obout:ComboBox>
                     </td>
                </tr>
               <tr>
                    <td class="fics" width="100%" style="vertical-align: central;"> 
                <!--  30.13 Простатаның денсаулық индесі/Индекс здоровья простаты:  ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabPca002" Text="30.13 Индекс здоровья простаты:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPca002" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem118" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem119" runat="server" Text="до 25" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem120" runat="server" Text="> 25" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem121" runat="server" Text="не определен" Value="3" />
                            </Items>
                        </obout:ComboBox>
  
                <!--  30.14 Простота биопсиясының нәтижелері (көрсеткіштері бойынша)/Результаты биопсии предстательной железы (по показаниям): ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="LabPca003" Text="30.14 Результаты биопсии предс.железы (по показаниям): " runat="server" Width="35%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPca003" Width="25%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem115" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem116" runat="server" Text="опухолевые клетки не обнаружены" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem117" runat="server" Text="доброкачественная гиперплазия предстательной железы" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem122" runat="server" Text="воспаление 4- ; 5- қалыпсыз кіші ацинарлық пролиференция/; 6- обыр/: 6а- 2-4; 6б-Глисон 5-7; 6в-Глисон 8-10." Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem123" runat="server" Text="простатическая интраэпителиальная неоплазия (ПИН)" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem124" runat="server" Text="атипическая мелкоацинарная пролиферация ASAP" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem125" runat="server" Text="рак" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem126" runat="server" Text="Глисон 2-4" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem127" runat="server" Text="Глисон 5-7" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem128" runat="server" Text="Глисон 8-10" Value="9" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
              </table>
          
             <hr>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  32.1. Здоров(а): ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label29" Text="32.1. Здоров(а):" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZdr" Width="10%" Height="200" FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem95" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem96" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem97" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    
                            <asp:Label ID="Label30" Text="32.3. Фкторы риска:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="Chk001"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label31" Text="Наслед.предраспол." runat="server" Width="13%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk002"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label32" Text="Гипертензия." runat="server" Width="10%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk003"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label33" Text="Гиперлипидемия." runat="server" Width="12%" Font-Bold="true" />

                        <obout:OboutCheckBox runat="server" ID="Chk004"
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
                        <asp:Label ID="Label34" Text="Гипергликемия." runat="server" Width="10%" Font-Bold="true" />
                    </td>
                </tr>
            </table>

        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: -5px; position: relative; top: -5px; width: 100%; height: 30px;">
            <center>
                <asp:Button ID="Button1" runat="server" CommandName="Add" OnClick="Save_Click" Text="Сохранить"/>
            </center>
        </asp:Panel>

        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
        <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <%-- =================  окно для поиска клиента из базы  ============================================  --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>
    <style type="text/css">
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

  /*   For multiline textbox control:  */
       .ob_iTaMC textarea
    {
        font-size: 14px !important;
        font-family: Arial !important;
    }
      
 /*   For oboutButton Control: color: #0000FF !important; */

    .ob_iBC
    {
        font-size: 12px !important;
    }

 /*  For oboutTextBox Control: */

    .ob_iTIE
    {
        font-size: 12px !important;
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

      .style2 {
            width: 45px;
        }
    
        hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

   td.fics{
          height:38px;
          background-color: none
          }
</style>

  <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



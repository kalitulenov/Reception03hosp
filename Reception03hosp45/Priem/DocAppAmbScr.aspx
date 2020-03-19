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
      string AmbCrdIdn = "";
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
          //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
          AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          parCrdIdn.Value = AmbCrdIdn;

          parBuxKod.Value = BuxKod;
          //           KltIIN = (string)Session["KltIIN"];

          if (!Page.IsPostBack)
          {
              getDocNum();
          }
      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNum()
      {
          string TekDat;
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbScrIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbScrIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              //     obout:OboutTextBox ------------------------------------------------------------------------------------     
              parKltIIN.Value = Convert.ToString(ds.Tables[0].Rows[0]["ScrIin"]);
              TxtRos.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrRos"]);
              TxtBec.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrBec"]);
              TxtTal.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrTal"]);
              TxtDav001.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrDav001"]);
              TxtDav002.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrDav002"]);
              TxtEkg.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrEkg"]);
              TxtInvDig.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrInvDig"]);
              TxtXol.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrXolVal"]);
              TxtSax.Text = Convert.ToString(ds.Tables[0].Rows[0]["ScrSaxVal"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrInv"].ToString())) BoxInv.SelectedIndex = 0;
              else BoxInv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrInv"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrInvGrp"].ToString())) BoxInvGrp.SelectedIndex = 0;
              else BoxInvGrp.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrInvGrp"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKur"].ToString())) BoxKur.SelectedIndex = 0;
              else BoxKur.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKur"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlc"].ToString())) BoxAlc.SelectedIndex = 0;

              else BoxAlc.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlc"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcPiv"].ToString())) BoxAlcPiv.SelectedIndex = 0;
              else BoxAlcPiv.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcPiv"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcVin"].ToString())) BoxAlcVin.SelectedIndex = 0;
              else BoxAlcVin.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcVin"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrAlcVod"].ToString())) BoxAlcVod.SelectedIndex = 0;
              else BoxAlcVod.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrAlcVod"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrFiz"].ToString())) BoxFiz.SelectedIndex = 0;
              else BoxFiz.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrFiz"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrPrnIbc"].ToString())) BoxPrn.SelectedIndex = 0;
              else BoxPrn.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrPrnIbc"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrSrd"].ToString())) BoxSrd.SelectedIndex = 0;
              else BoxSrd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrSrd"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGolBol"].ToString())) BoxGol.SelectedIndex = 0;
              else BoxGol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGolBol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrDav"].ToString())) BoxDav.SelectedIndex = 0;
              else BoxDav.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrDav"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrn"].ToString())) BoxZrn.SelectedIndex = 0;
              else BoxZrn.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrn"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnPel"].ToString())) BoxZrnPel.SelectedIndex = 0;
              else BoxZrnPel.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnPel"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnGlo"].ToString())) BoxZrnGlo.SelectedIndex = 0;
              else BoxZrnGlo.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnGlo"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnDio"].ToString())) BoxZrnDio.SelectedIndex = 0;
              else BoxZrnDio.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnDio"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKal"].ToString())) BoxKal.SelectedIndex = 0;
              else BoxKal.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKal"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrXol"].ToString())) BoxXol.SelectedIndex = 0;
              else BoxXol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrXol"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrSax"].ToString())) BoxSax.SelectedIndex = 0;
              else BoxSax.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrSax"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrZrnDav"].ToString())) BoxZrnDav.SelectedIndex = 0;
              else BoxZrnDav.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrZrnDav"]);
              /*
                            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGem"].ToString())) BoxGem.SelectedIndex = 0;
                            else BoxGem.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGem"]);

                            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrGemTst"].ToString())) BoxGemTst.SelectedIndex = 0;
                            else BoxGemTst.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrGemTst"]);

                            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrKln"].ToString())) BoxGemKol.SelectedIndex = 0;
                            else BoxGemKol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrKln"]);
              */
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

          if (Convert.ToString(TxtXol.Text) == null || Convert.ToString(TxtXol.Text) == "") TxtXol.Text = "0";
          if (Convert.ToString(TxtSax.Text) == null || Convert.ToString(TxtSax.Text) == "") TxtSax.Text = "0";

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbScrIdnUpd", con);
          cmd = new SqlCommand("HspAmbScrIdnUpd", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@SCRIIN", SqlDbType.VarChar).Value = parKltIIN.Value;
          cmd.Parameters.Add("@ScrRos", SqlDbType.VarChar).Value = TxtRos.Text;
          cmd.Parameters.Add("@ScrBec", SqlDbType.VarChar).Value = TxtBec.Text;
          cmd.Parameters.Add("@ScrTal", SqlDbType.VarChar).Value = TxtTal.Text;
          cmd.Parameters.Add("@ScrDav001", SqlDbType.VarChar).Value = TxtDav001.Text;
          cmd.Parameters.Add("@ScrDav002", SqlDbType.VarChar).Value = TxtDav002.Text;
          cmd.Parameters.Add("@ScrEkg", SqlDbType.VarChar).Value = TxtEkg.Text;
          cmd.Parameters.Add("@ScrInvDig", SqlDbType.VarChar).Value = TxtInvDig.Text;
          cmd.Parameters.Add("@ScrXolVal", SqlDbType.Decimal).Value = TxtXol.Text;
          cmd.Parameters.Add("@ScrSaxVal", SqlDbType.Decimal).Value = TxtSax.Text;

          cmd.Parameters.Add("@ScrInv", SqlDbType.VarChar).Value = BoxInv.SelectedIndex;
          cmd.Parameters.Add("@ScrInvGrp", SqlDbType.VarChar).Value = BoxInvGrp.SelectedIndex;
          cmd.Parameters.Add("@ScrKur", SqlDbType.VarChar).Value = BoxKur.SelectedIndex;
          cmd.Parameters.Add("@ScrAlc", SqlDbType.VarChar).Value = BoxAlc.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcPiv", SqlDbType.VarChar).Value = BoxAlcPiv.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcVin", SqlDbType.VarChar).Value = BoxAlcVin.SelectedIndex;
          cmd.Parameters.Add("@ScrAlcVod", SqlDbType.VarChar).Value = BoxAlcVod.SelectedIndex;
          cmd.Parameters.Add("@ScrFiz", SqlDbType.VarChar).Value = BoxFiz.SelectedIndex;
          cmd.Parameters.Add("@ScrPrnIbc", SqlDbType.VarChar).Value = BoxPrn.SelectedIndex;
          cmd.Parameters.Add("@ScrSrd", SqlDbType.VarChar).Value = BoxSrd.SelectedIndex;
          cmd.Parameters.Add("@ScrGolBol", SqlDbType.VarChar).Value = BoxGol.SelectedIndex;
          cmd.Parameters.Add("@ScrDav", SqlDbType.VarChar).Value = BoxDav.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnPel", SqlDbType.VarChar).Value = BoxZrnPel.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnGlo", SqlDbType.VarChar).Value = BoxZrnGlo.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnDio", SqlDbType.VarChar).Value = BoxZrnDio.SelectedIndex;
          cmd.Parameters.Add("@ScrKal", SqlDbType.VarChar).Value = BoxKal.SelectedIndex;
          cmd.Parameters.Add("@ScrXol", SqlDbType.VarChar).Value = BoxXol.SelectedIndex;
          cmd.Parameters.Add("@ScrSax", SqlDbType.VarChar).Value = BoxSax.SelectedIndex;
          cmd.Parameters.Add("@ScrZrn", SqlDbType.VarChar).Value = BoxZrn.SelectedIndex;
          cmd.Parameters.Add("@ScrZrnDav", SqlDbType.VarChar).Value = BoxZrnDav.SelectedIndex;
          cmd.Parameters.Add("@ScrGem", SqlDbType.VarChar).Value = 0; // BoxGem.SelectedIndex;
          cmd.Parameters.Add("@ScrGemTst", SqlDbType.VarChar).Value = 0; //BoxGemTst.SelectedIndex;
          cmd.Parameters.Add("@ScrKln", SqlDbType.VarChar).Value = 0; //BoxGemKol.SelectedIndex;
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
        <asp:HiddenField ID="parKltIIN" runat="server" />
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
            Style="left: -5px; position: relative; top: -5px; width: 100%; height: 410px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                <!--  Инвалидность ----------------------------------------------------------------------------------------------------------  -->
                <tr >
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="LblInv" Text="9.Инвалидность:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxInv" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Есть" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LblInvGrp" Text="9.1.Группа инвалидности (от 16 лет):" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxInvGrp" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="1 группа" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="2 группа" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="3 группа" Value="3" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="LblInvDig" Text="9.2.Диагноз по инвалидности:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtInvDig" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                </tr>
                <!--  Антропометрия ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label2" Text="10.Рост:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtRos" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <asp:Label ID="Label12" Text="11.Вес:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtBec" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <asp:Label ID="Label13" Text="13.Объем талии:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtTal" Width="10%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                    </td>
                </tr>
                <!--  Вредные привычки ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label3" Text="14.Курение:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKur" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label11" Text="15.Употребление алкоголя:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlc" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label14" Text="Пиво:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcPiv" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="До 0.5 л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Более 0.5 л" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="До 285 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Более 285 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label15" Text="Вино:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcVin" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="До 250 мл" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem19" runat="server" Text="Более 250 мл" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem20" runat="server" Text="До 120 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem21" runat="server" Text="Более 120 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label16" Text="Водка:" runat="server" Width="5%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxAlcVod" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem22" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text="Не употребляет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="До 50 мл" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Более 50 мл" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="До 25 мл" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="Более 25 мл" Value="5" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

                <!--  16.Физическая активность ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label17" Text="16.Физ.активность:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxFiz" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label18" Text="17.Имеются ли у родителей болезни сердца:" runat="server" Width="30%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPrn" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem48" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label19" Text="18.Появляется ли у Вас боль за грудиной:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxSrd" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem49" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem50" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem51" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <!--  19.Отмечаются ли у Вас головные боли ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label20" Text="19.Головные боли:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGol" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem52" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem53" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem54" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label21" Text="20.Есть ли у Вас повышение АД:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDav" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem55" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem56" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem57" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label22" Text="21.АД(систолическое/диастолическое):" runat="server" Width="25%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtDav001" Width="5%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <obout:OboutTextBox runat="server" ID="TxtDav002" Width="5%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                    </td>
                </tr>

                <!--  Наблюдается ли у Вас снижение остроты зрения ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label23" Text="22.Сниж.ост.зрения:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrn" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem58" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem59" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem60" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label24" Text="23.Есть ли (пелена) перед глазами :" runat="server" Width="22%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnPel" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem61" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem62" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem63" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label25" Text="24.Есть ли у родителей глаукома:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnGlo" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem64" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem65" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem66" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label26" Text="25.Диоптрии > 4:" runat="server" Width="11%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxZrnDio" Width="7%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem67" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem68" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem69" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>

                    </td>
                </tr>

                <!--  26.Отмечаются ли у Вас в течение последнего года патологические примеси в кале ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label27" Text="26.Отмечаются ли у Вас в течение последнего года патологические примеси в кале:" runat="server" Width="50%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxKal" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem70" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem71" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem72" runat="server" Text="Кровь" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem73" runat="server" Text="Слизь" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem74" runat="server" Text="Гной" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
               <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label1" Text="28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета:" runat="server" Width="100%" Font-Bold="true" />
                    </td>
                </tr>
                <tr>
                    <td class="fics" >
                        <asp:Label ID="Label4" Text="28.1 ЭКГ:" runat="server" Width="13%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtEkg" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>

                        <asp:Label ID="Label5" Text=" 28.2 Уровень холестерина:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtXol" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>
                        <obout:ComboBox runat="server" ID="BoxXol" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="5.2 ммоль/л" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text=">5.2 ммоль/л" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text=">состоит на дисп у" Value="3" />
                            </Items>
                        </obout:ComboBox>
                        <asp:Label ID="Label6" Text=" 28.3 Глюкоза:" runat="server" Width="10%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtSax" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"></obout:OboutTextBox>
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
                        <asp:Label ID="Label8" Text="29.1 Глазное давление:" runat="server" Width="20%" Font-Bold="true" />
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
                <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
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
          height:35px;
          background-color: none
          }
</style>

  <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



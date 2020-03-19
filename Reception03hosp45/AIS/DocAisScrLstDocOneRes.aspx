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
          //=====================================================================================

          GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
          GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
          GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

          sdsMem.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsMem.SelectCommand = "SELECT * FROM SprAisMem ORDER BY MemNam";

          sdsTypDig.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsTypDig.SelectCommand = "SELECT * FROM SprAisTypDig ORDER BY TypDigNam";

          sdsTypDsp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsTypDsp.SelectCommand = "SELECT * FROM SprAisTypDsp ORDER BY TypDspNam";

          sdsDspGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsDspGrp.SelectCommand = "SELECT * FROM SprAisDspGrp ORDER BY DspGrpNam";

          sdsStt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsStt.SelectCommand = "SELECT * FROM SprAisStt ORDER BY SttNam";

          sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsKto.SelectCommand = "SELECT BuxKod,FI+' '+DLGNAM AS FIODLG FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ' ORDER BY FI";

          sdsDig.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          sdsDig.SelectCommand = "SELECT MkbKod,MkbNam FROM MKB10 ORDER BY MKBKOD";

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

          if (ds.Tables[0].Rows.Count > 0)
          {
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResDsp"].ToString())) BoxDsp.SelectedIndex = 0;
              else BoxDsp.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResDsp"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResNap"].ToString())) BoxNap.SelectedIndex = 0;
              else BoxNap.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResNap"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResIsx"].ToString())) BoxIsx.SelectedIndex = 0;
              else BoxIsx.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResIsx"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResVid"].ToString())) BoxVid.SelectedIndex = 0;
              else BoxVid.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResVid"]);

        //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResDoc"].ToString())) BoxDoc.SelectedIndex = 0;
        //      else BoxDoc.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["ScrResDoc"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResBeg"].ToString())) TxtBeg.Text = "";
              else TxtBeg.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["ScrResBeg"]).ToString("dd.MM.yyyy");

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrResEnd"].ToString())) TxtEnd.Text = "";
              else TxtEnd.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["ScrResEnd"]).ToString("dd.MM.yyyy");

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["ScrInpFlg"].ToString())) ChkAis.Checked = false;
              else ChkAis.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["ScrInpFlg"]);
          }

          if (ds.Tables[1].Rows.Count > 0)
          {
              GridUsl.DataSource = ds.Tables[1];
              GridUsl.DataBind();
          }

          //          string name = value ?? string.Empty;
      }


      // ============================ проверка и опрос для записи документа в базу ==============================================
      protected void Save_Click(object sender, EventArgs e)
      {
          string ScrBeg = "";
          string ScrEnd = "";
          bool ScrAis = false;

          BuxFrm = (string)Session["BuxFrmKod"];
          //=====================================================================================

          if (Convert.ToString(TxtBeg.Text) == null || Convert.ToString(TxtBeg.Text) == "") ScrBeg = "";
          else ScrBeg = Convert.ToString(TxtBeg.Text);

          if (Convert.ToString(ChkAis.Text) == "Checked = true") ScrAis = true;
          else ScrAis = ChkAis.Checked;

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisScrLstDocOneResUpd", con);
          cmd = new SqlCommand("HspAisScrLstDocOneResUpd", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
          cmd.Parameters.Add("@SCRIIN", SqlDbType.VarChar).Value = KltIIN;
          cmd.Parameters.Add("@ScrResBeg", SqlDbType.VarChar).Value = TxtBeg.Text;
          cmd.Parameters.Add("@ScrResEnd", SqlDbType.VarChar).Value = TxtEnd.Text;
          cmd.Parameters.Add("@ScrResDsp", SqlDbType.VarChar).Value = BoxDsp.SelectedIndex;
          cmd.Parameters.Add("@ScrResNap", SqlDbType.VarChar).Value = BoxNap.SelectedIndex;
          cmd.Parameters.Add("@ScrResIsx", SqlDbType.VarChar).Value = BoxIsx.SelectedIndex;
          cmd.Parameters.Add("@ScrResVid", SqlDbType.VarChar).Value = BoxVid.SelectedIndex;
          cmd.Parameters.Add("@ScrInpFlg", SqlDbType.Bit, 1).Value = ScrAis;
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();
      }

      void InsertRecord(object sender, GridRecordEventArgs e)
      {
          string ScrDat;
          string ScrDatNxt;


          if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrDat"]))) ScrDat = DateTime.Now.ToString("dd.MM.yyyy");
          else  ScrDat = Convert.ToDateTime(e.Record["ScrDat"]).ToString("dd.MM.yyyy");

          if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrNxt"]))) ScrDatNxt = DateTime.Now.ToString("dd.MM.yyyy");
          else  ScrDatNxt = Convert.ToDateTime(e.Record["ScrNxt"]).ToString("dd.MM.yyyy");


          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisScrLstDocOneResGrdIns", con);
          cmd = new SqlCommand("HspAisScrLstDocOneResGrdIns", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
          cmd.Parameters.Add("@SCRIIN", SqlDbType.VarChar).Value = KltIIN;
          cmd.Parameters.Add("@ScrDtlDat", SqlDbType.VarChar).Value = ScrDat;
          cmd.Parameters.Add("@ScrDtlDig", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDig"]);
          cmd.Parameters.Add("@ScrDtlTypDsp", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlTypDsp"]);
          cmd.Parameters.Add("@ScrDtlTypDig", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlTypDig"]);
          cmd.Parameters.Add("@ScrDtlDspGrp", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDspGrp"]);
          cmd.Parameters.Add("@ScrDtlDatNxt", SqlDbType.VarChar).Value = ScrDatNxt;
          cmd.Parameters.Add("@ScrDtlStt", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlStt"]);
          cmd.Parameters.Add("@ScrDtlMem", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlMem"]);
          cmd.Parameters.Add("@ScrDtlDoc", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDoc"]);
          cmd.Parameters.Add("@ScrDtlPlc", SqlDbType.VarChar).Value = 1;

          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();
          getDocNum();
      }


      void UpdateRecord(object sender, GridRecordEventArgs e)
      {
          int  ScrDtlIdn = Convert.ToInt32(e.Record["ScrDtlIdn"]);
          string ScrDat;
          string ScrDatNxt;

          if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrDat"]))) ScrDat = DateTime.Now.ToString("dd.MM.yyyy");
          else  ScrDat = Convert.ToDateTime(e.Record["ScrDat"]).ToString("dd.MM.yyyy");

          if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrDatNxt"]))) ScrDatNxt = DateTime.Now.ToString("dd.MM.yyyy");
          else  ScrDatNxt = Convert.ToDateTime(e.Record["ScrDatNxt"]).ToString("dd.MM.yyyy");

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisScrLstDocOneResGrdUpd", con);
          cmd = new SqlCommand("HspAisScrLstDocOneResGrdUpd", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
          cmd.Parameters.Add("@ScrDtlIdn", SqlDbType.VarChar).Value = ScrDtlIdn;
          cmd.Parameters.Add("@ScrDtlDat", SqlDbType.VarChar).Value = ScrDat;
          cmd.Parameters.Add("@ScrDtlDig", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDig"]);
          cmd.Parameters.Add("@ScrDtlTypDsp", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlTypDsp"]);
          cmd.Parameters.Add("@ScrDtlTypDig", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlTypDig"]);
          cmd.Parameters.Add("@ScrDtlDspGrp", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDspGrp"]);
          cmd.Parameters.Add("@ScrDtlDatNxt", SqlDbType.VarChar).Value = ScrDatNxt;
          cmd.Parameters.Add("@ScrDtlStt", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlStt"]);
          cmd.Parameters.Add("@ScrDtlMem", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlMem"]);
          cmd.Parameters.Add("@ScrDtlDoc", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ScrDtlDoc"]);
          cmd.Parameters.Add("@ScrDtlPlc", SqlDbType.VarChar).Value = 1;

          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();            // ------------------------------------------------------------------------------заполняем второй уровень
          getDocNum();

      }

      void DeleteRecord(object sender, GridRecordEventArgs e)
      {
          string  ScrDtlIdn = Convert.ToString(e.Record["ScrDtlIdn"]);

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("DELETE FROM TABSCRDTL WHERE SCRDTLIDN=" + ScrDtlIdn, con);
          //  cmd = new SqlCommand("HspAisScrLstDocOneResGrdIns", con);
          cmd.ExecuteNonQuery();
          con.Close();
          getDocNum();
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
            Style="left: -5px; position: relative; top: -5px; width: 100%; height: 460px;">


            <asp:Label ID="Label11" Text="2.4 Заключительный диагноз:" runat="server" Width="100%" Font-Bold="true" />
            </br>
                        <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column00" DataField="ScrDtlIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="ScrDat" HeaderText="ДАТА" DataFormatString = "{0:dd/MM/yy}" Width="7%" />
                    <obout:Column ID="Column02" DataField="ScrDtlDig" HeaderText="МКБ" Width="5%" >
                           <TemplateSettings EditTemplateId="TemplateEditDtlDig" />
                    </obout:Column>
                    <obout:Column ID="Column03" DataField="MkbNam" HeaderText="ДИАГНОЗ" ReadOnly="true" Width="21%" />
                    <obout:Column ID="Column04" DataField="ScrDtlTypDsp" HeaderText="ТИП ДСП" Width="10%" >
                           <TemplateSettings  TemplateId="TemplateTypDsp" EditTemplateId="TemplateEditTypDsp" />
                    </obout:Column>
                    <obout:Column ID="Column05" DataField="ScrDtlTypDig" HeaderText="ТИП ДИА" Width="8%" >
                           <TemplateSettings TemplateId="TemplateTypDig" EditTemplateId="TemplateEditTypDig" />
                    </obout:Column>
                    <obout:Column ID="Column06" DataField="ScrDtlDspGrp" HeaderText="ДСП.ГРП" Width="8%" Align="left" >
                           <TemplateSettings TemplateId="TemplateDspGrp" EditTemplateId="TemplateEditDspGrp" />
                    </obout:Column>
                    <obout:Column ID="Column07" DataField="ScrDtlStt" HeaderText="СОС.ЗДР" Width="8%" Align="right" >
                           <TemplateSettings TemplateId="TemplateStt" EditTemplateId="TemplateEditStt" />
                    </obout:Column>
                    <obout:Column ID="Column08" DataField="ScrDtlMem" HeaderText="ПРИЧИНА" Width="8%" Align="right" >
                           <TemplateSettings TemplateId="TemplateMem" EditTemplateId="TemplateEditMem" />
                    </obout:Column>
                    <obout:Column ID="Column09" DataField="ScrDatNxt" HeaderText="СЛД.ЯВК" Width="8%" DataFormatString = "{0:dd/MM/yy}" Align="center"/>
                    <obout:Column ID="Column10" DataField="ScrDtlDoc" HeaderText="ВРАЧ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="7%" AllowEdit="true" AllowDelete="true" runat="server"/>
                </Columns>

               <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateDtlDig">
                        <Template>
                            <%# Container.DataItem["MkbKod"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditDtlDig" ControlID="ddlDig" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlDig" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsDig" CssClass="ob_gEC" DataTextField="MkbKod" DataValueField="MkbKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateTypDsp">
                        <Template>
                            <%# Container.DataItem["TypDspNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditTypDsp" ControlID="ddlTypDsp" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlTypDsp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTypDsp" CssClass="ob_gEC" DataTextField="TypDspNam" DataValueField="TypDspKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateTypDig">
                        <Template>
                            <%# Container.DataItem["TypDigNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditTypDig" ControlID="ddlTypDig" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlTypDig" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTypDig" CssClass="ob_gEC" DataTextField="TypDigNam" DataValueField="TypDigKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>
                   
                    <obout:GridTemplate runat="server" ID="TemplateDspGrp">
                        <Template>
                            <%# Container.DataItem["DspGrpNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditDspGrp" ControlID="ddlDspGrp" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlDspGrp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsDspGrp" CssClass="ob_gEC" DataTextField="DspGrpNam" DataValueField="DspGrpKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>
                   
                    <obout:GridTemplate runat="server" ID="TemplateStt">
                        <Template>
                            <%# Container.DataItem["SttNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditStt" ControlID="ddlStt" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlStt" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsStt" CssClass="ob_gEC" DataTextField="SttNam" DataValueField="SttKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>
                    
                    <obout:GridTemplate runat="server" ID="TemplateMem">
                        <Template>
                            <%# Container.DataItem["MemNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditMem" ControlID="ddlMem" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlMem" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsMem" CssClass="ob_gEC" DataTextField="MemNam" DataValueField="MemKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateKtoNam">
                        <Template>
                            <%# Container.DataItem["FIODLG"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKtoNam" ControlID="ddlKtoNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKtoNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKto" CssClass="ob_gEC" DataTextField="FIODLG" DataValueField="BuxKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    </Templates>
            </obout:Grid>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  28.Результаты обследования на выявление болезней системы кровообращения и сахарного диабета: 28.1 ЭКГ: ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td class="fics" width="100%" style="vertical-align: central;">
                        <asp:Label ID="Label12" Text="33.Группа диспансерного наблюдения:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDsp" Width="10%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="IA" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="IБ" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="II" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text="III" Value="4" />
                            </Items>
                        </obout:ComboBox>
                    
                        <asp:Label ID="Label13" Text="34.Направлен к врачу:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxNap" Width="10%" Height="200" FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Нет" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="Да" Value="2" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="fics">
                        <asp:Label ID="Label14" Text="Исход обращения:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxIsx" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="Не определен" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Здоров" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="Выздоровление" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="Без перемен" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text="Улучшение" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem50" runat="server" Text="Госпитализация" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem51" runat="server" Text="Направлен на МСЭК" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem52" runat="server" Text="Смерть" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem53" runat="server" Text="Выезд" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem54" runat="server" Text="Привит" Value="9" />
                                <obout:ComboBoxItem ID="ComboBoxItem55" runat="server" Text="Продолжение СПО" Value="10" />
                                <obout:ComboBoxItem ID="ComboBoxItem56" runat="server" Text="Направлен в КДП (КДЦ)" Value="11" />
                            </Items>
                        </obout:ComboBox>

                        <asp:Label ID="Label15" Text="Вид посещения:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxVid" Width="15%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="актив на дому" Value="А" />
                                <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="дневной стационар" Value="Б" />
                                <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="на дому" Value="Д" />
                                <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="передвижной мед. комплекс" Value="К" />
                                <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="в поликлинике" Value="П" />
                                <obout:ComboBoxItem ID="ComboBoxItem57" runat="server" Text="Стационар на дому" Value="С" />
                                <obout:ComboBoxItem ID="ComboBoxItem58" runat="server" Text="в учреждении" Value="У" />
                                <obout:ComboBoxItem ID="ComboBoxItem59" runat="server" Text="школа, дет. Cад" Value="Ш" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="fics">
                        <asp:Label ID="Label17" Text="Дата начала скрининга:" runat="server" Width="15%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtBeg" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <obout:Calendar ID="ScrBeg" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtBeg"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                        <asp:Label ID="Label18" Text="Дата окончания:" runat="server" Width="10%" Font-Bold="true" />
                        <obout:OboutTextBox runat="server" ID="TxtEnd" Width="7%" BackColor="White" Height="30px" FolderStyle="~/Styles/Interface/plain/OboutTextBox"> </obout:OboutTextBox>
                        <obout:Calendar ID="ScrEnd" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtEnd"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />


                        <asp:Label ID="Label34" Text="Отпр. в АИС" runat="server" Width="10%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkAis" 
                            FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        </obout:OboutCheckBox>
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
          height:43px;
          background-color: none
          }
</style>

  <asp:SqlDataSource runat="server" ID="sdsMem" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsStt"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsTypDig"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsTypDsp"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsDspGrp"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsDig" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
 
</body>
</html>



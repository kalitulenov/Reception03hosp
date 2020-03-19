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
          //    AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          //    parCrdIdn.Value = AmbCrdIdn;

          parBuxKod.Value = BuxKod;

          KltIIN = Convert.ToString(Request.QueryString["KltIIN"]);
          parCrdIdn.Value = KltIIN;
          //=====================================================================================

          GridDsp.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
          GridDsp.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
          GridDsp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
          //           KltIIN = (string)Session["KltIIN"];

          sdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsDoc.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ' ORDER BY FI";

          sdsGde.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsGde.SelectCommand = "SELECT * FROM SprDspGde ORDER BY DspGdeNam";

          sdsSos.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsSos.SelectCommand = "SELECT * FROM SprDspSos ORDER BY DspSosNam";

          sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsTyp.SelectCommand = "SELECT * FROM SprDspTyp ORDER BY DspTypNam";

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
          SqlCommand cmd = new SqlCommand("HspAisDspIin", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@KLTIIN", SqlDbType.VarChar).Value = KltIIN;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAisDspIin");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              parDspIdn.Value = Convert.ToString(ds.Tables[0].Rows[0]["DspIdn"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspMkb"].ToString())) TxtDig.Text = "";
              else TxtDig.Text = Convert.ToString(ds.Tables[0].Rows[0]["DspMkb"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspDoc"].ToString())) BoxDoc.SelectedIndex = 0;
              else BoxDoc.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DspDoc"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspBeg"].ToString())) TxtBeg.Text = "";
              else TxtBeg.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DspBeg"]).ToString("dd.MM.yyyy");

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspVid"].ToString())) BoxVid.SelectedIndex = 0;
              else BoxVid.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DspVid"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspGrp"].ToString())) BoxGrp.SelectedIndex = 0;
              else BoxGrp.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DspGrp"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspZbl"].ToString())) BoxBol.SelectedIndex = 0;
              else BoxBol.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DspZbl"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspEnd"].ToString())) TxtEnd.Text = "";
              else TxtEnd.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DspEnd"]).ToString("dd.MM.yyyy");

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DspEndWhy"].ToString())) BoxPrc.SelectedIndex = 0;
              else BoxPrc.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DspEndWhy"]);
          }

          if (ds.Tables[1].Rows.Count > 0)
          {
              GridDsp.DataSource = ds.Tables[1];
              GridDsp.DataBind();
          }

          //          string name = value ?? string.Empty;
      }

      // ============================ проверка и опрос для записи документа в базу ==============================================

      // ============================ проверка и опрос для записи документа в базу ==============================================
      protected void Save_Click(object sender, EventArgs e)
      {
          string DspMkb = "";
          string DspBeg = "";
          string DspEnd = "";

          BuxFrm = (string)Session["BuxFrmKod"];
          //=====================================================================================

          if (Convert.ToString(TxtBeg.Text) == null || Convert.ToString(TxtBeg.Text) == "") DspBeg = "";
          else DspBeg = Convert.ToString(TxtBeg.Text);

          if (Convert.ToString(TxtEnd.Text) == null || Convert.ToString(TxtEnd.Text) == "") DspEnd = "";
          else DspEnd = Convert.ToString(TxtEnd.Text);

          if (Convert.ToString(TxtDig.Text) == null || Convert.ToString(TxtDig.Text) == "") DspMkb = "";
          else DspMkb = Convert.ToString(TxtDig.Text);

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("HspAisDspIinRep", con);
          cmd = new SqlCommand("HspAisDspIinRep", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@DSPFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@DSPIIN", SqlDbType.VarChar).Value = KltIIN;
          cmd.Parameters.Add("@DSPBEG", SqlDbType.VarChar).Value = TxtBeg.Text;
          cmd.Parameters.Add("@DSPEND", SqlDbType.VarChar).Value = TxtEnd.Text;
          cmd.Parameters.Add("@DSPMKB", SqlDbType.VarChar).Value = TxtDig.Text;
          cmd.Parameters.Add("@DSPDOC", SqlDbType.VarChar).Value = BoxDoc.SelectedIndex;
          cmd.Parameters.Add("@DSPVID", SqlDbType.VarChar).Value = BoxVid.SelectedIndex;
          cmd.Parameters.Add("@DSPZBL", SqlDbType.VarChar).Value = BoxBol.SelectedIndex;
          cmd.Parameters.Add("@DSPGRP", SqlDbType.VarChar).Value = BoxGrp.SelectedIndex;
          cmd.Parameters.Add("@DSPENDWHY", SqlDbType.VarChar).Value = BoxPrc.SelectedIndex;
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();
      }

      void InsertRecord(object sender, GridRecordEventArgs e)
      {
          string DspDat;

          if (string.IsNullOrEmpty(Convert.ToString(e.Record["DSPDTLDAT"]))) DspDat = DateTime.Now.ToString("dd.MM.yyyy");
          else  DspDat = Convert.ToDateTime(e.Record["DSPDTLDAT"]).ToString("dd.MM.yyyy");

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("INSERT INTO AMBDSPDTL (DSPDTLREF,DSPDTLGDE,DSPDTLSOS,DSPDTLTYP,DSPDTLDAT) " +
                                                          "VALUES(@DSPDTLREF,@DSPDTLGDE,@DSPDTLSOS,@DSPDTLTYP,@DSPDTLDAT)",con);
          //   cmd = new SqlCommand("HspAisDspLstDocOneResGrdIns", con);
          // указать тип команды
          //   cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@DSPDTLREF", SqlDbType.VarChar).Value = parDspIdn.Value;
          cmd.Parameters.Add("@DSPDTLGDE", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlGde"]);
          cmd.Parameters.Add("@DSPDTLSOS", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlSos"]);
          cmd.Parameters.Add("@DSPDTLTYP", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlTyp"]);
          cmd.Parameters.Add("@DSPDTLDAT", SqlDbType.VarChar).Value = DspDat;
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();


          getDocNum();
      }


      void UpdateRecord(object sender, GridRecordEventArgs e)
      {
          int  DspDtlIdn = Convert.ToInt32(e.Record["DspDtlIdn"]);
          string DspDat;

          //parDspIdn.Value

          if (string.IsNullOrEmpty(Convert.ToString(e.Record["DSPDTLDAT"]))) DspDat = DateTime.Now.ToString("dd.MM.yyyy");
          else  DspDat = Convert.ToDateTime(e.Record["DSPDTLDAT"]).ToString("dd.MM.yyyy");

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("UPDATE AMBDSPDTL SET DSPDTLGDE=@DSPDTLGDE,DSPDTLSOS=@DSPDTLSOS,DSPDTLTYP=@DSPDTLTYP,DSPDTLDAT=@DSPDTLDAT WHERE DSPDTLIDN=@DSPDTLIDN",con);
          //   cmd = new SqlCommand("HspAisDspLstDocOneResGrdIns", con);
          // указать тип команды
          //   cmd.CommandType = CommandType.StoredProcedure;
          // создать коллекцию параметров
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          cmd.Parameters.Add("@DSPDTLIDN", SqlDbType.VarChar).Value = DspDtlIdn;
          cmd.Parameters.Add("@DSPDTLGDE", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlGde"]);
          cmd.Parameters.Add("@DSPDTLSOS", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlSos"]);
          cmd.Parameters.Add("@DSPDTLTYP", SqlDbType.VarChar).Value = Convert.ToString(e.Record["DspDtlTyp"]);
          cmd.Parameters.Add("@DSPDTLDAT", SqlDbType.VarChar).Value = DspDat;
          // ------------------------------------------------------------------------------заполняем второй уровень
          cmd.ExecuteNonQuery();
          con.Close();


          getDocNum();

      }

      void DeleteRecord(object sender, GridRecordEventArgs e)
      {

          int  DspDtlIdn = Convert.ToInt32(e.Record["DspDtlIdn"]);

          // строка соединение
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();

          // создание команды
          SqlCommand cmd = new SqlCommand("DELETE FROM AMBDSPDTL WHERE DSPDTLIDN=" + DspDtlIdn, con);
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
        <asp:HiddenField ID="parDspIdn" runat="server" />
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
           <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px;
                       left: 0px; position: relative; top: 0px; width: 50%; height: 380px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                <!--  Диагноз: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="LblInv" Text="Диагноз:" runat="server" Width="40%" Font-Bold="true" />
                        <asp:TextBox runat="server" ID="TxtDig" Width="50%" BackColor="White" Height="20px"> </asp:TextBox>
                    </td>
                </tr>

                <!--  Врач: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label1" Text="Врач:" runat="server" Width="40%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxDoc" Width="50%" Height="200" 
                               FolderStyle="/Styles/Combobox/Plain"   
                               DataSourceID="sdsDoc" DataTextField="FI" DataValueField="BUXKOD" >
                        </obout:ComboBox>                      
                    </td>
                </tr>

                <!--  Дата взятия: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label7" Text="Дата взятия:" runat="server" Width="40%" Font-Bold="true" />
                        <asp:TextBox runat="server" ID="TxtBeg" Width="20%" BackColor="White" Height="20px"> </asp:TextBox>
                        <obout:Calendar ID="Cal001" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtBeg"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>

                <!--  Вид взятия на учет: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label17" Text="Вид взятия на учет:" runat="server" Width="40%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxVid" Width="50%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="с диагнозом, установленным впервые" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="с ранее установленным диагнозом" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="состоит на учете в  ведомственной лечебной организации" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="учтен посмертно" Value="4" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

                <!--  Диспансерная группа: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label5" Text="Диспансерная группа:" runat="server" Width="40%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxGrp" Width="50%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="3А" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="3Б" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="3В" Value="5" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>

                <!--  Характер заболевания: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label6" Text="Характер заболевания:" runat="server" Width="40%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxBol" Width="50%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="острое заболевание" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="впервые зарегистрированное хроническое" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="известное ранее хроническое" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="фактор риска" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="Не указано" Value="5" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
         
                <!--  Дата снятие: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label3" Text="Дата снятие:" runat="server" Width="40%" Font-Bold="true" />
                        <asp:TextBox runat="server" ID="TxtEnd" Width="20%" BackColor="White" Height="20px"> </asp:TextBox>
                        <obout:Calendar ID="Calendar1" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="TxtEnd"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>

                <!--  Причина снятия: ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height:35px">   
                    <td width="100%" class="fics" style="vertical-align: central;">
                        <asp:Label ID="Label2" Text="Причина снятия:" runat="server" Width="40%" Font-Bold="true" />
                        <obout:ComboBox runat="server" ID="BoxPrc" Width="50%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain">
                            <Items>
                                <obout:ComboBoxItem ID="ComboBoxItem9" runat="server" Text="неизвестно" Value="0" />
                                <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="выздоровление" Value="1" />
                                <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="достигнуто 15 лет" Value="2" />
                                <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="выезд" Value="3" />
                                <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="смерть" Value="4" />
                                <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="достигнуто 18 лет" Value="5" />
                                <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="отрыв от диспансеризации" Value="6" />
                                <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="перевод в другую организацию" Value="7" />
                                <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Диагноз не подтвердился" Value="8" />
                                <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="Прочее" Value="9" />
                            </Items>
                        </obout:ComboBox>
                    </td>
                </tr>
           </table>
        </asp:Panel>


                  <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="Both"
                      Style="left: 51%; position: relative; top: -385px; width: 50%; height: 380px;">
  
            <obout:Grid ID="GridDsp" runat="server"
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
                    <obout:Column ID="Column00" DataField="DspDtlIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="DspDtlGde" HeaderText="Место проведения" Width="30%" >
                           <TemplateSettings   TemplateId="TemplateGde" EditTemplateId="TemplateEditGde" />
                    </obout:Column>
                    <obout:Column ID="Column04" DataField="DspDtlSos" HeaderText="Состояние здоровья" Width="30%" >
                           <TemplateSettings  TemplateId="TemplateSos" EditTemplateId="TemplateEditSos" />
                    </obout:Column>
                    <obout:Column ID="Column05" DataField="DspDtlTyp" HeaderText="Тип дисп." Width="19%" >
                           <TemplateSettings TemplateId="TemplateTyp" EditTemplateId="TemplateEditTyp" />
                    </obout:Column>
                    <obout:Column ID="Column06" DataField="DspDtlDat" HeaderText="Дата след. явки" Width="11%" Align="left" />
                    
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server"/>
                </Columns>

               <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateGde">
                        <Template>
                            <%# Container.DataItem["DspGdeNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditGde" ControlID="ddlGde" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlGde" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGde" CssClass="ob_gEC" DataTextField="DspGdeNam" DataValueField="DspGdeKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateTyp">
                        <Template>
                            <%# Container.DataItem["DspTypNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditTyp" ControlID="ddlTyp" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlTyp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTyp" CssClass="ob_gEC" DataTextField="DspTypNam" DataValueField="DspTypKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSos">
                        <Template>
                            <%# Container.DataItem["DspSosNam"]%>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditSos" ControlID="ddlSos" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlSos" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsSos" CssClass="ob_gEC" DataTextField="DspSosNam" DataValueField="DspSosKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>
                   
                    </Templates>
            </obout:Grid>

	      </asp:Panel> 

        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -385px; width: 100%; height: 30px;">
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
          height:40px;
          background-color: none
          }
</style>

  <asp:SqlDataSource runat="server" ID="sdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsGde" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsSos" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



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

         //    ------------------------------------------------------------------------------------------------------------------------

         </script>

</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string BuxKod;
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
          AmbCrdIdn = (string)Session["AmbCrdIdn"];
          //=====================================================================================
          sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsNoz.SelectCommand = "SELECT NozKod,NozNam FROM SprNoz ORDER BY NozNam";
          sdsMkb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsMkb.SelectCommand = "SELECT TOP 100 * FROM MKB10 ORDER BY MkbNam";
          sdsPvd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsPvd.SelectCommand = "SELECT ObrPvdKod,ObrPvdNam FROM SprObrPvd ORDER BY ObrPvdKod";
          //=====================================================================================

          if (!Page.IsPostBack)
          {
              Session.Add("KLTIDN", (string)"");
              Session.Add("WHERE", (string)"");

              getDocNum();
          }
          //               filComboBox();

      }

      // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNum()
      {

          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbDocIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbDocIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              //     obout:OboutTextBox ------------------------------------------------------------------------------------      
              Jlb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCJLB"]);
              Anm003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANM"]);
              AnmLif003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANMLIF"]);
              Stt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCLOC"]);
              Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
              Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
              Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
              Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
              //               Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              //if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCNOZ"].ToString())) BoxDocNoz.SelectedValue = "0";
              //else BoxDocNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCNOZ"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRPVD"].ToString())) BoxDocPvd.SelectedIndex = 0;
              else BoxDocPvd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRPVD"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRPVD"].ToString())) BoxDocPvd.SelectedValue = "0";
              else BoxDocPvd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCOBRPVD"]);

              //if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRNPR"].ToString())) BoxDocNpr.SelectedIndex = 0;
              //else BoxDocNpr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRNPR"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRVID"].ToString())) BoxDocVid.SelectedIndex = 0;
              else BoxDocVid.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRVID"]);

              /*
                              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG1"].ToString())) BoxDig001.SelectedIndex = 0;
                              else BoxDig001.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG1"]);

                              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG2"].ToString())) BoxDig002.SelectedIndex = 0;
                              else BoxDig002.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG2"]);

                              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCMKBDG3"].ToString())) BoxDig003.SelectedIndex = 0;
                              else BoxDig003.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCMKBDG3"]);
              */
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESOBR"].ToString())) BoxDocResObr.SelectedIndex = 0;
              else BoxDocResObr.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCRESOBR"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR001"].ToString())) ChkBox001.Checked = false;
              else ChkBox001.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR001"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR002"].ToString())) ChkBox002.Checked = false;
              else ChkBox002.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR002"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR003"].ToString())) ChkBox003.Checked = false;
              else ChkBox003.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR003"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESNPR004"].ToString())) ChkBox004.Checked = false;
              else ChkBox004.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESNPR004"]);
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCRESCPO"].ToString())) ChkBoxEnd.Checked = false;
              else ChkBoxEnd.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["DOCRESCPO"]);

          }

          //          string name = value ?? string.Empty;
      }
      // ============================ чтение заголовка таблицы а оп ==============================================
      void filComboBox()
      {
          int i;

          String[] MasPvd = {"Заболевание", "Профосмотр", "Диспансеризация", "Прививка", "Медико-социальный", "Прочие",
                               "Травма на производстве","Травма в сель.хоз.","Травма ДТП на производстве","Травма прочая на производстве",
                               "Травма бытовая","Травма уличная","Травма в ДТП","Травма спортивная","Травма школьная"};
          String[] MasNpr = {"АДА(СВА)", "Скорая помощью", "Стационаром", "Самостоятельно"};
          String[] MasVid = {"Поликлиника", "Дома", "В школе (д/с)", "В учреждении", "Дневой стационар", "Стационар на дому"};
          String[] MasRes = { "Здоров", "Выздоровление", "Без перемен", "Улучшение", "Госпитализация", "Смерть", "Отказ больного", "Выезд", "Привит", "Прочие", "Продолжение СПО" };
          String[] MasDig = { "Предварительный", "Клинический", "Окончательный"};

          // looping through the full names array and adding each state to the first combobox
          BoxDocPvd.Items.Clear();
          BoxDocPvd.SelectedIndex = -1;
          BoxDocPvd.SelectedValue = "";
          for (i = 0; i < MasPvd.Length; i++)
          {
              BoxDocPvd.Items.Add(new ComboBoxItem(MasPvd[i], Convert.ToString(i+1)));
          }
          // looping through the full names array and adding each state to the first combobox
          //for (i = 0; i < MasNpr.Length; i++)
          //{
          //    BoxDocNpr.Items.Add(new ComboBoxItem(MasNpr[i], Convert.ToString(i+1)));
          //}
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasVid.Length; i++)
          {
              BoxDocVid.Items.Add(new ComboBoxItem(MasVid[i], Convert.ToString(i+1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasRes.Length; i++)
          {
              BoxDocResObr.Items.Add(new ComboBoxItem(MasRes[i], Convert.ToString(i + 1)));
          }
          // looping through the full names array and adding each state to the first combobox
          for (i = 0; i < MasDig.Length; i++)
          {
              //              BoxDig001.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
              //               BoxDig002.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
              //               BoxDig003.Items.Add(new ComboBoxItem(MasDig[i], Convert.ToString(i + 1)));
          }
          //           BoxDocPvd.SelectedIndex = 3;
          //           BoxDocNpr.SelectedIndex = 4;
          //           BoxDocVid.SelectedIndex = 5;

      }

      //------------------------------------------------------------------------
      // ==================================== поиск клиента по фильтрам  ============================================
      protected void FndBtn_Click(object sender, EventArgs e)
      {
          int I = 0;
          string commandText = "SELECT * FROM MKB10 ";
          string whereClause = "";

          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          whereClause = "";
          if (FndTxt.Text != "")
          {
              I = I + 1;
              whereClause += "MKBNAM LIKE '" + FndTxt.Text.Replace("'", "''") + "%'";
          }
          if (FndKod.Text != "")
          {
              I = I + 1;
              if (I > 1) whereClause += " AND ";
              whereClause += "MKBKOD LIKE '" + FndKod.Text.Replace("'", "''") + "%'";
          }

          if (whereClause != "")
          {
              whereClause = whereClause.Replace("*", "%");


              if (whereClause.IndexOf("SELECT") != -1) return;
              if (whereClause.IndexOf("UPDATE") != -1) return;
              if (whereClause.IndexOf("DELETE") != -1) return;

              commandText += " where " + whereClause;
              SqlCommand cmd = new SqlCommand(commandText, con);
              con.Open();
              SqlDataReader myReader = cmd.ExecuteReader();
              gridMkb.DataSource = myReader;
              gridMkb.DataBind();
              con.Close();

          }
      }

  </script>   
    
    
<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
            <asp:HiddenField ID="parMkbNum" runat="server" />
       <%-- ============================  шапка экрана ============================================ --%>

   
          <%-- ============================  шапка экрана ============================================ --%>
 <asp:Panel ID="PanelMid" runat="server" BorderStyle="Groove" ScrollBars="Vertical" 
             Style="left: 0%; position: relative; top: 0px; width: 99%; height: 500px;">

         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
<%--                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Noz002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Нозология" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>--%>
                             <td width="94%" style="vertical-align: top;" >
<%--                                 <obout:ComboBox runat="server" ID="BoxDocNoz" Width="18%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsNoz" DataTextField="NozNam" DataValueField="NozKod" >
                                 </obout:ComboBox>   --%>
                               
                                 <asp:Label id="LblPvd" Text="Повод:" runat="server"  Width="8%" Font-Bold="true" />   
                                 <obout:ComboBox runat="server" ID="BoxDocPvd"  Width="50%" Height="200" 
                                        DataSourceID="SdsPvd" DataTextField="ObrPvdNam" DataValueField="ObrPvdKod" 
                                        FolderStyle="/Styles/Combobox/Plain"> 
                                </obout:ComboBox>  

<%--                                 <asp:Label id="LblNpr" Text="Напр.:" runat="server"  Width="8%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocNpr"  Width="16%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain">
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem29" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem25" runat="server" Text="АДА(СВА)" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem26" runat="server" Text="Скорая помощью" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem27" runat="server" Text="Стационаром" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem28" runat="server" Text="Самостоятельно" Value="4" />
                                        </Items>
                                 </obout:ComboBox>  
--%>
                                 <asp:Label id="LblVid" Text="Вид:" runat="server"  Width="8%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocVid"  Width="25%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain">
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem30" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem31" runat="server" Text="Поликлиника" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem32" runat="server" Text="Дома" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="В школе (д/с)" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="В учреждении" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="Дневой стационар" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem36" runat="server" Text="Стационар на дому" Value="6" />
                                        </Items>
                                 </obout:ComboBox>  
                             </td>
                        </tr>
       </table>

         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Жалобы" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="94%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>
                        </tr>
 <!--  Анамнез жизни----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез жизни" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="94%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmLif003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr> 
             
<!--  Анамнез бол----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Anm002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез бол" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="94%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr> 
 <!--  Статус ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Статус" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="94%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="60px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>                     
                         </tr> 
                                                 
 <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                             
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dig002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз осн" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                
                                    <asp:Label id="Label1" Text="МК" runat="server"  Width="35%" Font-Bold="true" />                             
                                    <asp:TextBox ID="Mkb001" Width="55%" Height="20" runat="server" ReadOnly="true" Style="font-weight: 700; font-size: medium; text-align:center" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dig003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
                
 <!--  Диагноз сопутствующий ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dsp002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз соп" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                    <asp:Label id="Label2" Text="МК" runat="server"  Width="35%" Font-Bold="true" />                             
                                    <asp:TextBox ID="Mkb002" Width="55%" Height="20" runat="server" ReadOnly="true" Style="font-weight: 700; font-size: medium; text-align:center" />
                           </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dsp003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
                
 <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лечение" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
 		                         </obout:OboutTextBox>
  
                               </td>

                        </tr> 
        </table>
  
        <hr>      
<!-- Результат----------------------------------------------------------------------------------------------------------  -->    
               <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr> 
                             <td width="20%" style="vertical-align: central;" >
                                        <asp:Label id="Label4" Text="Исход обращ.:" runat="server"  Width="40%" Font-Bold="true" />                             
                                        <obout:ComboBox runat="server" ID="BoxDocResObr"  Width="55%" Height="250"
                                               FolderStyle="/Styles/Combobox/Plain" >
                                               <Items>
                                                   <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="Выздоровление" Value="1" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text="Без перемен" Value="2" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="Улучшение" Value="3" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="Госпитализация" Value="4" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="Смерть" Value="5" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="Отказ больного" Value="6" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem44" runat="server" Text="Выезд" Value="7" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem45" runat="server" Text="Привит" Value="8" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem46" runat="server" Text="Прочие" Value="9" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem47" runat="server" Text="Продолжение СПО" Value="10" />
                                               </Items>
                                        </obout:ComboBox>  
                              </td>
                                 <td width="5%" style="vertical-align: central;" >    
                                        <asp:Label id="Label5" Text="Направлены:" runat="server" Width="10%" Font-Bold="true" />  
                              </td>
                                 <td width="5%" style="vertical-align: central;" >
                                            <obout:OboutCheckBox runat="server" ID="ChkBox001"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                </obout:OboutCheckBox>                           
                                        <asp:Label id="Label7" Text="МСЭ" runat="server" />  
                                </td>
                                     <td width="5%" style="vertical-align: central;"  >
                                        <obout:OboutCheckBox runat="server" ID="ChkBox002"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                </obout:OboutCheckBox>                                   
                                         <asp:Label id="Label8" Text="КДП(КДЦ)" runat="server" />  
                              </td>
                                     <td width="5%" style="vertical-align: central;" >
                                              <obout:OboutCheckBox runat="server" ID="ChkBox003"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                </obout:OboutCheckBox>                                   
                                        <asp:Label id="Label9" Text="Туб.дсп" runat="server" /> 
                                     </td>     
                               <td width="5%" style="vertical-align: central;" >
                                           <obout:OboutCheckBox runat="server" ID="ChkBox004"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                </obout:OboutCheckBox>  
                                         <asp:Label id="Label10" Text="Онкол" runat="server" />  
                              </td>
                               <td width="15%" style="vertical-align: central;  " >
                                        <asp:Label id="Label6" Text="СПО завершен:" runat="server"  Font-Bold="true"  />                             
                                        <obout:OboutCheckBox runat="server" ID="ChkBoxEnd"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                                </obout:OboutCheckBox>  
                               </td>
                        </tr>
       </table>
  <!-- Результат ---------------------------------------------------------------------------------------------------------- 
     
       -->
               
 
        </asp:Panel> 
    <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="MkbWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="200" Top="50" Height="400" Width="900" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Справочник МКБ10">
           
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="15%" class="PO_RowCap" align="left">Текст:</td>
                            <td width="25%">
                                <asp:TextBox ID="FndTxt" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="15%" class="PO_RowCap" align="left">Код:</td>
                            <td width="25%">
                                <asp:TextBox ID="FndKod" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>
                            
                            <td width="10%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                        </tr>
            </table>


            <oajax:CallbackPanel ID="CallbackPanelMkb" runat="server">
             <Content>           
              <obout:Grid ID="gridMkb"
                  runat="server"
                  CallbackMode="true"
                  Serialize="true"
                  AutoGenerateColumns="false"
                  FolderStyle="~/Styles/Grid/style_5"
                  AllowAddingRecords="false"
                  ShowLoadingMessage="true"
                  ShowColumnsFooter="false"
                  KeepSelectedRecords="true"
                  DataSourceID="sdsMkb"
                  Width="100%"
                  PageSize="-1"
                  ShowFooter="false">
                 <ClientSideEvents OnClientDblClick="OnClientDblClick" />
                 <Columns>
                      <obout:Column ID="Column20" DataField="MKBIDN" HeaderText="Идн" ReadOnly="true" Width="0%" Visible="false" />
                      <obout:Column ID="Column21" DataField="MKBKOD" HeaderText="Код" ReadOnly="true" Width="5%"  Align="left"/>
                      <obout:Column ID="Column22" DataField="MKBNAM" HeaderText="Наименование" ReadOnly="true" Width="95%" Align="left" />
                </Columns>
                <ScrollingSettings ScrollHeight="400" ScrollWidth="100%" />
              </obout:Grid>
              
             </Content>
           </oajax:CallbackPanel>
             
          </owd:Window>
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
    background-color: gray; /* Цвет линии */
    color: gray; /* Цвет линии для IE6-7 */
    height: 2px; /* Толщина линии */
   }
</style>

  <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsPvd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



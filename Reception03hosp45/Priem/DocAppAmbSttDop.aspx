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

         function onChange(sender, newText) {
 //            alert("onChangeStsGnr=" + sender.ID);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID) {
                 case 'StsGnr003':
                     GrfDocRek = 'DOCSTSGNR';
                     break;
                 case 'StsSrd003':
                     GrfDocRek = 'DOCSTSSRD'
                     break;
                 case 'StsDix003':
                     GrfDocRek = 'DOCSTSDIX'
                     break;
                 case 'StsJkt003':
                     GrfDocRek = 'DOCSTSJKT';
                     break;
                 case 'StsMch003':
                     GrfDocRek = 'DOCSTSMCH';
                     break;
                 case 'StsNer003':
                     GrfDocRek = 'DOCSTSNER';
                     break;
                 case 'StsKoz003':
                     GrfDocRek = 'DOCSTSKOZ';
                     break;
                 case 'StsKst003':
                     GrfDocRek = 'DOCSTSKST';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }


         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBDOC';
             var DatDocKey = 'DOCAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

            var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

//             alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
             switch (DatDocTyp) {
                 case 'Sql':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Str':
                     DatDocTyp = 'Str';
                     SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                     break;
                 case 'Dat':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 case 'Int':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
                 default:
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
//             alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

         }

         // ==================================== ГОЛОСОВОЙ ВВОД  ============================================
         function Speech(event) {
   //          alert("OnButtonTitClick=" + event);
             var ParTxt = "Жалобы";
             window.open("SpeechAmb.aspx?ParTxt=" + event, "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

         // ==================================== ГОЛОСОВОЙ ВВОД  ПОЛУЧИТЬ РЕЗУЛЬТАТ ============================================
         function HandlePopupResult(result) {
 //                    alert("result of popup is: " + result);
             var MasPar = result.split('@');

             if (MasPar[0] == 'GrfStsGnr') document.getElementById('StsGnr003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsSrd') document.getElementById('StsSrd003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsDix') document.getElementById('StsDix003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsJkt') document.getElementById('StsJkt003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsMch') document.getElementById('StsMch003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsNer') document.getElementById('StsNer003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsKoz') document.getElementById('StsKoz003').value = MasPar[1];
             if (MasPar[0] == 'GrfStsKst') document.getElementById('StsKst003').value = MasPar[1];
         }


         // ==================================== при выборе клиента показывает его программу  ============================================
         function TmpSab(ButXxx) {
             //             alert("ButXxx=" + ButXxx);
             /*
             var DatDocMdb = 'HOSPBASE';

             if (ButXxx == 'DOCSTSGNR') SqlStr = "SELECT TOP 1 STSGNR FROM SPRSTSETL WHERE STSDLG=1";
             if (ButXxx == 'DOCSTSSRD') SqlStr = "SELECT TOP 1 STSSRD FROM SPRSTSETL WHERE STSDLG=1";
             if (ButXxx == 'DOCSTSDIX') SqlStr = "SELECT TOP 1 STSDIX FROM SPRSTSETL WHERE STSDLG=1";
             if (ButXxx == 'DOCSTSJKT') SqlStr = "SELECT TOP 1 STSJKT FROM SPRSTSETL WHERE STSDLG=1";
             if (ButXxx == 'DOCSTSMCH') SqlStr = "SELECT TOP 1 STSMCH FROM SPRSTSETL WHERE STSDLG=1";
             if (ButXxx == 'DOCSTSNER') SqlStr = "SELECT TOP 1 STSNER FROM SPRSTSETL WHERE STSDLG=1";

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/SelectOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '"}',
                 dataType: "json",
                 success: function (response) {
                     if (ButXxx == 'DOCSTSGNR') {
                         alert("response=" + response.d);
                         alert("response2=" +  document.getElementById('StsGnr003').value);
                         document.getElementById('StsGnr003').value = response.d;
            //         НО ПОСЛЕ ОБНОВЛЕНИЯ ПРОИСХОДИТЬ POSTBACK
                     }
                     if (ButXxx == 'DOCSTSSRD') StsSrd003.Text = response.d;
                     if (ButXxx == 'DOCSTSDIX') StsDix003.Text = response.d;
                     if (ButXxx == 'DOCSTSJKT') StsJkt003.Text = response.d;
                     if (ButXxx == 'DOCSTSMCH') StsMch003.Text = response.d;
                     if (ButXxx == 'DOCSTSNER') StsNer003.Text = response.d;
                 },
                 error: function () { alert("ERROR=" + SqlStr); }
             });
             */
         }



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
          //            AmbCrdIdn = (string)Session["AmbCrdIdn"];
          AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          //=====================================================================================
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
          int DlgKod = 0;
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

              DlgKod=Convert.ToInt32(ds.Tables[0].Rows[0]["DLGKOD"]);
              //     obout:OboutTextBox ------------------------------------------------------------------------------------    
              if (DlgKod == 44)
              {
                  //<!-- Кожные покровы:  ----------------------------------------------------------------------------------------------------------  -->
                  StsKoz001.Enabled = false;
                  StsKoz002.Enabled = false;
                  StsKoz003.Visible = false;
                 //<!-- Костно-мышечная система:  ----------------------------------------------------------------------------------------------------------  -->
                  StsKst001.Enabled = false;
                  StsKst002.Enabled = false;
                  StsKst003.Visible = false;
                  StsNer002.Text = "Эндокрин. система";
              }
              StsGnr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSGNR"]);
              StsSrd003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSSRD"]);
              StsDix003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSDIX"]);
              StsJkt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSJKT"]);
              StsMch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSMCH"]);
              StsNer003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSNER"]);
              StsKoz003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSKOZ"]);
              StsKst003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSKST"]);

          }
          //          string name = value ?? string.Empty;
      }


      // ============================ кнопка новый документ  ==============================================

      protected void RepButton_Click(object sender, EventArgs e)
      {
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbSttPrv", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          // Выполнить команду
          con.Open();

          cmd.ExecuteNonQuery();

          con.Close();

          getDocNum();

      }
      // ============================ кнопка новый документ  ==============================================

      protected void TmpButton_Click(object sender, EventArgs e)
      {
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbSttTmp", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = "ADD";
          // Выполнить команду
          con.Open();

          cmd.ExecuteNonQuery();

          con.Close();

          getDocNum();

      }

      protected void ClrButton_Click(object sender, EventArgs e)
      {
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbSttTmp", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = "DEL";
          // Выполнить команду
          con.Open();

          cmd.ExecuteNonQuery();

          con.Close();

          getDocNum();

      }
      // ============================ чтение заголовка таблицы а оп ==============================================
      //------------------------------------------------------------------------
      // ==================================== поиск клиента по фильтрам  ============================================

  </script>   
    
    
<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
            <asp:HiddenField ID="parMkbNum" runat="server" />
       <%-- ============================  шапка экрана ============================================ --%>

    <div>
   
          <%-- ============================  шапка экрана ============================================ --%>

         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Общее состояние ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsGnr001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsGnr002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Общее состояние" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="StsGnr003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsGnr" onclick="Speech('GrfStsGnr')">
                                <img id="start_img1" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
 <!--  Дыхательная система:  ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsDix001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsDix002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Дыхат. система:  " Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsDix003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsSrd" onclick="Speech('GrfStsDix')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>               
<!--  Сердечно-сосудистая система: ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsSrd001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsSrd002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Сер.сос. система:" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsSrd003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsSrd" onclick="Speech('GrfStsSrd')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 


             <!-- Пищеварительная система:  ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsJkt001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsJkt002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Пищевар. система: " Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsJkt003"  width="100%" BackColor="White" Height="60px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:3%" >
                                <button id="start_StsJkt" onclick="Speech('GrfStsJkt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
                                                 
 <!--  Мочеиспускательная система:  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                             
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsMch001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsMch002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Мочепол. система: " Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsMch003"  width="100%" BackColor="White" Height="55px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                             </td>

                             <td style="vertical-align: top; width:3%" >
                                <button id="start_StsMch" onclick="Speech('GrfStsMch')">
                                 <img id="start_img4" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
                
 <!-- Неврологический статус:  ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsNer001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsNer002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Невролог. статус: " Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsNer003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsNer" onclick="Speech('GrfStsNer')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
 
 <!-- Кожные покровы:  ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsKoz001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsKoz002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Кожные покровы " Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsKoz003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsNer" onclick="Speech('GrfStsKoz')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
 <!-- Костно-мышечная система:  ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsKst001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="StsKst002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Кост.мыш.система" Height="30px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="91%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsKst003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:3%" >
                                <button id="start_StsNer" onclick="Speech('GrfStsKst')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
               
        </table>
  
  <!-- Результат ----------------------------------------------------------------------------------------------------------        -->
  <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left:0; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Заполнить из предыдущего" onclick="RepButton_Click"/>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Заполнить шаблоном" onclick="TmpButton_Click"/>
                 <asp:Button ID="ClrButton" runat="server" CommandName="Add" Text="Очистить шаблон" onclick="ClrButton_Click"/>
             </center>
  </asp:Panel>              
             
 
    <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
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
        font-size: 10px !important;
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

 
</body>
</html>



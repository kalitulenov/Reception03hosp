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
             //            alert("onChangeJlb=" + sender.ID);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID) {
                 case 'Jlb003':
                     GrfDocRek = 'DOCJLB';
                     break;
                 case 'Anm003':
                     GrfDocRek = 'DOCANM'
                     break;
                 case 'AnmAlr003':
                     GrfDocRek = 'KLTALR'
                     break;
                 case 'Stt003':
                     GrfDocRek = 'DOCLOC';
                     break;
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }


         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeTxt(sender, newText) {
             //            alert("onChangeJlb=" + sender);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender) {
                 case 'Jlb003':
                     GrfDocRek = 'DOCJLB';
                     break;
                 case 'Anm003':
                     GrfDocRek = 'DOCANM'
                     break;
                 case 'AnmLif003':
                     GrfDocRek = 'DOCANMLIF'
                     break;
                 case 'Stt003':
                     GrfDocRek = 'DOCLOC';
                     break;
                 case 'Dig003':
                     GrfDocRek = 'DOCDIG';
                     break;
                 case 'Dsp003':
                     GrfDocRek = 'DOCDIGSOP';
                     break;
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function OnSelectedIndexChanged(sender, selectedIndex) {
             //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
             //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
             //           alert('SelectedIndexChanged: ' + selectedIndex);
             //             alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal;
             var GrfDocTyp = 'Int';

             switch (sender.ID) {
                 case 'BoxDocPvd':
                     GrfDocRek = 'DOCOBRPVD'
                     GrfDocVal = BoxDocPvd.options[BoxDocPvd.selectedIndex()].value;
                     break;
                 case 'BoxDocTor':
                     GrfDocRek = 'DOCOBRVID'
                     GrfDocVal = BoxDocTor.options[BoxDocTor.selectedIndex()].value;
                     break;
                 case 'BoxZak':
                     GrfDocRek = 'DOCOBRNPR';
                     GrfDocVal = BoxZak.options[BoxZak.selectedIndex()].value;
                     break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

            if (sender.ID == 'BoxDocPvd') {
                 if (GrfDocVal != "4") window.parent.HandleResult("Заболевание");
             }
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

             DatDocVal = DatDocVal.replace("\\", "\u002F");
             DatDocVal = DatDocVal.replace("\\", "\u002F");
             DatDocVal = DatDocVal.replace("\\", "\u002F");
             DatDocVal = DatDocVal.replace("\\", "\u002F");
             DatDocVal = DatDocVal.replace("\\", "\u002F");
             DatDocVal = DatDocVal.replace("\\", "\u002F");

             DatDocVal = DatDocVal.replace("\"", "\\u0022");
             DatDocVal = DatDocVal.replace("\"", "\\u0022");
             DatDocVal = DatDocVal.replace("\"", "\\u0022");
             DatDocVal = DatDocVal.replace("\"", "\\u0022");
             DatDocVal = DatDocVal.replace("\"", "\\u0022");
             DatDocVal = DatDocVal.replace("\"", "\\u0022");

             DatDocVal = DatDocVal.replace("\'", "\\u0022");
             DatDocVal = DatDocVal.replace("\'", "\\u0022");
             DatDocVal = DatDocVal.replace("\'", "\\u0022");
             DatDocVal = DatDocVal.replace("\'", "\\u0022");
             DatDocVal = DatDocVal.replace("\'", "\\u0022");
             DatDocVal = DatDocVal.replace("\'", "\\u0022");

      //       alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
                     if (GrfDocRek == 'KLTALR') SqlStr = "UPDATE SPRKLT SET KLTALR='" + DatDocVal + "' WHERE KLTIIN='" + document.getElementById('parKltIin').value + "'";
                     else SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
     //      alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function ()
                 {
                 //    alert("ERROR=" + SqlStr);
                 }
             });

             if (sender.ID == 'BoxDocPvd') {
                 //       alert("GrfDocVal ==" + GrfDocVal);
                 if (GrfDocVal == "2") {
                     document.getElementById('Jlb003').value = ' жалоб нет.';
                     onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
                     document.getElementById('Anm003').value = ' Хронические заболевания отрицает.';
                     onChangeTxt('Anm003', document.getElementById('Anm003').value);
                     document.getElementById('AnmLif003').value =  'Аллергии нет. Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
                     onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
                     document.getElementById('Stt003').value = 'Общее состояние удовлетворительное. Сознание ясное.';
                     onChangeTxt('Stt003', document.getElementById('Stt003').value);

                     onChangeTxt('Dig003', 'Рутинная общая проверка');
                     onChangeTxt('Mkb001', 'Z10.8');
                 }
             }

             //   ----------------------------------- НОЗОЛОГИЮ ПОВТОРИТЬ В УСЛУГЕ
         }

// --------------------- клише на анамнез жизни 
        
         function SablonJlb() {
             document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + 'Жалоб нет.';
             onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
         }

         function SablonAnm() {
             document.getElementById('Anm003').value = document.getElementById('Anm003').value + 'Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
             onChangeTxt('Anm003', document.getElementById('Anm003').value);
         }

         function SablonAnmAlr() {
             document.getElementById('AnmAlr003').value = document.getElementById('AnmAlr003').value + 'Аллергии нет.';
             onChangeTxt('AnmAlr003', document.getElementById('AnmAlr003').value);
         }
 
         function SablonLch() {
             document.getElementById('Lch003').value = document.getElementById('Lch003').value + 'ПРОТИВ _______________ ДОЗА _______ ДАТА ________ СЕРИЯ_________';
             onChangeTxt('Lch003', document.getElementById('Lch003').value);
         }
         
         //    ---------------- обращение веб методу --------------------------------------------------------

         function HandlePopupStatus(result) {
             //          alert(result);
             document.getElementById('Stt003').value = result;
             onChangeTxt('Stt003', document.getElementById('Stt003').value);
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
          parBuxKod.Value = BuxKod;
          //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
          AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          parCrdIdn.Value = AmbCrdIdn;


          if (!Page.IsPostBack)
          {

              //=====================================================================================
              //     sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              //     sdsNoz.SelectCommand = "SELECT NozKod,NozNam FROM SprNoz ORDER BY NozNam";
              sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
              sdsKto.SelectCommand = "SELECT BuxKod,FI+' '+DLGNAM AS FIODLG FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ' ORDER BY FI";
              //=====================================================================================
              Session.Add("KLTIDN", (string)"");
              Session.Add("WHERE", (string)"");

              getDocNum();
          }
          //               filComboBox();

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
              AnmAlr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTALR"]);
              Stt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCLOC"]);
       //       Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
       //       Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
       //       Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
       //       Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
       //       Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);
       //       MkbSop001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP001"]);
       //       MkbSop002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP002"]);
       //       MkbSop003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKBSOP003"]);

              TekDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFCTRDAT"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 

          //    if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRPVD"].ToString())) BoxDocPvd.SelectedIndex = 0;
          //    else BoxDocPvd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRPVD"]);
              BoxDocPvd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCOBRPVD"]);

            //  if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRNPR"].ToString())) BoxZak.SelectedIndex = 0;
            //  else BoxZak.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRNPR"]);
              BoxZak.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCOBRNPR"]);

             // if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRVID"].ToString())) BoxDocTor.SelectedIndex = 0;
             // else BoxDocTor.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRVID"]);
              BoxDocTor.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DOCOBRVID"]);

              //     obout:CheckBox ------------------------------------------------------------------------------------ 

              parKltIin.Value = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);
           //   parDlgSts.Value = Convert.ToString(ds.Tables[0].Rows[0]["DLGSTS"]);

          }

          //          string name = value ?? string.Empty;
      }
      // ==================================== ШАБЛОНЫ  ============================================
      //------------------------------------------------------------------------
      protected void SablonPrvJlb(object sender, EventArgs e) { SablonPrv("Jlb");}
      protected void SablonPrvAnm(object sender, EventArgs e) { SablonPrv("Anm"); }
      protected void SablonPrvLif(object sender, EventArgs e) { SablonPrv("Lif"); }
      protected void SablonPrvStt(object sender, EventArgs e) { SablonPrv("Stt"); }
      protected void SablonPrvDig(object sender, EventArgs e) { SablonPrv("Dig"); }
      protected void SablonPrvDsp(object sender, EventArgs e) { SablonPrv("Dsp"); }
      protected void SablonPrvLch(object sender, EventArgs e) { SablonPrv("Lch"); }

      void SablonPrv(string SblTyp)
      {
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          // создание соединение Connection
          SqlConnection con = new SqlConnection(connectionString);
          // создание команды
          SqlCommand cmd = new SqlCommand("HspAmbSblPrv", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
          cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = SblTyp;
          // Выполнить команду
          con.Open();
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
            <asp:HiddenField ID="parStsImg" runat="server" />
            <asp:HiddenField ID="parKltIin" runat="server" />

            <span id="WindowPositionHelper"></span>
     <%-- ============================  шапка экрана ============================================ --%>

    <div style="position: relative; top: -10px;">
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
         <table border="0" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace" >
 <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                              <td width="100%" style="vertical-align: central;" >
                                 <asp:Label id="LblPvd" Text="Повод обращения:" runat="server"  Width="12%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxDocPvd"  Width="30%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Заболевание" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Профосмотр" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Диспансеризация" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Прививка" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Медико-социальный" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Прочие" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Травма на производстве" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Травма в сель.хоз." Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="Травма ДТП на производстве" Value="9" />
                                            <obout:ComboBoxItem ID="ComboBoxItem19" runat="server" Text="Травма прочая на производстве" Value="10" />
                                            <obout:ComboBoxItem ID="ComboBoxItem20" runat="server" Text="Травма бытовая" Value="11" />
                                            <obout:ComboBoxItem ID="ComboBoxItem21" runat="server" Text="Травма уличная" Value="12" />
                                            <obout:ComboBoxItem ID="ComboBoxItem22" runat="server" Text="Травма в ДТП" Value="13" />
                                            <obout:ComboBoxItem ID="ComboBoxItem23" runat="server" Text="Травма спортивная" Value="14" />
                                            <obout:ComboBoxItem ID="ComboBoxItem24" runat="server" Text="Травма школьная" Value="15" />
                                         </Items>
                                         <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>  
                             </td>
                        </tr>
       </table>

         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Jlb001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="SablonJlb()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Жалобы" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:7%" >
                             </td>
                        </tr>
<!--  Анамнез болезни ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Anm001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Anm002" runat="server"
                                    OnClientClick="SablonAnm()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез бол" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                             </td>
                        </tr> 

 <!--  Аллергия,Противопоказания -----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="AnmAlr001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="AnmAlr002" runat="server"
                                    OnClientClick="SablonAlr()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Аллергол. анамнез" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmAlr003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                             </td>
                        </tr>     

             <!--  Заключение ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Stt001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Заключение" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxZak"  Width="30%" Height="250"
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                              <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="Здоров(а) допускается к иммунизации" Value="0" />
                                              <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="Мед отвод постоянный с диагнозом" Value="1" />
                                              <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="Мед отвод временный с диагнозом" Value="2" />
                                        </Items>
                                        <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>  
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="55%" BackColor="White" Height="30px" 
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                             </td>
                          </tr> 
                                                 
 <!--  Прививка ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Lch001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="SablonLch()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Прививка" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="40px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:7%" >
                             </td>
                        </tr> 
        </table>
  
           
<!-- Результат---------------------------------------------------------------------------------------------------------- <hr>    -->    
               <table border="0" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace" >
                   <tr>
                       <td width="60%" style="vertical-align: central;">
                           <asp:Label ID="Label4" Text="Осмотр врача через 30 минут:" runat="server" Width="30%" Font-Bold="true" />
                           <obout:ComboBox runat="server"
                               ID="BoxDocTor"
                               Width="40%"
                               Height="200"
                               EmptyText="Выберите врача ..."
                               FolderStyle="/Styles/Combobox/Plain"
                               DataSourceID="sdsKto"
                               DataTextField="FIODLG"
                               DataValueField="BUXKOD">
                               <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                           </obout:ComboBox>

                       </td>
                       <td style="vertical-align: top; width:30%" > </td>
                   </tr>
       </table>
  <!-- Как сделать длинный пробел? ---------------------------------------------------------------------------------------------------------- 
     &nbsp; неразрывный пробел
&thinsp; узкий пробел (применяют в двойных словах)
&ensp; средний, разрывной пробел
&emsp; длинный разрывной пробел (примеяют в конце предложений)

      <span style='padding-left:10px;'> </span>
       -->
               
 
        </div>
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
    background-color: gray; /* Цвет линии */
    color: gray; /* Цвет линии для IE6-7 */
    height: 2px; /* Толщина линии */
   }
</style>

  <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



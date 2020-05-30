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

         window.onload = function () {
             parBrowser.value = "Desktop";
             if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                 parBrowser.value = "Android";
 //                alert("Android");
             }
 //            else alert("Desktop");
         };

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
 //            alert("onChangeJlb=" + sender.ID + " " + newText);
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
                 case 'Mkb001':
                     GrfDocRek = 'DOCMKB001';
                     break;
                 case 'Mkb002':
                     GrfDocRek = 'DOCMKB002';
                     break;
                 case 'Mkb003':
                     GrfDocRek = 'DOCMKB003';
                     break;
                 case 'TxtResAdd':
                     GrfDocRek = 'SMPENDADD';
                     break;
                 case 'TxtResChs':
                     GrfDocRek = 'SMPENDCHS';
                     break;
                 case 'TxtResPls':
                     GrfDocRek = 'SMPENDPLS';
                     break;
                 case 'TxtResGdd':
                     GrfDocRek = 'SMPENDGDD';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeTxt(sender, newText) {
  //           alert("onChangeTxt=" + sender + " " + newText);

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
                 case 'Mkb001':
                     GrfDocRek = 'DOCMKB001';
                     break;
                 case 'Mkb002':
                     GrfDocRek = 'DOCMKB002';
                     break;
                 case 'Mkb003':
                     GrfDocRek = 'DOCMKB003';
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
                 case 'BoxDocNoz':
                     GrfDocRek = 'DOCNOZ';
                     GrfDocVal = BoxDocNoz.options[BoxDocNoz.selectedIndex()].value;
//                     alert('GrfDocVal: ' + GrfDocVal);
                     break;
                 case 'BoxDocPvd':
                     GrfDocRek = 'DOCOBRPVD'
                     GrfDocVal = BoxDocPvd.options[BoxDocPvd.selectedIndex()].value;
                     break;
                 case 'BoxDocNpr':
                     GrfDocRek = 'DOCOBRNPR';
                     GrfDocVal = BoxDocNpr.options[BoxDocNpr.selectedIndex()].value;
                     break;
                 case 'BoxDocVid':
                     GrfDocRek = 'DOCOBRVID';
                     GrfDocVal = BoxDocVid.options[BoxDocVid.selectedIndex()].value;
                     break;
                 case 'BoxDig001':
                     GrfDocRek = 'DOCMKBDG1';
                     GrfDocVal = BoxDig001.options[BoxDig001.selectedIndex()].value;
                     break;
                 case 'BoxDig002':
                     GrfDocRek = 'DOCMKBDG2';
                     GrfDocVal = BoxDig002.options[BoxDig002.selectedIndex()].value;
                     break;
                 case 'BoxDig003':
                     GrfDocRek = 'DOCMKBDG3';
                     GrfDocVal = BoxDig003.options[BoxDig003.selectedIndex()].value;
                     break;
                 case 'BoxRes':
                     GrfDocRek = 'SMPENDSTT';
                     GrfDocVal = BoxRes.options[BoxRes.selectedIndex()].value;
                     break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

         }

         //    ------------------------------------------------------------------------------------------------------------------------
        

         function onCheckedChanged(sender, isChecked) {
         //    alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
             //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
             //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
             //            alert('SelectedIndexChanged: ' + selectedIndex);
             //            alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal = isChecked;
             var GrfDocTyp = 'Bit';

             switch (sender.ID) {
                 case 'ChkBox001':
                     GrfDocRek = 'DOCRESNPR001';
                     break;
                 case 'ChkBox002':
                     GrfDocRek = 'DOCRESNPR002'
                     break;
                 case 'ChkBox003':
                     GrfDocRek = 'DOCRESNPR003';
                     break;
                 case 'ChkBox004':
                     GrfDocRek = 'DOCRESNPR004';
                     break;
                 case 'ChkBoxEnd':
                     GrfDocRek = 'DOCRESCPO';
                     break;
                 default:
                     break;

             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

         }

  /*       
         function OnClientDateChanged(sender, selectedDate) {

             var GrfDocRek='GRFCTRDAT';
             var GrfDocVal = txtDatCtr.value();
             var GrfDocTyp = 'Dat';
             alert("You've selected " + txtDatCtr.value());
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }
*/
         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBDOC';
             var DatDocKey = 'DOCAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             if (DatDocRek.substring(0, 3) == "SMP") {
                 DatDocTab = 'AMBSMP';
                 DatDocKey = 'SMPAMB';
             }

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

//             alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
             switch (DatDocTyp) {
                 case 'Sql':
                     DatDocTyp = 'Sql';
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=N'" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
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
                     SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=N'" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                     break;
             }
          //   alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

             //   ----------------------------------- НОЗОЛОГИЮ ПОВТОРИТЬ В УСЛУГЕ
             if (DatDocKey == 'DOCNOZ')
             {
                 DatDocTyp='Sql';
                 SqlStr = "UPDATE AMBUSL SET USLNOZ="+DatDocVal+" WHERE USLAMB="+DatDocIdn;
  //               alert("SqlStr=" + SqlStr);

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



         }

         // ==================================== при выборе клиента показывает его программу  ============================================
         function OnButton001Click() {
             parMkbNum.value = 1;
             MkbWindow.Open();
         }
         function OnButton002Click() {
             parMkbNum.value = 2;
             MkbWindow.Open();
         }
         function OnButton003Click() {
             parMkbNum.value = 3;
             MkbWindow.Open();
         }

         function LekRusLat() {
             var SqlStr = document.getElementById('Lch003').value;
             var DatDocMdb = 'HOSPBASE';
        //     alert("SqlStr=" + SqlStr);

             var QueryString = getQueryString();
             var DatDocIdn = QueryString[1];
        //     alert("DatDocIdn=" + DatDocIdn);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/Translate',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","TxtRus":"' + SqlStr + '","DatDocIdn":"' + DatDocIdn + '"}',
                 dataType: "json",
                 success: function (response)
                 {
             //        alert("response=" + response.d);
             //        onChangeTxt('Lch003', response.d);
             //       document.getElementById('Lch003').value = response.d;
             //       alert("response2=" + document.getElementById('Lch003').value);
                 },
                 error: function () { alert("ERROR=" + SqlStr); }
             });



         }

         function OnClientDblClick(iRecordIndex) {
   //          alert('OnClientDblClick= ' + parMkbNum.value);
            var GrfDocRek;
            var GrfDocVal = gridMkb.Rows[iRecordIndex].Cells[1].Value;
          
            if (parMkbNum.value == 1)
            {
                Mkb001.value=GrfDocVal;
                GrfDocRek = 'DOCMKB001';
             }
             if (parMkbNum.value == 2) 
             {
                 Mkb002.value = GrfDocVal;
                 GrfDocRek = 'DOCMKB002';
             }
             MkbWindow.Close();

             onChangeUpd(GrfDocRek, GrfDocVal,'Sql');
         }

      //    ------------------------------------------------------------------------------------------------------------------------
         function Speech(event) {
   //          alert("OnButtonTitClick=" + event);
             var ParTxt = "Жалобы";

             //               var QueryString = getQueryString();
             //               DatDocIdn = QueryString[1];

             //               var KltOneIdn = 12345;
             window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=" + parBrowser.value, "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
 //            alert("OnButtonTitClick=" + event);
             //                 SpeechWindow.setTitle("Голосовой блокнот");
             //                 SpeechWindow.setUrl("Speech_03.aspx?ParTxt=GrfJlb");
             //                 SpeechWindow.Open();

             return false;
         }

         function HandlePopupResult(result) {
             //                    alert("result of popup is: " + result);
             var MasPar = result.split('@');

             if (MasPar[0] == 'GrfJlb') {
                 document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + MasPar[1] + '.';
                 onChangeTxt('Jlb003', document.getElementById('Jlb003').value);
             }
             if (MasPar[0] == 'GrfAnm') {
                 document.getElementById('Anm003').value = document.getElementById('Anm003').value + MasPar[1] + '.';
                 onChangeTxt('Anm003', document.getElementById('Anm003').value);
             }
             if (MasPar[0] == 'GrfAnmLif') {
                 document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + MasPar[1] + '.';
                 onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
             }
             if (MasPar[0] == 'GrfStt') {
                 document.getElementById('Stt003').value = document.getElementById('Stt003').value + MasPar[1] + '.';
                 onChangeTxt('Stt003', document.getElementById('Stt003').value);
             }
             if (MasPar[0] == 'GrfDig') {
                 document.getElementById('Dig003').value = document.getElementById('Dig003').value + MasPar[1] + '.';
                 onChangeTxt('Dig003', document.getElementById('Dig003').value);
             }
             if (MasPar[0] == 'GrfDsp') {
                 document.getElementById('Dsp003').value = document.getElementById('Dsp003').value + MasPar[1] + '.';
                 onChangeTxt('Dsp003', document.getElementById('Dsp003').value);
             }
             if (MasPar[0] == 'GrfLch') {
                 document.getElementById('Lch003').value = document.getElementById('Lch003').value + MasPar[1] + '.';
                 onChangeTxt('Lch003', document.getElementById('Lch003').value);
             }
             //         document.getElementById('ctl00$MainContent$HidTextBoxFio').value = result;
         }

         // --------------------- клише на анамнез жизни 
         function SablonSts() {
             document.getElementById('Stt003').value = "АҚҚ (АД)  000/00   ЖСЖ(ЧСС) 00 ТАЖ(ЧД)  00  Дене қызуы(температура) 00";
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
          //            AmbCrdIdn = (string)Session["AmbCrdIdn"];
          AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
          //=====================================================================================
          sdsIsx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsIsx.SelectCommand = "SELECT * FROM Spr003Isx ORDER BY SmpIsxNam";
          sdsMkb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
          sdsMkb.SelectCommand = "SELECT TOP 100 * FROM MKB10 ORDER BY MkbNam";
          //=====================================================================================

          if (!Page.IsPostBack)
          {
              Session.Add("KLTIDN", (string)"");
              Session.Add("WHERE", (string)"");

          }
          getDocNum();
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
              //Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
              //Dsp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIGSOP"]);
              Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
              //Mkb001.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB001"]);
              //Mkb002.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB002"]);
              //       Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);

              //     obout:ComboBox ------------------------------------------------------------------------------------ 

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["SMPENDSTT"].ToString())) BoxRes.SelectedIndex = 0;
              else BoxRes.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["SMPENDSTT"]);

              TxtResAdd.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPENDADD"]);
              TxtResChs.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPENDCHS"]);
              TxtResPls.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPENDPLS"]);
              TxtResGdd.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPENDGDD"]);
              //     obout:CheckBox ------------------------------------------------------------------------------------ 

          }

          //          string name = value ?? string.Empty;
      }
      // ============================ чтение заголовка таблицы а оп ==============================================
      void filComboBox()
      {
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
              whereClause += "MKBNAM LIKE '%" + FndTxt.Text.Replace("'", "''") + "%'";
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
            <asp:HiddenField ID="parBrowser" runat="server" />
       <%-- ============================  шапка экрана ============================================ --%>

    <div>
   
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
         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Jlb001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="clearfilter()"
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
                                <button id="start_Jlb" onclick="Speech('GrfJlb')">
                                <img id="start_img1" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
 <!--  Анамнез жизни----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез жизни" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmLif003"  width="100%" BackColor="White" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Anm" onclick="Speech('GrfAnmLif')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>      
             <!--  Статус ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Stt001" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="SablonSts()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Статус" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="60px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('GrfStt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
             
<!--  Анамнез болезни ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Anm001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Anm002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез бол" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="80px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Anm" onclick="Speech('GrfAnm')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 


             <!--  Статус ----------------------------------------------------------------------------------------------------------  --> 
 <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->  
<%--                         <tr>                             
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Dig001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                   
                                    <asp:Button ID="Button4" runat="server"
                                                OnClientClick="OnButton001Click()"
                                                Width="100%" CommandName="" CommandArgument=""
                                                Text="МКБ" Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />

                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dig002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="25%" CommandName="" CommandArgument=""
                                    Text="Диагноз осн" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                <asp:TextBox ID="Mkb001" Width="25%" Height="20" runat="server" ReadOnly="true"  
                                    Style="font-weight: 300; font-size: small; text-align:center" />
                                <asp:TextBox ID="TextBox1" Width="25%" Height="20" runat="server" ReadOnly="true"  
                                    Style="font-weight: 300; font-size: small; text-align:center" />
                                <asp:TextBox ID="TextBox2" Width="25%" Height="20" runat="server" ReadOnly="true"  
                                    Style="font-weight: 300; font-size: small; text-align:center" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dig003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                             </td>

                             <td style="vertical-align: top; width:7%" >
                                <button id="start_Dig" onclick="Speech('GrfDig')">
                                 <img id="start_img4" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
                
 <!--  Диагноз сопутствующий ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Dsp001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />

                                 <asp:Button ID="ButDsp" runat="server"
                                                OnClientClick="OnButton002Click()"
                                                Width="100%" CommandName="" CommandArgument=""
                                                Text="МКБ" Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dsp002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз соп" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                                <asp:TextBox ID="Mkb002" Width="100%" Height="20" runat="server" ReadOnly="true" 
                                     Style="position: relative; font-weight: 700; font-size: medium; text-align:center" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dsp003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Dsp" onclick="Speech('GrfDsp')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>--%>
                
 <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->  
 <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->    
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Lch001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />


                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Оказ.помощь" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />

                                    <asp:Button ID="LekNam" runat="server"
                                                OnClientClick="LekRusLat()"
                                                Width="100%" CommandName="" CommandArgument=""
                                                Text="Рус->Lat" Height="25px" Style="position: relative; top: 0px; left: 0px" />

                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="120px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Lch" onclick="Speech('GrfLch')">
                                <img id="start_img6" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 
        </table>
  
        <hr>      
<!-- Результат----------------------------------------------------------------------------------------------------------  -->    
               <table border="0" cellspacing="0" width="100%" cellpadding="0">
                 <tr>
                     <td width="100%" style="vertical-align: top; height: 25px;">
                
                                 <asp:Label ID="Label19" runat="server" align="center" Style="font-weight: bold;" Text="Исход обращения:"></asp:Label>
                        <obout:ComboBox runat="server" ID="BoxRes" Width="30%" Height="100"
                             DataSourceID="SdsIsx" DataTextField="SmpIsxNam" DataValueField="SmpIsxKod"
                            FolderStyle="/Styles/Combobox/Plain">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <asp:Label ID="Label25" runat="server" align="center" Style="font-weight: bold;" Text="AD"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtResAdd" Width="10%" BackColor="White" Height="30px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label20" runat="server" align="center" Style="font-weight: bold;" Text="ЧСС"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtResChs" Width="10%" BackColor="White" Height="30px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label26" runat="server" align="center" Style="font-weight: bold;" Text="Пульс"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtResPls" Width="10%" BackColor="White" Height="30px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label27" runat="server" align="center" Style="font-weight: bold;" Text="ГДД"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtResGdd" Width="10%" BackColor="White" Height="30px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                </tr>
       </table>
  <!-- Результат ---------------------------------------------------------------------------------------------------------- 
     
       -->
               
 
        </div>
    <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="MkbWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="300" Top="0" Height="500" Width="900" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Тарификатор">
           
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="10%" class="PO_RowCap" align="center">МКБ:</td>
                            <td width="30%">
                                <asp:TextBox ID="FndKod" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                    Style="font-weight: 700; font-size: large;" />
                            </td>

                            <td width="10%" class="PO_RowCap" align="center">Текст:</td>
                            <td width="30%">
                                <asp:TextBox ID="FndTxt" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                                    Style="font-weight: 700; font-size: large;" />
                            </td>
                            
                            <td width="10%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="top: 0px; left: 0px" />
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
                      <obout:Column ID="Column21" DataField="MKBKOD" HeaderText="Код" ReadOnly="false" Width="7%"  Align="left"/>
                      <obout:Column ID="Column22" DataField="MKBNAM" HeaderText="Наименование" ReadOnly="true" Width="93%" Align="left" />
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

  <asp:SqlDataSource runat="server" ID="sdsIsx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



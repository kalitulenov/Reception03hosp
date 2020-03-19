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
                 case 'Zab003':
                     GrfDocRek = 'DOCSTSGNR'
                     break;
                 case 'Stt003':
                     GrfDocRek = 'DOCLOC';
                     break;
                 case 'Dig003':
                     GrfDocRek = 'DOCDIG';
                     break;
                 case 'Prk003':
                     GrfDocRek = 'DOCSTSDIX';
                     break;
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 case 'Xry003':
                     GrfDocRek = 'DOCSTSSRD';
                     break;
                 case 'Alr003':
                     GrfDocRek = 'KLTALR';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }


         //    ------------------------------------------------------------------------------------------------------------------------


 /*        
         function OnClientDateChanged(sender, selectedDate) {

             var GrfDocRek='DOCRESCPODAT';
             var GrfDocVal = txtDateCpo.value();
             var GrfDocTyp = 'Dat';
             alert("You've selected " + txtDateCpo.value());
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
 //            alert("SqlStr=" + SqlStr);

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
                 alert("SqlStr=" + SqlStr);

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
             window.open("SpeechAmb.aspx?ParTxt=" + event, "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
 //            alert("OnButtonTitClick=" + event);
             //                 SpeechWindow.setTitle("Голосовой блокнот");
             //                 SpeechWindow.setUrl("Speech_03.aspx?ParTxt=GrfJlb");
             //                 SpeechWindow.Open();

             return false;
         }

         function HandlePopupResult(result) {
 //                    alert("result of popup is: " + result);
             var MasPar = result.split('@');

             if (MasPar[0] == 'GrfJlb') document.getElementById('Jlb003').value = MasPar[1];
             if (MasPar[0] == 'GrfAnm') document.getElementById('Anm003').value = MasPar[1];
             if (MasPar[0] == 'DocStsGnr') document.getElementById('Zab003').value = MasPar[1];
             if (MasPar[0] == 'GrfStt') document.getElementById('Stt003').value = MasPar[1];
             if (MasPar[0] == 'GrfDig') document.getElementById('Dig003').value = MasPar[1];
             if (MasPar[0] == 'GrfDsp') document.getElementById('Dsp003').value = MasPar[1];
             if (MasPar[0] == 'GrfLch') document.getElementById('Lch003').value = MasPar[1];
             if (MasPar[0] == 'DocStsDix') document.getElementById('Prk003').value = MasPar[1];
             if (MasPar[0] == 'DocStsSrd') document.getElementById('Wry003').value = MasPar[1];
             //         document.getElementById('ctl00$MainContent$HidTextBoxFio').value = result;
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
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
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
 //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //=====================================================================================
            sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNoz.SelectCommand = "SELECT NozKod,NozNam FROM SprNoz ORDER BY NozNam";
            sdsMkb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMkb.SelectCommand = "SELECT TOP 100 * FROM MKB10 ORDER BY MkbNam";
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
                Zab003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSGNR"]);
                Stt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCLOC"]);
                Dig003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
                Alr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTALR"]);
                Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
                Prk003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSDIX"]);
                Xry003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTSSRD"]);
         //       Mkb003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCMKB003"]);
                       //     obout:ComboBox ------------------------------------------------------------------------------------ 
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCOBRPVD"].ToString())) BoxDocPvd.SelectedIndex = 0;
              else BoxDocPvd.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCOBRPVD"]);

                //     obout:ComboBox ------------------------------------------------------------------------------------ 

            }

  //          string name = value ?? string.Empty;
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
                       <tr> 
                            <td width="3%" style="vertical-align: top;"> </td>
                            <td width="7%" style="vertical-align: top;"> 
                                <asp:Button ID="Button1" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Повод обращения:" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="90%" style="vertical-align: top;" >
                                 <obout:ComboBox runat="server" ID="BoxDocPvd"  Width="22%" Height="200" 
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
                            <td style="vertical-align: top; width:7%" > </td>
                        </tr>
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
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Jlb" onclick="Speech('GrfJlb')">
                                <img id="start_img1" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>
 <!--  Анамнез жизни (Перенесенные заболевания) ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Zab001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Zab002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Перенес. заболевания" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Zab003"  width="100%" BackColor="White" Height="35px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Anm" onclick="Speech('DocStsGnr')">
                                 <img id="start_img2" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr>   
              
 <!--  Аллергический анамнез ----------------------------------------------------------------------------------------------------------  -->
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Alr001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Alr002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Аллерг.анамнез" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Alr003"  width="100%" BackColor="White" Height="35px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Dsp" onclick="Speech('KltAlr')">
                                 <img id="start_img5" src="/Icon/Microphone.png" alt="Start"></button>
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
                                    Text="Разв. заболевания" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Anm003"  width="100%" BackColor="White" Height="35px"
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
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Stt001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Объект.исследования" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="50px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('GrfStt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
  <!--  Прикус ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Prk001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Prk002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Прикус" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Prk003"  width="100%" BackColor="White" Height="35px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('DocStsDix')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
 <!--  Рентген исследования ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Xry001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Xry002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Рентген исследования" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Xry003"  width="100%" BackColor="White" Height="35px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('DocStsSrd')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
                                                
 <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                             
                            <td width="3%" style="vertical-align: top;">
                                <asp:Button ID="Dig001" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="<<<" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />

                            </td>
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dig002" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Диагноз" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dig003"  width="100%" BackColor="White" Height="35px"
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
                
 <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->  
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
                                    Text="Лечение" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lch003"  width="100%" BackColor="White" Height="50px"
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
  
  <!-- Результат ---------------------------------------------------------------------------------------------------------- 
     
       -->
               
 
        </div>
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


 
</body>
</html>



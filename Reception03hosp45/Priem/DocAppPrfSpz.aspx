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
    //         alert("onChangeJlb=" + sender.ID);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID || sender) {
                 case 'Oft003':
                     GrfDocRek = 'PRFOFT';
                     break;
                 case 'Lor003':
                     GrfDocRek = 'PRFLOR'
                     break;
                 case 'Nev003':
                     GrfDocRek = 'PRFNEV'
                     break;
                 case 'Xir003':
                     GrfDocRek = 'PRFXIR';
                     break;
                 case 'Der003':
                     GrfDocRek = 'PRFDER';
                     break;
                 case 'Gin003':
                     GrfDocRek = 'PRFGIN';
                     break;
                 case 'Psx003':
                     GrfDocRek = 'PRFPSX';
                     break;
                 case 'Dnt003':
                     GrfDocRek = 'PRFDNT';
                     break;
                 case 'Url003':
                     GrfDocRek = 'PRFURL';
                     break;
                 case 'Krd003':
                     GrfDocRek = 'PRFKRD';
                     break;
                 case 'Mam003':
                     GrfDocRek = 'PRFMAM';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function OnSelectedIndexChanged(sender, selectedIndex) {
             //               alert('Selected item: ' + BoxTrp.options[BoxTrp.selectedIndex()].text);
             //               alert('Selected value): ' + BoxTrp.options[BoxTrp.selectedIndex()].value);
             //              alert('SelectedIndexChanged: ' + selectedIndex);
             //                alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal;
             var GrfDocTyp = 'Int';

             switch (sender.ID) {
                 case 'BoxOft':
                     GrfDocRek = 'PRFOFTDOC';
                     GrfDocVal = BoxOft.options[BoxOft.selectedIndex()].value;
                     break;
                 case 'BoxLor':
                     GrfDocRek = 'PRFLORDOC';
                     GrfDocVal = BoxLor.options[BoxLor.selectedIndex()].value;
                     break;
                 case 'BoxNev':
                     GrfDocRek = 'PRFNEVDOC';
                     GrfDocVal = BoxNev.options[BoxNev.selectedIndex()].value;
                     break;
                 case 'BoxXir':
                     GrfDocRek = 'PRFXIRDOC';
                     GrfDocVal = BoxXir.options[BoxXir.selectedIndex()].value;
                     break;
                 case 'BoxDer':
                     GrfDocRek = 'PRFDERDOC';
                     GrfDocVal = BoxDer.options[BoxDer.selectedIndex()].value;
                     break;
                 case 'BoxGin':
                     GrfDocRek = 'PRFGINDOC';
                     GrfDocVal = BoxGin.options[BoxGin.selectedIndex()].value;
                     break;
                 case 'BoxPsx':
                     GrfDocRek = 'PRFPSXDOC';
                     GrfDocVal = BoxPsx.options[BoxPsx.selectedIndex()].value;
                     break;
                 case 'BoxDnt':
                     GrfDocRek = 'PRFDNTDOC';
                     GrfDocVal = BoxDnt.options[BoxDnt.selectedIndex()].value;
                     break;
                 case 'BoxUrl':
                     GrfDocRek = 'PRFURLDOC';
                     GrfDocVal = BoxUrl.options[BoxUrl.selectedIndex()].value;
                     break;
                 case 'BoxKrd':
                     GrfDocRek = 'PRFKRDDOC';
                     GrfDocVal = BoxKrd.options[BoxKrd.selectedIndex()].value;
                     break;
                 case 'BoxMam':
                     GrfDocRek = 'PRFMAMDOC';
                     GrfDocVal = BoxMam.options[BoxMam.selectedIndex()].value;
                     break;
                 default:
                     break;
             }

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBPRF';
             var DatDocKey = 'PRFAMB';
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

  //           alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
  //           alert("SqlStr=" + SqlStr);

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

         // ==================================== при выборе клиента показывает его программу  ============================================

      //    ------------------------------------------------------------------------------------------------------------------------
         function Speech(event) {
  //           var ParTxt = "Жалобы";
  //           window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

// --------------------- клише на анамнез жизни 
         function SablonOft()
         {
             document.getElementById('Oft003').value = document.getElementById('Oft003').value + 'Здоров.';
             onChange('Oft003', document.getElementById('Oft003').value);
         }
         function SablonLor() {
             document.getElementById('Lor003').value = document.getElementById('Lor003').value + 'Здоров.';
             onChange('Lor003', document.getElementById('Lor003').value);
         }
         function SablonNev() {
             document.getElementById('Nev003').value = document.getElementById('Nev003').value + 'Здоров.';
             onChange('Nev003', document.getElementById('Nev003').value);
         }
         function SablonXir() {
             document.getElementById('Xir003').value = document.getElementById('Xir003').value + 'Здоров.';
             onChange('Xir003', document.getElementById('Xir003').value);
         }
         function SablonDer() {
             document.getElementById('Der003').value = document.getElementById('Der003').value + 'Здоров.';
             onChange('Der003', document.getElementById('Der003').value);
         }
         function SablonGin() {
             document.getElementById('Gin003').value = document.getElementById('Gin003').value + 'Здоров.';
             onChange('Gin003', document.getElementById('Gin003').value);
         }
         function SablonPsx() {
             document.getElementById('Psx003').value = document.getElementById('Psx003').value + 'Здоров.';
             onChange('Psx003', document.getElementById('Psx003').value);
         }
         function SablonDnt() {
             document.getElementById('Dnt003').value = document.getElementById('Dnt003').value + 'Здоров.';
             onChange('Dnt003', document.getElementById('Dnt003').value);
         }
         function SablonUrl() {
             document.getElementById('Url003').value = document.getElementById('Url003').value + 'Здоров.';
             onChange('Url003', document.getElementById('Url003').value);
         }
         function SablonKrd() {
             document.getElementById('Krd003').value = document.getElementById('Krd003').value + 'Здоров.';
             onChange('Krd003', document.getElementById('Krd003').value);
         }
         function SablonMam() {
             document.getElementById('Mam003').value = document.getElementById('Mam003').value + 'Здоров.';
             onChange('Mam003', document.getElementById('Mam003').value);
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
           
                
            if (!Page.IsPostBack)
            {

                //=====================================================================================
                sdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
                sdsDoc.SelectCommand = "SELECT BuxKod AS DOCKOD,FI AS DOCNAM FROM SprBuxKdr WHERE (DlgZan=3 OR DlgZan=11) AND BuxFrm=" + BuxFrm + " AND ISNULL(BUXUBL,0)=0 ORDER BY FI";

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
            SqlCommand cmd = new SqlCommand("HspAmbPrfIdn", con);
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
                Oft003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFOFT"]);
                Lor003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFLOR"]);
                Nev003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFNEV"]);
                Xir003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFXIR"]);
                Der003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFDER"]);
                Gin003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFGIN"]);
                Psx003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFPSX"]);
                Dnt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFDNT"]);
                Krd003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFKRD"]);
                Url003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFURL"]);
                Mam003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFMAM"]);
                
                //     obout:ComboBox ------------------------------------------------------------------------------------ 
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFOFTDOC"].ToString())) BoxOft.SelectedValue = "0";
                else BoxOft.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFOFTDOC"]);
                
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFLORDOC"].ToString())) BoxLor.SelectedValue = "0";
                else BoxLor.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFLORDOC"]);
                
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFNEVDOC"].ToString())) BoxNev.SelectedValue = "0";
                else BoxNev.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFNEVDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFXIRDOC"].ToString())) BoxXir.SelectedValue = "0";
                else BoxXir.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFXIRDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFDERDOC"].ToString())) BoxDer.SelectedValue = "0";
                else BoxDer.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFDERDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFGINDOC"].ToString())) BoxGin.SelectedValue = "0";
                else BoxGin.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFGINDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFPSXDOC"].ToString())) BoxPsx.SelectedValue = "0";
                else BoxPsx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFPSXDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFDNTDOC"].ToString())) BoxDnt.SelectedValue = "0";
                else BoxDnt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFDNTDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFKRDDOC"].ToString())) BoxKrd.SelectedValue = "0";
                else BoxKrd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFKRDDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFURLDOC"].ToString())) BoxUrl.SelectedValue = "0";
                else BoxUrl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFURLDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFMAMDOC"].ToString())) BoxMam.SelectedValue = "0";
                else BoxMam.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFMAMDOC"]);
                

             //   TekDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFCTRDAT"]);
               
            }

  //          string name = value ?? string.Empty;
        }
        // ============================ чтение заголовка таблицы а оп ==============================================
        //------------------------------------------------------------------------
        // ==================================== поиск клиента по фильтрам  ============================================
        // ==================================== ШАБЛОНЫ  ============================================
        //------------------------------------------------------------------------
        
  </script>   
    
    
<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
            <asp:HiddenField ID="parMkbNum" runat="server" />
            <asp:HiddenField ID="parSblNum" runat="server" />
            <asp:HiddenField ID="parBuxKod" runat="server" />
            <span id="WindowPositionHelper"></span>
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
 <!--  Окулист ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Oft002" runat="server"
                                    OnClientClick="SablonOft()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Окулист" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Oft003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxOft" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   
                            </td>
                        </tr>
<!--  ЛОР ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lor002" runat="server"
                                    OnClientClick="SablonLor()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="ЛОР" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Lor003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxLor" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   
                            </td>
                        </tr> 

 <!--  Невропатолог----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Nev002" runat="server"
                                    OnClientClick="SablonNev()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Невропатолог" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Nev003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxNev" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   
                            </td>
                        </tr>               

 <!--  Хирург ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Xir002" runat="server"
                                    OnClientClick="SablonXir()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Хирург" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Xir003"  width="100%" BackColor="White" Height="42px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:20%" >
                                  <obout:ComboBox runat="server" ID="BoxXir" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                              </td>
                          </tr> 

  <!--  Дераматолог ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Der002" runat="server"
                                    OnClientClick="SablonDer()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Дераматолог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Der003"  width="100%" BackColor="White" Height="42px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxDer" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                              </td>
                          </tr>                                                 
 <!--  Гиниколог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Gin002" runat="server"
                                    OnClientClick="SablonGin()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Гинеколог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Gin003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                  <obout:ComboBox runat="server" ID="BoxGin" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Психолог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Psx002" runat="server"
                                    OnClientClick="SablonPsx()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Психолог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Psx003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxPsx" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 

 <!--  Стоматолог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Dnt002" runat="server"
                                    OnClientClick="SablonDnt()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Стоматолог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Dnt003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxDnt" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Уролог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Url002" runat="server"
                                    OnClientClick="SablonUrl()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Уролог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Url003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                  <obout:ComboBox runat="server" ID="BoxUrl" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Кардиолог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Krd002" runat="server"
                                    OnClientClick="SablonKrd()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Кардиолог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Krd003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxKrd" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Мамолог ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Mam002" runat="server"
                                    OnClientClick="SablonMam()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Мамолог" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Mam003"  width="100%" BackColor="White" Height="42px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                 <obout:ComboBox runat="server" ID="BoxMam" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
        </table>
  
<!-- Результат----------------------------------------------------------------------------------------------------------  -->    
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

  <asp:SqlDataSource runat="server" ID="sdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



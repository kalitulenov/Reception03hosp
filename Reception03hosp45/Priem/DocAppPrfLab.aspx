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
                 case 'LabMkr003':
                     GrfDocRek = 'PRFLABMKR';
                     break;
                 case 'LabOak003':
                     GrfDocRek = 'PRFLABOAK'
                     break;
                 case 'LabOam003':
                     GrfDocRek = 'PRFLABOAM'
                     break;
                 case 'LabSvr003':
                     GrfDocRek = 'PRFLABSVR';
                     break;
                 case 'Ekg003':
                     GrfDocRek = 'PRFEKG';
                     break;
                 case 'Xry003':
                     GrfDocRek = 'PRFXRY';
                     break;
                 case 'Aud003':
                     GrfDocRek = 'PRFAUD';
                     break;
                 case 'Spr003':
                     GrfDocRek = 'PRFSPR';
                     break;
                 case 'Bst003':
                     GrfDocRek = 'PRFBST';
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
                 case 'BoxLab':
                     GrfDocRek = 'PRFLABDOC';
                     GrfDocVal = BoxLab.options[BoxLab.selectedIndex()].value;
                     break;
                 case 'BoxEkg':
                     GrfDocRek = 'PRFEKGDOC';
                     GrfDocVal = BoxEkg.options[BoxEkg.selectedIndex()].value;
                     break;
                 case 'BoxXry':
                     GrfDocRek = 'PRFXRYDOC';
                     GrfDocVal = BoxXry.options[BoxXry.selectedIndex()].value;
                     break;
                 case 'BoxAud':
                     GrfDocRek = 'PRFAUDDOC';
                     GrfDocVal = BoxAud.options[BoxAud.selectedIndex()].value;
                     break;
                 case 'BoxSpr':
                     GrfDocRek = 'PRFSPRDOC';
                     GrfDocVal = BoxSpr.options[BoxSpr.selectedIndex()].value;
                     break;
                 case 'BoxBst':
                     GrfDocRek = 'PRFBSTDOC';
                     GrfDocVal = BoxBst.options[BoxBst.selectedIndex()].value;
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
   //          var ParTxt = "Жалобы";
   //          window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

// --------------------- клише на анамнез жизни 
         function SablonLif()
         {
             document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + 'Аллергии нет. Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
             onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
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
                sdsDoc.SelectCommand = "SELECT BuxKod AS DOCKOD,FI AS DOCNAM FROM SprBuxKdr WHERE (DlgZan=3 OR DlgZan=5) AND BuxFrm=" + BuxFrm + " AND ISNULL(BUXUBL,0)=0 ORDER BY FI";
                
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
                LabMkr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFLABMKR"]);
                LabOak003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFLABOAK"]);
                LabOam003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFLABOAM"]);
                LabSvr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFLABSVR"]);
                Ekg003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFEKG"]);
                Xry003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFXRY"]);
                Aud003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFAUD"]);
                Spr003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFSPR"]);
                Bst003.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRFBST"]);
                
                //     obout:ComboBox ------------------------------------------------------------------------------------ 
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFLABDOC"].ToString())) BoxLab.SelectedValue = "0";
                else BoxLab.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFLABDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFEKGDOC"].ToString())) BoxEkg.SelectedValue = "0";
                else BoxEkg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFEKGDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFXRYDOC"].ToString())) BoxXry.SelectedValue = "0";
                else BoxXry.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFXRYDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFAUDDOC"].ToString())) BoxAud.SelectedValue = "0";
                else BoxAud.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFAUDDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFSPRDOC"].ToString())) BoxSpr.SelectedValue = "0";
                else BoxSpr.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFSPRDOC"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["PRFBSTDOC"].ToString())) BoxBst.SelectedValue = "0";
                else BoxBst.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRFBSTDOC"]);

            }

  //          string name = value ?? string.Empty;
        }
        // ============================ чтение заголовка таблицы а оп ==============================================
        //------------------------------------------------------------------------
        // ==================================== поиск клиента по фильтрам  ============================================
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
 <!--  Лаборатория (микрореакция) ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="LabMkr002" runat="server"
                                    OnClientClick="SablonLabMkr()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лаборатория (микрореакция)" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="LabMkr003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxLab" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   
                            </td>
                        </tr>
<!--   Лаборатория (ОАК) ----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="LabOak002" runat="server"
                                    OnClientClick="SablonLabOak()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лаборатория (ОАК)" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="LabOak003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:20%" >
                             </td>
                        </tr> 

 <!--   Лаборатория (ОАМ)----------------------------------------------------------------------------------------------------------  -->    
                         <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="LabOam002" runat="server"
                                    OnClientClick="SablonLabOam()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лаборатория (ОАМ)" Height="20px" 
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="LabOam003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td style="vertical-align: top; width:20%" >
                             </td>
                        </tr>               

 <!--  Лаборатория (свертывакмость крови)- ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="7%" style="vertical-align: top; align-content:flex-start">
                                <asp:Button ID="LabSvr002" runat="server"
                                    OnClientClick="SablonLabSvr()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Лаборатория (свертываемость крови)" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="LabSvr003"  width="100%" BackColor="White" Height="50px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:20%" >
                             </td>
                          </tr> 

  <!--  ЭКГ ----------------------------------------------------------------------------------------------------------  --> 
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Ekg002" runat="server"
                                    OnClientClick="SablonEkg()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="ЭКГ " Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Ekg003"  width="100%" BackColor="White" Height="50px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxEkg" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                              </td>
                          </tr>                                                 
 <!--  Флюрография ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Xry002" runat="server"
                                    OnClientClick="SablonXry()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Флюрография" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Xry003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxXry" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Аудиометрия ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Aud002" runat="server"
                                    OnClientClick="SablonAud()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Аудиометрия" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Aud003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxAud" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 

 <!--  Спирография ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Spr002" runat="server"
                                    OnClientClick="SablonSpr()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Спирография" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Spr003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxSpr" Width="100%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsDoc" DataTextField="DocNam" DataValueField="DocKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   

                            </td>
                        </tr> 
 <!--  Вестибулярный аппарат ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Bst002" runat="server"
                                    OnClientClick="SablonBst()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Вестибулярный аппарат" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Bst003"  width="100%" BackColor="White" Height="50px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:20%" >
                                <obout:ComboBox runat="server" ID="BoxBst" Width="100%" Height="200"
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
 
</body>
</html>



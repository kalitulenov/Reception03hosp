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

             switch (sender.ID || sender) {
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
                 case 'Lch003':
                     GrfDocRek = 'DOCPLNLCH';
                     break;
                 case 'Grp003':
                     GrfDocRek = 'DOCDIG';
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
                 case 'BoxTrp':
               //      GrfDocRek = 'GRFKOD';
                     GrfDocVal = BoxTrp.options[BoxTrp.selectedIndex()].value;
           //                     alert('GrfDocVal: ' + GrfDocVal);
                     break;
                 default:
                     break;
             }
      //       onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

             var DatDocMdb = 'HOSPBASE';
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

             DatDocTyp = 'Sql';
             SqlStr = "UPDATE AMBCRD SET GRFKOD=" + GrfDocVal + " WHERE GRFIDN=" + DatDocIdn;
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


      //    ------------------------------------------------------------------------------------------------------------------------
         function Speech(event) {
   //          var ParTxt = "Жалобы";
  //           window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

// --------------------- клише на анамнез жизни 
         function SablonJlb() {
             document.getElementById('Jlb003').value = document.getElementById('Jlb003').value + 'Жалоб нет.';
             onChange('Jlb003', document.getElementById('Jlb003').value);
         }

         function SablonLif() {
             document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value +
                     'Родиласась(ся) а развивалась(ся) нормально. Наследственность не отягощена. Перенесенные общие заболевания: ___.' +
                     'Перенесенные инфекции в детстве:_____, Гепатиты ___, Туберкулез _____, Венерические заболевания _________, ' +
                     'Хронические заболевания _____, Диспансерный учет _____, Госпитализация _____, Гемотрансфузия _______, Аллергоанамнез _________';
             onChange('AnmLif003', document.getElementById('AnmLif003').value);
         }

         function SablonSts() {
             document.getElementById('Stt003').value = document.getElementById('Stt003').value +
                 'Рост: ___. Вес: ___. Температура: ___, Пульс ___, АД __/__ , Общее состояние: Удовлетворительное.' +
                 'Общее состояние ___, Особенности телосложение нормостеник,гипостеник,гиперстеник,Кожные покровы _____,' +
                 'Состояние полости рта _______, Лимфотические узлы _____,Состояние органов дыхание _____ ' +
                 'Сердечн-сосуд. срстема ______, Живот ___, Печень не увеличен, Симптом покалачивания ____, Мочеиспускания ___, Стул ___';
             onChange('Stt003', document.getElementById('Stt003').value);
         }

         function SablonLch() {
             document.getElementById('Lch003').value = document.getElementById('Lch003').value + 'Здоров.';
             onChange('Lch003', document.getElementById('Lch003').value);
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
              sdsTrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
              sdsTrp.SelectCommand = "SELECT BuxKod AS TRPKOD,FI AS TRPNAM FROM SprBuxKdr WHERE BuxFrm=" + BuxFrm + " AND ISNULL(BUXUBL,0)=0 ORDER BY FI";
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
          //      Anm003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANM"]);
                AnmLif003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCANMLIF"]);
                Stt003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCLOC"]);
                Lch003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCPLNLCH"]);
                Grp003.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCDIG"]);
                
                //     obout:ComboBox ------------------------------------------------------------------------------------ 
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFKOD"].ToString())) BoxTrp.SelectedValue = "0";
                else BoxTrp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["GRFKOD"]);

                TekDat = Convert.ToString(ds.Tables[0].Rows[0]["GRFCTRDAT"]);
               
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
 <!--  Жалобы ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Jlb002" runat="server"
                                    OnClientClick="SablonJlb()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Жалобы" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="Jlb003"  width="100%" BackColor="White" Height="80px"
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
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="AnmLif002" runat="server"
                                    OnClientClick="SablonLif()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Анамнез" Height="20px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AnmLif003"  width="100%" BackColor="White" Height="80px"
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
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Stt002" runat="server"
                                    OnClientClick="SablonSts()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Оъективные данные" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Stt003"  width="100%" BackColor="White" Height="80px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                     
                              <td style="vertical-align: top; width:7%" >
                                <button id="start_Stt" onclick="Speech('GrfStt')">
                                 <img id="start_img3" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                          </tr> 
 <!--  Лечение ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Lch002" runat="server"
                                    OnClientClick="SablonLch()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Заключение" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;">
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
 <!--  Группа здоровья ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Grp002" runat="server"
                                    OnClientClick="SablonGrp()"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Группа здоровья" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="Grp003"  width="100%" BackColor="White" Height="80px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
  
                            </td>
                            <td style="vertical-align: top; width:7%" >
                                <button id="start_Lch" onclick="Speech('GrfGrp')">
                                 <img id="start_img6" src="/Icon/Microphone.png" alt="Start"></button>
                             </td>
                        </tr> 
 <!--  Терапевт ----------------------------------------------------------------------------------------------------------  -->  
                         <tr>                            
                            <td width="7%" style="vertical-align: top;">
                                <asp:Button ID="Trp002" runat="server"
                                    Width="100%" CommandName="" CommandArgument=""
                                    Text="Врач" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px; text-align:left" />
                            </td>
                             <td width="93%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxTrp" Width="18%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsTrp" DataTextField="TrpNam" DataValueField="TrpKod" >
                                       <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>   
                            </td>
                            <td style="vertical-align: top; width:7%" > </td>
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

  <asp:SqlDataSource runat="server" ID="sdsTrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsMkb"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



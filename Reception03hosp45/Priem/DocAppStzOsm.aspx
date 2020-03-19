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
                 case 'TxtOtd':
                     GrfDocRek = 'STZOTD';
                     break;
                 case 'TxtPal':
                     GrfDocRek = 'STZPAL'
                     break;
                 case 'TxtOtd002':
                     GrfDocRek = 'STZOTD002'
                     break;
                 case 'TxtDni':
                     GrfDocRek = 'STZKOIDNI';
                     break;
                 case 'TxtSpd':
                     GrfDocRek = 'STZSPD';
                     break;
                 case 'TxtKrv':
                     GrfDocRek = 'STZGRPKRV';
                     break;
                 case 'TxtRes':
                     GrfDocRek = 'STZRESFKT';
                     break;
                 case 'TxtAlg':
                     GrfDocRek = 'STZALG';
                     break;
                 case 'TxtNap':
                     GrfDocRek = 'STZKEMNAP';
                     break;
                 case 'TxtTim':
                     GrfDocRek = 'STZLPUTIM';
                     break;
                 case 'TxtGsp':
                     GrfDocRek = 'STZLPUNNN';
                     break;
                 case 'TxtDigNap':
                     GrfDocRek = 'STZDIGNAP';
                     break;
                 case 'TxtDigInp':
                     GrfDocRek = 'STZDIGINP';
                     break;
                 case 'TxtDigKln':
                     GrfDocRek = 'STZDIGKLN';
                     break;
                 case 'TxtDigZak':
                     GrfDocRek = 'STZDIGZAKOSN';
                     break;
                 case 'TxtDigSop':
                     GrfDocRek = 'STZDIGZAKSOP';
                     break;
                 case 'TxtDigNap':
                     GrfDocRek = 'STZDIGNAP';
                     break;
                 case 'TxtDigInp':
                     GrfDocRek = 'STZDIGINP';
                     break;
                 case 'TxtDigKln':
                     GrfDocRek = 'STZDIGKLN';
                     break;
                 case 'TxtDigZak':
                     GrfDocRek = 'STZDIGZAKOSN';
                     break;
                 case 'TxtDigSop':
                     GrfDocRek = 'STZDIGZAKSOP';
                     break;
                 case 'TxtOprNam001':
                     GrfDocRek = 'STZOPRNAM001';
                     break;
                 case 'TxtOprDat001':
                     GrfDocRek = 'STZOPRDAT001';
                     break;
                 case 'TxtOprObz001':
                     GrfDocRek = 'STZOPROBZ001';
                     break;
                 case 'TxtOprOsl001':
                     GrfDocRek = 'STZOPROSL001';
                     break;
                 case 'TxtOprNam002':
                     GrfDocRek = 'STZOPRNAM002';
                     break;
                 case 'TxtOprDat002':
                     GrfDocRek = 'STZOPRDAT002';
                     break;
                 case 'TxtOprObz002':
                     GrfDocRek = 'STZOPROBZ002';
                     break;
                 case 'TxtOprOsl002':
                     GrfDocRek = 'STZOPROSL002';
                     break;
                 case 'TxtOprObz002':
                     GrfDocRek = 'STZOPROBZ002';
                     break;
                 case 'TxtOprOsl002':
                     GrfDocRek = 'STZOPROSL002';
                     break;
                 case 'TxtOthLch':
                     GrfDocRek = 'STZOTHLCH';
                     break;
                 case 'TxtOnkLch':
                     GrfDocRek = 'STZONKLCH';
                     break;
                 case 'TxtIsxExp':
                     GrfDocRek = 'STZISXEXP';
                     break;
                 case 'TxtIsxMem':
                     GrfDocRek = 'STZISXMEM';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------
         //--  1 ----------------------------------------------------------------------------------------------------------  -->    
         //    ------------------------------------------------------------------------------------------------------------------------
         function OnSelectedIndexChanged(sender, selectedIndex) {
 //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
 //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
 //            alert('SelectedIndexChanged: ' + selectedIndex);
  //           alert('sender: ' + sender.ID);

             var GrfDocRek;
             var GrfDocVal;
             var GrfDocTyp = 'Int';

             switch (sender.ID) {
                 case 'BoxTrn':
                     GrfDocRek = 'STZVIDTRN';
                     GrfDocVal = BoxTrn.options[BoxTrn.selectedIndex()].value;
          //           alert('GrfDocVal: ' + GrfDocVal);
                     break;
                 case 'BoxDst':
                     GrfDocRek = 'STZLPUINP'
                     GrfDocVal = BoxDst.options[BoxDst.selectedIndex()].value;
                     break;
                 case 'BoxDocOpr':
                     GrfDocRek = 'STZOPRDOC';
                     GrfDocVal = BoxDocOpr.options[BoxDocOpr.selectedIndex()].value;
                     break;
                 case 'BoxIsxLch':
                     GrfDocRek = 'STZISXLCH';
                     GrfDocVal = BoxIsxLch.options[BoxIsxLch.selectedIndex()].value;
                     break;
                 case 'BoxDocLch':
                     GrfDocRek = 'STZISXDOCLCH';
                     GrfDocVal = BoxDocLch.options[BoxDocLch.selectedIndex()].value;
                     break;
                 case 'BoxDocOtd':
                     GrfDocRek = 'STZISXDOCOTD';
                     GrfDocVal = BoxDocOtd.options[BoxDocOtd.selectedIndex()].value;
                     break;
                 case 'BoxIsxTrd':
                     GrfDocRek = 'STZISXTRD';
                     GrfDocVal = BoxIsxTrd.options[BoxIsxTrd.selectedIndex()].value;
                     break;
                 case 'BoxDocResObr':
                     GrfDocRek = 'DOCRESOBR';
                     GrfDocVal = BoxDocResObr.options[BoxDocResObr.selectedIndex()].value;
                     break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onDateChangeBeg(sender, selectedDate) {
             onDateChangeUpd("TxtBeg", selectedDate)
         }

         function onDateChangeEnd(sender, selectedDate) {
             onDateChangeUpd("TxtEnd", selectedDate)
         } 
         
         function onDateChangeDigDat(sender, selectedDate) {
             onDateChangeUpd("TxtDigKlnDat", selectedDate)
         }

         function onDateChangeUpd(sender, selectedDate) {
   //          alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             //             var GrfDocRek='GRFCTRDAT';
           //             alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var QueryString = getQueryString();
             var DatDocIdn = QueryString[1];
         //              alert("DatDocIdn " + DatDocIdn);

             switch (sender) {
                 case 'TxtBeg':
                     DatDocRek = 'STZDATBEG';
                     break;
                 case 'TxtEnd':
                     DatDocRek = 'STZDATEND'
                     break;
                 case 'TxtDigKlnDat':
                     DatDocRek = 'STZDIGKLNDAT';
                     break;
                 default:
                     break;

             }
             SqlStr = "UPDATE AMBSTZ SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE STZAMB=" + DatDocIdn;
    //         alert("SqlStr=" + SqlStr);

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
             var DatDocTab = 'AMBSTZ';
             var DatDocKey = 'STZAMB';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

   //          alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
             var ParTxt = "Жалобы";
             window.open("SpeechAmb.aspx?ParTxt=" + event + "&Browser=Desktop", "ModalPopUp", "toolbar=no,width=600,height=450,left=400,top=150,location=no,modal=yes,status=no,scrollbars=no,resize=no");
             return false;
         }

// --------------------- клише на анамнез жизни 
         function SablonLif()
         {
             document.getElementById('AnmLif003').value = document.getElementById('AnmLif003').value + 'Аллергии нет. Наследственность не отягощена. Твс, Вен, ВГВ отрицает.';
             onChangeTxt('AnmLif003', document.getElementById('AnmLif003').value);
         }

         function BoxAccDeb_SelectedIndexChanged(sender, selectedIndex) {

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

            sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ' ORDER BY FI";
            
            //=====================================================================================
            
            if (!Page.IsPostBack)
            {
                Session.Add("KLTIDN", (string)"");
                Session.Add("WHERE", (string)"");
            
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
            SqlCommand cmd = new SqlCommand("HspAmbStzIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbStzIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {

                //--  1 ----------------------------------------------------------------------------------------------------------  -->    
                //     obout:OboutTextBox ------------------------------------------------------------------------------------      
                TxtBeg.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDATBEG"]);
                TxtOtd.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOTD"]);
                TxtPal.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZPAL"]);
                TxtOtd002.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOTD002"]);
                TxtDni.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZKOIDNI"]);

                //--  2 ----------------------------------------------------------------------------------------------------------  -->    
                TxtEnd.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDATEND"]);
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZVIDTRN"].ToString())) BoxTrn.SelectedValue = "0";
                else BoxTrn.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZVIDTRN"]);
                TxtSpd.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZSPD"]);
                TxtKrv.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZGRPKRV"]);
                TxtRes.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZRESFKT"]);

                //--  3 ----------------------------------------------------------------------------------------------------------  -->    
                TxtAlg.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZALG"]);
                TxtNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZKEMNAP"]);
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZLPUINP"].ToString())) BoxDst.SelectedValue = "0";
                else BoxDst.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZLPUINP"]);
                TxtTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZLPUTIM"]);
                TxtGsp.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZLPUNNN"]);


                //--  4 ----------------------------------------------------------------------------------------------------------  -->    
                TxtDigNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGNAP"]);
                TxtDigInp.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGINP"]);
                TxtDigKln.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGKLN"]);
                TxtDigKlnDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGKLNDAT"]);
                TxtDigZak.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGZAKOSN"]);
                TxtDigSop.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGZAKSOP"]);

                //--  5 ----------------------------------------------------------------------------------------------------------  -->    
                TxtDigNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGNAP"]);
                TxtDigInp.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGINP"]);
                TxtDigKln.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGKLN"]);
                TxtDigKlnDat.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGKLNDAT"]);
                TxtDigZak.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGZAKOSN"]);
                TxtDigSop.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZDIGZAKSOP"]);

                //--  5 ----------------------------------------------------------------------------------------------------------  -->    
                TxtOprNam001.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPRNAM001"]);
                TxtOprDat001.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPRDAT001"]);
                TxtOprObz001.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPROBZ001"]);
                TxtOprOsl001.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPROSL001"]);

                //--  6 ----------------------------------------------------------------------------------------------------------  -->    
                TxtOprNam002.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPRNAM002"]);
                TxtOprDat002.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPRDAT002"]);
                TxtOprObz002.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPROBZ002"]);
                TxtOprOsl002.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOPROSL002"]);


                //--  7 ----------------------------------------------------------------------------------------------------------  -->    
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZOPRDOC"].ToString())) BoxDocOpr.SelectedValue = "0";
                else BoxDocOpr.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZOPRDOC"]);
                TxtOthLch.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZOTHLCH"]);
                TxtOnkLch.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZONKLCH"]);
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZISXLCH"].ToString())) BoxIsxLch.SelectedValue = "0";
                else BoxIsxLch.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZISXLCH"]);

                //--  8 ----------------------------------------------------------------------------------------------------------  -->    
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZISXTRD"].ToString())) BoxIsxTrd.SelectedValue = "0";
                else BoxIsxTrd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZISXTRD"]);
                TxtIsxExp.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZISXEXP"]);
                TxtIsxMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["STZISXMEM"]);
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZISXDOCLCH"].ToString())) BoxDocLch.SelectedValue = "0";
                else BoxDocLch.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZISXDOCLCH"]);
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["STZISXDOCOTD"].ToString())) BoxDocOtd.SelectedValue = "0";
                else BoxDocOtd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["STZISXDOCOTD"]);
            }
               
        }
        // ============================ чтение заголовка таблицы а оп ==============================================
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
 <!--  1 ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="20%" style="vertical-align: top;">
                                 <asp:Label ID="Label1" runat="server" align="center" Width="40%" Style="font-weight: bold;" Text="Дата пост."></asp:Label>
                                 <asp:TextBox runat="server" id="TxtBeg" Width="50px" BackColor="#FFFFE0" />

			                     <obout:Calendar ID="Calendar1" runat="server"
			 			                   	StyleFolder="/Styles/Calendar/styles/default" 
    	            					    DatePickerMode="true"
    	            					    ShowYearSelector="true"
                						    YearSelectorType="DropDownList"
    	            					    TitleText="Выберите год: "
    	            					    CultureName = "ru-RU"
                						    TextBoxId = "TxtBeg"
                                            OnClientDateChanged="onDateChangeBeg"   
                   						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                            </td>
                            <td width="20%" style="vertical-align: top;">
                                <asp:Label ID="Label3" runat="server" align="center" Width="25%" Style="font-weight: bold;" Text="Отделен."></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtOtd"  Width="70%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                             <td width="20%" style="vertical-align: top;">
                                 <asp:Label ID="Label11" runat="server" align="center" Width="25%" Style="font-weight: bold;" Text="Палата"></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtPal"  Width="70%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>
                            <td width="20%" style="vertical-align: top;">
                                 <asp:Label ID="Label12" runat="server" align="center" Width="30%" Style="font-weight: bold;" Text="Пер.в отд."></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtOtd002"  Width="60%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                            <td width="20%" style="vertical-align: top;">
                                 <asp:Label ID="Label13" runat="server" align="center" Width="25%" Style="font-weight: bold;" Text="К-дни."></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtDni"  Width="70%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
 <!--  2 ----------------------------------------------------------------------------------------------------------  -->    

                        <tr>
                            <td width="20%" style="vertical-align: top;">
                                 <asp:Label ID="Label2" runat="server" align="center" Width="40%" Style="font-weight: bold;" Text="Дата вып."></asp:Label>
                                 <asp:TextBox runat="server" id="TxtEnd" Width="50px" BackColor="#FFFFE0" />

			                     <obout:Calendar ID="Calendar2" runat="server"
			 			                   	StyleFolder="/Styles/Calendar/styles/default" 
    	            					    DatePickerMode="true"
    	            					    ShowYearSelector="true"
                						    YearSelectorType="DropDownList"
    	            					    TitleText="Выберите год: "
    	            					    CultureName = "ru-RU"
                						    TextBoxId = "TxtEnd"
                                            OnClientDateChanged="onDateChangeEnd"   
                   						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                            </td>
                            <td width="20%" style="vertical-align: top;" >
                                 <asp:Label id="LblPvd" Text="Тран.:" runat="server"  Width="25%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxTrn"  Width="70%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="На каталке" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="На кресле" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Может идти" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Прививка" Value="4" />
                                         </Items>
                                         <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>
                            </td>

                            <td width="20%" style="vertical-align: top;" >                                 
                                 <asp:Label ID="Label14" runat="server" align="center" Width="25%" Style="font-weight: bold;" Text="ВИЧ:"></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtSpd"  Width="70%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>                                   
                            </td>
                                 
                             <td width="20%" style="vertical-align: top;" >
                                 <asp:Label ID="Label15" runat="server" align="center" Width="30%" Style="font-weight: bold;" Text="Грп.кров:"></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtKrv"  Width="60%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>                                   
                            </td>
 
                            <td width="20%" style="vertical-align: top;" >                                                                  
                                 <asp:Label ID="Label16" runat="server" align="center" Width="25%" Style="font-weight: bold;" Text="Резус:"></asp:Label>
                                 <obout:OboutTextBox runat="server" ID="TxtRes"  Width="70%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>                                   
                            </td>


                        </tr>
       </table>
        <hr>      

         <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  3 ----------------------------------------------------------------------------------------------------------  -->    
                        <tr> 
                            <td width="20%" style="vertical-align: top;" >                                 
                                 <asp:Label ID="Label9" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="Побочные дейст.:"></asp:Label>
                             </td>

                            <td width="20%" style="vertical-align: top;">
                                <asp:Label id="Label35" Text="15.Кем направлен:" runat="server"  Width="90%"  Font-Bold="true" />                             
                            </td>
                            <td width="20%" style="vertical-align: top;">
                                 <asp:Label id="Label36" Text="16.Доставлен в стационар:" runat="server"  Width="90%"  Font-Bold="true" />                             
                            </td>
                             <td width="20%" style="vertical-align: top;" >
                                 <asp:Label ID="Label37" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="Часов после травмы:"></asp:Label>
                            </td>
                            <td width="20%" style="vertical-align: top;" >
                               <asp:Label ID="Label32" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="22.Госп. в данном году:"></asp:Label>
                            </td>
                        </tr> 
 
                         <tr>                            
                            <td width="20%" style="vertical-align: top;" >                                 
                                 <obout:OboutTextBox runat="server" ID="TxtAlg"  Width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>                                   
                             </td>

                            <td width="20%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtNap"  width="90%"  BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>       
                            </td>
                            <td width="20%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxDst"  width="90%"  Height="200"
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="по экстренным показаниям" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="госпитализирован  в плановом порядке" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="самообращение" Value="3" />
                                         </Items>
                                         <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                 </obout:ComboBox>
                            </td>
                             <td width="20%" style="vertical-align: top;" >
                                 <obout:OboutTextBox runat="server" ID="TxtTim"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>                                   

                            </td>
                             <td width="20%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtGsp"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>

                            </td>  
                        </tr>
       </table>
        <hr>      
 <!--  4 ----------------------------------------------------------------------------------------------------------  -->    

         <table border="0" cellspacing="0" width="100%" cellpadding="0">

                         <tr> 
                            <td width="15%" style="vertical-align: top;">
                               <asp:Label ID="Label17" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="17.Диагноз напр.:"></asp:Label>
                            </td>

                            <td width="20%" style="vertical-align: top;">
                               <asp:Label ID="Label18" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="18.Диагноз при поступ:"></asp:Label>
                            </td>

                            <td width="20%" style="vertical-align: top;">
                               <asp:Label ID="Label19" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="19.Диагноз клинич:"></asp:Label>
                            </td>

                            <td width="10%" style="vertical-align: top;">
                                 <asp:Label ID="Label4" runat="server" align="center" Style="font-weight: bold;" Text="Дата диагн.:"></asp:Label>
                            </td>

                            <td width="20%" style="vertical-align: top;">
                                <asp:Label ID="Label20" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="21.Диагноз заключ.:"></asp:Label>
                            </td>

                            <td width="15%" style="vertical-align: top;">
                              <asp:Label ID="Label5" runat="server" align="center" Width="90%" Style="font-weight: bold;" Text="Диагноз соп:"></asp:Label>
                            </td>
                        </tr>               
             
                          <tr> 
                            <td width="15%" style="vertical-align: top;">
                               <obout:OboutTextBox runat="server" ID="TxtDigNap"  width="90%" BackColor="White" Height="100px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>

                            </td>

                            <td width="20%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtDigInp"  width="90%" BackColor="White" Height="100px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>

                            <td width="20%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtDigKln"  width="90%" BackColor="White" Height="100px" 
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>

                            <td width="10%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" id="TxtDigKlnDat" Width="50px" BackColor="#FFFFE0" />

			                     <obout:Calendar ID="Calendar3" runat="server"
			 			                   	StyleFolder="/Styles/Calendar/styles/default" 
    	            					    DatePickerMode="true"
    	            					    ShowYearSelector="true"
                						    YearSelectorType="DropDownList"
    	            					    TitleText="Выберите год: "
    	            					    CultureName = "ru-RU"
                						    TextBoxId = "TxtDigKlnDat"
                                            OnClientDateChanged="onDateChangeDigDat"   
                   						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>

                            </td>

                            <td width="20%" style="vertical-align: top;">

                                 <obout:OboutTextBox runat="server" ID="TxtDigZak"  width="90%" BackColor="White" Height="100px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                           <td width="15%" style="vertical-align: top;">

                                 <obout:OboutTextBox runat="server" ID="TxtDigSop"  width="90%" BackColor="White" Height="100px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>                  

                        </tr>               
      </table>
 <!--  5 ----------------------------------------------------------------------------------------------------------  -->    

<hr>  
         <table border="0" cellspacing="0" width="100%" cellpadding="0">                                              
                         <tr>                            
                                                                            
                             <td width="25%" style="vertical-align: top;">
                                 <asp:Label ID="Label22" runat="server" align="center" Style="font-weight: bold;" Text="Название операции"></asp:Label>
                            </td>
                                                                             
                             <td width="10%" style="vertical-align: top;">
                                  <asp:Label ID="Label23" runat="server" align="center" Style="font-weight: bold;" Text="Дата, час"></asp:Label>
                            </td>
                                                                             
                             <td width="25%" style="vertical-align: top;">
                                  <asp:Label ID="Label24" runat="server" align="center" Style="font-weight: bold;" Text="Метод обезболивания"></asp:Label>
                            </td>
                                                                             
                             <td width="40%" style="vertical-align: top;">
                                  <asp:Label ID="Label25" runat="server" align="center" Style="font-weight: bold;" Text="Осложнения"></asp:Label>
                            </td>
 
                      </tr>  
                          <tr> 
                              <td width="25%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprNam001"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>

                              </td>
                                                                             
                             <td width="10%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprDat001"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                            </td>
                                                                             
                             <td width="25%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprObz001"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                            </td>
                                                                             
                             <td width="40%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprOsl001"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox> 
                             </td>  
                                                         
                       </tr> 
 <!--  6 ----------------------------------------------------------------------------------------------------------  -->    

                       <tr> 
                            <td width="25%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprNam002"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                            </td>
                            <td width="10%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="TxtOprDat002"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                            </td>
                             <td width="25%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtOprObz002"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                            </td>
                           <td width="40%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtOprOsl002"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
 		                         </obout:OboutTextBox>
                             </td>
                        </tr> 

       </table>
 <!--  7 ----------------------------------------------------------------------------------------------------------  -->    

<hr> 
         <table border="0" cellspacing="0" width="100%" cellpadding="0">       
                     <tr>                            
                            <td width="25%" style="vertical-align: top;">
                                 <asp:Label ID="Label29" runat="server" align="center" Style="font-weight: bold;" Text="Оперировал:"></asp:Label>

                            </td>
                            <td width="25%" style="vertical-align: top;">
                                 <asp:Label ID="Label30" runat="server" align="center" Style="font-weight: bold;" Text="Другие виды лечения:"></asp:Label>
                            </td>
                             <td width="25%" style="vertical-align: top;">
                                <asp:Label ID="Label34" runat="server" align="center" Style="font-weight: bold;" Text="Для больных злок. новообраз.:"></asp:Label>
                             </td>

                            <td width="25%" style="vertical-align: central;" >
                                    <asp:Label ID="Label38" runat="server" align="center" Style="font-weight: bold;" Text="Исход заболевания:"></asp:Label>
                              </td>

                        </tr> 

                      <tr>                            
                            <td width="25%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxDocOpr" Width="90%" Height="300"
                                            FolderStyle="/Styles/Combobox/Plain"
                                            AutoPostBack="true"
                                            DataSourceID="sdsKto" DataTextField="FI" DataValueField="BUXKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                       </obout:ComboBox>

                            </td>
                            <td width="25%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtOthLch"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                            </td>
                             <td width="25%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtOnkLch"  width="90%" BackColor="White" Height="30px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
		                         </obout:OboutTextBox>
                             </td>

                            <td width="25%" style="vertical-align: central;" >
                                        <obout:ComboBox runat="server" ID="BoxIsxLch"  Width="90%" Height="250"
                                               FolderStyle="/Styles/Combobox/Plain" >
                                               <Items>
                                                   <obout:ComboBoxItem ID="ComboBoxItem37" runat="server" Text="" Value="0" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem38" runat="server" Text="выписан с выздоровлением" Value="1" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem39" runat="server" Text="выписан с улучшением" Value="2" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem40" runat="server" Text="выписан без перемен" Value="3" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem41" runat="server" Text="выписан с ухудшением" Value="4" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem42" runat="server" Text="Смерть" Value="5" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem43" runat="server" Text="переведен в другую организацию" Value="6" />
                                               </Items>
                                               <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                        </obout:ComboBox>  
                              </td>

                        </tr> 

        </table>
 <!--  8 ----------------------------------------------------------------------------------------------------------  -->    
                                         
        <hr>      
               <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr> 
 
                                 <td width="20%" style="vertical-align: central;" >    
                                    <asp:Label ID="Label21" runat="server" align="center"  Style="font-weight: bold;" Text="Трудоспособность:"></asp:Label>
                                </td>
                                     <td width="20%" style="vertical-align: central;"  >
                                        <asp:Label ID="Label26" runat="server" align="center"  Style="font-weight: bold;" Text="Экспертиза:"></asp:Label>
                              </td>
                                     <td width="20%" style="vertical-align: central;" >
                                         <asp:Label ID="Label28" runat="server" align="center" Style="font-weight: bold;" Text="Особые отметки:"></asp:Label>
                                     </td>     
                               <td width="20%" style="vertical-align: central;" >
                                   <asp:Label ID="Label39" runat="server" align="center"  Style="font-weight: bold;" Text="Леч.врач:"></asp:Label>
                              </td>
                               <td width="20%" style="vertical-align: central;  " >
                                        <asp:Label id="Label40" Text="Зав.отделением:" runat="server"  Font-Bold="true"  />                             
                               </td>
 

                            </tr>
                   
                                          <tr> 
 
                                 <td width="20%" style="vertical-align: central;" >    
                                        <obout:ComboBox runat="server" ID="BoxIsxTrd"  Width="90%" Height="250"
                                               FolderStyle="/Styles/Combobox/Plain" >
                                               <Items>
                                                   <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="" Value="0" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="восстановлена полностью" Value="1" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="снижена" Value="2" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem8" runat="server" Text="временно утрачена" Value="3" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="стойко утрачена " Value="4" />
                                                   <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="стойко утрачена с другими причинами" Value="5" />
                                               </Items>
                                               <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                        </obout:ComboBox>  
                                </td>
                                     <td width="20%" style="vertical-align: central;"  >
                                        <obout:OboutTextBox runat="server" ID="TxtIsxExp"  width="90%" BackColor="White" Height="30px"
                                                TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                                        <ClientSideEvents OnTextChanged="onChange" />
		                                 </obout:OboutTextBox>
                              </td>
                                     <td width="20%" style="vertical-align: central;" >
                                       <obout:OboutTextBox runat="server" ID="TxtIsxMem"  width="90%" BackColor="White" Height="30px"
                                                TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                                        <ClientSideEvents OnTextChanged="onChange" />
		                                 </obout:OboutTextBox>
                                     </td>     
                               <td width="20%" style="vertical-align: central;" >
                                   <obout:ComboBox runat="server" ID="BoxDocLch" Width="90%" Height="300"
                                            FolderStyle="/Styles/Combobox/Plain"
                                            AutoPostBack="true"
                                            DataSourceID="sdsKto" DataTextField="FI" DataValueField="BUXKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                       </obout:ComboBox>
                              </td>
                               <td width="20%" style="vertical-align: central;  " >
                                <obout:ComboBox runat="server" ID="BoxDocOtd" Width="90%" Height="300"
                                            FolderStyle="/Styles/Combobox/Plain"
                                            AutoPostBack="true"
                                            DataSourceID="sdsKto" DataTextField="FI" DataValueField="BUXKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                       </obout:ComboBox>
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
  <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


 
</body>
</html>



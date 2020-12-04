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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;
         //         alert("DocAppAmbPsm");
         
         window.onload = function () {
                 $.mask.definitions['H'] = '[012]';
                 $.mask.definitions['M'] = '[012345]';
                 $('#TxtBegTim').mask('H9:M9');
                 $('#TxtPrbTim').mask('H9:M9');
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
         //    alert("onChangeJlb=" + sender + " " + newText);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Txt';

             switch (sender.ID) {
                 case 'TxtTim':
                     GrfDocRek = 'GRFTIM'
                     break;
                 case 'TxtFio':
                     GrfDocRek = 'GRFPTH';
                     break;
                 case 'TxtIin':
                     GrfDocRek = 'GRFIIN';
                     break;
                 case 'TxtObl':
                     GrfDocRek = 'SMPADROBL';
                     break;
                 case 'TxtCty':
                     GrfDocRek = 'SMPADRCTY';
                     break;
                 case 'TxtStr':
                     GrfDocRek = 'SMPADRSTR';
                     break;
                 case 'TxtDom':
                     GrfDocRek = 'SMPADRDOM';
                     break;
                 case 'TxtApr':
                     GrfDocRek = 'SMPADRAPR';
                     break;
                 case 'TxtUgl':
                     GrfDocRek = 'SMPADRUGL';
                     break;
                 case 'TxtZsd':
                     GrfDocRek = 'SMPADRZSD';
                     break;
                 case 'TxtPod':
                     GrfDocRek = 'SMPADRPOD';
                     break;
                 case 'TxtEtg':
                     GrfDocRek = 'SMPADRETG';
                     break;
                 case 'TxtDmf':
                     GrfDocRek = 'SMPADRDMF';
                     break;
                 case 'TxtTel':
                     GrfDocRek = 'GRFTEL';
                     break;
                 case 'TxtJlb':
                     GrfDocRek = 'GRFMEM';
                     break;
                 case 'TxtLpuNam':
                     GrfDocRek = 'SMPLPUNAM';
                     break;
                 case 'TxtLpuOtd':
                     GrfDocRek = 'SMPLPUOTD';
                     break;
                 case 'TxtLpuMkb':
                     GrfDocRek = 'SMPLPUMKB';
                     break;
                 case 'TxtLpuMkbNam':
                     GrfDocRek = 'SMPLPUMKBNAM';
                     break;
                 case 'TxtLpuRes':
                     GrfDocRek = 'SMPLPURES';
                     break;
                 default:
                     break;
             }
             
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         function onChangeTxt(sender, newText) {
 //            alert("onChangeJlb=" + sender + " " + newText);
             var GrfDocRek;
             var GrfDocVal = newText;
             var GrfDocTyp = 'Int';

             switch (sender) {
                 case 'TxtBegTim':
                     GrfDocRek = 'GRFTIMBEG';
   //                  alert("GrfDocRek=" + GrfDocRek);
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), GETDATE(), 104)+" + " '" + newText + ":00',103)";

                     break;
                 case 'TxtPrbTim':
                     GrfDocRek = 'GRFTIMPRB';
                     GrfDocVal = "CONVERT(DATETIME,CONVERT(CHAR(12), GETDATE(), 104)+" + " '" + newText + ":00',103)";
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
                 case 'BoxDocSmp':
                     GrfDocRek = 'GRFKOD';
                     GrfDocVal = BoxDocSmp.options[BoxDocSmp.selectedIndex()].value;
                     break;
                 case 'BoxResTyp':
                     GrfDocRek = 'SMPSPRTYP';
                     GrfDocVal = BoxResTyp.options[BoxResTyp.selectedIndex()].value;
                     break;
                 case 'BoxResCrm':
                     GrfDocRek = 'SMPSPRCRM';
                     GrfDocVal = BoxResCrm.options[BoxResCrm.selectedIndex()].value;
                     break;
                 case 'BoxResViz':
                     GrfDocRek = 'SMPSPRVIZ';
                     GrfDocVal = BoxResViz.options[BoxResViz.selectedIndex()].value;
                     break;
                 case 'BoxResRsl':
                     GrfDocRek = 'SMPSPRRSL';
                     GrfDocVal = BoxResRsl.options[BoxResRsl.selectedIndex()].value;
                     break;
                 default:
                     break;
             }
             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);

         }

         //    ------------------------------------------------------------------------------------------------------------------------
        
         function OnClientDateChangedDat(sender, selectedDate) {

             var GrfDocRek = 'GRFDAT';
             var GrfDocVal = document.getElementById('TxtDat').value;
             var GrfDocTyp = 'Dat';

      //       alert("GrfDocVal " + GrfDocVal);

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         function OnClientDateChangedBrt(sender, selectedDate) {

             var GrfDocRek = 'GRFBRT';
             var GrfDocVal = document.getElementById('TxtBrt').value;
             var GrfDocTyp = 'Dat';

    //       alert("GrfDocVal " + GrfDocVal);

             onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
         }

         //    ------------------------------------------------------------------------------------------------------------------------

         function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

             var DatDocMdb = 'HOSPBASE';
             var DatDocTab = 'AMBCRD';
             var DatDocKey = 'GRFIDN';
             var DatDocRek = GrfDocRek;
             var DatDocVal = GrfDocVal;
             var DatDocTyp = GrfDocTyp;
             var DatDocIdn;

             if (DatDocRek.substring(0, 3) == "SMP")
             {
                 DatDocTab = 'AMBSMP';
                 DatDocKey = 'SMPAMB';
             }

             var QueryString = getQueryString();
             DatDocIdn = QueryString[1];

        //     alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
         //    alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR="); }
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
 //            alert('OnClientDblClick= ' + parMkbNum.value);
            var GrfDocRek;
            var GrfDocVal = gridMkb.Rows[iRecordIndex].Cells[1].Value;
          
            if (parMkbNum.value == 1)
            {
                Mkb001.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                GrfDocRek = 'DOCMKB001';
             }
             if (parMkbNum.value == 2) 
             {
                 Mkb002.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                 GrfDocRek = 'DOCMKB002';
             }
             if (parMkbNum.value == 3) 
             {
                 Mkb003.value(gridMkb.Rows[iRecordIndex].Cells[1].Value);
                 GrfDocRek = 'DOCMKB003';
             }
             MkbWindow.Close();

             onChangeUpd(GrfDocRek, GrfDocVal);
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
 //           AmbCrdIdn = (string)Session["AmbCrdIdn"];
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //=====================================================================================
            sdsCmp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsCmp.SelectCommand = "SELECT BuxKod,Fio FROM SprBuxKdr WHERE DLGTYP='СМП' AND BuxFrm=" + BuxFrm + " ORDER BY Fio";
            sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsTyp.SelectCommand = "SELECT * FROM Spr003Typ ORDER BY SmpTypNam";
            sdsRes.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsRes.SelectCommand = "SELECT * FROM Spr003Res ORDER BY SmpResNam";
            sdsCrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsCrm.SelectCommand = "SELECT * FROM Spr003Crm ORDER BY SmpCrmNam";
            sdsViz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsViz.SelectCommand = "SELECT * FROM Spr003Viz ORDER BY SmpVizNam";

//            sdsFam.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
//            sdsFam.SelectCommand = "SELECT BuxKod,Fio FROM SprBuxKdr WHERE (DLGKOD=128 OR DLGKOD=66) AND BuxFrm=" + BuxFrm + " ORDER BY Fio";
//            sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
//            sdsUsl.SelectCommand = "SELECT UslKod,UslNam FROM SprUsl WHERE UslZen>0 ORDER BY UslNam";
//            sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
//            sdsStx.SelectCommand = "SELECT CNTKEY AS STXKOD,CNTNAM AS STXNAM FROM SprFrmStx INNER JOIN SprCnt ON SprFrmStx.FrmStxKodStx=SprCnt.CntKod " +
//                       "WHERE SprCnt.CntLvl=0 AND SprFrmStx.FrmStxKodFrm=" + BuxFrm;      

            //=====================================================================================
                TxtBegTim.Attributes.Add("onchange", "onChangeTxt('TxtBegTim',TxtBegTim.value);");
                TxtPrbTim.Attributes.Add("onchange", "onChangeTxt('TxtPrbTim',TxtPrbTim.value);");
            
            
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
            
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("Hsp003CrdIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "Hsp003CrdIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {

                //     obout:OboutTextBox ------------------------------------------------------------------------------------      
//                TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
//                TxtTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFBEG"]).Substring(0,5); //ToString("hh:mm");
                
          //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMBEG"].ToString())) TxtBegTim.Text = "";
          //      else TxtBegTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMBEG"]).Substring(9,5);
                TxtBegTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMBEG"]);

          //      if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMPRB"].ToString())) TxtPrbTim.Text = "";
          //      else TxtPrbTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMPRB"]).Substring(9, 5);
                TxtPrbTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMPRB"]);
                
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFKOD"].ToString())) BoxDocSmp.SelectedValue = "0";
                else BoxDocSmp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["GRFKOD"]);
                
                TxtFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);

                TxtIin.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
                
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFBRT"].ToString())) TxtBrt.Text = "";
                else TxtBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFBRT"]).ToString("dd.MM.yyyy");
                
 //               TxtFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFCMP"]);
 //               TxtCrd.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
                TxtObl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADROBL"]);
                TxtCty.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRCTY"]);
                TxtStr.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRSTR"]);
                TxtDom.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRDOM"]);
                TxtApr.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRAPR"]);
                TxtUgl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRUGL"]);
                TxtZsd.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRZSD"]);
                TxtPod.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRPOD"]);
                TxtEtg.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRETG"]);
                TxtDmf.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPADRDMF"]);
                TxtTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTEL"]);
                TxtJlb.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFMEM"]);

                //    ------------------------------------------------------------------------------------------------------------ 

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["SMPSPRTYP"].ToString())) BoxResTyp.SelectedValue = "0";
                else BoxResTyp.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SMPSPRTYP"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["SMPSPRCRM"].ToString())) BoxResCrm.SelectedValue = "0";
                else BoxResCrm.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SMPSPRCRM"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["SMPSPRVIZ"].ToString())) BoxResViz.SelectedValue = "0";
                else BoxResViz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SMPSPRVIZ"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["SMPSPRRSL"].ToString())) BoxResRsl.SelectedValue = "0";
                else BoxResRsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SMPSPRRSL"]);

                //    ------------------------------------------------------------------------------------------------------------ 
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMEVK"].ToString())) TxtEvkTim.Text = "";
                else TxtEvkTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMEVK"]);

                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMLPU"].ToString())) TxtLpuTim.Text = "";
                else TxtLpuTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMLPU"]);

                //    ------------------------------------------------------------------------------------------------------------ 
                TxtLpuNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPLPUNAM"]);
                TxtLpuOtd.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPLPUOTD"]);
                TxtLpuMkb.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPLPUMKB"]);
                TxtLpuMkbNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPLPUMKBNAM"]);
                TxtLpuRes.Text = Convert.ToString(ds.Tables[0].Rows[0]["SMPLPURES"]);

                //    ------------------------------------------------------------------------------------------------------------ 
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMEND"].ToString())) TxtEndTim.Text = "";
                else TxtEndTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMEND"]);
                
                if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["GRFTIMFRE"].ToString())) TxtFreTim.Text = "";
                else TxtFreTim.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFTIMFRE"]);
                
            }

  //          string name = value ?? string.Empty;
        }
 
        //------------------------------------------------------------------------
        protected void ButBeg_Click(object sender, EventArgs e)
        {
            
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMBEG=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
            
        }

        //------------------------------------------------------------------------
        protected void ButPrb_Click(object sender, EventArgs e)
        {
            /*
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMPRB=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
             */
        }  
                    
        //------------------------------------------------------------------------
        protected void ButEvk_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMEVK=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        //------------------------------------------------------------------------
        protected void ButLpu_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMLPU=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        
        //------------------------------------------------------------------------
        protected void ButFre_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMFRE=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }      
                   
        //------------------------------------------------------------------------
        protected void ButEnd_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmdDtl = new SqlCommand("UPDATE AMBCRD SET GRFTIMEND=GETDATE() WHERE GRFIDN=" + AmbCrdIdn, con);
            cmdDtl.ExecuteNonQuery();
            con.Close();

            getDocNum();
        }

        
        // ==================================== поиск клиента по фильтрам  ============================================
                
  </script>   
    
    
<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parGrfIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <div>

            <%-- ============================  шапка экрана ============================================ --%>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
 
                <!--  ФИО ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label03" runat="server" align="center" Style="font-weight: bold;" Text="Ф.И.О."></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtFio" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label21" runat="server" align="center" Style="font-weight: bold;" Text="ИИН"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtIin" Width="20%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label04" runat="server" align="center" Style="font-weight: bold;" Text="Год/р"></asp:Label>
                        <asp:TextBox runat="server" ID="TxtBrt" Width="80px" BackColor="#FFFFE0" ReadOnly="true" /> 

                    </td>
                    <!--  Год рождения ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" align="center"></td>
                </tr>
                <!--  Область и нас.пункт ----------------------------------------------------------------------------------------------------------  -->
                 <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="Область"></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtObl" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        <asp:Label ID="Label1" runat="server" align="center" Style="font-weight: bold;" Text="Насе"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtCty" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                    <!--  Дом ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;" align="center"></td>
                </tr>

                <!--  Страховщик ----------------------------------------------------------------------------------------------------------  -->
                <!--  ИИН ----------------------------------------------------------------------------------------------------------  -->
                <!--  Улица ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label07" runat="server" align="center" Style="font-weight: bold;" Text="Улица"></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtStr" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                        <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="Дом &nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtDom" Width="15%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <!--  Квартира ----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="Label11" runat="server" align="center" Style="font-weight: bold;" Text="Квартира&nbsp;&nbsp;&nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtApr" Width="15%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                    <!--  Дом ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;" align="center"></td>
                </tr>
                <tr>

                    <!--  Угол ----------------------------------------------------------------------------------------------------------  -->

                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label08" runat="server" align="center" Style="font-weight: bold;" Text="Угол"></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtUgl" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label09" runat="server" align="center" Style="font-weight: bold;" Text="Заезд"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtZsd" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                    </td>
                    <!--  Заезд ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>
                <!--  Подъезд ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label12" runat="server" align="center" Style="font-weight: bold;" Text="Подъезд"></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtPod" Width="7%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label13" runat="server" align="center" Style="font-weight: bold;" Text="Этаж"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtEtg" Width="8%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label14" runat="server" align="center" Style="font-weight: bold;" Text="Домофон"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtDmf" Width="12%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                        <asp:Label ID="Label15" runat="server" align="center" Style="font-weight: bold;" Text="Тел. &nbsp;"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtTel" Width="45%" BackColor="White" Height="60px" ReadOnly="true"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>

                    </td>
                    <!--  Этаж ----------------------------------------------------------------------------------------------------------  -->
                    <td width="50%" style="vertical-align: top;" align="center"></td>

                </tr>
                <!--  Домофон ----------------------------------------------------------------------------------------------------------  -->
                <!--  Телефон ----------------------------------------------------------------------------------------------------------  -->
                <!--  Услуга ----------------------------------------------------------------------------------------------------------  -->

                <!--  Причина ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label17" runat="server" align="center" Style="font-weight: bold;" Text="Причина"></asp:Label>
                    </td>
                    <td width="45%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtJlb" Width="45%" BackColor="White" Height="50px" ReadOnly="true"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                <!--  Аллергия----------------------------------------------------------------------------------------------------------  -->
                        <asp:Label ID="Label19" runat="server" align="center" Style="font-weight: bold;" Text="Алле"></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtAlr" Width="45%" BackColor="White" Height="50px" ReadOnly="true"
                            TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                        </obout:OboutTextBox>
                    </td>
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>
                <!--  Врач СМП ----------------------------------------------------------------------------------------------------------  -->
                <!--  Врач семейный ----------------------------------------------------------------------------------------------------------  -->
            </table>
            <!-- Результат ----------------------------------------------------------------------------------------------------------   
                -->
            <hr>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
               <!--  Дата ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <input type="button" value="Принял" ID="ButBeg" runat="server" size="30" onserverclick="ButBeg_Click" />

                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <asp:TextBox ID="TxtBegTim" Width="7%" Height="20" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />

                       <asp:RegularExpressionValidator ID="regexTxtBegTim" ControlToValidate="TxtBegTim" SetFocusOnError="True" 
                            ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ErrorMessage="Ошибка" runat="server" />


                        <asp:Button ID="ButPrb" runat="server"
                            OnClick="ButPrb_Click"
                            Width="10%" CommandName="" CommandArgument=""
                            Text="Прибыл" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                        <asp:TextBox ID="TxtPrbTim" Width="7%" Height="20" runat="server" 
                            Style="font-weight: 700; font-size: small; text-align: center" />

                       <asp:RegularExpressionValidator ID="regexTxtPrbTim" ControlToValidate="TxtPrbTim" SetFocusOnError="True" 
                            ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ErrorMessage="Ошибка" runat="server" />

                        <asp:Label ID="Label18" runat="server" align="center" Style="font-weight: bold;" Text="Врач"></asp:Label>

                        <obout:ComboBox runat="server" ID="BoxDocSmp" Width="44%" Height="200"
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="SdsCmp" DataTextField="Fio" DataValueField="BuxKod">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                    </td>
                    <td width="5%" align="center"></td>
                </tr>
                <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td width="5%" style="vertical-align: top;"></td>
                    <td width="90%" style="vertical-align: top;">
                        <asp:Label ID="Label24" Text="Вид событий:" runat="server" Width="24%" Font-Bold="true" />
                        <asp:Label ID="LblNpr" Text="Криминал:" runat="server" Width="24%" Font-Bold="true" />
                        <asp:Label ID="LblVid" Text="Рез. вызова:" runat="server" Width="24%" Font-Bold="true" />
                        <asp:Label ID="Label6" Text="Стационар:" runat="server" Width="24%" Font-Bold="true" />
                    </td>

                    <!--  Врач семейный ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;" align="center"></td>
                </tr>
                <tr>
                    <td width="5%" style="vertical-align: top;"></td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:ComboBox runat="server" ID="BoxResTyp" Width="24%" Height="200"
                            DataSourceID="SdsTyp" DataTextField="SmpTypNam" DataValueField="SmpTypKod"
                            FolderStyle="/Styles/Combobox/Plain">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <obout:ComboBox runat="server" ID="BoxResCrm" Width="24%" Height="200"
                            DataSourceID="SdsCrm" DataTextField="SmpCrmNam" DataValueField="SmpCrmKod"
                            FolderStyle="/Styles/Combobox/Plain">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <obout:ComboBox runat="server" ID="BoxResViz" Width="24%" Height="200"
                            DataSourceID="SdsViz" DataTextField="SmpVizNam" DataValueField="SmpVizKod"
                            FolderStyle="/Styles/Combobox/Plain">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                        <obout:ComboBox runat="server" ID="BoxResRsl" Width="24%" Height="200"
                            DataSourceID="SdsRes" DataTextField="SmpResNam" DataValueField="SmpResKod"
                            FolderStyle="/Styles/Combobox/Plain">
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>

                    </td>

                    <!--  Врач семейный ----------------------------------------------------------------------------------------------------------  -->
                    <td width="5%" style="vertical-align: top;" align="center"></td>
                </tr>
            </table>
            <!--  Диагноз ----------------------------------------------------------------------------------------------------------  -->

            <hr>

            <!--  Транспортировка ----------------------------------------------------------------------------------------------------------  -->
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="5%" style="vertical-align: top;"></td>
                    <td width="90%" style="vertical-align: top;">
                        <asp:Button ID="ButEvk" runat="server"
                            OnClick="ButEvk_Click"
                            Width="20%" CommandName="" CommandArgument=""
                            Text="Транспортировка" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                        <asp:TextBox ID="TxtEvkTim" Width="30%" Height="20" runat="server" ReadOnly="true"
                            Style="font-weight: 700; font-size: medium; text-align: center" />

                        <asp:Button ID="ButLpu" runat="server"
                            OnClick="ButLpu_Click"
                            Width="20%" CommandName="" CommandArgument=""
                            Text="Доставка в ЛПУ" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                        <asp:TextBox ID="TxtLpuTim" Width="25%" Height="20" runat="server" ReadOnly="true"
                            Style="font-weight: 700; font-size: medium; text-align: center" />
                    </td>
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>

            </table>

            <hr>

            <!-- ЛПУ ----------------------------------------------------------------------------------------------------------  -->
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="ЛПУ"></asp:Label>
                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtLpuNam" Width="45%" BackColor="White" Height="20px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                        <asp:Label ID="Label16" runat="server" align="center" Style="font-weight: bold;" Text="Отд."></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtLpuOtd" Width="45%" BackColor="White" Height="20px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>

                <tr>
                    <td width="5%" style="vertical-align: top;">
                        <asp:Button ID="ButLpuMkb" runat="server"
                            OnClientClick="OnButton001Click()"
                            Width="100%" CommandName="" CommandArgument=""
                            Text="Диагноз" Height="30px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                    </td>
                    <td width="90%" style="vertical-align: top;">
                        <obout:OboutTextBox runat="server" ID="TxtLpuMkb" Width="10%" BackColor="White" Height="20px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <obout:OboutTextBox runat="server" ID="TxtLpuMkbNam" Width="75%" BackColor="White" Height="20px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>

                        <asp:Label ID="Label22" runat="server" align="center" Style="font-weight: bold;" Text="Рез."></asp:Label>
                        <obout:OboutTextBox runat="server" ID="TxtLpuRes" Width="5%" BackColor="White" Height="20px"
                            TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                             <ClientSideEvents OnTextChanged="onChange" />
                        </obout:OboutTextBox>
                    </td>
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>
            </table>

            <!-- РЕЗУЛЬТАТ ----------------------------------------------------------------------------------------------------------  -->
            <hr>

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>

                    <td width="5%" style="vertical-align: top;"></td>
                    <td width="90%" style="vertical-align: top;">
                        <asp:Button ID="ButFre" runat="server"
                            OnClick="ButFre_Click"
                            Width="20%" CommandName="" CommandArgument=""
                            Text="Свободен" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                        <asp:TextBox ID="TxtFreTim" Width="25%" Height="20" runat="server" ReadOnly="true"
                            Style="font-weight: 700; font-size: medium; text-align: center" />

                        <asp:Button ID="ButEnd" runat="server"
                            OnClick="ButEnd_Click"
                            Width="20%" CommandName="" CommandArgument=""
                            Text="Конец" Height="25px" Font-Bold="true"
                            Style="position: relative; top: 0px; left: 0px" />

                        <asp:TextBox ID="TxtEndTim" Width="30%" Height="20" runat="server" ReadOnly="true"
                            Style="font-weight: 700; font-size: medium; text-align: center" />


                    </td>
                    <td width="5%" style="vertical-align: top;" align="center"></td>

                </tr>
            </table>
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

  <asp:SqlDataSource runat="server" ID="sdsCmp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  <asp:SqlDataSource runat="server" ID="sdsTyp"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsRes"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsCrm"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
  <asp:SqlDataSource runat="server" ID="sdsViz"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 


 
</body>
</html>



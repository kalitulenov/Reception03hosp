<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

<%-- ============================  JAVA ============================================ --%>
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">

        /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

        /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
			}
			a.pg:hover {
				color:crimson;
			}

    </style>

 <script type="text/javascript">
     var myconfirm = 0;
//     myDialogDubl.visible = false;

     function KltClose(result) {
    //             alert("KofClose=1" + result);
         KltWindow.Close();

         var hashes = result.split('&');
       //             alert("hashes=" + hashes);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var AmbCrdIIN = hashes[2];

         var AmbCntIdn = hashes[0];

         var ua = navigator.userAgent;
         var h = $(window).height() - 100;
         var w = $(window).width() - 60;
    //     if (ua.search(/OPR/) > -1) h = h + 100;
     //   alert("AmbCntIdn = " + AmbCntIdn + " & GlvDocTyp=" + GlvDocTyp);

         switch (GlvDocTyp) {
             case 'АМБ':
                 if (GrfFrm == 12) location.href = "/Priem/DocAppAmbKrd.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=АМБ";
                 else window.open("/Priem/DocAppAmb.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ПРЦ':
                 //  location.href = "/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ФНК':
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'РНТ':
                 //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'УЗИ':
                 //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ФИЗ':
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'МАС':
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ЛАБ':
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'СТМ':
                 window.open("/Priem/DocAppDnt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'АНЛ':
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppAnl.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&AmbCrdIIN=" + AmbCrdIIN, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ВЫС':
                 window.open("/Priem/DocApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=СМП", "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ВЫС':
                 window.open("/Priem/DocApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ДОМ", "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             //case 'УЗИ': location.href = "/Priem/DocAppUzi.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'AMB': location.href = "/Priem/DocAppAmbAcm.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=АМБ"; break;
             case 'АНТ': location.href = "/Priem/DocAppAnt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'СМП': location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/Priem/DocAppAkt.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
//             case 'АНЛ': location.href = "/Priem/DocAppAnl.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             //case 'ВЫС': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=СМП"; break;
             //case 'ВЫД': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/Priem/DocAppDom.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/Priem/DocAppLab.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/Priem/DocAppStz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=СТЦ"; break;
             case 'ПРФ': location.href = "/Priem/DocAppPrf.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
             case '061':
             case '062':
             case '086':
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
                 break;
             case 'МЕД':
                 window.open("/Priem/DocAppNrs.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'СОЦ':
                 window.open("/Priem/DocAppSoz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                break;
         }
   //      var jsVar = "dotnetcurry.com";
   //      __doPostBack('callPostBack', jsVar);

     }


     // Client-Side Events for Delete
     // при ExposeSender = "false" OnBeforeDelete(record)
     // при ExposeSender = "true" OnBeforeDelete(sender,record)
     function OnBeforeDelete(sender,record) {
 //         alert("OnBeforeDelete");
          if (record.GRFDOCNAM == 'НАЗ') {
              alert('Удалять процедуры нельзя!');
              return false;
          }
          else {
              if (myconfirm == 1) {
                  return true;
              }
              else {
                  document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
                  document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                  myConfirmBeforeDelete.Open();
                  return false;
              }
          }
     }

     function findIndex(record) 
     {
         var index = -1;
         for (var i = 0; i < GridCrd.Rows.length; i++) {
             if (GridCrd.Rows[i].Cells[0].Value == record.GRFIDN) 
             {
                 index = i;
                 break;
             }
         }
         return index;
     }

     function ConfirmBeforeDeleteOnClick() 
     {
         myconfirm = 1;
 //        alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         GridCrd.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function OnClientSelect(sender, selectedRecords) {
         //      alert(document.getElementById('MainContent_parDbl').value);

         if (document.getElementById('MainContent_parDbl').value == "DBL") {
             document.getElementById('MainContent_parDbl').value = "";
             return;
         }

         var AmbCrdIdn = selectedRecords[0].GRFIDN;
         //      alert("AmbCrdIdn=" + AmbCrdIdn);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var AmbCrdIIN = selectedRecords[0].GRFIIN;

         //        var AmbCrdIdn = GridCrd.Rows[iRecordIndex].Cells[0].Value;
         //        var GlvDocPrv = GridCrd.Rows[iRecordIndex].Cells[1].Value;
         //     alert("AmbCrdIIN=" + AmbCrdIIN);

         var ua = navigator.userAgent;
         //     alert("ua=" + ua);
         var h = $(window).height() - 100;
         var w = $(window).width() - 60;
         //    alert("h=" + h);
         //    alert("w=" + w);
         //    if (ua.search(/OPR/) > -1) h = h + 100;
         //   alert("h2=" + h);
         //   alert("w2=" + w);

         switch (GlvDocTyp) {
             case 'АМБ':
                 if (GrfFrm == 12) location.href = "/Priem/DocAppAmbKrd.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=АМБ";
                 else {
                     var new_window = window.open("/Priem/DocAppAmb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
               //      new_window.onbeforeunload = function () { alert("при закрытии окна вызвать функцию"); }
                 }
                 break;
             case 'AMB': location.href = "/Priem/DocAppAmbAcm.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=АМБ"; break;
             case 'ПРЦ':
                 //  location.href = "/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ФНК':
                 // location.href = "/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; 
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'РНТ':
                 //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'УЗИ':
                 //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ФИЗ':
                 //   location.href = "/Priem/DocAppFiz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'МАС':
                 //   location.href = "/Priem/DocAppMas.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ЛАБ':
                 //location.href = "/Priem/DocAppLab.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'СТМ':
                 window.open("/Priem/DocAppDnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'АНЛ':
                 //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                 h = h - 200;
                 w = w - 200;
                 window.open("/Priem/DocAppAnl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&AmbCrdIIN=" + AmbCrdIIN, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ВЫС':
                 window.open("/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СМП", "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'ВЫС':
                 window.open("/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ", "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;

             //case 'УЗИ': location.href = "/Priem/DocAppUzi.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНТ': location.href = "/Priem/DocAppAnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'СМП': location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/Priem/DocAppAkt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             //case 'АНЛ': location.href = "/Priem/DocAppAnl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
 //            case 'ВЫС': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СМП"; break;
 //            case 'ВЫД': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/Priem/DocAppDom.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/Priem/DocAppLbr.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/Priem/DocAppStz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СТЦ"; break;
             case 'ПРФ': location.href = "/Priem/DocAppPrf.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case '061':
             case '062':
             case '086':
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + GlvDocTyp, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
                 break;
             case 'МЕД':
                 window.open("/Priem/DocAppNrs.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'СОЦ':
                 window.open("/Priem/DocAppSoz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                break;
         }
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtButton_Click() {

         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parDocTyp').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;
         if (GrfTyp == 'AMB') GrfTyp = 'АМБ';

         var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtAdvButton_Click() {

         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
         var GrfTyp = document.getElementById('MainContent_parDocTyp').value;
         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
         var GrfEnd = document.getElementById('MainContent_txtDate2').value;

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;
         if (GrfTyp == 'AMB') GrfTyp = 'АМБ';

         var ua = navigator.userAgent;

         if (GlvDocTyp == 'АМБ' || GlvDocTyp == 'AMB' || GlvDocTyp == 'УЗИ' || GlvDocTyp == 'РНТ' || GlvDocTyp == 'СТМ' || GlvDocTyp == 'СМП' || GlvDocTyp == 'ДОМ' || GlvDocTyp == 'ФНК' || GlvDocTyp == 'МЕД') {
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLstDoc&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLstDoc&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }
         else {
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }
     }

/*  ПРИМЕР
     function onClientSelect(selectedRecords) {
         var index = -1;

         for (var i = 0; i < grid1.Rows.length; i++) {
             if (grid1.Rows[i].Cells[0].Value == selectedRecords[0].OrderID) {
                 index = i;
                 break;
             }
         }

         if (index != -1) {
             grid1.editRecord(index);
         }
     }
*/

     // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
     function AddButton_Click() {
 /*
         KltWindow.setTitle("Поиск клиентов");
         KltWindow.setUrl("DocAppKlt.aspx?TextBoxFio=");
         KltWindow.Open();
*/
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;
         if (GlvDocTyp == 'AMB') GlvDocTyp = 'АМБ';
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;

         var ua = navigator.userAgent;
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
      //   alert("GlvDocTyp1=" + GlvDocTyp);

         KltWindow.setTitle("Поиск клиентов");
         KltWindow.setUrl("/Referent/RefGlv003Klt.aspx");
         KltWindow.Open();


  //       if (GlvDocTyp == 'СМП' || GlvDocTyp == 'ВЫС' || GlvDocTyp == 'ДОМ' || GlvDocTyp == 'ВЫД' || GrfFrm == 6) {
  //          if (ua.search(/Chrome/) > -1)
  //               window.open("/Referent/RefGlv003Klt.aspx", "ModalPopUp", "toolbar=no,width=1200,height=620,left=200,top=110,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
  //           else
  //               window.showModalDialog("/Referent/RefGlv003Klt", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:110px;dialogWidth:1200px;dialogHeight:620px;");
   //        }
  //       else {
  //           if (ua.search(/Chrome/) > -1)
  //               window.open("DocAppKlt.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
  //           else
  //               window.showModalDialog("DocAppKlt.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
   //      }
     }

     // -------изменение как EXCEL-------------------------------------------------------------------          

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'GRFPTH';
           GridCrd.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridCrd.executeFilter();
         }
         else {
             GridCrd.removeFilter();
         }
     }


     /* ПЕЧАТЬ РАСХОДА  -----------------------------------------------------------------------*/
     function RsxButton_Click() {
     //    alert("RsxButton");

             $(".RsxMatInp").dialog({
                 autoOpen: true,
                 width: 400,
                 height: 170,
                 modal: true,
                 draggable: false,
                 buttons:
                    {
                     "OK": function () {
                         
                         var GrfTxt = document.getElementById('MainContent_txtRsxMat').value;
                         if (GrfTxt == "")
                         {
                             alert("Материал не задан");
                             $(this).dialog("close");
                             return;
                         }

                 //        alert(GrfTxt);
                         //           alert(EndDat);
                         //           alert(document.getElementById('parBuxFrm').value);

                         $(this).dialog("close");
                         // =========================================================================================================================================================
                         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
                         var GrfKod = document.getElementById('MainContent_HidBuxKod').value;
                         var GrfTyp = document.getElementById('MainContent_parDocTyp').value;
                         var GrfBeg = document.getElementById('MainContent_txtDate1').value;
                         var GrfEnd = document.getElementById('MainContent_txtDate2').value;
                         
                         var ua = navigator.userAgent;

                         if (ua.search(/Chrome/) > -1)
                             window.open("/Report/DauaReports.aspx?ReportName=HspDocAppRsx&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekDocTxt=" + GrfTxt,
                                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                         else
                             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppRsx&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekDocTxt=" + GrfTxt,
                                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
                                
                         // =========================================================================================================================================================
 
                     },
                     "Отмена": function () {
                         $(this).dialog("close");
                     }
                 }
             });
     }

     
     function GridCrd_dbl(rowIndex) {
         //         alert('GridKas_dbl=');
         var AmbCrdIdn000 = GridCrd.Rows[rowIndex].Cells[0].Value;
         var AmbCrdIIN = GridCrd.Rows[rowIndex].Cells[6].Value;

         document.getElementById('MainContent_parCrdIdn').value=AmbCrdIdn000;
         document.getElementById('MainContent_parCrdIIN').value = AmbCrdIIN;
         document.getElementById('MainContent_parDbl').value="DBL";
         myDialogDubl.Open();
     }


     function OpenDublCrd(AmbCrdIdnDbl) {
         //     alert('GlvDocIdnDbl=' + GlvDocIdnDbl);
         myDialogDubl.Close();

         var AmbCrdIdn = AmbCrdIdnDbl;
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;

         var ua = navigator.userAgent;
         var h = $(window).height() - 100;
         var w = $(window).width() - 60;
         //  if (ua.search(/OPR/) > -1) h = h + 100;

         switch (GlvDocTyp) {
             case 'АМБ':
                        if (GrfFrm == 12) location.href = "/Priem/DocAppAmbKrd.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=АМБ";
                        else window.open("/Priem/DocAppAmb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'ПРЦ':
                        //  location.href = "/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'АНТ': location.href = "/Priem/DocAppAnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФНК':
                        // location.href = "/Priem/DocAppFnk.aspx?AmbCrdIdn=" + AmbCntIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'РНТ':
                        //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'УЗИ':
                         //location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp; break;
                         h = h - 200;
                         w = w - 200;
                         window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                         break;
             case 'ФИЗ':
                      //  location.href = "/Priem/DocAppFiz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'МАС':
                     //   location.href = "/Priem/DocAppMas.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppPrz.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'ЛАБ':
                        //location.href = "/Priem/DocAppLab.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
                        h = h - 200;
                        w = w - 200;
                        window.open("/Priem/DocAppFnk.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=150,top=200,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             case 'СТМ':
                        window.open("/Priem/DocAppDnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                        break;
             //case 'УЗИ': location.href = "/Priem/DocAppUzi.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'AMB': location.href = "/Priem/DocAppAmbAcm.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=АМБ"; break;
             case 'СМП': location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/Priem/DocAppAkt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
         //    case 'АНЛ': location.href = "/Priem/DocAppAnl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&AmbCrdIIN=" + AmbCrdIIN; break;
             case 'ВЫС': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СМП"; break;
             case 'ВЫД': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/Priem/DocAppDom.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/Priem/DocAppLbr.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/Priem/DocAppStz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СТЦ"; break;
             case 'ПРФ': location.href = "/Priem/DocAppPrf.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             //      case '061': location.href = "/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             //      case '062': location.href = "/Priem/DocApp062.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             //      case '086': location.href = "/Priem/DocApp086.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'МЕД':
                 window.open("/Priem/DocAppNrs.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w +",height=" + h +",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                 break;
             case 'СОЦ':
                 window.open("/Priem/DocAppSoz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp, "DocAppAmb", "toolbar=no,width=" + w + ",height=" + h + ",left=25,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no");
                break;
         }
     }

     function WindowRefresh() {
       //  alert("ExitFun");
         document.getElementById("MainContent_PushButton").click();
       //  var jsVar = "callPostBack";
       //  __doPostBack('callPostBack', jsVar);
     }

 </script>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">

        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int AmbCrdIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
            //       Sapka.Text = TxtDoc;
            if (GlvDocTyp == "AMB") GlvDocTyp = "АМБ";
            Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================

            if (GridCrd.IsCallback)
            {
                Session["pgSize"] = GridCrd.CurrentPageIndex;
            }

            switch (GlvDocTyp)
            {
                case "АМБ":
                    //   GridCrd.Columns[3].HeaderText = "Организация";
                    //    GridCrd.Columns[11].Visible= true;
                    //    GridCrd.Columns[12].Visible = false;
                    break;
                case "ПРЦ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "РНТ":
                    GridCrd.Columns[9].HeaderText = "ОЗФ";
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "ФИЗ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "УЗИ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "ЛАБ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "МАС":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "СТМ":
                    //   GridCrd.Columns[11].Visible= false;
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "СМП":
                    GridCrd.Columns[05].Width = "20%";
                    GridCrd.Columns[09].Visible = false;
                    GridCrd.Columns[10].Visible = false;

                    GridCrd.Columns[11].Visible = true;
                    GridCrd.Columns[12].Visible = true;
                    GridCrd.Columns[13].Visible = true;
                    GridCrd.Columns[14].Visible = true;
                    GridCrd.Columns[15].Visible = true;
                    GridCrd.Columns[16].Visible = true;
                    GridCrd.Columns[17].Visible = true;
                    GridCrd.Columns[18].Visible = true;
                    break;
                case "ВЫС":
                    //GridCrd.Columns[05].Width = "20%";
                    //GridCrd.Columns[09].Visible = false;
                    //GridCrd.Columns[10].Visible = false;

                    //GridCrd.Columns[11].Visible = true;
                    //GridCrd.Columns[12].Visible = true;
                    //GridCrd.Columns[13].Visible = true;
                    //GridCrd.Columns[14].Visible = true;
                    //GridCrd.Columns[15].Visible = true;
                    //GridCrd.Columns[16].Visible = true;
                    //GridCrd.Columns[17].Visible = true;
                    //GridCrd.Columns[18].Visible = true;
                    break;
                case "ВЫД":
                    //GridCrd.Columns[05].Width = "20%";
                    //GridCrd.Columns[09].Visible = false;
                    //GridCrd.Columns[10].Visible = false;

                    //GridCrd.Columns[11].Visible = true;
                    //GridCrd.Columns[12].Visible = true;
                    //GridCrd.Columns[13].Visible = true;
                    //GridCrd.Columns[14].Visible = true;
                    //GridCrd.Columns[15].Visible = true;
                    //GridCrd.Columns[16].Visible = true;
                    //GridCrd.Columns[17].Visible = true;
                    //GridCrd.Columns[18].Visible = true;
                    break;
                case "ДОМ":
                    GridCrd.Columns[05].Width = "20%";
                    GridCrd.Columns[09].Visible = false;
                    GridCrd.Columns[10].Visible = false;

                    GridCrd.Columns[11].Visible = true;
                    GridCrd.Columns[12].Visible = true;
                    GridCrd.Columns[13].Visible = true;
                    GridCrd.Columns[14].Visible = true;
                    GridCrd.Columns[15].Visible = true;
                    GridCrd.Columns[16].Visible = true;
                    GridCrd.Columns[17].Visible = true;
                    GridCrd.Columns[18].Visible = true;
                    break;
                case "ЛБР":
                    //         GridCrd.Columns[19].Visible = false;
                    //          GridCrd.Columns[05].Width = "35%";
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                case "СТЦ":
                    //   GridCrd.Columns[12].Visible = true;
                    break;
                default:
                    // Do nothing.
                    break;
            }


            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridCrd.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //               GridCrd.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);

            if (!Page.IsPostBack)
            {
                if (Session["pgSize"] != null)
                {
                    GridCrd.CurrentPageIndex = int.Parse(Session["pgSize"].ToString());
                }

                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();


                getGrid();

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                if (BuxFrm == "1" && GlvDocTyp == "АМБ" && BuxKod != "1988") AddButton.Visible = false;
                if (BuxFrm == "1" && GlvDocTyp == "МЕД") AddButton.Visible = false;

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            TekDocTyp = GlvDocTyp;
            if (GlvDocTyp == "AMB") TekDocTyp = "АМБ";
            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";


            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspDocAppLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = TekDocTyp;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspDocAppLst");

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (TekDocTyp == "ВЫД") Sapka.Text = "ВЫЗОВ ВРАЧА НА ДОМ";
                    else Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]) + " (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
                    GridCrd.DataSource = ds;
                    GridCrd.DataBind();
                }
            }
            catch
            {
            }

            con.Close();

        }


        protected void PushButton_Click(object sender, EventArgs e)
        {
            string GlvBegDatTxt;
            string GlvEndDatTxt;
            string TekDocTyp;

            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            if (GlvDocTyp == "ЛБР") TekDocTyp = "ЛАБ";
            else TekDocTyp = GlvDocTyp;

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            // ============================ посуммировать  ==============================================
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstSum", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = TekDocTyp;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();
            // ============================ посуммировать  ==============================================

            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

        //============= удаление записи после опроса  ===========================================================================================
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            string AmbCrdIdn;
            AmbCrdIdn = Convert.ToString(e.Record["GRFIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstDel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // Выполнить команду
            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();

        }

        // ---------Суммация  ------------------------------------------------------------------------
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {
                if (e.Row.Cells[13].Text == null | e.Row.Cells[13].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[13].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[11].Text = "Итого:";
                e.Row.Cells[13].Text = ItgDocSum.ToString();
            }
        }

        // ============================ дублировать амб.карту ==============================================
        protected void DblButtonOK_Click(object sender, EventArgs e)
        {
            int AmbCrdIdn;
            string AmbCrdIdnDbl;
            string AmbCrdIIN;

            //    myDialogDubl.Visible = false;
            //    myDialogDubl.VisibleOnLoad = false;

            AmbCrdIdn = Convert.ToInt32(parCrdIdn.Value);
            AmbCrdIIN = Convert.ToString(parCrdIIN.Value);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstDbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.Parameters.Add("@GRFIININP", SqlDbType.VarChar).Value = AmbCrdIIN;
            cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GRFBUXOUT", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GRFIDNOUT", SqlDbType.Int, 4).Value = 0;
            cmd.Parameters["@GRFIDNOUT"].Direction = ParameterDirection.Output;

            try
            {
                int numAff = cmd.ExecuteNonQuery();
                // Получить вновь сгенерированный идентификатор.
                AmbCrdIdnDbl = Convert.ToString(cmd.Parameters["@GRFIDNOUT"].Value);
                if (AmbCrdIdnDbl == "0")
                {
                    ExecOnLoad("OpenDublCrd(" + AmbCrdIdnDbl + ");");
                }
            }
            finally
            {
                con.Close();
            }

            ExecOnLoad("OpenDublCrd(" + AmbCrdIdnDbl + ");");

        }

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
            //   int SozDsp = Convert.ToInt32(e.Row.Cells[01].Text);
            string SozDsp = e.Row.Cells[01].Text;
            if (SozDsp.Length < 3) SozDsp = "   ";
            // if (e.Row.Cells[01].Text != "0") e.Row.Cells[07].ForeColor = System.Drawing.Color.Red;

            if (SozDsp[0].ToString() ==  "G") e.Row.Cells[07].ForeColor = System.Drawing.Color.Orange; // сгенерированая строка
            else
               if (SozDsp[1].ToString() ==  "C") e.Row.Cells[07].ForeColor = System.Drawing.Color.Red; // соц.не защищенный
            else
                  if (SozDsp[2].ToString() ==  "D") e.Row.Cells[07].ForeColor = System.Drawing.Color.Blue;  // диспансерный
        }
        // ======================================================================================

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parCrdIdn" runat="server" />
 <asp:HiddenField ID="parCrdIIN" runat="server" />
 <asp:HiddenField ID="parDbl" runat="server" />
   
 
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>
             <asp:Label ID="Label1" runat="server" Text="Период" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>


 <%-- ============================  OnClientDblClick  ============================================ 
      <ClientSideEvents ExposeSender="true"
                        OnClientDblClick="OnClientDblClick"
     --%>

 <%-- ============================  OnClientSelect  ============================================ 
       AllowRecordSelection = "true"
      <ClientSideEvents ExposeSender="false"
                          OnClientSelect="OnClientSelect"
     --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="none"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">
	        
	        <obout:Grid id="GridCrd" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "100"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
     OnRowDataBound="OnRowDataBound_Handle"
     FilterType="Normal"     
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
	            <ClientSideEvents ExposeSender="true" 
                          OnClientSelect="OnClientSelect"
	                      OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFSOZ" HeaderText="Соц" Visible="false" Width="0%" />
	                <obout:Column ID="Column02" DataField="GRFDOCNAM" HeaderText="НАЗ" Visible="false" Width="0%" />
	                <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column04" DataField="TIMBEG" HeaderText="ВРЕМЯ" Width="4%" />
	                <obout:Column ID="Column05" DataField="GRFINV" HeaderText="ИНВ" Align="right" Width="4%" />
	                <obout:Column ID="Column06" DataField="GRFIIN" HeaderText="ИИН" Align="center" Width="9%" />
	                <obout:Column ID="Column07" DataField="GRFPTH" HeaderText="ФИО" Width="22%" />
	                <obout:Column ID="Column08" DataField="GRFBRTGOD" HeaderText="ГОД/Р" Width="5%" />
	                <obout:Column ID="Column09" DataField="ORGSTXNAM" HeaderText="СТРАХОВЩИК" Width="8%" />
	                <obout:Column ID="Column10" DataField="GRFPOL" HeaderText="ЗАПОЛНЯЕМ." Width="6%" />
	                <obout:Column ID="Column11" DataField="GRFERR" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;КЕМ НАПРАВЛЕН" Width="19%"/>
	                <obout:Column ID="Column12" DataField="GRFSUM" HeaderText="СУММА" Align="right" Width="5%"/>
 	                <obout:Column ID="Column13" DataField="FI" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" Visible="false"/>
	                <obout:Column ID="Column14" DataField="TIMCMP" HeaderText="ПРИНЯЛ" DataFormatString = "{0:hh:mm}" Width="5%" Visible="false" />
  	                <obout:Column ID="Column15" DataField="TIMPRB" HeaderText="ПРИБЫЛ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false"/>
	                <obout:Column ID="Column16" DataField="TIMEVK" HeaderText="ЭВАК." DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column17" DataField="TIMLPU" HeaderText="ЛПУ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column18" DataField="TIMFRE" HeaderText="ОСВОБ." DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
	                <obout:Column ID="Column19" DataField="TIMEND" HeaderText="КОНЕЦ" DataFormatString = "{0:hh:mm}" Width="4%" Visible="false" />
		            <obout:Column ID="Column20" DataField="" HeaderText="КОРР" Width="5%" AllowEdit="false" AllowDelete="true" runat="server" />
                    <obout:Column ID="Column21" DataField="DBL" HeaderText="ДУБЛ" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateDbl" />
				    </obout:Column>				
		            <obout:Column ID="Column22" DataField="GRFEXP" HeaderText="ПС" Width="3%" Align="left"/>
		        </Columns>

                <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateDbl">
                       <Template>
                          <input type="button" id="btnDbl" class="tdTextSmall" value="Дубл" onmousedown="GridCrd_dbl(<%# Container.PageRecordIndex %>)"/>
 					</Template>
                    </obout:GridTemplate>
                </Templates>

           	</obout:Grid>


        <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        


  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                  <asp:Button ID="AddButton" runat="server" CommandName="AddCom" Text="Новая амб.карта" onClientClick="AddButton_Click(); return false;"/>
                 <input type="button" name="PrtButton" value="Печать отчета" id="PrtButton" onclick="PrtButton_Click();">
                 <input type="button" name="PrtButton" value="Печать отчета (расширенный)" id="PrtAdvButton" onclick="PrtAdvButton_Click();">
                 <input type="button" name="RsxButton" value="Расход матер." id="RsxButton" onclick="RsxButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 
    
    <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   
                  <input type="button" name="AddButton" value="Новая амб.карта" id="AddButton" onclick="AddButton_Click();">
      
        --%>
        <div class="RsxMatInp" title=" Укажите расходный материал">
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                   <td width="20%" style="vertical-align: central;" >
                        <asp:TextBox ID="txtRsxMat" Width="100%" runat="server" ></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>             

<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
     
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Удаление" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogDubl" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Дублирования амбулаторной карты" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите дублировать амбулаторную карту?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="DblButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="myDialogDubl.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

    <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================       --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
              Left="100" Top="10" Height="620" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
  
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

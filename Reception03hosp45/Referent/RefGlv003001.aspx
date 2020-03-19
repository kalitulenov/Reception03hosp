<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="RefGlv003001.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlv003001" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



        <script type="text/javascript">


        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function onchanged(checkbox, iRowIndex) 
        {
  //        alert("checkbox1="+checkbox);

            document.getElementById('parInd').value = iRowIndex;

            var FndIdn = localStorage.CntIdn; //getter
            var FndFio = localStorage.GrfPth; //getter
            var FndIIN = localStorage.GrfIIN; //getter
            var FndTel = localStorage.GrfTel; //getter
            var FndBrt = localStorage.GrfBrt; //getter
            var FndKrt = localStorage.GrfKrt; //getter
            var FndCmp = localStorage.GrfCmp; //getter
            var FndStx = localStorage.GrfStx; //getter

    //        alert('FIO1=' + FndFio);

            document.getElementById('parUpd').value = "0";
            var oRecord = new Object();
            oRecord.GRFIDN = GridGrf.Rows[iRowIndex].Cells[0].Value;
            oRecord.GRFWWW = GridGrf.Rows[iRowIndex].Cells[6].Value;
            oRecord.GRFBUS = GridGrf.Rows[iRowIndex].Cells[5].Value;

            if (checkbox == false) {
   //             alert("checkbox == false");
                // ----------------------------установит флажок-----------------------------------------------------------------------
                if (FndFio == "") {
                    windowalert("Клиент не указан", "Предупреждения", "warning"); 
                }
// ---------------------------------------------------------------------------------------------------
                else {
                    var GrfDocRek = 'GRFBUS';
                    var GrfDocVal = true;
                    var GrfDocTyp = 'Bit';
                    var GrfDocIdn = GridGrf.Rows[iRowIndex].Cells[0].Value;

// записать флажок
                    var body = GridGrf.GridBodyContainer.firstChild.firstChild.childNodes[1];
                    var cell = body.childNodes[iRowIndex].childNodes[5];
                    cell.firstChild.innerHTML = "<div class='ob_gCc2'>"+
                                                "<input type='checkbox' onmousedown='onchanged(this.checked, " + iRowIndex + ")' checked='checked' /></div>" +
                                                "<div class='ob_gCd'>True</div>";

//                    onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocIdn);

// записать пациента
                    cell = body.childNodes[iRowIndex].childNodes[8];
                    cell.firstChild.lastChild.innerHTML = FndFio;

                    cell = body.childNodes[iRowIndex].childNodes[9];
                    cell.firstChild.lastChild.innerHTML = FndTel;
// запись ФИО
 //                   alert("=1=" + FndFio + "=2=" + FndIIN + "=3=" + FndTel + "=4=" + FndBrt + "=5=" + FndKrt + "=6=" + FndCmp + "=7=" + FndStx);
                    var BuxKod = document.getElementById('parBuxKod').value;
 //                   alert("BuxKod_зап =" + BuxKod);

                    var GrfDocRek2 = "UPDATE AMBCRD SET GRFBUS=1,GRFBUX=" + BuxKod + ",GRFPTH=N'" + FndFio + "',GRFIIN='" + FndIIN + "',GRFTEL=LEFT('" + FndTel +
                                     "',50),GRFSTX=(SELECT TOP 1 CNTKLTKEY FROM SPRCNTKLT WHERE CNTKLTIDN=" + FndIdn + ") WHERE GRFIDN=" + GrfDocIdn;
                    onChangeUpd(GrfDocRek2, '0', 'Upd', GrfDocIdn);

// ====================================== ОКНО УСЛУГИ ==============================================================================================================
                    //           alert("OnClientDblClick=" + iRecordIndex);
                    var GrfOneIdn = GridGrf.Rows[iRowIndex].Cells[0].Value;
                    var GrfOneKod = GridGrf.Rows[iRowIndex].Cells[1].Value;
                    //       alert("GrfOneIdn=" + GrfOneIdn);
                    //        alert("GrfOneKod=" + GrfOneKod);

                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=900,height=450,left=250,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                    else {
                        window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:450px;");
                    }
                    return false;
// ====================================================================================================================================================


               }

            }
                // ------------------------------снять флажок---------------------------------------------------
            else {
 //               alert("checkbox == true");
//                if (oRecord.GRFWWW == '@') {
//                    alert("Записан через Интернет!");
//                }
//                else {
                    ConfirmDialog.screenCenter();
                    ConfirmDialog.Open();  // запрос на снятие флажка
//                }
           }
        }

        // ------------------------  щесчек на поле услуга  ------------------------------------------------------------------
        function onchangedUsl(checkbox, iRowIndex) {
    //                  alert("checkbox1="+checkbox);
            var Ind = document.getElementById('parInd').value;
    //        alert("checkbox2=" + iRowIndex);

            var body = GridGrf.GridBodyContainer.firstChild.firstChild.childNodes[1];
  //          alert("checkbox3=" + checkbox);
            var cell = body.childNodes[iRowIndex].childNodes[7];
 //           alert("checkbox4=" + cell);
            cell.firstChild.innerHTML = "<div class='ob_gCc2'>" +
                                         "<input type='checkbox' onmousedown='onchangedUsl(this.checked," + iRowIndex + ")' /></div>" +
                                         "<div class='ob_gCd'>True</div>";
 //           alert("checkbox5=" + checkbox);

            var GrfOneIdn = GridGrf.Rows[iRowIndex].Cells[0].Value;
  //          var GrfOneKod = GridGrf.Rows[iRowIndex].Cells[1].Value;
     //       alert("GrfOneIdn=" + GrfOneIdn);
    //        alert("GrfOneKod=" + GrfOneKod);

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=1100,height=550,left=250,top=210,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
            else {
                window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:550px;");
            }
            return false;

        }

            // запрос на снятие флажка отказ
        function Cancel_click() {
            ConfirmDialog.Close();
        }

            // запрос на снятие флажка согласие
        function OK_click() {
 //           	        alert("OK_click=");
            var Ind = document.getElementById('parInd').value;
 //           alert("checkbox2=" + Ind);

            var body = GridGrf.GridBodyContainer.firstChild.firstChild.childNodes[1];
            var cell = body.childNodes[Ind].childNodes[5];

            cell.firstChild.innerHTML = "<div class='ob_gCc2'>" +
                                         "<input type='checkbox' onmousedown='onchanged(this.checked," + Ind +")' /></div>" +
                                         "<div class='ob_gCd'>False</div>";

//  обнулить признак ИНтернета
//            cell = body.childNodes[Ind].childNodes[6];
            //            cell.firstChild.lastChild.innerHTML = "";
 //  обнулить признак услуги
            var cell = body.childNodes[Ind].childNodes[7];
            cell.firstChild.lastChild.innerHTML = "";

//  обнулить признак
            cell = body.childNodes[Ind].childNodes[8];
            cell.firstChild.lastChild.innerHTML = "";


// обнулить признак GRFPTH
            cell = body.childNodes[Ind].childNodes[9];
            cell.firstChild.lastChild.innerHTML = "";


            // -------------------------------------------------------------------------------- запись в базу удаленных ------------------------------
            var BuxKod = document.getElementById('parBuxKod').value;
//            alert("BuxKod_удал =" + BuxKod);
            var GrfDocIdn = GridGrf.Rows[Ind].Cells[0].Value;
            var GrfDocRek = "INSERT INTO AMBCRDDEL (GrfIdn,GrfRef,GrfFrm,GrfCab,GrfTyp,GrfDocNam,GrfDocIdn,GrfKod,GrfDat,GrfBeg,GrfTimBeg,GrfTimPrb,GrfTimEvk,GrfTimLpu,GrfTimFre,GrfTimEnd, " +
                                                   "GrfPth,GrfBrt,GrfStx,GrfIIN,GrfPol,GrfNnn,GrfNoz,GrfZen,GrfBus,GrfPrzLgt,GrfPrg,GrfBux,GrfTim,GrfDelFlg,GrfDelTim,GrfDelBux) " +
                            "SELECT GrfIdn,GrfRef,GrfFrm,GrfCab,GrfTyp,GrfDocNam,GrfDocIdn,GrfKod,GrfDat,GrfBeg,GrfTimBeg,GrfTimPrb,GrfTimEvk,GrfTimLpu,GrfTimFre,GrfTimEnd, " +
                                   "GrfPth,GrfBrt,GrfStx,GrfIIN,GrfPol,GrfNnn,GrfNoz,GrfZen,GrfBus,GrfPrzLgt,'Реф',GrfBux,GrfTim,1,GETDATE()," + BuxKod +
                            " FROM AMBCRD WHERE GRFIDN=" + GrfDocIdn;
            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);
          
            // -------------------------------------------------------------------------------- обнулить запись ------------------------------
            GrfDocRek = "UPDATE AMBCRD SET GRFBUS=0,GRFPTH='',GRFIIN='',GRFPOL='',GRFSTX='',GRFINTFLG=0,GRFINTBEG=NULL,GRFINTEND=NULL,GRFEML='',GRFTEL='',GRFTIM=NULL WHERE GRFIDN=" + GrfDocIdn;

            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);

            // -------------------------------------------------------------------------------- удалить услуги ------------------------------
            GrfDocRek = "DELETE FROM AMBUSL WHERE USLAMB=" + GrfDocIdn;

            onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);



            ConfirmDialog.Close();

        }

        function changeCellData() {
            var body = GridGrf.GridBodyContainer.firstChild.firstChild.childNodes[1];

            // change data in first row, second cell
            var cell1 = body.childNodes[0].childNodes[1];

            cell1.firstChild.lastChild.innerHTML = "value 1";

            // change data in second row, second cell
            var cell2 = body.childNodes[1].childNodes[1];
            cell2.firstChild.lastChild.innerHTML = "value 2";

            // change data in all rows, third cell
            for (var i = 0; i < body.childNodes.length; i++) {
                var cell = body.childNodes[i].childNodes[3];
                cell.firstChild.lastChild.innerHTML = "value " + i;
            }
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocIdn) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBCRD';
            var DatDocKey = 'GRFIDN';
            var DatDocRek = GrfDocRek;
            var DatDocVal = GrfDocVal;
            var DatDocTyp = GrfDocTyp;
            var DatDocIdn = GrfDocIdn;

   //         var QueryString = getQueryString();
   //         DatDocIdn = QueryString[1];
   //         alert("DatDocTyp=" + DatDocTyp);

   //         alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
            switch (DatDocTyp) {
                case 'Sql':
                    DatDocTyp = 'Sql';
                 //   if (DatDocRek.substring(0,6) == 'UPDATE' || DatDocRek.substring(0,6) == 'SELECT' || DatDocRek.substring(0,6) == 'DELETE') SqlStr = DatDocRek;
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
                case 'Upd':
                    DatDocTyp = 'Sql';
                    SqlStr = DatDocRek;
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

            ConfirmDialog.Close();
        }

        function OnClientDblClick(sender, iRecordIndex) {
   //           alert("OnClientDblClick=" + iRecordIndex);
            var GrfOneIdn = GridGrf.Rows[iRecordIndex].Cells[0].Value;
            var GrfOneKod = GridGrf.Rows[iRecordIndex].Cells[1].Value;
            //       alert("GrfOneIdn=" + GrfOneIdn);
            //        alert("GrfOneKod=" + GrfOneKod);

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=900,height=550,left=250,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
            else {
                window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:550px;");
            }
            return false;
        }

 		    //==============================================================================================
 		    //================================================================================================== 		    
 		    
    </script>

</head>
<body>
    <form id="form1" runat="server">
            <asp:HiddenField ID="parUpd" runat="server" />
            <asp:HiddenField ID="parInd" runat="server" />
            <asp:HiddenField ID="parBuxKod" runat="server" />

    <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    <div style="top: -20px">
            <obout:Grid ID="GridGrf" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                ShowLoadingMessage="false"
                AllowRecordSelection="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="false"
                Width="100%"
                AllowPaging="false"
                AllowFiltering="false">
  	            <ClientSideEvents ExposeSender="true" OnClientDblClick="OnClientDblClick" />
              <Columns>
                    <obout:Column ID="Column100" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0px" />
                    <obout:Column ID="Column101" DataField="GRFKOD" HeaderText="Код" Visible="false" Width="0px" />
                    <obout:Column ID="Column102" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="9%" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column103" DataField="TIMBEG" HeaderText="Время" ReadOnly="true" Width="9%"/>
                    <obout:Column ID="Column104" DataField="F" HeaderText="Врач" ReadOnly="true" Width="20%" />
                    <obout:Column ID="Column105" DataField="GRFBUS" HeaderText="Занят" Width="5%">
                        <TemplateSettings TemplateId="tplBus" />
                    </obout:Column>
                    <obout:Column ID="Column106" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="5%" />
                    <obout:Column ID="Column107" DataField="USLKOL" HeaderText="Усл"  Width="5%" />
                    <obout:Column ID="Column108" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="27%" />
                    <obout:Column ID="Column109" DataField="GRFTEL" HeaderText="Телефон" ReadOnly="true" Width="20%" />
               </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus">
                        <Template>
                            <input type="checkbox" onmousedown="onchanged(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                       </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>

                <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialog" runat="server" Visible="true" VisibleOnLoad="false" IsModal="true" Position="CUSTOM" 
                    Top="50" Left="100" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" 
                    Title="Cнять прием" zIndex="10" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите снять прием ?</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <input type="button" value="OK" onclick="OK_click()" />
                              <input type="button" value="Отмена" onclick="Cancel_click()" />
                        </td>
                    </tr>
                </table> 
            </center>
        </owd:Dialog>

    </div>
            <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />


          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UslWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="20" Top="0" Height="450" Width="450" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Услуги врача">
       </owd:Window>

    </form>
       
      <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

    <style type="text/css">
         /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }

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
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }

    </style>

</body>
</html>

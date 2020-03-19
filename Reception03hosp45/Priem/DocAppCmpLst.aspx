<%@ Page Language="C#" MasterPageFile="~/Masters/MstrBlank.Master" AutoEventWireup="True" CodeBehind="DocAppCmpLst.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppCmpLst" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


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
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 17px;
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
     //    ------------------ смена логотипа ----------------------------------------------------------
     /*
     window.onload = function () {
         //           alert("AmbCrdIdn=" + AmbCrdIdn);

         var BrwNam = "Desktop";

         if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
             BrwNam = "Android";
             //              alert("Android");
         }
         //          else alert("Windows");

         var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

         document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = 'bold';

         mySpl.loadPage("BottomContent", "DocApp003Viz.aspx?AmbCrdIdn=" + AmbCrdIdn);
     };

     */
     // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
     function HandlePopupResult(result) {
 //        alert("result of popup is: " + result);
         var hashes = result.split('&');
//        alert("hashes=" + hashes[0]);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         var AmbCntIdn = hashes[0];

        location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=0&AmbCntIdn=" + AmbCntIdn + "&GlvDocTyp=" + GlvDocTyp;
     }


     // Client-Side Events for Delete
     function OnBeforeDelete(sender, record)
      {
          if (myconfirm == 1) 
         {
             return true;
         }
         else {
             document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
             document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
             myConfirmBeforeDelete.Open();
             return false;
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

     function OnClientDblClick(sender, iRecordIndex) {
            var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         
            var AmbCrdIdn = GridCrd.Rows[iRecordIndex].Cells[0].Value;
            var GlvDocPrv = GridCrd.Rows[iRecordIndex].Cells[1].Value;

            location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn="; 

     }


     function OnClientSelect(selectedRecords) {
         var AmbCrdIdn = selectedRecords[0].GRFIDN;
 //        alert("AmbCrdIdn=" + AmbCrdIdn);

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;

 //        var AmbCrdIdn = GridCrd.Rows[iRecordIndex].Cells[0].Value;
 //        var GlvDocPrv = GridCrd.Rows[iRecordIndex].Cells[1].Value;


         location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn="; 

     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtButton_Click() {

         var GrfFrm = document.getElementById('ctl00$MainContent$HidBuxFrm').value;
         var GrfKod = document.getElementById('ctl00$MainContent$HidBuxKod').value;
         var GrfTyp = document.getElementById('ctl00$MainContent$parDocTyp').value;
         var GrfBeg = document.getElementById('ctl00$MainContent$txtDate1').value;
         var GrfEnd = document.getElementById('ctl00$MainContent$txtDate2').value;

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;

         var ua = navigator.userAgent;

         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppLst&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
    
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
         //      alert("AddButton_Click=");
         var ua = navigator.userAgent;
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
//         alert("GlvDocTyp1=" + GlvDocTyp);

 //        if (GlvDocTyp == 'СМП' || GlvDocTyp == 'ВЫС' || GlvDocTyp == 'ДОМ' || GlvDocTyp == 'ВЫД') {
             if (ua.search(/Chrome/) > -1)
                 window.open("/Referent/RefGlv003Klt.aspx", "ModalPopUp", "toolbar=no,width=1200,height=620,left=200,top=110,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Referent/RefGlv003Klt", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:110px;dialogWidth:1200px;dialogHeight:620px;");
//         }
//         else {
//             if (ua.search(/Chrome/) > -1)
//                 window.open("DocAppKlt.aspx", "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
//             else
//                 window.showModalDialog("DocAppKlt.aspx", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
//         }
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


 </script>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="HidBuxBrw" runat="server" />
   
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: -30px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: -30px; width: 100%; height: 30px;">
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

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 0%; position: relative; top: -30px; width: 100%; height: 550px;">
	        
	        <obout:Grid id="GridCrd" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_5" 
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
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
	            <ClientSideEvents 
                          OnClientSelect="OnClientSelect"
	                      OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFFLGREP" HeaderText="Проведен" Visible="false" Width="0%" />
	                <obout:Column ID="Column02" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column03" DataField="TIMBEG" HeaderText="ВРЕМЯ" Width="5%" />
	                <obout:Column ID="Column04" DataField="GRFIIN" HeaderText="ИИН" Width="10%" />
	                <obout:Column ID="Column05" DataField="GRFPTH" HeaderText="ФИО" Width="29%" />
	                <obout:Column ID="Column06" DataField="GRFBRTGOD" HeaderText="ГОД/Р" Width="5%" />
 	                <obout:Column ID="Column07" DataField="FI" HeaderText="ОТВЕТСТВЕННЫЙ" Width="11%" />
	                <obout:Column ID="Column08" DataField="TIMCMP" HeaderText="ПРИНЯЛ" DataFormatString = "{0:hh:mm}" Width="5%" />
  	                <obout:Column ID="Column09" DataField="TIMPRB" HeaderText="ПРИБЫЛ" DataFormatString = "{0:hh:mm}" Width="5%" />
	                <obout:Column ID="Column10" DataField="TIMEVK" HeaderText="ЭВАК." DataFormatString = "{0:hh:mm}" Width="5%" />
	                <obout:Column ID="Column11" DataField="TIMLPU" HeaderText="ЛПУ" DataFormatString = "{0:hh:mm}" Width="5%" />
	                <obout:Column ID="Column12" DataField="TIMFRE" HeaderText="ОСВОБ." DataFormatString = "{0:hh:mm}" Width="5%" />
	                <obout:Column ID="Column13" DataField="TIMEND" HeaderText="КОНЕЦ" DataFormatString = "{0:hh:mm}" Width="5%" />
		            <obout:Column ID="Column14" DataField="" HeaderText="КОРР" Width="5%" AllowEdit="false" AllowDelete="true" runat="server" />
		        </Columns>
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
             Style="left: 0%; position: relative; top: -30px; width: 100%; height: 30px;">
             <center>
                 <input type="button" name="AddButton" value="Новый док" id="AddButton" onclick="AddButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
     
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Confirm" Width="300" IsModal="true">
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
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="WinFrm.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="350" Top="150" Height="450" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>   
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

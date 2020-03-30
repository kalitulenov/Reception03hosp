<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DocAppLstBce.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppLstBce" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

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

     // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
     function OnClientSelect(selectedRecords) {
         var AmbCrdIdn = selectedRecords[0].GRFIDN;
 //        alert("AmbCrdIdn=" + AmbCrdIdn);

         var GlvDocTyp = selectedRecords[0].GRFTYP;

 //        var AmbCrdIdn = GridCrd.Rows[iRecordIndex].Cells[0].Value;
 //        var GlvDocPrv = GridCrd.Rows[iRecordIndex].Cells[1].Value;


         switch (GlvDocTyp) {
             
             case 'АМБ': location.href = "/Priem/DocAppAmb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ПРЦ': location.href = "/Priem/DocAppPrz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'РНТ': location.href = "/Priem/DocAppXry.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ФИЗ': location.href = "/Priem/DocAppFiz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'УЗИ': location.href = "/Priem/DocAppUzi.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'МАС': location.href = "/Priem/DocAppMas.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ЛАБ': location.href = "/Priem/DocAppLab.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'СТМ': location.href = "/Priem/DocAppDnt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'СМП': location.href = "/Priem/DocAppCmp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АКТ': location.href = "/Priem/DocAppAkt.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'АНЛ': location.href = "/Priem/DocAppAnl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=" + GlvDocTyp; break;
             case 'ВЫС': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СМП"; break;
             case 'ВЫД': location.href = "/Priem/DocApp003Dsp.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ДОМ': location.href = "/Priem/DocAppDom.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ДОМ"; break;
             case 'ЛБР': location.href = "/Priem/DocAppLbr.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=ЛАБ"; break;
             case 'СТЦ': location.href = "/Priem/DocAppStz.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=&GlvDocTyp=СТЦ"; break;
         }

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

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspDocAppSvd&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAppSvd&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
     }

     function PrtAmbButton_Click() {

         var GrfFrm = document.getElementById('ctl00$MainContent$HidBuxFrm').value;
         var GrfKod = document.getElementById('ctl00$MainContent$HidBuxKod').value;
         var GrfTyp = document.getElementById('ctl00$MainContent$parDocTyp').value;
         var GrfBeg = document.getElementById('ctl00$MainContent$txtDate1').value;
         var GrfEnd = document.getElementById('ctl00$MainContent$txtDate2').value;

         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         if (GlvDocTyp == 'ЛБР') return;

         var ua = navigator.userAgent;

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCemAll&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtCemAll&TekDocIdn=0&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
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

 <asp:SqlDataSource runat="server" ID="sdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
 <%-- =================  диалоговое окно для ввод расходных материалов  ============================================   --%>
        <div class="RsxMatInp" title=" Укажите расходный материал">
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                   <td width="20%" style="vertical-align: central;" >
                        <asp:TextBox ID="txtRsxMat" Width="100%" runat="server" ></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>             
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
             <obout:ComboBox runat="server"
                            ID="BoxDoc"
                            Width="20%"
                            Height="200"
                            Font-Bold="true"
                            EmptyText="Выберите врача ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsDoc"
                            DataTextField="DOCNAM"
                            DataValueField="DOCKOD" >
             </obout:ComboBox>
						    
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

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
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
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
	            <ClientSideEvents ExposeSender="false" 
                          OnClientSelect="OnClientSelect" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFTYP" HeaderText="ТИП" Visible="true" Width="3%" />
	                <obout:Column ID="Column02" DataField="GRFDOCNAM" HeaderText="НАЗ" Visible="false" Width="0%" />
	                <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column04" DataField="TIMBEG" HeaderText="ВРЕМЯ" Width="4%" />
	                <obout:Column ID="Column05" DataField="GRFIIN" HeaderText="ИИН" Width="10%" />
	                <obout:Column ID="Column06" DataField="GRFPTH" HeaderText="ФИО" Width="20%" />
	                <obout:Column ID="Column07" DataField="GRFBRTGOD" HeaderText="ГОД/Р" Width="5%" />
	                <obout:Column ID="Column08" DataField="ORGSTXNAM" HeaderText="СТРАХОВЩИК" Width="8%" />
	                <obout:Column ID="Column09" DataField="GRFPOL" HeaderText="ЖАМСДЛНЗ" Width="6%" />
	                <obout:Column ID="Column10" DataField="GRFERR" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ПРИМЕЧАНИЕ" Width="14%"/>
	                <obout:Column ID="Column11" DataField="GRFSUM" HeaderText="Сумма" Align="right" Width="5%"/>
 	                <obout:Column ID="Column12" DataField="FI" HeaderText="ВРАЧ" Width="10%" />
 	                <obout:Column ID="Column13" DataField="DLGNAM" HeaderText="СПЕЦ" Width="10%" />
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

<%-- ============================  нижний блок   ExposeSender="true" ============================================ 
                    FilterType="ProgrammaticOnly" 

    
    --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать амб.карт" id="PrtAmbButton" onclick="PrtAmbButton_Click();">
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

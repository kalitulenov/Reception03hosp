<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DocAppLstNazLek.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppLstNazLek" Title="Безымянная страница" %>

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
 //        var AmbNazIdn = record.NAZIDN;
         UklWindow.setTitle(selectedRecords[0].GRFPTH);
         UklWindow.setUrl("/Priem/DocAppLstNazDtl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=");
         UklWindow.Open();

   //      location.href = "/Priem/DocAppLstNazDtl.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbCntIdn=";
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

     // -------изменение как EXCEL-------------------------------------------------------------------          

     function filterGrid(e) {
         var fieldName;
         //        alert("filterGrid=");

         if (e != 'ВСЕ') {
             fieldName = 'UKLNAM';
             GridNaz.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
             GridNaz.executeFilter();
         }
         else {
             GridNaz.removeFilter();
         }
     }

 </script>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
   
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="СПИСОК НАЗНАЧЕННЫХ ЛЕКАРСТВ" 
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

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridNaz" runat="server" 
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
                FilterType="ProgrammaticOnly" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
	            <ClientSideEvents ExposeSender="false" 
                          OnClientSelect="OnClientSelect" />
                <Columns>
                    <obout:Column ID="Column000" DataField="UKLNAM" HeaderText="ЛЕКАРСТВО" Width="36%" />
                    <obout:Column ID="Column001" DataField="KOL000" HeaderText="ВСЕГО" Width="4%" Align="right" />
                    <obout:Column ID="Column002" DataField="KOL001" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column003" DataField="KOL002" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column004" DataField="KOL003" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column005" DataField="KOL004" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column006" DataField="KOL005" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column007" DataField="KOL006" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column008" DataField="KOL007" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column009" DataField="KOL008" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column010" DataField="KOL009" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column011" DataField="KOL010" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column012" DataField="KOL011" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column013" DataField="KOL012" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column014" DataField="KOL013" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column015" DataField="KOL014" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
                    <obout:Column ID="Column016" DataField="KOL015" HeaderText="." Width="4%" Align="right" DataFormatString="{0:##}" />
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
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UklWindow" runat="server"  Url="WinFrm.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="100" Top="150" Height="450" Width="1200" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>   
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

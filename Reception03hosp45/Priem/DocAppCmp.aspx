<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MstrBlank.Master" AutoEventWireup="true" CodeBehind="DocAppCmp.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppCmp" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
 
         window.onload = function () {
  //           alert("AmbCrdIdn=" + AmbCrdIdn);
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocApp003Viz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         };

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

         function VizButton_Click() {
    //         var QueryString = getQueryString();
    //         var AmbCrdIdn = QueryString[1];
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

  //           alert('AmbCrdIdn =' + AmbCrdIdn);

             var AmbCrdIdn = document.getElementById('MainContent_parGrfIdn').value;
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocApp003Viz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function MapButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocApp003Map.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function OsmButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             /*
             alert("QueryString[0]=" + QueryString[0]);
             alert("QueryString[1]=" + QueryString[1]);
             alert("QueryString[2]=" + QueryString[2]);
             alert("QueryString[3]=" + QueryString[3]);
*/
 //            var property = document.getElementById("MainContent_mySpl_ctl00_ctl01_ButtonOsm");
 //            property.style.backgroundColor = "#7FFF00";
 //            property.style.fontStyle.bold = true;
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocApp003Osm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function LocButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbSttSpz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function UslButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = 'bold';
             document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppAmbUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }


          function ArxAmbButton_Click() {
              var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;

              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonViz').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonMap').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonOsm').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonLoc').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
              document.getElementById('MainContent_mySpl_ctl00_ctl01_ButtonArxAmb').style.fontWeight = 'bold';

              mySpl.loadPage("BottomContent", "DocAppAmbArx.aspx?AmbCrdIdn=" + AmbCrdIdn);
          }


         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
         function OK_click() {
             // Номер элемента
             var IndFix = document.getElementById('MainContent_parIndFix').value;
             // Номер строки
             var IndChk = document.getElementById('MainContent_parIndChk').value;

             $(".EmlDialog").dialog(
             {
                 autoOpen: true,
                 width: 500,
                 height: 300,
                 modal: true,
                 zIndex: 20000,
                 buttons:
                 {
                     "ОК": function () {
                         var bValid = Page_ClientValidate();
                         if (bValid) {
                             Eml_OK_click();
                             $(this).dialog("close");
                         }
                     },
                     "Отмена": function () {
                         document.getElementById('MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl08').innerHTML = '<div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl09" class="ob_gCc2">                                <input type="checkbox" onclick="updateSent01(this.checked,' + IndChk + ');">                            </div><div id="MainContent_WinGrfDocDay_grid4_ob_grid4BodyContainer_ctl' + IndFix + '_ctl11" class="ob_gCd">False</div>';
                         $(this).dialog("close");
                     }
                 }
             });
         }
         //    ==========================  ПЕЧАТЬ =============================================================================================

         function PrtButton_Click() {
             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrt003&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrt003&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

 </script>

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:2%; position: relative; top: -30px; width: 96%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="5%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="15%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="40%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="15%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="15%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="5%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="15%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="40%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="15%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="15%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>

        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: -40px; width: 96%; height: 550px;">

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="30" HeightMax="30" HeightDefault="30" >
				    <Content>
                     <asp:Button ID="ButtonViz" runat="server" Height="30" Width="16%" CommandName="Push" Text="Вызов" OnClientClick="VizButton_Click(); return false;"/>
                     <asp:Button ID="ButtonMap" runat="server" Height="30" Width="16%" CommandName="Push" Text="На карте" OnClientClick="MapButton_Click(); return false;"/>
                     <asp:Button ID="ButtonUsl" runat="server" Height="30" Width="16%" CommandName="Push" Text="Услуги" OnClientClick="UslButton_Click(); return false"/>
                     <asp:Button ID="ButtonOsm" runat="server" Height="30" Width="16%" CommandName="Push" Text="Осмотр" OnClientClick="OsmButton_Click(); return false;"/>
                     <asp:Button ID="ButtonLoc" runat="server" Height="30" Width="16%" CommandName="Push" Text="Статус" OnClientClick="LocButton_Click(); return false;"/>
                     <asp:Button ID="ButtonArxAmb" runat="server" Height="30" Width="15%" CommandName="Push" Text="Архив приемов" OnClientClick="ArxAmbButton_Click(); return false;"/>
				    </Content>
			    </TopPanel>
                <BottomPanel HeightDefault="400" HeightMin="400" HeightMax="400">
				    <Content>
					   

				    </Content>
			    </BottomPanel>
       </obspl:HorizontalSplitter>
  
            
        </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: -40px; width: 96%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
                 <input type="button" value="Печать"  onclick="PrtButton_Click()" />
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
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
    
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="DocAppLstAllAmb.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppLstAllAmb" %>

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
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
             mySpl.loadPage("BottomContent", "DocAppLstAllUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
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

         function UslButton_Click() {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];

             document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = 'bold';
             document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonNap').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAppLstAllUsl.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function NapButton_Click() {
  //           alert("NapButton=");
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
             document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = '';
             document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonNap').style.fontWeight = 'bold';
     //                  alert("NapButton="+);

             mySpl.loadPage("BottomContent", "DocAppLstAllPrs.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }


         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

 </script>


      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:2%; position: relative; top: 0px; width: 96%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="7%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№кассы</td>
                  <td width="6%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№напр</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№карты</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="20%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Программа</td>
              </tr>
              
               <tr>
                  <td width="7%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKas" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="6%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxPrs" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

                  <td width="20%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTit" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxPrg" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="ЗАПИСЬ К ВРАЧУ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 550px;">

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
				    <Content>
                          <asp:Button ID="ButtonUsl" runat="server" Width="49%" CommandName="Push" Text="УСЛУГИ" OnClientClick="UslButton_Click(); return false;" />
                          <asp:Button ID="ButtonNap" runat="server" Width="49%" CommandName="Push" Text="НАПРАВЛЕНИЯ" OnClientClick="NapButton_Click(); return false;" />
				    </Content>
			    </TopPanel>
                <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
				    <Content>
					   

				    </Content>
			    </BottomPanel>
       </obspl:HorizontalSplitter>
  
            
        </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 2%; position: relative; top: 0px; width: 96%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
  
</asp:Content>

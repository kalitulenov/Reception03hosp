<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="DocAisScrLstDocOne.aspx.cs" Inherits="Reception03hosp45.AIS.DocAisScrLstDocOne" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>


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

         window.onload = function () {
             var KltIIN = document.getElementById('HidKltIIN').value;
           //  alert("KltIIN=" + KltIIN);

             document.getElementById('mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocAisScrLstDocOneScr.aspx?KltIIN=" + KltIIN);
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

         function ScrButton_Click() {
             var KltIIN = document.getElementById('HidKltIIN').value;
             document.getElementById('mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonRes').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObs').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAisScrLstDocOneScr.aspx?KltIIN=" + KltIIN);
         }

         function ObsButton_Click() {
             var KltIIN = document.getElementById('HidKltIIN').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonRes').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObs').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocAisScrLstDocOneObs.aspx?KltIIN=" + KltIIN);
         }

         function ResButton_Click() {
             var KltIIN = document.getElementById('HidKltIIN').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonScr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonRes').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObs').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "DocAisScrLstDocOneRes.aspx?KltIIN=" + KltIIN);
         }

         function PrtButton_Click() {
             var KltIIN = document.getElementById('HidKltIIN').value;

             var GrfFrm = document.getElementById('HidBuxFrm').value;

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocAis025&TekDocKod="+KltIIN+ "&TekDocFrm=" + GrfFrm,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocAis025&TekDocKod=" + KltIIN + "&TekDocFrm=" + GrfFrm,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

         function Export() {
             //    alert('Export=');
             myDialogDubl.Open();
         }

 </script>

</head>

<body>
    <form id="form1" runat="server">


        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidKltIIN" runat="server" />
        <asp:HiddenField ID="HidBuxFrm" runat="server" />
        <asp:HiddenField ID="Sapka" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  верхний блок  ============================================ --%>

        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 65px;">

            <table border="1" cellspacing="0" width="100%">
                <tr>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Дата</td>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">ИИН</td>
                    <td width="28%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Фамилия И.О.</td>
                    <td width="6%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Д.рож</td>
                    <td width="6%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">№ инв</td>
                    <td width="14%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Телефон</td>
                    <td width="25%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Работа</td>
                </tr>

                <tr>
                    <td width="10%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxDat" BorderStyle="None" Width="80px" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="10%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="28%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxFio" BorderStyle="None" Width="100%" Height="20" runat="server" ReadOnly="true" BackColor="#FFFFE0" />
                    </td>
                    <td width="6%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="6%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxNum" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="14%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxTel" BorderStyle="None" Width="100%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                    </td>
                    <td width="25%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                </tr>

            </table>
        </asp:Panel>
        <%-- ============================  средний блок  ============================================ --%>

        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="None"
            Style="left: 0%; position: relative; top: -10px; width: 100%; height: 580px;">

            <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
                    <Content>
                        <asp:Button ID="ButtonScr" runat="server" Width="19%" CommandName="Push" Text="Скрининг-обседование" OnClientClick="ScrButton_Click(); return false;" />
                        <asp:Button ID="ButtonObs" runat="server" Width="19%" CommandName="Push" Text="Результат обседования" OnClientClick="ObsButton_Click(); return false;" />
                        <asp:Button ID="ButtonRes" runat="server" Width="19%" CommandName="Push" Text="Результат осмотора" OnClientClick="ResButton_Click(); return false;" />
                        <asp:Button ID="ButtonPrt" runat="server" Width="19%" CommandName="Push" Text="Печать статкарту" OnClientClick="PrtButton_Click(); return false;" />
                        <asp:Button ID="ButtonMis" runat="server" Width="19%" CommandName="Push" Text="Передать в МИС" OnClientClick="Export(); return false;" />
                    </Content>
                </TopPanel>
                <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                    <Content>
                    </Content>
                </BottomPanel>
            </obspl:HorizontalSplitter>
        </asp:Panel>

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogDubl" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Дублирования амбулаторной карты" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите отправить в МИС?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="ExpButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="myDialogDubl.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>

    </form>
</body>




</html>

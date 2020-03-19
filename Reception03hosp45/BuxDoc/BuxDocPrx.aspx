<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxDocPrx.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxDocPrx" %>

<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
	        font-size: 12px;
         }

 
       /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }

    </style>
 
<%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

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

        // Client-Side Events for Delete
        function OnBeforeDelete(sender, record) {

            if (myconfirm == 1) {
                return true;
            }
            else {
                document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                myConfirmBeforeDelete.Open();
                return false;
            }
        }

        function findIndex(record) {
            var index = -1;
            for (var i = 0; i < GridMat.Rows.length; i++) {
                if (GridMat.Rows[i].Cells[0].Value == record.DTLIDN) {
                    index = i;

                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridMat.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            //          alert("1");
            var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;
            //          alert("2");
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxPrxDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPrxDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function GridMat_ClientEdit(sender, record) {
            var TabDtlIdn = record.DTLIDN;
            //           alert("GridMat_ClientEdit=" + AmbDtlIdn);
            var QueryString = getQueryString();
            var GlvDocIdn = QueryString[1];

            MatWindow.setTitle(TabDtlIdn);
            MatWindow.setUrl("BuxDocPrxOne.aspx?TabDtlIdn=" + TabDtlIdn);
            MatWindow.setUrl("BuxDocPrxOne.aspx?GlvDocIdn=" + GlvDocIdn + "&TabDtlIdn=" + TabDtlIdn);
            MatWindow.Open();

            return false;
        }

        function GridMat_ClientInsert(sender, record) {
            //                    alert("GridMat_ClientInsert");

            var QueryString = getQueryString();
            var GlvDocIdn = QueryString[1];

            var TabDtlIdn = 0;

            MatWindow.setTitle("Новый");
            MatWindow.setUrl("BuxDocPrxOne.aspx?GlvDocIdn=" + GlvDocIdn + "&TabDtlIdn=0");
            MatWindow.Open();

            return false;
        }

        function WindowClose() {
            //           alert("GridNazClose");
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }


    </script>


   

<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  <asp:HiddenField ID="parDocIdn" runat="server" />

<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Приходные накладные" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 5%; position: relative; width: 90%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 60px;">

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="№ док.:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                    <asp:TextBox ID="TxtDocNum" Width="25%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;от&nbsp;&nbsp;"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtDocDat" Width="80px" />
                    <obout:Calendar ID="CalDoc" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtDocDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                </td>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label3" runat="server" align="center" Style="font-weight: bold;" Text="Поставщик:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <%-- ============================  выбор поставщика  ============================================ --%>
                    <obout:ComboBox runat="server"
                        AutoPostBack="false"
                        ID="BoxOrg"
                        Width="90%"
                        Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        EmptyText="Выберите поставщика ..."
                        DataSourceID="sdsOrg"
                        DataTextField="ORGNAM"
                        DataValueField="ORGKOD" />
                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label4" runat="server" align="center" Style="font-weight: bold;" Text="Счет:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                     <obout:ComboBox runat="server" ID="BoxAcc" Width="25%" Height="200" MenuWidth="600px" 
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsAccOrg" DataTextField="ACCTXT" DataValueField="ACCKOD">
                    </obout:ComboBox>

                    <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="МОЛ:"></asp:Label>
                     <obout:ComboBox runat="server" ID="BoxMol" Width="50%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsMol" DataTextField="MOLNAM" DataValueField="MOLKOD">
                    </obout:ComboBox>

                </td>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label6" runat="server" align="center" Style="font-weight: bold;" Text="Счет-фактура:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <asp:TextBox ID="TxtFkt" Width="50%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtFktDat" Width="60px" />
                    <obout:Calendar ID="CalFkt" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtFktDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />


                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->

        </table>


    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>

    <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">


        <obout:Grid runat="server"
            ID="GridMat"
            Serialize="true"
            AutoGenerateColumns="false"
            FolderStyle="~/Styles/Grid/style_5"
            ShowTotalNumberOfPages="false"
            FolderLocalization="~/Localization"
            AllowSorting="false"
            Language="ru"
            CallbackMode="true"
            AllowPaging="false"
            AllowPageSizeSelection="false"
            Width="100%"
            PageSize="-1"
             EnableTypeValidation="false"
            ShowColumnsFooter="true">
            <ScrollingSettings ScrollHeight="310" />
            <Columns>
                <obout:Column ID="Column00" DataField="DTLIDN" Visible="false" HeaderText="Идн" Width="0%" />
                <obout:Column ID="Column01" DataField="DTLDEB" HeaderText="СЧЕТ" Align="right" Width="5%">
                    <TemplateSettings EditTemplateId="TemplateEditAccNam" />
                </obout:Column>
                <obout:Column ID="Column02" DataField="DTLNAM" HeaderText="НАИМЕНОВАНИЕ" Width="38%" />
                <obout:Column ID="Column03" DataField="DTLKOL" HeaderText="КОЛ-ВО" Align="right" Width="5%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column04" DataField="DTLEDN" HeaderText="ЕД.ИЗМ" Width="10%">
                    <TemplateSettings TemplateId="TemplateEdn" EditTemplateId="TemplateEditEdn" />
                </obout:Column>
                <obout:Column ID="Column07" DataField="DTLZEN" HeaderText="ЦЕНА" Align="right" Width="10%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column08" DataField="DTLNDC" HeaderText="НДС" Align="center" Width="5%">
                    <TemplateSettings TemplateId="TemplateNdc" EditTemplateId="TemplateEditNdc" />
                </obout:Column>
                <obout:Column ID="Column09" DataField="DTLSUM" HeaderText="СУММА" Align="right" ReadOnly="true" Width="5%" DataFormatString="{0:F2}" />
                <obout:Column ID="Column10" DataField="DTLPRZ" HeaderText="НАДБАВКА" Width="5%" DataFormatString="{0:F2}" Align="right" />
                <obout:Column ID="Column11" DataField="DTLGRP" HeaderText="ГРУППА" Width="12%">
                    <TemplateSettings TemplateId="TemplateGrp" EditTemplateId="TemplateEditGrp" />
                </obout:Column>
                <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="5%" AllowEdit="true" AllowDelete="true" runat="server" />
            </Columns>

            <Templates>
                <obout:GridTemplate runat="server" ID="TemplateEdn">
                    <Template>
                        <%# Container.DataItem["DTLEDN"]%>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditEdn" ControlID="ddlEdn" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlEdn" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsEdn" CssClass="ob_gEC" DataTextField="EDNNAM" DataValueField="EDNNAM">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateGrp">
                    <Template>
                        <%# Container.DataItem["GRPMATNAM"]%>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditGrp" ControlID="ddlGrp" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlGrp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGrp" CssClass="ob_gEC" DataTextField="GRPMATNAM" DataValueField="GRPMATKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditAccNam" ControlID="ddlAccNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlAccNam" runat="server" Width="99%" DataSourceID="sdsAcc" CssClass="ob_gEC" DataTextField="ACCTXT" DataValueField="ACCKOD">
                            <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="tplDatePickerSlb" ControlID="txtOrderDateSlb" ControlPropertyName="value">
                    <Template>
                        <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                            <tr>
                                <td valign="middle">
                                    <obout:OboutTextBox runat="server" ID="txtOrderDateSlb" Width="100%"
                                        FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                </td>
                                <td valign="bottom" width="30">
                                    <obout:Calendar ID="calDat" runat="server"
                                        StyleFolder="~/Styles/Calendar/styles/default"
                                        TextBoxId="txtOrderDateSlb"
                                        DatePickerMode="true"
                                        ShowYearSelector="true"
                                        YearSelectorType="DropDownList"
                                        TitleText="Выберите год: "
                                        CultureName="ru-RU"
                                        DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                </td>
                            </tr>
                        </table>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="tplDatePickerDat" ControlID="txtOrderDateDat" ControlPropertyName="value">
                    <Template>
                        <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                            <tr>
                                <td valign="middle">
                                    <obout:OboutTextBox runat="server" ID="txtOrderDateDat" Width="100%"
                                        FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                </td>
                                <td valign="bottom" width="30">
                                    <obout:Calendar ID="calBeg" runat="server"
                                        StyleFolder="~/Styles/Calendar/styles/default"
                                        TextBoxId="txtOrderDateDat"
                                        DatePickerMode="true"
                                        ShowYearSelector="true"
                                        YearSelectorType="DropDownList"
                                        TitleText="Выберите год: "
                                        CultureName="ru-RU"
                                        DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                </td>
                            </tr>
                        </table>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateNdc" UseQuotes="true">
                    <Template>
                        <%# (Container.Value == "True" ? "+" : " ") %>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditNdc" ControlID="chkNdc" ControlPropertyName="checked" UseQuotes="false">
                    <Template>
                        <input type="checkbox" id="chkNdc" />
                    </Template>
                </obout:GridTemplate>
            </Templates>


        </obout:Grid>
    </asp:Panel>

    <%-- ============================  нижний блок  ============================================ 
                    <asp:DropDownList ID="ddlSheets" runat="server" AppendDataBoundItems = "true"/>
     --%>

    <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="ClrButton" runat="server" CommandName="Clr" Text="Очистить" onclick="ClrButton_Click"/>
                 <asp:FileUpload ID="FileUpload1" runat="server" />
                 <asp:Button ID="ButtonUpl" runat="server" onclick="Import_Click" Text="Загрузить" />
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
    </asp:Panel> 
  
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="150" StyleFolder="/Styles/Window/wdstyles/default" Title="ЗАПИСЬ" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
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
    
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="130" StyleFolder="/Styles/Window/wdstyles/default" Title="ОШИБКА" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" TextMode="MultiLine" Height="20" runat="server" 
                                ForeColor="Red" BorderStyle="None" BackColor="#cccccc" Font-Bold="true" Font-Size="Larger" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" style="width:60%; font-size:medium" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

           <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="MatWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="200" Top="50" Height="450" Width="1000" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Материалы">

       </owd:Window>

 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
 <%-- =================  источник  для ГРИДА============================================ 
	<asp:SqlDataSource ID="sdsDtl" runat="server">
         <UpdateParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
         </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
--%>    
<%-- =================  источник  для КАДРЫ ============================================ --%>
    	    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMol" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsAccOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
	        <asp:SqlDataSource ID="sdsDtl" runat="server"></asp:SqlDataSource>
		    
<%-- =================  прочие ============================================ --%>
    
       
</asp:Content>

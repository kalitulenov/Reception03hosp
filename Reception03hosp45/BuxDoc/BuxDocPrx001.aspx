<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxDocPrx001.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxDocPrx001" %>

<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>
<%-- ============================  стили ============================================ --%>
<style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
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
            //          alert("GridMatClose");
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);
            //  __doPostBack('btnSave', e.innerHTML);
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
             style="top: 0px; left: 10%; position: relative; width: 80%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 60px;">

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="№ док.:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                    <asp:TextBox ID="TxtDocNum" Width="50%" Height="20" runat="server" Style="font-weight: 700; font-size: medium; text-align: center" />
                    <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
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
                        AutoPostBack="true"
                        ID="BoxOrg"
                        Width="90%"
                        Height="200"
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
                   <obout:ComboBox runat="server"
                        AutoPostBack="true"
                        ID="BoxAcc"
                        Width="25%"
                        Height="200"
                        EmptyText="Выберите счет..."
                        DataSourceID="sdsAcc"
                        DataTextField="ACCKOD"
                        DataValueField="ACCKOD" />
                    <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="МОЛ:"></asp:Label>
                    <obout:ComboBox runat="server"
                        AutoPostBack="true"
                        ID="BoxMol"
                        Width="50%"
                        Height="200"
                        EmptyText="Выберите счет..."
                        DataSourceID="sdsMol"
                        DataTextField="MOLNAM"
                        DataValueField="MOLKOD" />
                </td>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label6" runat="server" align="center" Style="font-weight: bold;" Text="Счет-фактура:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 40%">
                    <asp:TextBox ID="TxtFkt" Width="50%" Height="20" runat="server" Style="font-weight: 700; font-size: medium; text-align: center" />
                    <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtFktDat" Width="80px" />
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
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 400px;"> 
  
 
	  <obout:Grid runat="server" 
                ID="GridMat" 
                Serialize="true" 
                AutoGenerateColumns="false" 
                FolderStyle="~/Styles/Grid/style_5" 
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowSorting="false"
	            Language = "ru"
	            CallbackMode="true"
                AllowPaging="false"
                AllowPageSizeSelection="false"
	            ShowColumnsFooter = "true"
	            Width="100%"
	            PageSize = "-1">
                 <ClientSideEvents 
		               OnBeforeClientEdit="GridMat_ClientEdit" 
		               OnBeforeClientAdd="GridMat_ClientInsert"
		               ExposeSender="true"/>
	    <ScrollingSettings ScrollHeight="310" />
	    <Columns>
            <obout:Column ID="Column00" DataField="DTLIDN" Visible="false" HeaderText="Идн" Width="0%" />
     		<obout:Column ID="Column01" DataField="DTLDEB" HeaderText="Счет" Align="right" Width="5%" />
            <obout:Column ID="Column02" DataField="MATNAM" HeaderText="Наименование" Width="30%" />
            <obout:Column ID="Column03" DataField="DTLKOL" HeaderText="Кол-во" Align="right"  Width="5%" DataFormatString="{0:F2}" />
  	        <obout:Column ID="Column04" DataField="DTLEDN" HeaderText="Ед.изм." Width="7%" />
            <obout:Column ID="Column05" DataField="DTLZEN" HeaderText="Цена" Align="right" Width="10%" DataFormatString="{0:F2}" />
            <obout:Column ID="Column06" DataField="NDC" HeaderText="НДС" Align="right" Width="5%" DataFormatString="{0:F2}" />
	        <obout:Column ID="Column07" DataField="DTLSUM" HeaderText="Сумма" Align="right" ReadOnly="true"  Width="10%" DataFormatString="{0:F2}" />
	        <obout:Column ID="Column08" DataField="GRPMATNAM" HeaderText="Мат.группа"  Width="10%" />
	        <obout:Column ID="Column09" DataField="DTLSRKSLB" HeaderText="Срок храниения" DataFormatString = "{0:dd/MM/yy}" Width="8%" />
         
               <obout:Column ID="Column10" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
		           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
		    </obout:Column>

	    </Columns>	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
       			<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridMat.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridMat.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridMat.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridMat.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridMat.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridMat.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridMat.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	

                </Templates>

	
    </obout:Grid>
 </asp:Panel>
 <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="PrvButton" runat="server" CommandName="Prv" Text="Проводить" onclick="PrvButton_Click"/>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 
  
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
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
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="PrvConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите проводить ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnPrvOK" Text="ОК" OnClick="btnPrvOK_click" />
                              <input type="button" value="Отмена" onclick="PrvConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
        
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
                            <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                            <asp:Button runat="server" ID="btnCancel" Text="Отмена" onclick="ConfirmDialog.Close();" />
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
     
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

           <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="MatWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="100" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Материалы">

       </owd:Window>

 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
	<asp:SqlDataSource ID="sdsDtl" runat="server"></asp:SqlDataSource>
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
		    
<%-- =================  прочие ============================================ --%>
    
       
</asp:Content>

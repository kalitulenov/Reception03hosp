<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="RefPrmOrd.aspx.cs" Inherits="Reception03hosp45.Referent.RefPrmOrd" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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
    </style>

    <script type="text/javascript">
        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
// когда получает фокус 01
        function Focused01(checkbox, iRowIndex) {
            alert("checkbox1=" + checkbox + "  iRowIndex=" + iRowIndex);
            if (checkbox == true) 
            {
 //               alert("checkbox2=" + checkbox + "  iRowIndex=" + iRowIndex);
                if (grid01.Rows[iRowIndex].Cells[6].Value == 'e') 
               {
                   alert("Записан через Интернет!");
                 }
                 else 
                 {
   //                alert("checkbox3=" + checkbox + "  iRowIndex=" + iRowIndex);
                   document.getElementById('par').value = iRowIndex;
                     document.getElementById('ctl00$MainContent$parPnl').value = "1";
                     document.getElementById('ctl00$MainContent$parUpd').value = "0";
                     var oRecord = new Object();
                     oRecord.GRFIDN = grid01.Rows[iRowIndex].Cells[0].Value;
                     ConfirmDialog.Open();
                 }
             }
             else
 //               alert("checkbox4=" + checkbox + "  iRowIndex=" + iRowIndex);
               if (document.getElementById('ctl00$MainContent$FndFio').value == "" ) 
                    alert("Клиент не указан 1 окно");
                else {
//                    alert("checkbox5=" + checkbox + "  iRowIndex=" + iRowIndex);
                    document.getElementById('par').value = iRowIndex;
                    document.getElementById('ctl00$MainContent$parPnl').value = "1";
                    document.getElementById('ctl00$MainContent$parUpd').value = "0";
                    var oRecord = new Object();
                    oRecord.GRFIDN = grid01.Rows[iRowIndex].Cells[0].Value;
                    oRecord.GRFBUS = true;
//                    ManyDialog.Open();
                    grid01.executeUpdate(oRecord);
                     }
            
        }
        // когда получает фокус 02
        function Focused02(checkbox, iRowIndex) {
            if (checkbox == true) {
                if (grid02.Rows[iRowIndex].Cells[6].Value == 'e') {
                    alert("Записан через Интернет!");
                }
                else {
                    document.getElementById('par').value = iRowIndex;
                    document.getElementById('ctl00$MainContent$parPnl').value = "2";
                    document.getElementById('ctl00$MainContent$parUpd').value = "0";
                    var oRecord = new Object();
                    oRecord.GRFIDN = grid02.Rows[iRowIndex].Cells[0].Value;
                    ConfirmDialog.Open();
                }
            }
            else
                if (document.getElementById('ctl00$MainContent$FndFio').value == "" && document.getElementById('ctl00$MainContent$FndIma').value == "")
                    alert("Клиент не указан 2 окно");
            else {
                document.getElementById('par').value = iRowIndex;
                document.getElementById('ctl00$MainContent$parPnl').value = "2";
                document.getElementById('ctl00$MainContent$parUpd').value = "0";
                var oRecord = new Object();
                oRecord.GRFIDN = grid02.Rows[iRowIndex].Cells[0].Value;
                oRecord.GRFBUS = true;
      //          ManyDialog.Open();
                grid02.executeUpdate(oRecord);
            }

        }

        // когда получает фокус 03
        function Focused03(checkbox, iRowIndex) {
            if (checkbox == true) {
                if (grid03.Rows[iRowIndex].Cells[6].Value == 'e') {
                    alert("Записан через Интернет!");
                }
                else {
                    document.getElementById('par').value = iRowIndex;
                    document.getElementById('ctl00$MainContent$parPnl').value = "3";
                    document.getElementById('ctl00$MainContent$parUpd').value = "0";
                    var oRecord = new Object();
                    oRecord.GRFIDN = grid03.Rows[iRowIndex].Cells[0].Value;
                    ConfirmDialog.Open();
                }
            }
            else
                if (document.getElementById('ctl00$MainContent$FndFio').value == "" && document.getElementById('ctl00$MainContent$FndIma').value == "")
                    alert("Клиент не указан 3 окно");
            else {
                document.getElementById('par').value = iRowIndex;
                document.getElementById('ctl00$MainContent$parPnl').value = "3";
                document.getElementById('ctl00$MainContent$parUpd').value = "0";
                var oRecord = new Object();
                oRecord.GRFIDN = grid03.Rows[iRowIndex].Cells[0].Value;
                oRecord.GRFBUS = true;
        //        ManyDialog.Open();
                grid03.executeUpdate(oRecord);
            }

        }
        
        // подтвердить снятие записи
        function OK_click() 
 		    {
 		        var Ind = document.getElementById('par').value;
 		        var Pnl = document.getElementById('ctl00$MainContent$parPnl').value;
 //		        var Kol = document.getElementById('ctl00$MainContent$ConfirmDialog_txtKolZapDel').value;
 //		        if (Kol == null || Kol == "") Kol = "0";

 		        var oRecord = new Object();
 		        document.getElementById('ctl00$MainContent$parUpd').value = "0";
// 		        document.getElementById('ctl00$MainContent$parKol').value = Kol;
 		        
 		        oRecord.GRFBUS = false;
 		        if (Pnl == "1") {
 		            oRecord.GRFIDN = grid01.Rows[Ind].Cells[0].Value;
 		            grid01.executeUpdate(oRecord);
 		        }
 		        if (Pnl == "2") {
 		            oRecord.GRFIDN = grid02.Rows[Ind].Cells[0].Value;
 		            grid02.executeUpdate(oRecord);
 		        }
 		        if (Pnl == "3") {
 		            oRecord.GRFIDN = grid03.Rows[Ind].Cells[0].Value;
 		            grid03.executeUpdate(oRecord);
 		        }
 		    }

 		    // отказ от запись
 		    function Cancel_click() {
 //		        alert("OCancel_click1:Ind=" + document.getElementById('par').value + " Pnl=" + document.getElementById('ctl00$MainContent$parPnl').value);
 		        var Ind = document.getElementById('par').value;
 		        var Pnl = document.getElementById('ctl00$MainContent$parPnl').value;
 		        var oRecord = new Object();
 		        document.getElementById('ctl00$MainContent$parUpd').value = "1";
 		        oRecord.GRFBUS = true;
 		        
 		        if (Pnl == "1") {
 		            oRecord.GRFIDN = grid01.Rows[Ind].Cells[0].Value;
 		            grid01.executeUpdate(oRecord);
 		        }
 		        if (Pnl == "2") {
 		            oRecord.GRFIDN = grid02.Rows[Ind].Cells[0].Value;
 		            grid02.executeUpdate(oRecord);
 		        }
 		        if (Pnl == "3") {
 		            oRecord.GRFIDN = grid03.Rows[Ind].Cells[0].Value;
 		            grid03.executeUpdate(oRecord);
 		        }
 		        ConfirmDialog.Close();
 		    }

 		    function OnClientDblClick(iRecordIndex) {
 		        myWindow.Close();
 		        document.getElementById('ctl00$MainContent$ButHid').click(); // нажитие скрытой кнопки для POSTBACK
 		        //		        $("#ButHid").mouseup();
 		        // 		        $("#ButHid").triggerHandler('click');
 		    }

 		    function clearfilter() {
 		        document.getElementById('ctl00$MainContent$FndFio').value = '';
 	//	        document.getElementById('ctl00$MainContent$FndIma').value = '';
 		        document.getElementById('ctl00$MainContent$FndBrt').value = '';
 		        document.getElementById('ctl00$MainContent$FndKrt').value = '';
 		        document.getElementById('ctl00$MainContent$FndFrm').value = '';
 		        document.getElementById('ctl00$MainContent$FndTel').value = '';
 //		        document.getElementById('ctl00$MainContent$FndEml').value = '';
 		        return false;
 		    }

 		    // нажата ПОИСК
 		    function FndBtn_click() {
 		        document.getElementById('ctl00$MainContent$parBtn').value = "OK";
 		        myWindow.Open();
 		    }
 		    //==============================================================================================
 		    //================================================================================================== 		    
 		    
    </script>

    <asp:SqlDataSource runat="server" ID="SdsDoc001" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsDoc002" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsDoc003" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio001" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio002" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio003" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  для хранения переменных -----------------------------------------------  -->
     <%-- ============================  для передач значении  ============================================ --%>
    <input type="hidden" name="Index" id="par" />
    <asp:HiddenField ID="parPnl" runat="server" />
    <asp:HiddenField ID="parUpd" runat="server" />
    <asp:HiddenField ID="parKol" runat="server" />
    <asp:HiddenField ID="parBtn" runat="server" />
    <%-- ============================  для передач значении  ============================================ --%>
   <!--  конец -----------------------------------------------  -->

    <div>
        <asp:TextBox ID="Sapka"
            Text=""
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>

       <table border="1" cellspacing="0" width="100%" cellpadding="0">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="ButHid"
                                    runat="server"
                                    OnClick="ButHid_Click"
                                    Visible="true" Text="Б"
                                    Width="5px" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td>
                                <asp:Button ID="ButClr" runat="server"
                                    OnClientClick="clearfilter()"
                                    Width="70px" CommandName="" CommandArgument=""
                                    Text="Очистить" Height="25px"
                                    Style="position: relative; top: 0px; left: -30px" />
                            </td>
                            <td class="PO_RowCap" align="left">Фамилия И.О:</td>
                            <td>
                                <asp:TextBox ID="FndFio" Width="120" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Д/р:</td>
                            <td>
                                <asp:TextBox ID="FndBrt" Width="80" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">№карты:</td>
                            <td>
                                <asp:TextBox ID="FndKrt" Width="80" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Фирма:</td>
                            <td>
                                <asp:TextBox ID="FndFrm" Width="120" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Тел:</td>
                            <td>
                                <asp:TextBox ID="FndTel" Width="80" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Адрес:</td>
                            <td>
                                <asp:TextBox ID="FndAdr" Width="120" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td>
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClientClick="FndBtn_click()"
                                    Width="70px" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:TextBox ID="TextBoxDoc"
            Text=""
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="8px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: -3px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>

        <asp:Panel ID="Panel01" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px; left: 0px; position: relative; top: -5px; width: 33%; height: 580px;">

            <obout:ComboBox runat="server" ID="BoxDoc001" Width="78%" Height="200"
                FolderStyle="/Styles/Combobox/premiere_blue"
                OnSelectedIndexChanged="BoxDoc001_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc001" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst001" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst001_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio001" Width="78%" Height="200"
                OnSelectedIndexChanged="BoxFio001_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio001" DataTextField="FIO" DataValueField="BUXKOD" />

            <obout:Grid ID="grid01" runat="server"
                CallbackMode="false"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                ShowColumnsFooter = "false"
                AllowPaging="false"
                ShowLoadingMessage="false"
                AllowColumnResizing="true"
                AllowSorting="false"
                AllowRecordSelection="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column11" DataField="GRFIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column ID="Column12" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column13" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="50" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column14" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="50" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column15" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column16" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus01" />
                    </obout:Column>
                    <obout:Column ID="Column17" DataField="GRFWWW" HeaderText="  e" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column18" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column19" DataField="GRFTEL" HeaderText="Телефон" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column20" DataField="GRFEML" HeaderText="Email" ReadOnly="true" Width="120" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus01">
                        <Template>
                          <input type="checkbox" onfocus="Focused01(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

        <asp:Panel ID="Panel02" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 33%; position: relative; top: -590px; width: 33%; height: 580px;">
            <obout:ComboBox runat="server" ID="BoxDoc002" Width="78%" Height="200"
                FolderStyle="/Styles/Combobox/premiere_blue"
                OnSelectedIndexChanged="BoxDoc002_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc002" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst002" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst002_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio002" Width="78%" Height="200"
                OnSelectedIndexChanged="BoxFio002_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio002" DataTextField="FIO" DataValueField="BUXKOD" />

            <obout:Grid ID="grid02" runat="server"
                CallbackMode="false"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                ShowColumnsFooter = "false"
                AllowPaging="false"
                ShowLoadingMessage="false"
                AllowColumnResizing="true"
                AllowSorting="false"
                AllowRecordSelection="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column21" DataField="GRFIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column ID="Column22" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column23" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="50" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column24" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="50" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column25" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column26" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus02" />
                    </obout:Column>
                    <obout:Column ID="Column27" DataField="GRFWWW" HeaderText="  e" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column28" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column29" DataField="GRFTEL" HeaderText="Телефон" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column30" DataField="GRFEML" HeaderText="Email" ReadOnly="true" Width="120" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus02">
                        <Template>
                            <input type="checkbox" onfocus="Focused02(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

        <asp:Panel ID="Panel03" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 66%; position: relative; top: -1175px; width: 33%; height: 580px;">

            <obout:ComboBox runat="server" ID="BoxDoc003" Width="78%" Height="200"
                FolderStyle="/Styles/Combobox/premiere_blue"
                OnSelectedIndexChanged="BoxDoc003_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc003" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst003" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst003_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio003" Width="78%" Height="200"
                OnSelectedIndexChanged="BoxFio003_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio003" DataTextField="FIO" DataValueField="BUXKOD" />

            <obout:Grid ID="grid03" runat="server"
                CallbackMode="false"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                ShowColumnsFooter = "false"
                AllowPaging="false"
                ShowLoadingMessage="false"
                AllowColumnResizing="true"
                AllowSorting="false"
                AllowRecordSelection="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column31" DataField="GRFIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column ID="Column32" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column33" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="50" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column34" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="50" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column35" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column36" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus03" />
                    </obout:Column>
                    <obout:Column ID="Column37" DataField="GRFWWW" HeaderText="  e" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column38" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column39" DataField="GRFTEL" HeaderText="Телефон" ReadOnly="true" Width="100" />
                    <obout:Column ID="Column40" DataField="GRFEML" HeaderText="Email" ReadOnly="true" Width="120" />
               </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus03">
                        <Template>
                            <input type="checkbox" onfocus="Focused03(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>
        <%-- =================  запчасти
            <asp:Button ID="ButPrt001" runat="server" Width="80px" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt001_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />

            <asp:Button ID="ButPrt002" runat="server" Width="80px" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt002_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />
            <asp:Button ID="ButPrt003" runat="server" Width="80px" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt003_Click" Height="20px"
                Style="position: relative; top: 0px; left: 0px" />
          ============================================ --%>
        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialog" runat="server" Visible="true" VisibleOnLoad="false" 
                    IsModal="true" Position="CUSTOM" Top="300" Left="600" Width="300" 
                    Height="180" StyleFolder="/Styles/Window/wdstyles/default" 
                    Title="Снять клиента с записи" zIndex="10" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите снять запись ? </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <asp:Button runat="server" ID="OK" Text="ОК" OnClientClick="OK_click()"  />
                              <input type="button" value="Отмена" onclick="Cancel_click()" />
                        </td>
                    </tr>
                </table> 
            </center>
        </owd:Dialog>
      
      <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
        <owd:Window ID="myWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="200" Top="100" Height="460" Width="920" Visible="true" VisibleOnLoad="false" StyleFolder="/Styles/Window/wdstyles/blue"
            Title="Поиcк клиента">
            <obout:Grid ID="grid2"
                runat="server"
                CallbackMode="true"
                Serialize="true"
                AutoGenerateColumns="false"
                FolderStyle="~/Styles/Grid/style_5"
                AllowAddingRecords="false"
                ShowLoadingMessage="true"
                ShowColumnsFooter="false"
                PageSize="-1"
                ShowFooter="false">
                <ClientSideEvents OnClientDblClick="OnClientDblClick" />
                <Columns>
                    <obout:Column DataField="KLTIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column DataField="KLTFAM" HeaderText="Фамилия" Width="120" />
                    <obout:Column DataField="KLTIMA" HeaderText="Имя" Width="120" />
                    <obout:Column DataField="KLTKRT" HeaderText="Карта" Width="120" />
                    <obout:Column DataField="KLTFRMTXT" HeaderText="Фирма" Width="120" />
                    <obout:Column DataField="KLTTHN" HeaderText="Телефон" Width="120" />
                    <obout:Column DataField="KLTEML" HeaderText="Адрес" Width="120" />
                    <obout:Column DataField="KLTBRT" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Дата рож" Width="150" />
                </Columns>
                <ScrollingSettings ScrollHeight="460" ScrollWidth="920" />
            </obout:Grid>
        </owd:Window>

    </div>

</asp:Content>


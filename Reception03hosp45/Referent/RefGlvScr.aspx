<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="RefGlvScr.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlvScr" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <!--  ссылка на JQUERY DATEPICKER-------------------------------------------------------------- -->
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
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }

		
    </style>



    <%-- ============================  для передач значении  ============================================ --%>
    <input type="hidden" name="Index" id="par" />
    <asp:HiddenField ID="parPnl" runat="server" />
    <asp:HiddenField ID="parUpd" runat="server" />
    <%-- ============================  для передач значении  ============================================ --%>
    <script type="text/javascript">

        // ------------------------  соглашения на ввод информаций о себе при записи к врачу из диалогового окна  ------------------------------------------------------------------
        function onchanged01(checkbox, iRowIndex) 
        {
 //           alert("checkbox1="+checkbox);
            document.getElementById('par').value = iRowIndex;
            document.getElementById('ctl00$MainContent$parPnl').value = "1";
            document.getElementById('ctl00$MainContent$parUpd').value = "0";
            var oRecord = new Object();
            oRecord.GRFIDN = grid01.Rows[iRowIndex].Cells[0].Value;
            oRecord.GRFWWW = grid01.Rows[iRowIndex].Cells[6].Value;
            oRecord.GRFBUS = grid01.Rows[iRowIndex].Cells[5].Value;

            if (checkbox == false) {
                if (document.getElementById('ctl00$MainContent$FndFio').value == "") {
                    checkbox == true;
                    alert("Клиент не указан ");
                }
                else {
                      oRecord.GRFBUS = true;
                      OK_update();
               }

            }
            else {
                if (oRecord.GRFWWW == '@') {
                    alert("Записан через Интернет!");
                }
                else {
                    ConfirmDialog.Open();
                    return;
                }
           }
        }

        function onchanged02(checkbox, iRowIndex) 
        {
  //                    alert("checkbox2="+checkbox);
            document.getElementById('par').value = iRowIndex;
            document.getElementById('ctl00$MainContent$parPnl').value = "2";
            document.getElementById('ctl00$MainContent$parUpd').value = "0";
            var oRecord = new Object();
            oRecord.GRFIDN = grid02.Rows[iRowIndex].Cells[0].Value;
            oRecord.GRFWWW = grid02.Rows[iRowIndex].Cells[6].Value;
            oRecord.GRFBUS = grid02.Rows[iRowIndex].Cells[5].Value;

            if (checkbox == false) {
                if (document.getElementById('ctl00$MainContent$FndFio').value == "") {
                    checkbox == true;
                    alert("Клиент не указан ");
                }
                else {
                    oRecord.GRFBUS = true;
                    OK_update();
                }

            }
            else {
                if (oRecord.GRFWWW == '@') {
                    alert("Записан через Интернет!");
                }
                else {
                    ConfirmDialog.Open();
                    return;
                }
            }
        }



        function onchanged03(checkbox, iRowIndex) 
        {
   //                   alert("checkbox3="+checkbox);
            document.getElementById('par').value = iRowIndex;
            document.getElementById('ctl00$MainContent$parPnl').value = "3";
            document.getElementById('ctl00$MainContent$parUpd').value = "0";
            var oRecord = new Object();
            oRecord.GRFIDN = grid03.Rows[iRowIndex].Cells[0].Value;
            oRecord.GRFWWW = grid03.Rows[iRowIndex].Cells[6].Value;
            oRecord.GRFBUS = grid03.Rows[iRowIndex].Cells[5].Value;

            if (checkbox == false) {
                if (document.getElementById('ctl00$MainContent$FndFio').value == "") {
                    checkbox == true;
                    alert("Клиент не указан ");
                }
                else {
                    oRecord.GRFBUS = true;
                    OK_update();
                }

            }
            else {
                if (oRecord.GRFWWW == '@') {
                    alert("Записан через Интернет!");
                }
                else {
                    ConfirmDialog.Open();
                    return;
                }
            }
        }

 	 
        
        function OK_click() 
 		    {
 	//	        alert("OK_click=");

 		        var Ind = document.getElementById('par').value;
 		        var Pnl = document.getElementById('ctl00$MainContent$parPnl').value;

 		        var oRecord = new Object();
 		        oRecord.GRFPTH = document.getElementById('ctl00$MainContent$FndFio').value;
 		        oRecord.GRFTEL = document.getElementById('ctl00$MainContent$FndTel').value;
 		        oRecord.GRFADR = document.getElementById('ctl00$MainContent$FndAdr').value;
 		        oRecord.GRFPOL = document.getElementById('ctl00$MainContent$FndKrt').value;
 		        oRecord.GRFFRM = document.getElementById('ctl00$MainContent$FndFrm').value;
 		        oRecord.GRFBRT = document.getElementById('ctl00$MainContent$FndBrt').value;
 		        oRecord.GRFBUS = true;
 	//	        alert("oRecord.GRFPTH="+ oRecord.GRFPTH);
 		        
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

 		    function Cancel_click() {
 		        var Ind = document.getElementById('par').value;
 		        var Pnl = document.getElementById('ctl00$MainContent$parPnl').value;
 		        var oRecord = new Object();
 		        document.getElementById('ctl00$MainContent$parUpd').value = "1";
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
 		        document.getElementById('ctl00$MainContent$FndIma').value = '';
 		        document.getElementById('ctl00$MainContent$FndBrt').value = '';
 		        document.getElementById('ctl00$MainContent$FndKrt').value = '';
 		        document.getElementById('ctl00$MainContent$FndFrm').value = '';
 		        document.getElementById('ctl00$MainContent$FndTel').value = '';
 		        document.getElementById('ctl00$MainContent$FndAdr').value = '';
 		        return false;
 		    }
 		    //==============================================================================================
 		    //================================================================================================== 		    
 		    
    </script>

    <asp:SqlDataSource runat="server" ID="SdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsFio" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsKlt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для хранения переменных -----------------------------------------------  -->
    <!--  для хранения переменных -----------------------------------------------  -->
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
                            <td class="PO_RowCap" align="left">Фамилия:</td>
                            <td>
                                <asp:TextBox ID="FndFio" Width="120" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Имя:</td>
                            <td>
                                <asp:TextBox ID="FndIma" Width="80" Height="20" runat="server"
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
                            <td class="PO_RowCap" align="right">Компания:</td>
                            <td>
                                <asp:TextBox ID="FndFrm" Width="120" Height="20" runat="server"
                                    Style="font-weight: 700; font-size: small;" />
                            </td>
                            <td class="PO_RowCap" align="right">Телефон:</td>
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
                                    OnClientClick="myWindow.Open()"
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
            Font-Size="4px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: -3px; left: 0px; position: relative; width: 100%"
            runat="server"></asp:TextBox>
            
        <asp:Panel ID="Panel01" runat="server" ScrollBars="Both" Style="border-style: double; 
                   left: 1%; position: relative; top: -5px; width: 32%; height: 580px;">

            <obout:ComboBox runat="server" ID="BoxDoc001" Width="77%" Height="200"
                FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxDoc001_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst001" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst001_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio001" Width="77%" Height="200"
                FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxFio001_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio" DataTextField="FIO" DataValueField="BUXKOD" />

            <asp:Button ID="ButPrt001" runat="server" Width="20%" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt001_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:Grid ID="grid01" runat="server"
                CallbackMode="false"
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
                AllowPaging="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column100" DataField="GRFIDN" HeaderText="Идн" Visible="true" Width="70" />
                    <obout:Column ID="Column101" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column102" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="40" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column103" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="40" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column104" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="70" />
                    <obout:Column ID="Column105" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus01" />
                    </obout:Column>
                    <obout:Column ID="Column106" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column107" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column108" DataField="BRTGOD" HeaderText="Год.р" ReadOnly="true" Width="40" />
                    <obout:Column ID="Column109" DataField="ORGNAM" HeaderText="Фирма" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column110" DataField="GRFPOL" HeaderText="Карта" ReadOnly="true" Width="80" />
               </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus01">
                        <Template>
                            <input type="checkbox" onmousedown="onchanged01(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                       </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

        <asp:Panel ID="Panel02" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 34%; position: relative; top: -590px; width: 32%; height: 580px;">

            <obout:ComboBox runat="server" ID="BoxDoc002" Width="77%" Height="200"
               FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxDoc002_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst002" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst002_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio002" Width="77%" Height="200"
                FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxFio002_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio" DataTextField="FIO" DataValueField="BUXKOD" />

            <asp:Button ID="ButPrt002" runat="server" Width="20%" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt002_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:Grid ID="grid02" runat="server"
                CallbackMode="false"
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
                AllowPaging="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column200" DataField="GRFIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column ID="Column201" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column202" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="40" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column203" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="40" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column204" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="70" />
                    <obout:Column ID="Column205" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus02" />
                    </obout:Column>
                    <obout:Column ID="Column206" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column207" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column208" DataField="BRTGOD" HeaderText="Год.р" ReadOnly="true" Width="40" />
                    <obout:Column ID="Column209" DataField="GRFCMP" HeaderText="Фирма" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column210" DataField="GRFPOL" HeaderText="Карта" ReadOnly="true" Width="80" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus02">
                        <Template>
                            <input type="checkbox" onmousedown="onchanged02(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

        <asp:Panel ID="Panel03" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 67%; position: relative; top: -1175px; width: 32%; height: 580px;">

            <obout:ComboBox runat="server" ID="BoxDoc003" Width="77%" Height="200"
               FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxDoc003_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsDoc" DataTextField="DLGNAM" DataValueField="BuxDlg" />

            <asp:Button ID="ButPst003" runat="server" Width="20%" CommandName="Cancel"
                Text="Обновить" OnClick="ButPst003_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:ComboBox runat="server" ID="BoxFio003" Width="77%" Height="200"
                FolderStyle="/Styles/Combobox/Plain"
                OnSelectedIndexChanged="BoxFio003_OnSelectedIndexChanged" AutoPostBack="true"
                DataSourceID="SdsFio" DataTextField="FIO" DataValueField="BUXKOD" />

            <asp:Button ID="ButPrt003" runat="server" Width="20%" CommandName="Cancel"
                Text="Печать" OnClick="ButPrt003_Click" Height="30px"
                Style="position: relative; top: 0px; left: 0px" />

            <obout:Grid ID="grid03" runat="server"
                CallbackMode="false"
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
                AllowPaging="false"
                AllowFiltering="false">
                <Columns>
                    <obout:Column ID="Column300" DataField="GRFIDN" HeaderText="Идн" Visible="false" />
                    <obout:Column ID="Column301" DataField="GRFKOD" HeaderText="Код" Visible="false" />
                    <obout:Column ID="Column302" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="40" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column303" DataField="GRFBEG" HeaderText="Время" ReadOnly="true" Width="40" DataFormatString="{0:hh:mm}" />
                    <obout:Column ID="Column304" DataField="FI" HeaderText="Врач" ReadOnly="true" Width="70" />
                    <obout:Column ID="Column305" DataField="GRFBUS" HeaderText="Занят" Width="30">
                        <TemplateSettings TemplateId="tplBus03" />
                    </obout:Column>
                    <obout:Column ID="Column306" DataField="GRFWWW" HeaderText="@" ReadOnly="true" Width="30" />
                    <obout:Column ID="Column307" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column308" DataField="BRTGOD" HeaderText="Год.р" ReadOnly="true" Width="40" />
                    <obout:Column ID="Column309" DataField="GRFCMP" HeaderText="Фирма" ReadOnly="true" Width="150" />
                    <obout:Column ID="Column310" DataField="GRFPOL" HeaderText="Карта" ReadOnly="true" Width="80" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="tplBus03">
                        <Template>
                            <input type="checkbox" onmousedown="onchanged03(this.checked, <%# Container.PageRecordIndex %>)" <%# Container.Value == "True" ? "checked='checked'" : "" %> />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialog" runat="server" Visible="true" VisibleOnLoad="false" IsModal="true" Position="CUSTOM" Top="200" Left="600" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите снять прием ?</td>
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
                    <obout:Column DataField="KLTADR" HeaderText="Адрес" Width="120" />
                    <obout:Column DataField="KLTBRT" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Дата рож" Width="150" />
                </Columns>
                <ScrollingSettings ScrollHeight="460" ScrollWidth="920" />
            </obout:Grid>
        </owd:Window>

    </div>

</asp:Content>


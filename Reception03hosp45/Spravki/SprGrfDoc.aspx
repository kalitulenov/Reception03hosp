<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="SprGrfDoc.aspx.cs" Inherits="Reception03hosp45.Spravki.SprGrfDoc" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>


<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!--  ссылка на JQUERY DATEPICKER-------------------------------------------------------------- -->

    <link href="/Styles/DatePicker/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />

    <script src="/Scripts/DatePicker/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="/Scripts/DatePicker/ui/jquery.ui.core.js" type="text/javascript"></script>
    <script src="/Scripts/DatePicker/ui/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/Scripts/DatePicker/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
    <script src="/Scripts/DatePicker/DatePickerRus.js" type="text/javascript"></script>
    <!-- для диалога -------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


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
    </style>

        <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
        function PrtButton_Click() {
            var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprBuxGrf&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprBuxGrf&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

    </script>	

    <!--  конец -----------------------------------------------  -->
    <%-- =================  диалоговое окно для подтверждения записи докуумента  
  
  
  
  ============================================ --%>
         <asp:HiddenField ID="parBuxFrm" runat="server" />


      <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">

    
        <asp:TextBox ID="Sapka"
            Text="                                                                          График врачей"
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 0px; position: relative; width: 99%"
            runat="server"></asp:TextBox>

        <asp:Panel ID="PanelLeft" runat="server" ScrollBars="Both" Style="border-style: double; left: 10px; left: 0px; 
                                  position: relative; top: 0px; width: 30%; height: 500px;">
            <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

            <obout:Tree ID="OboutTree" 
                     runat="server" 
                     ClientObjectID="_OboutTree" 
                     EnableTheming="True" 
                     NodeDropTargets="" 
                     OnTreeNodeExpanded="OboutTree_TreeNodeExpanded"
                     CssClass = "vista"
                     OnSelectedTreeNodeChanged="OboutTree_SelectedTreeNodeChanged"
                     Height="100%" 
                     Width="100%" 
                     EnableViewState="true">
                </obout:Tree>
  
        </asp:Panel>

        <asp:Panel ID="PanelRight" runat="server" BorderStyle="Double" ScrollBars="Both"
            Style="left: 31%; position: relative; top: -505px; width: 69%; height: 500px;">

          <asp:TextBox ID="TextBoxDoc"
                Text=""
                BackColor="#0099FF"
                Font-Names="Verdana"
                Font-Size="17px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

            <table border="0" cellspacing="0" width="100%">
                <tr>

                    <td width="25%" class="PO_RowCap">
                        <asp:Button ID="Button01" runat="server" Width="70%" CommandName="Cancel"
                            Text="Генерация" OnClick="CompOne_Click" Height="27px" Enabled="false"
                            Style="position: relative; top: 0px; left: 0px" />

                    </td>

                    <td width="50%" class="PO_RowCap">
                        <asp:Label ID="Label1" runat="server" Text="Период"></asp:Label>

                        <asp:TextBox runat="server" ID="txtDate1" Width="80px" BackColor="#FFFFE0" />

                        <obout:Calendar ID="cal1" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="txtDate1"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                        <asp:TextBox runat="server" ID="txtDate2" Width="80px" BackColor="#FFFFE0" />
                        <obout:Calendar ID="cal2" runat="server"
                            StyleFolder="/Styles/Calendar/styles/default"
                            DatePickerMode="true"
                            ShowYearSelector="true"
                            YearSelectorType="DropDownList"
                            TitleText="Выберите год: "
                            CultureName="ru-RU"
                            TextBoxId="txtDate2"
                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                    </td>


                    <td width="20%" class="PO_RowCap">
                        <input type="button" name="PrtButton" style="width: 100%; height: 28px;" value="Печать справочника" id="PrtButton" onclick="PrtButton_Click();" />
                    </td>
                </tr>
            </table>

        <%-- =================  DataFormatString="{0:HH:mm}" где HH 24-формат, hh-12-формат  ============================================ --%>
            <obout:Grid ID="GridGrf" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="20"
                EnableTypeValidation="false"
                AllowRecordSelection="true"
                AllowFiltering="false"
                AllowPageSizeSelection="false"
                AllowPaging="false"
                Width="100%" 
                ShowFooter="true">
                <Columns>
                    <obout:Column ID="Column00" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column01" DataField="NEDKOD" HeaderText="Дни недели" Width="14%" >
                          <TemplateSettings TemplateId="TemplateNedNam" EditTemplateId="TemplateEditNedNam" />
                    </obout:Column>
                    <obout:Column ID="Column02" DataField="TIMBEG" HeaderText="Начало" Width="8%" >
                          <TemplateSettings TemplateId="TemplateBegNam" EditTemplateId="TemplateEditBegNam" />
                    </obout:Column>
                    <obout:Column ID="Column03" DataField="TIMEND" HeaderText="Конец" Width="8%" >
                           <TemplateSettings TemplateId="TemplateEndNam" EditTemplateId="TemplateEditEndNam" />
                    </obout:Column>
                    <obout:Column ID="Column04" DataField="GRFHUR" HeaderText="Час" ReadOnly="true" Width="5%" />
                    <obout:Column ID="Column05" DataField="GRFDLT" HeaderText="Длит." Width="5%" />
                    <obout:Column ID="Column06" DataField="GRFCAB" HeaderText="Кабинет" Width="10%" >
                           <TemplateSettings TemplateId="TemplateCabNam" EditTemplateId="TemplateEditCabNam" />
                    </obout:Column>

                    <obout:Column ID="Column07" DataField="TIMBEGNON" HeaderText="Обед нач" Width="8%" >
                          <TemplateSettings TemplateId="TemplateBegNamNon" EditTemplateId="TemplateEditBegNamNon" />
                    </obout:Column>
                    <obout:Column ID="Column08" DataField="TIMENDNON" HeaderText="Обед кон" Width="8%" >
                           <TemplateSettings TemplateId="TemplateEndNamNon" EditTemplateId="TemplateEditEndNamNon" />
                    </obout:Column>
                    <obout:Column ID="Column09" DataField="GRFHURNON" HeaderText="Час" ReadOnly="true" Width="4%" />

                    <obout:Column ID="Column10" DataField="GRFWWW" HeaderText="WWW" Width="10%">
                        <TemplateSettings TemplateId="TemplateWww" EditTemplateId="TemplateEditWww" />
                    </obout:Column>
                    <obout:Column ID="Column11" DataField="GRFFLG" HeaderText="Генер" Width="10%">
                        <TemplateSettings TemplateId="TemplateGnr" EditTemplateId="TemplateEditGnr" />
                    </obout:Column>
                     <obout:Column ID="Column12" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="TemplateNedNam">
                        <Template>
                            <%# Container.DataItem["NEDNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditNedNam" ControlID="ddlNedNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlNedNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsNed"  CssClass="ob_gEC" DataTextField="NEDNAM" DataValueField="NEDKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateBegNam">
                        <Template>
                            <%# Container.DataItem["TIMBEG"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditBegNam" ControlID="ddlBegNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlBegNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTimBeg"  CssClass="ob_gEC" DataTextField="TIMBEG" DataValueField="TIMBEG">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEndNam">
                        <Template>
                            <%# Container.DataItem["TIMEND"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditEndNam" ControlID="ddlEndNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlEndNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTimEnd"  CssClass="ob_gEC" DataTextField="TIMEND" DataValueField="TIMEND">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateBegNamNon">
                        <Template>
                            <%# Container.DataItem["TIMBEGNON"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditBegNamNon" ControlID="ddlBegNamNon" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlBegNamNon" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTimBegNon"  CssClass="ob_gEC" DataTextField="TIMBEGNON" DataValueField="TIMBEGNON">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEndNamNon">
                        <Template>
                            <%# Container.DataItem["TIMENDNON"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditEndNamNon" ControlID="ddlEndNamNon" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlEndNamNon" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsTimEndNon"  CssClass="ob_gEC" DataTextField="TIMENDNON" DataValueField="TIMENDNON">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateCabNam">
                        <Template>
                            <%# Container.DataItem["CABNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditCabNam" ControlID="ddlCabNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlCabNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsCab"  CssClass="ob_gEC" DataTextField="CABNAM" DataValueField="CABKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateGnr" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditGnr" ControlID="chkGnr" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkGnr" />
                        </Template>
                    </obout:GridTemplate>
                    
                    <obout:GridTemplate runat="server" ID="TemplateWww" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditWww" ControlID="chkWww" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkWww" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>

            </obout:Grid>
            <br/>
            
 
            </asp:Panel>
         </asp:Panel> 

        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
        <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Position="CUSTOM" Top="200" Left="600" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите сгенерировать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>
        </owd:Dialog>


    <asp:SqlDataSource runat="server" ID="sdsNed" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsCab" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsTimBeg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsTimEnd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsTimBegNon" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsTimEndNon" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

</asp:Content>


<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />
    
    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


       <%-- ============================  STYLES ============================================ --%>

    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        /*   For multiline textbox control:  */
        .ob_iTaMC textarea {
            font-size: 14px !important;
            font-family: Arial !important;
        }

        /*   For oboutButton Control: color: #0000FF !important; */

        .ob_iBC {
            font-size: 12px !important;
        }

        /*  For oboutTextBox Control: */

        .ob_iTIE {
            font-size: 12px !important;
        }

        /*------------------------- для checkbox  --------------------------------*/
        .excel-checkbox {
            height: 20px;
            line-height: 20px;
        }

        .tdText {
            font: 11px Verdana;
            color: #333333;
        }

        .option2 {
            font: 11px Verdana;
            color: #0033cc;
            background-color: #f6f9fc;
            padding-left: 4px;
            padding-right: 4px;
        }

        a {
            font: 11px Verdana;
            color: #315686;
            text-decoration: underline;
        }

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>
        <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        /*------------------------- при нажатии на поле бит --------------------------------*/
        function persistFieldValue(field) {
            var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
            var DatDocRek = 'HSPUSLALL';
            var DatDocTyp = 'Bit';
            var DatDocIdn;

            if (focusedGrid != null && focusedGrid._lastEditedField != null) {
                if (typeof (focusedGrid._lastEditedFieldEditor.value) == 'function') {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.value();
                } else {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.checked() ? ' +' : ' ';
                }
                document.getElementById('FieldEditorsContainer').appendChild(document.getElementById(focusedGrid._lastEditedFieldEditor.ID + 'Container'));
                focusedGrid._lastEditedField.style.display = '';

                focusedGrid._lastEditedField = null;
                focusedGrid._lastEditedFieldEditor = null;

                DatDocIdn = parDocIdn.value;
                onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
            }
        }


        // -------изменение как EXCEL-------------------------------------------------------------------          
        function markAsFocused(textbox) {
            textbox.className = 'excel-textbox-focused';
        }

        /*------------------------- при нажатии на поле текст --------------------------------*/
        function markAsBlured(textbox, dataField, rowIndex) {
            var DatDocIdn;
            var DatDocRek;
            var DatDocVal;
            var DatDocTyp = 'Int';

 //           alert(textbox + '  -  ' + dataField + '  -  ' + rowIndex);
            textbox.className = 'excel-textbox';

            GridUsl.Rows[rowIndex].Cells[dataField].Value = textbox.value;

            DatDocRek = dataField;
            DatDocIdn = GridUsl.Rows[rowIndex].Cells['HSPUSLIDN'].Value;
            DatDocVal = textbox.value;
            if (DatDocVal == null || DatDocVal == "") DatDocVal = "0";

            onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
            parDocIdn.value = GridUsl.Rows[rowIndex].Cells['HSPUSLIDN'].Value;
            //            alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

        }

        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'SPRORGHSPUSL';
            var DatDocKey = 'HSPUSLIDN';

            //     var DatDocRek = GrfDocRek;
            //     var DatDocVal = GrfDocVal;
            //     var DatDocTyp = GrfDocTyp;
            //      var DatDocIdn;


            //            alert("onChange=" + DatDocMdb + ' ' + DatDocTab + ' ' + DatDocKey + ' ' + DatDocIdn + ' ' + DatDocRek + ' ' + DatDocVal + ' ' + DatDocTyp);

 //                   alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
            switch (DatDocTyp) {
                case 'Sql':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                case 'Str':
                    DatDocTyp = 'Str';
                    SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                    break;
                case 'Dat':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                case 'Int':
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
                default:
                    DatDocTyp = 'Sql';
                    SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                    break;
            }
//                      alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
        }

    </script>


</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string BuxKod;
    string BuxFrm;
    int ItgSum = 0;

    string GlvOrgKod;
    string GlvPrcKey;
    string ComParKey = "";
    string ComParTxt = "";

    string ParKey = "";
    bool VisibleNo = false;
    bool VisibleYes = true;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

       //=====================================================================================
       GlvPrcKey = Convert.ToString(Request.QueryString["NodKey"]);
       GlvOrgKod = Convert.ToString(Request.QueryString["OrgKod"]);
        
       BuxFrm = (string)Session["BuxFrmKod"];
       BuxKod = (string)Session["BuxKod"];
       //=====================================================================================

        if (!Page.IsPostBack)
        {
             LoadGridNode();

        }
       
    }


    //=============Заполнение массива первыми тремя уровнями===========================================================================================
    protected void LoadGridNode()
    {

        //        DataSet ds = new DataSet("Menu");
        //        ds.Merge(InsSprCntUsl(MdbNam, BuxFrm, BuxKod, GlvOrgKod));
        

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprOrgHspUsl", con);
            cmd = new SqlCommand("HspSprOrgHspUsl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@ORGKOD", SqlDbType.VarChar).Value = GlvOrgKod;
            cmd.Parameters.Add("@PRCKEY", SqlDbType.VarChar).Value = GlvPrcKey;
            // ------------------------------------------------------------------------------заполняем первый уровень
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprOrgHspUsl");
            // ------------------------------------------------------------------------------заполняем второй уровень
            
            GridUsl.DataSource = ds;
            GridUsl.DataBind();

            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
        }
    // ============================ чтение заголовка таблицы а оп ==============================================

</script>


<body>
    <form id="form1" runat="server">
        
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField runat="server" ID="GridUslExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridUslExcelData" />
        <%-- ============================  шапка экрана ============================================ --%>

       <%-- ============================  верхний блок  ============================================ --%>
           <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 500px;">
             <asp:TextBox ID="TextBox2" 
             Text="Значения" 
             BackColor="Yellow"  
             Font-Names="Verdana" 
             Font-Size="16px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>

               <%-- ============================  для отображение виде MASTER-DATAIL 
               <obout:Grid ID="GridUsl" runat="server"
                   ShowFooter="false"
                   CallbackMode="true"
                   Serialize="true"
                   FolderLocalization="~/Localization"
                   Language="ru"
                   AutoGenerateColumns="false"
                   FolderStyle="~/Styles/Grid/style_5"
                   ShowColumnsFooter="false"
                   KeepSelectedRecords="false"
                   AutoPostBackOnSelect="false"
                   AllowRecordSelection="false"
                   AllowAddingRecords="false"
                   AllowColumnResizing="true"
                   AllowSorting="false"
                   AllowPaging="false"
                   AllowPageSizeSelection="false"
                AllowDataAccessOnServer="true"
                   Width="100%"
                   PageSize="-1"
                   AllowGrouping="true"
                   ShowMultiPageGroupsInfo="true"
                   ShowCollapsedGroups="true"
                   GroupBy="USLGRP">
                   <ScrollingSettings ScrollHeight="450" />                 
                    =========================================== --%>

               <%-- ============================  для отображение оплаты =========================================== --%>
               <obout:Grid ID="GridUsl" runat="server"
                   ShowFooter="false"
                   CallbackMode="true"
                   Serialize="true"
                   FolderLocalization="~/Localization"
                   Language="ru"
                   AutoGenerateColumns="false"
                   FolderStyle="~/Styles/Grid/style_5"
                   ShowColumnsFooter="false"
                   KeepSelectedRecords="false"
                   AutoPostBackOnSelect="false"
                   AllowRecordSelection="false"
                   AllowAddingRecords="false"
                   AllowColumnResizing="true"
                   AllowSorting="false"
                   AllowPaging="false"
                   AllowPageSizeSelection="false"
                AllowDataAccessOnServer="true"
                   Width="100%"
                   PageSize="-1"
                   AllowGrouping="false"
                   ShowMultiPageGroupsInfo="false"
                   ShowCollapsedGroups="false">
                   <ScrollingSettings ScrollHeight="500" />
                   <Columns>
                       <obout:Column ID="Column20" DataField="HSPUSLIDN" HeaderText="Код" Visible="false" Width="0%" />
                       <obout:Column ID="Column21" DataField="HSPUSLKEY" HeaderText="Ключ" Visible="false" Width="0%" />
                       <obout:Column ID="Column22" DataField="HSPUSLPRCKOD" HeaderText="Код"  ReadOnly="true" Width="5%" />
                       <obout:Column ID="Column23" DataField="HSPUSLTRF" HeaderText="Шифр"  ReadOnly="true" Width="10%" />
                       <obout:Column ID="Column24" DataField="HSPUSLNAM" HeaderText="Наименование" ReadOnly="true" Width="40%" />
                       <obout:Column ID="Column25" DataField="HSPUSLEDN" HeaderText="Ед.измерения" ReadOnly="true" Width="10%" />
                       <obout:Column ID="Column26" DataField="HSPUSLZEN" HeaderText="Цена" ReadOnly="true" Width="5%" Align="right" />

                       <obout:Column ID="Column27" DataField="HSPUSLALL" HeaderText="Включен" Width="5%">
                           <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                       </obout:Column>                       
                       <obout:Column ID="Column28" DataField="HSPUSLSUM" HeaderText="Сумма" Width="8%" Align="right">
                           <TemplateSettings TemplateId="TxtEditTemplate" />
                       </obout:Column>
                       <obout:Column ID="Column29" DataField="HSPUSLKOL" HeaderText="Кол. обращ." Width="7%" Align="right">
                           <TemplateSettings TemplateId="TxtEditTemplate" />
                       </obout:Column>
                       <obout:Column ID="Column30" DataField="HSPUSLKOLALL" HeaderText="Кол.всего" Width="10%" Align="right">
                           <TemplateSettings TemplateId="TxtEditTemplate" />
                       </obout:Column>

                   </Columns>
                   <Templates>
                       <obout:GridTemplate runat="server" ID="TxtEditTemplate">
                           <Template>
                               <input type="text" class="excel-textbox" value="<%# Container.Value %>" ondblclick="markAsDblClick(this, '<%# GridUsl.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)"
                                   onfocus="markAsFocused(this)" onblur="markAsBlured(this, '<%# GridUsl.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)" />
                           </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                           <Template>
                               <input type="text" name="TextBox1"
                                   class="excel-textbox"
                                   value='<%# Container.Value == "True" ? "   +" : " " %>'
                                   readonly="readonly"
                                   onblur="saveCheckBoxChanges(this, <%# Container.PageRecordIndex %>)"
                                   onfocus="GridUsl.editWithCheckBox(this)" />
                           </Template>
                       </obout:GridTemplate>
                   </Templates>

               </obout:Grid>

               
            <div style="display: none;" id="FieldEditorsContainer">
                <div id="CheckBoxEditorContainer" style="width: 100%">
                    <obout:OboutCheckBox runat="server" ID="CheckBoxEditor" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        <ClientSideEvents OnBlur="persistFieldValue" />
                    </obout:OboutCheckBox>
                </div>
            </div>

           </asp:Panel>
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

        <script type="text/javascript">
            window.onload = function () {
                GridUsl.convertToExcel(
                    ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
                    '<%=GridUslExcelData.ClientID %>',
                    '<%=GridUslExcelDeletedIds.ClientID %>'
                );
         }
        </script>

    </form>

</body>
    <script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>

</html>



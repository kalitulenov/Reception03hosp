<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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



    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        /*------------------------- при нажатии на поле бит --------------------------------*/
        function persistFieldValue(field) {
            var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
            var DatDocRek = 'STTFLG';
            var DatDocTyp = 'Bit';
            var DatDocIdn;

            if (focusedGrid != null && focusedGrid._lastEditedField != null) {
                if (typeof (focusedGrid._lastEditedFieldEditor.value) == 'function') {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.value();
                } else {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.checked() ? '   +' : ' ';
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
            var DatDocRek = 'STTMEM';
            var DatDocVal;
            var DatDocTyp = 'Txt';

            textbox.className = 'excel-textbox';

            GridStt.Rows[rowIndex].Cells[dataField].Value = textbox.value;

            DatDocIdn = GridStt.Rows[rowIndex].Cells['STTIDN'].Value;
            DatDocVal = textbox.value;
            onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
            parDocIdn.value = GridStt.Rows[rowIndex].Cells['STTIDN'].Value;
            //            alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

        }

        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBSTT';
            var DatDocKey = 'STTIDN';

       //     var DatDocRek = GrfDocRek;
       //     var DatDocVal = GrfDocVal;
       //     var DatDocTyp = GrfDocTyp;
      //      var DatDocIdn;


            //            alert("onChange=" + DatDocMdb + ' ' + DatDocTab + ' ' + DatDocKey + ' ' + DatDocIdn + ' ' + DatDocRek + ' ' + DatDocVal + ' ' + DatDocTyp);

   //         alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
 //           alert("SqlStr=" + SqlStr);

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

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================
        if (!Page.IsPostBack)
        {

            getGrid();
        }
    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbSttIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbSttIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {

            //    корректировка ширины колонок -------------------------------------------------------------------------- 
     //       if (String.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["STTLEN003"]))) LenCol = "0";
    //        else 
            LenCol = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN003"]);

            GridStt.Columns[1].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN001"]);
            GridStt.Columns[2].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN002"]);
            GridStt.Columns[3].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN003"]);
            GridStt.Columns[4].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN004"]);
            GridStt.Columns[5].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN005"]);
            GridStt.Columns[6].Width = Convert.ToString(ds.Tables[0].Rows[0]["STTLEN006"]);

            GridStt.DataSource = ds;
            GridStt.DataBind();
        }

    }
        
        // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField runat="server" ID="GridSttExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridSttExcelData" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka"
            Text="СТАТУС"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>
        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 500px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridStt" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                ShowColumnsFooter="false">
                <Columns>
                    <obout:Column ID="Column0" DataField="STTIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="STTDTLGRP" HeaderText="Группа" Width="10%" />
                    <obout:Column ID="Column2" DataField="STTDTLPDG" HeaderText="ПодГруппа" Width="10%" />
                    <obout:Column ID="Column3" DataField="STTDTLSAP" HeaderText="Наименование" Width="20%" />
                    <obout:Column ID="Column4" DataField="STTDTLLST" HeaderText="Значение" Width="10%" />
                    <obout:Column ID="Column5" DataField="STTFLG" HeaderText="Признак" Width="5%" Align="center">
                        <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                    </obout:Column>
                    <obout:Column ID="Column6" DataField="STTMEM" HeaderText="Примечание" Width="44%" >
                        <TemplateSettings TemplateId="TxtEditTemplate" />
                    </obout:Column>
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="TxtEditTemplate">
                        <Template>
                            <input type="text" class="excel-textbox" value="<%# Container.Value %>" ondblclick="markAsDblClick(this, '<%# GridStt.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)"
                                onfocus="markAsFocused(this)" onblur="markAsBlured(this, '<%# GridStt.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                        <Template>
                            <input type="text" name="TextBox1"
                                class="excel-textbox"
                                value='<%# Container.Value == "True" ? "   +" : " " %>'
                                readonly="readonly"
                                onblur="saveCheckBoxChanges(this, <%# Container.PageRecordIndex %>)"
                                onfocus="GridStt.editWithCheckBox(this)" />
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


        <script type="text/javascript">
            window.onload = function () {
                GridStt.convertToExcel(
                    ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
                    '<%=GridSttExcelData.ClientID %>',
                    '<%=GridSttExcelDeletedIds.ClientID %>'
                );
         }
        </script>
    </form>
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
            font: 12px Verdana;
            color: #333333;
        }

        .option2 {
            font: 12px Verdana;
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
            font-size: 12px !important;  // для увеличения коррект поля
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

</body>
<script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>
</html>



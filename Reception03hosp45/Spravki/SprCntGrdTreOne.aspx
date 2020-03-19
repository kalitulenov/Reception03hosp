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



        <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        /*------------------------- при нажатии на поле бит --------------------------------*/
        function persistFieldValue(field) {
            var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
            var DatDocRek = 'CNTUSLALL';
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
    //        alert(textbox.value + '  -  ' + dataField + '  -  ' + rowIndex);
            textbox.className = 'excel-textbox';

            GridUsl.Rows[rowIndex].Cells[dataField].Value = textbox.value;
            var DatDocIdn = GridUsl.Rows[rowIndex].Cells['CNTUSLIDN'].Value;
            var DatDocZen = GridUsl.Rows[rowIndex].Cells['USLZEN'].Value;
            var DatDocFrm = document.getElementById('parBuxFrm').value;
            var DatDocCnt = document.getElementById('parCntKey').value;
            var DatDocKod = GridUsl.Rows[rowIndex].Cells['USLKOD'].Value;

            var DatDocVal = textbox.value;
            if (DatDocVal == null || DatDocVal == "") DatDocVal = "0";
            if (DatDocIdn == null || DatDocIdn == "") DatDocIdn = "0";


            var ParStr = DatDocIdn + ':' + DatDocFrm + ':' + DatDocCnt + ':' + DatDocKod + ':' + dataField + ':' + DatDocVal + ':' + DatDocZen + ':';

        //    alert("ParStr=" + ParStr);
            
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/HspSprCntUslWrt',
                contentType: "application/json; charset=utf-8",
                data: '{"ParStr":"' + ParStr + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
            

        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
            parDocIdn.value = GridUsl.Rows[rowIndex].Cells['CNTUSLIDN'].Value;
            //            alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

        }


    </script>


</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string BuxKod;
    string BuxFrm;
    int ItgSum = 0;

    string GlvCntKey;
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
        GlvCntKey = Convert.ToString(Request.QueryString["CntKey"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxFrm.Value = BuxFrm;
        parPrcKey.Value = GlvPrcKey;
        parCntKey.Value = GlvCntKey;
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
        //        ds.Merge(InsSprCntUsl(MdbNam, BuxFrm, BuxKod, GlvCntKey));


        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprCntUsl", con);
        cmd = new SqlCommand("HspSprCntUsl", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@CNTKEY", SqlDbType.VarChar).Value = GlvCntKey;
        cmd.Parameters.Add("@PRCKEY", SqlDbType.VarChar).Value = GlvPrcKey;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspSprCntUsl");
        // ------------------------------------------------------------------------------заполняем второй уровень

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

        // освобождаем экземпляр класса DataSet
        ds.Dispose();
        con.Close();
        // возвращаем значение
    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    protected void AddButton_Click(object sender, EventArgs e)
    {
        bool flag;

        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprCntUslOut", con);
        cmd = new SqlCommand("HspSprCntUslOut", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@CNTKEY", SqlDbType.VarChar).Value = GlvCntKey;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        cmd.ExecuteNonQuery();

        // ------------------------------------------------------------------------------заполняем второй уровень
        con.Close();

        LoadGridNode();
    }


    /*
    AllowDataAccessOnServer="true"
    protected void SomeMethod(object sender, EventArgs e)
    {
        string txt = "";
        Hashtable dataIt = null;
        foreach (Obout.Grid.GridRow row in grid1.Rows)
        {
            if (row.RowType == GridRowType.DataRow)
            {
                dataIt = row.ToHashtable() as Hashtable;
                txt = dataIt["ShipName"].ToString();
            }
        }
    }
  */

</script>


<body>
    <form id="form1" runat="server">
        
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parPrcKey" runat="server" />
        <asp:HiddenField ID="parCntKey" runat="server" />
        <asp:HiddenField runat="server" ID="GridUslExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridUslExcelData" />
        <%-- ============================  шапка экрана ============================================ --%>

       <%-- ============================  верхний блок  ============================================ --%>
           <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 510px;">
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
                   <ScrollingSettings ScrollHeight="470" />
                   <Columns>
                       <obout:Column ID="Column20" DataField="CNTUSLIDN" HeaderText="Код" Visible="false" Width="0%" />
                       <obout:Column ID="Column21" DataField="USLKOD" HeaderText="КОД"  ReadOnly="true" Width="8%" />
                       <obout:Column ID="Column22" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ" Wrap="true" ReadOnly="true" Width="52%" />
                       <obout:Column ID="Column23" DataField="USLZEN" HeaderText="ПРЕЙСКУРАНТ" ReadOnly="true" Align="right" Width="8%" />
                       <obout:Column ID="Column24" DataField="CNTUSLZEN" HeaderText="ЦЕНА" Align="right" Width="8%" >
                           <TemplateSettings TemplateId="TxtEditTemplate" />
                       </obout:Column>
                       <obout:Column ID="Column25" DataField="CNTUSLKOL" HeaderText="КОЛ.ОБРАЩ." Width="10%" Align="right" >
                           <TemplateSettings TemplateId="TxtEditTemplate" />
                       </obout:Column>
                       <obout:Column ID="Column26" DataField="CNTUSLSUM" HeaderText="СУММА" Width="14%" Align="right">
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
       <%-- ============================  STYLES ============================================ --%>

    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R, div.ob_gCc1 {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

        /*   For multiline textbox control:  */
        .ob_iTaMC textarea {
            font-size: 12px !important;
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
            font: 12px Verdana;
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
            padding-top: 0px;
            padding-bottom: 0px;
            font: bold 12px Tahoma !important;  /*------excel-textbox-----------*/
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



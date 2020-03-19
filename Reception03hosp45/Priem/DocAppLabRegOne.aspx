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
       //     alert(textbox.value + '  -  ' + dataField + '  -  ' + rowIndex);
            textbox.className = 'excel-textbox';

            var DatDocFrm = document.getElementById('parBuxFrm').value;
            GridUsl.Rows[rowIndex].Cells[dataField].Value = textbox.value;
            var DatDocIdn = GridUsl.Rows[rowIndex].Cells['USLIDN'].Value;
            var DatDocMem = GridUsl.Rows[rowIndex].Cells['USLMEM'].Value;

            var DatDocVal = textbox.value;
            if (DatDocVal == null || DatDocVal == "") DatDocVal = "0";
            if (DatDocIdn == null || DatDocIdn == "") DatDocIdn = "0";


            var ParStr = DatDocFrm + ':' + DatDocIdn + ':' + DatDocVal + ':';

           // alert("ParStr=" + ParStr);
            
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/HspDocAppLabRegUslWrt',
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

    string UslKod;
    string UslDat;
    string UslNam;
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
        UslKod = Convert.ToString(Request.QueryString["UslKod"]);
        UslNam = Convert.ToString(Request.QueryString["UslNam"]);
        UslDat = Convert.ToString(Request.QueryString["UslDat"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxFrm.Value = BuxFrm;

        parUslKod.Value = UslKod;
        parUslDat.Value = UslDat;
        //=====================================================================================

        if (!Page.IsPostBack)
        {
            TxtUsl.Text = UslNam;
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
        SqlCommand cmd = new SqlCommand("HspDocAppLabRegUsl", con);
        cmd = new SqlCommand("HspDocAppLabRegUsl", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = parUslDat.Value;
        cmd.Parameters.Add("@USLKOD", SqlDbType.VarChar).Value = parUslKod.Value;
        // ------------------------------------------------------------------------------заполняем первый уровень
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspDocAppLabRegUsl");
        // ------------------------------------------------------------------------------заполняем второй уровень

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

        // освобождаем экземпляр класса DataSet
        ds.Dispose();
        con.Close();
        // возвращаем значение
    }
    // ============================ чтение заголовка таблицы а оп ==============================================


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
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parUslDat" runat="server" />
        <asp:HiddenField runat="server" ID="GridUslExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridUslExcelData" />
        <%-- ============================  шапка экрана ============================================ --%>

       <%-- ============================  верхний блок  ============================================ --%>
           <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 510px;">
               <%-- ============================  для отображение оплаты =========================================== --%>
               <asp:TextBox ID="TxtUsl"
                     Text=" "
                     BackColor="#0099FF"
                     Font-Names="Verdana"
                     Font-Size="20px"
                     Font-Bold="True"
                     ForeColor="White"
                     Style="top: 0px; left: 0px; position: relative; width: 100%"
                     runat="server"></asp:TextBox>

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
                       <obout:Column ID="Column00" DataField="" ReadOnly="true" HeaderText="NO." Width="5%" runat="server">
                             <TemplateSettings TemplateId="tplNumbering"/>
                       </obout:Column>
                       <obout:Column ID="Column20" DataField="USLIDN" HeaderText="Код" Visible="false" Width="0%" />
                       <obout:Column ID="Column21" DataField="GRFIIN" HeaderText="ИИН"  ReadOnly="true" Width="20%" />
                       <obout:Column ID="Column22" DataField="GRFPTH" HeaderText="ФАМИЛИЯ И.О." Wrap="true" ReadOnly="true" Width="45%" />
                       <obout:Column ID="Column24" DataField="USLMEM" HeaderText="ЗНАЧЕНИЯ" Align="right" Width="30%" >
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

                       <obout:GridTemplate runat="server" ID="tplNumbering">
                          <Template>
                              <b><%# (Container.RecordIndex + 1) %>.</b>
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



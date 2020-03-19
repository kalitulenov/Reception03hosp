<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
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
    <%-- ============================  JAVA ============================================ --%>
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        // -------изменение как EXCEL-------------------------------------------------------------------          

        /*------------------------- при нажатии на поле бит --------------------------------*/
        function persistFieldValue(field) {
            //                 alert("persistFieldValue=");
            var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
            var DatDocRek = 'PRSNPRFLG';
            var DatDocTyp = 'Sql';
            var DatDocIdn;

            if (focusedGrid != null && focusedGrid._lastEditedField != null) {
                if (typeof (focusedGrid._lastEditedFieldEditor.value) == 'function') {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.value();
                } else {
                    focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.checked() ? '              +' : ' ';
                }
                document.getElementById('FieldEditorsContainer').appendChild(document.getElementById(focusedGrid._lastEditedFieldEditor.ID + 'Container'));
                focusedGrid._lastEditedField.style.display = '';

                focusedGrid._lastEditedField = null;
                focusedGrid._lastEditedFieldEditor = null;

                DatDocIdn = parDocIdn.value;

                onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
            }
        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
 //                    alert("saveCheckBoxChanges=");
            parDocIdn.value = GridNap.Rows[rowIndex].Cells['PRSIDN'].Value;
            //                alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);
        }

        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {
   //         alert("onChangeUpd=");

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'HspAmbNapTooUsl';
            var DatDocKey;
            var SqlStr;
            var DatDocIdn;

            var QueryString = getQueryString();
            DatDocIdn = QueryString[1];

            //     alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);

            //    ---------------- прикрепить услугу к приходу --------------------------------------------------------
            //    ---------------- выбрать врача если есть и записать на приход --------------------------------------------------------
            //    ---------------- выбрать пациента и записать на приход --------------------------------------------------------
            //    ---------------- выбрать текст услуг и записать на приход --------------------------------------------------------

            DatDocTyp = 'Str';
            SqlStr = "HspAmbNapTooUsl&@GLVDOCIDN&" + DatDocIdn + "&@NAPIDN&" + parDocIdn.value;
  //                     alert("SqlStr=" + SqlStr);

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

        //    ------------------ читать переданные параметры ----------------------------------------------------------
        function getQueryString() {
            var queryString = [];
            var vars = [];
            var hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            //               alert("hashes=" + hashes);
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                queryString.push(hash[0]);
                vars[hash[0]] = hash[1];
                queryString.push(hash[1]);
            }
            return queryString;
        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";

    string MdbNam = "HOSPBASE";

    int PrsIdn;
    int PrsAmb;
    int PrsGrp;
    int PrsNum;
    int PrsUsl;
    int PrsUslExp;
    string PrsMem;
    bool PrsNprFlg;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
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
        SqlCommand cmd = new SqlCommand("HspAmbPrsAllIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbPrsAllIdn");

        con.Close();
        
        GridNap.DataSource = ds;
        GridNap.DataBind();

    }
    // ======================================================================================
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <asp:HiddenField runat="server" ID="GridNapExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridNapExcelData" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАПРАВЛЕНИЯ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 430px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridNap" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/grand_gray"
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
                EnableTypeValidation="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
                    <obout:Column ID="Column0" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                <obout:Column ID="Column1" DataField="GRFDAT" HeaderText="Дата"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column2" DataField="FI" HeaderText="Идн" Width="10%" />
                    <obout:Column ID="Column3" DataField="PRSNUM" HeaderText="НОМЕР" Width="5%"  Align="right" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="USLNAM" HeaderText="НАПРАВЛЕНИЯ" Width="45%" />
                    <obout:Column ID="Column5" DataField="USLINP" HeaderText="ВНУТ" Width="5%"  Align="center" ReadOnly="true"  ItemStyle-Font-Bold="true"/>
                    <obout:Column ID="Column6" DataField="USLOUT" HeaderText="ВНЕШ" Width="5%"  Align="center" ReadOnly="true" ItemStyle-Font-Bold="true" />

                    <obout:Column ID="Column7" DataField="PRSMEM" HeaderText="ПРИМЕЧАНИЕ" Width="17%"  Align="left" />
                    <obout:Column ID="Column8" DataField="PRSNPRFLG" HeaderText="ВЫБОРКА" Width="8%" Align="center">
                        <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                    </obout:Column>
                </Columns>

                <Templates>
                   <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                        <Template>
                            <input type="text" name="TextBox1"
                                class="excel-textbox"
                                value='<%# Container.Value == "True" ? "      +" : " " %>'
                                readonly="readonly"
                                onblur="saveCheckBoxChanges(this, <%# Container.PageRecordIndex %>)"
                                onfocus="GridNap.editWithCheckBox(this)" />
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
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    
        <script type="text/javascript">
            window.onload = function () {
                GridNap.convertToExcel(
                        ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
                '<%=GridNapExcelData.ClientID %>',
                '<%=GridNapExcelDeletedIds.ClientID %>'
                );
               }
        </script>

    </form>

    <%-- ============================  STYLES ============================================ --%>
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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }

            
        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
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
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
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



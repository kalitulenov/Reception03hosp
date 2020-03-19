<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


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

    <script type="text/javascript">
        var ComRowIndex;
        var ComRowIdn;

        //    ---------------- обращение веб методу --------------------------------------------------------
        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parRefIdn').value;

            switch (sender.ID) {
                case 'BoxSblSex':
                    DatDocVal = BoxSblSex.options[BoxSblSex.selectedIndex()].value;
                    SqlStr = "UPDATE SPRREF SET SPRREFSEX='" + DatDocVal + "' WHERE SPRREFIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
            //                           alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });

        }


        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
            //           alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            //            var QueryString = getQueryString();
            //            var DatDocIdn = QueryString[1];
            var DatDocIdn = document.getElementById('parRefIdn').value;

            var SqlStr = "";


            switch (sender) {
                case 'TxtSblNam':
                    //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE SPRREF SET SPRREFNAM='" + DatDocVal + "' WHERE SPRREFIDN=" + DatDocIdn;
                    break;
                case 'TxtSblMin':
                    SqlStr = "UPDATE SPRREF SET SPRREFMIN='" + DatDocVal + "' WHERE SPRREFIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }
            //               alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });
        }


        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'SprRefDTL';
            var DatDocKey = 'USLDTLIDN';

            SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
            //           alert("SqlStr=" + SqlStr);

            //          alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
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
           //            alert("SqlStr=" + SqlStr);

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


        function loadUsl(sender, index) {
            //   alert("sender.value =" + sender.value());
            //        alert("loadStx 0 =" + index);
            //        alert("loadStx 1 =" + document.getElementById('parBuxFrm').value);
            //        alert("loadStx 2 =" + document.getElementById('parCrdIdn').value);
            //       var GrfDlg = BoxDoc001.options[BoxDoc001.selectedIndex()].value;

            var SndPar = sender.value() + ':' + document.getElementById('parBuxFrm').value;
            //        alert("loadStx 3 =" + SndPar);
            //        PageMethods.GetSprDlg(SndPar, onSprDlgLoaded, onSprDlgLoadedError);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/GetSprGrpUsl',
                data: '{"SndPar":"' + SndPar + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (SprUsl) {
                     //             alert("onSprUslLoaded=" + SprUsl.d);

                    SprUslComboBox.options.clear();
                    SprUslComboBox.options.add("");   //   без этой строки не работает !!!!!!!!!!!!!!!!!!!!!!!!
                    for (var i = 0; i < SprUsl.d.length; i = i + 2) {
                        SprUslComboBox.options.add(SprUsl.d[i], SprUsl.d[i + 1]);
                    }
                },
                error: function () { alert("ERROR="); }
            });
        }


        function updateSprUslSelection(sender, index) {
            document.getElementById('hiddenUslNam').value = sender.value();
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string SprRefIdn;
    string SprRefIdnTek;
    string AmbUziTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;
    bool BuxUbl;

    int RefIdn;
    int RefRef;
    string RefGrp;
    int RefKod;
    int DocKod;
    int RefNnn;
    int RefGde;
    int RefMin;
    string RefSex;


    //    string Col003;
    //    string Col004;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        SprRefIdn = Convert.ToString(Request.QueryString["SprRefIdn"]);
        //    if (SprRefIdn == "0") AmbUziTyp = "ADD";
        //    else AmbUziTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        //     AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //     Session.Add("SprRefIdn ", SprRefIdn);
        parBuxFrm.Value = BuxFrm;

        GridRefUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridRefUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridRefUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        sdsCab.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsCab.SelectCommand = "SELECT CABKOD,CABNAM FROM SPRCAB WHERE CABFRM="+ BuxFrm + " ORDER BY CABNAM";

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsGrp.SelectCommand = "SELECT SprUsl.UslKey001 AS GrpKod,SprUsl.UslGrp001 AS GrpNam " +
                               "FROM SprUsl INNER JOIN SprUslFrm ON SprUsl.UslKod=SprUslFrm.UslFrmKod " +
                               "WHERE SprUslFrm.UslFrmHsp=" + BuxFrm +" AND SprUsl.UslPrc=1 AND SprUslFrm.UslFrmZen>0 " +
                               "GROUP BY SprUsl.UslGrp001,SprUsl.UslKey001 ORDER BY SprUsl.UslKey001";

        //       sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsSex.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSex.SelectCommand = "SELECT * FROM SPRSEX ORDER BY SEXNAM";

        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm +
                               " AND (DLGTYP='АМБ' OR DLGTYP='УЗИ' OR DLGTYP='ЛАБ' OR DLGTYP='РНТ' OR DLGTYP='ФНК' OR DLGTYP='СТМ') ORDER BY FI";


        if (!Page.IsPostBack)
        {
            TxtSblNam.Attributes.Add("onchange", "onChange('TxtSblNam',TxtSblNam.value);");
            //============= Установки ===========================================================================================
            //        SprRefIdnTek = (string)Session["SprRefIdn"];
            //        if (SprRefIdnTek != "Post")
            //        {
            if (SprRefIdn == "0")  // новый документ
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspSprRefAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@REFIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@REFIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    SprRefIdn = Convert.ToString(cmd.Parameters["@REFIDN"].Value);
                }
                finally
                {
                    con.Close();
                }
            }
            //      }

            //  Session["SprRefIdn"] = Convert.ToString(SprRefIdn);
            parRefIdn.Value = SprRefIdn;

            GetGrid();
        }
    }

    void GetGrid()
    {

        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT SprRef.*,SprRefUsl.*,SprUsl.UslNamFul as UslNam,SprBuxKdr.FI," +
                                               "(SELECT TOP (1) StrUslNam FROM SprStrUsl WHERE StrUslKey001=SprRefUsl.SprRefUslGrp) AS GrpNam, " +
                                               "(SELECT TOP (1) CABNAM FROM SPRCAB WHERE CABKOD=SprRefUsl.SprRefUslGde) AS CABNAM " +
                                        "FROM SprRef LEFT OUTER JOIN SprBuxKdr " +
                                                    "RIGHT OUTER JOIN SprRefUsl ON SprBuxKdr.BuxKod=SprRefUsl.SprRefUslDoc " +
                                                                         "ON SprRef.SprRefKod=SprRefUsl.SprRefUslRef " +
                                                    "LEFT OUTER JOIN SprUsl ON SprRefUsl.SprRefUslKod=SprUsl.UslKod " +
                                        "WHERE SprRef.SprRefFrm=" + BuxFrm + " AND SprRef.SprRefIdn=" +parRefIdn.Value + " ORDER BY SprRefUsl.SprRefUslNnn",con);        // указать тип команды
        
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "SprRefUsl");

        if (ds.Tables[0].Rows.Count > 0)
        {
            // ============================================================================================
            TxtSblNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRREFNAM"]);
            parRefRef.Value = Convert.ToString(ds.Tables[0].Rows[0]["SPRREFKOD"]);
        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            //        BoxUsl.SelectedValue = "";
        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        GridRefUsl.DataSource = ds;
        GridRefUsl.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["SprRefUslKod"] == null | e.Record["SprRefUslKod"] == "") RefKod = 0;
        else RefKod = Convert.ToInt32(e.Record["SprRefUslKod"]);

        if (e.Record["SprRefUslGrp"] == null | e.Record["SprRefUslGrp"] == "") RefGrp = "000";
        else RefGrp = Convert.ToString(e.Record["SprRefUslGrp"]);

        if (e.Record["SprRefUslNnn"] == null | e.Record["SprRefUslNnn"] == "") RefNnn = 0;
        else RefNnn = Convert.ToInt32(e.Record["SprRefUslNnn"]);

        if (e.Record["SprRefUslGde"] == null | e.Record["SprRefUslGde"] == "") RefGde = 0;
        else RefGde = Convert.ToInt32(e.Record["SprRefUslGde"]);

        if (e.Record["SprRefUslMin"] == null | e.Record["SprRefUslMin"] == "") RefMin = 10;
        else RefMin = Convert.ToInt32(e.Record["SprRefUslMin"]);

        if (e.Record["SprRefUslSex"] == null | e.Record["SprRefUslSex"] == "") RefSex = "";
        else RefSex = Convert.ToString(e.Record["SprRefUslSex"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("INSERT INTO SPRREFUSL(SprRefUslRef,SprRefUslNnn,SprRefUslGrp,SprRefUslKod,SprRefUslGde,SprRefUslMin,SprRefUslSex)" +
                                        "VALUES(" + parRefRef.Value + ","+RefNnn+",'"+RefGrp+"',"+RefKod+",'"+RefGde+"',"+RefMin+",'"+RefSex+"')",con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        RefIdn = Convert.ToInt32(e.Record["SprRefUslIdn"]);

        if (e.Record["SprRefUslKod"] == null | e.Record["SprRefUslKod"] == "") RefKod = 0;
        else RefKod = Convert.ToInt32(e.Record["SprRefUslKod"]);

        if (e.Record["SprRefUslGrp"] == null | e.Record["SprRefUslGrp"] == "") RefGrp = "000";
        else RefGrp = Convert.ToString(e.Record["SprRefUslGrp"]);

        if (e.Record["SprRefUslGde"] == null | e.Record["SprRefUslGde"] == "") RefGde = 0;
        else RefGde = Convert.ToInt32(e.Record["SprRefUslGde"]);

        if (e.Record["SprRefUslNnn"] == null | e.Record["SprRefUslNnn"] == "") RefNnn = 0;
        else RefNnn = Convert.ToInt32(e.Record["SprRefUslNnn"]);

        if (e.Record["SprRefUslDoc"] == null | e.Record["SprRefUslDoc"] == "") DocKod = 0;
        else DocKod = Convert.ToInt32(e.Record["SprRefUslDoc"]);

        if (e.Record["SprRefUslMin"] == null | e.Record["SprRefUslMin"] == "") RefMin = 10;
        else RefMin = Convert.ToInt32(e.Record["SprRefUslMin"]);

        if (e.Record["SprRefUslSex"] == null | e.Record["SprRefUslSex"] == "") RefSex = "";
        else RefSex = Convert.ToString(e.Record["SprRefUslSex"]);


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("UPDATE SPRREFUSL SET SprRefUslNnn=" + RefNnn + ",SprRefUslGrp='" + RefGrp + "',SprRefUslKod=" + RefKod +
                                        ",SprRefUslDoc=" + DocKod + ",SprRefUslMin=" + RefMin + ",SprRefUslSex='" + RefSex +
                                        "',SprRefUslGde=" + RefGde + "  WHERE SprRefUslIdn="+RefIdn, con);

        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        RefIdn = Convert.ToInt32(e.Record["SprRefUslIdn"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmdDtl = new SqlCommand("DELETE FROM SPRREFUSL WHERE SPRREFUSLIDN=" + RefIdn, con);
        cmdDtl.ExecuteNonQuery();
        con.Close();

        GetGrid();
    }
    //------------------------------------------------------------------------
</script>


<body>
    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parRefIdn" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parRefKod" runat="server" />
        <asp:HiddenField ID="parRefRef" runat="server" />
        <asp:HiddenField ID="Col003" runat="server" />
        <asp:HiddenField ID="Col004" runat="server" />
        <asp:HiddenField ID="GridRefRefExcelDeletedIds" runat="server"/>
        <asp:HiddenField ID="GridRefRefExcelData" runat="server"/>   

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 400px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%">
                       <asp:Label id="Label4" Text="НАИМ.:" runat="server"  Width="10%" Font-Bold="true" /> 
                       <asp:TextBox ID="TxtSblNam" Width="85%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: small;" />
                    </td>
               </tr>
            </table>

            <obout:Grid ID="GridRefUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                 ShowGroupFooter="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                Width="100%"
                 EnableTypeValidation="false"
             AllowFiltering="false" 
                AllowSorting="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="true"
                AllowRecordSelection="false"
                 ShowColumnsFooter="false"
                 AllowPaging="false">
                <ScrollingSettings ScrollHeight="310" />
                <Columns>
                    <obout:Column ID="Column1" DataField="SprRefUslIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="SprRefUslRef" HeaderText="КОД" ReadOnly="true" Width="0%" />
                    <obout:Column ID="Column3" DataField="SprRefUslNnn" HeaderText="№№" Width="5%" />
                    <obout:Column ID="Column4" DataField="SprRefUslGrp" HeaderText="ГРУППА" Width="12%" >
                         <TemplateSettings TemplateId="TemplateGrp" EditTemplateId="TemplateEditGrp" />
                    </obout:Column>
                    <obout:Column ID="Column5" DataField="SprRefUslKod" HeaderText="УСЛУГА" Width="41%" >
                        <TemplateSettings TemplateId="TemplateUsl" EditTemplateId="TemplateEditUsl" />
                    </obout:Column>
                    <obout:Column ID="Column6" DataField="SprRefUslSex" HeaderText="ПОЛ" Width="7%" >
                        <TemplateSettings EditTemplateId="TemplateEditSex" />
                    </obout:Column>
                    <obout:Column ID="Column7" DataField="SprRefUslMin" HeaderText="ДЛИТ." Width="5%" />
                    <obout:Column ID="Column8" DataField="SprRefUslDoc" HeaderText="ВРАЧ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>                
                     <obout:Column ID="Column06" DataField="SprRefUslGde" HeaderText="Кабинет" Width="10%" >
                           <TemplateSettings TemplateId="TemplateCabNam" EditTemplateId="TemplateEditCabNam" />
                    </obout:Column>

                    <obout:Column ID="Column10" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>

                <Templates>

                   <obout:GridTemplate runat="server" ID="TemplateGrp">
                        <Template>
                            <%# Container.DataItem["GrpNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlGrp" ID="TemplateEditGrp" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlGrp" Width="100%" Height="150" MenuWidth="200"
                                DataSourceID="sdsGrp" DataTextField="GrpNam" DataValueField="GrpKod">
                                <ClientSideEvents OnSelectedIndexChanged="loadUsl" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>
                    
                    <obout:GridTemplate runat="server" ID="TemplateUsl">
                        <Template>
                            <%# Container.DataItem["UslNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUsl" ControlPropertyName="value">
                        <Template>
                           <input type="hidden" id="hiddenUslNam" />
                           <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%" Height="150" MenuWidth="800" >
                                <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>
                    
                     <obout:GridTemplate runat="server" ControlID="ddlSex" ID="TemplateEditSex" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlSex" Width="100%" Height="150" MenuWidth="200"
                                DataSourceID="sdsSex" DataTextField="SexNam" DataValueField="SexNam">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateKtoNam">
                        <Template>
                            <%# Container.DataItem["FI"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKtoNam" ControlID="ddlKtoNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKtoNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKto" CssClass="ob_gEC" DataTextField="FI" DataValueField="BuxKod">
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

                </Templates>
            </obout:Grid>

        </asp:Panel>

   <%-- =================  окно для поиска клиента из базы  ============================================ --%>
    </form>
    
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsSex" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsCab" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

               <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
       /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

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
    </style>




</body>



</html>



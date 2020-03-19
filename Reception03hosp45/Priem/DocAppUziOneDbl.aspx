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

        //    ---------------- обращение веб методу --------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parUslIdn').value;

            switch (sender.ID) {
                case 'BoxNoz':
                    DatDocVal = BoxNoz.options[BoxNoz.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLNOZ=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'BoxKto':
                    DatDocVal = BoxKto.options[BoxKto.selectedIndex()].value;
                    SqlStr = "UPDATE AMBUSL SET USLKTO=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
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


        // -------изменение как EXCEL-------------------------------------------------------------------          
        function markAsFocused(textbox) {
            //                alert("markAsFocused=");
            textbox.className = 'excel-textbox-focused';
        }

        /*------------------------- при нажатии на поле текст --------------------------------*/
        function markAsBlured(textbox, dataField, rowIndex) {
            //               alert("markAsBlured=");
            //           alert("textbox=" + textbox.value + " dataField=" + dataField + " rowIndex=" + rowIndex);
            var DatDocIdn;
            var DatDocRek = 'USLDTLVAL';
            var DatDocVal;
            var DatDocTyp = 'Txt';

            textbox.className = 'excel-textbox';

            GridUziOne.Rows[rowIndex].Cells[dataField].Value = textbox.value;

            //          DatDocRek = GridUziOne.Rows[rowIndex].Cells['LabUSLREK'].Value;
            DatDocIdn = GridUziOne.Rows[rowIndex].Cells['UZIUSLIDN'].Value;
            DatDocVal = textbox.value;
            onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
        }

        /*------------------------- при выходе запомнить Идн --------------------------------*/
        function saveCheckBoxChanges(element, rowIndex) {
            parDocIdn.value = GridUziOne.Rows[rowIndex].Cells['UZIUSLIDN'].Value;
            //            alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

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
            var DatDocIdn = document.getElementById('parUslIdn').value;

            var SqlStr = "";


            switch (sender) {
                case 'TxtNap':
                    //                   alert("TxtNap=" + sender.ID);
                    SqlStr = "UPDATE AMBUSL SET USLNAP=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
                    break;
                case 'TxtLgt':
                    if (DatDocVal == null || DatDocVal == "" || DatDocVal <= "0" || DatDocVal > "99") {
                        //         alert("DatDocVal=" + DatDocVal + " " + TxtZen.value);
                        SqlStr = "UPDATE AMBUSL SET USLLGT=0,USLSUM=USLZEN WHERE USLIDN=" + DatDocIdn;
                        //          alert("DatDocVal2=" + DatDocVal + " " + TxtZen.value);
                        TxtSum.value = TxtZen.value;
                    }
                    else
                        SqlStr = "UPDATE AMBUSL SET USLLGT=" + DatDocVal + ",USLSUM=(100-" + DatDocVal + ")*USLZEN/100 WHERE USLIDN=" + DatDocIdn;
                    TxtSum.value = Math.round(TxtSum.value * (100 - TxtLgt.value) / 100);
                    break;
                case 'TxtSum':
                    SqlStr = "UPDATE AMBUSL SET USLSUM=" + DatDocVal + " WHERE USLIDN=" + DatDocIdn;
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
            var DatDocTab = 'AMBUSLDTL';
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
                       alert("SqlStr=" + SqlStr);

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


        var dblClickRs = null;

        function setEditingRecordOnReload() {

            if (dblClickRs != null) {
                GridUziOne.editRecord(dblClickRs);
                dblClickRs = null;
            }
        }

        function onDoubleClick(iRecordIndex) {
            var editingRs = GridUziOne.RecordInEditMode;

            alert("iRecordIndex=" + iRecordIndex);
            alert("editingRs=" + editingRs);

            if (editingRs != null) {
                dblClickRs = iRecordIndex;

                GridUziOne.updateRecord(editingRs);
            } else {
                dblClickRs = null;
                GridUziOne.editRecord(iRecordIndex);
            }
        }


    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslIdnTek;
    string AmbUziTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

//    string Col003;
//    string Col004;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);
        if (AmbUslIdn == "0") AmbUziTyp = "ADD";
        else AmbUziTyp = "REP";
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbUslIdn ", AmbUslIdn);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";


        if (!Page.IsPostBack)
        {
            TxtNap.Attributes.Add("onchange", "onChange('TxtNap',TxtNap.value);");
            TxtLgt.Attributes.Add("onchange", "onChange('TxtLgt',TxtLgt.value);");
            TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
            //============= Установки ===========================================================================================
              AmbUslIdnTek = (string)Session["AmbUslIdn"];
              if (AmbUslIdnTek != "Post")
              {
                  if (AmbUslIdn == "0")  // новый документ
                  {

                      // строка соединение
                      string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                      // создание соединение Connection
                      SqlConnection con = new SqlConnection(connectionString);
                      // создание команды
                      SqlCommand cmd = new SqlCommand("HspAmbUslWinAdd", con);
                      // указать тип команды
                      cmd.CommandType = CommandType.StoredProcedure;
                      // передать параметр
                      cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                      cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = 0;
                      cmd.Parameters["@USLIDN"].Direction = ParameterDirection.Output;
                      con.Open();
                      try
                      {
                          int numAff = cmd.ExecuteNonQuery();
                          // Получить вновь сгенерированный идентификатор.
                          //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                          //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                          AmbUslIdn = Convert.ToString(cmd.Parameters["@USLIDN"].Value);
                      }
                      finally
                      {
                          con.Close();
                      }
                  }
              }

            Session["AmbUslIdn"] = Convert.ToString(AmbUslIdn);
            parUslIdn.Value = AmbUslIdn;

            getDocNum();
            GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        // --------------------------  считать данные одного врача -------------------------
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT AMBUSL.USLKOD,AMBUSL.USLNOZ,AMBUSL.USLSTX,AMBUSL.USLLGT,AMBUSL.USLSUM,AMBUSL.USLNAP,AMBUSL.USLZEN," +
                                               "SprUsl.UslNam,SprUzi.SprUziNam," +
                                               "SprUzi.SprUziLen001,SprUzi.SprUziLen002,SprUzi.SprUziLen003," +
                                               "SprUzi.SprUziLen004,SprUzi.SprUziLen005,SprUzi.SprUziLen006 " +
                                        "FROM AMBUSL LEFT OUTER JOIN SprUsl ON AMBUSL.USLKOD=SprUsl.UslKod " +
                                                    "LEFT OUTER JOIN SprUzi ON AMBUSL.USLLAB=SprUzi.SprUziKod " +
                                        "WHERE AMBUSL.USLIDN=" + AmbUslIdn, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "UziOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            // ============================================================================================
            sdsUsl.SelectCommand = "HspAmbUslKodSou";
            sdsUsl.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            sdsUsl.SelectParameters.Clear();
            Parameter par1 = new Parameter("BUXFRMKOD", TypeCode.String, BuxFrm);
            par1.Size = 10;
            sdsUsl.SelectParameters.Add(par1);
            Parameter par2 = new Parameter("BUXKOD", TypeCode.String, BuxKod);
            par2.Size = 10;
            sdsUsl.SelectParameters.Add(par2);
            Parameter par3 = new Parameter("USLSTX", TypeCode.String, Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]));
            par3.Size = 10;
            sdsUsl.SelectParameters.Add(par3);
            Parameter par4 = new Parameter("AMBCRDIDN", TypeCode.String, AmbCrdIdn);
            par4.Size = 10;
            sdsUsl.SelectParameters.Add(par4);
            Parameter par5 = new Parameter("AMBUSLIDN", TypeCode.String, AmbUslIdn);
            par5.Size = 10;
            sdsUsl.SelectParameters.Add(par5);
            sdsUsl.DataBind();                    //???
            BoxUsl.Items.Clear();
            BoxUsl.DataBind();
            // ============================================================================================

//            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZINAM"]);
            BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLSTX"]);
            BoxUsl.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKOD"]);
            BoxNoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLNOZ"]);
            TxtNap.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLNAP"]);
            TxtLgt.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLLGT"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLSUM"]);
            TxtZen.Text = Convert.ToString(ds.Tables[0].Rows[0]["USLZEN"]);

            if (BoxUsl.SelectedValue != "")
            {
                GridUziOne.Columns[3].Width = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN001"]);  // группа
                Col003.Value = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN001"]);  // группа 
                GridUziOne.Columns[4].Width = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN002"]);  // подгруппа
                Col004.Value = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN002"]);  // группа 
                GridUziOne.Columns[5].Width = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN003"]);  // Параметры
                GridUziOne.Columns[6].Width = Convert.ToString(ds.Tables[0].Rows[0]["SPRUZILEN006"]);  // Значения
                GridUziOne.Columns[6].Wrap = true;  // Значения
            }

        }
        else
        {
 //           BoxTit.Text = "Новая запись";
            BoxUsl.SelectedValue = "";
        }
        
        parUslKod.Value = BoxUsl.SelectedValue;

    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    void GetGrid()
    {

 //       if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUziOneDtl", con);
        cmd = new SqlCommand("HspAmbUziOneDtl", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@AMBUSLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUziOneDtl");
        // ------------------------------------------------------------------------------заполняем второй уровень
        GridUziOne.DataSource = ds;
        GridUziOne.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }

    //------------------------------------------------------------------------
    protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string TekStx;
        int TekUsl;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;
        
        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);

//        if (TekStx > 0)
//        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
            cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
            cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
            cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            //===============================================================================================================

            getDocNum();

            GetGrid();

  //      }
    }

    //------------------------------------------------------------------------
    protected void BoxUsl_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int TekUsl;
        string TekStx;

        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);

        if (parUslKod.Value == BoxUsl.SelectedValue) return;


        if (BoxStx.SelectedValue == null | BoxStx.SelectedValue == "") TekStx = "00000";
        else TekStx = BoxStx.SelectedValue;

        if (BoxUsl.SelectedValue == null | BoxUsl.SelectedValue == "") TekUsl = 0;
        else TekUsl = Convert.ToInt32(BoxUsl.SelectedValue);
        
        if (TekUsl > 0)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslOneRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@USLDOC", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = TekStx;
            cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = TekUsl;
            cmd.Parameters.Add("@USLIDN", SqlDbType.VarChar).Value = AmbUslIdn;
            cmd.Parameters.Add("@CRDIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            //===============================================================================================================

            getDocNum();

            GetGrid();

        }
    }
    //------------------------------------------------------------------------

    //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
    /*
    protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
    {
        e.Row.Cells[6].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.color = 'red';";
        e.Row.Cells[6].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
        e.Row.Cells[6].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",6)");
    }
    */
    //------------------------------------------------------------------------
    protected void PrtButton_Click(object sender, EventArgs e)
    {
        AmbUslIdn = Convert.ToString(Session["AmbUslIdn"]);
        // --------------  печать ----------------------------

        if (Col003.Value != "0%")  // Группа
            Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbUzi003&TekDocIdn=" + AmbUslIdn);
        else
            if (Col004.Value != "0%")  // Подгруппа
                Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbUzi002&TekDocIdn=" + AmbUslIdn);
            else
                Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbUzi001&TekDocIdn=" + AmbUslIdn);
    }
    //===============================================================================================================
    //===============================================================================================================
    //===============================================================================================================

</script>


<body>
    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="Col003" runat="server" />
        <asp:HiddenField ID="Col004" runat="server" />


        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 600px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%">

                      <asp:Label id="Label5" Text="№ НАПР:" runat="server"  Width="8%" Font-Bold="true" /> 
                      <asp:TextBox ID="TxtNap" Width="10%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                      <asp:Label id="Label1" Text="СТРАХ:" runat="server"  Width="7%" Font-Bold="true" /> 
                      <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxStx"
                            Width="25%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"
                            DataSourceID="sdsStx"
                            DataTextField="StxNam"
                            DataValueField="StxKod" />

                      <asp:Label id="Label3" Text="НОЗАЛОГ:" runat="server"  Width="10%" Font-Bold="true" /> 
                      <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxNoz"
                            Width="15%"
                            Height="200"
                            EmptyText="Выберите нозологию ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsNoz"
                            DataTextField="NOZNAM"
                            DataValueField="NOZKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>   

                      <asp:Label id="Label2" Text="ЛЬГОТ:" runat="server"  Width="7%" Font-Bold="true" /> 
                      <asp:TextBox ID="TxtLgt" Width="10%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: small;" />
                      <asp:RegularExpressionValidator id="RegularExpressionValidator2"
                            ControlToValidate="TxtLgt"
                            ValidationExpression="\d+"
                            Display="Static"
                            EnableClientScript="true"
                            ErrorMessage="*"
                            runat="server"/>
                      <asp:TextBox ID="TxtZen" Width="0%" Height="20" runat="server" Style="position: relative; font-weight: 700; display:none; font-size: small;" />

                    </td>
                </tr>
                <tr>
                    <td style="width: 100%">
                       <asp:Label id="Label6" Text="УСЛУГА:" runat="server"  Width="8%" Font-Bold="true" /> 
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxUsl"
                            Width="69%"
                            Height="200"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            OnSelectedIndexChanged="BoxUsl_OnSelectedIndexChanged"
                            DataSourceID="sdsUsl"
                            DataTextField="USLNAM"
                            DataValueField="USLKOD" />

                       <asp:Label id="Label4" Text="СУММА:" runat="server"  Width="7%" Font-Bold="true" /> 
                       <asp:TextBox ID="TxtSum" Width="10%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />


                    </td>
                </tr>

            </table>

            <obout:Grid ID="GridUziOne" runat="server"
                ShowFooter="false"
                AllowSorting="false"
                AllowPaging="false"
                AllowPageSizeSelection="false"
                FolderLocalization="~/Localization"
                Language="ru"
                CallbackMode="true"
                Serialize="true"
                AutoGenerateColumns="false"
                FolderStyle="~/Styles/Grid/style_5"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                ShowColumnsFooter="false"
                AllowMultiRecordSelection="false"
                KeepSelectedRecords="false"
                Width="100%"
                PageSize="-1">
                <ScrollingSettings ScrollHeight="480" />
       			<ClientSideEvents OnClientDblClick="onDoubleClick" OnClientCallBack="setEditingRecordOnReload"/>
                <Columns>
                    <obout:Column ID="Column10" DataField="UZIUSLIDN" HeaderText="Идн" ReadOnly="true" Visible="false" Width="0%" />
                    <obout:Column ID="Column11" DataField="UZIUSLAMB" HeaderText="Идн" ReadOnly="true" Visible="false" Width="0%" />
                    <obout:Column ID="Column12" DataField="UZIUSLREF" HeaderText="Идн" ReadOnly="true" Visible="false" Width="0%" />
                    <obout:Column ID="Column13" DataField="UZIUSLGRP" HeaderText="Группа" ReadOnly="true" Width="0%" />
                    <obout:Column ID="Column14" DataField="UZIUSLPGR" HeaderText="Подгруппа" ReadOnly="true" Width="25%" />
                    <obout:Column ID="Column15" DataField="UZIUSLSAP" HeaderText="Параметры" ReadOnly="true" Wrap="true" Width="20%" />
                    <obout:Column ID="Column16" DataField="UZIUSLVAL" HeaderText="Данные исследования" Wrap="true" ItemStyle-Font-Overline="true" Width="50%" />
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="TxtEditTemplate">
                        <Template>
                            <input type="text" style="font-size: 14px" class="excel-textbox" value="<%# Container.Value %>" ondblclick="markAsDblClick(this, '<%# GridUziOne.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)"
                                onfocus="markAsFocused(this)" onblur="markAsBlured(this, '<%# GridUziOne.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>
        </asp:Panel>

            <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px%; position: relative; top: -10px; width: 100%; height: 25px;">
                <center>
                     <asp:Button ID="ButRef" runat="server" CommandName="Add" Text="Обновить" OnClick="BoxUsl_OnSelectedIndexChanged" />
                     <asp:Button ID="PrtButton" runat="server" CommandName="Add" Text="Печать" OnClick="PrtButton_Click" />
               </center>
            </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

   <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="UziWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""  OnClientClose="WindowClose();"
            Left="200" Top="100" Height="300" Width="800" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="">

            <asp:TextBox ID="UziText" Width="100%" Height="300" runat="server" TextMode="MultiLine" Style="font-weight: 700; font-size: large; text-align: left" />
             
          </owd:Window>

    </form>

     <%--
                        <TemplateSettings TemplateId="TxtEditTemplate" />
                    </obout:Column>

    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="HspAmbUslKodSou" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
        <SelectParameters>
            <asp:SessionParameter SessionField="BUXFRMKOD" Name="BuxFrmKod" Type="String" />
            <asp:SessionParameter SessionField="BUXKOD" Name="BuxKod" Type="String" />
            <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
            <asp:SessionParameter SessionField="AMBUSLIDN" Name="AmbUslIdn" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
  --%>  

     <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>



    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        
        .ob_gCc2{
    white-space: -moz-pre-wrap !important;
    white-space: -pre-wrap; 
    white-space: -o-pre-wrap; 
    white-space: pre-wrap;
    word-wrap: break-word;
     }

        /* Body rows */
.ob_gBody tbody .ob_gC, .ob_gBody tbody .ob_gCW 
{
     height: 50px !important;
}

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

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

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

    white-space: -moz-pre-wrap !important;
    white-space: -pre-wrap; 
    white-space: -o-pre-wrap; 
    white-space: pre-wrap;
    word-wrap: break-word;


        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }

    </style>



</body>

</html>



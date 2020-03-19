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

        function saveExcelChanges() {
        //    alert("saveExcelChanges15=");
            var excelData = new Array();
            var rowsContainer = GridUziOne.GridBodyContainer.firstChild.firstChild.childNodes[1];

            for (var i = 0; i < rowsContainer.childNodes.length; i++) {

                var row = rowsContainer.childNodes[i];
                var rowData = new Array();

                var textboxes = row.childNodes[0].firstChild.firstChild.getElementsByTagName('INPUT');
                rowData.push(textboxes[0].value);

                var textboxes2 = row.childNodes[6].firstChild.firstChild.getElementsByTagName('INPUT');
                rowData.push(textboxes2[0].value);
                /*
                for (var j = 0; j < row.childNodes.length - 1; j++) {
                    var textboxes = row.childNodes[j].firstChild.firstChild.getElementsByTagName('INPUT');
                    rowData.push(textboxes[0].value);
                }
                */
                excelData.push(rowData.join('|*cell*|'));
            }
            //   this.ExcelDataContainer.value = excelData.join('|*row*|');
            document.getElementById('GridUziOneExcelData').value = excelData.join('|*row*|');
        //    alert("saveExcelChanges16=" + document.getElementById('GridUziOneExcelData').value);

            return true;
        }

        function exportToExcel() {
            GridUziOne.exportToExcel("Отчет", false, true, false, true);

            return false;
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
    
    protected void SaveChanges(object sender, EventArgs e)
    {
 //       OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));
 //       myConn.Open();

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // extract the rows to insert/update from the hidden field
        string excelData = GridUziOneExcelData.Value;

        // extract the ids of the rows to delete from the hidden field
        string excelDeletedIds = GridUziOneExcelDeletedIds.Value;

        string[] rowSeparator = new string[] { "|*row*|" };
        string[] cellSeparator = new string[] { "|*cell*|" };

        string[] dataRows = excelData.Split(rowSeparator, StringSplitOptions.None);

        for (int i = 0; i < dataRows.Length; i++)
        {
            string[] dataCells = dataRows[i].Split(cellSeparator, StringSplitOptions.None);

            string UziIdn = dataCells[0];
            string UziParVal = dataCells[1];    // изм. данные

  //          string insertUpdateQuery = "";
  //          if (!string.IsNullOrEmpty(UziParVal))
  //          {
  //              insertUpdateQuery = "UPDATE Orders SET ShipName = @ShipName, ShipCity = @ShipCity, ShipAddress = @ShipAddress, ShipCountry = @ShipCountry, OrderDate = @OrderDate, Sent = @Sent WHERE OrderID = @OrderID";
  //          }
  //          else
   //         {
    //            insertUpdateQuery = "INSERT INTO Orders (ShipName, ShipCity, ShipAddress, ShipCountry, OrderDate, Sent) VALUES(@ShipName, @ShipCity, @ShipAddress, @ShipCountry, @OrderDate, @Sent)";
    //        }

         //   OleDbCommand myComm = new OleDbCommand(insertUpdateQuery, myConn);
            // создание команды
              SqlCommand cmd = new SqlCommand("HspAmbUslDtlRep", con);
              cmd = new SqlCommand("HspAmbUslDtlRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@USLDTLIDN", SqlDbType.VarChar).Value = UziIdn;
            cmd.Parameters.Add("@USLDTLVAL", SqlDbType.VarChar).Value = UziParVal;

            if (!string.IsNullOrEmpty(UziIdn))
            {
                cmd.ExecuteNonQuery();

            }

        }

        
 //       if (!string.IsNullOrEmpty(excelDeletedIds))
 //       {
 //           // delete the rows that were deleted
 //           OleDbCommand deleteComm = new OleDbCommand("DELETE FROM Orders WHERE OrderID IN (" + excelDeletedIds + ")", myConn);
 //           deleteComm.ExecuteNonQuery();
 //       }

        con.Close();

        GetGrid();
    }
    
    
    
    
</script>


<body>
    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="Col003" runat="server" />
        <asp:HiddenField ID="Col004" runat="server" />
        <asp:HiddenField ID="GridUziOneExcelDeletedIds" runat="server"/>
        <asp:HiddenField ID="GridUziOneExcelData" runat="server"/>   

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
                CallbackMode="false"
                Serialize="false"
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
                <TemplateSettings MultiRecordSaveCancel_TemplateId="ButtonsTemplate2" />
              <Columns>
                    <obout:Column ID="Column10" DataField="UZIUSLIDN" HeaderText="Идн1" ReadOnly="true" Visible="false" Width="0%" >
                           <TemplateSettings TemplateId="ReadOnlyTemplate" />
                    </obout:Column>			
                    <obout:Column ID="Column11" DataField="UZIUSLAMB" HeaderText="Идн2" ReadOnly="true" Visible="false" Width="0%" />
                    <obout:Column ID="Column12" DataField="UZIUSLREF" HeaderText="Идн3" ReadOnly="true" Visible="false" Width="0%" />
                    <obout:Column ID="Column13" DataField="UZIUSLGRP" HeaderText="Группа" ReadOnly="true" Width="0%" />
                    <obout:Column ID="Column14" DataField="UZIUSLPGR" HeaderText="Подгруппа" ReadOnly="true" Width="25%" />
                    <obout:Column ID="Column15" DataField="UZIUSLSAP" HeaderText="Параметры" ReadOnly="true" Wrap="true" Width="20%" />
                    <obout:Column ID="Column16" DataField="UZIUSLVAL" HeaderText="Данные исследования" Wrap="true" ItemStyle-Font-Overline="true" Width="50%" >
                         <TemplateSettings TemplateId="MultiLineTextBoxEditTemplate" />
                    </obout:Column>
               </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="MultiLineTextBoxEditTemplate">
                       <Template>
                             <input type="text" name="TextBox1" class="excel-textbox" value='<%# Container.Value %>' readonly="readonly"
                                    onfocus="GridUziOne.editWithMultiLineTextBox(this)" />
                        </Template>
                    </obout:GridTemplate>
              
                   <obout:GridTemplate runat="server" ID="ButtonsTemplate2">
                      <Template>
                      </Template>
                   </obout:GridTemplate>
                
                   <obout:GridTemplate runat="server" ID="ReadOnlyTemplate">
                      <Template>
                          <input type="text" name="TextBox1" class="excel-textbox" value='<%# Container.Value %>' readonly="readonly" />
                          </Template>
                   </obout:GridTemplate>

                </Templates>

            </obout:Grid>

     <div style="display: none;" id="FieldEditorsContainer">
        <div id="MultiLineTextBoxEditorContainer" style="width: 100%">
            <obout:OboutTextBox runat="server" ID="MultiLineTextBoxEditor" TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox" Width="100%" Height="40" AutoCompleteType="None">
                <ClientSideEvents OnKeyDown="navigateThroughCells" />
            </obout:OboutTextBox>
        </div>
    </div>


        </asp:Panel>

            <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px%; position: relative; top: -10px; width: 100%; height: 25px;">
                <center>
                     <asp:Button ID="ButRef" runat="server" CommandName="Add" Text="Обновить" OnClick="BoxUsl_OnSelectedIndexChanged" />
                     <asp:Button ID="Button1" runat="server" CommandName="Add" Text="Сохранить" OnClientClick="return saveExcelChanges()" OnClick="SaveChanges" />
                     <asp:Button ID="PrtButton" runat="server" CommandName="Add" Text="Печать" OnClick="PrtButton_Click" />
               </center>
            </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ 
      
                      <input type="button" name="PrtButton" value="Экспрот в Excel" id="ExlButton" onclick="exportToExcel(); return false;" />
                       <obout:OboutButton ID="OboutButton2" runat="server" Text="Save Changes" OnClientClick="return saveExcelChanges()" OnClick="SaveChanges" />
    
      
      --%>

   <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <script type="text/javascript">
             window.onload = function () {
                 GridUziOne.convertToExcel(
                         ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
                         '<%=GridUziOneExcelData.ClientID %>',
                         '<%=GridUziOneExcelDeletedIds.ClientID %>'
                );
             }

 
        </script>

          <script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>

    </form>


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
            .ob_gFAL
    {
        position: relative;
        top: -3px;
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

    </style>



</body>



</html>



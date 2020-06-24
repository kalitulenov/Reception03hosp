<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
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

        // ==================================== при выборе клиента показывает его программу  ============================================
        function OnButtonApt() {
            AptWindow.Open();

        }
/*
        function OnClientDblClick(iRecordIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parNazIdn').value;

            var DatDocVal = GridApt.Rows[iRecordIndex].Cells[1].Value;
            TxtNaz.value = DatDocVal;

            AptWindow.Close();

            SqlStr = "UPDATE AMBNAZ SET NAZPLNOBS='" + DatDocVal + "' WHERE NAZIDN=" + DatDocIdn;

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () {  }
            });
        }
*/

        function OnClientSelect(selectedRecords) {
            var AmbCrdIdn = selectedRecords[0].GRFIDN;
            //        alert("AmbCrdIdn=" + AmbCrdIdn);Наименование

            var DatDocMdb = 'HOSPBASE';
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parNazIdn').value;

//          var DatDocVal = GridApt.Rows[iRecordIndex].Cells[1].Value;
            var DatDocVal = selectedRecords[0].Наименование;
            TxtNaz.value = DatDocVal;

            AptWindow.Close();

            SqlStr = "UPDATE AMBNAZ SET NAZPLNOBS='" + DatDocVal + "' WHERE NAZIDN=" + DatDocIdn;
            //                  alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { }
            });
        }


        //error: function () { alert("ERROR=" + SqlStr); }
//  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
  //          alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = newText;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parNazIdn').value;

            DatDocVal = DatDocVal.replace("\\", "\u002F");
            DatDocVal = DatDocVal.replace("\\", "\u002F");
            DatDocVal = DatDocVal.replace("\\", "\u002F");
            DatDocVal = DatDocVal.replace("\\", "\u002F");
            DatDocVal = DatDocVal.replace("\\", "\u002F");
            DatDocVal = DatDocVal.replace("\\", "\u002F");

            DatDocVal = DatDocVal.replace("\"", "\\u0022");
            DatDocVal = DatDocVal.replace("\"", "\\u0022");
            DatDocVal = DatDocVal.replace("\"", "\\u0022");
            DatDocVal = DatDocVal.replace("\"", "\\u0022");
            DatDocVal = DatDocVal.replace("\"", "\\u0022");
            DatDocVal = DatDocVal.replace("\"", "\\u0022");

            DatDocVal = DatDocVal.replace("\'", "\\u0022");
            DatDocVal = DatDocVal.replace("\'", "\\u0022");
            DatDocVal = DatDocVal.replace("\'", "\\u0022");
            DatDocVal = DatDocVal.replace("\'", "\\u0022");
            DatDocVal = DatDocVal.replace("\'", "\\u0022");
            DatDocVal = DatDocVal.replace("\'", "\\u0022");

            var SqlStr = "";
            switch (sender) {
                case 'TxtNaz':
                    SqlStr = "UPDATE AMBNAZ SET NAZPLNOBS='" + DatDocVal + "' WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'TxtDni':
                    SqlStr = "UPDATE AMBNAZ SET NAZDNI=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'TxtKol':
                    DatDocVal = DatDocVal.replace(",", ".");

                    if (DatDocVal == "") {alert("Кол-во не указан " + DatDocVal); return false;}

                    var strCheck = "0123456789.";
                    var i;

                    for (i in DatDocVal) {
                //        alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                        if (strCheck.indexOf(DatDocVal[i]) == -1) { alert("Ошибка в количестве " + DatDocVal); return false; }
                    }

                    SqlStr = "UPDATE AMBNAZ SET NAZKOLTAB=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
            }
        //          alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { }
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parNazIdn').value;

            switch (sender.ID) {
                case 'BoxBln':
                    DatDocVal = BoxBln.options[BoxBln.selectedIndex()].value;
                    SqlStr = "UPDATE AMBNAZ SET NAZBLN=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'BoxPrm':
                    DatDocVal = BoxPrm.options[BoxPrm.selectedIndex()].value;
                    SqlStr = "UPDATE AMBNAZ SET NAZPRMTAB=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'BoxKrt':
                    DatDocVal = BoxKrt.options[BoxKrt.selectedIndex()].value;
                    SqlStr = "UPDATE AMBNAZ SET NAZKRTTAB=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'BoxMtd':
                    DatDocVal = BoxMtd.options[BoxMtd.selectedIndex()].value;
                    SqlStr = "UPDATE AMBNAZ SET NAZMTDTAB=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
                    break;
                case 'BoxEdn':
                    DatDocVal = BoxEdn.options[BoxEdn.selectedIndex()].value;
                    SqlStr = "UPDATE AMBNAZ SET NAZEDNTAB=" + DatDocVal + " WHERE NAZIDN=" + DatDocIdn;
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
                error: function () {}
            });

        }

        function OnClientDateChanged(sender, selectedDate) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek = 'NAZDATNAZ';
            var DatDocVal = TxtDat.value;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parNazIdn').value;

            SqlStr = "UPDATE AMBNAZ SET NAZDATNAZ=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE NAZIDN=" + DatDocIdn;
 //           alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { }
            });
        }

        function onCheckedChanged(sender, isChecked) {
            //    alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
            //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
            //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
            //            alert('SelectedIndexChanged: ' + selectedIndex);
            //            alert('sender: ' + sender.ID);

            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = isChecked;
            var DatDocTyp = 'Str';

            var DatDocIdn = document.getElementById('parNazIdn').value;
 //           alert(" isChecked " + DatDocVal + ' ' + DatDocIdn);

//            if (DatDocVal == true) SqlStr = "UPDATE AMBNAZ SET NAZRZPFLG=1 WHERE NAZIDN=" + DatDocIdn;
//            else SqlStr = "UPDATE AMBNAZ SET NAZRZPFLG=0 WHERE NAZIDN=" + DatDocIdn;

            if (DatDocVal == true) SqlStr = "HspAmbNazChkRep&@NAZIDN&" + DatDocIdn + "&@NAZRZPFLG&1";
            else SqlStr = "HspAmbNazChkRep&@NAZIDN&" + DatDocIdn + "&@NAZRZPFLG&0";

   //                                  alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () {}
            });

        }
        //    ---------------- обращение веб методу --------------------------------------------------------

        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBNAZDTL';
            var DatDocKey = 'NAZDTLIDN';



  //          SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                       alert("SqlStr=" + SqlStr);

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

//  -------------------- Проверка на число ---------------------------------
        function isNumeric(evt) {
            var c = (evt.which) ? evt.which : event.keyCode
            if ((c >= '0' && c <= '9') || c == '.') return true;
            return false;
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbNazIdn;
    string AmbNazIdnTek;
    string AmbNazTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbNazIdn = Convert.ToString(Request.QueryString["AmbNazIdn"]);
        if (AmbNazIdn == "0") AmbNazTyp = "ADD";
        else AmbNazTyp = "REP";
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("AmbNazIdn ", AmbNazIdn);

        sdsBln.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsBln.SelectCommand = "SELECT NazBlnKod,NazBlnNam FROM SprNazBln";
        sdsPrm.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsPrm.SelectCommand = "SELECT PrmKod,PrmNam FROM SprNazPrm ORDER By PrmNam";
        sdsKrt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrt.SelectCommand = "SELECT KrtKod,KrtNam FROM SprNazKrt";
        sdsEdn.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsEdn.SelectCommand = "SELECT EdnLekKod,EdnLekNam FROM SprEdnLek";


        if (!Page.IsPostBack)
        {
            TxtNaz.Attributes.Add("onchange", "onChange('TxtNaz',TxtNaz.value);");
            TxtDni.Attributes.Add("onchange", "onChange('TxtDni',TxtDni.value);");
            TxtKol.Attributes.Add("onchange", "onChange('TxtKol',TxtKol.value);");
 //           TxtKol.Attributes.Add("onkeypress", "return isNumeric(event)");
            //============= Установки ===========================================================================================
            AmbNazIdnTek = (string)Session["AmbNazIdn"];
            if (AmbNazIdnTek != "Post")
            {
                if (AmbNazIdn == "0")  // новый документ
                {
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbNazWinAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                    cmd.Parameters.Add("@NAZIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@NAZIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbNazIdn = Convert.ToString(cmd.Parameters["@NAZIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }

            Session["AmbNazIdn"] = Convert.ToString(AmbNazIdn);
            parNazIdn.Value = AmbNazIdn;

            getDocNum();
//            GetGrid();
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
        SqlCommand cmd = new SqlCommand("SELECT * FROM AMBNAZ WHERE NAZIDN=" + AmbNazIdn, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "NazOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
//            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRNazNAM"]);
            BoxPrm.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZPRMTAB"]);
            BoxKrt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZKRTTAB"]);
  //          BoxMtd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZMTDTAB"]);
            BoxBln.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZBLN"]);
            BoxEdn.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["NAZEDNTAB"]);

            TxtRzp.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZNUMBLN"]);
            TxtNaz.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZPLNOBS"]);
            TxtKol.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZKOLTAB"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["NAZDATNAZ"].ToString())) TxtDat.Text = "";
            else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["NAZDATNAZ"]).ToString("dd.MM.yyyy");
            TxtDni.Text = Convert.ToString(ds.Tables[0].Rows[0]["NAZDNI"]);
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["NAZRZPFLG"].ToString())) ChkPrz.Checked = false;
            else ChkPrz.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["NAZRZPFLG"]);
        }
        else
        {
 //           BoxTit.Text = "Новая запись";
   //         BoxNaz.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    // ==================================== поиск клиента по фильтрам  ============================================
    protected void FndBtn_Click(object sender, EventArgs e)
    {
        string whereClause = "";

        whereClause = "";
        if (FndTxt.Text != "") whereClause += "%" + FndTxt.Text.Replace("'", "''") + "%";

        if (whereClause != "")
        {
            whereClause = whereClause.Replace("*", "%");

            if (whereClause.IndexOf("SELECT") != -1) return;
            if (whereClause.IndexOf("UPDATE") != -1) return;
            if (whereClause.IndexOf("DELETE") != -1) return;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbNazApt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@CLAUSE", SqlDbType.VarChar).Value = whereClause;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbNazApt");
            
            GridApt.DataSource = ds;
            GridApt.DataBind();
       
            con.Close();            
           
        }
    }

                // ------------------------------------------------------------------------------заполняем второй уровень

        // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parNazIdn" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="№ РЕЦЕПТА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtRzp" Width="20%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label1" Text="БЛАНК:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxBln"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите бланк ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsBln"
                            DataTextField="NAZBLNNAM"
                            DataValueField="NAZBLNKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
                       <asp:Button ID="ButApt" runat="server"
                                                OnClientClick="OnButtonApt()"
                                                Width="10%" CommandName="" CommandArgument=""
                                                Text="Аптека" Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>
 
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label2" Text="НАЗНАЧЕНИЕ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtNaz" Width="50%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="ПРИМЕНЕНИЕ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxPrm"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите применение ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsPrm"
                            DataTextField="PRMNAM"
                            DataValueField="PRMKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
 
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label9" Text="ЕД.ИЗМ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxEdn"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите применение ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsEdn"
                            DataTextField="EDNLEKNAM"
                            DataValueField="EDNLEKKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
 
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label10" Text="КОЛ.ЗА ОДИН ПРИЕМ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtKol" Width="20%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />

                        <asp:RegularExpressionValidator ID="regexTxtKol" ControlToValidate="TxtKol" SetFocusOnError="True" 
                                   ValidationExpression="(?!^0*$)(?!^0*\.0*$)^\d{1,18}(\.\d{1,2})?$" ErrorMessage="Ошибка" runat="server" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label6" Text="КРАТНОСТЬ:" runat="server" Width="25%" Font-Bold="true"  Font-Size="Medium"/>
                        <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxKrt"
                            Width="40%"
                            Height="200"
                            EmptyText="Выберите кратность ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsKrt"
                            DataTextField="KRTNAM"
                            DataValueField="KRTKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label3" Text="ДАТА НАЗНАЧЕНИЯ:" runat="server" Width="25%" Font-Bold="true"  Font-Size="Medium"/>
                        <asp:TextBox ID="TxtDat" Width="20%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="calNaz" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtDat"
                               OnClientDateChanged="OnClientDateChanged"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label7" Text="КОЛ ДНЕЙ:" runat="server" Width="25%" Font-Bold="true" />
                        <asp:TextBox ID="TxtDni" Width="20%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                   </td>
                </tr>

               <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label8" Text="НА ИСПОЛНЕНИЕ:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkPrz" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                            <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                </obout:OboutCheckBox>  

                    </td>
                </tr>

               <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label11" Text="СМС НАПОМИНАНИЕ:" runat="server" Width="25%" Font-Bold="true" />
                        <obout:OboutCheckBox runat="server" ID="ChkSms" Enabled="false" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                             <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		                </obout:OboutCheckBox>  

                    </td>
                </tr>

            </table>

        </asp:Panel>

       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
     <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="AptWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="10" Height="300" Width="700" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Тарификатор">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="10%" class="PO_RowCap" align="center">Лекарство:</td>
                    <td width="30%">
                        <asp:TextBox ID="FndTxt" Width="100%" Height="20" runat="server" OnTextChanged="FndBtn_Click"
                            Style="font-weight: 700; font-size: large;" />
                    </td>

                    <td width="10%">
                        <asp:Button ID="FndBtn" runat="server"
                            OnClick="FndBtn_Click"
                            Width="100%" CommandName="Cancel"
                            Text="Поиск" Height="25px"
                            Style="top: 0px; left: 0px" />
                    </td>
                </tr>
            </table>

            <oajax:CallbackPanel ID="CallbackPanelApt" runat="server">
             <Content>    
                        
             <obout:Grid ID="GridApt"
                  runat="server"
                  CallbackMode="true"
                  Serialize="true"
                  AutoGenerateColumns="false"
                  FolderStyle="~/Styles/Grid/style_5"
                  AllowAddingRecords="false"
                  ShowLoadingMessage="true"
                  ShowColumnsFooter="false"
                  KeepSelectedRecords="true"
                  Width="100%"
                  PageSize="-1"
                  ShowFooter="false">
                 <ClientSideEvents OnClientSelect="OnClientSelect" />
                 <Columns>
                      <obout:Column ID="Column0" DataField="Код" HeaderText="Идн" ReadOnly="true" Width="0%" Visible="false" />
                      <obout:Column ID="Column1" DataField="Наименование" HeaderText="Наименование" ReadOnly="true" Width="70%"  Align="left"/>
                      <obout:Column ID="Column2" DataField="ЕдИзм" HeaderText="Ед.изм" ReadOnly="true" Width="10%" Align="left" />
                      <obout:Column ID="Column3" DataField="Цена" HeaderText="Цена" ReadOnly="true" Width="10%" Align="left" />
                      <obout:Column ID="Column4" DataField="Кол" HeaderText="Кол" ReadOnly="true" Width="10%" Align="left" />
                </Columns>
                <ScrollingSettings ScrollHeight="280" ScrollWidth="100%" />
              </obout:Grid>  
                             
             </Content>
           </oajax:CallbackPanel>
             
          </owd:Window>
    </form>

    <asp:SqlDataSource runat="server" ID="sdsBln" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsPrm" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>




    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
            font-size: 12px !important;  /* для увеличения коррект поля */
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

</html>



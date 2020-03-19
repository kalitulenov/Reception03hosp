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
        function OnButtonNam() {
            //           alert("OnButtonNam=");
            //            alert("parSpr001.value=" + parSpr001.value);
            if (parSpr001.value != "" && parSpr001.value != "0") {
                parSprNum.value = "1";
                FndWindow.Open();
            }
        }

        function OnButtonAnl() {
            if (parSpr002.value != "" && parSpr002.value != "0") {
                parSprNum.value = "2";
                FndWindow.Open();
            }
        }

        function OnClientSelectNam(selectedRecords) {
            var FndSpr = selectedRecords[0].FNDSPR;
            var FndKod = selectedRecords[0].FNDKOD;
            var FndTxt = selectedRecords[0].FNDTXT;
            //        alert("AmbCrdIdn=" + AmbCrdIdn);Наименование

            var DatDocMdb = 'HOSPBASE';
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parDtlIdn').value;

//          var DatDocVal = GridFnd.Rows[iRecordIndex].Cells[1].Value;
            //            var DatDocVal = selectedRecords[0].Наименование;
     //       alert("parSprNum.value=" + parSprNum.value);

            if (parSprNum.value == "1") {
                TxtNam.value = FndTxt;
 //               if (ChkBox001.checked == true) 
 //                   SqlStr = "UPDATE TABDOCDTL SET DTLKRDSPR=" + FndSpr + ",DTLKRDSPRVAL='" + FndKod + "' WHERE DTLIDN=" + DatDocIdn;
 //               else
                    SqlStr = "UPDATE TABDOCDTL SET DTLDEBSPR=" + FndSpr + ",DTLDEBSPRVAL='" + FndKod + "' WHERE DTLIDN=" + DatDocIdn;
           }

            if (parSprNum.value == "2") {
                TxtAnl.value = FndTxt;
                alert("TxtAnl.value=" + TxtAnl.value);
                //               if (ChkBox001.checked == true)
 //                   SqlStr = "UPDATE TABDOCDTL SET DTLKRDOBR=" + FndSpr + ",DTLKRDOBRVAL='" + FndKod + "' WHERE DTLIDN=" + DatDocIdn;
 //               else
                    SqlStr = "UPDATE TABDOCDTL SET DTLDEBOBR=" + FndSpr + ",DTLDEBOBRVAL='" + FndKod + "' WHERE DTLIDN=" + DatDocIdn;
            }

            FndWindow.Close();

   //         alert("SqlStr=" + SqlStr);

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
            var DatDocIdn = document.getElementById('parDtlIdn').value;

            var SqlStr = "";
            switch (sender) {
                case 'TxtNum':
                    SqlStr = "UPDATE TABDOCDTL SET DTLNUM=" + DatDocVal + " WHERE DTLIDN=" + DatDocIdn;
                    break;
                case 'TxtSum':
                    DatDocVal = DatDocVal.replace(",", ".");

                    if (DatDocVal == "") { alert("Cумма не указан " + DatDocVal); return false; }

                    var strCheck = "0123456789.";
                    var i;

                    for (i in DatDocVal) {
                        //        alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                        if (strCheck.indexOf(DatDocVal[i]) == -1) { alert("Ошибка в сумме " + DatDocVal); return false; }
                    }

                    SqlStr = "UPDATE TABDOCDTL SET DTLSUM=" + DatDocVal + " WHERE DTLIDN=" + DatDocIdn;
                    break;
                case 'TxtMem':
                    SqlStr = "UPDATE TABDOCDTL SET DTLMEM='" + DatDocVal + "' WHERE DTLIDN=" + DatDocIdn;
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
                error: function () { }
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parDtlIdn').value;

            switch (sender.ID) {
                case 'BoxAcc':
                    DatDocVal = BoxAcc.options[BoxAcc.selectedIndex()].value;
                    SqlStr = "UPDATE TABDOCDTL SET DTLDEB='" + DatDocVal + "',DTLDEBSPR=0,DTLDEBSPRVAL='',DTLDEBOBR=0,DTLDEBOBRVAL='' WHERE DTLIDN=" + DatDocIdn;
                    break;
                case 'BoxSpz':
                    DatDocVal = BoxSpz.options[BoxSpz.selectedIndex()].value;
                    SqlStr = "UPDATE TABDOCDTL SET DTLGRP=" + DatDocVal + " WHERE DTLIDN=" + DatDocIdn;
                    break;
                default:
                    break;
            }

   //       alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () {}
            });

            if (sender.ID == 'BoxAcc')
            {
                DatDocIdn = document.getElementById('parBnkIdn').value;
                var ParStr = document.getElementById('parBuxSid').value + ':' + document.getElementById('parBuxFrm').value + ':' + DatDocVal + ':' + DatDocIdn + ':';
                document.getElementById('TxtNam').value = "";
                document.getElementById('TxtAnl').value = "";

                $.ajax({
                    type: 'POST',
                    url: '/HspUpdDoc.aspx/BuxAccKodSpr',
                    contentType: "application/json; charset=utf-8",
                    data: '{"ParStr":"' + ParStr + '"}',
                    dataType: "json",
                    success: function (msg) {
                //        alert("msg=" + msg);
                //        alert("msg.d=" + msg.d);
                        //                                alert("msg.d2=" + msg.d.substring(0, 3));
                        //                                alert("msg.d3=" + msg.d.substring(3, 7));
                        var hashes = msg.d.split(':');
                        parSpr001.value = hashes[0];
                        parSpr002.value = hashes[1];
                        parSpr003.value = hashes[2];
               //         alert("parSpr001.value=" + parSpr001.value);
                //        alert("parSpr002.value=" + parSpr002.value);
               //         alert("parSpr003.value=" + parSpr003.value);
                    },
                    error: function () { }
                });
            }

        }
        //    ------------------------------------------------------------------------------------------------------------------------


        function onCheckedChanged(sender, isChecked) {
       //         alert('The checked state of ' + sender.ID + ' has been changed to: ' + isChecked + '.');
            //            alert('Selected item: ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].text);
            //            alert('Selected value): ' + BoxDocPvd.options[BoxDocPvd.selectedIndex()].value);
            //            alert('SelectedIndexChanged: ' + selectedIndex);
            //            alert('sender: ' + sender.ID);
            var DatDocMdb = 'HOSPBASE';
            var DatDocTyp = 'Sql';
            var DatDocIdn = document.getElementById('parDtlIdn').value;

            switch (sender.ID) {
                case 'ChkBox001':
                    if (isChecked == true) ChkBox002.checked(false);
                    else ChkBox002.checked(true);
                    SqlStr = "UPDATE TABDOCDTL SET DTLOPR='+' WHERE DTLIDN=" + DatDocIdn;
                    break;
                case 'ChkBox002':
                    ChkBox001.value = false;
                    if (isChecked == true) ChkBox001.checked(false);
                    else ChkBox001.checked(true);
                    SqlStr = "UPDATE TABDOCDTL SET DTLOPR='-' WHERE DTLIDN=" + DatDocIdn;
                    break;
                default:
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
    string BuxBnkIdn;
    string BuxDtlIdn;
    string BuxDtlIdnTek;
    string AmbBnkTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        BuxBnkIdn = Convert.ToString(Request.QueryString["BuxBnkIdn"]);
        BuxDtlIdn = Convert.ToString(Request.QueryString["BuxDtlIdn"]);
        parBnkIdn.Value = BuxBnkIdn;
        parDtlIdn.Value = BuxDtlIdn;

        //       if (BuxDtlIdn == "0") AmbBnkTyp = "ADD";
        //       else AmbBnkTyp = "REP";

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        parBuxSid.Value = BuxSid;

        //     AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("BuxBnkIdn ", BuxBnkIdn);

        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

        sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDeb.SelectCommand = "SELECT BUXKOD,SprBuxKdr.FIO AS BUXNAM FROM SprBuxKdr WHERE BuxFrm=" + BuxFrm + " ORDER BY FIO";

        sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrd.SelectCommand = "SELECT BUXKOD,SprBuxKdr.FIO AS BUXNAM FROM SprBuxKdr WHERE BuxFrm=" + BuxFrm + " ORDER BY FIO";

        sdsSpz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSpz.SelectCommand = "SELECT BuxSpzKod,BuxSpzNam FROM SPRBUXSPZ ORDER BY BUXSPZNAM";

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  //&& AmbCrdIdn == "0"
        {
            Session["BuxDtlIdn"] = "Post";
            //    PushButton();
            //                AmbCrdIdn = parCrdIdn.Value;
        }

        if (!Page.IsPostBack)
        {
            TxtNum.Attributes.Add("onchange", "onChange('TxtNum',TxtNum.value);");
            TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
            TxtMem.Attributes.Add("onchange", "onChange('TxtMem',TxtMem.value);");
            //           TxtKol.Attributes.Add("onkeypress", "return isNumeric(event)");
            //============= Установки ===========================================================================================
            BuxDtlIdnTek = (string)Session["BuxDtlIdn"];
            if (BuxDtlIdnTek != "Post")
            {

                if (BuxDtlIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("BuxDocDtlAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Бнк";
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = BuxBnkIdn;
                    cmd.Parameters.Add("@DTLIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@DTLIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        BuxDtlIdn = Convert.ToString(cmd.Parameters["@DTLIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }

                Session["BuxDtlIdn"] = Convert.ToString(BuxDtlIdn);
                parDtlIdn.Value = BuxDtlIdn;

                //           getDocNum();
                //            GetGrid();
            }

        }
        getDocNum();

    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("BuxDocDtlSelIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@BUXIDN", SqlDbType.VarChar).Value = BuxDtlIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxDocDtlSelIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DTLOPR"].ToString()) || Convert.ToString(ds.Tables[0].Rows[0]["DTLOPR"]) == "+")
            {
                ChkBox001.Checked = true;
                ChkBox002.Checked = false;
            }
            else
            {
                ChkBox001.Checked = false;
                ChkBox002.Checked = true;
            }

            BoxAcc.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLDEB"]);
            BoxSpz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["DTLGRP"]);

            TxtNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLNUM"]);
            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLSUM"]);
            TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["DTLMEM"]);

            TxtNam.Text = Convert.ToString(ds.Tables[0].Rows[0]["TXTNAM"]);
            TxtAnl.Text = Convert.ToString(ds.Tables[0].Rows[0]["TXTANL"]);

            parSpr001.Value = Convert.ToString(ds.Tables[0].Rows[0]["ACCSPR001"]);
            parSpr002.Value = Convert.ToString(ds.Tables[0].Rows[0]["ACCSPR002"]);
            parSpr003.Value = Convert.ToString(ds.Tables[0].Rows[0]["ACCSPR003"]);


            /*
 //            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["SPRBnkNAM"]);
             BoxPrm.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BnkPRMTAB"]);
             BoxKrt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BnkKRTTAB"]);
             BoxBln.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BnkBLN"]);
             BoxEdn.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BnkEDNTAB"]);

             TxtBnk.Text = Convert.ToString(ds.Tables[0].Rows[0]["BnkPLNOBS"]);
             TxtKol.Text = Convert.ToString(ds.Tables[0].Rows[0]["BnkKOLTAB"]);

             if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BnkDATBnk"].ToString())) TxtDat.Text = "";
             else TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BnkDATBnk"]).ToString("dd.MM.yyyy");
             TxtDni.Text = Convert.ToString(ds.Tables[0].Rows[0]["BnkDNI"]);
             if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BnkRZPFLG"].ToString())) ChkPrz.Checked = false;
             else ChkPrz.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["BnkRZPFLG"]);
             */
        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            //         BoxBnk.SelectedValue = "";
        }

    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    // ==================================== поиск клиента по фильтрам  ============================================
    protected void FndNamBtn_Click(object sender, EventArgs e)
    {
        if (parSprNum.Value == "1") BuxSprAnlFnd(FndTxt.Text, parSpr001.Value);
        if (parSprNum.Value == "2") BuxSprAnlFnd(FndTxt.Text, parSpr002.Value);
        if (parSprNum.Value == "3") BuxSprAnlFnd(FndTxt.Text, parSpr003.Value);
    }

    // ==================================== поиск клиента по фильтрам  ============================================
    protected void BuxSprAnlFnd(string FndTxt, string BuxSpr)
    {
        string whereClause = "";
        //      string BuxSpr="0";

        whereClause = "";
        if (FndTxt != "") whereClause += "%" + FndTxt.Replace("'", "''") + "%";

        if (whereClause != "")
        {
            whereClause = whereClause.Replace("*", "%");

            if (whereClause.IndexOf("SELECT") != -1) return;
            if (whereClause.IndexOf("UPDATE") != -1) return;
            if (whereClause.IndexOf("DELETE") != -1) return;

            //           if (NumSpr == "1") BuxSpr = parSpr001.Value;
            //           if (NumSpr == "2") BuxSpr = parSpr002.Value;
            //           if (NumSpr == "3") BuxSpr = parSpr003.Value;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("BuxSprAnlFnd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@FNDFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@FNDSPR", SqlDbType.VarChar).Value = BuxSpr;
            cmd.Parameters.Add("@FNDTXT", SqlDbType.VarChar).Value = whereClause;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxSprAnlFnd");

            GridFnd.DataSource = ds;
            GridFnd.DataBind();

            con.Close();

        }
    }


    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBnkIdn" runat="server" />
        <asp:HiddenField ID="parDtlIdn" runat="server" />
        <asp:HiddenField ID="parBuxSid" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parSpr001" runat="server" />
        <asp:HiddenField ID="parSpr002" runat="server" />
        <asp:HiddenField ID="parSpr003" runat="server" />
        <asp:HiddenField ID="parSprNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Выписка банка" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0%; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 400px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                                        
                <tr>
                    <td style="width: 100%; height: 40px;">
                        <asp:Label ID="Label5" Text="№№:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtNum" Width="20%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 40px;">
                      <asp:Label ID="Label7" Text="ПРИХОД:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                      <obout:OboutCheckBox runat="server" ID="ChkBox001"
		                      FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                      <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		               </obout:OboutCheckBox>                           
                   
                   
                      <asp:Label ID="Label3" Text="<span style='padding-left:25px;'> </span> РАСХОД:" runat="server" Width="14%" Font-Bold="true" Font-Size="Medium"  />
                      <obout:OboutCheckBox runat="server" ID="ChkBox002"
		                      FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                      <ClientSideEvents OnCheckedChanged="onCheckedChanged" />
		               </obout:OboutCheckBox>                           
                   </td>
                </tr>

            
                <tr>
                    <td style="width: 100%; height: 40px;">
                        <asp:Label ID="Label11" Text="СЧЕТ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                        <obout:ComboBox runat="server" ID="BoxAcc" Width="20%" Height="200"                    
                               FolderStyle="/Styles/Combobox/Plain"
                               DataSourceID="sdsAcc" DataTextField="ACCKOD" DataValueField="ACCKOD">
                             <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                   </obout:ComboBox>
                    </td>
                </tr>

               <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label12" Text="СУММА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtSum" Width="20%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorDeb" ControlToValidate="TxtSum" SetFocusOnError="True" 
                                   ValidationExpression="(?!^0*$)(?!^0*\.0*$)^\d{1,18}(\.\d{1,2})?$" ErrorMessage="Ошибка" runat="server" />

                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 35px;">
                        <asp:Label ID="Label1" Text="НАИМЕНОВАНИЕ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtNam" Width="43%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                      
                          <input type="button" value="..." onclick="OnButtonNam()" />

 
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 35px;">
                        <asp:Label ID="Label13" Text="АНАЛИТИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtAnl" Width="43%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />

                          <input type="button" value="..." onclick="OnButtonAnl()" />

 
                    </td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 50px; vertical-align: top; ">
                        <asp:Label ID="Label2" Text="ПРИМЕЧАНИЕ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtMem" TextMode="MultiLine" Width="48%" Height="100" runat="server"
                             Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                 
                <tr>
                    <td style="width: 100%; height: 35px;">
                        <asp:Label ID="Label4" Text="СПЕЦИФИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="true"
                            ID="BoxSpz"
                            Width="45%"
                            Height="200"
                            EmptyText="Выберите специфику ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsSpz"
                            DataTextField="BUXSPZNAM"
                            DataValueField="BUXSPZKOD" >
                            <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                        </obout:ComboBox>
 
                    </td>
                </tr>

             </table>

        </asp:Panel>
          <%-- ============================  нижний блок  ============================================ 
              
                         <asp:Button ID="ButNam" runat="server"
                                                OnClientClick="OnButtonNam()"
                                                Width="5%" CommandName="" CommandArgument=""
                                                Text="..." Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />
              
                         <asp:Button ID="ButAnl" runat="server"
                                                OnClientClick="OnButtonAnl()"
                                                Width="5%" CommandName="" CommandArgument=""
                                                Text="..." Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />                        
              
              --%>

  <!-- Как сделать длинный пробел? ---------------------------------------------------------------------------------------------------------- 
     &nbsp; неразрывный пробел
&thinsp; узкий пробел (применяют в двойных словах)
&ensp; средний, разрывной пробел
&emsp; длинный разрывной пробел (примеяют в конце предложений)

      <span style='padding-left:10px;'> </span>
       -->
       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
     <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="FndWindow" runat="server" IsModal="true" ShowCloseButton="true" Status=""
            Left="50" Top="10" Height="300" Width="700" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Тарификатор">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="10%" class="PO_RowCap" align="center">НАИМЕНОВАНИЕ:</td>
                    <td width="30%">
                        <asp:TextBox ID="FndTxt" Width="100%" Height="20" runat="server" OnTextChanged="FndNamBtn_Click"
                            Style="font-weight: 700; font-size: large;" />
                    </td>

                    <td width="10%">
                        <asp:Button ID="FndNamBtn" runat="server"
                            OnClick="FndNamBtn_Click"
                            Width="100%" CommandName="Cancel"
                            Text="Поиск" Height="25px"
                            Style="top: 0px; left: 0px" />
                    </td>
                </tr>
            </table>

            <oajax:CallbackPanel ID="CallbackPanelNam" runat="server">
             <Content>    
                        
             <obout:Grid ID="GridFnd"
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
                 <ClientSideEvents OnClientSelect="OnClientSelectNam" />
                 <Columns>
                      <obout:Column ID="Column10" DataField="FNDSPR" HeaderText="СПР" Visible="false" Width="0%" />
                      <obout:Column ID="Column11" DataField="FNDKOD" HeaderText="КОД" ReadOnly="true" Width="10%" />
                      <obout:Column ID="Column12" DataField="FNDTXT" HeaderText="НАИМЕНОВАНИЕ" ReadOnly="true" Width="90%"  Align="left"/>
                </Columns>
                <ScrollingSettings ScrollHeight="280" ScrollWidth="100%" />
              </obout:Grid>  
                             
             </Content>
           </oajax:CallbackPanel>
             
          </owd:Window>

    </form>

<%-- =================  источник  для КАДРЫ ============================================ --%>
    	    <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsSpz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
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
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>



</body>

</html>



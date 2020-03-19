<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
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
        //      document.getElementById("parDebDat001").value = 'A new value';
        /*
        window.onerror = function () {
             alert(document.getElementById("parError").value);
           document.getElementById('TxtErr').value = "Не указан номер документа";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
        }
*/
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
        function OnButtonDebAnl001() {
            //           alert("OnButtonNam=");
    //        alert("TxtDebSpr001=" + document.getElementById("TxtDebSpr001").value);

            if (document.getElementById("TxtDebSpr001").value != "" && document.getElementById("TxtDebSpr001").value != "0") {
                parSprNum.value = "D1";
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/BuxDoc/BuxFndAnl.aspx?FndSnd=D1&FndSpr=" + document.getElementById("TxtDebSpr001").value, "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/BuxDoc/BuxFndAnl.aspx?FndSnd=D1&FndSpr=" + document.getElementById("TxtDebSpr001").value, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
            }
        }
        function OnButtonDebAnl002() {
            //           alert("OnButtonNam=");
            //            alert("parSpr001.value=" + parSpr001.value);
            if (document.getElementById("TxtDebSpr002").value != "" && document.getElementById("TxtDebSpr002").value != "0") {
                parSprNum.value = "D2";
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/BuxDoc/BuxFndAnl.aspx?FndSnd=D2&FndSpr=" + document.getElementById("TxtDebSpr002").value, "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/BuxDoc/BuxFndAnl.aspx?FndSnd=D2&FndSpr=" + document.getElementById("TxtDebSpr002").value, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
            }
        }

        function OnButtonKrdAnl001() {
            //           alert("OnButtonNam=");
            //            alert("parSpr001.value=" + parSpr001.value);
            if (document.getElementById("TxtKrdSpr001").value != "" && document.getElementById("TxtKrdSpr001").value != "0") {
                parSprNum.value = "K1";
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/BuxDoc/BuxFndAnl.aspx?FndSnd=K1&FndSpr=" + document.getElementById("TxtKrdSpr001").value, "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/BuxDoc/BuxFndAnl.aspx?FndSnd=K1&FndSpr=" + document.getElementById("TxtKrdSpr001").value, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
            }
        }
        function OnButtonKrdAnl002() {
            //           alert("OnButtonNam=");
            //            alert("parSpr001.value=" + parSpr001.value);
            if (document.getElementById("TxtKrdSpr002").value != "" && document.getElementById("TxtKrdSpr002").value != "0") {
                parSprNum.value = "K2";
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/BuxDoc/BuxFndAnl.aspx?FndSnd=K2&FndSpr=" + document.getElementById("TxtKrdSpr002").value, "ModalPopUp", "toolbar=no,width=800,height=450,left=350,top=150,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/BuxDoc/BuxFndAnl.aspx?FndSnd=K2&FndSpr=" + document.getElementById("TxtKrdSpr002").value, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:150px;dialogWidth:800px;dialogHeight:450px;");
            }
        }

        //error: function () { alert("ERROR=" + SqlStr); }
//  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        //    ------------------------------------------------------------------------------------------------------------------------

        function OnSelectedIndexChanged(sender, selectedIndex) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocRek;
            var DatDocVal = 0;
            var DatDocIdn = document.getElementById('parPrvIdn').value;

            switch (sender.ID) {
                case 'BoxDeb':
                    DatDocVal = BoxDeb.options[BoxDeb.selectedIndex()].value;
                    break;
                case 'BoxKrd':
                    DatDocVal = BoxKrd.options[BoxKrd.selectedIndex()].value;
                    break;
                default:
                    break;
            }
            
            var ParStr = document.getElementById('parBuxSid').value + ':' + document.getElementById('parBuxFrm').value + ':' + DatDocVal + ':0:';
    //        alert("ParStr=" + ParStr);
            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/BuxAccKodSpr',
                contentType: "application/json; charset=utf-8",
                data: '{"ParStr":"' + ParStr + '"}',
                dataType: "json",
                success: function (msg) {
      //                     alert("msg=" + msg.d);
                    //                    alert("msg.d=" + msg.d);
                    //                                alert("msg.d2=" + msg.d.substring(0, 3));
                    //                                alert("msg.d3=" + msg.d.substring(3, 7));
                    var hashes = msg.d.split(':');
                    if (sender.ID == "BoxDeb") {
     //                   alert("hashes[0]=" +hashes[0]);
                        document.getElementById("TxtDebSpr001").value = hashes[0];
                        if (hashes[0] == "" || hashes[0] == "0") {
                            document.getElementById("ButDeb001").style.visibility = "hidden";
                            document.getElementById("TxtDebAnl001").style.visibility = "hidden";
                        }
                        else {
                            document.getElementById("ButDeb001").style.visibility = "visible";
                            document.getElementById("TxtDebAnl001").style.visibility = "visible";
                        }

                        document.getElementById("TxtDebSpr002").value = hashes[1];
                        if (hashes[1] == "" || hashes[1] == "0") {
                            document.getElementById("ButDeb002").style.visibility = "hidden";
                            document.getElementById("TxtDebAnl002").style.visibility = "hidden";
                        }
                        else {
                            document.getElementById("ButDeb002").style.visibility = "visible";
                            document.getElementById("TxtDebAnl002").style.visibility = "visible";
                        }

                    }
                    if (sender.ID == "BoxKrd") {
                        document.getElementById("TxtKrdSpr001").value = hashes[0];
                        if (hashes[0] == "" || hashes[0] == "0") {
                            document.getElementById("ButKrd001").style.visibility = "hidden";
                            document.getElementById("TxtKrdAnl001").style.visibility = "hidden";
                        }
                        else {
                            document.getElementById("ButKrd001").style.visibility = "visible";
                            document.getElementById("TxtKrdAnl001").style.visibility = "visible";
                        }

                        document.getElementById("TxtKrdSpr002").value = hashes[1];
                        if (hashes[1] == "" || hashes[1] == "0") {
                            document.getElementById("ButKrd002").style.visibility = "hidden";
                            document.getElementById("TxtKrdAnl002").style.visibility = "hidden";
                        }
                        else {
                            document.getElementById("ButKrd002").style.visibility = "visible";
                            document.getElementById("TxtKrdAnl002").style.visibility = "visible";
                        }


                    }
  
                    //                      alert("parSpr001.value=" + parSpr001.value);
                    //                      alert("parSpr002.value=" + parSpr002.value);
                    //                      alert("parSpr003.value=" + parSpr003.value);
                },
                error: function () { }
            });
        }
        //    ------------------------------------------------------------------------------------------------------------------------

//  -------------------- Проверка на число ---------------------------------
        function isNumeric(evt) {
            var c = (evt.which) ? evt.which : event.keyCode
            if ((c >= '0' && c <= '9') || c == '.') return true;
            return false;
        }

        //  -----------------------------------------------------------------
        function ExitFun() {
     //              alert("parSpr001.value=");
            window.parent.PrvClose();
        }
        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

        function HandlePopupResult(result) {
           //            alert("result of popup is: " + result);
            var hashes = result.split('&');
          //         alert("hashes=" + hashes[0]);

            switch (hashes[1]) {
                case "D1": // USL
                    document.getElementById('TxtDebSpr001').value = hashes[2];
                    document.getElementById('TxtDebSprVal001').value = hashes[3];
                    document.getElementById('TxtDebAnl001').value = hashes[4];
                    break;
                case "D2": // USL
                    document.getElementById('TxtDebSpr002').value = hashes[2];
                    document.getElementById('TxtDebSprVal002').value = hashes[3];
                    document.getElementById('TxtDebAnl002').value = hashes[4];
                    break;
                case "K1": // USL
                    document.getElementById('TxtKrdSpr001').value = hashes[2];
                    document.getElementById('TxtKrdSprVal001').value = hashes[3];
                    document.getElementById('TxtKrdAnl001').value = hashes[4];
                    break;
                case "K2": // USL
                    document.getElementById('TxtKrdSpr002').value = hashes[2];
                    document.getElementById('TxtKrdSprVal002').value = hashes[3];
                    document.getElementById('TxtKrdAnl002').value = hashes[4];
                    break;
            }


        }

        function AddButton() {
            var x;

            x = document.getElementById('TxtNum').value;
            try { 
                if (x == "") throw "Не указан номер документа";
                if (isNaN(x)) throw "Номер документа не число";
            }
            catch (err) { windowalert( err,"Ошибка", "error"); return; }

   //         alert("002");

            x = document.getElementById('TxtDat').value;
            try { if (x == "") throw "Не указан дата документа"; }
            catch (err) { windowalert(err, "Ошибка", "error"); return; }

    //        alert("003");
            
            x = BoxDeb.options[BoxDeb.selectedIndex()].value;
            try { if (x == "0000") throw "Не указан дебетовый счет"; }
            catch (err) { windowalert(err, "Ошибка", "error"); return; }
            
            x = BoxKrd.options[BoxKrd.selectedIndex()].value;
            try { if (x == "0000") throw "Не указан кредитовый счет"; }
            catch (err) { windowalert(err, "Ошибка", "error"); return; }
            
     //       alert("005");
            x = document.getElementById('TxtSum').value;
            try {
                if (x == "") throw "Не указан сумма";
                if (isNaN(x)) throw "Cумма не число";
            }
            catch (err) { windowalert(err, "Ошибка", "error"); return; }

//            alert("006");

            x = document.getElementById('TxtMem').value;
            try {if (x == "") throw "Не указан назначения";}
            catch (err) { windowalert(err, "Ошибка", "error"); return; }
   //         alert("007");

            ConfirmDialog.screenCenter();
            ConfirmDialog.Open();
         //   var w = document.getElementById('ConfirmDialog').value
         //   w.style.display = 'block';
       //     ConfirmDialog.VisibleOnLoad = true;

        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string BuxPrvPrv;
    string BuxPrvIdn;
    string BuxPrvIdnTek;
    string AmbBnkTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        BuxPrvIdn = Convert.ToString(Request.QueryString["GlvPrvIdn"]);
        BuxPrvPrv = Convert.ToString(Request.QueryString["GlvPrvPrv"]);
        parPrvIdn.Value = BuxPrvIdn;

 //       if (BuxPrvIdn == "0") AmbBnkTyp = "ADD";
 //       else AmbBnkTyp = "REP";
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        parBuxSid.Value = BuxSid;

   //     AmbCrdIdn = (string)Session["AmbCrdIdn"];
        Session.Add("BuxPrvIdn ", BuxPrvIdn);
        sdsAcc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsAcc.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

        sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

        sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

        sdsSpz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsSpz.SelectCommand = "SELECT BuxSpzKod,BuxSpzNam FROM SPRBUXSPZ ORDER BY BUXSPZNAM";
 //       BuxPrvPrv = parDebDat001.Value;
  //      BuxPrvPrv = TxtDebAnl001.Text;
  //      BuxPrvPrv = TxtDebSprVal001.Text;

        if (!Page.IsPostBack)
        {
 //           TxtNum.Attributes.Add("onchange", "onChange('TxtNum',TxtNum.value);");
 //           TxtSum.Attributes.Add("onchange", "onChange('TxtSum',TxtSum.value);");
 //           TxtMem.Attributes.Add("onchange", "onChange('TxtMem',TxtMem.value);");
            //============= Установки ===========================================================================================
            BuxPrvIdnTek = (string)Session["BuxPrvIdn"];
            if (BuxPrvIdnTek != "Post")
            {

                if (BuxPrvIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("BuxDocPrvAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@PRVSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@PRVFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@PRVBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@PRVIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@PRVIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        BuxPrvIdn = Convert.ToString(cmd.Parameters["@PRVIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                }


                Session["BuxPrvIdn"] = Convert.ToString(BuxPrvIdn);
                parDtlIdn.Value = BuxPrvIdn;

                getDocNum();

        //        ConfirmDialog.Visible = false;
        //        ConfirmDialog.VisibleOnLoad = false;
            }
  //          parDebDat001.Value = "1111111111";
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        int Id = 0;
        int Ik = 0;


        TxtDebSpr001.Text = "";
        TxtDebSprVal001.Text = "";
        TxtDebAnl001.Text = "";
  //      ButDeb001.Visible = false;
  //      TxtDebAnl001.Visible = false;

        TxtDebSpr002.Text = "";
        TxtDebSprVal002.Text = "";
        TxtDebAnl002.Text = "";
        ButDeb002.Visible = false;
        TxtDebAnl002.Visible = false;

        TxtKrdSpr001.Text = "";
        TxtKrdSprVal001.Text = "";
        TxtKrdAnl001.Text = "";
 //       ButKrd001.Visible = false;
 //       TxtKrdAnl001.Visible = false;

        TxtKrdSpr002.Text = "";
        TxtKrdSprVal002.Text = "";
        TxtKrdAnl002.Text = "";
        ButKrd002.Visible = false;
        TxtKrdAnl002.Visible = false;

        
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("BuxDocPrvIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@PRVSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@PRVIDN", SqlDbType.VarChar).Value = BuxPrvIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BuxDocPrvIdn");
        
        con.Close();
        
        

        if (ds.Tables[0].Rows.Count > 0)
        {
            TxtNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRVNUM"]);
            TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["PRVDAT"]).ToString("dd.MM.yyyy");
 //---------------------------------------------------------------------------------------------------------------------------           
            BoxDeb.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRVDEB"]);
            BoxKrd.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRVKRD"]);
            BoxSpz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["PRVSPZ"]);

            TxtSum.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRVSUM"]);
            TxtMem.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRVMEM"]);

            // Заполнить в цикле
            foreach (DataRow row in ds.Tables["BuxDocPrvIdn"].Rows)
            {
                if (row["PRVANLOPR"].ToString() == "+")
                {
                    Id = Id + 1;
                    if (Id == 1)
                    {
                        TxtDebSpr001.Text = Convert.ToString(row["PRVANLSPR"]);
                        TxtDebSprVal001.Text = Convert.ToString(row["PRVANLSPRVAL"]);
                        TxtDebAnl001.Text = Convert.ToString(row["PRVANLSPRTXT"]);

                        if (TxtDebSprVal001.Text == null | TxtDebSprVal001.Text == "")
                        {
                            ButDeb001.Visible = false;
                            TxtDebAnl001.Visible = false;
                        }
                        else
                        {
                            ButDeb001.Visible = true;
                            TxtDebAnl001.Visible = true;
                        }
                    }
                         
                    if (Id == 2)
                    {
                        TxtDebSpr002.Text = Convert.ToString(row["PRVANLSPR"]);
                        TxtDebSprVal002.Text = Convert.ToString(row["PRVANLSPRVAL"]);
                        TxtDebAnl002.Text = Convert.ToString(row["PRVANLSPRTXT"]);

                        if (TxtDebSprVal002.Text == null | TxtDebSprVal002.Text == "")
                        {
                            ButDeb002.Visible = false;
                            TxtDebAnl002.Visible = false;
                        }
                        else
                        {
                            ButDeb002.Visible = true;
                            TxtDebAnl002.Visible = true;
                        }
                    }
                }
                
                if (row["PRVANLOPR"].ToString() == "-")
                {
                    Ik = Ik + 1;
                    if (Ik == 1)
                    {
                        TxtKrdSpr001.Text = Convert.ToString(row["PRVANLSPR"]);
                        TxtKrdSprVal001.Text = Convert.ToString(row["PRVANLSPRVAL"]);
                        TxtKrdAnl001.Text = Convert.ToString(row["PRVANLSPRTXT"]);

                        if (TxtKrdSprVal001.Text == null | TxtKrdSprVal001.Text == "")
                        {
                            ButKrd001.Visible = false;
                            TxtKrdAnl001.Visible = false;
                        }
                        else
                        {
                            ButKrd001.Visible = true;
                            TxtKrdAnl001.Visible = true;
                        }
                    }
                    if (Ik == 2)
                    {
                        TxtKrdSpr002.Text = Convert.ToString(row["PRVANLSPR"]);
                        TxtKrdSprVal002.Text = Convert.ToString(row["PRVANLSPRVAL"]);
                        TxtKrdAnl002.Text = Convert.ToString(row["PRVANLSPRTXT"]);

                        if (TxtKrdSprVal002.Text == null | TxtKrdSprVal002.Text == "")
                        {
                            ButKrd002.Visible = false;
                            TxtKrdAnl002.Visible = false;
                        }
                        else
                        {
                            ButKrd002.Visible = true;
                            TxtKrdAnl002.Visible = true;
                        }
                    }
                }

            }
            
        }
        else
        {
 //           BoxTit.Text = "Новая запись";
   //         BoxBnk.SelectedValue = "";
        }

    }
    
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void CanButton_Click(object sender, EventArgs e)
    {
    }
    
    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnOK_click(object sender, EventArgs e)
    {
        ConfirmDialog.Visible = false;
        ConfirmDialog.VisibleOnLoad = false;
        
        BuxPrvIdn = Convert.ToString(Session["BuxPrvIdn"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("BuxDocPrvRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@PRVIDN", SqlDbType.Int, 4).Value = BuxPrvIdn;
        cmd.Parameters.Add("@PRVFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@PRVBUX", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@PRVNUM", SqlDbType.VarChar).Value = TxtNum.Text;
        cmd.Parameters.Add("@PRVDAT", SqlDbType.VarChar).Value = TxtDat.Text;

        cmd.Parameters.Add("@PRVDEB", SqlDbType.VarChar).Value = BoxDeb.SelectedValue;
        if (TxtDebSprVal001.Text == null || TxtDebSprVal001.Text == "") 
        {   cmd.Parameters.Add("@PRVDEBSPR001", SqlDbType.VarChar).Value = 0;
            cmd.Parameters.Add("@PRVDEBSPRVAL001", SqlDbType.VarChar).Value = "";
        }
        else
        {
            cmd.Parameters.Add("@PRVDEBSPR001", SqlDbType.VarChar).Value = TxtDebSpr001.Text;
            cmd.Parameters.Add("@PRVDEBSPRVAL001", SqlDbType.VarChar).Value = TxtDebSprVal001.Text;
        }
        if (TxtDebSprVal002.Text == null || TxtDebSprVal002.Text == "")
        {
            cmd.Parameters.Add("@PRVDEBSPR002", SqlDbType.VarChar).Value = 0;
            cmd.Parameters.Add("@PRVDEBSPRVAL002", SqlDbType.VarChar).Value = "";
        }
        else
        {
            cmd.Parameters.Add("@PRVDEBSPR002", SqlDbType.VarChar).Value = TxtDebSpr002.Text;
            cmd.Parameters.Add("@PRVDEBSPRVAL002", SqlDbType.VarChar).Value = TxtDebSprVal002.Text;
        }

        cmd.Parameters.Add("@PRVKRD", SqlDbType.VarChar).Value = BoxKrd.SelectedValue;
        if (TxtKrdSprVal001.Text == null || TxtKrdSprVal001.Text == "")
        {
            cmd.Parameters.Add("@PRVKRDSPR001", SqlDbType.VarChar).Value = 0;
            cmd.Parameters.Add("@PRVKRDSPRVAL001", SqlDbType.VarChar).Value = "";
        }
        else
        {
            cmd.Parameters.Add("@PRVKRDSPR001", SqlDbType.VarChar).Value = TxtKrdSpr001.Text;
            cmd.Parameters.Add("@PRVKRDSPRVAL001", SqlDbType.VarChar).Value = TxtKrdSprVal001.Text;
        }
        if (TxtKrdSprVal002.Text == null || TxtKrdSprVal002.Text == "")
        {
            cmd.Parameters.Add("@PRVKRDSPR002", SqlDbType.VarChar).Value = 0;
            cmd.Parameters.Add("@PRVKRDSPRVAL002", SqlDbType.VarChar).Value = "";
        }
        else
        {
            cmd.Parameters.Add("@PRVKRDSPR002", SqlDbType.VarChar).Value = TxtKrdSpr002.Text;
            cmd.Parameters.Add("@PRVKRDSPRVAL002", SqlDbType.VarChar).Value = TxtKrdSprVal002.Text;
        }

        cmd.Parameters.Add("@PRVSUM", SqlDbType.VarChar).Value = TxtSum.Text;
        cmd.Parameters.Add("@PRVSPZ", SqlDbType.VarChar).Value = BoxSpz.SelectedValue;
        cmd.Parameters.Add("@PRVMEM", SqlDbType.VarChar).Value = TxtMem.Text;

        cmd.ExecuteNonQuery();
        /*
                                // создание команды
                                SqlCommand cmdUsl = new SqlCommand("BuxKasPrxUslWrt", con);
                                // указать тип команды
                                cmdUsl.CommandType = CommandType.StoredProcedure;
                                cmdUsl.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                                cmdUsl.ExecuteNonQuery();
        */
        con.Close();
        
        ConfirmDialog.Visible = false;
        ConfirmDialog.VisibleOnLoad = false;
       
        ExecOnLoad("ExitFun();");

 //       Response.Redirect("~/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса");
    }

    // ============================ отказ записи документа в базу ==============================================
</script>


<body>
    <form id="form1" runat="server">
      <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager1" />

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parPrvIdn" runat="server" />
        <asp:HiddenField ID="parDtlIdn" runat="server" />
        <asp:HiddenField ID="parBuxSid" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />

        <asp:HiddenField ID="parSprNum" runat="server" />
        <asp:HiddenField ID="parError" runat="server" />
       <%-- ============================  для передач значении  ============================================ --%>
        
        <asp:TextBox ID="TxtDebSpr001" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtDebSpr002" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtKrdSpr001" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtKrdSpr002" Style="display:none" runat="server" />

        <asp:TextBox ID="TxtDebSprVal001" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtDebSprVal002" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtKrdSprVal001" Style="display:none" runat="server" />
        <asp:TextBox ID="TxtKrdSprVal002" Style="display:none" runat="server" />

        <%-- ============================  шапка экрана ============================================ --%>


       <asp:TextBox ID="Sapka0" 
             Text="ПРОВОДКА" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0%; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:UpdatePanel runat="server" ID="CascadingPanel">
            <ContentTemplate>
                
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: 0px; width: 100%; height: 40px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 40px;">
                        <asp:Label ID="Label5" Text="№№:" runat="server" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtNum" Width="20%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                        
                        <asp:Label ID="Label10" runat="server" Text="Дата" Font-Bold="true" Font-Size="Medium"  ></asp:Label>  
             
                        <asp:TextBox runat="server" id="TxtDat" Width="80px" BackColor="#FFFFE0" />
			            <obout:Calendar ID="cal1" runat="server"
			 			            	StyleFolder="/Styles/Calendar/styles/default" 
						                DatePickerMode="true"
						                ShowYearSelector="true"
						                YearSelectorType="DropDownList"
						                TitleText="Выберите год: "
						                CultureName = "ru-RU"
						                TextBoxId = "TxtDat"
						                DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                    </td>
                </tr>
              </table>
       </asp:Panel>

 
                <%-- ============================  дебетовый  блок  ============================================ --%>
                <asp:Panel ID="PanelDeb" runat="server" BorderStyle="Double"
                    Style="left: 0px; position: relative; top: 0px; width: 49%; height: 150px;">

                    <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td style="width: 100%; height: 40px;">
                                <asp:Label ID="Label11" Text="ДЕБЕT:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <obout:ComboBox runat="server" ID="BoxDeb" Width="20%" Height="200"
                                    FolderStyle="/Styles/Combobox/Plain"
                                    DataSourceID="sdsAcc" DataTextField="ACCKOD" DataValueField="ACCKOD">
                                    <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                </obout:ComboBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 100%; height: 35px;">
                                <asp:Label ID="Label1" Text="АНАЛИТИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <asp:TextBox ID="TxtDebAnl001" Width="63%" ReadOnly="true" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                                <input type="button" id="ButDeb001" runat="server" value="..." onclick="OnButtonDebAnl001()" />
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 100%; height: 35px;">
                                <asp:Label ID="Label13" Text="АНАЛИТИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <asp:TextBox ID="TxtDebAnl002" Width="63%" ReadOnly="true" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                                <input type="button" id="ButDeb002" runat="server" value="..." onclick="OnButtonDebAnl002()" />
                            </td>
                        </tr>

                    </table>

                </asp:Panel>

 
                <%-- ============================  кредитовый  блок  ============================================ --%>
                <asp:Panel ID="PanelKrd" runat="server" BorderStyle="Double"
                    Style="left: 51%; position: relative; top: -156px; width: 49%; height: 150px;">
                    <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td style="width: 100%; height: 40px;">
                                <asp:Label ID="Label6" Text="КРЕДИТ:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <obout:ComboBox runat="server" ID="BoxKrd" Width="20%" ReadOnly="true" Height="200"
                                    FolderStyle="/Styles/Combobox/Plain"
                                    DataSourceID="sdsAcc" DataTextField="ACCKOD" DataValueField="ACCKOD">
                                    <ClientSideEvents OnSelectedIndexChanged="OnSelectedIndexChanged" />
                                </obout:ComboBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 100%; height: 35px;">
                                <asp:Label ID="Label7" Text="АНАЛИТИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <asp:TextBox ID="TxtKrdAnl001" Width="63%" Height="20" ReadOnly="true" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                                <input type="button" id="ButKrd001" runat="server" value="..." onclick="OnButtonKrdAnl001()" />
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 100%; height: 35px;">
                                <asp:Label ID="Label8" Text="АНАЛИТИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                                <asp:TextBox ID="TxtKrdAnl002" Width="63%" Height="20" ReadOnly="true" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                                <input type="button" id="ButKrd002" runat="server" value="..." onclick="OnButtonKrdAnl002()" />
                            </td>
                        </tr>

                    </table>

                </asp:Panel>

                     </ContentTemplate>
        </asp:UpdatePanel>
      
               
       <%-- ============================  прочие блок  ============================================ --%>
       <asp:Panel ID="PanelOth" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -150px; width: 100%; height: 100px;">
           <table border="0" cellspacing="0" width="100%" cellpadding="0">
               <tr>
                    <td style="width: 50%; height: 30px; vertical-align:top" >
                        <asp:Label ID="Label12" Text="СУММА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtSum" Width="35%" Height="20" runat="server"
                            Style="position: relative; font-weight: 700; font-size: medium;" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorDeb" ControlToValidate="TxtSum" SetFocusOnError="True" 
                                   ValidationExpression="(?!^0*$)(?!^0*\.0*$)^\d{1,18}(\.\d{1,2})?$" ErrorMessage="Ошибка" runat="server" />
                        <br />
                        <asp:Label ID="Label4" Text="СПЕЦИФИКА:" runat="server" Width="25%" Font-Bold="true" Font-Size="Medium" />
                       <obout:ComboBox runat="server"
                            AutoPostBack="false"
                            ID="BoxSpz"
                            Width="65%"
                            Height="200"
                            EmptyText="Выберите специфику ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsSpz"
                            DataTextField="BUXSPZNAM"
                            DataValueField="BUXSPZKOD" >
                        </obout:ComboBox> 

                    </td>
                    <td style="width: 50%; height: 50px; vertical-align: top; ">
                        <asp:Label ID="Label2" Text="ПРИМЕЧАНИЕ:" runat="server" Width="65%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtMem" TextMode="MultiLine" Width="98%" Height="70" runat="server"
                             Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                 
             </table>

        </asp:Panel>

          <%-- ============================  нижний блок  ============================================ --%>
       <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -155px; width: 100%; height: 25px;">
             <center>
                 <input type="button" name="PrtButton" value="Записать" id="PrtJrnButton" onclick="AddButton();">
                 <input type="button" name="CanButton" value="Закрыть" id="CanButton" runat="server" onserverclick="CanButton_Click"/>
           </center>
        </asp:Panel>                     
              

  <!-- Как сделать длинный пробел? ---------------------------------------------------------------------------------------------------------- 
    &nbsp; неразрывный пробел
&thinsp; узкий пробел (применяют в двойных словах)
&ensp; средний, разрывной пробел
&emsp; длинный разрывной пробел (примеяют в конце предложений)

      <span style='padding-left:10px;'> </span>
       -->
       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
 

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
    --%>
              <!--     Dialog должен быть раньше Window-->
      <owd:Dialog ID="ConfirmDialog" runat="server" Height="150" StyleFolder="/Styles/Window/wdstyles/default" 
           Title="ПРОВОДКА" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать проводку ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table> 
            </center>
        </owd:Dialog>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
    <%-- =================  окно для поиска клиента из базы  ============================================ --%>
        <owd:Window ID="FndWindow" runat="server" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
            Left="50" Top="10" Height="300" Width="700" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="Тарификатор">
        </owd:Window>

        <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true"/>

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

    </style>



</body>

</html>



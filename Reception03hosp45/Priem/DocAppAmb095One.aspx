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
        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            var AmbBolIdn = document.getElementById('parBolIdn').value;
      //      alert(AmbBolIdn);
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmb095Prt&TekDocIdn=" + AmbBolIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmb095Prt&TekDocIdn=" + AmbBolIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }


    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbBolIdn;
    string AmbBolIdnTek;
    string AmbRej;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbBolIdn = Convert.ToString(Request.QueryString["AmbBolIdn"]);
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbRej = Convert.ToString(Request.QueryString["AmbRej"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        Session.Add("AmbBolIdn ", AmbBolIdn);

        sdsDoc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDoc.SelectCommand = "SELECT BUXKOD AS DOCKOD,FI+' '+DLGNAM AS DOCNAM FROM SprBuxKdr WHERE BUXUBL=0 AND BUXFRM=" + BuxFrm + " AND DLGTYP='АМБ' ORDER BY FI";

        if (!Page.IsPostBack)
        {
            //   TxtBol.Attributes.Add("onchange", "onChange('TxtBol',TxtBol.value);");
            //   TxtDni.Attributes.Add("onchange", "onChange('TxtDni',TxtDni.value);");
            //   TxtKol.Attributes.Add("onchange", "onChange('TxtKol',TxtKol.value);");
            //           TxtKol.Attributes.Add("onkeypress", "return isNumeric(event)");
            //============= Установки ===========================================================================================
            AmbBolIdnTek = (string)Session["AmbBolIdn"];
            //         if (AmbBolIdnTek != "Post")
            //         {

            if (AmbBolIdn == "0")  // новый документ
            {

                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspAmbBolAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
                cmd.Parameters.Add("@BOLTYP", SqlDbType.VarChar).Value = "095";
                cmd.Parameters.Add("@BOLIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@BOLIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    AmbBolIdn = Convert.ToString(cmd.Parameters["@BOLIDN"].Value);
                }
                finally
                {
                    con.Close();
                }
            }

            Session["AmbBolIdn"] = Convert.ToString(AmbBolIdn);
            parBolIdn.Value = AmbBolIdn;
            getDocNum();

            //           }

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
        SqlCommand cmd = new SqlCommand("SELECT * FROM AMBBOL WHERE BOLIDN=" + AmbBolIdn, con);        // указать тип команды

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "BolOneSap");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {

            TxtFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["BOLPTH"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLBRT"].ToString())) TxtBrt.Text = "";
            else TxtBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLBRT"]).ToString("dd.MM.yyyy");

            //     TxtAdr.Text = Convert.ToString(ds.Tables[0].Rows[0]["BOLADR"]);
            TxtRab.Text = Convert.ToString(ds.Tables[0].Rows[0]["BOLRAB"]);
            TxtDig.Text = Convert.ToString(ds.Tables[0].Rows[0]["BOLDIG"]);

            TxtNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["BOLNUM"]);
            BoxDoc000.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLDOC000"]);

            BoxStt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLSTT"]);
            BoxPri.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLPRI"]);
            BoxKud.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLKUD"]);
            BoxCnt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLCNT"]);

            BoxDoc000.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BOLDOC000"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLBEG000"].ToString())) TxtBeg000.Text = "";
            else TxtBeg000.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLBEG000"]).ToString("dd.MM.yyyy");
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLEND000"].ToString())) TxtEnd000.Text = "";
            else TxtEnd000.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLEND000"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLEND001"].ToString())) TxtBeg001.Text = "";
            else TxtBeg001.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLEND001"]).ToString("dd.MM.yyyy");
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLEND002"].ToString())) TxtEnd002.Text = "";
            else TxtEnd001.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLEND002"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLEND003"].ToString())) TxtBeg002.Text = "";
            else TxtBeg002.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLEND003"]).ToString("dd.MM.yyyy");
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["BOLEND009"].ToString())) TxtEnd002.Text = "";
            else TxtEnd002.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["BOLEND009"]).ToString("dd.MM.yyyy");

            //     if (TxtEnd009.Text.Length > 0 && BoxDoc009.SelectedValue.Length > 0)
            //     {
            //         ZapButton.Visible = false;
            //  PrtButton.Visible = false;
            //     }
        }
        else
        {
            //           BoxTit.Text = "Новая запись";
            //         BoxBol.SelectedValue = "";
        }

    }

    // ============================ кнопка новый документ  ==============================================
    protected void ZapButton_Click(object sender, EventArgs e)
    {
        int BolIdn;

        string BolFio = "";
        string BolBrt = "";
        string BolAdr = "";
        string BolRab = "";
        string BolDig = "";

        int BolNum;
        string BOLDOC000;
        string BolPri;
        string BolStt;
        string BolKud;
        string BolCnt;
        string BOLDOC009;

        string BolBeg000 = "";
        string BolBeg001 = "";
        string BolBeg002 = "";
        string BolEnd000 = "";
        string BolEnd001 = "";
        string BolEnd002 = "";
        string BolEnd003 = "";
        string BolEnd009 = "";

        BolIdn =  Convert.ToInt32(parBolIdn.Value);
        //=====================================================================================
        if (Convert.ToString(TxtNum.Text) == null || Convert.ToString(TxtNum.Text) == "") BolNum = 0;
        else BolNum = Convert.ToInt32(TxtNum.Text);

        if (Convert.ToString(TxtFio.Text) == null || Convert.ToString(TxtFio.Text) == "") BolFio = "";
        else BolFio = Convert.ToString(TxtFio.Text);

        if (Convert.ToString(TxtBrt.Text) == null || Convert.ToString(TxtBrt.Text) == "") BolBrt = "";
        else BolBrt = Convert.ToString(TxtBrt.Text);

        if (Convert.ToString(TxtRab.Text) == null || Convert.ToString(TxtRab.Text) == "") BolRab = "";
        else BolRab = Convert.ToString(TxtRab.Text);

        //      if (Convert.ToString(TxtDig.Text) == null || Convert.ToString(TxtDig.Text) == "") BolDig = "";
        //      else BolDig = Convert.ToString(TxtDig.Text);

        if (Convert.ToString(BoxStt.SelectedValue) == null || Convert.ToString(BoxStt.SelectedValue) == "") BolStt = "0";
        else BolStt = Convert.ToString(BoxStt.SelectedValue);

        if (Convert.ToString(BoxPri.SelectedValue) == null || Convert.ToString(BoxPri.SelectedValue) == "") BolPri = "0";
        else BolPri = Convert.ToString(BoxPri.SelectedValue);

        if (Convert.ToString(BoxKud.SelectedValue) == null || Convert.ToString(BoxKud.SelectedValue) == "") BolKud = "0";
        else BolKud = Convert.ToString(BoxKud.SelectedValue);

        if (Convert.ToString(BoxCnt.SelectedValue) == null || Convert.ToString(BoxCnt.SelectedValue) == "") BolCnt = "0";
        else BolCnt = Convert.ToString(BoxCnt.SelectedValue);

        if (Convert.ToString(BoxDoc000.SelectedValue) == null || Convert.ToString(BoxDoc000.SelectedValue) == "") BOLDOC000 = "0";
        else BOLDOC000 = Convert.ToString(BoxDoc000.SelectedValue);

        if (Convert.ToString(TxtBeg000.Text) == null || Convert.ToString(TxtBeg000.Text) == "") BolBeg000 = "";
        else BolBeg000 = Convert.ToString(TxtBeg000.Text);
        if (Convert.ToString(TxtEnd000.Text) == null || Convert.ToString(TxtEnd000.Text) == "") BolEnd000 = "";
        else BolEnd000 = Convert.ToString(TxtEnd000.Text);


        if (Convert.ToString(TxtBeg001.Text) == null || Convert.ToString(TxtBeg001.Text) == "") BolBeg001 = "";
        else BolBeg001 = Convert.ToString(TxtBeg001.Text);
        if (Convert.ToString(TxtEnd001.Text) == null || Convert.ToString(TxtEnd001.Text) == "") BolEnd001 = "";
        else BolEnd001 = Convert.ToString(TxtEnd001.Text);

        if (Convert.ToString(TxtBeg002.Text) == null || Convert.ToString(TxtBeg002.Text) == "") BolBeg002 = "";
        else BolBeg002 = Convert.ToString(TxtBeg002.Text);
        if (Convert.ToString(TxtEnd002.Text) == null || Convert.ToString(TxtEnd002.Text) == "") BolEnd002 = "";
        else BolEnd002 = Convert.ToString(TxtEnd002.Text);

        if (BolNum > 0)
        {
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspAmb095Rep", con);
            cmd = new SqlCommand("HspAmb095Rep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BOLIDN", SqlDbType.Int, 4).Value = BolIdn;
            cmd.Parameters.Add("@BOLPTH", SqlDbType.VarChar).Value = BolFio;
            cmd.Parameters.Add("@BOLBRT", SqlDbType.VarChar).Value = BolBrt;
            cmd.Parameters.Add("@BOLRAB", SqlDbType.VarChar).Value = BolRab;

            cmd.Parameters.Add("@BOLSTT", SqlDbType.VarChar).Value = BolStt;
            cmd.Parameters.Add("@BOLPRI", SqlDbType.VarChar).Value = BolPri;
            cmd.Parameters.Add("@BOLKUD", SqlDbType.VarChar).Value = BolKud;
            cmd.Parameters.Add("@BOLCNT", SqlDbType.VarChar).Value = BolCnt;

            cmd.Parameters.Add("@BOLDOC000", SqlDbType.Int, 4).Value = BOLDOC000;
            cmd.Parameters.Add("@BOLBEG000", SqlDbType.VarChar).Value = BolBeg000;
            cmd.Parameters.Add("@BOLEND000", SqlDbType.VarChar).Value = BolEnd000;

            cmd.Parameters.Add("@BOLEND001", SqlDbType.VarChar).Value = BolBeg001;
            cmd.Parameters.Add("@BOLEND002", SqlDbType.VarChar).Value = BolEnd001;

            cmd.Parameters.Add("@BOLEND003", SqlDbType.VarChar).Value = BolBeg002;
            cmd.Parameters.Add("@BOLEND009", SqlDbType.VarChar).Value = BolEnd002;

            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            getDocNum();
        }
    }
    // ============================ чтение заголовка таблицы а оп ==============================================

    // ==================================== поиск клиента по фильтрам  ============================================

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBolIdn" runat="server" />
        <asp:HiddenField ID="DigIdn" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 350px;">

            
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                 <tr>
                    <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:Label ID="Label1" Text="№ СПРАВКИ:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:TextBox ID="TxtNum" Width="7%" Height="20" BorderStyle="None" runat="server" Style="font-size: medium;" ReadOnly="true" />
                        <asp:Label ID="LabDig" Text="ДИАГНОЗ:" runat="server" Width="12%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtDig" Width="72%" Height="20" BorderStyle="None" runat="server" Style="font-size: medium;" ReadOnly="true" />
                    </td>
                 </tr>
               <tr>
                    <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:Label ID="Label8" Text="ФАМИЛИЯ И.О.:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:TextBox ID="TxtFio" Width="50%" Height="20" BorderStyle="None" runat="server" Style="font-size: medium;" />
                        <asp:Label ID="LabBrt" Text="Д/Р:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtBrt" Width="20%" Height="20" BorderStyle="None" runat="server" Style="font-size: medium;" />
                        <obout:Calendar ID="CalBrt" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtBrt"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>


               <tr>
                     <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                         <asp:Label ID="Label6" Text="СТАТУС:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;">
                        <obout:ComboBox runat="server" ID="BoxStt"  Width="100%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="студента" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="учащегося колледжа" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="профессионально-технического училища" Value="3" />
                                         </Items>
                                 </obout:ComboBox>

                    </td>
                </tr>

               <tr>
                     <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                         <asp:Label ID="Label3" Text="ПРИЧИНА ОТС:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;">
                       <obout:ComboBox runat="server" ID="BoxPri"  Width="100%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem1" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem2" runat="server" Text="болезнь" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem3" runat="server" Text="карантин" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem4" runat="server" Text="прочие" Value="3" />
                                         </Items>
                                 </obout:ComboBox>
                    </td>
                </tr>

               <tr>
                     <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                         <asp:Label ID="Label9" Text="КУДА:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;">
                       <obout:ComboBox runat="server" ID="BoxKud"  Width="100%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem33" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem34" runat="server" Text="школу" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem35" runat="server" Text="детскую дошкольную организацию" Value="2" />
                                         </Items>
                                 </obout:ComboBox>
                    </td>
                </tr>

               <tr>
                     <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                         <asp:Label ID="Label10" Text="КОНТАКТ:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                    <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;">
                       <obout:ComboBox runat="server" ID="BoxCnt"  Width="100%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem5" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem6" runat="server" Text="нет" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem7" runat="server" Text="да" Value="2" />
                                         </Items>
                                 </obout:ComboBox>
                    </td>
                </tr>
               <tr>
                     <td height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:Label ID="Label7" Text="УЧЕБ.ЗАВЕДЕНИЯ:" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                   <td height="20" width="80%" style="vertical-align: top; padding: 1px; border: 1px solid black;" >
                        <asp:TextBox ID="TxtRab" Width="100%" Height="20" BorderStyle="None" runat="server" Style="font-size: Medium;" />
                    </td>
                </tr>

             </table>

             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  ШАПКА ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black; background-color:yellow " >
                        <asp:Label ID="Label00" Text="ДЕЙСТВИЯ" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                    <td  height="20" width="40%" style="vertical-align: top; padding: 1px; border: 1px solid black; background-color:yellow">
                        <asp:Label ID="Label12" Text="ВРАЧ" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black; background-color:yellow">
                        <asp:Label ID="Label13" Text="НАЧАЛО" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 1px; border: 1px solid black; background-color:yellow">
                        <asp:Label ID="Label14" Text="КОНЕЦ" runat="server" Width="100%" Font-Bold="true" Font-Size="Medium" />
                    </td>
                </tr>

                <!--  ВРАЧ ОТКРЫЛ ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:Label ID="Label2" Text="ОТКРЫЛ" runat="server" Width="100%" Font-Size="Larger" />
                    </td>
                    <td  height="20" width="40%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <obout:ComboBox runat="server"
                            ID="BoxDoc000"
                            Width="100%"
                            Height="200"
                            Font-Bold="true"
                            EmptyText="Выберите врача ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsDoc"
                            DataTextField="DOCNAM"
                            DataValueField="DOCKOD" >
                        </obout:ComboBox>

                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtBeg000" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="CalBeg001" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtBeg000"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtEnd000" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="CalEnd000" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtEnd000"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>

                <!--  ВРАЧ ПРОДЛИЛ 1 ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:Label ID="Label4" Text="ПРОДЛИЛ" runat="server" Width="100%" Font-Size="Larger" />
                    </td>
                    <td  height="20" width="40%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                      <asp:TextBox ID="TxtBeg001" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                      <obout:Calendar ID="Calendar1" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtBeg001"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtEnd001" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="CalEnd001" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtEnd001"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>

                <!--  ВРАЧ ПРОДЛИЛ 2 ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:Label ID="Label5" Text="ПРОДЛИЛ" runat="server" Width="100%" Font-Size="Larger" />
                    </td>
                    <td  height="20" width="40%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtBeg002" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="Calendar2" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtBeg002"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                    <td  height="20" width="20%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="TxtEnd002" Width="60%" Height="20" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                        <obout:Calendar ID="CalEnd002" runat="server"
                               StyleFolder="~/Styles/Calendar/styles/default"
                               DatePickerMode="true"
                               ShowYearSelector="true"
                               YearSelectorType="DropDownList"
                               TitleText="Выберите год: "
                               CultureName="ru-RU"
                               TextBoxId = "TxtEnd002"
                               DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                    </td>
                </tr>

            </table>

        </asp:Panel>
       <asp:Panel ID="PanelBottom" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 30px;">
             <center>
                 <asp:Button ID="ZapButton" runat="server" CommandName="Cancel" Text="Записать" onclick="ZapButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать 095/у" runat="server"  id="PrtButton" onclick="PrtButton_Click();"/>
             </center>
        </asp:Panel>

        <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
       <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

    <asp:SqlDataSource runat="server" ID="sdsDoc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



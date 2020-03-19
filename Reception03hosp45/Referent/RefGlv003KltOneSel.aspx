<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
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
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">
        // -------изменение как EXCEL-------------------------------------------------------------------          
        function markAsFocused(textbox) {
            //           alert("markAsFocused=");
            textbox.className = 'excel-textbox-focused';
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          
        function SelButton_Click() {
            //           alert("markAsFocused=");
            localStorage.setItem("FndFio", GrfFio); //setter
            window.opener.HandlePopupResult(GrfFio);
        }


        /*------------------------- при выходе из TEXTBOX запомнить Идн --------------------------------*/
        function onChange(sender, newText) {
                //            alert("onChangeJlb=" + sender.ID);
                var GrfDocRek;
                var GrfDocVal = newText;
                var GrfDocTyp = 'Txt';

                switch (sender.ID) {
                    case 'TelTxt':
                        GrfDocRek = 'KLTTHN';
                        break;
                    case 'AdrTxt':
                        GrfDocRek = 'KLTADR';
                        break;
                    case 'AlrTxt':
                        GrfDocRek = 'KLTALR';
                        break;
                    default:
                        break;
                }

            onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
        }

        /*------------------------- при выходе из TEXTBOX запомнить Идн --------------------------------*/
        function onChangeInt(sender, newText) {
            //            alert("onChangeJlb=" + sender.ID);
            var GrfDocRek;
            var GrfDocVal = newText;
            var GrfDocTyp = 'Int';

            switch (sender.ID) {
                case 'InvTxt':
                    GrfDocRek = 'KLTINV';
                    break;
                default:
                    break;
            }

            onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
        }

        /*------------------------- Обращение к ВЕБ методу --------------------------------*/
        function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp) {
            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'SPRKLT';
            var DatDocKey = 'KLTIDN';
            var DatDocIdn;
//            var QueryString = getQueryString();
//            DatDocIdn = QueryString[1];
            DatDocIdn = TekDocIdn.value;
 //                        alert("onChange=" + DatDocMdb + ' ' + DatDocTab + ' ' + DatDocKey + ' ' + DatDocIdn + ' ' + DatDocRek + ' ' + DatDocVal + ' ' + DatDocTyp);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","DatDocTab":"' + DatDocTab + '","DatDocKey":"' + DatDocKey + '","DatDocIdn":"' + DatDocIdn + '","DatDocRek":"' + DatDocRek + '","DatDocVal":"' + DatDocVal + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR="); }
            });
        }

        /*------------------------- Изиять переданный параметр --------------------------------*/
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

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string GrfOneIdn;
    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

        GrfOneIdn = Convert.ToString(Request.QueryString["GrfOneIdn"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsStx.SelectCommand = "SELECT CntKey As StxKod,CntNam As StxNam FROM SprCnt WHERE CntLvl=0 ORDER BY CntNam";

        sdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsOrg.SelectCommand = "SELECT CntKod As OrgKod,CntNam As OrgNam FROM SprCnt WHERE CntLvl=1 And Left(CntKey,5)='00002' ORDER BY CntNam";

        sdsCnt.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //        sdsCnt.SelectCommand = "SELECT CntKod As CntKod,CntNam As CntNam FROM SprCnt WHERE CntKey=LEFT(KLTKEY,17) ORDER BY CntNam";

        sdsVar.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //       sdsVar.SelectCommand = "SELECT CntKod As VarKod,CntNam As VarNam FROM SprCnt WHERE CntKey=LEFT(KLTKEY,23) ORDER BY CntNam";

        if (!Page.IsPostBack)
        {
     //       TekKltIdn.Value = Convert.ToString(KltOneIdn);
     //       TekCntIdn.Value = Convert.ToString(CntOneIdn);

            if (String.IsNullOrEmpty(GrfOneIdn)) GrfOneIdn = null;
            else GetGrid();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {

  //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspRefGlv003KltOneSel", con);
        cmd = new SqlCommand("HspRefGlv003KltOneSel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@GRFONEIDN", SqlDbType.VarChar).Value = GrfOneIdn;
        
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlv003KltOneSel");
     
        if (ds.Tables[0].Rows.Count > 0)
        {

            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTFAM"]) + " " +
                          Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]) + " " +
                          Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            FamTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTFAM"]);
            ImaTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]);
            OtcTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTBRT"].ToString())) BrtDat.Text = "";
            else BrtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KLTBRT"]).ToString("dd.MM.yyyy");

            InvTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTINV"]);
            IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);
            TelTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);

//            AdrOblTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADROBL"]);
//            AdrRaiTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRRAI"]);
            AdrPnkTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPNK"]);
            AdrStrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRSTR"]);
            AdrDomTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDOM"]);
            AdrAprTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRAPR"]);
            AdrUglTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRUGL"]);
            AdrEtgTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRETG"]);
            AdrPodTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRPOD"]);
            AdrDmfTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDMF"]);
            
            PolTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTKRT"]);
            SplTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSEMKRT"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"].ToString())) BegDat.Text = "";
            else BegDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTEND"].ToString())) EndDat.Text = "";
            else EndDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTEND"]).ToString("dd.MM.yyyy");
            
            DlgTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTDLG"]);
            EmpTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);
            
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTUBLDAT"].ToString())) UblDat.Text = "";
            else UblDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTUBLDAT"]).ToString("dd.MM.yyyy");
            
            AlrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTALR"]);

            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTX"].ToString())) BoxStx.SelectedValue = "0";
            else BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSTX"]);

            sdsOrg.SelectCommand = "SELECT CntKey As OrgKod,CntNam As OrgNam FROM SprCnt WHERE Left(CntKey,5)='" + BoxStx.SelectedValue + "' AND CNTLVL=1 ORDER BY CntNam";
            
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTCMP"].ToString())) BoxOrg.SelectedValue = "0";
            else BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTCMP"]);

            sdsCnt.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,11)='" + BoxOrg.SelectedValue + "' AND CNTLVL=2 ORDER BY CntNam";

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTCNT"].ToString())) BoxCnt.SelectedValue = "0";
            else BoxCnt.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTCNT"]);

            sdsVar.SelectCommand = "SELECT CntKey As VarKod,CntNam As VarNam FROM SprCnt WHERE Left(CntKey,17)='" + BoxCnt.SelectedValue + "' AND CNTLVL=3 ORDER BY CntNam";

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTVAR"].ToString())) BoxVar.SelectedValue = "0";
            else BoxVar.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTVAR"]);
            
            //     obout:CheckBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTUBLFLG"].ToString())) UblFlg.Checked = false;
            else UblFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTUBLFLG"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTF"].ToString())) StfFlg.Checked = false;
            else UblFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTSTF"]);
            
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTVIP"].ToString())) VipFlg.Checked = false;
            else UblFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["CNTKLTVIP"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSEX"].ToString())) SexFlg.Checked = false;
            else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTSEX"]);



        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
        
    }

    //------------------------------------------------------------------------


</script>


<body>
    <form id="form1" runat="server">




       <asp:HiddenField ID="TekKltIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 420px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
 <!--  Фамилия , Страховщик ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                            <td width="10%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="IinTxt"  width="35%" BackColor="White" ReadOnly="true" Height="35px"
                                       FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; № инв.
                                 <obout:OboutTextBox runat="server" ID="InvTxt"  width="25%" BackColor="White" ReadOnly="true"
                                      FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>                                                         
                             <td width="10%" class="PO_RowCap">&nbsp;Страховщик&nbsp;:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxStx" Width="100%" Height="200" AutoPostBack="true" ReadOnly="true"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="SdsStx" DataTextField="StxNam" DataValueField="StxKod" >
                                </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Имя , Фирма страхователь ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Фамилия:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="FamTxt"  width="100%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Фирма:</td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxOrg" Width="100%" Height="200" AutoPostBack="true" ReadOnly="true"
                                        FolderStyle="/Styles/Combobox/Plain" 
                                        DataSourceID="SdsOrg" DataTextField="OrgNam" DataValueField="OrgKod" >
                                 </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Отчество , Договор ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Имя:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="ImaTxt"  width="100%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Договор:</td>
                             <td width="35%" style="vertical-align: top;">
                               <obout:ComboBox runat="server" ID="BoxCnt" Width="100%" Height="200" AutoPostBack="true" ReadOnly="true"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="SdsCnt" DataTextField="CntNam" DataValueField="CntKod" >
                                 </obout:ComboBox>  
                             </td>
                        </tr>
 <!--  Пол, Год рождения , Вариант договора ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Отчество:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="OtcTxt"  width="100%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Вариант:</td>
                             <td width="35%" style="vertical-align: top;">
                               <obout:ComboBox runat="server" ID="BoxVar" Width="100%" Height="200" AutoPostBack="true" ReadOnly="true"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="SdsVar" DataTextField="VarNam" DataValueField="VarKod" >
                                 </obout:ComboBox>                              
                             </td>
                        </tr>
 <!-- ИИН , Инвен. номер , Начало страхования, Конец страхования  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                            <td width="10%" class="PO_RowCap">&nbsp;Пол (муж):</td>
                            <td width="35%" style="vertical-align: central;">
                                 <obout:OboutCheckBox runat="server" ID="SexFlg" 
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>
                                 &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  
                                 Год рождения:
                                <obout:OboutTextBox runat="server" ID="BrtDat"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Начало:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="BegDat"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                &nbsp;Конец:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <obout:OboutTextBox runat="server" ID="EndDat"  width="30%" BackColor="White" ReadOnly="true" Height="35px" 
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
 
 <!--  Телефон , Карта, Сем.карта----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Телефон:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TelTxt"  width="100%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp; Карта:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="PolTxt"  width="25%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             
                                  &nbsp; &nbsp; &nbsp; Сем.карта:
                                   <obout:OboutTextBox runat="server" ID="SplTxt"  width="25%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                

                            </td>
                        </tr>

             <!--  Аллергия,  Мест работы, Должн. ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Аллергия:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AlrTxt"  width="100%" BackColor="White" ReadOnly="true" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Мест работы:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="EmpTxt"  width="55%" BackColor="White" ReadOnly="true" Height="60px"
                                     TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 &nbsp;Дол.:
                                 <obout:OboutTextBox runat="server" ID="DlgTxt"  width="30%" BackColor="White" ReadOnly="true" Height="60px"
                                     TextMode="MultiLine"  FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>

                        </tr>

  <!--  Адрес , Уволен и Дата увол.  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Город:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrPnkTxt"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Улица: &nbsp;&nbsp;&nbsp;&nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrStrTxt"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">&nbsp;Сотрудник:</td>
                             <td width="35%" style="vertical-align: central;">
                                 <obout:OboutCheckBox runat="server" ID="StfFlg" Height="35px"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox> 
                                 &nbsp; VIP: &nbsp;
                                 <obout:OboutCheckBox runat="server" ID="VipFlg" Height="35px"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox> 

                            </td>
                        </tr>

<!--  Адрес , Уволен и Дата увол.  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                            <td width="10%" class="PO_RowCap">&nbsp;Угол:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrUglTxt"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                                 
                                 &nbsp; Подъезд: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrPodTxt"  width="40%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td> 
                             <td width="10%" class="PO_RowCap">&nbsp;Уволен:</td>
                             <td width="35%" style="vertical-align: central;">
                                  <obout:OboutCheckBox runat="server" ID="UblFlg" Height="35px"
		                                       FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox> 
                                 &nbsp;Дата:

                                 <obout:OboutTextBox runat="server" ID="UblDat"  width="22%" BackColor="White" ReadOnly="true"
                                      FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                             </td>
                        </tr>

<!--  Адрес , Уволен и Дата увол.  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Дом:</td>
                             <td width="35%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="AdrDomTxt"  width="12%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Кв.: &nbsp;
                                <obout:OboutTextBox runat="server" ID="AdrAprTxt"  width="12%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Этаж: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrEtgTxt"  width="12%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp; Домофон: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrDmfTxt"  width="12%" BackColor="White" ReadOnly="true" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                              <td width="10%" class="PO_RowCap"></td>
                             <td width="35%" style="vertical-align: top;"> </td>



                            </td>

<!--  Адрес , Уволен и Дата увол.  ----------------------------------------------------------------------------------------------------------  -->  

      </table>
         </asp:Panel>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>

    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    
    <asp:SqlDataSource runat="server" ID="sdsCnt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsVar" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
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
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
         .ob_iTIE
    {
           font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
       
    }

    </style>


</body>

</html>



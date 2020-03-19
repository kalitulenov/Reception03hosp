<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript" ></script>

   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#BrtDat').mask('D9.M9.Y999');
        };
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

        /*------------------------- Изиять переданный параметр --------------------------------*/
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        function ExitFun() {
            var KltFio = document.getElementById('SelFio').value;
         //   alert(KltFio);
            //window.parent.KofClick();
            window.parent.KltOneClose(KltFio);
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        // -----------------------------------------------------------------------------------
        //    ---------------- обращение веб методу --------------------------------------------------------
        // -----------------------------------------------------------------------------------

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KltOneIdn;
    string KltOneIin;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        KltOneIin = Convert.ToString(Request.QueryString["KltOneIin"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {
            TekKltIin.Value = Convert.ToString(KltOneIin);

            if (String.IsNullOrEmpty(KltOneIdn) || KltOneIdn == "0") IinTxt.ReadOnly = false;
            else IinTxt.ReadOnly = true;

            if (String.IsNullOrEmpty(CntOneIdn)) CntOneIdn = null;
            else GetGrid();

        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================
    void GetGrid()
    {

        //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspRefGlv003KltOne", con);
        cmd = new SqlCommand("HspRefGlv003KltOne", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@KLTONEIDN", SqlDbType.VarChar).Value = KltOneIdn;
        cmd.Parameters.Add("@CNTONEIDN", SqlDbType.VarChar).Value = CntOneIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlv003KltOne");

        if (ds.Tables[0].Rows.Count > 0)
        {

            //           BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTFAM"]) + " " +
            //                         Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]) + " " +
            //                         Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);
            BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            FioTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTFIO"]);
            //           ImaTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTIMA"]);
            //            OtcTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["CNTOTC"]);
            //            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTIIN"].ToString())  ) IinTxt.Enabled = true;

            if (Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]) != null && Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]) != "")
            {
                IinTxt.Enabled = false;
            }

            IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTIIN"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTBRT"].ToString())) BrtDat.Text = "";
            else BrtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KLTBRT"]).ToString("dd.MM.yyyy");

            AdrStrTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRSTR"]);
            AdrDomTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRDOM"]);
            AdrAprTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADRAPR"]);

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"].ToString())) BegDat.Text = "";
            else BegDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTBEG"]).ToString("dd.MM.yyyy");

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTKRTEND"].ToString())) EndDat.Text = "";
            else EndDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CNTKLTKRTEND"]).ToString("dd.MM.yyyy");

            EmpTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTRABNAM"]);



            //     obout:ComboBox ------------------------------------------------------------------------------------ 
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTSTX"].ToString())) BoxStx.SelectedValue = "0";
            else BoxStx.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTSTX"]);

            sdsOrg.SelectCommand = "SELECT CntKey As OrgKod,CntNam As OrgNam FROM SprCnt WHERE Left(CntKey,5)='" + BoxStx.SelectedValue + "' AND CNTLVL=1 ORDER BY CntNam";

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["CNTKLTCMP"].ToString())) BoxOrg.SelectedValue = "0";
            else BoxOrg.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CNTKLTCMP"]);

            sdsCnt.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,11)='" + BoxOrg.SelectedValue + "' AND CNTLVL=2 ORDER BY CntNam";


            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSOZLGT"].ToString())) BoxSoz.SelectedValue = "0";
            else BoxSoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTSOZLGT"]);

            //     obout:CheckBox ------------------------------------------------------------------------------------ 

            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSEX"].ToString())) SexFlg.Checked = false;
            else SexFlg.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["KLTSEX"]);

        }
        // ------------------------------------------------------------------------------заполняем второй уровень
        else
        {
            // создание команды
            SqlCommand cmdMax = new SqlCommand("HspSprKltMaxIinInv", con);
            cmdMax = new SqlCommand("HspSprKltMaxIinInv", con);
            // указать тип команды
            cmdMax.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            // передать параметр
            cmdMax.Parameters.Add("@BUXFRM", SqlDbType.Int,4).Value = BuxFrm;
            // создание DataAdapter
            SqlDataAdapter daMax = new SqlDataAdapter(cmdMax);
            // заполняем DataSet из хран.процедуры.
            daMax.Fill(dsMax, "HspSprKltMaxIinInv");

            if (dsMax.Tables[0].Rows.Count > 0)
            {
                IinTxt.Text = Convert.ToString(dsMax.Tables[0].Rows[0]["KLTMAXIIN"]);
            }
        }

        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }


    //------------------------------------------------------------------------
    protected void BoxStx_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxStx.SelectedIndex > -1)
        {
            //           KeyStx = Convert.ToInt32(BoxStx.SelectedValue).ToString("D5");
            //===============================================================================================================
            BoxOrg.Items.Clear();
            sdsOrg.SelectCommand = "SELECT CntKey As OrgKod,CntNam As OrgNam FROM SprCnt WHERE Left(CntKey,5)='" + BoxStx.SelectedValue + "' AND CNTLVL=1 ORDER BY CntNam";
            //           BoxOrg.SelectedValue = "";
            //===============================================================================================================
            //           BoxCnt.Items.Clear();
            //           BoxCnt.SelectedIndex = -1;
            //           BoxVar.Items.Clear();
            //           BoxVar.SelectedIndex = -1;
            //===============================================================================================================
            con.Close();
        }
    }

    //------------------------------------------------------------------------
    protected void BoxOrg_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxOrg.SelectedIndex > -1)
        {
            //===============================================================================================================
            //           BoxCnt.Items.Clear();
            //           sdsCnt.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,11)='" + BoxOrg.SelectedValue + "' AND CNTLVL=2 ORDER BY CntNam";
            //===============================================================================================================
            //          BoxVar.Items.Clear();
            //          BoxVar.SelectedIndex = -1;
            //===============================================================================================================
            con.Close();
        }
    }


    //------------------------------------------------------------------------
    /*
    protected void BoxCnt_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        if (BoxCnt.SelectedIndex > -1)
        {
            //===============================================================================================================
            BoxVar.Items.Clear();
            sdsVar.SelectCommand = "SELECT CntKey As CntKod,CntNam As CntNam FROM SprCnt WHERE Left(CntKey,17)='" + BoxOrg.SelectedValue + "' AND CNTLVL=3 ORDER BY CntNam";
            //===============================================================================================================
            con.Close();
        }

    }
*/

    //------------------------------------------------------------------------
    protected void RepKltIin_Click(object sender, EventArgs e)
    {
        ConfirmDialog.Visible = true;
        ConfirmDialog.VisibleOnLoad = true;
    }


</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekKltIin" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 495px;">

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
 <!--  Фамилия , Страховщик ----------------------------------------------------------------------------------------------------------  
     -->  
                         <tr style="height:35px"> 
                            <td width="10%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <asp:TextBox runat="server" ID="IinTxt" width="22%" BackColor="White" Height="25px"/>
                             </td>                                                         
                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabStx" Text="&nbsp;Страховщик:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxStx" Width="100%" Height="200" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain" OnSelectedIndexChanged="BoxStx_OnSelectedIndexChanged"   
                                        DataSourceID="SdsStx" DataTextField="StxNam" DataValueField="StxKod" >
                                </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Имя , Фирма страхователь ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="10%" class="PO_RowCap">&nbsp;Фамилия И.О:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="FioTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                             <td width="10%" class="PO_RowCap">
                                 <asp:Label id="LabOrg" Text="&nbsp;Фирма:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                <obout:ComboBox runat="server" ID="BoxOrg" Width="100%" Height="200" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain" OnSelectedIndexChanged="BoxOrg_OnSelectedIndexChanged" 
                                        DataSourceID="SdsOrg" DataTextField="OrgNam" DataValueField="OrgKod" >
                                 </obout:ComboBox>  
                            </td>
                        </tr>
 <!--  Отчество , Договор ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;Пол (муж):</td>
                            <td width="35%" style="vertical-align: central;">
                                 <obout:OboutCheckBox runat="server" ID="SexFlg" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
		                         </obout:OboutCheckBox>
                                 &nbsp;Д/р:&nbsp;

                                <obout:OboutTextBox runat="server" ID="BrtDat"  width="22%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                <asp:RegularExpressionValidator ID="regexBrtDat" ControlToValidate="BrtDat" SetFocusOnError="True" 
                                     ValidationExpression="(0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.](19|20)\d\d" ErrorMessage="Ошибка" runat="server" />
                                
                                <asp:Label id="Label1" Text="Статус:" runat="server" Width="10%"/>  

                                 <obout:ComboBox runat="server" ID="BoxSoz"  Width="30%" Height="300" MenuWidth="600" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Дети до 18 лет" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Беременные" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Участники Великой Отечественной войны" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Инвалиды" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Многодетные матери, награжденные подвесками «Алтын алка», «Кумыс алка»" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Получатели адресной социальной помощи" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Пенсионеры по возрасту" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Больным инфекционными, социально-значимыми заболеваниями и заболеваниями, представляющими опасность для окружающих" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="По заболеванию" Value="9" />
                                         </Items>
                                 </obout:ComboBox>  
 <!--  Иност  

                                     <obout:ComboBox runat="server" ID="BoxFam" Width="23%" Height="100" AutoPostBack="true"
                                        FolderStyle="/Styles/Combobox/Plain"  
                                        DataSourceID="sdsFam" DataTextField="FamNam" DataValueField="FamKod" >
                                 </obout:ComboBox>  
     -------------------------------------  -->  

                            </td>
                            <td width="10%" class="PO_RowCap"> 
                                 <asp:Label id="LabEmp" Text="&nbsp;Мест работы:" runat="server" Width="100%"/> 
                             </td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="EmpTxt"  width="90%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>

                        </tr>
 <!--  Пол, Год рождения , Вариант договора ----------------------------------------------------------------------------------------------------------  -->  
 <!-- ИИН , Инвен. номер , Начало страхования, Конец страхования  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                               <td width="10%" class="PO_RowCap">&nbsp;Улица:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrStrTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp;Дом: &nbsp;&nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrDomTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                                 &nbsp;Кв:
                                <obout:OboutTextBox runat="server" ID="AdrAprTxt"  width="12%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                             

                             <td width="10%" class="PO_RowCap">
                                  <asp:Label id="LabBeg" Text="&nbsp;Начало:" runat="server" Width="100%"/> 
                            </td>
                            <td width="35%" style="vertical-align: top;">
                                <obout:OboutTextBox runat="server" ID="BegDat"  width="35%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 <obout:Calendar ID="CalBeg" runat="server"
			 				                    StyleFolder="/Styles/Calendar/styles/default" 
						                        DatePickerMode="true"
						                        ShowYearSelector="true"
						                        YearSelectorType="DropDownList"
						                        TitleText="Выберите год: "
						                        CultureName = "ru-RU"
						                        TextBoxId = "BegDat"
						                        DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                                
                                <asp:Label id="LabEnd" Text="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Конец:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" runat="server" Width="15%"/> 
                                <obout:OboutTextBox runat="server" ID="EndDat"  width="30%" BackColor="White" Height="35px" 
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                             
                             </td>                                                     
                        </tr>

<!--  Телефон , Карта, Сем.карта----------------------------------------------------------------------------------------------------------  -->  
</table>
            <hr />

         </asp:Panel>
 
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ 
                                            <td width="10%" class="PO_RowCap">&nbsp;Область:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="AdrOblTxt"  width="40%" BackColor="White" Height="60px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
    
                                 &nbsp; Район: &nbsp;
                                 <obout:OboutTextBox runat="server" ID="AdrRaiTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>

                            </td>
               
               
               
               --%>
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
                   <input type="button" value="Экстренная карта помощи" style="width:30%"  onclick="PrtKltQrc()" />
                   <input type="button" value="Фото" style="width:20%"  onclick="WebCam();" />
                   <input type="button" value="SMS" style="width:20%"  onclick="SMSsend();" />
               </center>
           </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="KltWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="50" Top="20" Height="450" Width="1000" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="">
       </owd:Window>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>
<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>  
              <!--     Dialog должен быть раньше Window-->
      <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите изменить ИИН ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                                <input type="button" value="ОК" onclick="IinButton_Click();" />
                                <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

   <%-- =================  диалоговое окно для смены пароля  ============================================ --%>
    <div class="IinDialog" title="Смена ИИН" style="display: none">
        <%--        <asp:ValidationSummary runat="server" ID="ValidationSummary" CssClass="ValidationSummary" />  --%>
        <table>
            <tr>
                <td>Новый ИИН:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtIinNew"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegExTxtIinNew"
                                        ControlToValidate="txtIinNew"
                                        ValidationExpression="\d+"
                                        Display="Static"
                                        EnableClientScript="true"
                                        ErrorMessage="Ошибка"
                                        runat="server" />

            </tr>
        </table>
    </div>

    <%-- =================  Пароль успешно изменен  ============================================ --%>
    <div class="OkSuccess" title=" Смена ИИН " style="display: none">
        <table>
            <tr>
                <td>ИИН успешно изменен! 
               </td>
            </tr>
        </table>
    </div>

        <%-- ============================  верхний блок  ============================================ --%>
     <div class="SmsDialog" title="Отправка SMS сообщения" style="display: none">
          <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="ТЕЛЕФОН:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox runat="server" ID="TxtTelSms" Width="80%" onkeypress="OnlyNumeric();" MaxLength="13" onfocus="getIt(this);"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                                                  runat="server" 
                                                  ControlToValidate="TxtTelSms"
                                                  Display="None" 
                                                  ErrorMessage="Invalid phone number" 
                                                  SetFocusOnError="True" 
                                                  ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$">
                        </asp:RegularExpressionValidator>  
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label4" Text="ТЕКСТ СООБЩЕНИЯ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtSmsTxt" Width="80%" Height="200" TextMode="MultiLine" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                   </td>
                </tr>
        </table>
    </div>

   <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    </form>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
                                <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="AddButton_Click" OnClientClick="requestPermission();" />
                               <obout:OboutButton runat="server" ID="OboutButton0"   
                                   FolderStyle="styles/grand_gray/OboutButton" Text="ОК" OnClick="AddButton_Click"
		                           OnClientClick="requestPermission();" />
    --%>

    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    
    <asp:SqlDataSource runat="server" ID="sdsCnt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsVar" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsFam" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsRes" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
               hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>


</body>

</html>



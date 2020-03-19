<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

<%-- ============================  JAVA ============================================ --%>
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

        /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
               

			}
			a.pg:hover {
				color:crimson;
			}

    </style>

 <script type="text/javascript">
     var myconfirm = 0;
//     myDialogDubl.visible = false;

     // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------

     function filterGrid(e) {
         var fieldName;
 //        alert("filterGrid=");

         if (e != 'ВСЕ')
         {
           fieldName = 'KLTFIO';
           GridKlt.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
           GridKlt.executeFilter();
         }
         else {
             GridKlt.removeFilter();
         }
     }


     function OpenDublCrd(AmbCrdIdnDbl) {
         //   alert('GlvDocIdnDbl=' + GlvDocIdnDbl);
         myDialogDubl.Close();

         var AmbCrdIdn = AmbCrdIdnDbl;
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
     }

     function Export() {
     //    alert('Export=');
         myDialogDubl.Open();
     }

     //    ==========================  ПЕЧАТЬ =============================================================================================
     function PrtButton_Click() {

         var GrfFrm = document.getElementById('MainContent_HidBuxFrm').value;
         var GrfUch = document.getElementById('MainContent_BoxUch_ob_CboBoxUchTB').value;
         var GrfBeg = document.getElementById('MainContent_BoxLetBeg_ob_CboBoxLetBegTB').value;
         var GrfEnd = document.getElementById('MainContent_BoxLetEnd_ob_CboBoxLetEndTB').value;
         var GrfDet = document.getElementById('MainContent_ParRadChl').value;
         var GrfSex = document.getElementById('MainContent_BoxSex_ob_CboBoxSexTB').value;
         
         if (GrfUch == "") GrfUch = "Все участки";

         var ua = navigator.userAgent;
         if (ua.search(/Chrome/) > -1)
             window.open("/Report/DauaReports.aspx?ReportName=HspAisScrLst&TekDocIdn=" + GrfUch + "&TekDocKod=" + GrfDet + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekDocTxt=" + GrfSex,
                 "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         else
             window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAisScrLst&TekDocIdn=" + GrfUch + "&TekDocKod=" + GrfDet + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd + "&TekDocTxt=" + GrfSex,
                 "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

     }

 </script>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">

        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int AmbCrdIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //       Sapka.Text = TxtDoc;

            // =====================================================================================
            sdsUch.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsUch.SelectCommand = "SELECT KLTUCH FROM SPRKLT WHERE KLTFRM=" + BuxFrm + " GROUP BY KLTUCH ORDER BY KLTUCH";

            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            HidBuxFrm.Value = BuxFrm;

            BuxKod = (string)Session["BuxKod"];
            HidBuxKod.Value = BuxKod;

            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================

            if (GridKlt.IsCallback)
            {
                Session["pgSize"] = GridKlt.CurrentPageIndex;
            }


            if (!Page.IsPostBack)
            {
                string[] alphabet = "Ә;І;Ғ;Ү;Ұ;Қ;Ө;А;Б;В;Г;Д;Е;Ж;З;И;К;Л;М;Н;О;П;Р;С;Т;У;Ф;Х;Ц;Ч;Ш;Щ;Ы;Э;Ю;Я;A;B;C;D;E;F;G;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;ВСЕ".Split(';');
                rptAlphabet.DataSource = alphabet;
                rptAlphabet.DataBind();
                BoxLetBeg.SelectedText = "30";
                BoxLetEnd.SelectedText = "70";
                BoxLetBeg.SelectedIndex = 1;
                BoxLetEnd.SelectedIndex = 20;
                ParRadChl.Value = "1";
                RadBut002.Checked = true;

                getGrid();

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAisScrLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXSEX", SqlDbType.VarChar).Value = BoxSex.SelectedText;
            cmd.Parameters.Add("@BUXBEG", SqlDbType.VarChar).Value = BoxLetBeg.SelectedText;
            cmd.Parameters.Add("@BUXEND", SqlDbType.VarChar).Value = BoxLetEnd.SelectedText;
            cmd.Parameters.Add("@BUXCHL", SqlDbType.VarChar).Value = ParRadChl.Value;
            cmd.Parameters.Add("@BUXUCH", SqlDbType.VarChar).Value = BoxUch.SelectedText;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAisScrLst");

            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]) + " (" + Convert.ToString(ds.Tables[0].Rows[0]["DLGNAM"]) + ")";
                }
            }
            catch
            {
            }

            con.Close();

            GridKlt.DataSource = ds;
            GridKlt.DataBind();

        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

        // ============================ дублировать амб.карту ==============================================
        protected void ScrButtonOK_Click(object sender, EventArgs e)
        {
            //KltIin = Convert.ToString(parKltIin.Value);

            if (GridKlt.SelectedRecords != null)
            {
                string selectedIIN = "";
                //=====================================================================================
                foreach (Hashtable oRecord in GridKlt.SelectedRecords)
                {
                    selectedIIN += Convert.ToString(oRecord["KLTIIN"])+":";
                }

                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspAisScrLstAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@BUXIINLST", SqlDbType.VarChar).Value = selectedIIN;
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                }
                finally
                {
                    con.Close();
                }
            }
            //           ExecOnLoad("OpenDublCrd(" + AmbCrdIdnDbl + ");");
            getGrid();
        }


        protected void OboutRadioButton_CheckedChanged001(object sender, EventArgs e)
        {
            //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadChl.Value = "0";
            BoxLetBeg.Enabled = false;
            BoxLetEnd.Enabled = false;
            BoxSex.Enabled = false;

            getGrid();
        }
        protected void OboutRadioButton_CheckedChanged002(object sender, EventArgs e)
        {
            //         label1.Text = "<br /><br />The checked state of the radio button has been changed to: " + ((OboutRadioButton)sender).Checked.ToString().ToLower();
            ParRadChl.Value = "1";
            BoxLetBeg.Enabled = true;
            BoxLetEnd.Enabled = true;
            BoxSex.Enabled = true;

            getGrid();
        }

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parKltIin" runat="server" />
 <asp:HiddenField ID="parDbl" runat="server" />
 <asp:HiddenField ID="ParRadChl" runat="server" />
  
 
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="СПИСОК ДЛЯ СКРИНИНГА" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 5%; position: relative; width: 90%; text-align:center"
             runat="server"></asp:TextBox>

             <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
        <center>   
<%-- ============================  верхний блок  ============================================ --%>
                                 <asp:Label id="Label1" Text="Участок:" runat="server"  Width="5%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxUch" Width="20%" Height="150"
                                        FolderStyle="/Styles/Combobox/Plain"
                                        DataSourceID="sdsUch" DataTextField="KLTUCH" DataValueField="KLTUCH">
                                 </obout:ComboBox>


                                 <asp:Label id="LblPvd" Text="Возраст с:" runat="server"  Width="10%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxLetBeg"  Width="10%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem100" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem101" runat="server" Text="30" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem102" runat="server" Text="35" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem103" runat="server" Text="40" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem104" runat="server" Text="42" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem105" runat="server" Text="44" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem106" runat="server" Text="45" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem107" runat="server" Text="46" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem108" runat="server" Text="48" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem109" runat="server" Text="50" Value="9" />
                                            <obout:ComboBoxItem ID="ComboBoxItem110" runat="server" Text="52" Value="10" />
                                            <obout:ComboBoxItem ID="ComboBoxItem111" runat="server" Text="54" Value="11" />
                                            <obout:ComboBoxItem ID="ComboBoxItem112" runat="server" Text="55" Value="12" />
                                            <obout:ComboBoxItem ID="ComboBoxItem113" runat="server" Text="56" Value="13" />
                                            <obout:ComboBoxItem ID="ComboBoxItem114" runat="server" Text="58" Value="14" />
                                            <obout:ComboBoxItem ID="ComboBoxItem115" runat="server" Text="60" Value="15" />
                                            <obout:ComboBoxItem ID="ComboBoxItem116" runat="server" Text="62" Value="16" />
                                            <obout:ComboBoxItem ID="ComboBoxItem117" runat="server" Text="64" Value="17" />
                                            <obout:ComboBoxItem ID="ComboBoxItem118" runat="server" Text="66" Value="18" />
                                            <obout:ComboBoxItem ID="ComboBoxItem119" runat="server" Text="68" Value="19" />
                                            <obout:ComboBoxItem ID="ComboBoxItem120" runat="server" Text="70" Value="20" />
                                         </Items>
                                 </obout:ComboBox>  
                                 
                                 <asp:Label id="LblNpr" Text=" до:" runat="server"  Width="5%" Font-Bold="true" />                             
                                <obout:ComboBox runat="server" ID="BoxLetEnd"  Width="10%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem200" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem201" runat="server" Text="30" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem202" runat="server" Text="35" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem203" runat="server" Text="40" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem204" runat="server" Text="42" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem205" runat="server" Text="44" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem206" runat="server" Text="45" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem207" runat="server" Text="46" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem208" runat="server" Text="48" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem209" runat="server" Text="50" Value="9" />
                                            <obout:ComboBoxItem ID="ComboBoxItem210" runat="server" Text="52" Value="10" />
                                            <obout:ComboBoxItem ID="ComboBoxItem211" runat="server" Text="54" Value="11" />
                                            <obout:ComboBoxItem ID="ComboBoxItem212" runat="server" Text="55" Value="12" />
                                            <obout:ComboBoxItem ID="ComboBoxItem213" runat="server" Text="56" Value="13" />
                                            <obout:ComboBoxItem ID="ComboBoxItem214" runat="server" Text="58" Value="14" />
                                            <obout:ComboBoxItem ID="ComboBoxItem215" runat="server" Text="60" Value="15" />
                                            <obout:ComboBoxItem ID="ComboBoxItem216" runat="server" Text="62" Value="16" />
                                            <obout:ComboBoxItem ID="ComboBoxItem217" runat="server" Text="64" Value="17" />
                                            <obout:ComboBoxItem ID="ComboBoxItem218" runat="server" Text="66" Value="18" />
                                            <obout:ComboBoxItem ID="ComboBoxItem229" runat="server" Text="68" Value="19" />
                                            <obout:ComboBoxItem ID="ComboBoxItem230" runat="server" Text="70" Value="20" />
                                         </Items>
                                 </obout:ComboBox>  

                                 <asp:Label id="LblVid" Text="Пол:" runat="server"  Width="5%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxSex"  Width="10%" Height="200"
                                        FolderStyle="/Styles/Combobox/Plain">
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem300" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem301" runat="server" Text="Муж" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem302" runat="server" Text="Жен" Value="2" />
                                        </Items>
                                 </obout:ComboBox>  

                 <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>

                 <obout:OboutRadioButton runat="server" ID="RadBut001" Width="5%" OnCheckedChanged="OboutRadioButton_CheckedChanged001"
                        FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Дети" AutoPostBack="true" GroupName="g1" />
                 <obout:OboutRadioButton runat="server" ID="RadBut002" Width="5%" OnCheckedChanged="OboutRadioButton_CheckedChanged002"
                        FolderStyle="/Styles/Interface/plain/OboutRadioButton" Text="Взрослые" AutoPostBack="true" GroupName="g1" />

           </center>

    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>


 <%-- ============================  OnClientDblClick  ============================================ 
      <ClientSideEvents ExposeSender="true"
                        OnClientDblClick="OnClientDblClick"
     --%>

 <%-- ============================  OnClientSelect  ============================================ 
       AllowRecordSelection = "true"
      <ClientSideEvents ExposeSender="false"
                          OnClientSelect="OnClientSelect"
     --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridKlt" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "200"
	            AllowPaging="true"
                EnableRecordHover="true"
                AllowManualPaging="false"
                 AllowMultiRecordSelection="true"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
	            ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
	        	    <obout:Column ID="Column0A" DataField="UCH" HeaderText="УЧАС" Width="5%"/>
	        	    <obout:Column ID="Column00" DataField="KLTIIN" HeaderText="ИИН" Width="8%"/>
	                <obout:Column ID="Column01" DataField="KLTFIO" HeaderText="ФИО" Width="21%" />
	                <obout:Column ID="Column02" DataField="Sex" HeaderText="ПОЛ" Width="4%" Align="center" />
	                <obout:Column ID="Column04" DataField="KLTTEL" HeaderText="ТЕЛ" Width="11%" Align="center" Wrap="true" />
	                <obout:Column ID="Column05" DataField="LET" HeaderText="ВОЗРАСТ" Width="5%" Align="center" />
	                <obout:Column ID="Column06" DataField="БСК" HeaderText="БСК" Width="6%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap000" />
				    </obout:Column>				
	                <obout:Column ID="Column08" DataField="глаз_давления" HeaderText="Глаукома" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap001" />
				    </obout:Column>				
	                <obout:Column ID="Column07" DataField="холестерин" HeaderText="Сах.диабет" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap002" />
				    </obout:Column>				
	                <obout:Column ID="Column09" DataField="цитология" HeaderText="РШМ" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap004" />
				    </obout:Column>				
	                <obout:Column ID="Column10" DataField="мамография" HeaderText="РМЖ" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap005" />
				    </obout:Column>				
	                <obout:Column ID="Column11" DataField="кала_на_кровь" HeaderText="Кал на кровь" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap006" />
				    </obout:Column>				
	                <obout:Column ID="Column12" DataField="ФГДС" HeaderText="Пищ.Желуд." Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap007" />
				    </obout:Column>				
	                <obout:Column ID="Column13" DataField="ПСА" HeaderText="ПСА" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap009" />
				    </obout:Column>				
	                <obout:Column ID="Column14" DataField="ОАК" HeaderText="PROF" Width="5%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap003" />
				    </obout:Column>				
		        </Columns>
                <Templates>								
                    <obout:GridTemplate runat="server" ID="TemplateSap000">
                      <Template>
                          БСК<br />Z13.6
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap001">
                      <Template>
                          Глаукома<br />Z13.5
                      </Template>
                    </obout:GridTemplate>  

                    <obout:GridTemplate runat="server" ID="TemplateSap002">
                      <Template>
                           Сах.диабет<br />Z13.1
                      </Template>
                    </obout:GridTemplate>   

                    <obout:GridTemplate runat="server" ID="TemplateSap003">
                      <Template>
                          Дети<br />Z00.0
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap004">
                      <Template>
                          РШМ<br />Z12.4
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap005">
                      <Template>
                          РМЖ<br />Z12.3
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap006">
                      <Template>
                          Колорект.рак<br />Z12.8
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap007">
                      <Template>
                          РПЖ<br />Z12.0
                      </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSap009">
                      <Template>
                          ПСА<br />Z12.5
                      </Template>
                    </obout:GridTemplate>

                </Templates>

           	</obout:Grid>

        <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <input type="button" name="AddButton" value="В скрининг" id="AddButton" onclick="Export();">
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel> 

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogDubl" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Дублирования амбулаторной карты" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите отправить на скрининг?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="ScrButtonOK_Click" />
                              <input type="button" value="Отмена" onclick="myDialogDubl.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 

<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
 <asp:SqlDataSource runat="server" ID="sdsUch" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

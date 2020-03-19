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
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            //       Sapka.Text = TxtDoc;
            GridKlt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
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
                BoxGod.SelectedIndex = 0;
                BoxGod.SelectedText = "2017";

                parCmp.Value = "0";
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
            SqlCommand cmd = new SqlCommand("HspAisScrPlnLst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXGOD", SqlDbType.VarChar).Value = BoxGod.SelectedText;
            cmd.Parameters.Add("@BUXCMP", SqlDbType.VarChar).Value = parCmp.Value;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAisScrPlnLst");

            con.Close();

            GridKlt.DataSource = ds;
            GridKlt.DataBind();

        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            parCmp.Value = "1";
            getGrid();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int  ScrPlnIdn = Convert.ToInt32(e.Record["ScrPlnIdn"]);
            string ScrDat;
            string ScrDatNxt;

            if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrDat"]))) ScrDat = DateTime.Now.ToString("dd.MM.yyyy");
            else  ScrDat = Convert.ToDateTime(e.Record["ScrDat"]).ToString("dd.MM.yyyy");

            if (string.IsNullOrEmpty(Convert.ToString(e.Record["ScrDatNxt"]))) ScrDatNxt = DateTime.Now.ToString("dd.MM.yyyy");
            else  ScrDatNxt = Convert.ToDateTime(e.Record["ScrDatNxt"]).ToString("dd.MM.yyyy");

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspAisScrPlnLstUpd", con);
            cmd = new SqlCommand("HspAisScrPlnLstUpd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            cmd.Parameters.Add("@ScrPlnIdn", SqlDbType.VarChar).Value = ScrPlnIdn;
            cmd.Parameters.Add("@ScrPlnBck", SqlDbType.VarChar).Value = Convert.ToString(e.Record["БСК"]);
            cmd.Parameters.Add("@ScrPlnGlo", SqlDbType.VarChar).Value = Convert.ToString(e.Record["глаз_давления"]);
            cmd.Parameters.Add("@ScrPlnSax", SqlDbType.VarChar).Value = Convert.ToString(e.Record["холестерин"]);
            cmd.Parameters.Add("@ScrPlnPrf", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ОАК"]);
            cmd.Parameters.Add("@ScrPlnZit", SqlDbType.VarChar).Value = Convert.ToString(e.Record["цитология"]);
            cmd.Parameters.Add("@ScrPlnMam", SqlDbType.VarChar).Value = Convert.ToString(e.Record["мамография"]);
            cmd.Parameters.Add("@ScrPlnKal", SqlDbType.VarChar).Value = Convert.ToString(e.Record["кала_на_кровь"]);
            cmd.Parameters.Add("@ScrPlnFgd", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ФГДС"]);
            cmd.Parameters.Add("@ScrPlnPsa", SqlDbType.VarChar).Value = Convert.ToString(e.Record["ПСА"]);
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();            // ------------------------------------------------------------------------------заполняем второй уровень

            parCmp.Value = "1";
            getGrid();

        }
        // ============================ дублировать амб.карту ==============================================

    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField ID="parKltIin" runat="server" />
 <asp:HiddenField ID="parCmp" runat="server" />
 <asp:HiddenField ID="ParRadChl" runat="server" />
  
 
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="ПЛАН,ФАКТ ПО СКРИНИНГУ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 10%; position: relative; width: 80%; text-align:center"
             runat="server"></asp:TextBox>

             <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
                Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
                <center>   
<%-- ============================  верхний блок  ============================================ --%>
                                 <asp:Label id="LblPvd" Text="ГОД:" runat="server"  Width="10%" Font-Bold="true" />                             
                                 <obout:ComboBox runat="server" ID="BoxGod"  Width="10%" Height="200" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem100" runat="server" Text="2017" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem101" runat="server" Text="2018" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem102" runat="server" Text="2019" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem103" runat="server" Text="2020" Value="3" />
                                         </Items>
                                 </obout:ComboBox>  
                                 
                 <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
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
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 460px;">
	        
	        <obout:Grid id="GridKlt" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_1" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
  EnableTypeValidation="false"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "300"
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
	        	    <obout:Column ID="Column00" DataField="ScrPlnIdn" HeaderText="УЧАС" Width="0%" Visible="false"/>
	        	    <obout:Column ID="Column01" DataField="ScrPlnMesTxt" HeaderText="МЕСЯЦ" ReadOnly="true" Width="10%"/>
	                <obout:Column ID="Column02" DataField="ScrPlnNnn" HeaderText="ПЛАН" ReadOnly="true" Width="10%" />
	                <obout:Column ID="Column04" DataField="БСК" HeaderText="БСК" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap000" />
				    </obout:Column>				
	                <obout:Column ID="Column05" DataField="глаз_давления" HeaderText="Глаукома" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap001" />
				    </obout:Column>				
	                <obout:Column ID="Column06" DataField="холестерин" HeaderText="Сах.диабет" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap002" />
				    </obout:Column>				
	                <obout:Column ID="Column08" DataField="цитология" HeaderText="РШМ" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap004" />
				    </obout:Column>				
	                <obout:Column ID="Column09" DataField="мамография" HeaderText="РМЖ" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap005" />
				    </obout:Column>				
	                <obout:Column ID="Column10" DataField="кала_на_кровь" HeaderText="Кал на кровь" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap006" />
				    </obout:Column>				
	                <obout:Column ID="Column11" DataField="ФГДС" HeaderText="РПЖ" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap007" />
				    </obout:Column>				
	                <obout:Column ID="Column13" DataField="ПСА" HeaderText="ПСА" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap009" />
				    </obout:Column>				
	                <obout:Column ID="Column07" DataField="ОАК" HeaderText="PROF" Width="8%" Align="center" >
				         <TemplateSettings HeaderTemplateID="TemplateSap003" />
				    </obout:Column>				
                    <obout:Column ID="Column14" DataField="" HeaderText="КОРР" Width="8%" AllowEdit="true" AllowDelete="false" />
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
                          Проф.детей<br />Z00.0
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

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <input type="button" name="AddButton" value="Печать" id="AddButton" onclick="Prt_Button();">
             </center>
  </asp:Panel> 

    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

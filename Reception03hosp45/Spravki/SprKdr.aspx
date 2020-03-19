<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ============================конец для почты  ============================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--  ссылка на JQUERY -------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <!-- -------------------------------------------------------------------------------- -->

 
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

              /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

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
    </style>
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        int KdrIdn;
        int KdrKod;
        string KdrKodTxt;
        string KdrFam;
        string KdrIma;
        string KdrOtc;
        bool KdrSex;
        string KdrIIN;

        int EduIdn;
        int EduKod;
        string EduNam;
        string EduKvl;

        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            //           OboutInc.Calendar2.Calendar orderDateCalendar = (OboutInc.Calendar2.Calendar)(SuperForm1.Rows[6].Cells[1].Controls[0].Controls[1].Controls[0]);
            //           orderDateCalendar.CultureName = "ru-RU";

            if (Session["KDRKODSES"] == null) Session.Add("KDRKODSES", (string)"0");
            KdrKodTxt = (string)Session["KDRKODSES"];
            if (KdrKodTxt == null || KdrKodTxt == "") KdrKodTxt = "0";

            //         grid1.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            grid1.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            //           grid1.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);



            if (IsPostBack)
            {
                /*              
                              string eventTarget = (this.Request["__EVENTTARGET"] == null ? string.Empty : this.Request["__EVENTTARGET"]);
                              string eventArgument = (this.Request["__EVENTARGUMENT"] == null ? string.Empty : this.Request["__EVENTARGUMENT"]);
                              if (eventTarget == "item2")
                              {
                                  string[] args = eventArgument.Split('|');
                                  string ParNam = args[0];
                                  string ParVal = args[1];
              */
                //               getGridEdu();


            }
            else
            {
                //             TxtSpr = (string)Request.QueryString["TxtSpr"];
                Sapka.Text = (string)Request.QueryString["TxtSpr"];
                //=====================================================================================
                getGrid();
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            // создание DataSet.
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM KDR WHERE KDRFRM=" + BuxFrm + " ORDER BY KDRFAM", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprKdr");
            grid1.DataSource = ds;
            grid1.DataBind();

        }

        // ============================ чтение таблицы а оп ==============================================
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            string KdrBrtTxt;
            int KdrKodSup;

            //      KdrKod = Convert.ToInt32(e.Record["KDRKOD"]);
            KdrFam = Convert.ToString(e.Record["KDRFAM"]);
            KdrIma = Convert.ToString(e.Record["KDRIMA"]);
            KdrOtc = Convert.ToString(e.Record["KDROTC"]);

            KdrBrtTxt = Convert.ToString(e.Record["KDRBRT"]);
            if (string.IsNullOrEmpty(KdrBrtTxt))
            { KdrBrtTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { KdrBrtTxt = Convert.ToDateTime(e.Record["KDRBRT"]).ToString("dd.MM.yyyy"); }
            //            KdrBrt = Convert.ToDateTime(e.Record["KDRBRT"]);
            KdrSex = Convert.ToBoolean(e.Record["KDRSEX"]);
            KdrIIN = Convert.ToString(e.Record["KDRIIN"]);
            
            KdrKodSup = Convert.ToInt32(e.Record["KDRKODSUP"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO KDR (KDRKOD,KDRKODSUP,KDRFAM,KDRIMA,KDROTC,KDRBRT,KDRSEX,KDRIIN,KDRFRM) " +
                                            "VALUES ((SELECT MAX(KDRKOD) AS KOD FROM KDR)+1,"+KdrKodSup+",'" + KdrFam + "','" + KdrIma + "','" + KdrOtc +
                                            "',CONVERT(DATETIME,'" + KdrBrtTxt + "',104)," + KdrSex + "," + KdrIIN + "," + BuxFrm + ")", con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
        /*
                void UpdateRecord(object sender, GridRecordEventArgs e)
                {
                    string KdrBrtTxt;

                    KdrIdn = Convert.ToInt32(e.Record["KDRIDN"]);
                    KdrKod = Convert.ToInt32(e.Record["KDRKOD"]);
                    KdrFam = Convert.ToString(e.Record["KDRFAM"]);
                    KdrIma = Convert.ToString(e.Record["KDRIMA"]);
                    KdrOtc = Convert.ToString(e.Record["KDROTC"]);

                    KdrBrtTxt = Convert.ToString(e.Record["KDRBRT"]);
                    if (string.IsNullOrEmpty(KdrBrtTxt))
                    { KdrBrtTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
                    else
                    { KdrBrtTxt = Convert.ToDateTime(e.Record["KDRBRT"]).ToString("dd.MM.yyyy"); }

                    //            KdrBrt = Convert.ToDateTime(e.Record["KDRBRT"]);
                    KdrSex = Convert.ToBoolean(e.Record["KDRSEX"]);
                    KdrIIN = Convert.ToString(e.Record["KDRIIN"]);


                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    con.Open();

                    // создание команды
                    SqlCommand cmd = new SqlCommand("UPDATE KDR SET KDRKOD=" + KdrKod + ",KDRFAM='" + KdrFam + "',KDRIMA='" + KdrIma + "',KDROTC='" + KdrOtc +
                                                    "',KDRBRT=CONVERT(DATETIME,'" + KdrBrtTxt + "',104),KDRSEX='" + KdrSex + "',KDRIIN=" + KdrIIN +
                                                    " WHERE KDRIDN=" + KdrIdn + " AND KDRFRM=" + BuxFrm, con);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    getGrid();
                }
        */
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            KdrIdn = Convert.ToInt32(e.Record["KDRIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM KDR WHERE KDRIDN=" + KdrIdn, con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

        [WebMethod]
        public static bool SetValue(string val)
        {
            HttpContext.Current.Session["KDRKODSES"] = val;
            return true;
        }

    </script>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        // ------------------------  при выборе вкладок  ------------------------------------------------------------------
        // Client-Side Events for Delete
        function grid1_ClientDelete(sender, record) {
            if (myconfirm == 1) {
                return true;
            }
            else {
                document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить ?";
                document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                myConfirmBeforeDelete.Open();
                return false;
            }
        }

        function findIndex(record) {
            var index = -1;
            for (var i = 0; i < grid1.Rows.length; i++) {
                if (grid1.Rows[i].Cells[0].Value == record.KDRIDN) {
                    index = i;
                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            grid1.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }
        
        function grid1_ClientEdit(sender, record) {
           
            var TempSession = record.KDRKOD;
            $.ajax({
                    type: 'POST',
                    url: 'SprKdr.aspx/SetValue',
                    data: '{"val":"' + TempSession + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(msg) { }
                });
                   
             myWindow.Open();
 //           alert(TempSession);
             myWindow.setUrl("SprKdrOne.aspx");
             
            return false;
        }

        function grid1_ClientInsert(sender, record) {
            var TempSession = "0";
            $.ajax({
                type: 'POST',
                url: 'SprKdr.aspx/SetValue',
                data: '{"val":"' + TempSession + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function(msg) { }
            });

            myWindow.Open();
            //           alert(TempSession);
            myWindow.setUrl("SprKdrOne.aspx");

            return false;
        }
    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="hiddenServerEvent" runat="server" />
    <input type="hidden" id="KDRIDN" />
    <input type="hidden" id="KDRKOD" />
    <asp:HiddenField ID="KDRKODHID" runat="server" Value="OLD" />
 
    <span id="WindowPositionHelper"></span>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>  
    <owd:Window runat="server"  Title="Карта сотрудника" IsModal="true" Overflow="AUTO"  
              ID="myWindow" Width="800" Url="SprWin000.aspx" Height="500" Left="200" Top="100" VisibleOnLoad="false" ShowCloseButton="true"  
              StyleFolder="Styles/Window/wdstyles/default" ShowStatusBar="true" >
    </owd:Window>
  
      
  <!--  конец -----------------------------------------------  -->    
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
       
     
<!--  конец -----------------------------------------------  -->    
        <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 1260px; text-align:center"
             runat="server"></asp:TextBox>
             
        <div id="div_kdr" style="position:relative;left:15%;" >
             <obout:Grid id="grid1" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "true" >
                                   <ScrollingSettings ScrollHeight="600" />
                                   <ClientSideEvents 
		                                OnBeforeClientEdit="grid1_ClientEdit" 
		                                OnBeforeClientDelete="grid1_ClientDelete" 
		                                OnBeforeClientAdd="grid1_ClientInsert"
		                                ExposeSender="true"/>
                    			<Columns>
	                    			<obout:Column ID="Column1" DataField="KDRIDN" HeaderText="Идн" Width="0" ReadOnly="true" />											
	                    			<obout:Column ID="Column2" DataField="KDRKOD" HeaderText="Код" Width="75" ReadOnly="true" />											
	                    			<obout:Column ID="Column3" DataField="KDRFAM" HeaderText="Фамилия" Width="150" />											
                    				<obout:Column ID="Column4" DataField="KDRIMA" HeaderText="Имя" Width="100" />
                    				<obout:Column ID="Column5" DataField="KDROTC" HeaderText="Отчество" Width="100" />
                    				<obout:Column ID="Column6" DataField="KDRBRT" HeaderText="Дата рож"  Width="80" DataFormatString = "{0:dd/MM/yy}" />
                    				<obout:Column ID="Column7" DataField="KDRSEX" HeaderText="Пол" Width="60" >
	            			              <TemplateSettings TemplateId="TemplateSex" EditTemplateId="TemplateEditSex" />
	            			        </obout:Column>
              			        	<obout:Column ID="Column8" DataField="KDRIIN" HeaderText="ИИН" Width="120" />
	                    			<obout:Column ID="Column9" DataField="KDRKODSUP" HeaderText="Код" Width="75" />											
		                    		<obout:Column ID="Column10" DataField="" HeaderText="Корр" Width="100" AllowEdit="true" AllowDelete="true" />
		                    	</Columns>
		                    	
		                    	<Templates>								
		    		           		<obout:GridTemplate runat="server" ID="TemplateSex" UseQuotes="true">
	    				                <Template>
    						                <%# (Container.Value == "True" ? "М" : "Ж") %>
    					                </Template>
				                    </obout:GridTemplate>
				                    <obout:GridTemplate runat="server" ID="TemplateEditSex" ControlID="chkSex" ControlPropertyName="checked" UseQuotes="false">
					                    <Template>
						                    <input type="checkbox" id="chkSex"/>
					                    </Template>
				                    </obout:GridTemplate>
	                    		</Templates>
	
	                    	</obout:Grid>	
     </div>
     
    <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>

   
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
</asp:Content>
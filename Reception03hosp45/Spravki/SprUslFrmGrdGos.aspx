<%@ Page Title="" Language="C#" AutoEventWireup="true"  Inherits="OboutInc.oboutAJAXPage"%>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
        <script type="text/javascript">

            function cancelChanges() {
                Window1.Close();
            }


            function GridPrc_rsx() {
      //                  alert("GridPrz_rsx=");
                var UslIdn = document.getElementById('USLIDN').value;
                var UslFrmIdn = document.getElementById('USLFRMIDN').value;
                var UslFrmNam = document.getElementById('USLNAM').value;
                /*
          //      RsxWindow.setTitle(UslFrmIdn);
                RsxWindow.setUrl("SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslFrmIdn);
                RsxWindow.Open();
*/

                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn+"&UslNam="+UslFrmNam, "ModalPopUp2", "width=900,height=480,left=250,top=210,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn + "&UslNam=" + UslFrmNam, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:900px;dialogHeight:480px;");

                return true;
            }


            function GridPrc_ClientEdit(sender, record) {
            //               alert("GridPrc_ClientEdit");
                var SprUslIdn = record.USLIDN;
                var SprUslFrmIdn = record.USLFRMIDN;
                var SprUslCnt = document.getElementById('parSprCnt').value;
                var SprUslKey = document.getElementById('parSprKey').value;

                PrcWindow.setTitle(SprUslIdn);
                PrcWindow.setUrl("SprUslFrmGrdOneGos.aspx?SprUslIdn=" + SprUslIdn + "&SprUslFrmIdn=" + SprUslFrmIdn + "&SprUslCnt=" + SprUslCnt + "&SprUslKey=" + SprUslKey);
                //     PrcWindow.setUrl("DocAppAmbPrcOne.aspx?AmbPrcIdn=" + AmbPrcIdn);
                PrcWindow.Open();

                return false;
            }

            function PrcOneClose() {
                PrcWindow.Close();
            }

            function WindowClose() {
                //          alert("GridPrcClose");
                var jsVar = "callPostBack";
                __doPostBack('callPostBack', jsVar);
                //  __doPostBack('btnSave', e.innerHTML);
            }

            </script>



     
</head>



    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid GridPrc = new Grid();

        string BuxSid;
        string BuxFrm;
        string Html;
        string UslKey000;
        string UslKey003;
        string UslKey007;
        string UslKey011;
        string UslKey015;

        string ComParKey = "";
        string ComParTxt = "";
        string ComParCnt = "";
        string whereClause = "";

        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            GridPrc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            /*
            SdsPrc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsPrc.SelectCommand = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprFrmStx INNER JOIN SprPrc ON SprFrmStx.FrmStxPrc=SprPrc.PrcKod " +
                                   "WHERE SprFrmStx.FrmStxKodFrm=" + BuxFrm +
                                   " GROUP BY SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "ORDER BY SprPrc.PrcKod";
            */
            SdsOrg.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM AS ORGNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm + " ORDER BY ORGHSPNAM";
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //             getPrcNum(); 
                //              PopulateTree();


                ComParKey = (string)Request.QueryString["NodKey"];
                ComParTxt = (string)Request.QueryString["NodTxt"];
                ComParCnt = (string)Request.QueryString["NumPrc"];
                parSprKey.Value = ComParKey;
                parSprCnt.Value = ComParCnt;
                parSprTxt.Value = ComParTxt;
                parBuxFrm.Value = BuxFrm;
                parCond.Value = "";
            }
            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {
            string NumPrc;

            //            NumPrc = Convert.ToInt32(ComParCnt);
            NumPrc = parSprCnt.Value;
            ComParKey = parSprKey.Value;
            //    Service1 ws = new Service1();
            Service1Soap ws = new Service1SoapClient();
            DataSet ds = new DataSet("Menu");
            if (ComParKey == null) return;

            if (string.IsNullOrEmpty(ComParKey)) return;    // проверка на null и пробел
            whereClause = parCond.Value;


            //       TxtUsl.Text = ComParTxt.PadLeft(100);      // добавляет слева пробел выравнивая общую длину до 1000
            TxtUsl.Text = ComParTxt;

            if (whereClause == null || whereClause == "")
            {
                switch (ComParKey.Length)
                {
                    case 0:
                        // Populate the first-level nodes.
                        // PopulateCategories(e.Node);
                        break;
                    case 3:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 3, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 7:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 7, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 11:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 11, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    default:
                        break;
                }
            }
            else
            {
                ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 0, whereClause, NumPrc));
                GridPrc.DataSource = ds;
                GridPrc.DataBind();

            }
        }

        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        //------------------------------------------------------------------------
        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            int UslIdn;
            int UslFrmIdn;
            int UslKod;
            string UslZen;
            string UslZenDom;
            string UslTimMin;
            string UslTimMax;
            string UslMem;
            string UslAkz;
            string UslIin;
            int UslIinKol;
            string ZenFlg;

            UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

            ZenFlg = Convert.ToString(e.Record["ZENFLG"]);

            if (e.Record["USLFRMIDN"] == null || e.Record["USLFRMIDN"] == "")  UslFrmIdn = 0;
            else UslFrmIdn = Convert.ToInt32(e.Record["USLFRMIDN"]);

            UslKod = Convert.ToInt32(e.Record["USLKOD"]);
            if (ZenFlg == "true") UslZen = Convert.ToString(e.Record["USLZEN"]);
            else UslZen ="";
        //    UslZen = Convert.ToString(e.Record["USLFRMZEN"]);
            UslZenDom = "";  // Convert.ToString(e.Record["USLFRMZENDOM"]);
            //          UslTimMin = Convert.ToString(e.Record["USLFRMTIMMIN"]);
            //          UslTimMax = Convert.ToString(e.Record["USLFRMTIMMAX"]);
            UslMem = ""; // Convert.ToString(e.Record["USLFRMMEM"]);
            UslAkz = ""; // Convert.ToString(e.Record["USLFRMAKZ"]);
            UslIin = Convert.ToString(e.Record["USLFRMIIN"]);

            if (e.Record["USLFRMIINKOL"] == null || e.Record["USLFRMIINKOL"] == "")  UslIinKol = 0;
            else UslIinKol = Convert.ToInt32(e.Record["USLFRMIINKOL"]);

            //           Service1Soap ws = new Service1SoapClient();
            ComSprUslFrmRep(MdbNam, BuxSid, UslZen, UslZenDom,"30", "30", UslMem, UslAkz, UslIin, UslIinKol, UslIdn, UslFrmIdn, UslKod);

            LoadGridNode();
        }

        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndUsl.Text != "")
            {
                I = I + 1;
                //             whereClause += "SprUsl.UslNamFul LIKE '%" + FndUsl.Text.Replace("'", "''") + "%'";
                whereClause += " '%" + FndUsl.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
                parCond.Value = whereClause;
                /*
                                Service1 ws = new Service1();
                                DataSet ds = new DataSet("Menu");
                                ds.Merge(ws.InsSprKltSelFil(MdbNam, BuxSid, BuxFrm, whereClause));
                                grid1.DataSource = ds;
                                grid1.DataBind();
                */
                //           sdsPrg.SelectCommand = "InsPlnFktOneKlt";

                LoadGridNode();

            }
        }


        // ============================ чтение заголовка таблицы а оп ==============================================
        // ==================================================================================================  

        // изменение подразделении  (справочника SPRSTRFRM)
        public bool ComSprUslFrmRep(string BUXMDB, string BUXSID, string USLZEN, string USLZENDOM, string USLTIMMIN, string USLTIMMAX, string USLMEM, string USLAKZ,string USLIIN,int USLIINKOL, int USLIDN, int USLFRMIDN, int USLKOD)
        {

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("ComSprUslFrmRep", con);
            cmd = new SqlCommand("ComSprUslFrmRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXSID", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLZEN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLZENDOM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLMEM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLTIMMIN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLTIMMAX", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLAKZ", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLIIN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@USLIINKOL", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@USLIDN", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@USLFRMIDN", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@USLKOD", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@USLFRM", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@USLPRC", SqlDbType.Int, 4));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXSID"].Value = BUXSID;
            cmd.Parameters["@USLZEN"].Value = USLZEN;
            cmd.Parameters["@USLZENDOM"].Value = USLZENDOM;
            cmd.Parameters["@USLMEM"].Value = USLMEM;
            cmd.Parameters["@USLTIMMIN"].Value = USLTIMMIN;
            cmd.Parameters["@USLTIMMAX"].Value = USLTIMMAX;
            cmd.Parameters["@USLAKZ"].Value = USLAKZ;
            cmd.Parameters["@USLIIN"].Value = USLIIN;
            cmd.Parameters["@USLIINKOL"].Value = USLIINKOL;
            cmd.Parameters["@USLIDN"].Value = USLIDN;
            cmd.Parameters["@USLFRMIDN"].Value = USLFRMIDN;
            cmd.Parameters["@USLKOD"].Value = USLKOD;
            cmd.Parameters["@USLFRM"].Value = parBuxFrm.Value;
            cmd.Parameters["@USLPRC"].Value = parSprCnt.Value;

            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            return true;
        }

 </script>   


<body>
    <form id="form1" runat="server">   
<%-- ============================  JAVA ============================================ --%>
  

<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <asp:HiddenField ID="parUslKod" runat="server" />
  <asp:HiddenField ID="parUslNam" runat="server" />
  <asp:HiddenField ID="parSprTxt" runat="server" />
  <asp:HiddenField ID="parSprCnt" runat="server" />
  <asp:HiddenField ID="parSprKey" runat="server" />
  <asp:HiddenField ID="parBuxFrm" runat="server" />
  <asp:HiddenField ID="parCond" runat="server" />

  <input type="hidden" name="hhh" id="par" />
  
    <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <!--  для источника -----------------------------------------------  -->
     
    <div>
                           <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="5%" class="PO_RowCap" align="left">&nbsp;&nbsp;Услуга:</td>
                            <td width="20%">
                                <asp:TextBox ID="FndUsl" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>

                            <td width="5%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td>&nbsp;</td>
                            <td width="70%">
      <asp:TextBox ID="TxtUsl" 
             Text="                                                            Справочник услуг" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>
                             </td>
                        </tr>
                  </table>
  

                        <obout:Grid id="GridPrc" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   EnableTypeValidation="false"      
	         		               AllowAddingRecords = "false"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="false"
                                   Width="100%"
                                   AllowPageSizeSelection="false">
                                   <ClientSideEvents OnBeforeClientEdit="GridPrc_ClientEdit" ExposeSender="true"/>
                                  <ScrollingSettings ScrollHeight="450" />
                  		    	<Columns>
	                    			<obout:Column ID="Column00" DataField="USLIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="USLFRMIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column02" DataField="STRUSLKEY" HeaderText="Ключ" Visible="false" Width="0%"/>											
	                    			<obout:Column ID="Column03" DataField="USLGRP001" HeaderText="ГРП" ReadOnly = "true" Align="right" Width="5%" />											
	                    			<obout:Column ID="Column04" DataField="USLGRP002" HeaderText="ГРП" ReadOnly = "true" Align="right" Width="5%" />											
	                    			<obout:Column ID="Column05" DataField="USLKOD" HeaderText="КОД" ReadOnly = "true" Align="right" Width="4%" />											
	                    			<obout:Column ID="Column06" DataField="USLTRF" HeaderText="ТАРИФ" ReadOnly = "true" Align="center" Width="9%" />											
                    				<obout:Column ID="Column07" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ" ReadOnly = "true" Wrap="true" Width="45%" />
                    				<obout:Column ID="Column08" DataField="EDNNAM" HeaderText="ЕД.ИЗМ" ReadOnly = "true" Width="5%" />
		              				<obout:Column ID="Column09" DataField="USLZEN" HeaderText="ЦЕНА" ReadOnly = "true" Width="5%" Align="right" />
<%--		              				<obout:Column ID="Column10" DataField="USLFRMIIN" HeaderText="МО УСЛУГА" Width="18%" >
                                           <TemplateSettings TemplateId="TemplateOrgNam" EditTemplateId="TemplateEditOrgNam" />
                                    </obout:Column>--%>
		              				<obout:Column ID="Column10" DataField="ORGNAM" HeaderText="МО УСЛУГА" Width="8%" Align="center" />
                                    <obout:Column ID="Column11" DataField="USLFRMIINKOL" HeaderText="КОЛ" Width="4%" />
                                    <obout:Column ID="Column12" DataField="ZENFLG" HeaderText="УСЛУГА" Align="center" Width="5%">
                                          <TemplateSettings TemplateId="TemplateZen" EditTemplateId="TemplateEditZen" />
                                    </obout:Column>
                                    <obout:Column HeaderText="ИЗМ" Width="5%" AllowEdit="true" AllowDelete="false" runat="server">
                                           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                                    </obout:Column>
		                    	</Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridPrc.edit_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохран" class="tdTextSmall" onclick="GridPrc.update_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateZen" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>

                </Templates>


	
	                    	</obout:Grid>	
        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="RsxWindow" runat="server" Url="SprUslFrmGrdRsx.aspx" IsModal="true" ShowCloseButton="true" Status=""
            RelativeElementID="WindowPositionHelper" Left="300" Top="200" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/aura"
            Title="Справочник расхода материалов">
        </owd:Window>

          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="PrcWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="100" Top="10" Height="470" Width="900" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="ПРЕЙСКУРАНТ">

       </owd:Window>


       </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  
     
                         <obout:GridTemplate runat="server" ID="TemplateEditOrgNam" ControlID="ddlOrgNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlOrgNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsOrg" CssClass="ob_gEC" DataTextField="ORGNAM" DataValueField="ORGHSPKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateZen" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditZen" ControlID="chkZen" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkZen" />
                        </Template>
                    </obout:GridTemplate>
 
                    <obout:GridTemplate runat="server" ID="TemplateOrgNam">
                        <Template>
                            <%# Container.DataItem["ORGNAM"]%>
                        </Template>
                    </obout:GridTemplate>    
     ============================================ --%>
    
    
   </form>

     <%-- ------------------------------------- для удаления отступов в GRID 
                                 <obout:DropDownListField DataField="USLFRMIIN" DisplayField="ORGNAM" HeaderText="МО услуга" DataSourceID="SdsOrg"  FieldSetID="FieldSet1"/>

         --------------------------------%>
    <style type="text/css">
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
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }

    </style>
    
    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
        }
    </style>

    </body>
</html>

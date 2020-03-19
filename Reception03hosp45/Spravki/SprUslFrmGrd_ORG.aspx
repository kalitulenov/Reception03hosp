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

            function GridPrc_ClientEdit(sender, record) {

         //       alert("record.USLFRMIIN=" + record.USLFRMIIN);

                Window1.Open();

                document.getElementById('USLIDN').value = record.USLIDN;
                document.getElementById('USLFRMIDN').value = record.USLFRMIDN;
                document.getElementById('USLNAM').value = record.USLNAM;
                //             document.getElementById('par').value = record.DOCDTLKDR;

                SuperForm1_USLKOD.value(record.USLKOD);
                SuperForm1_USLNAM.value(record.USLNAM);
                SuperForm1_EDNNAM.value(record.EDNNAM);
                SuperForm1_USLFRMZEN.value(record.USLFRMZEN);
                SuperForm1_USLFRMZENDOM.value(record.USLFRMZENDOM);
                //             SuperForm1_USLFRMTIMMIN.value(record.USLFRMTIMMIN);
                //             SuperForm1_USLFRMTIMMAX.value(record.USLFRMTIMMAX);
                SuperForm1_USLFRMMEM.value(record.USLFRMMEM);
                SuperForm1_USLFRMAKZ.value(record.USLFRMAKZ);

           //     if (DatDocVal.length != 12) { alert("длина ИИН не верен " + DatDocVal); return false; }

                if (record.USLFRMIIN == "") SuperForm1_ORGHSPKOD.value(0);
                else SuperForm1_ORGHSPKOD.value(record.USLFRMIIN);
                SuperForm1_USLFRMIINKOL.value(record.USLFRMIINKOL);

                return false;
            }

            function saveChanges() {
                Window1.Close();

                var USLIDN = document.getElementById('USLIDN').value;
                var USLFRMIDN = document.getElementById('USLFRMIDN').value;

                // -------------------------- изменить GRID -------------------------------------------------
                for (var i = 0; i < GridPrc.Rows.length; i++) {
                    if (GridPrc.Rows[i].Cells[0].Value == USLIDN) {
                        //                     alert('USLFRMIDN=' + USLFRMIDN);
                        GridPrc.Rows[i].Cells[8].Value = SuperForm1_USLFRMZEN.value();
                        GridPrc.Rows[i].Cells[9].Value = SuperForm1_USLFRMZENDOM.value();
                        GridPrc.Rows[i].Cells[10].Value = SuperForm1_USLFRMMEM.value();
                        //                       alert('SuperForm1_USLFRMAKZ.value 1=' + GridPrc.Rows[i].Cells[7].Value);
                        GridPrc.Rows[i].Cells[11].Value = SuperForm1_USLFRMAKZ.value();
                        //                    alert('SuperForm1_USLFRMAKZ.value 2=' + GridPrc.Rows[i].Cells[7].Value);
                        GridPrc.Rows[i].Cells[12].Value = SuperForm1_ORGHSPKOD.value();
                        GridPrc.Rows[i].Cells[14].Value = SuperForm1_USLFRMIINKOL.value();
                        break;
                    }
                }
                // -------------------------- изменить GRID -------------------------------------------------

                var data = new Object();

                //       if (isNaN(parseInt(KDRCMB.options[KDRCMB.selectedIndex()].value))) // еслн не число
                //           data.DOCDTLKDR = document.getElementById('par').value;
                //       else
                //           data.DOCDTLKDR = KDRCMB.options[KDRCMB.selectedIndex()].value;
                //              alert('data.DOCDTLKDR: ' + data.DOCDTLKDR);

                data.USLKOD = SuperForm1_USLKOD.value();
                data.USLNAM = SuperForm1_USLNAM.value();
                data.EDNNAM = SuperForm1_EDNNAM.value();
                data.USLFRMZEN = SuperForm1_USLFRMZEN.value();
                data.USLFRMZENDOM = SuperForm1_USLFRMZENDOM.value();
                //           data.USLFRMTIMMIN = SuperForm1_USLFRMTIMMIN.value();
                //            data.USLFRMTIMMAX = SuperForm1_USLFRMTIMMAX.value();
                data.USLFRMMEM = SuperForm1_USLFRMMEM.value();
                data.USLFRMAKZ = SuperForm1_USLFRMAKZ.value();
                data.USLFRMIIN = SuperForm1_ORGHSPKOD.value();
                data.USLFRMIINKOL = SuperForm1_USLFRMIINKOL.value();

                if (USLIDN != 0) {
                    data.USLIDN = USLIDN;
                    data.USLFRMIDN = USLFRMIDN;
                    GridPrc.executeUpdate(data);
                }
                else {
                    Contr = parseInt(Contr) + 1;
                    document.getElementById('cntr').value = Contr;
                    GridPrc.executeInsert(data);
                }

            }

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
            SdsOrg.SelectCommand = "SELECT ORGHSPKOD,ORGHSPNAM FROM SPRORGHSP WHERE ORGHSPFRM=" + BuxFrm + " ORDER BY ORGHSPNAM";
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                //             getPrcNum(); 
                //              PopulateTree();


                ComParKey = (string)Request.QueryString["NodKey"];
                ComParTxt = (string)Request.QueryString["NodTxt"];
                ComParCnt = (string)Request.QueryString["NumCnt"];
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
            string NumCnt;

            //            NumCnt = Convert.ToInt32(ComParCnt);
            NumCnt = parSprCnt.Value;
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
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 3, ComParKey, NumCnt));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 7:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 7, ComParKey, NumCnt));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 11:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 11, ComParKey, NumCnt));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    default:
                        break;
                }
            }
            else
            {
                ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 0, whereClause, NumCnt));
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

            UslIdn = Convert.ToInt32(e.Record["USLIDN"]);
            if (e.Record["USLFRMIDN"] == null || e.Record["USLFRMIDN"] == "")  UslFrmIdn = 0;
            else UslFrmIdn = Convert.ToInt32(e.Record["USLFRMIDN"]);
            UslKod = Convert.ToInt32(e.Record["USLKOD"]);
            UslZen = Convert.ToString(e.Record["USLFRMZEN"]);
            UslZenDom = Convert.ToString(e.Record["USLFRMZENDOM"]);
            //          UslTimMin = Convert.ToString(e.Record["USLFRMTIMMIN"]);
            //          UslTimMax = Convert.ToString(e.Record["USLFRMTIMMAX"]);
            UslMem = Convert.ToString(e.Record["USLFRMMEM"]);
            UslAkz = Convert.ToString(e.Record["USLFRMAKZ"]);
            UslIin = Convert.ToString(e.Record["USLFRMIIN"]);
            if (e.Record["USLFRMIINKOL"] == null || e.Record["USLFRMIINKOL"] == "")  UslIinKol = 0;
            else UslIinKol = Convert.ToInt32(e.Record["USLFRMIINKOL"]);

            //           Service1Soap ws = new Service1SoapClient();
            ComSprUslFrmRep(MdbNam, BuxSid, UslZen, UslZenDom,"30", "30", UslMem, UslAkz, UslIin, UslIinKol, UslIdn, UslFrmIdn, UslKod);

            LoadGridNode();
        }

        //-------------------------- увеличение высоту полей описание и акции ----------------------------------------------
        protected void SuperForm1_DataBound(object sender, EventArgs e)
        {
            if (SuperForm1.CurrentMode == DetailsViewMode.Edit || SuperForm1.CurrentMode == DetailsViewMode.Insert)
            {
                OboutTextBox BoxOps = SuperForm1.GetFieldControl(4) as OboutTextBox;
                BoxOps.Height = Unit.Pixel(100);
                OboutTextBox BoxAkz = SuperForm1.GetFieldControl(5) as OboutTextBox;
                BoxAkz.Height = Unit.Pixel(100);
                OboutTextBox BoxIin = SuperForm1.GetFieldControl(6) as OboutTextBox;
                BoxIin.Height = Unit.Pixel(50);
            }
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
	         		               AllowAddingRecords = "false"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false"
                                   AllowPaging="false"
                                   Width="100%"
                                   AllowPageSizeSelection="false" >
                                   <ClientSideEvents 
		                               OnBeforeClientEdit="GridPrc_ClientEdit" ExposeSender="true"/>
                                  <ScrollingSettings ScrollHeight="450" />
                  		    	<Columns>
	                    			<obout:Column ID="Column00" DataField="USLIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="USLFRMIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column02" DataField="STRUSLKEY" HeaderText="Ключ" Visible="false" Width="0%"/>											
	                    			<obout:Column ID="Column03" DataField="USLGRP001" HeaderText="ГРП" ReadOnly = "true" Align="right" Width="5%" />											
	                    			<obout:Column ID="Column04" DataField="USLGRP002" HeaderText="ГРП" ReadOnly = "true" Align="right" Width="5%" />											
	                    			<obout:Column ID="Column05" DataField="USLKOD" HeaderText="КОД" ReadOnly = "true" Align="right" Width="4%" />											
	                    			<obout:Column ID="Column06" DataField="USLTRF" HeaderText="ТАРИФ" ReadOnly = "true" Align="center" Width="9%" />											
                    				<obout:Column ID="Column07" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ" ReadOnly = "true" Wrap="true" Width="35%" />
                    				<obout:Column ID="Column08" DataField="EDNNAM" HeaderText="ЕД.ИЗМ" ReadOnly = "true" Width="5%" />
                    				<obout:Column ID="Column09" DataField="USLFRMZEN" HeaderText="ЦЕНА" Width="5%" Align="right" />
		              				<obout:Column ID="Column10" DataField="USLFRMZENDOM" HeaderText="ДОМ" Width="5%" />
                    				<obout:Column ID="Column11" DataField="USLFRMMEM" HeaderText="ОПИСАНИЕ"  Width="4%" />
		              				<obout:Column ID="Column12" DataField="USLFRMAKZ" HeaderText="АКЦИЯ" Width="4%" />
		              				<obout:Column ID="Column13" DataField="USLFRMIIN" HeaderText="ИИН орг" Visible="false" Width="0%" />
		              				<obout:Column ID="Column14" DataField="ORGNAM" HeaderText="МО УСЛУГА" Width="10%" />
		              				<obout:Column ID="Column15" DataField="USLFRMIINKOL" HeaderText="КОЛ" Width="4%" />
		                    		<obout:Column ID="Column16" DataField="" HeaderText="Корр" Width="5%" AllowEdit="true" AllowDelete="false" />
		                    	</Columns>

	                    		<Templates>								
    	                    		<obout:GridTemplate runat="server" ID="TemplateOrgNam" >
	    			                    <Template>
				                            <%# Container.DataItem["ORGHSPNAM"]%>			      		       
		    		                    </Template>
			    	                </obout:GridTemplate>
	                    		</Templates>
	
	                    	</obout:Grid>	
       </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    
     <owd:Window ID="Window1" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        RelativeElementID="WindowPositionHelper" Top="0" Left="300" Height="500" Width="650" VisibleOnLoad="false" StyleFolder="/Styles/Window/wdstyles/aura"
        Title="Прейскурант цен">
            <input type="hidden" id="USLIDN" />
            <input type="hidden" id="USLFRMIDN" />
            <input type="hidden" id="USLNAM" />

            <div class="super-form">
                <obout:SuperForm ID="SuperForm1" runat="server"
                    AutoGenerateRows="false"
                    AutoGenerateInsertButton ="false"
                    AutoGenerateEditButton="false"
                    AutoGenerateDeleteButton="false" 
                    FolderStyle="/Styles/SuperForm/plain"
                    InterfaceFolderStyle="/Styles/Interface/plain"
                    DataKeyNames="USLFRMIDN" 
                    DefaultMode="Insert" 
                    OnDataBound="SuperForm1_DataBound"
                    Width="600" >
   
                    <EditRowStyle BackColor="#D5E2FF" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="#D5E2FF" ForeColor="Black" /> 
                                      
                    <Fields>
                        <obout:BoundField DataField="USLKOD" HeaderText="Код" ReadOnly="true" FieldSetID="FieldSet1" />
	                    <obout:MultiLineField DataField="USLNAM" HeaderText="Наименование" ReadOnly="true" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="EDNNAM" HeaderText="Ед.измерения" ReadOnly="true" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="USLFRMZEN" HeaderText="Цена" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="USLFRMZENDOM" HeaderText="Цена на дому" FieldSetID="FieldSet1" />
	                    <obout:MultiLineField DataField="USLFRMMEM" HeaderText="Описание" FieldSetID="FieldSet1" ItemStyle-Height="50px" ControlStyle-Height="50px"/>
	                    <obout:MultiLineField DataField="USLFRMAKZ" HeaderText="Акция" FieldSetID="FieldSet1" ItemStyle-Height="50px" ControlStyle-Height="50px" />
                        <obout:DropDownListField DataField="ORGHSPKOD" DisplayField="ORGHSPNAM" HeaderText="МО услуга" DataSourceID="SdsOrg"  FieldSetID="FieldSet1"/>
	                    <obout:BoundField DataField="USLFRMIINKOL" HeaderText="Кол-во" FieldSetID="FieldSet1"  />
                 
                        <obout:TemplateField FieldSetID="FieldSet2">
                             <EditItemTemplate>
                                <obout:OboutButton ID="OboutButton1" runat="server" Text="Сохранить" OnClientClick="saveChanges(); return false;" Width="120" FolderStyle="/Styles/Interface/plain/OboutButton" />
                                <obout:OboutButton ID="OboutButton2" runat="server" Text="Расход мат." OnClientClick="GridPrc_rsx(); return false;" Width="100" FolderStyle="/Styles/Interface/plain/OboutButton" />
                                <obout:OboutButton ID="OboutButton3" runat="server" Text="Отмена" OnClientClick="cancelChanges(); return false;" Width="100" FolderStyle="/Styles/Interface/plain/OboutButton" />
                            </EditItemTemplate>
                        </obout:TemplateField>
                     </Fields>
                  
                    <FieldSets>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet1"/>
                        </obout:FieldSetRow>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet2" ColumnSpan="1" CssClass="command-row"  />
                        </obout:FieldSetRow>
                    </FieldSets>
                    
                    <CommandRowStyle Width="350" HorizontalAlign="Left" />
                </obout:SuperForm>
            </div>
    </owd:Window>  


<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="RsxWindow" runat="server"  Url="SprUslFrmGrdRsx.aspx" IsModal="true" ShowCloseButton="true" Status=""
                    RelativeElementID="WindowPositionHelper" Left="300" Top="200" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
                    StyleFolder="~/Styles/Window/wdstyles/aura"
                    Title="Справочник расхода материалов">



        </owd:Window>

    
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

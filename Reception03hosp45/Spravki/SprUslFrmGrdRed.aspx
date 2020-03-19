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
        string ComParPrc = "";
        string whereClause = "";
        
        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
    //        GridPrc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            SdsPrc.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            SdsPrc.SelectCommand = "SELECT SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "FROM SprFrmStx INNER JOIN SprPrc ON SprFrmStx.FrmStxPrc=SprPrc.PrcKod " +
                                   "WHERE SprFrmStx.FrmStxKodFrm=" + BuxFrm +
                                   " GROUP BY SprPrc.PrcKod,SprPrc.PrcNam " +
                                   "ORDER BY SprPrc.PrcKod";
             //=====================================================================================
           if (!Page.IsPostBack)
            {
  //             getPrcNum(); 
 //              PopulateTree();
            }
           
            ComParKey = (string)Request.QueryString["NodKey"];
            ComParTxt = (string)Request.QueryString["NodTxt"];
            ComParPrc = (string)Request.QueryString["NumPrc"];
            
            LoadGridNode();
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {
            string NumPrc;

//            NumPrc = Convert.ToInt32(ComParPrc);
            NumPrc = ComParPrc;

            Service1Soap ws = new Service1SoapClient();
            DataSet ds = new DataSet("Menu");
            if (ComParKey == null) return;

            if (string.IsNullOrEmpty(ComParKey)) return;    // проверка на null и пробел


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
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 300, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 7:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 700, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    case 11:
                        ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 1100, ComParKey, NumPrc));
                        GridPrc.DataSource = ds;
                        GridPrc.DataBind();
                        break;
                    default:
                        break;
                }
            }
            else
            {
                ds.Merge(ws.ComSelUslFrm(MdbNam, BuxSid, BuxFrm, 2000, whereClause, NumPrc));
                GridPrc.DataSource = ds;
                GridPrc.DataBind();

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
                whereClause += " '%" + FndUsl.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;
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
                                                         
        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        //------------------------------------------------------------------------
        // ============================ чтение заголовка таблицы а оп ==============================================

 </script>   


<body>
    <form id="form1" runat="server">   
<%-- ============================  JAVA ============================================ --%>
  

<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <asp:HiddenField ID="parUslKod" runat="server" />
  <asp:HiddenField ID="parUslNam" runat="server" />

  <input type="hidden" name="hhh" id="par" />
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  
    <!--  для источника -----------------------------------------------  -->
    <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
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
                                  <ScrollingSettings ScrollHeight="450" />
                  		    	<Columns>
	                    			<obout:Column ID="Column00" DataField="USLIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column01" DataField="USLFRMIDN" HeaderText="Код" Visible="false" Width="0%" />
	                    			<obout:Column ID="Column02" DataField="STRUSLKEY" HeaderText="Ключ" Visible="false" Width="0%"/>											
	                    			<obout:Column ID="Column03" DataField="USLFRMKOD" HeaderText="Код" ReadOnly = "true" Align="right" Width="5%" />											
	                    			<obout:Column ID="Column04" DataField="USLTRF" HeaderText="Тариф" ReadOnly = "true" Align="center" Width="10%" />											
                    				<obout:Column ID="Column05" DataField="USLNAM" HeaderText="Наименование" ReadOnly = "true" Wrap="true" Width="30%" />
                    				<obout:Column ID="Column06" DataField="EDNNAM" HeaderText="Ед.измерения" ReadOnly = "true" Width="10%" />
                    				<obout:Column ID="Column07" DataField="USLFRMZEN" HeaderText="Цена" Width="10%" />
                    				<obout:Column ID="Column08" DataField="USLFRMMEM" HeaderText="Описание"  Width="10%" />
		              				<obout:Column ID="Column09" DataField="USLFRMAKZ" HeaderText="Акция" Width="10%" />
		              				<obout:Column ID="Column10" DataField="USLFRMIIN" HeaderText="ИИН орг" Width="10%" />
		                    		<obout:Column ID="Column11" DataField="" HeaderText="Корр" Width="5%" AllowEdit="false" AllowDelete="false" />
		                    	</Columns>
	
	                    	</obout:Grid>	
       </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    
   </form>

     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

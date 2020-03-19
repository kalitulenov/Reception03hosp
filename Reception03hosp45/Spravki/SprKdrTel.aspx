<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
      <style type="text/css">
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Arial;
            font-size: 12px;
        }
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
	        font-size: 12px;
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
    </style>

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

    </script>
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
        Boolean KdrSex;
        string KdrIIN;
        string KdrThn;
        string KdrEml;
        string KdrAdr;
        string KdrWeb;
        string KdrDnn;
        string KdrDdt;
        string KdrDpl;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
             //============= локолизация для календаря  ===========================================================================================
  
          //   NumSpr = (string)Request.QueryString["NumSpr"];
            //         if (Session["KDRKODSES"] == null) Session.Add("KDRKODSES", (string)"0");

            //=====================================================================================
            getGrid();
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
            SqlCommand cmd = new SqlCommand("SELECT FIO, MAX(DLGNAM) AS DLG, KDRTHN FROM SprBuxKdr WHERE ISNULL(BuxUbl,0)=0 AND BuxFrm=" + 
                                                    BuxFrm + " GROUP BY FIO,KDRTHN ORDER BY FIO", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprKdr");
            GridKdr.DataSource = ds;
            GridKdr.DataBind();
       
            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();

        }
        // ======================================================================================
    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="KDRKOD" />
     
    <span id="WindowPositionHelper"></span>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    
     
<!--  конец -----------------------------------------------  -->  
  
        <asp:TextBox ID="Sapka" 
             Text="ТЕЛЕФОН СОТРУДНИКОВ" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 20%; position: relative; width: 48%; text-align:center"
             runat="server"></asp:TextBox>
             
        <div id="div_kdr" style="position:relative;left:20%; width:60%; " >
             <obout:Grid id="GridKdr" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="/Styles/Grid/style_11" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
                                   AllowColumnResizing="true"
                                   AllowSorting="true"
                                   AllowPaging="false"
                                   Width="80%"
                                   PageSize="-1"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowFooter="false">
                                   <ScrollingSettings ScrollHeight="500" />
		                        	<Columns>
	                    			<obout:Column ID="Column01" DataField="FIO" HeaderText="ФАМИЛИЯ И.О." Width="35%" />											
                                    <obout:Column ID="Column02" DataField="DLG" HeaderText="ДОЛЖНОСТЬ" Width="30%" />											
                    				<obout:Column ID="Column03" DataField="KDRTHN" HeaderText="ТЕЛЕФОН"  Width="35%" />
		                    	</Columns>
	        </obout:Grid>	
    
         </div>
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>
</asp:Content>

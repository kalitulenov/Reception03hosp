<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ============================  для почты  ============================================ --%>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>
<%-- ============================конец для почты  ============================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%> 
 
    <style type="text/css">
               /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
     /* ------------------------------------- для удаления отступов в GRID -------------------------------- */
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }      
        /*------------------------- для TREE  --------------------------------*/
       .modalBackground 
       {
           background-color:Gray;
       }

        /*------------------------- для TREE  --------------------------------*/
       .modalPopup {
           background-color:#FFD9D5;
           border-width:3px;
           border-style:solid;
           border-color:Gray;
           padding:3px;
           width:250px;
       }

        /*------------------------- для TREE шрифт  --------------------------------*/
        input.c {height:13px; width:13px; margin-left:0px; margin-right:6px; margin-bottom:0px; margin-top:1px;} 
</style>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
     function OnClientSelect(sender,selectedRecords) {
   //      alert(document.getElementById('MainContent_parDbl').value);
         
         var OrgKod = selectedRecords[0].ORGHSPKOD;
         var OrgNam = selectedRecords[0].ORGHSPNAM;
  //       alert("OrgKod=" + OrgKod);
  //       alert("OrgNam=" + OrgNam);

         mySpl.loadPage("RightContent", "SprOrgHspUslTre.aspx?OrgKod=" + OrgKod + "&OrgNam=" + OrgNam);
     }

    </script>	


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        int HspKod = 0;
        string HspBin = "";
        int BuxFlg;
        int BuxTyp;
        string BuxSid;
        string BuxFrm;
        string HspNam = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;

        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            // =====================================================================================


            //===================================================================================================
            if (!Page.IsPostBack)
            {

                PopulateGridHsp();

                Session.Add("ComHspKod", 0);
                Session.Add("ComUslKey", 0);
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridHsp()
        {
            //            int Pol;
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("SELECT * FROM SprOrgHsp WHERE ORGHSPFRM=" + BuxFrm + " ORDER BY ORGHSPNAM", con);
            // указать тип команды
            //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            //     cmd.Parameters.Add("@BUXAPP", SqlDbType.Int, 4).Value = Convert.ToInt32(Session["BuxApp"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            con.Open();

            da.Fill(ds, "Bux");
            GridHsp.DataSource = ds.Tables[0].DefaultView;
            GridHsp.DataBind();

            con.Close();
        }

        // ============================ чтение таблицы а оп ==============================================
     </script> 
     
     
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
<!--  конец -----------------------------------------------  -->    
  <%-- ============================  для передач значении  ============================================ --%>
    <asp:HiddenField ID="parChkLst" runat="server" />

       <asp:Panel ID="Panel1" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 600px;">
        <asp:TextBox ID="TextBox1" 
             Text="                                                            Медицинские центры + услуги" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl">
            <LeftPanel WidthMin="100" WidthMax="500" WidthDefault="250">
                <Content>
                    <div style="margin: 5px;">
       <asp:TextBox ID="TextBox2" 
             Text="Медицинские центры" 
             BackColor="Yellow"  
             Font-Names="Verdana" 
             Font-Size="16px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: 0px; left: 0px; position: relative; width: 100%"
             runat="server"></asp:TextBox>

                        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    		           <obout:Grid id="GridHsp" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="100%"
	         		               AllowAddingRecords = "false"
	         		               AutoPostBackOnSelect = "false"
                                   AllowRecordSelection = "true"
                                   AllowFiltering = "false" >
 	                               <ClientSideEvents ExposeSender="true"  OnClientSelect="OnClientSelect" />
          		           		<Columns>
	                    			<obout:Column ID="Column1" DataField="ORGHSPKOD" HeaderText="КОД" ReadOnly ="true" Width="15%" />
                    				<obout:Column ID="Column2" DataField="ORGHSPNAM" HeaderText="ОРГАНИЗАЦИЯ"  Width="85%" />
		                    	</Columns>
	                    	</obout:Grid>	
                    </div>
                    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>

                </Content>
            </LeftPanel>
            <RightPanel>
                <Content>
                </Content>
            </RightPanel>
        </spl:Splitter>


    </asp:Panel>

</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    
		<link href="resources/custom-styles/black_glass/style.css" rel="Stylesheet" type="text/css" />	
		<link href="resources/custom-styles/grand_gray/style.css" rel="Stylesheet" type="text/css" />		
		<link href="resources/custom-styles/premiere_blue/style.css" rel="Stylesheet" type="text/css" />		

<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;

         function GridQst_add() {
          //       alert("GridQst_add=");

             QstWindow.setTitle("Задаите вопрос");
             QstWindow.setUrl("/Priem/DocAppAmbTlkQst.aspx");
             QstWindow.Open();
             return true;
         }

         function GridAns_add(rowIndex) {
         //    alert("GridAns=");
             var TlkNum = GridQst.Rows[rowIndex].Cells[0].Value;
          //   alert("TlkNum ="+TlkNum);
             QstWindow.setTitle("Ответ на вопрос");
             QstWindow.setUrl("/Priem/DocAppAmbTlkAns.aspx?TlkNum=" + TlkNum);
             QstWindow.Open();
             return true;
         }

         function QstClose() {
             QstWindow.Close();
         }
 </script>
 
 </head>

<script runat="server">
       
        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string Html;
        string ComParKey = "";
        string ComParTxt = "";
        string whereClause = "";

        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //=====================================================================================
            //           GridQst.ClientSideEvents.OnBeforeClientDelete = "OnBeforeDelete";
            //  GridQst.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);

            sdsQst.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsAns.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";

            //=====================================================================================
            if (!Page.IsPostBack)
            {

            }

        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================
        //=============При выборе узла дерево===========================================================================================
        protected void LoadGrid()
        {

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspTlkQst", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@BUXNOZ", SqlDbType.VarChar).Value = BoxNoz.Text;
            cmd.Parameters.Add("@BUXQST", SqlDbType.VarChar).Value = whereClause;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspTlkQst");


            GridQst.DataSource = ds;
            GridQst.DataBind();
            
            con.Close();

    //        sdsAns.SelectCommand = "HspTlkQstSel";

        }
        // ====================================после удаления ============================================
        // ======================================================================================
        //------------------------------------------------------------------------
        //------------------------------------------------------------------------

        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndQst.Text == "") FndQst.Text = "*";
            if (FndQst.Text != "")
            {
                I = I + 1;
                whereClause += "TLKTXT LIKE '%" + FndQst.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
               whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;


                LoadGrid();

            }

        }




</script>

<body>
    <form id="form1" runat="server">
        <div>

            <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
            --%>

            <!--  конец -----------------------------------------------  -->
            <%-- ============================  для передач значении  ============================================ 
            <span id="WindowPositionHelper"></span>--%>
                 <!--  источники -----------------------------------------------------------  
                        
                        -->
            <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsQst" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
   
              <asp:SqlDataSource runat="server" ID="sdsAns" SelectCommand="SELECT * FROM TabTlk WHERE ISNULL(TLKQSTFLG,0)=0 AND TlkNum = @TlkNum" ProviderName="System.Data.SqlClient">
		             <SelectParameters>
                        <asp:Parameter Name="TlkNum" Type="Int32" />
                     </SelectParameters>
		    </asp:SqlDataSource>           
            
          <!--  источники -----------------------------------------------------------  -->

            <div style="position: relative; left: 0px; top: 0px; font-family: Verdana; font-size: 10pt; border-style: groove; border-width: 1px; border-color: Black; padding: 1px">

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td width="25%" style="vertical-align: central;" > 
                            <asp:DropDownList runat="server" ID="BoxNoz" Width="100%" Font-Size="Large" 
                                    AutoPostBack="true"
                                    Height="25"
                                    DataSourceID ="sdsNoz"
                                    AppendDataBoundItems="true"
                                    DataTextField="NOZNAM"
                                    DataValueField="NOZKOD" />
                        </td>
                         <td width="25%" style="vertical-align: central;" > </td>     
                        <td width="45%" style="vertical-align: central;" > 
                             <asp:TextBox ID="FndQst" Width="87%" Height="20" runat="server"
                                Style="position: relative; font-weight: 700; font-size: large;" />
                            
                           <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="10%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
            <obout:Grid ID="GridQst" runat="server"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="20"
                AllowAddingRecords="true"
                AllowFiltering="false"
                ShowColumnsFooter="false"
                AllowPaging="true"
                Width="100%"
                AllowPageSizeSelection="false">
                <Columns>
                    <obout:Column ID="Column01" DataField="TlkNum" HeaderText="+" Width="1%" />
                    <obout:Column ID="Column02" DataField="Nnn" HeaderText="НОМЕР" Width="3%" />
                    <obout:Column ID="Column03" DataField="TLKTXT" HeaderText="СОДЕРЖАНИЕ ВОПРОСА" Wrap="true" Width="69%" />
                    <obout:Column ID="Column04" DataField="NOZNAM" HeaderText="НОЗОЛОГИЯ" Width="10%" />
                    <obout:Column ID="Column05" DataField="TLKKTO" HeaderText="НИК" Width="5%" />
                    <obout:Column ID="Column06" DataField="TLKDAT" HeaderText="ДАТА" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column07" DataField="RSXFLG" HeaderText="ОТВЕТИТЬ" Width="7%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateRsx" />
                    </obout:Column>
                </Columns>
                <MasterDetailSettings LoadingMode="OnCallback" />
                <DetailGrids>
                    <obout:DetailGrid runat="server" ID="GridAns"
                        AutoGenerateColumns="false"
                        ShowTotalNumberOfPages="false"
                        PageSize="20"
                        AllowAddingRecords="false"
                        ShowFooter="false"
                        AllowPageSizeSelection="false"
                        AllowPaging="false"
                        DataSourceID="sdsAns"
                        FolderStyle="_"
                        AllowFiltering="false"
                        ShowColumnsFooter="false"
                        AllowSorting="false"
                        Width="100%"
                        ForeignKeys="TlkNum">
                        <Columns>
                            <obout:Column ID="Column11" DataField="TlkNum" HeaderText="НОМЕР" Visible="false" />
                            <obout:Column ID="Column12" DataField="TLKNNN" HeaderText="№№" Width="3%" />
                            <obout:Column ID="Column13" DataField="TLKTXT" HeaderText="ОТВЕТ НА ВОПРОС" Wrap="true" Width="85%" />
                            <obout:Column ID="Column14" DataField="TLKKTO" HeaderText="НИК" Width="7%" />
                            <obout:Column ID="Column15" DataField="TLKDAT" HeaderText="ДАТА" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                        </Columns>
                                    <CssSettings CSSFolderImages="resources/custom-styles/premiere_blue" /> 
                    </obout:DetailGrid>
                </DetailGrids>
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Спросить" onclick="GridQst_add()" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                        <Template>
                            <input type="button" id="btnRsx" class="tdTextSmall" value="Ответить" onclick="GridAns_add(<%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                </Templates>
            </obout:Grid>

        </div>
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ 
                             <CssSettings CSSFolderImages="resources/custom-styles/premiere_blue" /> 	
            --%>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="QstWindow" runat="server"  Url="DocAppAmbTlkQst.aspx" IsModal="true" ShowCloseButton="true" Status=""
                    Left="300" Top="50" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
                    StyleFolder="~/Styles/Window/wdstyles/blue"
                    Title="Спросить">
        </owd:Window>

    </form>
        <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
              /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }

        .ob_gBody .ob_gRS .ob_gC, .ob_gBody .ob_gRS .ob_gCW {
        background-color: transparent !important;
        background-image: none !important;
        
    </style>

</body>
</html>

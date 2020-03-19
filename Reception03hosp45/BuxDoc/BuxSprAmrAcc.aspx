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

        int AmrIdn;
        string AmrFix;
        string AmrDeb;
        string AmrKrd;
        int AmrGrp;
        
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];

            sdsFix.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsFix.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND (ACCKOD LIKE '2410%' OR ACCKOD LIKE '2730%') AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND (ACCKOD LIKE '7%' OR ACCKOD LIKE '8%') AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND (ACCKOD LIKE '2420%' OR ACCKOD LIKE '2740%') AND ACCFRM='" + BuxFrm + "' ORDER BY ACCKOD";

            sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsGrp.SelectCommand = "SELECT STTSTRKOD,STTSTRNAM FROM SPRDEP WHERE STTSTRFRM=" + BuxFrm + "  ORDER BY STTSTRNAM";
 
            GridAmr.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridAmr.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridAmr.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

            if (IsPostBack)
            {

                
            }
            else
            {
          //     Sapka.Text = (string)Request.QueryString["TxtSpr"];
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
            SqlCommand cmd = new SqlCommand("SELECT SprAccAmr.*,SprDep.SttStrNam " +
                                            "FROM SprAccAmr LEFT OUTER JOIN SprDep ON SprAccAmr.AmrFrm=SprDep.SttStrFrm AND SprAccAmr.AmrGrp=SprDep.SttStrKod " +
                                            "WHERE SprAccAmr.AmrFrm=" + BuxFrm, con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprAmr");
            GridAmr.DataSource = ds;
            GridAmr.DataBind();

        }

        // ============================ чтение таблицы а оп ==============================================
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {

            AmrFix = Convert.ToString(e.Record["AMRFIX"]);
            AmrDeb = Convert.ToString(e.Record["AMRDEB"]);
            AmrKrd = Convert.ToString(e.Record["AMRKRD"]);
            AmrGrp = Convert.ToInt32(e.Record["AMRGRP"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO SPRACCAMR (AMRFRM,AMRFIX,AMRDEB,AMRKRD,AMRGRP) " +
                                            "VALUES (" + BuxFrm + ",'" + AmrFix + "','" + AmrDeb + "','" + AmrKrd + "'," + AmrGrp + ")", con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            AmrIdn = Convert.ToInt32(e.Record["AMRIDN"]);
            AmrFix = Convert.ToString(e.Record["AMRFIX"]);
            AmrDeb = Convert.ToString(e.Record["AMRDEB"]);
            AmrKrd = Convert.ToString(e.Record["AMRKRD"]);
            AmrGrp = Convert.ToInt32(e.Record["AMRGRP"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("UPDATE SPRACCAMR SET AMRFIX='" + AmrFix + "',AMRDEB='" + AmrDeb + "',AMRKRD='" + AmrKrd + "',AMRGRP=" +AmrGrp +
                                            " WHERE AMRIDN=" + AmrIdn, con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            AmrIdn = Convert.ToInt32(e.Record["AMRIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM SPRACCAMR WHERE AMRIDN=" + AmrIdn, con);
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }

    </script>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        // ------------------------  при выборе вкладок  ------------------------------------------------------------------
        // Client-Side Events for Delete
        function GridAmr_ClientDelete(sender, record) {
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
            for (var i = 0; i < GridAmr.Rows.length; i++) {
                if (GridAmr.Rows[i].Cells[0].Value == record.AMRIDN) {
                    index = i;
                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            GridAmr.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }
        
    </script>

    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="AMRIDN" />
    <input type="hidden" id="AMRKOD" />
 
    <span id="WindowPositionHelper"></span>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>  
      
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
             Text="СЧЕТА АМОРТИЗАЦИЙ" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative;left:30%; width:40%; text-align:center"
             runat="server"></asp:TextBox>

                 <div id="div_cnt" style="position:relative;left:30%; width:40%; " >
        <obout:Grid ID="GridAmr" runat="server"
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="~/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                		       PageSize = "-1"
                                   Width="100%"
                                   AllowSorting="true"
                                   AllowPageSizeSelection="false"
	         		               AllowAddingRecords = "true"
                                   AllowRecordSelection = "true"
                                   KeepSelectedRecords = "true">
                                   <ScrollingSettings ScrollHeight="550" />
            <ClientSideEvents
                OnBeforeClientDelete="GridAmr_ClientDelete"
                ExposeSender="true" />
            <Columns>
                <obout:Column ID="Column0" DataField="AMRIDN" HeaderText="Идн" Width="0" ReadOnly="true" />
                <obout:Column ID="Column1" DataField="AMRFIX" HeaderText="СЧЕТ" Width="20%" >
                    <TemplateSettings EditTemplateId="TemplateEditFixNam" />
                </obout:Column>
                <obout:Column ID="Column2" DataField="AMRGRP" HeaderText="ГРУППА" Width="20%">
                    <TemplateSettings TemplateId="TemplateGrp" EditTemplateId="TemplateEditGrp" />
                </obout:Column>
                <obout:Column ID="Column3" DataField="AMRDEB" HeaderText="ДЕБЕТ" Width="20%">
                    <TemplateSettings EditTemplateId="TemplateEditDebNam" />
                </obout:Column>
                <obout:Column ID="Column4" DataField="AMRKRD" HeaderText="КРЕДИТ" Width="20%">
                    <TemplateSettings EditTemplateId="TemplateEditKrdNam" />
                </obout:Column>
                <obout:Column ID="Column5" DataField="" HeaderText="Корр" Width="20%" AllowEdit="true" AllowDelete="true" />
            </Columns>

            <Templates>

                <obout:GridTemplate runat="server" ID="TemplateEditFixNam" ControlID="ddlFixNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlFixNam" runat="server" Width="99%" DataSourceID="sdsFix" CssClass="ob_gEC" DataTextField="ACCKOD" DataValueField="ACCKOD">
                            <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditDebNam" ControlID="ddlDebNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlDebNam" runat="server" Width="99%" DataSourceID="sdsDeb" CssClass="ob_gEC" DataTextField="ACCKOD" DataValueField="ACCKOD">
                            <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditKrdNam" ControlID="ddlKrdNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlKrdNam" runat="server" Width="99%" DataSourceID="sdsKrd" CssClass="ob_gEC" DataTextField="ACCKOD" DataValueField="ACCKOD">
                            <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateGrp">
                    <Template>
                        <%# Container.DataItem["SttStrNam"]%>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="TemplateEditGrp" ControlID="ddlGrp" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlGrp" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsGrp" CssClass="ob_gEC" DataTextField="STTSTRNAM" DataValueField="STTSTRKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>

            </Templates>

        </obout:Grid>
    </div>
     
    <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>

            <asp:SqlDataSource runat="server" ID="sdsFix" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
 
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
</asp:Content>
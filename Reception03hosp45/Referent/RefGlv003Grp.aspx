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
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        
        var myconfirm = 0;

 /*       
        function OnClientDblClick(sender, iRecordIndex) {
            var GrfFio = GridGrp.Rows[iRecordIndex].Cells[1].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[2].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[3].Value.substring(0,8) +"&"+
                         GridGrp.Rows[iRecordIndex].Cells[5].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[6].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[7].Value+"&"+
                         GridGrp.Rows[iRecordIndex].Cells[9].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[8].Value+"&"+GridGrp.Rows[iRecordIndex].Cells[10].Value.substring(0,8)+"&"+GridGrp.Rows[iRecordIndex].Cells[4].Value;
            localStorage.setItem("FndFio", GrfFio); //setter
            window.opener.HandlePopupResult(GrfFio);
            self.close();
        }
*/

        function OnClientSelect(sender,selectedRecords) {
            var RefKod = selectedRecords[0].SPRREFKOD;
 //           alert("RefKod ="+RefKod);
            document.getElementById('parRefKod').value = RefKod;
    //        alert("document.getElementById('parRefKod').value =" + document.getElementById('parRefKod').value);
    //        ConfirmDialog.Visible = true;
    //        ConfirmDialog.VisibleOnLoad = true;
            ConfirmDialog.Open();

        }

// ===============================================================================================================================================================

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";
    string SndPar = "";

    string MdbNam = "HOSPBASE";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        SndPar = Convert.ToString(Request.QueryString["SndPar"]);
        string[] MasLst = SndPar.Split(':');

        parGrfPth.Value = MasLst[3];
        parGrfIin.Value = MasLst[4];
        parGrfTel.Value = MasLst[5];
        parGrfBrt.Value = MasLst[6];
        parGrfKrt.Value = MasLst[7];
        parCntIdn.Value = MasLst[8];

        //=====================================================================================

        if (!Page.IsPostBack)
        {
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
        SqlCommand cmd = new SqlCommand("SELECT * FROM SPRREF WHERE SPRREFFRM=" + BuxFrm + " ORDER BY SPRREFNAM", con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //  cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "SprRef");

        con.Close();

        GridGrp.DataSource = ds;
        GridGrp.DataBind();
    }

    protected void GrpWrtButton_Click(object sender, EventArgs e)
    {
        string KltStx = "";
        string KltKrt = "";
        int res;

        ConfirmDialog.Visible = false;
        ConfirmDialog.VisibleOnLoad = false;
        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        //BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspDocGrfWrtGrp", con);
        cmd = new SqlCommand("HspDocGrfWrtGrp", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@GRFFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@GRFBUX", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@REFKOD", SqlDbType.VarChar).Value = parRefKod.Value;
        cmd.Parameters.Add("@GRFPTH", SqlDbType.VarChar).Value = parGrfPth.Value;
        cmd.Parameters.Add("@GRFIIN", SqlDbType.VarChar).Value = parGrfIin.Value;
        cmd.Parameters.Add("@GRFTEL", SqlDbType.VarChar).Value = parGrfTel.Value;
        cmd.Parameters.Add("@GRFBRT", SqlDbType.VarChar).Value = parGrfBrt.Value;
        cmd.Parameters.Add("@GRFPOL", SqlDbType.VarChar).Value = ""; // parGrfKrt.Value;
        cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = parCntIdn.Value;


        cmd.ExecuteNonQuery();
        con.Close();

        // ------------------------------------------------------------------------------заполняем второй уровень
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
    }

    // ==================================== поиск клиента по фильтрам  ============================================

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
             <asp:HiddenField ID="parCntIdn" runat="server" />
             <asp:HiddenField ID="parGrfKod" runat="server" />
             <asp:HiddenField ID="parGrfPth" runat="server" />
             <asp:HiddenField ID="parGrfIin" runat="server" />
             <asp:HiddenField ID="parGrfTel" runat="server" />
             <asp:HiddenField ID="parGrfBrt" runat="server" />
             <asp:HiddenField ID="parGrfKrt" runat="server" />
             <asp:HiddenField ID="parGrfStx" runat="server" />
             <asp:HiddenField ID="parRefKod" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 360px;">
            <%-- ============================  шапка экрана ============================================ --%>

            <obout:Grid ID="GridGrp" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                KeepSelectedRecords="true"
                AllowSorting="true"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                 ShowFooter="false"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                AutoPostBackOnSelect="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="350" ScrollWidth="100%" />
                 <ClientSideEvents OnClientSelect="OnClientSelect" ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="SPRREFIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="SPRREFKOD" HeaderText="КОД"  Width="5%" />
                    <obout:Column ID="Column07" DataField="SPRREFNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="80%" Align="left" />
                    <obout:Column HeaderText="ИЗМ УДЛ" Width="15%" AllowEdit="false" AllowDelete="false" runat="server" />
              </Columns>
 		    	
            </obout:Grid>
        </asp:Panel>

<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="ConfirmDialog" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td>Хотите записать ?</td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <asp:Button ID="ButtonUpl" runat="server" onclick="GrpWrtButton_Click" Text="ОК" />
                               <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>


<%-- =================  для удаление документа ============================================ --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>

<%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

     ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
                    a.pg
            {
                font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
            }

            a.pg:hover {
                color: crimson;
            }
    </style>

</body>
</html>



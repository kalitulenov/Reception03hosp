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

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function onClick(rowIndex, cellIndex)
        {
  //          alert(rowIndex + ' = ' + cellIndex + ' ' + GridMsg.Rows[rowIndex].Cells[0].Value);
            var EodIdn = GridMsg.Rows[rowIndex].Cells[0].Value;
          //  alert("EodIdn=" + EodIdn);

            if (cellIndex == 5 && GridMsg.Rows[rowIndex].Cells[5].Value == "+")
            {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=1", "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("EodLstGrdOneSho.aspx?EodBuxKod=0&EodIdn=" + EodIdn + "&EodImgNum=1", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            }
        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string EodIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int MsgIdn;
    int MsgAmb;
    int MsgNum;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
     //   BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
 //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        EodIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
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
        SqlCommand cmd = new SqlCommand("SELECT TABEOD.EodIdn,TABEOD.EodNum,TABEOD.EodDat,TABEOD.EodNam,TABEOD.EodEndDat," +
                                        "CASE WHEN LEN(ISNULL(TABEOD.EodImg001,''))>0 THEN '+' ELSE '' END AS IMG " +
                                        "FROM TABEOD INNER JOIN TABEODDTL ON TABEOD.EodIdn=TABEODDTL.EodDtlRef " +
                                        "WHERE TABEOD.EodFrm="+BuxFrm+" AND TABEOD.EodSts = N'6.3.4' AND TABEODDTL.EodDtlWho="+BuxKod+" AND ISNULL(TABEODDTL.EodDtlRdy, 0)=0", con);
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbMsgDoc");

        con.Close();
        
        GridMsg.DataSource = ds;
        GridMsg.DataBind();

    }
    // ======================================================================================

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
    protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
    {
            e.Row.Cells[5].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[5].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[5].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",5)");
        /*
        if (args.Row.Cells[4].Text == "USA" || args.Row.Cells[4].Text == "Denmark" || args.Row.Cells[4].Text == "Germany")
        {
            for (int i = 1; i < args.Row.Cells.Count; i++)
            {
                args.Row.Cells[i].BackColor = System.Drawing.Color.DarkGray;
            }
        }
*/
    }
    
 


    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НЕПРОЧИТАННЫЕ СООБЩЕНИЯ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 400px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridMsg" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                OnRowDataBound="OnRowDataBound_Handle"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
                    <obout:Column ID="Column0" DataField="EODIDN" HeaderText="Идн" Width="0%" />
                    <obout:Column ID="Column1" DataField="EODNUM" HeaderText="№№" Width="5%" />
                    <obout:Column ID="Column2" DataField="EODDAT" HeaderText="ДАТА" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column3" DataField="EODNAM" HeaderText="НАИМЕНОВАНИЕ" Width="80%" />
                    <obout:Column ID="Column4" DataField="EODENDDAT" HeaderText="СРОК" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column5" DataField="IMG" HeaderText="ДОКУМЕНТ" Width="5%" />
                </Columns>
            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    <owd:Window ID="ShoWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
        Left="300" Top="10" Height="450" Width="600" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="Лаборатория">
    </owd:Window>
    </form>

    <%-- ============================  STYLES ============================================ --%>
 
    
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
    </style>

</body>
</html>



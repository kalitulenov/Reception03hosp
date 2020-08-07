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
  //          alert(rowIndex + ' = ' + cellIndex + ' ' + GridLab.Rows[rowIndex].Cells[0].Value);
            var AmbLabIdn = GridLab.Rows[rowIndex].Cells[0].Value;
 //           alert("AmbLabIdn=" + AmbLabIdn);
/*
            if (cellIndex == 3 && GridLab.Rows[rowIndex].Cells[3].Value == "+")
            {
                LabWindow.setTitle(AmbLabIdn);
                LabWindow.setUrl("DocAppAmbLabOne.aspx?AmbUslIdn=" + AmbLabIdn);
                LabWindow.Open();
            }
*/

            if (cellIndex == 5 && GridLab.Rows[rowIndex].Cells[5].Value == "+") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

            if (cellIndex == 6 && GridLab.Rows[rowIndex].Cells[6].Value == "+") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

            if (cellIndex == 7 && GridLab.Rows[rowIndex].Cells[7].Value == "+") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }


        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int LabIdn;
    int LabAmb;
    int LabNum;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
 //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
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
        SqlCommand cmd = new SqlCommand("HspAmbLabIIN", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbLabIIN");

        con.Close();
        
        GridLab.DataSource = ds;
        GridLab.DataBind();

    }
    // ======================================================================================

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
    protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
    {
            e.Row.Cells[5].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[5].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[5].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",5)");

            e.Row.Cells[6].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[6].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[6].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",6)");

            e.Row.Cells[7].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[7].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[7].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",7)");
            
        
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
            Text="ЛАБОРАТОРНЫЕ АНАЛИЗЫ"
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
            <obout:Grid ID="GridLab" runat="server"
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
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Width="10%" />
                    <obout:Column ID="Column1" DataField="USLAMB" HeaderText="Амб" Width="0%" />
                    <obout:Column ID="Column2" DataField="TYPDOC" HeaderText="ДОКУМ" Width="5%" />
                    <obout:Column ID="Column3" DataField="GRFDAT" HeaderText="ДАТА" DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column4" DataField="NAM" HeaderText="АНАЛИЗ" Width="45%" />
                    <obout:Column ID="Column5" DataField="IMGXLS" HeaderText="1.ОБРАЗ" Width="5%" />
                    <obout:Column ID="Column6" DataField="IMG001" HeaderText="2.ОБРАЗ" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column7" DataField="IMG002" HeaderText="3.ОБРАЗ" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column8" DataField="USLFIO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" />
                    <obout:Column ID="Column9" DataField="USLBINGDE" HeaderText="ЛАБОРАТОРИЯ" Width="10%" />
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



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
        // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
        function HandlePopupResult(result) {
       //                       alert("result of popup is: " + result);

                              var jsVar = "dotnetcurry.com";
                              __doPostBack('callPostBack', jsVar);

        }


        function GridUkl_Edit(sender, record) {

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbNazPrz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbNazPrz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function onClick(rowIndex, cellIndex) {
        //   alert(rowIndex + ' = ' + 'cellIndex=' + ' ' + cellIndex);
            var AmbUklIdn = GridUkl.Rows[rowIndex].Cells[0].Value;
            var AmbCrdIdn = GridUkl.Rows[rowIndex].Cells[1].Value;
            var AmbStxKey = GridUkl.Rows[rowIndex].Cells[2].Value;
            var AmbCelVal = GridUkl.Rows[rowIndex].Cells[cellIndex].Value;
        //    alert("AmbCelVal=" + AmbCelVal);

            if (AmbCelVal.indexOf('+') != -1)
            {
              //  alert("AmbCrdIdn1=");
                var ua = navigator.userAgent;
                // Увеличить высоту для списание расхода
                //if (ua.search(/Chrome/) > -1)
                //    window.open("/Priem/DocAppLstNazDtlUpd.aspx?AmbUklIdn=" + AmbUklIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbStxKey=" + AmbStxKey + "&AmbUklCel=" + cellIndex, "ModalPopUp", "toolbar=no,width=1000,height=550,left=200,top=100,location=no,modal=0,status=no,scrollbars=no,resize=no,fullscreen=yes");
                //else
                //    window.showModalDialog("/Priem/DocAppLstNazDtlUpd.aspx?AmbUklIdn=" + AmbUklIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbStxKey=" + AmbStxKey + "&AmbUklCel=" + cellIndex, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:1000px;dialogHeight:550px;");

                if (ua.search(/Chrome/) > -1)
                    window.open("/Priem/DocAppLstNazDtlUpd.aspx?AmbUklIdn=" + AmbUklIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbStxKey=" + AmbStxKey + "&AmbUklCel=" + cellIndex, "ModalPopUp", "toolbar=no,width=1000,height=350,left=200,top=200,location=no,modal=0,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("/Priem/DocAppLstNazDtlUpd.aspx?AmbUklIdn=" + AmbUklIdn + "&AmbCrdIdn=" + AmbCrdIdn + "&AmbStxKey=" + AmbStxKey + "&AmbUklCel=" + cellIndex, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:200px;dialogWidth:1000px;dialogHeight:350px;");
            }

            
   //         alert("AmbCrdIdn2=");


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

    int UklIdn;
    int UklAmb;
    int UklNaz;
    string UklGod;
    string UklNam;
    string UklFlg001;
    string UklFlg002;
    string UklFlg003;
    string UklFlg004;
    string UklFlg005;
    string UklFlg006;
    string UklFlg007;
    string UklFlg008;
    string UklFlg009;
    string UklFlg010;
    string UklFlg011;
    string UklFlg012;
    string UklFlg013;
    string UklFlg014;
    string UklFlg015;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================
        sdsUkl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsUkl.SelectCommand = "SELECT UklKolKod,UklKolNam FROM SprUklKol";

 //       GridUkl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
//        GridUkl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //       GridUkl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {

        }
             getGrid();
       
        HidAmbCrdIdn.Value = AmbCrdIdn;
   

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        DateTime TekBegDat;
        
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUklIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["UKLDAT"].ToString())) TekBegDat = DateTime.Today;
            else TekBegDat = Convert.ToDateTime(ds.Tables[0].Rows[0]["UKLDAT"]);
            UklGod = Convert.ToDateTime(TekBegDat).ToString("yyyy");

            GridUkl.Columns[07].HeaderText = Convert.ToDateTime(TekBegDat).ToString("dd.MM");
            GridUkl.Columns[08].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(1)).ToString("dd.MM");
            GridUkl.Columns[09].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(2)).ToString("dd.MM");
            GridUkl.Columns[10].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(3)).ToString("dd.MM");
            GridUkl.Columns[11].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(4)).ToString("dd.MM");
            GridUkl.Columns[12].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(5)).ToString("dd.MM");
            GridUkl.Columns[13].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(6)).ToString("dd.MM");
            GridUkl.Columns[14].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(7)).ToString("dd.MM");
            GridUkl.Columns[15].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(8)).ToString("dd.MM");
            GridUkl.Columns[16].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(9)).ToString("dd.MM");
            GridUkl.Columns[17].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(10)).ToString("dd.MM");
            GridUkl.Columns[18].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(11)).ToString("dd.MM");
            GridUkl.Columns[19].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(12)).ToString("dd.MM");
            GridUkl.Columns[20].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(13)).ToString("dd.MM");
            GridUkl.Columns[21].HeaderText = Convert.ToDateTime(TekBegDat.AddDays(14)).ToString("dd.MM");

            Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);

        }
            
        GridUkl.DataSource = ds;
        GridUkl.DataBind();

    }
    
    // ======================================================================================
    //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
    protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
    {
        for (int i = 1; i < 16; i++)
        {
//            if (GridUkl.Columns[i + 6].HeaderText == Convert.ToDateTime(DateTime.Today).ToString("dd.MM"))
            if (Convert.ToDateTime(GridUkl.Columns[i + 6].HeaderText+"."+UklGod) <= DateTime.Today)
            {
 //               e.Row.Cells[i + 6].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
                e.Row.Cells[i + 6].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.color = 'red';this.style.fontWeight = 'bold';";
                e.Row.Cells[i + 6].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
                e.Row.Cells[i + 6].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + "," + Convert.ToString(i + 6) + ")");
            }
        }


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


                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАЗНАЧЕНИЯ ДЛЯ ПРОЦЕДУРНОГО КАБИНЕТА"
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
            <obout:Grid ID="GridUkl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
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
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                OnRowDataBound="OnRowDataBound_Handle"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="UKLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="UKLAMB" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="STXKEY" HeaderText="Вид"  Visible="false" Width="0%" />
                    <obout:Column ID="Column3" DataField="UKLNAM" HeaderText="Назначения" Width="27%" />
                    <obout:Column ID="Column4" DataField="PRMNAM" HeaderText="Примен" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column5" DataField="EDNLEKNAM" HeaderText="Ед.изм" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column6" DataField="UKLDOZ" HeaderText="Доза" Width="3%" ReadOnly="true" />

                    <obout:Column ID="Column001" DataField="UKLFLG001" HeaderText="." Width="4%" />
                    <obout:Column ID="Column002" DataField="UKLFLG002" HeaderText="." Width="4%" />
                    <obout:Column ID="Column003" DataField="UKLFLG003" HeaderText="." Width="4%" />
                    <obout:Column ID="Column004" DataField="UKLFLG004" HeaderText="." Width="4%" />
                    <obout:Column ID="Column005" DataField="UKLFLG005" HeaderText="." Width="4%" />
                    <obout:Column ID="Column006" DataField="UKLFLG006" HeaderText="." Width="4%" />
                    <obout:Column ID="Column007" DataField="UKLFLG007" HeaderText="." Width="4%" />
                    <obout:Column ID="Column008" DataField="UKLFLG008" HeaderText="." Width="4%" />
                    <obout:Column ID="Column009" DataField="UKLFLG009" HeaderText="." Width="4%" />
                    <obout:Column ID="Column010" DataField="UKLFLG010" HeaderText="." Width="4%" />
                    <obout:Column ID="Column011" DataField="UKLFLG011" HeaderText="." Width="4%" />
                    <obout:Column ID="Column012" DataField="UKLFLG012" HeaderText="." Width="4%" />
                    <obout:Column ID="Column013" DataField="UKLFLG013" HeaderText="." Width="4%" />
                    <obout:Column ID="Column014" DataField="UKLFLG014" HeaderText="." Width="4%" />
                    <obout:Column ID="Column015" DataField="UKLFLG015" HeaderText="." Width="4%" />

                </Columns>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                <input type="button" value="Печать назначения"   onclick="PrtButton_Click()" />
            </center>
        </asp:Panel>

   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UklWindow" runat="server"  Url="WinFrm.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="50" Top="10" Height="450" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Отметка о выполнении назанчения">
       </owd:Window>   

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsUkl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

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



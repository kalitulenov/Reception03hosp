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
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Http" %>
<%@ Import Namespace="System.IO" %>

<%--<%@ Import Namespace="System.Net.Http.Headers" %>--%>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>



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

        function HandlePopupPost(result) {
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }


        //    ---------------- обращение веб методу --------------------------------------------------------
        function ShoImg(rowIndex) {
        //    alert("ShoImg="+rowIndex);
            var AmbLabIdn = GridInt.Rows[rowIndex].Cells[3].Value;

            //alert("AmbLabIdn=" + AmbLabIdn);
            //alert("Cells[5]=" + GridInt.Rows[rowIndex].Cells[5].Value);

            if (GridInt.Rows[rowIndex].Cells[5].Value == "X") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

            if (GridInt.Rows[rowIndex].Cells[5].Value == "1") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

            if (GridInt.Rows[rowIndex].Cells[5].Value == "2") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

            if (GridInt.Rows[rowIndex].Cells[5].Value == "3") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=3", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=3", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }
        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string AmbCrdIIN = "";

    string MdbNam = "HOSPBASE";

    int IntIdn;
    int IntAmb;
    int IntLab;
    string IntMem;
    bool IntFlg;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
        //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCrdIIN = Convert.ToString(Request.QueryString["AmbCrdIIN"]);
        //=====================================================================================

        sdsLab.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsLab.SelectCommand = "SELECT AMBUSL.USLIDN,AMBCRD.GrfTyp+' '+CONVERT(VARCHAR(8),AMBCRD.GrfDat,104)+' '+SprUsl.UslNam AS NAM "+
                               "FROM AMBUSL INNER JOIN SPRUSL ON AMBUSL.USLKOD=SPRUSL.USLKOD "+
                               "LEFT OUTER JOIN AMBCRD ON AMBUSL.USLAMB=AMBCRD.GRFIDN "+
                               "WHERE (LEN(ISNULL(USLXLS,''))>0 OR LEN(ISNULL(USLIG1,''))>0 OR LEN(ISNULL(USLIG2,''))>0 OR LEN(ISNULL(USLIG3,''))>0) AND AMBCRD.GrfIIN='"+
                               AmbCrdIIN +"' ORDER BY AMBCRD.GRFDAT";

        GridInt.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridInt.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridInt.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {

        }

        getGrid();
    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        string StrSql = "SELECT AMBINT.*,AMBUSL.USLIDN,AMBUSL.USLDAT,AMBUSL.USLKOD,SprUsl.UslNam AS NAM, AMBCRD_1.GrfTyp " +
                                        "FROM AMBINT INNER JOIN AMBCRD ON AMBINT.INTAMB = AMBCRD.GrfIdn "+
                                        "INNER JOIN AMBUSL INNER JOIN SprUsl ON AMBUSL.USLKOD = SprUsl.UslKod ON AMBINT.INTLAB = AMBUSL.USLIDN "+
                                        "INNER JOIN AMBCRD AS AMBCRD_1 ON AMBUSL.USLAMB = AMBCRD_1.GrfIdn " +
                                        "WHERE AMBINT.INTAMB=" + AmbCrdIdn;

        SqlCommand cmd = new SqlCommand(StrSql, con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "AMBINT");

        if (ds.Tables[0].Rows.Count > 0)
        {
            //       KltIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            //       KolDig = Convert.ToInt32(ds.Tables[0].Rows[0]["KOLDIG"]);
            //       parMkbKol.Value = Convert.ToString(KolDig);
        }
        con.Close();

        GridInt.DataSource = ds;
        GridInt.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["INTLAB"] == null | e.Record["INTLAB"] == "") IntLab = 0;
        else IntLab = Convert.ToInt32(e.Record["INTLAB"]);

        if (e.Record["INTMEM"] == null | e.Record["INTMEM"] == "") IntMem = "";
        else IntMem = Convert.ToString(e.Record["INTMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        string StrSql = "INSERT INTO AMBINT (INTAMB,INTLAB,INTMEM,INTIMG) " +
                                        "VALUES (" + Convert.ToString(AmbCrdIdn) + "," + Convert.ToString(IntLab) + ",'" + IntMem + "'," +
                                        "(SELECT CASE WHEN LEN(ISNULL(USLXLS, N'')) > 0 THEN 'X' ELSE (CASE WHEN LEN(ISNULL(USLIG1, N'')) > 0 THEN '1' ELSE (CASE WHEN LEN(ISNULL(USLIG2, N'')) > 0 THEN '2' ELSE '3' END) END) END AS NUM " +
                                        "FROM AMBUSL WHERE USLIDN=" + Convert.ToString(IntLab) + "))";

        SqlCommand cmd = new SqlCommand(StrSql, con);


        //SqlCommand cmd = new SqlCommand("INSERT INTO AMBINT (INTAMB,INTLAB,INTMEM) " +
        //                                "VALUES (" + Convert.ToString(AmbCrdIdn) + "," + Convert.ToString(IntLab) + ",'" + IntMem + "'," +
        //                                "(SELECT CASE WHEN LEN(ISNULL(USLXLS, N'')) > 0 THEN 'X' ELSE (CASE WHEN LEN(ISNULL(USLIG1, N'')) > 0 THEN '1' ELSE (CASE WHEN LEN(ISNULL(USLIG2, N'')) > 0 THEN '2' ELSE '3' END) END) END AS NUM" +
        //                                "FROM AMBUSL WHERE USLIDN=" + Convert.ToString(IntLab) + "))", con);
        // указать тип команды
        //   cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        IntIdn = Convert.ToInt32(e.Record["INTIDN"]);

        if (e.Record["INTLAB"] == null | e.Record["INTLAB"] == "") IntLab = 0;
        else IntLab = Convert.ToInt32(e.Record["INTLAB"]);

        if (e.Record["INTMEM"] == null | e.Record["INTMEM"] == "") IntMem = "";
        else IntMem = Convert.ToString(e.Record["INTMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        string StrSql = "UPDATE AMBINT SET INTLAB=" + Convert.ToString(IntLab) +
                                        ",INTMEM='" + IntMem +
                                        "',INTIMG=(SELECT CASE WHEN LEN(ISNULL(USLXLS, N'')) > 0 THEN 'X' ELSE (CASE WHEN LEN(ISNULL(USLIG1, N'')) > 0 THEN '1' ELSE (CASE WHEN LEN(ISNULL(USLIG2, N'')) > 0 THEN '2' ELSE '3' END) END) END AS NUM " +
                                        "FROM AMBUSL WHERE USLIDN=" + Convert.ToString(IntLab) +
                                        ") WHERE INTIDN="+Convert.ToString(IntIdn);

        SqlCommand cmd = new SqlCommand(StrSql, con);

        //SqlCommand cmd = new SqlCommand("UPDATE AMBINT SET INTLAB=" + Convert.ToString(IntLab) +
        //                                ",INTMEM='" + IntMem +
        //                                "',INTIMG=(SELECT CASE WHEN LEN(ISNULL(USLXLS, N'')) > 0 THEN 'X' ELSE (CASE WHEN LEN(ISNULL(USLIG1, N'')) > 0 THEN '1' ELSE (CASE WHEN LEN(ISNULL(USLIG2, N'')) > 0 THEN '2' ELSE '3' END) END) END AS NUM " +
        //                                "FROM AMBUSL WHERE USLIDN=" + Convert.ToString(IntLab) +
        //                                ")' WHERE INTIDN="+Convert.ToString(IntIdn), con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        IntIdn = Convert.ToInt32(e.Record["INTIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBINT WHERE INTIDN=" + IntIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbKol" runat="server" />
        <asp:HiddenField ID="parIntIdn" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="ИНТЕРПРЕТАЦИЯ ИССЛЕДОВАНИИ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: 0px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 380px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridInt" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
<%--                <ClientSideEvents OnBeforeClientAdd="GridInt_ClientAdd" ExposeSender="true" />--%>
                <Columns>
                    <obout:Column ID="Column00" DataField="INTIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="GRFTYP" HeaderText="ВИД" ReadOnly="true" Width="4%" />
                    <obout:Column ID="Column02" DataField="USLDAT" HeaderText="ДАТА" ReadOnly="true" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="6%" />
                    <obout:Column ID="Column03" DataField="INTLAB" HeaderText="ИССЛЕДОВАНИЕ" Width="32%" Wrap="true" Align="left">
                        <TemplateSettings EditTemplateId="TemplateEditLab" TemplateId="TemplateLab" />
                    </obout:Column>
                    <obout:Column ID="Column04" DataField="INTMEM" HeaderText="ИНТЕРПРЕТАЦИЯ" Width="45%"  Align="left" Wrap="true" />
                    <obout:Column ID="Column05" DataField="INTIMG" HeaderText="COL" Visible="false" Width="0%" />
                   
                    <obout:Column ID="Column06" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>

                   <obout:Column ID="Column07" DataField="IMGFLG" HeaderText="ОБРАЗ" Width="5%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateImg" />
                    </obout:Column>
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

               <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridInt.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridInt.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridInt.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridInt.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridInt.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохр" class="tdTextSmall" onclick="GridInt.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridInt.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateImg">
                        <Template>
                            <input type="button" id="btnImg" class="tdTextSmall" value="Образ" onclick="ShoImg(<%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                 
                   <obout:GridTemplate runat="server" ID="TemplateLab">
                        <Template>
                            <%# Container.DataItem["NAM"]%>
                        </Template>
                    </obout:GridTemplate>
		
                    <obout:GridTemplate runat="server" ControlID="ddlLab" ID="TemplateEditLab" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlLab" Width="100%" Height="150" MenuWidth="800"
                                DataSourceID="sdsLab" DataTextField="NAM" DataValueField="USLIDN">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
<%--  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <input type="button" value="Печать направления по одному"  onclick="PrtButton_Click()" />
                 <input type="button" value="Печать направления"  onclick="PrtButtonAll_Click()" />
                 <input type="button" value="Шаблон направлении"   onclick="SablonPrs()" />
             </center>
  </asp:Panel> --%>
        
    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsLab"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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



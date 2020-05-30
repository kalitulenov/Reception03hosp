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
         function WebCam(rowIndex) {
    //         alert("GridAnl_ClientEdit="+rowIndex);
             var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
             var AmbAnlPth = "";  //document.getElementById('parXlsFio').value;
             var AmbUslIIN = document.getElementById('parGrfIIN').value;

             AnlWindow.setTitle(AmbAnlPth);
             AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbUslPth=" + AmbAnlPth + "&AmbUslIIN=" + AmbUslIIN);
             AnlWindow.Open();
             return false;
         }

         function WindowClose() {
             var jsVar = "callPostBack";
             __doPostBack('callPostBack', jsVar);
             //  __doPostBack('btnSave', e.innerHTML);
         }

         //function GridUsl_ClientAdd(sender, record) {

         //    //                    alert("GridUыд_ClientEdit");
         //    //            document.getElementById('parPrsIdn').value = 0;
         //    //            TrfWindow.Open();
         //    var AmbCrdIdn = document.getElementById('parCrdIdn').value;
         //    var ua = navigator.userAgent;
         //    if (ua.search(/Chrome/) > -1)
         //        window.open("/Priem/DocAppAmbUslSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
         //            "ModalPopUp", "toolbar=no,width=800,height=550,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
         //    else
         //        window.showModalDialog("/Priem/DocAppAmbUslSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
         //            "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:550px;");

         //    return false;
         //}



 </script>

</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UslIdn;
    int UslAmb;
    string UslNap;
    string UslStx;
    int UslLgt;
    int UslZen;
    int UslKol;
    int UslKod;
    int UslKto;
    string UslGde;
    string UslDat;

    string UslNam;
    string UslMem;
    string UslTyp;

    int NumDoc;

    string AmbCrdIdn;
    string AmbCntIdn;
    string AmbUslIdn;

    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
        //           TxtDoc = (string)Request.QueryString["TxtSpr"];
        //       Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];

        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE ISNULL(BUXUBL,0)=0 AND BUXFRM=" + BuxFrm + " ORDER BY FI"; //+ " AND DLGTYP='ФИЗ'"

        sdsGde.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGde.SelectCommand = "SELECT * FROM SprGdePrm ORDER BY GdePrmNam";

        GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // SELECT SttStrKey AS STTKEY, SttStrNam AS STTNAM FROM SprSttStr WHERE SttStrFrm=" + BuxFrm + " AND SttStrLvl = 1 ORDER BY SttStrNam";

        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        //=====================================================================================

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  // && parCrdIdn.Value == ""
        {
            Session["AmbUslIdn"] = "Post";
            PushButton();
        }
        else Session["PostBack"] = "no";

        //============= начало  ===========================================================================================
        if (!Page.IsPostBack)
        {

            //               GlvBegDat = (DateTime)Session["GlvBegDat"];
            //               GlvEndDat = (DateTime)Session["GlvEndDat"];
            //============= Установки ===========================================================================================
            if (AmbCrdIdn == "0")  // новый документ
            {
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "АНЛ";
                cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = AmbCntIdn;
                cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                    //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                    AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
                }
                finally
                {
                    con.Close();
                }

            }

            //Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
            HidAmbCrdIdn.Value = AmbCrdIdn;
            //parBuxFrm.Value = BuxFrm;
        }

        getGrid();
        //   getDocNum();

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        string StxKey;
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = HidAmbCrdIdn.Value;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslStxIdn");

        if (ds.Tables[0].Rows.Count > 0)
        {
            StxKey = Convert.ToString(ds.Tables[0].Rows[0]["STXKEY"]);
            parGrfIIN.Value = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
        }

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();
    }

    void PushButton()
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("HspDocAppLstSumIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = HidAmbCrdIdn.Value;
        cmd.ExecuteNonQuery();

        con.Close();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["USLMEM"] == null | e.Record["USLMEM"] == "") UslMem = "";
        else UslMem = Convert.ToString(e.Record["USLMEM"]);
        
        if (e.Record["USLBINGDE"] == null | e.Record["USLBINGDE"] == "") UslGde = "";
        else UslGde = Convert.ToString(e.Record["USLBINGDE"]);
        
        if (e.Record["USLPRMGDE"] == null | e.Record["USLPRMGDE"] == "") UslTyp = "";
        else UslTyp = Convert.ToString(e.Record["USLPRMGDE"]);

        if (e.Record["USLKTO"] == null | e.Record["USLKTO"] == "") UslKto =  Convert.ToInt32(BuxKod);
        else UslKto = Convert.ToInt32(e.Record["USLKTO"]);

        UslDat = Convert.ToString(e.Record["USLDAT"]);
        if (string.IsNullOrEmpty(UslDat)) UslDat = DateTime.Now.ToString("dd.MM.yyyy");
        else UslDat = Convert.ToDateTime(e.Record["USLDAT"]).ToString("dd.MM.yyyy");


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("INSERT INTO AMBUSL (USLAMB,USLKTO,USLDAT,USLSTX,USLDOCNAM,USLMEM,USLBINGDE,USLPRMGDE) " +
                                        "VALUES("+HidAmbCrdIdn.Value+","+
                                                  UslKto+","+
                                                  "CONVERT(DATETIME,'" + UslDat + "',104)," +
                                                  "'00000','АНЛ','"+
                                                  UslMem +"','"+ UslGde +"','" + UslTyp + "')", con);

        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();

    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        UslKod = 0;

        if (e.Record["USLMEM"] == null | e.Record["USLMEM"] == "") UslMem = "";
        else UslMem = Convert.ToString(e.Record["USLMEM"]);
        
        if (e.Record["USLBINGDE"] == null | e.Record["USLBINGDE"] == "") UslGde = "";
        else UslGde = Convert.ToString(e.Record["USLBINGDE"]);
        
        if (e.Record["USLPRMGDE"] == null | e.Record["USLPRMGDE"] == "") UslTyp = "";
        else UslTyp = Convert.ToString(e.Record["USLPRMGDE"]);

        if (e.Record["USLKTO"] == null | e.Record["USLKTO"] == "") UslKto =  Convert.ToInt32(BuxKod);
        else UslKto = Convert.ToInt32(e.Record["USLKTO"]);

        UslDat = Convert.ToString(e.Record["USLDAT"]);
        if (string.IsNullOrEmpty(UslDat)) UslDat = DateTime.Now.ToString("dd.MM.yyyy");
        else UslDat = Convert.ToDateTime(e.Record["USLDAT"]).ToString("dd.MM.yyyy");

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        //  SqlCommand cmd = new SqlCommand("HspAmbUslRepGde", con);

        SqlCommand cmd = new SqlCommand("UPDATE AMBUSL SET USLKTO="+UslKto+","+
                                                          "USLDAT=CONVERT(DATETIME,'" + UslDat + "',104)," +
                                                          "USLMEM='"+UslMem + "'," +
                                                          "USLBINGDE='"+UslGde + "'," +
                                                          "USLPRMGDE='"+UslTyp +"' WHERE USLIDN="+UslIdn, con);
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void RebindGrid(object sender, EventArgs e)
    {
        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmdDtl = new SqlCommand("DELETE FROM AMBUSLDTL WHERE USLDTLREF=" + UslIdn, con);
        cmdDtl.ExecuteNonQuery();
        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE USLIDN=" + UslIdn, con);
        cmd.ExecuteNonQuery();

        con.Close();

        getGrid();
    }


    // ==================================== ШАБЛОНЫ  ============================================
    //------------------------------------------------------------------------
    //protected void SablonPrvDig(object sender, EventArgs e) { SablonPrv("Dig"); }
    //protected void SablonPrvDsp(object sender, EventArgs e) { SablonPrv("Dsp"); }

    //void SablonPrv(string SblTyp)
    //{
    //    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
    //    // создание соединение Connection
    //    SqlConnection con = new SqlConnection(connectionString);
    //    // создание команды
    //    SqlCommand cmd = new SqlCommand("HspAmbSblPrv", con);
    //    // указать тип команды
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    // передать параметр
    //    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
    //    cmd.Parameters.Add("@GLVTYP", SqlDbType.VarChar).Value = SblTyp;
    //    // Выполнить команду
    //    con.Open();
    //    cmd.ExecuteNonQuery();

    //    con.Close();

    //    //  getDocNum();
    //}

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
         <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parGrfIIN" runat="server" />

        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />

            <%-- ============================  шапка экрана ============================================ --%>
            <asp:TextBox ID="Sapka"
                Text="СКАНИРОВАННЫЕ ДОКУМЕНТЫ"
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
            <obout:Grid ID="GridUsl" runat="server"
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
<%--                <ClientSideEvents OnBeforeClientAdd="GridUsl_ClientAdd" 
                                  ExposeSender="true" />--%>
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column03" DataField="USLDAT" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="12%" >
                        <TemplateSettings EditTemplateId="tplDatePicker" />
                    </obout:Column>
                    <obout:Column ID="Column04" DataField="USLPRMGDE" HeaderText="ВИД ДОКУМ" Width="10%" Align="left" />
                    <obout:Column ID="Column07" DataField="USLMEM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="45%" Wrap="true" Align="left" />
                    <obout:Column ID="Column14" DataField="USLBINGDE" HeaderText="ОТКУДА ДОКУМЕНТ" Width="18%" />

                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>

                    <obout:Column ID="Column15" DataField="IMGFLG" HeaderText="ОБРАЗ" Width="5%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateImg" />
                    </obout:Column>
                </Columns>

<%--                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />--%>

               <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridUsl.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="tplDatePicker" ControlID="txtOrderDate" ControlPropertyName="value">
                        <Template>
                            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                <tr>
                                    <td valign="middle">
                                        <obout:OboutTextBox runat="server" ID="txtOrderDate" Width="100%"
                                            FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                    </td>
                                    <td valign="bottom" width="30px">
                                        <obout:Calendar ID="calBeg" runat="server"
                                            StyleFolder="~/Styles/Calendar/styles/default"
                                            DatePickerMode="true"
                                            DateMin="01.01.2000"
                                            ShowYearSelector="true"
                                            YearSelectorType="DropDownList"
                                            TitleText="Выберите год: "
                                            TextBoxId="GridUsl$tplDatePicker$ctl00$txtOrderDate"
                                            CultureName="ru-RU"
                                            DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                    </td>
                                </tr>
                            </table>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateImg">
                        <Template>
                            <input type="button" id="btnImg" class="tdTextSmall" value="Образ" onclick="WebCam(<%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                </Templates>
            </obout:Grid>

        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
                     Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
                <center>
                    <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
                </center>
          </asp:Panel> 

        <!--  -----------------------------------------------------------------------------------------------------------------------  -->
        <%-- ============================  шапка экрана ============================================ --%>
        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="200" Top="10" Height="350" Width="700" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGde" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
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
        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
        .ob_iTIE {
            font-size: larger;
            font: bold 12px Tahoma !important; /* для увеличение корректируемого текста*/
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



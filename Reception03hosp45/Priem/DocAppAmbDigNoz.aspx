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

        function HandlePopupPost(result) {
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }

        // ==================================== корректировка данные клиента в отделном окне  ============================================

        function GridDig_ClientAdd(sender, record) {

   //                    alert("GridUыд_ClientEdit");
//            document.getElementById('parDOCDIGIdn').value = 0;
//            TrfWindow.Open();
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 
            var ua = navigator.userAgent;
            //if (ua.search(/Chrome/) > -1)
            //    window.open("/Priem/DocAppAmbDOCDIGGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
            //                "ModalPopUp", "toolbar=no,width=800,height=650,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            //else
            //    window.showModalDialog("/Priem/DocAppAmbDOCDIGGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
            //        "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:650px;");

            //parMkbNum.value = 1;
            ////             MkbWindow.Open();
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&MkbNum=1",
                    "ModalPopUp", "toolbar=no,width=800,height=545,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppAmbOsmMkb.aspx?AmbCrdIdn=" + AmbCrdIdn + "&MkbNum=1",
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:545px;");


            return false;
        }

        function HandlePopupResult(result) {
       //                         alert("result of popup is: " + result);
            var MasPar = result.split('@');

            if (MasPar[0] == 'GrfMkb') {
                //     var QueryString = getQueryString();
             //   var DatDocIdn = document.getElementById('parCrdIdn').value;
                var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 

                var ParStr = AmbCrdIdn + '@1@' + result + '@@@@';
                  //                  alert("ParStr=" + ParStr);

                    $.ajax({
                        type: 'POST',
                        url: '/HspUpdDoc.aspx/DocAppAmbOsmMkb',
                        contentType: "application/json; charset=utf-8",
                        data: '{"ParStr":"' + ParStr + '"}',
                        dataType: "json",
                        success: function (msg) {
                            //              alert("msg=" + msg);
                            //     alert("msg.d=" + msg.d);
                            //    alert("msg.d=" + MasPar[0] + ' * ' + MasPar[1] + ' * ' + MasPar[2] + ' * ' + MasPar[3]);
                            //                                alert("msg.d2=" + msg.d.substring(0, 3));
                            //                                alert("msg.d3=" + msg.d.substring(3, 7));
                            //               Mkb001.options[Mkb001.selectedIndex()].value = MasPar[1];
                            //               Mkb002.options[Mkb002.selectedIndex()].value = MasPar[2];
                            //               Mkb003.options[Mkb003.selectedIndex()].value = MasPar[3];

                            //document.getElementById('Dig003').value = document.getElementById('Dig003').value + msg.d + '.';
                            //document.getElementById('Mkb001').value = MasPar[1];
                            //document.getElementById('Mkb002').value = MasPar[2];
                            //document.getElementById('Mkb003').value = MasPar[3];
                        },
                        error: function () { }
                    });
            }
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);

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

    int DigIdn;
    int DigAmb;
    int DigTyp;
    int DigVid;
    string DigOpr;
    string DigKod;
    string DigNam;
    bool DigDigFlg;


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
        //=====================================================================================

        sdsDig.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsDig.SelectCommand = "SELECT MkbKod FROM MKB10 WHERE MkbNodKol=0 ORDER BY MkbKod";

        sdsTyp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsTyp.SelectCommand = "SELECT DIGTYPKOD,DIGTYPNAM FROM SPRDIGTYP ORDER BY DIGTYPKOD";

        sdsVid.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsVid.SelectCommand = "SELECT DIGVIDKOD,DIGVIDNAM FROM SPRDIGVID ORDER BY DIGVIDKOD";

        sdsOpr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsOpr.SelectCommand = "SELECT BGO006MKB,BGO006MKB+' '+BGO006NAM AS OPRNAM FROM SPRBGO006 WHERE BGO006CTYPOL='+' ORDER BY BGO006MKB";

        GridDig.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridDig.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridDig.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

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
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        //    SqlCommand cmd = new SqlCommand("HspAmbDigIdn", con);
        SqlCommand cmd = new SqlCommand("SELECT DocDigIdn,DocDigTyp,DocDigVid,DocDigKod,DocDigNam,DigTypNam,DocDigMkb009,SprBgo006.Bgo006Mkb+' '+SprBgo006.Bgo006Nam AS OPRNAM,DigVidNam,DocDigFin,MKB10.MkbXrn,MKB10.MkbInf,MKB10.MkbSoz " +
                                        "FROM AMBCRD INNER JOIN AMBDOCDIG ON AMBCRD.GrfIdn = AMBDOCDIG.DocDigAmb " +
                                        "INNER JOIN MKB10 ON AMBDOCDIG.DocDigKod=MKB10.MkbKod " +
                                        "LEFT OUTER JOIN SprDigTyp ON AMBDOCDIG.DocDigTyp = SprDigTyp.DigTypKod " +
                                        "LEFT OUTER JOIN SprDigVid ON AMBDOCDIG.DocDigVid = SprDigVid.DigVidKod " +
                                        "LEFT OUTER JOIN SprBgo006 ON AMBDOCDIG.DocDigMkb009 = SprBgo006.Bgo006Mkb " +
                                        "WHERE GRFIDN=" + AmbCrdIdn+" ORDER BY DocDigIdn", con);
        // указать тип команды
        //  cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //  cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbDigIdn");

        con.Close();

        GridDig.DataSource = ds;
        GridDig.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        //if (e.Record["DOCDIGTYP"] == null | e.Record["DOCDIGTYP"] == "") DigTyp = 0;
        //else DigTyp = Convert.ToInt32(e.Record["DOCDIGTYP"]);

        //if (e.Record["DOCDIGNAM"] == null | e.Record["DOCDIGNAM"] == "") DigNam = "";
        //else DigNam = Convert.ToString(e.Record["DOCDIGNAM"]);

        //string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        //// создание соединение Connection
        //SqlConnection con = new SqlConnection(connectionString);
        //con.Open();

        //// создание команды
        //SqlCommand cmd = new SqlCommand("INSERT INTO AMBDOCDIG (DOCDIGTYP,DOCDIGKOD) " +
        //                                "VALUES (" + DigTyp + "','" + DigKod + ")", con);
        //cmd.ExecuteNonQuery();
        //con.Close();


        //getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        DigIdn = Convert.ToInt32(e.Record["DOCDIGIDN"]);

        if (e.Record["DOCDIGTYP"] == null | e.Record["DOCDIGTYP"] == "") DigTyp = 0;
        else DigTyp = Convert.ToInt32(e.Record["DOCDIGTYP"]);

        if (e.Record["DOCDIGVID"] == null | e.Record["DOCDIGVID"] == "") DigVid = 0;
        else DigVid = Convert.ToInt32(e.Record["DOCDIGVID"]);

        if (e.Record["DOCDIGMKB009"] == null | e.Record["DOCDIGMKB009"] == "") DigOpr = "";
        else DigOpr = Convert.ToString(e.Record["DOCDIGMKB009"]);

        //if (e.Record["DOCDIGNAM"] == null | e.Record["DOCDIGNAM"] == "") DigNam = "";
        //else DigNam = Convert.ToString(e.Record["DOCDIGNAM"]);

        // ******************************************************* Передать GRFIDN и получить XML ***************************************************************************
        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        // ------------ удалить загрузку оператора ---------------------------------------
        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE AMBDOCDIG SET DOCDIGTYP=" + DigTyp + ",DOCDIGVID=" + DigVid + ",DOCDIGMKB009='" + DigOpr +
                                        "' WHERE DOCDIGIDN=" + DigIdn, con);
        // указать тип команды
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();



        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        DigIdn = Convert.ToInt32(e.Record["DOCDIGIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("HspSprMkbDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@DIGIDN", SqlDbType.Int, 4).Value = DigIdn;
        cmd.Parameters.Add("@GRFIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        // Выполнить команду
        con.Open();
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();
        // ------------------------------------------------------------------------------заполняем второй уровень

        getGrid();
    }

    // =================================================================================================================================================


</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parDigIdn" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="ДИАГНОЗЫ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 380px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridDig" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ClientSideEvents OnBeforeClientAdd="GridDig_ClientAdd" 
                                  ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column00" DataField="DOCDIGIDN" HeaderText="Idn" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="DOCDIGCRD" HeaderText="Crd" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="DOCDIGTYP" HeaderText="ТИП ДИАГНОЗА" Width="10%" >
                        <TemplateSettings TemplateId="TemplateTypNam" EditTemplateId="TemplateEditTypNam" />
                    </obout:Column>
                    <obout:Column ID="Column10" DataField="DOCDIGFIN" HeaderText="ВИД ОПЛ" Align="left" ReadOnly="true" Wrap="true" Width="5%"  />
                    <obout:Column ID="Column05" DataField="DOCDIGKOD" HeaderText="МКБ" Width="5%"  ReadOnly="true"/>
                    <obout:Column ID="Column06" DataField="DOCDIGNAM" HeaderText="ДИАГНОЗ" Align="left" ReadOnly="true" Wrap="true" Width="38%"  />
                    <obout:Column ID="Column07" DataField="MKBXRN" HeaderText="ХРН" Align="center" ReadOnly="true" Width="4%"  />
                    <obout:Column ID="Column08" DataField="MKBINF" HeaderText="ИНФ" Align="center" ReadOnly="true" Width="4%"  />
                    <obout:Column ID="Column09" DataField="MKBSOZ" HeaderText="СЗЗ" Align="center" ReadOnly="true" Width="4%"  />
                    <obout:Column ID="Column03" DataField="DOCDIGVID" HeaderText="ДЛЯ ДНЕВ.СТАЦИОНАРА" Width="12%" >
                        <TemplateSettings TemplateId="TemplateVidNam" EditTemplateId="TemplateEditVidNam" />
                    </obout:Column>
                    <obout:Column ID="Column04" DataField="DOCDIGMKB009" HeaderText="ВИД ОПЕРАЦИИ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateOprNam" EditTemplateId="TemplateEditOprNam" />
                    </obout:Column>
                    <obout:Column ID="Column11" DataField="" HeaderText="КОРР" Width="8%" AllowEdit="true" AllowDelete="true" />
                </Columns>

                   <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                   
                   <Templates>
                       <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridDig.addRecord()"/>
                        </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridDig.insertRecord()"/> 
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridDig.cancelNewRecord()"/> 
                        </Template>
                      </obout:GridTemplate>	

                    <obout:GridTemplate runat="server" ID="TemplateTypNam">
                        <Template>
                            <%# Container.DataItem["DigTypNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlTypNam" ID="TemplateEditTypNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlTypNam" Width="100%" Height="250"
                                DataSourceID="sdsTyp" DataTextField="DigTypNam" DataValueField="DigTypKod">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateVidNam">
                        <Template>
                            <%# Container.DataItem["DigVidNam"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlVidNam" ID="TemplateEditVidNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlVidNam" Width="100%" Height="250"
                                DataSourceID="sdsVid" DataTextField="DigVidNam" DataValueField="DigVidKod">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateOprNam">
                        <Template>
                            <%# Container.DataItem["OPRNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlOprNam" ID="TemplateEditOprNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlOprNam" Width="100%" Height="250" MenuWidth="600"
                                DataSourceID="sdsOpr" DataTextField="OPRNAM" DataValueField="BGO006MKB">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateMkbNam">
                        <Template>
                            <%# Container.DataItem["MkbKod"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlMkbNam" ID="TemplateEditMkbNam" ControlPropertyName="value">
                        <Template>
                            <obout:ComboBox runat="server" ID="ddlMkbNam" Width="100%" Height="250"
                                DataSourceID="sdsDig" DataTextField="MkbKod" DataValueField="MkbKod">
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>


                </Templates>
            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
<%--                 <input type="button" value="Печать направления по одному"  onclick="PrtButton_Click()" />
                 <input type="button" value="Печать направления"  onclick="PrtButtonAll_Click()" />
                 <input type="button" value="Шаблон направлении"   onclick="SablonDig()" />--%>
             </center>
  </asp:Panel> 
        

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsDig" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsVid" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsOpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

<%--    <asp:SqlDataSource runat="server" ID="sdsNpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
	    <SelectParameters>
	        <asp:Parameter Name="STRUSLKEY" Type="String" />
	    </SelectParameters>	    
    </asp:SqlDataSource>		--%>
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



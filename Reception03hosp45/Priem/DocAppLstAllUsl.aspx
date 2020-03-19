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
        function GridUsl_Edit(sender, record) {
            alert("GridUsl_Edit=");

            //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
            TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
            TemplateGrpKey.value(record.STRUSLKEY);
            TemplateGrpKey._preventDetailLoading = false;
            TemplateGrpKey._populateDetail();

            return true;
        }

        function GridUsl_rsx(rowIndex) {
            var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
 //           alert("GridUsl_rsx=" + AmbUslIdn);

            RsxWindow.setTitle(AmbUslIdn);
            RsxWindow.setUrl("DocAppAmbUslRsx.aspx?AmbUslIdn=" + AmbUslIdn);
            RsxWindow.Open();
            return true;
        }


        function loadStx(sender, index) {
 //           alert("loadStx 0 =" + index);
 //           alert("loadStx 1 =" + document.getElementById('parBuxFrm').value);
 //           alert("loadStx 2 =" + document.getElementById('parBuxKod').value);
            var SndPar = sender.value() + ':' + document.getElementById('parBuxFrm').value + ':' + document.getElementById('parCrdIdn').value;
 //           alert("loadStx 3 =" + SndPar);
            PageMethods.GetSprUsl(SndPar, onSprUslLoaded, onSprUslLoadedError);
/*
            var DatDocIdn;
            var QueryString = getQueryString();
            DatDocIdn = QueryString[1];
*/
            //                      alert("onChange=" + DatDocMdb + ' ' + DatDocTab + ' ' + DatDocKey + ' ' +DatDocIdn + ' ' + DatDocRek + ' ' + DatDocVal);

        }

        function onSprUslLoaded(SprUsl) {
  //          alert("onSprUslLoaded=" + SprUsl);

            SprUslComboBox.options.clear();

            for (var i = 0; i < SprUsl.length; i++) {
                SprUslComboBox.options.add(SprUsl[i]);
            }

            SprUslComboBox.value(document.getElementById('hiddenUslNam').value);
        }

        function onSprUslLoadedError() {
        }

        function updateSprUslSelection(sender, index) {
            document.getElementById('hiddenUslNam').value = sender.value();
        }

        // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
        function OK_click() {
 
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

    int UslIdn;
    int UslAmb;
    int UslNap;
    int UslStx;
    int UslLgt;
    string UslNam;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //=====================================================================================
        parBuxFrm.Value = BuxFrm;
        parBuxKod.Value = BuxKod;
        parCrdIdn.Value = AmbCrdIdn;
        //=====================================================================================
 
        sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";
        
        sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;

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
        SqlCommand cmd = new SqlCommand("HspAmbUslStxIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUslStxIdn");

        con.Close();

        GridUsl.DataSource = ds;
        GridUsl.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        else UslNap = Convert.ToInt32(e.Record["USLNAP"]);
        if (e.Record["USLSTX"] == null | e.Record["USLSTX"] == "") UslStx = 0;
        else UslStx = Convert.ToInt32(e.Record["USLSTX"]);
        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.Int, 4).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);
        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = 0;
        else UslNap = Convert.ToInt32(e.Record["USLNAP"]);
        if (e.Record["USLSTX"] == null | e.Record["USLSTX"] == "") UslStx = 0;
        else UslStx = Convert.ToInt32(e.Record["USLSTX"]);
        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);
        
        if (e.Record["USLNAM"] == null | e.Record["USLNAM"] == "") UslNam = "";
        else UslNam = Convert.ToString(e.Record["USLNAM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslStxRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLNAP", SqlDbType.Int, 4).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.Int, 4).Value = UslStx;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = UslLgt;
        cmd.Parameters.Add("@USLNAM", SqlDbType.VarChar).Value = UslNam;
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
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE ISNULL(USLRDY,0)=0 AND USLIDN=" + UslIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }


    [WebMethod]
    public static List<string> GetSprUsl(string StxKod)
    {
        List<string> SprUsl = new List<string>();
        
        string[] MasLst = StxKod.Split(':');


        if (!string.IsNullOrEmpty(StxKod))
        {
            string SqlStr;
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("HspAmbUslStxSou", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@USLAMB", SqlDbType.VarChar).Value = MasLst[2];
            cmd.Parameters.Add("@USLFRM", SqlDbType.VarChar).Value = MasLst[1];
            cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = MasLst[0];
            // создание команды
 
            con.Open();

            SqlDataReader myReader = cmd.ExecuteReader();
            while (myReader.Read())
            {
                SprUsl.Add(myReader.GetString(0));
            }

            con.Close();
        }

        return SprUsl;
    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka"
            Text="УСЛУГИ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 400px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/grand_gray"
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
        OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
                ShowColumnsFooter="true">
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="USLKAS" HeaderText="№касс" Width="7%" ReadOnly="true" />
                    <obout:Column ID="Column2" DataField="USLNAP" HeaderText="№напр" Width="8%" />
                    <obout:Column ID="Column20" DataField="GRFDAT" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="10%">
                        <TemplateSettings EditTemplateId="tplDatePickerDat" />
                    </obout:Column>                   
                    <obout:Column ID="Column3" DataField="USLSTX" HeaderText="ВИД ОПЛ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateStxNam" EditTemplateId="TemplateEditStxNam" />
                    </obout:Column>
                    <obout:Column ID="Column4" DataField="USLNAM" HeaderText="Наименование услуги" Width="28%" Align="left" >
                        <TemplateSettings TemplateId="TemplateUslNam" EditTemplateId="TemplateEditUslNam" />
                    </obout:Column>
                    <obout:Column ID="Column5" DataField="USLLGT" HeaderText="Льгота" Width="5%" />
                    <obout:Column ID="Column6" DataField="USLZEN" HeaderText="Цена" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column7" DataField="USLSUM" HeaderText="Сумма" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column8" DataField="FI" HeaderText="Ответственный" Width="10%" ReadOnly="true" />
                    <obout:Column ID="Column9" DataField="RDY" HeaderText="Резул" Width="5%" ReadOnly="true" />
                    
                    <obout:Column ID="Column10" HeaderText="Коррек  Удаление" Width="7%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>		
 
                    <obout:GridTemplate runat="server" ID="tplDatePickerDat" ControlID="txtDatPic" ControlPropertyName="value">
                        <Template>
                            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                <tr>
                                    <td valign="middle">
                                        <obout:OboutTextBox runat="server" ID="txtDatPic" Width="100%"
                                            FolderStyle="~/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                    </td>
                                    <td valign="bottom" width="30">
                                        <obout:Calendar ID="calDat" runat="server"
                                            StyleFolder="~/Styles/Calendar/styles/default"
                                            DatePickerMode="true"
                                            ShowYearSelector="true"
                                            YearSelectorType="DropDownList"
                                            TitleText="Выберите год: "
                                            CultureName="ru-RU"
                                            DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                    </td>
                                </tr>
                            </table>
                        </Template>
                    </obout:GridTemplate>                   
                    
                    						
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridUsl.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridUsl.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUsl.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
                   			
                    <obout:GridTemplate runat="server" ID="TemplateStxNam">
                        <Template>
                            <%# Container.DataItem["STXNAM"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ControlID="ddlStxNam" ID="TemplateEditStxNam" ControlPropertyName="value">
                        <Template>
                           <obout:ComboBox runat="server" ID="ddlStxNam" Width="100%" Height="150"
                                DataSourceID="sdsStx" DataTextField="StxNam" DataValueField="StxKod">
                                <ClientSideEvents OnSelectedIndexChanged="loadStx" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>
                    
                    <obout:GridTemplate runat="server" ID="TemplateUslNam">
                        <Template>
                            <%# Container.DataItem["UslNam"]%>
                        </Template>
                    </obout:GridTemplate>

                   <obout:GridTemplate runat="server" ControlID="hiddenUslNam" ID="TemplateEditUslNam" ControlPropertyName="value">
                        <Template>
                           <input type="hidden" id="hiddenUslNam" />
                           <obout:ComboBox runat="server" ID="SprUslComboBox" Width="100%"  Height="300">
                                <ClientSideEvents OnSelectedIndexChanged="updateSprUslSelection" />
                            </obout:ComboBox>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
   
     <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="HspAmbUslKodSou" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="BUXFRMKOD" Name="BuxFrmKod" Type="String" />
                    <asp:SessionParameter SessionField="BUXKOD" Name="BuxKod" Type="String" />
                </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="HspAmbUslStxSel" SelectCommandType="StoredProcedure" 
        ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter SessionField="AMBCRDIDN" Name="AmbCrdIdn" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

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
    </style>

</body>
</html>



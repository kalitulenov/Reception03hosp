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
            //                       alert("result of popup is: " + result);

            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);

        }

        //    ------------------ смена логотипа ----------------------------------------------------------
        function getQueryString() {
            var queryString = [];
            var vars = [];
            var hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            //           alert("hashes=" + hashes);
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                queryString.push(hash[0]);
                vars[hash[0]] = hash[1];
                queryString.push(hash[1]);
            }
            return queryString;
        }

        function GridNaz_ClientEdit(sender, record) {
            //           alert("GridNaz_ClientEdit");
            var AmbNazIdn = record.NAZIDN;
            var AmbNazTyp = document.getElementById('HidAmbCrdTyp').value;

            NazWindow.setTitle(AmbNazIdn);
            if (AmbNazTyp == "СТЦ") NazWindow.setUrl("DocAppAmbNazOneStz.aspx?AmbNazIdn=" + AmbNazIdn);
            else NazWindow.setUrl("DocAppAmbNazOne.aspx?AmbNazIdn=" + AmbNazIdn);
       //     NazWindow.setUrl("DocAppAmbNazOne.aspx?AmbNazIdn=" + AmbNazIdn);
            NazWindow.Open();

            return false;
        }

        function GridNaz_ClientInsert(sender, record) {
  //                    alert("GridNaz_ClientInsert");
            var AmbNazIdn = 0;
            var AmbNazTyp = document.getElementById('HidAmbCrdTyp').value;
  //          alert("AmbNazTyp=" + AmbNazTyp);

            NazWindow.setTitle(AmbNazIdn);
            if (AmbNazTyp == "СТЦ") NazWindow.setUrl("DocAppAmbNazOneStz.aspx?AmbNazIdn=" + AmbNazIdn);
            else NazWindow.setUrl("DocAppAmbNazOne.aspx?AmbNazIdn=" + AmbNazIdn);
   //         NazWindow.setUrl("DocAppAmbNazOne.aspx?AmbNazIdn=" + AmbNazIdn);
            NazWindow.Open();

            return false;
        }

        function WindowClose() {
  //          alert("GridNazClose");
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);
        //  __doPostBack('btnSave', e.innerHTML);
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtNazButton_Click() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbNaz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbNaz&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtRzpButtonPrz_Click() {
   //         alert("PrtRzpButton=");
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn +"&TekDocKod=1", "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn +"&TekDocKod=1", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function PrtRzpButtonStz_Click() {
            //         alert("PrtRzpButton=");
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn +"&TekDocKod=2", "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn +"&TekDocKod=2", "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function SablonNaz() {
            //      alert('SblTyp=' + SblTyp);
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            window.open("DocAppSblNaz.aspx?AmbCrdIdn=" + AmbCrdIdn,"ModalPopUp", "toolbar=no,width=900,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
        }

        function GridNaz_sbl(rowIndex) {
            //           alert("GridUsl_rsx=");
            var AmbNazIdn = GridNaz.Rows[rowIndex].Cells[0].Value;
      //      alert("AmbNazIdn="+AmbNazIdn);
      //      alert("document.getElementById('parBuxKod').value="+document.getElementById('parBuxKod').value);
        
            $.ajax({
                type: 'POST',
                url: 'DocAppAmbNaz.aspx/ZapSablon',
                data: '{"AmbNazIdn":"' + AmbNazIdn + '", "BuxKod":"' + document.getElementById('parBuxKod').value + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {  },
                error: function() {alert("Ошибка!");}
            });
        }

        //    ------------------------------------------------------------------------------------------------------------------------

        //    ------------------------------------------------------------------------------------------------------------------------

        function onChange(sender, newText) {
            //            alert("onChangeJlb=" + sender.ID);
            var GrfDocRek;
            var GrfDocVal = newText;
            var GrfDocTyp = 'Txt';

            switch (sender.ID) {
                case 'TxtRej':
                    GrfDocRek = 'DOCREJ';
                    break;
                case 'TxtStl':
                    GrfDocRek = 'DOCSTL'
                    break;
                case 'TxtUslGde':
                    GrfDocRek = 'DOCUSLGDE'
                    break;
                default:
                    break;
            }

            onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp);
        }


        //    ------------------------------------------------------------------------------------------------------------------------

        function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp) {

            var DatDocMdb = 'HOSPBASE';
            var DatDocTab = 'AMBDOC';
            var DatDocKey = 'DOCAMB';
            var DatDocRek = GrfDocRek;
            var DatDocVal = GrfDocVal;
            var DatDocTyp = GrfDocTyp;
            var DatDocIdn;

            var QueryString = getQueryString();
            DatDocIdn = QueryString[1];

            //           alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
            DatDocTyp = 'Sql';
            SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;

        //    alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });

        }


    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string AmbCrdTyp = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int NazIdn;
    int NazAmb;
    int NazNum;
    int NazBln;
    string NazObs;
    int NazTab;
    int NazKrt;
    string NazDat;
    int NazDni;
    bool NazFlg;
    
    int NazEdn;
    decimal NazDoz;
    
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbCrdTyp = Convert.ToString(Request.QueryString["AmbCrdTyp"]);
        //=====================================================================================

 //       GridNaz.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNaz.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
 //       GridNaz.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================
        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals("")) Session["AmbNazIdn"] = "Post";
        if (!Page.IsPostBack)
        {

        }

        getDocNum();
        getGrid();
        
        HidAmbCrdIdn.Value = AmbCrdIdn;
        HidAmbCrdTyp.Value = AmbCrdTyp;


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
        SqlCommand cmd = new SqlCommand("HspAmbNazIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbNazIdn");

        con.Close();

        GridNaz.DataSource = ds;
        GridNaz.DataBind();

    }

          // ============================ чтение заголовка таблицы а оп ==============================================
      void getDocNum()
      {
          string TekDat;
          //------------       чтение уровней дерево
          DataSet ds = new DataSet();
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("HspAmbDocIdn", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "HspAmbDocIdn");

          con.Close();

          if (ds.Tables[0].Rows.Count > 0)
          {

              //     obout:ComboBox ------------------------------------------------------------------------------------ 
              TxtRej.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCREJ"]);
              TxtStl.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCSTL"]);
              TxtUslGde.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCUSLGDE"]);
            /*
              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCREJ"].ToString())) BoxRej.SelectedIndex = 0;
              else BoxRej.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCREJ"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCSTL"].ToString())) BoxStl.SelectedIndex = 0;
              else BoxStl.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCSTL"]);

              if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["DOCUSLGDE"].ToString())) BoxUslGde.SelectedIndex = 0;
              else BoxUslGde.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DOCUSLGDE"]);
              */
          }
      }

    // ======================================================================================

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        NazIdn = Convert.ToInt32(e.Record["NAZIDN"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbNazDel", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@NAZIDN", SqlDbType.Int, 4).Value = NazIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    // =================================================================================================================================================
    
    [WebMethod]
    public static string ZapSablon(string AmbNazIdn, string BuxKod)
    {

        if (!string.IsNullOrEmpty(AmbNazIdn))
        {
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();

            SqlCommand cmd = new SqlCommand("HspAmbSblNazAmbSbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@NAZIDN", SqlDbType.VarChar).Value = AmbNazIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        else
        {
            //          Otvet.Text = "Неверный пароль или входное имя";
            return "ERR";
        }
    }
/*
    protected void PrtNazButton_Click(object sender, EventArgs e)
    {
        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbNaz&TekDocIdn=" + AmbCrdIdn);
    }

    protected void PrtRzpButton_Click(object sender, EventArgs e)
    {
        string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
        int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
        // --------------  печать ----------------------------
        Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbRzp&TekDocIdn=" + AmbCrdIdn);
    }
 */   
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <asp:HiddenField ID="HidAmbCrdTyp" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАЗНАЧЕНИЯ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

         <table border="1" cellspacing="0" width="100%" cellpadding="0" style="background-color: ButtonFace" >
 <!--  Нозология ----------------------------------------------------------------------------------------------------------  -->    
            <tr> 
               <td width="100%" style="vertical-align: central;" >
                   <asp:Label id="LblRej" Text="Режим:" runat="server"  Width="10%" Font-Bold="true" />                             
                   <obout:OboutTextBox runat="server" ID="TxtRej"  width="20%" BackColor="White" Height="30px"
                          TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                  <ClientSideEvents OnTextChanged="onChange" />
		           </obout:OboutTextBox>
                                 
                   <asp:Label id="LblStl" Text="Стол:" runat="server"  Width="10%" Font-Bold="true" />                             
                   <obout:OboutTextBox runat="server" ID="TxtStl"  width="20%" BackColor="White" Height="30px"
                         TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                 <ClientSideEvents OnTextChanged="onChange" />
		           </obout:OboutTextBox>
                   
                   <asp:Label id="LblVid" Text="В условиях:" runat="server"  Width="10%" Font-Bold="true" />                             
                   <obout:OboutTextBox runat="server" ID="TxtUslGde"  width="20%" BackColor="White" Height="30px"
                          TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                  <ClientSideEvents OnTextChanged="onChange" />
		           </obout:OboutTextBox>
                </td>
            </tr>
       </table>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 350px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridNaz" runat="server"
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
                <ClientSideEvents 
		               OnBeforeClientEdit="GridNaz_ClientEdit" 
		               OnBeforeClientAdd="GridNaz_ClientInsert"
		               ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="NAZIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="NAZDAT" HeaderText="Дата" DataFormatString="{0:dd.MM.yy}" Width="5%" />
                    <obout:Column ID="Column02" DataField="NAZNUMBLN" HeaderText="№ РЕЦ" Width="5%" Align="right" />
                    <obout:Column ID="Column03" DataField="NAZBLNNAM" HeaderText="БЛАНК" Width="5%" Align="right" />
                    <obout:Column ID="Column04" DataField="NAZPLNOBS" HeaderText="НАЗНАЧЕНИЯ" Width="20%" />
                    <obout:Column ID="Column05" DataField="PRMNAM" HeaderText="ПРИМЕНЕН." Width="12%" />

                    <obout:Column ID="Column06" DataField="EDNLEKNAM" HeaderText="ЕД.ИЗМ" Width="5%" />
                    <obout:Column ID="Column07" DataField="NAZKOLTAB" HeaderText="КОЛ" Width="5%" DataFormatString="{0:F2}" />

                    <obout:Column ID="Column08" DataField="KRTNAM" HeaderText="КРАТНОСТЬ" Width="8%" />

                    <obout:Column ID="Column10" DataField="NAZDATNAZ" HeaderText="НАЧАЛО" DataFormatString="{0:dd.MM.yy}" Width="5%" />

                    <obout:Column ID="Column11" DataField="NAZDNI" HeaderText="ДНИ" Width="5%" />
                    <obout:Column ID="Column12" DataField="NAZPRZ" HeaderText="ПРОЦ." Width="5%" />
                    <obout:Column ID="Column13" DataField="NAZOTM" HeaderText="ОТМЕНА" Width="5%" />
                    <obout:Column ID="Column14" HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	             
                   
                    <obout:Column ID="Column15" DataField="SBLFLG" HeaderText="ШАБЛОН" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateSbl" />
				    </obout:Column>		

                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />

                <Templates>
       			<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridNaz.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridNaz.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridNaz.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridNaz.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridNaz.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridNaz.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridNaz.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	

                   <obout:GridTemplate runat="server" ID="TemplateSbl">
                       <Template>
                          <input type="button" id="btnSbl" class="tdTextSmall" value="->Шаблон" onclick="GridNaz_sbl(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
            <center>
                 <input type="button" value="Печать назначения"   onclick="PrtNazButton_Click()" />
                 <input type="button" value="Печать рецепта в Проц.кабинет"   onclick="PrtRzpButtonPrz_Click()" />
                 <input type="button" value="Печать рецепта в Днев.стац"   onclick="PrtRzpButtonStz_Click()" />
                 <input type="button" value="Шаблон назначений"   onclick="SablonNaz()" />
            </center>
        </asp:Panel>


          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="NazWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="10" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Назначения">

       </owd:Window>

    </form>

    <%-- ============================  STYLES ============================================ --%>

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


7
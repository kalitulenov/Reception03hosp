<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
      <style type="text/css">
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
     /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Arial;
            font-size: 12px;
        }
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
	        font-size: 12px;
         }

       /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
    </style>

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridKdr.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            //           alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        function OnBeforeDelete(sender, record) {
            if (myconfirm == 1) {
                return true;
            }
            else {
                document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                myConfirmBeforeDelete.Open();
                return false;
            }
        }
        
        function findIndex(record) {
             var index = -1;
             for (var i = 0; i < GridKdr.Rows.length; i++) {
                 if (GridKdr.Rows[i].Cells[0].Value == record.KDRKOD) {
                    index = i;
       //            alert('index: ' + index);
                      break;
                    }
                }
            return index;
        }

        function PrtButton_Click() {
            var GrfFrm = document.getElementById('MainContent_parBuxFrm').value;

            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspSprKdr&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspSprKdr&TekDocFrm=" + GrfFrm,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        // --------------------- РАСХОД МАТЕРИАЛОВ ПО ЭТОЙ УСЛУГЕ
        function GridKdr_krt(rowIndex) {
            //                  alert("GridPrz_rsx=");
            
            var KdrKod = GridKdr.Rows[rowIndex].Cells[0].Value;

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Spravki/SprKdrOne.aspx?KdrKod=" + KdrKod,
                    "ModalPopUp", "toolbar=no,width=1100,height=650,left=100,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Spravki/SprKdrOne.aspx?KdrKod=" + KdrKod,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:100px;dialogtop:100px;dialogWidth:1100px;dialogHeight:650px;");

            return true;
          
        }

    </script>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        string TxtSpr;

        string BuxFrm;
        string BuxSid;

        int KdrIdn;
        int KdrKod;
        string KdrKodTxt;
        string KdrFam;
        string KdrIma;
        string KdrOtc;
        Boolean KdrSex;
        string KdrIIN;
        string KdrThn;
        string KdrEml;
        string KdrAdr;
        string KdrWeb;
        string KdrDnn;
        string KdrDdt;
        string KdrDpl;
        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxSid = (string)Session["BuxSid"];
            parBuxFrm.Value = BuxFrm;

             //============= локолизация для календаря  ===========================================================================================
  
          //   NumSpr = (string)Request.QueryString["NumSpr"];
            //         if (Session["KDRKODSES"] == null) Session.Add("KDRKODSES", (string)"0");

            TxtSpr = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtSpr;

            GridKdr.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridKdr.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridKdr.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            getGrid();

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
            SqlCommand cmd = new SqlCommand("SELECT * FROM KDR WHERE KDRFRM=" + BuxFrm + " ORDER BY KDRFAM", con);
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "ComSprKdr");
            GridKdr.DataSource = ds;
            GridKdr.DataBind();
       
            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();
        }
        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            string KdrBrtTxt;
            string KdrKodSup;

            //      KdrKod = Convert.ToInt32(e.Record["KDRKOD"]);
            KdrFam = Convert.ToString(e.Record["KDRFAM"]);
            KdrIma = Convert.ToString(e.Record["KDRIMA"]);
            KdrOtc = Convert.ToString(e.Record["KDROTC"]);

            KdrBrtTxt = Convert.ToString(e.Record["KDRBRT"]);
            if (string.IsNullOrEmpty(KdrBrtTxt))
            { KdrBrtTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { KdrBrtTxt = Convert.ToDateTime(e.Record["KDRBRT"]).ToString("dd.MM.yyyy"); }
            //            KdrBrt = Convert.ToDateTime(e.Record["KDRBRT"]);
            KdrIIN = Convert.ToString(e.Record["KDRIIN"]);
            KdrKodSup = Convert.ToString(e.Record["KDRKODSUP"]);
//            KdrEml = Convert.ToString(e.Record["KDREML"]);
            KdrThn = Convert.ToString(e.Record["KDRTHN"]);
//            KdrWeb = Convert.ToString(e.Record["KDRWEB"]);
            KdrSex = Convert.ToBoolean(e.Record["KDRSEX"]);
//            if ((string)e.Record["KDRSEX"] == "0") KdrSex = false;
//            else KdrSex = true;

            KdrDnn = Convert.ToString(e.Record["KDRDNN"]);
            KdrDpl = Convert.ToString(e.Record["KDRDPL"]);
            KdrDdt = Convert.ToString(e.Record["KDRDDT"]);
            if (string.IsNullOrEmpty(KdrDdt))
            { KdrDdt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { KdrDdt = Convert.ToDateTime(e.Record["KDRDDT"]).ToString("dd.MM.yyyy"); }

//            localhost.Service1Soap ws = new localhost.Service1SoapClient();
//            ws.ComSprKdrAdd(MdbNam, BuxSid, BuxFrm, KdrFam, KdrIma, KdrOtc, KdrBrtTxt, KdrSex, KdrIIN, KdrDnn, KdrDdt, KdrThn, KdrDpl);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprKdrAdd", con);
            cmd = new SqlCommand("BuxSprKdrAdd", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KDRFAM", SqlDbType.NVarChar).Value = KdrFam;
            cmd.Parameters.Add("@KDRIMA", SqlDbType.NVarChar).Value = KdrIma;
            cmd.Parameters.Add("@KDROTC", SqlDbType.NVarChar).Value = KdrOtc;
            cmd.Parameters.Add("@KDRBRT", SqlDbType.VarChar).Value = KdrBrtTxt;
            cmd.Parameters.Add("@KDRSEX", SqlDbType.Bit, 1).Value = KdrSex;
            cmd.Parameters.Add("@KDRIIN", SqlDbType.VarChar).Value = KdrIIN;
            cmd.Parameters.Add("@KDRTHN", SqlDbType.VarChar).Value = KdrThn;
            cmd.Parameters.Add("@KDRDNN", SqlDbType.VarChar).Value = KdrDnn;
            cmd.Parameters.Add("@KDRDDT", SqlDbType.VarChar).Value = KdrDdt;
            cmd.Parameters.Add("@KDRDPL", SqlDbType.VarChar).Value = KdrDpl;
            cmd.Parameters.Add("@KDRKODSUP", SqlDbType.VarChar).Value = KdrKodSup;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------

            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            string KdrBrtTxt;
            string KdrKodSup;

            KdrIdn = Convert.ToInt32(e.Record["KDRIDN"]);
            KdrKod = Convert.ToInt32(e.Record["KDRKOD"]);
            KdrFam = Convert.ToString(e.Record["KDRFAM"]);
            KdrIma = Convert.ToString(e.Record["KDRIMA"]);
            KdrOtc = Convert.ToString(e.Record["KDROTC"]);

            KdrBrtTxt = Convert.ToString(e.Record["KDRBRT"]);
            if (string.IsNullOrEmpty(KdrBrtTxt))
            { KdrBrtTxt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { KdrBrtTxt = Convert.ToDateTime(e.Record["KDRBRT"]).ToString("dd.MM.yyyy"); }
            //            KdrBrt = Convert.ToDateTime(e.Record["KDRBRT"]);
            KdrIIN = Convert.ToString(e.Record["KDRIIN"]);
            KdrKodSup = Convert.ToString(e.Record["KDRKODSUP"]);
            //            KdrEml = Convert.ToString(e.Record["KDREML"]);
            KdrThn = Convert.ToString(e.Record["KDRTHN"]);
            //            KdrWeb = Convert.ToString(e.Record["KDRWEB"]);
            KdrSex = Convert.ToBoolean(e.Record["KDRSEX"]);
//            if ((string)e.Record["KDRSEX"] == "0") KdrSex = false;
//            else KdrSex = true;

            KdrDnn = Convert.ToString(e.Record["KDRDNN"]);
            KdrDpl = Convert.ToString(e.Record["KDRDPL"]);
            KdrDdt = Convert.ToString(e.Record["KDRDDT"]);
            if (string.IsNullOrEmpty(KdrDdt))
            { KdrDdt = DateTime.Now.ToString("dd.MM.yyyy"); }
            else
            { KdrDdt = Convert.ToDateTime(e.Record["KDRDDT"]).ToString("dd.MM.yyyy"); }

 //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
 //           ws.ComSprKdrRep(MdbNam, BuxSid, KdrKod, KdrFam, KdrIma, KdrOtc, KdrBrtTxt, KdrSex, KdrIIN, KdrAdr, KdrEml, KdrThn, KdrWeb);
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxSprKdrRep", con);
            cmd = new SqlCommand("BuxSprKdrRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@KDRKOD", SqlDbType.VarChar).Value = KdrKod;
            cmd.Parameters.Add("@KDRFAM", SqlDbType.NVarChar).Value = KdrFam;
            cmd.Parameters.Add("@KDRIMA", SqlDbType.NVarChar).Value = KdrIma;
            cmd.Parameters.Add("@KDROTC", SqlDbType.NVarChar).Value = KdrOtc;
            cmd.Parameters.Add("@KDRBRT", SqlDbType.VarChar).Value = KdrBrtTxt;
            cmd.Parameters.Add("@KDRSEX", SqlDbType.Bit, 1).Value = KdrSex;
            cmd.Parameters.Add("@KDRIIN", SqlDbType.VarChar).Value = KdrIIN;
            cmd.Parameters.Add("@KDRTHN", SqlDbType.VarChar).Value = KdrThn;
            cmd.Parameters.Add("@KDRDNN", SqlDbType.VarChar).Value = KdrDnn;
            cmd.Parameters.Add("@KDRDDT", SqlDbType.VarChar).Value = KdrDdt.Substring(0,10);
            cmd.Parameters.Add("@KDRDPL", SqlDbType.VarChar).Value = KdrDpl;
            cmd.Parameters.Add("@KDRKODSUP", SqlDbType.VarChar).Value = KdrKodSup;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------
            getGrid();
        }
       
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            KdrKod = Convert.ToInt32(e.Record["KDRKOD"]);
            Reception03hosp45.localhost.Service1Soap ws = new Reception03hosp45.localhost.Service1SoapClient();
            ws.ComSprKdrDel(MdbNam, BuxSid, KdrKod);
            getGrid();
        }
    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="KDRKOD" />
     <asp:HiddenField ID="parBuxFrm" runat="server" />
     
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
                                <input type="button" value="Назад" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
       
     
<!--  конец -----------------------------------------------  -->  
            <table border="0" cellspacing="0" width="100%">
            <tr>
                <td width="10%" class="PO_RowCap">  </td>
                <td width="70%" class="PO_RowCap">
        <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

                </td>
                <td width="10%" class="PO_RowCap">
                           <input type="button" name="PrtButton" style="width: 100%; height:28px;" value="Печать справочника" id="PrtButton" onclick="PrtButton_Click();" />
                </td>
                <td width="10%" class="PO_RowCap">  </td>
            </tr>

        </table>

        <div id="div_kdr" style="position:relative;left:10%; width:80%; " >
            <obout:Grid ID="GridKdr" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                AllowRecordSelection="false"
                AllowColumnResizing="true"
                AllowSorting="true"
                AllowPaging="false"
                EnableTypeValidation="false"
                AllowPageSizeSelection="false"
                Width="100%"
                PageSize="-1"
                AllowAddingRecords="true"
                AllowFiltering="true"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="450" />
                <ClientSideEvents
                    OnBeforeClientDelete="OnBeforeDelete"
                    ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column00" DataField="KDRKOD" HeaderText="Код" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column01" DataField="KDRFAM" HeaderText="ФАМИЛИЯ" Width="11%" />
                    <obout:Column ID="Column02" DataField="KDRIMA" HeaderText="ИМЯ" Width="7%" />
                    <obout:Column ID="Column03" DataField="KDROTC" HeaderText="ОТЧЕСТВО" Width="13%" />
                    <obout:Column ID="Column04" DataField="KDRSEX" HeaderText="Пол" Width="3%">
                        <TemplateSettings TemplateId="TemplateSex" EditTemplateId="TemplateEditSex" />
                    </obout:Column>
                    <obout:Column ID="Column05" DataField="KDRIIN" HeaderText="ИИН" Width="10%" />
                    <obout:Column ID="Column06" DataField="KDRDNN" HeaderText="№ УДОСТВ." Width="8%" />
                    <obout:Column ID="Column07" DataField="KDRDDT" HeaderText="ДАТА ВЫД." DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="8%">
                        <TemplateSettings EditTemplateId="tplDatePicker" />
                    </obout:Column>
                    <obout:Column ID="Column08" DataField="KDRDPL" HeaderText="КЕМ ВЫД." Width="6%" />
                    <obout:Column ID="Column09" DataField="KDRTHN" HeaderText="ТЕЛЕФОН" Width="11%" />
                    <obout:Column ID="Column10" DataField="KDRKODSUP" HeaderText="Supreme" Width="5%" />

                    <obout:Column HeaderText="ИЗМ УДЛ" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>

                    <obout:Column ID="Column15" DataField="KDRFLG" HeaderText="КАРТА" Width="5%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplateKrt" />
                    </obout:Column>

                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridKdr.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridKdr.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сох" class="tdTextSmall" onclick="GridKdr.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridKdr.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridKdr.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridKdr.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridKdr.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateKrt">
                        <Template>
                            <input type="button" id="btnKrt" class="tdTextSmall" value="Карта" onclick="GridKdr_krt(<%# Container.PageRecordIndex %>)" />
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
                                    <td valign="bottom" width="30">
                                        <obout:Calendar ID="calBeg" runat="server"
                                            StyleFolder="~/Styles/Calendar/styles/default"
                                            DatePickerMode="true"
                                            DateMin="01.01.2000"
                                            ShowYearSelector="true"
                                            YearSelectorType="DropDownList"
                                            TitleText="Выберите год: "
                                            TextBoxId="txtOrderDate"
                                            CultureName="ru-RU"
                                            DatePickerImagePath="~/Styles/Calendar/styles/icon2.gif" />
                                    </td>
                                </tr>
                            </table>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateSex" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "М" : "Ж") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditSex" ControlID="chkSex" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkSex" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>

            </obout:Grid>

        </div>
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>
</asp:Content>

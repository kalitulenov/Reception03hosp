<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#DatBrt').mask('D9.M9.Y999');
            $('#TxtDokDat').mask('D9.M9.Y999');
        };
        /*------------------------- Изиять переданный параметр --------------------------------*/
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

        /*------------------------- Изиять переданный параметр --------------------------------*/

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KdrKod;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    int NgrIdn;
    string NgrDat;
    string NgrNam;
    string NgrMem;

    int ItgSum = 0;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        KdrKod = Convert.ToString(Request.QueryString["KdrKod"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        GridKdr.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridKdr.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridKdr.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        if (!Page.IsPostBack)
        {
            GetGrid();
         }
   //     OboutInc.Calendar2.Calendar orderDateCalendar = GridKdr.Templates[0].Container.FindControl("calBeg") as OboutInc.Calendar2.Calendar;
   //     OboutTextBox txtOrderDate = GridKdr.Templates[0].Container.FindControl("txtOrderDate") as OboutTextBox;
   //     orderDateCalendar.TextBoxId = txtOrderDate.ClientID;

    }


    // ============================ чтение заголовка таблицы а оп ==============================================

    void GetGrid()
    {
        DataSet ds = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT KDRNGR.* FROM KDR INNER JOIN KDRNGR ON KDR.KDRKOD=KDRNGR.NGRKOD WHERE KDRKOD=" + KdrKod, con);
        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "KdrOne");
        GridKdr.DataSource = ds;
        GridKdr.DataBind();

        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }

        // ======================================================================================

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
         //   NgrIdn = Convert.ToInt32(e.Record["NGRIDN"]);
            NgrDat = Convert.ToString(e.Record["NGRDAT"]);
            NgrNam = Convert.ToString(e.Record["NGRNAM"]);
            NgrMem = Convert.ToString(e.Record["NGRMEM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO KDRNGR (NGRKOD,NGRDAT,NGRNAM,NGRMEM) VALUES (@NGRKOD,CONVERT(DATETIME,@NGRDAT,103),@NGRNAM,@NGRMEM)", con);
         //   cmd = new SqlCommand("BuxSprKdrAdd", con);
            // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@NGRKOD", SqlDbType.VarChar).Value = KdrKod;
            cmd.Parameters.Add("@NGRDAT", SqlDbType.VarChar).Value = NgrDat;
            cmd.Parameters.Add("@NGRNAM", SqlDbType.VarChar).Value = NgrNam;
            cmd.Parameters.Add("@NGRMEM", SqlDbType.VarChar).Value = NgrMem;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------

            GetGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            NgrIdn = Convert.ToInt32(e.Record["NGRIDN"]);
            NgrDat = Convert.ToString(e.Record["NGRDAT"]);
            NgrNam = Convert.ToString(e.Record["NGRNAM"]);
            NgrMem = Convert.ToString(e.Record["NGRMEM"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("UPDATE KDRNGR SET NGRDAT=CONVERT(DATETIME,@NGRDAT,103),NGRNAM=@NGRNAM,NGRMEM=@NGRMEM WHERE NGRIDN=@NGRIDN", con);
         //   cmd = new SqlCommand("BuxSprKdrAdd", con);
            // указать тип команды
      //      cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@NGRIDN", SqlDbType.VarChar).Value = NgrIdn;
            cmd.Parameters.Add("@NGRDAT", SqlDbType.VarChar).Value = NgrDat;
            cmd.Parameters.Add("@NGRNAM", SqlDbType.VarChar).Value = NgrNam;
            cmd.Parameters.Add("@NGRMEM", SqlDbType.VarChar).Value = NgrMem;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------

            GetGrid();
        }
       
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            NgrIdn = Convert.ToInt32(e.Record["NGRIDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM KDRNGR WHERE NGRIDN=@NGRIDN", con);
         //   cmd = new SqlCommand("BuxSprKdrAdd", con);
            // указать тип команды
        //    cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров

            cmd.Parameters.Add("@NGRIDN", SqlDbType.VarChar).Value = NgrIdn;
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ----------------------------------------

            GetGrid();
        }
    //------------------------------------------------------------------------
    // ============================ проверка и опрос для записи документа в базу ==============================================


</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekKdrIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 400px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

             <obout:Grid ID="GridKdr" runat="server"
                CallbackMode="false"
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
                <Columns>
                    <obout:Column ID="Column00" DataField="NGRIDN" HeaderText="ИДН" Width="0%" Visible="false" />
                    <obout:Column ID="Column01" DataField="NGRDAT" HeaderText="ДАТА" DataFormatString="{0:dd.MM.yyyy}" ApplyFormatInEditMode="true" Width="10%" />
                    <obout:Column ID="Column02" DataField="NGRNAM" HeaderText="НАГРАДА" Width="50%" />
                    <obout:Column ID="Column03" DataField="NGRMEM" HeaderText="ПРИМЕЧАНИЕ." Width="30%" />

                    <obout:Column HeaderText="ИЗМ УДЛ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>
                    
                    <obout:GridTemplate runat="server" ID="tplDatePicker" ControlID="txtOrderDate" ControlPropertyName="value">
                        <Template>
                            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                                <tr>
                                    <td valign="middle">
                                        <obout:OboutTextBox runat="server" ID="txtOrderDate" Width="100%"
                                            FolderStyle="/Styles/Grid/premiere_blue/interface/OboutTextBox" />
                                    </td>
                                    <td valign="bottom" width="30">
                                        <obout:Calendar ID="calBeg" runat="server"
                                            StyleFolder="/Styles/Calendar/styles/default"
                                            DatePickerMode="true"
                                            DateMin="01.01.2000"
                                            ShowYearSelector="true"
                                            YearSelectorType="DropDownList"
                                            TitleText="Выберите год: "
                                            TextBoxId="txtOrderDate"
                                            CultureName="ru-RU"
                                            DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                                    </td>
                                </tr>
                            </table>
                        </Template>
                    </obout:GridTemplate>

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


                </Templates>

            </obout:Grid>
              </asp:Panel>


<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>

    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        /*------------------------- для ЗАПИСЕЙ 1 ОТ 30  --------------------------------*/
        .ob_gFCont {
            font-size: 12px !important;
            color: #000000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
     
        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
           .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
               hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>


</body>

</html>



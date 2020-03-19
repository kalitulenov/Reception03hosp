<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

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
<%@ Import Namespace="System.IO" %>

<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         //    ---------------- обращение веб методу --------------------------------------------------------
         function MedDocPic(rowIndex) {
         //            alert("WebCam");
             var AmbAnlIdn = GridUsl.Rows[rowIndex].Cells[0].Value;
             //        alert("AmbAnlIdn =" + AmbAnlIdn);
             var AmbAnlPth = document.getElementById('MainContent_TextBoxFio').value;
             var AmbAnlIIN = document.getElementById('MainContent_TextBoxIIN').value;
           //          alert("AmbAnlPth =" + AmbAnlPth);

             AnlWindow.setTitle(AmbAnlPth);
             AnlWindow.setUrl("/WebCam/DocAppWebCam.aspx?AmbUslIdn=" + AmbAnlIdn + "&AmbUslPth=" + AmbAnlPth + "&AmbUslIIN=" + AmbAnlIIN);
             AnlWindow.Open();
             return false;

         }

         function WindowClose() {
             var jsVar = "callPostBack";
             __doPostBack('callPostBack', jsVar);
             //  __doPostBack('btnSave', e.innerHTML);
         }
         // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
         function HandlePopupResult(result) {
             //        alert("result of popup is: " + result);
             var jsVar = "dotnetcurry.com";
             __doPostBack('callPostBack', jsVar);


             //   document.getElementById('ctl00$MainContent$TextBoxFio').value = result;
             //   document.getElementById('MainContent_HidTextBoxFio').value = result;
         }
         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

         // --------------  ИЗМЕНИТЬ ДАТУ ПРИЕМА ----------------------------
         function onDateChange(sender, selectedDate) {
             //          alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             //             var GrfDocRek='GRFCTRDAT';
             //           alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //           alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
             //            alert("SqlStr=" + SqlStr);

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

    string UslNam;
    string UslMem;

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

        GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        //   sdsGrpUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // SELECT SttStrKey AS STTKEY, SttStrNam AS STTNAM FROM SprSttStr WHERE SttStrFrm=" + BuxFrm + " AND SttStrLvl = 1 ORDER BY SttStrNam";

        //    sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
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

            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
            HidAmbCrdIdn.Value = AmbCrdIdn;
            parBuxFrm.Value = BuxFrm;
        }

        getGrid();
        getDocNum();

    }


    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        string GrpUslKey;
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

        if (ds.Tables[0].Rows.Count > 0)
        {
            GridUsl.DataSource = ds;
            GridUsl.DataBind();
        }

        con.Close();
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
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        cmd.ExecuteNonQuery();

        con.Close();
    }

    // ============================ чтение заголовка таблицы а оп ==============================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["USLKOD"] == null | e.Record["USLKOD"] == "") UslKod = 0;
        else UslKod = Convert.ToInt32(e.Record["USLKOD"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 1;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLMEM"] == null | e.Record["USLMEM"] == "") UslMem = "";
        else UslMem = Convert.ToString(e.Record["USLMEM"]);

        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = "";
        else UslNap = Convert.ToString(e.Record["USLNAP"]);

        UslStx = "00000";
        UslKto =  Convert.ToInt32(BuxKod);

        UslGde = "";

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslAddGde", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLNAP", SqlDbType.VarChar).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = "00000";
        cmd.Parameters.Add("@USLKTO", SqlDbType.Int, 4).Value = UslKto;
        cmd.Parameters.Add("@USLGDE", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@USLMEM", SqlDbType.VarChar).Value = UslMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        if (e.Record["USLKOD"] == null | e.Record["USLKOD"] == "") UslKod = 0;
        else UslKod = Convert.ToInt32(e.Record["USLKOD"]);

        if (e.Record["USLKOL"] == null | e.Record["USLKOL"] == "") UslKol = 1;
        else UslKol = Convert.ToInt32(e.Record["USLKOL"]);

        if (e.Record["USLLGT"] == null | e.Record["USLLGT"] == "") UslLgt = 0;
        else UslLgt = Convert.ToInt32(e.Record["USLLGT"]);

        if (e.Record["USLMEM"] == null | e.Record["USLMEM"] == "") UslMem = "";
        else UslMem = Convert.ToString(e.Record["USLMEM"]);

        if (e.Record["USLNAP"] == null | e.Record["USLNAP"] == "") UslNap = "";
        else UslNap = Convert.ToString(e.Record["USLNAP"]);

        UslStx = "00000";
        UslKto =  Convert.ToInt32(BuxKod);

        UslGde = "";

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUslRepGde", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@USLIDN", SqlDbType.Int, 4).Value = UslIdn;
        cmd.Parameters.Add("@USLKOD", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLKOL", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLLGT", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters.Add("@USLNAP", SqlDbType.VarChar).Value = UslNap;
        cmd.Parameters.Add("@USLSTX", SqlDbType.VarChar).Value = "00000";
        cmd.Parameters.Add("@USLKTO", SqlDbType.Int, 4).Value = UslKto;
        cmd.Parameters.Add("@USLGDE", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@USLMEM", SqlDbType.VarChar).Value = UslMem;
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


    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        int KodOrg = 0;
        int KodCnt = 0;

        string KeyOrg;
        string KeyCnt;
        int LenCnt;
        string SqlCnt;


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbCrdIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbCrdIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
            TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["HURMIN"]).ToString("hh:mm");
            TextBoxKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
            TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["RABNAM"]);
            TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
            TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
            /* для просмотра IMAGE ============================================================================ */
            /* для просмотра IMAGE ============================================================================ */
            string path = @"C:\BASEPICKLT\"+ TextBoxIIN.Text+".jpg";
            // Проверить входной файл ----------------------------------------------------------------
            string[] files = Directory.GetFiles(@"C:\BASEPICKLT","*.jpg"); // список всех jpg файлов в директории C:\temp
            string Per = "No";
            // вывод первого списка файлов
            if (files.Length > 0)
            {
                for (int i = 0; i < files.Length; i++)
                {
                    if (path == files[i])
                    {
                        Per = "Yes";
                        break;
                    }
                }
            }
            if (Per == "Yes") TxtImg.ImageUrl = "DynamicImage.aspx?path=" + path;
            else TxtImg.ImageUrl = "~/DoctorFoto/NoFoto.jpg";
            //     TxtImg.Width = 250;
            //     TxtImg.Height = 250;
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
</script>



        <%-- ============================  для передач значении  ============================================ --%>
         <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />

        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />
          <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:3%; position: relative; top: 0px; width: 80%; height: 65px;">

       <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="27%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="80px" Height="20" RunAt="server" BackColor="#FFFFE0" />
			          <obout:Calendar ID="Calendar3" runat="server"
			 	                    	StyleFolder="/Styles/Calendar/styles/default" 
    	          					    DatePickerMode="true"
    	           					    ShowYearSelector="true"
                					    YearSelectorType="DropDownList"
    	           					    TitleText="Выберите год: "
    	           					    CultureName = "ru-RU"
                					    TextBoxId = "TextBoxDat"
                                        OnClientDateChanged="onDateChange"   
                					    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="27%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                  </td>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>
            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="TextBox1" 
             Text="СКАНИРОВАННЫЕ МЕДИЦИНСКИЕ ДОКУМЕНТЫ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

        </asp:Panel>     

        <%-- ============================  средний блок  ============================================ --%>
      <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 3%; position: relative; top: 0px; width: 80%; height: 550px;">

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
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column07" DataField="USLMEM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="82%" Align="left" />

                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="8%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>
                    
                    <obout:Column ID="Column15" DataField="USLFLG" HeaderText="ОБРАЗ" Width="10%" ReadOnly="true">
                        <TemplateSettings TemplateId="TemplatePic" />
                    </obout:Column>
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм." onclick="GridUsl.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл." onclick="GridUsl.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохр." class="tdTextSmall" onclick="GridUsl.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отм." class="tdTextSmall" onclick="GridUsl.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохр." class="tdTextSmall" onclick="GridUsl.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отм." class="tdTextSmall" onclick="GridUsl.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplatePic">
                        <Template>
                            <input type="button" id="btnRsx" class="tdTextSmall" value="Образ" onclick="MedDocPic(<%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>

        </asp:Panel>

        <div style="left: 84%; position: relative; top: -620px; width: 210px; height: 158px; border:double">
             <asp:Image ID="TxtImg" runat="server" ImageUrl="~/DoctorFoto/NoFoto.jpg"  
                        style="top:0px; left: 0px; width: 100%; height: 100%; margin-left: 0px" /> 
        </div> 

             <%--  style=" background-image: url(/Icon/webcam.png);" --%>
               
       <!--  -----------------------------------------------------------------------------------------------------------------------  -->
        <%-- ============================  шапка экрана ============================================ --%>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AnlWindow" runat="server"  Url="DocAppAmbAnlLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="300" Top="100" Height="400" Width="600" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsGrpUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

    </asp:Content>


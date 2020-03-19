<%@ Page Title="" Language="C#" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

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

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->
<%-- ============================  JAVA ============================================ --%>
      <script type="text/javascript">

          //      function GridDeb_ClientUpdate(sender, record) {
          //         alert("GridDeb_ClientUpdate");
          //         window.parent.GridKrd();       // вызов JAVASCRIPT  из другой программы
          //     }

          //    ------------------ смена логотипа ----------------------------------------------------------
          //    ------------------ смена логотипа ----------------------------------------------------------
          // -------изменение как EXCEL-------------------------------------------------------------------          
          function markAsFocused(textbox) {
              //                 alert("markAsFocused=");
              textbox.className = 'excel-textbox-focused';
          }

          /*------------------------- при нажатии на поле текст --------------------------------*/
          function markAsBlured(textbox, dataField, rowIndex) {
              //           alert("markAsBlured=");
              //  alert("textbox=" + textbox.value + " dataField=" + dataField + " rowIndex=" + rowIndex);
              //     alert("markAsBlured=" + textbox.value);
              if (textbox.value == "" || textbox.value == "0") return;

     //         alert("markAsBlured=" + document.getElementById('parTekAccKrd').value);
              if (document.getElementById('parTekAccKrd').value == "") {
                  alert("Не выбран счет");
                  return;

              }

              textbox.className = 'excel-textbox';

              //        GridDeb.Rows[rowIndex].Cells[dataField].Value = textbox.value;
              /*
              alert("parBuxSid=" + document.getElementById('parBuxSid').value);
              alert("parBuxFrm=" + document.getElementById('parBuxFrm').value);
              alert("parBuxKod=" + document.getElementById('parBuxKod').value);
              alert("parDocIdn=" + document.getElementById('parDocIdn').value);
              alert("MATKOD=" + GridDeb.Rows[rowIndex].Cells['MATKOD'].Value);
              alert("MATKOL=" + GridDeb.Rows[rowIndex].Cells['MATKOL'].Value);
              alert("MATZEN=" + GridDeb.Rows[rowIndex].Cells['MATZEN'].Value);
      */

              var ParStr = document.getElementById('parBuxSid').value + ':' + document.getElementById('parBuxFrm').value + ':' + document.getElementById('parBuxKod').value + ':' +
                            GridDeb.Rows[rowIndex].Cells['MATKOD'].Value + ':Спс:' + document.getElementById('parDocIdn').value + ':' +
                            GridDeb.Rows[rowIndex].Cells['MATZEN'].Value + ':' + GridDeb.Rows[rowIndex].Cells['MATKOL'].Value + ':' +
                            textbox.value + ':' + GridDeb.Rows[rowIndex].Cells['MATDEB'].Value + ':1:' +
                            GridDeb.Rows[rowIndex].Cells['MATMOL'].Value + ':' + document.getElementById('parTekAccKrd').value + ':1:0:';

       //       alert("ParStr=" + ParStr);

              //     id="MainContent_mySpl01_ctl01_ctl01_mySplKrd_ctl00_ctl01_BoxMolKrd_ob_CboBoxMolKrdTB"
              //     id="MainContent_mySpl01_ctl01_ctl01_mySplKrd_ctl00_ctl01_BoxAccKrd_ob_CboBoxAccKrdTB"
              //      alert("loadStx 3 =" + SndPar);
              //    id = "MainContent_mySpl01_ctl01_ctl01_mySplKrd_ctl00_ctl01_BoxMolKrd_ob_CboBoxMolKrdTB"
              //       PageMethods.UpdateDeb(ParStr);
              $.ajax({
                  type: 'POST',
                  url: '/HspUpdDoc.aspx/BuxUpdateDeb',
                  contentType: "application/json; charset=utf-8",
                  data: '{"ParStr":"' + ParStr + '"}',
                  dataType: "json",
                  success: function () { },
                  error: function () { }
              });


           //          alert("loadStx 4 =");
              window.parent.GridDeb();
              //        window.parent.GridKrd();

          }


</script>
</head>
    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

     <script runat="server">
        string GlvDocIdn;
        string GlvDocPrv;
        string GlvDocTyp;
        DateTime GlvDocDat;
        string MdbNam = "HOSPBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;

        string TekAccDeb;
        string TekMolDeb;
        string TekAccKrd;
        string TekMolKrd;

        decimal ItgDocSum = 0;
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            BuxFrm = (string)Session["BuxFrmKod"];
            GlvDocTyp = "Спс";

            //=====================================================================================
            GlvDocIdn = Convert.ToString(Request.QueryString["DocIdn"]);
            TekAccDeb = Convert.ToString(Request.QueryString["TekAccDeb"]);
            TekMolDeb = Convert.ToString(Request.QueryString["TekMolDeb"]);
            TekAccKrd = Convert.ToString(Request.QueryString["TekAccKrd"]);
            TekMolKrd = Convert.ToString(Request.QueryString["TekMolKrd"]);
            
            //============= начало  ===========================================================================================
            parBuxFrm.Value = BuxFrm;
            parBuxKod.Value = BuxKod;
            parBuxSid.Value = BuxSid;
            parDocIdn.Value = GlvDocIdn;
            parTekAccDeb.Value = TekAccDeb;
            parTekMolDeb.Value = TekMolDeb;
            parTekAccKrd.Value = TekAccKrd;
            parTekMolKrd.Value = TekMolKrd;
           
            //=====================================================================================

 //           GridDeb.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecordDeb);

            if (!Page.IsPostBack)
            {
            }
            // ---------------------------------------          корректировка только за тек день

            CreateGridDeb(TekAccDeb, TekMolDeb);
        }



        //------------------------------------------------------------------------

        protected void BoxDru_OnTextChanged(object sender, EventArgs e)
        {
            /*
            string MatNam = BoxDru.Text;
            //    string MatCty = Convert.ToString(Session["CTYKOD"]);

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("MatPoiSelMat", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@MATNAM", SqlDbType.VarChar).Value = MatNam;

            // создать коллекцию параметров
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "MatPoiSelMat");
            // ------------------------------------------------------------------------------заполняем второй уровень
            GridDeb.DataSource = ds;
            GridDeb.DataBind();

            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();

            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;

*/
        }

        //------------------------------------------------------------------------
        //------------------------------------------------------------------------
        public void CreateGridDeb(string TekAccDeb, string TekMolDeb)
        {

            int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

              // создание DataSet.
                        DataSet ds = new DataSet();
                        // строка соединение
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        // создание соединение Connection
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();

                        // создание команды
                        SqlCommand cmd = new SqlCommand("BuxPrmDocDebSel", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
                        cmd.Parameters.Add("@MATDEB", SqlDbType.VarChar).Value = TekAccDeb;
                        cmd.Parameters.Add("@MATMOL", SqlDbType.VarChar).Value = TekMolDeb;
                        cmd.Parameters.Add("@MATDOCIDN", SqlDbType.Int, 4).Value = TekDocIdn;
                        cmd.Parameters.Add("@MATPRXIDN", SqlDbType.Int, 4).Value = 0;

                        // создать коллекцию параметров
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "BuxPrmDocDebSel");
                        // ------------------------------------------------------------------------------заполняем второй уровень
                        GridDeb.DataSource = ds;
                        GridDeb.DataBind();
  
                        // -----------закрыть соединение --------------------------
                        ds.Dispose();
                        con.Close();

                 //       UpdatePanel("CallbackPanelDeb");
                //        UpdatePanel("CallbackPanelKrd");
           
 
            
        }
        //------------------------------------------------------------------------
        // ============================ чтение заголовка таблицы а оп ==============================================
/*
        [WebMethod]
        public static bool UpdateDeb(string ParStr)
        {
            //  List<string> SprUsl = new List<string>();

            string[] MasLst = ParStr.Split(':');


            if (!string.IsNullOrEmpty(ParStr))
            {

                // создание DataSet.
                DataSet ds = new DataSet();
                // строка соединение
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                // создание команды
                SqlCommand cmd = new SqlCommand("BuxPrmDocDebPay", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = MasLst[0];
                cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = MasLst[1];
                cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = MasLst[2];
                cmd.Parameters.Add("@MATKOD", SqlDbType.Int, 4).Value = MasLst[3];
                cmd.Parameters.Add("@MATDOCNUM", SqlDbType.VarChar).Value = MasLst[4];
                cmd.Parameters.Add("@MATDOCIDN", SqlDbType.Int, 4).Value = MasLst[5];
                cmd.Parameters.Add("@MATZEN", SqlDbType.Decimal).Value = MasLst[6];
                cmd.Parameters.Add("@MATKOL", SqlDbType.Decimal).Value = MasLst[7];
                cmd.Parameters.Add("@MATPAY", SqlDbType.Decimal).Value = MasLst[8];
                cmd.Parameters.Add("@MATDEB", SqlDbType.VarChar).Value = MasLst[9];
                cmd.Parameters.Add("@MATDEBSPR", SqlDbType.Int, 4).Value = MasLst[10];
                cmd.Parameters.Add("@MATDEBSPRVAL", SqlDbType.VarChar).Value = MasLst[11];
                cmd.Parameters.Add("@MATKRD", SqlDbType.VarChar).Value = MasLst[12];
                cmd.Parameters.Add("@MATKRDSPR", SqlDbType.Int, 4).Value = MasLst[13];
                cmd.Parameters.Add("@MATKRDSPRVAL", SqlDbType.VarChar).Value = MasLst[14];

                //           cmd.Parameters.Add("@MDVIDN", SqlDbType.Int, 4).Value = 0;
                //           cmd.Parameters["@MDVIDN"].Direction = ParameterDirection.Output;
                con.Open();
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                    //    MDVIDN = (int)cmd.Parameters["@MDVIDN"].Value;
                }
                finally
                {
                    con.Close();
                }

            }
            return true;
        }
*/


</script>


<body>
    <form id="form1" runat="server">   


<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="Pusto" id="Pusto" value="Pusto" runat="server"/>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>

  <asp:HiddenField ID="parBuxSid" runat="server" />
  <asp:HiddenField ID="parBuxFrm" runat="server" />
  <asp:HiddenField ID="parBuxKod" runat="server" />
  <asp:HiddenField ID="parDocIdn" runat="server" />
  <asp:HiddenField ID="parTekAccDeb" runat="server" />
  <asp:HiddenField ID="parTekMolDeb" runat="server" />
  <asp:HiddenField ID="parTekAccKrd" runat="server" />
  <asp:HiddenField ID="parTekMolKrd" runat="server" />
 <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
<%-- ============================  шапка экрана ============================================ --%>
<%-- ============================  верхний блок  ============================================ --%>
 
<%-- ============================  подшапка  ============================================ --%>
                        <obout:Grid ID="GridDeb" runat="server"
                            ShowFooter="false"
                            CallbackMode="true"
                            Serialize="true" 
                            FolderLocalization="~/Localization"
                            Language="ru"
                            AutoGenerateColumns="false"
                            FolderStyle="~/Styles/Grid/style_5"
                            ShowColumnsFooter="false"
                            KeepSelectedRecords="false"
                            AllowRecordSelection="false"
                            AllowAddingRecords="false"
                            AllowColumnResizing="true"
                            AllowSorting="true"
                            AllowPaging="false"
                            AllowPageSizeSelection="false"
                            Width="100%"
                            PageSize="-1">
                           <ScrollingSettings ScrollHeight="440" />
                            <Columns>
                                <obout:Column ID="Column1" DataField="MATKOD" HeaderText="Код" ReadOnly="true" Visible="false" Width="0%"/>
                                <obout:Column ID="Column2" DataField="MATMOL" HeaderText="МОЛ" ReadOnly="true" Visible="false" Width="0%" />
                                <obout:Column ID="Column3" DataField="MATDEB" HeaderText="Счет" ReadOnly="true" Width="10%" Align="left" />
                                <obout:Column ID="Column4" DataField="MATMOLFIO" HeaderText="МОЛ" ReadOnly="true" Width="10%" Align="left" />
                                <obout:Column ID="Column5" DataField="MATNAM" HeaderText="Материалы" ReadOnly="true" Width="40%" Align="left" />
                                <obout:Column ID="Column6" DataField="MATEDN" HeaderText="Ед.изм" ReadOnly="true" Width="10%"  Align="center"/>
                                <obout:Column ID="Column7" DataField="MATZEN" HeaderText="Цена" ReadOnly="true" Width="10%" Wrap="false" Align="right" DataFormatString="{0:F2}" />
                                <obout:Column ID="Column8" DataField="MATKOL" HeaderText="Кол-во" ReadOnly="true" Width="10%" Align="right" DataFormatString="{0:F2}"/>
                                <obout:Column ID="Column9" DataField="MATPAY" HeaderText="Списание" Width="10%" >
                                            <TemplateSettings TemplateId="TxtEditTemplate" />
                                </obout:Column>
                           </Columns>

                <Templates>

                    <obout:GridTemplate runat="server" ID="TxtEditTemplate">
                        <Template>
                            <input type="text" style="font-size: 14px" class="excel-textbox" value="<%# Container.Value %>" ondblclick="markAsDblClick(this, '<%# GridDeb.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)"
                                onfocus="markAsFocused(this)" onblur="markAsBlured(this, '<%# GridDeb.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>
                </Templates>

                        </obout:Grid>



<%-- =================  источник  для КАДРЫ ============================================ --%>
<%-- =================  источник  для КАДРЫ ============================================ --%>
      </form>
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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
            outline: 0;
            width: 100%;
            font-size: 12px !important;  // для увеличения коррект поля
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
    </style>
<%-- ============================  стили ============================================ --%>

    </body>
</html>

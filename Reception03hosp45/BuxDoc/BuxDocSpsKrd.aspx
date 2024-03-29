﻿<%@ Page Title="" Language="C#" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

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

          //      function GridKrd_ClientUpdate(sender, record) {
          //         alert("GridKrd_ClientUpdate");
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
              //              alert("textbox=" + textbox.value + " dataField=" + dataField + " rowIndex=" + rowIndex);
              textbox.className = 'excel-textbox';

              //        GridKrd.Rows[rowIndex].Cells[dataField].Value = textbox.value;
              /*
              alert("parBuxSid=" + document.getElementById('parBuxSid').value);
              alert("parBuxFrm=" + document.getElementById('parBuxFrm').value);
              alert("parBuxKod=" + document.getElementById('parBuxKod').value);
              alert("parDocIdn=" + document.getElementById('parDocIdn').value);
              alert("MATKOD=" + GridKrd.Rows[rowIndex].Cells['MATKOD'].Value);
              alert("MATKOL=" + GridKrd.Rows[rowIndex].Cells['MATKOL'].Value);
              alert("MATZEN=" + GridKrd.Rows[rowIndex].Cells['MATZEN'].Value);
              alert("MATPAY=" + GridKrd.Rows[rowIndex].Cells['MATPAY'].Value);
              */
              var ParStr = document.getElementById('parBuxSid').value + ':' + GridKrd.Rows[rowIndex].Cells['MATIDN'].Value + ':' +
                            document.getElementById('parDocIdn').value + ':' + textbox.value + ':';
        //      alert("loadStx 3 =" + ParStr);

              //       PageMethods.UpdateDeb(ParStr);
              $.ajax({
                  type: 'POST',
                  url: '/HspUpdDoc.aspx/BuxUpdateKrd',
                  contentType: "application/json; charset=utf-8",
                  data: '{"ParStr":"' + ParStr + '"}',
                  dataType: "json",
                  success: function () { },
                  error: function () { }
              });


              //        alert("loadStx 4 =");
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

        string TekAcc;
        string TekMol;

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
  //          GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            
            //============= начало  ===========================================================================================
            
            parBuxSid.Value = BuxSid;
            parDocIdn.Value = GlvDocIdn;

            if (!Page.IsPostBack)
            {
        //        getDocNum();

            }
            // ---------------------------------------          корректировка только за тек день

            CreateGridKrd();
        }

        // ============================ чтение заголовка таблицы а оп ==============================================


        //------------------------------------------------------------------------


        protected void CreateGridKrd()
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
            SqlCommand cmd = new SqlCommand("BuxPrmDocKrdSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
            cmd.Parameters.Add("@MATDOCNUM", SqlDbType.VarChar).Value = "Спс";
            cmd.Parameters.Add("@MATDOCIDN", SqlDbType.Int, 4).Value = TekDocIdn;

            // создать коллекцию параметров
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "BuxPrmDocKrdSel");
            // ------------------------------------------------------------------------------заполняем второй уровень
            GridKrd.DataSource = ds;
            GridKrd.DataBind();

            // -----------закрыть соединение --------------------------
            ds.Dispose();
            con.Close();

        }
        // ============================ проверка и опрос для записи документа в базу ==============================================

</script>


<body>
    <form id="form1" runat="server">   




<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="Pusto" id="Pusto" value="Pusto" runat="server"/>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>

  <asp:HiddenField ID="parBuxSid" runat="server" />
  <asp:HiddenField ID="parDocIdn" runat="server" />
  <asp:HiddenField ID="parMatIdn" runat="server" />
  <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
<%-- ============================  шапка экрана ============================================ --%>
<%-- ============================  верхний блок  ============================================ --%>
        <%-- ============================  для отображение розницы ============================================ --%>
 
                         <obout:Grid ID="GridKrd" runat="server"
                            ShowFooter="false"
                            CallbackMode="true"
                            Serialize="true" 
                            FolderLocalization="~/Localization"
                            Language="ru"
                            AutoGenerateColumns="false"
                            FolderStyle="~/Styles/Grid/style_5"
                            KeepSelectedRecords="false"
                            AllowRecordSelection="false"
                            AllowAddingRecords="false"
                            AllowColumnResizing="true"
                            AllowSorting="true"
                            AllowPaging="false"
                            AllowPageSizeSelection="false"
                            ShowColumnsFooter="true"
                            Width="100%"
                            PageSize="-1">
                            <ScrollingSettings ScrollHeight="440" />
                            <Columns>
                                <obout:Column ID="Column11" DataField="MATKOD" HeaderText="Код" ReadOnly="true" Visible="false" Width="0%"/>
                                <obout:Column ID="Column12" DataField="MATIDN" HeaderText="Идн" ReadOnly="true" Visible="false" Width="0%" />
                                <obout:Column ID="Column13" DataField="MATDEB" HeaderText="Счет" ReadOnly="true" Width="10%" Align="left" />
                                <obout:Column ID="Column14" DataField="MATMOLFIO" HeaderText="МОЛ" ReadOnly="true" Width="10%" Align="left" />
                                <obout:Column ID="Column15" DataField="MATNAM" HeaderText="Материалы" ReadOnly="true" Width="40%" Align="left" />
                                <obout:Column ID="Column16" DataField="MATEDN" HeaderText="Ед.изм" ReadOnly="true" Width="10%"  Align="center"/>
                                <obout:Column ID="Column17" DataField="MATZEN" HeaderText="Цена" ReadOnly="true" Width="10%" Wrap="false" Align="right" DataFormatString="{0:F2}" />
                                <obout:Column ID="Column18" DataField="MATKOL" HeaderText="Кол-во" Width="20%" Align="right" DataFormatString="{0:F2}" >
                                            <TemplateSettings TemplateId="TxtEditTemplate" />  
                               </obout:Column>
                   </Columns>
               <Templates>

                    <obout:GridTemplate runat="server" ID="TxtEditTemplate">
                        <Template>
                            <input type="text" style="font-size: 14px" class="excel-textbox" value="<%# Container.Value %>" ondblclick="markAsDblClick(this, '<%# GridKrd.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)"
                                onfocus="markAsFocused(this)" onblur="markAsBlured(this, '<%# GridKrd.Columns[Container.ColumnIndex].DataField %>', <%# Container.PageRecordIndex %>)" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>

                        </obout:Grid>        
            
 <%-- ============================  нижний блок  ============================================ --%>

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

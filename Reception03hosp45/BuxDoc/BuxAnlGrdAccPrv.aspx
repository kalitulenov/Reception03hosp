<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
 

    
<%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">

         var myconfirm = 0;
         // ==================================== поиск клиента по фильтрам  ============================================
         function onClick(rowIndex, cellIndex) {
             alert(rowIndex + ' = ' + cellIndex);

       //      if (cellIndex == 1) {
             PrvWindow.setTitle("Номер " + GridAcc.Rows[rowIndex].Cells[1].Value + " от " + GridAcc.Rows[rowIndex].Cells[2].Value);

                 var GlvPrvIdn = GridAcc.Rows[rowIndex].Cells[0].Value;
             //        alert('OnClientSelect1=');
                 var GlvDocTyp = GridAcc.Rows[rowIndex].Cells[11].Value;
             //        alert('OnClientSelect2=' + GlvDocTyp);
                 var GlvDocIdn = GridAcc.Rows[rowIndex].Cells[1].Value;
             //        alert('OnClientSelect3=');
                 var GlvDocDeb = GridAcc.Rows[rowIndex].Cells[2].Value;
             //        alert('OnClientSelect4=' + GlvDocDeb);
                 var GlvDocKrd = GridAcc.Rows[rowIndex].Cells[6].Value;
             //         alert('GlvPrvIdn=' + GlvPrvIdn); 

             //      if (GlvDocPrv == '+') GlvDocPrv = 'проведен';

                 switch (GlvDocTyp) {
                     case 'Кас':
                         if (GlvDocDeb == "1010") PrvWindow.setUrl("/BuxDoc/BuxDocPrvKasPrx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=1");
                         else PrvWindow.setUrl("/BuxDoc/BuxDocPrvKasRsx.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=1");
                         break;
                     case 'Прв':
                         PrvWindow.setUrl("/BuxDoc/BuxDocPrvOne.aspx?GlvPrvIdn=" + GlvPrvIdn + "&GlvPrvPrv=''");
                         break;
                 }
                 PrvWindow.Open();
      //       }
         }
         // =============================== опрос до удаления клиента  ============================================
         // ==================================== чистка поле поиска  ============================================
         
          // ==================================== записать данные клиента с отдельного окна  ============================================

 </script>
</head>
    
    
  <script runat="server">

      string BuxSid;
      string BuxFrm;
      string Html;
      string ComKltIdn = "";
      string ComParAcc = "";
      string ComBegDat = "";
      string ComEndDat = "";
      string ComAccSum = "";
      string ComDebKrd = "";

      string MdbNam = "HOSPBASE";
      //=============Установки===========================================================================================
      protected void Page_Load(object sender, EventArgs e)
      {
          //=====================================================================================
          BuxSid = (string)Session["BuxSid"];
          BuxFrm = (string)Session["BuxFrmKod"];
          ComParAcc = (string)Request.QueryString["AccKod"];
          ComBegDat = (string)Request.QueryString["BegDat"];
          ComEndDat = (string)Request.QueryString["EndDat"];
          ComAccSum = (string)Request.QueryString["AccSum"];
          ComDebKrd = (string)Request.QueryString["DebKrd"];

          TxtAcc.Text = ComParAcc;
          TxtSum.Text = ComAccSum;

          //=====================================================================================
          if (!Page.IsPostBack)
          {
          }

          LoadGrid();
      }

      // ======================================================================================
      protected void LoadGrid()
      {
          DataSet ds = new DataSet("Menu");
          //------------       чтение уровней дерево
          string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
          SqlConnection con = new SqlConnection(connectionString);
          con.Open();
          SqlCommand cmd = new SqlCommand("BuxGlvTreAccSelSum", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = ComParAcc;
          cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = ComBegDat;
          cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = ComEndDat;
          cmd.Parameters.Add("@PRVDEBKRD", SqlDbType.VarChar).Value = ComDebKrd;
          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "BuxGlvTreAccSelSum");
          con.Close();

          GridAcc.DataSource = ds;
          GridAcc.DataBind();

          Session.Add("KLTIDN", (string)"");
      }

      //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
      protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
      {
          e.Row.Cells[5].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
          e.Row.Cells[5].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal';";
          e.Row.Cells[5].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",5)");
      }
      //------------------------------------------------------------------------
  </script>   
    
    
<body>
    <form id="form1" runat="server">
        <div>
            <%-- ============================  для передач значении  ============================================ --%>
            <input type="hidden" name="hhh" id="par" />
            <input type="hidden" name="aaa" id="cntr" value="0" />
            <span id="WindowPositionHelper"></span>
            <%-- =================  окно для поиска клиента из базы  ============================================ --%>
            <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
            <owd:Window ID="PrvWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
                Left="220" Top="100" Height="430" Width="1000" Visible="true" VisibleOnLoad="false"
                StyleFolder="~/Styles/Window/wdstyles/blue"
                Title="ПРОВОДКА">
            </owd:Window>


            <!--  источники -----------------------------------------------------------  -->
            <div>
                <div style="position: relative; left: 0px; top: 0px; font-family: Verdana; font-size: 10pt; border-style: groove; border-width: 1px; border-color: Black; padding: 1px">

                    <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="19%">
                                <asp:TextBox ID="TxtAcc" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td width="81%">
                                <asp:TextBox ID="TxtSum" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                        </tr>
                    </table>
                </div>
                <obout:Grid ID="GridAcc" runat="server"
                    CallbackMode="true"
                    Serialize="false"
                    FolderStyle="~/Styles/Grid/style_11"
                    AutoGenerateColumns="false"
                    ShowTotalNumberOfPages="false"
                    FolderLocalization="~/Localization"
                    Language="ru"
                    AllowAddingRecords="false"
                    AllowFiltering="true"
                    ShowColumnsFooter="false"
                    AllowPaging="false"
                    EnableTypeValidation="false"
                    PageSize="-1"
                    Width="100%"
                    OnRowDataBound="OnRowDataBound_Handle"
                    AllowPageSizeSelection="false">
                    <ScrollingSettings ScrollHeight="450" />
                    <Columns>
                        <obout:Column ID="Column00" DataField="PRVIDN" HeaderText="ИДН" Width="0%" Visible="false" />
                        <obout:Column ID="Column01" DataField="PRVDOCIDN" HeaderText="ИДН" Width="0%" Visible="false" />
                        <obout:Column ID="Column02" DataField="PRVACC" HeaderText="СЧЕТ" ReadOnly="true" Width="7%" Align="left" />
                        <obout:Column ID="Column03" DataField="PRVNUM" HeaderText="№" ReadOnly="true" Align="right" Width="5%" />
                        <obout:Column ID="Column04" DataField="PRVDAT" HeaderText="ДАТА" ReadOnly="true" Align="right" Width="7%" DataFormatString="{0:dd/MM/yy}" />
                        <obout:Column ID="Column05" DataField="PRVSUM" HeaderText="СУММА" ReadOnly="true" Align="right" Width="12%" DataFormatString="{0:N}" />
                        <obout:Column ID="Column06" DataField="PRVCOR" HeaderText="СЧЕТ КОР" ReadOnly="true" Align="left" Width="7%" />
                        <obout:Column ID="Column07" DataField="PRVANLSPRTXT" HeaderText="ОТ КОГО,КОМУ" ReadOnly="true" Align="left" Width="20%" />
                        <obout:Column ID="Column08" DataField="SymNam" HeaderText="СПЕЦИФ." ReadOnly="true" Align="left" Width="14%" />
                        <obout:Column ID="Column09" DataField="PRVMEM" HeaderText="ПРИМЕЧАНИЕ" ReadOnly="true" Align="left" Width="21%" />
                        <obout:Column ID="Column10" DataField="FIO" HeaderText="БУХГАЛТЕР" ReadOnly="true" Align="left" Width="4%" />
                        <obout:Column ID="Column11" DataField="PRVDOCNAM" HeaderText="ДОК" ReadOnly="true" Align="left" Width="3%" />
                    </Columns>

                </obout:Grid>

            </div>
            <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
        </div>

        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
        <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

            .super-form {
                margin: 12px;
            }

            .ob_fC table td {
                white-space: normal !important;
            }

            .command-row .ob_fRwF {
                padding-left: 50px !important;
            }
        </style>
    </form>

</body>
</html>



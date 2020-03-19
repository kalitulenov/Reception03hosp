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

         // =============================== опрос до удаления клиента  ============================================
          // ==================================== записать данные клиента с отдельного окна  ============================================
         // ==================================== поиск клиента по фильтрам  ============================================
         function onClick(rowIndex, cellIndex) {
                    alert(rowIndex + ' = ' + cellIndex);
             var AmbLabIdn = GridAcc.Rows[rowIndex].Cells[0].Value;
                    alert("AmbLabIdn=" + AmbLabIdn);

             if (cellIndex == 1) {
                 AccWindow.setTitle(GridAcc.Rows[rowIndex].Cells[0].Value + " Дебет " + GridAcc.Rows[rowIndex].Cells[1].Value);
                 AccWindow.setUrl("BuxGlvGrdAccPrv.aspx?AccKod=" + GridAcc.Rows[rowIndex].Cells[0].Value +
                                  "&AccSpr=0" + 
                                  "&AccSprVal=0" + 
                                  "&AccSum=" + GridAcc.Rows[rowIndex].Cells[1].Value +
                                  "&DebKrd='D'" +
                                  "&BegDat=" + document.getElementById('parBeg').value +
                                  "&EndDat=" + document.getElementById('parEnd').value);
                 AccWindow.Open();
             }
             if (cellIndex == 2) {
                 AccWindow.setTitle(GridAcc.Rows[rowIndex].Cells[0].Value + " Кредит " + GridAcc.Rows[rowIndex].Cells[2].Value);
                 AccWindow.setUrl("BuxGlvGrdAccPrv.aspx?AccKod=" + GridAcc.Rows[rowIndex].Cells[0].Value +
                                  "&AccSpr=0" +
                                  "&AccSprVal=0" + 
                                  "&AccSum=" + GridAcc.Rows[rowIndex].Cells[2].Value +
                                  "&DebKrd='K'" +
                                  "&BegDat=" + document.getElementById('parBeg').value +
                                  "&EndDat=" + document.getElementById('parEnd').value);
                 AccWindow.Open();
             }
         }
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
      string ComDebSum = "";
      string ComKrdSum = "";

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
          ComDebSum = (string)Request.QueryString["DebSum"];
          ComKrdSum = (string)Request.QueryString["KrdSum"];

          TxtAcc.Text = ComParAcc;
          TxtDeb.Text = ComDebSum;
          TxtKrd.Text = ComKrdSum;

          parBeg.Value = ComBegDat;
          parEnd.Value = ComEndDat;

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
          SqlCommand cmd = new SqlCommand("BuxGlvTreAccSelOne", con);
          // указать тип команды
          cmd.CommandType = CommandType.StoredProcedure;
          // передать параметр
          cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
          cmd.Parameters.Add("@ACCKOD", SqlDbType.VarChar).Value = ComParAcc;
          cmd.Parameters.Add("@PRVBEGDAT", SqlDbType.VarChar).Value = ComBegDat;
          cmd.Parameters.Add("@PRVENDDAT", SqlDbType.VarChar).Value = ComEndDat;
          // создание DataAdapter
          SqlDataAdapter da = new SqlDataAdapter(cmd);
          // заполняем DataSet из хран.процедуры.
          da.Fill(ds, "BuxGlvTreAccSelOne");
          con.Close();

          GridAcc.DataSource = ds;
          GridAcc.DataBind();

          Session.Add("KLTIDN", (string)"");
      }

      //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
      protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
      {
          e.Row.Cells[1].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
          e.Row.Cells[1].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal';";
          e.Row.Cells[1].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",1)");

          e.Row.Cells[2].Attributes["onmouseover"] = "this.style.fontSize = '16px'; this.style.fontWeight = 'bold';";
          e.Row.Cells[2].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal';";
          e.Row.Cells[2].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",2)");
      }
      //------------------------------------------------------------------------
  </script>   
    
    
<body>
    <form id="form1" runat="server">
        <div>
            <%-- ============================  для передач значении  ============================================ --%>
            <input type="hidden" name="hhh" id="par" />
            <input type="hidden" name="aaa" id="cntr" value="0" />
            <asp:HiddenField ID="parBeg" runat="server" />
            <asp:HiddenField ID="parEnd" runat="server" />

            <span id="WindowPositionHelper"></span>
            <%-- =================  окно для поиска клиента из базы  ============================================ --%>
            <owd:Window ID="AccWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
                Left="10" Top="0" Height="550" Width="950" Visible="true" VisibleOnLoad="false"
                StyleFolder="~/Styles/Window/wdstyles/blue" Title="">
            </owd:Window>

            <!--  источники -----------------------------------------------------------  -->
            <div>
                <div style="position: relative; left: 0px; top: 0px; font-family: Verdana; font-size: 10pt; border-style: groove; border-width: 1px; border-color: Black; padding: 1px">

                    <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="20%"> 
                                <asp:TextBox ID="TxtAcc" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td width="20%">
                                <asp:TextBox ID="TxtDeb" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>

                            <td width="20%">
                                <asp:TextBox ID="TxtKrd" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: medium;" />
                            </td>
                            <td width="20%"></td>
                            <td width="20%"></td>

                        </tr>
                    </table>
                </div>
                <obout:Grid ID="GridAcc" runat="server"
                    CallbackMode="true"
                    Serialize="false"
                    FolderStyle="~/Styles/Grid/style_5"
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
                        <obout:Column ID="Column00" DataField="PRVACC" HeaderText="СЧЕТ" ReadOnly="true" Width="20%" Align="center" />
                        <obout:Column ID="Column03" DataField="DEBSUM" HeaderText="ДЕБЕТ" ReadOnly="true" Align="right" Width="20%" DataFormatString="{0:N}" />
                        <obout:Column ID="Column04" DataField="KRDSUM" HeaderText="КРЕДИТ" ReadOnly="true" Align="right" Width="20%" DataFormatString="{0:N}" />
                        <obout:Column ID="Column05" DataField="KRD001" HeaderText="..." ReadOnly="true" Align="right" Width="20%" DataFormatString="{0:N}" />
                        <obout:Column ID="Column06" DataField="KRD002" HeaderText="..." ReadOnly="true" Align="right" Width="20%" DataFormatString="{0:N}" />
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



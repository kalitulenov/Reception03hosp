<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BuxGlvGrd.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxGlvGrd" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

        // ==================================== поиск клиента по фильтрам  ============================================
        function onClick(rowIndex, cellIndex) {
    //        alert(rowIndex + ' = ' + cellIndex + ' ' + document.getElementById('parAcc').value);
            var AmbLabIdn = GridAcc.Rows[rowIndex].Cells[0].Value;
     //       alert("AmbLabIdn=" + AmbLabIdn);

            if (cellIndex == 0) {
                AccWindow.setTitle(GridAcc.Rows[rowIndex].Cells[0].Value + " Дебет " + GridAcc.Rows[rowIndex].Cells[3].Value + " Кредит " + GridAcc.Rows[rowIndex].Cells[4].Value);
                AccWindow.setUrl("BuxGlvGrdAcc.aspx?AccKod=" + GridAcc.Rows[rowIndex].Cells[0].Value +
                                 "&DebSum=" + GridAcc.Rows[rowIndex].Cells[3].Value +
                                 "&KrdSum=" + GridAcc.Rows[rowIndex].Cells[4].Value +
                                 "&BegDat=" + document.getElementById('parBeg').value + 
                                 "&EndDat=" + document.getElementById('parEnd').value);
                AccWindow.Open();
            }
            if (cellIndex == 3) {
                AccWindow.setTitle(GridAcc.Rows[rowIndex].Cells[0].Value + " Дебет " + GridAcc.Rows[rowIndex].Cells[3].Value);
                AccWindow.setUrl("BuxGlvGrdAccPrv.aspx?AccKod=" + GridAcc.Rows[rowIndex].Cells[0].Value +
                                 "&AccSum=" + GridAcc.Rows[rowIndex].Cells[3].Value +
                                 "&DebKrd='D'" +
                                 "&BegDat=" + document.getElementById('parBeg').value +
                                 "&EndDat=" + document.getElementById('parEnd').value);
                AccWindow.Open();
            }
            if (cellIndex == 4) {
                AccWindow.setTitle(GridAcc.Rows[rowIndex].Cells[0].Value + " Кредит " + GridAcc.Rows[rowIndex].Cells[4].Value);
                AccWindow.setUrl("BuxGlvGrdAccPrv.aspx?AccKod=" + GridAcc.Rows[rowIndex].Cells[0].Value +
                                 "&AccSum=" + GridAcc.Rows[rowIndex].Cells[4].Value +
                                 "&DebKrd='K'" +
                                 "&BegDat=" + document.getElementById('parBeg').value +
                                 "&EndDat=" + document.getElementById('parEnd').value);
                AccWindow.Open();
            }
        }

        // ------------------------  при выборе медуслуги в первой вкладке ------------------------------------------------------------------       
    </script>

</head>

<body>
    <form id="form1" runat="server">
        <div>


            <!--  конец -----------------------------------------------  -->
            <%-- ============================  для передач значении  ============================================ --%>
            <span id="WindowPositionHelper"></span>

            <asp:HiddenField ID="parAcc" runat="server" />
            <asp:HiddenField ID="parAccTxt" runat="server" />
            <asp:HiddenField ID="parFrmKod" runat="server" />
            <asp:HiddenField ID="parBeg" runat="server" />
            <asp:HiddenField ID="parEnd" runat="server" />

            <!--  источники -----------------------------------------------------------  -->
            <asp:SqlDataSource runat="server" ID="sdsOpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsTyp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsStx" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

            <!--  источники -----------------------------------------------------------  -->
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
                <ScrollingSettings ScrollHeight="500" />
                <Columns>
                    <obout:Column ID="Column00" DataField="ACCKOD" HeaderText="СЧЕТ" ReadOnly="true" Width="6%" Align="rihgt" />
                    <obout:Column ID="Column01" DataField="INPDEB" HeaderText="ВХД.ОСТ.(ДЕБ)" ReadOnly="true" Align="rihgt" Width="16%" DataFormatString="{0:N}" />
                    <obout:Column ID="Column02" DataField="INPKRD" HeaderText="ВХД.ОСТ.(КРД)" ReadOnly="true" Align="rihgt" Width="16%" DataFormatString="{0:N}" />
                    <obout:Column ID="Column03" DataField="OBRDEB" HeaderText="ОБОРОТ (ДЕБ)" ReadOnly="true" Align="rihgt" Width="15%" DataFormatString="{0:N}" />
                    <obout:Column ID="Column04" DataField="OBRKRD" HeaderText="ОБОРОТ (КРД)" ReadOnly="true" Align="rihgt" Width="15%" DataFormatString="{0:N}" />
                    <obout:Column ID="Column05" DataField="OUTDEB" HeaderText="ИСХ.ОСТ.(ДЕБ)" ReadOnly="true" Align="rihgt" Width="16%" DataFormatString="{0:N}" />
                    <obout:Column ID="Column06" DataField="OUTKRD" HeaderText="ИСХ.ОСТ.(КРД)" ReadOnly="true" Align="rihgt" Width="16%" DataFormatString="{0:N}" />
                </Columns>

            </obout:Grid>

            <!--  источники -----------------------------------------------------------  -->
            <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
            --%>


            <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
            <owd:Window ID="AccWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
                Left="50" Top="0" Height="600" Width="1000" Visible="true" VisibleOnLoad="false"
                StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
            </owd:Window>

        </div>


    </form>
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
</body>
</html>

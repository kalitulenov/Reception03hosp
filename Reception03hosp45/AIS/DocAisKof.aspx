<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


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
            $('#BrtDat').mask('D9.M9.Y999');
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
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
  //                    alert("onChange=" + sender + " = " + newText);
            var DatDocVal = newText;
 //           alert("onChange=" + sender + " = " + newText);
            //         DatDocVal = DatDocVal.replace(",", ".");

            if (DatDocVal == "") { alert("ИИН не указан " + DatDocVal); return false; }
            if (DatDocVal.length != 12) { alert("длина ИИН не верен " + DatDocVal); return false; }

            var strCheck = "0123456789";
            var i;

            for (var i = 0; i < DatDocVal.length; i++) {
              //          alert("i=" + i + "DatDocVal=" + DatDocVal[i]);
                if (strCheck.indexOf(DatDocVal[i]) == -1) { alert("Ошибка в ИИН " + DatDocVal + " i=" + i ); return false; }
            }
        }

        function ExitFun() {
  //          window.parent.KofClick();
            window.parent.KofClose();
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KltOneIdn;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    string GlvBegDatTxt;
    string GlvEndDatTxt;


    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        GlvBegDatTxt = Convert.ToString(Request.QueryString["BegDat"]);
        GlvEndDatTxt = Convert.ToString(Request.QueryString["EndDat"]);

  //      TxtPmc.Text = "1";
  //      TxtKdu.Text = "1";

        if (!Page.IsPostBack)
        {

        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void ChkButton_Click(object sender, EventArgs e)
    {

        if (TxtPmc.Text.Length == 0)
        {
            TxtPmc.Text = "1";
        }

        if (TxtKdu.Text.Length == 0)
        {
            TxtKdu.Text = "1";
        }

   //     ConfirmDialog.Visible = true;
  //      ConfirmDialog.VisibleOnLoad = true;
        //---------------------------------------------- запись --------------------------
        int PmcVal = 1;
        int KduVal = 1;

        //=====================================================================================
        //        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(TxtPmc.Text) == null || Convert.ToString(TxtPmc.Text) == "") PmcVal = 1;
        else PmcVal = Convert.ToInt32(TxtPmc.Text);

        if (Convert.ToString(TxtKdu.Text) == null || Convert.ToString(TxtKdu.Text) == "") KduVal = 1;
        else KduVal = Convert.ToInt32(TxtKdu.Text);


        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspDocSttKof", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
        cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
        cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
        cmd.Parameters.Add("@KOFPMC", SqlDbType.Int,4).Value = PmcVal;
        cmd.Parameters.Add("@KOFKDU", SqlDbType.Int,4).Value = KduVal;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);
    }


</script>


<body>

    <form id="form1" runat="server">
        <asp:HiddenField ID="TekKltIdn" runat="server" />
        <asp:HiddenField ID="TekCntIdn" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 110px;">

            <asp:TextBox ID="BoxTit"
                Text="УКАЖИТЕ КОЭФФИЦИЕНТ"
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 99%"
                runat="server"></asp:TextBox>
            </br>
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <!--  Фамилия , Страховщик ----------------------------------------------------------------------------------------------------------  
     -->
                <tr style="height: 35px">
                    <td width="20%" class="PO_RowCap"></td>
                    <td width="10%" class="PO_RowCap">&nbsp;ПМСП:</td>
                    <td width="70%" style="vertical-align: top;">
                        <asp:TextBox runat="server" ID="TxtPmc" Width="50%" Text="1" BackColor="White" Height="25px" Font-Size="Larger" AutoPostBack="false">
                        </asp:TextBox>
                    </td>
                </tr>
                <!--  Имя , Фирма страхователь ----------------------------------------------------------------------------------------------------------  -->
                <tr style="height: 35px">
                    <td width="20%" class="PO_RowCap"></td>
                    <td width="10%" class="PO_RowCap">&nbsp;КДУ:</td>
                    <td width="70%" style="vertical-align: top;">
                        <asp:TextBox runat="server" ID="TxtKdu" Width="50%" Text="1" BackColor="White" Height="25px" Font-Size="Larger" AutoPostBack="false">
                        </asp:TextBox>
                   </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 30px;">
            <center>
                <asp:Button ID="Button1" runat="server" CommandName="Add" Style="display: none" Text="1" />
                <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать" />
            </center>
        </asp:Panel>


        <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
        <!--     Dialog должен быть раньше Window-->
  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
                            
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

    </style>


</body>

</html>



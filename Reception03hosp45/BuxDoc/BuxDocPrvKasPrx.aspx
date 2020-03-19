<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ============================  для почты  ============================================ --%>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%> 
 

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
    </style>

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>


    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
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

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;
        //    ------------------ смена логотипа ----------------------------------------------------------

        window.onload = function () {
            var GlvDocIdn = document.getElementById('MainContent_parKasIdn').value;
            var GlvDocPrv = document.getElementById('MainContent_parKasPrv').value;
   //         mySpl.loadPage("BottomContent", "/Priem/DocAppAmbUsl.aspx?AmbCrdIdn=" + GlvDocIdn);
        };


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


        function PrtButton_Click() {
  //          alert("PrtPrxOrd=");

            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

</script>
</head>
    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">


        string GlvDocIdn;
        string GlvDocPrv;

        int DtlIdn;
        string DtlNam;
        decimal DtlKol;
        string DtlEdn;
        decimal DtlZen;
        decimal DtlSum;
        string DtlIzg;
        string DtlSrkSlb;


        string GlvDocTyp;
        DateTime GlvDocDat;
        string MdbNam = "HOSPBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;
        string CountTxt;
        int CountInt;
        decimal ItgDocSum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            //============= Установки ===========================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            BuxFrm = (string)Session["BuxFrmKod"];

            GlvDocTyp = "Прх";
            //=====================================================================================
            GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            sdsDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,4)='1010' AND ACCPRV=1 ORDER BY ACCKOD";
            sdsKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCFRM=" + BuxFrm + " AND LEFT(ACCKOD,4)='6010' AND ACCPRV=1 ORDER BY ACCKOD";
            sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " ORDER BY FI";
            sdsNaz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNaz.SelectCommand = "SELECT BuxSpzKod,BuxSpzNam FROM SprBuxSpz";

            if (!Page.IsPostBack)
            {

                //============= Установки ===========================================================================================
                    KASNUM.Enabled = false;
                    KASDAT.Enabled = false;
                    KASDEB.Enabled = false;
                    KASKRD.Enabled = false;
                    KASSUM.Enabled = false;
                    cal1.Visible = false;
                    KASKTO.Enabled = false;
                    KASFIO.Enabled = false;
                    KASMEM.Enabled = false;
                    KASIIN.Enabled = false;
                    KASFIO.Enabled = false;

                Session.Add("KASSPL", "");
              
                Session["GlvDocIdn"] = Convert.ToString(GlvDocIdn);
                parKasIdn.Value = Convert.ToString(GlvDocIdn);
                parKasPrv.Value = Convert.ToString(GlvDocPrv);

                getDocNum();

            }
        }

             //============= ввод записи после опроса  ===========================================================================================
        // ============================ чтение заголовка таблицы а оп ==============================================
             void getDocNum()
                    {

                        //------------       чтение уровней дерево
                        DataSet ds = new DataSet();
                        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                        SqlConnection con = new SqlConnection(connectionString);
                        con.Open();
                        SqlCommand cmd = new SqlCommand("BuxKasIdn", con);
                        // указать тип команды
                        cmd.CommandType = CommandType.StoredProcedure;
                        // передать параметр
                        cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;

                        // создание DataAdapter
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        // заполняем DataSet из хран.процедуры.
                        da.Fill(ds, "BuxKasIdn");

                        con.Close();

                        if (ds.Tables[0].Rows.Count > 0)
                        {

                            KASDAT.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KASDAT"]).ToString("dd.MM.yyyy");
                            KASNUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASNUM"]);
                            KASSUM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASSUM"]);
                            KASDEB.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASDEB"]);
                            KASKRD.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASKRD"]);
                            KASFIO.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIONAM"]);
                            KASKTO.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSPRVAL"]);
                            KASSYM.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSYM"]);
                            parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);
                            KASMEM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
                            KASIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIOIIN"]);

                            parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);

                        }
                    }
                    
             // ============================ чтение заголовка таблицы а оп ==============================================
                    // ============================ проводить записи документа в базу ==============================================

                    void RebindGrid(object sender, EventArgs e)
                    {
//                        getGrid();
                    }
                    // ============================ проверка и опрос для записи документа в базу ==============================================

</script>


<body>
    <form id="form1" runat="server">   

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

    <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parKasPrv" runat="server" />
        <asp:HiddenField ID="parKasSpr" runat="server" />
        <asp:HiddenField ID="parKasKod" runat="server" />
        <asp:HiddenField ID="parKasNam" runat="server" />
        <asp:HiddenField ID="parKasZen" runat="server" />
    <%-- ============================  шапка экрана ============================================ --%>
    <asp:TextBox ID="Sapka0"
        Text="Кассовый приходной ордер"
        BackColor="#3CB371"
        Font-Names="Verdana"
        Font-Size="20px"
        Font-Bold="True"
        ForeColor="White"
        Style="top: 0px; left: 0%; position: relative; width: 100%; text-align: center"
        runat="server"></asp:TextBox>
    <%-- ============================  подшапка  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>
    <%-- ============================  средний блок  ============================================ --%>
      <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 0%; position: relative; top: 0px; width: 100%; height: 220px;">

        <table border="1" cellspacing="0" width="100%">
            <tr>
                <td width="7%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Признак проведения</td>
                <td width="12%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">№ доку<wbr>мента</td>
                <td width="8%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Дата</td>
                <td width="8%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Счет кассы</td>
                <td width="21%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Корр.счет</td>
                <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Сумма</td>
                <td width="5%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">НДС</td>
                <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Сумма НДС</td>
                <td width="19%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Назачения</td>
            </tr>

            <tr>
                <td width="7%" class="PO_RowCap"></td>
                <td width="12%" class="PO_RowCap">
                    <asp:TextBox ID="KASNUM" Font-Size="Medium" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="13%" class="PO_RowCap">
                    <asp:TextBox runat="server" ID="KASDAT" Width="80px" />
                    <obout:Calendar ID="cal1" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="DOCDAT"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                </td>
                <td width="10%" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASDEB" Width="100%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsDeb" DataTextField="AccKod" DataValueField="AccKod">
                    </obout:ComboBox>

                </td>

                <td width="10%" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASKRD" Width="100%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsKrd" DataTextField="AccKod" DataValueField="AccKod">
                    </obout:ComboBox>
                </td>
                <td width="10%" class="PO_RowCap">
                    <asp:TextBox ID="KASSUM" Font-Size="Medium" Font-Bold="true" style="text-align:right" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="5%" class="PO_RowCap"></td>
                <td width="10%" class="PO_RowCap"></td>
                <td width="19%" colspan="3" class="PO_RowCap">
                    <obout:ComboBox runat="server" ID="KASSYM" Width="100%" Height="200"
                          FolderStyle="/Styles/Combobox/Plain"
                          DataSourceID="sdsNaz" DataTextField="BUXSPZNAM" DataValueField="BUXSPZKOD" >
                    </obout:ComboBox>
                </td>

            </tr>
            <tr>
                <td width="15%" align="center" style="font-weight: bold;" class="PO_RowCap">Принято от</td>
                <td width="12%" class="PO_RowCap">
                    <asp:TextBox ID="KASIIN" Font-Size="Medium" Font-Bold="true" style="text-align:left" Width="98%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="40%" colspan="2" class="PO_RowCap">
                    <asp:TextBox ID="KASFIO" Font-Size="Medium" Font-Bold="true" style="text-align:left" Width="95%" Height="20" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="14%" align="center" style="font-weight: bold;" class="PO_RowCap">
                </td>
                <td width="10%" colspan="3" class="PO_RowCap"> 
                    <obout:ComboBox runat="server" ID="KASKTO" Width="100%" Height="200"
                          FolderStyle="/Styles/Combobox/Plain"
                          DataSourceID="sdsKto" DataTextField="FI" DataValueField="BuxKod" >
                    </obout:ComboBox>
                </td>
                <td width="10%" class="PO_RowCap"> 
                </td>
            </tr>
            
            <tr>
                <td width="15%" align="center" style="font-weight: bold;" class="PO_RowCap">Основание</td>
                <td width="85%" colspan="8" class="PO_RowCap">
                    <obout:OboutTextBox runat="server" ID="KASMEM" Width="100%" BackColor="White" Height="100px" Font-Bold="true"
                           TextMode="MultiLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
                    </obout:OboutTextBox>
                </td>
            </tr>
        </table>

    </asp:Panel>
        <%-- ============================  шапка экрана ============================================ --%>

<%-- ============================  нижний блок  ============================================ --%>
<%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
              </center>      
  </asp:Panel> 

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  источник  для ГРИДА============================================ --%>
    <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsNaz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  

      </form>
   </body>
</html>
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

        .super-form {
            margin: 12px;
        }

        .ob_fC table td {
            white-space: normal !important;
        }

        .command-row .ob_fRwF {
            padding-left: 50px !important;
        }
        .auto-style1 {
            height: 29px;
        }
    </style>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>


    <%-- ============================  стили ============================================ --%>
 

    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">
        // -----------------------------------------------   переход по вводу
        $(document).ready(function () {
            $("input").not($(":button")).keypress(function (evt) {
                if (evt.keyCode == 13) {
                    iname = $(this).val();
                    if (iname !== 'Печать') {
                        var fields = $(this).parents('form:eq(0),body').find('button,input,textarea,select');
                        var index = fields.index(this);
                        if (index > -1 && (index + 1) < fields.length) {
                            fields.eq(index + 1).focus();
                        }
                        id = this.id;
                        //    id = $(this).attr("id");
                      //  alert("id=" + id);

                        if (id == 'KASCAB') {
                            // ====================================================   поиск врача из  кабинета
                            var ParStr = document.getElementById('parBuxFrm').value + '@' + iname + '@';
                        //    alert("ParStr=" + ParStr);
                            
                            $.ajax({
                                type: 'POST',
                                url: '/HspUpdDoc.aspx/BuxKasPrxDatDoc',
                                contentType: "application/json; charset=utf-8",
                                data: '{"ParStr":"' + ParStr + '"}',
                                dataType: "json",
                                success: function (msg) {
                                    var hashes = msg.d.split(';');
                                 //        alert("msg=" + msg);
                                 //        alert("msg.d=" + msg.d);
                                    document.getElementById('KASDOCKOD').value = hashes[0];
                                    document.getElementById('KASDOCFIO').value = hashes[1];
                                },
                                error: function () { }
                            });
                            
                       //     document.getElementById('KASDOC').value = "Ибраимова";
                        }

                        // ====================================================   поиск врача из  кабинета
                        return false;
                    }

                }
            });
        });

 

        var myconfirm = 0;
        //    ------------------ смена логотипа ----------------------------------------------------------

        window.onload = function () {
            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var GlvDocPrv = document.getElementById('parKasPrv').value;
            document.getElementById('KASSUM').focus();
     //       mySpl.loadPage("BottomContent", "/Priem/DocAppAmbUsl.aspx?AmbCrdIdn=" + GlvDocIdn);
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


        function PrtPrxOrd() {
       //     alert("PrtPrxOrd=");

            var GlvDocIdn = document.getElementById('parKasIdn').value;
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasPrxOrd&TekDocIdn=" + GlvDocIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
        function ExitFun() {
            window.parent.KasClose();
            //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
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

            parBuxFrm.Value = Convert.ToString(BuxFrm);


            GlvDocTyp = "Прх";
            //=====================================================================================
            GlvDocIdn = Convert.ToString(Request.QueryString["GlvDocIdn"]);
            GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            sdsNaz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsNaz.SelectCommand = "SELECT BuxSpzKod,BuxSpzNam FROM SprBuxSpz";

            if (!Page.IsPostBack)
            {
                //============= Установки ===========================================================================================
                if (GlvDocIdn == "0")  // новый документ
                {
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("BuxKasAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
                    cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@KASIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        GlvDocIdn = Convert.ToString(cmd.Parameters["@KASIDN"].Value);
                    }
                    finally
                    {
                        con.Close();
                    }
                    parKasTyp.Value = "ADD";

                }
                else parKasTyp.Value = "REP";

            //    ConfirmDialog.Visible = false;
           //     ConfirmDialog.VisibleOnLoad = false;

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
                //    KASDEB.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASDEB"]);
                //     KASKRD.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASKRD"]);
                //     KASFIO.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIONAM"]);
                //     KASKTO.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSPRVAL"]);
                //  KASSYM.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KASSYM"]);
                parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);
                //     KASMEM.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASMEM"]);
                //     KASIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASFIOIIN"]);
                KASDOCKOD.Text = Convert.ToString(ds.Tables[0].Rows[0]["KASVAL"]);
                KASDOCFIO.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCFIO"]);

                parKasSpr.Value = Convert.ToString(ds.Tables[0].Rows[0]["KASSPR"]);

            }

        }

        // ============================ проверка и опрос для записи документа в базу ==============================================
        // ============================ отказ записи документа в базу ==============================================
        //----------------  ПЕЧАТЬ  --------------------------------------------------------
        protected void PrtButton_Click(object sender, EventArgs e)
        {


                ConfirmOK.Visible = false;
                ConfirmOK.VisibleOnLoad = false;


                if (KASNUM.Text.Length == 0)
                {
                    Err.Text = "Не указан номер документа";
                    ConfirmOK.Visible = true;
                    ConfirmOK.VisibleOnLoad = true;
                    return;
                }

                if (KASDAT.Text.Length == 0)
                {
                    Err.Text = "Не указан дата документа";
                    ConfirmOK.Visible = true;
                    ConfirmOK.VisibleOnLoad = true;
                    return;
                }

                if (KASSUM.Text.Length == 0)
                {
                    Err.Text = "Не указан сумма";
                    ConfirmOK.Visible = true;
                    ConfirmOK.VisibleOnLoad = true;
                    return;
                }

    //            ConfirmDialogPrt.Visible = true;
    //            ConfirmDialogPrt.VisibleOnLoad = true;
 //       }

        // ============================ одобрение для записи документа в базу ==============================================
 //       protected void btnPrtOK_click(object sender, EventArgs e)
 //       {
            GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxKasOrdWrt", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@KASIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@KASFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@KASBUX", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@KASOPR", SqlDbType.VarChar).Value = "+";
            cmd.Parameters.Add("@KASNUM", SqlDbType.VarChar).Value = KASNUM.Text;
            cmd.Parameters.Add("@KASDAT", SqlDbType.VarChar).Value = KASDAT.Text;

            cmd.Parameters.Add("@KASDEB", SqlDbType.VarChar).Value = "1010"; // KASDEB.SelectedValue;
            cmd.Parameters.Add("@KASDEBSPR", SqlDbType.VarChar).Value = "2";
            cmd.Parameters.Add("@KASDEBSPRVAL", SqlDbType.VarChar).Value = "1";

            cmd.Parameters.Add("@KASKRD", SqlDbType.VarChar).Value = "6010"; // KASKRD.SelectedValue;
            cmd.Parameters.Add("@KASKRDSPR", SqlDbType.VarChar).Value = parKasSpr.Value;
            cmd.Parameters.Add("@KASKRDSPRVAL", SqlDbType.VarChar).Value = ""; // KASIIN.Text;

            cmd.Parameters.Add("@KASFIO", SqlDbType.VarChar).Value = "Пациент"; // KASFIO.Text;
            cmd.Parameters.Add("@KASSUM", SqlDbType.VarChar).Value = KASSUM.Text;
            cmd.Parameters.Add("@KASVAL", SqlDbType.VarChar).Value = KASDOCKOD.Text; // KASKTO.SelectedValue;
            cmd.Parameters.Add("@KASSYM", SqlDbType.VarChar).Value = 0;  // KASSYM.SelectedValue;
            cmd.Parameters.Add("@KASMEM", SqlDbType.VarChar).Value = "Медицинские услуги"; // KASMEM.Text;
            cmd.Parameters.Add("@KASDOC", SqlDbType.VarChar).Value = KASDOCKOD.Text;


            cmd.ExecuteNonQuery();
            con.Close();

            ExecOnLoad("PrtPrxOrd();");

            ExecOnLoad("ExitFun();");

        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            //    if (GlvDocPrv != "проведен")
            if (parKasTyp.Value == "ADD")
            {

                GlvDocIdn = Convert.ToString(Session["GlvDocIdn"]);
                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("BuxKasOrdCan", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@KASIDN", SqlDbType.VarChar).Value = GlvDocIdn;
                cmd.ExecuteNonQuery();

                con.Close();

            }

            ExecOnLoad("ExitFun();");
        }


        // ============================ проверка и опрос для записи документа в базу ==============================================
 </script>

<body>
    <form id="form1" runat="server">   

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

    <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parKasIdn" runat="server" />
        <asp:HiddenField ID="parKasPrv" runat="server" />
        <asp:HiddenField ID="parKasSpr" runat="server" />
        <asp:HiddenField ID="parKasKod" runat="server" />
        <asp:HiddenField ID="parKasNam" runat="server" />
        <asp:HiddenField ID="parKasZen" runat="server" />
        <asp:HiddenField ID="parKasSum" runat="server" />
        <asp:HiddenField ID="parKasMem" runat="server" />
        <asp:HiddenField ID="parKasTyp" runat="server" />
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
        Style="left: 0%; position: relative; top: 0px; width: 100%; height: 80px;">

        <table border="1" cellspacing="0" width="100%">
            <tr>
                <td width="15%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Дата</td>
                <td width="7%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">№ доку<wbr>мента</td>
                <td width="7%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Сумма</td>
                <td width="7%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Кабинет</td>
                <td width="7%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Печать</td>
                <td width="40%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Врач</td>
           </tr>

            <tr>

                <td width="15%" class="auto-style1">
                    <asp:TextBox runat="server" ID="KASDAT" Width="80px" ReadOnly="true" />
                    <obout:Calendar ID="cal1" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="KASDAT"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />
                </td>
                <td width="7%" class="auto-style1">
                    <asp:TextBox ID="KASNUM" Font-Size="Medium" Width="95%" Height="20" ReadOnly="true" TabIndex="0" runat="server" BackColor="#FFFFE0" />
                </td>
                <td width="7%" class="auto-style1">
                    <asp:TextBox ID="KASSUM" Font-Size="Medium" Font-Bold="true" style="text-align:right" Width="95%" Height="20" runat="server" TabIndex="0" BackColor="#FFFFE0" />
                </td>
                <td width="7%" class="auto-style1">
                    <asp:TextBox ID="KASCAB" Font-Size="Medium" Font-Bold="true" style="text-align:right" Width="95%" Height="20" runat="server" TabIndex="1" BackColor="#FFFFE0" />
                </td>

                <td width="7%" class="auto-style1">
                     <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать" onclick="PrtButton_Click" TabIndex="3"/>
                </td>

               <td width="40%" class="auto-style1">
                    <asp:TextBox ID="KASDOCFIO" Font-Size="Medium" Font-Bold="true" style="text-align:right" Width="95%" ReadOnly="true" Height="20" runat="server" TabIndex="2" BackColor="#FFFFE0" />
                    <asp:TextBox ID="KASDOCKOD" style="display:none" runat="server" />
                </td>
            </tr>

        </table>

    </asp:Panel>

        <%-- ============================  шапка экрана ============================================
           
            
            --%>

<%-- ============================  нижний блок  ============================================ --%>
<%-- ============================  нижний блок  ============================================ 
                    <obout:ComboBox runat="server" ID="KASSYM" Width="100%" Height="200"
                          FolderStyle="/Styles/Combobox/Plain" TabIndex="1"
                          DataSourceID="sdsNaz" DataTextField="BUXSPZNAM" DataValueField="BUXSPZKOD" >
                    </obout:ComboBox>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                 <asp:Button ID="AddButton" runat="server" CommandName="Cancel" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Печать" onclick="PrtButton_Click"/>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Закрыть" OnClick="CanButton_Click" />
              </center>      
  </asp:Panel> 
--%>
<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

     <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="450" Height="150" StyleFolder="/Styles/Window/wdstyles/default" Title="" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Text="" BackColor="Transparent" BorderStyle="None"  Font-Size="Large"  Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" style="width:150px; height:30px;"  onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

<%-- =================  источник  для ГРИДА============================================ --%>
    <asp:SqlDataSource runat="server" ID="sdsDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsNaz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

      </form>
   </body>
</html>
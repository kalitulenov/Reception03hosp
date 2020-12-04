<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
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
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->

    <script type="text/javascript">
        //    ------------------ смена логотипа ----------------------------------------------------------
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


        // --------------------- РАСХОД МАТЕРИАЛОВ ПО ЭТОЙ УСЛУГЕ
        function GridUsl_rsx() {
            //                  alert("GridPrz_rsx=");
            var AmbCrdIdn = document.getElementById('parCrdIdn').value;
            var AmbUslIdn = "0";
            var AmbUklIdn = document.getElementById('parUklIdn').value;
            var AmbStxKey = document.getElementById('parStxKey').value;

            //             RsxWindow.setTitle(AmbUslNam);
            //             RsxWindow.setUrl("DocAppAmbUslRsx.aspx?AmbUslIdn=" + AmbUslIdn + "&AmbUslNam=" + AmbUslNam);
            //             RsxWindow.Open();

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppAmbUslRsxMat.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn + "&AmbStxKey=" + AmbStxKey,
                    "ModalPopUp", "toolbar=no,width=1000,height=650,left=150,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppAmbUslRsxMat.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn + "&AmbStxKey=" + AmbStxKey,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:150px;dialogtop:100px;dialogWidth:1000px;dialogHeight:650px;");

            return true;
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          
        /*------------------------- при нажатии на поле текст --------------------------------*/
        /*------------------------- при выходе запомнить Идн --------------------------------*/

//  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        //    ------------------------------------------------------------------------------------------------------------------------

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUklIdn;
    string AmbUklCel;
    string AmbStxKey;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

    string Col001;
    string Col002;
    string Col003;
    string Col004;
    string Col005;
    string Col006;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        AmbUklIdn = Convert.ToString(Request.QueryString["AmbUklIdn"]);
        AmbUklCel = Convert.ToString(Request.QueryString["AmbUklCel"]);
        AmbStxKey = Convert.ToString(Request.QueryString["AmbStxKey"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        parUklIdn.Value = AmbUklIdn;
        parCrdIdn.Value = AmbCrdIdn;
        parStxKey.Value = AmbStxKey;
        //       BuxSid = (string)Session["BuxSid"];
        //       BuxKod = (string)Session["BuxKod"];
        //      AmbCrdIdn = (string)Session["AmbCrdIdn"];
        //        Session.Add("AmbUslIdn ", AmbUslIdn);

        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm + " AND BUXUBL=0 AND ZANNAM='средний мед персонал' ORDER BY FI";
        //       sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr WHERE BUXFRM=" + BuxFrm;

        if (!Page.IsPostBack)
        {
            //============= Установки ===========================================================================================
            //       AmbUslIdnTek = (string)Session["AmbUslIdn"];

            getDocNum();
        }
    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    void getDocNum()
    {
        int NumCelInt;
        string NumCel;
        // --------------------------  считать данные одного врача -------------------------
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbUklIdnUpd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbUklIdn;
        cmd.Parameters.Add("@GLVDOCCEL", SqlDbType.VarChar).Value = AmbUklCel;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbUklIdnUpd");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            TxtDat.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
            TxtTim.Text = Convert.ToDateTime(DateTime.Now).ToString("hh:mm");
            TxtFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TxtNaz.Text = Convert.ToString(ds.Tables[0].Rows[0]["UKLNAM"]);
            TxtPrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["PRMNAM"]);
            TxtEdn.Text = Convert.ToString(ds.Tables[0].Rows[0]["EDNLEKNAM"]);
            TxtKol.Text = Convert.ToString(ds.Tables[0].Rows[0]["UKLKOLTAB"]);

            NumCelInt = Convert.ToInt32(AmbUklCel)-6;
            NumCel = NumCelInt.ToString("000");
            TxtPls.Text = Convert.ToString(ds.Tables[0].Rows[0]["UKLFLG"+NumCel]);
            //          BoxKto.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["USLKTO"]);
        }
        else
        {
        }

    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;


        if (BoxKto.SelectedValue == "")
        {
            Err.Text = "Не указан ответственный";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        ConfirmDialog.Visible = true;
        ConfirmDialog.VisibleOnLoad = true;
    }

    // ============================ одобрение для записи документа в базу ==============================================
    protected void btnOK_click(object sender, EventArgs e)
    {

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmbUklIdnUpdWrt", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbUklIdn;
        cmd.Parameters.Add("@GLVDOCCEL", SqlDbType.Int).Value = Convert.ToInt32(AmbUklCel) - 6;
        cmd.Parameters.Add("@GLVDOCKTO", SqlDbType.VarChar).Value = BoxKto.SelectedValue;
        cmd.ExecuteNonQuery();

        con.Close();

        // ------------------------------------------------------------------------------заполняем второй уровень
        ConfirmDialog.Visible = false;
        ConfirmDialog.VisibleOnLoad = false;

        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(),"Close_Window", "window.opener.HandlePopupResult(); self.close();", true);

    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ чтение заголовка таблицы а оп ==============================================

    //------------------------------------------------------------------------
    //------------------------------------------------------------------------
    //===============================================================================================================

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUklIdn" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <asp:HiddenField ID="parStxKey" runat="server" />
        <asp:HiddenField ID="OpsIdn" runat="server" />
        <asp:HiddenField ID="ZakIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 330px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="ДАТА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtDat" Width="20%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; border:hidden; font-size: medium;" />
                        <asp:Label ID="Label8" Text="ВРЕМЯ:" runat="server" Width="15%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtTim" Width="20%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; border:hidden; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                   <td style="width: 100%; height: 30px;">
                        <hr>
                        <asp:Label ID="Label1" Text="ПАЦИЕНТ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtFio" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label6" Text="НАЗНАЧЕНИЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtNaz" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label3" Text="ПРИМЕНЕНИЕ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtPrm" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="ЕД.ИЗМ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtEdn" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label9" Text="КОЛИЧЕСТВО:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtKol" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
               <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label10" Text="ОТМЕТКИ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtPls" Width="78%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;"">
                        <asp:Label ID="Label7" Text="ОТВЕТСТВЕН:" runat="server" Width="20%" Font-Bold="true" />
                        <obout:ComboBox runat="server"
                            ID="BoxKto"
                            Width="78%"
                            Height="100"
                            EmptyText="Выберите услугу ..."
                            FolderStyle="/Styles/Combobox/Plain"
                            DataSourceID="sdsKto"
                            DataTextField="FI"
                            DataValueField="BUXKOD" >
                        </obout:ComboBox>   
                   </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <hr>
<%--                        <asp:Label ID="Label2" Text="" runat="server" Width="20%" Font-Bold="true" />--%>
<%--                        <input type="button" style="width: 20%; height:25px;" value="Расходы" onclick="GridUsl_rsx()" />--%>
                        <asp:Button ID="ButApt" runat="server"
                                                OnClick ="AddButton_Click"
                                                Width="98%" CommandName="" CommandArgument=""
                                                Text="Записать" Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>

            </table>

        </asp:Panel>


<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Запись процедуры" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="btnOK_click" />
                              <input type="button" value="Назад" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
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
    </form>
    
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>


    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        hr {
 border: none; /* Убираем границу для браузера Firefox */
    color: red; /* Цвет линии для остальных браузеров */
    background-color: red; /* Цвет линии для браузера Firefox и Opera */
    height: 2px; /* Толщина линии */           }
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



</body>

</html>



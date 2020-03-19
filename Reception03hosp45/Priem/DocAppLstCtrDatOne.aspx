<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

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

    <script type="text/javascript">
        function ExitFun() {
            window.parent.MemClose();
        }
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;

    string BuxFrm;
    string BuxKod;
    string BuxSid;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        
        BuxFrm = (string)Session["BuxFrmKod"];
 //       BuxSid = (string)Session["BuxSid"];
 //       BuxKod = (string)Session["BuxKod"];
  //      AmbCrdIdn = (string)Session["AmbCrdIdn"];
//        Session.Add("AmbUslIdn ", AmbUslIdn);

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
        // --------------------------  считать данные одного врача -------------------------
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspDocAppLstCtrDatOne", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAppLstCtrDatOne");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
//            TxtDat.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
            TxtDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFCTRDAT"]).ToString("dd.MM.yyyy");
            TxtFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TxtTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
            TxtAdr.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTADR"]);
            TxtRes.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFMEM"]);
        }

    }

    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void AddButton_Click(object sender, EventArgs e)
    {
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE AMBCRD SET GRFMEM='" + TxtRes.Text + "' WHERE GRFIDN=" + AmbCrdIdn, con);
        cmd.ExecuteNonQuery();
        // создание команды

        con.Close();

        // ------------------------------------------------------------------------------заполняем второй уровень
        ExecOnLoad("ExitFun();");

    }

    // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parUslIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 330px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label5" Text="ДАТА:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium"  />
                        <asp:TextBox ID="TxtDat" Width="20%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; border:hidden; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                   <td style="width: 100%; height: 30px;">
                        <hr>
                        <asp:Label ID="Label1" Text="ПАЦИЕНТ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtFio" Width="70%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label3" Text="ТЕЛЕФОН:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtTel" Width="70%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label4" Text="АДРЕС:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                        <asp:TextBox ID="TxtAdr" Width="70%" Height="20" ReadOnly="true" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
               <tr>
                    <td style="width: 100%; height: 30px;">
                        <asp:Label ID="Label10" Text="РЕЗУЛЬТАТ:" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                   </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                       <asp:Label ID="Label6" Text="" runat="server" Width="20%" Font-Bold="true" Font-Size="Medium" />
                       <asp:TextBox ID="TxtRes" Width="70%" Height="140" TextMode="MultiLine" runat="server" Style="position: relative; font-weight: 700; font-size: medium;" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 30px;">
                        <hr>
                        <asp:Label ID="Label2" Text="" runat="server" Width="20%" Font-Bold="true" />
                        <asp:Button ID="ButApt" runat="server"
                                                OnClick ="AddButton_Click"
                                                Width="70%" CommandName="" CommandArgument=""
                                                Text="Записать" Height="25px" Font-Bold="true"
                                                Style="position: relative; top: 0px; left: 0px" />
                    </td>
                </tr>

            </table>

        </asp:Panel>

    </form>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>

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

    </style>



</body>

</html>



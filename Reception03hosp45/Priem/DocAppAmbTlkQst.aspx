﻿<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

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
    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

        function ExitFun() {
            window.parent.QstClose();
   //         location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbTlkIdn;
    string AmbTlkIdnTek;
    string BuxFrm;
    string BuxKod;
    string BuxSid;


    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
  //      AmbUslIdn = Convert.ToString(Request.QueryString["AmbUslIdn"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];

        sdsNoz.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        sdsNoz.SelectCommand = "SELECT NOZKOD,NOZNAM FROM SPRNOZ ORDER BY NOZNAM";
        
        if (!Page.IsPostBack)
        {
            //============= Установки ===========================================================================================
             AmbTlkIdnTek = (string)Session["AmbTlkIdn"];
             if (AmbTlkIdnTek != "Post")
             {

                     // строка соединение
                     string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                     // создание соединение Connection
                     SqlConnection con = new SqlConnection(connectionString);
                     // создание команды
                     SqlCommand cmd = new SqlCommand("HspTlkQstAdd", con);
                     // указать тип команды
                     cmd.CommandType = CommandType.StoredProcedure;
                     // передать параметр
                     cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                     cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                     cmd.Parameters.Add("@TLKIDN", SqlDbType.Int, 4).Value = 0;
                     cmd.Parameters["@TLKIDN"].Direction = ParameterDirection.Output;
                     con.Open();
                     try
                     {
                         int numAff = cmd.ExecuteNonQuery();
                         // Получить вновь сгенерированный идентификатор.
                         //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                         //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                         AmbTlkIdn = Convert.ToString(cmd.Parameters["@TLKIDN"].Value);
                     }
                     finally
                     {
                         con.Close();
                     }
             }

             Session["AmbTlkIdn"] = Convert.ToString(AmbTlkIdn);
             parTlkIdn.Value = AmbTlkIdn;
            
        }

        Session["AmbTlkIdn"] = parTlkIdn.Value;

    }

    // ============================ чтение заголовка таблицы а оп ==============================================
    // ============================ проверка и опрос для записи документа в базу ==============================================
    protected void QstButton_Click(object sender, EventArgs e)
    {
        string QstNoz = "";
        string QstTxt = "";
        string QstNik = "";
        
        AmbTlkIdn = parTlkIdn.Value;

        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(BoxNoz.SelectedValue) == null || Convert.ToString(BoxNoz.SelectedValue) == "") QstNoz = "";
        else QstNoz = Convert.ToString(BoxNoz.SelectedValue);

        if (Convert.ToString(TxtQst.Text) == null || Convert.ToString(TxtQst.Text) == "") QstTxt = "";
        else QstTxt = Convert.ToString(TxtQst.Text);

        if (Convert.ToString(TxtNik.Text) == null || Convert.ToString(TxtNik.Text) == "") QstNik = "";
        else QstNik = Convert.ToString(TxtNik.Text);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspTlkQstRep", con);
        cmd = new SqlCommand("HspTlkQstRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
        cmd.Parameters.Add("@TLKIDN", SqlDbType.VarChar).Value = AmbTlkIdn;
        cmd.Parameters.Add("@TLKNOZ", SqlDbType.VarChar).Value = QstNoz;
        cmd.Parameters.Add("@TLKTXT", SqlDbType.VarChar).Value = QstTxt;
        cmd.Parameters.Add("@TLKNIK", SqlDbType.VarChar).Value = QstNik;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

        ExecOnLoad("ExitFun();");

    }
    // ============================ чтение заголовка таблицы а оп ==============================================

</script>


<body>
    <form id="form1" runat="server">

       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parTlkIdn" runat="server" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: 0px; position: relative; top: -10px; width: 100%; height: 310px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 100%">
                       <asp:Label id="Label6" Text="НОЗОЛОГИЯ:" runat="server"  Width="20%" Font-Bold="true" /> 
                        <asp:DropDownList runat="server" ID="BoxNoz" Width="30%" Font-Size="Large" 
                                    AutoPostBack="true"
                                    Height="25"
                                    DataSourceID ="sdsNoz"
                                    AppendDataBoundItems="true"
                                    DataTextField="NOZNAM"
                                    DataValueField="NOZKOD" />

                        <asp:Label id="Label1" Text="НИК:" runat="server"  Width="10%" Font-Bold="true" /> 
                        <asp:TextBox runat="server" ID="TxtNik" width="30%" BackColor="White" Height="25px" Font-Size="Medium" Font-Bold="true"  >
		                </asp:TextBox>

                    </td>
                </tr>

            </table>


            <asp:TextBox runat="server" ID="TxtQst" width="99%" BackColor="White" Height="280px" Font-Size="Larger" Font-Bold="true" TextMode="MultiLine" >
		    </asp:TextBox>

        </asp:Panel>

        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px%; position: relative; top: -10px; width: 100%; height: 30px;">
            <table border="0" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td style="width: 50%">

                    </td>
                    <td style="width: 30%">
                       <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                       <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="QstButton_Click" Text="Записать"/>
                    </td>
                    <td style="width: 20%"></td>
                </tr>
            </table>
        </asp:Panel>

    </form>

  <%--   --%>

      
    <asp:SqlDataSource runat="server" ID="sdsNoz" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

</body>

</html>



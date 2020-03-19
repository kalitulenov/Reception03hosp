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
            $('#DatBrt').mask('D9.M9.Y999');
            $('#TxtDokDat').mask('D9.M9.Y999');
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

        function ExitFun() {
     //       self.close();
        }

        // -----------------------------------------------------------------------------------
    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KdrKod;
    string CntOneIdn;

    string BuxFrm;
    string BuxKod;

    int ItgSum = 0;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

        KdrKod = Convert.ToString(Request.QueryString["KdrKod"]);
        //       KdrStx = KdrOneIdn.Substring(0, 5);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {
            GetGrid();
        }
    }


    // ============================ чтение заголовка таблицы а оп ==============================================

    void GetGrid()
    {

        //      if (BoxTit.Text == "Запись не найден") return;

        DataSet ds = new DataSet();
        DataSet dsMax = new DataSet();

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        // создание команды
        SqlCommand cmd = new SqlCommand("SELECT * FROM KDR WHERE KDRKOD=" + KdrKod, con);
        //        cmd = new SqlCommand("HspRefGlv003KdrOne", con);
        // указать тип команды
        //      cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        //    cmd.Parameters.Add("@KdrONEIDN", SqlDbType.VarChar).Value = KdrOneIdn;
        //    cmd.Parameters.Add("@CNTONEIDN", SqlDbType.VarChar).Value = CntOneIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "KdrOne");

        if (ds.Tables[0].Rows.Count > 0)
        {
            //     obout:OboutTextBox ------------------------------------------------------------------------------------      
            TxtGrp.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMGRU"]);
            TxtKat.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMKAT"]);
            TxtSos.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMSOS"]);
            TxtZvn.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMSBN"]);
            TxtBus.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMBUS"]);
            TxtGod.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMGDN"]);
            TxtRai.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMPBK"]);
            TxtSpz.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRARMSPL"]);
        }
        // ------------------------------------------------------------------------------заполняем второй уровень

        //        GridXry.DataSource = ds;
        //        GridXry.DataBind();
        // -----------закрыть соединение --------------------------
        ds.Dispose();
        con.Close();
    }


    //------------------------------------------------------------------------
    // ============================ проверка и опрос для записи документа в базу ==============================================
    
    protected void ChkButton_Click(object sender, EventArgs e)
    {
        //---------------------------------------------- запись --------------------------
            string KdrGrp = "";
            string KdrKat = "";
            string KdrSos = "";
            string KdrZvn = "";
            string KdrBus = "";
            string KdrGod = "";
            string KdrRai = "";
            string KdrSpz = "";
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================
          //     obout:OboutTextBox ------------------------------------------------------------------------------------      
          
            if (Convert.ToString(TxtGrp.Text) == null || Convert.ToString(TxtGrp.Text) == "") KdrGrp = "";
            else KdrGrp = Convert.ToString(TxtGrp.Text);

            if (Convert.ToString(TxtKat.Text) == null || Convert.ToString(TxtKat.Text) == "") KdrKat = "";
            else KdrKat = Convert.ToString(TxtKat.Text);

            if (Convert.ToString(TxtSos.Text) == null || Convert.ToString(TxtSos.Text) == "") KdrSos = "";
            else KdrSos = Convert.ToString(TxtSos.Text);

            if (Convert.ToString(TxtZvn.Text) == null || Convert.ToString(TxtZvn.Text) == "") KdrZvn = "";
            else KdrZvn = Convert.ToString(TxtZvn.Text);

            if (Convert.ToString(TxtBus.Text) == null || Convert.ToString(TxtBus.Text) == "") KdrBus = "";
            else KdrBus = Convert.ToString(TxtBus.Text);

            if (Convert.ToString(TxtGod.Text) == null || Convert.ToString(TxtGod.Text) == "") KdrGod = "";
            else KdrGod = Convert.ToString(TxtGod.Text);

            if (Convert.ToString(TxtRai.Text) == null || Convert.ToString(TxtRai.Text) == "") KdrRai = "";
            else KdrRai = Convert.ToString(TxtRai.Text);

            if (Convert.ToString(TxtSpz.Text) == null || Convert.ToString(TxtSpz.Text) == "") KdrSpz = "";
            else KdrSpz = Convert.ToString(TxtSpz.Text);

        // ------------------------------------------------------------------------------------------------------------------------     

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE KDR SET KDRARMGRU=@KDRARMGRU,KDRARMKAT=@KDRARMKAT,KDRARMSOS=@KDRARMSOS," +
                                        "KDRARMSBN=@KDRARMSBN,KDRARMBUS=@KDRARMBUS,KDRARMGDN=@KDRARMGDN,KDRARMPBK=@KDRARMPBK,KDRARMSPL=@KDRARMSPL " +
                                        "WHERE KDRKOD=@KDRKOD", con);
 //       cmd = new SqlCommand("ComSprKdrTitRep", con);
        // указать тип команды
  //      cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@KDRKOD", SqlDbType.VarChar).Value = KdrKod;
        cmd.Parameters.Add("@KDRARMGRU", SqlDbType.VarChar).Value = KdrGrp;
        cmd.Parameters.Add("@KDRARMKAT", SqlDbType.VarChar).Value = KdrKat;
        cmd.Parameters.Add("@KDRARMSOS", SqlDbType.VarChar).Value = KdrSos;
        cmd.Parameters.Add("@KDRARMSBN", SqlDbType.VarChar).Value = KdrZvn;
        cmd.Parameters.Add("@KDRARMBUS", SqlDbType.VarChar).Value = KdrBus;
        cmd.Parameters.Add("@KDRARMGDN", SqlDbType.VarChar).Value = KdrGod;
        cmd.Parameters.Add("@KDRARMPBK", SqlDbType.VarChar).Value = KdrRai;
        cmd.Parameters.Add("@KDRARMSPL", SqlDbType.VarChar).Value = KdrSpz;

        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        con.Close();

    //    ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);

    }
  

    //------------------------------------------------------------------------

</script>


<body >
 
    <form id="form1" runat="server">


       <asp:HiddenField ID="TekKdrIdn" runat="server" />
       <asp:HiddenField ID="TekCntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -6px; position: relative; top: -10px; width: 100%; height: 400px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>


           <hr />

      <table border="0" cellspacing="0" width="100%" cellpadding="0">
<!--  Место рожд, Место прописки ----------------------------------------------------------------------------------------------------------  -->  
                           <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Группа учета:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtGrp"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Категория учета:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtKat"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>

   <!--  Место прожив,Индекс ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;Состав:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtSos"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Воинское звание:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtZvn"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>


   <!--  Место прожив,Индекс ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;ВУС:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtBus"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Годность :</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtGod"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>

   <!--  Место прожив,Индекс ----------------------------------------------------------------------------------------------------------  --> 
                         <tr style="height:35px">                       
                             <td width="10%" class="PO_RowCap">&nbsp;РайВоенкомат:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtRai"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            

                             </td>

                             <td width="10%" class="PO_RowCap">&nbsp;Спецучет:</td>
                             <td width="35%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="TxtSpz"  width="100%" BackColor="White" Height="60px"
                                     TextMode="SingleLine" FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>                            
                             </td>

                        </tr>

                 </table>
           <hr />

              </asp:Panel>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать"/>
               </center>
           </asp:Panel>

<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>

    </form>

<%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ 
                                <asp:Button runat="server" ID="btnOK" Text="ОК" onclick="AddButton_Click" OnClientClick="requestPermission();" />
                               <obout:OboutButton runat="server" ID="OboutButton0"   
                                   FolderStyle="styles/grand_gray/OboutButton" Text="ОК" OnClick="AddButton_Click"
		                           OnClientClick="requestPermission();" />
    --%>

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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            width: 100%;
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
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
           .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
               hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>


</body>

</html>



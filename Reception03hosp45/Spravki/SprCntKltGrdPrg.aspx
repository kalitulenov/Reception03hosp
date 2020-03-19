<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>

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

       <%-- ============================  STYLES ============================================ --%>

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

        /*   For multiline textbox control:  */
        .ob_iTaMC textarea {
            font-size: 14px !important;
            font-family: Arial !important;
        }

        /*   For oboutButton Control: color: #0000FF !important; */

        .ob_iBC {
            font-size: 12px !important;
        }

        /*  For oboutTextBox Control: */

        .ob_iTIE {
            font-size: 12px !important;
        }

        /*------------------------- для checkbox  --------------------------------*/
        .excel-checkbox {
            height: 20px;
            line-height: 20px;
        }

        .tdText {
            font: 11px Verdana;
            color: #333333;
        }

        .option2 {
            font: 11px Verdana;
            color: #0033cc;
            background-color: #f6f9fc;
            padding-left: 4px;
            padding-right: 4px;
        }

        a {
            font: 11px Verdana;
            color: #315686;
            text-decoration: underline;
        }

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
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
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>
        <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

    </script>


</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string BuxKod;
    string BuxFrm;
    int ItgSum = 0;

    string GlvCntIdn;
    string GlvCntKey;
    string ComParKey = "";
    string ComParTxt = "";

    string ParKey = "";
    bool VisibleNo = false;
    bool VisibleYes = true;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

       //=====================================================================================
       GlvCntIdn = Convert.ToString(Request.QueryString["GlvCntIdn"]);
       GlvCntKey = Convert.ToString(Request.QueryString["GlvCntKey"]);
       BuxFrm = (string)Session["BuxFrmKod"];
       BuxKod = (string)Session["BuxKod"];
       //=====================================================================================

        if (!Page.IsPostBack)
        {

  //          ComParKey = (string)Request.QueryString["NodKey"];
  //          ComParTxt = (string)Request.QueryString["NodTxt"];
            LoadGridNode();
        }
    }


    //=============Заполнение массива первыми тремя уровнями===========================================================================================
    protected void LoadGridNode()
    {

        //      ComParKey = Convert.ToString(Session["HidNodKey"]);
        //      ComParTxt = Convert.ToString(Session["HidNodTxt"]);

        //           localhost.Service1Soap ws = new localhost.Service1SoapClient();
                DataSet ds = new DataSet("Menu");
                ds.Merge(InsSprCntUslIdn(MdbNam, BuxFrm, GlvCntIdn, GlvCntKey));
                GridUsl.DataSource = ds;
                GridUsl.DataBind();


    }
    
    
    
        // ======================================================================================
    public DataSet InsSprCntUslIdn(string BUXMDB, string BUXFRM, string KLTIDN, string CNTKEY)
        {
            bool flag;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("HspSprCntUslIdn", con);
            cmd = new SqlCommand("HspSprCntUslIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@CNTIDN", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@CNTKEY", SqlDbType.VarChar));
            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@CNTIDN"].Value = GlvCntIdn;
            cmd.Parameters["@CNTKEY"].Value = CNTKEY;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspSprCntUslIdn");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            try
            {
                flag = true;
            }
            // если запись не найден
            catch
            {
                flag = false;
            }
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
            return ds;
        }
    // ============================ чтение заголовка таблицы а оп ==============================================

</script>


<body>
    <form id="form1" runat="server">
        
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

       <asp:Panel ID="PanelAll" runat="server" ScrollBars="Vertical" BorderStyle="Double"  
                  Style="left: -6px; position: relative; top: -10px; width: 100%; height: 540px;">
       <%-- ============================  верхний блок  ============================================ --%>
           <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 510px;">

               <%-- ============================  для отображение оплаты =========================================== --%>
               <obout:Grid ID="GridUsl" runat="server"
                   ShowFooter="false"
                   CallbackMode="true"
                   Serialize="true"
                   FolderLocalization="~/Localization"
                   Language="ru"
                   AutoGenerateColumns="false"
                   FolderStyle="~/Styles/Grid/style_5"
                   ShowColumnsFooter="false"
                   KeepSelectedRecords="false"
                   AutoPostBackOnSelect="false"
                   AllowRecordSelection="false"
                   AllowAddingRecords="false"
                   AllowColumnResizing="true"
                   AllowSorting="false"
                   AllowPaging="false"
                   AllowPageSizeSelection="false"
                AllowDataAccessOnServer="true"
                   Width="100%"
                   PageSize="-1">
                   <ScrollingSettings ScrollHeight="450" />
                   <Columns>
                       <obout:Column ID="Column20" DataField="USLIDN" HeaderText="Код" Visible="false" Width="0%" />
                       <obout:Column ID="Column21" DataField="USLKOD" HeaderText="Код" Visible="false" Width="0%" />
                       <obout:Column ID="Column22" DataField="CNTUSLKEY" HeaderText="Ключ" Visible="false" Width="0%" />
                       <obout:Column ID="Column23" DataField="USLGRP001" HeaderText="Группа" ReadOnly="true" Width="15%" />
                       <obout:Column ID="Column24" DataField="USLNAM" HeaderText="Наименование" ReadOnly="true" Width="40%" />
                       <obout:Column ID="Column25" DataField="USLEDN" HeaderText="Ед.измерения" ReadOnly="true" Width="10%" />
                       <obout:Column ID="Column26" DataField="USLZEN" HeaderText="Цена" ReadOnly="true" Width="7%" />
                       <obout:Column ID="Column27" DataField="CNTUSLSUM" HeaderText="Сумма" Width="10%" />
                       <obout:Column ID="Column28" DataField="CNTUSLKOL" HeaderText="Кол-во" Width="10%" />
                       <obout:Column ID="Column29" DataField="CNTUSLALL" HeaderText="Все" Width="8%">
                           <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                       </obout:Column>
                   </Columns>
                   <Templates>

                       <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                           <Template>
                               <input type="text" name="TextBox1"
                                   class="excel-textbox"
                                   value='<%# Container.Value == "True" ? "   +" : " " %>'
                                   readonly="readonly" />
                           </Template>
                       </obout:GridTemplate>
                   </Templates>

               </obout:Grid>

               
           </asp:Panel>
           <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double"
               Style="left: -6px; position: relative; top: -10px; width: 100%; height: 30px;">
               <center>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" />
               </center>


           </asp:Panel>


       </asp:Panel>

    </form>

</body>
</html>



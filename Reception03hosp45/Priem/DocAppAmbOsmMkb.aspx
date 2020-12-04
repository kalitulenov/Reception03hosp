<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ============================  для почты  ============================================ --%>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>
<%-- ============================конец для почты  ============================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

 


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">
        // ------------------------  при корректировке ячейки занято ------------------------------------------------------------------
        function ExitFun() {
       //     var KasSumMem = "USL&" + document.getElementById('parKasSum').value + "&" + document.getElementById('parKasMem').value;
        //                        alert("GrfFio=" + GrfFio); 
       //     localStorage.setItem("KasSumMem", KasSumMem); //setter
            window.opener.HandlePopupPost("UslRef");
           self.close();
        //   window.parent.UslRef();
        }

        // -------изменение как EXCEL-------------------------------------------------------------------          

    </script>

</head>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        string BuxKod = "";
        int BuxUsl = 0;
        int BuxFlg;
        int BuxTyp;
        string BuxSid;
        string BuxFrm;
        string BuxStx;

        string BuxFio = "";
        string BuxKey;
        string BuxKey000;
        string BuxKey003;
        string BuxKey007;
        string BuxKey011;
        string BuxKey015;
        string whereClause = "";

        string AmbCrdIdn = "";
        //     string AmbCrdFio = "";

        string MdbNam = "HOSPBASE";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            // =====================================================================================
            //    BuxKod = Convert.ToInt32(Request.QueryString["BuxKod"]);
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //===================================================================================================
            if (!Page.IsPostBack)
            {

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

                whereClause = "";
                PopulateGridMkb();

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridMkb()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbMkbSelFin", con);
            cmd = new SqlCommand("HspAmbMkbSelFin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@AMBCRDIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
            cmd.Parameters.Add("@BUXCND", SqlDbType.VarChar).Value = whereClause;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbMkbSelFin");

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    TxtSoz.Text = Convert.ToString(ds.Tables[0].Rows[0]["SOZ"]);
                    TxtPvd.Text = Convert.ToString(ds.Tables[0].Rows[0]["OBR"]);
                    TxtSts.Text = Convert.ToString(ds.Tables[0].Rows[0]["STS"]);

                    GridMkb.DataSource = ds;
                    GridMkb.DataBind();
                }
            }
            catch
            {
            }

            con.Close();
        }

        // ============================ дублировать амб.карту ==============================================
        protected void MkbButtonOK_Click(object sender, EventArgs e)
        {
            //KltIin = Convert.ToString(parKltIin.Value);

            if (GridMkb.SelectedRecords != null)
            {
                string selectedUsl = "";
                //=====================================================================================
                foreach (Hashtable oRecord in GridMkb.SelectedRecords)
                {
                    selectedUsl += Convert.ToString(oRecord["MKBKOD"])+"&";
                }

                string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                // создание соединение Connection
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                // создание команды
                SqlCommand cmd = new SqlCommand("HspAmbMkbSelFinAdd", con);
                // указать тип команды
                cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                cmd.Parameters.Add("@GRFIDN", SqlDbType.Int, 4).Value = AmbCrdIdn;
                cmd.Parameters.Add("@MKBKODLST", SqlDbType.VarChar).Value = selectedUsl;
                try
                {
                    int numAff = cmd.ExecuteNonQuery();
                    // Получить вновь сгенерированный идентификатор.
                }
                finally
                {
                    con.Close();
                }
            }

            ExecOnLoad("ExitFun();");
        }

        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            whereClause = "";
            if (FndNam.Text != "")
            {
                whereClause += "MKBNAM LIKE '%" + FndNam.Text.Replace("'", "''") + "%'";
            }
            else
                    if (FndMkb.Text != "")
                    {
                        //      if (I > 1) whereClause += " AND ";
                        whereClause += "MKBKOD LIKE '" + FndMkb.Text.Replace("'", "''") + "%'";
                    }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");

                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                PopulateGridMkb();
            }
        }

        //------------------------------------------------------------------------
    </script>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
     
<body>
    <form id="form1" runat="server">

        <!--  конец -----------------------------------------------  -->
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parChkLst" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>
  <%-- ============================  шапка экрана ============================================ --%>
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None"
                Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 490px;">

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                       <tr>
                          <td style="width: 100%; height: 30px;">
                               <asp:Label ID="Label2" Text="СТАТУС:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                               <asp:TextBox ID="TxtSts" Width="85%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" />
                          </td>
                       </tr>

                       <td style="width: 100%; height: 30px;">
                            <asp:Label ID="Label5" Text="ПОВОД:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="TxtPvd" Width="85%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" />
                       </td>
                    </tr>
                     <tr>
                        <td style="width: 100%; height: 30px;">
                             <asp:Label ID="Label1" Text="СОЦ.ЗАЩ.:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="TxtSoz" Width="85%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" />
                      </td>
                    </tr>
                    <tr>
                        <td style="width: 100%; height: 30px;">
                            <asp:Label ID="Label4" Text="МКБ:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="FndMkb" Width="10%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" ForeColor="Blue" />
                            <asp:Label ID="Label3" Text="НАИМ:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="FndNam" Width="50%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" ForeColor="Blue" />
                            <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="13%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                     </tr>

                </table>


                <obout:Grid ID="GridMkb" runat="server"
                  CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_5" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
  AllowRecordSelection = "true"
  AllowMultiRecordSelection="true"
                AllowSorting="true"
	            Language = "ru"
	            PageSize = "-1"
	            AllowPaging="false"
          EnableRecordHover="false"
                AllowManualPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
                ShowColumnsFooter = "false" >
                <ScrollingSettings ScrollHeight="310" />
                    <Columns>
                        <obout:Column ID="Column01" DataField="MKBKOD" HeaderText="МКБ" Width="10%" />
                        <obout:Column ID="Column03" DataField="MKBNAM" HeaderText="НАМЕНОВАНИЕ" Width="75%" />
                        <obout:Column ID="Column04" DataField="MKBXRN" HeaderText="ХРН" Align="center" ReadOnly="true" Width="5%"  />
                        <obout:Column ID="Column05" DataField="MKBINF" HeaderText="ИНФ" Align="center" ReadOnly="true" Width="5%"  />
                        <obout:Column ID="Column06" DataField="MKBSOZ" HeaderText="СЗЗ" Align="left" ReadOnly="true" Width="5%"  />
                    </Columns>

                </obout:Grid>

            </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px; position: relative; top: 0px; width: 100%; height: 30px;">
                <center>
                    <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Записать" OnClick="MkbButtonOK_Click" />
                </center>
          </asp:Panel> 


    </form>

   <%-- ************************************* стили **************************************************** 
                 OnRowDataBound="GridMkb_RowDataBound"
      
       --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <style type="text/css">
        /* ------------------------------------- для цвета выбора--------------------------------*/
        .ob_gRS {
            color: #FF0000 !important;
            background-image: url(row_selected.png) !important;
            background-color: #ffd800 !important;
        }
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

        /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
        a.pg {
            font: 12px Arial;
            color: #315686;
            text-decoration: none;
            word-spacing: -2px;
        }

            a.pg:hover {
                color: crimson;
            }

        /*------------------------- форма без scrollbara --------------------------------*/
        html {
            overflow-y: hidden;
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

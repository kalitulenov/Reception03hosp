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
            var FioLst = document.getElementById('parChkLst').value;
           // alert('FioLst= ' + FioLst);

         //   var GrfFrm = document.getElementById('parBuxFrm').value;
         //   alert('GrfFrm= ' + GrfFrm);

            window.opener.HandlePopupPost(FioLst);
            self.close();

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

        string AmbCrdFio = "";

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
            parBuxFrm.Value = BuxFrm;
            AmbCrdFio = Convert.ToString(Request.QueryString["SelFioCnd"]);
            //    AmbCrdFio = Convert.ToString(Request.QueryString["AmbCrdFio"]);
            //    sdsStx.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            //===================================================================================================
            if (!Page.IsPostBack)
            {

                //    Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

                whereClause = "AMBCRD.GrfPth LIKE '" + AmbCrdFio.Replace("'", "''") + "%'";
                whereClause =  whereClause.Replace("*", "%");
                PopulateGridFio();
                //      Sapka.Text = AmbCrdFio;

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void PopulateGridFio()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT TOP 50 MAX(AMBCRD.GrfDat) AS DATLST, AMBCRD.GrfIIN AS IIN,AMBCRD.GrfPth AS FIO," +
                                            "MAX(SprCnt.CntNam) AS VIDOPL "+
                                            "FROM AMBCRD LEFT OUTER JOIN SprCnt ON AMBCRD.GrfStx = SprCnt.CntKey AND " +
                                                                                    "AMBCRD.GrfFrm = dbo.SprCnt.CntFrm " +
                                            "WHERE AMBCRD.GrfFrm = 1 AND SprCnt.CntLvl=0 " +
                                            "GROUP BY AMBCRD.GrfPth,AMBCRD.GrfIIN " +
                                            "HAVING " + whereClause +
                                            " ORDER BY FIO", con);
            //cmd = new SqlCommand("HspAmbFioSelFin", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //// создать коллекцию параметров
            //cmd.Parameters.Add("@BUXFRMKOD", SqlDbType.Int,4).Value = BuxFrm;
            //cmd.Parameters.Add("@BUXKOD", SqlDbType.Int,4).Value = BuxKod;
            //cmd.Parameters.Add("@AMBCRDIDN", SqlDbType.Int,4).Value = AmbCrdIdn;
            //cmd.Parameters.Add("@BUXCND", SqlDbType.VarChar).Value = whereClause;
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbFioSelFin");

            //TxtSoz.Text = Convert.ToString(ds.Tables[0].Rows[0]["SOZ"]);
            //TxtDig.Text = Convert.ToString(ds.Tables[0].Rows[0]["DIGMKB"])+' '+Convert.ToString(ds.Tables[0].Rows[0]["DIGMKBNAM"]);
            //TxtPvd.Text = Convert.ToString(ds.Tables[0].Rows[0]["OBR"]);
            //TxtSts.Text = Convert.ToString(ds.Tables[0].Rows[0]["STS"]);

            GridFio.DataSource = ds;
            GridFio.DataBind();

            con.Close();
        }

        // ============================ отправить на сервер запрос на печать амб.карты ==============================================
        protected void PrtButtonOK_Click(object sender, EventArgs e)
        {
            //KltIin = Convert.ToString(parKltIin.Value);

            string selectedFio = "";

            if (GridFio.SelectedRecords != null)
            {
                //=====================================================================================
                foreach (Hashtable oRecord in GridFio.SelectedRecords)
                {
                    selectedFio += Convert.ToString(oRecord["FIO"])+"*";
                }
            }
            parChkLst.Value = selectedFio;

            ExecOnLoad("ExitFun();");

            //       Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbLab003&TekDocIdn=" + AmbUslIdn);
        }

        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            // создание команды
            whereClause = "";
            if (FndFio.Text != "")
            {
                I = I + 1;
                whereClause = "AMBCRD.GrfPth LIKE '" + FndFio.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");

                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                //  Session["WHERE"] = whereClause;
                //  BuxKod = 0;
                PopulateGridFio();
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
         <asp:HiddenField ID="parBuxFrm" runat="server" />
        
        <%-- ============================  для передач значении  ============================================ --%>
  <%-- ============================  шапка экрана ============================================ --%>
            <asp:Panel ID="PanelLeft" runat="server" ScrollBars="None"
                Style="border-style: double; left: 10px; left: 0px; position: relative; top: 0px; width: 100%; height: 490px;">

                <table border="0" cellspacing="0" width="100%" cellpadding="0">
                    <tr>
                        <td style="width: 100%; height: 30px;">
                            <asp:Label ID="Label4" Text="ПОИСК:" runat="server" Width="10%" Font-Bold="true" Font-Size="Medium" />
                            <asp:TextBox ID="FndFio" Width="70%" Height="20" runat="server" Style="position: relative; font-weight: 600; font-size: medium;" ForeColor="Blue" />
                            <asp:Button ID="FndBtn" runat="server"
                                OnClick="FndBtn_Click"
                                Width="15%" CommandName="Cancel"
                                Text="Поиск" Height="25px"
                                Style="position: relative; top: 0px; left: 0px" />
                        </td>
                     </tr>
                </table>


                <obout:Grid ID="GridFio" runat="server"
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
                <ScrollingSettings ScrollHeight="410" />
                    <Columns>
<%--                        <obout:Column ID="Column01" DataField="USLKOD" HeaderText="+" ReadOnly="true" Visible="true" Width="5%" runat="server" >
				             <TemplateSettings TemplateID="TemplateWithCheckbox" />
				        </obout:Column>--%>
                        <obout:Column ID="Column01" DataField="FIO" HeaderText="ФИО" Width="40%"  />
                        <obout:Column ID="Column02" DataField="IIN" HeaderText="ИИН" Width="10%" />
                        <obout:Column ID="Column03" DataField="LSTDAT" HeaderText="ПОСЛ.ДАТА" Width="10%" />
                        <obout:Column ID="Column04" DataField="VIDOPL" HeaderText="ВИД ОПЛ" Width="40%" />
                    </Columns>

<%--			        <Templates>
			        	<obout:GridTemplate runat="server" ID="TemplateWithCheckbox">
				        	<Template>
				        		<asp:CheckBox runat="server" ID="ChkID" ToolTip="<%# Container.Value %>" />
				        	</Template>
				        </obout:GridTemplate>
		        	</Templates>--%>

                </obout:Grid>

            </asp:Panel>
        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" Style="left: 0px; position: relative; top: 0px; width: 100%; height: 30px;">
                <center>
                    <asp:Button ID="PrtButton" runat="server" CommandName="Add" Text="Показать амб.карты" OnClick="PrtButtonOK_Click" />
                </center>
          </asp:Panel> 


    </form>

   <%-- ************************************* стили **************************************************** 
                 OnRowDataBound="GridFio_RowDataBound"
      
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

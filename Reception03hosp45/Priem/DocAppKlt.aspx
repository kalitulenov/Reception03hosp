﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

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


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function OnClientDblClick(sender, iRecordIndex) {
//            alert("OnClientDblClick=" + iRecordIndex);
            var GrfIin = GridKlt.Rows[iRecordIndex].Cells[1].Value + "&" + GridKlt.Rows[iRecordIndex].Cells[2].Value + "&" + GridKlt.Rows[iRecordIndex].Cells[5].Value;
 //           var GrfFio = GridKlt.Rows[iRecordIndex].Cells[1].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[2].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[3].Value.substring(0,8) +"&"+
 //                        GridKlt.Rows[iRecordIndex].Cells[5].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[6].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[7].Value+"&"+
 //                        GridKlt.Rows[iRecordIndex].Cells[9].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[8].Value+"&"+GridKlt.Rows[iRecordIndex].Cells[10].Value.substring(0,8);
 //           alert("GrfIin=" + GrfIin);
            localStorage.setItem("FndIin", GrfIin); //setter
            window.opener.HandlePopupResult(GrfIin);
            self.close();
        }

        function OnClientSelect(selectedRecords) {

            var GrfIin = selectedRecords[0].CNTKLTIDN + "&" + selectedRecords[0].KLTFIO + "&" + selectedRecords[0].KLTIIN;
            //          alert("GrfIin=" + GrfIin);
            localStorage.setItem("FndIin", GrfIin); //setter
            window.opener.HandlePopupResult(GrfIin);
            self.close();

        }
    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
//        AmbCrdIdn = (string)Session["AmbCrdIdn"];


        //=====================================================================================
        Session["AmbCrdIdn"] = "0";

        if (!Page.IsPostBack)
        {
  //          FndFio.Text = Convert.ToString(Request.QueryString["TextBoxFio"]);
            
            FndFio.Text = "";
            string Cond = "";
            
            if (FndFio.Text != "")
            {
                Cond = FndFio.Text.Replace("*", "%");
                Cond = Cond.Replace(" ", "%") + "%";
//                Cond = Cond + "%";
                if (FndFio.Text.IndexOf("SELECT") != -1) return;
                if (FndFio.Text.IndexOf("UPDATE") != -1) return;
                if (FndFio.Text.IndexOf("DELETE") != -1) return;

                getGrid(Cond);
            }

        }

    }

    // ======================================================================================

    // ==================================== поиск клиента по фильтрам  ============================================
    protected void FndBtn_Click(object sender, EventArgs e)
    {
        
        string Cond = "";
        
        if (FndFio.Text != "")
        {
            Cond = FndFio.Text.Replace("*", "%");
            Cond = Cond.Replace(" ", "%") + "%";


            if (FndFio.Text.IndexOf("SELECT") != -1) return;
            if (FndFio.Text.IndexOf("UPDATE") != -1) return;
            if (FndFio.Text.IndexOf("DELETE") != -1) return;
           
            getGrid(Cond);
       }

   }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid(string Cond)
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspRefGlf003Klt", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@FNDFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@FNDFIO", SqlDbType.VarChar).Value = Cond;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspRefGlf003Klt");

        con.Close();

        GridKlt.DataSource = ds;
        GridKlt.DataBind();
    }
    
    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 560px;">
            <%-- ============================  шапка экрана ============================================ --%>
             <table border="0" cellspacing="0" width="100%" cellpadding="0">
                        <tr>
                            <td width="5%" class="PO_RowCap" align="left">Ф.И.О.:</td>
                            <td width="50%">
                                <asp:TextBox ID="FndFio" Width="100%" Height="20" runat="server"
                                    Style="position: relative; font-weight: 700; font-size: small;" />
                            </td>

                            <td width="5%">
                                <asp:Button ID="FndBtn" runat="server"
                                    OnClick="FndBtn_Click"
                                    Width="100%" CommandName="Cancel"
                                    Text="Поиск" Height="25px"
                                    Style="position: relative; top: 0px; left: 0px" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                  </table>

            <obout:Grid ID="GridKlt" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="true"
                KeepSelectedRecords="true"
                AllowSorting="true"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                AutoPostBackOnSelect="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="320" ScrollWidth="100%" />
                <ClientSideEvents OnClientSelect="OnClientSelect" ExposeSender="false"/>
                 <Columns>
                    <obout:Column ID="Column00" DataField="KLTIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column01" DataField="CNTKLTIDN" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="KLTFIO" HeaderText="Фамилия" Width="39%" />
                    <obout:Column ID="Column03" DataField="KLTBRT" HeaderText="Дата.р" DataFormatString="{0:yyyy}" Width="5%" />
                    <obout:Column ID="Column04" DataField="SEX" HeaderText="Пол" Width="5%" />
                    <obout:Column ID="Column05" DataField="KLTIIN" HeaderText="ИИН" Width="12%" />
                    <obout:Column ID="Column06" DataField="CNTKLTKRT" HeaderText="Карта" Width="10%" />
                    <obout:Column ID="Column07" DataField="KLTSTX" HeaderText="Страх" Width="10%" />
                    <obout:Column ID="Column08" DataField="CNTKLTKRTEND" DataFormatString="{0:dd/MM/yy}" HeaderText="Конец" Width="10%" />
                    <obout:Column ID="Column09" DataField="UBL" HeaderText="Удл" Width="9%" />
              </Columns>
 		    	
            </obout:Grid>
        </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>

<%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

     ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }



            a.pg
            {
                font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
            }

            a.pg:hover {
                color: crimson;
            }
    </style>

</body>
</html>



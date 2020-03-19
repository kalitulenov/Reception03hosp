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
<%@ Import Namespace="System.Collections.Generic" %>

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

         function OnClientSelect(selectedRecords) {
             var AmbCrdIdn = selectedRecords[0].GRFIDN;
             var AmbDlgNam = selectedRecords[0].DLGNAM;
  //                  alert("AmbDlgNam=" + AmbDlgNam);
   //          AmbWindow.setTitle(AmbCrdIdn);
   //          AmbWindow.setUrl("DocAppAmbArxOne.aspx?AmbCrdIdn=" + AmbCrdIdn);
   //          AmbWindow.Open();

             window.open("DocAppAmbArxOne.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDlgNam=" + AmbDlgNam,"ModalPopUp", "toolbar=no,width=1100,height=680,left=150,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");

         }




         //    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {
/*
             var GrfFrm = document.getElementById('ctl00$MainContent$HidBuxFrm').value;
             var GrfKod = document.getElementById('ctl00$MainContent$HidBuxKod').value;
             var GrfTyp = "КАС";    // document.getElementById('ctl00$MainContent$parDocTyp').value;
             var GrfBeg = document.getElementById('ctl00$MainContent$txtDate1').value;
             var GrfEnd = document.getElementById('ctl00$MainContent$txtDate2').value;


             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=BuxKasJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxKasJrn&TekDocIdn=" + GrfTyp + "&TekDocKod=" + GrfKod + "&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
*/
         }


 </script>

</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int AmbIdn;
    int AmbAmb;
    int AmbKod;
    int AmbKol;
    int AmbSum;
    int AmbKto;
    int AmbLgt;
    string AmbMem;



    int NumDoc;
    //        string TxtDoc;

    //        DateTime GlvBegDat;
    //        DateTime GlvEndDat;

    string AmbCrdIdn;
    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //           TxtDoc = (string)Request.QueryString["TxtSpr"];
 //       Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        //           sdsAmb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

        //============= начало  ===========================================================================================

        if (!Page.IsPostBack)
        {

            //               GlvBegDat = (DateTime)Session["GlvBegDat"];
            //               GlvEndDat = (DateTime)Session["GlvEndDat"];

            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);

            getGrid();
        }

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbDigFio", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbDigFio");

        con.Close();

        GridDig.DataSource = ds;
        GridDig.DataBind();
    }

    protected void PrtButton_Click(object sender, EventArgs e)
    {

    }

        // ======================================================================================
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIdn" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>
        <asp:TextBox ID="Sapka"
            Text="УСТАНОВЛЕННЫЕ ДИАГНОЗЫ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 380px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridDig" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="true"
                AllowSorting="true"
        FilterType="ProgrammaticOnly" 
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="360" />
 	            <ClientSideEvents ExposeSender="false" OnClientSelect="OnClientSelect"/>
               <Columns>
	        	    <obout:Column ID="Column0" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column1" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	               <obout:Column ID="Column2" DataField="DIGTYPNAM" HeaderText="ТИП ДИАГНОЗА" Width="10%" />
	                <obout:Column ID="Column3" DataField="DOCDIGKOD" HeaderText="МКБ" Width="5%" />
	                <obout:Column ID="Column4" DataField="DOCDIGNAM" HeaderText="ДИАГНОЗ" Wrap="true" Width="55%" />
<%--	                        <obout:Column ID="Column4" DataField="DOCMKBSOP001" HeaderText="МКБ доп" Width="5%" />
	                        <obout:Column ID="Column5" DataField="DOCDIGSOP" HeaderText="ДИАГНОЗ СОПУТСТВ."  Wrap="true" Width="20%" />--%>
	                <obout:Column ID="Column6" DataField="DLGNAM" HeaderText="СПЕЦИАЛЬНОСТЬ" Width="10%" />
	                <obout:Column ID="Column7" DataField="FI" HeaderText="ВРАЧ" Width="10%" />
	                <obout:Column ID="Column8" DataField="ORGKLTNAMSHR" HeaderText="КЛИНИКА" Width="5%" />
		        </Columns>
           </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <input type="button" name="PrtButton" value="Лист уточненного диагноза" id="PrtButton" onclick="PrtButton_Click();">
             </center>
  </asp:Panel>   
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AmbWindow" runat="server"  Url="DocAppAmbAmbLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="100" Top="0" Height="500" Width="1100" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>


        
           </form>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
     /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}
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
    </style>
</body>
</html>



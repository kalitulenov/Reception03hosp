<%@ Page Title="" Language="C#" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
 
         window.onload = function () {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
 //             alert("AmbCrdIdn=" + AmbCrdIdn);
 //           document.getElementById('ctl00$MainContent$mySpl_ctl00_ctl01_ButtonUsl').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "DocAppAmbArxOneOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
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

         function OsmButton_Click() {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];

             mySpl.loadPage("BottomContent", "DocAppAmbArxOneOsm.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function PrsButton_Click() {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
        //     alert("AmbCrdIdn=" + AmbCrdIdn);

             mySpl.loadPage("BottomContent", "DocAppAmbArxOnePrs.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function NazButton_Click() {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];

             mySpl.loadPage("BottomContent", "DocAppAmbArxOneNaz.aspx?AmbCrdIdn=" + AmbCrdIdn);
         }

         function DigButton_Click() {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];

             mySpl.loadPage("BottomContent", "DocAppAmbDigNoz.aspx?AmbCrdIdn=" + AmbCrdIdn);
        }

         function PrtButton_Click() {
             //    ==========================  ПЕЧАТЬ =============================================================================================
                 var QueryString = getQueryString();
                 var AmbCrdIdn = QueryString[1];
                 var AmbDlgNam = document.getElementById('parDlgNam').value;
          //       alert("AmbCrdIdn=" + AmbCrdIdn);
          //       alert("AmbDlgNam=" + AmbDlgNam);

                 var ua = navigator.userAgent;

                 var BuxFrm = document.getElementById('parBuxFrm').value;
                 //     alert(BuxFrm);
                 if (AmbDlgNam == "Семейный врач" ||
                     AmbDlgNam == "Врач общей практики" ||
                     AmbDlgNam == "Дежурный врач" ||
                     AmbDlgNam == "Врач терапевт")
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     if (BuxFrm == "1")
                         if (AmbDlgNam == "Врач эндокринолог")
                             window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtEnd&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                         else
                             window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                     else
                         window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPed&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             }
         
 </script>
</head>

    <script runat="server">

       //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;

        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        string AmbCrdIdn;
        string AmbDlgNam;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            AmbDlgNam = Convert.ToString(Request.QueryString["AmbDlgNam"]);
     //       parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
    //        Sapka.Text = TxtDoc;
    //        Session.Add("AmbCrdIdn", AmbCrdIdn);
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];
           //=====================================================================================
           parBuxFrm.Value = BuxFrm;
           parDlgNam.Value = AmbDlgNam;
        //=====================================================================================

            //============= начало  ===========================================================================================
            if (!Page.IsPostBack)
            {

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];
                //============= Установки ===========================================================================================
                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

        }

        // ==================================================================================================  
</script>


<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parDlgNam" runat="server" />

  <%-- ============================  шапка экрана ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Groove" ScrollBars="Vertical" 
             Style="left: 0%; position: relative; top: 0px; width: 99%; height: 550px;">

       <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">   
			    <TopPanel HeightMin="20" HeightMax="350" HeightDefault="23">
				    <Content>
                     <asp:Button ID="ButtonOsm" runat="server" Width="17%" CommandName="Push" Text="Прием и осмотр" OnClientClick="OsmButton_Click(); return false;"/>
                     <asp:Button ID="ButtonPrs" runat="server" Width="17%" CommandName="Push" Text="Направления" OnClientClick="PrsButton_Click(); return false"/>
                     <asp:Button ID="ButtonNaz" runat="server" Width="17%" CommandName="Push" Text="Назначения" OnClientClick="NazButton_Click(); return false"/>
                     <asp:Button ID="ButtonDig" runat="server" Width="17%" CommandName="Push" Text="Диагноз" OnClientClick="DigButton_Click(); return false"/>
                     <asp:Button ID="ButtonPrt" runat="server" Width="17%" CommandName="Push" Text="Печать Амб.Карты" OnClientClick="PrtButton_Click(); return false"/>
				    </Content>
			    </TopPanel>
                <BottomPanel HeightDefault="300" HeightMin="200" HeightMax="400">
				    <Content>
					   

				    </Content>
			    </BottomPanel>
       </obspl:HorizontalSplitter>
  
            
        </asp:Panel> 

<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
    </form>

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
    </style>

</body>
</html>
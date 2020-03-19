<%@ Page Title="" Language="C#" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>

<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.Common" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing" %>
<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
    <%-- ============================  JAVA ============================================ --%>

     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             TitButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
 
         window.onload = function () {
  //           alert("KdrKod=" + KdrKod);
             var KdrKod = document.getElementById('parKdrKod').value;
             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = 'bold';
             mySpl.loadPage("BottomContent", "SprKdrOneTit.aspx?KdrKod=" + KdrKod);
         };

         function getQueryString() {
             var queryString = [];
             var vars = [];
             var hash;
             var hashes = window.Obration.href.slice(window.Obration.href.indexOf('?') + 1).split('&');
  //           alert("hashes=" + hashes);
             for (var i = 0; i < hashes.length; i++) {
                 hash = hashes[i].split('=');
                 queryString.push(hash[0]);
                 vars[hash[0]] = hash[1];
                 queryString.push(hash[1]);
             }
             return queryString;
         }

         function TitButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;
 //            var property = document.getElementById("mySpl_ctl00_ctl01_ButtonTit");
 //            property.style.backgroundColor = "#7FFF00";
 //            property.style.fontStyle.bold = true;
             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

       //      alert("KdrKod=" + KdrKod);
             mySpl.loadPage("BottomContent", "SprKdrOneTit.aspx?KdrKod=" + KdrKod);
         }

         function ObrButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneObr.aspx?KdrKod=" + KdrKod);
         }

         function KatButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;
   //          alert("KdrKod=" + KdrKod);

             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneKat.aspx?KdrKod=" + KdrKod);
         }

         function NagButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneNag.aspx?KdrKod=" + KdrKod);
         }

         function SemButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneSem.aspx?KdrKod=" + KdrKod);
         }

         function ArmButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;

             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneArm.aspx?KdrKod=" + KdrKod);
         }

         function DlgButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;

             //            alert('KdrKod =' + KdrKod);
             document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = 'bold';
             document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
             document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneDlg.aspx?KdrKod=" + KdrKod);
         }

          function NakButton_Click() {
              var KdrKod = document.getElementById('parKdrKod').value;

              document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = 'bold';

             mySpl.loadPage("BottomContent", "SprKdrOneNkz.aspx?KdrKod=" + KdrKod);
          }

          function StgButton_Click() {
              var KdrKod = document.getElementById('parKdrKod').value;

              document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = 'bold';
              document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';

             mySpl.loadPage("BottomContent", "SprKdrOneStj.aspx?KdrKod=" + KdrKod);
         }


          function UsbButton_Click() {
              var KdrKod = document.getElementById('parKdrKod').value;

              document.getElementById('mySpl_ctl00_ctl01_ButtonTit').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonDlg').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonObr').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonKat').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNag').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonSem').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonUsb').style.fontWeight = 'bold';
              document.getElementById('mySpl_ctl00_ctl01_ButtonStg').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonArm').style.fontWeight = '';
              document.getElementById('mySpl_ctl00_ctl01_ButtonNak').style.fontWeight = '';
              mySpl.loadPage("BottomContent", "SprKdrOneUsv.aspx?KdrKod=" + KdrKod);
          }

         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
         //    ==========================  ПЕЧАТЬ =============================================================================================
         function PrtButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;
             var ua = navigator.userAgent;

             if (document.getElementById('MainContent_Sapka').value == "Семейный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач общей практики" ||
                 document.getElementById('MainContent_Sapka').value == "Врач педиатр" ||
                 document.getElementById('MainContent_Sapka').value == "Дежурный врач" ||
                 document.getElementById('MainContent_Sapka').value == "Врач терапевт")
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + KdrKod, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,Obration=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtCem&TekDocIdn=" + KdrKod, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
             else
                 if (ua.search(/Chrome/) > -1)
                     window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtSpz&TekDocIdn=" + KdrKod, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,Obration=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else
                     window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtSpz&TekDocIdn=" + KdrKod, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }

         function PrtPthButton_Click() {
             var KdrKod = document.getElementById('parKdrKod').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + KdrKod, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,Obration=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtPth&TekDocIdn=" + KdrKod, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }
 </script>
</head>

    
<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int NumDoc;
    string TxtDoc;

    DateTime GlvBegDat;
    DateTime GlvEndDat;

    string KdrKod;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        KdrKod = Convert.ToString(Request.QueryString["KdrKod"]);

        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        parBuxFrm.Value = BuxFrm;
        parKdrKod.Value = KdrKod;
        //============= начало  ===========================================================================================
        if (!Page.IsPostBack)
        {
            getDocNum();
        }

    }

    // ============================ чтение таблицы а оп ==============================================
    void getDocNum()
    {

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM SPRKDR WHERE KDRKOD=" + KdrKod, con);
        // указать тип команды
        //   cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //   cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = KdrKod;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspKdrIdn");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            TextBoxBrt.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["KDRBRT"]).ToString("dd.MM.yyyy");
            TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRIIN"]);
            TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIO"]);
            TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KDRTHN"]);

        }
    }

</script>


<body>
    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parKdrKod" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="Sapka" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  верхний блок  ============================================ --%>

        <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 65px;">

            <table border="1" cellspacing="0" width="100%">
                <tr>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">ИИН</td>
                    <td width="50%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Фамилия И.О.</td>
                    <td width="10%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Д.рож</td>
                    <td width="30%" align="center" style="font-weight: bold; background-color: yellow" class="PO_RowCap">Телефон</td>
                </tr>

                <tr>
                    <td width="10%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="50%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxFio" BorderStyle="None" Width="75%" Height="20" runat="server" ReadOnly="true" BackColor="#FFFFE0" />
                    </td>
                    <td width="10%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                    <td width="30%" class="PO_RowCap">
                        <asp:TextBox ID="TextBoxTel" BorderStyle="None" Width="100%" Height="20" runat="server" BackColor="#FFFFE0" />
                    </td>
                </tr>

            </table>
        </asp:Panel>
        <%-- ============================  средний блок  ============================================ --%>

        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="None"
            Style="left: 0%; position: relative; top: -10px; width: 100%; height: 475px;">

            <obspl:HorizontalSplitter ID="mySpl" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                <TopPanel HeightMin="20" HeightMax="400" HeightDefault="23">
                    <Content>
                        <asp:Button ID="ButtonTit" runat="server" Width="9%" CommandName="Push" Text="Титул" OnClientClick="TitButton_Click(); return false;" />
                        <asp:Button ID="ButtonDlg" runat="server" Width="10%" CommandName="Push" Text="Назначения" OnClientClick="DlgButton_Click(); return false" />
                        <asp:Button ID="ButtonObr" runat="server" Width="9%" CommandName="Push" Text="Образование" OnClientClick="ObrButton_Click(); return false;" />
                        <asp:Button ID="ButtonKat" runat="server" Width="10%" CommandName="Push" Text="Категория" OnClientClick="KatButton_Click(); return false" />
                        <asp:Button ID="ButtonNag" runat="server" Width="9%" CommandName="Push" Text="Награды" OnClientClick="NagButton_Click(); return false" />
                        <asp:Button ID="ButtonSem" runat="server" Width="10%" CommandName="Push" Text="Семейное пол." OnClientClick="SemButton_Click(); return false" />
                        <asp:Button ID="ButtonUsb" runat="server" Width="9%" CommandName="Push" Text="Усоверш." OnClientClick="UsbButton_Click(); return false" />
                        <asp:Button ID="ButtonStg" runat="server" Width="9%" CommandName="Push" Text="Стаж" OnClientClick="StgButton_Click(); return false" />
                        <asp:Button ID="ButtonArm" runat="server" Width="9%" CommandName="Push" Text="Воин.учет" OnClientClick="ArmButton_Click(); return false" />
                        <asp:Button ID="ButtonNak" runat="server" Width="9%" CommandName="Push" Text="Наказания" OnClientClick="NakButton_Click(); return false" />
                    </Content>
                </TopPanel>
                <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                    <Content>
                    </Content>
                </BottomPanel>
            </obspl:HorizontalSplitter>
        </asp:Panel>

    </form>

</body>

</html>


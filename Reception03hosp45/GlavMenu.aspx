<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.master" Inherits="OboutInc.oboutAJAXPage"%>

<%@ Register TagPrefix="oboutGrid" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%-- ================================================================================ --%>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
     <script src="/Scripts/jquery-1.4.1.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
          

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <script type="text/javascript">
     //    ------------------ смена логотипа ----------------------------------------------------------
 //        window.onload = function () {
        var LogStr = getQueryString();
  //      alert("LogStr=" + LogStr);
 //       if (LogStr == "0001" || LogStr == "0002" || LogStr == "0004") document.getElementById("ctl00_Image1").src = "Logo/LogoSofi.jpg";
 //       else document.getElementById("ctl00_Image1").src = "Logo/LogoDauaBig.jpg";


         function getQueryString() {
             var queryString = [];
             var vars = [];
             var hash;
             var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
             for (var i = 0; i < hashes.length; i++) {
                 hash = hashes[i].split('=');
                 //     queryString.push(hash[0]);
                 //     vars[hash[0]] = hash[1];
                 queryString.push(hash[1]);
             }
             return queryString;
        }

        function ReadEodMsg(KolMsg) {

            windowalert("У Вас " + KolMsg + " непрочитанных сообщений", "Сообщение", "info");

            var BuxKod = document.getElementById('MainContent_parBuxKod').value;
         //   var FrmKod = document.getElementById('parFrmKod').value;
            EodWindow.setTitle("Непрочитанные сообщения");
            EodWindow.setUrl("Delo/EodLstOneDoc.aspx?BuxKod=" + BuxKod);
            EodWindow.Open();
            return false;

            //self.close();
            //window.opener.WindowClose();
        }

        function EodClose() {
            //    alert("KofClose=1" + result);
            EodWindow.Close();
        }

    </script>

    <script runat="server">
        string BuxFrm;
        string BuxKod;
        string EodIdn = "";

        string MdbNam = "HOSPBASE";

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //=====================================================================================
            parBuxKod.Value = BuxKod;

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT TABEOD.EodIdn " +
                                            "FROM TABEOD INNER JOIN TABEODDTL ON TABEOD.EodIdn=TABEODDTL.EodDtlRef " +
                                                        "INNER JOIN SprEdoTyp ON TABEOD.EodTyp=SprEdoTyp.EdoTypKod " +
                                            "WHERE TABEOD.EodFrm=" + BuxFrm + "  AND RIGHT(TABEOD.EodSts,1) <> '1' AND TABEODDTL.EodDtlWho=" + BuxKod + " AND ISNULL(TABEODDTL.EodDtlRdy, 0)=0", con);

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbMsgDoc");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ExecOnLoad("ReadEodMsg("+Convert.ToString(ds.Tables[0].Rows.Count)+");");
            }
            con.Close();

        }

 </script>   


    <!--    
     <h2>
        Welcome to ASP.NET!  
     </h2>
     <h2>


        <span style="font-size: 28pt">
            <img src="Images/Map.bmp" alt="" 
            style="z-index: 100; left: 359px; position: static; top: 122px; margin-left: 439px; width: 498px; height: 398px;" /></span>
    </h2>
     -->  
       <%-- ============================  для передач значении  ============================================ --%>
             <asp:HiddenField ID="parBuxKod" runat="server" />

      <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="EodWindow" runat="server" Url="EodLstOneDoc.aspx" IsModal="true" ShowCloseButton="false" Status=""
             Left="200" Top="100" Height="450" Width="900" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Непрочитанное сообщение">
       </owd:Window>

     <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

</asp:Content>

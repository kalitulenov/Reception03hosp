<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" Inherits="OboutInc.oboutAJAXPage"%>

<%-- ================================================================================ --%>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace=" System.Xml.Linq" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

     <%--Google API reference--%>
   <%-- ============================  для отображение карты с адресами пациентов ============================================ 
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false">    </script>  --%>
       <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=abcdefg" type="text/javascript">    

       </script>

    <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
         });​
 
        
           window.onload = function () {
 //              alert(" 111=" + document.getElementById('map_canvas'));
               var infoWindow = new google.maps.InfoWindow;
               var onMarkerClick = function () {
                   var marker = this;
                   var latLng = marker.getPosition();
                   infoWindow.setContent(marker.title);
                   infoWindow.open(map, marker);
               };
               var latlng = new google.maps.LatLng(43.23615203452269, 76.94582284359433);
               var myOptions = { zoom: 5, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP };
               var map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
               var latlngbounds = new google.maps.LatLngBounds();
               var myLatLng = new google.maps.LatLng(43.23615203452269, 76.94582284359433);
               latlngbounds.extend(myLatLng);
               var marker = new google.maps.Marker({ position: myLatLng, map: map, title: 'ПРИМЕР' });
               map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds));
               google.maps.event.addListener(marker, 'click', onMarkerClick);
               map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds));

         };
  */      
       </script>
 
    <%-- ============================  JAVA ============================================ --%>

</head>

<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";
    DateTime GlvBegDat;
    DateTime GlvEndDat;
    string GlvBegDatTxt;
    string GlvEndDatTxt;
    

    string MdbNam = "HOSPBASE";

    int LabIdn;
    int LabAmb;
    int LabNum;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        /*
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
         * */
        BuxFrm = "1";

        //=====================================================================================

        if (!Page.IsPostBack)
        {

            Map_Load();
        }

    }

    // ============================ чтение таблицы а оп ==============================================

    // -------------------------------------------------------загружаем карту для показа поликлиник 
    public void Map_Load()
    {
        string Locations = "";
        string Header = "";
        string Footer = "";
        string Cond = "";

//        GlvBegDat = (DateTime)Session["GlvBegDat"];
//        GlvEndDat = (DateTime)Session["GlvEndDat"];

//        GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
//        GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
          GlvBegDatTxt = "14.06.2015";
          GlvEndDatTxt = "14.06.2015";


        // GlvBegDat = Convert.ToDateTime(Session["GlvBegDat"]);
        // GlvEndDat = Convert.ToDateTime(Session["GlvEndDat"]);
        /*
        var address = "123 something st, somewhere";
        var requestUri = string.Format("http://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false", Uri.EscapeDataString(address));

        var request = WebRequest.Create(requestUri);
        var response = request.GetResponse();
        var xdoc = XDocument.Load(response.GetResponseStream());

        var result = xdoc.Element("GeocodeResponse").Element("result");
        var locationElement = result.Element("geometry").Element("location");
        var lat = locationElement.Element("lat");
        var lng = locationElement.Element("lng");
        */

      
        
        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("HspAmb003Map", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
        cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;

        // создать коллекцию параметров
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmb003Map");
        // ------------------------------------------------------------------------------заполняем второй уровень
        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {


            Header = @"<script type='text/javascript'>
                        var infoWindow = new google.maps.InfoWindow;
                        var onMarkerClick = function () {
                            var marker = this;
                            var latLng = marker.getPosition();
                            infoWindow.setContent(marker.title);
                            infoWindow.open(map, marker);
                        };
                        var latlng = new google.maps.LatLng(43.23615203452269,76.94582284359433);
                        var myOptions = { zoom: 12, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP };
                        var map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
                        var latlngbounds = new google.maps.LatLngBounds();";

            Footer = @"map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds)); ";

            foreach (DataRow row in ds.Tables["HspAmb003Map"].Rows)
            {
                //  ========================================================================================================================================================
                
                /*
                var address = "ул. Айтеке Би 83, город Алматы ";
                var requestUri = string.Format("http://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false", Uri.EscapeDataString(address));

                var request = WebRequest.Create(requestUri);
                var response = request.GetResponse();
                Stream stream = response.GetResponseStream();
                //         XDocument xdoc = XDocument.Load(response.GetResponseStream());
                XDocument xdoc = XDocument.Load(new StreamReader(stream));

                var result = xdoc.Element("GeocodeResponse").Element("result");
                var locationElement = result.Element("geometry").Element("location");
                string Lat = Convert.ToString(locationElement.Element("lat"));
                string Long = Convert.ToString(locationElement.Element("lng"));
 //               string Latitude = Lat.Substring(5,Lat.Length-11);
 //               string Longitude = Long.Substring(5, Long.Length - 11);
                 * */

                string Latitude = "43.2577";
                string Longitude = "76.9373";

                //  ========================================================================================================================================================



                // пропуск пустого значения	 	
                //          if (row["ORGLAT"].ToString().Trim().Length == 0) continue;

                //          string Latitude = row["ORGLAT"].ToString();
                //          string Longitude = row["ORGLNG"].ToString();
                //           string Title = row["LEKAPTNAM"].ToString();
                string Title = "ПРИМЕР";

                // create a line of JavaScript for marker on map for this record	
                //        Locations += Environment.NewLine + " map.addOverlay(new GMarker(new GLatLng(" + Latitude + "," + Longitude + ")));";
                Locations += " var myLatLng = new google.maps.LatLng(" + Latitude + "," + Longitude + ");";
                Locations += " latlngbounds.extend(myLatLng);";
                Locations += " var marker = new google.maps.Marker({ position: myLatLng, map: map, title:'" + Title + "'});";
                Locations += " map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds));";
                Locations += " google.maps.event.addListener(marker, 'click', onMarkerClick);";


                // create a line of JavaScript for marker on map for this record	
                //        Locations += Environment.NewLine + " map.addOverlay(new GMarker(new GLatLng(" + Latitude + "," + Longitude + ")));";
                Locations += " var myLatLng = new google.maps.LatLng(" + Latitude + "," + Longitude + ");";
                Locations += " latlngbounds.extend(myLatLng);";
                Locations += " var marker = new google.maps.Marker({ position: myLatLng, map: map, title:'" + Title + "'});";
                Locations += " map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds));";
                Locations += " google.maps.event.addListener(marker, 'click', onMarkerClick);";

                
            }

            // construct the final script
            js.Text = Header + Locations + Footer + "<" + "/script>";

             UpdatePanel("CallbackPanel14");

        }
    }


    // ==================================== поиск клиента по фильтрам  ============================================
                
</script>


<body>
    <form id="form1" runat="server">
            <%-- ============================  для отображение карты с клиниками ============================================ --%>
                 <oajax:CallbackPanel ID="CallbackPanel14" runat="server">
                    <Content>
                        <%--Place holder to fill with javascript by server side code--%>
                        <asp:Literal ID="js" runat="server"></asp:Literal>
                        <%--Place for google to show your MAP--%>
                        <div id="map_canvas" style="width: 100%; height: 600px"></div>

                    </Content>
                </oajax:CallbackPanel>
        <br />
    </form>

</body>
</html>



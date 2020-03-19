<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница"%>

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

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
     <title>
          Adding Markers to a Google Maps from database
     </title>
 
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>

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
  
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        AmbCrdIdn = (string)Session["AmbCrdIdn"];
/*
        GlvBegDat = (DateTime)Session["GlvBegDat"];
        GlvEndDat = (DateTime)Session["GlvEndDat"];
        GlvBegDatTxt = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
        GlvEndDatTxt = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");
 */      
        /*
        BuxFrm = "1";
        GlvBegDatTxt = "14.06.2015";
        GlvEndDatTxt = "14.06.2015";
        */
        Map_Load();
    
    }

  
    // -------------------------------------------------------загружаем карту для показа поликлиник 
    public void Map_Load()
    {
        string Locations = "";
        string Header = "";
        string Footer = "";
        string Title = "";


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
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
       
 /*
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDatTxt;
        cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDatTxt;
*/
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
                        var map = new google.maps.Map(document.getElementById('mapArea'), myOptions);
                        var latlngbounds = new google.maps.LatLngBounds();";

            Footer = @"map.setCenter(latlngbounds.getCenter(), map.fitBounds(latlngbounds)); ";

            foreach (DataRow row in ds.Tables["HspAmb003Map"].Rows)
            {
                //  ========================================================================================================================================================
                // пропуск пустого значения	 	
                //          if (row["ORGLAT"].ToString().Trim().Length == 0) continue;

                //          string Latitude = row["ORGLAT"].ToString();
                //          string Longitude = row["ORGLNG"].ToString();
                Title = row["GRFPTH"].ToString(); // +" " + row["CMPSTSNAM"].ToString();


                //  ============================= из адреса получить координаты ===================================================================================
                var address = row["ADRPTH"].ToString();  // "ул. Сатпаева 30а, город Алматы "; //row["LEKAPTNAM"].ToString();  //
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
                string Latitude = Lat.Substring(5,Lat.Length-11);
                string Longitude = Long.Substring(5, Long.Length - 11);

 //               string Latitude = "43.2577";
 //               string Longitude = "76.9373";

                //  ========================================================================================================================================================

 //               string Title = "ПРИМЕР";

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

        }
    }


    // ==================================== поиск клиента по фильтрам  ============================================

    protected void Page_Load_Markers(object sender, EventArgs e)
    {
        string markers = GetMarkers();
        js.Text = @"<script type='text/javascript'>
                              function initialize() {
                                   var mapOptions = {center: new google.maps.LatLng(43.2577,76.9373),zoom: 12,mapTypeId: google.maps.MapTypeId.ROADMAP};
                                   var myMap = new google.maps.Map(document.getElementById('mapArea'),mapOptions);" + markers + @"}" + @"<" + @"/script>";
    }

    // ============================ чтение таблицы а оп ==============================================
    protected string GetMarkers()
    {
        string markers = "";
        using (SqlConnection con = new
        SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConString"].ConnectionString))
        {
            SqlCommand cmd = new SqlCommand("SELECT Latitude, Longitude, City FROM Locations", con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            int i = 0;

            while (reader.Read())
            {
                i++;
                markers +=
                @"var marker" + i.ToString() + @" = new google.maps.Marker({
              position: new google.maps.LatLng(" + reader["Latitude"].ToString() + ", " +
                reader["Longitude"].ToString() + ")," +
                @"map: myMap,
              title:'" + reader["City"].ToString() + "'});";
            }
        }
        return markers;
    }

                
</script>


<body onload="initialize()">
     <form id="form1" runat="server">
          <div id="mapArea" style="width: 1400px; height: 700px;">   </div>
                        <%--Place for google to show your MAP    <asp:Literal ID="Literal1" runat="server"></asp:Literal>                 --%>
            <asp:Literal ID="js" runat="server"></asp:Literal>
     </form>
</body>

</html>



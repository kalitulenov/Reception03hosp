<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Reception03hosp45.localhost" %>


<%-- ============================  для почты  ============================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
    <%-- ============================  для отображение карты с клиниками ============================================ --%>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false">
    </script>
  <!-- -------------------------------------------------------------------------------- -->

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

<!-- для диалога -------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
<%-- ============================  JAVA ============================================ --%>
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>

 
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        
        string BuxSid;
        string BuxFrm;
        string BuxKod;


        int NumDoc;
        string TxtDoc;

        DateTime GlvBegDat;
        DateTime GlvEndDat;

        int GlvDocIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            GlvDocTyp = Convert.ToString(Request.QueryString["NumSpr"]);
            parDocTyp.Value = Convert.ToString(Request.QueryString["NumSpr"]);
            TxtDoc = (string)Request.QueryString["TxtSpr"];
            Sapka.Text = TxtDoc;
            Session.Add("GlvDocTyp", GlvDocTyp.ToString());
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];
            //============= начало  ===========================================================================================
            switch (GlvDocTyp)
            {
                case "Прх":
                    GridCmp.Columns[3].HeaderText = "Организация";
                    break;
                case "Рсх":
                    GridCmp.Columns[3].HeaderText = "Организация";
                    break;
                default:
                    // Do nothing.
                    break;
            }

            // ViewState
            // ViewState["text"] = "Artem Shkolovy";
            // string Value = (string)ViewState["name"];
            GridCmp.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
            GridCmp.RowDataBound += new Obout.Grid.GridRowEventHandler(SumDoc);
            if (!Page.IsPostBack)
            {

                GlvBegDat = (DateTime)Session["GlvBegDat"];
                GlvEndDat = (DateTime)Session["GlvEndDat"];

                txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
                txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

                getGrid();

            }

        }

        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Reception03hosp45.localhost.Service1 ws = new Reception03hosp45.localhost.Service1();
            DataSet ds = new DataSet("Spr000");

            ds.Merge(ws.ComDocGet(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvBegDat, GlvEndDat));
            GridCmp.DataSource = ds;
            GridCmp.DataBind();
        }

        protected void PushButton_Click(object sender, EventArgs e)
        {
            Session["GlvBegDat"] = DateTime.Parse(txtDate1.Text);
            Session["GlvEndDat"] = DateTime.Parse(txtDate2.Text);

            GlvBegDat = (DateTime)Session["GlvBegDat"];
            GlvEndDat = (DateTime)Session["GlvEndDat"];

            Reception03hosp45.localhost.Service1 ws = new Reception03hosp45.localhost.Service1();
            ws.ComGlvBegEndDat(MdbNam, BuxSid, GlvBegDat, GlvEndDat);

            getGrid();
        }
        protected void CanButton_Click(object sender, EventArgs e)
        {
            //           Response.Redirect("~/GoBack/GoBack1.aspx");
            Response.Redirect("~/GlavMenu.aspx");

        }

         //============= Подтвердить оплату  ===========================================================================================
       void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int GlvDocIdn;
            GlvDocIdn = Convert.ToInt32(e.Record["DOCIDN"]);
            Reception03hosp45.localhost.Service1 ws = new Reception03hosp45.localhost.Service1();
            ws.ComDocDel(MdbNam, BuxSid, GlvDocIdn);
            getGrid();

        }

        // ---------Суммация  ------------------------------------------------------------------------
        public void SumDoc(object sender, GridRowEventArgs e)
        {
            if (e.Row.RowType == GridRowType.DataRow)
            {

                if (e.Row.Cells[4].Text == null | e.Row.Cells[4].Text == "") ItgDocKol += 0;
                else ItgDocKol += decimal.Parse(e.Row.Cells[4].Text);

                if (e.Row.Cells[5].Text == null | e.Row.Cells[5].Text == "") ItgDocSum += 0;
                else ItgDocSum += decimal.Parse(e.Row.Cells[5].Text);
            }
            else if (e.Row.RowType == GridRowType.ColumnFooter)
            {
                e.Row.Cells[3].Text = "Итого:";
                e.Row.Cells[4].Text = ItgDocKol.ToString();

                e.Row.Cells[5].Text = ItgDocSum.ToString();

            }
        }

        // -------------------------------------------------------загружаем карту для показа поликлиник 
        public void Map_Load()
        {
            String Locations = "";
            String Header = "";
            String Footer = "";
            String Cond = "";

 //           GlvBegDat = (DateTime)Session["GlvBegDat"];
 //           GlvEndDat = (DateTime)Session["GlvEndDat"];
            GlvBegDat = Convert.ToDateTime(Session["GlvBegDat"]);
            GlvEndDat = Convert.ToDateTime(Session["GlvEndDat"]);
 
            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("AptTopDstMap", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@GLVBEGDAT", SqlDbType.VarChar).Value = GlvBegDat;
            cmd.Parameters.Add("@GLVENDDAT", SqlDbType.VarChar).Value = GlvEndDat;
 
            // создать коллекцию параметров
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "AptTopDstMap");
            // ------------------------------------------------------------------------------заполняем второй уровень
            con.Close();

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

            foreach (DataRow row in ds.Tables["AptTopDstMap"].Rows)
            {
                // пропуск пустого значения	 	
                if (row["ORGLAT"].ToString().Trim().Length == 0) continue;

                string Latitude = row["ORGLAT"].ToString();
                string Longitude = row["ORGLNG"].ToString();
                string Title = row["LEKAPTNAM"].ToString();

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

           UpdatePanel("CallbackPanel11");

        }
        //------------------------------------------------------------------------
   </script>
 

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
 
  <script type="text/javascript">
      var myconfirm = 0;

      // ------------------------  при выборе вкладок  ------------------------------------------------------------------
      function SelectTab(tabId) {
          if (tabId == "item1") {
              //                  alert("item1");
              ContainerVisibility("divApt", true);
              ContainerVisibility("divAptMap", false);
              //        alert("item1-1 ");
              //         LoadMedUsl(LEKKOD = grid1.PageSelectedRecords[0].LEKKOD);
              document.getElementById('ctl00$MainContent$parAptTab').value = "Tab1";
              //        alert("item1-2 ");
          }
          else
              if (tabId == "item2") {
              ContainerVisibility("divApt", false);
              ContainerVisibility("divAptMap", true);

              document.getElementById('ctl00$MainContent$parAptTab').value = "Tab2";

              LoadAptMap();
          }

          ob_em_SelectItem(tabId);
      }

      // ------------------------  проверка на выбор мед услуги в первой вкладке ------------------------------------------------------------------       
      // ------------------------  скрывает и открывает вклади в зависимости от выбора ------------------------------------------------------------------       
      function ContainerVisibility(item, visibe) {
          var container = document.getElementById(item);
          if (visibe) {
              container.style.visibility = "visible";
              container.style.display = "Block";
          }
          else {
              container.style.visibility = "hidden";
              container.style.display = "none";
          }
      }

      // ------------------------  для отображения карты на 4-ой вкладке ------------------------------------------------------------------       
      function LoadAptMap() {
          //          alert("LoadMedUslHspMap=");
          //          ob_post.AddParam("LEKORG", 0);
          //          ob_post.post(null, "Map_Load", LoadMedUslHspMapXxx);
          ob_post.post(null, "Map_Load", function() { });
      }
      function OnClientDblClick(sender, iRecordIndex) {
          var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;

          // sender, добавляется при ExposeSender="true"
          //          alert("iRecordIndex=" + iRecordIndex);
          //          var elems = $("tr[class^='ob_gR'] td[class='ob_gC_I'] div[class='ob_gCc2']");
          //          var GlvDocIdn = $(elems[iRecordIndex]).text();
          var GlvDocIdn = Grid1.Rows[iRecordIndex].Cells[0].Value;
          var GlvDocDst = Grid1.Rows[iRecordIndex].Cells[7].Value;
          //    alert('GlvDocIdn=' + GlvDocIdn);
          //    alert('GlvDocPrv=#' + GlvDocPrv+'#'); 

          var index = -1;
          for (var i = 0; i < Grid1.Rows.length; i++) {
               if (Grid1.Rows[i].Cells[0].Value == GlvDocIdn) {
                   index = i;
                   break;
                  }
              }

              document.getElementById('forDstContent').innerHTML = "Товар доставлен ?";
              document.getElementById('forDstHidden').value = index;
          forDst.Open();
          return false;
      }

      function forDstOnClick() {
          myconfirm = 1;
          Grid1.delete_record(document.getElementById('forDstHidden').value);
          forDst.Close();
          myconfirm = 0;
      }
        
 </script>
 
 
 
 
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="parAptTab" runat="server" />
  
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             
<%--             <div style="float:left;  width: 50%; position: relative; left: 20px; color: green; "> </div>   --%>
          <center>
             <asp:Label ID="Label1" runat="server" Text="Период" ></asp:Label>  
             
             <asp:TextBox runat="server" id="txtDate1" Width="80px" BackColor="#FFFFE0" />

			 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate1"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
			 
             <ASP:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center> 
            
        </asp:Panel> 
<%-- ============================  средний блок  ============================================ --%>
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 400px;">
	    
	        <oem:EasyMenu ID="EasymenuTabStrip" runat="server" ShowEvent="Always" StyleFolder="~/styles/TabStrip0"
                Position="Horizontal" Width="100%" SelectedItemId="item1">

                <Components>
                    <oem:MenuItem InnerHtml="<span style='cursor:default'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Заявки &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>" OnClientClick="SelectTab('item1')" ID="item1"></oem:MenuItem>
                    <oem:MenuItem InnerHtml="<span style='cursor:default'>Аптеки на карте</span>" OnClientClick="SelectTab('item2')" ID="item2"></oem:MenuItem>
                </Components>
            </oem:EasyMenu>

            <input type="hidden" id="hiddenServerEvent" runat="server" />

          <%-- ============================  для отображение вкладок услуг ============================================ --%>
       <div id="divCmp" style="visibility: visible; display: block; height: 80%;">

           <oajax:CallbackPanel ID="CallbackPanel10" runat="server">
               <Content>
                   <obout:Grid ID="GridCmp" runat="server"
                       CallbackMode="true"
                       Serialize="true"
                       FolderStyle="~/Styles/Grid/style_5"
                       AutoGenerateColumns="false"
                       ShowTotalNumberOfPages="false"
                       FolderLocalization="~/Localization"
                       AllowAddingRecords="false"
                       Language="ru"
                       PageSize="-1"
                       AllowPaging="false"
                       Width="100%"
                       AllowPageSizeSelection="false"
                       ShowColumnsFooter="true">
                       <ClientSideEvents ExposeSender="true"
                           OnClientDblClick="OnClientDblClick"
                           OnBeforeClientDelete="OnBeforeDelete" />
                       <Columns>
                           <obout:Column ID="Column1" DataField="DOCIDN" HeaderText="Идн" Visible="false" Width="0%" />
                           <obout:Column ID="Column2" DataField="DOCNUM" HeaderText="Номер" Align="right" Width="8%" />
                           <obout:Column ID="Column3" DataField="DOCDAT" HeaderText="Дата" DataFormatString="{0:dd/MM/yy}" Width="11%" />
                           <obout:Column ID="Column4" DataField="FRM" HeaderText="Поставщик" Width="36%" />
                           <obout:Column ID="Column5" DataField="DOCKOL" HeaderText="Кол-во" Width="8%" Align="right" />
                           <obout:Column ID="Column6" DataField="DOCSUM" HeaderText="Сумма" Width="10%" Align="right" DataFormatString="{0:F2}" />
                           <obout:Column ID="Column7" DataField="BUX" HeaderText="Ответст." Width="15%" />
                           <obout:Column ID="Column8" DataField="FLG" HeaderText="Проведен" Width="6%" />
                           <obout:Column ID="Column9" DataField="" HeaderText="Корр" Width="6%" AllowEdit="false" AllowDelete="true" runat="server" />
                       </Columns>
                   </obout:Grid>
               </Content>
           </oajax:CallbackPanel>
       </div>
            <%-- ============================  для отображение карты с клиниками ============================================ --%>
            <div id="divCmpMap" style="visibility: hidden; display: none; height:80%;">
                <oajax:CallbackPanel ID="CallbackPanel11" runat="server" >
                    <Content>
                        <%--Place holder to fill with javascript by server side code--%>
                        <asp:Literal ID="js" runat="server"></asp:Literal>
                        <%--Place for google to show your MAP--%>
                        <div id="map_canvas" style="width: 100%; height:400px"></div>

                    </Content>
                </oajax:CallbackPanel>
            </div>
        </asp:Panel>
	     
	     
	        

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад" onclick="CanButton_Click"/>
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
<%-- =================  для подтверждение оплаты ============================================ --%>
     <owd:Dialog ID="forDst" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="forDstContent"></div>
                <input type="hidden" value="" id="forDstHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="Да" onclick="forDstOnClick();" />
                                <input type="button" value="Нет" onclick="forDst.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
    
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

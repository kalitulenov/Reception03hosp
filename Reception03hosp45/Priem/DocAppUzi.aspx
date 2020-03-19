<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrPusto.Master" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
    <%-- ============================  JAVA ============================================ --%>

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
    </style>


    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
/*
         $(document).ready ( function(){
             alert("ok");
             OsmButton_Click();
         });​
         */

         //    ------------------ смена логотипа ----------------------------------------------------------
/* 
         window.onload = function () {
             var QueryString = getQueryString();
             var AmbCrdIdn = QueryString[1];
             mySpl.loadPage("BottomContent", "DocAppUziLst.aspx?AmbCrdIdn=" + AmbCrdIdn);
         };
*/
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


         function GridUzi_Edit(sender, record) {
             //          alert("GridUzi_Edit=");

             //            alert("record.STRUSLKEY=" + record.STRUSLKEY);
             TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
             TemplateGrpKey.value(record.STRUSLKEY);
             TemplateGrpKey._preventDetailLoading = false;
             TemplateGrpKey._populateDetail();

             return true;
         }

                
         function GridUzi_ClientEdit(sender, record) {
             //           alert("GridUzi_ClientEdit");
             var AmbUziIdn = record.USLIDN;
//             UziWindow.setTitle(AmbUziIdn);
//             UziWindow.setUrl("DocAppUziOne.aspx?AmbUslIdn=" + AmbUziIdn);
//            UziWindow.setUrl("DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn);
//            UziWindow.Open();

            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1) 
                window.open("/Priem/DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else 
                window.showModalDialog("/Priem/DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
            
             return false;
         }

         function GridUzi_ClientInsert(sender, record) {
    //                   alert("GridUzi_ClientInsert");
             var AmbUziIdn = 0;
  //           UziWindow.setTitle(AmbUziIdn);
  //           UziWindow.setUrl("DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn);
  //           UziWindow.setUrl("/Example/Aspose_exm.aspx");
  //           UziWindow.Open();

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1) 
                 window.open("/Priem/DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else 
                 window.showModalDialog("/Priem/DocAppUziOneAspose.aspx?AmbUslIdn=" + AmbUziIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
             
             return false;
         }

         function WindowClose() {
      //                  alert("GridNazClose");
             var jsVar = "dotnetcurry.com";
             __doPostBack('callPostBack', jsVar);
         }
         // ------------------------  получает сведение из диалогового окна  ------------------------------------------------------------------
         function HandlePopupResult(result) {
                 alert("result of popup is: " + result);
                 var jsVar = "dotnetcurry.com";
                 __doPostBack('callPostBack', jsVar);


             //   document.getElementById('ctl00$MainContent$TextBoxFio').value = result;
             //   document.getElementById('MainContent_HidTextBoxFio').value = result;
         }
         
         // --------------  ИЗМЕНИТЬ ДАТУ ПРИЕМА ----------------------------
         function onDateChange(sender, selectedDate) {
             //          alert("sender=" + sender + "  " + selectedDate);
             var DatDocMdb = 'HOSPBASE';
             var DatDocRek;
             var DatDocTyp = 'Sql';

             var dd = selectedDate.getDate();
             var mm = selectedDate.getMonth() + 1;
             if (mm < 10) mm = '0' + mm;
             var yy = selectedDate.getFullYear();

             var DatDocVal = dd + "." + mm + "." + yy;

             //             var GrfDocRek='GRFCTRDAT';
             //           alert("DatDocVal " + DatDocVal);
             //             var GrfDocTyp = 'Dat';

             var AmbCrdIdn = document.getElementById('MainContent_HidAmbCrdIdn').value;
             //           alert("AmbCrdIdn " + AmbCrdIdn);

             SqlStr = "UPDATE AMBCRD SET GRFDAT=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE GRFIDN=" + AmbCrdIdn;
         //    alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { alert("ERROR=" + SqlStr); }
             });

         }
         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
 </script>

<script runat="server">

        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        
        int UziIdn;
        int UziAmb;
        int UziKod;
        int UziKol;
        int UziSum;
        int UziKto;
        int UziLgt;
        string UziMem;

        int NumDoc;

        string AmbCrdIdn;
        string AmbCntIdn;
        string GlvDocTyp;
        string MdbNam = "HOSPBASE";
        decimal ItgDocSum = 0;
        decimal ItgDocKol = 0;

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            AmbCntIdn = Convert.ToString(Request.QueryString["AmbCntIdn"]);
            //           TxtDoc = (string)Request.QueryString["TxtSpr"];
      //      Session.Add("AmbCrdIdn", AmbCrdIdn);
            //=====================================================================================
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            BuxSid = (string)Session["BuxSid"];
            //=====================================================================================
 //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

            GridUzi.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
            GridUzi.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            
        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  // && parCrdIdn.Value == ""
        {
            Session["AmbUslIdn"] = "Post";
            PushButton();
        }
        else Session["PostBack"] = "no";

            //============= начало  ===========================================================================================
            
            if (!Page.IsPostBack)
            {

 //               GlvBegDat = (DateTime)Session["GlvBegDat"];
 //               GlvEndDat = (DateTime)Session["GlvEndDat"];
                //============= Установки ===========================================================================================
                if (AmbCrdIdn == "0")  // новый документ
                {

                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("HspAmbCrdAdd", con);
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@CRDFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@CRDBUX", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "УЗИ";
                    cmd.Parameters.Add("@CNTIDN", SqlDbType.VarChar).Value = AmbCntIdn;
                    cmd.Parameters.Add("@CRDIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@CRDIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        //      Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));

                        AmbCrdIdn = Convert.ToString(cmd.Parameters["@CRDIDN"].Value);
              //          parCrdIdn.Value = AmbCrdIdn;
                    }
                    finally
                    {
                        con.Close();
                    }
                    
                }

                Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
                HidAmbCrdIdn.Value = AmbCrdIdn;
            }

            getDocNum();
            getGrid();

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
            SqlCommand cmd = new SqlCommand("HspAmbUslStxIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbUslStxIdn");

            con.Close();

            GridUzi.DataSource = ds;
            GridUzi.DataBind();
        }

        void PushButton()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            // создание команды
            SqlCommand cmd = new SqlCommand("HspDocAppLstSumIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
            cmd.ExecuteNonQuery();

            con.Close();
        }

        // ============================ кнопка новый документ  ==============================================

        protected void AddButton_Click(object sender, EventArgs e)
        {
            //            localhost.Service1SoapClient ws = new localhost.Service1SoapClient();
            //            ws.ComDocAdd(BuxBas, BuxSid, GlvDocTyp);

            //           GlvDocIdn= Convert.ToInt32(ds.Tables[0].Rows[0]["GLVDOCIDN"]);
            //  передача через SESSION не работает
            //            Session.Add("CounterTxt", (string)"0");
            //  передача через ViewState не работает
            //            ViewState["CounterTxt"] = "0";

        }

        protected void CanButton_Click(object sender, EventArgs e)
        {
          Response.Redirect("~/GoBack/GoBack1.aspx");
          //  Response.Redirect("~/GlavMenu.aspx");

        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNum()
        {
            int KodOrg = 0;
            int KodCnt = 0;

            string KeyOrg;
            string KeyCnt;
            int LenCnt;
            string SqlCnt;


            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbCrdIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbCrdIdn");

            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
            TextBoxDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
            TextBoxTim.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["HURMIN"]).ToString("hh:mm");
            TextBoxKrt.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPOL"]);
            TextBoxFio.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFPTH"]);
            TextBoxFrm.Text = Convert.ToString(ds.Tables[0].Rows[0]["RABNAM"]);
            TextBoxIns.Text = Convert.ToString(ds.Tables[0].Rows[0]["STXNAM"]);
            TextBoxIIN.Text = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
            TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);

            /* для просмотра IMAGE ============================================================================ */
            string path = @"C:\BASEPICKLT\"+ TextBoxIIN.Text+".jpg";
            // Проверить входной файл ----------------------------------------------------------------
            string[] files = Directory.GetFiles(@"C:\BASEPICKLT","*.jpg"); // список всех jpg файлов в директории C:\temp
            string Per = "No";
            // вывод первого списка файлов
            if (files.Length > 0)
            {
                for (int i = 0; i < files.Length; i++)
                {
                    if (path == files[i])
                    {
                        Per = "Yes";
                        break;
                    }
                }
            }
            if (Per == "Yes") TxtImg.ImageUrl = "DynamicImage.aspx?path=" + path;
            else TxtImg.ImageUrl = "~/DoctorFoto/NoFoto.jpg";
            //     TxtImg.Width = 250;
            //     TxtImg.Height = 250;

            }
        }

        void InsertRecord(object sender, GridRecordEventArgs e)
        {
            getGrid();
        }

        void UpdateRecord(object sender, GridRecordEventArgs e)
        {
            getGrid();
        }

        void RebindGrid(object sender, EventArgs e)
        {
            getGrid();
        }

        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            UziIdn = Convert.ToInt32(e.Record["USLIDN"]);

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmdDtl = new SqlCommand("DELETE FROM AMBUSLDTL WHERE USLDTLREF=" + UziIdn, con);
            cmdDtl.ExecuteNonQuery();
            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE USLIDN=" + UziIdn, con);
            cmd.ExecuteNonQuery();

            con.Close();

            getGrid();
        }

   /*
        protected void PrtButton_Click(object sender, EventArgs e)
        {

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbUslBlnNum", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@NAZAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
            cmd.Parameters.Add("@NAZBUX", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@NAZTYPBLN", SqlDbType.Int, 4).Value = 4;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();

            getGrid();
        }
*/
        // ======================================================================================
</script>

      <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />

      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:3%; position: relative; top: 0px; width: 80%; height: 65px;">

     <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="27%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№ инв</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Телефон</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
              </tr>
              
               <tr>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="80px" Height="20" RunAt="server" BackColor="#FFFFE0" />
			          <obout:Calendar ID="Calendar3" runat="server"
			 	                    	StyleFolder="/Styles/Calendar/styles/default" 
    	          					    DatePickerMode="true"
    	           					    ShowYearSelector="true"
                					    YearSelectorType="DropDownList"
    	           					    TitleText="Выберите год: "
    	           					    CultureName = "ru-RU"
                					    TextBoxId = "TextBoxDat"
                                        OnClientDateChanged="onDateChange"   
                					    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="27%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTel" BorderStyle="None" Width="100%" Height="20" RunAt="server" Style="position: relative; font-weight: 700; font-size: medium;" BackColor="#FFFFE0" />
                  </td>
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>
            
   </table>  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="УЛЬТРАЗВУКОВОЕ ИССЛЕДОВАНИЕ" 
             BackColor="yellow"  
             Font-Names="Verdana" 
             Font-Size="12px" 
             Font-Bold="True" 
             ForeColor="Blue" 
             style="top: -5px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>

        </asp:Panel>     
<%-- ============================  средний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" 
             Style="left: 3%; position: relative; top: 0px; width: 80%; height: 550px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUzi" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                OnRebind="RebindGrid" OnInsertCommand="InsertRecord"  OnDeleteCommand="DeleteRecord" OnUpdateCommand="UpdateRecord"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="460" />
                <ClientSideEvents 
		                                OnBeforeClientEdit="GridUzi_ClientEdit" 
		                                OnBeforeClientAdd="GridUzi_ClientInsert"
		                                ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column1" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="USLKAS" HeaderText="№ КАСС" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="StxNam" HeaderText="ВИД ОПЛ" Width="5%" />
                    <obout:Column ID="Column5" DataField="USLTRF" HeaderText="ТАРИФ" Width="7%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column6" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="43%" Align="left" />
                    <obout:Column ID="Column7" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="5%" />

                    <obout:Column ID="Column8" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column9" DataField="USLKTO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>
                    
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                    
                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>								
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Описан" onclick="GridUzi.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridUzi.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUzi.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUzi.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUzi.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUzi.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUzi.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
                   			
                    <obout:GridTemplate runat="server" ID="TemplateKtoNam">
                        <Template>
                            <%# Container.DataItem["FI"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditKtoNam" ControlID="ddlKtoNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlKtoNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsKto" CssClass="ob_gEC" DataTextField="FI" DataValueField="BuxKod">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
 
       </asp:Panel> 

       <div style="left: 84%; position: relative; top: -620px;  width: 210px; height: 158px; border:double">
            <asp:Image ID="TxtImg" runat="server" ImageUrl="~/DoctorFoto/NoFoto.jpg"  
                 style="top:0px; left: 0px; width: 100%; height: 100%; margin-left: 0px" /> 
       </div> 
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
                 <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
             </center>
             

  </asp:Panel>              
     
    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

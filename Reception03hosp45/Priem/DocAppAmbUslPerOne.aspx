<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

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
                      mySpl.loadPage("BottomContent", "DocAppUslLst.aspx?AmbCrdIdn=" + AmbCrdIdn);
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

         function TstButton_Click() {
  //           alert("TstButton");
             //          alert(ob_spl_isElementInsideSplitter(document.getElementById('ctl00$MainContent$Sapka')));
             //           alert(ob_spl_isElementInsideSplitterContainer(document.getElementById('ctl00$MainContent$loginDialog$txtOrgNam').value));
             //          alert(ob_spl_isElementInsideSplitterContainer(document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam')).value);
             //     alert(ob_spl_elementGetPosition(document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam')));
             //          alert(mySpl.GetWindow("RightContent").document.getElementById('ctl00$MainContent$Sapka'));
             //           alert(Webbrowser1.Document.getElementById('ctl00$MainContent$loginDialog_txtOrgNam').SetAttribute(value));
         }

         function GridUsl_rsx(rowIndex) {
  //           alert("GridUsl_rsx=");
             var AmbUslIdn = GridUsl.Rows[rowIndex].Cells[0].Value;

             RsxWindow.setTitle(AmbUslIdn);
             RsxWindow.setUrl("DocAppAmbUslRsx.aspx?AmbUslIdn=" + AmbUslIdn);
             RsxWindow.Open();
             return true;
         }

         function GridUsl_ClientEdit(sender, record) {
             var AmbUslNam = record.USLNAM;
             var AmbUslIdn = record.USLIDN;
             var AmbCrdIdn = record.USLAMB;
             var AmbUslKod = record.USLKOD;

             //       alert("GridUsl_ClientEdit=" +AmbUslNam.indexOf("форма 061"));
        //     alert("AmbUslNam=" + AmbUslNam);
       //      alert("AmbUslIdn=" + AmbUslIdn);
       //      alert("AmbCrdIdn=" + AmbCrdIdn);
        //     alert("AmbUslKod=" + AmbUslKod);
/*
           if (AmbUslNam.indexOf("форма 061") > 0 || AmbUslNam.indexOf("форма 062") > 0)
             {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1) 
                     window.open("DocAppAmbUsl061.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn + "&AmbUslKod=" + AmbUslKod + "&AmbUslNam=" + AmbUslNam, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                 else 
                     window.showModalDialog("DocAppAmbUsl061.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbUslIdn=" + AmbUslIdn + "&AmbUslKod=" + AmbUslKod + "&AmbUslNam=" + AmbUslNam, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
             }
             else
             {
                 UslWindow.setTitle(AmbUslIdn);
                 UslWindow.setUrl("DocAppAmbUslOne.aspx?AmbUslIdn=" + AmbUslIdn);
                 UslWindow.Open();
             }
*/
             
             UslWindow.setTitle(AmbUslIdn);
             UslWindow.setUrl("DocAppAmbUslOne.aspx?AmbUslIdn=" + AmbUslIdn);
             UslWindow.Open();

             return false;
         }

         function GridUsl_ClientInsert(sender, record) {
 //                      alert("GridUsl_ClientInsert");
             var AmbUslIdn = 0;
             UslWindow.setTitle(AmbUslIdn);
             UslWindow.setUrl("DocAppAmbUslOne.aspx?AmbUslIdn=" + AmbUslIdn);
             UslWindow.Open();

             return false;
         }

         function WindowClose() {
             var jsVar = "callPostBack";
             __doPostBack('callPostBack', jsVar);
             //  __doPostBack('btnSave', e.innerHTML);
         }
         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       

         function PrtZnrButton_Click() {
             var AmbCrdIdn = document.getElementById('parCrdIdn').value;
             var ua = navigator.userAgent;

             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtDntZakNar&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtDntZakNar&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");

         }
 </script>

</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int UslIdn;
    int UslAmb;
    int UslKod;
    int UslKol;
    int UslSum;
    int UslKto;
    int UslLgt;
    string UslMem;



    int NumDoc;
    //        string TxtDoc;

    //        DateTime GlvBegDat;
    //        DateTime GlvEndDat;

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
 //       Session.Add("AmbCrdIdn", AmbCrdIdn);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

        GridUsl.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridUsl.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridUsl.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  // && parCrdIdn.Value == ""
        {
            Session["AmbUslIdn"] = "Post";
            PushButton();
  //          AmbCrdIdn = parCrdIdn.Value;
        }
        else Session["PostBack"] = "no";

        //============= начало  ===========================================================================================

        if (!Page.IsPostBack)
        {

            //               GlvBegDat = (DateTime)Session["GlvBegDat"];
            //               GlvEndDat = (DateTime)Session["GlvEndDat"];
            //============= Установки ===========================================================================================
            /*
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
                cmd.Parameters.Add("@CRDTYP", SqlDbType.VarChar).Value = "АМБ";
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
                }
                finally
                {
                    con.Close();
                }
            }

            Session["AmbCrdIdn"] = Convert.ToString(AmbCrdIdn);
*/
            parCrdIdn.Value = AmbCrdIdn;
        }

            getGrid();

        //=====================================================================================
        /*
                    if (!Page.IsPostBack)
                    {

                        getGrid();
                    }
        */

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

        GridUsl.DataSource = ds;
        GridUsl.DataBind();
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

    // ============================ чтение заголовка таблицы а оп ==============================================

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
        UslIdn = Convert.ToInt32(e.Record["USLIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmdDtl = new SqlCommand("DELETE FROM AMBUSLDTL WHERE USLDTLREF=" + UslIdn, con);
        cmdDtl.ExecuteNonQuery();
        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBUSL WHERE USLIDN=" + UslIdn, con);
        cmd.ExecuteNonQuery();

        con.Close();

        getGrid();
    }


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
            Text="УСЛУГИ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: -5px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 400px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
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
		                                OnBeforeClientEdit="GridUsl_ClientEdit" 
		                                OnBeforeClientAdd="GridUsl_ClientInsert"
		                                ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="USLAMB" HeaderText="Амб" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="USLKOD" HeaderText="Код" Visible="false" Width="0%" />
                    <obout:Column ID="Column04" DataField="KASOPL" HeaderText="КАССА" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column05" DataField="USLNAP" HeaderText="№ НАПР" Width="5%" />
                    <obout:Column ID="Column06" DataField="StxNam" HeaderText="ВИД ОПЛ" Width="5%" />
                    <obout:Column ID="Column07" DataField="USLNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="44%" Align="left" />
                    <obout:Column ID="Column08" DataField="USLLGT" HeaderText="ЛЬГОТА" Width="3%"  Align="right"/>
                    <obout:Column ID="Column09" DataField="USLKOL" HeaderText="КОЛ" Width="3%" Align="right"  />
                    <obout:Column ID="Column10" DataField="USLZEN" HeaderText="ЦЕНА" Width="5%" Align="right"  />
                    <obout:Column ID="Column11" DataField="USLSUM" HeaderText="СУММА" Width="5%" ReadOnly="true" Align="right" />
                    <obout:Column ID="Column12" DataField="USLKTO" HeaderText="ОТВЕТСТВЕННЫЙ" Width="10%" >
                        <TemplateSettings TemplateId="TemplateKtoNam" EditTemplateId="TemplateEditKtoNam" />
                    </obout:Column>
                    
                    <obout:Column HeaderText="ИЗМЕН УДАЛЕНИЕ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                    
                    <obout:Column ID="Column13" DataField="RSXFLG" HeaderText="РАСХОД" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateRsx" />
				    </obout:Column>				

                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>								
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridUsl.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridUsl.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridUsl.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridUsl.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridUsl.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridUsl.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridUsl.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
                   			
                    <obout:GridTemplate runat="server" ID="TemplateRsx">
                       <Template>
                          <input type="button" id="btnRsx" class="tdTextSmall" value="Расход" onclick="GridUsl_rsx(<%# Container.PageRecordIndex %>)"/>
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

          <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <input type="button" value="Печать заказ-наряда" onclick="PrtZnrButton_Click()" />
                 <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
             </center>
             

  </asp:Panel>              
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    </form>

    <%-- ============================  STYLES ============================================ --%>

   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
        <owd:Window ID="RsxWindow" runat="server"  Url="DocAppAmbUslRsx.aspx" IsModal="true" ShowCloseButton="true" Status=""
                    Left="300" Top="200" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
                    StyleFolder="~/Styles/Window/wdstyles/blue"
                    Title="График приема врача">
        </owd:Window>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UslWindow" runat="server"  Url="DocAppAmbUslLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""  OnClientClose="WindowClose();"
             Left="300" Top="10" Height="450" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>


    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
       /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

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



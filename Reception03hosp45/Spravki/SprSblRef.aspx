<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

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

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <%-- ============================  JAVA ============================================ --%>
     <script type="text/javascript">
         myconfirm = 0;

         function GridRef_ClientEdit(sender, record) {
             var SprRefNam = record.SPRREFNAM;
             var SprRefIdn = record.SPRREFIDN;
             var SprRefKod = record.SPRREFKOD;

             UslWindow.setTitle(SprRefIdn);
             UslWindow.setUrl("SprSblRefUsl.aspx?SprRefIdn=" + SprRefIdn);
             UslWindow.Open();

             return false;
         }

         function GridRef_ClientInsert(sender, record) {
 //                      alert("GridRef_ClientInsert");
             var SprRefIdn = 0;
             UslWindow.setTitle(SprRefIdn);
             UslWindow.setUrl("SprSblRefUsl.aspx?SprRefIdn=" + SprRefIdn);
             UslWindow.Open();

             return false;
         }

         function WindowClose() {
   //          var jsVar = "callPostBack";
   //          __doPostBack('callPostBack', jsVar);
             //  __doPostBack('btnSave', e.innerHTML);
         }
         // ------------------------  при соглашений на запись к врачу из 1-го диалогового окна  ------------------------------------------------------------------       
         function OnBeforeDelete(sender, record) {
            //          alert("OnBeforeDelete");
                 if (myconfirm == 1) {
                     return true;
                 }
                 else {
                     document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
                     document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                     myConfirmBeforeDelete.Open();
                     return false;
                 }
         }

         function findIndex(record) {
             var index = -1;
             for (var i = 0; i < GridRef.Rows.length; i++) {
                 if (GridRef.Rows[i].Cells[0].Value == record.SPRREFIDN) {
                     index = i;
                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             //        alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
             GridRef.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }

 </script>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int RefKod;
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

    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];
        //=====================================================================================
        //           sdsUsl.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsKto.SelectCommand = "SELECT BuxKod,FI FROM SprBuxKdr";

        GridRef.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridRef.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
        GridRef.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

        string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
        string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
        if (par02 != null && !par02.Equals(""))  // && parCrdIdn.Value == ""
        {
        }

        //============= начало  ===========================================================================================

        if (!Page.IsPostBack)
        {
        }

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
        SqlCommand cmd = new SqlCommand("SELECT * FROM SPRREF WHERE SPRREFFRM=" + BuxFrm + " ORDER BY SPRREFNAM", con);
        // указать тип команды
       // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
      //  cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "SprRef");

        con.Close();

        GridRef.DataSource = ds;
        GridRef.DataBind();
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
        RefKod = Convert.ToInt32(e.Record["SPRREFKOD"]);
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmdDtl = new SqlCommand("DELETE FROM SPRREFUSL WHERE SPRREFUSLREF=" + RefKod, con);
        cmdDtl.ExecuteNonQuery();
        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM SPRREF WHERE SPRREFKOD=" + RefKod, con);
        cmd.ExecuteNonQuery();

        con.Close();

        getGrid();
    }

        // ======================================================================================
</script>


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
            Style="top: 0; left: 20%; position: relative; width: 60%; text-align: center"
            runat="server"></asp:TextBox>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 20%; position: relative; top: 0px; width: 60%; height: 500px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridRef" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_1"
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
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="460" />
                <ClientSideEvents 
		                                OnBeforeClientEdit="GridRef_ClientEdit" 
		                                OnBeforeClientAdd="GridRef_ClientInsert"
                                        OnBeforeClientDelete="OnBeforeDelete"
		                                ExposeSender="true"/>
                <Columns>
                    <obout:Column ID="Column00" DataField="SPRREFIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="SPRREFKOD" HeaderText="КОД"  Width="5%" />
                    <obout:Column ID="Column07" DataField="SPRREFNAM" HeaderText="НАИМЕНОВАНИЕ УСЛУГИ" Width="80%" Align="left" />
                    <obout:Column HeaderText="ИЗМ УДЛ" Width="15%" AllowEdit="true" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				    </obout:Column>	                   
                    
                </Columns>
 		    	
                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>								
				<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                        <input type="button" id="btnEdit" class="tdTextSmall" value="Измен" onclick="GridRef.edit_record(this)"/>
                        <input type="button" id="btnDelete" class="tdTextSmall" value="Удален" onclick="GridRef.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridRef.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridRef.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>
                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridRef.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridRef.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridRef.cancelNewRecord()"/> 
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
             Style="left: 20%; position: relative; top: 0px; width: 60%; height: 30px;">
             <center>
                 <asp:Button ID="RefButton" runat="server" CommandName="Add" Text="Обновить" OnClick="RebindGrid" />
             </center>
          </asp:Panel>              
          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UslWindow" runat="server"  Url="DocAppSprRefLstOne.aspx" IsModal="true" ShowCloseButton="true" Status=""  OnClientClose="WindowClose();"
             Left="250" Top="100" Height="450" Width="900" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>
    <%-- ============================  STYLES ============================================ --%>
<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Удаление" Width="300" IsModal="true">
       <center>
       <br />
        <table>
            <tr>
                <td align="center"><div id="myConfirmBeforeDeleteContent"></div>
                <input type="hidden" value="" id="myConfirmBeforeDeleteHidden" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table style="width:150px">
                        <tr>
                            <td align="center">
                                <input type="button" value="ОК" onclick="ConfirmBeforeDeleteOnClick();" />
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>


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
</asp:Content>



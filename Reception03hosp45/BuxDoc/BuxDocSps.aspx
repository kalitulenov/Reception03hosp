<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true"  %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="spl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

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
<%-- ============================  стили ============================================ --%>
<style type="text/css">
        .super-form
        {
            margin: 12px;
        }
        
        .ob_fC table td
        {
            white-space: normal !important;
        }
        
        .command-row .ob_fRwF
        {
            padding-left: 50px !important;
        }
    </style>
 
<%-- ============================  JAVA ============================================ --%>

      <script type="text/javascript">
          window.onload = function () {
              GridKrd();
          }


          function GridDeb_ClientUpdate(sender, record) {
              var TekAcc = BoxAccDeb.value();
              var TekMol = BoxMolDeb.value();
              //                   alert(TekAcc);
              //                   alert(TekMol);

              ob_post.AddParam("TekAcc", TekAcc);
              ob_post.AddParam("TekMol", TekMol);

              ob_post.post(null, "CreateGridDeb", function () { });
          }

          function GridDeb() {
              var TekAccDeb = BoxAccDeb.value();
              var TekMolDeb = BoxMolDeb.value();
              var TekAccKrd = BoxAccKrd.value();
  //            var TekPrxIdn = BoxPrxDeb.value();
              //      var TekMolKrd = BoxMolKrd.value();

              mySplDeb.loadPage("BottomContent", "BuxDocSpsDeb.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value +
                                                 "&TekAccDeb=" + TekAccDeb + "&TekMolDeb=" + TekMolDeb + "&TekAccKrd=" + TekAccKrd + "&TekMolKrd=0");

              GridKrd();
          }

          function GridKrd() {
              mySplKrd.loadPage("BottomContent", "BuxDocSpsKrd.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value);
          }

          function BoxAccDeb_SelectedIndexChanged(sender, selectedIndex) {

              var TekAccDeb = BoxAccDeb.value();
              var TekMolDeb = BoxMolDeb.value();
              var TekAccKrd = BoxAccKrd.value();
        //      var TekMolKrd = BoxMolKrd.value();

              //       alert("TekAcc=" + TekAcc);
              //       alert("TekMol=" + TekMol);
       //              alert("parDocIdn=" + document.getElementById('MainContent_parDocIdn').value);

              mySplDeb.loadPage("BottomContent", "BuxDocSpsDeb.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value +
                                                 "&TekAccDeb=" + TekAccDeb + "&TekMolDeb=" + TekMolDeb + "&TekAccKrd=" + TekAccKrd + "&TekMolKrd=0");
          }



          //    ==========================  ПЕЧАТЬ =============================================================================================
          function PrtButton_Click() {
              //          alert("1");
              var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;
              //          alert("2");
              var ua = navigator.userAgent;

              if (ua.search(/Chrome/) > -1)
                  window.open("/Report/DauaReports.aspx?ReportName=BuxPrmDoc&TekDocIdn=" + DatDocIdn,
                      "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
              else
                  window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxPrmDoc&TekDocIdn=" + DatDocIdn,
                      "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
          }


          /*------------------------- при нажатии на поле текст --------------------------------*/

          function BoxPrxDeb_SelectedIndexChanged(sender, selectedIndex) {

              if (BoxAccKrd.value() == "") {
                  alert("Не указан счет списание")

                  // обнуление COMBOBOX
           //       document.getElementById('MainContent_mySpl01_ctl00_ctl01_mySplDeb_ctl00_ctl01_BoxPrxDeb_MainContent_mySpl01_ctl00_ctl01_mySplDeb_ctl00_ctl01_BoxPrxDeb').value = null;

                  return true;
              }

              var TekAccDeb = BoxAccDeb.value();
              var TekMolDeb = BoxMolDeb.value();
              var TekAccKrd = BoxAccKrd.value();
         //     var TekMolKrd = BoxMolKrd.value();
         //     var TekPrxIdn = BoxPrxDeb.value();

         //     if (TekAccKrd == "") TekAccKrd = TekAccDeb;


              //       alert("TekAcc=" + TekAcc);
              //       alert("TekMol=" + TekMol);
        //      alert("parDocIdn=" + document.getElementById('MainContent_parDocIdn').value);


              var ParStr = document.getElementById('MainContent_parBuxFrm').value + ':' + document.getElementById('MainContent_parBuxKod').value +
                            ':' + document.getElementById('MainContent_parDocIdn').value + ':' + TekPrxIdn + ':' + TekAccKrd + ':1:0:';
        //      alert("ParStr =" + ParStr);

              $.ajax({
                  type: 'POST',
                  url: '/HspUpdDoc.aspx/BuxUpdatePrm',
                  contentType: "application/json; charset=utf-8",
                  data: '{"ParStr":"' + ParStr + '"}',
                  dataType: "json",
                  success: function () { },
                  error: function () { }
              });

              mySplKrd.loadPage("BottomContent", "BuxDocSpsKrd.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value);

          }

          /*------------------------- при нажатии на поле текст --------------------------------*/

          function ClearKrd_Click() {

              var DatDocMdb = 'HOSPBASE';
              var DatDocTyp = 'Sql';

              var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;

              SqlStr = "DELETE FROM TABDOCDTL WHERE DTLDOCIDN=" + DatDocIdn;
        //      alert("SqlStr=" + SqlStr);

              $.ajax({
                  type: 'POST',
                  url: '/HspUpdDoc.aspx/UpdateOrder',
                  contentType: "application/json; charset=utf-8",
                  data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                  dataType: "json",
                  success: function () { },
                  error: function () { alert("ERROR=" + SqlStr); }
              });

              mySplKrd.loadPage("BottomContent", "BuxDocSpsKrd.aspx?DocIdn=" + document.getElementById('MainContent_parDocIdn').value);

          }
      </script>

    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
     <script runat="server">
           int GlvDocIdn;
        string GlvDocPrv;
        string GlvDocTyp;
        DateTime GlvDocDat;
        string MdbNam = "HOSPBASE";

        string BuxSid;
        string BuxKod;
        string BuxFrm;

        string TekAcc;
        string TekMol;

        decimal ItgDocSum = 0;
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            BuxSid = (string)Session["BuxSid"];
            BuxKod = (string)Session["BuxKod"];
            BuxFrm = (string)Session["BuxFrmKod"];
            GlvDocTyp = "Спс";
            parBuxFrm.Value = BuxFrm;
            parBuxKod.Value = BuxKod;

            //=====================================================================================
            GlvDocIdn = Convert.ToInt32(Request.QueryString["GlvDocIdn"]);
  //          GlvDocPrv = Convert.ToString(Request.QueryString["GlvDocPrv"]);
            //============= начало  ===========================================================================================
            sdsAccDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsAccDeb.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

            sdsMolDeb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsMolDeb.SelectCommand = "SELECT MOLKOD,FI AS MOLNAM FROM SprMolKdr WHERE MolFrm=" + BuxFrm + " ORDER BY FI";

            sdsAccKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
            sdsAccKrd.SelectCommand = "SELECT ACCKOD FROM TABACC WHERE ACCPRV=1 AND ACCFRM=" + BuxFrm + " ORDER BY ACCKOD";

 //           sdsMolKrd.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
 //           sdsMolKrd.SelectCommand = "SELECT MOLKOD,FI AS MOLNAM FROM SprMolKdr WHERE MolFrm='" + BuxFrm + "' ORDER BY FI";

    
            if (!Page.IsPostBack)
            {
                if (GlvDocIdn == 0)
                {
                    // создание DataSet.
                    DataSet ds = new DataSet();
                    // строка соединение
                    string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
                    // создание соединение Connection
                    SqlConnection con = new SqlConnection(connectionString);
                    // создание команды
                    SqlCommand cmd = new SqlCommand("BuxPrxDocAdd", con);
                    
                    // указать тип команды
                    cmd.CommandType = CommandType.StoredProcedure;
                    // передать параметр
                    cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
                    cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
                    cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
                    cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = "Спс";
                    cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = 0;
                    cmd.Parameters["@GLVDOCIDN"].Direction = ParameterDirection.Output;
                    con.Open();
                    try
                    {
                        int numAff = cmd.ExecuteNonQuery();
                        // Получить вновь сгенерированный идентификатор.
                        //      MDVIDN = (int)cmd.Parameters["@GLVDOCIDN"].Value;
                        Session.Add("GLVDOCIDN", Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value));
                        Session.Add("GLVREJ", "ADD");
                        parDocIdn.Value = Convert.ToString(cmd.Parameters["@GLVDOCIDN"].Value);

                    }
                    finally
                    {
                        con.Close();
                    }

                }
                else
                {
                    Session["GLVDOCIDN"] = Convert.ToString(GlvDocIdn);
                    parDocIdn.Value = Convert.ToString(GlvDocIdn);

                    Session.Add("GLVREJ", "REP");

                }
                //=====================================================================================

                getDocNum();

            }
            
        }

        // ============================ чтение заголовка таблицы а оп ==============================================
        void getDocNum()
        {

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды

            SqlCommand cmd = new SqlCommand("SELECT * FROM TABDOC WHERE DOCIDN=" + GlvDocIdn, con);

            con.Open();
            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "GetDocNum");

            con.Close();

            TxtDocDat.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DOCDAT"]).ToString("dd.MM.yyyy");
            TxtDocNum.Text = Convert.ToString(ds.Tables[0].Rows[0]["DOCNUM"]);
            
            
            
        }
        //------------------------------------------------------------------------

        // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void AddButton_Click(object sender, EventArgs e)
        {
            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            string KodErr = "";
            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;


            if (TxtDocNum.Text.Length == 0)
            {
                Err.Text = "Не указан номер документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }

            if (TxtDocDat.Text.Length == 0)
            {
                Err.Text = "Не указан дата документа";
                ConfirmOK.Visible = true;
                ConfirmOK.VisibleOnLoad = true;
                return;
            }


                ConfirmDialog.Visible = true;
                ConfirmDialog.VisibleOnLoad = true;
        }

        // ============================ одобрение для записи документа в базу ==============================================
        protected void btnOK_click(object sender, EventArgs e)
        {

            GlvDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);

            //          localhost.Service1Soap ws = new localhost.Service1SoapClient();
            //          ws.AptPrxDocAddRep(MdbNam, BuxSid, BuxFrm, GlvDocTyp, GlvDocIdn, DOCNUM.Text, DOCDAT.Text, BoxOrg.SelectedValue, BuxKod);
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("BuxPrxDocAddRep", con);
            cmd = new SqlCommand("BuxPrxDocAddRep", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
            cmd.Parameters.Add("@GLVDOCTYP", SqlDbType.VarChar).Value = GlvDocTyp;
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.Int, 4).Value = GlvDocIdn;
            cmd.Parameters.Add("@DOCNUM", SqlDbType.VarChar).Value = TxtDocNum.Text;
            cmd.Parameters.Add("@DOCDAT", SqlDbType.VarChar).Value = TxtDocDat.Text;
            cmd.Parameters.Add("@DOCDEB", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DOCDEBSPR", SqlDbType.VarChar).Value = "6";                // BoxOrg.SelectedValue;
            cmd.Parameters.Add("@DOCDEBSPRVAL", SqlDbType.VarChar).Value = "0";
            cmd.Parameters.Add("@DOCKRD", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DOCKRDSPR", SqlDbType.VarChar).Value = "6";
            cmd.Parameters.Add("@DOCKRDSPRVAL", SqlDbType.VarChar).Value = "0";
            cmd.Parameters.Add("@DOCNUMFKT", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DOCDATFKT", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@DOCMEM", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;

            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Спс&TxtSpr=Документы на списание");

        }

        // ============================ отказ записи документа в базу ==============================================
        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Спс&TxtSpr=Документы на списание");
        }
        // ============================ отказ записи документа в базу ==============================================
       
</script>

<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="Pusto" id="Pusto" value="Pusto" runat="server"/>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  <asp:HiddenField ID="parDocIdn" runat="server" />
  <asp:HiddenField ID="parBuxFrm" runat="server" />
  <asp:HiddenField ID="parBuxKod" runat="server" />

  <%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Документы на списание" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  подшапка  ============================================ --%>
<%-- ============================  верхний блок  ============================================ --%>
 <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 40px;">
     
    <table border="1" cellspacing="0" width="100%">
        <tr>
           <td>
             <table>
               <tr>
                <td class="PO_RowCap">Номер&nbsp;документа:
                 </td>
                 <td>
                    <asp:TextBox id="TxtDocNum" Width="60" Height="20" RunAt="server" BackColor="#FFFFE0" />
                </td>
                <td class="PO_RowCap" align="right">
                   от
                </td>
                 <td align="left">
                     <asp:TextBox runat="server" id="TxtDocDat" Width="80px" />
		        	 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "TxtDocDat"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                </td>
                <td>
                   &nbsp;
                </td>
               
              </tr>
            </table>
        </td>
      </tr>
   </table>
          
   </asp:Panel>   


    <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager1" />

    <asp:Panel ID="Panel1" runat="server" ScrollBars="None" Style="border-style: double; left: 10px; left: 5%; position: relative; top: 0px; width: 90%; height: 550px;">

        <spl:Splitter CookieDays="0" runat="server" StyleFolder="~/Styles/Splitter" ID="mySpl01">
            <LeftPanel WidthMin="600" WidthMax="800" WidthDefault="700">
                <Content>
                    <obspl:HorizontalSplitter ID="mySplDeb" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                        <TopPanel HeightMin="40" HeightMax="100" HeightDefault="60">
                            <Content>
                                <asp:TextBox ID="TextBox1"
                                    Text="Остаток"
                                    BackColor="#32CD32"
                                    Font-Names="Verdana"
                                    Font-Size="18px"
                                    Font-Bold="True"
                                    ForeColor="White"
                                    Style="top: 0px; left: 0; position: relative; width: 99%; text-align: center"
                                    runat="server"></asp:TextBox>

                                <asp:UpdatePanel runat="server" ID="CascadingPanelDeb">
                                    <ContentTemplate>

                                        <obout:ComboBox runat="server" ID="BoxAccDeb" Width="20%" Height="400"
                                            FolderStyle="/Styles/Combobox/Plain" AutoPostBack="false"
                                            DataSourceID="sdsAccDeb" DataTextField="ACCKOD" DataValueField="ACCKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="BoxAccDeb_SelectedIndexChanged" />
                                       </obout:ComboBox>

                                        <obout:ComboBox runat="server" ID="BoxMolDeb" Width="50%" Height="300"
                                            FolderStyle="/Styles/Combobox/Plain"
                                            AutoPostBack="false"
                                            DataSourceID="sdsMolDeb" DataTextField="MOLNAM" DataValueField="MOLKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="BoxAccDeb_SelectedIndexChanged" />
                                        </obout:ComboBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </Content>
                        </TopPanel>
                        <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                            <Content>
                            </Content>
                        </BottomPanel>
                    </obspl:HorizontalSplitter>
                </Content>
            </LeftPanel>

            <RightPanel>
                <Content>
                    <obspl:HorizontalSplitter ID="mySplKrd" CookieDays="0" runat="server" IsResizable="false" StyleFolder="~/Styles/Splitter">
                        <TopPanel HeightMin="40" HeightMax="100" HeightDefault="60">
                            <Content>
                                <asp:TextBox ID="TextBox2"
                                    Text="Списание"
                                    BackColor="#32CD32"
                                    Font-Names="Verdana"
                                    Font-Size="18px"
                                    Font-Bold="True"
                                    ForeColor="White"
                                    Style="top: 0px; left: 0; position: relative; width: 99%; text-align: center"
                                    runat="server"></asp:TextBox>

                               <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                    <ContentTemplate>

                                        <obout:ComboBox runat="server" ID="BoxAccKrd" Width="30%" Height="400"
                                            FolderStyle="/Styles/Combobox/Plain" AutoPostBack="false"
                                            DataSourceID="sdsAccKrd" DataTextField="ACCKOD" DataValueField="ACCKOD">
                                            <ClientSideEvents OnSelectedIndexChanged="BoxAccDeb_SelectedIndexChanged" />
                                        </obout:ComboBox>

                                       <input type="button" name="ClearButton" value="Очистить" id="ClearButton" onclick="ClearKrd_Click();">

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </Content>
                        </TopPanel>

                        <BottomPanel HeightDefault="400" HeightMin="300" HeightMax="500">
                            <Content>
                            </Content>
                        </BottomPanel>
                    </obspl:HorizontalSplitter>

                </Content>
            </RightPanel>
        </spl:Splitter>
    </asp:Panel>

   

<%-- ============================  средний блок  ============================================ --%>

<%-- ============================  средний блок  ============================================ --%>
 
<%-- ============================  подшапка  ============================================ --%>

 <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <input type="button" name="PrtButton" value="Печать" id="PrtButton" onclick="PrtButton_Click();">
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
            </center>
  </asp:Panel> 

  <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите записать ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                              <input type="button" value="Отмена" onclick="ConfirmDialog.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>
 
<%-- =================  источник  для КАДРЫ ============================================ --%>
             <asp:SqlDataSource runat="server" ID="sdsMolDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsAccKrd" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
             <asp:SqlDataSource runat="server" ID="sdsAccDeb" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

<%-- =================  источник  для КАДРЫ ============================================ --%>
       
</asp:Content>

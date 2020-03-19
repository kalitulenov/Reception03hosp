<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

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
        <!--  ссылка на JQUERY DATEPICKER-------------------------------------------------------------- -->
    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

         function OnClientSelect(selectedRecords) {
             var AmbCrdIdn = selectedRecords[0].GRFIDN;
             //        alert("AmbCrdIdn=" + AmbCrdIdn);
             AmbWindow.setTitle(AmbCrdIdn);
             AmbWindow.setUrl("DocAppAmbArxOne.aspx?AmbCrdIdn=" + AmbCrdIdn);
             AmbWindow.Open();
             /*
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Priem/DocAppAmbArxOne.aspx?AmbCrdIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=1200,height=620,left=200,top=110,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Priem/DocAppAmbArxOne.aspx?AmbCrdIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:110px;dialogWidth:1200px;dialogHeight:600px;");
         */
         }

         // -----------------------------------------------------------------------------------------------------------------------------
         function PrtAmbButton_Click() {

             var GrfIin = document.getElementById('parCrdIin').value;
             var GrfFrm = document.getElementById('parBuxFrm').value;
             var FioLst = document.getElementById('Sapka').value;

  //           alert("GrfIin=" + GrfIin);
   //          alert("GrfFrm=" + GrfFrm);
     //        alert("FioLst=" + FioLst);

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspAmbKrtCemOne&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbKrtCemOne&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

         // -----------------------------------------------------------------------------------------------------------------------------
         function PrtLstButton_Click() {

             var GrfIin = document.getElementById('parCrdIin').value;
             var GrfFrm = document.getElementById('parBuxFrm').value;
             var FioLst = document.getElementById('Sapka').value;
      //                 alert("GrfIin=" + GrfIin);
       //                alert("GrfFrm=" + GrfFrm);

             var GrfBeg = document.getElementById('txtDate1').value;
             var GrfEnd = document.getElementById('txtDate2').value;
                 //      var GrfBeg000 = document.getElementById('ctl00$MainContent$TextBoxBegDat').value;

                       

              //         alert("GrfBeg=" + GrfBeg);
               //        alert("GrfEnd=" + GrfEnd);
                //       alert("GrfBeg000=" + GrfBeg000);

             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocFioLst&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocFioLst&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

         // -----------------------------------------------------------------------------------------------------------------------------
         function PrtLstAdvButton_Click() {

             var GrfIin = document.getElementById('parCrdIin').value;
             var GrfFrm = document.getElementById('parBuxFrm').value;
             var FioLst = document.getElementById('Sapka').value;

             var GrfBeg = document.getElementById('txtDate1').value;
             var GrfEnd = document.getElementById('txtDate2').value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocFioLstAdv&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocFioLstAdv&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

         // -----------------------------------------------------------------------------------------------------------------------------
         function PrtLstDocButton_Click() {

             var GrfIin = document.getElementById('parCrdIin').value;
             var GrfFrm = document.getElementById('parBuxFrm').value;
             var FioLst = document.getElementById('Sapka').value;

             var GrfBeg = document.getElementById('txtDate1').value;
             var GrfEnd = document.getElementById('txtDate2').value;
             var ua = navigator.userAgent;
             if (ua.search(/Chrome/) > -1)
                 window.open("/Report/DauaReports.aspx?ReportName=HspDocFioLstDoc&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
             else
                 window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspDocFioLstDoc&TekDocIdn=" + FioLst + "&TekDocKod=0&TekDocFrm=" + GrfFrm + "&TekDocBeg=" + GrfBeg + "&TekDocEnd=" + GrfEnd,
                     "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
         }

 </script>
</head>


<script runat="server">

    //        Grid Grid1 = new Grid();

    string BuxSid;
    string BuxFrm;
    string BuxKod;

    int AmbIdn;
    int AmbAmb;
    int AmbKod;
    int AmbKol;
    int AmbSum;
    int AmbKto;
    int AmbLgt;
    string AmbMem;



    int NumDoc;
    //        string TxtDoc;

    //        DateTime GlvBegDat;
    //        DateTime GlvEndDat;

    string AmbCrdFioLst;
    string GlvDocTyp;
    string MdbNam = "HOSPBASE";
    decimal ItgDocSum = 0;
    decimal ItgDocKol = 0;

    //=============Установки===========================================================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        AmbCrdFioLst = Convert.ToString(Request.QueryString["AmbCrdFioLst"]);
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        BuxSid = (string)Session["BuxSid"];

        parBegDat.Value = Convert.ToString(Session["GlvBegDat"]);
        parEndDat.Value = Convert.ToString(Session["GlvEndDat"]);


        parBuxFrm.Value = BuxFrm;
        //  parCrdIdn.Value = AmbCrdFioLst;

        //=====================================================================================
        //           sdsAmb.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        //============= начало  ===========================================================================================

        if (!Page.IsPostBack)
        {
            //  Session["AmbCrdIin"] = Convert.ToString(AmbCrdIin);

            getGrid();

            //     txtDate1.Text = Convert.ToDateTime(Session["GlvBegDat"]).ToString("dd.MM.yyyy");
            //txtDate2.Text = Convert.ToDateTime(Session["GlvEndDat"]).ToString("dd.MM.yyyy");

        }

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
        SqlCommand cmd = new SqlCommand("HspAmbArxFioLst", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@FIOLST", SqlDbType.NVarChar).Value = AmbCrdFioLst;
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbArxFioLst");

        con.Close();

        if (ds.Tables[0].Rows.Count > 0)
        {
            Sapka.Text = Convert.ToString(ds.Tables[0].Rows[0]["FIOLST"]);
            txtDate1.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["GRFDAT"]).ToString("dd.MM.yyyy");
            txtDate2.Text = Convert.ToDateTime(ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["GRFDAT"]).ToString("dd.MM.yyyy");
        }
        else
        {
            txtDate1.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
         //   txtDate2.Text = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
        }


        GridAmb.DataSource = ds;
        GridAmb.DataBind();
    }

    // ======================================================================================
</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parCrdIin" runat="server" />
        <asp:HiddenField ID="parBegDat" runat="server" />
        <asp:HiddenField ID="parEndDat" runat="server" />
        <%-- ============================  шапка экрана ============================================ --%>

    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
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
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
        <asp:TextBox ID="Sapka"
            Text="АРХИВ ПРИЕМОВ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="14px"
            Font-Bold="True"
            ForeColor="Blue"
            ReadOnly="true"
            Style="top: -0px; left: 0px; position: relative; width: 60%; text-align: left"
            runat="server"></asp:TextBox>
           </center>

    </asp:Panel>

        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 500px;">

            <asp:ScriptManager ID="ScriptManager" runat="server"  EnablePageMethods="true" />
            
            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridAmb" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="true"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="450" />
	            <ClientSideEvents ExposeSender="false" 
                          OnClientSelect="OnClientSelect"/>
                <Columns>
	        	    <obout:Column ID="Column0" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	        	    <obout:Column ID="Column1" DataField="GRFFRM" HeaderText="Орг" Visible="false" Width="0%"/>
	        	    <obout:Column ID="Column2" DataField="GRFIIN" HeaderText="ИИН" Width="10%"/>
                    <obout:Column ID="Column3" DataField="GRFPTH" HeaderText="ФИО" Width="15%"/>
                    <obout:Column ID="Column4" DataField="GRFTEL" HeaderText="ТЕЛЕФОН" Width="20%"/>
	                <obout:Column ID="Column5" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="10%" />
	                <obout:Column ID="Column6" DataField="TIMBEG" HeaderText="ВРЕМЯ"  DataFormatString="{0:hh:mm}" Width="10%" />
	                <obout:Column ID="Column7" DataField="FI" HeaderText="ВРАЧ" Width="20%" />
	                <obout:Column ID="Column8" DataField="DLGNAM" HeaderText="СПЕЦИАЛЬНОСТЬ" Width="15%" />
		        </Columns>
           </obout:Grid>
        </asp:Panel>

        <%-- ============================  нижний блок  ============================================ --%>

        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: -5px; position: relative; top: 0px; width: 100%; height: 30px;">
              <center>      
                   <input type="button" name="PrtButton" value="Печать амб.карт" id="PrtAmbButton" onclick="PrtAmbButton_Click();">
                   <input type="button" name="PrtButton" value="Печать услуг" id="PrtLstButton" onclick="PrtLstButton_Click();">
                   <input type="button" name="PrtButton" value="Печать группа,услуга" id="PrtLstAdvButton" onclick="PrtLstAdvButton_Click();">
                   <input type="button" name="PrtButton" value="Печать врач,услуга" id="PrtDocButton" onclick="PrtLstDocButton_Click();">
              </center>      
        </asp:Panel> 

          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
   <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="AmbWindow" runat="server"  Url="WinFrm.aspx" IsModal="true" ShowCloseButton="true" Status=""
             Left="50" Top="10" Height="550" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="График приема врача">
       </owd:Window>   
    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
              <%--   ------------------------------------- для удаления отступов в GRID --------------------------------%>
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

        /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
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



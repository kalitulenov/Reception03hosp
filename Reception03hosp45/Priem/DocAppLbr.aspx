<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

    <%-- ============================  STYLES ============================================ --%>
 
    
     <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
         function onClick(rowIndex, cellIndex) {
      //       alert(rowIndex + ' = ' + cellIndex + ' ' + GridLab.Rows[rowIndex].Cells[0].Value);
             var AmbLabIdn = GridLab.Rows[rowIndex].Cells[0].Value;
             //          alert("AmbLabIdn=" + AmbLabIdn);
             /*
                         if (cellIndex == 3 && GridLab.Rows[rowIndex].Cells[3].Value == "+")
                         {
                             LabWindow.setTitle(AmbLabIdn);
                             LabWindow.setUrl("DocAppAmbLabOne.aspx?AmbUslIdn=" + AmbLabIdn);
                             LabWindow.Open();
                         }
             */


  
            if (cellIndex == 4 && GridLab.Rows[rowIndex].Cells[4].Value == "+") {
                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
            }

           if (cellIndex == 5 && GridLab.Rows[rowIndex].Cells[5].Value == "+") {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                 else
                     window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=1", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
             }

             if (cellIndex == 6 && GridLab.Rows[rowIndex].Cells[6].Value == "+") {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                 else
                     window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=2", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
             }
             if (cellIndex == 7 && GridLab.Rows[rowIndex].Cells[7].Value == "+") {
                 var ua = navigator.userAgent;
                 if (ua.search(/Chrome/) > -1)
                     window.open("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=3", "ModalPopUp2", "width=800,height=600,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                 else
                     window.showModalDialog("DocAppAnlOneSho.aspx?AmbUslIdn=" + AmbLabIdn + "&AmbUslImgNum=X", "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:1100px;dialogHeight:480px;");
             }
         }

 </script>

<script runat="server">

        //        Grid Grid1 = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        
        int LabIdn;
        int LabAmb;
        int LabKod;
        int LabKol;
        int LabSum;
        int LabKto;
        int LabLgt;
        string LabMem;



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
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];
            //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
            AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
            //=====================================================================================

            if (!Page.IsPostBack)
            {
                getDocNum();
                getGrid();
            }

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
         //   TextBoxTel.Text = Convert.ToString(ds.Tables[0].Rows[0]["KLTTEL"]);
            }
        }
        
        // ============================ чтение таблицы а оп ==============================================
        void getGrid()
        {
            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbLabIdn", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbLabIdn");

            con.Close();

            GridLab.DataSource = ds;
            GridLab.DataBind();
        }

        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
            e.Row.Cells[4].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[4].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[4].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",4)");

            e.Row.Cells[5].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[5].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[5].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",5)");

            e.Row.Cells[6].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[6].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[6].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",6)");

            e.Row.Cells[7].Attributes["onmouseover"] = "this.style.fontSize = '20px'; this.style.fontWeight = 'bold';";
            e.Row.Cells[7].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.color = 'black';";
            e.Row.Cells[7].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",7)");

            /*
            if (args.Row.Cells[4].Text == "USA" || args.Row.Cells[4].Text == "Denmark" || args.Row.Cells[4].Text == "Germany")
            {
                for (int i = 1; i < args.Row.Cells.Count; i++)
                {
                    args.Row.Cells[i].BackColor = System.Drawing.Color.DarkGray;
                }
            }
    */
        }

        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GoBack/GoBack1.aspx");
            //  Response.Redirect("~/GlavMenu.aspx");

        }


</script>


      <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="None"  
             Style="left:10%; position: relative; top: 0px; width: 80%; height: 65px;">

      <table border="1" cellspacing="0" width="100%">
               <tr>
                  <td width="7%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Дата</td>
                  <td width="3%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Время</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">ИИН</td>
                  <td width="32%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Фамилия И.О.</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Д.рож</td>
                  <td width="8%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">№карты</td>
                  <td width="12%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Место работы</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Страхователь</td>
                  <td width="10%" align="center" style="font-weight:bold; background-color:yellow" class="PO_RowCap">Титул</td>
              </tr>
              
               <tr>
                  <td width="7%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxDat" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="3%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTim" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIIN" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="32%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFio" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                   <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxBrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>                  <td width="8%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxKrt" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td> 
                  <td width="12%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxFrm" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxIns" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>
                  <td width="10%" class="PO_RowCap">
                      <asp:TextBox id="TextBoxTit" BorderStyle="None" Width="100%" Height="20" RunAt="server" BackColor="#FFFFE0" />
                  </td>

              </tr>            
   </table>
  <%-- ============================  шапка экрана ============================================ --%>
 <asp:TextBox ID="Sapka" 
             Text="ЛАБОРАТОРИЯ" 
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
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 350px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridLab" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                OnRowDataBound="OnRowDataBound_Handle"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Width="0%" />
                    <obout:Column ID="Column1" DataField="USLAMB" HeaderText="Амб" Width="0%" />
                    <obout:Column ID="Column2" DataField="USLTRF" HeaderText="АНАЛИЗ" Width="7%" />
                    <obout:Column ID="Column3" DataField="USLNAM" HeaderText="АНАЛИЗ" Width="58%" />
                    <obout:Column ID="Column4" DataField="IMGXLS" HeaderText="1.ОБРАЗ" Width="5%" Align="Center" />
                    <obout:Column ID="Column5" DataField="IMG001" HeaderText="2.ОБРАЗ" Width="5%" ReadOnly="true" Align="Center" />
                    <obout:Column ID="Column6" DataField="IMG002" HeaderText="3.ОБРАЗ" Width="5%" ReadOnly="true" Align="Center" />
                    <obout:Column ID="Column7" DataField="IMG003" HeaderText="3.ОБРАЗ" Width="5%" ReadOnly="true" Align="Center" />
                    <obout:Column ID="Column8" DataField="USLFIO" HeaderText="ОТВЕТ" Width="5%" />
                    <obout:Column ID="Column9" DataField="USLBINGDE" HeaderText="ЛАБОРАТОРИЯ" Width="10%" />
                </Columns>
            </obout:Grid>
 
       </asp:Panel> 
    <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад к списку" onclick="CanButton_Click"/>
             </center>
             

  </asp:Panel>         
<%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
    <owd:Window ID="ShoWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status=""
        Left="300" Top="10" Height="450" Width="600" Visible="true" VisibleOnLoad="false"
        StyleFolder="~/Styles/Window/wdstyles/blue"
        Title="Лаборатория">
    </owd:Window>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsKto" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
  
</asp:Content>

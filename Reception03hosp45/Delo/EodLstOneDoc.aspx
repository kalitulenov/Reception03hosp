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

        var myconfirm = 0;

        // ===============================================================================================================================================================
        function GridEod_prg(rowIndex) {
            //  alert("GridEod_prg="+rowIndex);

            var EodIdn = GridEod.Rows[rowIndex].Cells[0].Value;
            var EodVid = GridEod.Rows[rowIndex].Cells[1].Value;
            var DocPls = GridEod.Rows[rowIndex].Cells[6].Value;
            var EodTxt = GridEod.Rows[rowIndex].Cells[4].Value;
            //  alert("EodIdn=" + EodIdn);
            var Num = 1;
            var BuxKod = document.getElementById('parBuxKod').value;
            //  alert("BuxKod=" + BuxKod);

            SqlStr = "UPDATE TABEODDTL SET EODDTLRDY=1,EODDTLEND=GETDATE() WHERE EODDTLREF=" + EodIdn + " AND EODDTLWHO=" + BuxKod;
           // alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"HOSPBASE","SqlStr":"' + SqlStr + '","DatDocTyp":"Sql"}',
                dataType: "json",
                success: function () { },
                error: function () { alert("ERROR=" + SqlStr); }
            });

            if (DocPls != "+") {
                //  jAlert('Это обычное окно предупреждения', 'Внимание !');
                //  windowalert(EodTxt, "Сообщение", "info");
                alert(EodTxt);
                // KofWindow.setTitle("Коэффициент");
                //KofWindow.setUrl("EodLstGrdOneTxt.aspx?EodVid=" +EodVid+"&EodTxt=" + EodTxt);
                //KofWindow.Open();
                //return false;
            }
            else {

                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("EodLstGrdOneSho.aspx?EodBuxKod=" + BuxKod + "&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                else
                    window.showModalDialog("EodLstGrdOneSho.aspx?EodBuxKod=" + BuxKod + "&EodIdn=" + EodIdn + "&EodImgNum=" + Num, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
            }
            var jsVar = "callPostBack";
            __doPostBack('callPostBack', jsVar);

            return false;
        }


        function ExitFun() {
         //   self.close();
            window.parent.EodClose();
            //window.opener.WindowClose();
        }

    </script>

</head>


<script runat="server">

    string BuxFrm;
    string BuxKod;

    string MdbNam = "HOSPBASE";

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        parBuxKod.Value = BuxKod;

        //=====================================================================================

        //if (!Page.IsPostBack)
        //{
        //}
        getGrid();

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT TABEOD.EodIdn,TABEOD.EodNum,TABEOD.EodDat,TABEOD.EodNam,TABEOD.EodEndDat," +
                                "CASE WHEN LEN(ISNULL(TABEOD.EodImg001,''))>0 THEN '+' ELSE '' END AS IMG,SprEdoTyp.EdoTypNam " +
                                "FROM TABEOD INNER JOIN TABEODDTL ON TABEOD.EodIdn=TABEODDTL.EodDtlRef " +
                                "INNER JOIN SprEdoTyp ON TABEOD.EodTyp=SprEdoTyp.EdoTypKod " +
                                "WHERE TABEOD.EodFrm=" + BuxFrm + " AND RIGHT(TABEOD.EodSts,1) <> '1' AND TABEODDTL.EodDtlWho=" + BuxKod + " AND ISNULL(TABEODDTL.EodDtlRdy, 0)=0", con);
        // AND TABEOD.EodSts = N'6.3.4'
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //cmd.Parameters.Add("@FNDFRM", SqlDbType.VarChar).Value = BuxFrm;
        //cmd.Parameters.Add("@FNDFIO", SqlDbType.VarChar).Value = Cond;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "EodLstDoc");

        if (ds.Tables[0].Rows.Count > 0)
        {
            GridEod.DataSource = ds;
            GridEod.DataBind();
        }
        else
        {
            ExecOnLoad("ExitFun();");
        }

        con.Close();
    }

    // ==================================== поиск клиента по фильтрам  ============================================

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
             <asp:HiddenField ID="parBuxKod" runat="server" />
        <%-- ============================  для передач значении  ============================================ --%>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: -5px; position: relative; top: 0px; width: 100%; height: 350px;">
            <%-- ============================  шапка экрана ============================================ --%>
                    <asp:TextBox ID="Sapka" 
             Text="НЕПРОЧИТАННЫЕ СООБЩЕНИЯ" 
             BackColor="green"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>


            <obout:Grid ID="GridEod" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                KeepSelectedRecords="false"
                AllowSorting="true"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                AutoPostBackOnSelect="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="260" ScrollWidth="100%" />
                 <Columns>
                    <obout:Column ID="Column00" DataField="EODIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column01" DataField="EDOTYPNAM" HeaderText="ВИД ДОКУМЕНТА" Width="22%" />
                    <obout:Column ID="Column02" DataField="EODNUM" HeaderText="НОМЕР" Width="7%" />
                    <obout:Column ID="Column03" DataField="EODDAT" HeaderText="ДАТА" DataFormatString="{0:yyyy}" Width="7%" />
                    <obout:Column ID="Column04" DataField="EODNAM" HeaderText="СОДЕРЖАНИЕ" Width="42%" Wrap="true" />
                    <obout:Column ID="Column05" DataField="EODENDDAT" DataFormatString="{0:dd/MM/yy}" HeaderText="СРОК" Align="center" Width="7%" />
                    <obout:Column ID="Column06" DataField="IMG" HeaderText="ДОКУМЕНТ" Align="center" Width="8%" />
                    <obout:Column ID="Column07" DataField="FLG" HeaderText="ЧИТАТЬ" Width="7%" ReadOnly="true" Align="center" >
				         <TemplateSettings TemplateId="TemplatePrg" />
				    </obout:Column>				
              </Columns>
 		    	
               <Templates>	
                  <obout:GridTemplate runat="server" ID="TemplatePrg">
                      <Template>
                         <input type="image" id="btnRsx" class="tdTextSmall" value="ОТКРЫТЬ" src="/Icon/Show.png" onclick="GridEod_prg(<%# Container.PageRecordIndex %>)"/>
 					  </Template>
                 </obout:GridTemplate>                  			

                </Templates>
            </obout:Grid>
        </asp:Panel>

    </form>

    <%-- ============================  STYLES ============================================ --%>

<%--
    <asp:SqlDataSource runat="server" ID="sdsUsl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

     ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
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



            a.pg
            {
                font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
            }

            a.pg:hover {
                color: crimson;
            }
    </style>

</body>
</html>



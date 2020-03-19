<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>


<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

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
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript" ></script>

   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#BrtDat').mask('D9.M9.Y999');
        };
        /*------------------------- Изиять переданный параметр --------------------------------*/
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

        /*------------------------- Изиять переданный параметр --------------------------------*/
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        //function ExitFun() {
        //    var KltFio = document.getElementById('SelFio').value;
        // //   alert(KltFio);
        //    //window.parent.KofClick();
        //    window.parent.KltOneClose(KltFio);
        //    //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        //}


        function ExitFun() {
            var KltStx;
            var KltBrt;

            if (document.getElementById('MorTxt').value.indexOf("Республиканский семейно-врачебный центр") < 0) KltStx = "ПЛАТНО";
            else KltStx = "ГОСЗАКАЗ";

            KltBrt = document.getElementById('BrtTxt').value.substr(8, 2) + "." +
                document.getElementById('BrtTxt').value.substr(5, 2) + "." +
                document.getElementById('BrtTxt').value.substr(0, 4)
          //  alert(KltBrt);

            var GrfFio = document.getElementById('CntIdn').value + "&" +
                document.getElementById('FioTxt').value + "&" +
                document.getElementById('IinTxt').value + "&" +
                KltBrt + "&" +
                " " + "&" + " " + "&" +
                " " + "&" +
                KltStx + "&" +
                " " + "&" +
                " ";
            localStorage.setItem("FndFio", GrfFio); //setter

            window.parent.KltCloseRPN(GrfFio);
        }

        // -----------------------------------------------------------------------------------
        //    ---------------- обращение веб методу --------------------------------------------------------
        // -----------------------------------------------------------------------------------

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KltOneIin;
    string CntKltIdn;

    string BuxFrm;
    string BuxKod;
    string Result;

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {

        KltOneIin = Convert.ToString(Request.QueryString["KltOneIin"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {
            // TekKltIin.Value = Convert.ToString(KltOneIin);

            IdnTxt.Text = "";
            IinTxt.Text = "";
            BrtTxt.Text = "";
            FioTxt.Text = "";
            BoxTit.Text = "";
            SexTxt.Text = "";
            MigTxt.Text = "";
            DatPrkTxt.Text = "";
            MorTxt.Text = "";
            DomTxt.Text = "";


            // ******************************************************* Передать GRFIDN и получить XML ***************************************************************************
            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("INSERT INTO TABRPNIIN (RPNFRM,RPNIIN,RPNFLG,RPNFLGOUT) VALUES("+ BuxFrm+",'" + KltOneIin + "',0,0)", con);
            //  SqlCommand cmd = new SqlCommand("UPDATE AMBBOL SET BOLMEM='TEST' WHERE BOLIDN=" + Id, con);
            // указать тип команды
            con.Open();
            cmd.ExecuteNonQuery();
            //  con.Close();


            //  System.Threading.Thread.Sleep(3000);

            while (1==1)
            {
                //------------       чтение уровней дерево
                //  con.Open();
                SqlCommand cmdIin = new SqlCommand("SELECT TOP 1 * FROM TABRPNIIN WHERE RPNFLGOUT=1 AND RPNFRM=" + BuxFrm + " AND RPNIIN='" + KltOneIin + "'", con);
                // указать тип команды
                // cmd.CommandType = CommandType.StoredProcedure;
                // передать параметр
                // cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

                // создание DataAdapter
                SqlDataAdapter da = new SqlDataAdapter(cmdIin);
                // заполняем DataSet из хран.процедуры.
                da.Fill(ds, "RpnIinRec");
                // создание DataAdapter

                if (ds.Tables[0].Rows.Count > 0)
                {
                    IdnTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNIDN"]);
                    IinTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNIIN"]);
                    BrtTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNBRT"]);
                    FioTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNFIO"]);
                    BoxTit.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNFIO"]);

                    if (Convert.ToString(ds.Tables[0].Rows[0]["RPNSEX"]) == "3") SexTxt.Text = "муж";
                    else
                       if (Convert.ToString(ds.Tables[0].Rows[0]["RPNSEX"]) == "2") SexTxt.Text = "жен";
                    else SexTxt.Text = "";

                    MigTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNMIG"]);
                    DatPrkTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNDAT"]);
                    MorTxt.Text = Convert.ToString(ds.Tables[0].Rows[0]["RPNMO"]);

                    //  if (MorTxt.Text.IndexOf("Республиканский семейно-врачебный центр") < 0) MorTxt.ForeColor = Color.Red;

                    if (Convert.ToString(ds.Tables[0].Rows[0]["RPNDOM"]) == "true") DomTxt.Text = "да";
                    else DomTxt.Text = "нет";
                    break;
                }
            }

            con.Close();




            //DopService.Service1Soap wsDop = new DopService.Service1SoapClient();
            //Result = wsDop.DopServiceRPN("1","530103302492").ToString();
            //BuxFrm = "1";
        }

    }

    // ============================ кнопка новый документ  ==============================================

    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (FioTxt.Text.Length == 0)
        {
            Err.Text = "Не указан фамилия";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }
        if (IinTxt.Text.Length != 12)
        {
            Err.Text = "Ошибка в ИИН";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //---------------------------------------------- запись --------------------------
        string KltStx = "";
        string KltFam = "";
        string KltCmp = "";
        string KltCnt = "";
        string KltVar = "";
        string KltUch = "";
        string KltKrtBeg = "";
        string KltKrtEnd = "";
        string KltEmp = "";
        string KltDlg = "";
        bool KltStf = false;
        bool KltVip = false;
        bool KltDspFlg = false;
        // string KltDspDat = "";

        string KltFio = "";
        bool KltSex = false;
        bool KltRsd = false;
        string KltBrt = "";
        string KltIin = "";
        string KltInv = "";
        string KltTel = "";
        string KltAlr = "";
        string KltAdrObl = "";
        string KltAdrPnk = "";
        string KltAdrStr = "";
        string KltAdrDom = "";
        string KltAdrApr = "";
        string KltAdrUgl = "";
        string KltAdrPod = "";
        string KltAdrEtg = "";
        string KltAdrDmf = "";
        string KltAdrZsd = "";
        string KltKnt001 = "";
        string KltKnt001Tel = "";
        string KltKnt002 = "";
        string KltKnt002Tel = "";
        string KltBol = "";
        string KltLek = "";
        string KltPrt = "";
        string KltKrvGrp = "";
        string KltKrvRes = "";
        string KltMem = "";
        string KltSum = "";
        string KltLgt = "";
        string KltSoz = "";

        //=====================================================================================
        // BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (MorTxt.Text.IndexOf("Республиканский семейно-врачебный центр") < 0) KltStx = "00004";
        else KltStx = "00001";

        KltKrtBeg = DatPrkTxt.Text.Substring(8, 2) + "." + DatPrkTxt.Text.Substring(5, 2) + "." + DatPrkTxt.Text.Substring(0, 4);
        // ------------------------------------------------------------------------------------------------------------------------     
        KltFio = FioTxt.Text;
        if (Convert.ToString(SexTxt.Text) == "муж") KltSex = true;
        else KltSex = false;
        KltRsd = false;
        KltBrt = BrtTxt.Text.Substring(8, 2) + "." + BrtTxt.Text.Substring(5, 2) + "." + BrtTxt.Text.Substring(0, 4);
        KltIin = Convert.ToString(IinTxt.Text);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("InsSprCntKltRepRpn", con);
        cmd = new SqlCommand("InsSprCntKltRepRpn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KltIdn", SqlDbType.VarChar).Value = 0;   // KltOneIdn;
        cmd.Parameters.Add("@CntIdn", SqlDbType.VarChar).Value = 0; /// CntOneIdn;
        cmd.Parameters.Add("@KltStx", SqlDbType.VarChar).Value = KltStx;
        cmd.Parameters.Add("@KltCmp", SqlDbType.VarChar).Value = KltCmp;
        cmd.Parameters.Add("@KltCnt", SqlDbType.VarChar).Value = KltCnt;
        cmd.Parameters.Add("@KltVar", SqlDbType.VarChar).Value = KltVar;
        cmd.Parameters.Add("@KltUch", SqlDbType.VarChar).Value = KltUch;
        cmd.Parameters.Add("@KltKrtBeg", SqlDbType.VarChar).Value = KltKrtBeg;
        cmd.Parameters.Add("@KltKrtEnd", SqlDbType.VarChar).Value = KltKrtEnd;
        cmd.Parameters.Add("@KltEmp", SqlDbType.VarChar).Value = KltEmp;
        cmd.Parameters.Add("@KltDlg", SqlDbType.VarChar).Value = KltDlg;
        cmd.Parameters.Add("@KltStf", SqlDbType.Bit, 1).Value = KltStf;
        cmd.Parameters.Add("@KltVip", SqlDbType.Bit, 1).Value = KltVip;
        cmd.Parameters.Add("@KltDspFlg", SqlDbType.Bit, 1).Value = KltDspFlg;
        cmd.Parameters.Add("@KltDspDat", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KltFio", SqlDbType.NVarChar).Value = KltFio;
        cmd.Parameters.Add("@KltSex", SqlDbType.Bit, 1).Value = KltSex;
        cmd.Parameters.Add("@KltRsd", SqlDbType.Bit, 1).Value = KltRsd;
        cmd.Parameters.Add("@KltBrt", SqlDbType.VarChar).Value = KltBrt;
        cmd.Parameters.Add("@KltIin", SqlDbType.VarChar).Value = KltIin;
        cmd.Parameters.Add("@KltInv", SqlDbType.VarChar).Value = KltInv;
        cmd.Parameters.Add("@KltTel", SqlDbType.VarChar).Value = KltTel;
        cmd.Parameters.Add("@KltAlr", SqlDbType.VarChar).Value = KltAlr;
        cmd.Parameters.Add("@KltAdrObl", SqlDbType.VarChar).Value = KltAdrObl;
        cmd.Parameters.Add("@KltAdrPnk", SqlDbType.VarChar).Value = KltAdrPnk;
        cmd.Parameters.Add("@KltAdrStr", SqlDbType.VarChar).Value = KltAdrStr;
        cmd.Parameters.Add("@KltAdrDom", SqlDbType.VarChar).Value = KltAdrDom;
        cmd.Parameters.Add("@KltAdrApr", SqlDbType.VarChar).Value = KltAdrApr;
        cmd.Parameters.Add("@KltAdrUgl", SqlDbType.VarChar).Value = KltAdrUgl;
        cmd.Parameters.Add("@KltAdrPod", SqlDbType.VarChar).Value = KltAdrPod;
        cmd.Parameters.Add("@KltAdrEtg", SqlDbType.VarChar).Value = KltAdrEtg;
        cmd.Parameters.Add("@KltAdrDmf", SqlDbType.VarChar).Value = KltAdrDmf;
        cmd.Parameters.Add("@KltAdrZsd", SqlDbType.VarChar).Value = KltAdrZsd;
        cmd.Parameters.Add("@KltSoz", SqlDbType.VarChar).Value = KltSoz;

        cmd.Parameters.Add("@KltKnt001", SqlDbType.VarChar).Value = KltKnt001;
        cmd.Parameters.Add("@KltKnt001Tel", SqlDbType.VarChar).Value = KltKnt001Tel;
        cmd.Parameters.Add("@KltKnt002", SqlDbType.VarChar).Value = KltKnt002;
        cmd.Parameters.Add("@KltKnt002Tel", SqlDbType.VarChar).Value = KltKnt002Tel;
        cmd.Parameters.Add("@KltBol", SqlDbType.VarChar).Value = KltBol;
        cmd.Parameters.Add("@KltLek", SqlDbType.VarChar).Value = KltLek;
        cmd.Parameters.Add("@KltPrt", SqlDbType.VarChar).Value = KltPrt;
        cmd.Parameters.Add("@KltKrvGrp", SqlDbType.VarChar).Value = KltKrvGrp;
        cmd.Parameters.Add("@KltKrvRes", SqlDbType.VarChar).Value = KltKrvRes;
        cmd.Parameters.Add("@KltMem", SqlDbType.VarChar).Value = KltMem;
        cmd.Parameters.Add("@KltSum", SqlDbType.VarChar).Value = KltSum;
        cmd.Parameters.Add("@KltLgt", SqlDbType.VarChar).Value = KltLgt;
        cmd.Parameters.Add("@CNTKLTIDN", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters["@CNTKLTIDN"].Direction = ParameterDirection.Output;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
            CntKltIdn = Convert.ToString(cmd.Parameters["@CNTKLTIDN"].Value);
            CntIdn.Value = CntKltIdn;
        }
        finally
        {
            con.Close();
        }

        con.Close();

        //           ConfirmDialog.Visible = false;
        //           ConfirmDialog.VisibleOnLoad = false;
        //  SelFio.Value = KltFio;
        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);


    }

    //------------------------------------------------------------------------


</script>


<body>
    <form id="form1" runat="server">
       <asp:HiddenField ID="CntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -4px; position: relative; top: 0px; width: 100%; height: 330px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

        <table border="0" cellspacing="0" width="100%" cellpadding="0">

 <!-- IDN  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;IDN:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="IdnTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!--  ИИН ------------------------------------------------------------------------------------------------>  
                         <tr style="height:35px"> 
                            <td width="20%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="80%" style="vertical-align: top;">
                                  <obout:OboutTextBox runat="server" ID="IinTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>                                                         
                        </tr>
 <!--  ФИО ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="20%" class="PO_RowCap">&nbsp;Фамилия И.О:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="FioTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
 <!--  ПОЛ ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="20%" class="PO_RowCap">&nbsp;Пол:</td>
                             <td width="80%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="SexTxt"  width="20%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 &nbsp;Д/р:&nbsp;

                                <obout:OboutTextBox runat="server" ID="BrtTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                
                            </td>
                        </tr>
 <!-- МО  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;МО:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="MorTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                             
                        </tr>
 <!-- Дата прикрепление  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;Дата прикреп.:</td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="DatPrkTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!-- На дому  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;На дому:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="DomTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!-- Оралман  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;Оралман:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="MigTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

</table>
<%--            <hr />--%>

         </asp:Panel>
 
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -4px; position: relative; top: 0px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать на прием"/>
               </center>
           </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
    <%-- =================  Пароль успешно изменен  ============================================ --%>

        <%-- ============================  верхний блок  ============================================ --%>

   <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />
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

    </form>


    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
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

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
           .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
               hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>

</body>

</html>



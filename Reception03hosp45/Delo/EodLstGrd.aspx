<%@ Page Title="" Language="C#" AutoEventWireup="true"  Inherits="OboutInc.oboutAJAXPage"%>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="Reception03hosp45.localhost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

        <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 


        <script type="text/javascript">
            var myconfirm = 0;
            function GridEod_rsx() {
      //                  alert("GridPrz_rsx=");
                var UslIdn = document.getElementById('USLIDN').value;
                var UslFrmIdn = document.getElementById('USLFRMIDN').value;
                var UslFrmNam = document.getElementById('USLNAM').value;

                var ua = navigator.userAgent;
                if (ua.search(/Chrome/) > -1)
                    window.open("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn+"&UslNam="+UslFrmNam, "ModalPopUp2", "width=900,height=480,left=250,top=210,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                else
                    window.showModalDialog("/Spravki/SprUslFrmGrdRsx.aspx?UslFrmIdn=" + UslIdn + "&UslNam=" + UslFrmNam, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:210px;dialogWidth:900px;dialogHeight:480px;");

                return true;
            }


            // ==================================== корректировка данные клиента в отделном окне  ============================================
            function GridEod_ClientEdit(sender, record) {
                var EodIdn = record.EODIDN;
                var EodSts = record.EODSTS;
                var EodKey = document.getElementById('parNodKey').value;
                var EodTxt = document.getElementById('parNodTxt').value;
                //alert("EodKey=" + EodKey);
                //alert("EodTxt=" + EodTxt);
                //alert("EodIdn=" + EodIdn);

                switch (EodSts) {
                    case '6.1.1':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne611.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne611.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.1.2':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne612.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne612.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.1.3':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne613.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne613.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.1.4':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne614.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne614.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.1.5':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne615.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne615.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    //   ВНУТРЕННИЕ ДОКУМЕНТЫ
                    case '6.3.1':    // НОВЫЙ
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne631.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne631.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.3.2':     // НА РЕЗОЛЮЦИЙ
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne632.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne632.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.3.4':     // НА ИСПОЛНЕНИИ
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne634.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne634.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodSts + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
               }
                return false;
           }


            function GridEod_ClientInsert(sender, record) {
                //           alert("GridUыд_ClientEdit");
                var EodIdn = 0;
                var EodKey = document.getElementById('parNodKey').value;
                var EodTxt = document.getElementById('parNodTxt').value;
                //alert("EodKey=" + EodKey);
                //alert("EodTxt=" + EodTxt);

                if (EodKey.substr(4, 1) != "1") {
                    windowalert("Вставить можно только новые документы!", "Сообщение", "warning");
                    return false;
                }


                switch (EodKey) {
                    case '6.1.1':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne611.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne611.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.2.1':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne612.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne612.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                    case '6.3.1':
                        var ua = navigator.userAgent;
                        if (ua.search(/Chrome/) > -1)
                            window.open("EodLstGrdOne631.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "width=1100,height=630,left=250,top=100,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                        else
                            window.showModalDialog("EodLstGrdOne631.aspx?EodIdn=" + EodIdn + "&EodKey=" + EodKey + "&EodTxt=" + EodTxt, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:100px;dialogWidth:1100px;dialogHeight:630px;");
                        break;
                }
                return false;
            }


            function WindowClose() {
                //          alert("GridEodClose");
                var jsVar = "callPostBack";
                __doPostBack('callPostBack', jsVar);
                //  __doPostBack('btnSave', e.innerHTML);
            }
           

            //function PrcOneClose() {
            //    PrcWindow.Close();
            //}

            function OnBeforeDelete(sender, record) {
                var EodKey = document.getElementById('parNodKey').value;
           //     alert("EodKey=" + EodKey + " " + EodKey.substr(4, 1));

              //  if (EodKey.length != 3) return false;
                if (EodKey.substr(4, 1) != "1") {
                    windowalert("Удалять можно только новые документы!", "Сообщение", "warning");
                    return false;
                }
                //                    alert("myconfirm=" + myconfirm);  
                if (myconfirm == 1) {
                    return true;
                }
                else {
                    document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить запись ?";
                    document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
                    myConfirmBeforeDelete.Open();
                    return false;
                }
            }

            function findIndex(record) {
                var index = -1;
                //            alert('1 index: ' + index);
                for (var i = 0; i < GridEod.Rows.length; i++) {
                    if (GridEod.Rows[i].Cells[0].Value == record.EODIDN) {
                   //     alert(record.EODIDN);
                        index = i;
                        break;
                    }
                }
                return index;
            }

            // =============================== удаления клиента после опроса  ============================================
            function ConfirmBeforeDeleteOnClick() {
                myconfirm = 1;
                GridEod.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
                myConfirmBeforeDelete.Close();
                myconfirm = 0;
            }

   </script>
</head>
    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid GridEod = new Grid();

        string BuxSid;
        string BuxFrm;
        string Html;
        string UslKey000;
        string UslKey003;
        string UslKey007;
        string UslKey011;
        string UslKey015;

        string ComParKey = "";
        string ComParTxt = "";
        string ComParCnt = "";
        string whereClause = "";

        string MdbNam = "HOSPBASE";


        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================
            GridEod.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);

            string par01 = this.Request["__EVENTTARGET"]; // 1st parameter
            string par02 = this.Request["__EVENTARGUMENT"]; // 2nd parameter
            if (par02 != null && !par02.Equals("")) Session["SprUslIdn"] = "Post";

            if (!Page.IsPostBack)
            {
                ComParKey = (string)Request.QueryString["NodKey"];
                ComParTxt = (string)Request.QueryString["NodTxt"];
                parNodKey.Value = ComParKey;
                parNodTxt.Value = ComParTxt;
            }
            LoadGridNode();

            TxtUsl.Text = ComParTxt;
        }

        //=============Заполнение массива первыми тремя уровнями===========================================================================================

        protected void LoadGridNode()
        {
            int LenKey = parNodKey.Value.Length;

            DataSet ds = new DataSet("Menu");

            //      whereClause = Convert.ToString(Session["WHERE"]);

            if (whereClause == null || whereClause == "")
            {
                if (LenKey > 0)
                {
                    Session["WHERE"] = "";
                    ds.Merge(EodLstGrdSel(MdbNam, BuxFrm, LenKey, parNodKey.Value));
                    GridEod.DataSource = ds;
                    GridEod.DataBind();
                }
            }
            else
            {
                ds.Merge(EodLstGrdSel(MdbNam, BuxFrm, 0, whereClause));
                GridEod.DataSource = ds;
                GridEod.DataBind();
            }
        }

        //=============При выборе узла дерево===========================================================================================
        // ====================================после удаления ============================================
        //------------------------------------------------------------------------
        // ==================================== поиск клиента по фильтрам  ============================================
        protected void FndBtn_Click(object sender, EventArgs e)
        {
            int I = 0;

            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            whereClause = "";
            if (FndTxt.Text != "")
            {
                I = I + 1;
                whereClause += "CNTKLTFIO LIKE '%" + FndTxt.Text.Replace("'", "''") + "%'";
            }

            if (whereClause != "")
            {
                whereClause = whereClause.Replace("*", "%");


                if (whereClause.IndexOf("SELECT") != -1) return;
                if (whereClause.IndexOf("UPDATE") != -1) return;
                if (whereClause.IndexOf("DELETE") != -1) return;

                Session["WHERE"] = whereClause;

                LoadGridNode();

            }
        }


        // ============================ чтение заголовка таблицы а оп ==============================================
        // ==================================================================================================  

        // изменение подразделении  (справочника SPRSTRFRM)
        void DeleteRecord(object sender, GridRecordEventArgs e)
        {
            int EODIDN = Convert.ToInt32(e.Record["EODIDN"]);

            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            SqlCommand cmd = new SqlCommand("DELETE FROM TABEOD WHERE EODIDN=@EODIDN", con);
            // указать тип команды
          //  cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@EODIDN", SqlDbType.VarChar).Value = EODIDN;
            con.Open();
            // ------------------------------------------------------------------------------заполняем второй уровень
            cmd.ExecuteNonQuery();
            con.Close();
            // ------------------------------------------------------------------------------заполняем второй уровень
            LoadGridNode();

        }

        // ==================================================================================================  
        public DataSet EodLstGrdSel(string BUXMDB, string BUXFRM, int LENKEY, string TREKEY)
        {
            bool flag;

            // создание DataSet.
            DataSet ds = new DataSet();
            // строка соединение
            // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[BUXMDB].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            // создание команды
            SqlCommand cmd = new SqlCommand("EodLstGrdSel", con);
            cmd = new SqlCommand("EodLstGrdSel", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // создать коллекцию параметров
            cmd.Parameters.Add(new SqlParameter("@BUXFRM", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@LENKEY", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@TREKEY", SqlDbType.VarChar));
            cmd.Parameters.Add(new SqlParameter("@ARXFLG", SqlDbType.Int, 4));

            // ------------------------------------------------------------------------------заполняем первый уровень
            // передать параметр
            cmd.Parameters["@BUXFRM"].Value = BUXFRM;
            cmd.Parameters["@LENKEY"].Value = LENKEY;
            cmd.Parameters["@TREKEY"].Value = TREKEY;
            if (parNodKey.Value == "6.1.9" || parNodKey.Value == "6.2.9" || parNodKey.Value == "6.3.9") cmd.Parameters["@ARXFLG"].Value = 1;
            else cmd.Parameters["@ARXFLG"].Value = 0;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "EodLstGrdSel");
            // ------------------------------------------------------------------------------заполняем второй уровень

            // если запись найден
            try
            {
                flag = true;
            }
            // если запись не найден
            catch
            {
                flag = false;
            }
            // освобождаем экземпляр класса DataSet
            ds.Dispose();
            con.Close();
            // возвращаем значение
            return ds;
        }

 </script>   


<body>
    <form id="form1" runat="server">
        <%-- ============================  JAVA ============================================ --%>


        <!--  конец -----------------------------------------------  -->
        <%-- ============================  для передач значении  ============================================ --%>
        <span id="WindowPositionHelper"></span>
        <asp:HiddenField ID="parUslKod" runat="server" />
        <asp:HiddenField ID="parUslNam" runat="server" />
        <asp:HiddenField ID="parNodTxt" runat="server" />
        <asp:HiddenField ID="parSprCnt" runat="server" />
        <asp:HiddenField ID="parNodKey" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parCond" runat="server" />

        <input type="hidden" name="hhh" id="par" />

        <!--  для источника -----------------------------------------------  -->
        <!--  для источника -----------------------------------------------  -->

            <table border="0" cellspacing="0" style="top:-10px" width="100%" cellpadding="0">
                <tr>
                    <td width="5%" class="PO_RowCap" align="left">&nbsp;&nbsp;Услуга:</td>
                    <td width="18%">
                        <asp:TextBox ID="FndTxt" Width="100%" Height="22px" runat="server"
                            Style="position: relative; font-weight: 700; font-size: small;" />
                    </td>

                    <td width="5%">
                        <asp:Button ID="FndBtn" runat="server"
                            OnClick="FndBtn_Click"
                            Width="100%" CommandName="Cancel"
                            Text="Поиск" Height="28px"
                            Style="position: relative; top: 0px; left: 0px" />
                    </td>
                    <td>&nbsp;</td>
                    <td width="65%">
                        <asp:TextBox ID="TxtUsl"
                            Text=""
                            BackColor="#0099FF"
                            Font-Names="Verdana"
                            Font-Size="20px"
                            Font-Bold="True"
                            ForeColor="White"
                            Style="top: 0px; left: 0px; position: relative; width: 100%"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>


            <obout:Grid ID="GridEod" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                AllowAddingRecords="true"
                AllowFiltering="true"
                ShowColumnsFooter="false"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false">
                <ClientSideEvents 
		               OnBeforeClientEdit="GridEod_ClientEdit" 
		               OnBeforeClientAdd="GridEod_ClientInsert"
                       OnBeforeClientDelete="OnBeforeDelete"
		               ExposeSender="true"/>
               <ScrollingSettings ScrollHeight="450" />
                <Columns>
                    <obout:Column ID="Column00" DataField="EODIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="EODSTS" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column02" DataField="EODSTSNAM" HeaderText="СТАТУС" Width="7%" />
                    <obout:Column ID="Column03" DataField="EODPRF" HeaderText="№ РЕГ" Width="6%" Align="left" />
                    <obout:Column ID="Column04" DataField="EODNUM" HeaderText="№ РЕГ" Width="4%" Align="right" />
                    <obout:Column ID="Column05" DataField="EODDAT" HeaderText="ДАТА" ReadOnly="true" Align="right" Width="6%" />
                    <obout:Column ID="Column06" DataField="EDOTYPNAM" HeaderText="ТИП" Width="10%" />
                    <obout:Column ID="Column07" DataField="EODNAM" HeaderText="НАИМЕНОВАНИЕ" ReadOnly="true" Align="left" Width="22%" />
                    <obout:Column ID="Column08" DataField="EODOUTORG" HeaderText="ОТ КОГО" Align="right" Width="13%" />
<%--                    <obout:Column ID="Column08" DataField="FIORSL" HeaderText="РЕЗОЛЮТЕР" Align="right" Width="8%" />--%>
                    <obout:Column ID="Column09" DataField="FIOISP" HeaderText="ИСПОЛНИТЕЛЬ" Align="right" Width="10%" />
                    <obout:Column ID="Column10" DataField="EODRSLEND" HeaderText="СРОК" Align="right" Width="6%" />
                    <obout:Column ID="Column11" DataField="EODBIPDAT" HeaderText="ДАТА ВЫП" Align="right" Width="6%" />
<%--                    <obout:Column ID="Column12" DataField="EDOBIPNAM" HeaderText="РЕЗУЛЬТАТ" Align="left" Width="8%" />--%>

                    <obout:Column HeaderText="ИЗМ УДЛ" Width="10%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>
                </Columns>

                <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                <Templates>
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnEdit" class="tdTextSmall" value="Изм" onclick="GridEod.edit_record(this)" />
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridEod.delete_record(this)"/>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                        <Template>
                            <input type="button" id="btnUpdate" value="Сохран" class="tdTextSmall" onclick="GridEod.update_record(this)" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridEod.cancel_edit(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridEod.addRecord()" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridEod.insertRecord()" />
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridEod.cancelNewRecord()" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>

            </obout:Grid>
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
          <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />


        <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%--        <owd:Window ID="RsxWindow" runat="server" Url="SprUslFrmGrdRsx.aspx" IsModal="true" ShowCloseButton="true" Status=""
            RelativeElementID="WindowPositionHelper" Left="300" Top="200" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
            StyleFolder="~/Styles/Window/wdstyles/aura"
            Title="Справочник расхода материалов">
        </owd:Window>--%>

          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%--        <owd:Window ID="PrcWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="100" Top="10" Height="470" Width="900" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="ПРЕЙСКУРАНТ">

       </owd:Window>--%>

<%-- =================  для удаление документа ============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Confirm" Width="300" IsModal="true">
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
                                <input type="button" value="Назад" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </center>
    </owd:Dialog>
    </form>

    <%-- ------------------------------------- для удаления отступов в GRID 
                                 <obout:DropDownListField DataField="USLFRMIIN" DisplayField="ORGNAM" HeaderText="МО услуга" DataSourceID="SdsOrg"  FieldSetID="FieldSet1"/>

         --------------------------------%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }

        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
        }
      /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
         font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

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

    <%-- ============================  стили ============================================ --%>
    <style type="text/css">
        .super-form {
            margin: 12px;
        }

        .ob_fC table td {
            white-space: normal !important;
        }

        .command-row .ob_fRwF {
            padding-left: 50px !important;
        }
    </style>

</body>
</html>

<%@ Page Title="" Language="C#" AutoEventWireup="true"  Inherits="OboutInc.oboutAJAXPage"%>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
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


    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>
    <%-- ************************************* javascript **************************************************** --%>

        <script type="text/javascript">

            window.onload = function ()
            {
                attachMenuToRecords();
            }
        // ------------------------------------------------------------------------------------------

            function MnuUsl() {
                var RecordIndex = document.getElementById('parRowIndex').value;
                var CellIndex = document.getElementById('parCellIndex').value;

                var GrfOneFio = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex].Value;
                var GrfOneIdn = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex - 1].Value;
         //              alert("GrfOneIdn=" + GrfOneIdn);
         //              alert("GrfOneFio=" + GrfOneFio);
                if (GrfOneFio.length > 6) {
                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=1100,height=550,left=150,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                    else {
                        window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:550px;");
                    }
                }
                return false;
            }

            function MnuArx() {
                var RecordIndex = document.getElementById('parRowIndex').value;
                var CellIndex = document.getElementById('parCellIndex').value;

                var GrfOneFio = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex].Value;
                var GrfOneIdn = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex - 1].Value;
                //              alert("GrfOneIdn=" + GrfOneIdn);
                //              alert("GrfOneFio=" + GrfOneFio);
                if (GrfOneFio.length > 6) {
                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Referent/RefGlvUslArx.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=1100,height=550,left=150,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                    else {
                        window.showModalDialog("/Referent/RefGlvUslArx.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:550px;");
                    }
                }
                return false;
            }

            function MnuZap() {
                var RecordIndex = document.getElementById('parRowIndex').value;
                var CellIndex = document.getElementById('parCellIndex').value;

                var GrfOneFio = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex].Value;
                var GrfOneIdn = GridGrfDoc.Rows[RecordIndex].Cells[CellIndex - 1].Value;
              //                alert("GrfOneIdn=" + GrfOneIdn);
              //                alert("GrfOneFio=" + GrfOneFio);

                var FndIdn = localStorage.CntIdn; //getter
              //                            alert('FIO1=' + FndIdn);
                var FndFio = localStorage.GrfPth; //getter
              //                           alert('FIO2=' + FndFio);
                var FndIIN = localStorage.GrfIIN; //getter
              //                           alert('FIO3=' + FndIIN);
                var FndTel = localStorage.GrfTel; //getter
              //  alert('FIO4=' + FndTel);
                var FndTim = GrfOneFio.substring(0, 5);
              //  alert('FndTim=' + FndTim);
                if (FndFio == "" || FndFio == null) { windowalert("Клиент не указан", "Предупреждения", "warning"); return;}

             //   alert('FndTim2=');

                var SndPar = document.getElementById("parBuxFrm").value + ":" +
                    document.getElementById("parRefKod").value + ":" +
                    document.getElementById("parBuxKod").value + ":" +
                    FndFio + ":" + FndIIN + ":" + FndTel + ": :" + FndTim + ": :";

            //    alert("SndPar=" + SndPar);

                //            PageMethods.GetSprDoc(SndPar, onSprUslLoaded01, onSprUslLoadedError);
                
                $.ajax({
                    type: 'POST',
                    url: '/HspUpdDoc.aspx/RefZapTekTim',
                    data: '{"SndPar":"' + SndPar + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () { },
                    error: function () { alert("ERROR="); }
                });
                

                /*
                if (GrfOneFio.length > 6) {
                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "width=1100,height=550,left=150,top=160,modal=yes,directories=no,toolbar=no,menubar=no,location=no,status=no,scrollbars=no,resizable=no,fullscreen=yes");
                    else {
                        window.showModalDialog("/Referent/RefGlvUsl.aspx?AmbCrdIdn=" + GrfOneIdn, "ModalPopUp2", "center:yes;resizable:yes;status:no;dialogleft:250px;dialogtop:160px;dialogWidth:900px;dialogHeight:550px;");
                    }
                }
                */
                return false;

            }

            function attachMenuToRecords() {
              //  alert("attachMenuToRecords");
                var gridContainerID = "GridGrfDoc_ob_GridGrfDocMainContainer";
                // attach menu to grid container
                ob_em_EasyMenu1.attachToControl(gridContainerID);

                // hide menu on clicking the grid container
                document.getElementById(gridContainerID).onclick = function () {
                    ob_em_EasyMenu1.hideMenu();
                }

                gridIds = GridGrfDoc.getRecordsIds().split(",");
                for (index = 0; index < gridIds.length; index++) {
                    var rowId = gridIds[index];

                   // attach menu to each grid row
                    ob_em_EasyMenu1.attachToControl(rowId);

                    var rowCells = document.getElementById(rowId).childNodes;
              //      alert(rowCells.length);
                    for (elIndex = 0; elIndex < rowCells.length; elIndex++) {
                        // stop the event propagation when click on grid cells to avoid rows unselection
                        rowCells[elIndex].onmousedown = function (e) {
                            var event = e || window.event;

                            // stop event propagation on right mouse click
                            if (event.button == 2) {
                                if (event.stopPropagation) { event.stopPropagation(); } else { event.cancelBubble = true; }
                            }
                        }
                    }
                }
            }



            /* ======================================================================== */
            /* ======================================================================== */
            /* ======================================================================== */
            /* ======================================================================== */
            function onMouseDown(rowIndex, cellIndex) {
          //      alert("oncontextmenu-rowIndex=" + rowIndex + "  cellIndex=" + cellIndex);
                document.getElementById('parRowIndex').value = rowIndex;
                document.getElementById('parCellIndex').value = cellIndex;

                // Панель график по дням
            }
            // ------------------------  показать третью вкладку (график врача)  -----------------------
            function onClick(rowIndex, cellIndex) {
                //  alert("rowIndex=" + rowIndex + "  cellIndex=" + cellIndex);
                // Панель график по дням
                if (cellIndex > 0 && cellIndex < 14) {
                    //        alert("Value=" + GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value);


                    var FndIdn = localStorage.CntIdn; //getter
                    //            alert('FIO1=' + FndIdn);
                    var FndFio = localStorage.GrfPth; //getter
                    //           alert('FIO2=' + FndFio);
                    var FndIIN = localStorage.GrfIIN; //getter
                    //           alert('FIO3=' + FndIIN);
                    var FndTel = localStorage.GrfTel; //getter
                    //           alert('FIO4=' + FndTel);

                    // анализ HTML
                    var body = GridGrfDoc.GridBodyContainer.firstChild.firstChild.childNodes[1];
                    //    alert("body-" + body.innerHTML);
                    var cell = body.childNodes[rowIndex].childNodes[cellIndex];
                    //     alert("Cell =" + cell.innerHTML);
                    var CelTxt = cell.firstChild.innerHTML;
                    //   alert("CelTxt =" + CelTxt);
                    var CelTxtFio = cell.firstChild.innerText;
            //        alert("CelTxtFio =" + CelTxtFio + CelTxtFio.length);

                    var GrfFio = GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value;
                    //   alert("GrfFio=" + GrfFio + GrfFio.length);

                    if (CelTxtFio.length == 6) {
                        //      alert("пустой");
                        // ----------------------------установит флажок-----------------------------------------------------------------------
                        if (FndFio == "" || FndFio == null) { windowalert("Клиент не указан", "Предупреждения", "warning"); }
                        // ---------------------------------------------------------------------------------------------------
                        else {
                            var GrfDocIdn = GridGrfDoc.Rows[rowIndex].Cells[cellIndex - 1].Value;
                            //  alert("GrfDocIdn=" + GrfDocIdn);
                            // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------
                            /*
                                                var result = ""
                                                var d = document.getElementsByTagName("div");
                                                for (var i = 0; i < d.length; i++) {
                                                    result += "i=" + i + " id=" + d[i].id + " Text= " + d[i].innerText + "\n"
                                                }
                                                alert(result);
                            */
                            // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------	
                            var CelTxt001 = cell.firstChild.innerHTML.substring(0, 26) + " " + FndFio + "</div>";
                            //     alert("CelTxt001 =" + CelTxt001);
                            cell.firstChild.innerHTML = CelTxt001;

                            var cellP01 = cell;
                            //   alert("cellP-01 =" + cellP01.outerHTML);
                            cellP01.outerHTML = cellP01.outerHTML.replace('black', 'red');
                            //   alert("cellP-02 =" + cellP01.outerHTML);

                            var BuxKod = document.getElementById('parBuxKod').value;

                            var GrfDocRek2 = "UPDATE AMBCRD SET GRFBUS=1,GRFBUX=" + BuxKod + ",GRFPTH=N'" + FndFio + "',GRFIIN='" + FndIIN + "',GRFTEL=LEFT('" + FndTel +
                                             "',50),GRFSTX=(SELECT TOP 1 CNTKLTKEY FROM SPRCNTKLT WHERE CNTKLTIDN=" + FndIdn + ") WHERE GRFIDN=" + GrfDocIdn;
                            //      alert("GrfDocRek2 =" + GrfDocRek2);

                            onChangeUpd(GrfDocRek2, '0', 'Upd', GrfDocIdn);
                            GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value = GridGrfDoc.Rows[rowIndex].Cells[cellIndex].Value + ' ' + FndFio;

                            //     alert("GrfDocRek2=" + GrfDocRek2);
                            // ====================================== ОКНО УСЛУГИ ==============================================================================================================
                            return false;
                        }

                    }
                    // ------------------------------занят пациентом ---------------------------------------------------
                    else
                        if (CelTxtFio.length > 6) {
                            document.getElementById('parCellIdn').value = GridGrfDoc.Rows[rowIndex].Cells[cellIndex - 1].Value;
                            document.getElementById('parCellRow').value = rowIndex;
                            document.getElementById('parCellCol').value = cellIndex;

                            var GrfDocIdn = GridGrfDoc.Rows[rowIndex].Cells[cellIndex - 1].Value;

                            ConfirmDialog.screenCenter();
                            ConfirmDialog.Open();  // запрос на снятие флажка
                        }


                }
            }

            //    ------------------------------------------------------------------------------------------------------------------------

            function onChangeUpd(GrfDocRek, GrfDocVal, GrfDocTyp, GrfDocIdn) {

                var DatDocMdb = 'HOSPBASE';
                var DatDocTab = 'AMBCRD';
                var DatDocKey = 'GRFIDN';
                var DatDocRek = GrfDocRek;
                var DatDocVal = GrfDocVal;
                var DatDocTyp = GrfDocTyp;
                var DatDocIdn = GrfDocIdn;

                //         var QueryString = getQueryString();
                //         DatDocIdn = QueryString[1];
                //         alert("DatDocTyp=" + DatDocTyp);

                //         alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);
                switch (DatDocTyp) {
                    case 'Sql':
                        DatDocTyp = 'Sql';
                        //   if (DatDocRek.substring(0,6) == 'UPDATE' || DatDocRek.substring(0,6) == 'SELECT' || DatDocRek.substring(0,6) == 'DELETE') SqlStr = DatDocRek;
                        SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                        break;
                    case 'Str':
                        DatDocTyp = 'Str';
                        SqlStr = DatDocTab + "&" + DatDocKey + "&" + DatDocIdn;
                        break;
                    case 'Dat':
                        DatDocTyp = 'Sql';
                        SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=CONVERT(DATETIME,'" + DatDocVal + "',103) WHERE " + DatDocKey + "=" + DatDocIdn;
                        break;
                    case 'Int':
                        DatDocTyp = 'Sql';
                        SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "=" + DatDocVal + " WHERE " + DatDocKey + "=" + DatDocIdn;
                        break;
                    case 'Upd':
                        DatDocTyp = 'Sql';
                        SqlStr = DatDocRek;
                        break;
                    default:
                        DatDocTyp = 'Sql';
                        SqlStr = "UPDATE " + DatDocTab + " SET " + DatDocRek + "='" + DatDocVal + "' WHERE " + DatDocKey + "=" + DatDocIdn;
                        break;
                }
                //          alert("SqlStr=" + SqlStr);

                $.ajax({
                    type: 'POST',
                    url: '/HspUpdDoc.aspx/UpdateOrder',
                    contentType: "application/json; charset=utf-8",
                    data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                    dataType: "json",
                    success: function () { },
                    error: function () { alert("ERROR="); }
                });

                ConfirmDialog.Close();
            }


            // запрос на снятие флажка согласие
            function OK_click() {
              //  alert("OK_click");

                var GrfDocIdn = document.getElementById('parCellIdn').value;
                var rowIndex = document.getElementById('parCellRow').value;
                var cellIndex = document.getElementById('parCellCol').value;

                // ----------------------------- отладка просмотр всех элементов div в сайте --------------------------	
                // записать пациента
                var body = GridGrfDoc.GridBodyContainer.firstChild.firstChild.childNodes[1];
            //        alert("body-" + body.innerHTML);
                var cell = body.childNodes[rowIndex].childNodes[cellIndex];
            //        alert("Cell =" + cell.innerHTML);
                var CelTxt = cell.firstChild.innerHTML;
             //        alert("CelTxt =" + CelTxt);
                var CelTxt001 = cell.firstChild.innerHTML.substring(0, 26) + " </div>";
            //         alert("CelTxt001 =" + CelTxt001);
                cell.firstChild.innerHTML = CelTxt001;

                var BuxKod = document.getElementById('parBuxKod').value;

                // -------------------------------------------------------------------------------- обнулить запись ------------------------------
                GrfDocRek = "UPDATE AMBCRD SET GRFBUS=0,GRFPTH='',GRFIIN='',GRFPOL='',GRFSTX='',GRFINTFLG=0,GRFINTBEG=NULL,GRFINTEND=NULL,GRFEML='',GRFTEL='',GRFTIM=NULL WHERE GRFIDN=" + GrfDocIdn;
            //    alert("GrfDocRek2 =" + GrfDocRek);
                onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);

                // -------------------------------------------------------------------------------- удалить услуги ------------------------------
                GrfDocRek = "DELETE FROM AMBUSL WHERE USLAMB=" + GrfDocIdn;

                onChangeUpd(GrfDocRek, '0', 'Upd', GrfDocIdn);

                ConfirmDialog.Close();
            }

            // запрос на снятие флажка отказ
            function Cancel_click() {
                ConfirmDialog.Close();
            }

   </script>

     
</head>



    
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">
        //        Grid GridPrc = new Grid();

        string BuxSid;
        string BuxFrm;
        string BuxKod;
        string GlvBegDatTxt;
        string GlvEndDatTxt;
        DateTime GlvBegDat;
        DateTime GlvEndDat;
        int GrfDlg;
        int GrfKod;
        string MdbNam;
        int DayWek = 0;

        string ComParDat = "";

        //=============Установки===========================================================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            MdbNam = "HOSPBASE";
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            parBuxKod.Value = (string)Request.QueryString["BuxKod"];
            parRefKod.Value = BuxKod;
            parBuxFrm.Value = BuxFrm;

            //=====================================================================================
            //    ComParCty = "2"; // (string)Request.QueryString["GrfCty"];
            //  ComParDat = Convert.ToDateTime(DateTime.Today).ToString("dd.MM.yyyy");
            ComParDat = (string)Request.QueryString["BuxDat"];
            //      hidBuxDat.Value = ComParDat;
            GlvBegDat = Convert.ToDateTime(ComParDat);
            //=====================================================================================
            //         GridPrc.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);
            //=====================================================================================
            if (!Page.IsPostBack)
            {
                DayWek =(int) DateTime.Now.DayOfWeek;

                GridGrfDoc.Columns[01].HeaderText = (Convert.ToDateTime(GlvBegDat).ToString("dd.MM dddd")+"..........").Substring(0,19);
                GridGrfDoc.Columns[03].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(01)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[05].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(02)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[07].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(03)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[09].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(04)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[11].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(05)).ToString("dd.MM dddd") + "..........").Substring(0, 19);
                GridGrfDoc.Columns[13].HeaderText = (Convert.ToDateTime(GlvBegDat.AddDays(06)).ToString("dd.MM dddd") + "..........").Substring(0, 19);

                LoadGrid();
                EasyMenu1.AttachTo = "";

            }
        }

        protected void LoadGrid()
        {
            //    if (ComParKey == "_tree1") return;

            //------------       чтение уровней дерево
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspRefGlvDocGrf007", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = parBuxKod.Value;
            cmd.Parameters.Add("@USLDAT", SqlDbType.VarChar).Value = ComParDat;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspRefGlvDocGrf007");

            GridGrfDoc.DataSource = ds;
            GridGrfDoc.DataBind();

            ds.Dispose();
            con.Close();

        }
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------
        //-------------- для высвечивания анализа при подводе курсора ----------------------------------------------------------воскресенье
        protected void OnRowDataBound_Handle(Object o, GridRowEventArgs e)
        {
            e.Row.Cells[01].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[01].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[01].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[01].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 1)
            {
                e.Row.Cells[01].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[01].Text.IndexOf("Обед") > 0) e.Row.Cells[01].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[01].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",01)");
            e.Row.Cells[01].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",01)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[03].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[03].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[03].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[03].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 2)
            {
                e.Row.Cells[03].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[03].Text.IndexOf("Обед") > 0) e.Row.Cells[03].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[03].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",03)");
            e.Row.Cells[03].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",03)");
            //---------------------------------------------------------------------------------------------------

            //---------------------------------------------------------------------------------------------------
            e.Row.Cells[05].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[05].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[05].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[05].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 3)
            {
                e.Row.Cells[05].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[05].Text.IndexOf("Обед") > 0) e.Row.Cells[05].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[05].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",05)");
            e.Row.Cells[05].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",05)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[07].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[07].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[07].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[07].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 4)
            {
                e.Row.Cells[07].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[07].Text.IndexOf("Обед") > 0) e.Row.Cells[07].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[07].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",07)");
            e.Row.Cells[07].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",07)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[09].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[09].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[09].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[09].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 5)
            {
                e.Row.Cells[09].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[09].Text.IndexOf("Обед") > 0) e.Row.Cells[09].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[09].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",09)");
            e.Row.Cells[09].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",09)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[11].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[11].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[11].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.LightPink;
            }
            if (DayWek == 6)
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.LightCyan;
            }
            if (e.Row.Cells[11].Text.IndexOf("Обед") > 0) e.Row.Cells[11].BackColor = System.Drawing.Color.LightPink;
            e.Row.Cells[11].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",11)");
            e.Row.Cells[11].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",11)");
            //---------------------------------------------------------------------------------------------------

            e.Row.Cells[13].Attributes["onmouseover"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'bold'; this.style.color = 'red'";
            e.Row.Cells[13].Attributes["onmouseout"] = "this.style.fontSize = '12px'; this.style.fontWeight = 'normal'; this.style.color = 'black';";
            if (GridGrfDoc.Columns[13].HeaderText.IndexOf("воскресенье") > 0)
            {
                e.Row.Cells[13].BackColor = System.Drawing.Color.LightPink;
            }
            e.Row.Cells[13].Attributes.Add("onclick", "onClick(" + e.Row.RowIndex + ",13)");
            e.Row.Cells[13].Attributes.Add("onmousedown", "onMouseDown(" + e.Row.RowIndex + ",13)");

        }
 </script>   


<body>
    <form id="form1" runat="server">
        <%-- ============================  JAVA ============================================ --%>


        <!--  конец -----------------------------------------------  -->
        <%-- ============================  для передач значении  ============================================ --%>
        <span id="WindowPositionHelper"></span>
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parRefKod" runat="server" />
        <asp:HiddenField ID="parUslNam" runat="server" />
        <asp:HiddenField ID="parSprTxt" runat="server" />
        <asp:HiddenField ID="parSprCnt" runat="server" />
        <asp:HiddenField ID="parSprKey" runat="server" />
        <asp:HiddenField ID="parBuxFrm" runat="server" />
        <asp:HiddenField ID="parCell" runat="server" />
        <asp:HiddenField ID="parCellIdn" runat="server" />
        <asp:HiddenField ID="parCellRow" runat="server" />
        <asp:HiddenField ID="parCellCol" runat="server" />
        <asp:HiddenField ID="parRowIndex" runat="server" />
        <asp:HiddenField ID="parCellIndex" runat="server" />

        <input type="hidden" name="hhh" id="par" />

        <!--  для источника -----------------------------------------------  -->
        <asp:SqlDataSource runat="server" ID="SdsPrc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
        <!--  для источника -----------------------------------------------  -->
        <asp:ScriptManager ID="ScriptManager3" runat="server"></asp:ScriptManager>

        <obout:Grid ID="GridGrfDoc" runat="server"
            ShowFooter="false"
            CallbackMode="true"
            Serialize="true"
            FolderLocalization="~/Localization"
            Language="ru"
            AutoGenerateColumns="false"
            FolderStyle="~/Styles/Grid/style_5"
            AllowAddingRecords="false"
            ShowColumnsFooter="false"
            AllowRecordSelection="true"
            AllowMultiRecordSelection="false"
            KeepSelectedRecords="false"
            AutoPostBackOnSelect="false"
            AllowColumnResizing="true"
            AllowSorting="false"
            OnRowDataBound="OnRowDataBound_Handle"
            Width="100%"
            ShowHeader="true"
            AllowPaging="false"
            AllowPageSizeSelection="false"
            GenerateRecordIds="true"
            PageSize="-1">
            <ClientSideEvents OnClientCallback="attachMenuToRecords" />
            <ScrollingSettings ScrollHeight="900" />
            <Columns>
                <obout:Column ID="Column01" DataField="I01" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column02" DataField="D01" HeaderText="002" ReadOnly="true" Width="15%" Align="left" />
                <obout:Column ID="Column03" DataField="I02" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column04" DataField="D02" HeaderText="002" ReadOnly="true" Width="15%" Align="left" />
                <obout:Column ID="Column05" DataField="I03" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column06" DataField="D03" HeaderText="002" ReadOnly="true" Width="15%" Align="left" />
                <obout:Column ID="Column07" DataField="I04" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column08" DataField="D04" HeaderText="002" ReadOnly="true" Width="15%" Align="left" />
                <obout:Column ID="Column09" DataField="I05" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column10" DataField="D05" HeaderText="002" ReadOnly="true" Width="14%" Align="left" />
                <obout:Column ID="Column11" DataField="I06" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column12" DataField="D06" HeaderText="002" ReadOnly="true" Width="13%" Align="left" />
                <obout:Column ID="Column13" DataField="I07" HeaderText="001" Visible="false" Width="0%" />
                <obout:Column ID="Column14" DataField="D07" HeaderText="002" ReadOnly="true" Width="13%" Align="left" />
            </Columns>
        </obout:Grid>

        <%-- =================  EasyMenu д.б. внутри тега FORM  ============================================ --%>

        <oem:EasyMenu ID="EasyMenu1" ShowEvent="ContextMenu" runat="server" StyleFolder="/Styles/WindowsXP"
            Width="200" UseIcons="true" IconsPosition="Left" Align="Cursor" ZIndex="100">
            <Components>
                <oem:MenuItem ID="menuItem2" OnClientClick="MnuUsl();"
                    InnerHtml="Услуги">
                </oem:MenuItem>
                <oem:MenuItem ID="menuItem3" OnClientClick="MnuArx();"
                    InnerHtml="Архив услуг">
                </oem:MenuItem>
                <oem:MenuItem ID="menuItem4" OnClientClick="MnuZap();"
                    InnerHtml="Запись на тек.время">
                </oem:MenuItem>
            </Components>
        </oem:EasyMenu>

    </form>

    <%-- =================  для удаление документа ============================================ --%>
    <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
    <!--     Dialog должен быть раньше Window-->
    <owd:Dialog ID="ConfirmDialog" runat="server" Visible="true" VisibleOnLoad="false" IsModal="true" Position="CUSTOM"
        Top="50" Left="100" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default"
        Title="Cнять прием" zIndex="10" ShowCloseButton="false">
        <br />
        <center>
            <table>
                <tr>
                    <td>Хотите снять прием ?</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                        <input type="button" value="OK" onclick="OK_click()" />
                        <input type="button" value="Отмена" onclick="Cancel_click()" />
                    </td>
                </tr>
            </table>
        </center>
    </owd:Dialog>


    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>
    <%-- ************************************* style **************************************************** --%>

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

        /*------------------------- для укрупнения шрифта GRID  -------------------------------- */
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

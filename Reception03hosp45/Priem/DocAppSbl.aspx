<%@ Page Language="C#" AutoEventWireup="true" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
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
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->


    <script type="text/javascript">

        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------
        function onChange(sender, newText) {
        //    alert("onChangeJlb=" + sender + " = " + newText);
            var DatDocMdb = 'HOSPBASE';
            var GrfDocRek;
            var GrfDocVal = newText;
            var GrfDocTyp = 'Str';

            TxtSbl.innerHTML = GrfDocVal;

            SqlStr = "HspAmbSblRep&@BUXKOD&" + document.getElementById('parBuxKod').value + "&@BUXTYP&" + parSblNum.value + "&@BUXSBL&" + GrfDocVal;
         //   alert("SqlStr=" + SqlStr);

            $.ajax({
                type: 'POST',
                url: '/HspUpdDoc.aspx/UpdateOrder',
                contentType: "application/json; charset=utf-8",
                data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + GrfDocTyp + '"}',
                dataType: "json",
                success: function () { },
                error: function () { }
            });
        }

        function SablonWrite() {
   //         alert("SablonWrite=" + parSblNum.value + '  @  ' + TxtSbl.innerHTML);
            window.opener.HandlePopupResult(parSblNum.value + '002@' + TxtSbl.innerHTML);
            self.close();
        }

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string AmbCrdIdn;
    string AmbUslIdn;
    string AmbUslIdnTek;
    string ParTyp;
    string BuxFrm;
    string BuxKod;
    string BuxSid;

//    string Col003;
//    string Col004;
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        ParTyp = Convert.ToString(Request.QueryString["SblTyp"]);
        
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxSid = (string)Session["BuxSid"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
        parSblNum.Value = ParTyp;

        if (ParTyp == "Jlb") TxtSap.Text = "ЖАЛОБА";
        if (ParTyp == "Anm") TxtSap.Text = "АНАМНЕЗ БОЛЕЗНИ";
        if (ParTyp == "Stt") TxtSap.Text = "СТАТУС ЛОКАЛИУС";
        if (ParTyp == "Dig") TxtSap.Text = "ДИАГНОЗ";
        if (ParTyp == "Dsp") TxtSap.Text = "ДИАГНОЗ ДОПОЛНИТЕЛЬНЫЙ";
        if (ParTyp == "Lch") TxtSap.Text = "ПЛАН ЛЕЧЕНИЯ";
        if (ParTyp == "Ops") TxtSap.Text = "ОПИСАНИЕ ИССЛЕДОВАНИЯ";
        if (ParTyp == "Zak") TxtSap.Text = "ЗАКЛЮЧЕНИЕ";
        if (ParTyp == "Rek") TxtSap.Text = "РЕКОМЕНДАЦИЙ";

        if (!Page.IsPostBack)
        {
            TxtSbl.Attributes.Add("onchange", "onChange('TxtSbl',TxtSbl.value);");

            // --------------------------  считать данные одного врача -------------------------
            DataSet ds = new DataSet();
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("HspAmbSbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            cmd.Parameters.Add("@BUXTYP", SqlDbType.VarChar).Value = ParTyp;

            // создание DataAdapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // заполняем DataSet из хран.процедуры.
            da.Fill(ds, "HspAmbSbl");
            con.Close();

            TxtSbl.Text = "";
            if (ds.Tables[0].Rows.Count > 0)
               {
                 TxtSbl.Text = Convert.ToString(ds.Tables[0].Rows[0]["SBLTXT"]);
               }
        }
    }

    //===============================================================================================================

</script>


<body>
    <form id="form1" runat="server">
       <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="parSblNum" runat="server" />

        <%-- ============================  верхний блок  ============================================ --%>

            <table border = "1" cellspacing="0" width="100%" cellpadding="0">
                <tr>
                    <td width="100%" >
                        <asp:TextBox ID="TxtSap" Width="100%" Height="30" runat="server" Style="font-weight: 700; font-size: large; text-align:center" />
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <asp:TextBox ID="TxtSbl" Width="100%" Height="300" TextMode="MultiLine" runat="server" Style="font-weight: 700; font-size: large;" />

                    </td>
                </tr>
                <tr>
                    <td width="100%" style="text-align:center">
                        <asp:Button ID="Button1" runat="server"
                            OnClientClick="SablonWrite()"
                            Width="40%" CommandName="Cancel"
                            Text="В амб.карту" Height="25px"
                            Style="top: 0px; left: 0px;" />
                    </td>
                </tr>
            </table>


    </form>

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
            outline: 0;
            width: 100%;
            font-size: 12px !important;  // для увеличения коррект поля
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

    white-space: -moz-pre-wrap !important;
    white-space: -pre-wrap; 
    white-space: -o-pre-wrap; 
    white-space: pre-wrap;
    word-wrap: break-word;


        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }

    </style>



</body>

</html>



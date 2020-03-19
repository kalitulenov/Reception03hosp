<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>

    <style type="text/css">

        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 25px;
            font-size: 15px;
        }

        /*------------------------- для кнопки  --------------------------------*/

        .submit {
        border: 1px solid #563d7c;
        border-radius: 5px;
        color: black;
        padding: 5px 10px 5px 25px;
    }

   .largerCheckbox input{    
         width: 20px;    
         height: 20px;
    }
    </style>


    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;
        //         alert("DocAppAmbPsm");


        //    ------------------ смена логотипа ----------------------------------------------------------
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

    </script>


    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>
    <%-- ************************************* программа C# **************************************************** --%>

    <script runat="server">

        string BuxKod;
        string BuxSid;
        string BuxFrm;

        string MdbNam = "HOSPBASE";
        //=============Установки===========================================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            //=====================================================================================
            BuxSid = (string)Session["BuxSid"];
            BuxFrm = (string)Session["BuxFrmKod"];
            //=====================================================================================

            if (!Page.IsPostBack)
            {

            }
            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;
            ConfirmOK.Visible = false;
            ConfirmOK.VisibleOnLoad = false;
        }

        // ============================ кнопка новый документ  ==============================================

       // ============================ проверка и опрос для записи документа в базу ==============================================
        protected void AddButton_Click(object sender, EventArgs e)
        {
            ConfirmDialog.Visible = true;
            ConfirmDialog.VisibleOnLoad = true;
        }

                // ============================ одобрение для записи документа в базу ==============================================
        protected void btnOK_click(object sender, EventArgs e)
        {
            ConfirmDialog.Visible = false;
            ConfirmDialog.VisibleOnLoad = false;

            // ============================ чтение заголовка таблицы а оп ==============================================
             // строка соединение
            string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("BuxSldGod", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@BUXSID", SqlDbType.VarChar).Value = BuxSid;
            cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
  //          cmd.Parameters.Add("@BUXKOD", SqlDbType.Int, 4).Value = BuxKod;
            cmd.Parameters.Add("@BUXGOD", SqlDbType.Int, 4).Value = BoxGod.SelectedValue;
            cmd.Parameters.Add("@BUXACC", SqlDbType.VarChar).Value = Chk11.Checked;
            cmd.Parameters.Add("@BUXANL", SqlDbType.VarChar).Value = Chk12.Checked;
            cmd.Parameters.Add("@BUXFIX", SqlDbType.VarChar).Value = Chk13.Checked;
            cmd.Parameters.Add("@BUXMAT", SqlDbType.VarChar).Value = Chk14.Checked;
            cmd.Parameters.Add("@BUXAMR", SqlDbType.VarChar).Value = Chk15.Checked;

            // ------------------------------------------------------------------------------заполняем первый уровень
            cmd.ExecuteNonQuery();
            con.Close();

            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
    //        Response.Redirect("~/BuxDoc/BuxDoc.aspx?NumSpr=Прх&TxtSpr=Приходные накладные (материалы)");
        }

        protected void CanButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/GlavMenu.aspx");
        }
                
    </script>


    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>

    <%-- ============================  для передач значении  ============================================ --%>
    <asp:HiddenField ID="parMkbNum" runat="server" />
    <%-- ============================  шапка экрана ============================================ --%>

    <div>

        <%-- ============================  шапка экрана ============================================ --%>
        <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
      <%-- ============================  Титул  ============================================ --%>
        <asp:Panel ID="PanelTit" runat="server" BorderStyle="Double" ScrollBars="None"
            Style=" position: relative; top: 50px; left: 20%; width: 60%; height: 30px;">
            <select id="Select1">
                <option></option>

            </select>
            <asp:Label ID="Label17" Text="Переход на следующий год :" runat="server" Font-Bold="true" Font-Size="Large" width="50%"/>
            <asp:DropDownList runat="server" ID="BoxGod" Width="10%"  Font-Size="Large" AutoPostBack="false">
                            <Items>
                                <asp:ListItem Text="2017" Value="2017" />
                                <asp:ListItem Text="2018" Value="2018" />
                                <asp:ListItem Text="2019" Value="2019" />
                                <asp:ListItem Text="2020" Value="2020" />
                                <asp:ListItem Text="2021" Value="2021" />
                                <asp:ListItem Text="2022" Value="2022" />
                                <asp:ListItem Text="2023" Value="2023" />
                                <asp:ListItem Text="2024" Value="2024" />
                                <asp:ListItem Text="2025" Value="2025" />
                                <asp:ListItem Text="2026" Value="2026" />
                                <asp:ListItem Text="2027" Value="2027" />
                                <asp:ListItem Text="2028" Value="2028" />
                                <asp:ListItem Text="2029" Value="2029" />
                                <asp:ListItem Text="2030" Value="2030" />
                            </Items>
                        </asp:DropDownList>

        </asp:Panel>
        <%-- ============================  верхний блок  ============================================ --%>

        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style=" position: relative; top: 50px; left: 20%; width: 60%; height: 320px;">

            <table border="0" cellspacing="0" width="100%" cellpadding="0" >
                <!--  Язык ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:Label ID="Label00" Text="№" runat="server" Width="100%" Font-Bold="true" Font-Size="Larger" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:Label ID="Label11" Text="ТАБЛИЦЫ" runat="server" Width="100%" Font-Bold="true" Font-Size="Larger" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:Label ID="Label12" Text="ВЫБОР" runat="server" Width="100%" Font-Bold="true" Font-Size="Larger" />
                    </td>
                </tr>
                <!--  Остатки счетов ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;" >
                        <asp:TextBox ID="Lab01" Width="100%" Height="20" BorderStyle="None" Text="1." runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Sub01" Width="100%" Height="20" BorderStyle="None" Text="Остатки счетов" runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="Chk11" class="largerCheckbox" runat="server" />
                    </td>
                </tr>

                <!--  Остатки аналитик ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Lab02" Width="100%" Height="20" BorderStyle="None" Text="2."  runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Sub02" Width="100%" Height="20" BorderStyle="None" Text="Остатки аналитик" runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="Chk12" class="largerCheckbox" runat="server" />
                    </td>
                </tr>

                <!--  Основные средства ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                     <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Lab03" Width="100%" Height="20" BorderStyle="None" Text="3." runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Sub03" Width="100%" Height="20" BorderStyle="None" Text="Основные средства" runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="Chk13" class="largerCheckbox" runat="server"/>
                    </td>
                </tr>

                <!--  Материалы ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Lab04" Width="100%" Height="20" BorderStyle="None"  Text="4." runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Sub04" Width="100%" Height="20" BorderStyle="None" Text="Материалы" runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="Chk14" class="largerCheckbox" runat="server"/>
                    </td>
                </tr>

                <!--  Накопленный износ ----------------------------------------------------------------------------------------------------------  -->
                <tr>
                    <td  height="30" width="3%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Lab05" Width="100%" Height="20" BorderStyle="None" Text="5." runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="70%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:TextBox ID="Sub05" Width="100%" Height="20" BorderStyle="None" Text="Накопленный износ" runat="server" Style="font-size: large;" ReadOnly="true" />
                    </td>
                    <td  height="30" width="10%" style="vertical-align: top; padding: 3px; border: 1px solid black;">
                        <asp:CheckBox ID="Chk15" class="largerCheckbox" runat="server"/>
                    </td>
                </tr>

               <!--  Класс ----------------------------------------------------------------------------------------------------------  -->

            </table>

            <!-- Результат ---------------------------------------------------------------------------------------------------------- 
     
       -->
        </asp:Panel>

        <%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
        <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
            Style=" position: relative; top: 0%; left: 20%; width: 60%; height: 30px;">
            <center>
                    <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Перевод" OnClick="AddButton_Click"  CssClass="submit" />
                    <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" OnClick="CanButton_Click" CssClass="submit" />
                </center>


        </asp:Panel>

    </div>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
     
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="450" Height="150" StyleFolder="/Styles/Window/wdstyles/default" Title="" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Text="                     Готова..." BackColor="Transparent" BorderStyle="None"  Font-Size="Large"  Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" style="width:150px; height:30px;"  onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
              <!--     Dialog должен быть раньше Window-->
       <owd:Dialog ID="ConfirmDialog" runat="server" Visible="false" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите сделать перевод ?</td>
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


</asp:Content>



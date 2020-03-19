<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxDocVoz.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxDocVoz" %>

<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
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
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
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

        /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }

       /*------------------------- для алфавита   letter-spacing:1px;--------------------------------*/
            a.pg{
				font:12px Arial;
				color:#315686;
				text-decoration: none;
                word-spacing:-2px;
               

			}
			a.pg:hover {
				color:crimson;
			}
    </style>
 
<%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        var myconfirm = 0;

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

        // Client-Side Events for Delete
        function OnBeforeDelete(sender, record) {

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
            for (var i = 0; i < GridMat.Rows.length; i++) {
                if (GridMat.Rows[i].Cells[0].Value == record.DTLIDN) {
                    index = i;

                    break;
                }
            }
            return index;
        }

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridMat.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
  //          alert("1");
            var DatDocIdn = document.getElementById('MainContent_parDocIdn').value;
  //          alert("2");
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=BuxVozDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=BuxVozDoc&TekDocIdn=" + DatDocIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }
    </script>


   

<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
  <asp:HiddenField ID="parDocIdn" runat="server" />

<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="Возврат ТМЗ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 10%; position: relative; width: 80%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 60px;">

        <table border="0" cellspacing="0" width="100%" cellpadding="0">
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label01" runat="server" align="center" Style="font-weight: bold;" Text="№ док.:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                    <asp:TextBox ID="TxtDocNum" Width="20%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label2" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtDocDat" Width="80px" />
                    <obout:Calendar ID="CalDoc" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtDocDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />

                </td>
                <td width="20%" style="vertical-align: top;">
                    <asp:Label ID="Label3" runat="server" align="center" Style="font-weight: bold;" Text="Поставщик:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 30%">
                    <%-- ============================  выбор поставщика  ============================================ --%>
                    <obout:ComboBox runat="server"
                        AutoPostBack="false"
                        ID="BoxOrg"
                        Width="90%"
                        Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        EmptyText="Выберите поставщика ..."
                        DataSourceID="sdsOrg"
                        DataTextField="ORGNAM"
                        DataValueField="ORGKOD" />
                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->
            <tr>
                <td width="10%" style="vertical-align: top;">
                    <asp:Label ID="Label4" runat="server" align="center" Style="font-weight: bold;" Text="Счет:"></asp:Label>
                </td>
                <td width="40%" style="vertical-align: top;">
                     <obout:ComboBox runat="server" ID="BoxAcc" Width="25%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsAcc" DataTextField="ACCKOD" DataValueField="ACCKOD">
                    </obout:ComboBox>

                    <asp:Label ID="Label5" runat="server" align="center" Style="font-weight: bold;" Text="МОЛ:"></asp:Label>
                     <obout:ComboBox runat="server" ID="BoxMol" Width="50%" Height="200"
                        FolderStyle="/Styles/Combobox/Plain"
                        DataSourceID="sdsMol" DataTextField="MOLNAM" DataValueField="MOLKOD">
                    </obout:ComboBox>

                </td>
                <td width="20%" style="vertical-align: top;">
                    <asp:Label ID="Label6" runat="server" align="center" Style="font-weight: bold;" Text="Документ отгрузки:"></asp:Label>
                </td>
                <td style="vertical-align: top; width: 30%">
                    <asp:TextBox ID="TxtFkt" Width="50%" Height="16" runat="server" Style="font-weight: 700; font-size: small; text-align: center" />
                    <asp:Label ID="Label10" runat="server" align="center" Style="font-weight: bold;" Text="от"></asp:Label>
                    <asp:TextBox runat="server" ID="TxtFktDat" Width="70px" />
                    <obout:Calendar ID="CalFkt" runat="server"
                        StyleFolder="/Styles/Calendar/styles/default"
                        DatePickerMode="true"
                        ShowYearSelector="true"
                        YearSelectorType="DropDownList"
                        TitleText="Выберите год: "
                        CultureName="ru-RU"
                        TextBoxId="TxtFktDat"
                        DatePickerImagePath="/Styles/Calendar/styles/icon2.gif" />


                </td>
            </tr>
            <!--  ----------------------------------------------------------------------------------------------------------------  -->

        </table>


    </asp:Panel>
    <%-- ============================  средний блок  ============================================ --%>

    <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
        Style="left: 10%; position: relative; top: 0px; width: 80%; height: 400px;">


        <obout:Grid runat="server"
            ID="GridMat"
            Serialize="true"
            AutoGenerateColumns="false"
            FolderStyle="~/Styles/Grid/style_5"
            ShowTotalNumberOfPages="false"
            FolderLocalization="~/Localization"
            AllowSorting="false"
            Language="ru"
            CallbackMode="true"
            AllowPaging="false"
            AllowPageSizeSelection="false"
            ShowColumnsFooter="true"
            Width="100%"
            PageSize="-1">
            <ClientSideEvents ExposeSender="true"  OnBeforeClientDelete="OnBeforeDelete" />
            <ScrollingSettings ScrollHeight="310" />
            <Columns>
                <obout:Column ID="Column00" DataField="DTLIDN" Visible="false" HeaderText="Идн" Width="0%" />
                <obout:Column ID="Column01" DataField="DTLKRD" HeaderText="Счет" Align="right" Width="7%">
                    <TemplateSettings EditTemplateId="TemplateEditAccNam" />
                </obout:Column>
                <obout:Column ID="Column02" DataField="DTLKOD" HeaderText="Наименование" Width="34%">
                    <TemplateSettings TemplateId="TemplateMatNam" EditTemplateId="TemplateEditMatNam" />
                </obout:Column>
                <obout:Column ID="Column03" DataField="DTLKOL" HeaderText="Кол-во"  Width="8%" Align="right" DataFormatString="{0:F2}" />
                <obout:Column ID="Column04" DataField="DTLEDN" HeaderText="Ед.изм" ReadOnly="true" Width="6%" Align="right"/>
                <obout:Column ID="Column05" DataField="DTLUPK" HeaderText="В упк" ReadOnly="true"  Width="8%" Align="right" DataFormatString="{0:F0}" />
                <obout:Column ID="Column06" DataField="DTLZEN" HeaderText="Цена" ReadOnly="true"  Width="10%" Align="right" DataFormatString="{0:F2}" />
                <obout:Column ID="Column07" DataField="DTLSUM" HeaderText="Сумма"  ReadOnly="true" Width="10%" Align="right" DataFormatString="{0:F2}" />
                <obout:Column ID="Column08" DataField="GRPMATNAM" HeaderText="Мат.группа" ReadOnly="true" Width="10%" />

                <obout:Column ID="Column09" DataField="" HeaderText="Корр" Width="7%" AllowEdit="true" AllowDelete="true" runat="server" />
            </Columns>
            <Templates>

                <obout:GridTemplate runat="server" ID="TemplateMatNam">
                    <Template>
                        <%# Container.DataItem["MATNAM"]%>
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="TemplateEditMatNam" ControlID="ddlMatNam" ControlPropertyName="value">
                    <Template>
                        <asp:DropDownList ID="ddlMatNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsMat" CssClass="ob_gEC" DataTextField="MATNAM" DataValueField="MATKOD">
                            <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                        </asp:DropDownList>
                    </Template>
                </obout:GridTemplate>


                    <obout:GridTemplate runat="server" ID="TemplateEditAccNam" ControlID="ddlAccNam" ControlPropertyName="value">
                        <template>
                           <asp:DropDownList ID="ddlAccNam" runat="server" Width="99%" DataSourceID="sdsAcc" CssClass="ob_gEC" DataTextField="ACCKOD" DataValueField="ACCKOD">
                                <asp:ListItem Text="Выберите..." Value="" Selected="True" />
                           </asp:DropDownList>	
		                </template>
                    </obout:GridTemplate>

            </Templates>


        </obout:Grid>
    </asp:Panel>

     <%-- ============================  нижний блок  ============================================ 
                 <obout:Column ID="Column06" DataField="DTLNDC" HeaderText="НДС" Align="right" Width="5%" >
                        <TemplateSettings TemplateId="TemplateNdc" EditTemplateId="TemplateEditNdc" />
                </obout:Column>
                <obout:Column ID="Column09" DataField="DTLSRKSLB" HeaderText="Срок храниения" DataFormatString="{0:dd/MM/yy}" Width="9%" >
                    <TemplateSettings EditTemplateId="tplDatePicker1" />
                </obout:Column>      
          
 

                   <obout:GridTemplate runat="server" ID="TemplateNdc" UseQuotes="true">
                        <Template>
                            <%# (Container.Value == "True" ? "+" : " ") %>
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplateEditNdc" ControlID="chkNdc" ControlPropertyName="checked" UseQuotes="false">
                        <Template>
                            <input type="checkbox" id="chkNdc" />
                        </Template>
                    </obout:GridTemplate>
                 
                      <obout:GridTemplate runat="server" ID="tplDatePicker1" ControlID="txtOrderDate1" ControlPropertyName="value">
                        <template>
   		            <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
   		                <tr>
  		                    <td valign="middle">
      	                        <obout:OboutTextBox runat="server" ID="txtOrderDate1" Width="100%"
         	                            FolderStyle="~/Styles/Grid/style_51/interface/OboutTextBox" />
       	                    </td>
                            <td valign="bottom" width="30">			                        
                               <obout:Calendar ID="cal1" runat="server" 
                                      StyleFolder="~/Styles/Calendar/styles/default" 
			                          DatePickerMode="true"
			                          ShowYearSelector="true"
			                          YearSelectorType="DropDownList"
				                      TitleText="Выберите год: "
				   	 	              CultureName = "ru-RU"
					                  DatePickerImagePath ="~/Styles/Calendar/styles/icon2.gif"/>
                            </td>
				         </tr>
					</table>
		       </template>
                    </obout:GridTemplate>       
         --%>

 <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
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
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
                            <asp:Button runat="server" ID="btnOK" Text="ОК" OnClick="btnOK_click" />
                            <asp:Button runat="server" ID="btnCancel" Text="Отмена" onclick="ConfirmDialog.Close();" />
 --%>
        
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
                                <input type="button" value="Отмена" onclick="myConfirmBeforeDelete.Close();" />
                            </td>
                        </tr>
                    </table>
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

           <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="MatWindow" runat="server"  Url="" IsModal="true" ShowCloseButton="true" Status="" OnClientClose="WindowClose();"
             Left="300" Top="100" Height="400" Width="800" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Материалы">

       </owd:Window>

 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
	<asp:SqlDataSource ID="sdsDtl" runat="server"></asp:SqlDataSource>
 <%-- =================  источник  для ГРИДА============================================ 
	<asp:SqlDataSource ID="sdsDtl" runat="server">
         <UpdateParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DTLNAM" Type="String" />
            <asp:Parameter Name="DTLKOL" Type="Int32" />
            <asp:Parameter Name="DTLEDN" Type="String" />
            <asp:Parameter Name="DTLZEN" Type="Int32" />
            <asp:Parameter Name="DTLSUM" Type="Int32" />
            <asp:Parameter Name="DTLIZG" Type="String" />
            <asp:Parameter Name="DTLSRKSLB" Type="DateTime" />
         </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="DTLIDN" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
--%>    
<%-- =================  источник  для КАДРЫ ============================================ --%>
    	    <asp:SqlDataSource runat="server" ID="sdsEdn" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsOrg" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsAcc" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMol" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsMat" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
		    
<%-- =================  прочие ============================================ --%>
    
       
</asp:Content>

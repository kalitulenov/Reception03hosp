<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxDocPrf.aspx.cs" Inherits="Reception03hosp45.Prof.BuxDocPrf" %>

<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
        /*-----------------для укрупнения шрифта COMBOBOX  в GRID -----------------------*/
        .ob_gEC
         {
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

          var myconfirm = 0;


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
              for (var i = 0; i < Grid1.Rows.length; i++) {
                  if (Grid1.Rows[i].Cells[0].Value == record.DTLIDN) {
                      index = i;

                      break;
                  }
              }
              return index;
          }

          function ConfirmBeforeDeleteOnClick() {
              myconfirm = 1;
              Grid1.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
              myConfirmBeforeDelete.Close();
              myconfirm = 0;
          }
</script>


   

<%-- ============================  для передач значении  ============================================ --%>
  <span id="WindowPositionHelper"></span>
  <input type="hidden" name="hhh" id="par" />
  <input type="hidden" name="aaa" id="cntr"  value="0"/>
<%-- ============================  шапка экрана ============================================ --%>
       <asp:TextBox ID="Sapka0" 
             Text="ПРОФОСМОТР" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 10%; position: relative; width: 80%; text-align:center"
             runat="server"></asp:TextBox>
<%-- ============================  верхний блок  ============================================ --%>
 <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 40px;">
     
    <table border="1" cellspacing="0" width="100%">
        <tr>
           <td>
             <table>
              <tr>
               <td class="PO_RowCap">Номер&nbsp;документа:
                 </td>
                 <td>
                    <asp:TextBox id="DOCNUM" Width="60" Height="20" RunAt="server" BackColor="#FFFFE0" />
                </td>
                <td class="PO_RowCap" align="right">
                   от
                </td>
                 <td align="left">
                     <asp:TextBox runat="server" id="DOCDAT" Width="80px" />
		        	 <obout:Calendar ID="cal1" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "DOCDAT"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
                </td>
                <td>
                   &nbsp;
                </td>
                <td class="PO_RowCap">Поставщик:
                 </td>
                 <td>
                   <%-- ============================  выбор поставщика  ============================================ --%>
                     <obout:ComboBox runat="server" 
                            AutoPostBack="true"
                            ID="BoxOrg" 
                            Width="200px" 
                            Height="200"
                            EmptyText="Выберите поставщика ..."
                            DataSourceID="sdsOrg" 
                            DataTextField="ORGNAM" 
                            DataValueField="ORGKOD"/>
                 </td>
              </tr>
            </table>
        </td>
      </tr>
   </table>
          
   </asp:Panel>                
<%-- ============================  средний блок  ============================================ --%>
  
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 400px;"> 
  
 
	  <obout:Grid runat="server" 
                ID="Grid1" 
                Serialize="true" 
                AutoGenerateColumns="false" 
                FolderStyle="~/Styles/Grid/style_5" 
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowSorting="false"
	            Language = "ru"
	            CallbackMode="true"
                AllowPaging="false"
                AllowPageSizeSelection="false"
	            ShowColumnsFooter = "true"
	            Width="100%"
	            PageSize = "-1">
       	<ClientSideEvents 
		        OnBeforeClientDelete="OnBeforeDelete"
		        ExposeSender="true"/>
	    <ScrollingSettings ScrollHeight="310" />
	    <Columns>
            <obout:Column ID="Column1" DataField="DTLIDN" Visible="false" />
            <obout:Column ID="Column2" DataField="DTLNOMNUM" HeaderText="ИИН" Width="10%" />
            <obout:Column ID="Column3" DataField="DTLNAM" HeaderText="Наименование" Width="80%" />
	        <obout:Column ID="Column4" DataField="" HeaderText="Корр" Width="10%" AllowEdit="true" AllowDelete="true" runat="server" />
		</Columns>	
	
    </obout:Grid>
 </asp:Panel>
 <%-- ============================  нижний блок  ============================================ --%>

  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 10%; position: relative; top: 0px; width: 80%; height: 30px;">
             <center>
                 <asp:Button ID="GnrButton" runat="server" CommandName="Gnr" Text="Загрузить" onclick="GnrButton_Click"/>
                 <asp:Button ID="PrvButton" runat="server" CommandName="Add" Text="Проверить" onclick="PrvButton_Click"/>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Записать" onclick="AddButton_Click"/>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel> 
  
 <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
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
		    
<%-- =================  прочие ============================================ --%>
    
       
</asp:Content>

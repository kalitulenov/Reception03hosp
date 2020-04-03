<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="BuxDoc.aspx.cs" Inherits="Reception03hosp45.Prof.BuxDoc" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- для диалога -------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
<%-- ============================  JAVA ============================================ --%>
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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
    </style>

 <script type="text/javascript">
     var myconfirm = 0;


     // Client-Side Events for Delete
     function OnBeforeDelete(sender, record)
      {
          if (myconfirm == 1) 
         {
             return true;
         }
         else {
             document.getElementById('myConfirmBeforeDeleteContent').innerHTML = "Хотите удалить документ ?";
             document.getElementById('myConfirmBeforeDeleteHidden').value = findIndex(record);
             myConfirmBeforeDelete.Open();
             return false;
         }
     }

     function findIndex(record) 
     {
         var index = -1;
         for (var i = 0; i < GridDoc.Rows.length; i++) {
             if (GridDoc.Rows[i].Cells[0].Value == record.DOCIDN) 
             {
                 index = i;
                 break;
             }
         }
         return index;
     }

     function ConfirmBeforeDeleteOnClick() 
     {
         myconfirm = 1;
  //       alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
         GridDoc.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
         myConfirmBeforeDelete.Close();
         myconfirm = 0;
     }

     function OnClientDblClick(sender, iRecordIndex) {
         var GlvDocTyp = document.getElementById('<%= parDocTyp.ClientID%>').value;
         
            // sender, добавляется при ExposeSender="true"
            alert("iRecordIndex=" + iRecordIndex);
  //          var elems = $("tr[class^='ob_gR'] td[class='ob_gC_I'] div[class='ob_gCc2']");
  //          var GlvDocIdn = $(elems[iRecordIndex]).text();
            var GlvDocIdn = GridDoc.Rows[iRecordIndex].Cells[0].Value;
 //           var GlvDocPrv = GridDoc.Rows[iRecordIndex].Cells[7].Value;
 //    alert('GlvDocIdn=' + GlvDocIdn);
 //    alert('GlvDocPrv=#' + GlvDocPrv+'#'); 

            switch (GlvDocTyp) 
            {
                case 'ПРФ': location.href = "/Prof/BuxDocPrf.aspx?GlvDocIdn=" + GlvDocIdn + "&GlvDocPrv=0"; break;
            }
             
        }
 </script>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
   
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: 25%; position: relative; top: 0px; width: 680px; height: 30px;">
             
<%--             <div style="float:left;  width: 50%; position: relative; left: 20px; color: green; "> </div>   --%>
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
			 
             <ASP:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
			 <obout:Calendar ID="cal2" runat="server"
			 				StyleFolder="/Styles/Calendar/styles/default" 
						    DatePickerMode="true"
						    ShowYearSelector="true"
						    YearSelectorType="DropDownList"
						    TitleText="Выберите год: "
						    CultureName = "ru-RU"
						    TextBoxId = "txtDate2"
						    DatePickerImagePath ="/Styles/Calendar/styles/icon2.gif"/>
						    
             <asp:Button ID="PushButton" runat="server" CommandName="Push" Text="Обновить" onclick="PushButton_Click"/>
           </center> 
            
        </asp:Panel> 
<%-- ============================  средний блок  ============================================ --%>
   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 25%; position: relative; top: 0px; width: 680px; height: 450px;">
	        
	        <obout:Grid id="GridDoc" runat="server" 
                CallbackMode="true" 
                Serialize="true" 
	            FolderStyle="~/Styles/Grid/style_5" 
	            AutoGenerateColumns="false"
	            ShowTotalNumberOfPages = "false"
	            FolderLocalization = "~/Localization"
	            AllowAddingRecords="false" 
	            Language = "ru"
	            PageSize = "-1"
	            AllowPaging="false"
	            Width="100%"
                AllowPageSizeSelection="false"
	            ShowColumnsFooter = "true" >
	            <ClientSideEvents ExposeSender="true" 
	                      OnClientDblClick="OnClientDblClick" 
	                      OnBeforeClientDelete="OnBeforeDelete" />
                <Columns>
	        	    <obout:Column ID="Column1" DataField="DOCIDN" HeaderText="Идн" Visible="false" Width="0%"/>
                    <obout:Column ID="Column2" DataField="DOCNUM" HeaderText="Номер" Align="right" Width="8%"/>
	                <obout:Column ID="Column3" DataField="DOCDAT" HeaderText="Дата"  DataFormatString = "{0:dd/MM/yy}" Width="11%" />
	                <obout:Column ID="Column4" DataField="FRMSHR" HeaderText="Поставщик" Width="54%" />
	                <obout:Column ID="Column7" DataField="BUX" HeaderText="Ответст." Width="15%" />
	                <obout:Column ID="Column8" DataField="FLG" HeaderText="Проведен" Width="6%" />
		            <obout:Column ID="Column9" DataField="" HeaderText="Корр" Width="6%" AllowEdit="false" AllowDelete="true" runat="server" />
		        </Columns>
           	</obout:Grid>
  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 25%; position: relative; top: 0px; width: 680px; height: 30px;">
             <center>
                 <asp:Button ID="AddButton" runat="server" CommandName="Add" Text="Новый док" onclick="AddButton_Click"/>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Назад" onclick="CanButton_Click"/>
             </center>
             

  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ --%>
     
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
    
<%-- =================  источник  для ГРИДА============================================ --%>

 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

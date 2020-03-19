<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="SprCabDoc.aspx.cs" Inherits="Reception03hosp45.Spravki.SprCabDoc" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<%-- ================================================================================ --%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
   
   <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">

      /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

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
    

     <script type="text/javascript">

         var myconfirm = 0;

         function OnBeforeDelete(sender, record) {
             //            alert("myconfirm=" + myconfirm);  
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
             for (var i = 0; i < GridGrf.Rows.length; i++) {
                 if (GridGrf.Rows[i].Cells[0].Value == record.GrfIdn) {
                     index = i;
                     //                          alert('index: ' + index);

                     break;
                 }
             }
             return index;
         }

         function ConfirmBeforeDeleteOnClick() {
             myconfirm = 1;
             GridGrf.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
             myConfirmBeforeDelete.Close();
             myconfirm = 0;
         }
      
         window.onload = function () {
             window.setTimeout(hidePagingButtons, 250);
         }

 </script>
 
  <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Position="SCREEN_CENTER" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
     
<!--  источники -----------------------------------------------------------  -->    
    	    <asp:SqlDataSource runat="server" ID="sds1" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    	    <asp:SqlDataSource runat="server" ID="sds2" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsStf" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
            <asp:SqlDataSource runat="server" ID="sdsStt" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>	
    <!--------------------------------------------------------  -->   
     <asp:HiddenField ID="ParRadUbl" runat="server" />
     <asp:HiddenField ID="parGrfFrm" runat="server" />

    <div>
        <asp:TextBox ID="TextBox1"
            Text="                          Справочник кабинет+врачи"
            BackColor="#0099FF"
            Font-Names="Verdana"
            Font-Size="20px"
            Font-Bold="True"
            ForeColor="White"
            Style="top: 0px; left: 25%; position: relative; width: 50%"
            runat="server"></asp:TextBox>

        <div id="div_cnt" style="position: relative; left: 25%; width: 50%;">
            <obout:Grid ID="GridGrf" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                Width="100%"
                 EnableTypeValidation="false"
             AllowFiltering="true" 
                AllowSorting="true"
                AllowPageSizeSelection="false"
                AllowAddingRecords="true"
                AllowRecordSelection="true"
                KeepSelectedRecords="true">
                <ScrollingSettings ScrollHeight="500" />
                <Columns>
                    <obout:Column ID="Column1" DataField="GrfIdn" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column2" DataField="GrfCab" HeaderText="КАБИНЕТ" Align="center" Width="10%" />
                    <obout:Column ID="Column3" DataField="GrfKod" HeaderText="ВРАЧ" Width="80%">
                        <TemplateSettings TemplateId="TemplateGrfNam" EditTemplateId="TemplateEditGrfNam" />
                    </obout:Column>
                    <obout:Column ID="Column4" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>

                <Templates>

                    <obout:GridTemplate runat="server" ID="TemplateGrfNam">
                        <Template>
                            <%# Container.DataItem["FIODLG"]%>
                        </Template>
                    </obout:GridTemplate>

                    <obout:GridTemplate runat="server" ID="TemplateEditGrfNam" ControlID="ddlGrfNam" ControlPropertyName="value">
                        <Template>
                            <asp:DropDownList ID="ddlGrfNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sds1" CssClass="ob_gEC" DataTextField="FIODLG" DataValueField="BUXKOD">
                                <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                            </asp:DropDownList>
                        </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>


        </div>

        <div class="YesNo" title="Хотите удалить ?" style="display: none">
            Хотите удалить запись ?
        </div>


    </div>
       

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DatBegEnd.aspx.cs" Inherits="Reception03hosp45.Operation.DatBegEnd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<!--  ссылка на JQUERY DATEPICKER-------------------------------------------------------------- -->

    <link href="/Styles/DatePicker/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
  
    <script src="/JS/DatePicker/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.core.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
    <script src="/JS/DatePicker/DatePickerRus.js" type="text/javascript"></script>   
<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 
<!--  END -------------------------------------------------------------- --></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <script type="text/javascript">
 /* Организация диалога на добавления -----------------------------------------------------------------------*/
      $(function() {
        $(".InpBegEndDat").dialog({
                autoOpen: false,
                width: 500,
                height: 180,
                modal: true,
                open: function(event, ui) {
                    $(".DatePickerInput").datepicker("enable");
                },
                buttons:
                {
                    "OK": function() {
                        var StartDate = $("#<%= txtEventStartDate.ClientID  %>").val();
                        var EndDate = $("#<%= txtEventEndDate.ClientID  %>").val();
                        //                       alert(StartDate);
 //                                  alert("Successfully added new item");

                        $.ajax({
                            type: 'POST',
                            url: 'DatBegEnd.aspx/BegEndDatOk',
                            data: '{"StartDate":"' + StartDate + '","EndDate":"'+EndDate+'"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (msg) {
                                    $(this).dialog("close");
                            },
                            error: function() {
                                   alert("Error! Try again..." + StartDate);
                               }

                        });
                        $(this).dialog("close");
                        
                    },
                    "Отмена": function() {
                        $(this).dialog("close");
                    }
                }
         });
     });
  

</script>
        <div class="InpBegEndDat" title=" Укажите период" >
            <table>
                <tr>
                    <td>Начало &nbsp;&nbsp;</td>
                    <td><asp:TextBox ID="txtEventStartDate" Width ="120px" runat="server" CssClass="DatePickerInput" /></td>
                    <td>Конец &nbsp;&nbsp;</td>
                    <td><asp:TextBox ID="txtEventEndDate" Width ="120px" runat="server" CssClass="DatePickerInput" /></td>
                </tr>
            </table>
            <br />
            <asp:Literal ID="litMessage" runat="server" />
        </div>  
</asp:Content>

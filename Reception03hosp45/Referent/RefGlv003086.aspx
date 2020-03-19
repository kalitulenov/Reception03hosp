<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="RefGlv003086.aspx.cs" Inherits="Reception03hosp45.Referent.RefGlv003086" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



        <script type="text/javascript">
            //    ---------------- обращение веб методу --------------------------------------------------------
            function MedDocXls(rowIndex) {
             //   alert("rowIndex=" + rowIndex);
                    var AmbCrdIdn = GridGrf.Rows[rowIndex].Cells[0].Value;
                    var AmbCrdTyp = GridGrf.Rows[rowIndex].Cells[2].Value;
                    var ua = navigator.userAgent;
                    if (ua.search(/Chrome/) > -1)
                        window.open("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + AmbCrdTyp, "ModalPopUp", "toolbar=no,width=1300,height=700,left=50,top=50,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
                    else
                        window.showModalDialog("/Priem/DocApp061win.aspx?AmbCrdIdn=" + AmbCrdIdn + "&AmbDocTyp=" + AmbCrdTyp, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:50px;dialogtop:50px;dialogWidth:1300px;dialogHeight:700px;");
            }


 		    //==============================================================================================
 		    //================================================================================================== 		    
 		    
    </script>

</head>
<body>
    <form id="form1" runat="server">
            <asp:HiddenField ID="parUpd" runat="server" />
            <asp:HiddenField ID="parInd" runat="server" />
            <asp:HiddenField ID="parBuxKod" runat="server" />

    <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

    <div style="top: -20px">
            <obout:Grid ID="GridGrf" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                PageSize="-1"
                ShowLoadingMessage="false"
                AllowRecordSelection="false"
                AllowPageSizeSelection="false"
                AllowAddingRecords="false"
                Width="100%"
                AllowPaging="false"
                AllowFiltering="false">
  	            <ClientSideEvents ExposeSender="true" />
              <Columns>
                    <obout:Column ID="Column100" DataField="GRFIDN" HeaderText="Идн" Visible="false" Width="0px" />
                    <obout:Column ID="Column101" DataField="GRFKOD" HeaderText="Код" Visible="false" Width="0px" />
                    <obout:Column ID="Column102" DataField="GRFTYP" HeaderText="Тип" Visible="false" Width="0px" />
                    <obout:Column ID="Column103" DataField="GRFDAT" HeaderText="Дата" ReadOnly="true" Width="5%" DataFormatString="{0:dd/MM}" />
                    <obout:Column ID="Column104" DataField="TIMBEG" HeaderText="Время" ReadOnly="true" Width="5%"/>
                    <obout:Column ID="Column105" DataField="GRFPTH" HeaderText="Пацент" ReadOnly="true" Width="75%" />
                    <obout:Column HeaderText="УДАЛЕНИЕ" Width="7%" AllowEdit="true" AllowDelete="true" runat="server">
                        <TemplateSettings TemplateId="editBtnTemplate" />
                    </obout:Column>

                    <obout:Column ID="Column107" DataField="Prt" HeaderText="ОПИСАНИЕ" Width="8%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplatePrt" />
				    </obout:Column>				
               </Columns>
                <Templates>								
                    <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                            <input type="button" id="btnDelete" class="tdTextSmall" value="Удл." onclick="GridGrf.delete_record(this)" />
                        </Template>
                    </obout:GridTemplate>
                    <obout:GridTemplate runat="server" ID="TemplatePrt">
                       <Template>
                          <input type="button" id="btnRsx" class="tdTextSmall" value="Опис." onclick="MedDocXls(<%# Container.PageRecordIndex %>)" />
 					</Template>
                    </obout:GridTemplate>
                </Templates>

            </obout:Grid>

<%-- =================  для удаление документа  OnBeforeClientDelete="OnBeforeDelete"============================================ --%>
     <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="Удаление" Width="300" IsModal="true">
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

    </div>

    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

          <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
       <owd:Window ID="UslWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
             Left="20" Top="0" Height="450" Width="450" Visible="true" VisibleOnLoad="false"
             StyleFolder="~/Styles/Window/wdstyles/blue"
             Title="Услуги врача">
       </owd:Window>
    </form>
       
      <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>

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
 
        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/
 
        .ob_iCboICBC li
         {
            height: 20px;
            font-size: 12px;
        }
        
            .Tab001 { height:100%; }
            .Tab001 tr { height:100%; }
     	td.link{
			padding-left:30px;
			width:250px;			
		}

      .style2 {
            width: 45px;
        }

    </style>

</body>
</html>

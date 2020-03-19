<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="True" CodeBehind="BuxSprOrg.aspx.cs" Inherits="Reception03hosp45.Spravki.BuxSprOrg" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.SuperForm" Assembly="obout_SuperForm" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <%-- ************************************* стили **************************************************** --%>
    <style type="text/css">
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }
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

         /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
          .ob_iTIE
    {
          font-size: larger;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
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

    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>
    <%-- ************************************* программа javascript **************************************************** --%>

    <script type="text/javascript">

        var myconfirm = 0;

        function ConfirmBeforeDeleteOnClick() {
            myconfirm = 1;
            GridOrg.delete_record(document.getElementById('myConfirmBeforeDeleteHidden').value);
            //           alert("ConfirmBeforeDeleteOnClick=" + document.getElementById('myConfirmBeforeDeleteHidden').value);
            myConfirmBeforeDelete.Close();
            myconfirm = 0;
        }

        function GridOrg_ClientDelete(sender, record) {
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
             for (var i = 0; i < GridOrg.Rows.length; i++) {
                 if (GridOrg.Rows[i].Cells[0].Value == record.ORGKOD) {
                    index = i;
       //            alert('index: ' + index);
                      break;
                    }
                }
            return index;
        }

        function GridOrg_ClientEdit(sender, record) {
            Window1.Open();
            //           document.getElementById('KDRIDN').value = record.KDRIDN;
            document.getElementById('ORGKOD').value = record.ORGKOD;

            //           document.getElementById('KDRKODHID').value = record.KDRKOD;
            //             document.getElementById('par').value = record.DOCDTLKDR;
            SuperForm1_ORGKOD.value(record.ORGKOD);

            SuperForm1_ORGNAM.value(record.ORGNAM);
            SuperForm1_ORGNAMSHR.value(record.ORGNAMSHR);
            SuperForm1_ORGADR.value(record.ORGADR);
            SuperForm1_ORGBIN.value(record.ORGBIN);
    //        SuperForm1_ORGBIK.value(record.ORGBIK);
    //        SuperForm1_ORGIIK.value(record.ORGIIK);
            SuperForm1_ORGNDC.value(record.ORGNDC);
            SuperForm1_ORGDOGNUM.value(record.ORGDOGNUM);
            SuperForm1_ORGDOGPNT.value(record.ORGDOGPNT);
            SuperForm1_ORGKNP.value(record.ORGIRS);
            SuperForm1_ORGRUKFIO.value(record.ORGRUKFIO);
            SuperForm1_ORGBUXFIO.value(record.ORGBUXFIO);

            return false;
        }

        function GridOrg_ClientInsert(sender, record) {

            Window1.Open();

            document.getElementById('ORGKOD').value = 0;
            SuperForm1_ORGKOD.value('');
            SuperForm1_ORGNAM.value('');
            SuperForm1_ORGNAMSHR.value('');
            SuperForm1_ORGADR.value('');
            SuperForm1_ORGBIN.value('');
     //       SuperForm1_ORGBIK.value('');
     //       SuperForm1_ORGIIK.value('');
            SuperForm1_ORGNDC.value('');
            SuperForm1_ORGDOGNUM.value('');
            SuperForm1_ORGDOGPNT.value('');
            SuperForm1_ORGKNP.value('');
            SuperForm1_ORGRUKFIO.value('');
            SuperForm1_ORGBUXFIO.value('');

            return false;
        }

        function saveChanges() {
            Window1.Close();

            var ORGKOD = document.getElementById('ORGKOD').value;

            var data = new Object();

            data.ORGKOD = SuperForm1_ORGKOD.value();
            data.ORGNAM = SuperForm1_ORGNAM.value();
            data.ORGNAMSHR = SuperForm1_ORGNAMSHR.value();
            data.ORGADR = SuperForm1_ORGADR.value();
            data.ORGBIN = SuperForm1_ORGBIN.value();
      //      data.ORGBIK = SuperForm1_ORGBIK.value();
      //      data.ORGIIK = SuperForm1_ORGIIK.value();
            data.ORGNDC = SuperForm1_ORGNDC.value();
            data.ORGDOGNUM = SuperForm1_ORGDOGNUM.value();
            data.ORGDOGPNT = SuperForm1_ORGDOGPNT.value();
            data.ORGKNP = SuperForm1_ORGKNP.value();
            data.ORGRUKFIO = SuperForm1_ORGRUKFIO.value();
            data.ORGBUXFIO = SuperForm1_ORGBUXFIO.value();

            if (ORGKOD != 0) {
                //        alert('saveChanges: ' + KDRKOD);
                //            data.KDRKOD = DOCDTLIDN;
                GridOrg.executeUpdate(data);
            }
            else {
                GridOrg.executeInsert(data);
            }
        }

        function cancelChanges() {
            Window1.Close();
        }

        // ===============================================================================================================================================================
        function GridOrg_bnk(rowIndex) {
          //  var OrgKod;
        //    alert("GridLab_rsx="+rowIndex);

            var OrgKod= GridOrg.Rows[rowIndex].Cells[0].Value;
            var OrgFio= GridOrg.Rows[rowIndex].Cells[1].Value;
      //      alert("OrgKod="+OrgKod);
            BnkWindow.setTitle(OrgFio);
            BnkWindow.setUrl("/Spravki/BuxSprOrgBnk.aspx?GlvOrgKod=" + OrgKod);
            BnkWindow.Open();               

            return true;
        }


    </script>


    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    <%-- ************************************* для передач значении **************************************************** --%>
    
    <input type="hidden" id="ORGKOD" />
     
    <span id="WindowPositionHelper"></span>

    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    <%-- ************************************* HTML **************************************************** --%>
    
     
<!--  конец -----------------------------------------------  -->    
    <owd:Dialog ID="myConfirmBeforeDelete" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Удаление" Width="300" IsModal="true">
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
       
     
<!--  конец -----------------------------------------------  -->  
  
        <asp:TextBox ID="Sapka" 
             Text="                    Справочник организаций" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width:100%; text-align:center"
             runat="server"></asp:TextBox>
             
        <div id="div_org" style="position:relative;left:15%;" >
             <obout:Grid id="GridOrg" runat="server" 
                                   CallbackMode="true" 
                                   Serialize="true" 
	                		       FolderStyle="/Styles/Grid/style_5" 
	                		       AutoGenerateColumns="false"
	                		       ShowTotalNumberOfPages = "false"
	                               FolderLocalization = "~/Localization"
	                               Language = "ru"
	                	 AllowRecordSelection="false"
                                   AllowColumnResizing="true"
                                   AllowSorting="true"
                                   AllowPaging="true"
                                   AllowPageSizeSelection="false"
                                   Width="75%"
                                   PageSize="-1"
	         		               AllowAddingRecords = "true"
                                   AllowFiltering = "true"
                                   ShowColumnsFooter = "false" >
                                  <ScrollingSettings ScrollHeight="450" ScrollWidth="75%" />
                                  <ClientSideEvents 
		                                OnBeforeClientEdit="GridOrg_ClientEdit" 
		                                OnBeforeClientDelete="GridOrg_ClientDelete" 
		                                OnBeforeClientAdd="GridOrg_ClientInsert"
		                                ExposeSender="true"/>
		                        	<Columns>
	                    			<obout:Column ID="Column00" DataField="ORGKOD" HeaderText="Код" Width="5%" ReadOnly="true" Align="right" />											
	                    			<obout:Column ID="Column01" DataField="ORGNAM" HeaderText="Организация" Width="41%" />											
                    				<obout:Column ID="Column02" DataField="ORGBIN" HeaderText="БИН" Width="10%" />
                    				<obout:Column ID="Column04" DataField="ORGADR" HeaderText="Адрес" Width="30%" />
                    				<obout:Column ID="Column06" DataField="ORGNDC" HeaderText="НДС" Visible="false" Width="0%" />
                    				<obout:Column ID="Column07" DataField="ORGKNP" HeaderText="ЕКНП" Visible="false" Width="0%" />
                    				<obout:Column ID="Column08" DataField="ORGDOGNUM" HeaderText="Договор" Visible="false" Width="0%" />
                    				<obout:Column ID="Column09" DataField="ORGDOGPNT" HeaderText="Пункт" Visible="false" Width="0%" />
                    				<obout:Column ID="Column10" DataField="ORGRUKFIO" HeaderText="Директор" Visible="false" Width="0%" />
                    				<obout:Column ID="Column11" DataField="ORGBUXFIO" HeaderText="Бухгалтер" Visible="false" Width="0%" />
                    				<obout:Column ID="Column12" DataField="ORGNAMSHR" HeaderText="Наим" Visible="false" Width="0%" />
		                    		<obout:Column ID="Column13" DataField="" HeaderText="Корр" Width="9%" AllowEdit="true" AllowDelete="true" >
				                           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
				                    </obout:Column>	  
                             
                                    <obout:Column ID="Column14" DataField="FLG" HeaderText="Банк" Width="5%" ReadOnly="true" >
				                           <TemplateSettings TemplateId="TemplateBnk" />
				                    </obout:Column>				

		                        	</Columns>
               <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
               <Templates>	
               	<obout:GridTemplate runat="server" ID="editBtnTemplate">
                    <Template>
                       <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridOrg.edit_record(this)"/>
                       <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridOrg.delete_record(this)"/>
                    </Template>
                </obout:GridTemplate>
                
                <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                    <Template>
                        <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridOrg.update_record(this)"/> 
                        <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridOrg.cancel_edit(this)"/> 
                    </Template>
                </obout:GridTemplate>

                <obout:GridTemplate runat="server" ID="addTemplate">
                    <Template>
                        <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridOrg.addRecord()"/>
                    </Template>
                </obout:GridTemplate>
                 <obout:GridTemplate runat="server" ID="saveTemplate">
                    <Template>
                        <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridOrg.insertRecord()"/> 
                        <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridOrg.cancelNewRecord()"/> 
                    </Template>
                   </obout:GridTemplate>	
          
                  <obout:GridTemplate runat="server" ID="TemplateBnk">
                      <Template>
                         <input type="button" id="btnBnk" class="tdTextSmall" value="Банк" onclick="GridOrg_bnk(<%# Container.PageRecordIndex %>)"/>
 					  </Template>
                 </obout:GridTemplate>                  			

                </Templates>


	        </obout:Grid>	
  
         </div>
 <%-- ===  окно для корректировки одной записи из GRIDa (если поле VISIBLE=FALSE не работает) ============================================ --%>

   
     <owd:Window ID="Window1" runat="server" IsModal="true" ShowCloseButton="true" Status=""
        RelativeElementID="WindowPositionHelper" Top="25" Left="400" Height="520" Width="600" VisibleOnLoad="false" StyleFolder="/Styles/Window/wdstyles/aura"
        Title="Организаций">

 <%-- ============================  для отображение вкладок услуг ============================================ 
  <%--   
            <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
                  <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                </asp:ScriptManager>  

  --%>      
            <div class="super-form">
                <obout:SuperForm ID="SuperForm1" runat="server"
                    AutoGenerateRows="false"
                    AutoGenerateInsertButton ="false"
                    AutoGenerateEditButton="false"
                    AutoGenerateDeleteButton="false" 
                FolderStyle="/Styles/SuperForm/plain"
                InterfaceFolderStyle="/Styles/Interface/plain"
                    DataKeyNames="ORGKOD"
                    DefaultMode="Insert" 
                    Width="600" >
   
                    <EditRowStyle BackColor="#D5E2FF" Font-Bold="True" ForeColor="White" />
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="#D5E2FF" ForeColor="Black" /> 
                                      
                    <Fields>
	                    <obout:BoundField DataField="ORGKOD" HeaderText="Код"  AllowEdit="false" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGNAM" HeaderText="Организация" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGNAMSHR" HeaderText="Корот.наим." FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGADR" HeaderText="Адрес" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGBIN" HeaderText="БИН" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGNDC" HeaderText="№ свидет.по НДС" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGDOGNUM" HeaderText="Договор на поставку" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGDOGPNT" HeaderText="Пункт назначения" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGKNP" HeaderText="ЕКНП" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGRUKFIO" HeaderText="Руководитель" FieldSetID="FieldSet1" />
	                    <obout:BoundField DataField="ORGBUXFIO" HeaderText="Гл.бухгалтер" FieldSetID="FieldSet1" />

                        <obout:TemplateField FieldSetID="FieldSet2">
                             <EditItemTemplate>
                                <obout:OboutButton ID="OboutButton1" runat="server" Text="Сохранить" OnClientClick="saveChanges(); return false;" Width="120"  FolderStyle="/Styles/Interface/plain/OboutButton"/>
                                <obout:OboutButton ID="OboutButton2" runat="server" Text="Назад" OnClientClick="cancelChanges(); return false;" Width="75"  FolderStyle="/Styles/Interface/plain/OboutButton"/>
                            </EditItemTemplate>
                        </obout:TemplateField>
                     </Fields>
                    <FieldSets>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet1"/>
                        </obout:FieldSetRow>
                        <obout:FieldSetRow>
                            <obout:FieldSet ID="FieldSet2" ColumnSpan="1" CssClass="command-row"  />
                        </obout:FieldSetRow>
                    </FieldSets>
                    <CommandRowStyle Width="350" HorizontalAlign="Left" />
                </obout:SuperForm>
            </div>
    </owd:Window> 
     
        <%-- =================  окно для поиска клиента из базы  ============================================ --%>
         <owd:Window ID="BnkWindow" runat="server" Url="" IsModal="true" ShowCloseButton="true" Status=""
            Left="400" Top="100" Height="400" Width="700" Visible="true" VisibleOnLoad="false" 
            StyleFolder="~/Styles/Window/wdstyles/blue" Title="График приема врача">
        </owd:Window>

    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    <%-- ************************************* RECORDSOURCE **************************************************** --%>
    
</asp:Content>

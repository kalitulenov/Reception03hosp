<%@ Page Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="DocAppLstPrs.aspx.cs" Inherits="Reception03hosp45.Priem.DocAppLstPrs" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>
   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>


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
       /*------------------------- для checkbox  --------------------------------*/
        .excel-checkbox {
            height: 20px;
            line-height: 20px;
        }

        .tdText {
            font: 11px Verdana;
            color: #333333;
        }

        .option2 {
            font: 11px Verdana;
            color: #0033cc;
            background-color: #f6f9fc;
            padding-left: 4px;
            padding-right: 4px;
        }

        a {
            font: 11px Verdana;
            color: #315686;
            text-decoration: underline;
        }

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }

     </style>

 <script type="text/javascript">
     var myconfirm = 0;

     window.onload = function () {
         GridUsl.convertToExcel(
             ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
             '<%=GridPrsExcelData.ClientID %>',
             '<%=GridPrsExcelDeletedIds.ClientID %>'
           );
     }

     /*------------------------- при нажатии на поле бит --------------------------------*/
     function persistFieldValue(field) {
   //      alert("persistFieldValue");
         var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
   //      var DatDocRek = 'PRSFLG';
   //      var DatDocTyp = 'Bit';
   //      var DatDocIdn;

         if (DatDocVal == false) return;

     //    alert("DatDocVal ="+DatDocVal);

         if (focusedGrid != null && focusedGrid._lastEditedField != null) {
             if (typeof (focusedGrid._lastEditedFieldEditor.value) == 'function') {
                 focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.value();
             } else {
                 focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.checked() ? '    X' : ' ';
             }
             document.getElementById('FieldEditorsContainer').appendChild(document.getElementById(focusedGrid._lastEditedFieldEditor.ID + 'Container'));
             focusedGrid._lastEditedField.style.display = '';

             focusedGrid._lastEditedField = null;
             focusedGrid._lastEditedFieldEditor = null;

       //      alert("DatDocVal2 =" + DatDocVal);

             var DatDocIdn = document.getElementById('MainContent_parDocIdn').value; 
             var DatDocMdb = 'HOSPBASE';
             var DatDocTyp = 'Str';

      //       alert("DatDocIdn =" + DatDocIdn);

             var DatDocBux = document.getElementById('MainContent_HidBuxKod').value;
    //         alert("DatDocIdn =" + DatDocIdn);

             if (DatDocVal == true) SqlStr = "HspAmbPrsChkRep&@PRSIDN&" + DatDocIdn + "&@PRSFLG&1" + "&PRSBUX&" + DatDocBux;
             else return; //SqlStr = "HspAmbPrsChkRep&@PRSIDN&" + DatDocIdn + "&@NAZRZPFLG&0" + "&PRSBUX" + DatDocBux;

        //     alert("SqlStr=" + SqlStr);

             $.ajax({
                 type: 'POST',
                 url: '/HspUpdDoc.aspx/UpdateOrder',
                 contentType: "application/json; charset=utf-8",
                 data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                 dataType: "json",
                 success: function () { },
                 error: function () { }
             });
         }
     }


     // -------изменение как EXCEL-------------------------------------------------------------------          
     function markAsFocused(textbox) {
         textbox.className = 'excel-textbox-focused';
     }

     /*------------------------- при нажатии на поле текст --------------------------------*/
     /*------------------------- при выходе запомнить Идн --------------------------------*/
     function saveCheckBoxChanges(element, rowIndex) {
      //     alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#');
        document.getElementById('MainContent_parDocIdn').value = GridPrs.Rows[rowIndex].Cells['PRSIDN'].Value;
     }

     //    ---------------- обращение веб методу --------------------------------------------------------

     // -------изменение как EXCEL-------------------------------------------------------------------          

     function filterGrid(e) {
         var fieldName;
         //        alert("filterGrid=");

         if (e != 'ВСЕ') {
             fieldName = 'GRFPTH';
             GridPrs.addFilterCriteria(fieldName, OboutGridFilterCriteria.StartsWith, e);
             GridPrs.executeFilter();
         }
         else {
             GridPrs.removeFilter();
         }
     }

 </script>

<%-- ============================  для передач значении  ============================================ --%>
 <asp:HiddenField ID="parDocTyp" runat="server" />
 <asp:HiddenField ID="parDocIdn" runat="server" />
 <asp:HiddenField ID="HidBuxFrm" runat="server" />
 <asp:HiddenField ID="HidBuxKod" runat="server" />
 <asp:HiddenField runat="server" ID="GridPrsExcelDeletedIds" />
 <asp:HiddenField runat="server" ID="GridPrsExcelData" />
<%-- ============================  шапка экрана ============================================ --%>

 <asp:TextBox ID="Sapka" 
             Text="СПИСОК НАПРАВЛЕНИИ" 
             BackColor="#3CB371"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 100%; text-align:center"
             runat="server"></asp:TextBox>
             
<%-- ============================  верхний блок  ============================================ --%>
                               
    <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
        Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
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
			 
             <asp:TextBox runat="server" id="txtDate2" Width="80px" BackColor="#FFFFE0" />
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


 <%-- ============================  OnClientDblClick  ============================================ 
      <ClientSideEvents ExposeSender="true"
                        OnClientDblClick="OnClientDblClick"
     --%>

 <%-- ============================  OnClientSelect  ============================================ 
       AllowRecordSelection = "true"
      <ClientSideEvents ExposeSender="false"
                          OnClientSelect="OnClientSelect"
     --%>

   <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 460px;">
	        
	        <obout:Grid id="GridPrs" runat="server" 
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="false"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowFiltering="true" 
                FilterType="ProgrammaticOnly" 
                AllowPageSizeSelection="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
	        	    <obout:Column ID="Column00" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%"/>
	                <obout:Column ID="Column01" DataField="GRFPTH" HeaderText="ФИО" Width="10%" />
	                <obout:Column ID="Column02" DataField="GRFIIN" HeaderText="ИИН" Width="7%" />
	                <obout:Column ID="Column03" DataField="GRFDAT" HeaderText="ДАТА"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
	                <obout:Column ID="Column04" DataField="FI" HeaderText="ВРАЧ" Width="10%" />
	                <obout:Column ID="Column05" DataField="DLGNAM" HeaderText="СПЕЦ" Width="10%" />
	                <obout:Column ID="Column06" DataField="PRSNUM" HeaderText="НАПР" Width="4%" />
	                <obout:Column ID="Column07" DataField="USLTRF" HeaderText="КОД" Width="5%" />
	                <obout:Column ID="Column08" DataField="USLNAM" HeaderText="УСЛУГА" Width="16%" />
  	                <obout:Column ID="Column09" DataField="DOCDIGKOD" HeaderText="МКБ" Width="4%" Wrap="true"/>
	                <obout:Column ID="Column10" DataField="DOCDIGNAM" HeaderText="ДИАГНОЗ" Width="25%" Wrap="true"/>
                    <obout:Column ID="Column11" DataField="PRSFLG" HeaderText="+" Width="4%" Align="center">
                        <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                    </obout:Column>
                </Columns>

                <Templates>
                    <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                        <Template>
                            <input type="text" name="TextBox1"
                                class="excel-textbox"
                                value='<%# Container.Value == "True" ? "   V" : " " %>'
                                readonly="readonly"
                                onblur="saveCheckBoxChanges(this, <%# Container.PageRecordIndex %>)"
                                onfocus="GridPrs.editWithCheckBox(this)" />
                        </Template>
                    </obout:GridTemplate>

                </Templates>
           	</obout:Grid>

           <div style="display: none;" id="FieldEditorsContainer">
                <div id="CheckBoxEditorContainer" style="width: 100%">
                    <obout:OboutCheckBox runat="server" ID="CheckBoxEditor" FolderStyle="~/Styles/Interface/plain/OboutCheckBox">
                        <ClientSideEvents OnBlur="persistFieldValue" />
                    </obout:OboutCheckBox>
                </div>
            </div>

        <div class="ob_gMCont" style=" width:100%; height: 20px;">
            <div class="ob_gFContent">
                <asp:Repeater runat="server" ID="rptAlphabet">
                    <ItemTemplate>
                        <a href="#" class="pg" onclick="filterGrid('<%# Container.DataItem %>')">
                            <%# Container.DataItem %>
                        </a>&nbsp;
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>        

  </asp:Panel> 

<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 5%; position: relative; top: 0px; width: 90%; height: 30px;">
             <center>
                 <asp:Button ID="CanButton" runat="server" CommandName="Cancel" Text="Отмена" onclick="CanButton_Click"/>
             </center>
  </asp:Panel>              
<%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================   --%>
<%-- =================  источник  для ГРИДА============================================ --%>
 <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
  
</asp:Content>

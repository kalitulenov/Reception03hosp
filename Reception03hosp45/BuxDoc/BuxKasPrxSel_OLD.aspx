<%@ Page Title="" Language="C#" AutoEventWireup="True" CodeBehind="BuxKasPrxSel_OLD.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxKasPrxSel_OLD" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <%-- ============================  JAVA ============================================ --%>
    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />

    <!--  ссылка на excel-style-------------------------------------------------------------- -->
    <link href="/JS/excel-style/excel-style.css" type="text/css" rel="Stylesheet" />
    <!--  ссылка на excel-style-------------------------------------------------------------- -->

<%-- ============================  JAVA ============================================ --%>
      <script type="text/javascript">
               // -------изменение как EXCEL-------------------------------------------------------------------          

               /*------------------------- при нажатии на поле бит --------------------------------*/
               function persistFieldValue(field) {
  //                 alert("persistFieldValue=");
                   var DatDocVal = focusedGrid._lastEditedFieldEditor.checked();
                   var DatDocRek = 'USLFLG';
                   var DatDocTyp = 'Sql';
                   var DatDocIdn;

                   if (focusedGrid != null && focusedGrid._lastEditedField != null) {
                       if (typeof (focusedGrid._lastEditedFieldEditor.value) == 'function') {
                           focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.value();
                       } else {
                           focusedGrid._lastEditedField.value = focusedGrid._lastEditedFieldEditor.checked() ? '      +' : ' ';
                       }
                       document.getElementById('FieldEditorsContainer').appendChild(document.getElementById(focusedGrid._lastEditedFieldEditor.ID + 'Container'));
                       focusedGrid._lastEditedField.style.display = '';

                       focusedGrid._lastEditedField = null;
                       focusedGrid._lastEditedFieldEditor = null;

                       DatDocIdn = parDocIdn.value;

                       onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn);
                   }
               }

          /*------------------------- при выходе запомнить Идн --------------------------------*/
               function saveCheckBoxChanges(element, rowIndex) {
            //         alert("saveCheckBoxChanges=");
                       parDocIdn.value = GridUsl.Rows[rowIndex].Cells['USLIDN'].Value;
          //                alert("saveCheckBoxChanges=" + element.checked + '#' + rowIndex + '#' + parDocIdn.value);

          }

          //    ---------------- обращение веб методу --------------------------------------------------------

          function onChangeUpd(DatDocRek, DatDocVal, DatDocTyp, DatDocIdn) {

              var DatDocMdb = 'HOSPBASE';
              var DatDocTab = 'HspKasSelTooOrd';
              var DatDocKey;
              var SqlStr;
              var KasIdn;

              var QueryString = getQueryString();
              KasIdn = QueryString[1];

         //     alert("DatDocMdb=" + DatDocMdb + "  DatDocTab=" + DatDocTab + "  DatDocKey=" + DatDocKey + "  DatDocIdn=" + DatDocIdn + "  DatDocRek=" + DatDocRek + "  DatDocVal=" + DatDocVal + "  DatDocTyp=" + DatDocTyp);

//    ---------------- прикрепить услугу к приходу --------------------------------------------------------
//    ---------------- выбрать врача если есть и записать на приход --------------------------------------------------------
//    ---------------- выбрать пациента и записать на приход --------------------------------------------------------
//    ---------------- выбрать текст услуг и записать на приход --------------------------------------------------------

              DatDocTyp = 'Str';
              SqlStr = "HspKasSelTooOrd&@KASIDN&" + KasIdn + "&@USLIDN" + "&" + DatDocIdn;
   //           alert("SqlStr=" + SqlStr);

              $.ajax({
                  type: 'POST',
                  url: '/HspUpdDoc.aspx/UpdateOrder',
                  contentType: "application/json; charset=utf-8",
                  data: '{"DatDocMdb":"' + DatDocMdb + '","SqlStr":"' + SqlStr + '","DatDocTyp":"' + DatDocTyp + '"}',
                  dataType: "json",
                  success: function () { },
                  error: function () { alert("ERROR="); }
              });


          }

          //    ------------------ читать переданные параметры ----------------------------------------------------------
          function getQueryString() {
              var queryString = [];
              var vars = [];
              var hash;
              var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
       //               alert("hashes=" + hashes);
              for (var i = 0; i < hashes.length; i++) {
                  hash = hashes[i].split('=');
                  queryString.push(hash[0]);
                  vars[hash[0]] = hash[1];
                  queryString.push(hash[1]);
              }
              return queryString;
          }


    </script>
</head>
<body>
    <form id="form1" runat="server">

        <%-- ============================  для передач значении  ============================================ --%>
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parDocIdn" runat="server" />
        <asp:HiddenField runat="server" ID="GridUslExcelDeletedIds" />
        <asp:HiddenField runat="server" ID="GridUslExcelData" />
        <%-- ============================  для передач значении  ============================================ --%>
        <%-- ============================  шапка экрана ============================================ --%>
        <%-- ============================  подшапка  ============================================ --%>
        <%-- ============================  верхний блок  ============================================ --%>
                               
  <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double" 
             Style="left: -9px; position: relative; top: -9px; width: 101%; height: 30px;">
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
        <%-- ============================  средний блок  ============================================ --%>

        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double"
            Style="left: -9px; position: relative; top: -9px; width: 101%; height: 200px;">

            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridUsl" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/grand_gray"
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
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="false">
                <ScrollingSettings ScrollHeight="95%" />
                <Columns>
                    <obout:Column ID="Column0" DataField="USLIDN" HeaderText="Идн" Visible="false" Width="0%" />
	                <obout:Column ID="Column1" DataField="GRFDAT" HeaderText="Дата"  DataFormatString = "{0:dd/MM/yy}" Width="5%" />
                    <obout:Column ID="Column2" DataField="GRFPTH" HeaderText="Фамилия И.О." Width="15%" />
                    <obout:Column ID="Column3" DataField="USLKAS" HeaderText="№касс" Width="8%" ReadOnly="true" />
                    <obout:Column ID="Column4" DataField="USLNAM" HeaderText="Наименование услуги" Width="42%" Align="left" />
                    <obout:Column ID="Column5" DataField="USLLGT" HeaderText="Льгота" Width="5%" />
                    <obout:Column ID="Column6" DataField="USLZEN" HeaderText="Цена" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column7" DataField="USLSUM" HeaderText="Сумма" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column8" DataField="FI" HeaderText="Врач,медсестра" Width="10%" ReadOnly="true" />
                    <obout:Column ID="Column10" DataField="USLFLG" HeaderText="Выбрать" Width="5%" Align="center">
                        <TemplateSettings TemplateId="CheckBoxEditTemplate" />
                    </obout:Column>
                </Columns>
 		    	
                <Templates>		
                   <obout:GridTemplate runat="server" ID="CheckBoxEditTemplate">
                        <Template>
                            <input type="text" name="TextBox1"
                                class="excel-textbox"
                                value='<%# Container.Value == "True" ? "      +" : " " %>'
                                readonly="readonly"
                                onblur="saveCheckBoxChanges(this, <%# Container.PageRecordIndex %>)"
                                onfocus="GridUsl.editWithCheckBox(this)" />
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

        </asp:Panel>
        <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
        <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
    
        <script type="text/javascript">
               window.onload = function () {
               GridUsl.convertToExcel(
                       ['ReadOnly', 'TextBox', 'TextBox', 'MultiLineTextBox', 'ComboBox', 'TextBox', 'CheckBox', 'Actions'],
               '<%=GridUslExcelData.ClientID %>',
               '<%=GridUslExcelDeletedIds.ClientID %>'
                );
            }
        </script>
    </form>
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

            
        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
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
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
    </style>
</body>

    <script src="/JS/excel-style/excel-style.js" type="text/javascript"></script>

</html>

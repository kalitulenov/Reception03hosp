<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BuxOctAnlGrd.aspx.cs" Inherits="Reception03hosp45.BuxDoc.BuxOctAnlGrd" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

    </script>

</head>

<body>
    <form id="form1" runat="server">
        <div>
            <!--  конец -----------------------------------------------  -->
            <%-- ============================  для передач значении  ============================================ --%>
            <span id="WindowPositionHelper"></span>

            <asp:HiddenField ID="parAcc" runat="server" />
            <asp:HiddenField ID="parAccTxt" runat="server" />
            <asp:HiddenField ID="parFrmKod" runat="server" />
            <asp:HiddenField ID="parGod" runat="server" />

            <!--  источники -----------------------------------------------------------  -->
            <asp:SqlDataSource runat="server" ID="sdsAnl" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>

            <!--  источники -----------------------------------------------------------  -->
            <obout:Grid ID="GridAcc" runat="server"
                CallbackMode="true"
                Serialize="false"
                FolderStyle="~/Styles/Grid/style_5"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                Language="ru"
                AllowFiltering="true"
                ShowColumnsFooter="false"
                AllowPaging="false"
                EnableTypeValidation="false"
                PageSize="-1"
                Width="100%"
                AllowPageSizeSelection="false">
                <ScrollingSettings ScrollHeight="500" />
                <Columns>
                    <obout:Column ID="Column00" DataField="OCTKOD" HeaderText="СЧЕТ" ReadOnly="true" Width="0%" Align="rihgt" />
                    <obout:Column ID="Column01" DataField="OCTSPR" HeaderText="СПР" ReadOnly="true" Width="0%" Align="rihgt" />
                    <obout:Column ID="Column02" DataField="OCTSPRVAL" HeaderText="ФАМИЛИЯ И.О." Width="80%" Align="rihgt" >
	            		   <TemplateSettings TemplateId="TemplateAnlNam" EditTemplateId="TemplateEditAnlNam" />
	            	</obout:Column>
                    <obout:Column ID="Column04" DataField="OCTSUM" HeaderText="ВХД.ОСТ" ReadOnly="true" Align="rihgt" Width="10%" DataFormatString="{0:N}" />
		        	<obout:Column ID="Column9" DataField="" HeaderText="КОРР" Width="10%" AllowEdit="true" AllowDelete="true" />
                </Columns>
	                    		<Templates>								
	                    		
	                    		<obout:GridTemplate runat="server" ID="TemplateAnlNam" >
				                    <Template>
				                            <%# Container.DataItem["NAM"]%>			      		       
				                    </Template>
				                </obout:GridTemplate>
				
				                   <obout:GridTemplate runat="server" ID="TemplateEditAnlNam" ControlID="ddlAnlNam" ControlPropertyName="value">
				                      <Template>
                                          <asp:DropDownList ID="ddlAnlNam" runat="server" AppendDataBoundItems="True" Width="99%" DataSourceID="sdsAnl" CssClass="ob_gEC" DataTextField="NAM" DataValueField="KOD">
                                             <asp:ListItem Text="Выберите ..." Value="" Selected="True" />
                                          </asp:DropDownList>	
				                      </Template>
				                   </obout:GridTemplate>
	                    		</Templates>
            </obout:Grid>


        </div>


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

        .super-form {
            margin: 12px;
        }

        .ob_fC table td {
            white-space: normal !important;
        }

        .command-row .ob_fRwF {
            padding-left: 50px !important;
        }
    </style>
</body>
</html>

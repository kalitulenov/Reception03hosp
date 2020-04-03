<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MasterD.aspx.cs" Inherits="Reception03hosp45.Example.MasterD" Title="Безымянная страница" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    
<%-- ============================  JAVA ============================================ --%>
 </head>

<body>
    <form id="form1" runat="server">
    <div>
 
   <%-- =================  диалоговое окно для подтверждения удаление одной записи из GRIDa  ============================================ 
 --%>
        
<!--  конец -----------------------------------------------  -->  
<%-- ============================  для передач значении  ============================================ --%>
  
<!--  источники -----------------------------------------------------------  -->    
                   <!--  источники -----------------------------------------------------------  -->
         
            <asp:SqlDataSource runat="server" ID="sdsQst" 
                 SelectCommand="SELECT * FROM TABTLK WHERE TLKQSTFLG=1 ORDER BY TLKNUM" ProviderName="System.Data.SqlClient">
		    </asp:SqlDataSource> 
                  
            <asp:SqlDataSource runat="server" ID="sdsAns" SelectCommand="SELECT * FROM TABTLK WHERE ISNULL(TLKQSTFLG,0)=0 AND TLKNUM = @TlkNum ">
		         <SelectParameters>
                      <asp:Parameter Name="TlkNum" Type="String" />
                 </SelectParameters>
		    </asp:SqlDataSource>           

<!--  источники -----------------------------------------------------------  -->    
        <obout:Grid runat="server" ID="GridQst" AutoGenerateColumns="false" CallbackMode="true"
            DataSourceID="sdsQst" FolderStyle="~/Styles/Grid/grand_gray" AllowAddingRecords="false">
            <Columns>
                    <obout:Column ID="Column01" DataField="TlkNum" HeaderText="НОМЕР" Visible="false" />
                    <obout:Column ID="Column02" DataField="TLKNOZ" HeaderText="НОЗОЛОГИЯ" Width="10%" />
                    <obout:Column ID="Column05" DataField="TLKTXT" HeaderText="СОДЕРЖАНИЕ ВОПРОСА" Wrap="true" Width="70%" />
                    <obout:Column ID="Column06" DataField="TLKKTO" HeaderText="НИК" Width="10%" />
            </Columns>
            <MasterDetailSettings LoadingMode="OnCallback" />
            <DetailGrids>
            <obout:DetailGrid runat="server" ID="GridAns" AutoGenerateColumns="false"
                AllowAddingRecords="false" ShowFooter="true" AllowPageSizeSelection="false" AllowPaging="false"
                DataSourceID="sdsAns" FolderStyle="~/Styles/Grid/grand_gray" ForeignKeys="TlkNum">
                <columns>
                           <obout:Column ID="Column11" DataField="TlkNum" HeaderText="НОМЕР" ReadOnly="true" Width="10%" />
                            <obout:Column ID="Column12" DataField="TLKTXT" HeaderText="СОДЕРЖАНИЕ" Width="80%" />
                            <obout:Column ID="Column13" DataField="TLKKTO" HeaderText="НИК" Width="10%" />
                </columns>
            </obout:DetailGrid>
            </DetailGrids>
		                    
        </obout:Grid>

    </div>
 <%-- =================  окно для корректировки одной записи из GRIDa  ============================================ --%>
	        </div>
    </form>
</body>
</html>



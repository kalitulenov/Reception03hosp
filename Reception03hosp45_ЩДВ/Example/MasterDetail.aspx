<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MasterDetail.aspx.cs" Inherits="Reception03hosp45.Spravki.MasterDetail" Title="Безымянная страница" %>

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
                 SelectCommand="SELECT *,SprUziKod AS KOD FROM SprUzi ORDER BY SprUziKod" ProviderName="System.Data.SqlClient">
		    </asp:SqlDataSource> 
                  
            <asp:SqlDataSource runat="server" ID="sdsAns" SelectCommand="SELECT * FROM SprUziUsl WHERE SprUziUslKod = @SprUziKod ">
		         <SelectParameters>
                      <asp:Parameter Name="SprUziKod" Type="String" />
                 </SelectParameters>
		    </asp:SqlDataSource>           

<!--  источники -----------------------------------------------------------  -->    
        <obout:Grid runat="server" ID="GridQst" AutoGenerateColumns="false" CallbackMode="true"
            DataSourceID="sdsQst" FolderStyle="~/Styles/Grid/grand_gray" AllowAddingRecords="false">
            <Columns>
                <obout:Column ID="Column01" DataField="SprUziKod" HeaderText="НОМЕР" Visible="false"  />
                <obout:Column ID="Column02" DataField="KOD" HeaderText="НОЗОЛОГИЯ" Width="10%" />
                <obout:Column ID="Column05" DataField="SPRUZINAM" HeaderText="СОДЕРЖАНИЕ ВОПРОСА" Wrap="true" Width="60%" />
                <obout:Column ID="Column06" DataField="SPRUZILEN001" HeaderText="НИК" Width="10%" />
            </Columns>
            <MasterDetailSettings LoadingMode="OnCallback" />
            <DetailGrids>
            <obout:DetailGrid runat="server" ID="GridAns" AutoGenerateColumns="false"
                AllowAddingRecords="false" ShowFooter="true" AllowPageSizeSelection="false" AllowPaging="false"
                DataSourceID="sdsAns" FolderStyle="~/Styles/Grid/grand_gray" ForeignKeys="SprUziKod">
                <columns>
                            <obout:Column ID="Column11" DataField="SprUziUslKod" HeaderText="НОМЕР"  Visible="false" />
                            <obout:Column ID="Column12" DataField="SPRUZIUSLSAP" HeaderText="СОДЕРЖАНИЕ" Width="80%" />
                            <obout:Column ID="Column13" DataField="SPRUZIUSLVAL" HeaderText="НИК" Width="10%" />
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



<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MstrAcct.Master" AutoEventWireup="true" CodeBehind="AccChn.aspx.cs" Inherits="Reception03hosp45.AccChn" %>

<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">

        function OtmBut() 
         {
        //     alert("UpdBut1=");
             document.getElementById('<%= parOtmBut.ClientID %>').value = "OtmBut";
         }
         function OkBut() {
             document.getElementById('<%= parOtmBut.ClientID %>').value = "OkBut";
         }
 
         </script>
         
  <%-- ============================  для передач значении  ============================================ --%>
      <asp:HiddenField ID="parOtmBut" runat="server" />
  <%-- ============================  для передач значении  ============================================ --%>
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
  <!--       Create Hello World Dialog -->
        <owd:Dialog ID="loginDialog" runat="server" IsModal="true" Width="300" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td align="left">Пароль новый:</td>
                        <td><asp:TextBox runat="server" ID="txtPswNamNew001" TextMode="Password"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="left">Повторите новый пороль:</td>
                        <td><asp:TextBox runat="server" ID="txtPswNamNew002" TextMode="Password"></asp:TextBox></td>
                    </tr> 
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                            <asp:Button runat="server" ID="btnLogin" Text="ОК"/>
                            <asp:Button runat="server" ID="btnCancel" Text="Отмена" OnClientClick="OtmBut()" OnClick="OtmButton_Click"/>
                       </td>
                    </tr>
                    
                </table>  
            </center>      
        </owd:Dialog>
        
        <owd:Dialog ID="failNotice"  Visible ="false" runat="server" IsModal="true" Width="220" Height="120" StyleFolder="/Styles/Window/wdstyles/default" Title="Notice" zIndex="20" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
            <table>
           
                <tr>
                    <td align="center">Пароли не совпадают</td>
                </tr>
                <tr>                
                    <td align="center"><br /><input type="button" value="OK" style="width:60px;" onclick="failNotice.Close()" /></td>
                </tr>
                
            </table>
            </center>
        </owd:Dialog> 
        
        <owd:Dialog ID="succeedNotice" Visible ="false" runat="server" IsModal="true" Width="220" Height="120" StyleFolder="/Styles/Window/wdstyles/default" Title="Notice" zIndex="20" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
            <table>
                <tr>
                    <td align="center">Пароли изменен успешно!</td>
                </tr>
                <tr>                
                    <td align="center"><br />
                    <asp:Button runat="server" ID="Button1" Text="ОК" OnClientClick="OkBut()" OnClick="OkButton_Click"/>
                    </td>
                </tr>
                
            </table>
            </center>
        </owd:Dialog> 
        
              
</asp:Content>

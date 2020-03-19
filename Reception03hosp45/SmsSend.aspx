<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmsSend.aspx.cs" Inherits="Reception03hosp45.SmsSend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>How to send SMS using ASP.NET through HTTP</title>
</head>
<body>
    <center>
        <form id="smsdata" runat="server">
            <asp:Table ID="smstable" runat="server" Style="text-align: left; border-width: thin; border-color: Silver;" BorderStyle="Solid">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                    <b>Compose a message:</b>
                    <br />
                    <br />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" VerticalAlign="Top">
                        <asp:Label ID="labelRecipient" runat="server" Text="Recipient: "></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="textboxRecipient" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left" VerticalAlign="Top">
                        <asp:Label ID="labelMessage" runat="server" Text="Message Text: "></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="textboxMessage" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                        <asp:Button ID="buttonSend" runat="server" Text="Send Message" OnClick="buttonSendOnClick" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                        <asp:TextBox ID="textboxError" runat="server" BorderStyle="None" TextMode="MultiLine"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </form>
    </center>
</body>
</html>

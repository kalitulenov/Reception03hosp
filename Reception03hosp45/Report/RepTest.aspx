<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="RepTest.aspx.cs" Inherits="WebInsurance.Report.RepTest" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


          <rsweb:ReportViewer ID="DauaReport" 
                 runat="server" 
                 Width="100%" 
                 Height="900px"
                 ProcessingMode="Remote" ShowBackButton="true" >
             <ServerReport ReportServerUrl="http://localhost:8080/reportserver" />
         </rsweb:ReportViewer>
         
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/MsrMain.Master" AutoEventWireup="true" CodeBehind="Spr000.aspx.cs" Inherits="Reception03hosp45.Spravki.Spr000" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
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

   /*     
a.ob_gAL
{
     font-family: Tahoma;
     font-size: 14px;
     color: #000000;
     text-decoration: none;
}

a.ob_gAL:hover
{
     font-family: Tahoma;
     font-size: 14px;
     color: #000000;
     text-decoration: underline;
}
*/
/*
.ob_gRS
{
     color: #FF0000 !important;
     background-image: url(row_selected.png) !important;
     background-color: #E7F9FE !important;
}
*/
/* Row Edit Template container */
.ob_gRETpl
{
	font-family: Verdana;
	font-size: 15px;
	color: #196585;
	padding: 15px;
	border-top: 1px solid #c3c9ce;
	border-bottom: 1px solid #c3c9ce;
	background-image:url(form_bgr.gif);
	background-repeat:repeat-x;
	background-position:top;
	background-color: #ebecec;
	position: relative;
	z-index: 11;
}

/* Edit control - backward compatibility */
.ob_gEC
{
	padding: 0px;
	font-family: Verdana;
	font-size: 15px;
	color: #202426;			
	background-color: #FFFFFF;
	width: 96%;
	border: 1px solid #196585;
}

/* Row Edit Template container */
.ob_gRETpl
{
	font-family: Verdana;
	font-size: 15px;
	color: #196585;
	padding: 15px;
	border-top: 1px solid #c3c9ce;
	border-bottom: 1px solid #c3c9ce;
	background-image:url(form_bgr.gif);
	background-repeat:repeat-x;
	background-position:top;
	background-color: #ebecec;
	position: relative;
	z-index: 11;
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
		
    </style>

        <asp:TextBox ID="Sapka" 
             Text="" 
             BackColor="#0099FF"  
             Font-Names="Verdana" 
             Font-Size="20px" 
             Font-Bold="True" 
             ForeColor="White" 
             style="top: 0px; left: 0px; position: relative; width: 1260px; text-align:center"
             runat="server"></asp:TextBox>
     <div id="div_cnt" style="position:relative;left:30%;" >
        <asp:PlaceHolder ID="phGridSpr" runat="server"></asp:PlaceHolder>
     </div>
</asp:Content>

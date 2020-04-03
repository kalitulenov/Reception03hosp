<%@ Page Language="C#" Debug="true" EnableEventValidation="false" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="fup" Namespace="OboutInc.FileUpload" Assembly="obout_FileUpload" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">   
   void Page_load(object sender, EventArgs e)
   {               
      if (!Page.IsPostBack)  
      {
          CreateGrid();    
      }
      else
      {
        HttpFileCollection files = Page.Request.Files;
        string imagesPath = "resources/images/products/";
        string photoPath = "";
        string photoName = "";

        for(int i=0; i < files.Count; i++)
        {
          HttpPostedFile file = files[i];
          if(file.FileName.Length >0)
          {
            Regex reg = new Regex(@"((?:[^\\]*\\)*)(\S+)", RegexOptions.Compiled);
            photoName = DateTime.Now.Ticks.ToString() + "_" + reg.Replace(file.FileName, "$2");
            photoPath = imagesPath+photoName;

            file.SaveAs(Page.MapPath(photoPath));
            break;
          }
        }
        
        string ProductID = Page.Request["ServerResponse"];
        
        if (ProductID != null)
            if (ProductID.Length > 0 && !string.IsNullOrEmpty(photoName))
            {
               OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));
               myConn.Open();

               OleDbCommand myComm = new OleDbCommand("UPDATE Products SET [Image] = @Image WHERE ProductID = @ProductID", myConn);
               
               myComm.Parameters.Add("@Image", OleDbType.VarChar).Value = photoName;
               myComm.Parameters.Add("@ProductID", OleDbType.Integer).Value = ProductID;
               
               myComm.ExecuteNonQuery();
               myConn.Close();
            }

        ServerResponse.Value = "";
      }

      CreateGrid();
   }
   
   void CreateGrid()
   {
      OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));

      OleDbCommand myComm = new OleDbCommand("SELECT TOP 7 * FROM Products ORDER BY ProductID ASC", myConn);
      myConn.Open();
      OleDbDataReader myReader = myComm.ExecuteReader();


      grid1.DataSource = myReader;
      grid1.DataBind();

      myConn.Close(); 
   }       
           
   void UpdateRecord(object sender, GridRecordEventArgs e)
   {
       OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));
       myConn.Open();
       
       OleDbCommand myComm = new OleDbCommand("UPDATE Products SET ProductName = @ProductName, UnitPrice = @UnitPrice WHERE ProductID = @ProductID", myConn);
      
      myComm.Parameters.Add("@ProductName", OleDbType.VarChar).Value = e.Record["ProductName"];
      myComm.Parameters.Add("@UnitPrice", OleDbType.VarChar).Value = e.Record["UnitPrice"];
      myComm.Parameters.Add("@ProductID", OleDbType.Integer).Value = e.Record["ProductID"];
      
      myComm.ExecuteNonQuery();
      myConn.Close();
   }

   void DeleteRecord(object sender, GridRecordEventArgs e)
   {
      OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));
      myConn.Open();

      OleDbCommand myComm = new OleDbCommand("DELETE FROM Products WHERE ProductID = @ProductID", myConn);

      myComm.Parameters.Add("@ProductID", OleDbType.Integer).Value = e.Record["ProductID"];
      
      myComm.ExecuteNonQuery();
      myConn.Close();
   }

   void RebindGrid(object sender, EventArgs e)
   {
      CreateGrid();
   }
</script>

<html>
<head>
    <title>obout ASP.NET Grid example with FileUploadProgress</title>
    <style type="text/css">
			.tdText {
				font:11px Verdana;
				color:#333333;
			}
			.option2{
				font:11px Verdana;
				color:#0033cc;
				background-color___:#f6f9fc;
				padding-left:4px;
				padding-right:4px;
			}
			a {
				font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}

			a:hover {
				color:crimson;
			}
		</style>
        <script type="text/javascript">         

        function onBeforeClientUpdate(record)
        {
          var already = document.getElementById("tempInputFile");
          if(already != null)
            already.parentNode.removeChild(already);

          var el = document.getElementById("photopath");

          if(el.value.length > 0)
          {
            var ext = "";
            var str = el.value;
            var dotPos = str.lastIndexOf(".");
            var slashPos = str.lastIndexOf("/");
            var backSlashPos = str.lastIndexOf("\\");
            
            if(dotPos > slashPos && dotPos > backSlashPos) ext = str.substr(dotPos+1).toLowerCase();

            // Checked allowed file extensions

            if(ext == "bmp" || ext == "gif" || ext == "jpeg" || ext == "jpg" || ext == "png")
            {
               var saved = null;
               var hidden  = document.getElementById("photopath_text");
               hidden.value= el.value;
               
               if(document.all && !window.opera)
               {
                   el.parentNode.insertBefore(el.cloneNode(false),el);
                   saved = el.parentNode.removeChild (el);
               }
               else
               {
                   var new_span = document.createElement("SPAN");
                   
                   el.parentNode.insertBefore(new_span,el);
                   new_span.appendChild(el);
                   var innerHTML = new_span.innerHTML;
                   saved = el.parentNode.removeChild (el);
                   new_span.innerHTML = innerHTML;
                   
                   new_span.parentNode.insertBefore(new_span.firstChild,new_span);
                   new_span.parentNode.removeChild (new_span);
               }

               saved.id = "tempInputFile";
               document.getElementById("hidden_span").appendChild(saved);
               hidden.value = "Loading...";
            }
            else
            {
              alert("It should be Image file");
              return false;
            }
          }

          return true;
        }

        function onClientUpdate(record)
        {
          if(document.getElementById("tempInputFile") != null)
          {
            function waitServerResponse()
            {
                if (document.getElementById("<%= ServerResponse.ClientID %>").value.length == 0) {
                    document.forms[0].action = location.href;
                    grid1.refresh();
                } else {
                    setTimeout(waitServerResponse, 20);
                }
            }
            
            document.getElementById("<%= ServerResponse.ClientID %>").value = record.ProductID;
            setTimeout(function(){document.forms[0].submit();},10);
            setTimeout(waitServerResponse,20);
          }
        }

        </script>
</head>
<body>  
  <form runat="server">
    <br />
    <obout:Grid id="grid1" runat="server" CallbackMode="true" Serialize="true" AutoGenerateColumns="false"
         FolderStyle="styles/grand_gray" AllowFiltering="false" AllowAddingRecords="false"
         OnRebind="RebindGrid" OnUpdateCommand="UpdateRecord" OnDeleteCommand="DeleteRecord" >
         <ClientSideEvents
              OnClientUpdate="onClientUpdate"
              OnBeforeClientUpdate="onBeforeClientUpdate"
              OnClientInsert="onClientUpdate"
              OnBeforeClientInsert="onBeforeClientUpdate"
         />
        <Columns>
		    <obout:Column ID="Column1" DataField="ProductID" ReadOnly="true" HeaderText="Product ID" Width="125" runat="server"/>				
		    <obout:Column ID="Column2" DataField="ProductName" HeaderText="Product Name" Width="225" runat="server"/>				
		    <obout:Column ID="Column3" DataField="UnitPrice" HeaderText="Unit Price" Width="150" runat="server" />
		    <obout:Column ID="Column4" DataField="Image" HeaderText="Image" Width="225" runat="server">	
		        <TemplateSettings TemplateId="ImageTemplate" EditTemplateId="EditImageTemplate" />	    
		    </obout:Column>
		    <obout:Column ID="Column5" HeaderText="EDIT" AllowEdit="true" AllowDelete="true" Width="125" runat="server" />
	    </Columns>
        <Templates>
            <obout:GridTemplate runat="server" ID="EditImageTemplate" ControlID="photopath_text" ControlPropertyName="value">
                <Template>
                  <input type="hidden" id="photopath_text" name="photopath_text" />
                  <input type="file"   id="photopath" name="photopath" style="width:200px" onKeyDown="return false;" />
                </Template>
            </obout:GridTemplate>
            <obout:GridTemplate runat="server" ID="ImageTemplate">
				<Template><img src="resources/images/products/<%# Container.Value %>" alt="" width="50" height="50" /></Template>
			</obout:GridTemplate>
       </Templates>
    </obout:Grid>
    
    <span id="hidden_span" style="display:none"></span>
    <asp:HiddenField runat="server" ID="ServerResponse" Value="" />
    
    <fup:FileUploadProgress ID="FileUploadProgress1" runat="server" />
                            
    <fup:StatusPanel runat="server"> </fup:StatusPanel>
    
    <br /><br /><br />
		
	<a href="Default.aspx?type=ASPNET">« Back to examples</a>
  </form>
</body>
</html>
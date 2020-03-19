<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">

    DataSet ds; 
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection
                           (@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");
            SqlDataAdapter da = new SqlDataAdapter("select * from photos",con);
            ds = new DataSet();
            da.Fill(ds,"photos");
            DataList1.DataSource = ds.Tables[0];
            DataList1.DataBind();
        }
        catch (Exception ex)
        {
            Trace.Write(ex.Message);
        }
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
       Image img =  e.Item.FindControl("photo") as Image;
       DataRow row = ds.Tables[0].Rows[e.Item.ItemIndex];
       byte [] bytes  = (byte []) row["photo"];
        
       string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
       img.ImageUrl = "data:image/png;base64," + base64String;
    }
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>List Of Photos</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:DataList ID="DataList1" runat="server"  OnItemDataBound="DataList1_ItemDataBound">
            <ItemTemplate>
                <h2> <%# Eval("title") %></h2>
                <asp:Image ID="photo" runat="server" />
              
            </ItemTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>

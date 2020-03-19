<%@ Page Language="C#" AutoEventWireup="true" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            CreatePhoto();
        }

        void CreatePhoto()
        {
            try
            {
                string strPhoto = Request.Form["imageData"]; //Get the image from flash file
                byte[] photo = Convert.FromBase64String(strPhoto);
                FileStream fs = new FileStream("C:\\Webcam.jpg", FileMode.OpenOrCreate, FileAccess.Write);
                BinaryWriter br = new BinaryWriter(fs);
                br.Write(photo);
                br.Flush();
                br.Close();
                fs.Close();
            }
            catch (Exception Ex)
            {

            }

        }

    </script>

<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>

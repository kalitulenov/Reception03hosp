using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Text.RegularExpressions;


namespace Reception03hosp45
{
    public partial class SmsSend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            textboxRecipient.Width = 400;
            textboxMessage.Width = 450;
            textboxMessage.Rows = 10;
            textboxError.Width = 400;
            textboxError.Rows = 5;

            textboxError.ForeColor = System.Drawing.Color.Red;
            textboxError.Visible = false;
            textboxError.Text = "";

            if (!Page.IsPostBack)
            {
                textboxRecipient.Text = "77772127990";
                textboxMessage.Text = "Test message!";
            }
        }

        protected void buttonSendOnClick(object sender, EventArgs e)
        {
            //are required fields filled in:
            if (textboxRecipient.Text == "")
            {
                textboxError.Text += "Recipient(s) field must not be empty!\n";
                textboxError.Visible = true;
                return;
            }

            //we creating the necessary URL string:
            string ozSURL = "http://212.124.121.186"; //where the SMS Gateway is running
            string ozSPort = "9501"; //port number where the SMS Gateway is listening
            string ozUser = HttpUtility.UrlEncode("dauasoft"); //username for successful login
            string ozPassw = HttpUtility.UrlEncode("EJwHTLWSB"); //user's password
            string ozMessageType = "SMS:TEXT"; //type of message
            string ozRecipients = HttpUtility.UrlEncode(textboxRecipient.Text); //who will get the message
            string ozMessageData = HttpUtility.UrlEncode(textboxMessage.Text); //body of message

            string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                "?action=sendMessage" +
                "&username=" + ozUser +
                "&password=" + ozPassw +
                "&messageType=" + ozMessageType +
                "&recipient=" + ozRecipients +
                "&messageData=" + ozMessageData;

            try
            {
                //Create the request and send data to the SMS Gateway Server by HTTP connection
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                //Get response from the SMS Gateway Server and read the answer
                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                string responseString = respStreamReader.ReadToEnd();
                respStreamReader.Close();
                myResp.Close();

                //inform the user
                textboxError.Text = responseString;
                textboxError.Visible = true;
            }
            catch (Exception)
            {
                //if sending request or getting response is not successful the SMS Gateway Server may do not run
                textboxError.Text = "The SMS Gateway Server is not running!";
                textboxError.Visible = true;
            }

        }
    }
}
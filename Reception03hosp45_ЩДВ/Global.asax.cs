using System;
using System.Web.Routing;
using System.Web.Security;
using System.Web.Http;

namespace Reception03hosp45
{
    public class Global : System.Web.HttpApplication
    {
            void Application_Start(object sender, EventArgs e)
            {
            RouteTable.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = System.Web.Http.RouteParameter.Optional }
                );

        }

            void Application_End(object sender, EventArgs e)
            {
                //  Code that runs on application shutdown

            }

            void Application_Error(object sender, EventArgs e)
            {
                // Code that runs when an unhandled error occurs

            }
    }
}
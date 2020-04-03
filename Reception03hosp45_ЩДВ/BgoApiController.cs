using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
//using System.Web.Http;
using System.Web.Mvc;

namespace Reception03hosp45.Controllers
{
    public class BgoApiController : System.Web.Http.ApiController
    {
        public class TripObject
        {
            public string JsonTxt { get; set; }
            public string TokenBgo { get; set; }
        }

        // GET api/<controller>
        // GET api/va
        public string Get(string JsonTxt, string TokenBgo)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://bg22.testlab.kz:9804");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", TokenBgo);
                StringContent content = new StringContent(JsonTxt, Encoding.UTF8, "application/json");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var response = client.GetAsync("api//referrals//saveReferral").Result;
                if (response.IsSuccessStatusCode)
                {
                    string responseString = response.Content.ReadAsStringAsync().Result;
                }
            }
            return "View()";
        }

        [HttpPost]
        public async Task<string> PostBgo(TripObject data)
        {
            string JsonTxt = data.JsonTxt;
            string TokenBgo = data.TokenBgo;

            // Отключить проверку сертификата
            System.Net.ServicePointManager.ServerCertificateValidationCallback += (se, cert, chain, sslerror) => { return true; };

            using (var client = new HttpClient())
            {
                //  client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", TokenBgo);
                //  client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                StringContent content = new StringContent(JsonTxt, Encoding.UTF8, "application/json");
                HttpResponseMessage response = await client.PostAsync("https://bg22.testlab.kz:9804//api//referrals//saveReferral", content);
                string result = await response.Content.ReadAsStringAsync();

                if (response.IsSuccessStatusCode)
                {
                    return "OK";
                }

                dynamic myObject = Newtonsoft.Json.JsonConvert.DeserializeObject(result);
                string ErrorTxt = myObject[0].message;
                return ErrorTxt;
            }
        }


    }
}
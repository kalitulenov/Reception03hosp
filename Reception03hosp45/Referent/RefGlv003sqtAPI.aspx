<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" %>

<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Http" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

     <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <script src="/JS/jquery.maskedinput-1.2.2.min.js" type="text/javascript" ></script>

    <script src="/JS/PhoneFormat.js" type="text/javascript" ></script>

   	<link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" /> 



    <script type="text/javascript">
        window.onload = function () {
            $.mask.definitions['D'] = '[0123]';
            $.mask.definitions['M'] = '[01]';
            $.mask.definitions['Y'] = '[12]';
            $('#BrtDat').mask('D9.M9.Y999');
        };
        /*------------------------- Изиять переданный параметр --------------------------------*/
        function getQueryString() {
            var queryString = [];
            var vars = [];
            var hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            //           alert("hashes=" + hashes);
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                queryString.push(hash[0]);
                vars[hash[0]] = hash[1];
                queryString.push(hash[1]);
            }
            return queryString;
        }

        /*------------------------- Изиять переданный параметр --------------------------------*/
        //  для ASP:TEXTBOX ------------------------------------------------------------------------------------

        //function ExitFun() {
        //    var KltFio = document.getElementById('SelFio').value;
        // //   alert(KltFio);
        //    //window.parent.KofClick();
        //    window.parent.KltOneClose(KltFio);
        //    //       location.href = "/BuxDoc/BuxKas.aspx?NumSpr=Кас&TxtSpr=Касса";
        //}


        function ExitFun() {
            var KltStx;
            var KltBrt;

            //if (document.getElementById('MorTxt').value.indexOf("Республиканский семейно-врачебный центр") < 0) KltStx = "ПЛАТНО";
            //else KltStx = "ГОСЗАКАЗ";

            if (document.getElementById('Status').value == "1") KltStx = "ЗАСТРАХОВАН";
            else KltStx = "НЕ ЗАСТРАХОВАН";

            KltBrt = document.getElementById('BrtTxt').value.substr(8, 2) + "." +
                document.getElementById('BrtTxt').value.substr(5, 2) + "." +
                document.getElementById('BrtTxt').value.substr(0, 4)
          //  alert(KltBrt);

            var GrfFio = document.getElementById('CntIdn').value + "&" +
                document.getElementById('FioTxt').value + "&" +
                document.getElementById('IinTxt').value + "&" +
                KltBrt + "&" +
                " " + "&" + " " + "&" +
                " " + "&" +
                KltStx + "&" +
                " " + "&" +
                " ";
            localStorage.setItem("FndFio", GrfFio); //setter

            window.parent.KltCloseRPN(GrfFio);
        }

        // -----------------------------------------------------------------------------------
        //    ---------------- обращение веб методу --------------------------------------------------------
        // -----------------------------------------------------------------------------------

    </script>

</head>


<script runat="server">
    string MdbNam = "HOSPBASE";
    string KltOneIin;
    string CntKltIdn;

    string BuxFrm;
    string BuxKod;
    string Result;
    string Token = "";
    public string HtmlResult;
    public string HtmlResultIns;

    /*

Name	    				Description	   								Type	   					Additional information
----------------------------------------------------------------------------------------------------------------------------
deathDate	          		    Дата смерти    								date	   					None.

isExistsOpenRequest	  		    Есть ли открытые запросы      				boolean	 					None.
                                на прикрепление/открепление

isExistsSomeActiveAttachment    Есть несколько активных прикреплений     	boolean 					None.
                                (ошибочно появившиеся при одновременной 
                                работе нового и старого РПН)

hGBD	 					    Идентификатор ГБДФЛ  						integer	 					None.
activeAttachment		        Аткивное прикрепление 						Attachment  				None.
parentId				        Идентификатор родительской записи  			integer 					None.
isDel						    Признак удаления    						boolean 					None.
personStatus				    personStatus = (1003 - умерший)    			integer	 					None.  
somePersonDataForDuplicate	    Даннные необходимые в модуле объединения  	SomePersonDataForDuplicate	None.
                                двойников
isExistsDataOfDeath			    Есть ли у данного ФЛ свидетельство  		boolean						None.
                                или сведения о смерти
OpenRequestAttach			    Активный запрос на прикрепление 			Attachment  				None.
OpenRequestCA				    Отложенный запрос на прикрепление  			Attachment  				None.
                                (Компания прикрепления)
ConfirmRequestCA			    Одобренный отложенный запрос на    			Attachment	 				None.
                                прикрепление (Компания прикрепления)
LastAttachmentSV			    Последнее прикрепление с причиной   		Attachment	 				None.
                                "Свободный выбор"
PersonID	 				    Идентификатор физического лица 				string						None.
lastName 				    	Фамилия 									string						Required
firstName	 				    Имя  										string						Required
secondName 					    Отчество 									string						None.
birthDate					    Дата рождения 								date 						Required
iin	 						    ИИН  										string 						None.
sex							    Пол 										string	 					Required
national  				    	Национальность  							string 						Required
citizen	 				    	Гражданство 								string	 					Required   
*/

    public class RPNobject
    {
        public string deathDate { get; set; }
        public string isExistsOpenRequest { get; set; }
        public string isExistsSomeActiveAttachment { get; set; }
        public string hGBD { get; set; }
        public Attachment activeAttachment { get; set; }
        public string parentId { get; set; }
        public string isDel { get; set; }
        public string personStatus { get; set; }
        public SomePersonDataForDuplicate somePersonDataForDuplicate { get; set; }
        public string isExistsDataOfDeath { get; set; }
        public Attachment OpenRequestAttach { get; set; }
        public Attachment OpenRequestCA { get; set; }
        public Attachment ConfirmRequestCA { get; set; }
        public Attachment LastAttachmentSV { get; set; }
        public string PersonID { get; set; }
        public string lastName { get; set; }
        public string firstName { get; set; }
        public string secondName { get; set; }
        public string birthDate { get; set; }
        public string iin { get; set; }
        public string sex { get; set; }
        public string national { get; set; }
        public string citizen { get; set; }
    }
    /*
    Name	                       Description	                    Type	             Additional information   
     ---------------------------------------------------------------------------------------
    AttachmentID	               Идентификатор прикрепления       integer	             None.
    PersonID	                   Идентификатор физического лица   integer	             None.
    attachmentStatus               Статус прикрепления              string	             None.
    beginDate                      Дата начала                      date	             None.
    endDate	                       Дата окончания                   date	             None.
    orgHealthCare       	       Медицинская организация          OrgHealthCare        None.
    careAtHome	                   Обслуживание на дому             boolean	             None.
    causeOfAttach	               Причина прикрепления             string	             None.
    attachmentProfile	           Профиль                          string	             None.
    personAddressesID	           Адрес                            integer	             None.
    doctorID	                   Врач                             integer	             None.
    territoryServiceID	           ID Участка                       integer	             None.
    territotyServiceNumber  	   Номер участка                    integer	             None.
    territoryServiceProfileID	   ID Профиля участка               integer	             None.
    person	                       Физическое лицо                  PersonBase	         None.
    ParentID	                   Родительская запись              integer	             None.
    isMigrated	                   Запрос с портала egov            boolean              None.
    isCompletedOrRefused	       Обработан ли запрос              boolean	             None.
    Num	                           Номер запроса                    integer	             None.
    attachmentFiles                Прикрепленные документы          Collection of Files	 None.
    servApplicationID	           Id Записи запроса с Егов         integer	             None.
        */
    public class Attachment
    {
        public string AttachmentID { get; set; }
        public string PersonID { get; set; }
        public string attachmentStatus { get; set; }
        public string beginDate { get; set; }
        public string endDate { get; set; }
        public OrgHealthCare orgHealthCare { get; set; }
        public string careAtHome { get; set; }
        public string causeOfAttach { get; set; }
        public string attachmentProfile { get; set; }
        public string personAddressesID { get; set; }
        public string doctorID { get; set; }
        public string territoryServiceID { get; set; }
        public string territotyServiceNumber { get; set; }
        public string territoryServiceProfileID { get; set; }
        public PersonBase person { get; set; }
        public string ParentID { get; set; }
        public string isMigrated { get; set; }
        public string isCompletedOrRefused { get; set; }
        public string Num { get; set; }
        public string attachmentFiles { get; set; }
        public string servApplicationID { get; set; }
    }

    /*
        Name	Description	Type	Additional information
        -----------------------------------------------------
        id	        Идентификатор РПН     string	None.
        name        Наименование          string	None.
        originalID	Идентификатор СУР     string	None.
        oblId	    Идентификатор области integer	None. 
    */

    public class OrgHealthCare
    {
        public string id { get; set; }
        public string name { get; set; }
        public string originalID { get; set; }
        public string oblId { get; set; }
    }

    /*
        Name	Description	Type	Additional information
        -----------------------------------------------------
        PersonID	Идентификатор физического лица string	None.
        lastName    Фамилия                         string	Required
        firstName	Имя                             string	Required
        secondName	Отчество                        string	None.
        birthDate	Дата рождения                   date	Required
        iin	        ИИН                             string	None.
        sex	        Пол                             string	Required
        national	Национальность                  string	Required
        citizen	    Гражданство                     string	Required
    */

    public class PersonBase
    {
        public string PersonID { get; set; }
        public string lastName { get; set; }
        public string firstName { get; set; }
        public string secondName { get; set; }
        public string birthDate { get; set; }
        public string iin { get; set; }
        public string sex { get; set; }
        public string national { get; set; }
        public string citizen { get; set; }
    }

    /*
    Name	Description	Type	Additional information
    -----------------------------------------------------
    deathDateConfirmed	boolean	                        None.
    deathDate	        date	                        None.
    activeAttachment	Attachment	                    None.
    deathReg	        Collection of DeathRegModel	    None.
    birthReg	        Collection of BirthRegModel	    None.
*/

    public class SomePersonDataForDuplicate
    {
        public string deathDateConfirmed { get; set; }
        public string deathDate { get; set; }
        public Attachment activeAttachment { get; set; }
        public string deathReg { get; set; }
        public string birthReg { get; set; }
    }

    public class RespData
    {
        public string requestId { get; set; }
        public string responseId { get; set; }
        public string requestDate { get; set; }
        public string responseStatus { get; set; }
        public string errorData { get; set; }
        public string iin { get; set; }
        public RequestData insuredData { get; set; }
    }

    public class RequestData
    {
        public string insuredStatus { get; set; }

        public string statusDescriptionKZ { get; set; }

        public string statusDescriptionRu { get; set; }
    }

    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //string baseAddress = "";
        //string TKNINS = "";
        //string response = "";
        //string baseParam = "";
        string TokenIns = "";
        string KltSts = "";


        KltOneIin = Convert.ToString(Request.QueryString["KltOneIin"]);

        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];

        if (!Page.IsPostBack)
        {
            KltOneIin = Convert.ToString(Request.QueryString["KltOneIin"]);

            BuxFrm = (string)Session["BuxFrmKod"];
            BuxKod = (string)Session["BuxKod"];

            if (!Page.IsPostBack)
            {
                IdnTxt.Text = "";
                IinTxt.Text = "";
                BrtTxt.Text = "";
                FioTxt.Text = "";
                BoxTit.Text = "";
                SexTxt.Text = "";
                UchTypTxt.Text = "";
                DatPrkTxt.Text = "";
                MorTxt.Text = "";
                DomTxt.Text = "";

                string Token = "";


                // ******************************************************* ПОЛУЧИТЬ ТОКЕН ***************************************************************************
                DataSet dsIin = new DataSet();
                string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();

                SqlCommand cmdIin = new SqlCommand("SELECT TOP 1 * FROM TABTKN WHERE TKNFRM=" + BuxFrm, con);
                SqlDataAdapter daIin = new SqlDataAdapter(cmdIin);
                // заполняем DataSet из хран.процедуры.
                daIin.Fill(dsIin, "HspTkn");
                if (dsIin.Tables[0].Rows.Count > 0)
                {
                    Token = Convert.ToString(dsIin.Tables[0].Rows[0]["TKNRPN"]);
                    TokenIns = Convert.ToString(dsIin.Tables[0].Rows[0]["TKNINS"]);
                }

                con.Close();

                // ******************************************************* ОБРАТИТСЯ К API РПН ***************************************************************************
                string apiUrl = "http://5.104.236.197:22999/services/api/Person?fioiin=" + KltOneIin + "& page=1&pagesize=10";
                try
                {
                    using (WebClient client = new WebClient())
                    {
                        client.Headers.Add("Content-Type", "text");
                        client.Headers[HttpRequestHeader.Authorization] = "Bearer " + Token;
                        client.Encoding = Encoding.UTF8;
                        HtmlResult = client.DownloadString(apiUrl);
                        // HtmlResult = client.UploadString(apiUrl,"");


                        if (HtmlResult != "[]")
                        {
                            List<RPNobject> RPNobjects = new List<RPNobject>();

                            RPNobjects = JsonConvert.DeserializeObject<List<RPNobject>>(HtmlResult);

                            IdnTxt.Text = RPNobjects[0].PersonID;
                            IinTxt.Text = KltOneIin;
                            BrtTxt.Text = RPNobjects[0].birthDate.Substring(0, 10);
                            FioTxt.Text = Convert.ToString(RPNobjects[0].lastName + " " + RPNobjects[0].firstName + " " + RPNobjects[0].secondName);
                            BoxTit.Text = FioTxt.Text;

                            if (RPNobjects[0].sex == "3") SexTxt.Text = "муж";
                            else
                               if (RPNobjects[0].sex == "2") SexTxt.Text = "жен";
                            else SexTxt.Text = "";

                        //    MigTxt.Text = RPNobjects[0].activeAttachment.isMigrated;
                            UchTypTxt.Text = RPNobjects[0].activeAttachment.territoryServiceProfileID;

                            if (Convert.ToString(UchTypTxt.Text) == null || Convert.ToString(UchTypTxt.Text) == "" || Convert.ToString(UchTypTxt.Text) == "1") UchTypTxt.Text = "Город";
                            else UchTypTxt.Text = "Село";

                            DatPrkTxt.Text = RPNobjects[0].activeAttachment.beginDate.Substring(0, 10);
                            MorTxt.Text = Convert.ToString(RPNobjects[0].activeAttachment.orgHealthCare.name);

                            //      if (MorTxt.Text.IndexOf("Республиканский семейно-врачебный центр") < 0) MorTxt.ForeColor = Color.Red;

                            if (RPNobjects[0].activeAttachment.careAtHome == "true") DomTxt.Text = "да";
                            else DomTxt.Text = "нет";
                        }
                        else
                        {
                            IdnTxt.Text = "";
                            IinTxt.Text = "";
                            BrtTxt.Text = "";
                            FioTxt.Text = "";
                            BoxTit.Text = "";
                            SexTxt.Text = "";
                            UchTypTxt.Text = "";
                            DatPrkTxt.Text = "";
                            MorTxt.Text = "ИИН не верен";
                            DomTxt.Text = "";
                        }
                    }
                }
                catch (Exception ex)
                {
                    IdnTxt.Text = "";
                    IinTxt.Text = "";
                    BrtTxt.Text = "";
                    FioTxt.Text = "";
                    BoxTit.Text = "";
                    SexTxt.Text = "";
                    UchTypTxt.Text = "";
                    DatPrkTxt.Text = "";
                    MorTxt.Text = "Истек токен";
                    DomTxt.Text = "";
                }

                // ******************************************************* ОБРАТИТСЯ К API РПН ***************************************************************************

                //        /*  ОБРАЩЕНИЕ К САКТАНДЫРУ ДЛЯ ОПРЕДЕЛЕНИЯ СТАТУСА ИИН */
                //        baseAddress = @"http://87.255.215.3:4000///statusservice//getInsuranceStatus"; //?iin=520926401087&requestId=1&requestDate=2019-11-25 00:00:00";
                //        clientIns.DefaultRequestHeaders.Add("Authorization", "Bearer " + TokenIns);
                string apiUrlIns = "http://87.255.215.3:4000///statusservice//getInsuranceStatus?iin=" + KltOneIin + "&requestId=1&requestDate="+DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.CreateSpecificCulture("en-US"));
                using (WebClient clientIns = new WebClient())
                {
                    clientIns.Headers.Add("Content-Type", "text");
                    clientIns.Headers[HttpRequestHeader.Authorization] = "Bearer " + TokenIns;
                    clientIns.Encoding = Encoding.UTF8;
                    HtmlResultIns = clientIns.DownloadString(apiUrlIns);
                    // HtmlResult = client.UploadString(apiUrl,"");


                    if (HtmlResultIns != "[]")
                    {
                        // List<RespData> respData = new List<RespData>();
                        RespData respData = new RespData();

                        respData = JsonConvert.DeserializeObject<RespData>(HtmlResultIns);

                        if (respData.insuredData.insuredStatus == "100")
                        {
                            Status.Value = "1";
                            StsTxt.Text = "ЗАСТРАХОВАН";
                        }
                        else
                        {
                            Status.Value = "2";
                            StsTxt.Text = "НЕ ЗАСТРАХОВАН";
                        }


                    }

                    //if (String.IsNullOrEmpty(ds.Tables[0].Rows[0]["KLTSOZLGT"].ToString())) BoxSoz.SelectedValue = "0";
                    //else BoxSoz.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["KLTSOZLGT"]);

                    //HttpClient clientIns = new HttpClient();

                    //                            // ******************************************************************************************************************************************
                    //            /*  ОБРАЩЕНИЕ К САКТАНДЫРУ ДЛЯ ОПРЕДЕЛЕНИЯ СТАТУСА ИИН */
                    //            baseParam = "?iin=" + KltOneIin +
                    //                             "&requestId=12" + 
                    //                             "&requestDate=" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.CreateSpecificCulture("en-US"));
                    //            response = clientIns.GetStringAsync(baseAddress + baseParam);
                    //            RespData respData = JsonConvert.DeserializeObject<RespData>(response);
                    //            FinSouIdn = 1;
                    //            if (respData.insuredData.insuredStatus == "100") FinSouIdn = 1;
                    //            else FinSouIdn = 2;
                }

            }


        }
    }


    // ============================ кнопка новый документ  ==============================================

    protected void ChkButton_Click(object sender, EventArgs e)
    {
        ConfirmOK.Visible = false;
        ConfirmOK.VisibleOnLoad = false;

        //---------------------------------------------- проверка --------------------------

        if (FioTxt.Text.Length == 0)
        {
            Err.Text = "Не указан фамилия";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }
        if (IinTxt.Text.Length != 12)
        {
            Err.Text = "Ошибка в ИИН";
            ConfirmOK.Visible = true;
            ConfirmOK.VisibleOnLoad = true;
            return;
        }

        //---------------------------------------------- запись --------------------------
        string KltStx = "";
        string KltFam = "";
        string KltCmp = "";
        string KltCnt = "";
        string KltVar = "";
        string KltUch = "";
        string KltKrtBeg = "";
        string KltKrtEnd = "";
        string KltEmp = "";
        string KltDlg = "";
        bool KltStf = false;
        bool KltVip = false;
        bool KltDspFlg = false;
        // string KltDspDat = "";

        string KltFio = "";
        bool KltSex = false;
        bool KltRsd = false;
        string KltBrt = "";
        string KltIin = "";
        string KltInv = "";
        string KltTel = "";
        string KltAlr = "";
        string KltAdrObl = "";
        string KltAdrPnk = "";
        string KltAdrStr = "";
        string KltAdrDom = "";
        string KltAdrApr = "";
        string KltAdrUgl = "";
        string KltAdrPod = "";
        string KltAdrEtg = "";
        string KltAdrDmf = "";
        string KltAdrZsd = "";
        string KltKnt001 = "";
        string KltKnt001Tel = "";
        string KltKnt002 = "";
        string KltKnt002Tel = "";
        string KltBol = "";
        string KltLek = "";
        string KltPrt = "";
        string KltKrvGrp = "";
        string KltKrvRes = "";
        string KltMem = "";
        string KltSum = "";
        string KltLgt = "";
        string KltSoz = "";
        string KltSts = "";
        string KltPrk = "";
        string KltUchTyp = "";

        //=====================================================================================
        // BuxFrm = (string)Session["BuxFrmKod"];
        //=====================================================================================

        if (Convert.ToString(BoxSoz.SelectedValue) == null || Convert.ToString(BoxSoz.SelectedValue) == "") KltSoz = "";
        else KltSoz = Convert.ToString(BoxSoz.SelectedValue);

        if (Convert.ToString(UchTypTxt.Text) == null || Convert.ToString(UchTypTxt.Text) == "" || Convert.ToString(UchTypTxt.Text) == "Город") KltUchTyp = "Город";
        else KltUchTyp = "Село";

        if (MorTxt.Text.IndexOf("Республиканский семейно-врачебный центр") < 0) KltStx = "00004";
        else KltStx = "00001";

        KltPrk = MorTxt.Text;

        KltKrtBeg = DatPrkTxt.Text.Substring(8, 2) + "." + DatPrkTxt.Text.Substring(5, 2) + "." + DatPrkTxt.Text.Substring(0, 4);
        // ------------------------------------------------------------------------------------------------------------------------     
        KltFio = FioTxt.Text;
        if (Convert.ToString(SexTxt.Text) == "муж") KltSex = true;
        else KltSex = false;
        KltRsd = false;
        KltBrt = BrtTxt.Text.Substring(8, 2) + "." + BrtTxt.Text.Substring(5, 2) + "." + BrtTxt.Text.Substring(0, 4);
        KltIin = Convert.ToString(IinTxt.Text);

        // строка соединение
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("InsSprCntKltRepRpn", con);
        cmd = new SqlCommand("InsSprCntKltRepRpn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // создать коллекцию параметров
        cmd.Parameters.Add("@BUXFRM", SqlDbType.VarChar).Value = BuxFrm;
        cmd.Parameters.Add("@KltIdn", SqlDbType.VarChar).Value = 0;   // KltOneIdn;
        cmd.Parameters.Add("@CntIdn", SqlDbType.VarChar).Value = 0; /// CntOneIdn;
        cmd.Parameters.Add("@KltStx", SqlDbType.VarChar).Value = KltStx;
        cmd.Parameters.Add("@KltCmp", SqlDbType.VarChar).Value = KltCmp;
        cmd.Parameters.Add("@KltCnt", SqlDbType.VarChar).Value = KltCnt;
        cmd.Parameters.Add("@KltVar", SqlDbType.VarChar).Value = KltVar;
        cmd.Parameters.Add("@KltUch", SqlDbType.VarChar).Value = KltUch;
        cmd.Parameters.Add("@KltKrtBeg", SqlDbType.VarChar).Value = KltKrtBeg;
        cmd.Parameters.Add("@KltKrtEnd", SqlDbType.VarChar).Value = KltKrtEnd;
        cmd.Parameters.Add("@KltEmp", SqlDbType.VarChar).Value = KltEmp;
        cmd.Parameters.Add("@KltDlg", SqlDbType.VarChar).Value = KltDlg;
        cmd.Parameters.Add("@KltStf", SqlDbType.Bit, 1).Value = KltStf;
        cmd.Parameters.Add("@KltVip", SqlDbType.Bit, 1).Value = KltVip;
        cmd.Parameters.Add("@KltDspFlg", SqlDbType.Bit, 1).Value = KltDspFlg;
        cmd.Parameters.Add("@KltDspDat", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@KltFio", SqlDbType.NVarChar).Value = KltFio;
        cmd.Parameters.Add("@KltSex", SqlDbType.Bit, 1).Value = KltSex;
        cmd.Parameters.Add("@KltRsd", SqlDbType.Bit, 1).Value = KltRsd;
        cmd.Parameters.Add("@KltBrt", SqlDbType.VarChar).Value = KltBrt;
        cmd.Parameters.Add("@KltIin", SqlDbType.VarChar).Value = KltIin;
        cmd.Parameters.Add("@KltInv", SqlDbType.VarChar).Value = KltInv;
        cmd.Parameters.Add("@KltTel", SqlDbType.VarChar).Value = KltTel;
        cmd.Parameters.Add("@KltAlr", SqlDbType.VarChar).Value = KltAlr;
        cmd.Parameters.Add("@KltAdrObl", SqlDbType.VarChar).Value = KltAdrObl;
        cmd.Parameters.Add("@KltAdrPnk", SqlDbType.VarChar).Value = KltAdrPnk;
        cmd.Parameters.Add("@KltAdrStr", SqlDbType.VarChar).Value = KltAdrStr;
        cmd.Parameters.Add("@KltAdrDom", SqlDbType.VarChar).Value = KltAdrDom;
        cmd.Parameters.Add("@KltAdrApr", SqlDbType.VarChar).Value = KltAdrApr;
        cmd.Parameters.Add("@KltAdrUgl", SqlDbType.VarChar).Value = KltAdrUgl;
        cmd.Parameters.Add("@KltAdrPod", SqlDbType.VarChar).Value = KltAdrPod;
        cmd.Parameters.Add("@KltAdrEtg", SqlDbType.VarChar).Value = KltAdrEtg;
        cmd.Parameters.Add("@KltAdrDmf", SqlDbType.VarChar).Value = KltAdrDmf;
        cmd.Parameters.Add("@KltAdrZsd", SqlDbType.VarChar).Value = KltAdrZsd;
        cmd.Parameters.Add("@KltSoz", SqlDbType.VarChar).Value = KltSoz;

        cmd.Parameters.Add("@KltKnt001", SqlDbType.VarChar).Value = KltKnt001;
        cmd.Parameters.Add("@KltKnt001Tel", SqlDbType.VarChar).Value = KltKnt001Tel;
        cmd.Parameters.Add("@KltKnt002", SqlDbType.VarChar).Value = KltKnt002;
        cmd.Parameters.Add("@KltKnt002Tel", SqlDbType.VarChar).Value = KltKnt002Tel;
        cmd.Parameters.Add("@KltBol", SqlDbType.VarChar).Value = KltBol;
        cmd.Parameters.Add("@KltLek", SqlDbType.VarChar).Value = KltLek;
        cmd.Parameters.Add("@KltPrt", SqlDbType.VarChar).Value = KltPrt;
        cmd.Parameters.Add("@KltKrvGrp", SqlDbType.VarChar).Value = KltKrvGrp;
        cmd.Parameters.Add("@KltKrvRes", SqlDbType.VarChar).Value = KltKrvRes;
        cmd.Parameters.Add("@KltMem", SqlDbType.VarChar).Value = KltMem;
        cmd.Parameters.Add("@KltSum", SqlDbType.VarChar).Value = KltSum;
        cmd.Parameters.Add("@KltLgt", SqlDbType.VarChar).Value = KltLgt;
        cmd.Parameters.Add("@KltSts", SqlDbType.VarChar).Value = Status.Value;
        cmd.Parameters.Add("@KltPrk", SqlDbType.VarChar).Value = KltPrk;
        cmd.Parameters.Add("@KltUchTyp", SqlDbType.VarChar).Value = KltUchTyp;
        cmd.Parameters.Add("@CNTKLTIDN", SqlDbType.Int, 4).Value = 0;
        cmd.Parameters["@CNTKLTIDN"].Direction = ParameterDirection.Output;
        // ------------------------------------------------------------------------------заполняем второй уровень
        cmd.ExecuteNonQuery();
        try
        {
            int numAff = cmd.ExecuteNonQuery();
            // Получить вновь сгенерированный идентификатор.
            CntKltIdn = Convert.ToString(cmd.Parameters["@CNTKLTIDN"].Value);
            CntIdn.Value = CntKltIdn;
        }
        finally
        {
            con.Close();
        }

        con.Close();

        //           ConfirmDialog.Visible = false;
        //           ConfirmDialog.VisibleOnLoad = false;
        //  SelFio.Value = KltFio;
        ExecOnLoad("ExitFun();");

        // ------------------------------------------------------------------------------заполняем второй уровень
        //    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Close_Window", "self.close();", true);


    }


    //------------------------------------------------------------------------


</script>


<body>
    <form id="form1" runat="server">
       <asp:HiddenField ID="CntIdn" runat="server" />
       <asp:HiddenField ID="SelFio" runat="server" />
       <asp:HiddenField ID="Status" runat="server" />

        <asp:ScriptManager runat="server" EnablePartialRendering="true" ID="ScriptManager2" />

        <%-- ============================  верхний блок  ============================================ --%>
        <asp:Panel ID="PanelTop" runat="server" BorderStyle="Double"
            Style="left: -4px; position: relative; top: 0px; width: 100%; height: 380px;">

            <asp:TextBox ID="BoxTit"
                Text=""
                BackColor="#DB7093"
                Font-Names="Verdana"
                Font-Size="20px"
                Font-Bold="True"
                ForeColor="White"
                Style="top: 0px; left: 0px; position: relative; width: 100%"
                runat="server"></asp:TextBox>

        <table border="0" cellspacing="0" width="100%" cellpadding="0">

 <!-- IDN  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;IDN:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="IdnTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!--  ИИН ------------------------------------------------------------------------------------------------>  
                         <tr style="height:35px"> 
                            <td width="20%" class="PO_RowCap">&nbsp;ИИН:</td>
                             <td width="80%" style="vertical-align: top;">
                                  <obout:OboutTextBox runat="server" ID="IinTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                             </td>                                                         
                        </tr>
 <!--  ФИО ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px">                             
                             <td width="20%" class="PO_RowCap">&nbsp;Фамилия И.О:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="FioTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>
                        </tr>
 <!--  ПОЛ ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="20%" class="PO_RowCap">&nbsp;Пол:</td>
                             <td width="80%" style="vertical-align: central;">
                                 <obout:OboutTextBox runat="server" ID="SexTxt"  width="20%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                 &nbsp;Д/р:&nbsp;

                                <obout:OboutTextBox runat="server" ID="BrtTxt"  width="40%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                                
                            </td>
                        </tr>
 <!-- МО  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;МО:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="MorTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                             
                        </tr>
 <!-- Дата прикрепление  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 
                             <td width="10%" class="PO_RowCap">&nbsp;Дата прикреп.:</td>
                             <td width="90%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="DatPrkTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!-- На дому  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;На дому:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="DomTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!-- Оралман  ----------------------------------------------------------------------------------------------------------  -->  
                         <tr style="height:35px"> 

                             <td width="20%" class="PO_RowCap">&nbsp;Город/Село:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="UchTypTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>

 <!-- Статус ----------------------------------------------------------------------------------------------------------  -->  
                        <tr style="height:35px">  
                             <td width="20%" class="PO_RowCap">&nbsp;Статус:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:OboutTextBox runat="server" ID="StsTxt"  width="100%" BackColor="White" Height="35px"
                                     FolderStyle="~/Styles/Interface/plain/OboutTextBox">
		                         </obout:OboutTextBox>
                            </td>  
                        </tr>
 <!-- Соц не защищенный ----------------------------------------------------------------------------------------------------------  -->  
                       
                         <tr style="height:35px">  
                             <td width="20%" class="PO_RowCap">&nbsp;Соц.защита:</td>
                             <td width="80%" style="vertical-align: top;">
                                 <obout:ComboBox runat="server" ID="BoxSoz"  Width="100%" Height="300" MenuWidth="600" 
                                        FolderStyle="/Styles/Combobox/Plain" >
                                        <Items>
                                            <obout:ComboBoxItem ID="ComboBoxItem09" runat="server" Text="" Value="0" />
                                            <obout:ComboBoxItem ID="ComboBoxItem10" runat="server" Text="Дети до 18 лет" Value="1" />
                                            <obout:ComboBoxItem ID="ComboBoxItem11" runat="server" Text="Беременные" Value="2" />
                                            <obout:ComboBoxItem ID="ComboBoxItem12" runat="server" Text="Участники Великой Отечественной войны" Value="3" />
                                            <obout:ComboBoxItem ID="ComboBoxItem13" runat="server" Text="Инвалиды" Value="4" />
                                            <obout:ComboBoxItem ID="ComboBoxItem14" runat="server" Text="Многодетные матери, награжденные подвесками «Алтын алка», «Кумыс алка»" Value="5" />
                                            <obout:ComboBoxItem ID="ComboBoxItem15" runat="server" Text="Получатели адресной социальной помощи" Value="6" />
                                            <obout:ComboBoxItem ID="ComboBoxItem16" runat="server" Text="Пенсионеры по возрасту" Value="7" />
                                            <obout:ComboBoxItem ID="ComboBoxItem17" runat="server" Text="Больным инфекционными, социально-значимыми заболеваниями и заболеваниями, представляющими опасность для окружающих" Value="8" />
                                            <obout:ComboBoxItem ID="ComboBoxItem18" runat="server" Text="По заболеванию" Value="9" />
                                         </Items>
                                 </obout:ComboBox>  
                            </td>  
                        </tr>
          </table>
<%--            <hr />--%>

         </asp:Panel>
 
           <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
               Style="left: -4px; position: relative; top: 0px; width: 100%; height: 27px;">
               <center>
                   <asp:Button ID="Button1" runat="server" CommandName="Add"  style="display:none" Text="1"/>
                   <asp:Button ID="AddButton" runat="server" CommandName="Add" OnClick="ChkButton_Click" Text="Записать на прием"/>
               </center>
           </asp:Panel>

  <%-- ============================  для отображение графика врачей на один день в виде окна geryon============================================ --%>
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
    <%-- =================  Пароль успешно изменен  ============================================ --%>

        <%-- ============================  верхний блок  ============================================ --%>

   <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />
<%-- =================  диалоговое окно для резултатов проверок на корректность  ============================================ --%>
      <owd:Dialog ID="ConfirmOK" runat="server" Visible="false" IsModal="true" Width="350" Height="180" StyleFolder="/Styles/Window/wdstyles/default" Title="Укажите логин и пароль" zIndex="10" VisibleOnLoad="true" ShowCloseButton="false">
            <br />
            <center>
                <table>
                    <tr>
                        <td>
                           <asp:TextBox id="Err" ReadOnly="True" Width="300" Height="20" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <input type="button" value="OK" onclick="ConfirmOK.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog>

    </form>


    <%-- ------------------------------------- для удаления отступов в GRID ------------------------------ --%>
    <style type="text/css">
        /* ------------------------------------- для разлиновки GRID --------------------------------*/
        .ob_gCS {
            display: block !important;
        }
        /* ------------------------------------- для удаления отступов в GRID --------------------------------*/
        div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 14px;
        }

        .ob_gH .ob_gC, .ob_gHContWG .ob_gH .ob_gCW, .ob_gHCont .ob_gH .ob_gC, .ob_gHCont .ob_gH .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 18px;
        }

        .ob_gFCont {
            font-size: 18px !important;
            color: #FF0000 !important;
        }

        /*------------------------- для укрупнения шрифта COMBOBOX  --------------------------------*/

        .ob_iCboICBC li {
            height: 20px;
            font-size: 12px;
        }

        .Tab001 {
            height: 100%;
        }

            .Tab001 tr {
                height: 100%;
            }

        /*------------------------- для excel-textbox  --------------------------------*/

        .excel-textbox {
            background-color: transparent;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-focused {
            background-color: #FFFFFF;
            border: 0px;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            outline: 0;
            font: inherit;
            width: 100%;
            padding-top: 4px;
            padding-bottom: 4px;
        }

        .excel-textbox-error {
            color: #FF0000;
            font-size: 12px;
        }

        .ob_gCc2 {
            padding-left: 3px !important;
        }

        .ob_gBCont {
            border-bottom: 1px solid #C3C9CE;
        }
                /*------------------------- для OBOUTTEXTBOX  --------------------------------*/
           .ob_iTIE
    {
          font-size: xx-large;
          font: bold 12px Tahoma !important;  /* для увеличение корректируемого текста*/
          
    }
               hr {
          border: none; /* Убираем границу */
          background-color: red; /* Цвет линии */
          color: red; /* Цвет линии для IE6-7 */
          height: 2px; /* Толщина линии */
   }

    </style>

</body>

</html>



<%@ Page Language="C#" AutoEventWireup="true" Inherits="OboutInc.oboutAJAXPage" Title="Безымянная страница" %>

<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="owd" Namespace="OboutInc.Window" Assembly="obout_Window_NET" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<%-- ================================================================================ --%>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Http" %>
<%@ Import Namespace="System.IO" %>

<%--<%@ Import Namespace="System.Net.Http.Headers" %>--%>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>



<%-- ================================================================================ --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <!--  ссылка на JQUERY DIALOG-------------------------------------------------------------- -->
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


    <%-- ============================  JAVA ============================================ --%>
    <script type="text/javascript">

        function HandlePopupPost(result) {
            var jsVar = "dotnetcurry.com";
            __doPostBack('callPostBack', jsVar);
        }

        function GridNap_Edit(sender, record) {
            
 //           alert("record.STRUSLKEY=" + record.STRUSLKEY);
                TemplateNprKey._valueToSelectOnDemand = record.STRUSLKEY;
                TemplateGrpKey.value(record.STRUSLKEY);
                TemplateGrpKey._preventDetailLoading = false;
                TemplateGrpKey._populateDetail();

                return true;
        }

        // ==================================== корректировка данные клиента в отделном окне  ============================================
        //function GridNap_ClientEdit(sender, record) {
        //    document.getElementById('parPrsIdn').value = record.PRSIDN;
        //    TrfWindow.Open();

        //    return false;
        //}


        function GridNap_ClientAdd(sender, record) {

   //                    alert("GridUыд_ClientEdit");
//            document.getElementById('parPrsIdn').value = 0;
//            TrfWindow.Open();
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 
            var ua = navigator.userAgent;
            if (ua.search(/Chrome/) > -1)
                window.open("/Priem/DocAppAmbPrsGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                            "ModalPopUp", "toolbar=no,width=800,height=545,left=350,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Priem/DocAppAmbPrsGosSel.aspx?AmbCrdIdn=" + AmbCrdIdn,
                    "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:350px;dialogtop:100px;dialogWidth:800px;dialogHeight:545px;");

            return false;
        }




        //    ==========================  ПЕЧАТЬ =============================================================================================
        function PrtButton_Click() {
 //           alert('AmbCrdIdn= ' );
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value; 
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function PrtButtonAll_Click() {
            //           alert('AmbCrdIdn= ' );
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
            var ua = navigator.userAgent;

            if (ua.search(/Chrome/) > -1)
                window.open("/Report/DauaReports.aspx?ReportName=HspAmbPrsAll&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.showModalDialog("/Report/DauaReports.aspx?ReportName=HspAmbPrsAll&TekDocIdn=" + AmbCrdIdn, "ModalPopUp", "center:yes;resizable:yes;status:no;dialogleft:200px;dialogtop:100px;dialogWidth:900px;dialogHeight:650px;");
        }

        function SablonPrs() {
            var AmbCrdIdn = document.getElementById('HidAmbCrdIdn').value;
        //    alert('AmbCrdIdn=' + AmbCrdIdn);
            window.open("DocAppSblNap.aspx?AmbCrdIdn=" + AmbCrdIdn,"ModalPopUp", "toolbar=no,width=900,height=600,left=200,top=50,location=no,modal=yes,status=no,scrollbars=no,resize=no");
        }

        function GridPrs_sbl(rowIndex) {
//            alert("GridUsl_sbl=");
            var AmbPrsIdn = GridNap.Rows[rowIndex].Cells[0].Value;

  //          alert("AmbPrsIdn="+AmbPrsIdn);
 //           alert("BuxKod=" + document.getElementById('parBuxKod').value);

            $.ajax({
                type: 'POST',
                url: 'DocAppAmbPrs.aspx/ZapSablon',
                data: '{"AmbPrsIdn":"' + AmbPrsIdn + '", "BuxKod":"' + document.getElementById('parBuxKod').value + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () { },
                error: function () { alert("Ошибка!"); }
            });
        }


        function GridPrs_prt(rowIndex) {
            var AmbPrsIdn = GridNap.Rows[rowIndex].Cells[0].Value;
            window.open("/Report/DauaReports.aspx?ReportName=HspAmbPrsOne&TekDocIdn=" + AmbPrsIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
        }

        function GridPrs_prt_exp(rowIndex) {
            var AmbPrsIdn = GridNap.Rows[rowIndex].Cells[0].Value;
            var PrsTrf = GridNap.Rows[rowIndex].Cells[3].Value;
            if (PrsTrf.length == 0)
                window.open("/Report/DauaReports.aspx?ReportName=HspDocStzNap&TekDocIdn=" + AmbPrsIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
            else
                window.open("/Report/DauaReports.aspx?ReportName=HspDocStzNap&TekDocIdn=" + AmbPrsIdn, "ModalPopUp", "toolbar=no,width=900,height=650,left=200,top=100,location=no,modal=1,status=no,scrollbars=no,resize=no,fullscreen=yes");
        }

        function GridPrs_app_exp(rowIndex) {
            //         alert('GridKas_dbl=');
            document.getElementById('parPrsIdn').value = GridNap.Rows[rowIndex].Cells[0].Value;
            var PrsTrf = GridNap.Rows[rowIndex].Cells[3].Value;
            if (PrsTrf.length == 0) {
                myDialogSTZ.Open();
            }
            else {
                //if (confirm("Хотите отправить направления в ПС?") == false) {
                //    return false;
                //}
                myDialogAPP.Open();
            }
        }

        // GET ALL
        function GetBgo(JsonTxt,TokenBgo) {
            //alert("GetBgo=JsonTxt=" + JsonTxt.length);
            //alert("GetBgo=TokenBgo=" + TokenBgo.length);
           // JsonTxt = JsonTxt.substring(0, 1000);

            var TripObject = {
                JsonTxt: JsonTxt,
                TokenBgo: TokenBgo
            };

         //   console.log(TripObject);

            $.ajax({
                type: "POST",
                url: "/api/BgoApi",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(TripObject), // pass json object to web api
                success: function (data) {
                    if (data == "OK") windowalert("Успешно отправлено в БГ", "Сообщение", "info");
                    else windowalert(data, "Ошибка", "error");
                },
                error: function (xhr) {
                    alert("ОШИБКА!");
                }
            });
        }

    </script>

</head>


<script runat="server">

    string BuxSid;
    string BuxFrm;
    string BuxKod;
    string AmbCrdIdn = "";
    string whereClause = "";

    string MdbNam = "HOSPBASE";

    int PrsIdn;
    int PrsAmb;
    int PrsGrp;
    int PrsNum;
    int PrsUsl;
    int PrsUslExp;
    string PrsMem;
    bool PrsNprFlg;
    public string HtmlResult;

    string KltIin;
    string KltLgt;
    string KltCtyVil;
    string KltPrkIdn;
    string KltAdrIdn;
    string KltBrt;
    string KltPrsIdn;
    string KltGbd;
    string KltFam;
    string KltIma;
    string KltOtc;
    string KltSex;
    string KltNat;
    string KltCit;
    string KltNum;
    string KltAdr;


    public class Referral
    {
        public Patient patient = new Patient();                            //Пациент (Физ. лицо) 
        public OrgSchemeDirect orgSchemeDirect = new OrgSchemeDirect();            //Направляющая организация
        public OrgSchemeRef orgSchemeRef = new OrgSchemeRef();                       //Организация, в которую направляется пациент
        public string referralTypeIdCode { get; set; }                  //Тип направления
        public string bedProfileIdCode { get; set; }                    //Профиль койки
        public string referralTargetIdCode { get; set; }                //Цель направления
        public string surgProcIdCode { get; set; }                      //*Операция
        public string doctorPostId { get; set; }
        public string rehabilitationTypeIdCode { get; set; }            //*Тип реабилитации
        public DateTime ? outDate  { get; set; }                          //*Дата выписки для рабилитации
        public string cardNumber { get; set; }                          //*Номер карты пациента
        public List<DiagnosesList> diagnosesList  { get; set; }          //Список диагнозов
        public DateTime planDate  { get; set; }                        //Плановая дата госпитализации DateTime? myDate = null;
        public string bookingDateReserveId { get; set; }                //*Идентификатор зарезервированной плановой даты госпитализации
        public string additionalInformation { get; set; }               //*Дополнительная информация к направлению
        public VsmpData vsmpData { get; set; }                          //*Данные по направлению ВСМП
        public bool isValidatedRemainingCount { get; set; }             //*Признак того, что количество разрешенных услуг ВСМП закончилось, но пользователь все равно решил сохранить направление
        public bool isValidatedBedProfile { get; set; }                 //*Признак того, что профиль койки не соответствует возрасту пациента, но пользователь все равно решил сохранить направление (только в случае госпитализации подростка на десткий профиль койки)
        public List<ReferralsValidateException> referralsValidateExceptions  { get; set; } //*Идентифкаторы направлений, по которым не нужно выполнять проверку
        public int ? hospitalizationId { get; set; }                      //*Идентфиктор случая госптализации, на осонове которого делается напралвение на следующий этап
        public int ? referralBaseId { get; set; }                         //*Идентификатор направления, на основе которого создается данное направление (при типе направления "Направление в другой стационар по причине возникновения форс-мажорных обстоятельств")
        public string removalJustification { get; set; }                //*Обоснование снятия с листа учета напраления, на основе котрого создается данное направление
        public bool hasIndicationsForHospital { get; set; }             //*Имеет показания к госпитализации в круглосуточный стационар (при использовании диагноза, при котором рекомендовано лечение в дневном стационаре)
        public string inPatientHelpType { get; set; }                   //*
        public string dayHospitalAttach { get; set; }                   //*
        public string dayHospitalfuncstrId { get; set; }                    //*Идентификатор МО
        public List<File> files { get; set; }                              //*Прикрепленные к напралению файлы
        public List<RehabilitationFile> rehabilitationFiles { get; set; }    //*Прикрепленные к напралению файлы первого этапа реабилитации
        public string externalSystemCode { get; set; }                      //*Код внешних систем
        public bool isAccessVTMU { get; set; }                              //*Признак пройденной проверки операции (true - пользователь согласен сохранить, если операция отсутсвует в договоре или перелимит)
        public List<ReasonId> reasonIds  { get; set; }                       //*Прикрепленные к напралению файлы
        public string finSrcTypeIdCode { get; set; }                        //*Источник финансирования
        public string finSrcReserveId { get; set; }                            //*Идентификатор Источника финансирования
    }

    public class Patient
    {
        public bool isUnknowPatient { get; set; }                   // Признак неизвестного пациента ,
        public bool isAnonymouspatient { get; set; }                // Признак анонимного пациента ,
        public bool isHandMadePerson { get; set; }                  // Признак пациента ручника ,
        public bool isOrganized { get; set; }                       // Признак пациент организован ,
        public string organizedTypeIdCode { get; set; }             // *Тип учреждения организации пациента
        public string benefitTypeIdCode { get; set; }               // Категория льготности
        public string categoryCitizensIdCode { get; set; }          // Категория гражданства
        public string referenceTypeIdCode { get; set; }             // Житель город/село
        public string ageUnknownPatientsIdCode { get; set; }        // *Код возраста неизвестного ациента
        public long svaId { get; set; }                              // *Идентификатор организации прекрепления 2100000000000202
        public string note { get; set; }                            // *Дополнительная информация
        public string workPlace { get; set; }                       // *Место работы/Учебы
        public string parentWorkPlace { get; set; }                 // *Место работы родителей
        public int anonymousAreaId { get; set; }                    // *Регион анонима
        public DateTime ? organizedLastIncomeDate { get; set; }      // *Дата последнего посещения
        public string adressKz { get; set; }                        //*
        public string adressRu { get; set; }                        //*
        public int ? RPNApartmentID { get; set; }                     //*
        public int RPNBuildingID { get; set; }                      //*
        public int pAddressID { get; set; }                         //*
        public int addressTypeID { get; set; }                      //*
        public string kato { get; set; }                            //*
        public int ? arBuildingId { get; set; }                       //*
        public int ? arApartmentId { get; set; }                      //*
        public SelectedPatient selectedPatient { get; set; }          // Персонафицированные данные 
        public List<Phone> phones  { get; set; }                   // *Телефоны пациента
        public List<File> files  { get; set; }                     // *Скан. копия удостоверения личности
    }

    public class SelectedPatient
    {
        public int id { get; set; }                                 //*Идентифкатор физ. лица
        public DateTime birthDate { get; set; }                     //Дата рождения
        public long rpnID { get; set; }                              //*Идентификатор физ. лица (РПН)
        public int hGBD { get; set; }                               //*Запись ГБДФЛ
        public string personin { get; set; }                        //*ИИН
        public string lastName { get; set; }                        //Фамилия
        public string firstName { get; set; }                       //*Имя
        public string secondName { get; set; }                      //*Отчество
        public string sexIdCode { get; set; }                       //Код пола физ. лица
        public string nationalityIdCode { get; set; }               //*Код национальности
        public string citizenIdCode { get; set; }                   //*Код гражданства
    }

    public class Phone
    {
        public string phoneNumber { get; set; }                     //*Номер телефона
        public string phoneTypeIdCode { get; set; }                 //*Тип телефона
    }

    public class File
    {
        public string name { get; set; }                            // *Наименование файла
        public string file { get; set; }                            // *Файл закодированный в Base64

    }
    public class OrgSchemeDirect
    {
        public string orgHealthCareID { get; set; }                 //Идентификатор МО
        public string funcStructureOrgID { get; set; }              //*Идентификатор структурного подразделения (филиала)
        public int areaID { get; set; }                             //*Идентификатор региона МО
    }

    public class OrgSchemeRef
    {
        public string orgHealthCareID { get; set; }                 //Идентификатор МО
        public string funcStructureOrgID { get; set; }              //*Идентификатор структурного подразделения (филиала)
        public int areaID { get; set; }                             //*Идентификатор региона МО
    }

    public class DiagnosesList
    {
        public string sickIdCode { get; set; }                      //*Код диагноза
        public string sickName { get; set; }                        //*Наименование диагноза для передачи на клиента
        public string diagnosisTypeIdCode { get; set; }             //*Код вида диагноза
        public string diagnosisTypeName { get; set; }               //*Наименование вида диагноза
        public string diagTypeIdCode { get; set; }                  //*Код типа диагноза
        public string diagTypeName { get; set; }                    //*Наименование типа диагноза
        public string traumaTypeIdCode { get; set; }                //*Код типа травмы
        public string traumaTypeName { get; set; }                  //*Наименование типа травмы
    }

    public class VsmpData
    {
        public DateTime protocolDate { get; set; }                  //*Дата протокола
        public string protocolNumber { get; set; }                  //*Номер протокола
        public OrgSchemeRequest orgSchemeRequest { get; set; }      //*Организация, направившая на региональную комиссию
    }

    public class OrgSchemeRequest
    {
        public string orgHealthCareID { get; set; }                 //Идентификатор МО
        public string funcStructureOrgID { get; set; }              //*Идентификатор структурного подразделения (филиала)
        public int areaID { get; set; }                             //*Идентификатор региона МО
    }

    public class ReferralsValidateException
    {
        public int ID { get; set; }
    }

    public class RehabilitationFile
    {
        public string name { get; set; }                            // *Наименование файла
        public string file { get; set; }                            // *Файл закодированный в Base64
    }

    public class ReasonId
    {
        public int ID { get; set; }
    }


    // ==================================================  РПН  =================================================================
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

    public class DataBgo
    {

        public List<DataJsn> data {get;set;}
    }

    public class DataJsn
    {

        public string id {get;set;}
        public string name {get;set;}
    }
    //=============Установки===========================================================================================
    protected void Page_Load(object sender, EventArgs e)
    {
        //=====================================================================================
        BuxSid = (string)Session["BuxSid"];
        BuxFrm = (string)Session["BuxFrmKod"];
        BuxKod = (string)Session["BuxKod"];
        parBuxKod.Value = BuxKod;
        //       AmbCrdIdn = (string)Session["AmbCrdIdn"];
        AmbCrdIdn = Convert.ToString(Request.QueryString["AmbCrdIdn"]);
        //=====================================================================================

        sdsGrp.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsGrp.SelectCommand = "SELECT StrUslKey,StrUslNam FROM SprStrUsl WHERE StrUslLvl=1 ORDER BY StrUslNam";

        sdsNpr.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;
        sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM SprUsl ORDER BY UslNam";

        sdsTrf.ConnectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString; ;

        GridNap.InsertCommand += new Obout.Grid.Grid.EventHandler(InsertRecord);
        GridNap.DeleteCommand += new Obout.Grid.Grid.EventHandler(DeleteRecord);
        GridNap.UpdateCommand += new Obout.Grid.Grid.EventHandler(UpdateRecord);

        //=====================================================================================

        if (!Page.IsPostBack)
        {

        }

        getGrid();
        HidAmbCrdIdn.Value = AmbCrdIdn;

    }

    // ============================ чтение таблицы а оп ==============================================
    void getGrid()
    {
        string LenCol;
        KltIin = "";
        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbPrsIdn", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        // заполняем DataSet из хран.процедуры.
        da.Fill(ds, "HspAmbPrsIdn");

        if (ds.Tables[0].Rows.Count > 0)
        {
            KltIin = Convert.ToString(ds.Tables[0].Rows[0]["GRFIIN"]);
        }
        con.Close();

        GridNap.DataSource = ds;
        GridNap.DataBind();

    }
    // ======================================================================================

    void InsertRecord(object sender, GridRecordEventArgs e)
    {
        if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
        else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

        if (e.Record["PRSMEM"] == null | e.Record["PRSMEM"] == "") PrsMem = "";
        else PrsMem = Convert.ToString(e.Record["PRSMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbPrsAdd", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@PRSAMB", SqlDbType.Int, 4).Value = AmbCrdIdn;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSMEM", SqlDbType.VarChar).Value = PrsMem;

        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);

        if (e.Record["PRSUSL"] == null | e.Record["PRSUSL"] == "") PrsUsl = 0;
        else PrsUsl = Convert.ToInt32(e.Record["PRSUSL"]);

        if (e.Record["PRSMEM"] == null | e.Record["PRSMEM"] == "") PrsMem = "";
        else PrsMem = Convert.ToString(e.Record["PRSMEM"]);

        //------------       чтение уровней дерево
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbPrsRep", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@PRSIDN", SqlDbType.Int, 4).Value = PrsIdn;
        cmd.Parameters.Add("@BUXFRM", SqlDbType.Int, 4).Value = BuxFrm;
        cmd.Parameters.Add("@PRSTRF", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@PRSUSL", SqlDbType.Int, 4).Value = PrsUsl;
        cmd.Parameters.Add("@PRSMEM", SqlDbType.VarChar).Value = PrsMem;
        // создание команды
        cmd.ExecuteNonQuery();
        con.Close();


        getGrid();
    }

    void DeleteRecord(object sender, GridRecordEventArgs e)
    {
        PrsIdn = Convert.ToInt32(e.Record["PRSIDN"]);

        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();

        // создание команды
        SqlCommand cmd = new SqlCommand("DELETE FROM AMBPRS WHERE PRSIDN=" + PrsIdn, con);
        cmd.ExecuteNonQuery();
        con.Close();

        getGrid();
    }

    /*
        protected void PrtButton_Click(object sender, EventArgs e)
        {

            string TekDocIdnTxt = Convert.ToString(Session["GLVDOCIDN"]);
            int TekDocIdn = Convert.ToInt32(Session["GLVDOCIDN"]);
            // --------------  печать ----------------------------
            Response.Redirect("~/Report/DauaReports.aspx?ReportName=HspAmbPrs&TekDocIdn=" + AmbCrdIdn);
        }
    */

    protected void Detail_LoadingItems(object sender, ComboBoxLoadingItemsEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.Text))
        {
            sdsNpr.SelectParameters[0].DefaultValue = e.Text;
            //                sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM  SprUsl WHERE ISNULL(SprUsl.UslNap,0)=1 AND SprUsl.UslKey='" + 
            //                                        e.Text + "' " + "ORDER BY SprUsl.UslNam";
            sdsNpr.SelectCommand = "SELECT UslKod,UslNam FROM  SprUsl WHERE LEFT(SprUsl.UslKey,3)='" + e.Text + "' " + "ORDER BY SprUsl.UslNam";
        }
    }


    protected void SetRefferal_Click(object sender, EventArgs e)
    {
        // ******************************************************* Передать GRFIDN и получить XML ***************************************************************************
        // создание DataSet.
        DataSet ds = new DataSet();
        // строка соединение
        // ------------ удалить загрузку оператора ---------------------------------------
        string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        // создание соединение Connection
        SqlConnection con = new SqlConnection(connectionString);
        // создание команды
        SqlCommand cmd = new SqlCommand("UPDATE AMBPRS SET PRSEXPAPP=1,PRSEXPAPPDAT=GETDATE() WHERE PRSIDN=" + parPrsIdn.Value, con);
        // указать тип команды
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }

    protected void SetStaz_Click_Tst(object sender, EventArgs e)
    {
        ExecOnLoad("GetBgo('1','2');");

    }
    protected void SetStaz_Click(object sender, EventArgs e)
    {
        string baseAddress = "";

        // ====================================== ЗАПИСАТЬ НА ДНЕВНОЙ СТАЦИОНАР ===========================================================================================================
        DataSet ds = new DataSet();
        string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("HspAmbCrd_AmbStz", con);
        // указать тип команды
        cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;
        // создание команды
        cmd.ExecuteNonQuery();
        // con.Close();

        // ========================================================= ПОЛУЧИТЬ ЛИЧНЫЕ ДАННЫЕ ========================================================================================
        //------------       чтение уровней дерево
        //   KltIin = "980719301022";
        // KltIin = "680129300061";
        // KltIin = "800904400642";
        // KltIin = "980719301022";
        // KltIin = "830722300335";
        // KltIin = "860116302838";
        // KltIin = "810802301730";
        // KltIin = "780411400309";
        KltIin = "530103302492";

        DataSet dsKlt = new DataSet();
        //string connectionString = WebConfigurationManager.ConnectionStrings[MdbNam].ConnectionString;
        //SqlConnection con = new SqlConnection(connectionString);
        //con.Open();
        SqlCommand cmdKlt = new SqlCommand("SELECT TOP 1 * FROM SPRKLT WHERE KLTIIN='" + KltIin + "'", con);
        // указать тип команды
        // cmd.CommandType = CommandType.StoredProcedure;
        // передать параметр
        //cmd.Parameters.Add("@GLVDOCIDN", SqlDbType.VarChar).Value = AmbCrdIdn;

        // создание DataAdapter
        SqlDataAdapter daKlt = new SqlDataAdapter(cmdKlt);
        // заполняем DataSet из хран.процедуры.
        daKlt.Fill(dsKlt, "SprKlt");

        if (dsKlt.Tables[0].Rows.Count > 0)
        {
            //if (Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTSOZLGT"]) == "") KltLgt = "2700";
            //else KltLgt = "5800";
            KltLgt = "2700";
            KltCtyVil = "300";
            KltNum = Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTINV"]);
            if (string.IsNullOrEmpty(KltNum)) KltNum = "2156";
            KltAdr = Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTADROBL"]) + " " +
                    Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTADRPNK"]) + " " +
                    Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTADRSTR"]) + " " +
                    Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTADRDOM"]) + " " +
                    Convert.ToString(dsKlt.Tables[0].Rows[0]["KLTADRAPR"]);
            if (string.IsNullOrEmpty(KltAdr)) KltAdr = "ГОРОД РЕСП.ЗНАЧ.: Алматы , РАЙОН ВНУТРИ ГОРОДА:  , УЛИЦА:  , ДОМ: ";

        }
        //  con.Close();

        // ========================================================= ПОЛУЧИТЬ ТОКЕН РПН и БГ ========================================================================================
        string TokenBgo = "";
        string TokenRpn = "";

        DataSet dsTkn = new DataSet();
        // string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        // SqlConnection con = new SqlConnection(connectionString);
        //  con.Open();

        SqlCommand cmdTkn = new SqlCommand("SELECT TOP 1 * FROM TABTKN WHERE TKNFRM=" + BuxFrm, con);
        SqlDataAdapter daTkn = new SqlDataAdapter(cmdTkn);
        // заполняем DataSet из хран.процедуры.
        daTkn.Fill(dsTkn, "HspTkn");
        if (dsTkn.Tables[0].Rows.Count > 0)
        {
            TokenBgo = Convert.ToString(dsTkn.Tables[0].Rows[0]["TKNBGO"]);
            TokenRpn = Convert.ToString(dsTkn.Tables[0].Rows[0]["TKNRPN"]);
        }
        //   con.Close();

        // ============================================================ ОБРАТИТСЯ К API РПН ====================================================================================
        string apiUrl = "http://5.104.236.197:22999/services/api/Person?fioiin=" + KltIin + "& page=1&pagesize=10";
        using (WebClient client = new WebClient())
        {
            client.Headers.Add("Content-Type", "text");
            client.Headers[HttpRequestHeader.Authorization] = "Bearer " + TokenRpn;
            client.Encoding = Encoding.UTF8;
            HtmlResult = client.DownloadString(apiUrl);

            if (HtmlResult != "[]")
            {
                List<RPNobject> RPNobjects = new List<RPNobject>();

                RPNobjects = JsonConvert.DeserializeObject<List<RPNobject>>(HtmlResult);

                KltPrkIdn = RPNobjects[0].activeAttachment.orgHealthCare.originalID;
                KltAdrIdn = RPNobjects[0].LastAttachmentSV.personAddressesID;
                KltBrt = RPNobjects[0].birthDate;
                KltPrsIdn = RPNobjects[0].activeAttachment.PersonID;
                KltGbd = RPNobjects[0].hGBD;
                KltFam = RPNobjects[0].lastName;
                KltIma = RPNobjects[0].firstName;
                KltOtc = RPNobjects[0].secondName;
                if (KltIin.Substring(6, 1) == "1" || KltIin.Substring(6, 1) == "3" || KltIin.Substring(6, 1) == "5") KltSex = "300";
                else KltSex = "200";
                if (RPNobjects[0].national == "2") KltNat = "200";
                else KltNat = "200";
                if (RPNobjects[0].citizen == "1085") KltCit = "108500";
                else KltCit = "108500";
            }
        }

        // ===============================================================================================================

        Referral referral = new Referral();

        referral.patient.isUnknowPatient = false;                 // Признак неизвестного пациента ,
        referral.patient.isAnonymouspatient = false;                // Признак анонимного пациента ,
        referral.patient.isHandMadePerson = false;                 // Признак пациента ручника ,
        referral.patient.isOrganized = false;                       // Признак пациент организован ,
        referral.patient.organizedTypeIdCode = null;                // Признак пациент организован ,

        referral.patient.benefitTypeIdCode = KltLgt;                // Категория льготности спр 7 Нет льгот "2700";
        referral.patient.categoryCitizensIdCode = "100";            // Категория гражданства 9 Гражданин РК
        referral.patient.referenceTypeIdCode = KltCtyVil;           // Житель город/село  16 город "300"; 

        referral.patient.ageUnknownPatientsIdCode = null;           // Код возраста неизвестного ациента
        referral.patient.svaId = Convert.ToInt64(KltPrkIdn);        // Идентификатор организации прекрепления 
        referral.patient.note = null;                               // Дополнительная информация
        referral.patient.workPlace = null;                          // Место работы/Учебы 
        referral.patient.parentWorkPlace = null;                    // Место работы родителей
        referral.patient.anonymousAreaId = 0;                        // Регион анонима
        referral.patient.organizedLastIncomeDate = null;            // Дата последнего посещения
        referral.patient.adressKz = KltAdr;  // "РЕСП. МАҢЫЗЫ БАР ҚАЛАСЫ: Алматы , ҚАЛА IШIНДЕГI АУДАНЫ: Алмалинский , КӨШЕCI: Наурызбай батыра , ҮЙ: 104";
        referral.patient.adressRu = KltAdr;  // "ГОРОД РЕСП.ЗНАЧ.: Алматы , РАЙОН ВНУТРИ ГОРОДА: Алмалинский , УЛИЦА: Наурызбай батыра , ДОМ: 104";
        referral.patient.RPNApartmentID = null;                     //
        referral.patient.RPNBuildingID = 6888917;                   // ??
        referral.patient.pAddressID = Convert.ToInt32(KltAdrIdn);   // 61450879;                     //
        referral.patient.addressTypeID = 2;                         //??
        referral.patient.kato = "750000000";                        //??
        referral.patient.arBuildingId = null;                       //
        referral.patient.arApartmentId = null;                      //

        referral.patient.selectedPatient = new SelectedPatient();

        referral.patient.selectedPatient.id = 0;                    // Идентифкатор физ. лица
        referral.patient.selectedPatient.birthDate = Convert.ToDateTime(KltBrt);                     //Дата рождения

        referral.patient.selectedPatient.rpnID = Convert.ToInt64(KltPrsIdn);     // Идентификатор физ. лица (РПН) //417423186;       
        referral.patient.selectedPatient.hGBD = Convert.ToInt32(KltGbd);            // Запись ГБДФЛ //190001001; 
        referral.patient.selectedPatient.personin = KltIin;         // Дата рождения // "530103302492";
        referral.patient.selectedPatient.lastName = KltFam;          // Фамилия// "Туленов";
        referral.patient.selectedPatient.firstName = KltIma;         // Имя// "Кали";  
        referral.patient.selectedPatient.secondName = KltOtc;         // Отчество  // "";    
        referral.patient.selectedPatient.sexIdCode = KltSex;          // Код пола физ.лица  17 "300"; 
        referral.patient.selectedPatient.nationalityIdCode = KltNat;    // Код национальности 25 "200";
        referral.patient.selectedPatient.citizenIdCode = KltCit;    // Код гражданства 10 Казахстан "108500"; 

        referral.patient.phones = new List<Phone>();
        referral.patient.files = new List<File>();
        //List<File> files = new List<File>();                      // *Скан. копия удостоверения личности
        // Направляющая организация
        referral.orgSchemeDirect.orgHealthCareID = "2100000000000202";      //?? Направляющая организация . Идентификатор МО из СУРа
        referral.orgSchemeDirect.funcStructureOrgID = "";                   //?? Идентификатор структурного подразделения (филиала) 
        referral.orgSchemeDirect.areaID = 15;                               //?? Идентификатор региона МО из СУРа

        //Организация, в которую направляется пациент
        referral.orgSchemeRef.orgHealthCareID = "2100000000000202";      //?? Направляющая организация . Идентификатор МО из СУРа
        referral.orgSchemeRef.funcStructureOrgID = "";                   //?? Идентификатор структурного подразделения (филиала) 
        referral.orgSchemeRef.areaID = 15;                               //?? Идентификатор региона МО из СУРа

        referral.referralTypeIdCode = "1600";                //Тип направления 23 1600=Плановая госпитализация в ДС
        referral.bedProfileIdCode = null;                   //Профиль койки
        referral.referralTargetIdCode = "100";               //Цель направления 100 - Консервативное лечение
        referral.surgProcIdCode = null;                       // Операция
        referral.doctorPostId = "45500000001428495";          // 
        referral.rehabilitationTypeIdCode = null;             // Тип реабилитации
        referral.outDate = null;                              // Дата выписки для рабилитации 
        referral.cardNumber = KltNum;                           // Номер карты пациента "55"; 

        //   List<DiagnosesList> diagnosesLists = new List<DiagnosesList>();         //Список диагнозов
        referral.diagnosesList = new List<DiagnosesList>();
        //diagnosesLists.Add(new DiagnosesList
        //{
        referral.diagnosesList.Add(new DiagnosesList
        {
            sickIdCode = "I208",                     // Код диагноза
            sickName = "(I20.8)",                    // Наименование диагноза для передачи на клиента
            diagnosisTypeIdCode = "200",             // Код вида диагноза  Основное
            diagnosisTypeName = "Направительный",    // Наименование вида диагноза
            diagTypeIdCode = "200",                 // Код типа диагноза
            diagTypeName = "Основное",              // Наименование типа диагноза
            traumaTypeIdCode = null,                // Код типа травмы
            traumaTypeName = ""                     // Наименование типа травмы
        }
            );

        referral.planDate = Convert.ToDateTime("26.12.2019");       // Плановая дата госпитализации
        referral.bookingDateReserveId = null;                       // Идентификатор зарезервированной плановой даты госпитализации
        referral.additionalInformation = null;                      // Дополнительная информация к направлению
        referral.vsmpData = null;                                   // Данные по направлению ВСМП
        referral.isValidatedRemainingCount = false;                 // Признак того, что количество разрешенных услуг ВСМП закончилось, но пользователь все равно решил сохранить направление  
        referral.isValidatedBedProfile = false;                     // Признак того, что профиль койки не соответствует возрасту пациента, но пользователь все равно решил сохранить направление (только в случае госпитализации подростка на десткий профиль койки)

        //  List<ReferralsValidateException> referralsValidateExceptions = new List<ReferralsValidateException>(); //*Идентифкаторы направлений, по которым не нужно выполнять проверку

        referral.referralsValidateExceptions = new List<ReferralsValidateException>();     //*Идентифкаторы направлений, по которым не нужно выполнять проверку

        referral.referralBaseId = null;                             // Идентификатор направления, на основе которого создается данное направление (при типе направления "Направление в другой стационар по причине возникновения форс-мажорных обстоятельств") 
        referral.removalJustification = null;                       // Обоснование снятия с листа учета напраления, на основе котрого создается данное направление 
        referral.hasIndicationsForHospital = false;                 // Имеет показания к госпитализации в круглосуточный стационар (при использовании диагноза, при котором рекомендовано лечение в дневном стационаре)
        referral.inPatientHelpType = "DayHospital";                 // 
        referral.dayHospitalAttach = "100";                         // 
        referral.dayHospitalfuncstrId = "";                         // Идентификатор МО
                                                                    // referral.files":[],                                      // Прикрепленные к напралению файлы
                                                                    //referral.files.Add(new File  {});
        referral.files = new List<File>();

        //  List<RehabilitationFile> rehabilitationFiles = new List<RehabilitationFile>();   //*Прикрепленные к напралению файлы первого этапа реабилитации
        referral.rehabilitationFiles = new List<RehabilitationFile>();
        //  referral.rehabilitationFiles.Add(new RehabilitationFile  {});
        //referral.rehabilitationFiles":[],                         // Прикрепленные к напралению файлы первого этапа реабилитации
        referral.externalSystemCode = null;                         // Код внешних систем
        referral.isAccessVTMU = false;                              // Признак пройденной проверки операции (true - пользователь согласен сохранить, если операция отсутсвует в договоре или перелимит)
        referral.reasonIds = new List<ReasonId>();
        //  List<ReasonId> reasonIds = new List<ReasonId>();                       //*Прикрепленные к напралению файлы
        referral.finSrcTypeIdCode = "200";                          // Источник финансирования  19 Государственный
        referral.finSrcReserveId = null;                            // Идентификатор Источника финансирования

        string JsonTxt = Newtonsoft.Json.JsonConvert.SerializeObject(referral);

        //// ******************************************************* Передать GRFIDN и получить XML ЗАПИСАТЬ В БАЗУ ДАННЫХ ***************************************************************************
        //// создание DataSet.
        //DataSet dsExp = new DataSet();
        //// строка соединение
        //// ------------ удалить загрузку оператора ---------------------------------------
        //// string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
        //// создание соединение Connection
        //SqlConnection conExp = new SqlConnection(connectionString);
        //// создание команды
        //SqlCommand cmdExp = new SqlCommand("UPDATE AMBPRS SET PRSEXPAPP=1,PRSEXPAPPDAT=GETDATE(),PRSEXPJSN='"+ JsonTxt +"' WHERE PRSIDN=" + parPrsIdn.Value, con);
        //// указать тип команды
        //conExp.Open();
        //cmdExp.ExecuteNonQuery();
        //conExp.Close();

        // ******************************************************* ОБРАТИТСЯ К API БЮРО ГОСПИТАЛИЗАЦИИ ***************************************************************************
        ExecOnLoad("GetBgo('"+JsonTxt+"','"+TokenBgo+"');");
        // ******************************************************* ОБРАТИТСЯ К API БЮРО ГОСПИТАЛИЗАЦИИ ***************************************************************************

    }

    // =================================================================================================================================================
    [WebMethod]
    public static string ZapSablon(string AmbPrsIdn, string BuxKod)
    {

        if (!string.IsNullOrEmpty(AmbPrsIdn))
        {
            // ------------ удалить загрузку оператора ---------------------------------------
            string connectionString = WebConfigurationManager.ConnectionStrings["HOSPBASE"].ConnectionString;
            // создание соединение Connection
            SqlConnection con = new SqlConnection(connectionString);
            // создание команды
            con.Open();

            SqlCommand cmd = new SqlCommand("HspAmbSblNapAmbSbl", con);
            // указать тип команды
            cmd.CommandType = CommandType.StoredProcedure;
            // передать параметр
            cmd.Parameters.Add("@PRSIDN", SqlDbType.VarChar).Value = AmbPrsIdn;
            cmd.Parameters.Add("@BUXKOD", SqlDbType.VarChar).Value = BuxKod;
            // создание команды
            cmd.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        else
        {
            //          Otvet.Text = "Неверный пароль или входное имя";
            return "ERR";
        }
    }

</script>


<body>

    <form id="form1" runat="server">
        <%-- ============================  для передач значении  ============================================ --%>
        <asp:HiddenField ID="parMkbNum" runat="server" />
        <asp:HiddenField ID="parPrsIdn" runat="server" />
        <asp:HiddenField ID="parBuxKod" runat="server" />
        <asp:HiddenField ID="HidAmbCrdIdn" runat="server" />
        <%-- ============================  верхний блок  ============================================ --%>

        <%-- ============================  шапка экрана ============================================ --%>

        <asp:TextBox ID="Sapka"
            Text="НАПРАВЛЕНИЯ"
            BackColor="yellow"
            Font-Names="Verdana"
            Font-Size="12px"
            Font-Bold="True"
            ForeColor="Blue"
            Style="top: 0px; left: 0px; position: relative; width: 100%; text-align: center"
            runat="server"></asp:TextBox>


        <%-- ============================  средний блок  ============================================ --%>
        <asp:Panel ID="PanelMid" runat="server" BorderStyle="Double" ScrollBars="Vertical"
            Style="left: 0%; position: relative; top: 0px; width: 100%; height: 380px;">


            <%-- ============================  шапка экрана ============================================ --%>
            <obout:Grid ID="GridNap" runat="server"
                CallbackMode="true"
                Serialize="true"
                FolderStyle="~/Styles/Grid/style_11"
                AutoGenerateColumns="false"
                ShowTotalNumberOfPages="false"
                FolderLocalization="~/Localization"
                AllowAddingRecords="true"
                AllowRecordSelection="false"
                AllowSorting="false"
                Language="ru"
                PageSize="-1"
                AllowPaging="false"
                Width="100%"
                AllowPageSizeSelection="false"
                EnableTypeValidation="false"
                ShowColumnsFooter="true">
                <ClientSideEvents OnBeforeClientAdd="GridNap_ClientAdd" 
                                  ExposeSender="true" />
                <Columns>
                    <obout:Column ID="Column00" DataField="PRSIDN" HeaderText="Идн" Visible="false" Width="0%" />
                    <obout:Column ID="Column01" DataField="PRSUSL" HeaderText="Код" Width="0%" />
                    <obout:Column ID="Column02" DataField="PRSNUM" HeaderText="НОМЕР" Width="5%" ReadOnly="true" />
                    <obout:Column ID="Column03" DataField="PRSTRF" HeaderText="ТАРИФ" Width="7%" ReadOnly="true" />
                    <obout:Column ID="Column04" DataField="STXNAM" HeaderText="ВИД ОПЛ" ReadOnly="true" Width="6%" />
                    <obout:Column ID="Column05" DataField="PRSOBSTXT" HeaderText="НАПРАВЛЕНИЯ" Width="50%"  Align="left" Wrap="true" />
                    <obout:Column ID="Column06" DataField="ORGHSPNAMSHR" HeaderText="ГДЕ" Width="10%"  Align="left" ReadOnly="true"  ItemStyle-Font-Bold="true"/>
                    <obout:Column ID="Column07" HeaderText="Удаление" Width="4%" AllowEdit="false" AllowDelete="true" runat="server">
				           <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                    </obout:Column>	  

                    <obout:Column ID="Column08" DataField="PRTFLG" HeaderText="ВНУ" Width="4%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplatePrt" />
				    </obout:Column>	

                    <obout:Column ID="Column09" DataField="PRTFLGEXP" HeaderText="АПП" Width="4%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplatePrtExp" />
				    </obout:Column>	

                    <obout:Column ID="Column10" DataField="PRTFLGAPP" HeaderText="В АПП" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateAppExp" />
				    </obout:Column>	

                    <obout:Column ID="Column11" DataField="SBLFLG" HeaderText="ШАБЛОН" Width="5%" ReadOnly="true" >
				         <TemplateSettings TemplateId="TemplateSbl" />
				    </obout:Column>		
                </Columns>

                   <TemplateSettings NewRecord_TemplateId="addTemplate" NewRecord_EditTemplateId="saveTemplate" />
                   
                   <Templates>
                       <obout:GridTemplate runat="server" ID="editBtnTemplate">
                          <Template>
<%--                             <input type="button" id="btnEdit" class="tdTextSmall" value="Кор" onclick="GridNap.edit_record(this)"/>--%>
                             <input type="button" id="btnDelete" class="tdTextSmall" value="Удл" onclick="GridNap.delete_record(this)"/>
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="updateBtnTemplate">
                          <Template>
                             <input type="button" id="btnUpdate" value="Сохр" class="tdTextSmall" onclick="GridNap.update_record(this)"/> 
                             <input type="button" id="btnCancel" value="Отм" class="tdTextSmall" onclick="GridNap.cancel_edit(this)"/> 
                          </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="addTemplate">
                        <Template>
                            <input type="button" id="btnAddNew" class="tdTextSmall" value="Добавить" onclick="GridNap.addRecord()"/>
                        </Template>
                       </obout:GridTemplate>

                       <obout:GridTemplate runat="server" ID="saveTemplate">
                        <Template>
                            <input type="button" id="btnSave" value="Сохранить" class="tdTextSmall" onclick="GridNap.insertRecord()"/> 
                            <input type="button" id="btnCancel" value="Отмена" class="tdTextSmall" onclick="GridNap.cancelNewRecord()"/> 
                        </Template>
                      </obout:GridTemplate>	

                   <obout:GridTemplate runat="server" ID="TemplateSbl">
                       <Template>
                          <input type="button" id="btnSbl" class="tdTextSmall" value="Шаблон" onclick="GridPrs_sbl(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                   <obout:GridTemplate runat="server" ID="TemplatePrt">
                       <Template>
                          <input type="button" id="btnSbl" class="tdTextSmall" value="Печ" onclick="GridPrs_prt(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                   <obout:GridTemplate runat="server" ID="TemplatePrtExp">
                       <Template>
                          <input type="button" id="btnSblExp" class="tdTextSmall" value="Печ" onclick="GridPrs_prt_exp(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                   <obout:GridTemplate runat="server" ID="TemplateAppExp">
                       <Template>
                          <input type="button" id="btnAppExp" class="tdTextSmall" value="в АПП" onclick="GridPrs_app_exp(<%# Container.PageRecordIndex %>)"/>
 					   </Template>
                    </obout:GridTemplate>

                </Templates>
            </obout:Grid>
        </asp:Panel>
<%-- ============================  нижний блок   ExposeSender="true" ============================================ --%>
  <asp:Panel ID="PanelBot" runat="server" BorderStyle="Double" 
             Style="left: 0%; position: relative; top: 0px; width: 100%; height: 30px;">
             <center>
                 <input type="button" value="Печать направления по одному"  onclick="PrtButton_Click()" />
                 <input type="button" value="Печать направления"  onclick="PrtButtonAll_Click()" />
                 <input type="button" value="Шаблон направлении"   onclick="SablonPrs()" />
             </center>
  </asp:Panel> 
        
    <%-- ============================  для windowalert ============================================ --%>
    <owd:Window runat="server" StyleFolder="~/Styles/Window/wdstyles/default" EnableClientSideControl="true" />

      <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogAPP" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="НАПРАВЛЕНИЕ В ПС" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите отправить направления в ПС?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button3" Text="ОК" onclick="SetRefferal_Click" />
                              <input type="button" value="Отмена" onclick="myDialogAPP.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
      <%-- =================  диалоговое окно для подтверждения записи докуумента  ============================================ --%>
     <owd:Dialog ID="myDialogSTZ" runat="server" Height="180" StyleFolder="/Styles/Window/wdstyles/aura" Title="НАПРАВЛЕНИЕ В ДНЕВНОЙ СТАЦИОНАР" Width="300" IsModal="true">
            <br />
            <center>
                <table>
                    <tr>
                        <td>Хотите отправить направления в ДНЕВНОЙ СТАЦИОНАР ?</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                              <asp:Button runat="server" ID="Button1" Text="ОК" onclick="SetStaz_Click" />
<%--                             <input type="button" value="ОК" onclick="GetBgo();" />--%>
                            <input type="button" value="Отмена" onclick="myDialogSTZ.Close();" />
                        </td>
                    </tr>
                </table>  
            </center>      
        </owd:Dialog> 
       

    </form>

    <%-- ============================  STYLES ============================================ --%>

    <asp:SqlDataSource runat="server" ID="sdsTrf"  SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource> 
    <asp:SqlDataSource runat="server" ID="sdsGrp" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="sdsNpr" SelectCommand="" ConnectionString="" ProviderName="System.Data.SqlClient">
	    <SelectParameters>
	        <asp:Parameter Name="STRUSLKEY" Type="String" />
	    </SelectParameters>	    
    </asp:SqlDataSource>		
    <%-- ------------------------------------- для удаления отступов в GRID --------------------------------%>
    <style type="text/css">
      /* ------------------------------------- для разлиновки GRID --------------------------------*/
         .ob_gCS {display: block !important;}

       div.ob_gCc2, div.ob_gCc2C, div.ob_gCc2R {
            padding-left: 3px !important;
        }

        /*------------------------- для укрупнения шрифта GRID  --------------------------------*/
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            color: #000000;
            font-family: Tahoma;
            font-size: 12px;
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

        td.link {
            padding-left: 30px;
            width: 250px;
        }

        .style2 {
            width: 45px;
        }
    </style>

</body>
</html>



<%@ Page Language="C#" AutoEventWireup="true" %>


<!DOCTYPE html>
<meta charset="utf-8">
<title>Распознования речи</title>
<style>
    * {
        font-family: Verdana, Arial, sans-serif;
    }

    a:link {
        color: #000;
        text-decoration: none;
    }

    a:visited {
        color: #000;
    }

    a:hover {
        color: #33F;
    }

    .button {
        background: -webkit-linear-gradient(top,#008dfd 0,#0370ea 100%);
        border: 1px solid #076bd2;
        border-radius: 3px;
        color: #fff;
        display: none;
        font-size: 13px;
        font-weight: bold;
        line-height: 1.3;
        padding: 8px 25px;
        text-align: center;
        text-shadow: 1px 1px 1px #076bd2;
        letter-spacing: normal;
    }

    .center {
        padding: 10px;
        text-align: center;
    }

    .final {
        color: black;
        padding-right: 3px;
    }

    .interim {
        color: gray;
    }

    .info {
        font-size: 14px;
        text-align: center;
        color: #777;
        display: none;
    }

    .right {
        float: right;
    }

    .sidebyside {
        display: inline-block;
        width: 40%;
        min-height: 40px;
        text-align: left;
        vertical-align: top;
    }

    #headline {
        font-size: 40px;
        font-weight: 300;
    }

    #info {
        font-size: 20px;
        text-align: center;
        color: #777;
        visibility: hidden;
    }

    #results {
        font-size: 14px;
        font-weight: bold;
        border: 1px solid #ddd;
        padding: 15px;
        text-align: left;
        min-height: 200px;
    }

    #start_button {
        border: 0;
        background-color: transparent;
        padding: 0;
    }
</style>

<h1 class="center" id="headline">Голосовой блокнот</h1>

<div id="info">
    <p id="info_start">Кликни на микрофон чтобы начать диктовать.</p>
    <p id="info_speak_now">Диктуй!</p>
    <p id="info_no_speech"> Голос не обнаружен.</p>
    <p id="info_no_microphone" style="display: none"> Микрофон не найден.</p>
    <p id="info_allow">Нажмите кнопку "Разрешить" для использования микрофона.</p>
    <p id="info_denied">Разрешение на использование микрофона отсутствует.</p>
    <p id="info_blocked"> Permission to use microphone is blocked. To change,go to chrome://settings/contentExceptions#media-stream </p>
    <p id="info_upgrade">Ваш браузер не поддерживает Web Speech API.Обновите <a href="//www.google.com/chrome">Chrome</a>версий 25 или старше.</p>
</div>

 <div class="right">
    <button id="start_button" onclick="startButton(event)">
        <img id="start_img" src="/Icon/mic.gif" alt="Start"></button>
 </div>

 <div id="results">
    <span id="final_span" class="final"></span>
    <span id="interim_span" class="interim"></span>
    <p>
 </div>

 <div class="center">
    <div class="sidebyside" style="text-align: center">
        <input type="button" id="copy_button"  value="Копировать" onclick="copyButton();" />
    </div>

</div>

<script>
 
    showInfo('info_start');

    var final_transcript = '';
    var recognizing = false;                          // флаг идет ли распознование
    var ignore_onend;
    var start_timestamp;

    var QueryString = getQueryString();
    var ParTxt = QueryString[1];
    var ParBrw = QueryString[3];
    var TxtSap;

    //alert(ParTxt);
   //    alert(ParBrw);

    if (ParTxt == 'GrfJlb') TxtSap = 'ЖАЛОБА';
    if (ParTxt == 'GrfAnm') TxtSap = 'АНАМНЕЗ БОЛЕЗНИ';
    if (ParTxt == 'GrfAnmLif') TxtSap = 'АНАМНЕЗ ЖИЗНИ';
    if (ParTxt == 'GrfStt') TxtSap = 'СТАТУС ЛОКАЛИУС';
    if (ParTxt == 'GrfDig') TxtSap = 'ДИАГНОЗ';
    if (ParTxt == 'GrfDsp') TxtSap = 'ДИАГНОЗ ДОПОЛНИТЕЛЬНЫЙ';
    if (ParTxt == 'GrfLch') TxtSap = 'ПЛАН ЛЕЧЕНИЯ';
    if (ParTxt == 'GrfLch') TxtSap = 'ПЛАН ЛЕЧЕНИЯ';
    if (ParTxt == 'DryMem') TxtSap = 'ДНЕВНИК';
    if (ParTxt == 'StzEpi') TxtSap = 'ВЫПИСНОЙ ЭПИКРИЗ';
    if (ParTxt == 'GrfOps') TxtSap = 'ОПИСАНИЕ';
    if (ParTxt == 'GrfZak') TxtSap = 'ЗАКЛЮЧЕНИЯ';
    if (ParTxt == 'GrfRek') TxtSap = 'РЕКОМЕНДАЦИЙ';
    if (ParTxt.indexOf("NotePad") > -1) TxtSap = 'ГОЛОСОВОЙ БЛОКНОТ';


    document.getElementById('headline').innerHTML = TxtSap;
 //   info_sapka.innerHTML = ParTxt;

    // проверяем поддержку speach api
    if (!('webkitSpeechRecognition' in window)) {
        upgrade();
    }
    else   /* инициализируем api */
    {
        start_button.style.display = 'inline-block';
        var recognition = new webkitSpeechRecognition();  // создаем объект 	
        recognition.continuous = true;                    // не хотим чтобы когда пользователь прикратил говорить, распознование закончилось
        recognition.interimResults = true;                // хотим видеть промежуточные результаты. Т.е. мы можем некоторое время видеть слова, которые еще не были откорректированы

        /* метод вызывается когда начинается распознование */
        recognition.onstart = function ()
        {
            recognizing = true;
            showInfo('info_speak_now');
            start_img.src = '/Icon/mic-animate.gif';
        };

        /* обработчик ошибок */
        recognition.onerror = function (event)
        {
            if (event.error == 'no-speech') {
                start_img.src = '/Icon/mic.gif';
                showInfo('info_no_speech');
                ignore_onend = true;
            }
            if (event.error == 'audio-capture') {
                start_img.src = '/Icon/mic.gif';
                showInfo('info_no_microphone');
                ignore_onend = true;
            }
            if (event.error == 'not-allowed') {
                if (event.timeStamp - start_timestamp < 100) {
                    showInfo('info_blocked');
                } else {
                    showInfo('info_denied');
                }
                ignore_onend = true;
            }
        };

        /* метод вызывается когда распознование закончено */
        recognition.onend = function ()
        {
            recognizing = false;
            if (ignore_onend) {
                return;
            }
            start_img.src = '/Icon/mic.gif';
            if (!final_transcript) {
                showInfo('info_start');
                return;
            }
            showInfo('');
            if (window.getSelection) {
                window.getSelection().removeAllRanges();
                var range = document.createRange();
                range.selectNode(document.getElementById('final_span'));
                window.getSelection().addRange(range);
            }
        };

        /* 
         метод вызывается после каждой сказанной фразы. Параметра event используем атрибуты:
         - resultIndex - нижний индекс в результирующем массиве
         - results - массив всех результатов в текущей сессии
      */
        recognition.onresult = function (event) {
            var interim_transcript = '';

            /*   обход результирующего массива */
            for (var i = event.resultIndex; i < event.results.length; ++i) {

                /* если фраза финальная (уже откорректированная) сохраняем в конечный результат */
                if (event.results[i].isFinal)
                {
                    if (ParBrw == "Desktop") final_transcript += event.results[i][0].transcript;
                    else  final_transcript = event.results[i][0].transcript;
                }
                else              /* иначе сохраянем в промежуточный */
                {
                    if (ParBrw == "Desktop") interim_transcript += event.results[i][0].transcript;
                    else interim_transcript = event.results[i][0].transcript;
                }
            }
            final_transcript = capitalize(final_transcript);
            final_span.innerHTML = linebreak(final_transcript);
            interim_span.innerHTML = linebreak(interim_transcript);
            if (final_transcript || interim_transcript) {
                showButtons('inline-block');
            }
        };
    }

    function upgrade() {
        start_button.style.visibility = 'hidden';
        showInfo('info_upgrade');
    }

    var two_line = /\n\n/g;
    var one_line = /\n/g;
    function linebreak(s) {
        return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
    }

    var first_char = /\S/;
    function capitalize(s) {
        return s.replace(first_char, function (m) { return m.toUpperCase(); });
    }


    function copyButton() {
  //      alert("copyButton=" + ParTxt);
        if (recognizing) {
            recognizing = false;
            recognition.stop();
        }
  //      alert(final_span.innerHTML);

//        localStorage.setItem("FinTxt", final_span.innerHTML); //setter
        if (TxtSap == 'ГОЛОСОВОЙ БЛОКНОТ')
        {
            window.parent.WinClose(ParTxt + '@' + final_span.innerHTML);
        }
        else
        {
           window.opener.HandlePopupResult(ParTxt + '@' + final_span.innerHTML);
           self.close();
        }

     //   copy_button.style.display = 'none';
     //   copy_info.style.display = 'inline-block';
     //   showInfo('');
    }

    /* обработчик клика по микрофону */
    function startButton(event) {
        if (recognizing) {
            recognition.stop();
            return;
        }
        final_transcript = '';
        recognition.lang = 'ru';                      // язык, который будет распозноваться. Значение - lang code
        recognition.start();
        ignore_onend = false;
        final_span.innerHTML = '';
        interim_span.innerHTML = '';
        start_img.src = '/Icon/mic-slash.gif';
        showInfo('info_allow');
        showButtons('none');
        start_timestamp = event.timeStamp;
    }

    /* показ нужного сообщения */
    function showInfo(s) {
        if (s) {
            for (var child = info.firstChild; child; child = child.nextSibling) {
                if (child.style) {
                    child.style.display = child.id == s ? 'inline' : 'none';
                }
            }
            info.style.visibility = 'visible';
        } else {
            info.style.visibility = 'hidden';
        }
    }

    var current_style;

    function showButtons(style) {
        if (style == current_style) {
            return;
        }
        current_style = style;
        copy_button.style.display = style;
        copy_info.style.display = 'none';
    }


    //    ------------------ чтение переданного параметра ----------------------------------------------------------
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

</script>

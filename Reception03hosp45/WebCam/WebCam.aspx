<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html>
<head>
    <script src="/JS/jquery.webcam.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    
    <script src="/JS/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="/JS/jquery-ui-min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Styles/jquery-ui-blue.css" type="text/css" />


    <title>Sanp Photo</title>

          <style type="text/css">
           .booth-capture-button {
                display: block;
                margin:10px 0;
                padding:10px 20px;
                background-color:cornflowerblue;
                color:#fff;
                text-align:center;
                text-decoration:none;
            }
    </style>

    <script>
        var canvas, context, video, videoObj;

        $(function () {
            canvas = document.getElementById("canvas");
            context = canvas.getContext("2d");
            video = document.getElementById("video");

            /*
            navigator.mediaDevices.getUserMedia({ audio: false, video: true })
                .then(function (stream) {
                    var videoTracks = stream.getVideoTracks();
                    //    console.log('Got stream with constraints:', constraints);
                    //    console.log('Using video device: ' + videoTracks[0].label);
                    stream.onended = function () {
                        console.log('Stream ended');
                    };
                    window.stream = stream; // make variable available to console
                    video.srcObject = stream;
                    video.play();
                })
                .catch(function (error) {
                    alert(error.name + ": " + error.message);
                })

            */
           
            var p = navigator.mediaDevices.getUserMedia({ audio: false, video: true});

            p.then(function (mediaStream) {
                var video = document.querySelector('video');
                video.src = window.URL.createObjectURL(mediaStream);
                video.onloadedmetadata = function (e) {
                    // Do something with the video here.
                    video.play();

                };
            });
            
            p.catch(function (err) { alert(err.name); }); // always check for errors at the end.
           

           //  вариант 3
            /*
           navigator.getWebcam = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.moxGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
           if (navigator.mediaDevices.getUserMedia) {
             navigator.mediaDevices.getUserMedia({ audio: false, video: true })
                   .then(function (mediaStream) {
                       alert('1');
                       window.stream = mediaStream;
                       video.src = URL.createObjectURL(mediaStream);
                       video.play();
                   })
                   .catch(function (e) { logError(e.name + ": " + e.message); });
           }
           else {
               navigator.getWebcam({ audio: false, video: true },
                   function (mediaStream) {
                       alert('2');
                       window.stream = mediaStream;
                       video.src = URL.createObjectURL(mediaStream);
                       video.play();
                   },
                   function () { logError("Web cam is not accessible."); });
           }
            */


        /*

/*
        $(function ()
        {
            canvas = document.getElementById("canvas");
            context = canvas.getContext("2d");
            video = document.getElementById("video");
          
    //        alert('000');
            // different browsers provide getUserMedia() in differnt ways, so we need to consolidate 
            navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;

            if (navigator.getUserMedia)
            {
                navigator.getUserMedia
                   (
                  // Первый параметр - так называемые constraints, ограничения;
                    // в данном случае - предпочтительные параметры запрашиваемого потока:
                    {
                        audio: false,  // запрашиваем и аудио,...
                        video: true   // ...и видео
                    },
                    // Второй параметр - функция, вызываемая в случае успеха
                    function (stream)
                    {   // в качестве параметра передается объект LocalMediaStream
                        alert('000');
                             video.src = window.URL.createObjectURL(stream);
                             video.onloadedmetadata = function (e)
                              {
                               video.play();
                              };
                          },
                    // Третий параметр - функция, вызываемая в случае ошибки
                    function (error)
                     { // в качестве параметра передается объект с ошибкой
                          alert("The following error occured: " + err.name);
                       }
                   );
             } 
            else
               {
                alert("getUserMedia not supported");
              }
        */

        });

        function takePhoto() {
            context.drawImage(video, 0, 0, 640, 480);
        }

        function savePhoto() {
            var data = canvas.toDataURL();
            var title = $("#title").val();

            $.ajax({
                type: "POST",
                url: "WebCamSavePhoto.aspx",
                data: {
                    photo: data,
                    title: title
                }
            }).done(function (o) {
                alert("Photo Saved Successfully!");
            });
        }
    </script>
</head>
<body>
    <video id="video" width="320" height="240" autoplay="autoplay"  preload="auto"></video>
    <canvas style="float:right" id="canvas" width="320" height="240"></canvas>
    
    <button id="btnSnap" class="booth-capture-button" onclick="takePhoto()">Захват фото</button>
    <button id="btnSave" onclick="savePhoto()">Сохранить</button>

</body>
</html>

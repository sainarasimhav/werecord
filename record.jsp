<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<title>Record</title>
	<link rel="stylesheet" href="css/app.css">
</head>

<body>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Expires","0");
if(session.getAttribute("UserName")==null){
	response.sendRedirect("index.jsp");
}
%>
    <header>
<nav class="menu">
<table style="width:100%;">
<tr>
 <td> <a href="home.jsp" class="menu-index"><h1>Tickets booking</h1> </a></td>
   <td align="right"> <div class="links" >
  	<a  class="menu-about" ><%=session.getAttribute("UserName") %></a>
  </div></td></tr>
  </table>
</nav>
    </header>
    <main>
        <table style="width:100%;">
            <tr>
                <td><button id="btnStart">Start Recording</button><br /></td>
                <td><button id="btnStop">Stop Recording</button></td>
                <td><a class="foratag" href="#" id='downloadHere'>Download Here</a></td>
            </tr>
        </table>
        <video controls></video>

        <video id="vid2" controls></video>

        <!-- could save to canvas and do image manipulation and saving too -->
    </main>
    <script>

        let constraintObj = {
            audio: false,
            video: {
                facingMode: "user",
                width: { min: 640, ideal: 640, max: 1920 },
                height: { min: 480, ideal: 480, max: 1080 }
            }
        };
        // width: 1280, height: 720  -- preference only
        // facingMode: {exact: "user"}
        // facingMode: "environment"

        //handle older browsers that might implement getUserMedia in some way
        //start test
        // var getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
        // var cameraStream;

        // getUserMedia.call(navigator, {
        //     video: true,
        //     audio: true //optional
        // }, function (stream) {
        //     /*
        //     Here's where you handle the stream differently. Chrome needs to convert the stream
        //     to an object URL, but Firefox's stream already is one.
        //     */
        //     if (window.webkitURL) {
        //         video.src = window.webkitURL.createObjectURL(stream);
        //     } else {
        //         video.src = stream;
        //     }

        //     //save it for later
        //     cameraStream = stream;

        //     video.play();
        // });
        //end test
        if (navigator.mediaDevices === undefined) {
            navigator.mediaDevices = {};
            navigator.mediaDevices.getUserMedia = function (constraintObj) {
                let getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
                if (!getUserMedia) {
                    return Promise.reject(new Error('getUserMedia is not implemented in this browser'));
                }
                return new Promise(function (resolve, reject) {
                    getUserMedia.call(navigator, constraintObj, resolve, reject);
                });
            }
        } else {
            navigator.mediaDevices.enumerateDevices()
                .then(devices => {
                    devices.forEach(device => {
                        console.log(device.kind.toUpperCase(), device.label);
                        //, device.deviceId
                    })
                })
                .catch(err => {
                    console.log(err.name, err.message);
                })
        }

        navigator.mediaDevices.getUserMedia(constraintObj)
            .then(function (mediaStreamObj) {
                //connect the media stream to the first video element
                let video = document.querySelector('video');
                if ("srcObject" in video) {
                    video.srcObject = mediaStreamObj;
                } else {
                    //old version
                    video.src = window.URL.createObjectURL(mediaStreamObj);
                }

                video.onloadedmetadata = function (ev) {
                    //show in the video element what is being captured by the webcam
                    video.play();
                };

                //add listeners for saving video/audio
                let start = document.getElementById('btnStart');
                let stop = document.getElementById('btnStop');
                let vidSave = document.getElementById('vid2');
                let mediaRecorder = new MediaRecorder(mediaStreamObj);
                let chunks = [];

                start.addEventListener('click', (ev) => {
                    mediaRecorder.start();
                    console.log(mediaRecorder.state);
                })
                stop.addEventListener('click', (ev) => {
                    mediaRecorder.stop();
                    console.log(mediaRecorder.state);
                });
                mediaRecorder.ondataavailable = function (ev) {
                    chunks.push(ev.data);
                }
                mediaRecorder.onstop = (ev) => {
                    let blob = new Blob(chunks, { 'type': 'video/mp4;' });
                    chunks = [];
                    let videoURL = window.URL.createObjectURL(blob);
                    vidSave.src = videoURL;
                    var link = document.getElementById("downloadHere");
                    link.href = videoURL;
                    link.download = "aDefaultFileName.mp4";
                    upload(blob);
                }
            })
            .catch(function (err) {
                console.log(err.name, err.message);
            });
        function upload(blob) {
        	  var xhr = new XMLHttpRequest();
        	  xhr.open('POST', 'RecordWeb', true);
        	  xhr.onload = function(e) { console.log("loaded"); };
        	  xhr.onreadystatechange = function(){
        	      console.log("state: " + xhr.readyState);
        	  };
        	  xhr.upload.onprogress = function(e) { console.log("uploading..."); };
        	  xhr.setRequestHeader("Content-Type", "video/webm");
        	  xhr.send(blob);
        	}
    </script>
    <footer>
<div>
   <table style="width:100%;">
   <tr>
   <td><button type="button" onClick="history.back();">Back</button></td>
   <td><form action="home.jsp"><button type="submit">Home</button></form></td>
   <td><form action="index.jsp"><button type="submit">Logout</button></form></td>
	</tr></table>
</div></footer>
</body>

</html>
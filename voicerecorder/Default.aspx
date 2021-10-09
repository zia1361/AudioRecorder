<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="voicerecorder._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Getting started</h2>
            <p>
                ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
            A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <audio id="audioPlayer" style="display: none;"></audio>
        <button type="button" onclick="StartAudioRecording(this)">Start</button>
            </p>
        </div>
        
    </div>
    
    <script>
        var mediaRecorder;
        const sendAudioFile = file => {
            const formData = new FormData();
            formData.append('audio-file.mp3', file);
            return fetch('/api.ashx?methodname=audioUpload', {
                method: 'POST',
                body: formData
            });
        };
        function StartAudioRecording(element) {
            if (element.innerText == "Start") {
                element.innerText = "Stop";
                navigator.mediaDevices.getUserMedia({ audio: true })
                    .then(stream => {
                        mediaRecorder = new MediaRecorder(stream);
                        mediaRecorder.start();

                        const audioChunks = [];
                        mediaRecorder.addEventListener("dataavailable", event => {
                            audioChunks.push(event.data);
                        });

                        mediaRecorder.addEventListener("stop", () => {
                            
                            const audioBlob = new Blob(audioChunks, {
                                'type': 'audio/mp3'
                            });
                            sendAudioFile(audioBlob);
                            //const audioUrl = URL.createObjectURL(audioBlob);
                            //const audio = new Audio(audioUrl);
                            //audio.play();
                            mediaRecorder.stream.getAudioTracks().forEach(function (track) { track.stop(); });

                        });
                    });

            } else {
                element.innerText = "Start";
               
                mediaRecorder.stop();
            }
        }
    </script>
</asp:Content>

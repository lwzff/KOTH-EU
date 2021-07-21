// GESTION DU CURSEUR & TIPS
window.onload = function() 
{
    // CURSEUR
    let cursor = document.getElementById("cursor");
    cursor.style.left = event.pageX - cursor.width + 15;
    cursor.style.top = event.pageY - 6; 

    document.body.addEventListener("mousemove", function(event)
    {
            let cursor = document.getElementById("cursor");

            let x = event.pageX - cursor.width + 15;
            let y = event.pageY - 6;

            cursor.style.left = x;
            cursor.style.top = y;
            $("#cursor").fadeIn(750);
    });

    // TIPS
/*     (function() {
        var tips = $(".tip");
        var quoteIndex = -1;
        
        function showNextQuote() {
            if(quoteIndex != tips.length-1) {
                ++quoteIndex;
                tips.eq(quoteIndex % tips.length)
                    .fadeIn(1000)
                    .delay(5000)
                    .fadeOut(1000, showNextQuote);
            }
        }
        showNextQuote();
    
    })(); */
    (function() {
        var tips = $(".tip")
        var lasts = []
        function showNextQuote(){
            let last = Math.floor(Math.random() * Math.floor(tips.length))
            while(lasts.includes(last)){
                last = Math.floor(Math.random() * Math.floor(tips.length))
                if(lasts.length + tips.length == tips.length * 2) return
            }
            lasts.push(last)
            tips.eq(last)
                .fadeIn(1000)
                .delay(4500)
                .fadeOut(1000, showNextQuote)
        }
        showNextQuote()
    })()
}

$(function() {
    $("#music-player").prop("volume", 0.10);
});

// FONCTION POUR RENDRE MUETTE LA MUSIQUE
function muteMusic() {
    let musicplayer = document.getElementById('music-player');
    musicplayer.muted = !(musicplayer.muted);

    if(musicplayer.muted) {
        document.getElementById('volume-img').setAttribute("src", "./img/mute.png");
        $("#volume-bar").width("0");
    } else {
        document.getElementById('volume-img').setAttribute("src", "./img/unmute.png");
        $("#volume-bar").width($('#music-player').prop("volume")*100 + "%");
    }
}

$("#volume-meter").click(function(e) {
    var posX = e.pageX - this.offsetLeft;
    let totalWidth = $("#volume-meter").width();
    let percent = (posX/totalWidth)*100;
    if (percent > 96) 
        percent = 96
    $("#volume-bar").width(percent + "%");
    $('#music-player').prop("volume", percent/100);
}); 

/* // PNL MODE
let unlockPNL = 0;

$(document).on('keyup',function(evt) {
    if (evt.keyCode == 80 && unlockPNL == 0) {
       unlockPNL++;
    } else if(evt.keyCode == 78 && unlockPNL == 1) {
        unlockPNL++;
    } else if(evt.keyCode == 76 && unlockPNL == 2) {
        unlockPNL++;
    }

    if(unlockPNL == 3) {
        $("#pnlmode").fadeIn(500);
    }
}); */

/* function enablePNL(x) {
    let a = document.getElementById('music-player')
    let y = document.getElementById('src');
    let b = document.getElementById("pnlmode");
    let c = document.getElementById("color-layer");
    let p = document.getElementsByClassName("progress")[0];
    let g = document.getElementById("logoimg");
    let v = document.getElementById("bg-video");

    if(x) {
        y.src = "./medias/pnlmode.mp3";
        a.load();
        a.play();
        b.setAttribute("onclick", "enablePNL(false)");
        b.setAttribute("src", "./img/qlf.png");
        c.style.setProperty("background", "linear-gradient(to top, #0075b587,#da6b9796)");
        p.style.setProperty("background", "linear-gradient(to right, #00a5ff, #ff5b9c)");
    } else {
        y.src = "./medias/music.ogg";
        a.load();
        a.play();
        b.setAttribute("onclick", "enablePNL(true)");
        b.setAttribute("src", "./img/qlf.png");
        c.style.setProperty("background", "")
        p.style.setProperty("background", "")
    }
    v.pause();
    v.currentTime = 0;
    v.play();
} */

// GESTION DE LA BARRE DE CHARGEMENT
let count = 0;
let thisCount = 0;
let step = 0;

const handlers = {
    startInitFunctionOrder(data)
    {
        count = data.count;
        step++;
    },

    initFunctionInvoking(data)
    {
        document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width = ((data.idx / count) * 100) + '%';
    },

    startDataFileEntries(data)
    {
        count = data.count;
    },

    performMapLoadFunction(data)
    {
        thisCount++;
        document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width = ((thisCount / count) * 100) + '%';
    },

    onLogLine(data)
    {
        document.querySelector('.progress').style.width = '100%';
        document.querySelector('.progress').style.backgroundColor = '#56EB45';
        document.querySelector('.progress').style.boxShadow = '0px 0px 10px #56EB45';
    }
};

window.addEventListener('message', function(e)
{
    (handlers[e.data.eventName] || function() {})(e.data);
});
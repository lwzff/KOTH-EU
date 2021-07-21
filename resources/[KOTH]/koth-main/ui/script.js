var audioPlayer = null;

function closePanel(panel) {
    if (document.getElementById(panel).style.display == "block") {
        document.getElementById(panel).classList.add('animate__animated', 'animate__bounceOutUp');
        document.getElementById(panel).addEventListener('animationend', () => {
            document.getElementById(panel).style.display = "none";
            document.getElementById(panel).classList.remove('animate__animated', 'animate__bounceOutUp');
        }, {
            once: true
        });
    }
}

function openPanel(panel) {
    if (document.getElementById(panel).style.display == "none") {
        document.getElementById(panel).classList.add('animate__animated', 'animate__bounceInDown');
        document.getElementById(panel).style.display = "block";
        document.getElementById(panel).addEventListener('animationend', () => {
            document.getElementById(panel).classList.remove('animate__animated', 'animate__bounceInDown');
        }, {
            once: true
        });
    } else {
        closePanel(panel);
    }
}

function playGame(team, elem) {
    if (!elem.classList.contains("disabled")) {
        fetch('https://koth-main/selectTeam', {
            method: "POST",
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                selectedTeam: team
            })
        })
        .then(() => fetch('https://koth-ui/AtlantissKOTH:UI:SendNUIMessage', {
            method: "POST",
            body: JSON.stringify({eventName: "selectTeam"})
        }))
        .catch(console.error)
    }
}

function resetTeamSelect(elem, text) {
    document.getElementById(elem).classList.remove("disabled");
    document.getElementById(elem).removeAttribute('style');
    document.getElementById(elem).innerHTML = text;
}

let Data;
let user 

window.addEventListener('message', (event) => {
    let data = event.data


    Data = data

    if ( data.user ) { user = data.user };


    if (data.type == 'show') {
        document.body.style.display = "block";
        document.getElementById("redbtn").innerHTML = data.one;
        document.getElementById("greenbtn").innerHTML = data.two;
        document.getElementById("bluebtn").innerHTML = data.three;
        document.getElementById("bg-music").play();
    } else if (data.type == 'hide') {
        document.body.style.display = "none";
        document.getElementById("bg-music").pause();
    } else if (data.type == 'teamfull') {
        if (data.fullteam == 1) {
            document.getElementById("redbtn").classList.add("disabled");
            document.getElementById("redbtn").style.color = "#888";
            document.getElementById("redbtn").style.backgroundColor = "transparent";
            var originalText = document.getElementById("redbtn").innerHTML;
            document.getElementById("redbtn").innerHTML = "Team Full"
            setTimeout(function() {
                resetTeamSelect("redbtn", originalText)
            }, 10000)
        } else if (data.fullteam == 2) {
            document.getElementById("bluebtn").classList.add("disabled");
            document.getElementById("bluebtn").style.color = "#888";
            document.getElementById("bluebtn").style.backgroundColor = "transparent";
            var originalText = document.getElementById("bluebtn").innerHTML;
            document.getElementById("bluebtn").innerHTML = "Team Full"
            setTimeout(function() {
                resetTeamSelect("bluebtn", originalText)
            }, 10000)
        } else if (data.fullteam == 3) {
            document.getElementById("greenbtn").classList.add("disabled");
            document.getElementById("greenbtn").style.color = "#888";
            document.getElementById("greenbtn").style.backgroundColor = "transparent";
            var originalText = document.getElementById("greenbtn").innerHTML;
            document.getElementById("greenbtn").innerHTML = "Team Full"
            setTimeout(function() {
                resetTeamSelect("greenbtn", originalText)
            }, 10000)
        }
    }
})
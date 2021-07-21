let timeRealod;
let FeedCleaner
let interval;
let inv = [];
let name;
let count = 0;
let tempEvent = []

function GetName(str) {
    return str.slice(0, 20)
}

window.addEventListener('message', (event) => {
    let data = event.data

    if (document.querySelector('#weapon3').style.display == "flex" && data.startCooldown) {
        let CD = data.startCooldown / 1000
        const el = document.createElement('div')
        el.style = "font-size: 2.5vh;color: red;position: absolute;top: -8.5vh;right: 6.5vh;transform: skewY(4deg);"
        el.id = "medkitCD"
        el.innerHTML = `${CD}s`
        document.querySelector('.bag').append(el)
        const interval = setInterval(() => {
            CD --
            el.innerHTML = `${CD}s`
            if (CD <= 0) {
                document.querySelector('#medkitCD').remove()
                clearInterval(interval)
            }
        }, 1000)
    }

    let playerLife = data.life - 100;
    document.querySelector('#life').style.width = `${playerLife}%`;;

    let reload = document.querySelector('#reload');
    let weaponReload = data.reload;
    if (weaponReload) {
        reload.style.display = 'flex';
        timeRealod = setTimeout(() => {
            reload.style.display = 'none';
        }, 2000);
    };

    let hud = document.querySelector('#hud');
    let HudOn = data.hud;
    if (HudOn) {
        //hud.style.display = 'flex';
        hud.style.display = 'none';
    };

    let hudd = document.querySelector('#hud');
    let HudOff = data.huds;
    if (HudOff) {
        hudd.style.display = 'flex';
        //hudd.style.display = 'none';
    };


    try {
        data.player.name ? document.querySelector('#player').innerHTML = GetName(data.player.name) : ''
        document.querySelector('#money').innerHTML = data.player.money;
        document.querySelector('#xp').innerHTML = data.player.xp;
        document.querySelector('#xp2').innerHTML = data.player.nextExp;
        document.querySelector('#from').innerHTML = data.player.lvl;
        document.querySelector('#to').innerHTML = data.player.lvls;
        
        document.querySelector('#mana').style.width = data.player.progress;               
    } catch {}

    let teams = data.teams;
    if (teams) {
        teams.map(t => {
            if (t.color == 'red') {
                document.getElementById('redplayers').innerHTML = t.players;
                document.getElementById('redpoint').innerHTML = t.point;
                document.getElementById('redtarget').innerHTML = t.target;
            };
            if (t.color == 'blue') {
                document.getElementById('blueplayers').innerHTML = t.players;
                document.getElementById('bluepoint').innerHTML = t.point;
                document.getElementById('bluetarget').innerHTML = t.target;
            };
            if (t.color == 'green') {
                document.getElementById('greenplayers').innerHTML = t.players;
                document.getElementById('greenpoint').innerHTML = t.point;
                document.getElementById('greentarget').innerHTML = t.target;
            };
        });
    }

    
    if ( data.equiped && data.equiped != false && data.equiped != "false" ) {
        // document.querySelector('#equiped').classList.remove('remove');
        document.querySelector("#equiped").style.display = "flex";
        document.querySelector("#equipedWepon").innerHTML = `<img  src="hud/equiped/${data.equiped}.png">`;
        document.querySelector('#ammo').innerHTML = data.ammo ? data.ammo : "0";
    };

    if ( data.equiped == "false" ) {
        document.querySelector("#equipedWepon").innerHTML = "";
    };

    if ( data.weapon1 && data.weapon1 != false && data.weapon1 != "false" ) {
        document.querySelector('#weapon1').classList.remove('remove');
        document.querySelector('#weapon1').style.display = "flex"; 
        document.querySelector('#weapon1').innerHTML = `<img  src="hud/equiped/${data.weapon1}.png">`;
    };

    if ( data.weapon1 == "false" )  {
        document.querySelector("#weapon1").innerHTML = ""; 
        document.querySelector("#weapon1").style.display = "none";
        document.querySelector('#weapon1').classList.add('remove');
    }

    if ( data.weapon2 && data.weapon2 != false && data.weapon2 != "false" ) {
        document.querySelector('#weapon2').classList.remove('remove');
        document.querySelector('#weapon2').style.display = "flex"; 
        document.querySelector('#weapon2').innerHTML = `<img  src="hud/equiped/${data.weapon2}.png">`;
    };

    if ( data.weapon2 == "false" )  {
        document.querySelector("#weapon2").innerHTML = ""; 
        document.querySelector("#weapon2").style.display = "none";
        document.querySelector('#weapon2').classList.add('remove');
    }

    if ( data.weapon3 && data.weapon3 != false && data.weapon3 != "false" ) {
        document.querySelector('#weapon3').classList.remove('remove');
        document.querySelector('#weapon3').style.display = "flex";
        document.querySelector('#weapon3').innerHTML =`<img  src="hud/equiped/${data.weapon3}.png">`;
    }

    if ( data.weapon3 == "false" )  {
        document.querySelector("#weapon3").innerHTML = ""; 
        document.querySelector("#weapon3").style.display = "none";
        document.querySelector('#weapon3').classList.add('remove');
    }

    var rightNotifications = []
    var rightNotificationss = []
    function closeRight() {
        rightNotifications.shift();
        document.getElementById("xpright").classList.add('animate__animated', 'animate__zoomOutRight');
        document.getElementById("xpright").classList.remove('animate__animated', 'animate__zoomOutRight');
        document.getElementById("xpright").style.display = "none";
        displayNextRightNotification();
    };

    function closeRights() {
        rightNotificationss.shift();
        document.getElementById("xpcenter").classList.add('animate__animated', 'animate__zoomOutRight');
        document.getElementById("xpcenter").classList.remove('animate__animated', 'animate__zoomOutRight');
        document.getElementById("xpcenter").style.display = "none";
        displayNextRightNotifications();
    };


    
    function displayNextRightNotification() {
        if (document.getElementById("xpright").style.display == "none") {
            if (rightNotifications.length > 0) {
                
                if (rightNotifications[0][1] == null || rightNotifications[0][2] == null) {
                    document.getElementById("xpright_top").style.color = "#2282e3";
                    document.getElementById("xpright_bottom").style.display = "none";
                    document.getElementById("xpright_top").innerHTML = rightNotifications[0][0];
                } else {
                    if (rightNotifications[0][2] == "0") {
                        document.getElementById("xpright_bottom").style.display = "none";
                    } else {
                        document.getElementById("xpright_bottom").style.display = "block";
                    }
                    document.getElementById("xpright_top").style.color = "#39b425";
                    document.getElementById("xpright_top").innerHTML = "+ $"+rightNotifications[0][1]+" "+rightNotifications[0][0];
                    document.getElementById("xpright_bottom").innerHTML = "+ "+rightNotifications[0][2]+" xp";
                }
                document.getElementById("xpright").style.display = "block";
                document.getElementById("xpright").classList.add('animate__animated', 'animate__zoomInLeft');
                setTimeout(closeRight,  5000);
            };
        };
    };
    function displayNextRightNotifications() {
        if (document.getElementById("xpcenter").style.display == "none") {
            if (rightNotificationss.length > 0) {
                
                if (rightNotificationss[0][1] == null || rightNotificationss[0][2] == null) {
                    document.getElementById("xpcenter_top").style.color = "#D92E00";
                    document.getElementById("xpcenter_bottom").style.display = "none";
                    document.getElementById("xpcenter_top").innerHTML = rightNotificationss[0][0];
                } else {
                    if (rightNotificationss[0][2] == "0") {
                        document.getElementById("xpcenter_bottom").style.display = "none";
                    } else {
                        document.getElementById("xpcenter_bottom").style.display = "block";
                    }
                    document.getElementById("xpcenter_top").style.color = "#D92E00";
                    document.getElementById("xpcenter_top").innerHTML = ""+rightNotificationss[0][0];
                }
                document.getElementById("xpcenter").style.display = "block";
                document.getElementById("xpcenter").classList.add('animate__animated', 'animate__zoomInLeft');
                setTimeout(closeRights,  5000);
            };
        };
    };

    function newRightNotification(money, exp, reason) {
        rightNotifications.push([reason, money, exp])
        if (rightNotifications.length === 1) {
            displayNextRightNotification();
        };
    };

    function newRightNotifications(reason) {
        rightNotificationss.push([reason])
        if (rightNotificationss.length === 1) {
            displayNextRightNotifications();
        };
    };

    if (data.type == 'right') {
        newRightNotification(data.notif_money, data.notif_exp, data.notif_reason);
    };
    if (data.type == 'center') {
        newRightNotifications(data.notif_reasons);
    };

    if (data.killer, data.killed, data.weaponkill, data.ca, data.cv) {
        newEvent(data.killer, data.killed, data.weaponkill, data.ca, data.cv);
        if (data.headshot) newEvent(data.killer, data.killed, data.weaponkill, data.ca, data.cv, data.headshot);
    };

    function newEvent(killer, victim, weapon, colora, colorv, headshot) {

        if (count <= 3) {
            createEvent(killer, victim, weapon, colora, colorv, headshot);
        }
        else {
            !headshot ? tempEvent.push({killer, victim, weapon, colora, colorv}) : tempEvent.push({killer, victim, weapon, colora, colorv, headshot});
            tempEvent.map(ev => {
                setTimeout(() => {
                    console.log(ev.killer)
                    !ev.headshot ? createEvent(ev.killer, ev.victim, ev.weapon, ev.colora, ev.colorv) : createEvent(ev.killer, ev.victim, ev.weapon, ev.colora, ev.colorv, ev.headshot)
                }, 10000);
            });
        };
        // console.log(JSON.stringify("New" + tempEvent))
    };

    function closeEvent() {
        tempEvent.shift();
        // console.log(JSON.stringify("Close" + tempEvent))
        document.getElementById("event-" + count).remove();
        count--
    };

    function createEvent(killerr, victimm, weaponn, colora, colorv, headshott) {
        count++
        
        let fillkill = document.getElementById('killevent');
        let event = document.createElement('div');
        event.id = "event-" + count;
        event.classList.add('event');
            
        let killer = document.createElement('span');
        killer.classList.add(colora);
        killer.id = 'killer';
        killer.innerHTML = killerr;

        let content = document.createElement("div");
        content.classList.add('weapon');

        let weapon = document.createElement('img');
        weapon.src = `./hud/equiped/${weaponn}.png`;

        let victim = document.createElement('span');
        victim.classList.add(colorv);
        victim.id = 'killed';
        victim.innerHTML = victimm; 

        if (headshott) {
            let headshot = document.createElement('img');
            headshot.src = `./hud/headshot.png`;

            return content.appendChild(headshott);
        }; 

        content.appendChild(weapon);

        event.appendChild(killer);
        event.appendChild(content);
        event.appendChild(victim);

        fillkill.appendChild(event);

        setTimeout(() => { closeEvent() }, 5000);
    };
});
clearTimeout(interval);
clearTimeout(timeRealod);
clearTimeout(FeedCleaner)

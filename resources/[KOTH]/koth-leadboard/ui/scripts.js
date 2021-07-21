    let ranks = [
        {id : 1 },
        {id : 2 },
        {id : 3 },
        {id : 4 },
        {id : 5 },
        {id : 6 },
        {id : 7 },
        {id : 8 },
        {id : 9 },
        {id : 10},
        {id : 11},
        {id : 12},
        {id : 13},
        {id : 14}
    ]
    window.addEventListener('message', e => {
        let data = e.data;
        //let stats = data.stats;
        //let ranks = data.rank
    
        let view = document.getElementById('view');
        if (data.type == 'close') {
            //view.innerHTML = '';
            view.style = 'display: none';
            //$.post('http://koth-leadboard/close', JSON.stringify({ close: true }));
        }
        if (data.type == 'open') {
            //player = data.players
            view.style = 'display = flex';
        }
    
        if (data.players) {
                if (data.update) updateLeaderboard(data.players);
            else initLeaderboard(data.players);
        }
    
        // if (data.stats) {
        //     console.log(JSON.stringify(data.stats))
        //     data.stats.map(stat => {
        //         document.querySelector('#name').innerHTML = stat.name;
        //         document.querySelector('#kills').innerHTML = `<i class="fas fa-crosshairs"></i> ` + stat.kills;
        //         document.querySelector('#death').innerHTML = `<i class="fas fa-skull"></i> ` + stat.death;
        //         document.querySelector('#money').innerHTML =  `<i class="fas fa-dollar-sign"></i> ` + stat.money;
        //         document.querySelector('#xp').innerHTML = `<i class="fas fa-fire-alt"></i> ` + stat.xp;
        //     });
        // };
    });
    
    function initLeaderboard(players) {
        let playerlist = document.querySelector('#playerslist');
    
        let cards = document.createElement('div');
        cards.id = 'cards';
    
        players.map(player => {
            let card = document.createElement('div');
            card.classList.add("player", player.team);
    
            card.innerHTML = `<span id="name">${player.name}</span>
            <span id="score">${player.score}</span>
            <span id="kills">${player.kill}</span>
            <span id="assist">${player.assist}</span>
            <span id="death">${player.death}</span>`;
    
            cards.appendChild(card);
            playerlist.appendChild(cards);
        });
    };
    
    function updateLeaderboard(players) {
        try { document.querySelector('#cards').remove(); } catch {}
    
        let playerlist = document.querySelector('#playerslist');
    
        let cards = document.createElement('div');
        cards.id = 'cards';
    
        players.map(player => {
            let card = document.createElement('div');
            card.classList.add("player", player.team);
    
            card.innerHTML = `<span id="name">${player.name}</span>
            <span id="score">${player.score}</span>
            <span id="kills">${player.kill}</span>
            <span id="assist">${player.assist}</span>
            <span id="death">${player.death}</span>`;
    
            cards.appendChild(card);
            playerlist.appendChild(cards);
        });
    };
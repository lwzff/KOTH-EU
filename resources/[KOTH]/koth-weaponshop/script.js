let _cat = [
    // Weapon
    { name: 'infantry', thumb: 'INFANTRY.PNG', lvl: "1", cat: 'weapon' },
    { name: 'medic', thumb: 'MEDIC.PNG', lvl: "7", cat: 'weapon' },
    { name: 'explosives', thumb: 'EXPLOSIVES.PNG', lvl: "20", cat: 'weapon' },
    { name: 'support', thumb: 'SUPPORT.PNG', lvl: "27", cat: 'weapon' },
    { name: 'marksmamb', thumb: 'MARKSMAMB.PNG', lvl: "50", cat: 'weapon' },

    // Vehicule
    { name: 'Ground', thumb: 'INTRO_VEHICLE.PNG', lvl: "1", cat: 'vehicule' },
    { name: 'Air', thumb: 'INTRO2_VEHICLE.PNG', lvl: "15", cat: 'vehicule' },
];

let _purshace = ["4"];
let classs;

window.addEventListener('message', e => {
  let view = document.getElementById('view');
  let data = e.data;

  let cats = [];
  let items = [];
  let owned = [];
  // let loadout = [];

  switch (data.type) {
      case "vehicule":
          _cat.map(el => {
              if (el.cat != data.type) return;
              cats.push(el);
          });
          data.items.map(el => {
              if (el.cat != data.type) return;
              items.push(el);
          });
          data.owned.map(el => {
            //console.log(el)
              owned.push(el);
          });
          data.player.map(el => {
              home(el.lvl, owned, cats, items, _purshace, el.money);
          });
          break;
      case "weapon":
          _cat.map(el => {
              if (el.cat != data.type) return;
              cats.push(el);
          });
          data.items.map(el => {
              if (el.cat != data.type) return;
              items.push(el);
          });
          data.owned.map(el => {
            //console.log(el)
              owned.push(el);
          });
          // data.loadout.map(el => {

          // });
          data.player.map(el => {
              // Sys de mort loadout

              home(el.lvl, owned, cats, items, _purshace, el.money);
          });
          break;
      case "close":
        view.style = 'display: none';
      break;
      default:
          break;
  };
  function home(lvl, owned, cats, items, purshace, money, loadout, team) {
      
      function main(lvl, owned, cats, items, purshace, money, loadout, team) {
          // Clear du view
          view.innerHTML = '';
          view.style = 'display: flex';

          // Création header
          let header = document.createElement('header');
          header.innerHTML = `<div id="title" class="title"><p><i class="fas fa-shopping-cart"></i> </p></div>`;

          closebtn = document.createElement('button');
          closebtn.id = 'closebtn';
          closebtn.innerHTML = '<i class="fas fa-times"></i>';
          header.appendChild(closebtn);

          // Création du cart
          let cart = document.createElement('section');
          cart.classList.add('shop');
          cart.id = 'cart';

          cart.innerHTML = `<div id="logo" style="background-image: url('content/logo.png');"></div>`;

          // Branchement des éléments
          view.appendChild(cart);
          view.append(header);

          if (loadout) {
              purshace = [];
              dead(loadout);
          };

          closeHud(closebtn);

          return setupClasses(lvl, owned, cats, items, purshace, money, team);
      };

      function dead(loadout) {
          cart.innerHTML = '';

          let primary = document.createElement('div');
          primary.id = 'primary';
          primary.innerHTML = `<div class="item">primary</div>`;

          cart.append(primary);

          let secondary = document.createElement('div');
          secondary.id = 'secondary';
          secondary.innerHTML = `<div class="item">Secondary</div>`;

          cart.appendChild(secondary);

          let throwable = document.createElement('div');
          throwable.id = 'throwable';
          throwable.innerHTML = `<div class="item">throwable</div`;

          cart.appendChild(throwable);

          let buy = document.createElement('div');
          buy.id = 'buyall';
          buy.innerHTML = `Buy All <button>200</button>`;
          // ${item.buy ? `$ ${item.buy}` : 'free'}

          cart.appendChild(buy);
          loadout.map(item => {
              if (item.wrap == 'primary') {
                  let primary = document.getElementById('primary');
                  return primary.innerHTML = `<div class="item" style="background-image: url('content/item_images/${item.thumb}"></div><button>${item.buy ? `$ ${item.buy}` : 'free'}</button>`;
              };
        
              if (item.wrap == 'secondary') {
                let secondary = document.getElementById('secondary');
                return secondary.innerHTML = `<div class="item" style="background-image: url('content/item_images/${item.thumb}"></div><button>${item.buy ? `$ ${item.buy}` : 'free'}</button>`;
              };
        
              if (item.wrap == 'throwable') {
                let throwable = document.getElementById('throwable');
                return throwable.innerHTML = `<div class="item" style="background-image: url('content/item_images/${item.thumb}"></div><button>${item.buy ? `$ ${item.buy}` : 'free'}</button>`;
              };
        
              if (item.wrap == 'special') {
        
              };
            });
    };
  
    function setupClasses(lvl, owned, cats, items, purshace, money, team) {
      // Création des classes
      let classes = document.createElement('div');
      classes.classList.add('classes');
  
      cats.map(el => {
        let background = document.createElement('div');
        background.classList.add('class');
        background.id = el.name;
        if (data.type == "weapon") {
          switch (data.team) {
            case "redfor":
              background.style.backgroundImage = `url('content/class_images/R_${el.thumb}')`;
              break;
            case "blufor":
              background.style.backgroundImage = `url('content/class_images/B_${el.thumb}')`;
              break;
            case "independant":
              background.style.backgroundImage = `url('content/class_images/G_${el.thumb}')`;
            break;
            default:
              break;
          }
        }else background.style.backgroundImage = `url('content/class_images/${el.thumb}')`;

        //
        
        let layer = document.createElement('div');
        layer.classList.add('layer');
        layer.id = el.name;
        let p = document.createElement('p');
        if (lvl < el.lvl) {
          layer.classList.add('disabled');
          background.classList.replace('class', 'class-locked');
          p.innerHTML = `<i class='fas fa-lock'></i><br>Level ${el.lvl}</p>`;
        } else p.innerHTML = el.name;
    
        // Branchement au cart
        layer.append(p);
        background.append(layer);
        classes.append(background);
    
        // Branchement des classes
        view.appendChild(classes);
      });
  
      // Query des classes
      let classess = document.querySelectorAll('.class');
      classess.forEach(el => {
        // Event Listner des classes
        el.addEventListener('click', (e) => {
          $.post('http://koth-weaponshop/selectClass', JSON.stringify({class: el.id}));
          document.querySelector('.classes').remove();
          classs = e.id
          _purshace = ["4"];
   
          showItems(lvl, owned, el.id, items, purshace, money);
  
          // Création du button back
          let backbtn = document.createElement('button');
          backbtn.id = 'back';
          backbtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
  
          // Branchement du bouton back
          document.querySelector('header').appendChild(backbtn);
          backbtn.addEventListener('click', () => main(lvl, owned, cats, items, purshace, money, team, loadout));
  
          document.querySelector('#closebtn').remove();
  
          // Création du Pit de navigation
          let span = document.createElement('span');
          span.innerHTML = ' / ' + el.id;
          return document.querySelector('#title').append(span);
        });
      });
    };
  
    function showItems(lvl, owned, cat, items, purshace, money) {
      // Création du wrapper
      let wrapper = document.createElement('div');
      wrapper.classList.add('itemwrapper');
  
      // Création des sections
      let primary = document.createElement('div');
      primary.classList.add('primary');
      primary.innerHTML = '<header><h2>Primary</h2></div></header>'
      
      let secondary = document.createElement('div');
      secondary.classList.add('secondary');
      secondary.innerHTML = '<header><h2>Secondary</h2></header>'
      
      let throwable = document.createElement('div');
      throwable.classList.add('throwable');
      throwable.innerHTML = '<header><h2>Throwable</h2></header>'
  
      // Map des weapons
      items.map(el => {
        if (el.class != cat) return;
  
        // Création de l'item
        let item = document.createElement('div')
        item.classList.add('item');
        item.style.backgroundImage = "url(content/item_images/"+ el.thumb +")";
  
        if (lvl < el.lvl) {
          item.classList.replace('item', 'item-lock')
          item.innerHTML = `<div class='itemlayer'><p><i class='fas fa-lock'></i><br>Level ${el.lvl}</p></div>`
        };

        if (data.type == "weapon") {
          // Branchement des items
          if ( el.wrap == 'primary') primary.appendChild(item);

          if (el.wrap == 'secondary') secondary.appendChild(item);
          if (el.wrap == 'throwable') throwable.appendChild(item);

          wrapper.appendChild(primary);
          wrapper.appendChild(secondary);
          wrapper.appendChild(throwable);
        } else {
          wrapper.append(item);
        };
        view.append(wrapper);
  
        // Création du panier
        let cart = document.getElementById('cart');
  
        // Event click sur les items
        item.addEventListener('click', (e) => {
          // Clear du cart
          cart.innerHTML = '';
  
          // Block l'achat
          if (lvl < el.lvl) return;
  
          // Création du thumb
          let img = document.createElement('div');
          img.classList.add('detail_img');
          img.id = 'details_image';
          img.style.backgroundImage = "url(content/item_images/"+ el.thumb + ")";
  
          // Création du detail de l'item
          let detail = document.createElement('div');
          detail.classList.add('detailHolder');
  
          // Création du nom de l'item
          let name = document.createElement('p');
          name.classList.add('itemname');
          name.id = 'detailsName';
          name.innerHTML = el.name;
  
          // Création de la description de l'item
          let desc = document.createElement('p');
          desc.classList.add('itemtagline');
          desc.id = 'detailsDesc';
          desc.innerHTML = el.desc;
  
          // Branchement des details de l'item
          detail.append(name)
          detail.append(desc);

          let info = document.createElement('div');
          info.id = 'info';
  
          if (el.rent) {
            // Création du button d'achat Rent
            purshacebtn = document.createElement('div');
            purshacebtn.classList.add('purchasebutton');
            purshacebtn.id = 'purshace' + el.id
            purshacebtn.innerHTML = `<p class="type">Rent</p>
            <p class="price" id="rentprice">$ ${el.rent ? el.rent : "Free"}</p>`;
            
            purshacebtn.addEventListener('click', (e) => {
              if (money < el.rent) return info.innerHTML = "Not enough money !";
              money - el.rent
              purshacebtn.remove();
              closeHud(closebtn);
              purshace.push(el.id);
              info.innerHTML = (classs == "terrestre" || classs == "aerien" ? "You just rented this vehicul" : "You just rented this gun")
              $.post('http://koth-weaponshop/rent', JSON.stringify({type : el.cat, item: el.id,price: el.rent,class: el.wrap}));
            });

            let buybtn
            if (el.buy) {
              // Création du button d'achat Buy
              buybtn = document.createElement('div');
              buybtn.classList.add('purchasebutton');
              buybtn.id = 'buy' + el.id
              buybtn.innerHTML = `<p class="type">Purchase</p>
              <p class="price" id="buyprice">$ ${el.buy}</p>`;

              buybtn.addEventListener('click', (e) => {
                  if (money < el.buy) return info.innerHTML = "Not enough money !";
                  buybtn.remove();
                  purshacebtn.remove();
                  closeHud(closebtn);
                  purshace.push(el.id);
                  let confirmpurshace = document.createElement('div');
                  confirmpurshace.classList.add('purchasebutton');
                  confirmpurshace.innerHTML = `<p class="type">Yes, confirm Purchase</p>
                  <p class="price"></p>`;

                  let confirmno = document.createElement('div');
                  confirmno.classList.add('purchasebutton');
                  confirmno.innerHTML = `<p class="type">No, I don't want to buy it for myself</p>
                  <p class="price"></p>`;
                  
                  cart.appendChild(confirmpurshace);
                  cart.appendChild(confirmno);

                  confirmno.addEventListener('click', (e) => {
                    confirmpurshace.remove()
                    confirmno.remove()
                    cart.appendChild(buybtn);
                    cart.appendChild(purshacebtn);
                  });
                  confirmpurshace.addEventListener('click', (e) => {
                    confirmpurshace.remove()
                    confirmno.remove()
                    info.innerHTML = (classs == "terrestre" || classs == "aerien" ? "You just bought this vehicle" : "You just bought this gun")
                    $.post('http://koth-weaponshop/buy', JSON.stringify({id: el.id,price: el.buy}));
                  });
              });
            };

            
          // Branchement de l'item au panier
          cart.append(img);
          cart.appendChild(detail);
          cart.appendChild(info);
          purshace.map(w => {
            if (w == el.id) {
              info.innerHTML = "Your already have this weapon!";
              document.getElementById('buy' + el.id).remove();
              document.getElementById('purshace' + el.id).remove();
            } else {
              cart.appendChild(purshacebtn);
              if (el.buy) cart.appendChild(buybtn);
            };
          });

          owned.map(weapon => {
            if (weapon.id == el.id) {
              document.getElementById('buy' + el.id).remove();
              document.getElementById('purshace' + el.id).remove();
              //console.log("Create Button")
              let purshacebtn3 = document.createElement('div');
              purshacebtn3.classList.add('purchasebutton');
              purshacebtn3.innerHTML = `<p class="type">Owned</p>
              <p class="price">Free</p>`;
                
              cart.appendChild(purshacebtn3);

              purshacebtn3.addEventListener('click', (e) => {
                purshace.push(el.id);
                info.innerHTML = 'Votre arme est dans votre sac';
                $.post('http://koth-weaponshop/owned', JSON.stringify({type : el.cat, item: el.id,price: el.buy,class: el.wrap}));
              });
            };
          });

          };
          return;
        });
        return;
      });
    };
  
    function closeHud(btn) {
      btn.addEventListener('click', () => {
        view.innerHTML = '';
        view.style = 'display: none';
        $.post('http://koth-weaponshop/close', JSON.stringify({close: true}));
      });
    };
    
    return main(lvl, owned, cats, items, purshace, money, loadout, team);
  };
});
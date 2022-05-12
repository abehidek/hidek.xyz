let intro = document.querySelector(".intro");
let mobmenu = document.querySelector(".mobile-menu")

// window.onload = () => {
//   console.log("Inited")
//   const link = document.querySelector("#link")
//   link.addEventListener("click", e => {
//     e.preventDefault();
//   })
// }

window.addEventListener("DOMContentLoaded", () => {
	console.log("INIT");
	const links = document.querySelectorAll('a');

  links.forEach((link) => {
    link.addEventListener("click", e => {
      e.preventDefault();
      let target = e.target.href;
      intro.classList.remove("end");
      mobmenu.classList.remove("show");
      setTimeout(() => {
        window.location.href = target;
      }, 500)
    })
  })
	setTimeout(() => {
    intro.classList.add("end");
    mobmenu.classList.add("show")
  }, 500)
})

class MobileNav {
  constructor(mobileMenu, navList, navLinks) {
    this.mobileMenu = document.querySelector(mobileMenu);
    this.navList = document.querySelector(navList);
    this.navLinks = document.querySelectorAll(navLinks);
    this.activeClass = "active";

    this.handleClick = this.handleClick.bind(this);
    // this.scrollToElement = this.scrollToElement.bind(this);
  }

  animateLinks() {
    this.navLinks.forEach((link) => {
      link.style.animation
        ? (link.style.animation = "")
        : (link.style.animation = `navLinkFade 0.5s ease forwards 0.3s`);
    })
  }

  handleClick() {
    this.navList.classList.toggle(this.activeClass);
    this.animateLinks();
    this.mobileMenu.classList.toggle(this.activeClass);
  }
  
  showElement(evt) {
    const className = evt.currentTarget.innerText.toLowerCase()
    console.log(className)
    // const page = document.querySelector(".about");
    // page.classList.remove("active");
    document.querySelector("."+className).classList.add("active")
  }

  addClickEvent() {
    this.mobileMenu.addEventListener("click", this.handleClick);
    // this.navLinks.forEach((link) => {
    //   link.addEventListener("click", this.handleClick);
    //   link.addEventListener("click", this.showElement);
    // });
    //this.navHomeLink.addEventListener("click", this.scrollToHome);
  }

  init() {
    if (this.mobileMenu) {
      this.addClickEvent();
    }
    return this;
  }
}

const mobileNav = new MobileNav(
  ".mobile-menu",
  ".nav-list",
  ".nav-list li",
);

mobileNav.init();

particlesJS("particles-js", {
  "particles": {
    "number": {
      "value": 140,
      "density": {
        "enable": true,
        "value_area": 800
      }
    },
    "color": {
      "value": "#000"
    },
    "shape": {
      "type": "circle",
      "stroke": {
        "width": 0,
        "color": "#000000"
      },
      "polygon": {
        "nb_sides": 5
      },
      "image": {
        "src": "img/github.svg",
        "width": 100,
        "height": 100
      }
    },
    "opacity": {
      "value": 0.5,
      "random": false,
      "anim": {
        "enable": false,
        "speed": 1,
        "opacity_min": 0.1,
        "sync": false
      }
    },
    "size": {
      "value": 3,
      "random": true,
      "anim": {
        "enable": false,
        "speed": 40,
        "size_min": 0.1,
        "sync": false
      }
    },
    "line_linked": {
      "enable": true,
      "distance": 150,
      "color": "#000",
      "opacity": 0.4,
      "width": 1
    },
    "move": {
      "enable": true,
      "speed": 6,
      "direction": "none",
      "random": false,
      "straight": false,
      "out_mode": "out",
      "bounce": false,
      "attract": {
        "enable": false,
        "rotateX": 600,
        "rotateY": 1200
      }
    }
  },
  "interactivity": {
    "detect_on": "window",
    "events": {
      "onhover": {
        "enable": true,
        "mode": "grab"
      },
      "onclick": {
        "enable": true,
        "mode": "push"
      },
      "resize": true
    },
    "modes": {
      "grab": {
        "distance": 140,
        "line_linked": {
          "opacity": 1
        }
      },
      "bubble": {
        "distance": 400,
        "size": 40,
        "duration": 2,
        "opacity": 8,
        "speed": 3
      },
      "repulse": {
        "distance": 200,
        "duration": 0.4
      },
      "push": {
        "particles_nb": 4
      },
      "remove": {
        "particles_nb": 2
      }
    }
  },
  "retina_detect": true
});



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

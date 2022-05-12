let intro = document.querySelector(".intro");

window.addEventListener("DOMContentLoaded", () => {
	console.log("INIT");
	
	setTimeout(() => {
    intro.classList.add("end");
  }, 200)
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

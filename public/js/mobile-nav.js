class MobileNav {
  constructor(mobileMenu, navList, navLinks, navHomeLink) {
    this.mobileMenu = document.querySelector(mobileMenu);
    this.navList = document.querySelector(navList);
    this.navLinks = document.querySelectorAll(navLinks);
    this.navHomeLink = document.querySelector(navHomeLink);
    this.activeClass = "active";

    this.handleClick = this.handleClick.bind(this);
    this.scrollToElement = this.scrollToElement.bind(this);
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

  scrollToElement(evt) {
    console.log("#"+evt.currentTarget.innerText.toLowerCase())
    // document.querySelector("#contato").scrollIntoView({ behavior: 'smooth' })
    document.querySelector("#"+evt.currentTarget.innerText.toLowerCase()).scrollIntoView({ behavior: 'smooth' })
  }

  scrollToHome() {
    document.querySelector(".home").scrollIntoView({ behavior: 'smooth' })
  }

  addClickEvent() {
    this.mobileMenu.addEventListener("click", this.handleClick);
    this.navLinks.forEach((link) => {
      link.addEventListener("click", this.handleClick);
      link.addEventListener("click", this.scrollToElement);
    });
    this.navHomeLink.addEventListener("click", this.scrollToHome);
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
  "nav h1",
);

mobileNav.init();

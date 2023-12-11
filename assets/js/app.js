// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import hljs from "highlight.js"

window.test = () => {
  alert("test 2")
}

window.addEventListener("phx:page-loading-stop", _ => {
  // hljs.highlightAll()

  document.querySelectorAll("code").forEach(el => {
    hljs.highlightElement(el)
  })
})

let Hooks = {
  "CalculateReadingTime": {
    mounted() {
      const content = document.getElementById("article").innerText;
      const wpm = 225;

      const words = content.trim().split(/\s+/).length;
      console.log("article words:", words)
      const time = Math.round(words / wpm);
      document.getElementById("time").innerText = `${time} ${time > 0 ? "minutes" : "minute"}`;
    }
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => {
  if (info.detail.kind === "redirect") {
    const main = document.querySelector("main");
    main.classList.add("phx-page-loading");
  }
  // topbar.show(300)
})
window.addEventListener("phx:page-loading-stop", _info => {
  // topbar.hide()
  const main = document.querySelector("main");
  main.classList.remove("phx-page-loading");
})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


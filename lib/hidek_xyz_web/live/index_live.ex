defmodule HidekXyzWeb.IndexLive do
  use HidekXyzWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(page_title: "hidek.xyz")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="flex gap-8 items-center flex-col md:flex-row">
        <div class="w-full">
          <div class="mb-6">
            <p class="text-xl indent-2">安部・ギルヘルメ・ヒデK</p>
            <h1 class="font-black text-3xl md:text-5xl">Abe Guilherme Hidek</h1>
          </div>
          <div class="text-lg text-justify leading-relaxed flex flex-col gap-3">
            <p>
              A generalist working for software development, days off experimenting things with elixir, rust and self-hosting.
            </p>
            <p>Currently working @bosch as full-stack engineer.</p>
          </div>
        </div>
        <div class="w-full">
          <svg
            class="w-full bg-gray-950 p-10 sm:p-20"
            version="1.1"
            id="Layer_1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px"
            y="0px"
            enable-background="new 0 0 512 512"
            xml:space="preserve"
            viewBox="126.87 129.87 236.27 241.48"
          >
            <path
              fill="none"
              opacity="1.000000"
              stroke="#FFF"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="4.000000"
              d=" M168.500000,195.500000   C168.500000,242.500000 168.500000,289.500000 168.500000,336.500000  "
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
            <path
              fill="none"
              opacity="1.000000"
              stroke="#FFF"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="3.000000"
              d=" M359.500000,326.500000   C354.150940,309.935028 346.705048,294.386658 335.410126,281.076263   C326.687012,270.796661 315.590607,263.370270 302.977631,258.558624   C290.934570,253.964462 278.317841,251.889557 265.522461,250.317307   C257.470184,249.327881 249.497208,249.900391 241.500000,249.500000  "
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
            <path
              fill="none"
              opacity="1.000000"
              stroke="#FFF"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="4.000000"
              d=" M240.500000,151.500000   C240.500000,223.166672 240.500000,294.833344 240.500000,366.500000  "
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
            <path
              fill="none"
              opacity="1.000000"
              stroke="#FFF"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="3.000000"
              d=" M166.500000,133.500000   C154.032700,139.884201 142.378937,147.630615 130.500000,155.000000  "
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
            <path
              fill="none"
              opacity="1.000000"
              stroke="#FFF"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="3.000000"
              d=" M171.000000,166.000000   C158.972107,172.578629 147.331543,179.787781 136.000000,187.500000  "
              style="--darkreader-inline-stroke: #e8e6e3;"
              data-darkreader-inline-stroke=""
            />
          </svg>
        </div>
      </div>
    </div>
    """
  end
end

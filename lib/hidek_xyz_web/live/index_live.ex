defmodule HidekXyzWeb.IndexLive do
  use HidekXyzWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
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
          <img
            class="w-full bg-gray-950"
            src="https://raw.githubusercontent.com/abehidek/abehidek/main/assets/logo%203%20inverted.svg"
            alt="logo"
          />
        </div>
      </div>
    </div>
    """
  end
end

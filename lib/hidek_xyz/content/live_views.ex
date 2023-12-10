defmodule HidekXyz.Content.LiveViews do
  @moduledoc false
  use GenServer

  require Ecto.Query
  alias HidekXyz.Content.View
  alias HidekXyz.Repo

  defmodule ContentViews do
    defstruct count: 0
  end

  defstruct content_views: %{}

  @impl true
  def init(init_arg) do
    schedule_db_sync()
    {:ok, init_arg}
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)
  end

  @impl true
  def handle_call({:get, slug}, _from, %__MODULE__{} = state) do
    case Map.get(state.content_views, slug) do
      %ContentViews{} = content_views ->
        new_content_view = %ContentViews{
          count: content_views.count + 1
        }

        new_state =
          Map.put(state, :content_views, state.content_views |> Map.put(slug, new_content_view))

        HidekXyzWeb.Endpoint.broadcast!("content_views_" <> slug, "inc", %{})

        {:reply, {:ok, new_content_view}, new_state}

      nil ->
        %View{} =
          db_content_view =
          case Repo.get_by(View, slug: slug) do
            nil -> Repo.insert!(%View{count: 1, slug: slug})
            %View{} = view -> view
          end

        # %View{} =
        #   db_content_view =
        #   Repo.insert!(%View{count: 1, slug: slug}, on_conflict: [inc: [count: 1]])

        new_content_view = %ContentViews{
          count: db_content_view.count + 1
        }

        new_state =
          Map.put(state, :content_views, state.content_views |> Map.put(slug, new_content_view))

        HidekXyzWeb.Endpoint.broadcast!("content_views_" <> slug, "inc", %{})

        {:reply, {:ok, new_content_view}, new_state}

      _ ->
        raise "Something bad happened"
    end

    # case state.first_time do
    #   # fetch from db and put in count
    #   true ->
    #     %View{} =
    #       db_state = Repo.insert!(%View{count: 1, slug: slug}, on_conflict: [inc: [count: 1]])

    #     new_state = %__MODULE__{count: db_state.count, first_time: false}
    #     {:reply, {:ok, new_state}, new_state}

    #   false ->
    #     new_state = %__MODULE__{count: state.count + 1, first_time: false}
    #     {:reply, {:ok, new_state}, new_state}
    # end
    # {:reply, {:ok, state}, state}
  end

  def get(slug) when is_binary(slug), do: GenServer.call(__MODULE__, {:get, slug})

  @impl true
  def handle_info(:sync_db, %__MODULE__{} = state) do
    state.content_views
    |> Enum.each(fn {k, %ContentViews{} = v} ->
      Repo.get_by!(View, slug: k)
      |> Ecto.Changeset.change(%{count: v.count})
      |> Repo.update()
    end)

    schedule_db_sync()
    {:noreply, state}
  end

  def schedule_db_sync do
    Process.send_after(self(), :sync_db, 1000 * 10)
  end
end

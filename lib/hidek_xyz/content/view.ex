defmodule HidekXyz.Content.View do
  use Ecto.Schema
  import Ecto.Changeset

  schema "views" do
    field :count, :integer
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(view, attrs) do
    view
    |> cast(attrs, [:slug, :count])
    |> validate_required([:slug, :count])
    |> unique_constraint(:email)
  end
end

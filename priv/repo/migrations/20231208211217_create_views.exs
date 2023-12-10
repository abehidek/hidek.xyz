defmodule HidekXyz.Repo.Migrations.CreateViews do
  use Ecto.Migration

  def change do
    create table(:views) do
      add :slug, :string
      add :count, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:views, [:slug])
  end
end

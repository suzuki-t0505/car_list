defmodule CarList.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :company_name, :string
      add :model, :string
      add :year, :string
      add :engine_fuel_type, :string
      add :engine_hp, :integer
      add :transmission_type, :string
      add :driven_wheel, :string

      timestamps()
    end
  end
end

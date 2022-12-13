defmodule CarList.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :company_name, :string
    field :driven_wheel, :string
    field :engine_fuel_type, :string
    field :engine_hp, :integer
    field :model, :string
    field :transmission_type, :string
    field :year, :string

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:company_name, :model, :year, :engine_fuel_type, :engine_hp, :transmission_type, :driven_wheel])
    |> validate_required(:company_name, message: "Please enter company name.")
    |> validate_required(:driven_wheel, message: "Please enter driven wheel.")
    |> validate_required(:engine_fuel_type, message: "Please enter engine fuel type.")
    |> validate_required(:engine_hp, message: "Please enter engine hp.")
    |> validate_required(:model, message: "Please enter model.")
    |> validate_required(:transmission_type, message: "Please enter transmission type.")
    |> validate_required(:year, message: "Please enter year.")
  end
end

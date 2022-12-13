defmodule CarList.CarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarList.Cars` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        company_name: "some company_name",
        driven_wheel: "some driven_wheel",
        engine_fuel_type: "some engine_fuel_type",
        engine_hp: "some engine_hp",
        model: "some model",
        transmission_type: "some transmission_type",
        year: "some year"
      })
      |> CarList.Cars.create_car()

    car
  end
end

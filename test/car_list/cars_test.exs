defmodule CarList.CarsTest do
  use CarList.DataCase

  alias CarList.Cars

  describe "cars" do
    alias CarList.Cars.Car

    import CarList.CarsFixtures

    @invalid_attrs %{company_name: nil, driven_wheel: nil, engine_fuel_type: nil, engine_hp: nil, model: nil, transmission_type: nil, year: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Cars.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{company_name: "some company_name", driven_wheel: "some driven_wheel", engine_fuel_type: "some engine_fuel_type", engine_hp: "some engine_hp", model: "some model", transmission_type: "some transmission_type", year: "some year"}

      assert {:ok, %Car{} = car} = Cars.create_car(valid_attrs)
      assert car.company_name == "some company_name"
      assert car.driven_wheel == "some driven_wheel"
      assert car.engine_fuel_type == "some engine_fuel_type"
      assert car.engine_hp == "some engine_hp"
      assert car.model == "some model"
      assert car.transmission_type == "some transmission_type"
      assert car.year == "some year"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{company_name: "some updated company_name", driven_wheel: "some updated driven_wheel", engine_fuel_type: "some updated engine_fuel_type", engine_hp: "some updated engine_hp", model: "some updated model", transmission_type: "some updated transmission_type", year: "some updated year"}

      assert {:ok, %Car{} = car} = Cars.update_car(car, update_attrs)
      assert car.company_name == "some updated company_name"
      assert car.driven_wheel == "some updated driven_wheel"
      assert car.engine_fuel_type == "some updated engine_fuel_type"
      assert car.engine_hp == "some updated engine_hp"
      assert car.model == "some updated model"
      assert car.transmission_type == "some updated transmission_type"
      assert car.year == "some updated year"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Cars.update_car(car, @invalid_attrs)
      assert car == Cars.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Cars.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Cars.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Cars.change_car(car)
    end
  end
end

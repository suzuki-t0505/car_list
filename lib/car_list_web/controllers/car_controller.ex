defmodule CarListWeb.CarController do
  use CarListWeb, :controller

  alias CarList.Cars
  alias CarList.Cars.Car

  def index(conn, _params) do
    cars = Cars.list_cars()
    render(conn, "index.html", cars: cars)
  end

  def new(conn, _params) do
    changeset = Cars.change_car(%Car{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"car" => car_params}) do
    case Cars.create_car(car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car created successfully.")
        |> redirect(to: Routes.car_path(conn, :show, car))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Cars.get_car!(id)
    render(conn, "show.html", car: car)
  end

  def edit(conn, %{"id" => id}) do
    car = Cars.get_car!(id)
    changeset = Cars.change_car(car)
    render(conn, "edit.html", car: car, changeset: changeset)
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    car = Cars.get_car!(id)

    case Cars.update_car(car, car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car updated successfully.")
        |> redirect(to: Routes.car_path(conn, :show, car))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", car: car, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    car = Cars.get_car!(id)
    {:ok, _car} = Cars.delete_car(car)

    conn
    |> put_flash(:info, "Car deleted successfully.")
    |> redirect(to: Routes.car_path(conn, :index))
  end

  def csv_import(conn, _params) do
    render(conn, "csv_import_form.html", error_message: nil, index: nil, file_name: nil)
  end

  def create_cars(conn, %{"csv_file" => file_data}) do
    csv_data =
      file_data.path
      |> File.stream!()
      |> CSV.decode!(headers: fields())
      |> Enum.map(& &1)
      |> tl()
      |> Cars.create_cars()

    case csv_data do
      {:ok, _map} ->
        conn
        |> put_flash(:info, "Cars created successfully.")
        |> redirect(to: Routes.car_path(conn, :index))

      {:error, "car_" <> index, changeset, _map} ->

        IO.inspect(changeset)
        error_message =
          Enum.map(changeset.errors, fn {_key, {message, _details}} -> message end)
          |> IO.inspect()
        render(conn, "csv_import_form.html", error_message: error_message, index: String.to_integer(index), file_name: file_data.filename)
    end
  end

  defp fields do
    [:company_name, :model, :year, :engine_fuel_type, :engine_hp, :transmission_type, :driven_wheel]
  end
end

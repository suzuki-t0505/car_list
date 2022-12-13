defmodule CarListWeb.CarControllerTest do
  use CarListWeb.ConnCase

  import CarList.CarsFixtures

  @create_attrs %{company_name: "some company_name", driven_wheel: "some driven_wheel", engine_fuel_type: "some engine_fuel_type", engine_hp: "some engine_hp", model: "some model", transmission_type: "some transmission_type", year: "some year"}
  @update_attrs %{company_name: "some updated company_name", driven_wheel: "some updated driven_wheel", engine_fuel_type: "some updated engine_fuel_type", engine_hp: "some updated engine_hp", model: "some updated model", transmission_type: "some updated transmission_type", year: "some updated year"}
  @invalid_attrs %{company_name: nil, driven_wheel: nil, engine_fuel_type: nil, engine_hp: nil, model: nil, transmission_type: nil, year: nil}

  describe "index" do
    test "lists all cars", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Cars"
    end
  end

  describe "new car" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :new))
      assert html_response(conn, 200) =~ "New Car"
    end
  end

  describe "create car" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), car: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.car_path(conn, :show, id)

      conn = get(conn, Routes.car_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Car"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), car: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Car"
    end
  end

  describe "edit car" do
    setup [:create_car]

    test "renders form for editing chosen car", %{conn: conn, car: car} do
      conn = get(conn, Routes.car_path(conn, :edit, car))
      assert html_response(conn, 200) =~ "Edit Car"
    end
  end

  describe "update car" do
    setup [:create_car]

    test "redirects when data is valid", %{conn: conn, car: car} do
      conn = put(conn, Routes.car_path(conn, :update, car), car: @update_attrs)
      assert redirected_to(conn) == Routes.car_path(conn, :show, car)

      conn = get(conn, Routes.car_path(conn, :show, car))
      assert html_response(conn, 200) =~ "some updated company_name"
    end

    test "renders errors when data is invalid", %{conn: conn, car: car} do
      conn = put(conn, Routes.car_path(conn, :update, car), car: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Car"
    end
  end

  describe "delete car" do
    setup [:create_car]

    test "deletes chosen car", %{conn: conn, car: car} do
      conn = delete(conn, Routes.car_path(conn, :delete, car))
      assert redirected_to(conn) == Routes.car_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.car_path(conn, :show, car))
      end
    end
  end

  defp create_car(_) do
    car = car_fixture()
    %{car: car}
  end
end

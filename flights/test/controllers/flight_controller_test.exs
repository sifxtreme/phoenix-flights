defmodule Flights.FlightControllerTest do
  use Flights.ConnCase

  alias Flights.Flight
  @valid_attrs %{date: "2010-04-17", destination: "some content", lowest_price: 42, origin: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, flight_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing flights"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, flight_path(conn, :new)
    assert html_response(conn, 200) =~ "New flight"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, flight_path(conn, :create), flight: @valid_attrs
    assert redirected_to(conn) == flight_path(conn, :index)
    assert Repo.get_by(Flight, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, flight_path(conn, :create), flight: @invalid_attrs
    assert html_response(conn, 200) =~ "New flight"
  end

  test "shows chosen resource", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = get conn, flight_path(conn, :show, flight)
    assert html_response(conn, 200) =~ "Show flight"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, flight_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = get conn, flight_path(conn, :edit, flight)
    assert html_response(conn, 200) =~ "Edit flight"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = put conn, flight_path(conn, :update, flight), flight: @valid_attrs
    assert redirected_to(conn) == flight_path(conn, :show, flight)
    assert Repo.get_by(Flight, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = put conn, flight_path(conn, :update, flight), flight: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit flight"
  end

  test "deletes chosen resource", %{conn: conn} do
    flight = Repo.insert! %Flight{}
    conn = delete conn, flight_path(conn, :delete, flight)
    assert redirected_to(conn) == flight_path(conn, :index)
    refute Repo.get(Flight, flight.id)
  end
end

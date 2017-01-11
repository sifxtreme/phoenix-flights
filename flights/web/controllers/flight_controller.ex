defmodule Flights.FlightController do
  use Flights.Web, :controller

  alias Flights.Flight

  plug :scrub_params, "flight" when action in [:create, :update]

  def index(conn, _params) do
    flights = Repo.all(Flight)
    render(conn, "index.html", flights: flights)
  end

  def new(conn, _params) do
    changeset = Flight.changeset(%Flight{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"flight" => flight_params}) do
    changeset = Flight.changeset(%Flight{}, flight_params)

    case Repo.insert(changeset) do
      {:ok, _flight} ->
        conn
        |> put_flash(:info, "Flight created successfully.")
        |> redirect(to: flight_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = Repo.get!(Flight, id)
    render(conn, "show.html", flight: flight)
  end

  def edit(conn, %{"id" => id}) do
    flight = Repo.get!(Flight, id)
    changeset = Flight.changeset(flight)
    render(conn, "edit.html", flight: flight, changeset: changeset)
  end

  def update(conn, %{"id" => id, "flight" => flight_params}) do
    flight = Repo.get!(Flight, id)
    changeset = Flight.changeset(flight, flight_params)

    case Repo.update(changeset) do
      {:ok, flight} ->
        conn
        |> put_flash(:info, "Flight updated successfully.")
        |> redirect(to: flight_path(conn, :show, flight))
      {:error, changeset} ->
        render(conn, "edit.html", flight: flight, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    flight = Repo.get!(Flight, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(flight)

    conn
    |> put_flash(:info, "Flight deleted successfully.")
    |> redirect(to: flight_path(conn, :index))
  end
end

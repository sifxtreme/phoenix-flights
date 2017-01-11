defmodule Flights.FlightTest do
  use Flights.ModelCase

  alias Flights.Flight

  @valid_attrs %{date: "2010-04-17", destination: "some content", lowest_price: 42, origin: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Flight.changeset(%Flight{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Flight.changeset(%Flight{}, @invalid_attrs)
    refute changeset.valid?
  end
end

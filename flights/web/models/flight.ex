defmodule Flights.Flight do
  use Flights.Web, :model

  schema "flights" do
    field :destination, :string
    field :origin, :string
    field :date, Ecto.Date
    field :lowest_price, :integer

    timestamps
  end

  @required_fields ~w(destination origin date lowest_price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

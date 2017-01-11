defmodule Flights.Repo.Migrations.CreateFlight do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :destination, :string
      add :origin, :string
      add :date, :date
      add :lowest_price, :integer

      timestamps
    end

  end
end

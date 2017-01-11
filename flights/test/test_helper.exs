ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Flights.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Flights.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Flights.Repo)


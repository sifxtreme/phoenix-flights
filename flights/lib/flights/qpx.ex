require IEx

defmodule Flights.QPX do
  use HTTPotion.Base

  def runner do
    single_flight = %Flights.Flight{destination: destination, origin: origin, date: date |> Ecto.Date.cast!, lowest_price: lowest_price}
    {:ok, _} = Flights.Repo.insert(single_flight)
  end

  def origin do
    "LAX"
  end

  def destination do
    "DAL"
  end

  def date do
    Calendar.Date.today_utc |> Calendar.Date.add!(10)
  end

  def data_to_submit do
    ~s(
    {
      "request": {
        "slice": [
          {
            "origin": "#{origin}",
            "destination": "#{destination}",
            "date": "#{date}"
          }
        ],
        "passengers": {
          "adultCount": 1,
          "infantInLapCount": 0,
          "infantInSeatCount": 0,
          "childCount": 0,
          "seniorCount": 0
        },
        "solutions": 20,
        "refundable": false
      }
    }
    )
  end

  def get_flight_data do
    response = HTTPotion.post api_url_with_key, [body: data_to_submit, headers: ["Content-Type": "application/json"]]
    Poison.Parser.parse!(response.body)
  end

  def lowest_price do
    Enum.map(get_flight_data["trips"]["tripOption"], fn x -> x["saleTotal"] |> to_string |> String.replace("USD", "") |> Float.parse |> elem(0) |> round end) |> Enum.min
  end

  def api_url do
    "https://www.googleapis.com/qpxExpress/v1/trips/search"
  end

  def api_key do
    System.get_env("GOOGLE_FLIGHTS_API_KEY")
  end

  def api_url_with_key do
    api_url <> "?key=" <> api_key
  end

end

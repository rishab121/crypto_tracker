defmodule CryptoTracker.Allcurrency do
    def path do
        "https://api.coinmarketcap.com/v1/ticker/"
    end
    def new do
        {:ok, resp} = HTTPoison.get(path())
        Poison.decode!(resp.body)
    end

    def client_view(coins) do
       coins.data
    end
    def getAllCoins() do
        {:ok, resp} = HTTPoison.get(path())
        Poison.decode!(resp.body)
    end
    def checkAlerts() do
        {:ok, resp} = HTTPoison.get(path())
        Poison.decode!(resp.body)
        #IO.puts(List.first(data))
    end
   

end
#Attribution -> Followed Artice: https://medium.com/@efexen/periodic-tasks-with-elixir-5d9050bcbdb3
#Attribution -> https://github.com/mailman/mailman 

defmodule CryptoTracker.AlertsChecker do
    use Task
    def start_link(_arg) do
      Task.start_link(&poll/0)
    end
    def poll() do
      receive do
      after
        30_000 ->
          check_Alerts()
          poll()
      end
    end
    def path do
        "https://api.coinmarketcap.com/v1/ticker/"
    end

    defp check_Alerts() do
      # Call API & Persist
      IO.puts "To the moon!"
      {:ok, resp} = HTTPoison.get(path())
      data = Poison.Parser.parse!(resp.body) #list of all coins [%{},%{}]
      wanted = ["bitcoin", "ethereum", "litecoin", "ripple", "stellar", "eos", "cardano", "iota", "neo"]
      data = Enum.filter(data, fn(coin) -> Enum.member?(wanted, Map.get(coin, "id")) end) #filter currency we need
      data = Enum.map(data, fn(coin) -> %{                                                # get data we need  
          name: Map.get(coin, "id"),
          price: Map.get(coin, "price_usd")
      } end )
      alerts = CryptoTracker.Crypto.get_list_of_alerts() #have email, price, uid, name and aid
      check_alerts_helper(alerts,data)
    end

    def check_alerts_helper(alerts,data) do
      # data have name, price
      # alerts have name,target,email,uid,aid
      # To do get the alerts in which target==price and name==name
      # then delete the alert by delete_by_id
        for alert <- alerts do
            for coin <- data do
                {coin_price,temp} = Float.parse(coin.price)
                coin_price_floor = Float.floor(coin_price,2)
                coin_price_ceil = Float.ceil(coin_price,2)
                if coin_price_floor <= alert.target and coin_price_ceil >= alert.target and alert.name == coin.name do
                    IO.puts("sending Alert email")
                    sendemail(alert.email, coin.name, coin.price)
                    CryptoTracker.Crypto.delete_alert_by_id(alert.aid)
                end
            end
        end
    end
    
    def sendemail(email,name,price) do
        text = "Your coin " <> name <> " has reached the price of: " <> price
        email = %Mailman.Email{
                    subject: "CryptoCurrency Alert!!",
                    from: "mailman@elixir.com",
                    to: [email],
                    data: [
                      name: "Yo"
                    ],
                    text:  text,
                  
                }
        CryptoTracker.Mailer.deliver(email)
    end
end
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CryptoTracker.Repo.insert!(%CryptoTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


defmodule Seeds do
    alias CryptoTracker.Repo
    alias CryptoTracker.Accounts.User
    alias CryptoTracker.Crypto.Currency
    alias CryptoTracker.Crypto.Alert
    
    def run do
        p = Comeonin.Argon2.hashpwsalt("password1")

        Repo.delete_all(User)
        Repo.insert!(%User{ name: "Alice", email: "alice@gmail.com", password_hash: p})
        Repo.insert!(%User{ name: "Bob", email: "bob@gmail.com", password_hash: p})
        Repo.insert!(%User{ name: "Carol", email: "carol@gmail.com", password_hash: p})
        Repo.insert!(%User{ name: "David", email: "david@gmail.com", password_hash: p})

        Repo.delete_all(Currency)
        Repo.insert!(%Currency{ name: "bitcoin" })
        Repo.insert!(%Currency{ name: "ethereum" })
        Repo.insert!(%Currency{ name: "litecoin" })
        Repo.insert!(%Currency{ name: "ripple" })
        Repo.insert!(%Currency{ name: "stellar" })
        Repo.insert!(%Currency{ name: "eos" })
        Repo.insert!(%Currency{ name: "cardano" })
        Repo.insert!(%Currency{ name: "iota" })
        Repo.insert!(%Currency{ name: "neo" })
        Repo.insert!(%Currency{ name: "dash" })
        Repo.insert!(%Currency{ name: "tron" })
        Repo.insert!(%Currency{ name: "tether" })
        Repo.insert!(%Currency{ name: "vechain" })
        Repo.insert!(%Currency{ name: "omisego" })
        Repo.insert!(%Currency{ name: "qtum" })
        Repo.insert!(%Currency{ name: "binance-coin" })
        Repo.delete_all(Alert)
        Repo.insert!(%Alert{ user_id: 1, currency_id: 1, target: 1.0})

    end

end

Seeds.run
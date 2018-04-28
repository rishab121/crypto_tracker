defmodule CryptoTracker.CryptoTest do
  use CryptoTracker.DataCase

  alias CryptoTracker.Crypto

  describe "currencies" do
    alias CryptoTracker.Crypto.Currency

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def currency_fixture(attrs \\ %{}) do
      {:ok, currency} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Crypto.create_currency()

      currency
    end

    test "list_currencies/0 returns all currencies" do
      currency = currency_fixture()
      assert Crypto.list_currencies() == [currency]
    end

    test "get_currency!/1 returns the currency with given id" do
      currency = currency_fixture()
      assert Crypto.get_currency!(currency.id) == currency
    end

    test "create_currency/1 with valid data creates a currency" do
      assert {:ok, %Currency{} = currency} = Crypto.create_currency(@valid_attrs)
      assert currency.name == "some name"
    end

    test "create_currency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crypto.create_currency(@invalid_attrs)
    end

    test "update_currency/2 with valid data updates the currency" do
      currency = currency_fixture()
      assert {:ok, currency} = Crypto.update_currency(currency, @update_attrs)
      assert %Currency{} = currency
      assert currency.name == "some updated name"
    end

    test "update_currency/2 with invalid data returns error changeset" do
      currency = currency_fixture()
      assert {:error, %Ecto.Changeset{}} = Crypto.update_currency(currency, @invalid_attrs)
      assert currency == Crypto.get_currency!(currency.id)
    end

    test "delete_currency/1 deletes the currency" do
      currency = currency_fixture()
      assert {:ok, %Currency{}} = Crypto.delete_currency(currency)
      assert_raise Ecto.NoResultsError, fn -> Crypto.get_currency!(currency.id) end
    end

    test "change_currency/1 returns a currency changeset" do
      currency = currency_fixture()
      assert %Ecto.Changeset{} = Crypto.change_currency(currency)
    end
  end

  describe "alerts" do
    alias CryptoTracker.Crypto.Alert

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def alert_fixture(attrs \\ %{}) do
      {:ok, alert} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Crypto.create_alert()

      alert
    end

    test "list_alerts/0 returns all alerts" do
      alert = alert_fixture()
      assert Crypto.list_alerts() == [alert]
    end

    test "get_alert!/1 returns the alert with given id" do
      alert = alert_fixture()
      assert Crypto.get_alert!(alert.id) == alert
    end

    test "create_alert/1 with valid data creates a alert" do
      assert {:ok, %Alert{} = alert} = Crypto.create_alert(@valid_attrs)
    end

    test "create_alert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crypto.create_alert(@invalid_attrs)
    end

    test "update_alert/2 with valid data updates the alert" do
      alert = alert_fixture()
      assert {:ok, alert} = Crypto.update_alert(alert, @update_attrs)
      assert %Alert{} = alert
    end

    test "update_alert/2 with invalid data returns error changeset" do
      alert = alert_fixture()
      assert {:error, %Ecto.Changeset{}} = Crypto.update_alert(alert, @invalid_attrs)
      assert alert == Crypto.get_alert!(alert.id)
    end

    test "delete_alert/1 deletes the alert" do
      alert = alert_fixture()
      assert {:ok, %Alert{}} = Crypto.delete_alert(alert)
      assert_raise Ecto.NoResultsError, fn -> Crypto.get_alert!(alert.id) end
    end

    test "change_alert/1 returns a alert changeset" do
      alert = alert_fixture()
      assert %Ecto.Changeset{} = Crypto.change_alert(alert)
    end
  end

  describe "alerts" do
    alias CryptoTracker.Crypto.Alert

    @valid_attrs %{target: 42}
    @update_attrs %{target: 43}
    @invalid_attrs %{target: nil}

    def alert_fixture(attrs \\ %{}) do
      {:ok, alert} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Crypto.create_alert()

      alert
    end

    test "list_alerts/0 returns all alerts" do
      alert = alert_fixture()
      assert Crypto.list_alerts() == [alert]
    end

    test "get_alert!/1 returns the alert with given id" do
      alert = alert_fixture()
      assert Crypto.get_alert!(alert.id) == alert
    end

    test "create_alert/1 with valid data creates a alert" do
      assert {:ok, %Alert{} = alert} = Crypto.create_alert(@valid_attrs)
      assert alert.target == 42
    end

    test "create_alert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crypto.create_alert(@invalid_attrs)
    end

    test "update_alert/2 with valid data updates the alert" do
      alert = alert_fixture()
      assert {:ok, alert} = Crypto.update_alert(alert, @update_attrs)
      assert %Alert{} = alert
      assert alert.target == 43
    end

    test "update_alert/2 with invalid data returns error changeset" do
      alert = alert_fixture()
      assert {:error, %Ecto.Changeset{}} = Crypto.update_alert(alert, @invalid_attrs)
      assert alert == Crypto.get_alert!(alert.id)
    end

    test "delete_alert/1 deletes the alert" do
      alert = alert_fixture()
      assert {:ok, %Alert{}} = Crypto.delete_alert(alert)
      assert_raise Ecto.NoResultsError, fn -> Crypto.get_alert!(alert.id) end
    end

    test "change_alert/1 returns a alert changeset" do
      alert = alert_fixture()
      assert %Ecto.Changeset{} = Crypto.change_alert(alert)
    end
  end

  describe "follows" do
    alias CryptoTracker.Crypto.Follow

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follow_fixture(attrs \\ %{}) do
      {:ok, follow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Crypto.create_follow()

      follow
    end

    test "list_follows/0 returns all follows" do
      follow = follow_fixture()
      assert Crypto.list_follows() == [follow]
    end

    test "get_follow!/1 returns the follow with given id" do
      follow = follow_fixture()
      assert Crypto.get_follow!(follow.id) == follow
    end

    test "create_follow/1 with valid data creates a follow" do
      assert {:ok, %Follow{} = follow} = Crypto.create_follow(@valid_attrs)
    end

    test "create_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crypto.create_follow(@invalid_attrs)
    end

    test "update_follow/2 with valid data updates the follow" do
      follow = follow_fixture()
      assert {:ok, follow} = Crypto.update_follow(follow, @update_attrs)
      assert %Follow{} = follow
    end

    test "update_follow/2 with invalid data returns error changeset" do
      follow = follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Crypto.update_follow(follow, @invalid_attrs)
      assert follow == Crypto.get_follow!(follow.id)
    end

    test "delete_follow/1 deletes the follow" do
      follow = follow_fixture()
      assert {:ok, %Follow{}} = Crypto.delete_follow(follow)
      assert_raise Ecto.NoResultsError, fn -> Crypto.get_follow!(follow.id) end
    end

    test "change_follow/1 returns a follow changeset" do
      follow = follow_fixture()
      assert %Ecto.Changeset{} = Crypto.change_follow(follow)
    end
  end
end

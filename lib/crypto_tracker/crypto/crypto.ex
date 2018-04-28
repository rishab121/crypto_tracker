defmodule CryptoTracker.Crypto do
  @moduledoc """
  The Crypto context.
  """

  import Ecto.Query, warn: false
  alias CryptoTracker.Repo

  alias CryptoTracker.Crypto.Currency

  @doc """
  Returns the list of currencies.

  ## Examples

      iex> list_currencies()
      [%Currency{}, ...]

  """
  def list_currencies do
    Repo.all(Currency)
  end

  

  @doc """
  Gets a single currency.

  Raises `Ecto.NoResultsError` if the Currency does not exist.

  ## Examples

      iex> get_currency!(123)
      %Currency{}

      iex> get_currency!(456)
      ** (Ecto.NoResultsError)

  """
  def get_currency!(id), do: Repo.get!(Currency, id)

  @doc """
  Creates a currency.

  ## Examples

      iex> create_currency(%{field: value})
      {:ok, %Currency{}}

      iex> create_currency(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_currency(attrs \\ %{}) do
    %Currency{}
    |> Currency.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a currency.

  ## Examples

      iex> update_currency(currency, %{field: new_value})
      {:ok, %Currency{}}

      iex> update_currency(currency, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_currency(%Currency{} = currency, attrs) do
    currency
    |> Currency.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Currency.

  ## Examples

      iex> delete_currency(currency)
      {:ok, %Currency{}}

      iex> delete_currency(currency)
      {:error, %Ecto.Changeset{}}

  """
  def delete_currency(%Currency{} = currency) do
    Repo.delete(currency)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking currency changes.

  ## Examples

      iex> change_currency(currency)
      %Ecto.Changeset{source: %Currency{}}

  """
  def change_currency(%Currency{} = currency) do
    Currency.changeset(currency, %{})
  end

  alias CryptoTracker.Crypto.Alert

  @doc """
  Returns the list of alerts.

  ## Examples

      iex> list_alerts()
      [%Alert{}, ...]

  """
  def list_alerts do
    Repo.all(Alert)
    |> Repo.preload(:user)
    |> Repo.preload(:currency)
  end

  def list_alerts_of_user(user_id) do
      Repo.all(from a in Alert, where: a.user_id == ^user_id)
      |> Repo.preload(:user)
      |> Repo.preload(:currency)
  end

  def get_list_of_alerts do
     all =  Repo.all(Alert) |> Repo.preload(:user) |> Repo.preload(:currency)
     list_of_alerts = Enum.map(all, fn(alert) -> %{
         uid: alert.user_id,
         email: alert.user.email,
         target: alert.target,
         name: alert.currency.name,
         aid: alert.id

     } end )
  end
  @doc """
  Gets a single alert.

  Raises `Ecto.NoResultsError` if the Alert does not exist.

  ## Examples

      iex> get_alert!(123)
      %Alert{}

      iex> get_alert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_alert!(id) do
    Repo.get!(Alert, id)
    |> Repo.preload(:user)
    |> Repo.preload(:currency)
  end

  @doc """
  Creates a alert.

  ## Examples

      iex> create_alert(%{field: value})
      {:ok, %Alert{}}

      iex> create_alert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_alert(attrs \\ %{}) do
    %Alert{}
    |> Alert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a alert.

  ## Examples

      iex> update_alert(alert, %{field: new_value})
      {:ok, %Alert{}}

      iex> update_alert(alert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_alert(%Alert{} = alert, attrs) do
    alert
    |> Alert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Alert.

  ## Examples

      iex> delete_alert(alert)
      {:ok, %Alert{}}

      iex> delete_alert(alert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_alert(%Alert{} = alert) do
    Repo.delete(alert)
  end

  def delete_alert_by_id(id) do
      get_alert!(id)
      |> delete_alert()
  end
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking alert changes.

  ## Examples

      iex> change_alert(alert)
      %Ecto.Changeset{source: %Alert{}}

  """
  def change_alert(%Alert{} = alert) do
    Alert.changeset(alert, %{})
  end

  alias CryptoTracker.Crypto.Follow

  @doc """
  Returns the list of follows.

  ## Examples

      iex> list_follows()
      [%Follow{}, ...]

  """
  def list_follows do
    Repo.all(Follow)
    |> Repo.preload(:user)
    |> Repo.preload(:currency)
  end

  def follows_map_for(u_id) do
      Repo.all(from f in Follow, where: f.user_id == ^u_id)
      |> Enum.map(&({&1.currency_id, &1.id}))
      |> Enum.into(%{})
  end

  def currency_list_for(user) do
    Repo.all(from f in Follow, where: f.user_id == ^user.id)
    |> Enum.map(&({&1.currency_id, &1.id}))
    |> Enum.into(%{})
  end
  def getUserCurrency(user_id) do
   data = Repo.all(from f in Follow, where: f.user_id == ^user_id) |> Repo.preload(:user)  |> Repo.preload(:currency)
   list_of_currency = Enum.map(data, fn(record) -> record.currency.name end ) 
  end

  @doc """
  Gets a single follow.

  Raises `Ecto.NoResultsError` if the Follow does not exist.

  ## Examples

      iex> get_follow!(123)
      %Follow{}

      iex> get_follow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follow!(id), do: Repo.get!(Follow, id)

  @doc """
  Creates a follow.

  ## Examples

      iex> create_follow(%{field: value})
      {:ok, %Follow{}}

      iex> create_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follow.

  ## Examples

      iex> update_follow(follow, %{field: new_value})
      {:ok, %Follow{}}

      iex> update_follow(follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follow.

  ## Examples

      iex> delete_follow(follow)
      {:ok, %Follow{}}

      iex> delete_follow(follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follow changes.

  ## Examples

      iex> change_follow(follow)
      %Ecto.Changeset{source: %Follow{}}

  """
  def change_follow(%Follow{} = follow) do
    Follow.changeset(follow, %{})
  end
end

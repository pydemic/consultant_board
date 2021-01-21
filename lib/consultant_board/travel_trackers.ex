defmodule ConsultantBoard.TravelTrackers do
  @moduledoc """
  The TravelTrackers context.
  """

  import Ecto.Query, warn: false
  alias ConsultantBoard.Repo

  alias ConsultantBoard.TravelTrackers.TravelTracker

  @doc """
  Returns the list of traveltrackers.

  ## Examples

      iex> list_traveltrackers()
      [%TravelTracker{}, ...]

  """
  def list_travel_trackers do
    Repo.all(TravelTracker)
  end

  def list_travel_trackers(criteria) when is_list(criteria) do
    query = from(c in TravelTracker)

    query_builder(criteria, query)
    |> Repo.all()
  end

  def get_quantity_travel_trackers(criteria) when is_list(criteria) do
    query = from(c in TravelTracker)

    {_, criteria} = Keyword.pop_first(criteria, :paginate)
    {_, criteria} = Keyword.pop_first(criteria, :sort)

    query_builder(criteria, query)
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Gets a single travel_tracker.

  Raises `Ecto.NoResultsError` if the Travel tracker does not exist.

  ## Examples

      iex> get_travel_tracker!(123)
      %TravelTracker{}

      iex> get_travel_tracker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_travel_tracker!(id), do: Repo.get!(TravelTracker, id)

  @doc """
  Creates a travel_tracker.

  ## Examples

      iex> create_travel_tracker(%{field: value})
      {:ok, %TravelTracker{}}

      iex> create_travel_tracker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_travel_tracker(attrs \\ %{}) do
    %TravelTracker{}
    |> TravelTracker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a travel_tracker.

  ## Examples

      iex> update_travel_tracker(travel_tracker, %{field: new_value})
      {:ok, %TravelTracker{}}

      iex> update_travel_tracker(travel_tracker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_travel_tracker(%TravelTracker{} = travel_tracker, attrs) do
    travel_tracker
    |> TravelTracker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a travel_tracker.

  ## Examples

      iex> delete_travel_tracker(travel_tracker)
      {:ok, %TravelTracker{}}

      iex> delete_travel_tracker(travel_tracker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_travel_tracker(%TravelTracker{} = travel_tracker) do
    Repo.delete(travel_tracker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking travel_tracker changes.

  ## Examples

      iex> change_travel_tracker(travel_tracker)
      %Ecto.Changeset{data: %TravelTracker{}}

  """
  def change_travel_tracker(%TravelTracker{} = travel_tracker, attrs \\ %{}) do
    TravelTracker.changeset(travel_tracker, attrs)
  end

  defp query_builder(criteria, query) do
    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_page: per_page}}, query ->
        from c in query,
          offset: ^((page - 1) * per_page),
          limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from c in query, order_by: [{^sort_order, ^sort_by}]

      {:filter, %{filter: destination_federative_unit}}, query ->
        if destination_federative_unit != "" and destination_federative_unit != nil do
          from c in query,
            where: c.destination_federative_unit == ^destination_federative_unit
        else
          query
        end

      {:search, %{search: search}}, query ->
        if search != "" and search != nil do
          search = search |> String.normalize(:nfd) |> String.replace(~r/[^A-z\s]/u, "")

          from c in query,
            where:
              ilike(c.name_unaccent, ^"%#{String.replace(search, "%", "\\%")}%") or
                ilike(c.start_date, ^"%#{String.replace(search, "%", "\\%")}%") or
                ilike(c.end_date, ^"%#{String.replace(search, "%", "\\%")}%") or
                ilike(c.destination_federative_unit, ^"%#{String.replace(search, "%", "\\%")}%") or
                ilike(c.home_federative_unit, ^"%#{String.replace(search, "%", "\\%")}%") or
                like(c.visited_cities, ^"%#{String.replace(search, "%", "\\%")}%")
        else
          query
        end
    end)
  end
end

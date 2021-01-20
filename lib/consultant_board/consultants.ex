defmodule ConsultantBoard.Consultants do
  @moduledoc """
  The Consultants context.
  """

  import Ecto.Query, warn: false
  alias ConsultantBoard.Repo

  alias ConsultantBoard.Consultants.Consultant

  @doc """
  Returns the list of consultants.

  ## Examples

      iex> list_consultants()
      [%Consultant{}, ...]

  """
  def list_consultants do
    Repo.all(Consultant)
  end

  @doc """
  Returns a list of consultants matching the given `criteria`.

  Example Criteria:

  [
   paginate: %{page: 2, per_page: 5},
   sort: %{sort_by: :name, sort_order: :asc}
  ]
  """

  def list_of_count_by_federative_unit do
    # query = from(c in Consultant)
    federatives_units = Repo.all(from(c in Consultant, select: c.federative_unit))

    federatives_units
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.map(&%{name: &1, quantity: Enum.count(federatives_units, fn x -> x == &1 end)})
  end

  def list_consultants(criteria) when is_list(criteria) do
    query = from(c in Consultant)

    query_builder(criteria, query)
    |> Repo.all()
  end

  def get_quantity_consultants(criteria) when is_list(criteria) do
    query = from(c in Consultant)

    {_, criteria} = Keyword.pop_first(criteria, :paginate)
    {_, criteria} = Keyword.pop_first(criteria, :sort)

    query_builder(criteria, query)
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Gets a single consultant.

  Raises `Ecto.NoResultsError` if the Consultant does not exist.

  ## Examples

      iex> get_consultant!(123)
      %Consultant{}

      iex> get_consultant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_consultant!(id), do: Repo.get!(Consultant, id)

  @doc """
  Creates a consultant.

  ## Examples

      iex> create_consultant(%{field: value})
      {:ok, %Consultant{}}

      iex> create_consultant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_consultant(attrs \\ %{}) do
    %Consultant{}
    |> Consultant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a consultant.

  ## Examples

      iex> update_consultant(consultant, %{field: new_value})
      {:ok, %Consultant{}}

      iex> update_consultant(consultant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_consultant(%Consultant{} = consultant, attrs) do
    consultant
    |> Consultant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a consultant.

  ## Examples

      iex> delete_consultant(consultant)
      {:ok, %Consultant{}}

      iex> delete_consultant(consultant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_consultant(%Consultant{} = consultant) do
    Repo.delete(consultant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking consultant changes.

  ## Examples

      iex> change_consultant(consultant)
      %Ecto.Changeset{data: %Consultant{}}

  """
  def change_consultant(%Consultant{} = consultant, attrs \\ %{}) do
    Consultant.changeset(consultant, attrs)
  end

  defp query_builder(criteria, query) do
    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_page: per_page}}, query ->
        from c in query,
          offset: ^((page - 1) * per_page),
          limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from c in query, order_by: [{^sort_order, ^sort_by}]

      {:filter, %{filter: federative_unit}}, query ->
        if federative_unit != "" and federative_unit != nil do
          from c in query,
            where: c.federative_unit == ^federative_unit
        else
          query
        end

      {:search, %{search: search}}, query ->
        if search != "" and search != nil do
          search = search |> String.normalize(:nfd) |> String.replace(~r/[^A-z\s]/u, "")

          from c in query,
            where:
              ilike(c.name_unaccent, ^"%#{String.replace(search, "%", "\\%")}%") or
                ilike(c.federative_unit, ^"%#{String.replace(search, "%", "\\%")}%") or
                like(c.city, ^"%#{String.replace(search, "%", "\\%")}%")
        else
          query
        end
    end)
  end
end

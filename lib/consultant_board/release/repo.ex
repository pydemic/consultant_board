defmodule ConsultantBoard.Release.Repo do
  @spec migrate :: :ok
  def migrate do
    load_app()
    Enum.each(repos(), &migrate_repo/1)
  end

  @spec rollback(atom, String.t()) :: :ok
  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
    :ok
  end

  defp migrate_repo(repo) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    :ok
  end

  defp repos do
    Application.fetch_env!(:consultant_board, :ecto_repos)
  end

  defp load_app do
    Application.load(:consultant_board)
  end
end

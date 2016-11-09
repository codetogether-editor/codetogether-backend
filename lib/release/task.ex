defmodule Codetogether.Release.Task do
  def migrate do
    ensure_started(Codetogether.Repo)

    path = Application.app_dir(:codetogether, "priv/repo/migrations")

    Ecto.Migrator.run(Codetogether.Repo, path, :up, all: true)

    :init.stop()
  end

  defp ensure_started(repo) do
    {:ok, _} = Application.ensure_all_started(:ecto)
    {:ok, _} = repo.__adapter__.ensure_all_started(repo, :temporary)

    case repo.start_link(pool_size: 1) do
      {:ok, pid} ->
        pid
      {:error, {:already_started, _pid}} ->
        nil
      {:error, error} ->
        raise "Could not start repo #{inspect repo}, error: #{inspect error}"
    end
  end
end

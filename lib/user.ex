defmodule Codetogether.User do
  @behaviour Guardian.Serializer

  alias Codetogether.{User, OAuth, Repo}

  import Ecto.Query, only: [from: 2]

  def by_id(id) do
    Repo.get!(User.Account, id)
  end

  def from_oauth(provider, code) do
    with {:ok, provider} <- OAuth.provider_module(provider),
         {:ok, client}   <- provider.get_token(code),
         {:ok, data}     <- provider.get_data(client) do
      get_user(data) || register_user(data)
    end
  end

  def from_token("User:" <> data) do
    destructure [provider, uid], String.split(data, ":", parts: 2)
    if account = Repo.one(by_authentication_query(uid, provider)) do
      {:ok, account}
    else
      {:error, "no such user"}
    end
  end

  def from_token(_), do: {:error, "bad user"}

  def for_token(%User.Account{current_authentication: %{uid: uid, provider: provider}}),
    do: {:ok, "User:#{provider}:#{uid}"}
  def for_token(_other),
    do: {:error, "bad user"}

  defp get_user(data) do
    case Repo.one(by_authentication_query(data.uid, data.provider)) do
      nil   -> nil
      value -> {:ok, value}
    end
  end

  def by_authentication_query(uid, provider) do
    from u in User.Account,
      join:    a in assoc(u, :authentications),
      where:   a.uid == ^(uid || "") and a.provider == ^(provider || ""),
      preload: :authentications,
      select:  %{u | current_authentication: a}
  end


  def register_user(data) do
    data
    |> build_account()
    |> Repo.insert
  end

  defp build_account(data) do
    %User.Account{name:            data.name,
                  email:           data.email,
                  avatar_url:      data.avatar_url,
                  authentications: [build_authentication(data)]}
  end

  defp build_authentication(data) do
    %User.Authentication{provider:      data.provider,
                         uid:           data.uid,
                         token:         data.token,
                         refresh_token: data.refresh_token,
                         expires_at:    data.expires_at}
  end
end

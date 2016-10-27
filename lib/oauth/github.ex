defmodule Codetogether.OAuth.GitHub do
  @behaviour OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
  alias Codetogether.OAuth

  # Public API

  def client do
    Codetogether.Config.get_keyword(__MODULE__)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def get_token(code) do
    client = client()
    params = [code: code, client_secret: client.client_secret]
    case OAuth2.Client.get_token(client, params) do
      {:ok, client} -> {:ok, client}
      {:error, _}   -> {:error, [code: "is invalid"]}
    end
  end

  def get_data(client) do
    case OAuth2.Client.get(client, "/user") do
      {:ok, %OAuth2.Response{status_code: 200, body: body}} ->
        load_email(client, body)
        # {:ok, response_to_data(body, client.token)}
      {:ok, %OAuth2.Response{status_code: code, body: body}} when code in 400..599 ->
        {:error, [code: body["message"]]}
      {:error, _reason} ->
        {:error, [code: "unexpected error"]}
    end
  end

  defp load_email(client, user) do
    case OAuth2.Client.get(client, "/user/emails") do
      {:ok, %OAuth2.Response{status_code: 200, body: body}} ->
        email = Enum.find(body, &(&1["primary"]))["email"]
        {:ok, response_to_data(user, email, client.token)}
      {:ok, %OAuth2.Response{status_code: code, body: body}} when code in 400..599 ->
        {:error, [code: body["message"]]}
      {:error, _reason} ->
        {:error, [code: "unexpected error"]}
    end
  end

  # Strategy Callbacks

  @doc false
  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  @doc false
  def get_token(client, params, headers) do
    client
    |> OAuth2.Client.put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end

  # Helper functions

  defp config do
    [strategy:      __MODULE__,
     site:          "https://api.github.com",
     authorize_url: "https://github.com/login/oauth/authorize",
     token_url:     "https://github.com/login/oauth/access_token"]
  end

  defp response_to_data(body, email, token) do
    %OAuth.Data{uid: to_string(body["id"]), provider: "github",
                name: body["name"], email: email,
                avatar_url: body["avatar_url"],
                token: token.access_token, refresh_token: token.refresh_token,
                expires_at: token.expires_at}
  end
end

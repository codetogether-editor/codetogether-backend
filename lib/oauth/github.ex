defmodule Codetogether.OAuth.GitHub do
  @behaviour OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [strategy:      __MODULE__,
     site:          "https://api.github.com",
     authorize_url: "https://github.com/login/oauth/authorize",
     token_url:     "https://github.com/login/oauth/access_token"]
  end

  # Public API

  def client do
    Codetogether.Config.get(__MODULE__)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def get_token!(params \\ [], headers \\ []) do
    params = Keyword.merge(params, client_secret: client().client_secret)
    OAuth2.Client.get_token!(client(), params, headers)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> OAuth2.Client.put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end

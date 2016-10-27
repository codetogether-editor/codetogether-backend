defmodule Codetogether.OAuth.Data do
  defstruct [:uid, :provider,
             :name, :email, :avatar_url,
             :token, :refresh_token, :expires_at]
end

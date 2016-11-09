defmodule Codetogether.Factory do
  use ExMachina.Ecto, repo: Codetogether.Repo

  alias Codetogether.User

  def user_factory do
    authentication = build(:authentication)
    %User.Account{name:       "Jane Smith",
                  email:      sequence(:email, &"email-#{&1}@example.com"),
                  avatar_url: "http://some.avatar.com/photo.jpg",
                  current_authentication: authentication,
                  authentications:        [authentication]}
  end

  def authentication_factory do
    %User.Authentication{provider: "github",
                         uid:      sequence(:uid, &"#{1000 + &1}"),
                         token:    "1234"}
  end
end

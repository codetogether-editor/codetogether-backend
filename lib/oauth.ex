defmodule Codetogether.OAuth do
  def provider_module("github"), do: {:ok, Codetogether.OAuth.GitHub}
  def provider_module(_),        do: {:error, [provider: "no such provider"]}
end

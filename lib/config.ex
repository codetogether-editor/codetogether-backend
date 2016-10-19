defmodule Codetogether.Config do
  @moduledoc """
  This module handles fetching values from the config with some additional niceties
  """

  @spec get(atom, term | nil) :: term
  def get(key, default \\ nil) when is_atom(key) do
    convert(Application.get_env(:codetogether, key), default)
  end

  @spec get_keyword(atom) :: term
  def get_keyword(key) when is_atom(key) do
    for {key, value} <- get(key, []), do: {key, convert(value, nil)}
  end

  defp convert({:system, env_var}, default),
    do: System.get_env(env_var) || default
  defp convert({:system, env_var, preconfigured_default}, _default),
    do: System.get_env(env_var) || preconfigured_default
  defp convert(nil, default),
    do: default
  defp convert(value, _default),
    do: value
end

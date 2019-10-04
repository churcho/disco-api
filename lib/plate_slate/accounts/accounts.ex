defmodule Disco.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Disco.Repo
  alias Comeonin.Ecto.Password

  alias Disco.Accounts.User

  def authenticate(role, email, password) do
    user = Repo.get_by(User, role: to_string(role), email: email)

    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end

  def lookup(role, id) do
    Repo.get_by(User, role: to_string(role), id: id)
  end
end

defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
   %{
    age: 19,
    address: "Tua rua",
    cep: "81900350",
    cpf: "12345678999",
    email: "justin@gmail.com",
    password: "1234567",
    name: "justin"
  }
  end

  def user_factory do
    %User{
    age: 19,
    address: "Tua rua",
    cep: "81900350",
    cpf: "12345678999",
    email: "justin@gmail.com",
    password: "1234567",
    name: "justin",
    id: "58672a0d-c27e-469a-9336-d0bcbaf8cde8"
    }
  end
end

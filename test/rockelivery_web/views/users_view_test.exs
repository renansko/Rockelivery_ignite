defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    token = "xpto1234"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "xpto1234",
             user: %Rockelivery.User{
               address: "Tua rua",
               age: 19,
               cep: "81900350",
               cpf: "12345678999",
               email: "justin@gmail.com",
               id: "58672a0d-c27e-469a-9336-d0bcbaf8cde8",
               inserted_at: nil,
               name: "justin",
               password: "1234567",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end

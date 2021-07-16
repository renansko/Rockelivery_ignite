defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "When all params are valid, creates the user", %{conn: conn} do
      params =
        %{
          "age" => 19,
          "address" => "Tua rua",
          "cep" => "81900350",
          "cpf" => "12345678999",
          "email" => "justin@gmail.com",
          "password" => "1234567",
          "name" => "justin"
        }
response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

        assert  %{
          "message" => "User created!",
          "user" => %{
            "address" => "Tua rua",
            "age" => 19,
            "cpf" => "12345678999",
            "email" => "justin@gmail.com",
            "id" => _id
          }
        } = response
    end

    test "When are some error, returs the error", %{conn: conn} do
      params =
        %{
          "age" => 19,
          "address" => "Tua rua",
        }

        response =
          conn
          |> post(Routes.users_path(conn, :create, params))
          |> json_response(:bad_request)

        expected_response =
          %{
            "message" => %{
              "cep" => ["can't be blank"],
              "cpf" => ["can't be blank"],
              "email" => ["can't be blank"],
              "name" => ["can't be blank"],
              "password" => ["can't be blank"]
            }
          }
          assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn}do
      id = "58672a0d-c27e-469a-9336-d0bcbaf8cde8"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

        assert response == ""
      end
    end
end

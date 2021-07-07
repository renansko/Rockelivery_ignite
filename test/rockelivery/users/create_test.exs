defmodule Rockelivery.Users.CreateTest do
 use Rockelivery.DataCase, async: true
 import Rockelivery.Factory


  alias Rockelivery.{Error, User}

  alias Rockelivery.Users.Create

  describe "call/1" do
    test "When all params are valid, returns the user" do
       params = build(:user_params)

       response = Create.call(params)

      assert {:ok, %User{id: _id, age: 19, email: "justin@gmail.com"}} = response
      end


      test "When there are invalid params, returns an error"  do
      params = build(:user_params, %{password: "123", age: 15})

      response = Create.call(params)

      expeceted_response = %{
      age: ["must be greater than or equal to 18"],
      password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expeceted_response
    end
  end
end

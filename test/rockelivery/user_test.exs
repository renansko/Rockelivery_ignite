defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, return a vailid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "justin"}, valid?: true} = response
    end

    test "when updating a changeset, return a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{name: "banana", password: "4567897"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "banana"}, valid?: true} = response
    end

    test "When the are some error, returns invalid changeset" do
      params = build(:user_params, %{"age" => 15, "password" => "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end

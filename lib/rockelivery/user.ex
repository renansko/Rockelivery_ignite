defmodule Rockelivery.User do
use Ecto.Schema
import Ecto.Changeset

alias Ecto.Changeset
alias Rockelivery.Order
@primary_key {:id, :binary_id, autogenerate: true}

@fields [:age, :address, :cep, :cpf, :email, :password, :name]

@derive {Jason.Encoder, only: [:id, :age, :cpf,:address, :email]}
schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    has_many :orders, Order

    timestamps()
  end

  def build(changeset), do: apply_action(changeset, :create)

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, min: 8)
    |> validate_length(:cpf, min: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    |> validate_format(:email, ~r/@/)
    |> put_password_hash()
  end
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end

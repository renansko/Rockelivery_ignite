defmodule Rockelivery.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.{Item, User}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:address, :comments, :payment_method, :user_id]
  @payment_method [:money, :credit_card, :debit_card]

  @derive {Jason.Encoder, only: @fields ++ [:id, :items]}
  schema "orders" do
    field :address, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: @payment_method

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 8)
    |> validate_length(:comments, min: 6)
  end
end

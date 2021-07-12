defmodule Rockelivery.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.Order
  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:category, :description, :price, :photo]

  @itens_categorys [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @fields ++ [:id]}
  schema "items" do
      field :category, Ecto.Enum, values: @itens_categorys
      field :description, :string
      field :price, :decimal
      field :photo, :string

      many_to_many :order, Order, join_through: "orders_items"


      timestamps()
    end

    def changeset(struct \\ %__MODULE__{}, params) do
      struct
      |> cast(params, @fields)
      |> validate_required(@fields)
      |> validate_length(:description, min: 6)
      |> validate_number(:price, greater_than: 0)
    end
  end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo}

user = %User{
  age: 27,
  address: "Rua das alameidas 203",
  cep: "123456",
  cpf: "78965432158"
  email: "tenebroso@cabuloso.com",
  password: "123456",
  name: "Jorge"
}

%User{id: user_id} = Repo.insert!(user)

item1= %Item{
  category: :food,
  description: "Banana",
  price: Decimal.new("15.05"),
  photo: "priv/photos/banana_cozida;png"
}

item2= %Item{
  category: :food,
  description: "Coca",
  price: Decimal.new("11.05"),
  photo: "priv/photos/coquita;png"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item2, item3],
  address: "Rua das alameidas",
  comments: "Sem canela",
  payment_method: :money
}

Repo.insert!(order)

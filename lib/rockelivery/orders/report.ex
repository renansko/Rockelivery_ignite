defmodule Rockelivery.Orders.Report do
  import Ecto.Query
  alias Rockelivery.{Repo, Order}

  def create(filename \\ "report.csv") do
    query = from order in Order, order_by: order.user_id

    Repo.transaction(fn ->
      query
      |> Repo.stream(max_rows: 4)
      |> Enum.map(fn item -> item end)
      |> IO.inspect()
    end)
  end
end

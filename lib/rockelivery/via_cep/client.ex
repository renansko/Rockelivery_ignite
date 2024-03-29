defmodule Rockelivery.ViaCep.Client do
  use Tesla

  @base_url "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  alias Tesla.Env
  alias Rockelivery.ViaCep.Behaviour
  alias Rockelivery.Error

  @behaviour Behaviour

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}#{cep}/json"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => true}}}) do
    {:error, Error.build(:not_found, "cep not found")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "invalid CEP")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end

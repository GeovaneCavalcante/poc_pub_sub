defmodule PocPubSubWeb.TesteController do
  use PocPubSubWeb, :controller

  def index(conn, _params) do
    dado = PocPubSub.Teste.publish_message("teste")
    IO.inspect(dado)

    conn
    |> put_status(200)
    |> json(%{message: "Bem vindo ao BananaBank", status: :ok})
  end
end

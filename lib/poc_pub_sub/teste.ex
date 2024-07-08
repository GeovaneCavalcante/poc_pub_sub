defmodule PocPubSub.Teste do
  alias GoogleApi.PubSub.V1.Api.Projects
  alias GoogleApi.PubSub.V1.Model.PublishRequest
  alias GoogleApi.PubSub.V1.Model.PubsubMessage
  alias GoogleApi.PubSub.V1.Connection

  @project_id "snmxgfihomh7g4qogpyop2qtu0dief"
  @topic_id "teste-banking"

  def publish_message(message) do
    token = Goth.fetch!(MyApp.Goth)

    conn = Connection.new(token.token)

    publish_request = %PublishRequest{
      messages: [
        %PubsubMessage{
          data: Base.encode64(message)
        }
      ]
    }

    case Projects.pubsub_projects_topics_publish(
           conn,
           @project_id,
           @topic_id,
           [body: publish_request],
           []
         ) do
      {:ok, response} ->
        IO.inspect(response, label: "Message Published Successfully")

      {:error, reason} ->
        IO.inspect(reason, label: "Failed to Publish Message")
    end
  end
end

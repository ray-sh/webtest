defmodule StudyWeb.CarsChannel do
  use StudyWeb, :channel
  def join("cars:*", _payload, socket) do
    :timer.send_after(1000, "refresh")
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_info("refresh", socket) do
    cars = HL7MessageQue.ready_messages()
    if length(cars) > 0, do: push(socket,"cars", %{cars: cars})
    :timer.send_after(5000, "refresh")
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (cars:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

defmodule StudyWeb.CarsChannel do
  use StudyWeb, :channel

  def join("cars:*", payload, socket) do
    # Process.send_after(self, "refresh", 5000)
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_info("refresh", socket) do
  #   broadcast!(socket, "refresh", %{cars: ["car1", "car2"]})
  #   Process.send_after(self, "refresh", 5000)
  #   {:noreply, socket}
  # end

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

defmodule HL7Sim do
    @default_port 5001
    @default_server {{127,0,0,1}, @default_port}

    @product_server {{35,185,137,46}, 5000}

    def start_server(port \\@default_port) do
        MLLP.Receiver.start(port, HL7MessageBox, false)
    end

    def connect_local(), do: connect(@default_server)

    def connect(server \\ @product_server) do
        {:ok, s} = MLLP.Sender.start_link(server)
        s
    end
 
    def send(socket) do
        MLLP.Sender.async_send_message(socket, SimMessage.msg1())
    end
end
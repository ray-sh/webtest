defmodule HL7Sim do
    @default_port 5001
    @default_server {{127,0,0,1}, @default_port}
    def start_server(port \\@default_port) do
        MLLP.Receiver.start(port)
    end

    def start_client() do
        {:ok, s1} = MLLP.Sender.start_link(@default_server)
        MLLP.Sender.send_message(s1, SimMessage.msg1())
    end 
end
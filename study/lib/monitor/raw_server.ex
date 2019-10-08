defmodule DataHub.Raw do
    require Logger
    def start_server(port \\5001) do
        {:ok, listen_socket} =
          :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    
        Logger.info("开始监听端口#{port}")
        dump(listen_socket)
        {:ok, file} = File.open("debug.txt", [:append])
        Task.start(__MODULE__, :loop_acceptor, [listen_socket,file])
      end

      def loop_acceptor(listen_socket,file) do
        # acceptor要做为一个server，这样才能处理不同的client连接
        {:ok, accept_socket} = :gen_tcp.accept(listen_socket)
        Logger.info("One client connected")
        Task.start(__MODULE__, :read_frame, [accept_socket,file])
        loop_acceptor(listen_socket,file)
      end


      def read_frame(socket, file, buffer\\"") do
        Logger.info("start read data from socket with buffer #{buffer}")
    
        case :gen_tcp.recv(socket, 0) do
          {:ok, data} ->
            data =
            data
            |>String.replace(<<0x0b>>,"SB")
            |>String.replace(<<0x1c>>,"EB")
            
            IO.binwrite(file,data)
            read_frame(socket,file)
            # case String.split(data, <<0x1c,0x0d>>) do
            #   #没有结束符
            #   [data] ->
            #     read_frame(socket,file, buffer <> data)
            #   #发现结束符号，返回Frame，和下一个Frame的开始
            #   data ->
            #     last = handle_frame(data,file)
            #     Logger.info("Put data #{last} to buffer")
            #     read_frame(socket, file,buffer <> last)
            # end
          {:error, :closed} ->
            Logger.info("Funciton read_line error, close the socket")
            :gen_tcp.close(socket)
            raise "client closed"
        end        
      end
      
      defp handle_frame(data,file) do
        Logger.info("handle Frame ")
        #IO.inspect(data)
        {last, rest} = List.pop_at(data,-1)
        rest
        |>Enum.each(fn x -> 
          IO.binwrite(file,"=====")
          IO.binwrite(file,x)
          IO.binwrite(file,"=====")
        end)
        last
      end

      
      def trim_last_two_bytes(binary) do
        bits = bit_size(binary)
        binary
        |>IO.inspect()
        |> binary_part(0,div(bits - 16, 8))
      end

      defp dump(socket) do
        socket
        |> Port.info()
        |> IO.inspect()
      end
end
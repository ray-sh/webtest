defmodule DataHub do
  require Logger

  def accept(port) do
    #配置server的端口，参数
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    Logger.info("监听server的端口")
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    Logger.info("loop 读取socket里面的数据")
    read_line(socket)
    serve(socket)
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0) do
        {:ok, data} ->      
            Logger.info("Receive data #{data}")
        {:error, reason} ->
            Logger.info("Failed read line with reason #{reason}")
    end
    
  end

end
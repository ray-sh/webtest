defmodule DataHub do
  require Logger

  def start_server(port) do
    # 配置server的端口，参数，listen函数会真正占用这个端口，并且开始监听
    #可以用lsof -i tcp:5000来验证
    #可以用telnet host port 或者nc host port来作为client
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("开始监听端口#{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    #acceptor要做为一个server，这样才能处理不同的client连接
    {:ok, client} = :gen_tcp.accept(socket)
    #client是个#Port类型的数据
    Logger.info("One client connected")
    client
    |>IO.inspect()
    #|>serve()
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
        :gen_tcp.close(socket)
    end
  end
end

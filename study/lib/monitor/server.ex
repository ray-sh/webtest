defmodule DataHub do
  require Logger

  def start_server(port) do
    # 配置server的端口，参数，listen函数会真正占用这个端口，并且开始监听
    # 可以用lsof -i tcp:5000来验证
    # 可以用telnet host port 或者nc host port来作为client
    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("开始监听端口#{port}")
    dump(listen_socket)
    #Task.start(__MODULE__, :loop_acceptor, [listen_socket])
    Task.start(__MODULE__, :active_listen, [listen_socket])

  end

  def active_listen(listen_socket) do
    {:ok, accept_socket} = :gen_tcp.accept(listen_socket)
    Task.start(__MODULE__, :active_serve, [accept_socket])
    active_listen(listen_socket)
  end

  def active_serve(accept_socket) do
    #ative 模式，创建process的进程来处理，保存client发来的消息
    {:ok, handler} = DynamicSupervisor.start_child(Monitor.DynamicSupervisor, MsgHandler)
    Port.connect(accept_socket,handler)
    :inet.setopts(accept_socket, [active: true])
  end

  def loop_acceptor(listen_socket) do
    # acceptor要做为一个server，这样才能处理不同的client连接
    {:ok, accept_socket} = :gen_tcp.accept(listen_socket)
    # client是个#Port类型的数据
    # Ports provide a mechanism to start operating system processes external to the Erlang VM and
    # communicate with them via message passing
    Logger.info("One client connected")
    dump(accept_socket)

    '''
    IO.inspect(client)
    port的内容,这里没有真正的os pid，port可以理解为某种资源的容器，用来和VM隔离，达到并发和隔离的效果
    ??如何与这个Port交互？通过:gen_tcp里面的函数
        [
            name: 'tcp_inet',
            links: [#PID<0.288.0>],
            id: 400,
            connected: #PID<0.288.0>,
            input: 0,
            output: 0,
            os_pid: :undefined
          ]
    '''

    Task.start(__MODULE__, :serve, [accept_socket])
    loop_acceptor(listen_socket)
  end

  def serve(socket) do
    Logger.info("loop 读取socket里面的数据")
    read_line(socket)
    serve(socket)
  end

  defp read_line(socket) do
    Logger.info("start read data from socket")

    case :gen_tcp.recv(socket, 0) do
      {:ok, <<0x0B, data::binary>>} ->
        data =
        trim_last_two_bytes(data)
        Logger.info("Receive data #{String.trim(data)}")

      {:ok, data} ->
        IO.inspect(data)
        Logger.info("Receive data #{String.trim(data)}")

      {:error, :closed} ->
        Logger.info("Funciton read_line error, close the socket")
        :gen_tcp.close(socket)
        raise "client closed"
    end
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

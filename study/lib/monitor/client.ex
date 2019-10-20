defmodule DataClient do
  def connect() do
    {:ok, socket} = :gen_tcp.connect('localhost', 5001, [:binary])
    {:ok, client} = Task.start(__MODULE__, :send_info, [socket, 1])
    client
  end

  def send_info(socket, 5), do: :gen_tcp.close(socket)

  def send_info(socket, temp) do
    # \n is the newline character, 
    # while \r is the carriage return.
    # They differ in what uses them. 
    # Windows uses \r\n to signify the enter key was pressed, 
    # while Linux and Unix use \n to signify that the enter key was pressed.

    # 如果没有“\n”,数据能发过去吗？server那里如何知道数据发送完成？他是通过EOF来识别
    # 如果最后一个字符不是\n,send数据能发过去吗？
    # "\n" = <<10>>
    :gen_tcp.send(socket, <<0x0B>> <> "The temperature is #{temp}" <> <<0x1C, 0x0D, 10>>)
    # timer.sleep的单位时毫秒
    :timer.sleep(5000)
    send_info(socket, temp + 1)
  end
end

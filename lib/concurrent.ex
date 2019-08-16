defmodule Concurrent do
  use Application

  @impl true
  def start(_type, _args) do
    Concurrent.Supervisor.start_link(name: Concurrent.Supervisor)
  end

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

      loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
		  |> read_line()
	    |> write_line(socket)

   	serve(socket)
  end

	defp read_line(socket) do
	  {:ok, data} = :gen_tcp.recv(socket, 0)
		data
	end

	defp write_line(line, socket) do
	  :gen_tcp.send(socket, line)
	end
end

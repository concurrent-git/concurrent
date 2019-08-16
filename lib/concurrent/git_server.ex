defmodule Concurrent.GitServer do
  use GenServer

	@impl true
	def init(:ok) do
		{:ok, %{}}
  end

	def start_link(opts) do
	  GenServer.start_link(__MODULE__, :ok, opts)
	end
end

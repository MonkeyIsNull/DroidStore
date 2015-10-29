defmodule DroidStore do
  use GenServer

  # Server API
  def start_link(droids, name) do
    GenServer.start_link(__MODULE__, droids, name: name)
  end

  def handle_call(:list, _pid, current_droids) do
    {:reply, current_droids, current_droids}
  end

  def handle_call({:add, droid}, _pid, current_droids) do
    droids = [ droid | current_droids ]
    {:reply, droids, droids}
  end

  def handle_call({:remove, droid}, _pid, current_droids) do
    case droid in current_droids do
      true ->
         droids = List.delete(current_droids, droid)
        {:reply, {:ok, droids}, droids}
      false ->
        {:reply, :not_found, current_droids}
    end
  end

  def handle_cast({:stop, reason}, droids) do
    {:stop, reason, droids}
  end

  def terminate(reason, _droids) do
    # your final chance to do something
    IO.puts "Closing for #{reason}"
    :ok
  end

  def handle_call(:crash, _pid, current_droids) do
    9/0
    {:reply, current_droids, current_droids}
  end

  # Client API
  def init(droids) do
    IO.puts "initializing store..."
    {:ok, droids}
  end

  def list(srv_pid) do
    GenServer.call(srv_pid, :list)
  end

  def add(srv_pid, droid) do
    GenServer.call(srv_pid, {:add, droid})  
  end

  def remove(srv_pid, droid) do
    GenServer.call(srv_pid, {:remove, droid})
  end

  def close(srv_pid, reason) do
    GenServer.cast(srv_pid, {:stop, reason}) 
  end

  def crash(srv_pid) do
    GenServer.call(srv_pid, :crash)
  end
end

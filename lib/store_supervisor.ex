defmodule StoreSupervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    IO.puts "Supervisor initializing...."
    kids = [worker(DroidStore, [["bb8"], :mose], id: :mose_sup),
            worker(DroidStore, [["c3po"], :hoth], id: :hoth_sup),
            worker(DroidStore, [["r2d2"], :dagobah], id: :dagobah_sup)]
    supervise(kids, strategy: :one_for_one)
  end

end


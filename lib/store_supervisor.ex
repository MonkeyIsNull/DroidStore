defmodule StoreSupervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil)
  end

  def start_rebel_link() do
    kids = [worker(DroidStore, [["bb8"], :mose], id: :mose_sup),
            worker(DroidStore, [["c3po"], :hoth], id: :hoth_sup),
            worker(DroidStore, [["r2d2"], :dagobah], id: :dagobah_sup)]
    Supervisor.start_link(__MODULE__, kids, name: :rebel_sup)
  end

  def start_imperial_link() do
    kids = [worker(DroidStore, [["ig-88"], :coruscant], id: :coruscant_sup),
            worker(DroidStore, [["azi-3"], :imperial_palace], id: :iimperial_palace_sup)]
    Supervisor.start_link(__MODULE__, kids, name: :imperial_sup)
  end

  def o_init(_) do
    IO.puts "Supervisor initializing...."
    kids = [worker(DroidStore, [["bb8"], :mose], id: :mose_sup),
            worker(DroidStore, [["c3po"], :hoth], id: :hoth_sup),
            worker(DroidStore, [["r2d2"], :dagobah], id: :dagobah_sup)]
    supervise(kids, strategy: :one_for_one)
  end

  def init(kids) do
    IO.puts "Supervisor initializing...."
    supervise(kids, strategy: :one_for_one)
  end

end


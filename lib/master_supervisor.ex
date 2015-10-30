defmodule MasterSupervisor do
  use Supervisor

  def start_link(_) do
     Supervisor.start_link(__MODULE__, [], name: :master_sup)
  end

  def init(_) do
    kids = [worker(StoreSupervisor, [], id: :rebel_sup, function: :start_rebel_link),
            worker(StoreSupervisor, [], id: :imp_sup, function: :start_imperial_link)]
    supervise(kids, strategy: :one_for_one) 
  end
end


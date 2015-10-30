defmodule Realm do
  use Application

  def start(_type, _args) do 
    MasterSupervisor.start_link(nil)
  end


end


defmodule DroidStoreTest do
  use ExUnit.Case
  doctest DroidStore

  test "start, add, add, list, remove  and stop" do
    {:ok, srv} = DroidStore.start_link(["r2d2"])
    DroidStore.add(srv, "c3po")
    DroidStore.add(srv, "bb8")
    assert ["bb8", "c3po", "r2d2"] == DroidStore.list(srv)
    assert {:ok, ["bb8", "r2d2"]}  == DroidStore.remove(srv, "c3po")
    assert :not_found  == DroidStore.remove(srv, "Darth Vader")
    assert :ok == DroidStore.close(srv, "Imperial Invasion")
  end
end

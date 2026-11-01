defmodule ScratchKitchen.Share.Board do
  @moduledoc """
  Share board state machine, as a GenServer-style Agent sketch.
  planned -> packed -> offered -> picked_up -> delivered.
  No automatic dispatch, no payment, no courier booking in v1.
  A named human coordinator completes pickup and delivery.
  """
  use Agent

  def start_link(_opts \\ []) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_offer(offer), do: Agent.update(__MODULE__, &[offer | &1])
  def offers, do: Agent.get(__MODULE__, & &1)
  def by_status(status), do: offers() |> Enum.filter(&(&1.status == status))
end

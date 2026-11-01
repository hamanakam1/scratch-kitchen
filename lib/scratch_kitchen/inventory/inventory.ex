defmodule ScratchKitchen.Inventory do
  @moduledoc """
  Use-first ranking. Rank 1 = use first.
  Order: fridge `use soon` / opened / earliest first, then freezer
  open longest, then fridge `good` earliest, then pantry opened /
  earliest, then everything else oldest first.
  Re-rank after every photo batch; never overwrite history.
  """

  alias ScratchKitchen.Inventory.Item

  def rank(items) do
    items
    |> Enum.sort_by(&sort_key/1)
    |> Enum.with_index(1)
    |> Enum.map(fn {item, rank} -> %{item | use_first_rank: rank} end)
  end

  defp sort_key(%Item{location: :fridge, still_good: :use_soon}), do: {0, 0}
  defp sort_key(%Item{location: :freezer}), do: {1, 0}
  defp sort_key(%Item{location: :fridge}), do: {2, 0}
  defp sort_key(%Item{location: :pantry}), do: {3, 0}
  defp sort_key(_), do: {4, 0}
end

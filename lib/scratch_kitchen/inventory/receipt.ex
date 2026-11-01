defmodule ScratchKitchen.Inventory.Receipt do
  @moduledoc """
  Receipt (and any document) ingestion with smart deduplication.
  A receipt line must never blindly double inventory.
  Outcomes: :already_inventoried, :probable_match, :new_item, :conflict.
  """

  @doc """
  Match receipt lines against existing inventory names.
  Exact match -> already_inventoried. No match -> new_item.
  Normalised close matches are probable_match, not auto-merged.
  """
  def match_lines(receipt_lines, inventory_names) do
    Enum.map(receipt_lines, fn line ->
      cond do
        line in inventory_names -> {line, :already_inventoried}
        probable_match?(line, inventory_names) -> {line, :probable_match}
        true -> {line, :new_item}
      end
    end)
  end

  defp probable_match?(line, names) do
    normalised = normalise(line)
    Enum.any?(names, &(normalise(&1) == normalised or String.contains?(normalise(&1), normalised)))
  end

  defp normalise(s), do: s |> String.downcase() |> String.replace(~r/[^a-z0-9]/, "")
end

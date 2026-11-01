defmodule ScratchKitchen.Inventory.Receipt do
  @moduledoc """
  Receipt (and any document) ingestion with smart deduplication.
  A receipt line must never blindly double inventory.
  Outcomes: :already_inventoried, :probable_match, :new_item, :conflict.
  A receipt never overrides a later video, and price alone never creates
  an inventory item.
  """

  @doc """
  Match receipt lines against existing inventory names.
  Exact match -> already_inventoried. No match -> new_item.
  Normalised close matches are probable_match, not auto-merged.
  """
  def match_lines(receipt_lines, inventory_names) do
    Enum.map(receipt_lines, fn line ->
      name = line_name(line)
      cond do
        conflict?(line, inventory_names) -> {name, :conflict}
        name in inventory_names -> {name, :already_inventoried}
        probable_match?(name, inventory_names) -> {name, :probable_match}
        true -> {name, :new_item}
      end
    end)
  end

  defp line_name({name, _qty, _date}), do: name
  defp line_name(name) when is_binary(name), do: name

  defp conflict?({name, qty, date}, inventory_names) do
    # Conflict when a matching item exists but quantity/date disagree.
    name in inventory_names and (qty == :mismatch or date == :after_used)
  end
  defp conflict?(_, _), do: false

  defp probable_match?(line, names) do
    normalised = normalise(line)
    Enum.any?(names, fn n ->
      n2 = normalise(n)
      n2 != normalised and (n2 == normalised or String.contains?(n2, normalised) or String.contains?(normalised, n2))
    end)
  end

  defp normalise(s) do
    s |> String.downcase() |> String.replace(~r/[^a-z0-9]+/, "") |> String.trim()
  end
end

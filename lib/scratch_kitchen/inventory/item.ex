defmodule ScratchKitchen.Inventory.Item do
  @moduledoc """
  One inventoried kitchen item. Still-good judgement is the cook's
  judgement, never a food-safety guarantee. Unknown fields stay nil,
  they are never guessed.
  """

  @enforce_keys [:id, :name, :photo_file, :photo_date, :location]
  defstruct [
    :id,
    :name,
    :photo_file,
    :photo_date,
    :location,
    :quantity_estimate,
    :unit,
    :bought_date,
    :opened_date,
    :notes,
    still_good: :good,
    use_first_rank: nil
  ]

  @type still_good :: :good | :use_soon | :check | :do_not_use
  @type location :: :freezer | :fridge | :pantry | :prepared

  @doc "True only for items safe to propose for a giveaway share batch."
  def shareable?(%__MODULE__{still_good: good}), do: good in [:good, :use_soon]
end

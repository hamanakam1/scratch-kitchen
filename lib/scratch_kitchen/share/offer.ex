defmodule ScratchKitchen.Share.Offer do
  @moduledoc """
  A share offer. Giveaway and cottage sale are separate tracks,
  never relabelled. An offer needs the cook's approval for that
  specific batch, item, quantity, and date — no blanket approval.
  """

  @enforce_keys [:id, :meal_id, :items, :quantity, :date_prepared, :track]
  defstruct [
    :id,
    :meal_id,
    :items,
    :quantity,
    :date_prepared,
    :track,
    :allergens,
    status: :planned,
    approved: false
  ]

  @type track :: :giveaway | :cottage_sale
  @type status :: :planned | :packed | :offered | :picked_up | :delivered | :cancelled

  def approve(%__MODULE__{} = offer), do: %{offer | approved: true}
  def advance(%__MODULE__{status: :planned} = o), do: %{o | status: :packed}
  def advance(%__MODULE__{status: :packed} = o), do: %{o | status: :offered}
  def advance(%__MODULE__{status: :offered} = o), do: %{o | status: :picked_up}
  def advance(%__MODULE__{status: :picked_up} = o), do: %{o | status: :delivered}
  def advance(o), do: o
end

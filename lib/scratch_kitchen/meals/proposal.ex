defmodule ScratchKitchen.Meals.Proposal do
  @moduledoc """
  A specific meal proposal. Every proposal has a meal, a ready time,
  a person, and the inventory items it uses. No invented items:
  a proposal that needs an item not in inventory is not a proposal,
  it is a shopping-list entry.
  """

  @enforce_keys [:id, :name, :description, :ready_at, :for_person, :uses]
  defstruct [:id, :name, :description, :ready_at, :for_person, :uses, uses_up: [], leftover: :none]

  @doc "Descriptions are small and simple: 40 words max, enforced."
  def valid_description?(description) when is_binary(description) do
    description |> String.split() |> length() <= 40
  end
end

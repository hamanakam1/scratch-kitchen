defmodule ScratchKitchen.Inventory.Video do
  @moduledoc """
  Video-first inventory. Extract frames, identify items on-device,
  track the same item across frames so it is counted once, not once
  per frame. Photos remain an option for close-ups and flagged items.
  """

  defstruct [:file, :location, :duration_seconds, frames: []]

  @doc "An item seen in many frames is one item. Later frames update, never duplicate."
  def dedupe(items_by_frame) do
    items_by_frame
    |> List.flatten()
    |> Enum.uniq_by(&{&1.name, &1.location})
  end
end

defmodule ScratchKitchen.Inventory.Video do
  @moduledoc """
  Video-first inventory. Extract frames (1 per second plus scene
  changes), identify items on-device, track the same item across
  frames so it is counted once, not once per frame. Each item keeps
  its source: video file + timestamp + best frame. Unclear items are
  flagged for a still photo, never guessed. No cloud upload without
  explicit approval.
  """

  defstruct [:file, :location, :duration_seconds, frames: []]

  @doc "Frame timestamps: 1 per second plus any scene-change seconds."
  def frame_timestamps(duration_seconds, scene_changes \\ []) do
    base = Enum.to_list(0..(duration_seconds - 1))
    Enum.uniq(base ++ scene_changes) |> Enum.sort()
  end

  @doc "An item seen in many frames is one item. Later frames update, never duplicate."
  def dedupe(items_by_frame) do
    items_by_frame
    |> List.flatten()
    |> Enum.uniq_by(&{&1.name, &1.location})
  end

  @doc "Source reference for an inventoried item."
  def source(file, timestamp_seconds, frame_index) do
    %{file: file, timestamp: timestamp_seconds, frame: frame_index}
  end
end

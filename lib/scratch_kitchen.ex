defmodule ScratchKitchen do
  @moduledoc """
  Scratch Kitchen: photo-first kitchen app.
  Inventory from photos, specific meals from ingredients on hand,
  reuse into new meals, share the extra.
  See README.md and docs/spec.md.
  """
end

defmodule ScratchKitchen.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [ScratchKitchen.Share.Board]
    Supervisor.start_link(children, strategy: :one_for_one, name: ScratchKitchen.Supervisor)
  end
end

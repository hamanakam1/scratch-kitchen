defmodule ScratchKitchenTest do
  use ExUnit.Case, async: true
  alias ScratchKitchen.Meals.{Proposal, Reuse}
  alias ScratchKitchen.Inventory.Item

  test "meal descriptions are 40 words max" do
    assert Proposal.valid_description?("Herb chicken soup, small bowl, crusty bread.")
    refute Proposal.valid_description?(String.duplicate("word ", 41))
  end

  test "reuse into a new meal is allowed, re-serving the same meal is not" do
    assert {:ok, _} = Reuse.transform("roast chicken", "chicken soup", "roast chicken")
    assert {:error, :same_meal_reserved} = Reuse.transform("chicken soup", "chicken soup", "chicken soup")
  end

  test "only good / use soon items are shareable" do
    assert Item.shareable?(%Item{id: "1", name: "soup", photo_file: "f.jpg", photo_date: ~D[2026-10-31], location: :prepared, still_good: :good})
    refute Item.shareable?(%Item{id: "2", name: "soup", photo_file: "f.jpg", photo_date: ~D[2026-10-31], location: :prepared, still_good: :check})
  end
end

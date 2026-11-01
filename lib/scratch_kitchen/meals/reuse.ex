defmodule ScratchKitchen.Meals.Reuse do
  @moduledoc """
  Reuse, not leftovers. An ingredient may be reused into a NEW meal.
  A served meal may not be re-served as the same meal.
  Every transformation must be named, e.g. roasted chicken -> chicken soup.
  """

  @doc """
  Transform an ingredient into a new meal's ingredient.
  Returns {:ok, transformation} or {:error, :same_meal_reserved}
  if the proposed meal is the same as the served meal.
  """
  def transform(served_meal, new_meal, ingredient) when served_meal != new_meal do
    {:ok, %{from: served_meal, to: new_meal, ingredient: ingredient}}
  end

  def transform(served_meal, served_meal, _ingredient) do
    {:error, :same_meal_reserved}
  end
end

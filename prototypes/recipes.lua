data:extend {
  {
    type = "recipe",
    name = "carriage",
    enabled = false,
    energy_required = 3,
    ingredients = {
      { type = "item", name = "wood",            amount = 20 },
      { type = "item", name = "iron-plate",      amount = 10 },
      { type = "item", name = "iron-gear-wheel", amount = 10 },
    },
    results = { { type = "item", name = "carriage", amount = 1 } },
  },
  {
    type = "recipe",
    name = "waypoint",
    enabled = false,
    energy_required = 1,
    ingredients = {
      { type = "item", name = "wood", amount = 5 },
    },
    results = { { type = "item", name = "waypoint", amount = 1 } },
  },
}

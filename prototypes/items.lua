data:extend {
  {
    type = "rail-planner",
    name = "route",
    icon = GRAPHICSPATH .. "icon/route.png",
    icon_size = 64,
    localised_name = { "item-name.route" },
    flags = { "only-in-cursor" },
    order = "a[route-system]-a[route]",
    place_result = "straight-route",
    stack_size = 100,
    rails = {
      "straight-route",
      "half-diagonal-route",
      "curved-route-a",
      "curved-route-b",
    }
  },
  {
    type = "item-with-entity-data",
    name = "carriage",
    icon = GRAPHICSPATH .. "icon/carriage.png",
    icon_size = 64,
    flags = {},
    order = "a[route-system]-g[carriage]",
    place_result = "carriage",
    stack_size = 1,
  },
  {
    type = "item-with-entity-data",
    name = "carriage-engine",
    icon = data.raw["locomotive"]["locomotive"].icon,
    hidden = true,
    order = "a[route-system]-z[carriage-engine]",
    place_result = "carriage-engine",
    stack_size = 5,
  },
}

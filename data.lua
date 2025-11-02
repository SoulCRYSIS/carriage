-- Carriage Mod - Data Prototypes

-- Note: Rail categories are automatically created when first used in rail_category properties
-- No need to define them explicitly as prototypes

-- Carriage Track Item
data:extend({
  {
    type = "item",
    name = "carriage-track",
    icon = "__base__/graphics/icons/rail.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "transport",
    order = "a[transport-system]-a[rail]",
    place_result = "carriage-track",
    stack_size = 100
  }
})

-- Carriage Track Entity (simplified rail)
-- Reference base rail entity for Factorio 2.0 compatibility
local base_rail = nil
if data.raw["straight-rail"] and data.raw["straight-rail"]["straight-rail"] then
  base_rail = data.raw["straight-rail"]["straight-rail"]
else
  -- Fallback if base rail doesn't exist
  base_rail = {}
end

data:extend({
  {
    type = "straight-rail",
    name = "carriage-track",
    icon = "__base__/graphics/icons/rail.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "building-direction-8-way"},
    minable = {mining_time = 0.1, result = "carriage-track"},
    max_health = 100,
    corpse = "straight-rail-remnants",
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-0.7, -0.7}, {0.7, 0.7}},
    rail_category = "carriage",
    -- Copy pictures from base rail if available
    pictures = base_rail.pictures,
    walking_sound = base_rail.walking_sound,
    working_sound = base_rail.working_sound,
    build_effect = "straight-rail-build-effect",
    rail_overlay_visualisation = base_rail.rail_overlay_visualisation,
    collision_mask = {
      layers = {
        rail = true,
        floor = true,
        water_tile = true
      }
    },
    use_inventory_size = false,
    order = "a[transport-system]-a[rail]"
  }
})

-- Carriage Item (acts as locomotive)
data:extend({
  {
    type = "item",
    name = "carriage",
    icon = "__carriage__/graphics/icons/carriage.png",
    icon_size = 64,
    subgroup = "transport",
    order = "a[transport-system]-b[carriage]",
    place_result = "carriage",
    stack_size = 50
  }
})


-- Carriage Entity (locomotive with cargo inventory)
-- Copy base locomotive and modify it to have cargo space
local base_loco = data.raw["locomotive"]["locomotive"]
if base_loco then
  local carriage = table.deepcopy(base_loco)
  carriage.name = "carriage"
  carriage.icon = "__carriage__/graphics/icons/carriage.png"
  carriage.minable = {mining_time = 0.5, result = "carriage"}
  carriage.rail_category = "carriage"
  carriage.max_speed = 0.4  -- Slower than regular trains
  carriage.max_power = "200kW"  -- Less power
  
  -- Use cargo wagon graphics instead of locomotive graphics
  local base_cargo = data.raw["cargo-wagon"]["cargo-wagon"]
  if base_cargo then
    carriage.pictures = base_cargo.pictures
    carriage.horizontal_doors = base_cargo.horizontal_doors
    carriage.vertical_doors = base_cargo.vertical_doors
  end
  
  -- No fuel required - will be kept energized via control script
  if carriage.burner then
    carriage.burner.fuel_inventory_size = 1
    carriage.burner.burnt_inventory_size = 1
  end
  
  data:extend({carriage})
end

-- Carriage Station Item
data:extend({
  {
    type = "item",
    name = "carriage-station",
    icon = "__carriage__/graphics/icons/carriage-station.png",
    icon_size = 64,
    subgroup = "transport",
    order = "a[transport-system]-c[carriage-station]",
    place_result = "carriage-station",
    stack_size = 10
  }
})


-- Storage Chest for Carriage Station (hidden entity)
data:extend({
  {
    type = "container",
    name = "carriage-station-storage",
    icon = "__base__/graphics/icons/iron-chest.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "not-blueprintable", "not-deconstructable", "not-upgradable", "not-on-map", "hide-alt-info"},
    minable = nil,
    max_health = 1,
    corpse = nil,
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    inventory_size = 200,
    picture = {
      filename = "__core__/graphics/empty.png",
      width = 1,
      height = 1
    },
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75}
  }
})

-- Carriage Station Entity (large train stop with storage)
-- Copy base train stop for full Factorio 2.0 compatibility
local base_station = data.raw["train-stop"] and data.raw["train-stop"]["train-stop"]
if base_station then
  local station = table.deepcopy(base_station)
  station.name = "carriage-station"
  station.minable = {mining_time = 0.5, result = "carriage-station"}
  station.rail_category = "carriage"
  
  data:extend({station})
end

-- Free/cheap recipe for carriage track
-- Using minimal ingredients to satisfy Factorio 2.0 quality mod recycling requirements
data:extend({
  {
    type = "recipe",
    name = "carriage-track",
    enabled = true,
    energy_required = 0.5,
    ingredients = {
      {type = "item", name = "wood", amount = 1}
    },
    results = {
      {type = "item", name = "carriage-track", amount = 10} -- High yield = effectively free
    },
    allow_productivity = false,
    allow_decomposition = false -- Disable recycling
  }
})

-- Recipe for carriage
data:extend({
  {
    type = "recipe",
    name = "carriage",
    enabled = true,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 20},
      {type = "item", name = "iron-gear-wheel", amount = 10},
      {type = "item", name = "wood", amount = 10}
    },
    results = {
      {type = "item", name = "carriage", amount = 1}
    }
  }
})

-- Recipe for carriage station
data:extend({
  {
    type = "recipe",
    name = "carriage-station",
    enabled = true,
    energy_required = 3,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 50},
      {type = "item", name = "iron-gear-wheel", amount = 20},
      {type = "item", name = "copper-plate", amount = 20},
      {type = "item", name = "stone", amount = 20}
    },
    results = {
      {type = "item", name = "carriage-station", amount = 1}
    }
  }
})

-- Make carriages use carriage rail category (category already defined at top of file)
local carriage = data.raw["locomotive"]["carriage"]
if carriage then
  carriage.rail_category = "carriage"
end

-- Make carriage stations use carriage rail category
if data.raw["train-stop"] and data.raw["train-stop"]["carriage-station"] then
  data.raw["train-stop"]["carriage-station"].rail_category = "carriage"
end


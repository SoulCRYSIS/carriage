----- Carriage -----
local carriage_max_speed = 0.3

local carriage = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
carriage.name = "carriage"
carriage.icon = "__carriage__/graphics/icons/carriage.png"
carriage.flags = { "placeable-neutral", "player-creation", "placeable-off-grid" }
carriage.allow_copy_paste = true
carriage.minable = { mining_time = 0.5, result = "carriage" }
carriage.max_health = 250
-- carriage.corpse = "carriage-remnants"
carriage.collision_box = { { -0.2, -0.45 }, { 0.2, 0.45 } }
carriage.selection_box = { { -0.2, -0.4 }, { 0.2, 0.4 } }
carriage.selection_priority = 51
carriage.connection_distance = 1
carriage.joint_distance = 5
carriage.weight = 1000
carriage.inventory_size = 10
carriage.max_speed = carriage_max_speed
carriage.air_resistance = 0.1
carriage.pictures = {
  rotated = {
    layers = {
      {
        priority = "low",
        width = 256,
        height = 256,
        direction_count = 32,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage/main.png",
        line_length = 4,
        lines_per_file = 8,
        scale = 1,
      },
      {
        priority = "low",
        width = 256,
        height = 256,
        direction_count = 32,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage/shadow.png",
        line_length = 4,
        lines_per_file = 8,
        scale = 1,
        draw_as_shadow = true,
      }
    }
  }
}
-- carriage.vertical_doors = nil
-- carriage.horizontal_doors = nil
carriage.wheels = nil
-- carriage.working_sound =
-- carriage.drive_over_tie_trigger = nil
carriage.minimap_representation = {
  filename = "__carriage__/graphics/entities/carriage/minimap-representation.png",
  flags = { "icon" },
  size = { 26, 56 },
  scale = 0.5
}
carriage.selected_minimap_representation = {
  filename = "__carriage__/graphics/entities/carriage/selected-minimap-representation.png",
  flags = { "icon" },
  size = { 26, 56 },
  scale = 0.5
}
carriage.corpse = nil
-- carriage.factoriopedia_simulation = nil

----- Carriage Engine (Hidden) -----
local carriage_engine = table.deepcopy(data.raw["locomotive"]["locomotive"])
carriage_engine.name = "carriage-engine"
carriage_engine.minable = { mining_time = 0.5, result = nil }
carriage_engine.flags = { "placeable-neutral", "player-creation", "placeable-off-grid" }
carriage_engine.hidden_in_factoriopedia = true
carriage_engine.allow_copy_paste = true
carriage_engine.weight = 1000
carriage_engine.max_speed = carriage_max_speed
carriage_engine.max_power = "200kW"
carriage_engine.air_resistance = 0.1
carriage_engine.collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } }
carriage_engine.selection_box = { { -0.1, -0.1 }, { 0.1, 0.1 } }
carriage_engine.selection_priority = 51
carriage_engine.connection_distance = 1
carriage_engine.joint_distance = 5
carriage_engine.pictures = nil
carriage_engine.minimap_representation = nil
carriage_engine.selected_minimap_representation = nil
carriage_engine.water_reflection = nil
carriage_engine.wheels = nil
-- carriage_engine.working_sound = nil
carriage_engine.stop_trigger = nil
carriage_engine.drive_over_tie_trigger = nil
carriage_engine.factoriopedia_simulation = nil
carriage_engine.corpse = nil

----- End -----
data:extend({ carriage, carriage_engine })

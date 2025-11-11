----- Carriage -----
local carriage_max_speed = 0.15

local carriage = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
carriage.name = "carriage"
carriage.flags = { "placeable-neutral", "player-creation", "placeable-off-grid" }
carriage.allow_copy_paste = true
carriage.minable = { mining_time = 0.5, result = "carriage" }
carriage.max_health = 250
carriage.hidden_in_factoriopedia = true
carriage.corpse = nil
carriage.collision_box = { { -1, -1.5 }, { 1, 1.5 } }
carriage.selection_box = { { -1, -1.5 }, { 1, 1.5 } }
carriage.connection_distance = 2
carriage.joint_distance = 1.3
carriage.selection_priority = 51
carriage.weight = 1000
carriage.inventory_size = 10
carriage.max_speed = carriage_max_speed
carriage.air_resistance = 0.001
carriage.pictures = {
  rotated = {
    layers = {
      {
        priority = "low",
        width = 192,
        height = 192,
        direction_count = 128,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage/main.png",
        line_length = 8,
        lines_per_file = 16,
        scale = 0.8,
      },
      {
        priority = "low",
        width = 64,
        height = 64,
        direction_count = 128,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage/shadow.png",
        line_length = 8,
        lines_per_file = 16,
        scale = 2.4,
        draw_as_shadow = true,
      }
    }
  }
}
carriage.vertical_doors = nil
carriage.horizontal_doors = nil
carriage.wheels = nil
carriage.working_sound = nil
carriage.drive_over_tie_trigger = nil
carriage.minimap_representation = {
  filename = "__carriage__/graphics/entity/carriage/minimap-representation.png",
  flags = { "icon" },
  size = { 26, 56 },
  scale = 0.5
}
carriage.selected_minimap_representation = {
  filename = "__carriage__/graphics/entity/carriage/selected-minimap-representation.png",
  flags = { "icon" },
  size = { 26, 56 },
  scale = 0.5
}
carriage.corpse = nil
carriage.back_light = nil
carriage.stand_by_light = nil
carriage.factoriopedia_simulation = nil

----- Carriage Engine (Hidden) -----
local carriage_engine = table.deepcopy(data.raw["locomotive"]["locomotive"])
carriage_engine.name = "carriage-engine"
carriage_engine.icon = "__carriage__/graphics/icon/carriage.png"
carriage_engine.minable = { mining_time = 0.5, result = nil }
carriage_engine.flags = { "placeable-neutral", "player-creation", "placeable-off-grid" }
carriage_engine.allow_copy_paste = true
carriage_engine.weight = 1000
carriage_engine.max_speed = carriage_max_speed
carriage_engine.max_power = "100kW"
carriage_engine.air_resistance = 0.001
carriage_engine.collision_box = { { -0.6, -0.8}, { 0.6, 0.8 } }
carriage_engine.selection_box = { { -0.6, -0.8 }, { 0.6, 0.8 } }
carriage_engine.selection_priority = 51
carriage_engine.connection_distance = 2
carriage_engine.joint_distance = 0.6
carriage_engine.pictures = {
  rotated = {
    layers = {
      {
        priority = "low",
        width = 128,
        height = 128,
        direction_count = 128,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage-engine/main.png",
        line_length = 8,
        lines_per_file = 16,
        scale = 0.8,
      },
      {
        priority = "low",
        width = 64,
        height = 64,
        direction_count = 128,
        allow_low_quality_rotation = true,
        filename = "__carriage__/graphics/entity/carriage-engine/shadow.png",
        line_length = 8,
        lines_per_file = 16,
        scale = 1.6,
        draw_as_shadow = true,
      }
    }
  }
}
carriage_engine.energy_source = {
  type = "void",
}
carriage_engine.minimap_representation = nil
carriage_engine.selected_minimap_representation = nil
carriage_engine.water_reflection = nil
carriage_engine.wheels = nil
carriage_engine.working_sound = nil
carriage_engine.stop_trigger = nil
carriage_engine.drive_over_tie_trigger = nil
carriage_engine.factoriopedia_simulation = nil
carriage_engine.corpse = nil
carriage_engine.back_light = nil
carriage_engine.front_light = nil
carriage_engine.stand_by_light = nil
carriage_engine.resistances = nil
carriage_engine.max_health = 250

----- End -----
data:extend({ carriage, carriage_engine })

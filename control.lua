-- Carriage Mod - Control Script

-- Initialize on game start
script.on_init(function()
  storage.carriage_stations = storage.carriage_stations or {}
  storage.carriage_storage = storage.carriage_storage or {}
  storage.carriage_blocks = storage.carriage_blocks or {} -- Track block occupancy
end)

script.on_load(function()
  storage.carriage_stations = storage.carriage_stations or {}
  storage.carriage_storage = storage.carriage_storage or {}
  storage.carriage_blocks = storage.carriage_blocks or {}
end)

-- Handle carriage station placement - create storage chest
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, function(event)
  local entity = event.created_entity or event.entity
  if entity and entity.name == "carriage-station" then
    -- Create storage chest at station position
    local storage_entity = entity.surface.create_entity{
      name = "carriage-station-storage",
      position = entity.position,
      force = entity.force
    }
    if storage_entity then
      storage.carriage_storage[entity.unit_number] = storage_entity
    end
  end
end)

-- Handle carriage station removal - remove storage chest
script.on_event({defines.events.on_entity_died, defines.events.on_pre_player_mined_item, defines.events.on_robot_mined_entity}, function(event)
  local entity = event.entity
  if entity and entity.name == "carriage-station" then
    local storage_entity = storage.carriage_storage[entity.unit_number]
    if storage_entity and storage_entity.valid then
      storage_entity.destroy()
    end
    storage.carriage_storage[entity.unit_number] = nil
  end
end)

-- Prevent fuel requirement for carriages
script.on_event(defines.events.on_train_changed_state, function(event)
  local train = event.train
  if train and train.valid then
    -- Ensure carriages always have energy (no fuel required)
    for _, locomotive in pairs(train.locomotives.front_movers) do
      if locomotive.name == "carriage" then
        if locomotive.energy < locomotive.max_energy * 0.5 then
          locomotive.energy = locomotive.max_energy
        end
      end
    end
    for _, locomotive in pairs(train.locomotives.back_movers) do
      if locomotive.name == "carriage" then
        if locomotive.energy < locomotive.max_energy * 0.5 then
          locomotive.energy = locomotive.max_energy
        end
      end
    end
  end
end)

-- Block-based signaling: Make each rail block act like a signal
-- This prevents multiple carriages from occupying the same block
local function update_block_occupancy()
  if not storage.carriage_blocks then
    storage.carriage_blocks = {}
  end
  
  local current_blocks = {} -- Track current occupancy
  
  -- Check all trains for carriages
  local trains = nil
  if game and game.train_manager and game.train_manager.trains then
    trains = game.train_manager.trains
  else
    trains = {}
    local seen = {}
    for _, surface in pairs(game.surfaces) do
      for _, loco in pairs(surface.find_entities_filtered{type = "locomotive"}) do
        local train = loco.train
        if train and train.valid and not seen[train.id] then
          seen[train.id] = true
          table.insert(trains, train)
        end
      end
    end
  end

  for _, train in pairs(trains) do
      local has_carriage = false
      for _, locomotive in pairs(train.locomotives.front_movers) do
        if locomotive.name == "carriage" then
          has_carriage = true
          break
        end
      end
      if not has_carriage then
        for _, locomotive in pairs(train.locomotives.back_movers) do
          if locomotive.name == "carriage" then
            has_carriage = true
            break
          end
        end
      end
      
      if has_carriage and train.valid and train.state == defines.train_state.on_the_path then
        -- Get the rail block the train is on
        local front_rail = train.front_rail
        if front_rail and front_rail.valid then
          local rail_segment = front_rail.get_rail_segment_entity()
          if rail_segment and rail_segment.valid then
            local block_id = rail_segment.unit_number
            if current_blocks[block_id] and current_blocks[block_id] ~= train.id then
              -- Block is occupied by another train, slow down this train
              if train.speed > 0.05 then
                train.speed = math.max(0, train.speed * 0.8)
              end
            else
              -- Mark block as occupied by this train
              current_blocks[block_id] = train.id
            end
          end
        end
      end
    end
  
  -- Update storage tracking
  storage.carriage_blocks = current_blocks
end

-- Automatic item transfer when carriage arrives at station
-- Note: Carriages are locomotives, which don't have cargo inventory by default
-- This function is kept for future enhancement if we add inventory to locomotives via data.lua
local function transfer_items_at_station()
  -- Placeholder: Locomotives don't have cargo inventories
  -- Future: Could use burner inventory or add custom inventory via prototype
end

-- Periodic updates
script.on_nth_tick(10, function(event)
  update_block_occupancy()
  transfer_items_at_station()
end)



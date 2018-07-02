
-- simple algorithm
-- 1) unhooks all wires between all pairs if out of line in area
-- 2) connects if alignment is correct
function clean_up_list(poles) 
	-- TODO separate poles into (small, medium) and (big, substation)

	for idx, pole1 in ipairs(poles) do
		-- disconnect all copper wires
		--pole1.disconnect_neighbour()
		
		for idx, pole2 in ipairs(poles) do
			-- calculate differences
			local xd = math.abs(pole2.position.x - pole1.position.x)
			local yd = math.abs(pole2.position.y - pole1.position.y)
			
			if xd > 0.05 and yd > 0.05 then
				pole1.disconnect_neighbour(pole2)
			end
			
			if xd <= 0.05 and yd > 0.05 then
				pole1.connect_neighbour(pole2)
			end
			if xd > 0.05 and yd <= 0.05 then
				pole1.connect_neighbour(pole2)
			end
		end
	end
end

function on_selected_area(event)
	-- check that the rewire tool is being used
	if event.item ~= "rewire-tool" then return end

	poles = {}

	-- filter all valid electric poles
	for k, entity in pairs(event.entities) do
		if entity.valid then
			if entity.type == "electric-pole" then
				table.insert(poles, entity)
			end
		end
	end

	-- execute cleaning algorithm
	clean_up_list(poles)
end

-- is this a good idea?
--function on_tick_execute(event)
--	-- skip if not enabled
--	if not settings.global["rewire-background"].value then return end
--	
--	-- fetch frequency from settings
--	frequency = settings.global["rewire-frequency"].value
--
--	-- wait for correct time
--	if game.tick % frequency == 0 then
--		--local player = game.players[1]
--		--player.print("executing background check")
--		
--		-- safe version of clean up
--		-- only rewire when detecting a square
--
--		-- ## fetch random area
--		local surface = game.surfaces["nauvis"]
--
--		-- random selection is not good
--		local chunk = surface.get_random_chunk()
--		--player.print(chunk)
--		
--		-- this searches 4 chunks
--		local chunk_area = {{chunk.x*32, chunk.y*32}, {(chunk.x+2) * 32, (chunk.y+2)*32}}
--		local poles = surface.find_entities_filtered{area=chunk_area, type="electric-pole"}
--
--		-- execute algorithm on area
--		clean_up_list(poles)
--	end
--end

--function on_settings_change(event)
--	if event.setting == "rewire-background" then
--		-- fetch state of setting
--		local background = settings.global["rewire-background"].value
--
--		if background then
--			-- add event listener
--
--			script.on_event(defines.events.on_tick, function(event) on_tick_execute(event) end)
--		else
--			-- remove event listener
--
--			script.on_event(defines.events.on_tick, function(event) on_tick_execute(event) end)
--		end
--	end
--end

--script.on_init() -- check setting state
--script.on_load() -- check setting state
--script.on_event(defines.events.on_runtime_mod_setting_changed, function(event) on_settings_change(event) end)

-- hook in player selection-tool
script.on_event(defines.events.on_player_selected_area, function(event) on_selected_area(event) end)
script.on_event(defines.events.on_player_alt_selected_area, function(event) on_selected_area(event) end)

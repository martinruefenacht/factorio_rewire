function on_selected_area(event)
	-- check that the rewire tool is being used
	if event.item ~= "rewire-tool" then return end

	poles = {}

	-- TODO extend to small-electric-pole, medium-electric-pole, big-electric-pole, substation

	-- filter all valid electric poles
	for k, entity in pairs(event.entities) do
		if entity.valid then
			if entity.type == "electric-pole" then
				--local player = game.players[event.player_index]
				--player.print(entity.name)
				--player.print(entity.position)
				--entity.disconnect_neighbour()
				
				table.insert(poles, entity)
			end
		end
	end

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


script.on_event(defines.events.on_player_selected_area, function(event) on_selected_area(event) end)

data:extend({
	{
		type = "selection-tool",
		name = "rewire-tool",
		icon = "__rewire__/tool.png",
		icon_size = 32,
		stack_size = 1,
		subgroup = "tool",
		flags = {"goes-to-quickbar"},
		selection_color = {r=1.0,g=0.0,b=0.0},
		alt_selection_color = {r=0.0,g=1.0,b=0.0},
		selection_mode = {"buildable-type"},
		alt_selection_mode = {"buildable-type"},
		selection_cursor_box_type = "entity",
		alt_selection_cursor_box_type = "copy",
		can_be_mod_opened = true,
		show_in_library = true
	}
})

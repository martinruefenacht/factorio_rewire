data:extend({
	{
		type = "bool-setting",
		name = "rewire-background",
		setting_type = "runtime-global",
		default_value = false
	},

	{
		type = "int-setting",
		name = "rewire-frequency",
		setting_type = "runtime-global",
		default_value = 300,
		minimum_value = 60,
		maximum_value = 3600
	}
})

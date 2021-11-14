if not mobs.mod == "redo" then return end

mobs:register_mob("hades_better_rat:rat", {
	type = "animal",
	visual = "mesh",
	mesh = "rat.b3d",
	rotate = 180,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	textures = {
		{"rat_black.png"},
		{"rat_brown.png"},
		{"rat_gray.png"},
		{"rat_white.png"}
	},
	stepheight = 1.1,
	runaway = true,
	jump_height = 2,
	fly = false,
	walk_chance = 60,
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 8,
	passive = true,
	attack_type = "dogfight",
	damage = 1,
	reach = 1,
	pathfinding = false,
	group_attack = true,
	hp_min= 2,
	hp_max = 5,
	armor = 80,
	lava_damage = 2,
	fall_damage = 0,
	water_damage = 1,
	recovery_time = 0.25,
	blood_amount = 1,
	drops = {
		{name = "mobs:cheese", chance = 1, min = 1, max = 2},
	},
	replace_what = {
		"mobs:cheese",
		"mobs:cheeseblock",
		"hades_mr_goat:goatcheese",
		"hades_mr_goat:goatcheeseblock",
		"hades_extrafarming:barley_5",
		"hades_extrafarming:barley_6",
		"hades_extrafarming:barley_7",
		"hades_extrafarming_corn_7.png",
		"hades_extrafarming_corn_8.png",
		"hades_farming:wheat_5",
		"hades_farming:wheat_6",
		"hades_farming:wheat_7",
		"hades_farming:wheat_8"
	},
	replace_with = "air",
	replace_rate = 10,
	follow = {"mobs:cheese", "hades_mr_goat:goatcheese"},
	on_rightclick = function(self, clicker)
    -- feed or tame
    if mobs:feed_tame(self, clicker, 4, true, true) then return end
    if mobs:protect(self, clicker) then return end
		mobs:capture_mob(self, clicker, 25, 80, 0, true, "hades_better_rat:rat")
	end
})

--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
--[[
mobs:spawn_specific("hades_better_rat:rat",
	{"default:stone"},
	{"air"},
	0, 14, 30, 300000, 2, -25000, 5000
)
--]]
mobs:register_egg("hades_better_rat:rat", "Mouse", "wool_brown.png", 1)

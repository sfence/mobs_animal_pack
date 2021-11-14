if not mobs.mod == "redo" then return end

mobs:register_mob("hades_mr_goat:goat", {
	type = "animal",
	visual = "mesh",
	visual_size = {x=2,y=2},
	mesh = "mobs_goat.b3d",
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
	animation = {
		-- 1-30 head down, 31-60 head up, 61-121 tail wiggle, 185-215 lay down,
		-- 216-245 getting up, 331-390 chewing, 391-511 look around
		speed_normal = 15,		speed_run = 24,
		stand_start = 1,		stand_end = 121,
		walk_start = 122,		walk_end = 182,
		run_start = 122,		run_end = 182,
		punch_start = 246,		punch_end = 330,
	},
	textures = {
		{"mobs_goat_white.png"},
		{"mobs_goat_brown.png"},
		{"mobs_goat_grey.png"},
	},
	fear_height = 2,
	jump = true,
	fly = false,
	walk_chance = 60,
	view_range = 7,

	passive = true,
	attack_type = "dogfight",
	damage = 3,
	reach = 2,
	pathfinding = false,
	runaway = false,
	hp_min = 6,
	hp_max = 12,
	armor = 200,
	knock_back = 1,
	lava_damage = 7,
	fall_damage = 7,
	water_damage = 1,
	recovery_time = 0.25,
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},

	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "mobs:leather", chance = 1, min = 1, max = 2}
	},

	replace_what = {
		{"group:flower","air",0},
		{"hades_grass:grass_1","air",0},
		{"hades_grass:grass_2","hades_grass:grass_1",0},
		{"hades_grass:grass_3","hades_grass:grass_2",0},
		{"hades_grass:grass_4","hades_grass:grass_3",0},
		{"hades_grass:grass_5","hades_grass:grass_4",0},
		{"hades_core:dirt_with_grass", "hades_core:dirt_with_grass_l3", -1},
		{"hades_core:dirt_with_grass_l3", "hades_core:dirt_with_grass_l2", -1},
		{"hades_core:dirt_with_grass_l2", "hades_core:dirt_with_grass_l1", -1}
	},
	replace_rate = 50,
	follow = {
		"group:flower"
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 60, false, nil) then return end

		local tool = clicker:get_wielded_item()
		if tool:get_name() == "hades_bucket:bucket_empty" then
			if self.gotten == true or self.child == true then
				return
			end
			local inv = clicker:get_inventory()
			inv:remove_item("main", "hades_bucket:bucket_empty")
			if inv:room_for_item("main", {name = "hades_mr_goat:bucket_goatmilk"}) then
				clicker:get_inventory():add_item("main", "hades_mr_goat:bucket_goatmilk")
			else
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, {name = "hades_mr_goat:bucket_goatmilk"})
			end
			self.gotten = true -- milked
			return
		end
	end
})

--[[
local l_spawn_elevation_min = minetest.setting_get("water_level")
if l_spawn_elevation_min then
	l_spawn_elevation_min = l_spawn_elevation_min + 1
else
	l_spawn_elevation_min = 1
end
mobs:spawn({
	name = "hades_mr_goat:goat",
	nodes = {"default:dirt_with_grass", "ethereal:green_dirt_top"},
	min_light = 10,
	chance = 300000,
	min_height = l_spawn_elevation_min,
	max_height = 5000,
	day_toggle = true,
})
--]]
mobs:register_egg("hades_mr_goat:goat", "Goat", "default_grass.png", 1)

minetest.override_item("hades_mr_goat:goat", {
		_tt_help = "Eat flowers.",
	})

-- bucket of goat milk
minetest.register_craftitem("hades_mr_goat:bucket_goatmilk", {
	description = "Bucket of Goat Milk",
	inventory_image = "mobs_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(10, 'hades_bucket:bucket_empty'),
	groups = {food_milk = 11, eatable = 10},
})

-- cheese wedge
minetest.register_craftitem("hades_mr_goat:goatcheese", {
	description = "Goat Cheese",
	inventory_image = "mobs_cheese.png",
	on_use = minetest.item_eat(6),
	groups = {food_cheese = 1, eatable = 6},
})
minetest.register_craft({
	type = "cooking",
	output = "hades_mr_goat:goatcheese",
	recipe = "hades_mr_goat:bucket_goatmilk",
	cooktime = 8,
	replacements = {{ "hades_mr_goat:bucket_goatmilk", "hades_bucket:bucket_empty"}}
})

-- cheese block
minetest.register_node("hades_mr_goat:goatcheeseblock", {
	description = "Goat Cheese Block",
	tiles = {"mobs_cheeseblock.png"},
	is_ground_content = false,
	groups = {crumbly = 3},
	sounds = hades_sounds.node_sound_dirt_defaults()
})
minetest.register_craft({
	output = "hades_mr_goat:goatcheeseblock",
	recipe = {
		{'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese'},
		{'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese'},
		{'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese', 'hades_mr_goat:goatcheese'}
	}
})
minetest.register_craft({
	output = "hades_mr_goat:goatcheese 9",
	recipe = {
		{'hades_mr_goat:goatcheeseblock'}
	}
})

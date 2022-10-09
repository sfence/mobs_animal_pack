if not mobs.mod == "redo" then return end

-- local variables
local l_spawn_in          = {"default:water_source", "default:water_flowing", "default:river_water_source", "default:river_water_flowing"}
local l_spawn_near        = {"default:sand","default:dirt","group:seaplants","group:seacoral"}
local l_spawn_chance      = 100000
local l_cc_hand           = 25
local l_cc_net            = 80
local l_water_level       = minetest.settings:get("water_level") - 1
local l_anims             = {
	speed_normal = 24,		speed_run = 24,
	stand_start = 1,		stand_end = 80,
	walk_start = 81,		walk_end = 155,
	run_start = 81,			run_end = 155
}
local l_visual            = "mesh"
local l_clown_visual_size = { x = .5, y = .5}
local l_trop_visual_size  = { x = 1, y = 1}
local l_clown_mesh        = "animal_clownfish.b3d"
local l_trop_mesh         = "fish_blue_white.b3d"
local l_clown_textures    = {
	{"clownfish.png"},
	{"clownfish2.png"}
}
local l_trop_textures     = {
	{"fish.png"},
	{"fish2.png"},
	{"fish3.png"}
}

-- Clownfish
mobs:register_mob("hades_fish:clownfish", {
	type = "animal",
	lifetimer = 0,  -- doesn't despawn
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 100,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	rotate = 270,
	visual = l_visual,
	mesh = l_clown_mesh,
	textures = l_clown_textures,
	visual_size = l_clown_visual_size,
	makes_footstep_sound = false,
	stepheight = 0.1,
	fly = true,
	fly_in = "hades_core:water_source",
	fall_speed = 0,
	view_range = 8,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	animation = l_anims,
	drops = {
		{name = "hades_xocean:fish_edible", chance = 1, min = 1, max = 1},
	},
	follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
		"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		"hades_aquaz:grass", "hades_aquaz:tall_grass",
		"hades_aquaz:purple_alga", "hades_aquaz:orange_alga", "hades_aquaz:red_alga", "hades_aquaz:algae_feed",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		mobs:capture_mob(self, clicker, l_cc_hand, l_cc_net, 0, true, "hades_fish:clownfish")
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
--mobs:spawn_specific("hades_fish:clownfish", l_spawn_in, l_spawn_near, 5, 20, 30, l_spawn_chance, 1, -50, l_water_level)
mobs:register_egg("hades_fish:clownfish", "Clownfish", "animal_clownfish_clownfish_item.png", 0)

minetest.override_item("hades_fish:clownfish", {
		_tt_help = "Eat alga, seaweed. waterlily and kelp.",
	})

-- Tropical fish
mobs:register_mob("hades_fish:tropical", {
	type = "animal",
	lifetimer = 0,  -- doesn't despawn
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 100,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	rotate = 270,
	visual = l_visual,
	mesh = l_trop_mesh,
	textures = l_trop_textures,
	visual_size = l_trop_visual_size,
	makes_footstep_sound = false,
	stepheight = 0.1,
	fly = true,
	fly_in = "hades_core:water_source",
	fall_speed = 0,
	view_range = 8,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	animation = l_anims,
	drops = {
		{name = "hades_xocean:fish_edible", chance = 1, min = 1, max = 1},
	},
	follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
		"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		"hades_aquaz:grass", "hades_aquaz:tall_grass",
		"hades_aquaz:purple_alga", "hades_aquaz:orange_alga", "hades_aquaz:red_alga", "hades_aquaz:algae_feed",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		mobs:capture_mob(self, clicker, l_cc_hand, l_cc_net, 0, true, "hades_fish:tropical")
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
--mobs:spawn_specific("hades_fish:tropical", l_spawn_in, l_spawn_near, 5, 20, 30, l_spawn_chance, 1, -50, l_water_level)
mobs:register_egg("hades_fish:tropical", "Tropical fish", "animal_fish_blue_white_fish_blue_white_item.png", 0)

minetest.override_item("hades_fish:tropical", {
		_tt_help = "Eat alga, seaweed. waterlily and kelp.",
	})

if minetest.get_modpath("hades_xocean") then
	hades_xocean.add_fish("hades_fish:clownfish")
	hades_xocean.add_fish("hades_fish:tropical")
end

if minetest.get_modpath("hades_aquaz") then
	aquaz.add_algae_feed_fishes("hades_fish:clownfish")
	aquaz.add_algae_feed_fishes("hades_fish:tropical")
end


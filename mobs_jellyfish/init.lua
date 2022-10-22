if not mobs.mod == "redo" then return end

mobs:register_mob("hades_jellyfish:jellyfish", {
	lifetimer = 0,  -- doesn't despawn
	type = "animal",
	attack_type = "dogfight",
	damage = 5,
	reach = 1,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	visual = "mesh",
	mesh = "jellyfish.b3d",
	textures = {
		{"jellyfish.png"},
		{"jellyfish.png^[colorize:black:150"},
		{"jellyfish.png^[colorize:red:150"},
		{"jellyfish.png^[colorize:violet:150"},
	},
	makes_footstep_sound = false,
	walk_velocity = 0.1,
	run_velocity = 0.1,
	fly = true,
	fly_in = "hades_core:water_source",
	fall_speed = 0,
	view_range = 10,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
		"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
    "hades_aquaz:grass", "hades_aquaz:tall_grass",
		"hades_aquaz:purple_alga", "hades_aquaz:orange_alga", "hades_aquaz:red_alga", "hades_aquaz:algae_feed",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		mobs:capture_mob(self, clicker, 80, 100, 0, true, "hades_jellyfish:jellyfish")
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
--[[
mobs:spawn_specific("hades_jellyfish:jellyfish",
	{"default:water_source"},
	{"default:water_flowing","default:water_source"},
	1, 14, 30, 300000, 1, -50, -1)
--]]
mobs:register_egg("hades_jellyfish:jellyfish", "Jellyfish", "jellyfish_inv.png", 0)

if minetest.get_modpath("hades_xocean") then
  hades_xocean.add_fish("hades_jellyfish:jellyfish")
end

